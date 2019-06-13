Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E46BC31E4A
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 22:39:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328532177E
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 22:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="zeOE/zvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328532177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4B71DEB9;
	Thu, 13 Jun 2019 22:39:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 25CBCCDD
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 22:39:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 802CA7C3
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 22:39:39 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id m10so504489edv.6
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 15:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tcd-ie.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=EJ0KbItdu2TxPOp6NmcZ85nVQ2e5NOhr/kYDGDu9/qE=;
	b=zeOE/zvh1TwDJgGnFD06YP/Cpej9V018Ne4naI7KcEHh0yS7cV5SkBhhiRimOFJed9
	CIVbHgAGkVuXPgPLOfb6gwAD+YbCgwAkfIEHSsQJIerHVPctg8GdW4rUuc66fIvyLXQc
	hKvR/5Hm+vo+vhl8Pwk60SN0iYyTrhzrChpV9xYcaMnUUwDpQTN98YCIy3dY/xF8bsik
	ehA0vcSZDfYqkT23eQLQ0io5L+IvUuMxuREvkRBLXsfXM+IKHUEavzf30UjqPvgz/NoB
	7cY4bUUy/3lGoZ6nsQzt1Pi0Z2M9VRpqxVv70+Ha5JbxYPs9Gi0xIP6FU1JOAMdl2dbS
	K4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=EJ0KbItdu2TxPOp6NmcZ85nVQ2e5NOhr/kYDGDu9/qE=;
	b=AK5+7VMJx0Shp7p3d0cMD8lHGlv/Hg1iDDwj8zLM0ur7Kf6+cfKqGkPhluDUssfoVI
	0rrnOE7CoerU5IWUd/TRhunZdeAXW839L4ELJMQsRX+k13ePixNN3Gi+sUVYdkemgagH
	hOFfgUTOYwDfXDd5x+5h10tq/RNYJXLWFyUI/VYr08+bfSLblivxL1xKiHj81IR9RHhg
	65GsCea5zCT7XfYWXIiADIFIqTK2/Kw1RkZdiXF1miFCD9jbNEF2tfo3+plf924gHHz+
	LK8bW7EyoHAUAk017N5H7TNTND+oZQV0Zus/0pP/3ezE+FU8roMLnLt8tvFjKyhrcQ/D
	qhwg==
X-Gm-Message-State: APjAAAVGgLfM0UBq9tiMfQdrhx6P+SVyag9jTtG+4+MyxxPKxmeqHnl5
	VltWyIbvjusCkrS23ufIBX8gf0vMNT5vKQ==
X-Google-Smtp-Source: APXvYqx/uHASwls8eMlS/EUABG1iNxk9FfSuMbCAMjshsIltMQDse6oJS07oPnN6ZE7iiU0u7+JAvg==
X-Received: by 2002:a05:6402:8d7:: with SMTP id
	d23mr55678205edz.17.1560465577935; 
	Thu, 13 Jun 2019 15:39:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:a0:bc00:8042:d435:a754:1f22])
	by smtp.googlemail.com with ESMTPSA id
	s16sm216522eji.27.2019.06.13.15.39.36
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 13 Jun 2019 15:39:37 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v4 4/5] iommu/dma-iommu: Use the dev->coherent_dma_mask
Date: Thu, 13 Jun 2019 23:38:59 +0100
Message-Id: <20190613223901.9523-5-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613223901.9523-1-murphyt7@tcd.ie>
References: <20190613223901.9523-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>,
	virtualization@lists.linux-foundation.org,
	David Brown <david.brown@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Andy Gross <agross@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
	Kukjin Kim <kgene@kernel.org>, David Woodhouse <dwmw2@infradead.org>
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
 drivers/iommu/dma-iommu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f303bbe20e51..082fb789e3cf 100644
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
@@ -486,7 +486,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size = iova_align(&cookie->iovad, size + iova_off);
 	}
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
 	if (!iova)
 		return DMA_MAPPING_ERROR;
 
@@ -737,7 +737,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dma_handle;
 
-	dma_handle = __iommu_dma_map(dev, phys, size, prot);
+	dma_handle = __iommu_dma_map(dev, phys, size, prot, dma_get_mask(dev));
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
 		arch_sync_dma_for_device(dev, phys, size, dir);
@@ -940,7 +940,8 @@ static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	return __iommu_dma_map(dev, phys, size,
-			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO);
+			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
+			dma_get_mask(dev));
 }
 
 static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
@@ -1049,7 +1050,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	if (!cpu_addr)
 		return NULL;
 
-	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot);
+	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
+			dev->coherent_dma_mask);
 	if (*handle == DMA_MAPPING_ERROR) {
 		__iommu_dma_free(dev, size, cpu_addr);
 		return NULL;
@@ -1178,7 +1180,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = __iommu_dma_map(dev, msi_addr, size, prot);
+	iova = __iommu_dma_map(dev, msi_addr, size, prot, dma_get_mask(dev));
 	if (iova == DMA_MAPPING_ERROR)
 		goto out_free_page;
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
