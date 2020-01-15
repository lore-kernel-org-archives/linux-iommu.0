Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B430C33C9E
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 03:05:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB00C24673
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 03:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB00C24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A57C9862BC;
	Wed, 15 Jan 2020 03:05:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UoyoYgQNRW-3; Wed, 15 Jan 2020 03:05:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CC3B183B4F;
	Wed, 15 Jan 2020 03:05:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7487C1D88;
	Wed, 15 Jan 2020 03:05:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38AD4C077D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 03:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2DE92204CE
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 03:05:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i6ba+my0rQJY for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 03:05:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id 647A22042B
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 03:05:24 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jan 2020 19:05:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,321,1574150400"; d="scan'208";a="219138440"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.138])
 by fmsmga007.fm.intel.com with ESMTP; 14 Jan 2020 19:05:22 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PULL REQUEST] iommu/vt-d: patches for v5.6 - 2nd wave
Date: Wed, 15 Jan 2020 11:03:54 +0800
Message-Id: <20200115030359.13471-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: iommu@lists.linux-foundation.org
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

Hi Joerg,

Below patches have been piled up for v5.6 since v5.5-rc3. They
are mostly misc changes and cleanups.

 - Instead of aborting DMAR processing, mark firmware tainted
   if any RMRRs fail sanity check.
 - Check host bridge type correctly.
 - Allow devices with RMRRs to use identity domain.
 - Remove duplicated default identity domain treatment.

Please consider them for the iommu/vt-d branch.

Best regards,
-baolu

Barret Rhoden (2):
  iommu/vt-d: Mark firmware tainted if RMRR fails sanity check
  iommu/vt-d: Add RMRR base and end addresses sanity check

Lu Baolu (2):
  iommu/vt-d: Allow devices with RMRRs to use identity domain
  iommu/vt-d: Unnecessary to handle default identity domain

jimyan (1):
  iommu/vt-d: Don't reject Host Bridge due to scope mismatch

 drivers/iommu/dmar.c        |  2 +-
 drivers/iommu/intel-iommu.c | 47 ++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 25 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
