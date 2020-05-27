Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC85C433E0
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 16:56:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DDC20787
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 16:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DDC20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4CCA087E91;
	Wed, 27 May 2020 16:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uZZ+Uj4ydL2n; Wed, 27 May 2020 16:56:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C877287E5F;
	Wed, 27 May 2020 16:56:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAC37C0881;
	Wed, 27 May 2020 16:56:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C667EC016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 16:56:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C243087E5F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 16:56:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r47WjEwdYFL9 for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 16:56:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D1BC687D99
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 16:56:21 +0000 (UTC)
IronPort-SDR: QjilINLH6sPe24kFnYoVjnWHm1ihgPGPk9BJVPE6X/8V0GPrJ+a/6yICGV8WCxD6OOX4rlFpJY
 xpSGA4IFP1aA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 09:56:21 -0700
IronPort-SDR: ujYw5J0Ds55WcBUIgiqzIcxegHTqrsY0WWGCVy3NeTygRwye5U4hftzMqLpuzODQa4HMMQxVfB
 fjuemY8Z6qaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; d="scan'208";a="302522288"
Received: from jderrick-mobl.amr.corp.intel.com ([10.209.128.69])
 by orsmga008.jf.intel.com with ESMTP; 27 May 2020 09:56:20 -0700
From: Jon Derrick <jonathan.derrick@intel.com>
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v1 0/3] iommu/vt-d: real DMA sub-device info allocation
Date: Wed, 27 May 2020 10:56:14 -0600
Message-Id: <20200527165617.297470-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
 Jon Derrick <jonathan.derrick@intel.com>
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

This set adds the support for real DMA sub-devices to have device_domain_info,
leading to the correct domain type being used.

This applies on Joerg's origin/next. This also applies against v5.6.12
and v5.7-rc7 with some API modifications, making it a stable candidate
that fixes the issue reported in [1].

For v5.6.12 and v5.7-rc7, identity_mapping() would return 0 for real DMA
sub-devices due to not having valid device_domain_info, leading to
__intel_map_single() paths. This is a problem if the real DMA device
started in IDENTITY, leading to a NULL Pointer Dereference:

	__intel_map_single()
		domain = find_domain(dev);
			dev = &pci_real_dma_dev(to_pci_dev(dev))->dev;
			info = dev->archdata.iommu;
			return info->domain;

		iommu = domain_get_iommu(domain)
			if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
				return NULL;

		cap_zlr(iommu->cap) <-- NULL Pointer Deref

This issue was also fixed by 6fc7020cf298 ("iommu/vt-d: Apply per-device
dma_ops") due to removing identity_mapping() paths.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=207575

Jon Derrick (3):
  iommu/vt-d: Only clear real DMA device's context entries
  iommu/vt-d: Allocate domain info for real DMA sub-devices
  iommu/vt-d: Remove real DMA lookup in find_domain

 drivers/iommu/intel-iommu.c | 31 +++++++++++++++++++++++--------
 include/linux/intel-iommu.h |  1 +
 2 files changed, 24 insertions(+), 8 deletions(-)

-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
