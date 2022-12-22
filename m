Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108BF15A9
	for <iommu@lists.linux.dev>; Thu, 22 Dec 2022 01:21:36 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id u10so354563qvp.4
        for <iommu@lists.linux.dev>; Wed, 21 Dec 2022 17:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vQ+zYR3T/MLmRvx1y4HrhYHCm/YFhPZhfUkcUcESfM=;
        b=l2fa+q+FEd2XVftJdKunAWsH1HG7S8dBsHb+pyQnkCSX1TXkuXti8JKHEfARmsSWRT
         xQebS6MZkDhnAZE1A3MSyIEK1eUPZUe1gprb22RcFQ//PuymRzd8BLNOtFAGp/a61FTx
         57JSoFp9tNTtN1QcKe76hmTtf/9LzGx+KUuDqVsOlyBa3P8Z9dneruz+vGAafZacrKIF
         5D4qdPPjWSMkoveXI7RPaxRIbWKtRPn50A747wMHhLLoo8U+VfMCok3edYL+wnhGBTCJ
         v8NDSlV/3lrChQ+UVwl5AoSSDCCE4tVU9WZAvbYyVr00y/GTw1B5kOj7gmspi/N26quY
         /XKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vQ+zYR3T/MLmRvx1y4HrhYHCm/YFhPZhfUkcUcESfM=;
        b=xCCn8furcxnkQ8D1zzH27TIqgQr0rpNhNSlWONOXkUP2YsFm56JpXGAWTt1VW4f8za
         kskqb26fc4Pr4xh3dypdo4OUbNefT7Ppj9Rt7hw4uZgLWDYiWnNUfgraO4xyfPO5miEn
         wfowkNe7P/kbC4RRkEcIjtJBuxq8daYkaS5+VXhxbcPGURC01YOOYK7c8Wm22poiVO9n
         /8ns5PenMj8o0grachMdOEqWG+vySOvRSFN9olAVG+xk/cJ0q7RlZfmjanmsfjpM2YM3
         zZG/yHQEA8orqFBLAb5QGFwlPkdSXg247ANuGA1bE41wifpmWchy5/cmowKlMH0zLe4i
         YQUg==
X-Gm-Message-State: AFqh2kouOrjvxrSd7aa2UUF4CXBWquZBaJWI2JnzKv4HfTx7ZgzOkl4F
	/JZNBYF1fQobWrdHQDA0bqM=
X-Google-Smtp-Source: AMrXdXsShUh4L0yNGW8xONTed3Jku8Vj2tplYIwpahvEr5EHAURbNPUd/5CxhDGXUPZFyuLmJTm1qQ==
X-Received: by 2002:a05:6214:1bcd:b0:4c7:595c:993b with SMTP id m13-20020a0562141bcd00b004c7595c993bmr7380408qvc.40.1671672095984;
        Wed, 21 Dec 2022 17:21:35 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x18-20020a05620a259200b006fc2b672950sm11762886qko.37.2022.12.21.17.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 17:21:35 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id 53E7F27C0054;
	Wed, 21 Dec 2022 20:21:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 21 Dec 2022 20:21:34 -0500
X-ME-Sender: <xms:HLGjY9HklIzv77_Ct9lMRDUUZb6eQZa3yWh170mrFyW89x0jtHNjOA>
    <xme:HLGjYyVPmxd67lgBprsePVUHyTIbmxYBuswvDpnSE1LaX4Fk0VtZwvRh0xyufIUfo
    Z4CcOSYLSo3jI-gsA>
X-ME-Received: <xmr:HLGjY_JIuJnH4DJCOG6szjiAGggRCSJAEb8Iwik3CXE1nqxc07XdZPwLNC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeelgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddv
    hedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:HLGjYzHn-2QPGDrrRW8mLT94tasGENTscfk3B9t1nA3LK58a-ZZAMw>
    <xmx:HLGjYzU6ZywxNOeGu02VYyDqSSw-TM6buuzedUbIQ3Dz8ouTDzdx1Q>
    <xmx:HLGjY-MCAsYWrrwM_UVYF3caK2jVGszAVuVLkzMGsuXrqP9hm8VU4w>
    <xmx:HrGjY1HNBcK7WC41nwtRf2BlnZ2Rer4p-OxYjeo5j3vOumT9YXfVdghNAUc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Dec 2022 20:21:31 -0500 (EST)
Date: Wed, 21 Dec 2022 17:21:09 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
	mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org,
	tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>,
	davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	Arnd Bergmann <arnd@arndb.de>, penberg@kernel.org,
	rientjes@google.com, iamjoonsoo.kim@lge.com,
	Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-s390@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 00/12] Introduce cmpxchg128() -- aka. the demise of
 cmpxchg_double()
Message-ID: <Y6OxBW5F/ZF5wocE@boqun-archlinux>
References: <20221219153525.632521981@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219153525.632521981@infradead.org>

Hi Peter,

