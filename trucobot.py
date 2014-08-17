#####################################################
#           Truco Bot - HAL-NIQUILATOR              #
#####################################################
import random
import os
from time import sleep

nGames = 50000

########################################################################################
# giveCard(deck) -> recebe a lista representando o baralho e retorna uma carta aleatoria
# removendo ela do baralho
########################################################################################
                
def giveCard(deck):
        card = random.choice(deck)
        deck.remove(card)
        return card
        
########################################################################################
# dealHand(deck) -> recebe a lista representando o baralho e retorna uma lista com 3
# cartas selecionadas aleatoriamente
########################################################################################

def dealHand(deck):
        return [giveCard(deck),giveCard(deck),giveCard(deck)]
        
        
########################################################################################
# shuffleDeck() -> cria uma lista com cada carta de um baralho de truco
########################################################################################

def shuffleDeck():
        deck = []
        deck += ["4s","4c","4d","4h"]
        deck += ["5s","5c","5d","5h"]
        deck += ["6s","6c","6d","6h"]
        deck += ["7s","7c","7d","7h"]
        deck += ["Qs","Qc","Qd","Qh"]   
        deck += ["Js","Jc","Jd","Jh"]   
        deck += ["Ks","Kc","Kd","Kh"]
        deck += ["As","Ac","Ad","Ah"]
        deck += ["2s","2c","2d","2h"]
        deck += ["3s","3c","3d","3h"]
        return deck

########################################################################################
# setCardValueOrder(card) -> recebe o TOMBO (da forma 4Q, KS, 2C) e retorna o dicionario
# OrderDict[carta] = valor                      valor entre 13 e 1
########################################################################################
def setCardValueOrder(card):
        OrderDict = {}
        tombo = card[0]
        normalOrder = ['3','2','A','K','J','Q','7','6','5','4']
        
        manilha = normalOrder[normalOrder.index(tombo) - 1]

        normalOrder.remove(manilha)
        manilhaOrder = [manilha+"c",manilha+"h",manilha+"s",manilha+"d"]
        manilhaOrder += normalOrder

        print manilhaOrder
        
        value = len(manilhaOrder)       
        for i in manilhaOrder:
                if i[0] == manilha:
                        OrderDict[i] = value
                else:
                        OrderDict[i+"h"] = value
                        OrderDict[i+"c"] = value
                        OrderDict[i+"s"] = value
                        OrderDict[i+"d"] = value                        
                value-= 1
        OrderDict["0"] = -10
        return OrderDict
        
############################################################################################
# alucinate(deck, manilha, hand, nGames, rodada, placar,  op1card, op2card, partcard)
#
# deck -> lista de cartas representando baralho         
# valueOrder -> dicionario da sequencia de valor das cartas
# hand -> a lista de cartas na tua mao          
# nGames -> numero de games que serao alucinados
# rodada -> numero da rodada atual [0,1,2]
# placar -> valor que determina quem estah ganhando ate o momento( 0 = empate, +1 = vitoria, -1 = derrota)
# op1card -> carta jogada pelo oponente 1 NESTA RODADA
# op2card -> carta jogada pelo oponente 2 NESTA RODADA
# partcard -> carta jogada pelo parceiro NESTA RODADA
#
# retorna a carta que devera ser jogada nesta rodada ou os resuldatos ods jogos
############################################################################################
def alucinate(deck, valueOrder, hand, truco, nGames = 10, rodada = 0, placar = 0,  op1card = "0", op2card = "0", partcard = "0", mode = 0): 
        result_dict = {}
        redealop1 = False
        redealop2 = False
        redealpart = False

        if ((op1card != "0") or (op2card != "0") or (partcard != "0")) and mode == 0:                         #TESTE DE DESCARTE
                partBig = False
                if hasBiggerCard(hand,op1card,op2card,partcard,valueOrder,partBig) == False:
                        print "DESCARTEI!!!"
                        return hand[0]
        if ((op1card != "0") and (op2card != "0") and (partcard != "0")) and mode == 0:
                print "ULTIMO PLAYER"
                return smallestBiggerCard(hand,op1card,op2card,partcard,valueOrder)
                        
        
        for i in range(len(hand)):
                result_dict[hand[i]] = 0
        for i in range(nGames):
                tempdeck = list(deck)
                temphand = list(hand)
                if  op1card == "0" or redealop1 == True:                    #
                        op1card = giveCard(tempdeck)                                            #
                        redealop1 = True                                                        #
                if  op2card == "0" or redealop2 == True:                    #
                        op2card = giveCard(tempdeck)                                            #
                        redealop2 = True                                                        #  Se nao souber a carta, alucina uma
                if  partcard == "0" or redealpart == True:                 #
                        partcard = giveCard(tempdeck)                                           #
                        redealpart = True                                                       #
                
                result = playGame(tempdeck,valueOrder,temphand,op1card,op2card,partcard,rodada,placar) ##result = tupla(carta,resultado)
                result_dict[result[0]] += result[1]
        
        print "RESULT ITEMS >>> ",result_dict.items()
        
        if mode == 0: # mode == 0 devolve uma carta
                return chooseCardOrTruco(hand, result_dict,truco)
        
        else:   # mode == 1 devolve o dicionario de resultados inteiro
                return result_dict.items()

