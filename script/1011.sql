-- DROP TABLE
DROP TABLE SEARCH;
DROP TABLE ADVERTISEMENT;
DROP TABLE ATTACHMENT;
DROP TABLE ALERT;
DROP TABLE REPORT;
DROP TABLE POINT;
DROP TABLE ANSWER;
DROP TABLE QUESTION;
DROP TABLE LIKES;
DROP TABLE REPLY;
DROP TABLE BOARD;
DROP TABLE GROUP_BUYER;
DROP TABLE GROUP_BUY;
DROP TABLE REVIEW;
DROP TABLE WISH;
DROP TABLE ORDERS;
DROP TABLE CART;
DROP TABLE PRODUCT;
DROP TABLE CATEGORY;
DROP TABLE MEMBER;

-- DROP SEQUENCE
DROP SEQUENCE SEQ_SEARCH;
DROP SEQUENCE SEQ_ADNO;
DROP SEQUENCE SEQ_FNO;
DROP SEQUENCE SEQ_ALERT;
DROP SEQUENCE SEQ_RPT;
DROP SEQUENCE SEQ_POINT;
DROP SEQUENCE SEQ_ANO;
DROP SEQUENCE SEQ_QNO;
DROP SEQUENCE SEQ_RPL;
DROP SEQUENCE SEQ_BNO;
DROP SEQUENCE SEQ_GBUY;
DROP SEQUENCE SEQ_RVNO;
DROP SEQUENCE SEQ_ORDER;
DROP SEQUENCE SEQ_PNO;
DROP SEQUENCE SEQ_CTGR;
DROP SEQUENCE SEQ_UNO;

-- 사용자(MEMBER)
CREATE TABLE MEMBER(
    USER_NO NUMBER CONSTRAINT UNO_PK PRIMARY KEY,
    USER_ID VARCHAR2(15) CONSTRAINT UID_NN NOT NULL,
    USER_PWD VARCHAR2(20) CONSTRAINT UPWD_NN NOT NULL,
    USER_NAME VARCHAR2(20) CONSTRAINT UNAME_NN NOT NULL,
    NICKNAME VARCHAR2(30) CONSTRAINT NICKNAME_NN NOT NULL,
    ADDRESS VARCHAR2(100) CONSTRAINT ADDRESS_NN NOT NULL,
    EMAIL VARCHAR2(100) CONSTRAINT EMAIL_NN NOT NULL,
    PHONE VARCHAR2(13) CONSTRAINT PHONE_NN NOT NULL,
    POINT NUMBER DEFAULT 0,
    PROFILE VARCHAR2(100),
    ENROLL_DATE DATE DEFAULT SYSDATE,
    MODIFY_DATE DATE DEFAULT SYSDATE,
    STATUS VARCHAR2(1) DEFAULT 'Y'  CHECK (STATUS IN('Y', 'N')),
    USER_TOKEN VARCHAR2(4000),
    CONSTRAINT UID_UQ UNIQUE(USER_ID)
);

COMMENT ON COLUMN MEMBER.USER_NO IS '사용자번호';
COMMENT ON COLUMN MEMBER.USER_ID IS '아이디';
COMMENT ON COLUMN MEMBER.USER_PWD IS '비밀번호';
COMMENT ON COLUMN MEMBER.USER_NAME IS '이름';
COMMENT ON COLUMN MEMBER.NICKNAME IS '닉네임';
COMMENT ON COLUMN MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.PHONE IS '휴대폰번호';
COMMENT ON COLUMN MEMBER.POINT IS '포인트';
COMMENT ON COLUMN MEMBER.PROFILE IS '프로필사진';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '회원가입날짜';
COMMENT ON COLUMN MEMBER.MODIFY_DATE IS '회원수정날짜';
COMMENT ON COLUMN MEMBER.STATUS IS '상태(Y/N)';

CREATE SEQUENCE SEQ_UNO NOCACHE;

