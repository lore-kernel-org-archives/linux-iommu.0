Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B698A3E1D17
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397232; cv=none; b=jCYt+NEgYHbjwam7P5Ypqz4ScM7TVQeiur5cVy42DAHt1Wp3kY4wVwttEe1I1PGhH+7TaVkWn9GuPTl3IdEEPKWCrZea8238Xiw3f8oC1TFP9kdEoTGDMPXgyJLKi6/0UkccGKLufnUq3VK/x8kwvf6JAtOS2SIov4Y47PAS6BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397232; c=relaxed/simple;
	bh=SGhANO867IhGFSRPmXVIvgqBaE/0mJIP5/TRFgIRNTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0S6Yc/9o+uHWU9VRM93z+tBVHjjloH0118lC5C1e1mxzVdHyDwIU31M+RSVErQ9arQvDG1GqSw+ctESCPtq1WPnVsLAzC7CNeeQgjRWp4CGISVR9cC3R6ivckD9vhMsWVajU7y/76bwVOyS40ARpTTVCc4hEJKoVyc9AYKabXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QGXV6W/L; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QGXV6W/L"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397227; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FS/8CTbNUNtKKm1fU7W5+5c/18z86DAMGyOuBL/xGCw=;
	b=QGXV6W/LT53RRfwZhoVWAnNWsVShP9xl0rBCP7q4n4wViEPGzlwK1j+1iywwONpjyo/+ianq5LaicXBdpNo3ir+eKhv1RBVNE0dmpmg2euOcVyXepNqHhL9BDKNKQ3hkWa7lj/Kg8bXaQ+FbB7QjJgiBkIkWuNINr8HLQbMWfdk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E94t_1780397219;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E94t_1780397219 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:46:59 +0800
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
Subject: [PATCH v2 12/30] iommu/exynos: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:19 +0800
Message-ID: <20260602104637.1219810-13-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for Exynos IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/exynos-iommu.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 874d05f4b396..a9da28606cff 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1372,13 +1372,17 @@ static size_t exynos_iommu_unmap(struct iommu_domain *iommu_domain,
 	return 0;
 }
 
-static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
-					  dma_addr_t iova)
+static phys_addr_t exynos_iommu_iova_to_phys_length(struct iommu_domain *iommu_domain,
+						 dma_addr_t iova,
+						 size_t *mapped_length)
 {
 	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
 	sysmmu_pte_t *entry;
 	unsigned long flags;
-	phys_addr_t phys = 0;
+	phys_addr_t phys = PHYS_ADDR_MAX;
+
+	if (mapped_length)
+		*mapped_length = 0;
 
 	spin_lock_irqsave(&domain->pgtablelock, flags);
 
@@ -1386,13 +1390,20 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 
 	if (lv1ent_section(entry)) {
 		phys = section_phys(entry) + section_offs(iova);
+		if (mapped_length)
+			*mapped_length = SECT_SIZE;
 	} else if (lv1ent_page(entry)) {
 		entry = page_entry(entry, iova);
 
-		if (lv2ent_large(entry))
+		if (lv2ent_large(entry)) {
 			phys = lpage_phys(entry) + lpage_offs(iova);
-		else if (lv2ent_small(entry))
+			if (mapped_length)
+				*mapped_length = LPAGE_SIZE;
+		} else if (lv2ent_small(entry)) {
 			phys = spage_phys(entry) + spage_offs(iova);
+			if (mapped_length)
+				*mapped_length = SPAGE_SIZE;
+		}
 	}
 
 	spin_unlock_irqrestore(&domain->pgtablelock, flags);
@@ -1484,7 +1495,7 @@ static const struct iommu_ops exynos_iommu_ops = {
 		.attach_dev	= exynos_iommu_attach_device,
 		.map_pages	= exynos_iommu_map,
 		.unmap_pages	= exynos_iommu_unmap,
-		.iova_to_phys	= exynos_iommu_iova_to_phys,
+		.iova_to_phys_length	= exynos_iommu_iova_to_phys_length,
 		.free		= exynos_iommu_domain_free,
 	}
 };
-- 
2.43.7

