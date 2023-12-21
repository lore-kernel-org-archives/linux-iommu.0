Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5044419
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 03:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VWBtIXAg"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-77f642b9a22so108207885a.0
        for <iommu@lists.linux.dev>; Wed, 20 Dec 2023 19:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703128759; x=1703733559; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHVoW/MSujJv5NIsFUvfttxthtWbl9YXxYuPhvKhYN4=;
        b=VWBtIXAgfQASOQyo+HQBuMNV5nunahG4R7ggIElNlfBdLrwkfVm32yyScBZCSpqiTY
         g+43Hiv8Y5aBqHpVQfVqnBMTLQV9R6/auNpSkbigoe6SrIiSvvtPxOLahF35wzxj3enx
         GjIqsYuYa5NBkoLsFrs5FmGX6HyFidcjU3VCA6guyUKQo3dbp2APfhu0xij3K8wdXDEx
         PWm4oiwRSmEO8jig3rbNL9JOMfZudXKxZLvOS3c8N2d3n+EV0ZwwrvtRHKsD8sE7Ac2o
         yG48+UPPvLEKHi52Ilt3dBhdkZJGYfk29pWndaF2UyIs0aW45GkJO3BJW9sWK8CuPfPT
         QWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703128759; x=1703733559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHVoW/MSujJv5NIsFUvfttxthtWbl9YXxYuPhvKhYN4=;
        b=d/RNTQMQSO2gzTZRvvTGYJg7kCQuSIa5RyLLg22mjb7yUBZRdIXYFP2TkwOUCUskp+
         OnUjY6Fog8CBC6veRhE1A+vnvY+Ev5ZudpCpA57yS1afWbAtIE5spNQhuqyUglyimZGE
         iWI8qDfTGzX9tJjkiIyRSiyMrqtmgUzz5sryOTSAD+H3gF/MwkeRIsVJTSFY+Gpa/B1G
         LBxMeXRqNweTWi9V/3Gzwtxdh51W8uiaS17XahGIVDJlVecfUpDMCO9WJ1u41SvftRLu
         QJKcyw9q4oxgWF6ZtMWEYKH1Q3LML0Srg+pSn42iIpe2F2mV0eFB7xuHOCtowROznhKw
         +vDw==
X-Gm-Message-State: AOJu0Yye5ZXb9EU2LsiYR/a50tz0srouNbDbjbasmYVOzDG2OmT5/Atv
	nuk5qoi4Fjjfv5L9t9yhdicvjw==
X-Google-Smtp-Source: AGHT+IHY+sU7XqrPzSe1RhsjN9sLabzyaNEAd3hCwu8MQn6FSl4jaGvTX3sXjbffBRHiVyH9teDPwg==
X-Received: by 2002:a05:620a:461f:b0:781:97:fbc4 with SMTP id br31-20020a05620a461f00b007810097fbc4mr67467qkb.25.1703128759521;
        Wed, 20 Dec 2023 19:19:19 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id m18-20020a05620a221200b0077d85695db4sm371893qkh.99.2023.12.20.19.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:19:18 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	linux-kernel@vger.kernel.org,
	rientjes@google.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev
Subject: [RFC 1/3] iommu/intel: Use page->refcount to count number of entries in IOMMU
Date: Thu, 21 Dec 2023 03:19:13 +0000
Message-ID: <20231221031915.619337-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231221031915.619337-1-pasha.tatashin@soleen.com>
References: <20231221031915.619337-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to be able to efficiently free empty page table levels, count the
number of entries in each page table my incremeanting and decremeanting
refcount every time a PTE is inserted or removed form the page table.

For this to work correctly, add two helper function:
dma_clear_pte and dma_set_pte where counting is performed,

Also, modify the code so every page table entry is always updated using the
two new functions.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/intel/iommu.c | 40 +++++++++++++++++++++---------------
 drivers/iommu/intel/iommu.h | 41 +++++++++++++++++++++++++++++++------
 2 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 897159dba47d..4688ef797161 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -949,7 +949,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			if (domain->use_first_level)
 				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
 
-			if (cmpxchg64(&pte->val, 0ULL, pteval))
+			if (dma_set_pte(pte, pteval))
 				/* Someone else set it while we were thinking; use theirs. */
 				free_pgtable_page(tmp_page);
 			else
@@ -1021,7 +1021,8 @@ static void dma_pte_clear_range(struct dmar_domain *domain,
 			continue;
 		}
 		do {
-			dma_clear_pte(pte);
+			if (dma_pte_present(pte))
+				dma_clear_pte(pte);
 			start_pfn += lvl_to_nr_pages(large_page);
 			pte++;
 		} while (start_pfn <= last_pfn && !first_pte_in_page(pte));
