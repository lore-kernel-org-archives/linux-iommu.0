Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362ACC2BA2B
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 05:29:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B8D2076A
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 05:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B8D2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8C21D87E78;
	Wed, 15 Apr 2020 05:29:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H0vyntT7KYfE; Wed, 15 Apr 2020 05:29:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F09F8875D8;
	Wed, 15 Apr 2020 05:29:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5E10C1D7D;
	Wed, 15 Apr 2020 05:29:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5312C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 05:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8F414844A5
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 05:29:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nsg2ppv8Bdio for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 05:29:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F183E8449E
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 05:29:00 +0000 (UTC)
IronPort-SDR: J7aRSmRWA227eRgJ9EUqo3wILDLDuJfdyuLtu94pZnxGw2R/zExKzgy+xOaRCxIM/zJO4Jb9g+
 sx/oFPCPwUyQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 22:29:00 -0700
IronPort-SDR: 7MxBb7rl7r0a399Q743Ii+47fUxTTEONxEMePjuwNCoPfGk8H/nKEWgA45CJgDJLFvSzGt7EtG
 0F8+uQNETuWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; d="scan'208";a="277504145"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2020 22:28:58 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 0/7] iommu/vt-d: Add page request draining support
Date: Wed, 15 Apr 2020 13:25:35 +0800
Message-Id: <20200415052542.30421-1-baolu.lu@linux.intel.com>
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
so that the pasid could be reused. The register level interface
for page request draining is defined in 7.11 of the VT-d spec.
This series adds the support for page requests draining.

This includes two parts:
 - PATCH 1/7 ~ 3/7: refactor the qi_submit_sync() to support
   multiple descriptors per submission which will be used by
   PATCH 6/7.
 - PATCH 4/7 ~ 7/7: add page request drain support after a
   pasid entry is torn down due to an unbind operation.

Please help to review.

Best regards,
baolu

Change log:
 v1->v2:
  - Fix race between multiple prq handling threads

Lu Baolu (7):
  iommu/vt-d: Refactor parameters for qi_submit_sync()
  iommu/vt-d: Multiple descriptors per qi_submit_sync()
  iommu/vt-d: debugfs: Add support to show inv queue internals
  iommu/vt-d: Refactor prq_event_thread()
  iommu/vt-d: Save prq descriptors in an internal list
  iommu/vt-d: Add page request draining support
  iommu/vt-d: Remove redundant IOTLB flush

 drivers/iommu/dmar.c                |  63 +++--
 drivers/iommu/intel-iommu-debugfs.c |  62 +++++
 drivers/iommu/intel-pasid.c         |   4 +-
 drivers/iommu/intel-svm.c           | 383 ++++++++++++++++++----------
 drivers/iommu/intel_irq_remapping.c |   2 +-
 include/linux/intel-iommu.h         |  12 +-
 6 files changed, 369 insertions(+), 157 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
