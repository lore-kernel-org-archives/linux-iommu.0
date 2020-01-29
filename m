Return-Path: <SRS0=Gm0N=3S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URI_WP_DIRINDEX,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3326AC33CB2
	for <iommu@archiver.kernel.org>; Wed, 29 Jan 2020 12:06:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 125882071E
	for <iommu@archiver.kernel.org>; Wed, 29 Jan 2020 12:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125882071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E5D0986E33;
	Wed, 29 Jan 2020 12:06:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QFlch7mQy0Dx; Wed, 29 Jan 2020 12:06:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D94EE86E3A;
	Wed, 29 Jan 2020 12:06:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2223C1D8D;
	Wed, 29 Jan 2020 12:06:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8605BC1D84
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 12:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 749BE86E0A
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 12:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hodVZmMmNAYG for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jan 2020 12:06:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C64E186E33
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 12:06:40 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 04:06:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,377,1574150400"; d="scan'208";a="222433157"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 29 Jan 2020 04:06:39 -0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: alex.williamson@redhat.com,
	eric.auger@redhat.com
Subject: [RFC v3 8/8] vfio/type1: Add vSVA support for IOMMU-backed mdevs
Date: Wed, 29 Jan 2020 04:11:52 -0800
Message-Id: <1580299912-86084-9-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580299912-86084-1-git-send-email-yi.l.liu@intel.com>
References: <1580299912-86084-1-git-send-email-yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 jean-philippe.brucker@arm.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com
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

From: Liu Yi L <yi.l.liu@intel.com>

Recent years, mediated device pass-through framework (e.g. vfio-mdev)
are used to achieve flexible device sharing across domains (e.g. VMs).
Also there are hardware assisted mediated pass-through solutions from
platform vendors. e.g. Intel VT-d scalable mode which supports Intel
Scalable I/O Virtualization technology. Such mdevs are called IOMMU-
backed mdevs as there are IOMMU enforced DMA isolation for such mdevs.
In kernel, IOMMU-backed mdevs are exposed to IOMMU layer by aux-domain
concept, which means mdevs are protected by an iommu domain which is
aux-domain of its physical device. Details can be found in the KVM
presentation from Kevin Tian. IOMMU-backed equals to IOMMU-capable.

https://events19.linuxfoundation.org/wp-content/uploads/2017/12/\
Hardware-Assisted-Mediated-Pass-Through-with-VFIO-Kevin-Tian-Intel.pdf

This patch supports NESTING IOMMU for IOMMU-backed mdevs by figuring
out the physical device of an IOMMU-backed mdev and then invoking IOMMU
requests to IOMMU layer with the physical device and the mdev's aux
domain info.

With this patch, vSVA (Virtual Shared Virtual Addressing) can be used
on IOMMU-backed mdevs.

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: Jun Tian <jun.j.tian@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 2168318..5aea355 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -127,6 +127,7 @@ struct vfio_regions {
 
 struct domain_capsule {
 	struct iommu_domain *domain;
+	struct vfio_group *group;
 	void *data;
 };
 
@@ -143,6 +144,7 @@ static int vfio_iommu_for_each_dev(struct vfio_iommu *iommu,
 	list_for_each_entry(d, &iommu->domain_list, next) {
 		dc.domain = d->domain;
 		list_for_each_entry(g, &d->group_list, next) {
+			dc.group = g;
 			ret = iommu_group_for_each_dev(g->iommu_group,
 						       &dc, fn);
 			if (ret)
@@ -2372,7 +2374,12 @@ static int vfio_bind_gpasid_fn(struct device *dev, void *data)
 	struct iommu_gpasid_bind_data *gbind_data =
 		(struct iommu_gpasid_bind_data *) dc->data;
 
-	return iommu_sva_bind_gpasid(dc->domain, dev, gbind_data);
+	if (dc->group->mdev_group)
+		return iommu_sva_bind_gpasid(dc->domain,
+			vfio_mdev_get_iommu_device(dev), gbind_data);
+	else
+		return iommu_sva_bind_gpasid(dc->domain,
+						dev, gbind_data);
 }
 
 static int vfio_unbind_gpasid_fn(struct device *dev, void *data)
@@ -2381,7 +2388,12 @@ static int vfio_unbind_gpasid_fn(struct device *dev, void *data)
 	struct iommu_gpasid_bind_data *gbind_data =
 		(struct iommu_gpasid_bind_data *) dc->data;
 
-	return iommu_sva_unbind_gpasid(dc->domain, dev,
+	if (dc->group->mdev_group)
+		return iommu_sva_unbind_gpasid(dc->domain,
+					vfio_mdev_get_iommu_device(dev),
+					gbind_data->hpasid);
+	else
+		return iommu_sva_unbind_gpasid(dc->domain, dev,
 						gbind_data->hpasid);
 }
 
@@ -2454,7 +2466,12 @@ static int vfio_cache_inv_fn(struct device *dev, void *data)
 	struct iommu_cache_invalidate_info *cache_inv_info =
 		(struct iommu_cache_invalidate_info *) dc->data;
 
-	return iommu_cache_invalidate(dc->domain, dev, cache_inv_info);
+	if (dc->group->mdev_group)
+		return iommu_cache_invalidate(dc->domain,
+			vfio_mdev_get_iommu_device(dev), cache_inv_info);
+	else
+		return iommu_cache_invalidate(dc->domain,
+						dev, cache_inv_info);
 }
 
 static long vfio_iommu_type1_ioctl(void *iommu_data,
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
