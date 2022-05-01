Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF15BC433EF
	for <iommu@archiver.kernel.org>; Sun,  1 May 2022 11:27:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 49BC940447;
	Sun,  1 May 2022 11:27:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bQ46yopiPzen; Sun,  1 May 2022 11:27:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EBB3440150;
	Sun,  1 May 2022 11:27:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEE0EC0080;
	Sun,  1 May 2022 11:27:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60C80C002D
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 11:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E6E4408A0
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 11:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qS6q-adNvHJR for <iommu@lists.linux-foundation.org>;
 Sun,  1 May 2022 11:27:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5718A40886
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 11:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651404467; x=1682940467;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3qeW65sQDvzITMvI5ssPSJmfcPTkH+Ogq406imqFvIA=;
 b=B9YT5HJALIcsfoCkCNgHlfFTgQhv++W0FxnLdCESozEr8jTOvQz5Im6Z
 Hkp4moPoapJOBvoW8uAu8xhtWMehmuKJWOo2MtS5SLo/U2Gscnr54Ohas
 /hrxDJwf7rmGsjEx/Jz52g5ZvQEYmwOsHgYIcKR6riDBuK0sP8Be/FoPb
 q4szxiSMiOs/ISARfhtOmK3vGgwpa0ghEKdH0xApLuZUqcJMOzvDbZovx
 04AjRKorTlbCDl7/5dPPlExM3mPpr8Tgf5SnhQE/zo+hvXZTapRXPeDHa
 EKm3W5s2SAdIgKzAdueTp/OKPf9JgjFb2KgLxlNoSgEyvsj9HhsLCuOaM A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="292178334"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; d="scan'208";a="292178334"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2022 04:27:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; d="scan'208";a="545114742"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga002.jf.intel.com with ESMTP; 01 May 2022 04:27:43 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH 0/5] iommu/vt-d: Force snooping improvement
Date: Sun,  1 May 2022 19:24:29 +0800
Message-Id: <20220501112434.874236-1-baolu.lu@linux.intel.com>
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

Previously, the IOMMU capability of enforcing cache coherency is queried
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

Lu Baolu (5):
  iommu/vt-d: Block force-snoop domain attaching if no SC support
  iommu/vt-d: Set SNP bit only in second-level page table entries
  iommu/vt-d: Check domain force_snooping against attached devices
  iommu/vt-d: Remove domain_update_iommu_snooping()
  iommu/vt-d: Remove hard coding PGSNP bit in PASID entries

 drivers/iommu/intel/pasid.h |  3 +-
 drivers/iommu/intel/iommu.c | 92 ++++++++++++++++++++++---------------
 drivers/iommu/intel/pasid.c | 24 +++++++---
 3 files changed, 74 insertions(+), 45 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
