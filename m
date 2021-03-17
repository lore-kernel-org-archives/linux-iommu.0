Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E978BC433E6
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 09:10:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BA164EF3
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 09:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BA164EF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 361F5431FB;
	Wed, 17 Mar 2021 09:10:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j7yaFD7ZL88F; Wed, 17 Mar 2021 09:10:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1DEB642C27;
	Wed, 17 Mar 2021 09:10:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3362C0015;
	Wed, 17 Mar 2021 09:10:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 165FCC0001
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 09:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E795D6F4F9
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 09:10:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nD3_RgAoALt5 for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 09:10:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C14F1605B7
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 09:10:46 +0000 (UTC)
Received: from cap.home.8bytes.org (p549adcf6.dip0.t-ipconnect.de
 [84.154.220.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 27EBE3A4;
 Wed, 17 Mar 2021 10:10:42 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/3] iommu/amd: Move Stoney Ridge check to detect_ivrs()
Date: Wed, 17 Mar 2021 10:10:35 +0100
Message-Id: <20210317091037.31374-2-joro@8bytes.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317091037.31374-1-joro@8bytes.org>
References: <20210317091037.31374-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: Joerg Roedel <jroedel@suse.de>, Xiaojian Du <xiaojian.du@amd.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 David Woodhouse <dwmw2@infradead.org>
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

The AMD IOMMU will not be enabled on AMD Stoney Ridge systems. Bail
out even earlier and refuse to even detect the IOMMU there.

References: https://bugzilla.kernel.org/show_bug.cgi?id=212133
References: https://bugzilla.suse.com/show_bug.cgi?id=1183132
Cc: stable@vger.kernel.org # v5.11
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/init.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9126efcbaf2c..3280e6f5b720 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2714,7 +2714,6 @@ static int __init early_amd_iommu_init(void)
 	struct acpi_table_header *ivrs_base;
 	int i, remap_cache_sz, ret;
 	acpi_status status;
-	u32 pci_id;
 
 	if (!amd_iommu_detected)
 		return -ENODEV;
@@ -2804,16 +2803,6 @@ static int __init early_amd_iommu_init(void)
 	if (ret)
 		goto out;
 
-	/* Disable IOMMU if there's Stoney Ridge graphics */
-	for (i = 0; i < 32; i++) {
-		pci_id = read_pci_config(0, i, 0, 0);
-		if ((pci_id & 0xffff) == 0x1002 && (pci_id >> 16) == 0x98e4) {
-			pr_info("Disable IOMMU on Stoney Ridge\n");
-			amd_iommu_disabled = true;
-			break;
-		}
-	}
-
 	/* Disable any previously enabled IOMMUs */
 	if (!is_kdump_kernel() || amd_iommu_disabled)
 		disable_iommus();
@@ -2880,6 +2869,7 @@ static bool detect_ivrs(void)
 {
 	struct acpi_table_header *ivrs_base;
 	acpi_status status;
+	int i;
 
 	status = acpi_get_table("IVRS", 0, &ivrs_base);
 	if (status == AE_NOT_FOUND)
@@ -2892,6 +2882,17 @@ static bool detect_ivrs(void)
 
 	acpi_put_table(ivrs_base);
 
+	/* Don't use IOMMU if there is Stoney Ridge graphics */
+	for (i = 0; i < 32; i++) {
+		u32 pci_id;
+
+		pci_id = read_pci_config(0, i, 0, 0);
+		if ((pci_id & 0xffff) == 0x1002 && (pci_id >> 16) == 0x98e4) {
+			pr_info("Disable IOMMU on Stoney Ridge\n");
+			return false;
+		}
+	}
+
 	/* Make sure ACS will be enabled during PCI probe */
 	pci_request_acs();
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
