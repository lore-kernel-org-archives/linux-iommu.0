Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669E7C282E1
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 23:29:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9F6218DA
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 23:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9F6218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A6B21F1D;
	Tue, 23 Apr 2019 23:28:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A68BDA64
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 23:28:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1846782B
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 23:28:42 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Apr 2019 16:28:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,387,1549958400"; d="scan'208";a="293981282"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga004.jf.intel.com with ESMTP; 23 Apr 2019 16:28:38 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Eric Auger <eric.auger@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v2 10/19] iommu/vt-d: Add custom allocator for IOASID
Date: Tue, 23 Apr 2019 16:31:10 -0700
Message-Id:
 <1556062279-64135-11-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>, Liu@mail.linuxfoundation.org,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <20190423233110.sSUTr7ocpPXNnA5piyHQvnGYUaIzkJYYJ97bIJRu2qo@z>

When VT-d driver runs in the guest, PASID allocation must be
performed via virtual command interface. This patch register a
custom IOASID allocator which takes precedence over the default
IDR based allocator. The resulting IOASID allocation will always
come from the host. This ensures that PASID namespace is system-
wide.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  2 ++
 2 files changed, 60 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d93c4bd..ec6f22d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1711,6 +1711,8 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 		if (ecap_prs(iommu->ecap))
 			intel_svm_finish_prq(iommu);
 	}
+	ioasid_unregister_allocator(&iommu->pasid_allocator);
+
 #endif
 }
 
@@ -4811,6 +4813,46 @@ static int __init platform_optin_force_iommu(void)
 	return 1;
 }
 
+static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max, void *data)
+{
+	struct intel_iommu *iommu = data;
+	ioasid_t ioasid;
+
+	/*
+	 * VT-d virtual command interface always uses the full 20 bit
+	 * PASID range. Host can partition guest PASID range based on
+	 * policies but it is out of guest's control.
+	 */
+	if (min < PASID_MIN || max > PASID_MAX)
+		return -EINVAL;
+
+	if (vcmd_alloc_pasid(iommu, &ioasid))
+		return INVALID_IOASID;
+
+	return ioasid;
+}
+
+static int intel_ioasid_free(ioasid_t ioasid, void *data)
+{
+	struct iommu_pasid_alloc_info *svm;
+	struct intel_iommu *iommu = data;
+
+	if (!iommu || !cap_caching_mode(iommu->cap))
+		return -EINVAL;
+	/*
+	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
+	 * We can only free the PASID when all the devices are unbond.
+	 */
+	svm = ioasid_find(NULL, ioasid, NULL);
+	if (!svm) {
+		pr_warn("Freeing unbond IOASID %d\n", ioasid);
+		return -EBUSY;
+	}
+	vcmd_free_pasid(iommu, ioasid);
+
+	return 0;
+}
+
 int __init intel_iommu_init(void)
 {
 	int ret = -ENODEV;
@@ -4912,6 +4954,22 @@ int __init intel_iommu_init(void)
 				       "%s", iommu->name);
 		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
 		iommu_device_register(&iommu->iommu);
+		if (cap_caching_mode(iommu->cap) && sm_supported(iommu)) {
+			/*
+			 * Register a custom ASID allocator if we are running
+			 * in a guest, the purpose is to have a system wide PASID
+			 * namespace among all PASID users.
+			 * There can be multiple vIOMMUs in each guest but only
+			 * one allocator is active. All vIOMMU allocators will
+			 * eventually be calling the same host allocator.
+			 */
+			iommu->pasid_allocator.alloc = intel_ioasid_alloc;
+			iommu->pasid_allocator.free = intel_ioasid_free;
+			iommu->pasid_allocator.pdata = (void *)iommu;
+			ret = ioasid_register_allocator(&iommu->pasid_allocator);
+			if (ret)
+				pr_warn("Custom PASID allocator registeration failed\n");
+		}
 	}
 
 	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index bff907b..c24c8aa 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -31,6 +31,7 @@
 #include <linux/iommu.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmar.h>
+#include <linux/ioasid.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -549,6 +550,7 @@ struct intel_iommu {
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
+	struct ioasid_allocator pasid_allocator; /* Custom allocator for PASIDs */
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
 	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
