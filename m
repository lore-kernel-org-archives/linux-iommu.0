Return-Path: <SRS0=mxFs=VA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBB8C5B57D
	for <iommu@archiver.kernel.org>; Wed,  3 Jul 2019 01:57:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D69B2064A
	for <iommu@archiver.kernel.org>; Wed,  3 Jul 2019 01:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D69B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 68C2011CA;
	Wed,  3 Jul 2019 01:57:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C8C1011A1
	for <iommu@lists.linux-foundation.org>;
	Wed,  3 Jul 2019 01:57:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5425470D
	for <iommu@lists.linux-foundation.org>;
	Wed,  3 Jul 2019 01:57:12 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	02 Jul 2019 18:57:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,445,1557212400"; d="scan'208";a="190875064"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
	by fmsmga002.fm.intel.com with ESMTP; 02 Jul 2019 18:57:11 -0700
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH RFC 4/4] iommu: Document usage of
	"/sys/kernel/iommu_groups/<grp_id>/type" file
Date: Tue,  2 Jul 2019 18:54:02 -0700
Message-Id: <edcaaf585e99d1f4c7d7961f3b222856c132f827.1562116655.git.sai.praneeth.prakhya@intel.com>
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

The default domain type of an iommu group can be changed using file
"/sys/kernel/iommu_groups/<grp_id>/type". Hence, document it's usage and
more importantly spell out it's limitations and an example.

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
 .../ABI/testing/sysfs-kernel-iommu_groups     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
index 017f5bc3920c..7eb1b784c5e3 100644
--- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
+++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
@@ -33,3 +33,37 @@ Description:    In case an RMRR is used only by graphics or USB devices
 		it is now exposed as "direct-relaxable" instead of "direct".
 		In device assignment use case, for instance, those RMRR
 		are considered to be relaxable and safe.
+
+What:		/sys/kernel/iommu_groups/<grp_id>/type
+Date:		July 2019
+KernelVersion:	v5.4
+Contact:	Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
+Description:	/sys/kernel/iommu_groups/<grp_id>/type lets the user know the
+		type of default domain in use by iommu for this group. A
+		privileged user could request kernel to change the group type by
+		writing to this file. Presently, only two types are supported
+		1. dma: All the DMA transactions from the devices in this group
+			are translated by the iommu.
+		2. identity: All the DMA transactions from the devices in this
+			     group are *not* translated by the iommu.
+		Note:
+		-----
+		A group type could be modified only when *all* the devices in
+		the group are not binded to any device driver. So, the user has
+		to first unbind the appropriate drivers and then change the
+		default domain type.
+		Caution:
+		--------
+		Unbinding a device driver will take away the drivers control
+		over the device and if done on devices that host root file
+		system could lead to catastrophic effects (the user might
+		need to reboot the machine to get it to normal state). So, it's
+		expected that the user understands what he is doing.
+		Example:
+		--------
+		# Unbind USB device driver
+		1. echo "0000:00:14.0" > /sys/bus/pci/drivers/xhci_hcd/unbind
+		# Put the USB device in identity mode (a.k.a pass through)
+		2. echo "identity" > /sys/kernel/iommu_groups/<grp_id>/type
+		# Re-bind the driver
+		3. echo "0000:00:14.0" > /sys/bus/pci/drivers/xhci_hcd/bind
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
