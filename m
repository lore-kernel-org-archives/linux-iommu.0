Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458645;
	b=lC1wV+5Uo7fXSzbH/5sAzNJeNdZ4/XUFkEm/G3KmBuLvVaBTf9UbHeDtjhlZwFfhCobg
	 4gDY1pHL+9ZrYEofV4Wbur94ec3voA3otoMwPGAwLWAk6y0PF7QJbfYDZQ9Vt6ijzJkuz
	 POqIRlX79oAQBpBW7w5rZ+c7JOkHbvSHkrXejHTG7UVGGfC+LrBD5SW66GX6CzW9QpC4i
	 mZ32d1gTE9ZrAKp1boi1986Tes21ew4DaQIVPWCKjHpAQsH2lnvkORAnk4pfB8Es9ZQng
	 p6WHeQdhGmb3Wl+T46VGusi+AlwxoRlqa8aW4xBe7T2NyCQ9UpeBL3qMEE+EMi35L3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458645;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IKoThOXC199p56cI2GFtJ5hpbJEBRdRaGERY4se4zH4=;
	b=gAJaUgELPFV4USv+JAlrkk26G8U4Ww6qwhAjOKkyIaxjGKNwLBysZLwA65sNd2ebUdtG
	 G6OTAiv8vnZ4xP9z84kDkEW1uw934O26WmmFaMaI68m3grelCuAWaWAN6yXQa+2aZUOn9
	 Rk/IUFnUCgyLUNhGnJnflqCfu92tPT8Egrjzs5b4/G+892WE+n83evxsL9kkZ2rrWNpqX
	 GDZ1FMbjZuVF6vwJ67Wmnaw5dZHHxSZhxvL2XYjauOFRV9Suj5BTZNzVeEKTuTpI34VCL
	 6dboeIDBTLnTZM8GMGv2eqDH4/RBffhxFoxAozgMKoVx6EkmDxQzVc+yQN40vNmoTGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SISHqkCn;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9160A2622;
	Thu, 12 Nov 2026 04:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72E9160A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SISHqkCn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794458645; x=1825994645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R/nIFccc/jPVlVSy2bUdHcq1c2bU4EXd+SwUeXwW4CI=;
  b=SISHqkCnzYO3i7GD9RMX2smHJlRI5k/Z7B9NLUCkyJyGc0UcOKlIzRx3
   76jx6sO+yygJt9OF9bDXa3v3AhFOwQCUXgzGatsaeunOOLTzSN1/7L7aN
   8Q/umRWZ2ke/2vO8cVtRR/W1BZgXfQcYTKbRWy0vRn5hrElceSQo8VRO+
   T/elw4TvZbNua3k7n1rxxNl3NGyccw8Sk3/UICNf6VazZD2mytcdjnORo
   9/9E2nkeUEliCvgAH1/obP5b/IODhZekLr/Ynrj8lBomlW/xdaL7JqLo8
   1JAxRkzGqv6jlOWGw0UuOVXuL/blI8KS4z2z1Ps7HdHxMBxFi5Z06FHto
   w==;
X-CSE-ConnectionGUID: NSK8hevGSZm3WTc1eTGfrA==
X-CSE-MsgGUID: VFXejrCKQg6+Z1EMbxecNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3318353"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3318353"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:44:05 -0800
X-CSE-ConnectionGUID: pk3omHTxRdm4u5TMFFkQew==
X-CSE-MsgGUID: WIommXKGRF2ebZxb2CgkWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8728646"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2026 20:44:02 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 5/9] iommu/vt-d: Block GCMD and ECMD while acquired by the TDX module
Date: Thu, 12 Nov 2026 12:30:50 +0800
Message-ID: <20261112043054.2664857-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once tdx-host acquires an IOMMU for TDH.IOMMU.SETUP, the TDX module
owns its Secure TDX Mode state. The VT-d driver must not change the
global state of the IOMMU behind the TDX module's back, nor issue
enhanced commands, until the IOMMU is released after TDH.IOMMU.CLEAR.

