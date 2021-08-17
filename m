Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39C3C4338F
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 04:26:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5926E6054E
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 04:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5926E6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11ED3404C4;
	Tue, 17 Aug 2021 04:26:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IbiSC5qbLA8l; Tue, 17 Aug 2021 04:26:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D4C4C402F2;
	Tue, 17 Aug 2021 04:26:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 980E2C0010;
	Tue, 17 Aug 2021 04:26:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72768C000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 04:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D95D83640
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 04:26:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G0i6yAWNPbLE for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 04:26:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D181835FB
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 04:26:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="215717236"
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; d="scan'208";a="215717236"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2021 21:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,327,1620716400"; d="scan'208";a="449126342"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga007.fm.intel.com with ESMTP; 16 Aug 2021 21:26:25 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: iommu@lists.linux-foundation.org,
	baolu.lu@linux.intel.com
Subject: [PATCH v1 0/3] Misc fixes to intel iommu driver
Date: Tue, 17 Aug 2021 12:24:22 +0800
Message-Id: <20210817042425.1784279-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: yi.y.sun@intel.com, jun.j.tian@intel.com
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

Hi,

This series includes two minor enhancements and one bug fix. Please have
a review.

Thanks,
Yi Liu
---

Liu Yi L (3):
  iommu/vt-d: Using pasid_pte_is_present() helper function
  iommu/vt-d: Add present bit check in pasid entry setup helper
    functions
  iommu/vt-d: Fix Unexpected page request in Privilege Mode

 drivers/iommu/intel/pasid.c | 28 +++++++++++++++++++++++++---
 drivers/iommu/intel/pasid.h |  5 +++++
 2 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
