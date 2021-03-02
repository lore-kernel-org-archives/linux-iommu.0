Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5464C433E6
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 11:57:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A2364EE8
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 11:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A2364EE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E88B183D05;
	Tue,  2 Mar 2021 11:57:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iSv35jAlLEQP; Tue,  2 Mar 2021 11:57:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A23258277E;
	Tue,  2 Mar 2021 11:57:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F600C000B;
	Tue,  2 Mar 2021 11:57:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2E62C0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 11:57:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C021F4AA04
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 11:57:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s8UvkJLKj_wl for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 11:57:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 09FA14ECFE
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 11:57:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F9D764F60;
 Tue,  2 Mar 2021 11:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614686233;
 bh=YzbiNQhdh942VLjsdediUsjqpUuko2qfgVUPR6Cn+aM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HNFTxbBwoO6gwDasHbmzw8rCob/OqC7Pyra1hJRRnWM8B3fOR4VojbYvmwqJJI7L1
 xG4evv1nYqwpA5AsMkSMpSIlXywONeYs1UbZOG2nI8/5xjWagaqa5JvnW8ECtc0zpa
 IZkJ6xsD1ALKPhW+3DgnrtQDoqn9lbMWSeWWe+zr/4TKDNRxJp5Y58aWs2M1AZPr7R
 DAmeFhsOi4iOqgmFfkeCx5CdjzooWlxTq9bDhdx09S1ZznXKl4pfr8V6eCeF+2oPxU
 4IBCmbM/rV680xxdDQPkH6s2s4VnZBrPtSNDnRV39G2lhPOtwwRcGLn2zGxHufVKTr
 JNQ14e8eCk3vA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 21/47] iommu/amd: Fix performance counter
 initialization
Date: Tue,  2 Mar 2021 06:56:20 -0500
Message-Id: <20210302115646.62291-21-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302115646.62291-1-sashal@kernel.org>
References: <20210302115646.62291-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Tj <ml.linux@elloe.vision>,
 iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
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

[ Upstream commit 6778ff5b21bd8e78c8bd547fd66437cf2657fd9b ]

Certain AMD platforms enable power gating feature for IOMMU PMC,
which prevents the IOMMU driver from updating the counter while
trying to validate the PMC functionality in the init_iommu_perf_ctr().
This results in disabling PMC support and the following error message:

    "AMD-Vi: Unable to read/write to IOMMU perf counter"

To workaround this issue, disable power gating temporarily by programming
the counter source to non-zero value while validating the counter,
and restore the prior state afterward.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Tested-by: Tj (Elloe Linux) <ml.linux@elloe.vision>
Link: https://lore.kernel.org/r/20210208122712.5048-1-suravee.suthikulpanit@amd.com
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201753
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/init.c | 45 ++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c842545368fd..3c215f0a6052 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -12,6 +12,7 @@
 #include <linux/acpi.h>
 #include <linux/list.h>
 #include <linux/bitmap.h>
+#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/syscore_ops.h>
 #include <linux/interrupt.h>
@@ -254,6 +255,8 @@ static enum iommu_init_state init_state = IOMMU_START_STATE;
 static int amd_iommu_enable_interrupts(void);
 static int __init iommu_go_to_state(enum iommu_init_state state);
 static void init_device_table_dma(void);
+static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+				u8 fxn, u64 *value, bool is_write);
 
 static bool amd_iommu_pre_enabled = true;
 
@@ -1717,13 +1720,11 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	return 0;
 }
 
-static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
-				u8 fxn, u64 *value, bool is_write);
-
-static void init_iommu_perf_ctr(struct amd_iommu *iommu)
+static void __init init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
+	int retry;
 	struct pci_dev *pdev = iommu->dev;
-	u64 val = 0xabcd, val2 = 0, save_reg = 0;
+	u64 val = 0xabcd, val2 = 0, save_reg, save_src;
 
 	if (!iommu_feature(iommu, FEATURE_PC))
 		return;
@@ -1731,17 +1732,39 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	amd_iommu_pc_present = true;
 
 	/* save the value to restore, if writable */
-	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false) ||
+	    iommu_pc_get_set_reg(iommu, 0, 0, 8, &save_src, false))
 		goto pc_false;
 
-	/* Check if the performance counters can be written to */
-	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
-	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
-	    (val != val2))
+	/*
+	 * Disable power gating by programing the performance counter
+	 * source to 20 (i.e. counts the reads and writes from/to IOMMU
+	 * Reserved Register [MMIO Offset 1FF8h] that are ignored.),
+	 * which never get incremented during this init phase.
+	 * (Note: The event is also deprecated.)
+	 */
+	val = 20;
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 8, &val, true))
 		goto pc_false;
 
+	/* Check if the performance counters can be written to */
+	val = 0xabcd;
+	for (retry = 5; retry; retry--) {
+		if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true) ||
+		    iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false) ||
+		    val2)
+			break;
+
+		/* Wait about 20 msec for power gating to disable and retry. */
+		msleep(20);
+	}
+
 	/* restore */
-	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true) ||
+	    iommu_pc_get_set_reg(iommu, 0, 0, 8, &save_src, true))
+		goto pc_false;
+
+	if (val != val2)
 		goto pc_false;
 
 	pci_info(pdev, "IOMMU performance counters supported\n");
-- 
2.30.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
