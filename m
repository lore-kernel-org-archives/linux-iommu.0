Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D577D3CE0A2
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499954; cv=none; b=D5uJJ8wsHsmXHctOC8D57EKeYCcvmcDpgMUGMae9mVS3CkC51GaAOZ0xljL4N94WSFHXh6nSwmMDRBu3hEcKrCvw6i5pDoHxqwllsNVScMOrVsnzMVlTARJU63Fif1Tg2Td145n+7x8nyw+zM3O+gzR//SwxFX3c3yi4fARdvbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499954; c=relaxed/simple;
	bh=46L9LTzcQcvQkioanu40YoVpL2SL9Yf/P8f0rxz/3Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnjkRyu6SvyjPzNFhSSQ3VwvKGMVkS5D6VUO1i6SAN4v0RTY53wSs4ZbQmcCwkXOhq7hYDsf5HB3gK6BxVU6yETeDIpl2SrBKNdAOwl1JlPsb2Cf90HkfyVxw6mFeFlAFRIkYbxgngQJ3whv9mDctsfATrBr7ieMp8ljE7VofGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q/xHi9Vt; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q/xHi9Vt"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499945; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4BjT23R8uSreRxsom16Fm8xCEovN+6PRTMHyPqG167s=;
	b=Q/xHi9VtpAOeWiQCNd6WUGDprjUaTGCg2YsjbgdYQCfc3x5kt8n2oK577LleGtZZ8e0FJff/MNx1yOF72o1WzTmbD1IelpK7Veqsa1T/U0AvKLOEAeiBAr3ZpC3EFx3qYmOdlrbuFe09VBUVDKEpylrFaVSFN6t0Cy38h+fBQFI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR6t_1780499942;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR6t_1780499942 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:19:02 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: adrian.larumbe@collabora.com,
	airlied@gmail.com,
	alex@shazbot.org,
	alikernel-developer@linux.alibaba.com,
	baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	oliver.yang@linux.alibaba.com,
	robh@kernel.org,
	robin.murphy@arm.com,
	shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com,
	suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de,
	wei.guo.simon@linux.alibaba.com,
	will@kernel.org,
	xlpang@linux.alibaba.com
Subject: [PATCH v3 24/32] iommufd: use iova_to_phys_length for efficient unmap
Date: Wed,  3 Jun 2026 23:17:56 +0800
Message-ID: <20260603151804.1963871-25-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use iommu_iova_to_phys_length() to get PTE page size in
batch_from_domain and raw_pages_from_domain, allowing traversal
by actual mapping granularity instead of PAGE_SIZE steps.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
---
 drivers/iommu/iommufd/pages.c | 74 +++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 9bdb2945afe1..40a2fe9adf9c 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -417,17 +417,42 @@ static void batch_from_domain(struct pfn_batch *batch,
 	if (start_index == iopt_area_index(area))
 		page_offset = area->page_offset;
 	while (start_index <= last_index) {
+		size_t pgsize;
+		unsigned long npages;
+		unsigned long i;
+
 		/*
-		 * This is pretty slow, it would be nice to get the page size
-		 * back from the driver, or have the driver directly fill the
-		 * batch.
+		 * Use iova_to_phys_length to get both the physical address
+		 * and the contiguous mapped length in a single page table
+		 * walk, allowing us to skip ahead by the contiguous region
+		 * size instead of walking page tables for every PAGE_SIZE.
+		 * Query at page-aligned iova so pgsize covers from page start.
 		 */
-		phys = iommu_iova_to_phys(domain, iova) - page_offset;
-		if (!batch_add_pfn(batch, PHYS_PFN(phys)))
-			return;
-		iova += PAGE_SIZE - page_offset;
+		phys = iommu_iova_to_phys_length(domain, iova - page_offset,
+						  &pgsize);
+		if (WARN_ON(phys == PHYS_ADDR_MAX))
+			break;
+		if (WARN_ON(!pgsize || pgsize < PAGE_SIZE))
+			pgsize = PAGE_SIZE;
+
+		/*
+		 * pgsize is the contiguous length from the page-aligned
+		 * iova, so npages is simply pgsize / PAGE_SIZE.
+		 */
+		npages = pgsize / PAGE_SIZE;
+		npages = min_t(unsigned long, npages,
+			       last_index - start_index + 1);
+		if (!npages)
+			npages = 1;
+
+		for (i = 0; i < npages; i++) {
+			if (!batch_add_pfn(batch, PHYS_PFN(phys) + i))
+				return;
+		}
+
+		iova += npages * PAGE_SIZE - page_offset;
 		page_offset = 0;
-		start_index++;
+		start_index += npages;
 	}
 }
 
@@ -445,11 +470,36 @@ static struct page **raw_pages_from_domain(struct iommu_domain *domain,
 	if (start_index == iopt_area_index(area))
 		page_offset = area->page_offset;
 	while (start_index <= last_index) {
-		phys = iommu_iova_to_phys(domain, iova) - page_offset;
-		*(out_pages++) = pfn_to_page(PHYS_PFN(phys));
-		iova += PAGE_SIZE - page_offset;
+		size_t pgsize;
+		unsigned long npages;
+		unsigned long i;
+
+		/*
+		 * Resolve the contiguous mapped length together with the
+		 * physical address so we can fill multiple struct page
+		 * pointers per page table walk when the IOMMU uses large
+		 * pages. Query at page-aligned iova so pgsize covers from
+		 * page start.
+		 */
+		phys = iommu_iova_to_phys_length(domain, iova - page_offset,
+						  &pgsize);
+		if (WARN_ON(phys == PHYS_ADDR_MAX))
+			break;
+		if (WARN_ON(!pgsize || pgsize < PAGE_SIZE))
+			pgsize = PAGE_SIZE;
+
+		npages = pgsize / PAGE_SIZE;
+		npages = min_t(unsigned long, npages,
+			       last_index - start_index + 1);
+		if (!npages)
+			npages = 1;
+
+		for (i = 0; i < npages; i++)
+			*(out_pages++) = pfn_to_page(PHYS_PFN(phys) + i);
+
+		iova += npages * PAGE_SIZE - page_offset;
 		page_offset = 0;
-		start_index++;
+		start_index += npages;
 	}
 	return out_pages;
 }
-- 
2.43.7