INSERT INTO MEMBER
VALUES(SEQ_UNO.NEXTVAL, 'admin', '1234', '관리자', '관리자', '서울시 강남구 역삼동', 'admin@kh.or.kr', '010-1234-5678', DEFAULT, NULL, DEFAULT, DEFAULT, DEFAULT, NULL);

INSERT INTO MEMBER
VALUES(SEQ_UNO.NEXTVAL, 'user01', 'pass01', '차은우', '얼굴천재', '서울시 강남구 청담동', 'cha@kh.or.kr', '010-1111-2222', DEFAULT, NULL, DEFAULT, DEFAULT, DEFAULT, NULL);

INSERT INTO MEMBER
VALUES(SEQ_UNO.NEXTVAL, 'user02', 'pass02', '장원영', '인형', '서울시 용산구 이촌동', 'jang@kh.or.kr', '010-2222-3333', DEFAULT, NULL, DEFAULT, DEFAULT, DEFAULT, NULL);

INSERT INTO MEMBER
VALUES(SEQ_UNO.NEXTVAL, 'user03', 'pass03', '박용진', '조장', '서울시 용산구', 'dragon@kh.or.kr', '010-4444-5555', DEFAULT, NULL, DEFAULT, DEFAULT, DEFAULT, NULL);

INSERT INTO MEMBER
VALUES(SEQ_UNO.NEXTVAL, 'user04', 'pass04', '하민정', '좁눈', '서울시 동작구 사당동', 'mmj@kh.or.kr', '010-6666-7777', DEFAULT, NULL, DEFAULT, DEFAULT, DEFAULT, NULL);


-- 상품 카테고리
CREATE TABLE CATEGORY(
    CATEGORY_NO NUMBER CONSTRAINT CTG_NO_PK PRIMARY KEY,
    CATEGORY_L VARCHAR2(100) CONSTRAINT CTG_L_NN NOT NULL,
    CATEGORY_S VARCHAR2(100),
    CATEGORY_STATUS VARCHAR2(1) DEFAULT 'Y'
);

COMMENT ON COLUMN CATEGORY.CATEGORY_NO IS '카테고리번호';
COMMENT ON COLUMN CATEGORY.CATEGORY_L IS '대분류';
COMMENT ON COLUMN CATEGORY.CATEGORY_S IS '소분류';
COMMENT ON COLUMN CATEGORY.CATEGORY_STATUS IS '카테고리상태';

CREATE SEQUENCE SEQ_CTGR NOCACHE;

INSERT INTO CATEGORY
VALUES(SEQ_CTGR.NEXTVAL, '침대', '침대프레임', DEFAULT);

INSERT INTO CATEGORY
VALUES(SEQ_CTGR.NEXTVAL, '침대', '매트리스', DEFAULT);

INSERT INTO CATEGORY
VALUES(SEQ_CTGR.NEXTVAL, '테이블·식탁·책상', '식탁', DEFAULT);

INSERT INTO CATEGORY
VALUES(SEQ_CTGR.NEXTVAL, '테이블·식탁·책상', '책상', DEFAULT);

INSERT INTO CATEGORY
VALUES(SEQ_CTGR.NEXTVAL, '테이블·식탁·책상', '좌식테이블', DEFAULT);

INSERT INTO CATEGORY
VALUES(SEQ_CTGR.NEXTVAL, '서랍·수납장', '서랍장', DEFAULT);

INSERT INTO CATEGORY
VALUES(SEQ_CTGR.NEXTVAL, '서랍·수납장', '수납장', DEFAULT);

INSERT INTO CATEGORY
VALUES(SEQ_CTGR.NEXTVAL, '서랍·수납장', '캐비닛', DEFAULT);

INSERT INTO CATEGORY
VALUES(SEQ_CTGR.NEXTVAL, '밀키트·간편식.', '밀키트', DEFAULT);

INSERT INTO CATEGORY
VALUES(SEQ_CTGR.NEXTVAL, '생필품', '세탁세제·유연제', DEFAULT);


