Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C1DC47420
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 19:06:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD35221E5
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 19:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD35221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CB76C86D8B;
	Fri, 25 Sep 2020 19:06:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s1DAiwQZJ4aQ; Fri, 25 Sep 2020 19:06:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5504A86D8D;
	Fri, 25 Sep 2020 19:06:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B9D8C0891;
	Fri, 25 Sep 2020 19:06:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8C45C0051
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 19:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E34FE872C7
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 19:06:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EcFkoX0dRBPJ for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 19:06:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 15D0487322
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 19:06:28 +0000 (UTC)
IronPort-SDR: eyrXMAZjXt9EaZYYO32OhlepceHsMfHrOgTXx31YmgfAnExHNokmNjUfOpC4vHRKGOOQlq76ws
 N7GKDnavn7oQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="162505421"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; d="scan'208";a="162505421"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2020 12:06:27 -0700
IronPort-SDR: hyZXh2U2XdMDR+yitQyAytpiS/aRm/9ZAfMWsKTkUj1p05/5iF3vCMeLcTMdCzQnUQtSDqAr0v
 WniiPnpZC4Ug==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; d="scan'208";a="310944880"
Received: from araj-mobl1.jf.intel.com (HELO localhost) ([10.254.96.12])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2020 12:06:26 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux-foundation.org
Subject: [Patch V8 3/3] iommu: Document usage of
 "/sys/kernel/iommu_groups/<grp_id>/type" file
Date: Fri, 25 Sep 2020 12:06:20 -0700
Message-Id: <20200925190620.18732-4-ashok.raj@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20200925190620.18732-1-ashok.raj@intel.com>
References: <20200925190620.18732-1-ashok.raj@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

The default domain type of an iommu group can be changed by writing to
"/sys/kernel/iommu_groups/<grp_id>/type" file. Hence, document it's usage
and more importantly spell out its limitations.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 .../ABI/testing/sysfs-kernel-iommu_groups          | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
index 017f5bc3920c..effde9d23f4f 100644
--- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
+++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
@@ -33,3 +33,33 @@ Description:    In case an RMRR is used only by graphics or USB devices
 		it is now exposed as "direct-relaxable" instead of "direct".
 		In device assignment use case, for instance, those RMRR
 		are considered to be relaxable and safe.
+
+What:		/sys/kernel/iommu_groups/<grp_id>/type
+Date:		September 2020
+KernelVersion:	v5.10
+Contact:	Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
+Description:	Let the user know the type of default domain in use by iommu
+		for this group. A privileged user could request kernel to change
+		the group type by writing to this file. Presently, only three
+		types are supported
+		1. DMA: All the DMA transactions from the device in this group
+			are translated by the iommu.
+		2. identity: All the DMA transactions from the device in this
+			     group are *not* translated by the iommu.
+		3. auto: Change to the type the device was booted with. When the
+			 user reads the file he would never see "auto". This is
+			 just a write only value.
+		Note:
+		-----
+		A group type could be modified only when
+		1. The group has *only* one device
+		2. The device in the group is not bound to any device driver.
+		   So, the user must first unbind the appropriate driver and
+		   then change the default domain type.
+		Caution:
+		--------
+		Unbinding a device driver will take away the driver's control
+		over the device and if done on devices that host root file
+		system could lead to catastrophic effects (the user might
+		need to reboot the machine to get it to normal state). So, it's
+		expected that the user understands what he is doing.
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
