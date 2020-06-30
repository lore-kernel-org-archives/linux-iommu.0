Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D47C433E6
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 21:01:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5844F20772
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 21:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5844F20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8E67523042;
	Tue, 30 Jun 2020 21:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eiWuZov+P0+f; Tue, 30 Jun 2020 21:01:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6EFBB20407;
	Tue, 30 Jun 2020 21:01:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 618E3C088F;
	Tue, 30 Jun 2020 21:01:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E6DFC0894
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 23E09880C6
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:01:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8nCIDqzaplTz for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 21:01:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 933A2880E6
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:01:07 +0000 (UTC)
IronPort-SDR: SaMew3Ovce0k+Er5TdDyd+33knl7Uq6H8vyLqZdyjRN0kFKjty3lT8t5deaKYqCVPnWqgDnDUl
 NQNsurHZi9hQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="146382041"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="146382041"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 14:01:05 -0700
IronPort-SDR: yETbtdM0jc0glKQU6iGOOpflx13N+0/kfuQWSpAlJHwZkS4t3OAQuR8VyXVC/vwz8VTCWrXwPv
 V3jQHPlWgG0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="425337223"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 30 Jun 2020 14:01:05 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 0/7] iommu/vt-d: Misc tweaks and fixes for vSVA
Date: Tue, 30 Jun 2020 14:07:31 -0700
Message-Id: <1593551258-39854-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

Hi Baolu and all,

This is a series to address some of the issues we found in vSVA support.
Most of the patches deal with exception handling, we also removed some bits
that are not currently supported.

Many thanks to Kevin Tian's review.

Jacob & Yi


Changelog:

v2 Address reviews from Baolu
	- Fixed addr field in devTLB flush (5/7)
	- Assign address for single page devTLB invalidation (4/7)
	- Coding style tweaks

Jacob Pan (4):
  iommu/vt-d: Remove global page support in devTLB flush
  iommu/vt-d: Fix PASID devTLB invalidation
  iommu/vt-d: Warn on out-of-range invalidation address
  iommu/vt-d: Disable multiple GPASID-dev bind

Liu Yi L (3):
  iommu/vt-d: Enforce PASID devTLB field mask
  iommu/vt-d: Handle non-page aligned address
  iommu/vt-d: Fix devTLB flush for vSVA

 drivers/iommu/intel/dmar.c  | 24 +++++++++++++++++++-----
 drivers/iommu/intel/iommu.c | 37 ++++++++++++++++++++++---------------
 drivers/iommu/intel/pasid.c | 11 ++++++++++-
 drivers/iommu/intel/svm.c   | 22 +++++++++-------------
 include/linux/intel-iommu.h |  5 ++---
 5 files changed, 62 insertions(+), 37 deletions(-)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