Use the tdxc_acquired flag of struct intel_iommu, which is protected
by register_lock, to block both. dmar_tdxc_acquire() now fails with
-EBUSY if an enhanced command is still in progress when it sets the
flag. All GCMD writers hold register_lock and wait for completion before
dropping it, so setting the flag under the same lock guarantees no GCMD
operation is in flight once acquire() returns. While the flag is set,
ecmd_submit_sync() fails with -EBUSY rather than waiting, as it may be
called from atomic context.

Write buffer flushing is the only GCMD write reachable on the runtime
map path. Rather than adding a check there, refuse to acquire IOMMUs
that require it (rwbf_quirk or CAP.RWBF). Move rwbf_quirk and
rwbf_required() to iommu.h so dmar.c can use them.

The remaining GCMD writers (root table, translation enable/disable,
queued invalidation and interrupt remapping) are only used at init,
hotplug and suspend/resume. Acquired units are never hot-removed,
hibernation is unavailable with TDX, and the following patch refuses
system suspend while an IOMMU is acquired. Guard them with
WARN_ON_ONCE() ahead of their companion register writes (RTADDR,
IQT/IQA, IRTA).

intel_iommu_shutdown() is the exception. It is only called from
native_machine_shutdown() via machine_shutdown(). On restart, halt,
power-off and kexec, syscore_shutdown() runs first and tdx_shutdown()
issues TDH.SYS.DISABLE, which takes every IOMMU out of Secure TDX Mode.
The crash kexec path doesn't call it. Clear tdxc_acquired there so
translation is still turned off.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h         |  8 ++++-
 drivers/iommu/intel/dmar.c          | 50 ++++++++++++++++++++++++-----
 drivers/iommu/intel/iommu.c         | 33 +++++++++++++++++--
 drivers/iommu/intel/irq_remapping.c | 10 ++++++
 4 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 18fef91753a0..26135248675d 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -690,7 +690,10 @@ struct intel_iommu {
 	u64		ecmdcap[DMA_MAX_NUM_ECMDCAP];
 	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
 	raw_spinlock_t	register_lock; /* protect register handling */
-	/* Acquired for the TDX module. Protected by register_lock. */
+	/*
+	 * GCMD and ECMD writes are rejected while the TDX module owns this
+	 * IOMMU. Protected by register_lock.
+	 */
 	bool		tdxc_acquired;
 	int		seq_id;	/* sequence id of the iommu */
 	int		agaw; /* agaw of this iommu */
@@ -1354,6 +1357,9 @@ static inline bool intel_domain_is_ss_paging(struct dmar_domain *domain)
 }
 
 extern int intel_iommu_sm;
+extern int rwbf_quirk;
+
+#define rwbf_required(iommu)	(rwbf_quirk || cap_rwbf((iommu)->cap))
 int iommu_calculate_agaw(struct intel_iommu *iommu);
 int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
 int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd, u64 oa, u64 ob);
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 60d4c8ab1b4c..91826705a06b 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1731,6 +1731,9 @@ void dmar_disable_qi(struct intel_iommu *iommu)
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
+	if (WARN_ON_ONCE(iommu->tdxc_acquired))
+		goto end;
+
 	sts =  readl(iommu->reg + DMAR_GSTS_REG);
 	if (!(sts & DMA_GSTS_QIES))
 		goto end;
@@ -1762,9 +1765,6 @@ static void __dmar_enable_qi(struct intel_iommu *iommu)
 	struct q_inval *qi = iommu->qi;
 	u64 val = virt_to_phys(qi->desc);
 
-	qi->free_head = qi->free_tail = 0;
-	qi->free_cnt = QI_LENGTH;
-
 	/*
 	 * Set DW=1 and QS=1 in IQA_REG when Scalable Mode capability
 	 * is present.
@@ -1774,6 +1774,12 @@ static void __dmar_enable_qi(struct intel_iommu *iommu)
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
+	if (WARN_ON_ONCE(iommu->tdxc_acquired))
+		goto out;
+
+	qi->free_head = qi->free_tail = 0;
+	qi->free_cnt = QI_LENGTH;
+
 	/* write zero to the tail reg */
 	writel(0, iommu->reg + DMAR_IQT_REG);
 
