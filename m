Return-Path: <SRS0=99fx=3M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D3DC33CAA
	for <iommu@archiver.kernel.org>; Thu, 23 Jan 2020 22:32:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C64E21734
	for <iommu@archiver.kernel.org>; Thu, 23 Jan 2020 22:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JPtl/BXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C64E21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1212B883C1;
	Thu, 23 Jan 2020 22:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Of6C+QiHHruQ; Thu, 23 Jan 2020 22:32:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 43725883E0;
	Thu, 23 Jan 2020 22:32:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F349C0176;
	Thu, 23 Jan 2020 22:32:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90B23C0174
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jan 2020 22:32:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 77DA822650
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jan 2020 22:32:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9+IurnS1xCnj for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jan 2020 22:32:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com
 [209.85.166.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 5195422613
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jan 2020 22:32:17 +0000 (UTC)
Received: by mail-il1-f195.google.com with SMTP id t17so136015ilm.13
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jan 2020 14:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L7Z0MQLgFpVUqRMkpIW9BsJ/F7zZnMMX5vKIMOIOUGo=;
 b=JPtl/BXYDpF1WbyX3AFyai/TuIIICFzkw2YEVeL9iEiDTCopZDplYRtiYVhVJRlCXP
 sIv/mBcCxDR4iebP3GSRqf8FL/+ZJlFKIgafnRYwSDJdKS+J+xBxa1m9h/GdtOkYAidM
 2FelKQjhC9UjUH7sPHn2sd2t3b8ghc75wJivU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L7Z0MQLgFpVUqRMkpIW9BsJ/F7zZnMMX5vKIMOIOUGo=;
 b=R58c+vfkfgHpOnXKl1nWA16GFWggRH1g85bfsVbzVFtDZ/yzH1VPNLW0x+HVu4Mfxp
 N+vUZwoFmWbDWVwzam4Jiucqo3NbSt6C5l8XfPAASkx1gZ8NivJj7h6dUYU3QzCKNG7H
 JWpewhpZ14HBYtMlW6FMeVM3SJE1arHURpxve212UPBp74eFhp7pLz0jPX/q2DbptY5V
 dcJYcfp7ijtrmLoSQneYPnORpMABNUI5TNrJhD4OnCd8HfB7rtSvKoubn3ZnFCBBopH7
 AcQ5n+p3Qvr/9LNCSNyDfAXPM4HQi7VwfgOnSFsSTo0MQO1Mcm3ZfPuPlCzyzFGmuv2d
 /rIA==
X-Gm-Message-State: APjAAAWZc+UhtRKGCey2mZ/SQmFbOSYKWepGWK8+jg2wrQBBAlA2ESYP
 Rpib/nJG26jp+PUAl2ABtijyCzbA
X-Google-Smtp-Source: APXvYqxIuGjlwsK0WON45gzxdSefs72kcw1Dv0XZbxXn2BlLfgH1D4+eYrs9Jh4lr0Mn1phz0S3vlg==
X-Received: by 2002:a92:85c1:: with SMTP id f184mr434426ilh.221.1579818736563; 
 Thu, 23 Jan 2020 14:32:16 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id f4sm716943ioh.45.2020.01.23.14.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 14:32:16 -0800 (PST)
From: Shuah Khan <skhan@linuxfoundation.org>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Subject: [PATCH v2] iommu: amd: Fix IOMMU perf counter clobbering during init
Date: Thu, 23 Jan 2020 15:32:14 -0700
Message-Id: <20200123223214.2566-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
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

init_iommu_perf_ctr() clobbers the register when it checks write access
to IOMMU perf counters and fails to restore when they are writable.

Add save and restore to fix it.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes since v1:
-- Fix bug in sucessful return path. Add a return instead of
   fall through to pc_false error case

 drivers/iommu/amd_iommu_init.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 568c52317757..483f7bc379fa 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1655,27 +1655,39 @@ static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
 	struct pci_dev *pdev = iommu->dev;
-	u64 val = 0xabcd, val2 = 0;
+	u64 val = 0xabcd, val2 = 0, save_reg = 0;
 
 	if (!iommu_feature(iommu, FEATURE_PC))
 		return;
 
 	amd_iommu_pc_present = true;
 
+	/* save the value to restore, if writable */
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
+		goto pc_false;
+
 	/* Check if the performance counters can be written to */
 	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
 	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
-	    (val != val2)) {
-		pci_err(pdev, "Unable to write to IOMMU perf counter.\n");
-		amd_iommu_pc_present = false;
-		return;
-	}
+	    (val != val2))
+		goto pc_false;
+
+	/* restore */
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
+		goto pc_false;
 
 	pci_info(pdev, "IOMMU performance counters supported\n");
 
 	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
 	iommu->max_banks = (u8) ((val >> 12) & 0x3f);
 	iommu->max_counters = (u8) ((val >> 7) & 0xf);
+
+	return;
+
+pc_false:
+	pci_err(pdev, "Unable to read/write to IOMMU perf counter.\n");
+	amd_iommu_pc_present = false;
+	return;
 }
 
 static ssize_t amd_iommu_show_cap(struct device *dev,
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
