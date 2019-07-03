Return-Path: <SRS0=mxFs=VA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9892EC5B57D
	for <iommu@archiver.kernel.org>; Wed,  3 Jul 2019 01:57:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7784D2064A
	for <iommu@archiver.kernel.org>; Wed,  3 Jul 2019 01:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7784D2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1E43B11B7;
	Wed,  3 Jul 2019 01:57:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 159C911A1
	for <iommu@lists.linux-foundation.org>;
	Wed,  3 Jul 2019 01:57:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7F6C270D
	for <iommu@lists.linux-foundation.org>;
	Wed,  3 Jul 2019 01:57:10 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	02 Jul 2019 18:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,445,1557212400"; d="scan'208";a="190875056"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
	by fmsmga002.fm.intel.com with ESMTP; 02 Jul 2019 18:57:10 -0700
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH RFC 2/4] iommu: Add device_def_domain_type() call back
	function to iommu_ops
Date: Tue,  2 Jul 2019 18:54:00 -0700
Message-Id: <64808094f11b98a46fb7f74b333c8f34546cefcf.1562116655.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1562116655.git.sai.praneeth.prakhya@intel.com>
References: <cover.1562116655.git.sai.praneeth.prakhya@intel.com>
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
through sysfs, kernel has to make sure if it's ok to change the domain type
of every device in the group to the requested domain (every device may not
support both the domain types i.e. DMA and identity). Hence, add a call
back function that could be implemented per architecture that performs the
above check.

For intel_iommu, this is already done by device_def_domain_type(), but
every call back function in intel_iommu_ops starts with intel_iommu prefix,
hence modify device_def_domain_type() so that it follows the same semantics.

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
 include/linux/iommu.h       | 3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 54e82415e396..0c991eb5034a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2874,7 +2874,7 @@ static bool device_is_rmrr_locked(struct device *dev)
  *  - IOMMU_DOMAIN_IDENTITY: device requires an identical mapping domain
  *  - 0: both identity and dynamic domains work for this device
  */
-static int device_def_domain_type(struct device *dev, bool startup)
+static int intel_iommu_device_def_domain_type(struct device *dev, bool startup)
 {
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
@@ -5286,7 +5286,8 @@ static int intel_iommu_add_device(struct device *dev)
 	domain = iommu_get_domain_for_dev(dev);
 	dmar_domain = to_dmar_domain(domain);
 	if (domain->type == IOMMU_DOMAIN_DMA) {
-		if (device_def_domain_type(dev, true) == IOMMU_DOMAIN_IDENTITY) {
+		if (intel_iommu_device_def_domain_type(dev, true) ==
+		    IOMMU_DOMAIN_IDENTITY) {
 			ret = iommu_request_dm_for_dev(dev);
 			if (ret) {
 				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
@@ -5296,7 +5297,8 @@ static int intel_iommu_add_device(struct device *dev)
 			}
 		}
 	} else {
-		if (device_def_domain_type(dev, true) == IOMMU_DOMAIN_DMA) {
+		if (intel_iommu_device_def_domain_type(dev, true) ==
+		    IOMMU_DOMAIN_DMA) {
 			ret = iommu_request_dma_domain_for_dev(dev);
 			if (ret) {
 				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
@@ -5637,6 +5639,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.dev_enable_feat	= intel_iommu_dev_enable_feat,
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
+	.device_def_domain_type	= intel_iommu_device_def_domain_type,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fdc355ccc570..2d172c02be05 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -228,6 +228,7 @@ struct iommu_sva_ops {
  * @sva_unbind: Unbind process address space from device
  * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
+ * @device_def_domain_type: Return the required default domain type for a device
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
@@ -292,6 +293,8 @@ struct iommu_ops {
 			     struct iommu_fault_event *evt,
 			     struct iommu_page_response *msg);
 
+	int (*device_def_domain_type)(struct device *dev, bool startup);
+
 	unsigned long pgsize_bitmap;
 };
 
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
