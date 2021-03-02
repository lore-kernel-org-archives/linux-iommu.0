Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A02C433E6
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 11:56:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B532764F31
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 11:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B532764F31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 501CB83EA3;
	Tue,  2 Mar 2021 11:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZEFfTdTleI16; Tue,  2 Mar 2021 11:56:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAE8083E11;
	Tue,  2 Mar 2021 11:56:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8BFFC000B;
	Tue,  2 Mar 2021 11:56:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8601C0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 11:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D47F96F5FC
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 11:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HchHcrr4rIFD for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 11:56:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1F4F606B1
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 11:56:08 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B14564F2C;
 Tue,  2 Mar 2021 11:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614686168;
 bh=Tdzb6+vy7YGxj/DKItB+Vfi57PKkpa66F/H/L/K5cps=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Nn+T5eY6zM9Asd2fIi8oVf4KJOHTkLJBqBryWNAIeox2Trm1DgS7ifuL5Q1fJEzVm
 dF7V+Vf4+8/3738nASrUmI5/AuIiTkV28qEYCt9Hrg2uVIMogmJjy+ae5Hm2Sifjvj
 J0iMXIk8LXv+qKtUbcS4FegtlJXWHgYLRO+00XqTs3w+1AxH3S5xFCb/eeBpO+CPF7
 P538+TfNEerW435V+DvB5PQBpOmK7Zr7ePrff9R0+hZUUOP/xqxhLjCbUISlONN3Uy
 22PCa40zD4+ponz/qyN+vYpxYN999k6qwd1yM0OFdS0rycrCdsPql8bYQbHr2litE8
 Rnd0O//JqK6Bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 25/52] iommu/amd: Fix performance counter
 initialization
Date: Tue,  2 Mar 2021 06:55:06 -0500
Message-Id: <20210302115534.61800-25-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302115534.61800-1-sashal@kernel.org>
References: <20210302115534.61800-1-sashal@kernel.org>
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
index 83d8ab2aed9f..01da76dc1caa 100644
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
 
@@ -1712,13 +1715,11 @@ static int __init init_iommu_all(struct acpi_table_header *table)
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
@@ -1726,17 +1727,39 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
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