-- 상품
CREATE TABLE PRODUCT(
    PRODUCT_NO VARCHAR2(10) CONSTRAINT PR_PK PRIMARY KEY,
    CATEGORY_NO NUMBER NOT NULL,
    PRODUCT_NAME VARCHAR2(300) CONSTRAINT PR_PR_NM NOT NULL,
    SALE NUMBER,
    DELIVERY NUMBER CONSTRAINT DEL_NN NOT NULL,
    COUNT NUMBER DEFAULT 0,
    PRODUCT_OPTION VARCHAR2(10) CONSTRAINT POPT_NN NOT NULL, 
    STATUS VARCHAR2(1) DEFAULT 'Y'  CHECK (STATUS IN('Y', 'N')),
    CONSTRAINT PR_CTGR_FK FOREIGN KEY (CATEGORY_NO) REFERENCES CATEGORY
);

COMMENT ON COLUMN PRODUCT.PRODUCT_NO IS '상품번호';
COMMENT ON COLUMN PRODUCT.CATEGORY_NO IS '카테고리번호';
COMMENT ON COLUMN PRODUCT.PRODUCT_NAME IS '상품명';
COMMENT ON COLUMN PRODUCT.SALE IS '할인률';
COMMENT ON COLUMN PRODUCT.DELIVERY IS '배송비';
COMMENT ON COLUMN PRODUCT.COUNT IS '조회수';
COMMENT ON COLUMN PRODUCT.PRODUCT_OPTION IS '옵션구분';
COMMENT ON COLUMN PRODUCT.STATUS IS '상태';

CREATE SEQUENCE SEQ_PNO NOCACHE;

INSERT INTO PRODUCT
VALUES('P' || SEQ_PNO.NEXTVAL, 1, '유사품에 속지마세요! 원조 어메이징 원목 침대 매트리스 깔판', 0.2, 50000, DEFAULT, '사이즈', DEFAULT);

INSERT INTO PRODUCT
VALUES('P' || SEQ_PNO.NEXTVAL, 1, '유사품에 속지마세요! 원조 어메이징 원목 침대 매트리스 깔판', 0.2, 50000, DEFAULT, '사이즈', DEFAULT);

INSERT INTO PRODUCT
VALUES('P' || SEQ_PNO.NEXTVAL, 1, '유사품에 속지마세요! 원조 어메이징 원목 침대 매트리스 깔판', 0.2, 50000, DEFAULT, '사이즈', DEFAULT);

INSERT INTO PRODUCT
VALUES('P' || SEQ_PNO.NEXTVAL, 1, '유사품에 속지마세요! 원조 어메이징 원목 침대 매트리스 깔판', 0.2, 50000, DEFAULT, '사이즈', DEFAULT);

INSERT INTO PRODUCT
VALUES('P' || SEQ_PNO.NEXTVAL, 1, '유사품에 속지마세요! 원조 어메이징 원목 침대 매트리스 깔판', 0.2, 50000, DEFAULT, '사이즈', DEFAULT);

--- 장바구니
CREATE TABLE CART(
    PRODUCT_NO VARCHAR2(10),
    USER_NO NUMBER,
    VOLUME NUMBER DEFAULT 1,
    FOREIGN KEY (USER_NO) REFERENCES MEMBER,
    FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT,
    CONSTRAINT CART_PK PRIMARY KEY (PRODUCT_NO, USER_NO)
);

COMMENT ON COLUMN CART.PRODUCT_NO IS '상품번호';
COMMENT ON COLUMN CART.USER_NO IS '사용자번호';
COMMENT ON COLUMN CART.VOLUME IS '상품수량';

INSERT INTO CART
VALUES('P1', 2, DEFAULT);

INSERT INTO CART
VALUES('P2', 3, 2);

INSERT INTO CART
VALUES('P3', 1, DEFAULT);

INSERT INTO CART
VALUES('P4', 4, DEFAULT);


INSERT INTO CART
VALUES('P5', 5, DEFAULT);

