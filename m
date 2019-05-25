Return-Path: <SRS0=lyO4=TZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FFCC282CE
	for <iommu@archiver.kernel.org>; Sat, 25 May 2019 05:50:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1302621848
	for <iommu@archiver.kernel.org>; Sat, 25 May 2019 05:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1302621848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 01280DB4;
	Sat, 25 May 2019 05:49:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AB31ADAC
	for <iommu@lists.linux-foundation.org>;
	Sat, 25 May 2019 05:49:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 39C68A9
	for <iommu@lists.linux-foundation.org>;
	Sat, 25 May 2019 05:49:11 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 May 2019 22:49:11 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:49:08 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 12/15] iommu/vt-d: Cleanup get_valid_domain_for_dev()
Date: Sat, 25 May 2019 13:41:33 +0800
Message-Id: <20190525054136.27810-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, dima@arista.com,
	tmurphy@arista.com, linux-kernel@vger.kernel.org,
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

Previously, get_valid_domain_for_dev() is used to retrieve the
DMA domain which has been attached to the device or allocate one
if no domain has been attached yet. As we have delegated the DMA
domain management to upper layer, this function is used purely to
allocate a private DMA domain if the default domain doesn't work
for ths device. Cleanup the code for readability.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 18 ++++++++----------
 include/linux/intel-iommu.h |  1 -
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b93d328fcceb..59cd8b7e793f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2636,7 +2636,6 @@ static struct dmar_domain *find_or_alloc_domain(struct device *dev, int gaw)
 	}
 
 out:
-
 	return domain;
 }
 
@@ -3586,16 +3585,17 @@ static unsigned long intel_alloc_iova(struct device *dev,
 	return iova_pfn;
 }
 
-struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
+static struct dmar_domain *get_private_domain_for_dev(struct device *dev)
 {
 	struct dmar_domain *domain, *tmp;
 	struct dmar_rmrr_unit *rmrr;
 	struct device *i_dev;
 	int i, ret;
 
+	/* Device shouldn't be attached by any domains. */
 	domain = find_domain(dev);
 	if (domain)
-		goto out;
+		return NULL;
 
 	domain = find_or_alloc_domain(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
 	if (!domain)
@@ -3625,11 +3625,9 @@ struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
 	}
 
 out:
-
 	if (!domain)
 		dev_err(dev, "Allocating domain failed\n");
 
-
 	return domain;
 }
 
@@ -3666,7 +3664,7 @@ static bool iommu_need_mapping(struct device *dev)
 				dmar_domain = to_dmar_domain(domain);
 				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
 			}
-			get_valid_domain_for_dev(dev);
+			get_private_domain_for_dev(dev);
 		}
 
 		dev_info(dev, "32bit DMA uses non-identity mapping\n");
@@ -3688,7 +3686,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 
 	BUG_ON(dir == DMA_NONE);
 
-	domain = get_valid_domain_for_dev(dev);
+	domain = find_domain(dev);
 	if (!domain)
 		return DMA_MAPPING_ERROR;
 
@@ -3903,7 +3901,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	if (!iommu_need_mapping(dev))
 		return dma_direct_map_sg(dev, sglist, nelems, dir, attrs);
 
-	domain = get_valid_domain_for_dev(dev);
+	domain = find_domain(dev);
 	if (!domain)
 		return 0;
 
@@ -5570,7 +5568,7 @@ static int intel_iommu_add_device(struct device *dev)
 			ret = iommu_request_dma_domain_for_dev(dev);
 			if (ret) {
 				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
-				if (!get_valid_domain_for_dev(dev)) {
+				if (!get_private_domain_for_dev(dev)) {
 					dev_warn(dev,
 						 "Failed to get a private domain.\n");
 					return -ENOMEM;
@@ -5681,7 +5679,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	u64 ctx_lo;
 	int ret;
 
-	domain = get_valid_domain_for_dev(dev);
+	domain = find_domain(dev);
 	if (!domain)
 		return -EINVAL;
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 6925a18a5ca3..ef2d0e2df1f3 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -654,7 +654,6 @@ extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
 
 extern int dmar_ir_support(void);
 
-struct dmar_domain *get_valid_domain_for_dev(struct device *dev);
 void *alloc_pgtable_page(int node);
 void free_pgtable_page(void *vaddr);
 struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
