Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BEFC433FE
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:34:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C0C161A51
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C0C161A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 709838443D;
	Fri,  1 Oct 2021 14:34:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MAayiH82u-3u; Fri,  1 Oct 2021 14:34:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 54431843E1;
	Fri,  1 Oct 2021 14:34:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB562C000D;
	Fri,  1 Oct 2021 14:34:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16DB1C0011
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 14:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A5E5843FD
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 14:34:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DVuqeug1flma for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 14:34:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C682B843E1
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C38461F457AD;
 Fri,  1 Oct 2021 15:34:35 +0100 (BST)
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/5] drm/panfrost: Add a PANFROST_BO_GPUONLY flag
Date: Fri,  1 Oct 2021 16:34:26 +0200
Message-Id: <20211001143427.1564786-5-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001143427.1564786-1-boris.brezillon@collabora.com>
References: <20211001143427.1564786-1-boris.brezillon@collabora.com>
MIME-Version: 1.0
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org
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

This lets the driver reduce shareability domain of the MMU mapping,
which can in turn reduce access time and save power on cache-coherent
systems.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 3 ++-
 drivers/gpu/drm/panfrost/panfrost_gem.c | 1 +
 drivers/gpu/drm/panfrost/panfrost_gem.h | 1 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 3 +++
 include/uapi/drm/panfrost_drm.h         | 1 +
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index b29ac942ae2d..b176921b9392 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -77,7 +77,8 @@ static int panfrost_ioctl_get_param(struct drm_device *ddev, void *data, struct
 
 #define PANFROST_BO_FLAGS \
 	(PANFROST_BO_NOEXEC | PANFROST_BO_HEAP | \
-	 PANFROST_BO_NOREAD | PANFROST_BO_NOWRITE)
+	 PANFROST_BO_NOREAD | PANFROST_BO_NOWRITE | \
+	 PANFROST_BO_GPUONLY)
 
 static int panfrost_ioctl_create_bo(struct drm_device *dev, void *data,
 		struct drm_file *file)
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index d6c1bb1445f2..4b1f85c0b98f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -254,6 +254,7 @@ panfrost_gem_create_with_handle(struct drm_file *file_priv,
 	bo->noread = !!(flags & PANFROST_BO_NOREAD);
 	bo->nowrite = !!(flags & PANFROST_BO_NOWRITE);
 	bo->is_heap = !!(flags & PANFROST_BO_HEAP);
+	bo->gpuonly = !!(flags & PANFROST_BO_GPUONLY);
 
 	/*
 	 * Allocate an id of idr table where the obj is registered
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/panfrost/panfrost_gem.h
index 6246b5fef446..e332d5a4c24f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.h
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
@@ -40,6 +40,7 @@ struct panfrost_gem_object {
 	bool noread		:1;
 	bool nowrite		:1;
 	bool is_heap		:1;
+	bool gpuonly		:1;
 };
 
 struct panfrost_gem_mapping {
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 6a5c9d94d6f2..89eee8e80aa5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -321,6 +321,9 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 	if (!bo->noread)
 		prot |= IOMMU_READ;
 
+	if (bo->gpuonly)
+		prot |= IOMMU_DEVONLY;
+
 	sgt = drm_gem_shmem_get_pages_sgt(obj);
 	if (WARN_ON(IS_ERR(sgt)))
 		return PTR_ERR(sgt);
diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
index a2de81225125..538b58b2d095 100644
--- a/include/uapi/drm/panfrost_drm.h
+++ b/include/uapi/drm/panfrost_drm.h
@@ -88,6 +88,7 @@ struct drm_panfrost_wait_bo {
 #define PANFROST_BO_HEAP	2
 #define PANFROST_BO_NOREAD	4
 #define PANFROST_BO_NOWRITE	8
+#define PANFROST_BO_GPUONLY	0x10
 
 /**
  * struct drm_panfrost_create_bo - ioctl argument for creating Panfrost BOs.
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
