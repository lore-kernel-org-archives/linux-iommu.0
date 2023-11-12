Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87B2581
	for <iommu@lists.linux.dev>; Sun, 12 Nov 2023 04:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdXjIvNI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699762339; x=1731298339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xFZk1jO0NsxwqOQHg0a3driwffs3nDYuRHJpiimktAA=;
  b=mdXjIvNI2jbwGgV9a0OkW8tyP3HGUVjDWkrsBaLK41O0/IkyXvhRVp6O
   91iOTJCedDw8kIdQj1JP5S2MfM6QKP7eFeE/EkzJTa+Sgx0UkEXNATYIk
   tXPdEFBTD8w5EagxuZPPm/HgI8eBzVq2SdmeQV3/IoCOlqFYLGlZj/feX
   D5E80mBDwdoNPokgmvndVcZUkVdO0WaQIjObzTnavm/0C/FBA9kukYahj
   PwI7hFjl0lG1fIEWceFMGJrPcR6DZ2cIoYQas1Aa5zds5bpqVmBQKQFyt
   QQsYWwVBz2lSccCakNb42jOWKbh3dgl9+cdWYZEn66lep/tu44ri5fOUi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="476533984"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="476533984"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 20:12:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="713936773"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="713936773"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.116])
  by orsmga003.jf.intel.com with ESMTP; 11 Nov 2023 20:12:09 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	X86 Kernel <x86@kernel.org>,
	iommu@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Ingo Molnar" <mingo@redhat.com>
Cc: Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	maz@kernel.org,
	peterz@infradead.org,
	seanjc@google.com,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH RFC 12/13] iommu/vt-d: Add a helper to retrieve PID address
Date: Sat, 11 Nov 2023 20:16:42 -0800
Message-Id: <20231112041643.2868316-13-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

When programming IRTE for posted mode, we need to retrieve the physical
address of the posted interrupt descriptor (PID) that belongs to it's
target CPU.

This per CPU PID has already been set up during cpu_init().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/irq_remapping.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index f2870d3c8313..971e6c37002f 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1125,6 +1125,15 @@ struct irq_remap_ops intel_irq_remap_ops = {
 	.reenable		= reenable_irq_remapping,
 	.enable_faulting	= enable_drhd_fault_handling,
 };
+#ifdef CONFIG_X86_POSTED_MSI
+
+static u64 get_pi_desc_addr(struct irq_data *irqd)
+{
+	int cpu = cpumask_first(irq_data_get_effective_affinity_mask(irqd));
+
+	return __pa(per_cpu_ptr(&posted_interrupt_desc, cpu));
+}
+#endif
 
 static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
 {
-- 
2.25.1

