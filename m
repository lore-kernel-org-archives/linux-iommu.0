Return-Path: <SRS0=9TsP=MM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520B6C07E95
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 01:41:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC6B6113E
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 01:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC6B6113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B8AA40453;
	Tue, 20 Jul 2021 01:41:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5selOWw4zbkl; Tue, 20 Jul 2021 01:41:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 466BA40413;
	Tue, 20 Jul 2021 01:41:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 149F5C001B;
	Tue, 20 Jul 2021 01:41:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAB32C000E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 01:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD6FE607F8
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 01:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bGErvrIAs-Rd for <iommu@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 01:41:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EFB4A607F5
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 01:41:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="191440282"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; d="scan'208";a="191440282"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2021 18:41:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; d="scan'208";a="453887537"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 19 Jul 2021 18:41:16 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Sanjay Kumar <sanjay.k.kumar@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Liu Yi L <yi.l.liu@intel.com>
Subject: [PATCH 0/5] iommu/vt-d: Several minor adjustments
Date: Tue, 20 Jul 2021 09:38:51 +0800
Message-Id: <20210720013856.4143880-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

This series includes some adjustments for Intel IOMMU which I have
been suggested. Please help to review.

- Enable Intel IOMMU scalable mode by default
- Preset A/D bits for user space DMA usage
- Disallow SVA if devices don't support 64-bit address
- Allow devices to have more than 32 outstanding PRs

Best regards,
baolu

Lu Baolu (5):
  iommu/vt-d: Refactor Kconfig a bit
  iommu/vt-d: Enable Intel IOMMU scalable mode by default
  iommu/vt-d: Preset A/D bits for user space DMA usage
  iommu/vt-d: Disallow SVA if devices don't support 64-bit address
  iommu/vt-d: Allow devices to have more than 32 outstanding PRs

 .../admin-guide/kernel-parameters.txt         | 11 +++---
 include/linux/intel-svm.h                     |  5 +++
 drivers/iommu/intel/iommu.c                   | 34 ++++++++-----------
 drivers/iommu/intel/svm.c                     |  4 ---
 drivers/iommu/intel/Kconfig                   | 19 ++++++-----
 5 files changed, 36 insertions(+), 37 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