-- 상품구매내역
CREATE TABLE ORDERS(
    ORDER_NO NUMBER NOT NULL,
    PRODUCT_NO VARCHAR2(10) NOT NULL,
    USER_NO NUMBER NOT NULL,
    VOLUME NUMBER DEFAULT 1,
    ORDER_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT UNO_FK FOREIGN KEY (USER_NO) REFERENCES MEMBER,
    FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT
);

COMMENT ON COLUMN ORDERS.ORDER_NO IS '주문번호';
COMMENT ON COLUMN ORDERS.PRODUCT_NO IS '상품번호';
COMMENT ON COLUMN ORDERS.USER_NO IS '사용자번호';
COMMENT ON COLUMN ORDERS.VOLUME IS '구매수량';
COMMENT ON COLUMN ORDERS.ORDER_DATE IS '구매일자';

CREATE SEQUENCE SEQ_ORDER NOCACHE;

INSERT INTO ORDERS
VALUES(SEQ_ORDER.NEXTVAL, 'P1', 1, 2, DEFAULT);

INSERT INTO ORDERS
VALUES(SEQ_ORDER.CURRVAL, 'P2', 1, 1, DEFAULT);

INSERT INTO ORDERS
VALUES(SEQ_ORDER.NEXTVAL, 'P3', 2, 1, DEFAULT);

INSERT INTO ORDERS
VALUES(SEQ_ORDER.NEXTVAL, 'P1', 3, 3, DEFAULT);

INSERT INTO ORDERS
VALUES(SEQ_ORDER.NEXTVAL, 'P5', 3, 1, DEFAULT);


-- 찜하기
CREATE TABLE WISH(
    PRODUCT_NO VARCHAR2(10),
    USER_NO NUMBER,
    FOREIGN KEY (USER_NO) REFERENCES MEMBER,
    FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT,
    CONSTRAINT WISH_PK PRIMARY KEY (PRODUCT_NO, USER_NO)
);

COMMENT ON COLUMN WISH.PRODUCT_NO IS '상품번호';
COMMENT ON COLUMN WISH.USER_NO IS '사용자번호';


INSERT INTO WISH
VALUES('P1', 2);

INSERT INTO WISH
VALUES('P1', 3);

INSERT INTO WISH
VALUES('P2', 1);

INSERT INTO WISH
VALUES('P3', 4);

INSERT INTO WISH
VALUES('P5', 5);



-- 상품리뷰
CREATE TABLE REVIEW(
    REVIEW_NO VARCHAR2(10) CONSTRAINT REVIEW_PK PRIMARY KEY,
    REVIEW_WRITER NUMBER NOT NULL,
    PRODUCT_NO VARCHAR2(10) NOT NULL,
    ORDER_NO NUMBER NOT NULL,
    REVIEW_CONTENT VARCHAR2(3000) NOT NULL,
    RATING NUMBER NOT NULL,
    CREATE_DATE DATE DEFAULT SYSDATE,
    FOREIGN KEY (REVIEW_WRITER) REFERENCES MEMBER,
    FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT
);

COMMENT ON COLUMN REVIEW.REVIEW_NO IS '리뷰번호';
COMMENT ON COLUMN REVIEW.REVIEW_WRITER IS '작성자';
COMMENT ON COLUMN REVIEW.PRODUCT_NO IS '상품번호';
COMMENT ON COLUMN REVIEW.ORDER_NO IS '주문번호';
COMMENT ON COLUMN REVIEW.REVIEW_CONTENT IS '내용';
COMMENT ON COLUMN REVIEW.RATING IS '별점';
COMMENT ON COLUMN REVIEW.CREATE_DATE IS '작성일';

CREATE SEQUENCE SEQ_RVNO NOCACHE;

INSERT INTO REVIEW
VALUES('R' || SEQ_RVNO.NEXTVAL, 1, 'P1', 1, '생각보다 더 튼튼한거같아서 마음에 들어요', 4.5, DEFAULT);

INSERT INTO REVIEW
VALUES('R' || SEQ_RVNO.NEXTVAL, 1, 'P2', 1, '그냥그래요', 3, DEFAULT);