On Mon, Dec 19, 2022 at 04:35:25PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> Since Linus hated on cmpxchg_double(), a few patches to get rid of it, as proposed here:
> 
>   https://lkml.kernel.org/r/Y2U3WdU61FvYlpUh@hirez.programming.kicks-ass.net
> 
> based on tip/master because Linus' tree is moving a wee bit fast at the moment.
> 
> 0day robot is all green for building, very limited testing on arm64/s390
> for obvious raisins -- I tried to get the asm right, but please, double
> check.
> 

I added some test cases for cmpxcgh128 APIs, and found two issues. I
will reply separately in the patches. The test cases themselves are at
the end, let me know if you want to me to send a proper patch.

Regards,
Boqun

------------------------------------------------------------>8
Subject: [PATCH] atomic: Add test cases for cmpxchg128 family

Besides for 32bit and 64bit cmpxchg, we only test via atomic_cmpxchg_*
APIs, add tests via cmpxchg* APIs while we are at it.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/atomic64_test.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index d9d170238165..7f79d0704ba8 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -76,12 +76,19 @@ do {								\
 	BUG_ON(atomic##bit##_read(&v) != expect);		\
 } while (0)
 
+#define TEST_ARGS_PLAIN(_, op, init, ret, expect, args...)	\
+do {								\
+	__WRITE_ONCE(n, init);					\
+	BUG_ON(op(&n, ##args) != ret);				\
+	BUG_ON(__READ_ONCE(n) != expect);			\
+} while (0)
+
 #define XCHG_FAMILY_TEST(bit, init, new)				\
 do {									\
 	FAMILY_TEST(TEST_ARGS, bit, xchg, init, init, new, new);	\
 } while (0)
 
-#define CMPXCHG_FAMILY_TEST(bit, init, new, wrong)			\
+#define ATOMIC_CMPXCHG_FAMILY_TEST(bit, init, new, wrong)		\
 do {									\
 	FAMILY_TEST(TEST_ARGS, bit, cmpxchg, 				\
 			init, init, new, init, new);			\
@@ -89,6 +96,14 @@ do {									\
 			init, init, init, wrong, new);			\
 } while (0)
 
+#define CMPXCHG_FAMILY_TEST(bit, init, new, wrong)			\
+do {									\
+	FAMILY_TEST(TEST_ARGS_PLAIN, _, cmpxchg##bit, 			\
+			init, init, new, init, new);			\
+	FAMILY_TEST(TEST_ARGS_PLAIN, _, cmpxchg##bit,			\
+			init, init, init, wrong, new);			\
+} while (0)
+
 #define INC_RETURN_FAMILY_TEST(bit, i)			\
 do {							\
 	FAMILY_TEST(TEST_ARGS, bit, inc_return,		\
@@ -109,6 +124,7 @@ static __init void test_atomic(void)
 	int one = 1;
 
 	atomic_t v;
+	int n;
 	int r;
 
 	TEST(, add, +=, onestwos);
@@ -139,6 +155,7 @@ static __init void test_atomic(void)
 	DEC_RETURN_FAMILY_TEST(, v0);
 
 	XCHG_FAMILY_TEST(, v0, v1);
+	ATOMIC_CMPXCHG_FAMILY_TEST(, v0, v1, onestwos);
 	CMPXCHG_FAMILY_TEST(, v0, v1, onestwos);
 
 }
@@ -155,6 +172,7 @@ static __init void test_atomic64(void)
 	int r_int;
 
 	atomic64_t v = ATOMIC64_INIT(v0);
+	long long n = 0;
 	long long r = v0;
 	BUG_ON(v.counter != r);
 
@@ -201,6 +219,7 @@ static __init void test_atomic64(void)
 	DEC_RETURN_FAMILY_TEST(64, v0);
 
 	XCHG_FAMILY_TEST(64, v0, v1);
+	ATOMIC_CMPXCHG_FAMILY_TEST(64, v0, v1, v2);
 	CMPXCHG_FAMILY_TEST(64, v0, v1, v2);
 
 	INIT(v0);
@@ -245,10 +264,30 @@ static __init void test_atomic64(void)
 	BUG_ON(!r_int);
 }
 
+#ifdef system_has_cmpxchg128
+static __init void test_atomic128(void)
+{
+	long long v0 = 0xaaa31337c001d00dLL;
+	long long v1 = 0xdeadbeefdeafcafeLL;
+	long long v2 = 0xfaceabadf00df001LL;
+	long long v3 = 0x8000000000000000LL;
+
+	s128 init = ((s128)v0 << 64) + v1;
+	s128 new = ((s128)v1 << 64) + v0;
+	s128 wrong = ((s128)v2 << 64) + v3;
+	s128 n = 1;
+
+	CMPXCHG_FAMILY_TEST(128, init, new, wrong);
+}
+#else
+static __init void test_atomic128(void) {}
+#endif
+
 static __init int test_atomics_init(void)
 {
 	test_atomic();
 	test_atomic64();
+	test_atomic128();
 
 #ifdef CONFIG_X86
 	pr_info("passed for %s platform %s CX8 and %s SSE\n",
-- 
2.38.1

