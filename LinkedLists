# It is New Year's Day and people are in line for the Wonderland rollercoaster ride. ' \
# Each person wears a sticker indicating their initial position in the queue from  to .
# Any person can bribe the person directly in front of them to swap positions,
# but they still wear their original sticker. One person can bribe at most two others.
# Determine the minimum number of bribes that took place to get to a given queue order.
# Print the number of bribes, or, if anyone has bribed more than two people, print Too chaotic.

q = [1, 2, 5, 3, 4, 7, 8, 6]

def minimumBribes(q, counter=0):
    z = 0
    for i in range(1,len(q)):
        if q[i] < q[i-1]:
            q[i], q[i-1] = q[i-1], q[i]
            counter +=1
            z += 1
            if z > 2:
                return('Too chaotic')
        else:
            z = 0
            i+=1
    if q == sorted(q):
        print(counter)
        return(0)
    else:
        minimumBribes(q, counter=counter)

minimumBribes(q)


# Given pointers to the heads of two sorted linked lists, merge them into a single,
# sorted linked list. Either head pointer may be null meaning that the corresponding list is empty.

import math
import os
import random
import re
import sys

class SinglyLinkedListNode:
    def __init__(self, node_data):
        self.data = node_data
        self.next = None

class SinglyLinkedList:
    def __init__(self):
        self.head = None
        self.tail = None

    def insert_node(self, node_data):
        node = SinglyLinkedListNode(node_data)

        if not self.head:
            self.head = node
        else:
            self.tail.next = node


        self.tail = node

def print_singly_linked_list(node, sep, fptr):
    while node:
        fptr.write(str(node.data))

        node = node.next

        if node:
            fptr.write(sep)


def mergeLists(head1, head2):
    mergedList = SinglyLinkedList()
    while head1 and head2 is not None:
        if head1.data < head2.data:
            mergedList.insert_node(head1.data)
            head1 = head1.next
        else:
            mergedList.insert_node(head2.data)
            head2 = head2.next
    if head1 is None:
        mergedList.tail.next = head2
    else:
        mergedList.tail.next = head1

    return mergedList.head