INSERT INTO REVIEW
VALUES('R' || SEQ_RVNO.NEXTVAL, 2,'P3', 2, '색상이 너무 예뻐요', 5, DEFAULT);

INSERT INTO REVIEW
VALUES('R' || SEQ_RVNO.NEXTVAL, 3, 'P1', 3, '너무 좋아요', 5, DEFAULT );

INSERT INTO REVIEW
VALUES('R' || SEQ_RVNO.NEXTVAL, 5, 'P5', 5, '그저그래요', 3, DEFAULT );


-- 공동구매상품
CREATE TABLE GROUP_BUY(
    GBUY_NO NUMBER CONSTRAINT GBUYNO_PK PRIMARY KEY,
    PRODUCT_NO VARCHAR2(10) NOT NULL,
    GBUY_START DATE NOT NULL,
    GBUY_END DATE NOT NULL,
    FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT
);

COMMENT ON COLUMN GROUP_BUY.GBUY_NO IS '공동구매번호';
COMMENT ON COLUMN GROUP_BUY.PRODUCT_NO IS '상품번호';
COMMENT ON COLUMN GROUP_BUY.GBUY_START IS '시작날짜';
COMMENT ON COLUMN GROUP_BUY.GBUY_END IS '종료날짜';

CREATE SEQUENCE SEQ_GBUY NOCACHE;

INSERT INTO GROUP_BUY
VALUES(SEQ_GBUY.NEXTVAL, 'P3', '2023-10-23', '2023-10-25');

INSERT INTO GROUP_BUY
VALUES(SEQ_GBUY.NEXTVAL, 'P4', '2023-10-30', '2023-11-05');


-- 공동구매자
CREATE TABLE GROUP_BUYER(
    GBUY_NO,
    USER_NO,
    FOREIGN KEY (GBUY_NO) REFERENCES GROUP_BUY,
    FOREIGN KEY (USER_NO) REFERENCES MEMBER,
    CONSTRAINT GBUYER_PK PRIMARY KEY(GBUY_NO, USER_NO)
);

COMMENT ON COLUMN GROUP_BUYER.GBUY_NO IS '공동구매번호';
COMMENT ON COLUMN GROUP_BUYER.USER_NO IS '사용자번호';

INSERT INTO GROUP_BUYER
VALUES(1, 1);

INSERT INTO GROUP_BUYER
VALUES(1, 2);

INSERT INTO GROUP_BUYER
VALUES(1, 3);

INSERT INTO GROUP_BUYER
VALUES(2, 4);

INSERT INTO GROUP_BUYER
VALUES(2, 5);

-- 게시판
CREATE TABLE BOARD(
    BOARD_NO VARCHAR2(10) CONSTRAINT BNO_PK PRIMARY KEY,
    BOARD_WRITER NUMBER NOT NULL,
    BOARD_TITLE VARCHAR2(100) NOT NULL,
    BOARD_CONTENT VARCHAR2(4000) NOT NULL,
    CREATE_DATE DATE DEFAULT SYSDATE,
    COUNT NUMBER DEFAULT 0,
    TAG VARCHAR2(200),
    BOARD_TYPE NUMBER NOT NULL CHECK (BOARD_TYPE IN(1, 2)),
    STATUS VARCHAR2(1) DEFAULT 'Y'  CHECK (STATUS IN('Y', 'N')),
    FOREIGN KEY (BOARD_WRITER) REFERENCES MEMBER
);

COMMENT ON COLUMN BOARD.BOARD_NO IS '게시글번호';
COMMENT ON COLUMN BOARD.BOARD_WRITER IS '작성자';
COMMENT ON COLUMN BOARD.BOARD_TITLE IS '제목';
COMMENT ON COLUMN BOARD.BOARD_CONTENT IS '내용';
COMMENT ON COLUMN BOARD.CREATE_DATE IS '작성일';
COMMENT ON COLUMN BOARD.COUNT IS '조회수';
COMMENT ON COLUMN BOARD.TAG IS '태그';
COMMENT ON COLUMN BOARD.BOARD_TYPE IS '게시글타입';
COMMENT ON COLUMN BOARD.STATUS IS '상태(Y/N)';

