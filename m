Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC6E48C417
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499956; cv=none; b=RgCQCqVN3+O6J1ErYNOvvnz+QeKjyo6X8yy6f54weu6iehV/x32sGSKmOF3QrdrmRWsCZEXshX8uCfhBpF8yQ1O6PrN/iUbSLMJp5ikFJ3lxQ9tyFzC/glL58e+RuN34CEdClY5Kwxbn8YLRxJ9VZwNpTzIUgZYNQ8H18DedGjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499956; c=relaxed/simple;
	bh=Eo1T/DdjxK6cr5MBTlk9PUo4KuWE5dzwz16HwzPcZxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKUjrNVpX7+iav2EBnVxE+LJ0fxB+iQebgYaNQs5Ez9OR42f1Bo64l4MfTod3Xv8QJapGpcfMiI5hxs1rpcBv71cjZSvAz/2bFKcLXH94/2yh4uCesYCT6l/eB5zlPd6H/OeogleolgulV6b1TGkByswpDJ6lpo1ki3KTGvAoD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rPnvpYgq; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rPnvpYgq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499951; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HHcwXEJnumwKc2zUUog9MdRhUiRkhNb+QkY/zlqMCrg=;
	b=rPnvpYgqqdOdj8qphgqovqmNrOZ/zqZD3PkQL4ymax0zS/kk4gjubLENRjdWzLVQRusppsWDFPibHFkT16DFKTheo+EekjUzWOM0uWpbXrZognczVtIkYvXP3qGaXm3SBghc5dXblELGOTctNnrkcEUgBGOXk0mGS0co/nyjEGg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR8Q_1780499948;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR8Q_1780499948 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:19:08 +0800
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
Subject: [PATCH v3 30/32] iommu/io-pgtable-arm-v7s: remove deprecated iova_to_phys wrapper
Date: Wed,  3 Jun 2026 23:18:02 +0800
Message-ID: <20260603151804.1963871-31-guanghuifeng@linux.alibaba.com>
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

Remove the iova_to_phys wrapper function and .iova_to_phys assignment
from ARM v7s io-pgtable, as all callers now use iova_to_phys_length.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 62198e31a393..da065747e37c 100644
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
@@ -730,7 +718,6 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map_pages	= arm_v7s_map_pages,
 		.unmap_pages	= arm_v7s_unmap_pages,
-		.iova_to_phys	= arm_v7s_iova_to_phys,
 		.iova_to_phys_length	= arm_v7s_iova_to_phys_length,
 	};
 
-- 
2.43.7

