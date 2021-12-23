Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578B4C433F5
	for <iommu@archiver.kernel.org>; Thu, 23 Dec 2021 13:06:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4697F40144;
	Thu, 23 Dec 2021 13:06:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G1ygvSDLozbf; Thu, 23 Dec 2021 13:06:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E069940647;
	Thu, 23 Dec 2021 13:06:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9F11C001E;
	Thu, 23 Dec 2021 13:06:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFE25C0012
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 13:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD74940144
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 13:06:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aSQIxjtO-83l for <iommu@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 13:06:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id D54784013A
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 13:06:03 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,229,1635174000"; d="scan'208";a="104966906"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 23 Dec 2021 22:01:01 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id C3D2E4366C26;
 Thu, 23 Dec 2021 22:00:58 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Clark <robdclark@chromium.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Subject: [PATCH 1/2] iommu/arm-smmu: Use platform_irq_count() to get the
 interrupt count
Date: Thu, 23 Dec 2021 13:00:45 +0000
Message-Id: <20211223130046.9365-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211223130046.9365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211223130046.9365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Xin Tan <tanxin.ctf@gmail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
 Rob Herring <robh+dt@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_count().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4bc75c4ce402..4844cd075644 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2105,12 +2105,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (IS_ERR(smmu))
 		return PTR_ERR(smmu);
 
-	num_irqs = 0;
-	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
-		num_irqs++;
-		if (num_irqs > smmu->num_global_irqs)
-			smmu->num_context_irqs++;
-	}
+	num_irqs = platform_irq_count(pdev);
+	if (num_irqs < 0)
+		return num_irqs;
+
+	if (num_irqs > smmu->num_global_irqs)
+		smmu->num_context_irqs += (num_irqs - smmu->num_global_irqs);
 
 	if (!smmu->num_context_irqs) {
 		dev_err(dev, "found %d interrupts but expected at least %d\n",
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