CREATE SEQUENCE SEQ_BNO NOCACHE;

INSERT INTO BOARD
VALUES('B' || SEQ_BNO.NEXTVAL, 1, '첫번째 게시글', '첫번째 게시글임다', DEFAULT, DEFAULT, '첫게시글', 1, DEFAULT);
-- 엑셀


-- 댓글
CREATE TABLE REPLY(
    REPLY_NO NUMBER CONSTRAINT RPLNO_PK PRIMARY KEY,
    BOARD_NO VARCHAR2(10) NOT NULL,
    REPLY_WRITER NUMBER NOT NULL,
    REPLY_CONTENT VARCHAR2(1000) NOT NULL,
    CREATE_DATE DATE DEFAULT SYSDATE,
    FOREIGN KEY (BOARD_NO) REFERENCES BOARD,
    FOREIGN KEY (REPLY_WRITER) REFERENCES MEMBER
);

COMMENT ON COLUMN REPLY.REPLY_NO IS '댓글번호';
COMMENT ON COLUMN REPLY.BOARD_NO IS '게시글번호';
COMMENT ON COLUMN REPLY.REPLY_WRITER IS '작성자';
COMMENT ON COLUMN REPLY.REPLY_CONTENT IS '댓글내용';
COMMENT ON COLUMN REPLY.CREATE_DATE IS '작성일';

CREATE SEQUENCE SEQ_RPL NOCACHE;

INSERT INTO REPLY
VALUES(SEQ_RPL.NEXTVAL, 'B1', 2, '좋아요', DEFAULT);


INSERT INTO REPLY
VALUES(SEQ_RPL.NEXTVAL, 'B2', 2, '좋아요', DEFAULT);

INSERT INTO REPLY
VALUES(SEQ_RPL.NEXTVAL, 'B1', 2, '좋아요', DEFAULT);

INSERT INTO REPLY
VALUES(SEQ_RPL.NEXTVAL, 'B1', 2, '좋아요', DEFAULT);

INSERT INTO REPLY
VALUES(SEQ_RPL.NEXTVAL, 'B1', 2, '좋아요', DEFAULT);


-- 좋아요
CREATE TABLE LIKES(
    BOARD_NO VARCHAR2(10),
    USER_NO NUMBER,
    FOREIGN KEY (BOARD_NO) REFERENCES BOARD,
    FOREIGN KEY (USER_NO) REFERENCES MEMBER,
    CONSTRAINT LIKES_PK PRIMARY KEY (BOARD_NO, USER_NO)
);

COMMENT ON COLUMN LIKES.BOARD_NO IS '게시글번호';
COMMENT ON COLUMN LIKES.USER_NO IS '사용자번호';

INSERT INTO LIKES
VALUES('B1', 2);

INSERT INTO LIKES
VALUES('B1', 3);


-- 질문
CREATE TABLE QUESTION(
    Q_NO NUMBER CONSTRAINT QNO_PK PRIMARY KEY,
    Q_WRITER NUMBER NOT NULL,
    REF_NO VARCHAR2(10),
    Q_TITLE VARCHAR2(100) NOT NULL,
    Q_CONTENT VARCHAR2(4000) NOT NULL,
    Q_CATEGORY VARCHAR2(100),
    Q_DATE DATE DEFAULT SYSDATE,
    Q_STATUS VARCHAR2(1) DEFAULT 'N' CHECK (Q_STATUS IN('Y','N')),
    FOREIGN KEY (Q_WRITER) REFERENCES MEMBER
);

COMMENT ON COLUMN QUESTION.Q_NO IS '문의번호';
COMMENT ON COLUMN QUESTION.Q_WRITER IS '작성자';
COMMENT ON COLUMN QUESTION.REF_NO IS '참조번호';
COMMENT ON COLUMN QUESTION.Q_TITLE IS '제목';
COMMENT ON COLUMN QUESTION.Q_CONTENT IS '내용';
COMMENT ON COLUMN QUESTION.Q_CATEGORY IS '질문카테고리';
COMMENT ON COLUMN QUESTION.Q_DATE IS '작성일';
COMMENT ON COLUMN QUESTION.Q_STATUS IS '처리여부';

