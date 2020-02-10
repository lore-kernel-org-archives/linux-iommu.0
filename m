Return-Path: <SRS0=xjv2=36=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49198C352A4
	for <iommu@archiver.kernel.org>; Mon, 10 Feb 2020 07:51:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A1E20733
	for <iommu@archiver.kernel.org>; Mon, 10 Feb 2020 07:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A1E20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D0DFE84543;
	Mon, 10 Feb 2020 07:51:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id txfs8Ab4oS37; Mon, 10 Feb 2020 07:51:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3A326844C0;
	Mon, 10 Feb 2020 07:51:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27209C1796;
	Mon, 10 Feb 2020 07:51:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A1A8C0171
 for <iommu@lists.linux-foundation.org>; Mon, 10 Feb 2020 07:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 033B785EA5
 for <iommu@lists.linux-foundation.org>; Mon, 10 Feb 2020 07:51:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C3lKFtV5syRr for <iommu@lists.linux-foundation.org>;
 Mon, 10 Feb 2020 07:51:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BB8BA85E0D
 for <iommu@lists.linux-foundation.org>; Mon, 10 Feb 2020 07:51:25 +0000 (UTC)
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1j13qk-0008DR-0d; Mon, 10 Feb 2020 07:51:22 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: joro@8bytes.org
Subject: [PATCH v3] iommu/amd: Disable IOMMU on Stoney Ridge systems
Date: Mon, 10 Feb 2020 15:51:15 +0800
Message-Id: <20200210075115.14838-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "open list:AMD IOMMU AMD-VI" <iommu@lists.linux-foundation.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 open list <linux-kernel@vger.kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Serious screen flickering when Stoney Ridge outputs to a 4K monitor.

Use identity-mapping and PCI ATS doesn't help this issue.

According to Alex Deucher, IOMMU isn't enabled on Windows, so let's do
the same here to avoid screen flickering on 4K monitor.

Cc: Alex Deucher <alexander.deucher@amd.com>
Bug: https://gitlab.freedesktop.org/drm/amd/issues/961
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - Update commit message to mention identity-mapping and ATS don't help.

v2:
 - Find Stoney graphics instead of host bridge.

 drivers/iommu/amd_iommu_init.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 2759a8d57b7f..6be3853a5d97 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2523,6 +2523,7 @@ static int __init early_amd_iommu_init(void)
 	struct acpi_table_header *ivrs_base;
 	acpi_status status;
 	int i, remap_cache_sz, ret = 0;
+	u32 pci_id;
 
 	if (!amd_iommu_detected)
 		return -ENODEV;
@@ -2610,6 +2611,16 @@ static int __init early_amd_iommu_init(void)
 	if (ret)
 		goto out;
 
+	/* Disable IOMMU if there's Stoney Ridge graphics */
+	for (i = 0; i < 32; i++) {
+		pci_id = read_pci_config(0, i, 0, 0);
+		if ((pci_id & 0xffff) == 0x1002 && (pci_id >> 16) == 0x98e4) {
+			pr_info("Disable IOMMU on Stoney Ridge\n");
+			amd_iommu_disabled = true;
+			break;
+		}
+	}
+
 	/* Disable any previously enabled IOMMUs */
 	if (!is_kdump_kernel() || amd_iommu_disabled)
 		disable_iommus();
@@ -2718,7 +2729,7 @@ static int __init state_next(void)
 		ret = early_amd_iommu_init();
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
 		if (init_state == IOMMU_ACPI_FINISHED && amd_iommu_disabled) {
-			pr_info("AMD IOMMU disabled on kernel command-line\n");
+			pr_info("AMD IOMMU disabled\n");
 			init_state = IOMMU_CMDLINE_DISABLED;
 			ret = -EINVAL;
 		}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
