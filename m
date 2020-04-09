Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34FBC2BA19
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 19:32:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A1220757
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 19:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A1220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 34AB286B88;
	Thu,  9 Apr 2020 19:32:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L3ZNOGwm2Ijd; Thu,  9 Apr 2020 19:32:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 79BD18688B;
	Thu,  9 Apr 2020 19:32:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71F69C1D7E;
	Thu,  9 Apr 2020 19:32:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89260C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 19:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7672087BC8
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 19:32:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HTA7Q63p4Vr5 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 19:32:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B050D87BA6
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 19:32:24 +0000 (UTC)
IronPort-SDR: RtrJ3GmSY82K/mDMePYxRBmavEDyN7AmVHZ3Ib/x7hW588jliOsE9Ylr47DK0udUReailgQA1H
 7NJAk32DW+tw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 12:32:22 -0700
IronPort-SDR: NsKuVCbtdb3MPecg44vsYfhNG+3sk53k7GhNkwnAmaiK2NgdQrYz/IiIojtt88S1EBF5L8dG56
 SKSPuxuAsyxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; d="scan'208";a="452116453"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.40])
 by fmsmga005.fm.intel.com with ESMTP; 09 Apr 2020 12:32:22 -0700
From: Jon Derrick <jonathan.derrick@intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	<iommu@lists.linux-foundation.org>
Subject: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices and
 subdevices
Date: Thu,  9 Apr 2020 15:17:36 -0400
Message-Id: <20200409191736.6233-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200409191736.6233-1-jonathan.derrick@intel.com>
References: <20200409191736.6233-1-jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux@endlessm.com,
 Jon Derrick <jonathan.derrick@intel.com>
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

The PCI devices handled by intel-iommu may have a DMA requester on another bus,
such as VMD subdevices needing to use the VMD endpoint.

The real DMA device is now used for the DMA mapping, but one case was missed
earlier: if the VMD device (and hence subdevices too) are under
IOMMU_DOMAIN_IDENTITY, mappings do not work.

Codepaths like intel_map_page() handle the IOMMU_DOMAIN_DMA case by creating an
iommu DMA mapping, and fall back on dma_direct_map_page() for the
IOMMU_DOMAIN_IDENTITY case. However, handling of the IDENTITY case is broken
when intel_page_page() handles a subdevice.

We observe that at iommu attach time, dmar_insert_one_dev_info() for the
subdevices will never set dev->archdata.iommu. This is because that function
uses find_domain() to check if there is already an IOMMU for the device, and
find_domain() then defers to the real DMA device which does have one. Thus
dmar_insert_one_dev_info() returns without assigning dev->archdata.iommu.

Then, later:

1. intel_map_page() checks if an IOMMU mapping is needed by calling
   iommu_need_mapping() on the subdevice. identity_mapping() returns
   false because dev->archdata.iommu is NULL, so this function
   returns false indicating that mapping is needed.
2. __intel_map_single() is called to create the mapping.
3. __intel_map_single() calls find_domain(). This function now returns
   the IDENTITY domain corresponding to the real DMA device.
4. __intel_map_single() calls domain_get_iommu() on this "real" domain.
   A failure is hit and the entire operation is aborted, because this
   codepath is not intended to handle IDENTITY mappings:
       if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
                   return NULL;

This becomes problematic if the real DMA device and the subdevices have
different addressing capabilities and some require translation. Instead we can
put the real DMA dev and any subdevices on the DMA domain. This change assigns
subdevices to the DMA domain, and moves the real DMA device to the DMA domain
if necessary.

Reported-by: Daniel Drake <drake@endlessm.com>
Fixes: b0140c69637e ("iommu/vt-d: Use pci_real_dma_dev() for mapping")
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/iommu/intel-iommu.c | 56 ++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ef0a5246700e..b4844a502499 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3049,6 +3049,9 @@ static int device_def_domain_type(struct device *dev)
 		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
 			return IOMMU_DOMAIN_IDENTITY;
 
+		if (pci_real_dma_dev(pdev) != pdev)
+			return IOMMU_DOMAIN_DMA;
+
 		/*
 		 * We want to start off with all devices in the 1:1 domain, and
 		 * take them out later if we find they can't access all of memory.
@@ -5781,12 +5784,32 @@ static bool intel_iommu_capable(enum iommu_cap cap)
 	return false;
 }
 
+static int intel_iommu_request_dma_domain_for_dev(struct device *dev,
+                                                  struct dmar_domain *domain)
+{
+	int ret;
+
+	ret = iommu_request_dma_domain_for_dev(dev);
+	if (ret) {
+		dmar_remove_one_dev_info(dev);
+		domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
+		if (!get_private_domain_for_dev(dev)) {
+			dev_warn(dev,
+				 "Failed to get a private domain.\n");
+				return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 static int intel_iommu_add_device(struct device *dev)
 {
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
 	struct iommu_group *group;
+	struct device *real_dev = dev;
 	u8 bus, devfn;
 	int ret;
 
@@ -5810,6 +5833,21 @@ static int intel_iommu_add_device(struct device *dev)
 
 	domain = iommu_get_domain_for_dev(dev);
 	dmar_domain = to_dmar_domain(domain);
+
+	if (dev_is_pci(dev))
+		real_dev = &pci_real_dma_dev(to_pci_dev(dev))->dev;
+
+	if (real_dev != dev) {
+		domain = iommu_get_domain_for_dev(real_dev);
+		if (domain->type != IOMMU_DOMAIN_DMA) {
+			dmar_remove_one_dev_info(real_dev);
+
+			ret = intel_iommu_request_dma_domain_for_dev(real_dev, dmar_domain);
+			if (ret)
+				goto unlink;
+		}
+	}
+
 	if (domain->type == IOMMU_DOMAIN_DMA) {
 		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
 			ret = iommu_request_dm_for_dev(dev);
@@ -5823,20 +5861,12 @@ static int intel_iommu_add_device(struct device *dev)
 		}
 	} else {
 		if (device_def_domain_type(dev) == IOMMU_DOMAIN_DMA) {
-			ret = iommu_request_dma_domain_for_dev(dev);
-			if (ret) {
-				dmar_remove_one_dev_info(dev);
-				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
-				if (!get_private_domain_for_dev(dev)) {
-					dev_warn(dev,
-						 "Failed to get a private domain.\n");
-					ret = -ENOMEM;
-					goto unlink;
-				}
+			ret = intel_iommu_request_dma_domain_for_dev(dev, dmar_domain);
+			if (ret)
+				goto unlink;
 
-				dev_info(dev,
-					 "Device uses a private dma domain.\n");
-			}
+			dev_info(dev,
+				 "Device uses a private dma domain.\n");
 		}
 	}
 
-- 
2.18.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