CREATE SEQUENCE SEQ_QNO NOCACHE;

INSERT INTO QUESTION
VALUES(SEQ_QNO.NEXTVAL, 2, NULL, '신고처리는 어떻게 이뤄지나요?', '궁금합니다', NULL, DEFAULT, DEFAULT);

INSERT INTO QUESTION
VALUES(SEQ_QNO.NEXTVAL, 3, 'P1', '원목 원산지가 어딘가요?', '궁금합니다', '상품문의', DEFAULT, 'Y');

INSERT INTO QUESTION
VALUES(SEQ_QNO.NEXTVAL, 3, 'P3', '색상이 잘못 왔어요', '블루로 주문했는데 블랙이왔어요', '배송문의', DEFAULT, DEFAULT);


-- 답변
CREATE TABLE ANSWER(
    A_NO NUMBER CONSTRAINT ANO_PK PRIMARY KEY,
    Q_NO NUMBER NOT NULL,
    A_CONTENT VARCHAR2(4000) NOT NULL,
    A_DATE DATE DEFAULT SYSDATE,
    FOREIGN KEY (Q_NO) REFERENCES QUESTION
);

COMMENT ON COLUMN ANSWER.A_NO IS '답변번호';
COMMENT ON COLUMN ANSWER.Q_NO IS '문의번호';
COMMENT ON COLUMN ANSWER.A_CONTENT IS '답변내용';
COMMENT ON COLUMN ANSWER.A_DATE IS '작성일';

CREATE SEQUENCE SEQ_ANO NOCACHE;

INSERT INTO ANSWER
VALUES(SEQ_ANO.NEXTVAL, 2, '글쎄요', DEFAULT);


-- 포인트
CREATE TABLE POINT(
    POINT_NO NUMBER CONSTRAINT POINT_PK PRIMARY KEY,
    USER_NO NUMBER NOT NULL,
    REASON VARCHAR2(20) NOT NULL,
    POINT VARCHAR2(10) NOT NULL,
    FOREIGN KEY (USER_NO) REFERENCES MEMBER
);

COMMENT ON COLUMN POINT.POINT_NO IS '포인트번호';
COMMENT ON COLUMN POINT.USER_NO IS '사용자번호';
COMMENT ON COLUMN POINT.REASON IS '사유';
COMMENT ON COLUMN POINT.POINT IS '증감';

CREATE SEQUENCE SEQ_POINT NOCACHE;

INSERT INTO POINT
VALUES(SEQ_POINT.NEXTVAL, 2, '추천', '+1000');

INSERT INTO POINT
VALUES(SEQ_POINT.NEXTVAL, 3, '적립', '+500');

INSERT INTO POINT
VALUES(SEQ_POINT.NEXTVAL, 2, '사용', '-1000');


-- 신고
CREATE TABLE REPORT(
    REPORT_NO NUMBER CONSTRAINT RPT_PK PRIMARY KEY,
    REPORTER NUMBER NOT NULL,
    SUSPECT NUMBER NOT NULL,
    GUILTY VARCHAR2(50) NOT NULL,
    REPORT_CONTENT VARCHAR2(1000),
    REPORT_DATE DATE DEFAULT SYSDATE,
    RESULT VARCHAR2(10) DEFAULT 'N',
    FOREIGN KEY (REPORTER) REFERENCES MEMBER,
    FOREIGN KEY (SUSPECT) REFERENCES MEMBER
);

COMMENT ON COLUMN REPORT.REPORT_NO IS '신고번호';
COMMENT ON COLUMN REPORT.REPORTER IS '신고자';
COMMENT ON COLUMN REPORT.SUSPECT IS '피신고자';
COMMENT ON COLUMN REPORT.GUILTY IS '신고종류';
COMMENT ON COLUMN REPORT.REPORT_CONTENT IS '신고내용';
COMMENT ON COLUMN REPORT.REPORT_DATE IS '신고일자';
COMMENT ON COLUMN REPORT.RESULT IS '처리여부';