############################################################################################
# playGame(deck,valueOrder,hand,op1card,op2card,partcard,rodada,placar)
#
# deck -> lista de cartas representando baralho         
# valueOrder -> dicionario da sequencia de valor das cartas
# hand -> a lista de cartas na tua mao          
# rodada -> numero da rodada atual [0,1,2]
# placar -> valor que determina quem estah ganhando ate o momento( 0 = empate, +1 = ganhando, -1 = perdendo)
# op1card -> carta jogada pelo oponente 1 NESTA RODADA
# op2card -> carta jogada pelo oponente 2 NESTA RODADA
# partcard -> carta jogada pelo parceiro NESTA RODADA
#
# retorna a carta que devera ser jogada nesta rodada
############################################################################################
def playGame(deck,valueOrder,hand,op1card,op2card,partcard,rodada,placar): ##result = tupla(carta,resultado)    
        rodadas_left = 3 - rodada
        melou = False
        gotHigh = False
        partBig = False
        
        for i in range(rodadas_left):
                random_card = giveCard(hand)
                if i==0:
                        card = random_card
                else :
                        op1card = giveCard(deck)
                        op2card = giveCard(deck)
                        partcard = giveCard(deck)
                           
                #print random_card, op1card, op2card, partcard
                
                result = compareCards(random_card,op1card,op2card,partcard,valueOrder)
                
                #print result, placar
                
                if result == 0:
                        if placar != 0:                 #vitoria ou derrota apos melada
                                placar += result
                                break
                        elif i == rodadas_left:         #se melar a ultima rodada, chuta vitoria ou derrota aleatoriamente
                                placar = random.choice(["1","-1"])
                        else:                           # melar na primeira ou segunda rodada
                                placar += result
                                melou = True
                elif result == 1:
                        if placar == 1: # vitoria
                                break
                        elif placar == -1: #vai para a ultima rodada
                                placar += result
                        elif placar == 0:
                                placar+= result
                                if melou:       #se tiver melado, acaba
                                        break
                elif result == -1:
                        if placar == -1: # derrota
                                break
                        elif placar == 1: #vai para a ultima rodada
                                placar += result
                        elif placar == 0:
                                placar+= result 
                                if melou:       #se tiver melado, acaba
                                        break
        return (card,placar)
                        
############################################################################################
# compareCards(yourCard,op1Card,op2Card,partCard,valueOrder)
#
# yourCard -> carta que vc ira jogar
# op1card -> carta que o op1 ira jogar
# op2card -> carta que o op2 ira jogar
# partcard -> carta que seu parceiro ira jogar
#
# retorna o resultado da comparacao: 
# 1 - vitoria sua ou do parceiro
# -1 - vitoria dos oponentes
# 0 - empate (melou)
############################################################################################    
        
def compareCards(yourCard,op1card,op2card,partcard,valueOrder):
        if valueOrder[yourCard] < valueOrder[partcard]:
                highCardTeam = partcard
        else:


                
                highCardTeam = yourCard
        
        if valueOrder[op1card] < valueOrder[op2card]:
                highCardOp = op2card
        else:
                highCardOp = op1card
                
        if valueOrder[highCardOp] < valueOrder[highCardTeam]:
                return 1
        elif valueOrder[highCardOp] == valueOrder[highCardTeam]:
                return 0
        else:
                return -1

