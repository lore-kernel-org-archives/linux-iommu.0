Return-Path: <SRS0=Juc9=WR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84D8C3A589
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 02:46:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CFC22CE3
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 02:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CFC22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6ECECAD1;
	Wed, 21 Aug 2019 02:46:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 181FB41C
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 02:46:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 95E7B89B
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 02:46:00 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 Aug 2019 19:46:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,410,1559545200"; d="scan'208";a="329890096"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
	by orsmga004.jf.intel.com with ESMTP; 20 Aug 2019 19:45:59 -0700
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 2/4] iommu: Add device_def_domain_type() call back function to
	iommu_ops
Date: Tue, 20 Aug 2019 19:42:17 -0700
Message-Id: <c60289c168f7c9d90637f37f842deba7133d4078.1566353521.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1566353521.git.sai.praneeth.prakhya@intel.com>
References: <cover.1566353521.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

When user requests kernel to change the default domain type of a group
through sysfs, kernel has to make sure that it's ok to change the domain
type of every device in the group to the requested domain (every device may
not support both the domain types i.e. DMA and identity). Hence, add a call
back function that could be implemented per architecture that performs the
above check.

For intel_iommu, this is already done by device_def_domain_type(), but
every call back function in intel_iommu_ops starts with intel_iommu prefix,
hence modify device_def_domain_type() so that it follows the same
semantics.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 drivers/iommu/intel-iommu.c | 9 ++++++---
 include/linux/iommu.h       | 4 ++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 27c3c893530a..3e8655197aad 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2868,7 +2868,7 @@ static bool device_is_rmrr_locked(struct device *dev)
  *  - IOMMU_DOMAIN_IDENTITY: Device should always be in identity mapping domain
  *  - 0: Device could be in any domain (i.e. identity or dynamic)
  */
-static int device_def_domain_type(struct device *dev)
+static int intel_iommu_device_def_domain_type(struct device *dev)
 {
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
@@ -5297,7 +5297,8 @@ static int intel_iommu_add_device(struct device *dev)
 	domain = iommu_get_domain_for_dev(dev);
 	dmar_domain = to_dmar_domain(domain);
 	if (domain->type == IOMMU_DOMAIN_DMA) {
-		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
+		if (intel_iommu_device_def_domain_type(dev) ==
+		    IOMMU_DOMAIN_IDENTITY) {
 			ret = iommu_request_dm_for_dev(dev);
 			if (ret) {
 				dmar_remove_one_dev_info(dev);
@@ -5308,7 +5309,8 @@ static int intel_iommu_add_device(struct device *dev)
 			}
 		}
 	} else {
-		if (device_def_domain_type(dev) == IOMMU_DOMAIN_DMA) {
+		if (intel_iommu_device_def_domain_type(dev) ==
+		    IOMMU_DOMAIN_DMA) {
 			ret = iommu_request_dma_domain_for_dev(dev);
 			if (ret) {
 				dmar_remove_one_dev_info(dev);
@@ -5652,6 +5654,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.dev_enable_feat	= intel_iommu_dev_enable_feat,
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
+	.device_def_domain_type	= intel_iommu_device_def_domain_type,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 64ebaff33455..ae4755ad2937 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -244,6 +244,8 @@ struct iommu_iotlb_gather {
  * @sva_unbind: Unbind process address space from device
  * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
+ * @device_def_domain_type: Return the possible default domain types a device
+ * 			    could have.
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
@@ -307,6 +309,8 @@ struct iommu_ops {
 			     struct iommu_fault_event *evt,
 			     struct iommu_page_response *msg);
 
+	int (*device_def_domain_type)(struct device *dev);
+
 	unsigned long pgsize_bitmap;
 };
 
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
