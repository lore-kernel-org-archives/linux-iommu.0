Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64019C433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 03:40:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B78206FA
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 03:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B78206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 223D485F57;
	Tue,  1 Sep 2020 03:40:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UtLmc4AAT1DB; Tue,  1 Sep 2020 03:40:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D3E9085F51;
	Tue,  1 Sep 2020 03:40:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE46DC088B;
	Tue,  1 Sep 2020 03:40:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF6A7C0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ACC6B86FBB
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:40:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YMKRsTu9RXRF for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 03:40:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2645C8643B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:40:22 +0000 (UTC)
IronPort-SDR: Xn4IHsxEqZQKdVGZwHH7lNtjYVWh2D7HT9EOQxBjwgVEHmR9ssw9/i1hdaoi7mspQzdCZhAOE7
 VU4xiceCe5OQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="144843780"
X-IronPort-AV: E=Sophos;i="5.76,377,1592895600"; d="scan'208";a="144843780"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 20:40:21 -0700
IronPort-SDR: GQichjadeDgA+cvpAMfatx8HlghFYqypH/WWjRXZn6/BKY9ghVHsDuzl6QfGB0EsDySntIbQPV
 ME+MvPKTBC+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,377,1592895600"; d="scan'208";a="325180898"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2020 20:40:19 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v4 4/5] vfio/type1: Use iommu_aux_at(de)tach_group() APIs
Date: Tue,  1 Sep 2020 11:34:21 +0800
Message-Id: <20200901033422.22249-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901033422.22249-1-baolu.lu@linux.intel.com>
References: <20200901033422.22249-1-baolu.lu@linux.intel.com>
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

Replace iommu_aux_at(de)tach_device() with iommu_at(de)tach_subdev_group().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 43 +++++----------------------------
 1 file changed, 6 insertions(+), 37 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5e556ac9102a..8d5eb7ce0986 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1627,45 +1627,13 @@ static struct device *vfio_mdev_get_iommu_device(struct device *dev)
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
+		return iommu_attach_subdev_group(domain->domain,
+						 group->iommu_group,
+						 vfio_mdev_get_iommu_device);
 	else
 		return iommu_attach_group(domain->domain, group->iommu_group);
 }
@@ -1674,8 +1642,9 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
 				    struct vfio_group *group)
 {
 	if (group->mdev_group)
-		iommu_group_for_each_dev(group->iommu_group, domain->domain,
-					 vfio_mdev_detach_domain);
+		iommu_detach_subdev_group(domain->domain,
+					  group->iommu_group,
+					  vfio_mdev_get_iommu_device);
 	else
 		iommu_detach_group(domain->domain, group->iommu_group);
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
