Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439B0481FA6
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499946; cv=none; b=Vv7Zrbn2Aho3wg/MIULOgFe7Rb0ZZtusKGkrePOtVBzBzzA6hI1lhR+wdjhemECQcPyMqQeDFBn1Dt7CNjEdp64ptJuw48vQ5cs56YJMUP1VEP9ngCRVUANWTTnL8AL4/CUEKRmErR180J9eiNGHPejZ//uhn1Oe92D3kEg7I7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499946; c=relaxed/simple;
	bh=/z3ZSGZTYTY8Su5OOmOOL/5Ipe1LodVr3fVELPJ+v1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ll2zmdwMUJ6Vp/DLOq8VnTQ7O84fY2Q06wCqSja7cZ7ALh2q4a4kk1W2APrwkuTNGL86K1/htZhcBvZLwHXG8bkvYcYvqF/qt4zmCCPW052O3pqL9FVXq0K7sCVRRM9ieyZSIJGNEQV8dkAEMjR49UV0h+8fKNLoZ19EjFl+Dc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kB8lIvHg; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kB8lIvHg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499941; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YhFCJ0OCDdDnQ9GsEesCvbAqOo6Zg3iFvNCzM+hu5ak=;
	b=kB8lIvHgB7Mf8hAADuyKaxGMB64JMCqGbupJuIST/2yOWLtvhgJiuJb5A0/i2eEs4KG+CoC/ScqH1h7Sb8haCOEFeLkjEm6LnbRbGgdcIGqAfopBc8xFWldM2jw2gp369UaTiuEVI/oDuA6KW2+YI917ysgnH0VMCkhJsev/L/o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR6-_1780499939;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR6-_1780499939 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:18:59 +0800
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
Subject: [PATCH v3 21/32] iommu/tegra-smmu: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:53 +0800
Message-ID: <20260603151804.1963871-22-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for Tegra SMMU IOMMU driver,
returning the actual PTE mapping size.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/tegra-smmu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 67e7a7b925f0..12f9bb623d87 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -803,8 +803,8 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return size;
 }
 
-static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t iova)
+static phys_addr_t tegra_smmu_iova_to_phys_length(struct iommu_domain *domain,
+					   dma_addr_t iova, size_t *mapped_length)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	unsigned long pfn;
@@ -813,10 +813,13 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 
 	pte = tegra_smmu_pte_lookup(as, iova, &pte_dma);
 	if (!pte || !*pte)
-		return 0;
+		return PHYS_ADDR_MAX;
 
 	pfn = *pte & as->smmu->pfn_mask;
 
+	if (mapped_length)
+		*mapped_length = SZ_4K;
+
 	return SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova);
 }
 
@@ -1007,7 +1010,7 @@ static const struct iommu_ops tegra_smmu_ops = {
 		.attach_dev	= tegra_smmu_attach_dev,
 		.map_pages	= tegra_smmu_map,
 		.unmap_pages	= tegra_smmu_unmap,
-		.iova_to_phys	= tegra_smmu_iova_to_phys,
+		.iova_to_phys_length = tegra_smmu_iova_to_phys_length,
 		.free		= tegra_smmu_domain_free,
 	}
 };
-- 
2.43.7

