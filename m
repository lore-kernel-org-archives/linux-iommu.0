Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2E9C43461
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 10:43:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D9E206B8
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 10:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D9E206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7789187430;
	Thu, 10 Sep 2020 10:43:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7r+QD70PANzd; Thu, 10 Sep 2020 10:43:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 42C7A8758D;
	Thu, 10 Sep 2020 10:43:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EB99C0891;
	Thu, 10 Sep 2020 10:43:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECD48C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 10:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E806E87430
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 10:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oxlpJBnnOyPU for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 10:43:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 71A7687435
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 10:43:36 +0000 (UTC)
IronPort-SDR: W6PXxwwJI4woRRMEWTKNJuvs9pEJdK7vjsNFF+uqBvm1d5/a6AU+lkPj25f/pukHJ+HjODoz+0
 RKDS+272tqvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="243323838"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="243323838"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 03:43:35 -0700
IronPort-SDR: qqVbpwoHpXRw4uXJ/tF3bbA1eNSZ9spkgvcv01qCUk9F3wUDG1llqTkogCuM1gdz7aeNmlTVRt
 OEIkkJhIargg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="334137214"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 10 Sep 2020 03:43:35 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v7 12/16] vfio/type1: Add vSVA support for IOMMU-backed mdevs
Date: Thu, 10 Sep 2020 03:45:29 -0700
Message-Id: <1599734733-6431-13-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, yi.y.sun@intel.com, jasowang@redhat.com,
 hao.wu@intel.com
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

Recent years, mediated device pass-through framework (e.g. vfio-mdev)
is used to achieve flexible device sharing across domains (e.g. VMs).
Also there are hardware assisted mediated pass-through solutions from
platform vendors. e.g. Intel VT-d scalable mode which supports Intel
Scalable I/O Virtualization technology. Such mdevs are called IOMMU-
backed mdevs as there are IOMMU enforced DMA isolation for such mdevs.
In kernel, IOMMU-backed mdevs are exposed to IOMMU layer by aux-domain
concept, which means mdevs are protected by an iommu domain which is
auxiliary to the domain that the kernel driver primarily uses for DMA
API. Details can be found in the KVM presentation as below:

https://events19.linuxfoundation.org/wp-content/uploads/2017/12/Hardware-Assisted-Mediated-Pass-Through-with-VFIO-Kevin-Tian-Intel.pdf

This patch extends NESTING_IOMMU ops to IOMMU-backed mdev devices. The
main requirement is to use the auxiliary domain associated with mdev.

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: Jun Tian <jun.j.tian@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
v5 -> v6:
*) add review-by from Eric Auger.

v1 -> v2:
*) check the iommu_device to ensure the handling mdev is IOMMU-backed
---
 drivers/vfio/vfio_iommu_type1.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index b67ce2d..5cef732 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2438,29 +2438,49 @@ static int vfio_iommu_resv_refresh(struct vfio_iommu *iommu,
 	return ret;
 }
 
+static struct device *vfio_get_iommu_device(struct vfio_group *group,
+					    struct device *dev)
+{
+	if (group->mdev_group)
+		return vfio_mdev_get_iommu_device(dev);
+	else
+		return dev;
+}
+
 static int vfio_dev_bind_gpasid_fn(struct device *dev, void *data)
 {
 	struct domain_capsule *dc = (struct domain_capsule *)data;
 	unsigned long arg = *(unsigned long *)dc->data;
+	struct device *iommu_device;
+
+	iommu_device = vfio_get_iommu_device(dc->group, dev);
+	if (!iommu_device)
+		return -EINVAL;
 
-	return iommu_uapi_sva_bind_gpasid(dc->domain, dev,
+	return iommu_uapi_sva_bind_gpasid(dc->domain, iommu_device,
 					  (void __user *)arg);
 }
 
 static int vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
 {
 	struct domain_capsule *dc = (struct domain_capsule *)data;
+	struct device *iommu_device;
+
+	iommu_device = vfio_get_iommu_device(dc->group, dev);
+	if (!iommu_device)
+		return -EINVAL;
 
 	if (dc->user) {
 		unsigned long arg = *(unsigned long *)dc->data;
 
-		iommu_uapi_sva_unbind_gpasid(dc->domain,
-					     dev, (void __user *)arg);
+		iommu_uapi_sva_unbind_gpasid(dc->domain, iommu_device,
+					     (void __user *)arg);
 	} else {
 		struct iommu_gpasid_bind_data *unbind_data =
 				(struct iommu_gpasid_bind_data *)dc->data;
 
-		iommu_sva_unbind_gpasid(dc->domain, dev, unbind_data);
+		iommu_sva_unbind_gpasid(dc->domain,
+					iommu_device, unbind_data);
 	}
 	return 0;
 }
@@ -3116,8 +3136,14 @@ static int vfio_dev_cache_invalidate_fn(struct device *dev, void *data)
 {
 	struct domain_capsule *dc = (struct domain_capsule *)data;
 	unsigned long arg = *(unsigned long *)dc->data;
+	struct device *iommu_device;
+
+	iommu_device = vfio_get_iommu_device(dc->group, dev);
+	if (!iommu_device)
+		return -EINVAL;
 
-	iommu_uapi_cache_invalidate(dc->domain, dev, (void __user *)arg);
+	iommu_uapi_cache_invalidate(dc->domain, iommu_device,
+				    (void __user *)arg);
 	return 0;
 }
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
