Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9203FC47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 13:02:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256C8613BF
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 13:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256C8613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E086A4010E;
	Thu,  3 Jun 2021 13:02:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vTYEMvWGIVU1; Thu,  3 Jun 2021 13:02:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4910400ED;
	Thu,  3 Jun 2021 13:02:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A7C7C000D;
	Thu,  3 Jun 2021 13:02:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5709AC0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 13:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A1904056A
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 13:02:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D40G-gbAvs6I for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 13:02:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 207114055F
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 13:02:07 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2ba7c.dip0.t-ipconnect.de
 [79.242.186.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id C711F15C;
 Thu,  3 Jun 2021 15:02:04 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH] iommu/amd: Add amd_iommu=force_enable option
Date: Thu,  3 Jun 2021 15:02:03 +0200
Message-Id: <20210603130203.29016-1-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: Alex Deucher <alexander.deucher@amd.com>, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
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
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 drivers/iommu/amd/init.c                        | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..f6bf4e87df80 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -301,6 +301,9 @@
 					  allowed anymore to lift isolation
 					  requirements as needed. This option
 					  does not override iommu=pt
+			force_enable - Force enable the IOMMU on platforms known
+				       to be buggy with IOMMU enabled. Use this
+				       option with care.
 
 	amd_iommu_dump=	[HW,X86-64]
 			Enable AMD IOMMU driver option to dump the ACPI table
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d006724f4dc2..23614337abef 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -153,7 +153,8 @@ int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
 static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
 static bool amd_iommu_detected;
-static bool __initdata amd_iommu_disabled;
+static bool amd_iommu_disabled __initdata;
+static bool amd_iommu_force_enable __initdata;
 static int amd_iommu_target_ivhd_type;
 
 u16 amd_iommu_last_bdf;			/* largest PCI device id we have
@@ -2834,6 +2835,9 @@ static bool detect_ivrs(void)
 
 	acpi_put_table(ivrs_base);
 
+	if (amd_iommu_force_enable)
+		goto out;
+
 	/* Don't use IOMMU if there is Stoney Ridge graphics */
 	for (i = 0; i < 32; i++) {
 		u32 pci_id;
@@ -2845,6 +2849,7 @@ static bool detect_ivrs(void)
 		}
 	}
 
+out:
 	/* Make sure ACS will be enabled during PCI probe */
 	pci_request_acs();
 
@@ -3100,6 +3105,8 @@ static int __init parse_amd_iommu_options(char *str)
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
