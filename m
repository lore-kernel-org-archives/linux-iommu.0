Return-Path: <SRS0=3/Zu=FA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372E9C6379D
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 10:11:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B35208CA
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 10:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B35208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2EDA8876BA;
	Thu, 26 Nov 2020 10:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k6aet6s9Tcrk; Thu, 26 Nov 2020 10:11:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C9AFD8758C;
	Thu, 26 Nov 2020 10:11:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC0E7C163C;
	Thu, 26 Nov 2020 10:11:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B012AC0052
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 10:11:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9F60287290
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 10:11:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q72i8zIEIOKi for <iommu@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 10:11:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D8BAC87287
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 10:11:17 +0000 (UTC)
IronPort-SDR: XE+aXeKdjkgnaInwf3V9hRHmlWjVY/HRxLsTGcoG8HBh+SiMF8G/pD/XIpo39w6qA+5ieBF0op
 yPLyx6yw/xNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="160030533"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; d="scan'208";a="160030533"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2020 01:13:25 -0800
IronPort-SDR: 1W98j++zDlKY+Uyu1ROvcdDJOJF1MCSg4O2+mApuDwET4gmPwUg6O9xBS/6ofTHijiyvhxdySz
 a6EHzU3NcBqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; d="scan'208";a="433221130"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2020 01:13:23 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu: Fix htmldocs warnings in sysfs-kernel-iommu_groups
Date: Thu, 26 Nov 2020 17:06:03 +0800
Message-Id: <20201126090603.1511589-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

Below warnings are fixed:

Documentation/ABI/testing/sysfs-kernel-iommu_groups:38: WARNING: Unexpected indentation.
Documentation/ABI/testing/sysfs-kernel-iommu_groups:38: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/ABI/testing/sysfs-kernel-iommu_groups:38: WARNING: Enumerated list ends without a blank line; unexpected unindent.
Documentation/ABI/testing/sysfs-kernel-iommu_groups:38: WARNING: Unexpected indentation.
Documentation/ABI/testing/sysfs-kernel-iommu_groups:38: WARNING: Block quote ends without a blank line; unexpected unindent.

Fixes: 63a816749d86 ("iommu: Document usage of "/sys/kernel/iommu_groups/<grp_id>/type" file")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/linux-next/20201126174851.200e0e58@canb.auug.org.au/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 .../ABI/testing/sysfs-kernel-iommu_groups     | 33 ++++++++++---------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
index 407b1628d7fd..0fedbb0f94e4 100644
--- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
+++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
@@ -40,23 +40,24 @@ KernelVersion:	v5.11
 Contact:	Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
 Description:	/sys/kernel/iommu_groups/<grp_id>/type shows the type of default
 		domain in use by iommu for this group. See include/linux/iommu.h
-		for possible values. A privileged user could request kernel to
-		change the group type by writing to this file. Presently, only
-		three types of request are supported:
-		1. DMA: All the DMA transactions from the device in this group
-			are translated by the iommu.
-		2. identity: All the DMA transactions from the device in this
-			     group are *not* translated by the iommu.
-		3. auto: Change to the type the device was booted with.
-		Note:
-		-----
+		for possible read values. A privileged user could request kernel to
+		change the group type by writing to this file. Valid write values:
+
+		========  ======================================================
+		DMA       All the DMA transactions from the device in this group
+		          are translated by the iommu.
+		identity  All the DMA transactions from the device in this group
+		          are not translated by the iommu.
+		auto      Change to the type the device was booted with.
+		========  ======================================================
+
 		The default domain type of a group may be modified only when
-		1. The group has *only* one device
-		2. The device in the group is not bound to any device driver.
-		   So, the users must unbind the appropriate driver before
-		   changing the default domain type.
-		Caution:
-		--------
+
+		- The group has only one device.
+		- The device in the group is not bound to any device driver.
+		  So, the users must unbind the appropriate driver before
+		  changing the default domain type.
+
 		Unbinding a device driver will take away the driver's control
 		over the device and if done on devices that host root file
 		system could lead to catastrophic effects (the users might
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
