Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC3FC433FF
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 11:11:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E3B22067D
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 11:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="v0n9o//B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3B22067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1BD4810A5;
	Thu, 15 Aug 2019 11:10:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 58E2CD48
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 11:10:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
	[209.85.215.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 09811711
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 11:10:49 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id n9so1183534pgc.1
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tcd-ie.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Rq9oE/+ABrAqTFJN5so5jGPiSZbG95oHkV+cKhmZyPI=;
	b=v0n9o//BaoQ1ESwTpE6LtJwM0UMlZU6SHT31oFerAYe/9QP4IZ43sL++jjJ0lO7I0r
	33cFC5OPDHrUbaK1kRyeDxXqJw2kxWv1QBDKSRUAQYrFStgCOFm5F+WNNMG+odjGyiZr
	/nlAC34vY56gV4YH0EknAGiSIPRMu5D4jUi++DxYjMgJWJcvn7Trmg3g8cjHIW/PoZht
	I/MzH4/h0Y00wXwjjED/qhh151NQx8hzpG2BjjF6k/JBGMhtwrhWIiYFTHUGgQ31Zgu3
	3jTVnlzHTiNwLqrywAN5HiEUhVZ8Pcr9uu/E3P1MS3NDkKTzXbAxW83+7o1w3VSOxUBu
	pqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Rq9oE/+ABrAqTFJN5so5jGPiSZbG95oHkV+cKhmZyPI=;
	b=jt/qY2BfXWYn9enQoPrAhN600fn360V5p6rxcwln6/e0qiuh9BlcN0tqujm69h7Zl0
	Vheh2368ai1D52PCyheLAU5NjihHyDy1mcwUmWTRnvlMcic3r/IirSyjGXp9DDY+FayK
	ZbLhrtK9oyBmQ6afehMgpH5yF5pm/P0bsbO/brF4MtdXwacp4dAgnLCegR1ISJ5QLr4W
	HrQWduy7cyCEZEuxLGocKWsnU+w60ihOv6FKGcue0o8C7499pLHpG7P1d4NMEVNVTln+
	Y9cXFCd5iZ3Hh/efxqnQ6oa/r5Y5VbnRBi5V7g2vXgsPMVcPBzxaBp6oxs18P0zx2kXf
	WqLg==
X-Gm-Message-State: APjAAAWf9qK7Te5dw3Df28V8zLOsXN79yYUO788J4KajQiETCzSVxWlQ
	GCRqesMtr5eVwnMOCmhNHfDPccH9hLBxrg==
X-Google-Smtp-Source: APXvYqy/ZF1W56BYZyMWgqSYtJ5QoXnk2Q5jOdJW84PVtYVDa3GxlwLtVVqiFXWVLJYqEOcXHYdi2Q==
X-Received: by 2002:a65:6546:: with SMTP id a6mr3208852pgw.220.1565867448258; 
	Thu, 15 Aug 2019 04:10:48 -0700 (PDT)
Received: from localhost.localdomain
	([2404:e801:200e:19c4:6c3f:b548:3a9c:7867])
	by smtp.googlemail.com with ESMTPSA id
	z13sm1042678pjn.32.2019.08.15.04.10.41
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 15 Aug 2019 04:10:47 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH V5 4/5] iommu/dma-iommu: Use the dev->coherent_dma_mask
Date: Thu, 15 Aug 2019 12:09:42 +0100
Message-Id: <20190815110944.3579-5-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815110944.3579-1-murphyt7@tcd.ie>
References: <20190815110944.3579-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Cc: Heiko Stuebner <heiko@sntech.de>, virtualization@lists.linux-foundation.org,
	linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
	Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Andy Gross <agross@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
	Kukjin Kim <kgene@kernel.org>, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Use the dev->coherent_dma_mask when allocating in the dma-iommu ops api.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 906b7fa14d3c..b9a3ab02434b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -471,7 +471,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-		size_t size, int prot)
+		size_t size, int prot, dma_addr_t dma_mask)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -484,7 +484,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 
 	size = iova_align(iovad, size + iova_off);
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
 	if (!iova)
 		return DMA_MAPPING_ERROR;
 
@@ -735,7 +735,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dma_handle;
 
-	dma_handle = __iommu_dma_map(dev, phys, size, prot);
+	dma_handle = __iommu_dma_map(dev, phys, size, prot, dma_get_mask(dev));
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
 		arch_sync_dma_for_device(dev, phys, size, dir);
@@ -938,7 +938,8 @@ static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	return __iommu_dma_map(dev, phys, size,
-			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO);
+			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
+			dma_get_mask(dev));
 }
 
 static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
@@ -1041,7 +1042,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	if (!cpu_addr)
 		return NULL;
 
-	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot);
+	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
+			dev->coherent_dma_mask);
 	if (*handle == DMA_MAPPING_ERROR) {
 		__iommu_dma_free(dev, size, cpu_addr);
 		return NULL;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
