Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9436C4741F
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 05:05:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453C4221F9
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 05:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453C4221F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 93E5D873A3;
	Fri, 30 Oct 2020 05:05:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IRR9u0Lo1VOr; Fri, 30 Oct 2020 05:05:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EA70987498;
	Fri, 30 Oct 2020 05:05:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBA7CC1AD4;
	Fri, 30 Oct 2020 05:05:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A23BC0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 05:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 68CA32037B
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 05:05:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t+VE1K3FyrkG for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 05:05:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id D723F228B4
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 05:05:11 +0000 (UTC)
IronPort-SDR: Ld77+xNudrObM4mu5MkyEauD555Dl+5aZncAQD54Nh54SwU/lYUGND4JdxxLTw+/Nh83dM+nxL
 VDbFiPzNTG6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="253268381"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; d="scan'208";a="253268381"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 22:05:11 -0700
IronPort-SDR: LAC9eXFTdRYGEAuqJicF6BzOJWdyPWAZq2sNCKStnfDq5f+EsVQJvT3m8DWkUsYk0SH/garix/
 T2Sf8JN+V6Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; d="scan'208";a="425261545"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 29 Oct 2020 22:05:08 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v6 2/5] iommu: Use bus iommu ops for aux related callback
Date: Fri, 30 Oct 2020 12:58:06 +0800
Message-Id: <20201030045809.957927-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030045809.957927-1-baolu.lu@linux.intel.com>
References: <20201030045809.957927-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The aux-domain apis were designed for macro driver where the subdevices
are created and used inside a device driver. Use the device's bus iommu
ops instead of that in iommu domain for various callbacks.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6bbdd959f9f3..17f2686664db 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2913,10 +2913,11 @@ EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
  */
 int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev)
 {
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	int ret = -ENODEV;
 
-	if (domain->ops->aux_attach_dev)
-		ret = domain->ops->aux_attach_dev(domain, dev);
+	if (ops && ops->aux_attach_dev)
+		ret = ops->aux_attach_dev(domain, dev);
 
 	if (!ret)
 		trace_attach_device_to_domain(dev);
@@ -2927,8 +2928,10 @@ EXPORT_SYMBOL_GPL(iommu_aux_attach_device);
 
 void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev)
 {
-	if (domain->ops->aux_detach_dev) {
-		domain->ops->aux_detach_dev(domain, dev);
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (ops && ops->aux_detach_dev) {
+		ops->aux_detach_dev(domain, dev);
 		trace_detach_device_from_domain(dev);
 	}
 }
@@ -2936,10 +2939,11 @@ EXPORT_SYMBOL_GPL(iommu_aux_detach_device);
 
 int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 {
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	int ret = -ENODEV;
 
-	if (domain->ops->aux_get_pasid)
-		ret = domain->ops->aux_get_pasid(domain, dev);
+	if (ops && ops->aux_get_pasid)
+		ret = ops->aux_get_pasid(domain, dev);
 
 	return ret;
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
