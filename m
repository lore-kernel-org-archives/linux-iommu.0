Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBA153BE
	for <iommu@lists.linux.dev>; Mon,  1 Apr 2024 06:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711951719; cv=none; b=V6TDTV5QA3w/vrOk95b/Jw7+qnBcfoT8lyo6Sz7NiQDW/KhopuLtSO7RrCkxr08EJ+pYrNyzdAq+PUlzZlYTHsKgEa39P7bjdhWn9sLj+1BvBwIj/VSE2hJmbF+ymSzxXHhT6b++9CureJADrtCX0M0V3TOZaA1dZonqEOIKAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711951719; c=relaxed/simple;
	bh=IQzOAdQA+jJffWZwO/QNNaKvKCOndDIhXEcSZhEEC6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LN04baAuaVHwCP94AoeDTrF88zts14w5Sorx3GfvGqaPOgLmiGTx3PX+LuTE1i+K6//NplaYvWIOtVob4pgTYRUcqVrKmD6FsRT2oxqvxcakLLkqXkwXNfRQEp7xFSP44/0zhQyKhDAucuz7bRpmmoB8FstSCRcsm9U1iG0FVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Epg7kFM/; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Epg7kFM/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711951708; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xLAqmFdNuV37IQ1rLqAOuEMfgZpQzE4Jc8kvl/J8SJM=;
	b=Epg7kFM/EirfwvqIVTLGS99IH7zdoGEOUnHDXnBXfu0yUZXhetAvjHAYzKe2q44wElhtSCB6YdX/B8qUkAEQIjGLYtTb5w3dDcAWxLtEFvyA1r4eBc+3lnWj4k4TQuLEgy5dkDr4EWpxvDB6xoeFV33tuhuwesLx9muwFCnKimE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuchun.shang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W3gckJ5_1711951691;
Received: from GNRONE.hz.ali.com(mailfrom:xuchun.shang@linux.alibaba.com fp:SMTPD_---0W3gckJ5_1711951691)
          by smtp.aliyun-inc.com;
          Mon, 01 Apr 2024 14:08:26 +0800
From: Xuchun Shang <xuchun.shang@linux.alibaba.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	iommu@lists.linux.dev
Cc: Xuchun Shang <xuchun.shang@linux.alibaba.com>
Subject: [PATCH] iommu/vt-d: fix wrong use of pasid config
Date: Mon,  1 Apr 2024 14:07:53 +0800
Message-Id: <20240401060753.3321318-1-xuchun.shang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit "iommu/vt-d: Add IOMMU perfmon support" introduce IOMMU
PMU feature, but use the wrong config when set pasid filter.

Fixes: 7232ab8b89e9 ("iommu/vt-d: Add IOMMU perfmon support")
Signed-off-by: Xuchun Shang <xuchun.shang@linux.alibaba.com>
---
 drivers/iommu/intel/perfmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index cf43e798eca4..44083d01852d 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -438,7 +438,7 @@ static int iommu_pmu_assign_event(struct iommu_pmu *iommu_pmu,
 	iommu_pmu_set_filter(domain, event->attr.config1,
 			     IOMMU_PMU_FILTER_DOMAIN, idx,
 			     event->attr.config1);
-	iommu_pmu_set_filter(pasid, event->attr.config1,
+	iommu_pmu_set_filter(pasid, event->attr.config2,
 			     IOMMU_PMU_FILTER_PASID, idx,
 			     event->attr.config1);
 	iommu_pmu_set_filter(ats, event->attr.config2,
-- 
2.39.3

