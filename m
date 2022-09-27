Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39907645
	for <iommu@lists.linux.dev>; Tue, 27 Sep 2022 05:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664257057; x=1695793057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WQ+7AJ1twGlP0dTdICI8Azj4y4xZsvQCj7oQlGvz1Us=;
  b=OJaNxa5BxxUVyuZEGB4X36qGO54GsJFtXlc+jUlB2dJwo7e+QCb8J8fT
   QVnLUVps+42g7bv5ezhOX5fdByGL8J8MhwhG39NubKQpncqPzt1OHJumj
   Wul4Alx9I5jUuzIqhgFUeib0P+BzydR0rHxF92YKfJU0wvaA9rrRqR/ex
   Nqo658wte55+VcO6IkCq4/PlasxA5VLRNW+7FN7CH6wyK4Uid8vxCofku
   a8NW3xeZAjatRPR2QrWwLxxx6KW75Ilruj5DPtS52zZMQKDybaszlzfX2
   Iutaj4LsRh2GiDrSBu3HLZ45KWSuImheAbxvuAmxsAl8Gha9NkwzydiX2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="288376480"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="288376480"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 22:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="623633441"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="623633441"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 26 Sep 2022 22:37:18 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Use rcu_lock in get_resv_regions
Date: Tue, 27 Sep 2022 13:31:09 +0800
Message-Id: <20220927053109.4053662-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
References: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5f64ce5411b46 ("iommu/vt-d: Duplicate iommu_resv_region objects
per device list") converted rcu_lock in get_resv_regions to
dmar_global_lock to allow sleeping in iommu_alloc_resv_region(). This
introduced possible recursive locking if get_resv_regions is called from
within a section where intel_iommu_init() already holds dmar_global_lock.

Especially after commit c919739ce4721 ("iommu/vt-d: Handle race between
registration and device probe"), below lockdep splats could always be
seen.

 ============================================
 WARNING: possible recursive locking detected
 6.0.0-rc4+ #325 Tainted: G          I
 --------------------------------------------
 swapper/0/1 is trying to acquire lock:
 ffffffffa8a18c90 (dmar_global_lock){++++}-{3:3}, at:
 intel_iommu_get_resv_regions+0x25/0x270

 but task is already holding lock:
 ffffffffa8a18c90 (dmar_global_lock){++++}-{3:3}, at:
 intel_iommu_init+0x36d/0x6ea

 ...

 Call Trace:
  <TASK>
  dump_stack_lvl+0x48/0x5f
  __lock_acquire.cold.73+0xad/0x2bb
  lock_acquire+0xc2/0x2e0
  ? intel_iommu_get_resv_regions+0x25/0x270
  ? lock_is_held_type+0x9d/0x110
  down_read+0x42/0x150
  ? intel_iommu_get_resv_regions+0x25/0x270
  intel_iommu_get_resv_regions+0x25/0x270
  iommu_create_device_direct_mappings.isra.28+0x8d/0x1c0
  ? iommu_get_dma_cookie+0x6d/0x90
  bus_iommu_probe+0x19f/0x2e0
  iommu_device_register+0xd4/0x130
  intel_iommu_init+0x3e1/0x6ea
  ? iommu_setup+0x289/0x289
  ? rdinit_setup+0x34/0x34
  pci_iommu_init+0x12/0x3a
  do_one_initcall+0x65/0x320
  ? rdinit_setup+0x34/0x34
  ? rcu_read_lock_sched_held+0x5a/0x80
  kernel_init_freeable+0x28a/0x2f3
  ? rest_init+0x1b0/0x1b0
  kernel_init+0x1a/0x130
  ret_from_fork+0x1f/0x30
  </TASK>

This rolls back dmar_global_lock to rcu_lock to avoid the lockdep splat.

Fixes: c919739ce4721 ("iommu/vt-d: Handle race between registration and device probe")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d5965b4f8b60..b3cf0f991e29 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4534,7 +4534,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	struct device *i_dev;
 	int i;
 
-	down_read(&dmar_global_lock);
+	rcu_read_lock();
 	for_each_rmrr_units(rmrr) {
 		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
 					  i, i_dev) {
@@ -4553,14 +4553,14 @@ static void intel_iommu_get_resv_regions(struct device *device,
 
 			resv = iommu_alloc_resv_region(rmrr->base_address,
 						       length, prot, type,
-						       GFP_KERNEL);
+						       GFP_ATOMIC);
 			if (!resv)
 				break;
 
 			list_add_tail(&resv->list, head);
 		}
 	}
-	up_read(&dmar_global_lock);
+	rcu_read_unlock();
 
 #ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
 	if (dev_is_pci(device)) {
-- 
2.34.1

