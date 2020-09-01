Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F531C433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 03:40:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9CD206FA
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 03:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9CD206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0BFBC85F4D;
	Tue,  1 Sep 2020 03:40:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B0llH95AFTn8; Tue,  1 Sep 2020 03:40:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 69AB785DF6;
	Tue,  1 Sep 2020 03:40:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56D19C088B;
	Tue,  1 Sep 2020 03:40:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 948C5C0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 91B0186FE2
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:40:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xddr1vnpu-L4 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 03:40:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D6F6A8643B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:40:12 +0000 (UTC)
IronPort-SDR: LyL4zGXZEuFQ4RUo/C6RVbkU6fkB4Mn0M80YVECxi2TCuNNtDkT2AMe9bSDJn5Hq4fV3jYZ3e4
 cPfjxfvILUrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="144843768"
X-IronPort-AV: E=Sophos;i="5.76,377,1592895600"; d="scan'208";a="144843768"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 20:40:12 -0700
IronPort-SDR: 1kfNDpxVZ6PjA9CK/YbklI2otaiSCxb5Hzrt0nE6YVckEQ9BAy5kwhn0hOaSxj3FTWfku0VgS4
 ccCggZH6ZUZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,377,1592895600"; d="scan'208";a="325180863"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2020 20:40:09 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v4 1/5] iommu: Add optional subdev in aux_at(de)tach ops
Date: Tue,  1 Sep 2020 11:34:18 +0800
Message-Id: <20200901033422.22249-2-baolu.lu@linux.intel.com>
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

In the vfio/mdev use case of aux-domain, the subdevices are created from
the physical devices with IOMMU_DEV_FEAT_AUX enabled and the aux-domains
are attached to the subdevices through the iommu_ops.aux_attach_dev()
interface.

Current iommu_ops.aux_at(de)tach_dev() design only takes the aux-domain
and the physical device as the parameters, this is insufficient if we
want the vendor iommu drivers to learn the knowledge about relationships
between the aux-domains and the subdevices. Add a @subdev parameter to
iommu_ops.aux_at(de)tach_dev() interfaces so that a subdevice could be
opt-in.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 10 ++++++----
 drivers/iommu/iommu.c       |  4 ++--
 include/linux/iommu.h       |  6 ++++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bce158468abf..3c12fd06856c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5338,8 +5338,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	return domain_add_dev_info(to_dmar_domain(domain), dev);
 }
 
-static int intel_iommu_aux_attach_device(struct iommu_domain *domain,
-					 struct device *dev)
+static int
+intel_iommu_aux_attach_device(struct iommu_domain *domain,
+			      struct device *dev, struct device *subdev)
 {
 	int ret;
 
@@ -5359,8 +5360,9 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
 	dmar_remove_one_dev_info(dev);
 }
 
-static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
-					  struct device *dev)
+static void
+intel_iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev,
+			      struct device *subdev)
 {
 	aux_domain_remove_dev(to_dmar_domain(domain), dev);
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 609bd25bf154..38cdfeb887e1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2728,7 +2728,7 @@ int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev)
 	int ret = -ENODEV;
 
 	if (domain->ops->aux_attach_dev)
-		ret = domain->ops->aux_attach_dev(domain, dev);
+		ret = domain->ops->aux_attach_dev(domain, dev, NULL);
 
 	if (!ret)
 		trace_attach_device_to_domain(dev);
@@ -2740,7 +2740,7 @@ EXPORT_SYMBOL_GPL(iommu_aux_attach_device);
 void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev)
 {
 	if (domain->ops->aux_detach_dev) {
-		domain->ops->aux_detach_dev(domain, dev);
+		domain->ops->aux_detach_dev(domain, dev, NULL);
 		trace_detach_device_from_domain(dev);
 	}
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fee209efb756..871267104915 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -279,8 +279,10 @@ struct iommu_ops {
 	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
 
 	/* Aux-domain specific attach/detach entries */
-	int (*aux_attach_dev)(struct iommu_domain *domain, struct device *dev);
-	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*aux_attach_dev)(struct iommu_domain *domain, struct device *dev,
+			      struct device *subdev);
+	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev,
+			       struct device *subdev);
 	int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
 
 	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