@@ -1785,6 +1791,7 @@ static void __dmar_enable_qi(struct intel_iommu *iommu)
 	/* Make sure hardware complete it */
 	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG, readl, (sts & DMA_GSTS_QIES), sts);
 
+out:
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
 }
 
@@ -2584,10 +2591,29 @@ static void dmar_tdxc_unreserve_did(struct intel_iommu *iommu)
 	iommu->max_domain_id = cap_ndoms(iommu->cap);
 }
 
-static void dmar_tdxc_set_acquired(struct intel_iommu *iommu, bool acquired)
+static int dmar_tdxc_block_regs(struct intel_iommu *iommu)
 {
-	guard(raw_spinlock_irqsave)(&iommu->register_lock);
-	iommu->tdxc_acquired = acquired;
+	unsigned long flags;
+	int ret = 0;
+
+	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+	if (cap_ecmds(iommu->cap) &&
+	    (readq(iommu->reg + DMAR_ECRSP_REG) & DMA_ECMD_ECRSP_IP))
+		ret = -EBUSY;
+	else
+		iommu->tdxc_acquired = true;
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
+
+	return ret;
+}
+
+static void dmar_tdxc_unblock_regs(struct intel_iommu *iommu)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+	iommu->tdxc_acquired = false;
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
 }
 
 static struct dmar_drhd_unit *dmar_tdxc_find_drhd(struct pci_dev *pdev)
@@ -2669,11 +2695,19 @@ int dmar_tdxc_acquire(struct pci_dev *pdev,
 	if (!(iommu->gcmd & DMA_GCMD_TE) || !iommu->qi || !sm_supported(iommu))
 		return -EINVAL;
 
+	/* Write buffer flushing needs GCMD, which is blocked once acquired. */
+	if (rwbf_required(iommu))
+		return -EOPNOTSUPP;
+
 	ret = dmar_tdxc_reserve_did(iommu);
 	if (ret)
 		return ret;
 
-	dmar_tdxc_set_acquired(iommu, true);
+	ret = dmar_tdxc_block_regs(iommu);
+	if (ret) {
+		dmar_tdxc_unreserve_did(iommu);
+		return ret;
+	}
 
 	return 0;
 }
@@ -2699,7 +2733,7 @@ void dmar_tdxc_release(struct pci_dev *pdev,
 	if (WARN_ON(!drhd->iommu->tdxc_acquired))
 		return;
 
-	dmar_tdxc_set_acquired(drhd->iommu, false);
+	dmar_tdxc_unblock_regs(drhd->iommu);
 	dmar_tdxc_unreserve_did(drhd->iommu);
 }
 EXPORT_SYMBOL_FOR_MODULES(dmar_tdxc_release, "tdx-host");
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e..69e8c2c8680a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -46,9 +46,7 @@
 static void __init check_tylersburg_isoch(void);
 static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 					  bool enable);
-static int rwbf_quirk;
-
-#define rwbf_required(iommu)	(rwbf_quirk || cap_rwbf((iommu)->cap))
+int rwbf_quirk;
 
 /*
  * Skip forcing iommu on and avoid tboot-related kernel panics during
@@ -699,6 +697,10 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
 		addr |= DMA_RTADDR_SMT;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flag);
+	if (WARN_ON_ONCE(iommu->tdxc_acquired)) {
+		raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
+		return;
+	}
 	writeq(addr, iommu->reg + DMAR_RTADDR_REG);
 
 	writel(iommu->gcmd | DMA_GCMD_SRTP, iommu->reg + DMAR_GCMD_REG);
@@ -731,12 +733,15 @@ void iommu_flush_write_buffer(struct intel_iommu *iommu)
 		return;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flag);
+	if (WARN_ON_ONCE(iommu->tdxc_acquired))
+		goto out;
 	writel(iommu->gcmd | DMA_GCMD_WBF, iommu->reg + DMAR_GCMD_REG);
 
 	/* Make sure hardware complete it */
 	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
 		      readl, (!(val & DMA_GSTS_WBFS)), val);
 
