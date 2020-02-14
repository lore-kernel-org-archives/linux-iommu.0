Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04927C35242
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 22:26:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B195A206D7
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 22:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B195A206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8405C88367;
	Fri, 14 Feb 2020 22:26:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H35Zu63pPqY4; Fri, 14 Feb 2020 22:26:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0916C8832D;
	Fri, 14 Feb 2020 22:26:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDB16C08A4;
	Fri, 14 Feb 2020 22:26:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A034C0177
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 22:26:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3210D88363
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 22:26:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ZTl9pPUqXl8 for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 22:26:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3C9F08832D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 22:26:47 +0000 (UTC)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 40D4B20AC81;
 Fri, 14 Feb 2020 23:26:45 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com
 [134.27.49.11])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0388A20AC7D;
 Fri, 14 Feb 2020 23:26:45 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
 by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id
 2B20640A63; Fri, 14 Feb 2020 15:26:44 -0700 (MST)
From: Li Yang <leoyang.li@nxp.com>
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/arm-smmu: fix module name for parameters
Date: Fri, 14 Feb 2020 16:26:27 -0600
Message-Id: <1581719188-8682-1-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 1.9.0
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>
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

Commit cd221bd24ff5 ("iommu/arm-smmu: Allow building as a module")
introduced a side effect that changed the module name from arm-smmu to
arm-smmu-mod.  This breaks the users of kernel parameters for the driver
(e.g. arm-smmu.disable_bypass).  This patch changes the module name for
parameters back to arm-smmu to be consistent with older kernel.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/iommu/arm-smmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 16c4b87af42b..8d5a19bfde5c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -58,6 +58,8 @@
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "arm-smmu."
 static int force_stage;
 module_param(force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
