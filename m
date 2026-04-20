Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0909130E85C
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688364; cv=none; b=n3rk1s3ddYzjBo4LzltJzcdTlKsCFCVF2+G2ZPrYeiL6Sd6gmqf7M5h+vR91cf3knjFk7P5yVanvtF7pQCDw83mt5y4W/+1aiB3xfQ6lucU65r9niSB9RgkJhRB5heH1LuSjvTU+GjAfAjJ0XiIJ3Oc2doO3wLOCg4WI8O8Hfxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688364; c=relaxed/simple;
	bh=hfKn1gWu02ox0fBAB+Xii6DppfzcdbaZuM3tWxbUDvQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bzTTc/bKl30hVluFcg/rY/EKvgT3H1JQyntRPzcesyd30n2wv2C+bUxWfGqFLKDnW2aXVZ7ZHOTgNKB/xNWJrf9KJgBBxJmzpIW3vrvuXGljEYdLBVd1htZyZi4gSiMMvjuJkpgJKA23ME8wcf0zhSZVMXDOvlP0uBmWU+YkR8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=W8Zz/2CX; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="W8Zz/2CX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1776688362; x=1808224362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=syaahfr1AvjeTrgpecRtNBtBP+GrrbQJ3jcGHB9nAds=;
  b=W8Zz/2CX+22M46XWq/Q7Zpc8bKwmuYkTtOsdd1bovnAvrbWzE0ANmUXi
   mb3JPOQpi6q0Q/NjOqMMWP3ETnVq5c4FWSfgnfAXn5LxiQmLJT4LpBa79
   ZMubmm5gsjmunJQEYDbgIXv24k1xuyS+hg1FkaBr+siUpBKCqPB4V8rLv
   x3bGSROakAuSEML4RA8952HbOanyMlYJOI+KtDAf/9gaqOuI8413+Fu7k
   yu6qyLM2CHD8vfT6u5MC7adrVMJO/ly5MH+ldZoLrL0r0fAjayatGLssq
   VI6pdXPifKRUCZOsKk8f0JdvqQbVvEKI3QZpu7MZ0agyl7LHw1QalpGJU
   w==;
X-CSE-ConnectionGUID: QzW1fbjyTASzVH90g2euCQ==
X-CSE-MsgGUID: TT2won87QKSxh/RpnfGOUw==
X-IronPort-AV: E=Sophos;i="6.23,189,1770595200"; 
   d="scan'208";a="17503804"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 12:32:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:30295]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.81:2525] with esmtp (Farcaster)
 id 057c323d-5e62-472c-83db-4447edd78fdd; Mon, 20 Apr 2026 12:32:38 +0000 (UTC)
X-Farcaster-Flow-ID: 057c323d-5e62-472c-83db-4447edd78fdd
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 12:32:37 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 20 Apr 2026
 12:32:35 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Will Deacon <will@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Pranjal Shrivastava
	<praan@google.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>, Zeev Zilberman
	<zeev@amazon.com>
Subject: [PATCH] iommu/arm-smmu-v3: Allow disabling Stage 1 translation
Date: Mon, 20 Apr 2026 12:32:01 +0000
Message-ID: <20260420123221.20801-1-epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When the hardware advertises both Stage 1 and Stage 2 translation, the
driver prefers Stage 1 for DMA domain allocation and only falls back to
Stage 2 if Stage 1 is not supported.

Some configurations may want to force Stage 2 translation even when the
hardware supports Stage 1. Introduce a module parameter 'disable_s1'
that, when set, prevents the driver from advertising
ARM_SMMU_FEAT_TRANS_S1, causing all DMA domains to use Stage 2 instead.

Co-developed-by: Zeev Zilberman <zeev@amazon.com>
Signed-off-by: Zeev Zilberman <zeev@amazon.com>
Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e8d7dbe495f0..afb21c210e24 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -39,6 +39,11 @@ module_param(disable_msipolling, bool, 0444);
 MODULE_PARM_DESC(disable_msipolling,
 	"Disable MSI-based polling for CMD_SYNC completion.");
 
+static bool disable_s1;
+module_param(disable_s1, bool, 0444);
+MODULE_PARM_DESC(disable_s1,
+	"Disable Stage 1 translation even if supported by hardware.");
+
 static const struct iommu_ops arm_smmu_ops;
 static struct iommu_dirty_ops arm_smmu_dirty_ops;
 
@@ -5087,13 +5092,13 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		smmu->features |= ARM_SMMU_FEAT_STALLS;
 	}
 
-	if (reg & IDR0_S1P)
+	if ((reg & IDR0_S1P) && !disable_s1)
 		smmu->features |= ARM_SMMU_FEAT_TRANS_S1;
 
 	if (reg & IDR0_S2P)
 		smmu->features |= ARM_SMMU_FEAT_TRANS_S2;
 
-	if (!(reg & (IDR0_S1P | IDR0_S2P))) {
+	if (!(smmu->features & (ARM_SMMU_FEAT_TRANS_S1 | ARM_SMMU_FEAT_TRANS_S2))) {
 		dev_err(smmu->dev, "no translation support!\n");
 		return -ENXIO;
 	}
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

