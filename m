Return-Path: <SRS0=d1gY=H3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E7BC433E0
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 06:36:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532D364ED9
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 06:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532D364ED9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECA7B4ED60;
	Thu, 25 Feb 2021 06:36:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nfaEACe6zGTy; Thu, 25 Feb 2021 06:36:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B42014ED6C;
	Thu, 25 Feb 2021 06:36:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DE04C0010;
	Thu, 25 Feb 2021 06:36:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5346C000B
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 06:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C03DC4ED54
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 06:36:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 75DAUdQVUwq4 for <iommu@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 06:36:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 247514ED60
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 06:36:03 +0000 (UTC)
IronPort-SDR: uv9YMXeENehwrCSfg/ekD3lAuovVkuwJOGc5vXPic68WQYWZx2T6QK9C6L6jUFxB31Lix72Dd0
 8ClIV+ZIeq+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="249486050"
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; d="scan'208";a="249486050"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2021 22:35:54 -0800
IronPort-SDR: 1GwWinQ2jjPBuNPzJpkyQmJkkQ3fVDQv9Wh/e/GnXeiZu9TMEtpEXsiRLxom07nLA6+rg+VZsb
 zInIE2O1zrwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; d="scan'208";a="499965235"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2021 22:35:52 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 0/5] iommu/vt-d: Several misc fixes
Date: Thu, 25 Feb 2021 14:26:49 +0800
Message-Id: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com
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

Hi Joerg,

This series includes some misc fixes for the VT-d iommu driver. Please
help to review and merge.

Best regards,
baolu

Lu Baolu (5):
  iommu/vt-d: Report the right page fault address
  iommu/vt-d: Remove WO permissions on second-level paging entries
  iommu/vt-d: Invalidate PASID cache when root/context entry changed
  iommu/vt-d: Use user privilege for RID2PASID translation
  iommu/vt-d: Avoid unnecessary cache flush in pasid entry teardown

 drivers/iommu/intel/iommu.c | 28 ++++++++++++++++------------
 drivers/iommu/intel/pasid.c |  6 +++++-
 drivers/iommu/intel/svm.c   |  2 +-
 include/linux/intel-iommu.h |  1 +
 4 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
