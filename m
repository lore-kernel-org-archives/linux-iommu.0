Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F577480330
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499942; cv=none; b=DdaFFvdXvMYEx8Xm6Wi83T4L0wAvLki9iUXSl+TDeKxmDfzS3HOr4jqj3eG+f/1Di3T6+LiD1E1Ko5ClnIe351SsLgdKKfWLNqRHaN/ljXgkOkj5iqaDSD6l3vwIU15EXaYmgqCj2a1kU5X1jvxykbr6/PNfneEEdNtM2DTSKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499942; c=relaxed/simple;
	bh=ax8fDe/mdOayxrn8NCM5Uh70m+R/5ZZEaIDoJvQSYZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKmq3Gs9dvUV2nu1Ju1Z8DV2qmdMRZPzMBPR+ywQTv6AYV4QvypjQSewnXICZ21qYnAOWZjYbQxWEWwrNRCZKbM4t++CQ6D3MJYlHs9InACR/P5U/SHQAsA1zS/q163A4ks07KrhaAiDMiyVvaMB7yOOq4s+UnkKu/lo90pyuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fQ9txuXN; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fQ9txuXN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499931; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=M5zQjIPVfFmKstwwMGABYtO3/c5KzR7s9T/A9BdluRs=;
	b=fQ9txuXNKHL+hmHX8mrvPef/19iGfV7v1OchJ0p5XloWQxSrRsZSgAdF/lQNsuXH8ZMk0seNJR9n/oCFqc0v7UgZOEI42RquPDEsfjavtXiIWdZPqMcYFHRH0FmoRl/mLZBGuEt+zXuInDzk8bZGJkjowl/We6TWkAmnIFC35hc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR30_1780499928;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR30_1780499928 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:18:48 +0800
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
Subject: [PATCH v3 10/32] iommu/ipmmu-vmsa: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:42 +0800
Message-ID: <20260603151804.1963871-11-guanghuifeng@linux.alibaba.com>
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

Migrate IPMMU-VMSA to implement iova_to_phys_length, passing through
mapped_length from io-pgtable.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/ipmmu-vmsa.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9386b752dea2..6e2e5922ab1b 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -699,14 +699,16 @@ static void ipmmu_iotlb_sync(struct iommu_domain *io_domain,
 	ipmmu_flush_iotlb_all(io_domain);
 }
 
-static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
-				      dma_addr_t iova)
+static phys_addr_t ipmmu_iova_to_phys_length(struct iommu_domain *io_domain,
+				      dma_addr_t iova, size_t *mapped_length)
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
+
 	/* TODO: Is locking needed ? */
 
-	return domain->iop->iova_to_phys(domain->iop, iova);
+	return domain->iop->iova_to_phys_length(domain->iop, iova,
+						mapped_length);
 }
 
 static int ipmmu_init_platform_device(struct device *dev,
@@ -892,7 +894,7 @@ static const struct iommu_ops ipmmu_ops = {
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

