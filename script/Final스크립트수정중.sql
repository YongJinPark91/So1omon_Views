-----------------삭제------------------
--접속유저의 모든테이블 및 제약조건 삭제
BEGIN
    FOR C IN (SELECT TABLE_NAME FROM USER_TABLES) LOOP
    EXECUTE IMMEDIATE ('DROP TABLE '||C.TABLE_NAME||' CASCADE CONSTRAINTS');
    END LOOP;
END;
/
--접속유저의 모든 시퀀스 삭제
BEGIN
FOR C IN (SELECT * FROM USER_SEQUENCES) LOOP
  EXECUTE IMMEDIATE 'DROP SEQUENCE '||C.SEQUENCE_NAME;
END LOOP;
END;
/
--접속유저의 모든 뷰 삭제
BEGIN
FOR C IN (SELECT * FROM USER_VIEWS) LOOP
  EXECUTE IMMEDIATE 'DROP VIEW '||C.VIEW_NAME;
END LOOP;
END;
/
--접속유저의 모든 트리거 삭제
BEGIN
FOR C IN (SELECT * FROM USER_TRIGGERS) LOOP
  EXECUTE IMMEDIATE 'DROP TRIGGER '||C.TRIGGER_NAME;
END LOOP;
END;
/

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
VALUES('P' || SEQ_PNO.NEXTVAL, 3, '안나 원형 식탁테이블 600 700 800 1000 4type', 0, 25000, DEFAULT, '색상', DEFAULT);

INSERT INTO PRODUCT
VALUES('P' || SEQ_PNO.NEXTVAL, 6, '깔끔한 화이트 서랍장 3종', 0.1, 10000, DEFAULT, '색상', DEFAULT);

INSERT INTO PRODUCT
VALUES('P' || SEQ_PNO.NEXTVAL, 7, '따뜻하게 집에서! 베트남쌀국수 15팩/30팩', 0.2, 0, DEFAULT, '선택', DEFAULT);

INSERT INTO PRODUCT
VALUES('P' || SEQ_PNO.NEXTVAL, 10, '대용량 4L+리필 2600ml 초고농축 섬유유연제', 0, 0, DEFAULT, '선택', DEFAULT);

-- 상품옵션
CREATE TABLE OPTIONS(
    PRODUCT_NO VARCHAR2(10),
    OPTION_NAME VARCHAR2(100),
    STOCK NUMBER DEFAULT 0,
    PRICE NUMBER CONSTRAINT PRICE_NN NOT NULL,
    CONSTRAINT PNO_FK FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT,
    CONSTRAINT OPTION_PK PRIMARY KEY(PRODUCT_NO, OPTION_NMAE)
);

COMMENT ON COLUMN OPTIONS.PRODUCT_NO IS '상품번호';
COMMENT ON COLUMN OPTIONS.OPTION_NAME IS '옵션명';
COMMENT ON COLUMN OPTIONS.STOCK IS '재고';
COMMENT ON COLUMN OPTIONS.PRICE IS '가격';

--CREATE SEQUENCE SEQ_OPTNO NOCACHE;

INSERT INTO OPTIONS
VALUES('P2', '화이트', DEFAULT, 50000);

INSERT INTO OPTIONS
VALUES('P2', '블랙', DEFAULT, 50000);

INSERT INTO OPTIONS
VALUES('P3', '블루', DEFAULT, 75000);

INSERT INTO OPTIONS
VALUES('P3', '화이트', DEFAULT, 70000);

INSERT INTO OPTIONS
VALUES('P4', '15팩', DEFAULT, 25000);

INSERT INTO OPTIONS
VALUES('P4', '30팩', DEFAULT, 45000);

INSERT INTO OPTIONS
VALUES('P1', 'S', DEFAULT, 50000);

INSERT INTO OPTIONS
VALUES('P1', 'SS', DEFAULT, 55000);

INSERT INTO OPTIONS
VALUES(SEQ_OPTNO.NEXTVAL, 'P1', 'S', DEFAULT, 45000);


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
VALUES('P4', 4, 3);


INSERT INTO CART
VALUES('P5', 5, DEFAULT);

-- 주문
CREATE TABLE ORDERS(
    ORDER_NO NUMBER CONSTRAINT ORDER_PK PRIMARY KEY,
    USER_NO NUMBER NOT NULL,
    TRACKING NUMBER CONSTRAINT TRACKING_NN NOT NULL,
    ORDER_DATE DATE DEFAULT SYSDATE,
    CASH_TYPE VARCHAR2(30) CONSTRAINT CASHTYPE_NN NOT NULL,
    STATUS VARCHAR2(1) DEFAULT 'Y'  CHECK (STATUS IN('Y', 'N')),
    ADDRESS VARCHAR2(4000) CONSTRAINT ADDR_NN NOT NULL,
    MEMBER_STATUS VARCHAR2(1) DEFAULT 'M',
    CONSTRAINT UNO_FK FOREIGN KEY (USER_NO) REFERENCES MEMBER
);

COMMENT ON COLUMN ORDERS.ORDER_NO IS '주문번호';
COMMENT ON COLUMN ORDERS.USER_NO IS '사용자번호';
COMMENT ON COLUMN ORDERS.TRACKING IS '송장번호';
COMMENT ON COLUMN ORDERS.ORDER_DATE IS '구매일자';
COMMENT ON COLUMN ORDERS.CASH_DATE IS '결제수단';
COMMENT ON COLUMN ORDERS.STATUS IS '상태';
COMMENT ON COLUMN ORDERS.ADDRESS IS '주소';
COMMENT ON COLUMN ORDERS.MEMBER_STATUS IS '회원상태';


