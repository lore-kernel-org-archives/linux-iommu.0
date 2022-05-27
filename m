Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11B5C433EF
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 06:34:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 685E5615F1;
	Fri, 27 May 2022 06:34:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id txgRnk1jXRsq; Fri, 27 May 2022 06:34:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 28065614E2;
	Fri, 27 May 2022 06:34:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC7D3C0032;
	Fri, 27 May 2022 06:33:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55C5FC002D
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:33:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E725412E3
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:33:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0sd_-O5jCb0T for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 06:33:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34353412E1
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653633238; x=1685169238;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7Oir8NuXvQJ0KM9dT/47+p7JMHYeX2jSIoIAZRo5ALk=;
 b=RTFJg9m/H4s6O2GJnWtVXZTBjncNTuxhYtLiVoSh9k7ysmOs75y0GA71
 BPOk1yZPis4GJH8I+aWDSeLIdg2qbNHtH/HNFFpZ/n+BwOIig4nf5NSnx
 Gb8iTEl03g7B/hLj9MYbGyROK8rZrXcPbJ1kgXTLWv3AlYnunNWDY4UfS
 OK7P8rnqrfr14Q8VBoHCxuEmaN4+WkaUw0h82BsoqP4blHNxhzIozi5fo
 BFX4q34LTUGx27twuwSCJ93zPG95X5LCiUhAazE7GgE+TFpUtaqZqMt+8
 3A0hbbhR4oQ/kvY9wFzTO/90RTCOjeOlZVfy3okjWcQHWPEYrSsC6JNRs A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274123230"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; d="scan'208";a="274123230"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2022 23:33:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; d="scan'208";a="718688281"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:33:52 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 00/12] iommu/vt-d: Optimize the use of locks
Date: Fri, 27 May 2022 14:30:07 +0800
Message-Id: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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
- Convert spinlock into mutex so that non-critical functions could be
  called when the lock is held.

This series is also available on github:
https://github.com/LuBaolu/intel-iommu/commits/intel-iommu-lock-optimization-v1

Your comments and suggestions are very appreciated.

Best regards,
baolu

Lu Baolu (12):
  iommu/vt-d: Use iommu_get_domain_for_dev() in debugfs
  iommu/vt-d: Remove for_each_device_domain()
  iommu/vt-d: Remove clearing translation data in disable_dmar_iommu()
  iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()
  iommu/vt-d: Unncessary spinlock for root table alloc and free
  iommu/vt-d: Acquiring lock in domain ID allocation helpers
  iommu/vt-d: Acquiring lock in pasid manipulation helpers
  iommu/vt-d: Replace spin_lock_irqsave() with spin_lock()
  iommu/vt-d: Check device list of domain in domain free path
  iommu/vt-d: Fold __dmar_remove_one_dev_info() into its caller
  iommu/vt-d: Use device_domain_lock accurately
  iommu/vt-d: Convert device_domain_lock into per-domain mutex

 drivers/iommu/intel/iommu.h   |   5 +-
 drivers/iommu/intel/debugfs.c |  26 ++--
 drivers/iommu/intel/iommu.c   | 271 +++++++++-------------------------
 drivers/iommu/intel/pasid.c   | 143 +++++++++---------
 drivers/iommu/intel/svm.c     |   5 +-
 5 files changed, 147 insertions(+), 303 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
