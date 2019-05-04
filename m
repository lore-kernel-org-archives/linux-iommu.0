Return-Path: <SRS0=qFSc=TE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45FBC43219
	for <iommu@archiver.kernel.org>; Sat,  4 May 2019 13:25:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D5E206BB
	for <iommu@archiver.kernel.org>; Sat,  4 May 2019 13:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fUiRrk1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D5E206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 32DAA422B;
	Sat,  4 May 2019 13:25:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1C6CF417A
	for <iommu@lists.linux-foundation.org>;
	Sat,  4 May 2019 13:24:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5F40A87
	for <iommu@lists.linux-foundation.org>;
	Sat,  4 May 2019 13:24:23 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id n17so9470209edb.0
	for <iommu@lists.linux-foundation.org>;
	Sat, 04 May 2019 06:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=MGv2a159/utSNPRrKthALX+gwTy5XSWgBBtVZtxsUEs=;
	b=fUiRrk1KYySTZz5QtSC78v3sitRc/Xx4j8p1zc8HH22cDSu0OyFgp0BEaA6TRxJWhW
	laPz07843slSKo/TznYWA5pBlVNJtjZHd5nxJBKiX7BWyvNtTa7VfIKHzWAI1eVjjAfR
	ScqC8iqD5aTMb2F7mCM6HFA4NXzW3JgbKjHJ3g8bcxzTfQNYD0QrmLqD3AHKKWCFL3Iv
	iE2/oxpyYMuBQBZtoGE8WdvMrKEJFxZ7t20XF+UqQ5mRVoVcYUQ1pgw5IQEfRyrW3tlk
	snTxLt00MSL4L01LJEfrywVq2EoOGR9tWjliB0NjrCbZ1tczVjPxyyl6jZT9DVAeVYpv
	v79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=MGv2a159/utSNPRrKthALX+gwTy5XSWgBBtVZtxsUEs=;
	b=azhWsrTc6ABcMdt9lo+muZ9Nf/yMHZavWzXEr/ilCZYEt5wnbWufPZmw/2OIoD2rmc
	mMguXbWS96mjEUBs5fh/M9AL12aem9tf849WswlEBdPF4R4JBzea0DFPtbxcZXZhKYwa
	i6X7fNyD4IC3Tt8gC+Mab+iIkCJbNI0DxbTAlB5FSlBDFlbruEuPMI6+DVwPli9w7a8H
	Ss55e83YlhrCLhFuEcWFBYndh62DzAFAzEO1arU2R6k6Nf5sVlBHeRS9F6s4OSLJ3o6R
	peZuaUaQyBsGht3m7xc1+K7dkj/aU/0rnGGmUqwlIVt0qnKyepiBWIlpGAy6O6kBVbUK
	/bdw==
X-Gm-Message-State: APjAAAXlnQ1zSUU+sGBA+bYgMbAtS1apiMj6Uu6snv1ZVtm7J1Pw23iI
	5hEmOo4HHMb+7IqdXapLHFiBbCMxMhd8XQ==
X-Google-Smtp-Source: APXvYqywxlAbHXAeC69FkqfxEDfFcgcXMIm9JfImG/Xg1J0FSEmx+0RS7eL7cjdmPk25eN3Z2+sYWA==
X-Received: by 2002:a50:b4bb:: with SMTP id w56mr14985726edd.40.1556976261711; 
	Sat, 04 May 2019 06:24:21 -0700 (PDT)
Received: from localhost.localdomain ([79.97.203.116])
	by smtp.gmail.com with ESMTPSA id
	s53sm1391106edb.20.2019.05.04.06.24.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 04 May 2019 06:24:21 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [RFC 1/7] iommu/vt-d: Set the dma_ops per device so we can remove the
	iommu_no_mapping code
Date: Sat,  4 May 2019 14:23:17 +0100
Message-Id: <20190504132327.27041-2-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504132327.27041-1-tmurphy@arista.com>
References: <20190504132327.27041-1-tmurphy@arista.com>
Cc: Heiko Stuebner <heiko@sntech.de>, kvm@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>, David Brown <david.brown@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Andy Gross <andy.gross@linaro.org>, linux-tegra@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Tom Murphy <tmurphy@arista.com>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, murphyt7@tcd.ie,
	David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Set the dma_ops per device so we can remove the iommu_no_mapping code.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/intel-iommu.c | 85 +++----------------------------------
 1 file changed, 6 insertions(+), 79 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index eace915602f0..2db1dc47e7e4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2622,17 +2622,6 @@ static int __init si_domain_init(int hw)
 	return 0;
 }
 
