Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CACC10F0E
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 04:27:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646D72082E
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 04:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646D72082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F354EAE0;
	Fri, 12 Apr 2019 04:27:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9833BF5E
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 04:19:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1A9B97ED
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 04:19:33 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	11 Apr 2019 21:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,340,1549958400"; d="scan'208";a="142094935"
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by fmsmga007.fm.intel.com with ESMTP; 11 Apr 2019 21:19:30 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Kirti Wankhede <kwankhede@nvidia.com>
Subject: [PATCH v9 2/3] vfio/type1: Add domain at(de)taching group helpers
Date: Fri, 12 Apr 2019 12:13:25 +0800
Message-Id: <20190412041326.19914-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412041326.19914-1-baolu.lu@linux.intel.com>
References: <20190412041326.19914-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
	jacob.jun.pan@intel.com, kvm@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190412041325.qKMu3jjCFANjW6IjtmuXqq1MOwL5d_uU993XnqRidzE@z>

This adds helpers to attach or detach a domain to a
group. This will replace iommu_attach_group() which
only works for non-mdev devices.

If a domain is attaching to a group which includes the
mediated devices, it should attach to the iommu device
(a pci device which represents the mdev in iommu scope)
instead. The added helper supports attaching domain to
groups for both pci and mdev devices.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/vfio_iommu_type1.c | 84 ++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index d0f731c9920a..c956b85264ae 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -97,6 +97,7 @@ struct vfio_dma {
 struct vfio_group {
 	struct iommu_group	*iommu_group;
 	struct list_head	next;
+	bool			mdev_group;	/* An mdev group */
 };
 
 /*
@@ -1311,6 +1312,75 @@ static bool vfio_iommu_has_sw_msi(struct iommu_group *group, phys_addr_t *base)
 	return ret;
 }
 
+static struct device *vfio_mdev_get_iommu_device(struct device *dev)
+{
+	struct device *(*fn)(struct device *dev);
+	struct device *iommu_device;
+
+	fn = symbol_get(mdev_get_iommu_device);
+	if (fn) {
+		iommu_device = fn(dev);
+		symbol_put(mdev_get_iommu_device);
+
+		return iommu_device;
+	}
+
+	return NULL;
+}
+
+static int vfio_mdev_attach_domain(struct device *dev, void *data)
+{
+	struct iommu_domain *domain = data;
+	struct device *iommu_device;
+
+	iommu_device = vfio_mdev_get_iommu_device(dev);
+	if (iommu_device) {
+		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
+			return iommu_aux_attach_device(domain, iommu_device);
+		else
+			return iommu_attach_device(domain, iommu_device);
+	}
+
+	return -EINVAL;
+}
+
+static int vfio_mdev_detach_domain(struct device *dev, void *data)
+{
+	struct iommu_domain *domain = data;
+	struct device *iommu_device;
+
+	iommu_device = vfio_mdev_get_iommu_device(dev);
+	if (iommu_device) {
+		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
+			iommu_aux_detach_device(domain, iommu_device);
+		else
+			iommu_detach_device(domain, iommu_device);
+	}
+
+	return 0;
+}
+
+static int vfio_iommu_attach_group(struct vfio_domain *domain,
+				   struct vfio_group *group)
+{
+	if (group->mdev_group)
+		return iommu_group_for_each_dev(group->iommu_group,
+						domain->domain,
+						vfio_mdev_attach_domain);
+	else
+		return iommu_attach_group(domain->domain, group->iommu_group);
+}
+
+static void vfio_iommu_detach_group(struct vfio_domain *domain,
+				    struct vfio_group *group)
+{
+	if (group->mdev_group)
+		iommu_group_for_each_dev(group->iommu_group, domain->domain,
+					 vfio_mdev_detach_domain);
+	else
+		iommu_detach_group(domain->domain, group->iommu_group);
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -1386,7 +1456,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			goto out_domain;
 	}
 
-	ret = iommu_attach_group(domain->domain, iommu_group);
+	ret = vfio_iommu_attach_group(domain, group);
 	if (ret)
 		goto out_domain;
 
@@ -1418,8 +1488,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	list_for_each_entry(d, &iommu->domain_list, next) {
 		if (d->domain->ops == domain->domain->ops &&
 		    d->prot == domain->prot) {
-			iommu_detach_group(domain->domain, iommu_group);
-			if (!iommu_attach_group(d->domain, iommu_group)) {
+			vfio_iommu_detach_group(domain, group);
+			if (!vfio_iommu_attach_group(d, group)) {
 				list_add(&group->next, &d->group_list);
 				iommu_domain_free(domain->domain);
 				kfree(domain);
@@ -1427,7 +1497,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 				return 0;
 			}
 
-			ret = iommu_attach_group(domain->domain, iommu_group);
+			ret = vfio_iommu_attach_group(domain, group);
 			if (ret)
 				goto out_domain;
 		}
@@ -1453,7 +1523,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	return 0;
 
 out_detach:
-	iommu_detach_group(domain->domain, iommu_group);
+	vfio_iommu_detach_group(domain, group);
 out_domain:
 	iommu_domain_free(domain->domain);
 out_free:
@@ -1544,7 +1614,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 		if (!group)
 			continue;
 
-		iommu_detach_group(domain->domain, iommu_group);
+		vfio_iommu_detach_group(domain, group);
 		list_del(&group->next);
 		kfree(group);
 		/*
@@ -1610,7 +1680,7 @@ static void vfio_release_domain(struct vfio_domain *domain, bool external)
 	list_for_each_entry_safe(group, group_tmp,
 				 &domain->group_list, next) {
 		if (!external)
-			iommu_detach_group(domain->domain, group->iommu_group);
+			vfio_iommu_detach_group(domain, group);
 		list_del(&group->next);
 		kfree(group);
 	}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