+out:
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
@@ -956,6 +961,8 @@ static void iommu_enable_translation(struct intel_iommu *iommu)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+	if (WARN_ON_ONCE(iommu->tdxc_acquired))
+		goto out;
 	iommu->gcmd |= DMA_GCMD_TE;
 	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
 
@@ -963,6 +970,7 @@ static void iommu_enable_translation(struct intel_iommu *iommu)
 	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
 		      readl, (sts & DMA_GSTS_TES), sts);
 
+out:
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
 }
 
@@ -976,6 +984,8 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 		return;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flag);
+	if (WARN_ON_ONCE(iommu->tdxc_acquired))
+		goto out;
 	iommu->gcmd &= ~DMA_GCMD_TE;
 	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
 
@@ -983,6 +993,7 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
 		      readl, (!(sts & DMA_GSTS_TES)), sts);
 
+out:
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
@@ -2513,6 +2524,12 @@ void intel_iommu_shutdown(void)
 		/* Disable PMRs explicitly here. */
 		iommu_disable_protect_mem_regions(iommu);
 
+		/*
+		 * Only reached via machine_shutdown(), after syscore_shutdown()
+		 * ran TDH.SYS.DISABLE and took the IOMMU out of Secure TDX Mode.
+		 */
+		iommu->tdxc_acquired = false;
+
 		/* Make sure the IOMMUs are switched off */
 		iommu_disable_translation(iommu);
 	}
@@ -4336,6 +4353,16 @@ int ecmd_submit_sync(struct intel_iommu *iommu, u8 ecmd, u64 oa, u64 ob)
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
+	/*
+	 * The TDX module owns this IOMMU. This may be called from atomic
+	 * context (e.g. perf pmu::start/stop), so don't sleep; just reject
+	 * the request.
+	 */
+	if (iommu->tdxc_acquired) {
+		ret = -EBUSY;
+		goto err;
+	}
+
 	res = readq(iommu->reg + DMAR_ECRSP_REG);
 	if (res & DMA_ECMD_ECRSP_IP) {
 		ret = -EBUSY;
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 25c26f706984..6e1fe0fcafd9 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -464,6 +464,10 @@ static void iommu_set_irq_remapping(struct intel_iommu *iommu, int mode)
 	addr = virt_to_phys((void *)iommu->ir_table->base);
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+	if (WARN_ON_ONCE(iommu->tdxc_acquired)) {
+		raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
+		return;
+	}
 
 	writeq((addr) | IR_X2APIC_MODE(mode) | INTR_REMAP_TABLE_REG_SIZE,
 	       iommu->reg + DMAR_IRTA_REG);
@@ -489,6 +493,8 @@ static void iommu_enable_irq_remapping(struct intel_iommu *iommu)
 	u32 sts;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+	if (WARN_ON_ONCE(iommu->tdxc_acquired))
+		goto out;
 
 	/* Enable interrupt-remapping */
 	iommu->gcmd |= DMA_GCMD_IRE;
@@ -514,6 +520,7 @@ static void iommu_enable_irq_remapping(struct intel_iommu *iommu)
 			"Compatibility-format IRQs enabled despite intr remapping;\n"
 			"you are vulnerable to IRQ injection.\n");
 
+out:
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
 }
 
@@ -658,6 +665,9 @@ static void iommu_disable_irq_remapping(struct intel_iommu *iommu)
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
+	if (WARN_ON_ONCE(iommu->tdxc_acquired))
+		goto end;
+
 	sts = readl(iommu->reg + DMAR_GSTS_REG);
 	if (!(sts & DMA_GSTS_IRES))
 		goto end;
-- 
2.43.0