CREATE SEQUENCE SEQ_RPT NOCACHE;


-- 알림
CREATE TABLE ALERT(
    ALERT_NO NUMBER CONSTRAINT ALERT_PK PRIMARY KEY,
    ALERT_CONTENT VARCHAR2(1000) NOT NULL,
    ALERT_TIME DATE DEFAULT SYSDATE,
    ALERT_STATUS VARCHAR2(1) DEFAULT 'N',
    REF_NO VARCHAR2(10) NOT NULL
);

COMMENT ON COLUMN ALERT.ALERT_NO IS '알림번호';
COMMENT ON COLUMN ALERT.ALERT_CONTENT IS '알림내용';
COMMENT ON COLUMN ALERT.ALERT_TIME IS '알림시간';
COMMENT ON COLUMN ALERT.ALERT_STATUS IS '알림상태';
COMMENT ON COLUMN ALERT.REF_NO IS '참조번호';

CREATE SEQUENCE SEQ_ALERT NOCACHE;


-- 파일첨부
CREATE TABLE ATTACHMENT(
    FILE_NO NUMBER CONSTRAINT ATT_PK PRIMARY KEY,
    REF_NO VARCHAR2(10) NOT NULL,
    ORIGIN_NAME VARCHAR2(100) NOT NULL,
    CHANGE_NAME VARCHAR2(10) NOT NULL,
    FILE_PATH VARCHAR2(100) NOT NULL,
    UPLOAD_DATE DATE DEFAULT SYSDATE,
    STATUS VARCHAR2(1) DEFAULT 'Y'
);

COMMENT ON COLUMN ATTACHMENT.FILE_NO IS '파일번호';
COMMENT ON COLUMN ATTACHMENT.REF_NO IS '참조번호';
COMMENT ON COLUMN ATTACHMENT.ORIGIN_NAME IS '원본명';
COMMENT ON COLUMN ATTACHMENT.CHANGE_NAME IS '저장경로';
COMMENT ON COLUMN ATTACHMENT.FILE_PATH IS '저장경로';
COMMENT ON COLUMN ATTACHMENT.UPLOAD_DATE IS '업로드일';
COMMENT ON COLUMN ATTACHMENT.STATUS IS '상태';

CREATE SEQUENCE SEQ_FNO;

-- 광고
CREATE TABLE ADVERTISEMENT(
    AD_NO NUMBER CONSTRAINT ADNO_PK PRIMARY KEY,
    AD_TYPE NUMBER NOT NULL,
    AD_START DATE NOT NULL,
    AD_END DATE NOT NULL,
    AD_STATUS VARCHAR2(1) DEFAULT 'Y'
);

COMMENT ON COLUMN ADVERTISEMENT.AD_NO IS '광고번호';
COMMENT ON COLUMN ADVERTISEMENT.AD_TYPE IS '배너종류';
COMMENT ON COLUMN ADVERTISEMENT.AD_START IS '광고게시일';
COMMENT ON COLUMN ADVERTISEMENT.AD_END IS '광고종료일';
COMMENT ON COLUMN ADVERTISEMENT.AD_STATUS IS '광고상태';

CREATE SEQUENCE SEQ_ADNO NOCACHE;

-- 검색
CREATE TABLE SEARCH(
    SEARCH_NO NUMBER CONSTRAINT SEARCH_PK PRIMARY KEY,
    SEARCH_NAME VARCHAR2(1000) NOT NULL,
    SEARCH_DATE DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN SEARCH.SEARCH_NO IS '검색번호';
COMMENT ON COLUMN SEARCH.SEARCH_NAME IS '검색어';
COMMENT ON COLUMN SEARCH.SEARCH_DATE IS '검색일';

CREATE SEQUENCE SEQ_SEARCH NOCACHE;




