Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6614AA1
	for <iommu@lists.linux.dev>; Wed, 31 May 2023 13:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=EFRjNdGkKmPs8t8EQjORBoOhY59fsy+w5h28GAZsB6Q=; b=UtVwkPrM/XC85pGt7r9J/NNpRu
	UL+91AuyLHvjrvG49pQLde3FfNNUmo1htXYmBdQi6zGavV3SSWRcdYYRg2pT/RFAN1s0beaKp6uIt
	qmsCYWl48JdxSnUcl0TZnP/DxO6Las7rvju+4B6BHlugr3GN/O1xwkrFbvEm1TcgBc0nFb02d74Q+
	FugUvUwlkjaq40KU1RNfTvbPliEJmyGnO7N9Y8FQ1QTQ6NKNxRxIvQbmh4ObO5y3tSWG6QFsZealY
	U6f5lhw6Luo8Kph7RKkJJmtoJB0hFyStxCRmgm2iCzUziTKBMxS0MFEMxeMLjZEeDlsmuqhPZCMlC
	fkpnhqUg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q4LrG-00FTCc-1L;
	Wed, 31 May 2023 13:27:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55AC1300C4B;
	Wed, 31 May 2023 15:27:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
	id 992BE243B8570; Wed, 31 May 2023 15:27:16 +0200 (CEST)
Message-ID: <20230531132323.788955257@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 31 May 2023 15:08:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: torvalds@linux-foundation.org
Cc: corbet@lwn.net,
 will@kernel.org,
 peterz@infradead.org,
 boqun.feng@gmail.com,
 mark.rutland@arm.com,
 catalin.marinas@arm.com,
 dennis@kernel.org,
 tj@kernel.org,
 cl@linux.com,
 hca@linux.ibm.com,
 gor@linux.ibm.com,
 agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com,
 svens@linux.ibm.com,
 tglx@linutronix.de,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 x86@kernel.org,
 hpa@zytor.com,
 joro@8bytes.org,
 suravee.suthikulpanit@amd.com,
 robin.murphy@arm.com,
 dwmw2@infradead.org,
 baolu.lu@linux.intel.com,
 Arnd Bergmann <arnd@arndb.de>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 davem@davemloft.net,
 penberg@kernel.org,
 rientjes@google.com,
 iamjoonsoo.kim@lge.com,
 Andrew Morton <akpm@linux-foundation.org>,
 vbabka@suse.cz,
 roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 linux-s390@vger.kernel.org,
 iommu@lists.linux.dev,
 linux-arch@vger.kernel.org,
 linux-crypto@vger.kernel.org,
 sfr@canb.auug.org.au,
 mpe@ellerman.id.au,
 James.Bottomley@hansenpartnership.com,
 deller@gmx.de,
 linux-parisc@vger.kernel.org,
 Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 08/12] x86,amd_iommu: Replace cmpxchg_double()
References: <20230531130833.635651916@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |    9 +++++++--
 drivers/iommu/amd/iommu.c           |   10 ++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -986,8 +986,13 @@ union irte_ga_hi {
 };
 
 struct irte_ga {
-	union irte_ga_lo lo;
-	union irte_ga_hi hi;
+	union {
+		struct {
+			union irte_ga_lo lo;
+			union irte_ga_hi hi;
+		};
+		u128 irte;
+	};
 };
 
 struct irq_2_irte {
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3003,10 +3003,10 @@ static int alloc_irq_index(struct amd_io
 static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
 			  struct irte_ga *irte, struct amd_ir_data *data)
 {
-	bool ret;
 	struct irq_remap_table *table;
-	unsigned long flags;
 	struct irte_ga *entry;
+	unsigned long flags;
+	u128 old;
 
 	table = get_irq_table(iommu, devid);
 	if (!table)
@@ -3017,16 +3017,14 @@ static int modify_irte_ga(struct amd_iom
 	entry = (struct irte_ga *)table->table;
 	entry = &entry[index];
 
-	ret = cmpxchg_double(&entry->lo.val, &entry->hi.val,
-			     entry->lo.val, entry->hi.val,
-			     irte->lo.val, irte->hi.val);
 	/*
 	 * We use cmpxchg16 to atomically update the 128-bit IRTE,
 	 * and it cannot be updated by the hardware or other processors
 	 * behind us, so the return value of cmpxchg16 should be the
 	 * same as the old value.
 	 */
-	WARN_ON(!ret);
+	old = entry->irte;
+	WARN_ON(!try_cmpxchg128(&entry->irte, &old, irte->irte));
 
 	if (data)
 		data->ref = entry;


