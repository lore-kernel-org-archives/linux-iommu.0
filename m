Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93CCC433DF
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 12:10:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A8D2078D
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 12:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A8D2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 59DFE8878C;
	Thu, 11 Jun 2020 12:10:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9L+5m8q1gOhk; Thu, 11 Jun 2020 12:09:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 348DF887BC;
	Thu, 11 Jun 2020 12:09:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D09CC0894;
	Thu, 11 Jun 2020 12:09:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFA55C016F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BF906879F9
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:09:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aY7fQUsyMv9A for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 12:09:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6F1F487A60
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:09:11 +0000 (UTC)
IronPort-SDR: lektq/ScLspK7qKdjcrhXXLRnT29Wg0BQX5ZTRIOH/pudjj+l8+raH9fooU2q4IrrCE1aH2h3f
 JXBrSAlBEAkg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2020 05:09:10 -0700
IronPort-SDR: tS2P2dymG6XztasY2b9XIWr7eXMwbRwXCnUyWm/5pGTsahVGGAjGH5b/A929jlefvUVl8L1tuE
 VSriR8zKkitA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; d="scan'208";a="419082490"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 11 Jun 2020 05:09:09 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v2 08/15] iommu: Pass domain and unbind_data to
 sva_unbind_gpasid()
Date: Thu, 11 Jun 2020 05:15:27 -0700
Message-Id: <1591877734-66527-9-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, jun.j.tian@intel.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com, hao.wu@intel.com
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

From: Yi Sun <yi.y.sun@intel.com>

Current interface is good enough for SVA virtualization on an assigned
physical PCI device, but when it comes to mediated devices, a physical
device may attached with multiple aux-domains. So this interface needs
to pass in domain info. Then the iommu driver is able to know which
domain will be used for the 2nd stage translation of the nesting mode.

This patch passes @domain per the above reason. This interface is supposed
to serve the unbind request from user-space, should pass in unbind_data as
well.

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Sun <yi.y.sun@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-svm.c   | 14 ++++++++++++--
 drivers/iommu/iommu.c       |  4 ++--
 include/linux/intel-iommu.h |  3 ++-
 include/linux/iommu.h       |  8 +++++---
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 6272da6..bf55e2f 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -445,16 +445,26 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	return ret;
 }
 
-int intel_svm_unbind_gpasid(struct device *dev, int pasid)
+int intel_svm_unbind_gpasid(struct iommu_domain *domain,
+			    struct device *dev,
+			    struct iommu_gpasid_unbind_data *data)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
 	int ret = -EINVAL;
+	unsigned long minsz;
+	int pasid;
+
+	if (WARN_ON(!iommu) || !data)
+		return -EINVAL;
 
-	if (WARN_ON(!iommu))
+	minsz = offsetofend(struct iommu_gpasid_unbind_data, pasid);
+	if (data->argsz < minsz || data->flags)
 		return -EINVAL;
 
+	pasid = data->pasid;
+
 	mutex_lock(&pasid_mutex);
 	svm = ioasid_find(INVALID_IOASID_SET, pasid, NULL);
 	if (!svm) {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 374b34f..57aac03 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1955,12 +1955,12 @@ int iommu_sva_bind_gpasid(struct iommu_domain *domain,
 EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
 
 int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
-			     ioasid_t pasid)
+			    struct iommu_gpasid_unbind_data *data)
 {
 	if (unlikely(!domain->ops->sva_unbind_gpasid))
 		return -ENODEV;
 
-	return domain->ops->sva_unbind_gpasid(dev, pasid);
+	return domain->ops->sva_unbind_gpasid(domain, dev, data);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 29d1c6f..0b238c3 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -737,7 +737,8 @@ extern int intel_svm_finish_prq(struct intel_iommu *iommu);
 
 int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			  struct iommu_gpasid_bind_data *data);
-int intel_svm_unbind_gpasid(struct device *dev, int pasid);
+int intel_svm_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+			    struct iommu_gpasid_unbind_data *data);
 struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
 				 void *drvdata);
 void intel_svm_unbind(struct iommu_sva *handle);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 57c46ae..a19f063 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -325,7 +325,8 @@ struct iommu_ops {
 	int (*sva_bind_gpasid)(struct iommu_domain *domain,
 			struct device *dev, struct iommu_gpasid_bind_data *data);
 
-	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
+	int (*sva_unbind_gpasid)(struct iommu_domain *domain,
+		struct device *dev, struct iommu_gpasid_unbind_data *data);
 
 	int (*def_domain_type)(struct device *dev);
 
@@ -459,7 +460,7 @@ extern int iommu_cache_invalidate(struct iommu_domain *domain,
 extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,
 		struct device *dev, struct iommu_gpasid_bind_data *data);
 extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-				struct device *dev, ioasid_t pasid);
+		struct device *dev, struct iommu_gpasid_unbind_data *data);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -1084,7 +1085,8 @@ static inline int iommu_sva_bind_gpasid(struct iommu_domain *domain,
 }
 
 static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-					   struct device *dev, int pasid)
+					  struct device *dev,
+					  struct iommu_gpasid_unbind_data *data)
 {
 	return -ENODEV;
 }
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
