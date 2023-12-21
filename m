Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01E34696
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="lHx/F1wm"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78104f6f692so26248685a.1
        for <iommu@lists.linux.dev>; Wed, 20 Dec 2023 19:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703128761; x=1703733561; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGmYN/slxAgBeZjp+ZQs88mMzGzd5XnAVtjIWHCDIHA=;
        b=lHx/F1wm3QVmy9ZCkBxjKjQKbpMtX9nwl3pbNe77S9eHfplQx3OGYzCDbLeuyxwLvv
         ePRN03rs2hsDZNKF5sJR0HF4EaC04XqsymCWt2bNqRAkAMFHMH5Xk4+spBbqmXeSUT+2
         0BUwwScUHxw6GipFGVvvw8HlztdQpY369CyKRM9VLAUv+JoWzZns08QDqciRbsEXkLAh
         E4SF/vWhWHsGmakSWc64dDHDUU1KuSHodM1ZcFnZm6YSgSBcB9db/0sB0outT4osJxzp
         nnqh0uDSNKOjX3oMaPXtMDdHES9iUWvWbFdoFrZsbGy7b8UQT5/YfC9vg2KP+l+WSftj
         O82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703128761; x=1703733561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGmYN/slxAgBeZjp+ZQs88mMzGzd5XnAVtjIWHCDIHA=;
        b=X6BsOCd8U4hLOMlKEV+OD4SKJsJOsYk3B7XvFlnKVjDcSMaVLOS24evj2bES7BuezK
         ZAnfXePY9UMPCgrN+07ZWAXM/aLMICMmwesEazqoDvg8aBBFiwg/K+gWVBoQn5i6PxeG
         cCuIWp9iGG04QH0D6p1Jk3UpTDaT965mKlkJ8S7pkX00kK6MyvkxhYZ/Bh9qitj/B2lO
         iYtZC5p2cKqAc5LN5kCcgD6NVYLLTnNk6B/z8v7ID5O5ycXsKP2zjNHsxB1/vBmSdaBb
         xW+ffm5lGAUabmKS/PmqoYbSZKt9NH70V+EXmtIkdj/BUIRchYGVTsbyq1iY9lbgIBOA
         AtRQ==
X-Gm-Message-State: AOJu0YyVyEyxcysMeYOlfANbO6Ab5KtlPy/7FzPNLItnno1lQwa7xdya
	qiJabPE74NVdkClPnP9MrgJWkQ==
X-Google-Smtp-Source: AGHT+IGNYrBgDx+nvC9AuuwI67vV1vM61BysWepXxnQdaZCSvAikEGaalUvebM9KlNFAOPYa+XowDw==
X-Received: by 2002:ae9:e64d:0:b0:781:1ae:5aa1 with SMTP id x13-20020ae9e64d000000b0078101ae5aa1mr52489qkl.29.1703128760786;
        Wed, 20 Dec 2023 19:19:20 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id m18-20020a05620a221200b0077d85695db4sm371893qkh.99.2023.12.20.19.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:19:19 -0800 (PST)
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
Subject: [RFC 2/3] iommu/intel: synchronize page table map and unmap operations
Date: Thu, 21 Dec 2023 03:19:14 +0000
Message-ID: <20231221031915.619337-3-pasha.tatashin@soleen.com>
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

Since, we are going to update  parent page table entries when lower
level page tables become emtpy and we add them to the free list.
We need a way to synchronize the operation.

Use domain->pgd_lock to protect all map and unmap operations.
This is reader/writer lock. At the beginning everything is going to be
read only mode, however, later, when free page table on unmap is added
we will add a writer section as well.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++--
 drivers/iommu/intel/iommu.h |  3 +++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4688ef797161..733f25b277a3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1082,11 +1082,13 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
 				   unsigned long last_pfn,
 				   int retain_level)
 {
+	read_lock(&domain->pgd_lock);
 	dma_pte_clear_range(domain, start_pfn, last_pfn);
 
 	/* We don't need lock here; nobody else touches the iova range */
 	dma_pte_free_level(domain, agaw_to_level(domain->agaw), retain_level,
 			   domain->pgd, 0, start_pfn, last_pfn);
+	read_unlock(&domain->pgd_lock);
 
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
@@ -1179,9 +1181,11 @@ static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
 	    WARN_ON(start_pfn > last_pfn))
 		return;
 
