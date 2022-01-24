Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A9FC433EF
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 07:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 671B560AE2;
	Mon, 24 Jan 2022 07:12:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0IPHWHDwQY-n; Mon, 24 Jan 2022 07:12:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3E82C607A1;
	Mon, 24 Jan 2022 07:12:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 180F1C0031;
	Mon, 24 Jan 2022 07:12:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CCCBC002F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 07:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF8B7400F1
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 07:12:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8CCKMy4BTLlt for <iommu@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 07:12:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2A0E40116
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 07:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643008368; x=1674544368;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5TBZFsenuHwIPheekH0b3CEaehnEyJPuQXeOFXtZL/A=;
 b=Qua3FFugymkg9t+lRdVR2SLIbRR33iAz6XHlNbZJc6YUGnndXPaGtwzB
 icXWqCaNQACWd3sNF0ZzIGJD/hHjmic2bnv/G7fg1PLbUpB3C8mPIbbCi
 rgsJoRdjAC3FTZfTmOzOcSDrsUO6HlQiIfORqL5eI0sxOnnYth/8THAwZ
 UuocMtYo6EKXV/NcgZ4y/FH1D2A4R9/s7FPBbwhiOAXqI7GjOvoTlBYuE
 m/RFq7bI3buN4j0Lik7symWw1+GDaP5QdnaCEbD6bAWTfSUGop1q2BO/4
 ojNIDmP4IsSxuthAZ6me/bIfTH15+IT7BFHeNuQgy/9OBWTe8a0SXprVf A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245925946"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; d="scan'208";a="245925946"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2022 23:12:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; d="scan'208";a="627387804"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga004.jf.intel.com with ESMTP; 23 Jan 2022 23:12:43 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 5/7] drm/nouveau/device: Get right pgsize_bitmap of
 iommu_domain
Date: Mon, 24 Jan 2022 15:11:00 +0800
Message-Id: <20220124071103.2097118-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

The supported page sizes of an iommu_domain are saved in the pgsize_bitmap
field. Retrieve the value from the right place.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/20211218074546.1772553-1-baolu.lu@linux.intel.com
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
index d0d52c1d4aee..992cc285f2fe 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
@@ -133,7 +133,7 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *tdev)
 		 * or equal to the system's PAGE_SIZE, with a preference if
 		 * both are equal.
 		 */
-		pgsize_bitmap = tdev->iommu.domain->ops->pgsize_bitmap;
+		pgsize_bitmap = tdev->iommu.domain->pgsize_bitmap;
 		if (pgsize_bitmap & PAGE_SIZE) {
 			tdev->iommu.pgshift = PAGE_SHIFT;
 		} else {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
