Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAFB3E7BCB
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397233; cv=none; b=U1CtN/et50ptEmbdOXazttOD8GEQr1JhOiVHs4dPcgntsP7wqUbszjLsjTiDyikMwdSoQwoae8KMmD3b8ygQDJl1k/jHT3AGZEiSLRH+s5xdQ2Kg5eYnWc69cMT7kF30Hu7MJDRtOOG4BiBwkSrKIFu0ZRVT4Wl/sqj8piaKwFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397233; c=relaxed/simple;
	bh=yJs/DX+0Hhq1AFyIiVkqDS1b/OYZN709ZYW2HoQNaCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHnbmboqDSK00kSMifYEkeXAbfzjXULrKLq/uirjnr872KzfGArzowudc6TotQ/UbSTBw0V7Zn54WoO0OpzAnqPdAQJyciizOqW2kxBI8BRo1wnjTRkEm2SVZEmIpywQjuIwQRZfTVwnLYkaBTuUAlMFLGbgF29rDp/DrhNPEVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UD9KCkkM; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UD9KCkkM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397230; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RCvFh85B/tqBQu5u458IIKCnRVt7lt/6UxJszvT0Ehg=;
	b=UD9KCkkMrik8CA2UwL7PC/jb6zL070i8vlIvgatrFU2k+I2d4XPpBPuDx6Q55Yn87aT4bVDN6JcrA0uT5FW1tQ71OmcazOOmKZInMBmTjJi/6Obb+iaNp6LPz8O9fn/sh2s+HBTqABe06J2ZJYwy13CEV5D5aZT5p0/ndRPXl2w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E972_1780397225;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E972_1780397225 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:47:05 +0800
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
Subject: [PATCH v2 18/30] iommu/s390: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:25 +0800
Message-ID: <20260602104637.1219810-19-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for s390 IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/s390-iommu.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index f148f559ac56..b12ed389e1bd 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -986,22 +986,26 @@ static unsigned long *get_rto_from_iova(struct s390_domain *domain,
 	}
 }
 
-static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t iova)
+static phys_addr_t s390_iommu_iova_to_phys_length(struct iommu_domain *domain,
+						  dma_addr_t iova,
+						  size_t *mapped_length)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	unsigned long *rto, *sto, *pto;
 	unsigned long ste, pte, rte;
 	unsigned int rtx, sx, px;
-	phys_addr_t phys = 0;
+	phys_addr_t phys = PHYS_ADDR_MAX;
+
+	if (mapped_length)
+		*mapped_length = 0;
 
 	if (iova < domain->geometry.aperture_start ||
 	    iova > domain->geometry.aperture_end)
-		return 0;
+		return PHYS_ADDR_MAX;
 
 	rto = get_rto_from_iova(s390_domain, iova);
 	if (!rto)
-		return 0;
+		return PHYS_ADDR_MAX;
 
 	rtx = calc_rtx(iova);
 	sx = calc_sx(iova);
@@ -1014,8 +1018,11 @@ static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
 		if (reg_entry_isvalid(ste)) {
 			pto = get_st_pto(ste);
 			pte = READ_ONCE(pto[px]);
-			if (pt_entry_isvalid(pte))
+			if (pt_entry_isvalid(pte)) {
 				phys = pte & ZPCI_PTE_ADDR_MASK;
+				if (mapped_length)
+					*mapped_length = SZ_4K;
+			}
 		}
 	}
 
@@ -1183,7 +1190,7 @@ static struct iommu_domain blocking_domain = {
 		.flush_iotlb_all = s390_iommu_flush_iotlb_all, \
 		.iotlb_sync      = s390_iommu_iotlb_sync, \
 		.iotlb_sync_map  = s390_iommu_iotlb_sync_map, \
-		.iova_to_phys	= s390_iommu_iova_to_phys, \
+		.iova_to_phys_length	= s390_iommu_iova_to_phys_length, \
 		.free		= s390_domain_free, \
 	}
 
-- 
2.43.7

