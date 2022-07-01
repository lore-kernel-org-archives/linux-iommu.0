Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616F1C43334
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 07:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD55A40265;
	Fri,  1 Jul 2022 07:38:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD55A40265
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ak7mOfy6M4vH; Fri,  1 Jul 2022 07:38:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 59249409A8;
	Fri,  1 Jul 2022 07:38:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 59249409A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 149BDC0071;
	Fri,  1 Jul 2022 07:38:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 360F6C002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:38:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A57C607F5
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:38:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A57C607F5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WTm8ojZObtR3 for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 07:38:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8FCA60757
Received: from unicom145.biz-email.net (unicom145.biz-email.net
 [210.51.26.145])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8FCA60757
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:37:59 +0000 (UTC)
Received: from ([60.208.111.195])
 by unicom145.biz-email.net ((D)) with ASMTP (SSL) id VEM00054;
 Fri, 01 Jul 2022 15:37:54 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.9; Fri, 1 Jul 2022 15:37:53 +0800
From: Bo Liu <liubo03@inspur.com>
To: <joro@8bytes.org>, <will@kernel.org>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH] iommu/amd: Handle return of iommu_device_sysfs_add
Date: Fri, 1 Jul 2022 02:20:08 -0400
Message-ID: <20220701062008.6988-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
X-Originating-IP: [10.200.104.97]
tUid: 2022701153754142284bb54b59ca6fffe76b63419a9b2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Cc: iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
 Bo Liu <liubo03@inspur.com>, linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

As iommu_device_sysfs_add() can fail, we should check the return value.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/iommu/amd/init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3c82d9c5f1c0..a3c4fdd40f04 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2058,8 +2058,11 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	amd_iommu_erratum_746_workaround(iommu);
 	amd_iommu_ats_write_check_workaround(iommu);
 
-	iommu_device_sysfs_add(&iommu->iommu, &iommu->dev->dev,
+	ret = iommu_device_sysfs_add(&iommu->iommu, &iommu->dev->dev,
 			       amd_iommu_groups, "ivhd%d", iommu->index);
+	if (ret)
+		return ret;
+
 	iommu_device_register(&iommu->iommu, &amd_iommu_ops, NULL);
 
 	return pci_enable_device(iommu->dev);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
