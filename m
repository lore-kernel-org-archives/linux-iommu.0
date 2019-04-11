Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ADEC10F14
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:03:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 215232184B
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 00:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XmDArHBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215232184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5A95F2D09;
	Fri, 12 Apr 2019 00:03:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2BD852491
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:49:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E609063D
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 18:49:18 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id d13so6147953edr.5
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 11:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=h4NTbwpzCv6yGyNv0iD8bNRgN2z2J8QjAYzKFda07OQ=;
	b=XmDArHBqr3lcdwiD6rmDPJRrqBJX1smBT6QSTA2zzebiEMqn8UHCyGmgPzWi6atDRP
	PPUqmOGZYXS23R7Ffooko6LD7qj6HcfZPk0svG1qlEfih5yv1ge96oJLIsCqu83GWIXF
	fFHKmEUgNre/+8pORg56gg+YLbsw7/yz0pu3XRA4ZWqdbuqPvZl8lQN5tYR2Au1L2hT5
	igQqnGL7YIapccrpw4JKLDDC6E2iYOHKdL2mhqwUn6fNR6HmbSsje5e87puCLeQBvOF7
	qJ1AZEmghQioW31glddOQqlmAOHRJBc2Gufce5uL/GHbS7h6Ym95OptpDOHCVcqAvJgm
	WlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=h4NTbwpzCv6yGyNv0iD8bNRgN2z2J8QjAYzKFda07OQ=;
	b=piQxiXomPPiYZJV1xNuO6Dsegbd7f0qzofvsuIPMf0ywOC13YM0A934nrHvUkRPDJW
	Lr5jwNzuW5hbis6GWzyLs/bAuXHGIGOKZnxDlh2Lu9c6VMpWDBV96xI6XvYiYkLLXrXd
	s5yL3bAf8UYo5ePJaiJwFL67eJ7ORiVXibgGssgwC9apQBaioIOPxcPSACXGKNlRP1GS
	79ebvc6qHMjhtlZGyiErHjZLcRpX91Y2WNiQUKHoN88wOpRVrxb0tyOB0agn61h1Z7lG
	FoqIzE+PB9H4WojRH8PLccTGFTN9mmKe/z1KOxXDrmWWlo6seMEBTyBwkYCfzIWZl5SQ
	DbGQ==
X-Gm-Message-State: APjAAAWZ9L7YjlzQLMii8yRL3l/bqLtkeCSTOYttcNXVnKdAdThyVuFj
	LiB313AI+ZwvamjyB7Rwnkq2CwAXw7M86bwj
X-Google-Smtp-Source: APXvYqxbd4FvXCjbDMq5Fsg2btmgtwj7DZO42a/09ctUdEBj5tqSF7sGN2ToxCvtNcAbEs1PDoduJQ==
X-Received: by 2002:a50:93a6:: with SMTP id o35mr33093218eda.245.1555008557237;
	Thu, 11 Apr 2019 11:49:17 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
	by smtp.gmail.com with ESMTPSA id
	b10sm1285130edi.28.2019.04.11.11.49.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 11:49:16 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH 7/9] iommu/amd: Use the dma-iommu api
Date: Thu, 11 Apr 2019 19:47:36 +0100
Message-Id: <20190411184741.27540-8-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
X-Mailman-Approved-At: Fri, 12 Apr 2019 00:02:45 +0000
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>,
	David Brown <david.brown@linaro.org>,
	linux-samsung-soc@vger.kernel.org, dima@arista.com,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Tom Murphy <tmurphy@arista.com>, linux-kernel@vger.kernel.org,
	murphyt7@tcd.ie, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411184736.JLe9TfRfiFL6VUCRRvQiQet9oqVWN7KOO3OYFfCb5oQ@z>

Convert the AMD iommu driver to use the dma-iommu api.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/Kconfig     |   1 +
 drivers/iommu/amd_iommu.c | 217 +++++++++++++-------------------------
 2 files changed, 77 insertions(+), 141 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6f07f3b21816..cc728305524b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -136,6 +136,7 @@ config AMD_IOMMU
 	select PCI_PASID
 	select IOMMU_API
 	select IOMMU_IOVA
+        select IOMMU_DMA
 	depends on X86_64 && PCI && ACPI
 	---help---
 	  With this option you can enable support for AMD IOMMU hardware in
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b45e0e033adc..218faf3a6d9c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -32,6 +32,7 @@
 #include <linux/scatterlist.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-iommu.h>
 #include <linux/iommu-helper.h>
 #include <linux/iommu.h>
 #include <linux/delay.h>
