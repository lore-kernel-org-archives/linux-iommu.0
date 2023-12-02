Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1F3156C8
	for <iommu@lists.linux.dev>; Sat,  2 Dec 2023 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dj8DtcpB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701511219; x=1733047219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=eyjI0l/aTUHZutjS+4cOREv8PCxRPavsmMsLSGZ4+qo=;
  b=dj8DtcpBbcGAiquQ0YiOO6uWvzXx0YTekQcnBA3k2WO38fOf0k6OetBs
   xFqcd4ypxBpub92LO0CGqnqqTwtUfEJ7RLFHJ9CT/gBbF9wrbCGOP0NJo
   dr4P8YyUHdYPpoEev9HxMtXL8bDxn2l3FC70VTHmztcVRmOwzlWDZ6cpa
   Xn8Og5K0O1I9H9EiEqo39rkkRBHdhcNgTqlZNhIH/l09lJcdXLCelHBBJ
   1wZ5vL/cwKqCnQLgiIi1D7LI2hwC7U6Aik/Um0dTcR3DStiNiRkm0+Ql2
   nsz9GLrCI0CLES6+/v4fGDSdUpVtSqVOwir8dV/iSmg06qmzlhi3T5GiF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="396395294"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="396395294"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:00:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="799015506"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="799015506"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:00:15 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.williamson@redhat.com,
	jgg@nvidia.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	yi.l.liu@intel.com,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 32/42] KVM: x86/mmu: add extra param "kvm" to make_mmio_spte()
Date: Sat,  2 Dec 2023 17:31:19 +0800
Message-Id: <20231202093119.15407-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231202091211.13376-1-yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Add an extra param "kvm" to make_mmio_spte() to allow param "vcpu" to be
NULL in future to allow generating mmio spte in non-vcpu context.

When "vcpu" is NULL, kvm_memslots() rather than kvm_vcpu_memslots() is
called to get memslots pointer, so MMIO SPTEs are not allowed to be
generated for SMM mode in non-vCPU context.

This is a preparation patch for later KVM MMU to export TDP.

Note: actually, if the exported TDP is mapped in non-vCPU context, it
will not reach make_mmio_spte() due to earlier failure in
kvm_handle_noslot_fault(). make_mmio_spte() is modified in this patch to
avoid the check of "vcpu" in the caller.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/kvm/mmu/mmu.c     | 2 +-
 arch/x86/kvm/mmu/spte.c    | 5 +++--
 arch/x86/kvm/mmu/spte.h    | 2 +-
 arch/x86/kvm/mmu/tdp_mmu.c | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index df5651ea99139..e4cae4ff20770 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -296,7 +296,7 @@ static void kvm_flush_remote_tlbs_sptep(struct kvm *kvm, u64 *sptep)
 static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
 			   unsigned int access)
 {
-	u64 spte = make_mmio_spte(vcpu, gfn, access);
+	u64 spte = make_mmio_spte(vcpu->kvm, vcpu, gfn, access);
 
 	trace_mark_mmio_spte(sptep, gfn, spte);
 	mmu_spte_set(sptep, spte);
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 9060a56e45569..daeab3b9eee1e 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -71,9 +71,10 @@ static u64 generation_mmio_spte_mask(u64 gen)
 	return mask;
 }
 
-u64 make_mmio_spte(struct kvm_vcpu *vcpu, u64 gfn, unsigned int access)
+u64 make_mmio_spte(struct kvm *kvm, struct kvm_vcpu *vcpu, u64 gfn, unsigned int access)
 {
-	u64 gen = kvm_vcpu_memslots(vcpu)->generation & MMIO_SPTE_GEN_MASK;
+	struct kvm_memslots *memslots = vcpu ? kvm_vcpu_memslots(vcpu) : kvm_memslots(kvm);
+	u64 gen = memslots->generation & MMIO_SPTE_GEN_MASK;
 	u64 spte = generation_mmio_spte_mask(gen);
 	u64 gpa = gfn << PAGE_SHIFT;
 
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 8f747268a4874..4ad19c469bd73 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -539,7 +539,7 @@ bool make_spte(struct kvm_vcpu *vcpu,
 u64 make_huge_page_split_spte(struct kvm *kvm, u64 huge_spte,
 		      	      union kvm_mmu_page_role role, int index);
 u64 make_nonleaf_spte(u64 *child_pt, bool ad_disabled);
-u64 make_mmio_spte(struct kvm_vcpu *vcpu, u64 gfn, unsigned int access);
+u64 make_mmio_spte(struct kvm *kvm, struct kvm_vcpu *vcpu, u64 gfn, unsigned int access);
 u64 mark_spte_for_access_track(u64 spte);
 
 /* Restore an acc-track PTE back to a regular PTE */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 5d76d4849e8aa..892cf1f5b57a8 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -962,7 +962,7 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 		return RET_PF_RETRY;
 
 	if (unlikely(!fault->slot))
-		new_spte = make_mmio_spte(vcpu, iter->gfn, ACC_ALL);
+		new_spte = make_mmio_spte(vcpu->kvm, vcpu, iter->gfn, ACC_ALL);
 	else
 		wrprot = make_spte(vcpu, &vcpu->arch.mmu->common, sp, fault->slot,
 				   ACC_ALL, iter->gfn, fault->pfn, iter->old_spte,
-- 
2.17.1

