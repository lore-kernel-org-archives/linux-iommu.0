Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3960C433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 01:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C61860ACE;
	Thu,  5 May 2022 01:10:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c8F4XO0D_XSe; Thu,  5 May 2022 01:10:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 534B560804;
	Thu,  5 May 2022 01:10:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18C5AC0039;
	Thu,  5 May 2022 01:10:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 047BDC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 01:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E09E041953
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 01:10:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ckIT-fdSxHo2 for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 01:10:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7EA934194D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651713009; x=1683249009;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bObumrYm1BRiO8NC7JGkJj5WU3DlBUMAdCew4SD9ic0=;
 b=J8bb7iBtLkNUf6sIqIkROBwztiAw2ABtRPOkYBT7Q5RVJsjeF3hIj7e+
 5hhx2W/Dfy3RQL8tO7gjO2I8yruz78rYZIc+JJO5dA0UGYojkZgi76YQu
 FjW4JkNRYlQ9+z7zfFcb7pbUyHE6dYl4rl84FMX4PsqitFpuoDw3K1Y5C
 3ZbNzRwUSbOmkV3bVsEf9AbUy6BSSvrEN984IgLI7dIdKtEQ76fVGmpvB
 7Hy9kq5YLM1XWR2xVnsIpRnlWqSKo74mU8zDjbkiHmqDJL09hQ3+mmCYt
 MlZJLJzI4nbFwEkcxj0O9N1wMrfohAQrb/Fij/t7l8JIb4mbD3KRtKGTp Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="247857793"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; d="scan'208";a="247857793"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 18:10:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; d="scan'208";a="708713892"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 04 May 2022 18:10:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v2 0/4] iommu/vt-d: Force snooping improvement
Date: Thu,  5 May 2022 09:07:06 +0800
Message-Id: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 linux-kernel@vger.kernel.org
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

Hi folks,

Previously, the IOMMU capability of enforcing cache coherency was queried
through iommu_capable(IOMMU_CAP_CACHE_COHERENCY). This is a global
capability, hence the IOMMU driver reports support for this capability
only when all IOMMUs in the system has this support.

Commit 6043257b1de06 ("iommu: Introduce the domain op
enforce_cache_coherency()") converts this into a per-domain test-and-set
option, and the previous iommu_capable(IOMMU_CAP_CACHE_COHERENCY) is
deprecated.

This is a follow-up series which improves the Intel IOMMU driver to
support the per-domain scheme better.

Best regards,
baolu

Change log:
v2:
 - Check whether force_snooping has already been set in
   intel_iommu_enforce_cache_coherency().
 - Set PGSNP pasid bit field during domain attaching if forcing_snooping
   is set.
 - Remove redundant list_empty() checks.
 - Add dmar_domain->set_pte_snp and set it if force snooping is enforced
   on a domain with 2nd-level translation.

v1:
 - https://lore.kernel.org/linux-iommu/20220501112434.874236-1-baolu.lu@linux.intel.com
 - Initial post.

Lu Baolu (4):
  iommu/vt-d: Block force-snoop domain attaching if no SC support
  iommu/vt-d: Check domain force_snooping against attached devices
  iommu/vt-d: Remove domain_update_iommu_snooping()
  iommu/vt-d: Remove hard coding PGSNP bit in PASID entries

 include/linux/intel-iommu.h |  1 +
 drivers/iommu/intel/pasid.h |  2 +
 drivers/iommu/intel/iommu.c | 88 ++++++++++++++++++++++---------------
 drivers/iommu/intel/pasid.c | 26 +++++++++--
 4 files changed, 78 insertions(+), 39 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
