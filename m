Return-Path: <SRS0=sVNY=6G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A3BC55189
	for <iommu@archiver.kernel.org>; Wed, 22 Apr 2020 08:10:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33716206E9
	for <iommu@archiver.kernel.org>; Wed, 22 Apr 2020 08:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33716206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0B34B85FCB;
	Wed, 22 Apr 2020 08:10:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9L7Oxcuq49BF; Wed, 22 Apr 2020 08:10:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 963E083F11;
	Wed, 22 Apr 2020 08:09:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88BE3C1797;
	Wed, 22 Apr 2020 08:09:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCE43C0175
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 08:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CB49C2076B
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 08:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ne8AT26zx-F9 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Apr 2020 08:09:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id E661C20526
 for <iommu@lists.linux-foundation.org>; Wed, 22 Apr 2020 08:09:22 +0000 (UTC)
IronPort-SDR: qbMVfEbiuH2AofXbbRor7zXSJKiKjPsa1X+PKDX1A8yDWN4s8BLlBIVErLH0KoJQcwYo6CWrE5
 EWofIr75wGmw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2020 01:09:22 -0700
IronPort-SDR: NYAah0qsiK+CbyM/jO/clQIEDbrOCPop07kDA389yxLeqORC7eqQWTB0w7sqRpL07tXgPNqWp+
 jEk/3J5OMTAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,412,1580803200"; d="scan'208";a="365609616"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 22 Apr 2020 01:09:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 0/4] iommu/vt-d: Add page request draining support
Date: Wed, 22 Apr 2020 16:06:07 +0800
Message-Id: <20200422080611.15689-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

When a PASID is stopped or terminated, there can be pending PRQs
(requests that haven't received responses) in the software and
remapping hardware. The pending page requests must be drained
so that the pasid could be reused. The chapter 7.10 in the VT-d
specification specifies the software steps to drain pending page
requests and responses.

This includes two parts:
 - PATCH 1/4 ~ 2/4: refactor the qi_submit_sync() to support multiple
   descriptors per submission which will be used in the following
   patch.
 - PATCH 3/4 ~ 4/4: add page request drain support after a pasid entry
   is torn down.

Please help to review.

Best regards,
baolu

Change log:
 v2->v3:
  - Address Kevin's review comments
    - Squash the first 2 patches together;
    - The prq thread is serialized, no need to consider reentrance;
    - Ensure no new-coming prq before drain prq in queue;
    - Handle page request overflow case.

 v1->v2:
  - Fix race between multiple prq handling threads.


Lu Baolu (4):
  iommu/vt-d: Multiple descriptors per qi_submit_sync()
  iommu/vt-d: debugfs: Add support to show inv queue internals
  iommu/vt-d: Add page request draining support
  iommu/vt-d: Remove redundant IOTLB flush

 drivers/iommu/dmar.c                |  63 +++++++++-------
 drivers/iommu/intel-iommu-debugfs.c |  62 +++++++++++++++
 drivers/iommu/intel-pasid.c         |   4 +-
 drivers/iommu/intel-svm.c           | 112 +++++++++++++++++++++++++---
 drivers/iommu/intel_irq_remapping.c |   2 +-
 include/linux/intel-iommu.h         |  13 +++-
 6 files changed, 216 insertions(+), 40 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
