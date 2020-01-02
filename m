Return-Path: <SRS0=eP4Y=2X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58978C2D0DF
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 00:19:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37AB820672
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 00:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AB820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F3B588553C;
	Thu,  2 Jan 2020 00:19:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gDJfQ19lNJQy; Thu,  2 Jan 2020 00:19:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 215A1854E8;
	Thu,  2 Jan 2020 00:19:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07EA8C18DC;
	Thu,  2 Jan 2020 00:19:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 223CAC077D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 00:19:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0B9B1856F4
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 00:19:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V7K4kJNliKqt for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jan 2020 00:19:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5628D854C0
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 00:19:33 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Jan 2020 16:19:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,384,1571727600"; d="scan'208";a="244475894"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 01 Jan 2020 16:19:32 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PULL REQUEST] iommu/vt-d: patches for v5.6
Date: Thu,  2 Jan 2020 08:18:01 +0800
Message-Id: <20200102001823.21976-1-baolu.lu@linux.intel.com>
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

Below patches have been piled up for v5.6.

 - Some preparation patches for VT-d nested mode support
   - VT-d Native Shared virtual memory cleanup and fixes
   - Use 1st-level for IOVA translation

 - VT-d debugging and tracing
   - Extend map_sg trace event for more information
   - Add debugfs support to show page table internals

 - Kconfig option for the default status of scalable mode

 - Some miscellaneous cleanups.

Please consider them for the iommu/vt-d branch.

Best regards,
-baolu

Jacob Pan (8):
  iommu/vt-d: Fix CPU and IOMMU SVM feature matching checks
  iommu/vt-d: Match CPU and IOMMU paging mode
  iommu/vt-d: Reject SVM bind for failed capability check
  iommu/vt-d: Avoid duplicated code for PASID setup
  iommu/vt-d: Fix off-by-one in PASID allocation
  iommu/vt-d: Replace Intel specific PASID allocator with IOASID
  iommu/vt-d: Avoid sending invalid page response
  iommu/vt-d: Misc macro clean up for SVM

Lu Baolu (14):
  iommu/vt-d: Add Kconfig option to enable/disable scalable mode
  iommu/vt-d: trace: Extend map_sg trace event
  iommu/vt-d: Avoid iova flush queue in strict mode
  iommu/vt-d: Loose requirement for flush queue initializaton
  iommu/vt-d: Identify domains using first level page table
  iommu/vt-d: Add set domain DOMAIN_ATTR_NESTING attr
  iommu/vt-d: Add PASID_FLAG_FL5LP for first-level pasid setup
  iommu/vt-d: Setup pasid entries for iova over first level
  iommu/vt-d: Flush PASID-based iotlb for iova over first level
  iommu/vt-d: Make first level IOVA canonical
  iommu/vt-d: Update first level super page capability
  iommu/vt-d: Use iova over first level
  iommu/vt-d: debugfs: Add support to show page table internals
  iommu/vt-d: Add a quirk flag for scope mismatched devices

 drivers/iommu/Kconfig               |  13 ++
 drivers/iommu/dmar.c                |  78 +++++--
 drivers/iommu/intel-iommu-debugfs.c |  75 +++++++
 drivers/iommu/intel-iommu.c         | 305 +++++++++++++++++++++++-----
 drivers/iommu/intel-pasid.c         |  97 +++------
 drivers/iommu/intel-pasid.h         |   6 +
 drivers/iommu/intel-svm.c           | 171 +++++++++-------
 include/linux/intel-iommu.h         |  25 ++-
 include/trace/events/intel_iommu.h  |  48 ++++-
 9 files changed, 593 insertions(+), 225 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