INSERT INTO ORDERS
VALUES(202310111812, 1, 123456789, DEFAULT, '카드', DEFAULT, '서울시 용산구', DEFAULT);

INSERT INTO ORDERS
VALUES(202310111813, 2, 123456780, DEFAULT, '카드', DEFAULT, '서울시 동작구', DEFAULT);

INSERT INTO ORDERS
VALUES(202310111814, 3, 123456782, DEFAULT, '카드', DEFAULT, '서울시 관악구', DEFAULT);

INSERT INTO ORDERS
VALUES(202310111815, 4, 123456788, DEFAULT, '카드', DEFAULT, '광주광역시 북구', DEFAULT);

INSERT INTO ORDERS
VALUES(202310111816, 5, 123456787, DEFAULT, '카드', DEFAULT, '경남 거제시', DEFAULT);


-- 주문상세
CREATE TABLE ORDER_DETAIL(
    ORDER_NO NUMBER,
    PRODUCT_NO VARCHAR2(10) NOT NULL,
    OPTION_NAME VARCHAR2(300) NOT NULL,
    VOLUME NUMBER CONSTRAINT VOL_NN NOT NULL,
    FOREIGN KEY (ORDER_NO) REFERENCES ORDERS,
    FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT,
    FOREIGN KEY (OPTION_NAME) REFERENCES OPTIONS
);

COMMENT ON COLUMN ORDER_DETAIL.ORDER_NO IS '주문번호';
COMMENT ON COLUMN ORDER_DETAIL.PRODUCT_NAME IS '상품번호';
COMMENT ON COLUMN ORDER_DETAIL.OPTION_NO IS '옵션명';
COMMENT ON COLUMN ORDER_DETAIL.VOLUME IS '구매수량';

INSERT INTO ORDER_DETAIL
VALUES(202310111812, 'P2', '화이트', 1);

INSERT INTO ORDER_DETAIL
VALUES(202310111812, 'P3', '블루', 1);

INSERT INTO ORDER_DETAIL
VALUES(202310111813, 'P3', '화이트', 2);

INSERT INTO ORDER_DETAIL
VALUES(202310111814, 'P3', '화이트', 1);

INSERT INTO ORDER_DETAIL
VALUES(202310111815, 'P4', '30팩', 1);

INSERT INTO ORDER_DETAIL
VALUES(202310111816, 'P1', 'S', 1);

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
    ORDER_NO NUMBER CONSTRAINT ORDERNO_NN NOT NULL,
    PRODUCT_NO VARCHAR2(10) NOT NULL,
    OPTION_NAME VARCHAR2(300) NOT NULL,
    REVIEW_CONTENT VARCHAR2(3000) NOT NULL,
    RATING NUMBER NOT NULL,
    CREATE_DATE DATE DEFAULT SYSDATE,
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y','N')),
    FOREIGN KEY (ORDER_NO) REFERENCES ORDERS,
    FOREIGN KEY (PRODUCT_NO) REFERENCES PRODUCT,
    FOREIGN KEY (OPTION_NAME) REFERENCES OPTIONS
);

COMMENT ON COLUMN REVIEW.REVIEW_NO IS '리뷰번호';
COMMENT ON COLUMN REVIEW.ORDER_NO IS '주문번호';
COMMENT ON COLUMN REVIEW.PRODUCT_NO IS '상품번호';
COMMENT ON COLUMN REVIEW.OPTIOIN_NAME IS '옵션명';
COMMENT ON COLUMN REVIEW.REVIEW_CONTENT IS '내용';
COMMENT ON COLUMN REVIEW.RATING IS '별점';
COMMENT ON COLUMN REVIEW.CREATE_DATE IS '작성일';
COMMENT ON COLUMN REVIEW.STATUS IS '상태';

CREATE SEQUENCE SEQ_REVIEW NOCACHE;

INSERT INTO REVIEW
VALUES('R' || SEQ_REVIEW.NEXTVAL, 202310111812, 'P1', 'S', '생각보다 더 튼튼한거같아서 마음에 들어요', 4.5, DEFAULT, DEFAULT);

INSERT INTO REVIEW
VALUES('R' || SEQ_REVIEW.NEXTVAL, 202310111813, 'P1', 'S', '생각보다 더 튼튼한거같아서 마음에 들어요', 4.5, DEFAULT, DEFAULT);

INSERT INTO REVIEW
VALUES('R' || SEQ_REVIEW.NEXTVAL, 202310111814, 'P1', 'S', '생각보다 더 튼튼한거같아서 마음에 들어요', 4.5, DEFAULT, DEFAULT);

INSERT INTO REVIEW
VALUES('R' || SEQ_REVIEW.NEXTVAL, 202310111815, 'P1', 'S', '생각보다 더 튼튼한거같아서 마음에 들어요', 4.5, DEFAULT, DEFAULT);

INSERT INTO REVIEW
VALUES('R' || SEQ_REVIEW.NEXTVAL, 202310111816, 'P1', 'S', '생각보다 더 튼튼한거같아서 마음에 들어요', 4.5, DEFAULT, DEFAULT);


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