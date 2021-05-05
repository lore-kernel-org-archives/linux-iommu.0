Return-Path: <SRS0=LdVQ=KA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9834BC433ED
	for <iommu@archiver.kernel.org>; Wed,  5 May 2021 16:39:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C11619AF
	for <iommu@archiver.kernel.org>; Wed,  5 May 2021 16:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C11619AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACAF88355C;
	Wed,  5 May 2021 16:39:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dTd79fZ8QUqC; Wed,  5 May 2021 16:39:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 681D6838B6;
	Wed,  5 May 2021 16:39:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46299C000D;
	Wed,  5 May 2021 16:39:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30C38C0024
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 16:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0CC2940445
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 16:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id epcaIeBmpnQh for <iommu@lists.linux-foundation.org>;
 Wed,  5 May 2021 16:39:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B9F8840411
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 16:39:33 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31F8A619A4;
 Wed,  5 May 2021 16:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620232773;
 bh=ljpqIVKiHbJo/PLt8SWRlqsfImtXPYOLTR7zHuMruQE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KlTBO0+gJ5peThq+tQmzpfkMsWmq10UE/TVpZskXW0/f+LXwRCCBhjT0drJ0WV9Hx
 qdQtD1D3/JcYjyGiCsmm1BNT/jFZWkBRSt7YAwKAtdN5qAA+AbPLk+GJ7MqJxFXxSO
 2v6SY3FALH7SY2P5J1NsUWJ/sSVpkKNLYKiPtj7QZxUQIFhfeFmJFwSWo1y6HKso0g
 YtfeL6fMD/CFQO8m5WKAlhp1rmnTGbTgteJ0v9NGYodcErBJ0P7rH2V98DJ7fEFnfm
 qgFvPcuhAGhdFMQFlEVa4669GKjyu8lLYX+RdyYOHU8nOKjcFh6op0+albhcu7wGgV
 +qYgiYXGvyRMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 25/46] iommu/amd: Remove performance counter
 pre-initialization test
Date: Wed,  5 May 2021 12:38:35 -0400
Message-Id: <20210505163856.3463279-25-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163856.3463279-1-sashal@kernel.org>
References: <20210505163856.3463279-1-sashal@kernel.org>
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

[ Upstream commit 994d6608efe4a4c8834bdc5014c86f4bc6aceea6 ]

In early AMD desktop/mobile platforms (during 2013), when the IOMMU
Performance Counter (PMC) support was first introduced in
commit 30861ddc9cca ("perf/x86/amd: Add IOMMU Performance Counter
resource management"), there was a HW bug where the counters could not
be accessed. The result was reading of the counter always return zero.

At the time, the suggested workaround was to add a test logic prior
to initializing the PMC feature to check if the counters can be programmed
and read back the same value. This has been working fine until the more
recent desktop/mobile platforms start enabling power gating for the PMC,
which prevents access to the counters. This results in the PMC support
being disabled unnecesarily.

Unfortunatly, there is no documentation of since which generation
of hardware the original PMC HW bug was fixed. Although, it was fixed
soon after the first introduction of the PMC. Base on this, we assume
that the buggy platforms are less likely to be in used, and it should
be relatively safe to remove this legacy logic.

Link: https://lore.kernel.org/linux-iommu/alpine.LNX.3.20.13.2006030935570.3181@monopod.intra.ispras.ru/
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201753
Cc: Tj (Elloe Linux) <ml.linux@elloe.vision>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Alexander Monakov <amonakov@ispras.ru>
Cc: David Coe <david.coe@live.co.uk>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Tested-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/r/20210409085848.3908-3-suravee.suthikulpanit@amd.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu_init.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 31d7e2d4f304..692401e941a7 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1672,33 +1672,16 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	return 0;
 }
 
-static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
-				u8 fxn, u64 *value, bool is_write);
-
 static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
+	u64 val;
 	struct pci_dev *pdev = iommu->dev;
-	u64 val = 0xabcd, val2 = 0, save_reg = 0;
 
 	if (!iommu_feature(iommu, FEATURE_PC))
 		return;
 
 	amd_iommu_pc_present = true;
 
-	/* save the value to restore, if writable */
-	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
-		goto pc_false;
-
-	/* Check if the performance counters can be written to */
-	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
-	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
-	    (val != val2))
-		goto pc_false;
-
-	/* restore */
-	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
-		goto pc_false;
-
 	pci_info(pdev, "IOMMU performance counters supported\n");
 
 	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
@@ -1706,11 +1689,6 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	iommu->max_counters = (u8) ((val >> 7) & 0xf);
 
 	return;
-
-pc_false:
-	pci_err(pdev, "Unable to read/write to IOMMU perf counter.\n");
-	amd_iommu_pc_present = false;
-	return;
 }
 
 static ssize_t amd_iommu_show_cap(struct device *dev,
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
