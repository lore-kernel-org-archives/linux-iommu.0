Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D23D7D77
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397227; cv=none; b=oVZHAmw5zHR6EuxF6yJaYITCyt9q7QqYI0JpY6vgm9hfNCDfSzDGkijA6Z+Zj7yKKE4ZPePLNH1A4gCQcdt88KQ1UjZ244Rgn1y6iCODkwqs0KDwcPIHHlo5oh9awj7dqGLyhbSZUy15GeXsnjXPtUNz7QADfduPx3cblnjB9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397227; c=relaxed/simple;
	bh=mVPgHFrbAPLtvZOZYByaiCD57a2HCTzd59a0NePyD8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+s0fP/Spcmn0VHTMdDB70+vYHYDDBaT9oOwGs0txvHdyBU00NE+7PQvRcIGMmTSJdvX0rWebW6UgClJh41eWbjZ1EV1CGoyj+8TDQocLYOCUy/ulGhG2Mei1yV+yIuikvqh1NtRiPBPF/OkkVljrRTvECgK2jgeytH8K4gNFC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XCUkcrQB; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XCUkcrQB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397223; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UP0YTUy7zkrIojybqq6QMy6i41tG54VrVzfjKAt98ek=;
	b=XCUkcrQBt+b1LKpc4JzVt9Jy2ALSHyw7F370U5NRi8+Fre4NTVkjMMoQWvE6WpHzbjCMytCP1E+Z4DB3wuqsrtSB2SCbaHqOxFi8uAJSrZ+gmOqQ7qTsU3G6Cmd3Wrn772EuNXRyweMawWFGdKP26IZCgHm24OZUa+id0rERlCE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E952_1780397220;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E952_1780397220 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:47:00 +0800
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
Subject: [PATCH v2 13/30] iommu/fsl_pamu: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:20 +0800
Message-ID: <20260602104637.1219810-14-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for FSL PAMU IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/fsl_pamu_domain.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 9664ef9840d2..643984ac6ae1 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -169,12 +169,32 @@ static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct d
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
-static phys_addr_t fsl_pamu_iova_to_phys(struct iommu_domain *domain,
-					 dma_addr_t iova)
+static phys_addr_t fsl_pamu_iova_to_phys_length(struct iommu_domain *domain,
+						dma_addr_t iova,
+						size_t *mapped_length)
 {
+	if (mapped_length)
+		*mapped_length = 0;
+
 	if (iova < domain->geometry.aperture_start ||
 	    iova > domain->geometry.aperture_end)
-		return 0;
+		return PHYS_ADDR_MAX;
+
+	/*
+	 * PAMU configures exactly one Primary PAACE entry per LIODN with the
+	 * Multi-Window (MW) bit cleared and ATM = PAACE_ATM_WINDOW_XLATE,
+	 * WBAL/TWBAL = 0. That is, every LIODN is backed by a single hardware
+	 * mapping window of fixed size (1ULL << 36, i.e. 64GB, see
+	 * pamu_config_ppaace()) performing an identity translation. The driver
+	 * does not split this window into SPAACE sub-windows, so the entire
+	 * aperture is one PAACE "PTE" entry. Return that single entry's size
+	 * as mapped_length, matching the iova_to_phys_length contract that
+	 * mapped_length reports the full size of the mapping entry which
+	 * covers iova (not the remaining bytes from iova to its end).
+	 */
+	if (mapped_length)
+		*mapped_length = 1ULL << 36;
+
 	return iova;
 }
 
@@ -435,7 +455,7 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.device_group   = fsl_pamu_device_group,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= fsl_pamu_attach_device,
-		.iova_to_phys	= fsl_pamu_iova_to_phys,
+		.iova_to_phys_length	= fsl_pamu_iova_to_phys_length,
 		.free		= fsl_pamu_domain_free,
 	}
 };
-- 
2.43.7