@@ -1845,21 +1846,21 @@ static void iova_domain_flush_tlb(struct iova_domain *iovad)
  * Free a domain, only used if something went wrong in the
  * allocation path and we need to free an already allocated page table
  */
-static void dma_ops_domain_free(struct dma_ops_domain *dom)
+static void dma_ops_domain_free(struct protection_domain *domain)
 {
-	if (!dom)
+	if (!domain)
 		return;
 
-	del_domain_from_list(&dom->domain);
+	del_domain_from_list(domain);
 
-	put_iova_domain(&dom->iovad);
+	iommu_put_dma_cookie(&domain->domain);
 
-	free_pagetable(&dom->domain);
+	free_pagetable(domain);
 
-	if (dom->domain.id)
-		domain_id_free(dom->domain.id);
+	if (domain->id)
+		domain_id_free(domain->id);
 
-	kfree(dom);
+	kfree(domain);
 }
 
 /*
@@ -1867,37 +1868,46 @@ static void dma_ops_domain_free(struct dma_ops_domain *dom)
  * It also initializes the page table and the address allocator data
  * structures required for the dma_ops interface
  */
-static struct dma_ops_domain *dma_ops_domain_alloc(void)
+static struct protection_domain *dma_ops_domain_alloc(void)
 {
-	struct dma_ops_domain *dma_dom;
+	struct protection_domain *domain;
+	u64 size;
 
-	dma_dom = kzalloc(sizeof(struct dma_ops_domain), GFP_KERNEL);
-	if (!dma_dom)
+	domain = kzalloc(sizeof(struct protection_domain), GFP_KERNEL);
+	if (!domain)
 		return NULL;
 
-	if (protection_domain_init(&dma_dom->domain))
-		goto free_dma_dom;
+	if (protection_domain_init(domain))
+		goto free_domain;
 
-	dma_dom->domain.mode = PAGE_MODE_3_LEVEL;
-	dma_dom->domain.pt_root = (void *)get_zeroed_page(GFP_KERNEL);
-	dma_dom->domain.flags = PD_DMA_OPS_MASK;
-	if (!dma_dom->domain.pt_root)
-		goto free_dma_dom;
+	domain->mode = PAGE_MODE_3_LEVEL;
+	domain->pt_root = (void *)get_zeroed_page(GFP_KERNEL);
+	domain->flags = PD_DMA_OPS_MASK;
+	if (!domain->pt_root)
+		goto free_domain;
 
-	init_iova_domain(&dma_dom->iovad, PAGE_SIZE, IOVA_START_PFN);
+	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES;
+	domain->domain.type = IOMMU_DOMAIN_DMA;
+	domain->domain.ops = &amd_iommu_ops;
+	if (iommu_get_dma_cookie(&domain->domain) == -ENOMEM)
+		goto free_domain;
 
-	if (init_iova_flush_queue(&dma_dom->iovad, iova_domain_flush_tlb, NULL))
-		goto free_dma_dom;
+	size = 0;/* Size is only required if force_apperture is set */
+	if (iommu_dma_init_domain(&domain->domain, IOVA_START_PFN << PAGE_SHIFT,
+				size, NULL))
+		goto free_cookie;
 
 	/* Initialize reserved ranges */
-	copy_reserved_iova(&reserved_iova_ranges, &dma_dom->iovad);
+	iommu_dma_copy_reserved_iova(&reserved_iova_ranges, &domain->domain);
 
-	add_domain_to_list(&dma_dom->domain);
+	add_domain_to_list(domain);
 
-	return dma_dom;
+	return domain;
 
-free_dma_dom:
-	dma_ops_domain_free(dma_dom);
+free_cookie:
+	iommu_put_dma_cookie(&domain->domain);
+free_domain:
+	dma_ops_domain_free(domain);
 
 	return NULL;
 }
@@ -2328,6 +2338,26 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
 	return acpihid_device_group(dev);
 }
 
