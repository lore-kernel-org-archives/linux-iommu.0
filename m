Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C821C433E2
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 12:09:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA3C20760
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 12:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA3C20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5BFE0887D1;
	Thu, 11 Jun 2020 12:09:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qAyHN7dZB7cq; Thu, 11 Jun 2020 12:09:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3EE3088788;
	Thu, 11 Jun 2020 12:09:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23959C0895;
	Thu, 11 Jun 2020 12:09:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72CB2C0894
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D1FD587A7D
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:09:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BmtkYgvMmf9s for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 12:09:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4D572879F9
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:09:10 +0000 (UTC)
IronPort-SDR: g+yX8Qkmu3XgU3l3xMMbGocTu+/4V/n3yvfTGIlUDQyaVjT9T1wkN+md/ECVbnDroK2ObG0cky
 aRsJyt9KiPGQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2020 05:09:09 -0700
IronPort-SDR: 5cIVrk4qVhZY9UMB6zFu6O9R1R2+oLGGKf67PZW/Yj3+a1SvbxkEgJD6QuMK8ednUJ9ep5AEZA
 LQV6ih69Xk6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; d="scan'208";a="419082467"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 11 Jun 2020 05:09:09 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v2 01/15] vfio/type1: Refactor vfio_iommu_type1_ioctl()
Date: Thu, 11 Jun 2020 05:15:20 -0700
Message-Id: <1591877734-66527-2-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, jun.j.tian@intel.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com, hao.wu@intel.com
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

This patch refactors the vfio_iommu_type1_ioctl() to use switch instead of
if-else, and each cmd got a helper function.

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 183 +++++++++++++++++++++++-----------------
 1 file changed, 105 insertions(+), 78 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index cc1d647..402aad3 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2106,6 +2106,23 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
 	return ret;
 }
 
+static int vfio_iommu_type1_check_extension(struct vfio_iommu *iommu,
+					    unsigned long arg)
+{
+	switch (arg) {
+	case VFIO_TYPE1_IOMMU:
+	case VFIO_TYPE1v2_IOMMU:
+	case VFIO_TYPE1_NESTING_IOMMU:
+		return 1;
+	case VFIO_DMA_CC_IOMMU:
+		if (!iommu)
+			return 0;
+		return vfio_domains_have_iommu_cache(iommu);
+	default:
+		return 0;
+	}
+}
+
 static int vfio_iommu_iova_add_cap(struct vfio_info_cap *caps,
 		 struct vfio_iommu_type1_info_cap_iova_range *cap_iovas,
 		 size_t size)
@@ -2173,110 +2190,120 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
 	return ret;
 }
 
