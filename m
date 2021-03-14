Return-Path: <SRS0=2lDQ=IM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDC4C433E0
	for <iommu@archiver.kernel.org>; Sun, 14 Mar 2021 20:17:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C6964EB6
	for <iommu@archiver.kernel.org>; Sun, 14 Mar 2021 20:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C6964EB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B73F6F4E5;
	Sun, 14 Mar 2021 20:17:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7H-9SzDPejEw; Sun, 14 Mar 2021 20:17:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57D876F494;
	Sun, 14 Mar 2021 20:17:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30A39C000B;
	Sun, 14 Mar 2021 20:17:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22CC4C0001
 for <iommu@lists.linux-foundation.org>; Sun, 14 Mar 2021 20:17:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0466083A42
 for <iommu@lists.linux-foundation.org>; Sun, 14 Mar 2021 20:17:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z7JJtgDre4tg for <iommu@lists.linux-foundation.org>;
 Sun, 14 Mar 2021 20:17:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 696D083A41
 for <iommu@lists.linux-foundation.org>; Sun, 14 Mar 2021 20:17:33 +0000 (UTC)
IronPort-SDR: 0mYxaMnacVzcEiIa5xzGS3HSno+C/Anp1qXRY//8EpLipqd0LA97aIQOA1MYzhMLXshQQOmpVR
 ftDHBdWCfP7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="274051617"
X-IronPort-AV: E=Sophos;i="5.81,248,1610438400"; d="scan'208";a="274051617"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2021 13:17:32 -0700
IronPort-SDR: UKg6vP2QaPF9ZOgY1ASKSPGUfhWXxvU9Btffdz5bnN7cCbQjV75xvA49XW6dH5qy0ARtWSewr3
 UhHCUiF6YCaQ==
X-IronPort-AV: E=Sophos;i="5.81,248,1610438400"; d="scan'208";a="411627303"
Received: from km-skylake-client-platform.sc.intel.com ([172.25.103.115])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2021 13:17:31 -0700
From: Kyung Min Park <kyung.min.park@intel.com>
To: iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: Disable SVM when ATS/PRI/PASID are not enabled in
 the device
Date: Sun, 14 Mar 2021 13:15:34 -0700
Message-Id: <20210314201534.918-1-kyung.min.park@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: ravi.v.shankar@intel.com, ashok.raj@intel.com, dwmw2@infradead.org,
 Kyung Min Park <kyung.min.park@intel.com>, will@kernel.org
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

Currently, the Intel VT-d supports Shared Virtual Memory (SVM) only when
IO page fault is supported. Otherwise, shared memory pages can not be
swapped out and need to be pinned. The device needs the Address Translation
Service (ATS), Page Request Interface (PRI) and Process Address Space
Identifier (PASID) capabilities to be enabled to support IO page fault.

Disable SVM when ATS, PRI and PASID are not enabled in the device.

Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
---
 drivers/iommu/intel/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ee0932307d64..956a02eb40b4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5380,6 +5380,9 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 		if (!info)
 			return -EINVAL;
 
+		if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
+			return -EINVAL;
+
 		if (info->iommu->flags & VTD_FLAG_SVM_CAPABLE)
 			return 0;
 	}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
