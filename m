Return-Path: <SRS0=CZ1O=C7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCF3C2D0E2
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 06:17:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07F323A34
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 06:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07F323A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BA1612266C;
	Tue, 22 Sep 2020 06:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sYn213YZNSCm; Tue, 22 Sep 2020 06:17:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 885BE226D4;
	Tue, 22 Sep 2020 06:17:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72CF4C0859;
	Tue, 22 Sep 2020 06:17:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A607FC0051
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 06:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9347B85AE9
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 06:16:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NElWOlLBEN87 for <iommu@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 06:16:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4E49285AA1
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 06:16:57 +0000 (UTC)
IronPort-SDR: jl4XlrICbQM6pNysXSyPNRVOqNhKXpE+t2ZljtipZ5TieQ5xwdCVwTNyPSEixDUivREb9Hj7ge
 XiUIXHxyIRGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="148206694"
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="148206694"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 23:16:56 -0700
IronPort-SDR: 2l5kDw3N+6np1U/VqUYKYU7mufRsGFSfueEIkosOHVRqAUcfOlz5o4Iakc74qiQPoUAaIrf4Hg
 pP/lVnMQ1IYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="334877235"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2020 23:16:53 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v5 1/5] iommu: Add optional subdev in aux_at(de)tach ops
Date: Tue, 22 Sep 2020 14:10:38 +0800
Message-Id: <20200922061042.31633-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922061042.31633-1-baolu.lu@linux.intel.com>
References: <20200922061042.31633-1-baolu.lu@linux.intel.com>
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
 drivers/iommu/iommu.c       | 26 +++++++++++++++++---------
 include/linux/iommu.h       |  6 ++++--
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1b7d390beb68..86142ce32f21 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5353,8 +5353,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	return domain_add_dev_info(to_dmar_domain(domain), dev);
 }
 
-static int intel_iommu_aux_attach_device(struct iommu_domain *domain,
-					 struct device *dev)
+static int
+intel_iommu_aux_attach_device(struct iommu_domain *domain,
+			      struct device *dev, struct device *subdev)
 {
 	int ret;
 
@@ -5374,8 +5375,9 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
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
index 6c14c88cd525..4c6e94682327 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2714,7 +2714,7 @@ bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
 EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
 
 /*
- * Aux-domain specific attach/detach.
+ * Aux-domain specific interfaces.
  *
  * Only works if iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX) returns
  * true. Also, as long as domains are attached to a device through this
@@ -2722,36 +2722,44 @@ EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
  * (iommu_detach_device() can't fail, so we fail when trying to re-attach).
  * This should make us safe against a device being attached to a guest as a
  * whole while there are still pasid users on it (aux and sva).
+ *
+ * Some physical devices can be configured to generate several subdevices.
+ * The modern IOMMUs support the identification and isolation of these
+ * subdevices. Hence they could be passed through to users space. VFIO/mdev
+ * provides a generic framework for subdevice passthrough. Below interfaces
+ * support such use case. Generally, among the parameters of the following
+ * aux-domain specific functions, @physdev represents a physical device,
+ * and @subdev represents a subdevice.
  */
-int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev)
+int iommu_aux_attach_device(struct iommu_domain *domain, struct device *physdev)
 {
 	int ret = -ENODEV;
 
 	if (domain->ops->aux_attach_dev)
-		ret = domain->ops->aux_attach_dev(domain, dev);
+		ret = domain->ops->aux_attach_dev(domain, physdev, NULL);
 
 	if (!ret)
-		trace_attach_device_to_domain(dev);
+		trace_attach_device_to_domain(physdev);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_aux_attach_device);
 
-void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev)
+void iommu_aux_detach_device(struct iommu_domain *domain, struct device *physdev)
 {
 	if (domain->ops->aux_detach_dev) {
-		domain->ops->aux_detach_dev(domain, dev);
-		trace_detach_device_from_domain(dev);
+		domain->ops->aux_detach_dev(domain, physdev, NULL);
+		trace_detach_device_from_domain(physdev);
 	}
 }
 EXPORT_SYMBOL_GPL(iommu_aux_detach_device);
 
-int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
+int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *physdev)
 {
 	int ret = -ENODEV;
 
 	if (domain->ops->aux_get_pasid)
-		ret = domain->ops->aux_get_pasid(domain, dev);
+		ret = domain->ops->aux_get_pasid(domain, physdev);
 
 	return ret;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2ad26d8b4ab9..56297b4bbd0e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -279,8 +279,10 @@ struct iommu_ops {
 	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
 
 	/* Aux-domain specific attach/detach entries */
-	int (*aux_attach_dev)(struct iommu_domain *domain, struct device *dev);
-	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*aux_attach_dev)(struct iommu_domain *domain, struct device *physdev,
+			      struct device *subdev);
+	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *physdev,
+			       struct device *subdev);
 	int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
 
 	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
