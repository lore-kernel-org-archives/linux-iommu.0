Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15C5C433F5
	for <iommu@archiver.kernel.org>; Sun,  8 May 2022 12:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47AA14090B;
	Sun,  8 May 2022 12:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HG12eSl6u2Jm; Sun,  8 May 2022 12:38:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D9D43408BB;
	Sun,  8 May 2022 12:38:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A15D4C0032;
	Sun,  8 May 2022 12:38:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 726B3C002D
 for <iommu@lists.linux-foundation.org>; Sun,  8 May 2022 12:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A43F60EE3
 for <iommu@lists.linux-foundation.org>; Sun,  8 May 2022 12:38:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vB_VOHHaTaLA for <iommu@lists.linux-foundation.org>;
 Sun,  8 May 2022 12:38:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6533660706
 for <iommu@lists.linux-foundation.org>; Sun,  8 May 2022 12:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652013515; x=1683549515;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qSKUj5BCwE6SV0HTt3tJ3ivcwbJGH956cwe7y7FlJJU=;
 b=INsV88rHAzsJdZxG8fzKjO6AKFDM1hEV0gn6raZW9VK+7BcqSmulP47T
 Ad3keFhmXwB3Ed9rtICBIHNmm0nKfUhVFSCHWILntNmOJG02tRYdWvNvU
 orbslqhra8fJ5tYk6lc4mokTHIuvI0fl5gCzV7K43LbPPKA/nxpSa0TB0
 /1MMIsckgCXZyr7Uqke2gRmulUhaUpMoFMGK8v7xj+rI28PavyRZ3igEl
 3KD/tFBhrk6/++WcRIcLQZja+cbMXfSHgV6aTp/MUQfR8TxsQf/CnQ9gy
 rVFo3tI+jWf01n6hwUvfzIJB7WvqX1l6Gi3PUJ/hfxQOIf9BN8ud50zYO g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="331845777"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; d="scan'208";a="331845777"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2022 05:38:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; d="scan'208";a="710143723"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 08 May 2022 05:38:31 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v4 0/4] iommu/vt-d: Force snooping improvement
Date: Sun,  8 May 2022 20:35:21 +0800
Message-Id: <20220508123525.1973626-1-baolu.lu@linux.intel.com>
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
v4:
 - Flush caches after changing PGSNP bit in the right way.

v3:
 - https://lore.kernel.org/linux-iommu/20220506052727.1689687-1-baolu.lu@linux.intel.com/
 - Hold the device_domain_lock when check and set force snooping.
 - Refind the commit messages.

v2:
 - https://lore.kernel.org/linux-iommu/20220505010710.1477739-1-baolu.lu@linux.intel.com/
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
 drivers/iommu/intel/iommu.c | 90 ++++++++++++++++++++++---------------
 drivers/iommu/intel/pasid.c | 45 +++++++++++++++++--
 4 files changed, 99 insertions(+), 39 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
