Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C7581AA8
	for <iommu@lists.linux.dev>; Fri, 30 Jan 2026 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769756417; cv=none; b=fx7zOkhw6Qp3gb2z7Iecf0PIl2AtGyfNOLb28PA5O+vVbiPVno3PKv7xPyXvq3I64KRTCc0rDn8nlsVYVcrw0Cp4Zt6p7zPbaR+T7+dyoIVY9MI81aZOoWw9BQIn0T5l2h7r93ytcViDRU1vqvcu+DdiFvCBMSC/nrMP1FK0+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769756417; c=relaxed/simple;
	bh=9ombZwwISGB5HH7OzI8Btk4cF//LltI4Twak3chuXWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ky1Pa88CNLpGRwuQw8psBlBpw8sI3ijwH9Lsdj7fW1E495iAxQ2Tf8GfAtRcE0kb0BE4SXLmxoaRQAwhYXWWLf6Bp7sb0G58iofdV94LegjLTp5w6bJtbsI7EmRLspBweB/FU0PKDmsqLfdnmPzpvnZHLY8HM9sM1dQbnBWeRPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=115.124.28.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from guoyaxing.localdomain(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.gK.y6dm_1769756062 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 30 Jan 2026 14:54:48 +0800
From: Yaxing Guo <guoyaxing@bosc.ac.cn>
To: tjeznach@rivosinc.com
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxing Guo <guoyaxing@bosc.ac.cn>
Subject: [PATCH v1] iommu/riscv: Skip IRQ count check when using MSI interrupts
Date: Fri, 30 Jan 2026 14:54:20 +0800
Message-Id: <20260130065420.16811-1-guoyaxing@bosc.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RISC-V IOMMU platform devices that use MSI interrupts (indicated by the
presence of 'msi-parent' in the device tree), there are no wired interrupt
lines, so calling platform_get_irq_count() returns 0 or -ENXIO, causing the
driver to fail during probe.

However, MSI interrupts are allocated dynamically via the MSI subsystem and
do not appear in the device tree 'interrupts' property. Therefore, the
driver should not require a non-zero IRQ count when 'msi-parent' is present.

This patch fixes the bug where probe fails when using MSI interrupts
 (which do not have an 'interrupts' property in the device tree)..

Fixes: <d5f88acdd6ff> ("iommu/riscv: Add support for platform msi")

Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
---
 drivers/iommu/riscv/iommu-platform.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index 83a28c83f991..8f15b06e8499 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -68,12 +68,7 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAPABILITIES);
 	iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
 
-	iommu->irqs_count = platform_irq_count(pdev);
-	if (iommu->irqs_count <= 0)
-		return dev_err_probe(dev, -ENODEV,
-				     "no IRQ resources provided\n");
-	if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT)
-		iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
+	iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
 
 	igs = FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps);
 	switch (igs) {
@@ -120,6 +115,13 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 		fallthrough;
 
 	case RISCV_IOMMU_CAPABILITIES_IGS_WSI:
+		iommu->irqs_count = platform_irq_count(pdev);
+		if (iommu->irqs_count <= 0)
+			return dev_err_probe(dev, -ENODEV,
+					     "no IRQ resources provided\n");
+		if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT)
+			iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
+
 		for (vec = 0; vec < iommu->irqs_count; vec++)
 			iommu->irqs[vec] = platform_get_irq(pdev, vec);
 
-- 
2.34.1

