Return-Path: <SRS0=8AL1=AI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3E5C433E2
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 03:19:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A80720675
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 03:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A80720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EFDF388278;
	Sat, 27 Jun 2020 03:19:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hpVZofkV4Ljt; Sat, 27 Jun 2020 03:19:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3BDA888270;
	Sat, 27 Jun 2020 03:19:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28100C088C;
	Sat, 27 Jun 2020 03:19:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB03BC016F
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 03:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DA8E0882A1
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 03:19:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JXjLZ7w8Ev7e for <iommu@lists.linux-foundation.org>;
 Sat, 27 Jun 2020 03:19:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5CF408829A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 03:19:50 +0000 (UTC)
IronPort-SDR: arcRiemtZY+I5EqiO63kStOOeoKacJ5mAuuV1+RDnfjkWzDxvODDWW7GLUqwGFgdvJZTYsbdVV
 1P7N5bpheWUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="143799291"
X-IronPort-AV: E=Sophos;i="5.75,286,1589266800"; d="scan'208";a="143799291"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 20:19:50 -0700
IronPort-SDR: 0E5d9pkgpFPRPa4yVX8lXuv/vsuhWX6VqXWOQVY/cxH2FDKdDT6F/nBQVxfQY0fxYBz5zeYwGq
 splzo1hyqcMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,286,1589266800"; d="scan'208";a="302510433"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 26 Jun 2020 20:19:47 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 2/2] vfio/type1: Update group->domain after aux attach and
 detach
Date: Sat, 27 Jun 2020 11:15:32 +0800
Message-Id: <20200627031532.28046-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200627031532.28046-1-baolu.lu@linux.intel.com>
References: <20200627031532.28046-1-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

Update group->domain whenever an aux-domain is attached to or detached
from a mediated device. Without this change, iommu_get_domain_for_dev()
will be broken for mdev devices.

Fixes: 7bd50f0cd2fd5 ("vfio/type1: Add domain at(de)taching group helpers")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 37 ++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5e556ac9102a..e0d8802ce0c9 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1634,10 +1634,28 @@ static int vfio_mdev_attach_domain(struct device *dev, void *data)
 
 	iommu_device = vfio_mdev_get_iommu_device(dev);
 	if (iommu_device) {
-		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
-			return iommu_aux_attach_device(domain, iommu_device);
-		else
+		if (iommu_dev_feature_enabled(iommu_device,
+					      IOMMU_DEV_FEAT_AUX)) {
+			struct iommu_group *group = iommu_group_get(dev);
+			int ret;
+
+			if (!group)
+				return -EINVAL;
+
+			if (iommu_group_get_domain(group)) {
+				iommu_group_put(group);
+				return -EBUSY;
+			}
+
+			ret = iommu_aux_attach_device(domain, iommu_device);
+			if (!ret)
+				iommu_group_set_domain(group, domain);
+
+			iommu_group_put(group);
+			return ret;
+		} else {
 			return iommu_attach_device(domain, iommu_device);
+		}
 	}
 
 	return -EINVAL;
@@ -1650,10 +1668,19 @@ static int vfio_mdev_detach_domain(struct device *dev, void *data)
 
 	iommu_device = vfio_mdev_get_iommu_device(dev);
 	if (iommu_device) {
-		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
+		if (iommu_dev_feature_enabled(iommu_device,
+					      IOMMU_DEV_FEAT_AUX)) {
+			struct iommu_group *group;
+
 			iommu_aux_detach_device(domain, iommu_device);
-		else
+			group = iommu_group_get(dev);
+			if (group) {
+				iommu_group_set_domain(group, NULL);
+				iommu_group_put(group);
+			}
+		} else {
 			iommu_detach_device(domain, iommu_device);
+		}
 	}
 
 	return 0;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
