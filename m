Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DBBC433EF
	for <iommu@archiver.kernel.org>; Mon, 22 Nov 2021 03:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2CB8A403DE;
	Mon, 22 Nov 2021 03:29:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UY7bTvYRGNaw; Mon, 22 Nov 2021 03:29:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E2A0840283;
	Mon, 22 Nov 2021 03:29:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC7C6C002E;
	Mon, 22 Nov 2021 03:29:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DC09C0012
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 03:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 19EC280D41
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 03:29:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2M6fcDgnl0QO for <iommu@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 03:29:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B70A80D1D
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 03:29:43 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="295523915"
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800"; d="scan'208";a="295523915"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 19:29:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800"; d="scan'208";a="496702650"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 21 Nov 2021 19:29:40 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/2] iommu/vt-d: Fixes for v5.16-rc3
Date: Mon, 22 Nov 2021 11:24:56 +0800
Message-Id: <20211122032458.2549761-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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

Hi Joerg,

Two small fixes are queued for v5.16. They aim to fix:

 - Unbalanced rcu_read_lock/unlock() in cap_audit_static();
 - Missed unmapped PTE entries in dma_pte_clear_level().

This series is also available on github:
https://github.com/LuBaolu/intel-iommu/commits/vtd-fix-for-v5.16-rc3

Please consider them for the iommu/fix branch.

Best regards,
Lu Baolu

Alex Williamson (1):
  iommu/vt-d: Fix unmap_pages support

Christophe JAILLET (1):
  iommu/vt-d: Fix an unbalanced rcu_read_lock/rcu_read_unlock()

 drivers/iommu/intel/cap_audit.c | 5 +++--
 drivers/iommu/intel/iommu.c     | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
