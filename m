Return-Path: <SRS0=DkpR=AJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F804C433E0
	for <iommu@archiver.kernel.org>; Sun, 28 Jun 2020 00:37:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE07F2076E
	for <iommu@archiver.kernel.org>; Sun, 28 Jun 2020 00:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE07F2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 791182048C;
	Sun, 28 Jun 2020 00:37:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OKOaIYH2nGDQ; Sun, 28 Jun 2020 00:37:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6DC8B2043B;
	Sun, 28 Jun 2020 00:37:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CDD2C0865;
	Sun, 28 Jun 2020 00:37:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87A81C016F
 for <iommu@lists.linux-foundation.org>; Sun, 28 Jun 2020 00:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7A44B860DE
 for <iommu@lists.linux-foundation.org>; Sun, 28 Jun 2020 00:37:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KOHnd88JGbbc for <iommu@lists.linux-foundation.org>;
 Sun, 28 Jun 2020 00:37:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DC38F860C1
 for <iommu@lists.linux-foundation.org>; Sun, 28 Jun 2020 00:37:53 +0000 (UTC)
IronPort-SDR: vFJcH6p5RKTx19mQhHKkZACaKLad0xPC0k+/4hGBfSEtwPVMj8cAiWSnAhpZb4YWLXYT0Ufy36
 x9HIaFsWcL5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9665"; a="144805151"
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; d="scan'208";a="144805151"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2020 17:37:52 -0700
IronPort-SDR: j6OM7XnrZ+9iuGMNOEj3FL6aaSkLAEzzuZQGB7FREz9MHFJskQrH1gleXce3tHXRPqXLS1Nrfb
 flyp96BmTt1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; d="scan'208";a="302695000"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 27 Jun 2020 17:37:50 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 0/4] iommu/vt-d: Add prq report and response support
Date: Sun, 28 Jun 2020 08:33:28 +0800
Message-Id: <20200628003332.5720-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

This series adds page request event reporting and response support to
the Intel IOMMU driver. This is necessary when the page requests must
be processed by any component other than the vendor IOMMU driver. For
example, when a guest page table was bound to a PASID through the
iommu_ops->sva_bind_gpasid() api, the page requests should be routed to
the guest, and after the page is served, the device should be responded
with the result.

Your review comments are very appreciated.

Best regards,
baolu

Lu Baolu (4):
  iommu/vt-d: Refactor device_to_iommu() helper
  iommu/vt-d: Add a helper to get svm and sdev for pasid
  iommu/vt-d: Report page request faults for guest SVA
  iommu/vt-d: Add page response ops support

 drivers/iommu/intel/iommu.c |  56 +++----
 drivers/iommu/intel/svm.c   | 285 ++++++++++++++++++++++++++++--------
 include/linux/intel-iommu.h |   6 +-
 3 files changed, 246 insertions(+), 101 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
