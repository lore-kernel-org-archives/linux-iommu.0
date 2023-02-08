Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE6944A
	for <iommu@lists.linux.dev>; Wed,  8 Feb 2023 08:15:32 +0000 (UTC)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4PBXdq0XmXz1Drq
	for <iommu@lists.linux.dev>; Wed,  8 Feb 2023 16:06:55 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.36.20.94])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4PBXdQ6xqrz54hQ7
	for <iommu@lists.linux.dev>; Wed,  8 Feb 2023 16:06:34 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxus.zte.com.cn (FangMail) with ESMTPS id 4PBXdG4kjSz9wlkQ
	for <iommu@lists.linux.dev>; Wed,  8 Feb 2023 16:06:26 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PBXd45nSCz8RTZJ
	for <iommu@lists.linux.dev>; Wed,  8 Feb 2023 16:06:16 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4PBXcs209Wz501R8;
	Wed,  8 Feb 2023 16:06:05 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 31885rCj058224;
	Wed, 8 Feb 2023 16:05:53 +0800 (+08)
	(envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid31;
	Wed, 8 Feb 2023 16:05:55 +0800 (CST)
Date: Wed, 8 Feb 2023 16:05:55 +0800 (CST)
X-Zmail-TransId: 2af963e357e330e91502
X-Mailer: Zmail v1.0
Message-ID: <202302081605554841069@zte.com.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <joro@8bytes.org>
Cc: <will@kernel.org>, <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBpb21tdS9pcG1tdS12bXNhOiB1c2XCoGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 31885rCj058224
X-FangMail-Miltered: at esgde01-1.novalocal with ID 63E3580A.000 by FangMail milter!
X-FangMail-Envelope: 1675843595/4PBXdQ6xqrz54hQ7/63E3580A.000/10.36.20.94/[10.36.20.94]/mxus.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E3581E.000/4PBXdq0XmXz1Drq

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/iommu/ipmmu-vmsa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index bdf1a4e5eae0..aca7ca8b5543 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -967,7 +967,6 @@ static const struct of_device_id ipmmu_of_ids[] = {
 static int ipmmu_probe(struct platform_device *pdev)
 {
 	struct ipmmu_vmsa_device *mmu;
-	struct resource *res;
 	int irq;
 	int ret;

@@ -987,8 +986,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 		return ret;

 	/* Map I/O memory and request IRQ. */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mmu->base = devm_ioremap_resource(&pdev->dev, res);
+	mmu->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(mmu->base))
 		return PTR_ERR(mmu->base);

-- 
2.25.1
