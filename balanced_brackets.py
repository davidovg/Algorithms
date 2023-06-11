def enqueue(lst, itm):
    lst.append(itm)        # Just add item to end of list.
    return lst             # And return list (for consistency with dequeue).

def dequeue(lst):
    del(lst[0])          # Change list to remove first item.
    return 0    # Then return item and new list.

# Test harness. Start with empty queue.

myList = []

# t = int(input().strip())
# for t_itr in range(t):
#     #n = int(input().strip())
#     q = list(map(int, input().rstrip().split()))
#     if q[0] == 1:
#         enqueue(myList, q[1])
#
#     elif q[0] == 2:
#         dequeue(myList)
#
#     else:
#         print(myList[0])

#Checks if in a string brackets are all matched in pairs, eg. [({})]

openList = ["[", "{", "("]
closeList = ["]", "}", ")"]


def isBalanced(myStr):
    stack = []
    for i in myStr:
        if i in openList:
            stack.append(i)
        elif i in closeList:
            pos = closeList.index(i)
            if stack and (openList[pos] == stack[-1]):
                stack.pop()
            else:
                return "NO"
    if len(stack) == 0:
        return "YES"

#regex solution
import re

def isBalanced(s):
    prev_s = ''
    while prev_s != s:
        prev_s, s = s, re.sub(r'({}|\[\]|\(\))', '', s)
    return "YES" if s == '' else "NO"

s = '[([{{}}]{[[][][([[]]){[]}{}]]}[]{{}}{})[[]]]{{}}(()[[[[[(){}[]]({}{[]})[][[][]]]]{}]{[{}]{[{[][](()({{()}}){([]({({{[]}([([()]{()[[([({{{[]{(){}}[][]({{[([])()](())([{[]([()]{})}]){}([]){()}{}[]([[()]])}()})[{}]}()}(())}){{}()}[]]{{}})]][[]({{[{}]}})({{}({{[]{()}([][{[()]}]{})}()})}{{}}{})]()(){}}(()({()}[([](){[]()}[])])[])[])][{[{[]}]{}([])}]()(()))}){([{}])}[(([]){[]{}})]{}({}{})}){}({{}([][](){{[][{()([[{}()]]{()}{{}{[()]}})[()[]{}](){[{}()[]][{{}}{[{}][]()}[]](())[[][]][]()}}[({}([[{([]){}}]()([()(){}]){([()]())}](()))(()))]]{}()[][{[{}(([]){([()]{()()}([{}][[[]{[[(({([([]){()[]}]){(())}[]}))][((([]{})[{}[[()]({({[()[]]{}(()[{}[][[{}][][]({()}[{([])}][])]][]{})([])}){}{((){})}}){[]}[]()(()(()))(()[{{}}]){}({{{((()([](()[][]{}){({})}{(([{({{}})}]))})))}}})]]))]]}]]))})]}]}})}))})}]}}])'
s = '{[()]}'
isBalanced(s)