############################################################################################
# chooseCardOrTruco(hand, results)
#
# hand -> sua mao
# results -> dicionario com o resultado das alucinacoes
#
# retorna a carta que deve ser jogada ou se deve pedir Truco: 
############################################################################################
def chooseCardOrTruco(hand, results, truco):
        handSize = len(hand)
        card = hand[0]
        third_copy = False

        try:
                second_card = hand[1]
        except:
                second_card = "0"
        try:
                third_card = hand[2]
        except:
                third_card = "0"

        if (handSize != 1):
                gameResult = results[hand[0]]                       
                for i in range(handSize-1):                                     #no FOR encontra a ordem das cartas                 
                        if results[hand[i+1]] > gameResult:         
                                if third_copy:
                                        third_card = second_card
                                second_card = card                         
                                card = hand[i+1]                        
                                gameResult = results[hand[i+1]]     
                                third_copy = True
                               

                if third_card != "0":
                        if(results[third_card] > nGames*0.3):                                #### COISAS A MUDAR AKI ####
                                Truco[0] =  True
                                return random.choice([card,second_card,third_card])
                if (results[second_card] > nGames*0.2):
                        if (results[second_card] > 0.25*nGames):
                                Truco[0] =  True
                        return random.choice([card,second_card])
        else:
                if(results[card] > nGames*0.5):
                        Truco[0] = True
        return card
############################################################################################        
def readTruco():
        with open("files/truco_call.txt","r") as arq:
                line = arq.readline()
        if (line.strip() == 'Yes'):
                        return True
        else :
                return False

        
def readFlipAndHand(deck):
        os.system("readPlayerCards.ahk")
        with open("files/player.txt","r") as arq:
                lines = arq.readlines()
        flip = lines[0].strip()
        hand = [lines[1].strip(),lines[2].strip(),lines[3].strip()]
        if(flip in deck):
                deck.remove(flip)
        if hand[0] != "0" and hand[0] in deck:
                deck.remove(hand[0])
        if hand[1] != "0" and hand[1] in deck:
                deck.remove(hand[1])
        if hand[2] != "0" and hand[2] in deck:
                deck.remove(hand[2])
        return [flip,hand]
        

def playCard(hand,card):
        encoberto = ""
        
        if card[0] == "%":
                card = card[1:]
                encoberto = "eytuy"
        hand.remove(card)
        print "PLAYCARD -> "+ card+" "+encoberto
        os.system("playCard.ahk " + card + encoberto)   

def readTable(deck, checkNewTurn, op1Hand = [], op2Hand = [], partHand = [], placar = 0):
        os.system("readTable.ahk "+checkNewTurn)
        
        with open("files/new_round.txt") as new_round_arq:
                new_round = new_round_arq.readline()
        if new_round == "Yes":
                return True
        
        with open("files/left.txt","r") as left_arq:
                op1 = left_arq.readlines()
        with open("files/right.txt","r") as right_arq:
                op2 = right_arq.readlines()
        with open("files/top.txt","r") as part_arq:
                part = part_arq.readlines()
        if op1 != []:
                for card in op1:
                        if card[0] == "$":
                                try:
                                        deck.remove(card[1:3])
                                except:
                                        pass
                                op1Hand.append("0")
                        if card not in op1Hand:
                                op1Hand.append(card.strip())
        else:
                op1Hand.append("0")
                
        if op2 != []:
                for card in op2:
                        if card[0] == "$":
                                try:
                                        deck.remove(card[1:3])
                                except:
                                        pass
                                op2Hand.append("0")
                        if card not in op2Hand:
                                op2Hand.append(card.strip())
        else:
                op2Hand.append("0")
        if part != []:
                for card in part:
                        if card[0] == "$":
                                try:
                                        deck.remove(card[1:3])
                                except:
                                        pass
                                partHand.append("0")
                        if card not in partHand:
                               partHand.append(card.strip())
        else:
                partHand.append("0")

        return False
        # LER O PLACAR!!!

def hasBiggerCard(hand,op1card,op2card,partcard,valueOrder,partBig):
        high_card = op1card
        if valueOrder[high_card] < valueOrder[op2card]:
                high_card = op2card
        if valueOrder[high_card] < valueOrder[partcard]:
                high_card = partcard
                partBig = True                
        for card in hand:
                if valueOrder[card]>valueOrder[high_card]:
                                return True
        return False

