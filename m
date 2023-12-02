Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8BF156DD
	for <iommu@lists.linux.dev>; Sat,  2 Dec 2023 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbPbly7I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701511532; x=1733047532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2TvSYcYyRxZJXd7jYUAEf7Q9pF2z8JkVIapNJrcQxZk=;
  b=KbPbly7IUjoJoaPFWvF6sXEPJk9KeX6lk5DhyEJREwau46bErzpOzTGE
   PpO7HAl3rNH482OIIiRTxL0NezYErY4l/2MeYBtLMXr8pJdszQp/DNvSJ
   ya4d7YKVzLf5+lUxlDryU9H/opLU8pB376xnKdFagcD9crvtoFnAiLK2A
   kSb72Iey4sgRIrsKx2PM4xg1yhVIH+wMoRaii3rNcL+gOpHDEDfyb3vZ4
   f1I8C9tIgHuBc7MXaZ1cthuPsOPF2QJsfR1WhVoSqkOclmVCGrIjp2iZB
   QPQGJ6JvNYOork0g21LYLaRqOrCEXDD6kvS9lexF4zRen0hVjBma01TYx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="392459742"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="392459742"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:05:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="887939973"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="887939973"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:05:28 -0800
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
Subject: [RFC PATCH 41/42] KVM: VMX: Implement ops .flush_remote_tlbs* in VMX when EPT is on
Date: Sat,  2 Dec 2023 17:36:33 +0800
Message-Id: <20231202093633.15991-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231202091211.13376-1-yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Add VMX implementation of ops of flush_remote_tlbs* in kvm_x86_ops when
enable_ept is on and CONFIG_HYPERV is off.

Without ops flush_remote_tlbs* in VMX, kvm_flush_remote_tlbs*() just makes
all cpus request KVM_REQ_TLB_FLUSH after finding the two ops are
non-present.
So, by also making all cpu requests KVM_REQ_TLB_FLUSH in ops
flush_remote_tlbs* in VMX, no functional changes should be introduced.

The two ops allow vendor code (e.g. VMX) to control when to notify IOMMU
to flush TLBs. This is useful for contidions when sequence to flush CPU
TLBs and IOTLBs is important.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7965bc32f87de..2fec351a3fa5b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7544,6 +7544,17 @@ static int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 	return err;
 }
 
+static int vmx_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn, gfn_t nr_pages)
+{
+	kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH);
+	return 0;
+}
+
+static int vmx_flush_remote_tlbs(struct kvm *kvm)
+{
+	return vmx_flush_remote_tlbs_range(kvm, 0, -1ULL);
+}
+
 #define L1TF_MSG_SMT "L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
 #define L1TF_MSG_L1D "L1TF CPU bug present and virtualization mitigation disabled, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
 
@@ -8528,6 +8539,11 @@ static __init int hardware_setup(void)
 		vmx_x86_ops.flush_remote_tlbs = hv_flush_remote_tlbs;
 		vmx_x86_ops.flush_remote_tlbs_range = hv_flush_remote_tlbs_range;
 	}
+#else
+	if (enable_ept) {
+		vmx_x86_ops.flush_remote_tlbs = vmx_flush_remote_tlbs;
+		vmx_x86_ops.flush_remote_tlbs_range = vmx_flush_remote_tlbs_range;
+	}
 #endif
 
 	if (!cpu_has_vmx_ple()) {
-- 
2.17.1

