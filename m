Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1478C63
	for <iommu@lists.linux.dev>; Fri, 26 Apr 2024 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714103010; cv=none; b=aHU1u3SnR2BQbqSIIFAyfHYCq9XsMt7X6ADPKjBxT0/aOqMmyRzF7W8+USVsjkZnPma6G4pp/dBVqrBZngVOgkXXSBDW1zRn4KUKRqF1FBYuaqPukDwu6lmvoGaBmt4XzoUs2Yjnm0OO58ySxhl9xpQYbRvYwl0InZ1SESY4oQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714103010; c=relaxed/simple;
	bh=3z+GXuQGkWoDNcuvF/alZVLngGHITQXAlp4EnS0+nzc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxR8IVvDlU7RQGvr/ZD03h6is19dGwiMDNvkEBFLbh6PVzzRJvWuDpuBru/ej1+M62Rba5b2k9FXFEKp89Lecyxo1pLS6CgEpzubbHYZH3kOHFNsWsxftFlAxnoiLiwEg/uD8CLcAMZfT8x9aIgGDooSpqIbY878ieDyRUkcwCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=QijkS0oE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="QijkS0oE"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4365c1451d4so11449781cf.2
        for <iommu@lists.linux.dev>; Thu, 25 Apr 2024 20:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1714103007; x=1714707807; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GURCfQOZVuUrKhF3OYuy9zEmklzBEXgHfus1Ew76lR0=;
        b=QijkS0oEYMM5XsJ7zEpJz9Lh23pynwdAn+aR0XZ4jkkQE3IfXw70XVQKsSsHuO4Nlg
         53XY5wD9exjBUvI3l11i7i61BfdJEQ/MCGs5XuZwi1pVr2SGDQcMkBqKBytBXEolmELz
         jE+Q3TBAi/YQlddZiTb3auryzusCx0XBOFxRclVETCSOheZgSemU4NsHjxnLZTIwxm5f
         tH9zGFvyqU9icRhLfCVUF2rQMUvNWWXeXEa9LzD1dkQaCP+BEOBqeahjBO57uyRrK6Ot
         1b0QeeL/MfywkUD8UT8QHoyNu+fT2meq94tICUR4Ys2MYabi3JQwJL3RUJrYNZlcCuZG
         4zCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714103007; x=1714707807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GURCfQOZVuUrKhF3OYuy9zEmklzBEXgHfus1Ew76lR0=;
        b=EaH27Yfxd6rkGOMeIeJyzFOn8hY0Bq17/E04GT4Dech/pgCmopGv0cEdSV04fgEP1A
         D1qqjNjYBs7F6TRwwjj4FGlZmguEONwh+96n3UK4KyD4khGwceufvo3bPus5EkHX4poh
         Msnc3+gCyXqVs8DXQ5vtk4Bqoh3hxCN6JD1r1lOt1kNdeHy61XRKqhnjTGEM2lhIR7+Q
         X/9b78ovToyK2eA1lvp4alInqOo5GHom7m7X/RKusho/yDJobBm56ge9UiesOsdp9IBf
         eEprxclqW3EfpkM09X5p7GOzjgkmQCDvxwbWiUlPn4X2f38E06MCngsXCzUMstwWt4rL
         64Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXj7tvHJMbNwb+AeQhhAHQMo3b9hHm/qkoHYEImcYTfJa3wBApJIJdFmvG3ouURRW8OUYRhH1qz9oRJrBQJ3Uy9e+INiIk=
X-Gm-Message-State: AOJu0Yw3sPvNP1qy6EAesfNgUDgXo/Y3rzu9JnA8vZc/orIM0bssc5U9
	NlK1zIg1isIP1sZmYhrvTcI4A9fXHEXXmUpINIUXTCrFeehnshrQpcGYiL0B8CW06IzUxYcB8il
	9
X-Google-Smtp-Source: AGHT+IHx2jRF9sHZe0ji37o0f9d/WxOmNqlXZKb8rptZFsjIiM8LnbaBigJJCVNFjwy+WUFUifGdEw==
X-Received: by 2002:ac8:7f0e:0:b0:437:a1a2:f832 with SMTP id f14-20020ac87f0e000000b00437a1a2f832mr2149126qtk.11.1714103007410;
        Thu, 25 Apr 2024 20:43:27 -0700 (PDT)
Received: from soleen.c.googlers.com.com (129.177.85.34.bc.googleusercontent.com. [34.85.177.129])
        by smtp.gmail.com with ESMTPSA id c6-20020ac80546000000b00436bb57faddsm7540815qth.25.2024.04.25.20.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 20:43:27 -0700 (PDT)
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
Subject: [RFC v2 2/3] iommu/intel: synchronize page table map and unmap operations
Date: Fri, 26 Apr 2024 03:43:22 +0000
Message-ID: <20240426034323.417219-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240426034323.417219-1-pasha.tatashin@soleen.com>
References: <20240426034323.417219-1-pasha.tatashin@soleen.com>
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
index 1bfb6eccad05..8c7e596728b5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -995,11 +995,13 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
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
@@ -1093,9 +1095,11 @@ static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
 	    WARN_ON(start_pfn > last_pfn))
 		return;
 
+	read_lock(&domain->pgd_lock);
 	/* we don't need lock here; nobody else touches the iova range */
 	dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
 			    domain->pgd, 0, start_pfn, last_pfn, freelist);
+	read_unlock(&domain->pgd_lock);
 
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
@@ -2088,6 +2092,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 
 	pteval = ((phys_addr_t)phys_pfn << VTD_PAGE_SHIFT) | attr;
 
+	read_lock(&domain->pgd_lock);
 	while (nr_pages > 0) {
 		uint64_t tmp;
 
@@ -2097,8 +2102,10 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 
 			pte = pfn_to_dma_pte(domain, iov_pfn, &largepage_lvl,
 					     gfp);
-			if (!pte)
+			if (!pte) {
+				read_unlock(&domain->pgd_lock);
 				return -ENOMEM;
+			}
 			first_pte = pte;
 
 			lvl_pages = lvl_to_nr_pages(largepage_lvl);
@@ -2158,6 +2165,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			pte = NULL;
 		}
 	}
+	read_unlock(&domain->pgd_lock);
 
 	return 0;
 }
@@ -3829,6 +3837,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	domain->pgd = iommu_alloc_page_node(domain->nid, GFP_ATOMIC);
 	if (!domain->pgd)
 		return -ENOMEM;
+	rwlock_init(&domain->pgd_lock);
 	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
 	return 0;
 }
@@ -4074,11 +4083,15 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
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
@@ -4145,8 +4158,10 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	int level = 0;
 	u64 phys = 0;
 
+	read_lock(&dmar_domain->pgd_lock);
 	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level,
 			     GFP_ATOMIC);
+	read_unlock(&dmar_domain->pgd_lock);
 	if (pte && dma_pte_present(pte))
 		phys = dma_pte_addr(pte) +
 			(iova & (BIT_MASK(level_to_offset_bits(level) +
@@ -4801,8 +4816,10 @@ static int intel_iommu_read_and_clear_dirty(struct iommu_domain *domain,
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
index e5c1eb23897f..2f38b087ea4f 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -615,6 +615,9 @@ struct dmar_domain {
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
2.44.0.769.g3c40516874-goog

