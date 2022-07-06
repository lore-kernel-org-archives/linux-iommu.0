Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AE3C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 02:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 94C74405BA;
	Wed,  6 Jul 2022 02:59:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 94C74405BA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SynlIrOx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rNJbidizA1Qh; Wed,  6 Jul 2022 02:59:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3AD4A400FE;
	Wed,  6 Jul 2022 02:59:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3AD4A400FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20F38C0071;
	Wed,  6 Jul 2022 02:59:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30AA0C0070
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 02:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0C94402E8
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 02:59:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F0C94402E8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SS8xVsEij-XA for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 02:59:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89F1B400FE
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89F1B400FE
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 02:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657076392; x=1688612392;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FSiZChhVHv7Wpj5PCg89R1fUdgobRIw3yEg1zu2dmng=;
 b=SynlIrOxdkIHDPEu5TV9X0pAdac3RTRJ5EQWvcOhCSghswnUNA1O0Gm/
 eBUSAKfcKXwwWC/PkG3/Q0sa0pcGetfc7STLrNFUJNfEPziSaMYPve07c
 fBs2PHsejRFxOTw52EGmpwY/cQl2QsgKjSbSi9mLWq9TeclDxgVbIPM5/
 owU/8snb++yv7/NqCOJr5ILXlNiQ7+3pbYUmUWbwr9D1+uidXWsnE+Aoi
 oevoTfK2xRQAlsmAQv0JOBWZXv1i2fn8k8xsMryeRSteDWUB+wg5UqOWs
 i5TPqNE1Dnuds+0dZUt4lLxXmMgvACGXhnHXJryp6ps2O0eDUOFcaGg+d w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272409517"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; d="scan'208";a="272409517"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2022 19:59:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; d="scan'208";a="567874753"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 19:59:48 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Subject: [PATCH v4 00/11] iommu/vt-d: Optimize the use of locks
Date: Wed,  6 Jul 2022 10:55:13 +0800
Message-Id: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Jacob jun Pan <jacob.jun.pan@intel.com>
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

This series tries to optimize the uses of two locks in the Intel IOMMU
driver:

- The intel_iommu::lock is used to protect the IOMMU resources shared by
  devices. They include the IOMMU root and context tables, the pasid
  tables and the domain IDs.
- The global device_domain_lock is used to protect the global and the
  per-domain device tracking lists.

The optimization includes:

- Remove the unnecessary global device tracking list;
- Remove unnecessary locking;
- Reduce the scope of the lock as much as possible, that is, use the
  lock only where necessary;
- The global lock is transformed into a local lock to improve the
  efficiency.

This series is also available on github:
https://github.com/LuBaolu/intel-iommu/commits/intel-iommu-lock-optimization-v4

Your comments and suggestions are very appreciated.

Best regards,
baolu

Change log:

v4:
 - Kevin pointed out that the copy table failure path needs some
   improvements. We agreed that it worth a separated series to handle
   all improvements on copy table.
 - Kevin suggested that we could put all spinlock replacement changes in
   a single patch. Updated in this series.
 - Others look good to Kevin. (Thanks and very appreciated for all the
   review comments.)

v3:
 - https://lore.kernel.org/linux-iommu/20220629074725.2331441-1-baolu.lu@linux.intel.com/
 - Split reduction of lock ranges from changing irqsave.
   https://lore.kernel.org/linux-iommu/BN9PR11MB52760A3D7C6BF1AF9C9D34658CAA9@BN9PR11MB5276.namprd11.prod.outlook.com/
 - Fully initialize the dev_info before adding it to the list.
   https://lore.kernel.org/linux-iommu/BN9PR11MB52764D7CD86448C5E4EB46668CAA9@BN9PR11MB5276.namprd11.prod.outlook.com/
 - Various code and comments refinement.

v2:
 - https://lore.kernel.org/linux-iommu/20220614025137.1632762-1-baolu.lu@linux.intel.com/
 - Split the lock-free page walk issue into a new patch:
   https://lore.kernel.org/linux-iommu/20220609070811.902868-1-baolu.lu@linux.intel.com/
 - Drop the conversion from spinlock to mutex and make this series
   cleanup purpose only.
 - Address several comments received during v1 review.

v1:
 - https://lore.kernel.org/linux-iommu/20220527063019.3112905-1-baolu.lu@linux.intel.com/
 - Initial post.

Lu Baolu (11):
  iommu/vt-d: debugfs: Remove device_domain_lock usage
  iommu/vt-d: Remove clearing translation data in disable_dmar_iommu()
  iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()
  iommu/vt-d: Unnecessary spinlock for root table alloc and free
  iommu/vt-d: Replace spin_lock_irqsave() with spin_lock()
  iommu/vt-d: Acquiring lock in domain ID allocation helpers
  iommu/vt-d: Acquiring lock in pasid manipulation helpers
  iommu/vt-d: Check device list of domain in domain free path
  iommu/vt-d: Fold __dmar_remove_one_dev_info() into its caller
  iommu/vt-d: Use device_domain_lock accurately
  iommu/vt-d: Convert global spinlock into per domain lock

 drivers/iommu/intel/iommu.h   |   3 +-
 drivers/iommu/intel/pasid.h   |   1 +
 drivers/iommu/intel/debugfs.c |  49 ++++---
 drivers/iommu/intel/iommu.c   | 249 ++++++++++------------------------
 drivers/iommu/intel/pasid.c   | 103 +++++++-------
 drivers/iommu/intel/svm.c     |   5 +-
 6 files changed, 163 insertions(+), 247 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
