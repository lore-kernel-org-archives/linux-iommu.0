Return-Path: <SRS0=J+1i=42=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F87AC10F25
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 20:43:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41D62253D
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 20:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41D62253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A8CB98730F;
	Mon,  9 Mar 2020 20:43:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I92DzPyIB2rG; Mon,  9 Mar 2020 20:43:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2F737872CF;
	Mon,  9 Mar 2020 20:43:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1229CC18D3;
	Mon,  9 Mar 2020 20:43:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5F27C0177
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 19:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A4FD987303
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 19:53:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JkZw7V6_Aprf for <iommu@lists.linux-foundation.org>;
 Mon,  9 Mar 2020 19:53:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 979E587264
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 19:53:17 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 12:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; d="scan'208";a="234104034"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
 by fmsmga007.fm.intel.com with ESMTP; 09 Mar 2020 12:53:17 -0700
From: Megha Dey <megha.dey@linux.intel.com>
To: dwmw2@infradead.org, baolu.lu@linux.intel.com,
 iommu@lists.linux-foundation.org
Subject: [Patch V1 0/2] iommu/vtd: Fixes to the IOMMU debugfs
Date: Mon,  9 Mar 2020 13:09:45 -0700
Message-Id: <1583784587-26126-1-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Mon, 09 Mar 2020 20:43:19 +0000
Cc: Megha Dey <megha.dey@linux.intel.com>, megha.dey@intel.com
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

This patchset aims to fix some of the existing issues in the iommu debugfs.

The first patch aims to fix the debugfs register reads by using the correct
read function variant while reading the contents of iommu registers while
the second patch ensures the debugfs directory is populated even if DMA
remapping is disabled.

Megha Dey (2):
  iommu/vt-d: Fix debugfs register reads
  iommu/vt-d: Populate debugfs if IOMMUs are detected

 drivers/iommu/intel-iommu-debugfs.c | 53 ++++++++++++++++++++++++++-----------
 drivers/iommu/intel-iommu.c         |  4 ++-
 include/linux/intel-iommu.h         |  2 ++
 3 files changed, 43 insertions(+), 16 deletions(-)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
