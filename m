Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0397C28CBC
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 00:59:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2BF20708
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 00:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2BF20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3E7BF8873B;
	Thu,  7 May 2020 00:59:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L5E77iHWtMYm; Thu,  7 May 2020 00:59:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 870AC87FD2;
	Thu,  7 May 2020 00:59:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69E11C0863;
	Thu,  7 May 2020 00:59:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DD1DC0859
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 00:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6A62B20460
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 00:59:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 91tqzdukRmK1 for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 00:59:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by silver.osuosl.org (Postfix) with ESMTPS id 8B2AB2045A
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 00:59:04 +0000 (UTC)
IronPort-SDR: 5nsWrmz4awPJ2ItwU+DPz7/Ux5qjrxtaYP4RkJHlEo/T+1zyvm+9TGnbNZ7J/k7/H3NwtGx3fS
 9XSLDG02livA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2020 17:59:04 -0700
IronPort-SDR: HBHWzTc5qEKEfQUKVT27+UvyCL1wQmiUGmuWH1fJqN9zIu8Fpx9F4aaGHTinu4dkggs9ne6hVm
 /jojBFq9QJhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; d="scan'208";a="407461777"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by orsmga004.jf.intel.com with ESMTP; 06 May 2020 17:59:00 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 0/5] iommu/vt-d: Add page request draining support
Date: Thu,  7 May 2020 08:55:29 +0800
Message-Id: <20200507005534.3080-1-baolu.lu@linux.intel.com>
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

Best regards,
baolu

Change log:
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
 drivers/iommu/intel-pasid.h         |   3 +-
 drivers/iommu/intel-svm.c           | 123 ++++++++++++++++++++++++----
 drivers/iommu/intel_irq_remapping.c |   2 +-
 include/linux/intel-iommu.h         |  13 ++-
 8 files changed, 247 insertions(+), 53 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
