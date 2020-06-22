Return-Path: <SRS0=gLCG=AD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF6EC433DF
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 23:18:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C6920708
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 23:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C6920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BE8348940C;
	Mon, 22 Jun 2020 23:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bikHdYnGm4Nf; Mon, 22 Jun 2020 23:18:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 01A388934F;
	Mon, 22 Jun 2020 23:18:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5DEBC0891;
	Mon, 22 Jun 2020 23:18:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D05B0C016F
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 23:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B992A86D6A
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 23:18:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id twBRoOf7OTuV for <iommu@lists.linux-foundation.org>;
 Mon, 22 Jun 2020 23:18:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4BABC86CAC
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 23:18:03 +0000 (UTC)
IronPort-SDR: n9+7c8IP4Z4fI0BtKTb134Egm9TTXha5TIn5K9O+CnfP7+LX268BfIup1PRTUFhCUYy8e7xGfB
 2df8c68ZLyjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="145405628"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; d="scan'208";a="145405628"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2020 16:18:01 -0700
IronPort-SDR: JxtlGb5y28Icv4bHtPLhjaFEA6U0oMpvq6hIfgxNoibHAbRhGXUMFgZjbBXX9OdV4I96ECn0Nn
 qxkQhX0Q9FFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; d="scan'208";a="301006496"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2020 16:17:55 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/6] [PULL REQUEST] iommu/vt-d: fixes for v5.8
Date: Tue, 23 Jun 2020 07:13:39 +0800
Message-Id: <20200622231345.29722-1-baolu.lu@linux.intel.com>
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

Below fix patches have been piled up for v5.8. Please consider them for
your fix branch.

Best regards,
Lu Baolu

Lu Baolu (5):
  iommu/vt-d: Make Intel SVM code 64-bit only
  iommu/vt-d: Set U/S bit in first level page table by default
  iommu/vt-d: Enable PCI ACS for platform opt in hint
  iommu/vt-d: Update scalable mode paging structure coherency
  iommu/vt-d: Fix misuse of iommu_domain_identity_map()

Rajat Jain (1):
  iommu/vt-d: Don't apply gfx quirks to untrusted devices

 drivers/iommu/Kconfig       |  2 +-
 drivers/iommu/intel/dmar.c  |  3 +-
 drivers/iommu/intel/iommu.c | 59 ++++++++++++++++++++++++++++++++-----
 include/linux/intel-iommu.h |  1 +
 4 files changed, 56 insertions(+), 9 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