+	read_lock(&domain->pgd_lock);
 	/* we don't need lock here; nobody else touches the iova range */
 	dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
 			    domain->pgd, 0, start_pfn, last_pfn, freelist);
+	read_unlock(&domain->pgd_lock);
 
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
@@ -2217,6 +2221,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 
 	pteval = ((phys_addr_t)phys_pfn << VTD_PAGE_SHIFT) | attr;
 
+	read_lock(&domain->pgd_lock);
 	while (nr_pages > 0) {
 		uint64_t tmp;
 
@@ -2226,8 +2231,10 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 
 			pte = pfn_to_dma_pte(domain, iov_pfn, &largepage_lvl,
 					     gfp);
-			if (!pte)
+			if (!pte) {
+				read_unlock(&domain->pgd_lock);
 				return -ENOMEM;
+			}
 			first_pte = pte;
 
 			lvl_pages = lvl_to_nr_pages(largepage_lvl);
@@ -2287,6 +2294,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			pte = NULL;
 		}
 	}
+	read_unlock(&domain->pgd_lock);
 
 	return 0;
 }
@@ -4013,6 +4021,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	domain->pgd = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
 	if (!domain->pgd)
 		return -ENOMEM;
+	rwlock_init(&domain->pgd_lock);
 	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
 	return 0;
 }
@@ -4247,11 +4256,15 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	unsigned long start_pfn, last_pfn;
 	int level = 0;
 
+	read_lock(&dmar_domain->pgd_lock);
 	/* Cope with horrid API which requires us to unmap more than the
 	   size argument if it happens to be a large-page mapping. */
 	if (unlikely(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
-				     &level, GFP_ATOMIC)))
+				     &level, GFP_ATOMIC))) {
+		read_unlock(&dmar_domain->pgd_lock);
 		return 0;
+	}
+	read_unlock(&dmar_domain->pgd_lock);
 
 	if (size < VTD_PAGE_SIZE << level_to_offset_bits(level))
 		size = VTD_PAGE_SIZE << level_to_offset_bits(level);
@@ -4315,8 +4328,10 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	int level = 0;
 	u64 phys = 0;
 
+	read_lock(&dmar_domain->pgd_lock);
 	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level,
 			     GFP_ATOMIC);
+	read_unlock(&dmar_domain->pgd_lock);
 	if (pte && dma_pte_present(pte))
 		phys = dma_pte_addr(pte) +
 			(iova & (BIT_MASK(level_to_offset_bits(level) +
@@ -4919,8 +4934,10 @@ static int intel_iommu_read_and_clear_dirty(struct iommu_domain *domain,
 		struct dma_pte *pte;
 		int lvl = 0;
 
+		read_lock(&dmar_domain->pgd_lock);
 		pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &lvl,
 				     GFP_ATOMIC);
+		read_unlock(&dmar_domain->pgd_lock);
 		pgsize = level_size(lvl) << VTD_PAGE_SHIFT;
 		if (!pte || !dma_pte_present(pte)) {
 			iova += pgsize;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index f1ea508f45bd..cb0577ec5166 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -618,6 +618,9 @@ struct dmar_domain {
 		struct {
 			/* virtual address */
 			struct dma_pte	*pgd;
+
+			/* Synchronizes pgd map/unmap operations */
+			rwlock_t	pgd_lock;
 			/* max guest address width */
 			int		gaw;
 			/*
-- 
2.43.0.472.g3155946c3a-goog

