FasdUAS 1.101.10   ��   ��    k             l     ��  ��    7 1 Get a list of all "current messages" in Outlook.     � 	 	 b   G e t   a   l i s t   o f   a l l   " c u r r e n t   m e s s a g e s "   i n   O u t l o o k .   
  
 l    
 ����  O     
    r    	    l    ����  1    ��
�� 
CMgs��  ��    o      ���� "0 currentmessages currentMessages  m                                                                                         OPIM  alis    �  Macintosh HD 1             ̦d"H+   �0Microsoft Outlook.app                                           /��$�e        ����  	                Microsoft Office 2011     ̦ƒ      �%]�     �0 !�  IMacintosh HD 1:Applications: Microsoft Office 2011: Microsoft Outlook.app   ,  M i c r o s o f t   O u t l o o k . a p p    M a c i n t o s h   H D   1  8Applications/Microsoft Office 2011/Microsoft Outlook.app  / ��  ��  ��        l     ��������  ��  ��        l     ��  ��    !  Loop through the messages.     �   6   L o o p   t h r o u g h   t h e   m e s s a g e s .   ��  l   � ����  X    � ��   k    �        O    ~ ! " ! k    } # #  $ % $ l   �� & '��   & ) # Only notify about unread messages.    ' � ( ( F   O n l y   n o t i f y   a b o u t   u n r e a d   m e s s a g e s . %  )�� ) Z    } * +�� , * =   $ - . - n    " / 0 / 1     "��
�� 
pRed 0 o     ���� 0 eachmessage eachMessage . m   " #��
�� boovfals + k   ' w 1 1  2 3 2 r   ' * 4 5 4 m   ' (��
�� boovtrue 5 o      ���� *0 displaynotification displayNotification 3  6 7 6 r   + 1 8 9 8 e   + / : : l  + / ;���� ; n   + / < = < 1   , .��
�� 
subj = o   + ,���� 0 eachmessage eachMessage��  ��   9 o      ����  0 messagesubject messageSubject 7  > ? > r   2 7 @ A @ n   2 5 B C B 1   3 5��
�� 
sndr C o   2 3���� 0 eachmessage eachMessage A o      ���� 0 messagesender messageSender ?  D E D r   8 = F G F n   8 ; H I H 1   9 ;��
�� 
PlTC I o   8 9���� 0 eachmessage eachMessage G o      ����  0 messagecontent messageContent E  J K J l  > >�� L M��   L ` Z Get an appropriate representation of the sender; preferably name, but fall back on email.    M � N N �   G e t   a n   a p p r o p r i a t e   r e p r e s e n t a t i o n   o f   t h e   s e n d e r ;   p r e f e r a b l y   n a m e ,   b u t   f a l l   b a c k   o n   e m a i l . K  O�� O Q   > w P Q R P Z   A X S T�� U S =  A F V W V n   A D X Y X 1   B D��
�� 
pnam Y o   A B���� 0 messagesender messageSender W m   D E Z Z � [ [   T r   I P \ ] \ n   I N ^ _ ^ 1   J N��
�� 
radd _ o   I J���� 0 messagesender messageSender ] o      ���� 0 messagesender messageSender��   U r   S X ` a ` n   S V b c b 1   T V��
�� 
pnam c o   S T���� 0 messagesender messageSender a o      ���� 0 messagesender messageSender Q R      �� d e
�� .ascrerr ****      � **** d o      ���� 0 errormessage errorMessage e �� f��
�� 
errn f o      ���� 0 errornumber errorNumber��   R Q   ` w g h i g r   c j j k j n   c h l m l 1   d h��
�� 
radd m o   c d���� 0 messagesender messageSender k o      ���� 0 messagesender messageSender h R      �� n o
�� .ascrerr ****      � **** n o      ���� 0 errormessage errorMessage o �� p��
�� 
errn p o      ���� 0 errornumber errorNumber��   i k   r w q q  r s r l  r r�� t u��   t H B Couldn�t get name or email; we�ll just say the sender is unknown.    u � v v �   C o u l d n  t   g e t   n a m e   o r   e m a i l ;   w e  l l   j u s t   s a y   t h e   s e n d e r   i s   u n k n o w n . s  w�� w r   r w x y x m   r u z z � { {  U n k n o w n   s e n d e r y o      ���� 0 messagesender messageSender��  ��  ��   , k   z } | |  } ~ } l  z z��  ���    K E The message was already read, so we won�t bother notifying about it.    � � � � �   T h e   m e s s a g e   w a s   a l r e a d y   r e a d ,   s o   w e   w o n  t   b o t h e r   n o t i f y i n g   a b o u t   i t . ~  ��� � r   z } � � � m   z {��
�� boovfals � o      ���� *0 displaynotification displayNotification��  ��   " m     � �                                                                                  OPIM  alis    �  Macintosh HD 1             ̦d"H+   �0Microsoft Outlook.app                                           /��$�e        ����  	                Microsoft Office 2011     ̦ƒ      �%]�     �0 !�  IMacintosh HD 1:Applications: Microsoft Office 2011: Microsoft Outlook.app   ,  M i c r o s o f t   O u t l o o k . a p p    M a c i n t o s h   H D   1  8Applications/Microsoft Office 2011/Microsoft Outlook.app  / ��      � � � l   ��������  ��  ��   �  � � � l   �� � ���   �   Display notification    � � � � *   D i s p l a y   n o t i f i c a t i o n �  ��� � Z    � � ����� � =   � � � � o    ����� *0 displaynotification displayNotification � m   � ���
�� boovtrue � k   � � � �  � � � I  � ��� � �
�� .sysonotfnull��� ��� TEXT � o   � �����  0 messagecontent messageContent � �� � �
�� 
appr � o   � ����� 0 messagesender messageSender � �� ���
�� 
subt � o   � �����  0 messagesubject messageSubject��   �  � � � l  � ��� � ���   � 2 , Allow time for the notification to trigger.    � � � � X   A l l o w   t i m e   f o r   t h e   n o t i f i c a t i o n   t o   t r i g g e r . �  ��� � I  � ��� ���
�� .sysodelanull��� ��� nmbr � m   � ����� ��  ��  ��  ��  ��  �� 0 eachmessage eachMessage  o    ���� "0 currentmessages currentMessages��  ��  ��       �� � ���   � ��
�� .aevtoappnull  �   � **** � �� ����� � ���
�� .aevtoappnull  �   � **** � k     � � �  
 � �  ����  ��  ��   � �������� 0 eachmessage eachMessage�� 0 errormessage errorMessage�� 0 errornumber errorNumber �  ���������������������������� Z���� � z����������
�� 
CMgs�� "0 currentmessages currentMessages
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
pRed�� *0 displaynotification displayNotification
�� 
subj��  0 messagesubject messageSubject
�� 
sndr�� 0 messagesender messageSender
�� 
PlTC��  0 messagecontent messageContent
�� 
pnam
�� 
radd�� 0 errormessage errorMessage � ������
�� 
errn�� 0 errornumber errorNumber��  
�� 
appr
�� 
subt�� 
�� .sysonotfnull��� ��� TEXT
�� .sysodelanull��� ��� nmbr�� �� *�,E�UO ��[��l kh  � `��,f  UeE�O��,EE�O��,E�O��,E�O ��,�  �a ,E�Y ��,E�W X   �a ,E�W X  a E�Y fE�UO�e  �a �a �a  Okj Y h[OY�wascr  ��ޭ