Return-Path: <SRS0=NhDI=NJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620E5C432BE
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 13:51:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45C360238
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 13:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D45C360238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 98063400BB;
	Wed, 18 Aug 2021 13:51:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cnBcBrtpBGgu; Wed, 18 Aug 2021 13:51:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4058640123;
	Wed, 18 Aug 2021 13:51:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1800C001A;
	Wed, 18 Aug 2021 13:51:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46952C000E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 13:51:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2220F402C6
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 13:51:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OjaLKst3WENa for <iommu@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 13:51:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3717402BA
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 13:51:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="214478843"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="214478843"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2021 06:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="449729198"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga007.fm.intel.com with ESMTP; 18 Aug 2021 06:51:38 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/9] [PULL REQUEST] Intel IOMMU Updates for Linux v5.15
Date: Wed, 18 Aug 2021 21:48:43 +0800
Message-Id: <20210818134852.1847070-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Sanjay Kumar <sanjay.k.kumar@intel.com>, iommu@lists.linux-foundation.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

The patches queued in this series are for v5.15.
It includes:

 - Update the virtual command related registers
 - Enable Intel IOMMU scalable mode by default
 - Preset A/D bits for user space DMA usage
 - Allow devices to have more than 32 outstanding PRs 
 - Various cleanups

Please pull.

Best regards,
Baolu

Andy Shevchenko (1):
  iommu/vt-d: Drop the kernel doc annotation

Liu Yi L (2):
  iommu/vt-d: Use pasid_pte_is_present() helper function
  iommu/vt-d: Add present bit check in pasid entry setup helpers

Lu Baolu (5):
  iommu/vt-d: Update the virtual command related registers
  iommu/vt-d: Refactor Kconfig a bit
  iommu/vt-d: Enable Intel IOMMU scalable mode by default
  iommu/vt-d: Preset A/D bits for user space DMA usage
  iommu/vt-d: Allow devices to have more than 32 outstanding PRs

Zhen Lei (1):
  iommu/vt-d: Remove unnecessary oom message

 .../admin-guide/kernel-parameters.txt         | 11 +++---
 include/linux/intel-iommu.h                   |  6 +--
 include/linux/intel-svm.h                     |  5 +++
 drivers/iommu/intel/pasid.h                   | 10 ++---
 drivers/iommu/intel/dmar.c                    |  2 -
 drivers/iommu/intel/iommu.c                   | 37 ++++++-------------
 drivers/iommu/intel/pasid.c                   | 18 ++++++++-
 drivers/iommu/intel/perf.c                    |  2 +-
 drivers/iommu/intel/svm.c                     |  4 --
 drivers/iommu/intel/Kconfig                   | 19 ++++++----
 10 files changed, 60 insertions(+), 54 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
