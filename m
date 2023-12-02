Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFB515496
	for <iommu@lists.linux.dev>; Sat,  2 Dec 2023 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSyyAJDZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701511474; x=1733047474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=aDYDeaOzsRKl3ev8dC58rNFjF38aQ9l/2QXjjp0gHNA=;
  b=QSyyAJDZALCY4pKVd6Qh2y43euNdAyZQcFqd4eDrndrfIASZwzg9M2IA
   M+FARTKS04P+7I2MKysPTnUyQvz7dVPcMC3f0DybRHETQeRet13vWQ/lM
   /ppMJUQpZH4S/Owce4D0M2Md62skluSFjrtgFyj3zousME0+/YKVtoTna
   iW9vM+yDR4ncHt84DuyvxrZGfR1WkWXvCA1vR8EzFGr6RmF7bMVPd95je
   gBh6Oitdn9vfRnCrszKAjiNgeI7hVgWTXcdCb4RMGFvInu0RcIgE8CNf6
   NHoUvKGm9iVsK877vTPnnpSWDtxyH/bf/lRihZpDHHkszF42oQb4hWrk8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="392459640"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="392459640"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="887939832"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="887939832"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:04:30 -0800
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
Subject: [RFC PATCH 39/42] KVM: VMX: add config KVM_INTEL_EXPORTED_EPT
Date: Sat,  2 Dec 2023 17:35:35 +0800
Message-Id: <20231202093535.15874-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231202091211.13376-1-yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Add config KVM_INTEL_EXPORTED_EPT to let kvm_intel.ko support exporting EPT
to KVM external components (e.g. Intel VT-d).

This config will turn on HAVE_KVM_EXPORTED_TDP and
HAVE_KVM_MMU_PRESENT_HIGH automatically.

HAVE_KVM_MMU_PRESENT_HIGH will make bit 11 reserved as 0.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/kvm/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 950c12868d304..7126344077ab5 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -99,6 +99,19 @@ config X86_SGX_KVM
 
 	  If unsure, say N.
 
+config KVM_INTEL_EXPORTED_EPT
+	bool "export EPT to be used by other modules (e.g. iommufd)"
+	depends on KVM_INTEL
+	select HAVE_KVM_EXPORTED_TDP
+	select HAVE_KVM_MMU_PRESENT_HIGH if X86_64
+	help
+	  Intel EPT is architecturally guaranteed of compatible to stage 2
+	  page tables in Intel IOMMU.
+
+	  Enable this feature to allow Intel EPT to be exported and used
+	  directly as stage 2 page tables in Intel IOMMU.
+
+
 config KVM_AMD
 	tristate "KVM for AMD processors support"
 	depends on KVM && (CPU_SUP_AMD || CPU_SUP_HYGON)
-- 
2.17.1