@@ -1062,7 +1063,8 @@ static void dma_pte_free_level(struct dmar_domain *domain, int level,
 		 */
 		if (level < retain_level && !(start_pfn > level_pfn ||
 		      last_pfn < level_pfn + level_size(level) - 1)) {
-			dma_clear_pte(pte);
+			if (dma_pte_present(pte))
+				dma_clear_pte(pte);
 			domain_flush_cache(domain, pte, sizeof(*pte));
 			free_pgtable_page(level_pte);
 		}
@@ -1093,12 +1095,13 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
 	}
 }
 
-/* When a page at a given level is being unlinked from its parent, we don't
-   need to *modify* it at all. All we need to do is make a list of all the
-   pages which can be freed just as soon as we've flushed the IOTLB and we
-   know the hardware page-walk will no longer touch them.
-   The 'pte' argument is the *parent* PTE, pointing to the page that is to
-   be freed. */
+/*
+ * A given page at a given level is being unlinked from its parent.
+ * We need to make a list of all the pages which can be freed just as soon as
+ * we've flushed the IOTLB and we know the hardware page-walk will no longer
+ * touch them. The 'pte' argument is the *parent* PTE, pointing to the page
+ * that is to be freed.
+ */
 static void dma_pte_list_pagetables(struct dmar_domain *domain,
 				    int level, struct dma_pte *pte,
 				    struct list_head *freelist)
@@ -1106,17 +1109,20 @@ static void dma_pte_list_pagetables(struct dmar_domain *domain,
 	struct page *pg;
 
 	pg = pfn_to_page(dma_pte_addr(pte) >> PAGE_SHIFT);
-	list_add_tail(&pg->lru, freelist);
-
-	if (level == 1)
-		return;
-
 	pte = page_address(pg);
+
 	do {
-		if (dma_pte_present(pte) && !dma_pte_superpage(pte))
-			dma_pte_list_pagetables(domain, level - 1, pte, freelist);
+		if (dma_pte_present(pte)) {
+			if (level > 1 && !dma_pte_superpage(pte)) {
+				dma_pte_list_pagetables(domain, level - 1, pte,
+							freelist);
+			}
+			dma_clear_pte(pte);
+		}
 		pte++;
 	} while (!first_pte_in_page(pte));
+
+	list_add_tail(&pg->lru, freelist);
 }
 
 static void dma_pte_clear_level(struct dmar_domain *domain, int level,
@@ -2244,7 +2250,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		/* We don't need lock here, nobody else
 		 * touches the iova range
 		 */
-		tmp = cmpxchg64_local(&pte->val, 0ULL, pteval);
+		tmp = dma_set_pte(pte, pteval);
 		if (tmp) {
 			static int dumps = 5;
 			pr_crit("ERROR: DMA PTE for vPFN 0x%lx already set (to %llx not %llx)\n",
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ce030c5b5772..f1ea508f45bd 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -802,11 +802,6 @@ struct dma_pte {
 	u64 val;
 };
 
-static inline void dma_clear_pte(struct dma_pte *pte)
-{
-	pte->val = 0;
-}
-
 static inline u64 dma_pte_addr(struct dma_pte *pte)
 {
 #ifdef CONFIG_64BIT
@@ -818,9 +813,43 @@ static inline u64 dma_pte_addr(struct dma_pte *pte)
 #endif
 }
 
+#define DMA_PTEVAL_PRESENT(pteval) (((pteval) & 3) != 0)
 static inline bool dma_pte_present(struct dma_pte *pte)
 {
-	return (pte->val & 3) != 0;
+	return DMA_PTEVAL_PRESENT(pte->val);
+}
+
+static inline void dma_clear_pte(struct dma_pte *pte)
+{
+	u64 old_pteval;
+
+	old_pteval = xchg(&pte->val, 0ULL);
+	if (DMA_PTEVAL_PRESENT(old_pteval)) {
+		struct page *pg = virt_to_page(pte);
+		int rc = page_ref_dec_return(pg);
+
+		WARN_ON_ONCE(rc > 512 || rc < 1);
+	} else {
+		/* Ensure that we cleared a valid entry from the page table */
+		WARN_ON(1);
+	}
+}
+
+static inline u64 dma_set_pte(struct dma_pte *pte, u64 pteval)
+{
+	u64 old_pteval;
+
+	/* Ensure we about to set a valid entry to the page table */
+	WARN_ON(!DMA_PTEVAL_PRESENT(pteval));
+	old_pteval = cmpxchg64(&pte->val, 0ULL, pteval);
+	if (old_pteval == 0) {
+		struct page *pg = virt_to_page(pte);
+		int rc = page_ref_inc_return(pg);
+
+		WARN_ON_ONCE(rc > 513 || rc < 2);
+	}
+
+	return old_pteval;
 }
 
 static inline bool dma_sl_pte_test_and_clear_dirty(struct dma_pte *pte,
-- 
2.43.0.472.g3155946c3a-goog

