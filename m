Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27938605D7
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312253; cv=none; b=fcosnkmswrh0GIZDE6tkNgQrD03BNedNRX8g1EQmPA9kYcUGclXDi2drL8YdzGrrO8GRDjw5aXSYGWrwbvvJ0hM+iLDmOhRW6I0pjSmhOFbZAakCxX83hpoA1s6uX0ybXPCSJFc/KiUv8RqXg3sw01P9Zo1ycogTMyHDFLlpBZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312253; c=relaxed/simple;
	bh=RLEMYdVVEnLOqM5rupdyL8vv8OyQExpN9wq5K3uinZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PceJoFpEr7giZXT4XJYBMFmpgXNVf4FtzfJyx+AJFKYaB/IiP4tCWNWrpJFrDNSU+11UNBwNmbRKUoSPycJKE1sQGsQHLKtw2dO2nRLuzN6u9K09m3RO9bed1/h149Qj/wLrRl/8K85KYBtIFGkfQAx/wE6/1Ge8HjMNyMgvB04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bv9wgK09; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bv9wgK09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706312251; x=1737848251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RLEMYdVVEnLOqM5rupdyL8vv8OyQExpN9wq5K3uinZc=;
  b=bv9wgK09YcumyLvMp7bvmC2CZyCja5BsJkT6FBkaDMzAdJ60b1sLvXmo
   MH7FIRRR3mA2bEOF4F5JuIMeklDwz9DNKUKp6PwX1s7wgBxtfBAvTFq8I
   rvXbGEKaSZk58wKdXa23BPEcvKRj+t1XS6EPm5T9bL0jQ+PXcBtT2cKno
   1IkQmyQOK7U6nNd0a49clV7aplky6BPcOjdZ5rhPgx5TcTXpTvE1ULCrC
   /pXTN7SvmF3DTTstp/bIHtyteOs+NRLOPOQ4hfzTav3t5ldl1mB/u+pcT
   aXbW0Q9zNJPHJcrQWyH3pvSXExwuZYZxCDBkCqV+nHthAij6Cg+kouekp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9990788"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9990788"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:37:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821290755"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="821290755"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.116])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2024 15:37:23 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	X86 Kernel <x86@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	iommu@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Ingo Molnar" <mingo@redhat.com>
Cc: Paul Luse <paul.e.luse@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	maz@kernel.org,
	seanjc@google.com,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 14/15] iommu/vt-d: Add a helper to retrieve PID address
Date: Fri, 26 Jan 2024 15:42:36 -0800
Message-Id: <20240126234237.547278-15-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240126234237.547278-1-jacob.jun.pan@linux.intel.com>
References: <20240126234237.547278-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Physical address of the Intel posted interrupt descriptor (PID) is needed
when programming interrupt remapping table entry (IRTE) for posted mode.

PID is per-CPU, this patch adds a helper function to retrieve the target
CPU's PID address based on the effective affinity mask of the interrupt.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

---
v1: Added a warning if the effective affinity mask is not set up
---
 drivers/iommu/intel/irq_remapping.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index fa719936b44e..01df65dca1d5 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -19,6 +19,7 @@
 #include <asm/cpu.h>
 #include <asm/irq_remapping.h>
 #include <asm/pci-direct.h>
+#include <asm/posted_intr.h>
 
 #include "iommu.h"
 #include "../irq_remapping.h"
@@ -1126,6 +1127,19 @@ struct irq_remap_ops intel_irq_remap_ops = {
 	.enable_faulting	= enable_drhd_fault_handling,
 };
 
+#ifdef CONFIG_X86_POSTED_MSI
+
+static phys_addr_t get_pi_desc_addr(struct irq_data *irqd)
+{
+	int cpu = cpumask_first(irq_data_get_effective_affinity_mask(irqd));
+
+	if (WARN_ON(cpu >= nr_cpu_ids))
+		return 0;
+
+	return __pa(per_cpu_ptr(&posted_interrupt_desc, cpu));
+}
+#endif
+
 static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
 {
 	struct intel_ir_data *ir_data = irqd->chip_data;
-- 
2.25.1

