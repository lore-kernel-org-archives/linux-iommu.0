Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669AD4EA388
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195457; cv=none; b=K3puyHcZT1DMUrvv9KCQ9ov/3azKFl/A6i5m2Ef/ih8N2+Qj0qPLjMctxOAaZ2RxiRVXvw3BIvt936YcCgjupHwq6YbMHI4we/eSn0Qm509jThqyyLniclbPSy3KEJUsUBrWD1IPDCgqcjaVv2lN7MGHxwp34SleJDONRVTq3tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195457; c=relaxed/simple;
	bh=KIQUkhSAF15c8pq3oo7yWwIcmCNSRsPc9tYtjHF2Dz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FNu7XtQDt725bsIhmfwUnlLFiKsIzz+4HMVwK+F5OHrdTOjhVdgDVbvDm1KCK7y2kilvxKSXCmW0lhN2Cy+a6xsaxflKfntEsQ/4lNow+oi0jES474mnEx9G4YLLE7yiwA8mnyAYFU+vhONuBcVeX2K4YU8v1f0pGQDUxZBOIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j78B6y81; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j78B6y81"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779195444; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ORsC3jjziczAoDhmvkQwijx70HMiWpP5k92grPFcmws=;
	b=j78B6y814X+eqGvHnDhiHsdH3NJvth4PHe65o4SKVoyMmmkiMarb4v+KFOj8FrAxzvWTUCIPl66jf4ex0gHyMYj9DJb6ZCgJ+d2wH3YHLxKlud20d1CH2d5I/4ZqwLdoD8OXtBpsaIdTqeXWOwjvWHbvHV19CGBIl7Iks8PtjQo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X3FViH8_1779195442;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3FViH8_1779195442 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 May 2026 20:57:23 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	andrew.jones@oss.qualcomm.com
Cc: guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH] iommu/riscv: prefer WSI on IGS=BOTH when wired IRQs are described
Date: Tue, 19 May 2026 20:57:16 +0800
Message-Id: <20260519125716.81594-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

The RISC-V IOMMU spec defines IGS=BOTH as supporting both MSI and
WSI, with software selecting the path. The DT path already behaves
as expected by selecting WSI when wired IRQ resources are described.
The ACPI path, however, currently falls back to MSI even when
firmware describes wired IRQ resources.

Use firmware-described wired IRQ resources as the trigger to select
WSI for IGS=BOTH:
  - DT: "interrupts" present, no "msi-parent"
  - ACPI: DSDT _CRS Interrupt() descriptors
    (mainline does not yet parse the RIMT Interrupt Wire Array)

When triggered, rewrite igs to IGS_WSI and reuse the existing WSI
handling. Keep the existing behaviour otherwise.

Fixes: d5f88acdd6ff ("iommu/riscv: Add support for platform msi")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu-platform.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index 399ba8fe1b3e..bd7712231140 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -71,6 +71,21 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
 
 	igs = FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps);
+
+	/*
+	 * IGS=BOTH means the IOMMU supports either MSI or WSI;
+	 * the spec leaves the choice to software. Use the firmware-described
+	 * wired interrupt resources as the trigger:
+	 *   - DT  : "interrupts" property present, no "msi-parent"  -> WSI
+	 *   - ACPI: DSDT _CRS Interrupt() present  -> WSI
+	 * Otherwise default to the MSI path.
+	 */
+	if (igs == RISCV_IOMMU_CAPABILITIES_IGS_BOTH &&
+	    platform_irq_count(pdev) > 0) {
+		dev_info(dev, "firmware describes wired IRQs; preferring WSI on IGS=BOTH\n");
+		igs = RISCV_IOMMU_CAPABILITIES_IGS_WSI;
+	}
+
 	switch (igs) {
 	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
 	case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
-- 
2.50.1