-static int identity_mapping(struct device *dev)
-{
-	struct device_domain_info *info;
-
-	info = dev->archdata.iommu;
-	if (info && info != DUMMY_DEVICE_DOMAIN_INFO)
-		return (info->domain == si_domain);
-
-	return 0;
-}
-
 static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
 	struct dmar_domain *ndomain;
@@ -3270,43 +3259,6 @@ static unsigned long intel_alloc_iova(struct device *dev,
 	return iova_pfn;
 }
 
-/* Check if the dev needs to go through non-identity map and unmap process.*/
-static int iommu_no_mapping(struct device *dev)
-{
-	int found;
-
-	if (iommu_dummy(dev))
-		return 1;
-
-	found = identity_mapping(dev);
-	if (found) {
-		/*
-		 * If the device's dma_mask is less than the system's memory
-		 * size then this is not a candidate for identity mapping.
-		 */
-		u64 dma_mask = *dev->dma_mask;
-
-		if (dev->coherent_dma_mask &&
-		    dev->coherent_dma_mask < dma_mask)
-			dma_mask = dev->coherent_dma_mask;
-
-		if (dma_mask < dma_get_required_mask(dev)) {
-			/*
-			 * 32 bit DMA is removed from si_domain and fall back
-			 * to non-identity mapping.
-			 */
-			dmar_remove_one_dev_info(dev);
-			dev_warn(dev, "32bit DMA uses non-identity mapping\n");
-
-			return 0;
-		}
-
-		return 1;
-	}
-
-	return 0;
-}
-
 static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 				     size_t size, int dir, u64 dma_mask)
 {
@@ -3320,9 +3272,6 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 
 	BUG_ON(dir == DMA_NONE);
 
-	if (iommu_no_mapping(dev))
-		return paddr;
-
 	domain = find_domain(dev);
 	if (!domain)
 		return DMA_MAPPING_ERROR;
@@ -3391,9 +3340,6 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 	struct intel_iommu *iommu;
 	struct page *freelist;
 
-	if (iommu_no_mapping(dev))
-		return;
-
 	domain = find_domain(dev);
 	BUG_ON(!domain);
 
@@ -3442,9 +3388,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
-	if (!iommu_no_mapping(dev))
-		flags &= ~(GFP_DMA | GFP_DMA32);
-	else if (dev->coherent_dma_mask < dma_get_required_mask(dev)) {
+	if (dev->coherent_dma_mask < dma_get_required_mask(dev)) {
 		if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
 			flags |= GFP_DMA;
 		else
@@ -3456,11 +3400,6 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 
 		page = dma_alloc_from_contiguous(dev, count, order,
 						 flags & __GFP_NOWARN);
-		if (page && iommu_no_mapping(dev) &&
-		    page_to_phys(page) + size > dev->coherent_dma_mask) {
-			dma_release_from_contiguous(dev, page, count);
-			page = NULL;
-		}
 	}
 
 	if (!page)
@@ -3510,20 +3449,6 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	intel_unmap(dev, startaddr, nrpages << VTD_PAGE_SHIFT);
 }
 
-static int intel_nontranslate_map_sg(struct device *hddev,
-	struct scatterlist *sglist, int nelems, int dir)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sglist, sg, nelems, i) {
-		BUG_ON(!sg_page(sg));
-		sg->dma_address = sg_phys(sg);
-		sg->dma_length = sg->length;
-	}
-	return nelems;
-}
-
 static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nelems,
 			enum dma_data_direction dir, unsigned long attrs)
 {
@@ -3538,8 +3463,6 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	struct intel_iommu *iommu;
 
 	BUG_ON(dir == DMA_NONE);
-	if (iommu_no_mapping(dev))
-		return intel_nontranslate_map_sg(dev, sglist, nelems, dir);
 
 	domain = find_domain(dev);
 	if (!domain)
@@ -4570,7 +4493,6 @@ int __init intel_iommu_init(void)
 #if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
 	swiotlb = 0;
 #endif
-	dma_ops = &intel_dma_ops;
 
 	init_iommu_pm_ops();
 
@@ -4949,6 +4871,7 @@ static int intel_iommu_add_device(struct device *dev)
 {
 	struct intel_iommu *iommu;
 	struct iommu_group *group;
+	struct iommu_domain *domain;
 	u8 bus, devfn;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
@@ -4965,6 +4888,10 @@ static int intel_iommu_add_device(struct device *dev)
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
+	domain = iommu_get_domain_for_dev(dev);
+	if (domain->type == IOMMU_DOMAIN_DMA)
+		dev->dma_ops = &intel_dma_ops;
+
 	iommu_group_put(group);
 	return 0;
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