def sortHand(valueOrder, hand):
                tempHand = []
                min_card = hand[0]

                if valueOrder[min_card] > valueOrder[hand[1]]:
                        min_card = hand[1]
                if valueOrder[min_card] > valueOrder[hand[2]]:
                        min_card = hand[2]

                tempHand.append(min_card)
                hand.remove(min_card)

                min_card = hand[0]

                if valueOrder[min_card] > valueOrder[hand[1]]:
                        min_card = hand[1]
                
                tempHand.append(min_card)
                hand.remove(min_card)
                tempHand.append(hand[0])

                return tempHand

def smallestBiggerCard(hand,op1card,op2card,partcard,valueOrder):
        partBig = False
        high_card = op1card
        if valueOrder[high_card] < valueOrder[op2card]:
                high_card = op2card
        if valueOrder[high_card] <= valueOrder[partcard]:
                high_card = partcard
                partBig = True

        temphand = list(hand)
        
        if len(hand) != 3:
                for i in range(3 - len(hand)):
                        temphand.append("0")

        temphand = sortHand(valueOrder, temphand)

        try:
                while("0" in temphand):
                        temphand.remove("0")
        except:
                pass
        
        if partBig:
                return temphand[0]
        else:
                for i in temphand:
                        if valueOrder[i]>valueOrder[high_card]:
                                return i

###############################################################
if __name__ == "__main__":
        while(True):
                deck = shuffleDeck()

                handAndFlip=readFlipAndHand(deck)
                while( handAndFlip[0]== '0'):
                       handAndFlip=readFlipAndHand(deck)      
                flip=handAndFlip[0]
                valueOrder = setCardValueOrder(flip)
                hand=sortHand(valueOrder, handAndFlip[1])
                
                print flip, hand
                
                op1 = []
                op2 = []
                part = []
                Truco = [False]
                lastcard = "0"

                for rodada in range(3):
                        new_round = readTable(deck,handAndFlip[0],op1,op2,part)
                        if new_round:
                                break
                        if readTruco():
                                print "FOI TRUCADO"
                                high = 0
                                if rodada != 0:
                                        hand.append(lastcard)
                                results = alucinate(deck, valueOrder, hand,Truco, nGames, rodada, 0,  op1[rodada], op2[rodada], part[rodada],1)
                                print results
                                if rodada != 0:
                                        hand.remove(lastcard)
                                for i in results:
                                        print "I -> ", i
                                        if (i[1] >= 0.5 * nGames):
                                               print "+8",i 
                                               high+= 8
                                        elif (i[1]>= 0.3*nGames):
                                                print "+4",i
                                                high+=4
                                        elif (i[1]>=0.2*nGames):
                                                print "+2",i
                                                high+=2
                                        elif (i[1]>=0.1 * nGames):
                                                print "+1",i
                                                high+=1
                                        elif (i[1]>= 0):
                                                print "-1",i
                                                high-=1
                                        elif (i[1]>=-0.1 * nGames):
                                                print "-2",i
                                                high-=2
                                        elif (i[1]>=-0.2*nGames):
                                                print "-4",i
                                                high-=4
                                        else:
                                                print "-8",i
                                                high-=8
                                print "HIGH ",high
                                if high > 1:    
                                        os.system("handleTruco.ahk y")
                                else:
                                        os.system("handleTruco.ahk n")
                                        sleep(1)

                                        os.system("readTable.ahk "+readFlipAndHand(shuffleDeck())[0])
                                        with open("files/new_round.txt") as new_round_arq:
                                                checkround = new_round_arq.readline()
                                        if checkround == "Yes":
                                                break
                                #elif 5 < high:
                                #        os.system("handleTruco.ahk 6")         # FUTURE IMPROVEMENT (SE tah bom pra 6, vai tah bom pra 9)
                        
                        print 'op1,op2,part',op1,op2,part
                        card = alucinate(deck, valueOrder, hand, Truco, nGames, rodada, 0,  op1[rodada], op2[rodada], part[rodada])
                        lastcard = card
                        if Truco[0] == False:
                                print "HAND >> ",hand
                                print "CARD >> ",card
                                playCard(hand,card)
                        else:
                                os.system("handleTruco.ahk t")
                                sleep(3)
                                playCard(hand,card)
                                Truco[0] = False
                       #x = raw_input("\n\nDigite para continuar...\n\n")
                sleep(3)
                Truco[0] = False
