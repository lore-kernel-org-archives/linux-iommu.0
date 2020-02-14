Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3839DC3B19D
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 15:54:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6BF2465D
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 15:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xoFgLBZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6BF2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EEC5684D09;
	Fri, 14 Feb 2020 15:54:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3buC9xxq73HW; Fri, 14 Feb 2020 15:54:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6ED7D839DD;
	Fri, 14 Feb 2020 15:54:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CB72C0881;
	Fri, 14 Feb 2020 15:54:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 512FDC0177
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 15:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3BD6988158
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 15:54:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o0W51FitNycX for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 15:54:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id ED39C88127
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 15:54:24 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 25FD4222C4;
 Fri, 14 Feb 2020 15:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581695664;
 bh=uGPoaQq5sIQF55e4UpMPnmFtF7DSigxvWVTWul9hHJM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xoFgLBZYRJHH9osszXyjm5qGPsFqX9U6uEtkdBFwJ8q1IKa4HwO7rgpYqoSmNjqRF
 1ErH7xhgdlNneBPkGCxcMPh2udybUWNT4jozzN+eaXeJ1n9ESiJvffpToprh2qaAC9
 vTFBNz616Zz+S0A4Vyucc8XD61/HRFnx7j9hlaaM=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 254/542] iommu/amd: Check feature support bit
 before accessing MSI capability registers
Date: Fri, 14 Feb 2020 10:44:06 -0500
Message-Id: <20200214154854.6746-254-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

[ Upstream commit 813071438e83d338ba5cfe98b3b26c890dc0a6c0 ]

The IOMMU MMIO access to MSI capability registers is available only if
the EFR[MsiCapMmioSup] is set. Current implementation assumes this bit
is set if the EFR[XtSup] is set, which might not be the case.

Fix by checking the EFR[MsiCapMmioSup] before accessing the MSI address
low/high and MSI data registers via the MMIO.

Fixes: 66929812955b ('iommu/amd: Add support for X2APIC IOMMU interrupts')
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu_init.c  | 17 ++++++++++++-----
 drivers/iommu/amd_iommu_types.h |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 483f7bc379fa8..61628c906ce11 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -147,7 +147,7 @@ bool amd_iommu_dump;
 bool amd_iommu_irq_remap __read_mostly;
 
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
-static int amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
+static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
 static bool amd_iommu_detected;
 static bool __initdata amd_iommu_disabled;
@@ -1534,8 +1534,15 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 		if (((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0))
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
-		if (((h->efr_reg & (0x1 << IOMMU_EFR_XTSUP_SHIFT)) == 0))
-			amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
+		/*
+		 * Note: Since iommu_update_intcapxt() leverages
+		 * the IOMMU MMIO access to MSI capability block registers
+		 * for MSI address lo/hi/data, we need to check both
+		 * EFR[XtSup] and EFR[MsiCapMmioSup] for x2APIC support.
+		 */
+		if ((h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT)) &&
+		    (h->efr_reg & BIT(IOMMU_EFR_MSICAPMMIOSUP_SHIFT)))
+			amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
 		break;
 	default:
 		return -EINVAL;
@@ -1996,8 +2003,8 @@ static int iommu_init_intcapxt(struct amd_iommu *iommu)
 	struct irq_affinity_notify *notify = &iommu->intcapxt_notify;
 
 	/**
-	 * IntCapXT requires XTSup=1, which can be inferred
-	 * amd_iommu_xt_mode.
+	 * IntCapXT requires XTSup=1 and MsiCapMmioSup=1,
+	 * which can be inferred from amd_iommu_xt_mode.
 	 */
 	if (amd_iommu_xt_mode != IRQ_REMAP_X2APIC_MODE)
 		return 0;
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index f52f59d5c6bd4..f8a7945f3df90 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -383,6 +383,7 @@
 /* IOMMU Extended Feature Register (EFR) */
 #define IOMMU_EFR_XTSUP_SHIFT	2
 #define IOMMU_EFR_GASUP_SHIFT	7
+#define IOMMU_EFR_MSICAPMMIOSUP_SHIFT	46
 
 #define MAX_DOMAIN_ID 65536
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
