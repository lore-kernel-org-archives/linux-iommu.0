Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1AC882A
	for <iommu@lists.linux.dev>; Thu,  2 Feb 2023 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=ojAeZWZTS/q5DGsRDsr4pNfeq1PMMFo32HAk+mO3778=; b=FGER7ivRI9nqOjWL8qnZWxwDNb
	39pm5f8BWqpO7fYq6QibN6ZMQNOeNsT4Tg9w7Vo+6gECc8/1oeRV2ABFtChGZ49limW+d/1pIgGMI
	6wZgZ5jkMGHagoUdy5N0VpZWWjsJ3arChLUNp8epccoypGY5Q5iFN52IwwNXOvdwaeXRq9dSRv67L
	jexzaT3xActH30W/+i3QbicxHZqQOv425gL5Sur5FXyTLpHPwvrtDjg8n9dBZqrcjfi6sgZ4wuAdR
	HndfRFQO3mBLVi9gwLq1o2+rRTAz/XzyLKaQsYHafQ62KU2RwBgaEtKPlqLleGgm1mDqKHiB31COp
	qIdnlelA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pNbVU-005CFv-21;
	Thu, 02 Feb 2023 15:28:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3AE643021D4;
	Thu,  2 Feb 2023 16:28:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
	id 96E8D23F31FB6; Thu,  2 Feb 2023 16:28:40 +0100 (CET)
Message-ID: <20230202152655.564329626@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 02 Feb 2023 15:50:36 +0100
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
 Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 06/10] x86,amd_iommu: Replace cmpxchg_double()
References: <20230202145030.223740842@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |    9 +++++++--
 drivers/iommu/amd/iommu.c           |   10 ++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -979,8 +979,13 @@ union irte_ga_hi {
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
@@ -2992,10 +2992,10 @@ static int alloc_irq_index(struct amd_io
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
@@ -3006,16 +3006,14 @@ static int modify_irte_ga(struct amd_iom
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


