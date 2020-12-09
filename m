Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3646CC4361B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 01:52:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9308E238EB
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 01:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9308E238EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3100387633;
	Wed,  9 Dec 2020 01:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F076NNpxCzoN; Wed,  9 Dec 2020 01:52:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 70B7E8761F;
	Wed,  9 Dec 2020 01:52:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 502F5C0FA7;
	Wed,  9 Dec 2020 01:52:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACA0DC013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 01:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A08F287633
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 01:52:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eTJU+h8+IRkL for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 01:52:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D8D8C8761F
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 01:52:24 +0000 (UTC)
IronPort-SDR: vQvFl/NW3G7SogfbzGtOx96WKzz1htGNVCADxSUKu9DeycUXetlTjUpA8ZAl2Oml8dEYLjS6yQ
 twDB8rhwsSsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="238107646"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; d="scan'208";a="238107646"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2020 17:52:23 -0800
IronPort-SDR: p9GFQc1L7/h6pbmnpMG4Am+qXvFd6Zl3fTnwJGN3OBiNcEQkmNyUac0raGFIqVqQPy119057Rt
 c2Hw6pi3fkgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; d="scan'208";a="367998068"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga004.fm.intel.com with ESMTP; 08 Dec 2020 17:52:18 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v4 1/1] vfio/type1: Add vfio_group_iommu_domain()
Date: Wed,  9 Dec 2020 09:44:44 +0800
Message-Id: <20201209014444.332772-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add the API for getting the domain from a vfio group. This could be used
by the physical device drivers which rely on the vfio/mdev framework for
mediated device user level access. The typical use case like below:

	unsigned int pasid;
	struct vfio_group *vfio_group;
	struct iommu_domain *iommu_domain;
	struct device *dev = mdev_dev(mdev);
	struct device *iommu_device = mdev_get_iommu_device(dev);

	if (!iommu_device ||
	    !iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
		return -EINVAL;

	vfio_group = vfio_group_get_external_user_from_dev(dev);
	if (IS_ERR_OR_NULL(vfio_group))
		return -EFAULT;

	iommu_domain = vfio_group_iommu_domain(vfio_group);
	if (IS_ERR_OR_NULL(iommu_domain)) {
		vfio_group_put_external_user(vfio_group);
		return -EFAULT;
	}

	pasid = iommu_aux_get_pasid(iommu_domain, iommu_device);
	if (pasid < 0) {
		vfio_group_put_external_user(vfio_group);
		return -EFAULT;
	}

	/* Program device context with pasid value. */
	...

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio.c             | 18 ++++++++++++++++++
 drivers/vfio/vfio_iommu_type1.c | 24 ++++++++++++++++++++++++
 include/linux/vfio.h            |  4 ++++
 3 files changed, 46 insertions(+)

Change log:
 - v3: https://lore.kernel.org/linux-iommu/20201201012328.2465735-1-baolu.lu@linux.intel.com/
 - Changed according to comments @ https://lore.kernel.org/linux-iommu/20201202144834.1dd0983e@w520.home/
   - Rename group_domain to group_iommu_domain;
   - Remove an unnecessary else branch.

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 2151bc7f87ab..4ad8a35667a7 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -2331,6 +2331,24 @@ int vfio_unregister_notifier(struct device *dev, enum vfio_notify_type type,
 }
 EXPORT_SYMBOL(vfio_unregister_notifier);
 
+struct iommu_domain *vfio_group_iommu_domain(struct vfio_group *group)
+{
+	struct vfio_container *container;
+	struct vfio_iommu_driver *driver;
+
+	if (!group)
+		return ERR_PTR(-EINVAL);
+
+	container = group->container;
+	driver = container->iommu_driver;
+	if (likely(driver && driver->ops->group_iommu_domain))
+		return driver->ops->group_iommu_domain(container->iommu_data,
+						       group->iommu_group);
+
+	return ERR_PTR(-ENOTTY);
+}
+EXPORT_SYMBOL_GPL(vfio_group_iommu_domain);
+
 /**
  * Module/class support
  */
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 67e827638995..0b4dedaa9128 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2980,6 +2980,29 @@ static int vfio_iommu_type1_dma_rw(void *iommu_data, dma_addr_t user_iova,
 	return ret;
 }
 
+static struct iommu_domain *
+vfio_iommu_type1_group_iommu_domain(void *iommu_data,
+				    struct iommu_group *iommu_group)
+{
+	struct iommu_domain *domain = ERR_PTR(-ENODEV);
+	struct vfio_iommu *iommu = iommu_data;
+	struct vfio_domain *d;
+
+	if (!iommu || !iommu_group)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&iommu->lock);
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		if (find_iommu_group(d, iommu_group)) {
+			domain = d->domain;
+			break;
+		}
+	}
+	mutex_unlock(&iommu->lock);
+
+	return domain;
+}
+
 static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.name			= "vfio-iommu-type1",
 	.owner			= THIS_MODULE,
@@ -2993,6 +3016,7 @@ static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.register_notifier	= vfio_iommu_type1_register_notifier,
 	.unregister_notifier	= vfio_iommu_type1_unregister_notifier,
 	.dma_rw			= vfio_iommu_type1_dma_rw,
+	.group_iommu_domain	= vfio_iommu_type1_group_iommu_domain,
 };
 
 static int __init vfio_iommu_type1_init(void)
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 38d3c6a8dc7e..f45940b38a02 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -90,6 +90,8 @@ struct vfio_iommu_driver_ops {
 					       struct notifier_block *nb);
 	int		(*dma_rw)(void *iommu_data, dma_addr_t user_iova,
 				  void *data, size_t count, bool write);
+	struct iommu_domain *(*group_iommu_domain)(void *iommu_data,
+						   struct iommu_group *group);
 };
 
 extern int vfio_register_iommu_driver(const struct vfio_iommu_driver_ops *ops);
@@ -126,6 +128,8 @@ extern int vfio_group_unpin_pages(struct vfio_group *group,
 extern int vfio_dma_rw(struct vfio_group *group, dma_addr_t user_iova,
 		       void *data, size_t len, bool write);
 
+extern struct iommu_domain *vfio_group_iommu_domain(struct vfio_group *group);
+
 /* each type has independent events */
 enum vfio_notify_type {
 	VFIO_IOMMU_NOTIFY = 0,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
