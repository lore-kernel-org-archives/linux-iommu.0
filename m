Return-Path: <SRS0=TTgE=JT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED71FC433B4
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 13:07:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6DE61426
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 13:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6DE61426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05F3783D6B;
	Thu, 22 Apr 2021 13:07:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U8dcN9zFskzV; Thu, 22 Apr 2021 13:07:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D490783CE5;
	Thu, 22 Apr 2021 13:07:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2260C000E;
	Thu, 22 Apr 2021 13:07:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47D22C000B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 13:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2ED7083DB1
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 13:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Osy2uVD7s_Sl for <iommu@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 13:07:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8554C83CE5
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 13:07:20 +0000 (UTC)
Received: from cap.home.8bytes.org (p5b0069de.dip0.t-ipconnect.de
 [91.0.105.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id C04D3133;
 Thu, 22 Apr 2021 15:07:15 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/amd: Add amd_iommu=force_enable option
Date: Thu, 22 Apr 2021 15:07:01 +0200
Message-Id: <20210422130701.29872-1-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: Joerg Roedel <jroedel@suse.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexander.deucher@amd.com,
 d1nuc0m@protonmail.com, Will Deacon <will@kernel.org>
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

From: Joerg Roedel <jroedel@suse.de>

Add this option to enable the IOMMU on platforms like AMD Stoney,
where the kernel usually disables it because it may cause problems in
some scenarios.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 drivers/iommu/amd/init.c                        | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..c9573f726707 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -303,6 +303,9 @@
 					  allowed anymore to lift isolation
 					  requirements as needed. This option
 					  does not override iommu=pt
+			force_enable - Force enable the IOMMU on platforms known
+				       to be buggy with IOMMU enabled. Use this
+				       option with care.
 
 	amd_iommu_dump=	[HW,X86-64]
 			Enable AMD IOMMU driver option to dump the ACPI table
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 321f5906e6ed..3e2295d3b3e2 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -155,6 +155,7 @@ static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
 static bool amd_iommu_detected;
 static bool __initdata amd_iommu_disabled;
+static bool __initdata amd_iommu_force_enable;
 static int amd_iommu_target_ivhd_type;
 
 u16 amd_iommu_last_bdf;			/* largest PCI device id we have
@@ -2882,6 +2883,9 @@ static bool detect_ivrs(void)
 
 	acpi_put_table(ivrs_base);
 
+	if (amd_iommu_force_enable)
+		goto out;
+
 	/* Don't use IOMMU if there is Stoney Ridge graphics */
 	for (i = 0; i < 32; i++) {
 		u32 pci_id;
@@ -2893,6 +2897,7 @@ static bool detect_ivrs(void)
 		}
 	}
 
+out:
 	/* Make sure ACS will be enabled during PCI probe */
 	pci_request_acs();
 
@@ -3148,6 +3153,8 @@ static int __init parse_amd_iommu_options(char *str)
 	for (; *str; ++str) {
 		if (strncmp(str, "fullflush", 9) == 0)
 			amd_iommu_unmap_flush = true;
+		if (strncmp(str, "force_enable", 12) == 0)
+			amd_iommu_force_enable = true;
 		if (strncmp(str, "off", 3) == 0)
 			amd_iommu_disabled = true;
 		if (strncmp(str, "force_isolation", 15) == 0)
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
