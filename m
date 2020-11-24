Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B599C2D0E4
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 13:13:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1E92073C
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 13:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1E92073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B77E521537;
	Tue, 24 Nov 2020 13:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FFGGF4e5zV1p; Tue, 24 Nov 2020 13:13:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 79CDC214EC;
	Tue, 24 Nov 2020 13:13:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64F41C1833;
	Tue, 24 Nov 2020 13:13:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D307DC0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 13:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C282F85F18
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 13:13:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bwFR_toMcaz4 for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 13:13:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2D0F885DFF
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 13:13:42 +0000 (UTC)
IronPort-SDR: Jinz47nRdf8Dbk4abYeS3+zQTeT22jKCQgA3U3mnk6kRbZQycjGNMwDZtEmLcup9zDsMhz5pfP
 zwYE4Xo1ef4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172037967"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; d="scan'208";a="172037967"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2020 05:13:41 -0800
IronPort-SDR: p352IUKdUSa4CW99elVa4dDgS5dHCMYct8EWcV321HWlofmsqJw0BU6R32hdp7a8zcqZWwGdtL
 8ZPgAfmBn0Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; d="scan'208";a="432602256"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2020 05:13:39 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v10 4/4] iommu: Document usage of
 "/sys/kernel/iommu_groups/<grp_id>/type" file
Date: Tue, 24 Nov 2020 21:06:04 +0800
Message-Id: <20201124130604.2912899-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124130604.2912899-1-baolu.lu@linux.intel.com>
References: <20201124130604.2912899-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org,
 Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

The default domain type of an iommu group can be changed by writing to
"/sys/kernel/iommu_groups/<grp_id>/type" file. Hence, document it's usage
and more importantly spell out its limitations.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 .../ABI/testing/sysfs-kernel-iommu_groups     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
index 017f5bc3920c..407b1628d7fd 100644
--- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
+++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
@@ -33,3 +33,32 @@ Description:    In case an RMRR is used only by graphics or USB devices
 		it is now exposed as "direct-relaxable" instead of "direct".
 		In device assignment use case, for instance, those RMRR
 		are considered to be relaxable and safe.
+
+What:		/sys/kernel/iommu_groups/<grp_id>/type
+Date:		November 2020
+KernelVersion:	v5.11
+Contact:	Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
+Description:	/sys/kernel/iommu_groups/<grp_id>/type shows the type of default
+		domain in use by iommu for this group. See include/linux/iommu.h
+		for possible values. A privileged user could request kernel to
+		change the group type by writing to this file. Presently, only
+		three types of request are supported:
+		1. DMA: All the DMA transactions from the device in this group
+			are translated by the iommu.
+		2. identity: All the DMA transactions from the device in this
+			     group are *not* translated by the iommu.
+		3. auto: Change to the type the device was booted with.
+		Note:
+		-----
+		The default domain type of a group may be modified only when
+		1. The group has *only* one device
+		2. The device in the group is not bound to any device driver.
+		   So, the users must unbind the appropriate driver before
+		   changing the default domain type.
+		Caution:
+		--------
+		Unbinding a device driver will take away the driver's control
+		over the device and if done on devices that host root file
+		system could lead to catastrophic effects (the users might
+		need to reboot the machine to get it to normal state). So, it's
+		expected that the users understand what they're doing.
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
