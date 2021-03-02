Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0C4C433E0
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 12:37:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380F764F3D
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 12:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380F764F3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 047A983F2D;
	Tue,  2 Mar 2021 12:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nLCUYaqGDPAC; Tue,  2 Mar 2021 12:37:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D41D783F2F;
	Tue,  2 Mar 2021 12:37:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0569C000A;
	Tue,  2 Mar 2021 12:37:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECD01C0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 12:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE6C183F2F
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 12:37:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8fl7s6kzsOie for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 12:37:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A05983F2D
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 12:37:17 +0000 (UTC)
IronPort-SDR: PNoZC+9SWo6/Xbi9SMsXye+0/rlQhxpf5MDyhOzwfX9NltU7BB7idkyh3WoKotzywXbinEOPF2
 ZAyPqFT/YPlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="166675132"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="166675132"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 04:37:16 -0800
IronPort-SDR: r75wCfq+nex2exFmk/NZJGbTHr4BjDIzLy/Q74d6zVaE6tNjx6Elc2nSTm24GNG2KS3Zo2uPke
 KMHFoYkLenPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="427472104"
Received: from yiliu-dev.bj.intel.com (HELO dual-ub.bj.intel.com)
 ([10.238.156.135])
 by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2021 04:37:12 -0800
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [Patch v8 06/10] iommu: Pass domain to sva_unbind_gpasid()
Date: Wed,  3 Mar 2021 04:35:41 +0800
Message-Id: <20210302203545.436623-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302203545.436623-1-yi.l.liu@intel.com>
References: <20210302203545.436623-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, vivek.gautam@arm.com, yi.y.sun@intel.com,
 jgg@nvidia.com, Lingshan.Zhu@intel.com, jasowang@redhat.com, hao.wu@intel.com
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

From: Yi Sun <yi.y.sun@intel.com>

Current interface is good enough for SVA virtualization on an assigned
physical PCI device, but when it comes to mediated devices, a physical
device may be attached with multiple aux-domains. Also, for guest unbind,
the PASID to be unbind should be allocated to the VM. This check requires
to know the ioasid_set which is associated with the domain.

So this interface needs to pass in domain info. Then the iommu driver is
able to know which domain will be used for the 2nd stage translation of
the nesting mode and also be able to do PASID ownership check. This patch
passes @domain per the above reason.

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
v7 -> v8:
*) tweaked the commit message.

v6 -> v7:
*) correct the link for the details of modifying pasid prototype to bve "u32".
*) hold off r-b from Eric Auger as there is modification in this patch, will
   seek r-b in this version.

v5 -> v6:
*) use "u32" prototype for @pasid.
*) add review-by from Eric Auger.

v2 -> v3:
*) pass in domain info only
*) use u32 for pasid instead of int type

v1 -> v2:
*) added in v2.
---
 drivers/iommu/intel/svm.c   | 3 ++-
 drivers/iommu/iommu.c       | 2 +-
 include/linux/intel-iommu.h | 3 ++-
 include/linux/iommu.h       | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 561d011c7287..7521b4aefd16 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -496,7 +496,8 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	return ret;
 }
 
-int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
+int intel_svm_unbind_gpasid(struct iommu_domain *domain,
+			    struct device *dev, u32 pasid)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct intel_svm_dev *sdev;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d46f103a1e4b..822e485683ae 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2185,7 +2185,7 @@ int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
 	if (unlikely(!domain->ops->sva_unbind_gpasid))
 		return -ENODEV;
 
-	return domain->ops->sva_unbind_gpasid(dev, pasid);
+	return domain->ops->sva_unbind_gpasid(domain, dev, pasid);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 554aa946f142..aaf403966444 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -755,7 +755,8 @@ extern int intel_svm_enable_prq(struct intel_iommu *iommu);
 extern int intel_svm_finish_prq(struct intel_iommu *iommu);
 int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			  struct iommu_gpasid_bind_data *data);
-int intel_svm_unbind_gpasid(struct device *dev, u32 pasid);
+int intel_svm_unbind_gpasid(struct iommu_domain *domain,
+			    struct device *dev, u32 pasid);
 struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
 				 void *drvdata);
 void intel_svm_unbind(struct iommu_sva *handle);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e7fe519430a..4840217a590b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -299,7 +299,8 @@ struct iommu_ops {
 	int (*sva_bind_gpasid)(struct iommu_domain *domain,
 			struct device *dev, struct iommu_gpasid_bind_data *data);
 
-	int (*sva_unbind_gpasid)(struct device *dev, u32 pasid);
+	int (*sva_unbind_gpasid)(struct iommu_domain *domain,
+				 struct device *dev, u32 pasid);
 
 	int (*def_domain_type)(struct device *dev);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
