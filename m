Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517183F164C
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397243; cv=none; b=EbzdQVB04w7XroTrPuG5KgPd5WMumxEd/YqE2jGKpD8F3WymqicZE2wsguj5FC1Z9ivmthDP6PZ9kwqE0P/I/NVvBDbTF/CUTaNOaKDhm/7uHWZemVaMf8OZCMK3Cfe9L358fNG0yT7BDgWEyfrRH9HT+29wo4fXgczB6vtdksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397243; c=relaxed/simple;
	bh=SgGT2XtlwIW25fqqcH2sbNLX2j3WfGy10H1kAkmPCi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a31B7j4EMphLFKrJ/Qw4W4tP6T4B3OWgAdOfqmupsFHRMWwhzeM2aotYxFPPuoGKRei8eMdVwdpkOtW2OAkqPro0y4KGB7/Flmkti5ZBYyZ36D2hfyAEi9PUyk5EZPVisqlOy1J17XxG/V3zVJq+jOqJcjebmNcq30/7TWmdpA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fO1ZEZB6; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fO1ZEZB6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397239; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NV6kghCBJQvJsA0TcHTO4AYvesR8GtGwk13ibtGQHRk=;
	b=fO1ZEZB6hnVh9dOsSAtsTnyLpek8BRd/odhWWySBc5zv/rnK8wYc/HWgooGx/psCK0C7zTcdVfCiHmq/KF20sJKEDrh8m79FqhhW1eVOGrlcuosQn4nWYdx4ZQq0AsAJR6F3EE6NPw0mtVimCw9obJB7yYPUBhuj0gNzApVWSH4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E99j_1780397235;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E99j_1780397235 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:47:16 +0800
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
Subject: [PATCH v2 28/30] iommu/io-pgtable-arm-v7s: remove deprecated iova_to_phys wrapper
Date: Tue,  2 Jun 2026 18:46:35 +0800
Message-ID: <20260602104637.1219810-29-guanghuifeng@linux.alibaba.com>
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

Remove the iova_to_phys wrapper function and .iova_to_phys assignment
from ARM v7s io-pgtable, as all callers now use iova_to_phys_length.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 5868d68e8a85..2f954842b052 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -641,18 +641,6 @@ static size_t arm_v7s_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova
 	return unmapped;
 }
 
-static phys_addr_t arm_v7s_iova_to_phys_length(struct io_pgtable_ops *ops,
-						unsigned long iova,
-						size_t *mapped_length);
-
-static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
-					unsigned long iova)
-{
-	phys_addr_t phys = arm_v7s_iova_to_phys_length(ops, iova, NULL);
-
-	return (phys == PHYS_ADDR_MAX) ? 0 : phys;
-}
-
 static phys_addr_t arm_v7s_iova_to_phys_length(struct io_pgtable_ops *ops,
 						unsigned long iova,
 						size_t *mapped_length)
@@ -732,7 +720,6 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map_pages	= arm_v7s_map_pages,
 		.unmap_pages	= arm_v7s_unmap_pages,
-		.iova_to_phys	= arm_v7s_iova_to_phys,
 		.iova_to_phys_length	= arm_v7s_iova_to_phys_length,
 	};
 
-- 
2.43.7

