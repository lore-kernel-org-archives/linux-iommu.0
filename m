Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA74C433EC
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 06:02:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3915A21D93
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 06:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3915A21D93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0BA0224B6B;
	Tue, 14 Jul 2020 06:02:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8hREBHBgzYVs; Tue, 14 Jul 2020 06:02:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0627727D27;
	Tue, 14 Jul 2020 06:02:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2EFCC0888;
	Tue, 14 Jul 2020 06:02:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2E6BC0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 06:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CE9F28A6D4
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 06:02:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j7BRNr3dS3x5 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 06:02:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 494528A6D9
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 06:02:02 +0000 (UTC)
IronPort-SDR: qpZffSFREhW8y5tKkrpRCJ+SIhxasE2unWxpzJYIj48153uEGNjoK9xRE2Zbd1a2qtyPD5DQk0
 8v7yMFSKbWSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="147947594"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="147947594"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 23:02:02 -0700
IronPort-SDR: sROqWG6d4AFrPOSmY+gwkD+CtO1ZhCUGL8UHxl19xBSHuzj7kxFNhObfuFz5vi4aN0TkNYscBU
 i2Wd11r1qm1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="324450220"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2020 23:01:58 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 4/4] vfio/type1: Use iommu_aux_at(de)tach_group() APIs
Date: Tue, 14 Jul 2020 13:57:03 +0800
Message-Id: <20200714055703.5510-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714055703.5510-1-baolu.lu@linux.intel.com>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

Replace iommu_aux_at(de)tach_device() with iommu_aux_at(de)tach_group().
It also saves the IOMMU_DEV_FEAT_AUX-capable physcail device in the
vfio_group data structure so that it could be reused in other places.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 44 ++++++---------------------------
 1 file changed, 7 insertions(+), 37 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5e556ac9102a..f8812e68de77 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -100,6 +100,7 @@ struct vfio_dma {
 struct vfio_group {
 	struct iommu_group	*iommu_group;
 	struct list_head	next;
+	struct device		*iommu_device;
 	bool			mdev_group;	/* An mdev group */
 	bool			pinned_page_dirty_scope;
 };
@@ -1627,45 +1628,13 @@ static struct device *vfio_mdev_get_iommu_device(struct device *dev)
 	return NULL;
 }
 
-static int vfio_mdev_attach_domain(struct device *dev, void *data)
-{
-	struct iommu_domain *domain = data;
-	struct device *iommu_device;
-
-	iommu_device = vfio_mdev_get_iommu_device(dev);
-	if (iommu_device) {
-		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
-			return iommu_aux_attach_device(domain, iommu_device);
-		else
-			return iommu_attach_device(domain, iommu_device);
-	}
-
-	return -EINVAL;
-}
-
-static int vfio_mdev_detach_domain(struct device *dev, void *data)
-{
-	struct iommu_domain *domain = data;
-	struct device *iommu_device;
-
-	iommu_device = vfio_mdev_get_iommu_device(dev);
-	if (iommu_device) {
-		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
-			iommu_aux_detach_device(domain, iommu_device);
-		else
-			iommu_detach_device(domain, iommu_device);
-	}
-
-	return 0;
-}
-
 static int vfio_iommu_attach_group(struct vfio_domain *domain,
 				   struct vfio_group *group)
 {
 	if (group->mdev_group)
-		return iommu_group_for_each_dev(group->iommu_group,
-						domain->domain,
-						vfio_mdev_attach_domain);
+		return iommu_aux_attach_group(domain->domain,
+					      group->iommu_group,
+					      group->iommu_device);
 	else
 		return iommu_attach_group(domain->domain, group->iommu_group);
 }
@@ -1674,8 +1643,8 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
 				    struct vfio_group *group)
 {
 	if (group->mdev_group)
-		iommu_group_for_each_dev(group->iommu_group, domain->domain,
-					 vfio_mdev_detach_domain);
+		iommu_aux_detach_group(domain->domain, group->iommu_group,
+				       group->iommu_device);
 	else
 		iommu_detach_group(domain->domain, group->iommu_group);
 }
@@ -2007,6 +1976,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			return 0;
 		}
 
+		group->iommu_device = iommu_device;
 		bus = iommu_device->bus;
 	}
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
