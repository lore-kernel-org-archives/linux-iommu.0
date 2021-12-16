Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8B5C433F5
	for <iommu@archiver.kernel.org>; Thu, 16 Dec 2021 14:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37F0560FD7;
	Thu, 16 Dec 2021 14:34:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 37Kz1yO9KXQY; Thu, 16 Dec 2021 14:34:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1BCA360FB0;
	Thu, 16 Dec 2021 14:34:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC595C001E;
	Thu, 16 Dec 2021 14:34:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 307CAC0012
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 14:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F3AC83E62
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 14:34:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HgFCq2We_glG for <iommu@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 14:34:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 515DA83E60
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 14:34:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73E1E12FC;
 Thu, 16 Dec 2021 06:34:36 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C2F643F73B;
 Thu, 16 Dec 2021 06:34:35 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: thierry.reding@gmail.com,
	mperttunen@nvidia.com
Subject: [PATCH] drm/tegra: Add missing DMA API includes
Date: Thu, 16 Dec 2021 14:34:32 +0000
Message-Id: <dc81eec74be9064e33247257b1fe439b0f6ec78d.1639664721.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org
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

Include dma-mapping.h directly in the remaining places that touch the
DMA API, to avoid imminent breakage from refactoring other headers.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

This makes arm64 allmodconfig build cleanly for me with the IOVA series,
so hopefully is the last of it...

 drivers/gpu/drm/tegra/dc.c    | 1 +
 drivers/gpu/drm/tegra/hub.c   | 1 +
 drivers/gpu/drm/tegra/plane.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index a29d64f87563..c33420e1fb07 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -7,6 +7,7 @@
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 #include <linux/interconnect.h>
 #include <linux/module.h>
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index b910155f80c4..7d52a403334b 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/host1x.h>
 #include <linux/module.h>
 #include <linux/of.h>
diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index 16a1cdc28657..75db069dd26f 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 #include <linux/interconnect.h>
 
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
