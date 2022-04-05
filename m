Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C3EC433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 14:11:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F355B40217;
	Tue,  5 Apr 2022 14:11:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qsx0JVSC3JpQ; Tue,  5 Apr 2022 14:11:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EED144017A;
	Tue,  5 Apr 2022 14:11:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6920C001D;
	Tue,  5 Apr 2022 14:11:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68E80C0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 14:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65A9960E15
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 14:11:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WJUWuaSQ1KCe for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 14:11:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABED660BA4
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 14:11:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F15B323A;
 Tue,  5 Apr 2022 07:11:22 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 441513F5A1;
 Tue,  5 Apr 2022 07:11:22 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: liviu.dudau@arm.com,
	brian.starkey@arm.com
Subject: [PATCH] drm/arm/malidp: Stop using iommu_present()
Date: Tue,  5 Apr 2022 15:11:18 +0100
Message-Id: <5049994e6c2ba92c2f30d51850c8929136d0f8ca.1649167878.git.robin.murphy@arm.com>
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

iommu_get_domain_for_dev() is already perfectly happy to return NULL
if the given device has no IOMMU. Drop the unnecessary check.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/gpu/drm/arm/malidp_planes.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 0562bdaac00c..81d9f5004025 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -310,17 +310,13 @@ static int malidp_se_check_scaling(struct malidp_plane *mp,
 
 static u32 malidp_get_pgsize_bitmap(struct malidp_plane *mp)
 {
-	u32 pgsize_bitmap = 0;
+	struct iommu_domain *mmu_dom;
 
-	if (iommu_present(&platform_bus_type)) {
-		struct iommu_domain *mmu_dom =
-			iommu_get_domain_for_dev(mp->base.dev->dev);
+	mmu_dom = iommu_get_domain_for_dev(mp->base.dev->dev);
+	if (mmu_dom)
+		return mmu_dom->pgsize_bitmap;
 
-		if (mmu_dom)
-			pgsize_bitmap = mmu_dom->pgsize_bitmap;
-	}
-
-	return pgsize_bitmap;
+	return 0;
 }
 
 /*
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
