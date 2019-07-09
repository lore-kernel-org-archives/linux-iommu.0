Return-Path: <SRS0=Vhad=VG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BEBC606B0
	for <iommu@archiver.kernel.org>; Tue,  9 Jul 2019 05:31:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D207E214AF
	for <iommu@archiver.kernel.org>; Tue,  9 Jul 2019 05:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D207E214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8D94D2E91;
	Tue,  9 Jul 2019 05:31:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C592A2E3D
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Jul 2019 05:23:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 11F81826
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Jul 2019 05:23:15 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Jul 2019 22:23:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,469,1557212400"; d="scan'208";a="188721465"
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by fmsmga004.fm.intel.com with ESMTP; 08 Jul 2019 22:23:13 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 1/1] iommu/vt-d: Avoid duplicated pci dma alias consideration
Date: Tue,  9 Jul 2019 13:22:45 +0800
Message-Id: <20190709052245.28882-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

As we have abandoned the home-made lazy domain allocation
and delegated the DMA domain life cycle up to the default
domain mechanism defined in the generic iommu layer, we
needn't consider pci alias anymore when mapping/unmapping
the context entries. Without this fix, we see kernel NULL
pointer dereference during pci device hot-plug test.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Fixes: fa954e6831789 ("iommu/vt-d: Delegate the dma domain to upper layer")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reported-and-tested-by: Xu Pengfei <pengfei.xu@intel.com>
---
 drivers/iommu/intel-iommu.c | 55 ++-----------------------------------
 1 file changed, 2 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 7625702b2143..71cbca04c622 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -348,8 +348,6 @@ static void domain_exit(struct dmar_domain *domain);
 static void domain_remove_dev_info(struct dmar_domain *domain);
 static void dmar_remove_one_dev_info(struct device *dev);
 static void __dmar_remove_one_dev_info(struct device_domain_info *info);
-static void domain_context_clear(struct intel_iommu *iommu,
-				 struct device *dev);
 static int domain_detach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu);
 static bool device_is_rmrr_locked(struct device *dev);
@@ -2040,26 +2038,9 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	return ret;
 }
 
-struct domain_context_mapping_data {
-	struct dmar_domain *domain;
-	struct intel_iommu *iommu;
-	struct pasid_table *table;
-};
-
-static int domain_context_mapping_cb(struct pci_dev *pdev,
-				     u16 alias, void *opaque)
-{
-	struct domain_context_mapping_data *data = opaque;
-
-	return domain_context_mapping_one(data->domain, data->iommu,
-					  data->table, PCI_BUS_NUM(alias),
-					  alias & 0xff);
-}
-
 static int
 domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 {
-	struct domain_context_mapping_data data;
 	struct pasid_table *table;
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
@@ -2069,17 +2050,7 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 		return -ENODEV;
 
 	table = intel_pasid_get_table(dev);
-
-	if (!dev_is_pci(dev))
-		return domain_context_mapping_one(domain, iommu, table,
-						  bus, devfn);
-
-	data.domain = domain;
-	data.iommu = iommu;
-	data.table = table;
-
-	return pci_for_each_dma_alias(to_pci_dev(dev),
-				      &domain_context_mapping_cb, &data);
+	return domain_context_mapping_one(domain, iommu, table, bus, devfn);
 }
 
 static int domain_context_mapped_cb(struct pci_dev *pdev,
@@ -4738,28 +4709,6 @@ int __init intel_iommu_init(void)
 	return ret;
 }
 
-static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *opaque)
-{
-	struct intel_iommu *iommu = opaque;
-
-	domain_context_clear_one(iommu, PCI_BUS_NUM(alias), alias & 0xff);
-	return 0;
-}
-
-/*
- * NB - intel-iommu lacks any sort of reference counting for the users of
- * dependent devices.  If multiple endpoints have intersecting dependent
- * devices, unbinding the driver from any one of them will possibly leave
- * the others unable to operate.
- */
-static void domain_context_clear(struct intel_iommu *iommu, struct device *dev)
-{
-	if (!iommu || !dev || !dev_is_pci(dev))
-		return;
-
-	pci_for_each_dma_alias(to_pci_dev(dev), &domain_context_clear_one_cb, iommu);
-}
-
 static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 {
 	struct dmar_domain *domain;
@@ -4780,7 +4729,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 					PASID_RID2PASID);
 
 		iommu_disable_dev_iotlb(info);
-		domain_context_clear(iommu, info->dev);
+		domain_context_clear_one(iommu, info->bus, info->devfn);
 		intel_pasid_free_table(info->dev);
 	}
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
