Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C700BC433E0
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 08:15:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4621422D04
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 08:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4621422D04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BD28B866FC;
	Tue, 26 Jan 2021 08:15:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NOB1QhYrhs57; Tue, 26 Jan 2021 08:15:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EA4978616F;
	Tue, 26 Jan 2021 08:15:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE333C0FA7;
	Tue, 26 Jan 2021 08:15:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CBADC013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 08:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2B57E85188
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 08:15:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id isFVW_Mj3F-s for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 08:15:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9EF378511B
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 08:15:53 +0000 (UTC)
IronPort-SDR: BrWvFBEJKXG7dZTrI5uCiCDYOVdu2lCmg5Gr56iDWmQFNvEBu6RLaz3xKLSZtCoF4vtAQ3McVr
 tBZ5sKvmlpLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="177297768"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="177297768"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 00:15:50 -0800
IronPort-SDR: e/fSyhZG9rDLlzvsJ06TPGj1CGwEPgtCmI6wdhztK1UOLumOcWYbdeQoT5D2oXfTs96ru2V7wO
 PXhHWzlhzsTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="577725446"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga005.fm.intel.com with ESMTP; 26 Jan 2021 00:15:48 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v2 0/2] iommu/vt-d: Some misc tweaks in SVA
Date: Tue, 26 Jan 2021 16:07:28 +0800
Message-Id: <20210126080730.2232859-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

This includes some misc tweaks in the VT-d SVA implementation. I will
plan them for v5.12 if no objections.

Change log:
v1->v2:
  - v1:
    https://lore.kernel.org/linux-iommu/20210121014505.1659166-1-baolu.lu@linux.intel.com/
  - Keep the logic of clearing PRO sane
  - Drop the device outstanding PRQ number patch. Need more test and
    will repost later. 

Best regards,
baolu

Lu Baolu (2):
  iommu/vt-d: Clear PRQ overflow only when PRQ is empty
  iommu/vt-d: Use INVALID response code instead of FAILURE

 drivers/iommu/intel/svm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
