Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D6CC54E8D
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 00:56:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B8E3206F5
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 00:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8E3206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D86D88838D;
	Tue, 12 May 2020 00:56:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Chs5EwAkI76; Tue, 12 May 2020 00:56:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7BF9787779;
	Tue, 12 May 2020 00:56:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D980C0176;
	Tue, 12 May 2020 00:56:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 734EEC016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 00:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5C5B6887A1
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 00:56:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qFadww9h-syM for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 00:56:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BBFF3887A5
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 00:56:36 +0000 (UTC)
IronPort-SDR: aGQ+RUij3BISaB48pVNKmi6MwAN6gkQkLG1L2okjiG17TXETRX7oLnAIPV7FRhuqlh7VlZXj82
 FozVbnl50a6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2020 17:56:35 -0700
IronPort-SDR: cvFulzHyc6zjTWxm9v/k/Dr4cBjfdprX5LLtXpTnSCmkLw4FzgeER4Z6Wu9a7KqJtd1/9rezdz
 3CmU5/liMPUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; d="scan'208";a="286458375"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 11 May 2020 17:56:33 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v5 0/5] iommu/vt-d: Add page request draining support
Date: Tue, 12 May 2020 08:53:02 +0800
Message-Id: <20200512005307.19860-1-baolu.lu@linux.intel.com>
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
 - PATCH 1/5 ~ 2/5: refactor the qi_submit_sync() to support multiple
   descriptors per submission which will be used in the following
   patch.
 - PATCH 3/5 ~ 5/5: add page request drain support after a pasid entry
   is torn down.

This series is based on Jacob's vSVA support hence the guest pasid
could also be drained.

https://lkml.org/lkml/2020/4/21/1038

Best regards,
baolu

Change log:
v4->v5:
  - Only set FPD bit in PASID entry when entry changed from present
    to non-present;
  - Check pri_support in drain helper;
  - Refine the wait/completion usage.

v3->v4:
  - Remove prq drain in mm notifier;
  - Set PASID FPD bit when pasid is cleared in mm notifier and clear
    it in unbound().

 v2->v3:
  - Address Kevin's review comments
    - Squash the first 2 patches together;
    - The prq thread is serialized, no need to consider reentrance;
    - Ensure no new-coming prq before drain prq in queue;
    - Handle page request overflow case.

 v1->v2:
  - Fix race between multiple prq handling threads.

Lu Baolu (5):
  iommu/vt-d: Multiple descriptors per qi_submit_sync()
  iommu/vt-d: debugfs: Add support to show inv queue internals
  iommu/vt-d: Disable non-recoverable fault processing before unbind
  iommu/vt-d: Add page request draining support
  iommu/vt-d: Remove redundant IOTLB flush

 drivers/iommu/dmar.c                |  63 ++++++++------
 drivers/iommu/intel-iommu-debugfs.c |  62 ++++++++++++++
 drivers/iommu/intel-iommu.c         |   4 +-
 drivers/iommu/intel-pasid.c         |  30 +++++--
 drivers/iommu/intel-pasid.h         |   4 +-
 drivers/iommu/intel-svm.c           | 128 ++++++++++++++++++++++++----
 drivers/iommu/intel_irq_remapping.c |   2 +-
 include/linux/intel-iommu.h         |  13 ++-
 8 files changed, 253 insertions(+), 53 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