-static long vfio_iommu_type1_ioctl(void *iommu_data,
-				   unsigned int cmd, unsigned long arg)
+static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
+				     unsigned long arg)
 {
-	struct vfio_iommu *iommu = iommu_data;
+	struct vfio_iommu_type1_info info;
 	unsigned long minsz;
+	struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
+	unsigned long capsz;
+	int ret;
 
-	if (cmd == VFIO_CHECK_EXTENSION) {
-		switch (arg) {
-		case VFIO_TYPE1_IOMMU:
-		case VFIO_TYPE1v2_IOMMU:
-		case VFIO_TYPE1_NESTING_IOMMU:
-			return 1;
-		case VFIO_DMA_CC_IOMMU:
-			if (!iommu)
-				return 0;
-			return vfio_domains_have_iommu_cache(iommu);
-		default:
-			return 0;
-		}
-	} else if (cmd == VFIO_IOMMU_GET_INFO) {
-		struct vfio_iommu_type1_info info;
-		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
-		unsigned long capsz;
-		int ret;
-
-		minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
+	minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
 
-		/* For backward compatibility, cannot require this */
-		capsz = offsetofend(struct vfio_iommu_type1_info, cap_offset);
+	/* For backward compatibility, cannot require this */
+	capsz = offsetofend(struct vfio_iommu_type1_info, cap_offset);
 
-		if (copy_from_user(&info, (void __user *)arg, minsz))
-			return -EFAULT;
+	if (copy_from_user(&info, (void __user *)arg, minsz))
+		return -EFAULT;
 
-		if (info.argsz < minsz)
-			return -EINVAL;
+	if (info.argsz < minsz)
+		return -EINVAL;
 
-		if (info.argsz >= capsz) {
-			minsz = capsz;
-			info.cap_offset = 0; /* output, no-recopy necessary */
-		}
+	if (info.argsz >= capsz) {
+		minsz = capsz;
+		info.cap_offset = 0; /* output, no-recopy necessary */
+	}
 
-		info.flags = VFIO_IOMMU_INFO_PGSIZES;
+	info.flags = VFIO_IOMMU_INFO_PGSIZES;
 
-		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
+	info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
 
-		ret = vfio_iommu_iova_build_caps(iommu, &caps);
-		if (ret)
-			return ret;
+	ret = vfio_iommu_iova_build_caps(iommu, &caps);
+	if (ret)
+		return ret;
 
-		if (caps.size) {
-			info.flags |= VFIO_IOMMU_INFO_CAPS;
+	if (caps.size) {
+		info.flags |= VFIO_IOMMU_INFO_CAPS;
 
-			if (info.argsz < sizeof(info) + caps.size) {
-				info.argsz = sizeof(info) + caps.size;
-			} else {
-				vfio_info_cap_shift(&caps, sizeof(info));
-				if (copy_to_user((void __user *)arg +
-						sizeof(info), caps.buf,
-						caps.size)) {
-					kfree(caps.buf);
-					return -EFAULT;
-				}
-				info.cap_offset = sizeof(info);
+		if (info.argsz < sizeof(info) + caps.size) {
+			info.argsz = sizeof(info) + caps.size;
+		} else {
+			vfio_info_cap_shift(&caps, sizeof(info));
+			if (copy_to_user((void __user *)arg +
+					sizeof(info), caps.buf,
+					caps.size)) {
+				kfree(caps.buf);
+				return -EFAULT;
 			}
-
-			kfree(caps.buf);
+			info.cap_offset = sizeof(info);
 		}
 
-		return copy_to_user((void __user *)arg, &info, minsz) ?
-			-EFAULT : 0;
+		kfree(caps.buf);
+	}
 
-	} else if (cmd == VFIO_IOMMU_MAP_DMA) {
-		struct vfio_iommu_type1_dma_map map;
-		uint32_t mask = VFIO_DMA_MAP_FLAG_READ |
-				VFIO_DMA_MAP_FLAG_WRITE;
+	return copy_to_user((void __user *)arg, &info, minsz) ?
+		-EFAULT : 0;
 
-		minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
+}
 
-		if (copy_from_user(&map, (void __user *)arg, minsz))
-			return -EFAULT;
+static int vfio_iommu_type1_map_dma(struct vfio_iommu *iommu,
+				    unsigned long arg)
+{
+	struct vfio_iommu_type1_dma_map map;
+	unsigned long minsz;
+	uint32_t mask = VFIO_DMA_MAP_FLAG_READ |
+			VFIO_DMA_MAP_FLAG_WRITE;
 
-		if (map.argsz < minsz || map.flags & ~mask)
-			return -EINVAL;
+	minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
 
-		return vfio_dma_do_map(iommu, &map);
+	if (copy_from_user(&map, (void __user *)arg, minsz))
+		return -EFAULT;
 
-	} else if (cmd == VFIO_IOMMU_UNMAP_DMA) {
-		struct vfio_iommu_type1_dma_unmap unmap;
-		long ret;
+	if (map.argsz < minsz || map.flags & ~mask)
+		return -EINVAL;
 
-		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
+	return vfio_dma_do_map(iommu, &map);
+}
 
-		if (copy_from_user(&unmap, (void __user *)arg, minsz))
-			return -EFAULT;
+static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
+				    unsigned long arg)
+{
+	struct vfio_iommu_type1_dma_unmap unmap;
+	unsigned long minsz;
+	long ret;
 
-		if (unmap.argsz < minsz || unmap.flags)
-			return -EINVAL;
+	minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
 
-		ret = vfio_dma_do_unmap(iommu, &unmap);
-		if (ret)
-			return ret;
+	if (copy_from_user(&unmap, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (unmap.argsz < minsz || unmap.flags)
+		return -EINVAL;
+
+	ret = vfio_dma_do_unmap(iommu, &unmap);
+	if (ret)
+		return ret;
+
+	return copy_to_user((void __user *)arg, &unmap, minsz) ?
+		-EFAULT : 0;
+
+}
+
+static long vfio_iommu_type1_ioctl(void *iommu_data,
+				   unsigned int cmd, unsigned long arg)
+{
+	struct vfio_iommu *iommu = iommu_data;
 
-		return copy_to_user((void __user *)arg, &unmap, minsz) ?
-			-EFAULT : 0;
+	switch (cmd) {
+	case VFIO_CHECK_EXTENSION:
+		return vfio_iommu_type1_check_extension(iommu, arg);
+	case VFIO_IOMMU_GET_INFO:
+		return vfio_iommu_type1_get_info(iommu, arg);
+	case VFIO_IOMMU_MAP_DMA:
+		return vfio_iommu_type1_map_dma(iommu, arg);
+	case VFIO_IOMMU_UNMAP_DMA:
+		return vfio_iommu_type1_unmap_dma(iommu, arg);
 	}
 
 	return -ENOTTY;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
