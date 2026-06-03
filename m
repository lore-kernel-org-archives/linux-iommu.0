Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0446C48AE2E
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499950; cv=none; b=jEjcNhe/a60HYHJdCojwnN1DJbGYmCqwvdg38w1v1OgqH/zYdw383zFG0XPQ7Cz2T6ieNwMiMSL7qdDQQ1iVeDY4CQZbMSDg0FaDsnnY0awxXbHXllOBmIZKNpvAq9jSiRaKN+CLI8SNNPTmG1u6fg4qV6HZ9WUXFK6UDdJwxSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499950; c=relaxed/simple;
	bh=YQASs36NVWj0qZ5kH/E6DJa5+tQBX81O5+cWH/KpaaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkWwQlgNoriwjGJwJQ6XPy0r6QMWPg40AWKjXyNuQjDNRO20JpfnVy7N8thN8J/boocuLjuBTq0OhFQ5v6nOZA2GWicrwqFCTiKDavYVuKJIgoy9yH2g0ckGy751oTuvyutagvc9GD3etFe4d1jcbfxCOiDQ8FgHZvuBgbf4TQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TsknmRJl; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TsknmRJl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499939; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8M26HlFHL4LQgXZJUjqBP1yhFIjw3xr29kGlk8DF+os=;
	b=TsknmRJlx1H6dc/s+ttArt6ygZ43a/jVIW51D1PcoVstRNqddZV9fIZLNDudqzU8AdWT9CycxU7X+ZsevpmCTkTw383BWwuS2hX3H+PMvhUWkCqVROca6xnTpa/Q/gTt49WLqDVVOXj2k3NYx9V+5EJli0lN0wzucE+WZPVsCQ8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR4V_1780499933;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR4V_1780499933 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:18:53 +0800
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
Subject: [PATCH v3 15/32] iommu/mtk_v1: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:47 +0800
Message-ID: <20260603151804.1963871-16-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for MediaTek v1 IOMMU driver,
returning the actual PTE mapping size.
Also fix pre-existing bug: add page offset to physical address.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/mtk_iommu_v1.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index ac97dd2868d4..da41dda7620b 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -393,7 +393,9 @@ static size_t mtk_iommu_v1_unmap(struct iommu_domain *domain, unsigned long iova
 	return size;
 }
 
-static phys_addr_t mtk_iommu_v1_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
+static phys_addr_t mtk_iommu_v1_iova_to_phys_length(struct iommu_domain *domain,
+						    dma_addr_t iova,
+						    size_t *mapped_length)
 {
 	struct mtk_iommu_v1_domain *dom = to_mtk_domain(domain);
 	unsigned long flags;
@@ -404,6 +406,13 @@ static phys_addr_t mtk_iommu_v1_iova_to_phys(struct iommu_domain *domain, dma_ad
 	pa = pa & (~(MT2701_IOMMU_PAGE_SIZE - 1));
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
+	if (!pa)
+		return PHYS_ADDR_MAX;
+
+	pa |= (iova & (MT2701_IOMMU_PAGE_SIZE - 1));
+	if (mapped_length)
+		*mapped_length = MT2701_IOMMU_PAGE_SIZE;
+
 	return pa;
 }
 
@@ -590,7 +599,7 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 		.attach_dev	= mtk_iommu_v1_attach_device,
 		.map_pages	= mtk_iommu_v1_map,
 		.unmap_pages	= mtk_iommu_v1_unmap,
-		.iova_to_phys	= mtk_iommu_v1_iova_to_phys,
+		.iova_to_phys_length = mtk_iommu_v1_iova_to_phys_length,
 		.free		= mtk_iommu_v1_domain_free,
 	}
 };
-- 
2.43.7

