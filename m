Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D993E168B
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397230; cv=none; b=D0JWkA7AcQKg5bLM8jmXsI5LIIi8TzumPDoBlQRcj7k0B5KXlc4byDkuKBNPJj6Por65f6DKViO/baymR1IbWWFxluCMGgNQd3wqReKIkL2qaMVQ27TtbyaFHaFLdO3OQ/bHddGFqydw2aCVT8Qqeo7KAPjXmXj+SuQGdjxYe84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397230; c=relaxed/simple;
	bh=YRcq00ULr5ES22thBQR+6hcLGVLrBAdIiTZWihduxIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNSDNZxzX++lbXptiFiNrxSpJ9dIZrYiOhQRUTQT7DszuZ804RlboU2WEM3JH/oX3H5ijUWOrYKHmAyQQhXdWYYr5js5EQZTtVKaE4Fd9vIVNh7CeUgynK4n+o4BQiZltJ78mL6h2CnkIrPYR0e9+XsA/UB2DTVc6HUnVsg3Zg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ACkJ+7Ca; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ACkJ+7Ca"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397226; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eLIpHRxib2Q2tp8Ie9HCIz+i7UpgyrfwRapvc5RY2uw=;
	b=ACkJ+7CaA747Q5VftpS4Ft2sdDNuZ3ieX0r1pCgLWxK9xpSEzhTlTTOIEYkLK5gfx2qOVS78dGSbSHIs9A/cY3vbiAVerapXuh5LFIfU6KVVdvVO82OAWmsM/Yz/CMf2VWVGK7GHnSzHDovCPC3XZ5vtT9OXzyukeeXT/LO3Niw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E96H_1780397223;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E96H_1780397223 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:47:03 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: adrian.larumbe@collabora.com,
	airlied@gmail.com,
	alex@shazbot.org,
	baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
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
Cc: alikernel-developer@linux.alibaba.com
Subject: [PATCH v2 16/30] iommu/omap: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:23 +0800
Message-ID: <20260602104637.1219810-17-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement iova_to_phys_length for OMAP IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/omap-iommu.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 8231d7d6bb6a..883f9f61d4d9 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1592,15 +1592,19 @@ static void omap_iommu_domain_free(struct iommu_domain *domain)
 	kfree(omap_domain);
 }
 
-static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t da)
+static phys_addr_t omap_iommu_iova_to_phys_length(struct iommu_domain *domain,
+						  dma_addr_t da,
+						  size_t *mapped_length)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
 	struct omap_iommu_device *iommu = omap_domain->iommus;
 	struct omap_iommu *oiommu = iommu->iommu_dev;
 	struct device *dev = oiommu->dev;
 	u32 *pgd, *pte;
-	phys_addr_t ret = 0;
+	phys_addr_t ret = PHYS_ADDR_MAX;
+
+	if (mapped_length)
+		*mapped_length = 0;
 
 	/*
 	 * all the iommus within the domain will have identical programming,
@@ -1609,21 +1613,31 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 	iopgtable_lookup_entry(oiommu, da, &pgd, &pte);
 
 	if (pte) {
-		if (iopte_is_small(*pte))
+		if (iopte_is_small(*pte)) {
 			ret = omap_iommu_translate(*pte, da, IOPTE_MASK);
-		else if (iopte_is_large(*pte))
+			if (mapped_length)
+				*mapped_length = IOPTE_SIZE;
+		} else if (iopte_is_large(*pte)) {
 			ret = omap_iommu_translate(*pte, da, IOLARGE_MASK);
-		else
+			if (mapped_length)
+				*mapped_length = IOLARGE_SIZE;
+		} else {
 			dev_err(dev, "bogus pte 0x%x, da 0x%llx", *pte,
 				(unsigned long long)da);
+		}
 	} else {
-		if (iopgd_is_section(*pgd))
+		if (iopgd_is_section(*pgd)) {
 			ret = omap_iommu_translate(*pgd, da, IOSECTION_MASK);
-		else if (iopgd_is_super(*pgd))
+			if (mapped_length)
+				*mapped_length = IOSECTION_SIZE;
+		} else if (iopgd_is_super(*pgd)) {
 			ret = omap_iommu_translate(*pgd, da, IOSUPER_MASK);
-		else
+			if (mapped_length)
+				*mapped_length = IOSUPER_SIZE;
+		} else {
 			dev_err(dev, "bogus pgd 0x%x, da 0x%llx", *pgd,
 				(unsigned long long)da);
+		}
 	}
 
 	return ret;
@@ -1723,7 +1737,7 @@ static const struct iommu_ops omap_iommu_ops = {
 		.attach_dev	= omap_iommu_attach_dev,
 		.map_pages	= omap_iommu_map,
 		.unmap_pages	= omap_iommu_unmap,
-		.iova_to_phys	= omap_iommu_iova_to_phys,
+		.iova_to_phys_length	= omap_iommu_iova_to_phys_length,
 		.free		= omap_iommu_domain_free,
 	}
 };
-- 
2.43.7

