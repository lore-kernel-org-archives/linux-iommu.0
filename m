Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5499A3DD87A
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397224; cv=none; b=d5W6rbhX4sFOEtGo6xYgPuRbSDM6ASnXyw4UrEEdg/gm/OU627N03pr2zJb3MmsB5oXU2IvpFuXh6UfwayKjTDFd4Pej5vVMjvo5HsnttLPhxL2hmb/C0epDCoBF3VPH3eOYE4i6sVU3SL3VhQ6rGL1Or2F56phHMXcj4vA9hLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397224; c=relaxed/simple;
	bh=HknEBxplz6TPj1cTXgsn+O0b2afp/paN5O4c29PiuEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1hjGhlhMwpFo4YLzA4P3c6960UL2QFvkrobJr8ZzUNCZeWAYM2XGq40/kzsuhsquce6veGiepiQ+VWcpPEky/6vDxa2OBvtopCScvPegKEorO9/5Rs7BbiN6K/06qYSkUMNqeCOx8t3iFUpYDauL2PL/Hdsln/G1Xk9Ns6C4kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PFH+JANs; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PFH+JANs"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397219; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Qq9/61+2kM5dFltdNcmj4CJHO8jMn9Ru5g9fMIrB3uo=;
	b=PFH+JANs8/qWAqHsu8snuu8r+vZaiCNiC9fycb1LP2X+/6OzeUsFl2tFaltdIgGJGNL53+II9uILSHYw5HQYqUt10PSog8rTUBHCAS/N2QLPY1Px63H61HIfLfpkF9mMYomng8GMtDpKdI1mI+9IQ1WVrZ52zzDuxE1AAwrjpHM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E94P_1780397217;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E94P_1780397217 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:46:57 +0800
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
Subject: [PATCH v2 10/30] iommu/ipmmu-vmsa: implement iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:17 +0800
Message-ID: <20260602104637.1219810-11-guanghuifeng@linux.alibaba.com>
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

Migrate IPMMU-VMSA to implement iova_to_phys_length, passing through
mapped_length from io-pgtable.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/ipmmu-vmsa.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9386b752dea2..a1b659ddbdb5 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -699,14 +699,18 @@ static void ipmmu_iotlb_sync(struct iommu_domain *io_domain,
 	ipmmu_flush_iotlb_all(io_domain);
 }
 
-static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
-				      dma_addr_t iova)
+static phys_addr_t ipmmu_iova_to_phys_length(struct iommu_domain *io_domain,
+				      dma_addr_t iova, size_t *mapped_length)
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	/* TODO: Is locking needed ? */
 
-	return domain->iop->iova_to_phys(domain->iop, iova);
+	return domain->iop->iova_to_phys_length(domain->iop, iova,
+						mapped_length);
 }
 
 static int ipmmu_init_platform_device(struct device *dev,
@@ -892,7 +896,7 @@ static const struct iommu_ops ipmmu_ops = {
 		.unmap_pages	= ipmmu_unmap,
 		.flush_iotlb_all = ipmmu_flush_iotlb_all,
 		.iotlb_sync	= ipmmu_iotlb_sync,
-		.iova_to_phys	= ipmmu_iova_to_phys,
+		.iova_to_phys_length = ipmmu_iova_to_phys_length,
 		.free		= ipmmu_domain_free,
 	}
 };
-- 
2.43.7