+static int amd_iommu_domain_get_attr(struct iommu_domain *domain,
+		enum iommu_attr attr, void *data)
+{
+	switch (domain->type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		return -ENODEV;
+	case IOMMU_DOMAIN_DMA:
+		switch (attr) {
+		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
+			*(int *)data = !amd_iommu_unmap_flush;
+			return 0;
+		default:
+			return -ENODEV;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+}
+
 /*****************************************************************************
  *
  * The next functions belong to the dma_ops mapping/unmapping code.
@@ -2509,21 +2539,15 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 			   enum dma_data_direction dir,
 			   unsigned long attrs)
 {
-	phys_addr_t paddr = page_to_phys(page) + offset;
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
-	u64 dma_mask;
+	int prot = dir2prot(dir);
+	struct protection_domain *domain = get_domain(dev);
 
-	domain = get_domain(dev);
 	if (PTR_ERR(domain) == -EINVAL)
-		return (dma_addr_t)paddr;
+		return (dma_addr_t)page_to_phys(page) + offset;
 	else if (IS_ERR(domain))
 		return DMA_MAPPING_ERROR;
 
-	dma_mask = *dev->dma_mask;
-	dma_dom = to_dma_ops_domain(domain);
-
-	return __map_single(dev, dma_dom, paddr, size, dir, dma_mask);
+	return iommu_dma_map_page(dev, page, offset, size, prot);
 }
 
 /*
@@ -2532,16 +2556,11 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 		       enum dma_data_direction dir, unsigned long attrs)
 {
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
-
-	domain = get_domain(dev);
+	struct protection_domain *domain = get_domain(dev);
 	if (IS_ERR(domain))
 		return;
 
-	dma_dom = to_dma_ops_domain(domain);
-
-	__unmap_single(dma_dom, dma_addr, size, dir);
+	iommu_dma_unmap_page(dev, dma_addr, size, dir, attrs);
 }
 
 static int sg_num_pages(struct device *dev,
@@ -2578,77 +2597,10 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		  int nelems, enum dma_data_direction direction,
 		  unsigned long attrs)
 {
-	int mapped_pages = 0, npages = 0, prot = 0, i;
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
-	struct scatterlist *s;
-	unsigned long address;
-	u64 dma_mask;
-	int ret;
-
-	domain = get_domain(dev);
+	struct protection_domain *domain = get_domain(dev);
 	if (IS_ERR(domain))
 		return 0;
-
-	dma_dom  = to_dma_ops_domain(domain);
-	dma_mask = *dev->dma_mask;
-
-	npages = sg_num_pages(dev, sglist, nelems);
-
-	address = dma_ops_alloc_iova(dev, dma_dom, npages, dma_mask);
-	if (address == DMA_MAPPING_ERROR)
-		goto out_err;
-
-	prot = dir2prot(direction);
-
-	/* Map all sg entries */
-	for_each_sg(sglist, s, nelems, i) {
-		int j, pages = iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
-
-		for (j = 0; j < pages; ++j) {
-			unsigned long bus_addr, phys_addr;
-
-			bus_addr  = address + s->dma_address + (j << PAGE_SHIFT);
-			phys_addr = (sg_phys(s) & PAGE_MASK) + (j << PAGE_SHIFT);
-			ret = iommu_map_page(domain, bus_addr, phys_addr, PAGE_SIZE, prot, GFP_ATOMIC);
-			if (ret)
-				goto out_unmap;
-
-			mapped_pages += 1;
-		}
-	}
-
-	/* Everything is mapped - write the right values into s->dma_address */
-	for_each_sg(sglist, s, nelems, i) {
-		s->dma_address += address + s->offset;
-		s->dma_length   = s->length;
-	}
-
-	return nelems;
-
-out_unmap:
-	dev_err(dev, "IOMMU mapping error in map_sg (io-pages: %d reason: %d)\n",
-		npages, ret);
-
-	for_each_sg(sglist, s, nelems, i) {
-		int j, pages = iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
-
-		for (j = 0; j < pages; ++j) {
-			unsigned long bus_addr;
-
-			bus_addr  = address + s->dma_address + (j << PAGE_SHIFT);
-			iommu_unmap_page(domain, bus_addr, PAGE_SIZE);
-
-			if (--mapped_pages == 0)
-				goto out_free_iova;
-		}
-	}
-
-out_free_iova:
-	free_iova_fast(&dma_dom->iovad, address >> PAGE_SHIFT, npages);
-
-out_err:
-	return 0;
+	return iommu_dma_map_sg(dev, sglist, nelems, dir2prot(direction));
 }
 
 /*
@@ -2659,20 +2611,11 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 		     int nelems, enum dma_data_direction dir,
 		     unsigned long attrs)
 {
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
-	unsigned long startaddr;
-	int npages = 2;
-
-	domain = get_domain(dev);
+	struct protection_domain *domain = get_domain(dev);
 	if (IS_ERR(domain))
 		return;
 
-	startaddr = sg_dma_address(sglist) & PAGE_MASK;
-	dma_dom   = to_dma_ops_domain(domain);
-	npages    = sg_num_pages(dev, sglist, nelems);
-
-	__unmap_single(dma_dom, startaddr, npages << PAGE_SHIFT, dir);
+	iommu_dma_unmap_sg(dev, sglist, nelems, dir, attrs);
 }
 
 /*
@@ -2684,7 +2627,6 @@ static void *alloc_coherent(struct device *dev, size_t size,
 {
 	u64 dma_mask = dev->coherent_dma_mask;
 	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
 	struct page *page;
 
 	domain = get_domain(dev);
@@ -2695,7 +2637,6 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	} else if (IS_ERR(domain))
 		return NULL;
 
-	dma_dom   = to_dma_ops_domain(domain);
 	size	  = PAGE_ALIGN(size);
 	dma_mask  = dev->coherent_dma_mask;
 	flag     &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
@@ -2715,9 +2656,8 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	if (!dma_mask)
 		dma_mask = *dev->dma_mask;
 
-	*dma_addr = __map_single(dev, dma_dom, page_to_phys(page),
-				 size, DMA_BIDIRECTIONAL, dma_mask);
-
+	*dma_addr = iommu_dma_map_page_coherent(dev, page, 0, size,
+			dir2prot(DMA_BIDIRECTIONAL));
 	if (*dma_addr == DMA_MAPPING_ERROR)
 		goto out_free;
 
@@ -2739,7 +2679,6 @@ static void free_coherent(struct device *dev, size_t size,
 			  unsigned long attrs)
 {
 	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
 	struct page *page;
 
 	page = virt_to_page(virt_addr);
@@ -2749,9 +2688,8 @@ static void free_coherent(struct device *dev, size_t size,
 	if (IS_ERR(domain))
 		goto free_mem;
 
-	dma_dom = to_dma_ops_domain(domain);
-
-	__unmap_single(dma_dom, dma_addr, size, DMA_BIDIRECTIONAL);
+	iommu_dma_unmap_page(dev, dma_addr, size, DMA_BIDIRECTIONAL,
+			     attrs);
 
 free_mem:
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
@@ -2948,7 +2886,6 @@ static struct protection_domain *protection_domain_alloc(void)
 static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
 	struct protection_domain *pdomain;
-	struct dma_ops_domain *dma_domain;
 
 	switch (type) {
 	case IOMMU_DOMAIN_UNMANAGED:
@@ -2969,12 +2906,11 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 
 		break;
 	case IOMMU_DOMAIN_DMA:
-		dma_domain = dma_ops_domain_alloc();
-		if (!dma_domain) {
+		pdomain = dma_ops_domain_alloc();
+		if (!pdomain) {
 			pr_err("Failed to allocate\n");
 			return NULL;
 		}
-		pdomain = &dma_domain->domain;
 		break;
 	case IOMMU_DOMAIN_IDENTITY:
 		pdomain = protection_domain_alloc();
@@ -2993,7 +2929,6 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 static void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
 
 	domain = to_pdomain(dom);
 
@@ -3008,8 +2943,7 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 	switch (dom->type) {
 	case IOMMU_DOMAIN_DMA:
 		/* Now release the domain */
-		dma_dom = to_dma_ops_domain(domain);
-		dma_ops_domain_free(dma_dom);
+		dma_ops_domain_free(domain);
 		break;
 	default:
 		if (domain->mode != PAGE_MODE_NONE)
@@ -3278,9 +3212,10 @@ const struct iommu_ops amd_iommu_ops = {
 	.add_device = amd_iommu_add_device,
 	.remove_device = amd_iommu_remove_device,
 	.device_group = amd_iommu_device_group,
+	.domain_get_attr = amd_iommu_domain_get_attr,
 	.get_resv_regions = amd_iommu_get_resv_regions,
 	.put_resv_regions = amd_iommu_put_resv_regions,
-	.apply_resv_region = amd_iommu_apply_resv_region,
+	.apply_resv_region = iommu_dma_apply_resv_region,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
