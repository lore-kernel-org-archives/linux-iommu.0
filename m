Return-Path: <SRS0=LdVQ=KA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6294C43470
	for <iommu@archiver.kernel.org>; Wed,  5 May 2021 16:35:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D29C6192E
	for <iommu@archiver.kernel.org>; Wed,  5 May 2021 16:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D29C6192E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54E3083E08;
	Wed,  5 May 2021 16:35:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z_jgv_dJ84ax; Wed,  5 May 2021 16:35:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FD6583C20;
	Wed,  5 May 2021 16:35:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAA5DC000D;
	Wed,  5 May 2021 16:35:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D7F7C000D
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 16:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C12040665
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 16:35:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qpz3aatOUChX for <iommu@lists.linux-foundation.org>;
 Wed,  5 May 2021 16:35:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C8C7F4066B
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 16:35:49 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C8A66142F;
 Wed,  5 May 2021 16:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620232549;
 bh=L9Fh6FiWjtyOYGHCrMPfyT8MFcvxiBflcyQyZc5AxaM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TQrwd/IF8aohczlbQ2uOXIqLSP8T7mNfjnt0zLNC5JlwowG/H8Nu+unBmQ2o7zeVC
 DIUH/el1tFs6jmj0wRovsy0fzTC6/sd0XqneILD7ZVv2eV8j9L9lY7Hy6xS/mbed9x
 u9g7qJf2cuQWGz+lLcBLzGjtmhLOF0slrT1CWBIqWg0KKCa4xTuiYPLALbBzUD1nA9
 PyQqItMYQ5s4+qtE47bAkeRJmsHWq12t/K2BssCoUkUr+SZeyziPSfS7Z010ro/Q1x
 eNIr0aZcyWKE2iUb8XAEnuGrYyI3u5bmp3jmJYvD6+4wN3iCz0t/YG9kFo3UDxK6lp
 Jiow33MCpXgGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 066/104] Revert "iommu/amd: Fix performance
 counter initialization"
Date: Wed,  5 May 2021 12:33:35 -0400
Message-Id: <20210505163413.3461611-66-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163413.3461611-1-sashal@kernel.org>
References: <20210505163413.3461611-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Joerg Roedel <jroedel@suse.de>, David Coe <david.coe@live.co.uk>,
 Alexander Monakov <amonakov@ispras.ru>, iommu@lists.linux-foundation.org,
 Shuah Khan <skhan@linuxfoundation.org>, Tj <ml.linux@elloe.vision>
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

From: Paul Menzel <pmenzel@molgen.mpg.de>

[ Upstream commit 715601e4e36903a653cd4294dfd3ed0019101991 ]

This reverts commit 6778ff5b21bd8e78c8bd547fd66437cf2657fd9b.

The original commit tries to address an issue, where PMC power-gating
causing the IOMMU PMC pre-init test to fail on certain desktop/mobile
platforms where the power-gating is normally enabled.

There have been several reports that the workaround still does not
guarantee to work, and can add up to 100 ms (on the worst case)
to the boot process on certain platforms such as the MSI B350M MORTAR
with AMD Ryzen 3 2200G.

Therefore, revert this commit as a prelude to removing the pre-init
test.

Link: https://lore.kernel.org/linux-iommu/alpine.LNX.3.20.13.2006030935570.3181@monopod.intra.ispras.ru/
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201753
Cc: Tj (Elloe Linux) <ml.linux@elloe.vision>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Alexander Monakov <amonakov@ispras.ru>
Cc: David Coe <david.coe@live.co.uk>
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Link: https://lore.kernel.org/r/20210409085848.3908-2-suravee.suthikulpanit@amd.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/init.c | 45 ++++++++++------------------------------
 1 file changed, 11 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 78339b0bb8e5..7720dcfa2b29 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -12,7 +12,6 @@
 #include <linux/acpi.h>
 #include <linux/list.h>
 #include <linux/bitmap.h>
-#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
 #include <linux/interrupt.h>
@@ -255,8 +254,6 @@ static enum iommu_init_state init_state = IOMMU_START_STATE;
 static int amd_iommu_enable_interrupts(void);
 static int __init iommu_go_to_state(enum iommu_init_state state);
 static void init_device_table_dma(void);
-static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
-				u8 fxn, u64 *value, bool is_write);
 
 static bool amd_iommu_pre_enabled = true;
 
@@ -1715,11 +1712,13 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	return 0;
 }
 
-static void __init init_iommu_perf_ctr(struct amd_iommu *iommu)
+static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+				u8 fxn, u64 *value, bool is_write);
+
+static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
-	int retry;
 	struct pci_dev *pdev = iommu->dev;
-	u64 val = 0xabcd, val2 = 0, save_reg, save_src;
+	u64 val = 0xabcd, val2 = 0, save_reg = 0;
 
 	if (!iommu_feature(iommu, FEATURE_PC))
 		return;
@@ -1727,39 +1726,17 @@ static void __init init_iommu_perf_ctr(struct amd_iommu *iommu)
 	amd_iommu_pc_present = true;
 
 	/* save the value to restore, if writable */
-	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false) ||
-	    iommu_pc_get_set_reg(iommu, 0, 0, 8, &save_src, false))
-		goto pc_false;
-
-	/*
-	 * Disable power gating by programing the performance counter
-	 * source to 20 (i.e. counts the reads and writes from/to IOMMU
-	 * Reserved Register [MMIO Offset 1FF8h] that are ignored.),
-	 * which never get incremented during this init phase.
-	 * (Note: The event is also deprecated.)
-	 */
-	val = 20;
-	if (iommu_pc_get_set_reg(iommu, 0, 0, 8, &val, true))
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
 		goto pc_false;
 
 	/* Check if the performance counters can be written to */
-	val = 0xabcd;
-	for (retry = 5; retry; retry--) {
-		if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true) ||
-		    iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false) ||
-		    val2)
-			break;
-
-		/* Wait about 20 msec for power gating to disable and retry. */
-		msleep(20);
-	}
-
-	/* restore */
-	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true) ||
-	    iommu_pc_get_set_reg(iommu, 0, 0, 8, &save_src, true))
+	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
+	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
+	    (val != val2))
 		goto pc_false;
 
-	if (val != val2)
+	/* restore */
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
 		goto pc_false;
 
 	pci_info(pdev, "IOMMU performance counters supported\n");
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
