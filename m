Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0B63DA5A9
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397243; cv=none; b=GG1iK33Xh5J40wXZE7uU29fYqbVkCkC6jNe/Ugg674fjh7KOkkUKW2/EFQX+DvXjoTNHhYB/umvO5R137H6OUS0aR0F0TsirQRh7yOppiZNb4uZ4IWHbqNn/4h98vIyV2zqJp2SZwWzkbw8QkJc5BAtnIIEiFDe3z4MbsCVlkKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397243; c=relaxed/simple;
	bh=do6hrbiMu2ieoTUFvq1bsSKUbVS6YN1Qf61NrTmx4MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWhLDL6bkt8fyASfjNr9JQzidcV0ppQzMaHVsX2cRKlfOi3+qQhoPFldPz0yXI85KBD9llPVPpAFgFVk6b6jsX1YfMtoIzedHQknZsCFCtryGXRke5JaBUpKnF4d5cZDw7YBdCqRlsLCOrM4SJU0EmcEYB01FZeHjZrxzX7ZztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PQMta2nG; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PQMta2nG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397240; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=o1pBWOp6KPk1xwyKTTozbXEjvmJOV/Yw7GM3gk1sgVc=;
	b=PQMta2nGwmoPnVfCtBqqwGXCXzc1w0zgxpfOZh7lluiTgaFuJTZMnD4KKitasWT6muM/GCpmtY8uydWowx1f1B2Ach0W7oMONULOMyOTQJEmjhU9gxwhFCoaFSjZixh+AH9uzzictRsuwlrBKcqh7+Ne1RQqwwCiT9snA0eS5Bo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E9A._1780397236;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E9A._1780397236 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:47:17 +0800
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
Subject: [PATCH v2 29/30] iommu/io-pgtable-dart: remove deprecated iova_to_phys wrapper
Date: Tue,  2 Jun 2026 18:46:36 +0800
Message-ID: <20260602104637.1219810-30-guanghuifeng@linux.alibaba.com>
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
from DART io-pgtable, as all callers now use iova_to_phys_length.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/io-pgtable-dart.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
index 2dac21a578a7..01c4c022830b 100644
--- a/drivers/iommu/io-pgtable-dart.c
+++ b/drivers/iommu/io-pgtable-dart.c
@@ -333,18 +333,6 @@ static size_t dart_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	return i * pgsize;
 }
 
-static phys_addr_t dart_iova_to_phys_length(struct io_pgtable_ops *ops,
-					    unsigned long iova,
-					    size_t *mapped_length);
-
-static phys_addr_t dart_iova_to_phys(struct io_pgtable_ops *ops,
-				     unsigned long iova)
-{
-	phys_addr_t phys = dart_iova_to_phys_length(ops, iova, NULL);
-
-	return (phys == PHYS_ADDR_MAX) ? 0 : phys;
-}
-
 static phys_addr_t dart_iova_to_phys_length(struct io_pgtable_ops *ops,
 					    unsigned long iova,
 					    size_t *mapped_length)
@@ -416,7 +404,6 @@ dart_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map_pages		= dart_map_pages,
 		.unmap_pages		= dart_unmap_pages,
-		.iova_to_phys		= dart_iova_to_phys,
 		.iova_to_phys_length	= dart_iova_to_phys_length,
 	};
 
-- 
2.43.7

