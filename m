Return-Path: <SRS0=CZ1O=C7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74047C4363D
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 06:17:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A0A23A9B
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 06:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A0A23A9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BC25885BAE;
	Tue, 22 Sep 2020 06:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iHSiCRf3PI7z; Tue, 22 Sep 2020 06:17:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E66DD85C37;
	Tue, 22 Sep 2020 06:17:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D24C8C0859;
	Tue, 22 Sep 2020 06:17:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26CFAC0051
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 06:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1646C85BEE
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 06:17:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i8-YkiF8DCl6 for <iommu@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 06:17:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E5B7685AE9
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 06:17:03 +0000 (UTC)
IronPort-SDR: u3k9+dvN+xBFunKwdMHsa3z1pJkqqmciVOH/dJTpapus8eI6dK3uK4niM4VD+OVr8PvhnF6fIM
 ZKruuFvGNy+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="148206702"
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="148206702"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 23:17:03 -0700
IronPort-SDR: hQKOr7bsyk2kbpE/MSMW2jCpuIJ+taS5o6zMPkgn7nLLPKHCv2FzmQedp6g745cpQV3BGLRzPh
 MbY4N2n7c0Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="334877389"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2020 23:17:00 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v5 3/5] iommu: Add iommu_aux_get_domain_for_dev()
Date: Tue, 22 Sep 2020 14:10:40 +0800
Message-Id: <20200922061042.31633-4-baolu.lu@linux.intel.com>
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

The device driver needs an API to get its aux-domain. A typical usage
scenario is:

        unsigned long pasid;
        struct iommu_domain *domain;
        struct device *dev = mdev_dev(mdev);
        struct device *iommu_device = vfio_mdev_get_iommu_device(dev);

        domain = iommu_aux_get_domain_for_dev(dev);
        if (!domain)
                return -ENODEV;

        pasid = iommu_aux_get_pasid(domain, iommu_device);
        if (pasid <= 0)
                return -EINVAL;

         /* Program the device context */
         ....

This adds an API for such use case.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/linux-iommu/20200708130749.1b1e1421@x1.home/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 18 ++++++++++++++++++
 include/linux/iommu.h | 20 ++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 77f3a9fc4dfe..b6f24bf3bf87 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2905,6 +2905,24 @@ void iommu_detach_subdev_group(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_detach_subdev_group);
 
+struct iommu_domain *iommu_aux_get_domain_for_dev(struct device *subdev)
+{
+	struct iommu_domain *domain = NULL;
+	struct iommu_group *group;
+
+	group = iommu_group_get(subdev);
+	if (!group || !group->domain)
+		return NULL;
+
+	if (domain_is_aux(group->domain, subdev))
+		domain = group->domain;
+
+	iommu_group_put(group);
+
+	return domain;
+}
+EXPORT_SYMBOL_GPL(iommu_aux_get_domain_for_dev);
+
 /**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4df17a8f4540..652549de388a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -120,6 +120,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
 	DOMAIN_ATTR_MAX,
+	DOMAIN_ATTR_IS_AUX,
 };
 
 /* These are the possible reserved region types */
@@ -622,6 +623,12 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
 	dev->iommu->priv = priv;
 }
 
+static inline bool
+domain_is_aux(struct iommu_domain *domain, struct device *subdev)
+{
+	return iommu_domain_get_attr(domain, DOMAIN_ATTR_IS_AUX, subdev);
+}
+
 int iommu_probe_device(struct device *dev);
 void iommu_release_device(struct device *dev);
 
@@ -638,6 +645,7 @@ int iommu_attach_subdev_group(struct iommu_domain *domain,
 void iommu_detach_subdev_group(struct iommu_domain *domain,
 			       struct iommu_group *group,
 			       iommu_device_lookup_t fn);
+struct iommu_domain *iommu_aux_get_domain_for_dev(struct device *subdev);
 
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm,
@@ -1039,6 +1047,18 @@ iommu_detach_subdev_group(struct iommu_domain *domain, struct iommu_group *group
 {
 }
 
+static inline bool
+domain_is_aux(struct iommu_domain *domain, struct device *subdev)
+{
+	return false;
+}
+
+static inline struct iommu_domain *
+iommu_aux_get_domain_for_dev(struct device *subdev)
+{
+	return NULL;
+}
+
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
