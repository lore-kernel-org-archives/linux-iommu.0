Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526DF156DD
	for <iommu@lists.linux.dev>; Sat,  2 Dec 2023 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8wGCTFZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701511571; x=1733047571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Kur6VrDVtWtZgYRN/PKml2utDvkLe+OiXJiTkkUWmVs=;
  b=F8wGCTFZk2QUknO7gbXDejUEEb48++ssQQ0oTcPgn+IvpZwj373BhywE
   oBuan7FuN2fOBZtxFCvFyDuYB+uXrCiP9hLsI09Xk2EJXrBZPiTSWYt+E
   +gepyrYcVIStGEJ9pYti4pyaUrjuURhupDe4W6pd8lc7V9UedhyVWf0Ft
   ypAMK62lK2pZctfH8ScnM/Kjukr7QfHYTyAw5LsruhPudT6VpDABAdV1p
   ffJxv4xL4sQl5ga9DmyWgd2WT4OBjNK7WPgqzqu0nggO40NOGrCwXEeM2
   F3Mtpn3X0PHtz2PiffhMztIAKC7n839j5uoLFI5ci+eOZ4/K9F4TbLQC/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="383989386"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="383989386"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:06:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="913854410"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="913854410"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:06:07 -0800
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
Subject: [RFC PATCH 42/42] KVM: VMX: Notify importers of exported TDP to flush TLBs on KVM flushes EPT
Date: Sat,  2 Dec 2023 17:37:12 +0800
Message-Id: <20231202093712.16049-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231202091211.13376-1-yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Call TDP FD helper to notify importers of exported TDP to flush TLBs when
KVM flushes EPT.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2fec351a3fa5b..3a2b6ddcde108 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7547,6 +7547,9 @@ static int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 static int vmx_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn, gfn_t nr_pages)
 {
 	kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH);
+#if IS_ENABLED(CONFIG_KVM_INTEL_EXPORTED_EPT)
+	kvm_tdp_fd_flush_notify(kvm, gfn, nr_pages);
+#endif
 	return 0;
 }
 
-- 
2.17.1

