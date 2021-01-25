Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13AAC433DB
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 02:47:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1EA22AAA
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 02:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1EA22AAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 04602858FB;
	Mon, 25 Jan 2021 02:47:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gS6I0bX7xhOj; Mon, 25 Jan 2021 02:47:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4261B858D2;
	Mon, 25 Jan 2021 02:47:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B761C0FA7;
	Mon, 25 Jan 2021 02:47:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC3BFC013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 02:47:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C7F67858D2
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 02:47:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id swzYvUpez4yL for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 02:47:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BF148858C9
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 02:47:36 +0000 (UTC)
IronPort-SDR: wJn4/5EsOcd+yP1U0MWS2zf9UOAvYDxu9qS+WNBUeVcvcPi4YFFXZ5/defo7yiC4DdtAGEHmgF
 He4L5L2zEa9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="176142170"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; d="scan'208";a="176142170"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2021 18:47:36 -0800
IronPort-SDR: x7HRqFj5xsoSTHE05NV8EafOZokIzGjLPEFXkarHHMUHy2xo9RF9gVYhDY8Nuv0CrfDKxF1Ty3
 8QpqnD+Dh3Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; d="scan'208";a="429029417"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by orsmga001.jf.intel.com with ESMTP; 24 Jan 2021 18:47:34 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Chuck Lever <chuck.lever@oracle.com>
Subject: [RFT PATCH 0/3] Performance regression noted in v5.11-rc after
 c062db039f40
Date: Mon, 25 Jan 2021 10:38:55 +0800
Message-Id: <20210125023858.570175-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

This patch series is only for Request-For-Testing purpose. It aims to
fix the performance regression reported here.

https://lore.kernel.org/linux-iommu/D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com/

The first two patches are borrowed from here.

https://lore.kernel.org/linux-iommu/20210107122909.16317-1-yong.wu@mediatek.com/

Please kindly help to verification.

Best regards,
baolu

Lu Baolu (1):
  iommu/vt-d: Add iotlb_sync_map callback

Yong Wu (2):
  iommu: Move iotlb_sync_map out from __iommu_map
  iommu: Add iova and size as parameters in iotlb_sync_map

 drivers/iommu/intel/iommu.c | 86 +++++++++++++++++++++++++------------
 drivers/iommu/iommu.c       | 23 +++++++---
 drivers/iommu/tegra-gart.c  |  7 ++-
 include/linux/iommu.h       |  3 +-
 4 files changed, 83 insertions(+), 36 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
