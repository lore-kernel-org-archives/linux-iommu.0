Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EE53515F7;
	Mon, 28 Sep 2026 04:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790571058; cv=none; b=bLWlrO3YIaplr6pOzk3p/hdO9TlFfwMDdqNjhLjTzgY9r3I//sL36vBSyzkKUzmGdmVioFJhhtaNJG0PJrhqMRcFI5Vx+d6pNJZao14n+NoIZKdTvOtmZnMd+kKQwfewU5Lm997bB2l9v+Ob1KqDq4dVOyJHNeNCjsU67ZooXYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790571058; c=relaxed/simple;
	bh=3j1mpzcPrFe76hOhAvz2YYbRET5d895pBM5fHXKeyFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b/NVUNtfhRVGZjHT81BXPtEgLPwl+aXKnhCrQXKd8jhC4FsFOMkrtO5xHnGd0K5ipt8iHDEYss8pmcKBiYM/va2O8pIVMK8ZQPNTs+0gMp0XHBhF8cXpYtFHSZHPUhguhqx3l033DI/SXWHpPF8+AP0nOZPL3aF60ONJglLPym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4LXbLgo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4LXbLgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C612D1F000FF;
	Mon, 28 Sep 2026 04:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790571056;
	bh=0pKA+xOtiQf4MxfWRr6S4ZTsp4P6brh6acgiqbdPcmQ=;
	h=From:To:Cc:Subject:Date;
	b=J4LXbLgo1QY0gSaByHCagIkE/Z+yFlFvUwbBhlpxPdUFoNrHPYi2rRiOSS5Ct514k
	 DfRePVvE0m3qm+AxvzcDrBxhuc0FLtvqOV7dv4AMkE2+O/yWYI3MlrmmHbfcg0VZZJ
	 u4zRhES6EwbWUl8FLvlGweFrWyuT5doT3BpRR2DM/Wh8FsKMUQMjqlC34ZWBdhq9k3
	 vVxHKz13Z7LagiRtMauOoRfPlsrtZgpTa/ZjJr8lIAXbjHqqO3RYsstNzsfZmrQTBZ
	 9eCQbRPCFgXl9pz5joqZZE/DHKeWPCaSXX+90tTOhFkRho+FU5a+GEXUGjq3wW1Szc
	 vXVUNPNH4N+Fw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	iommu@lists.linux.dev (open list:AMD IOMMU (AMD-VI)),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH] iommu/amd: Make PerfOpt compulsory for APUs in identity
Date: Sun, 27 Sep 2026 23:50:50 -0500
Message-ID: <20260928045050.955165-1-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PerfOpt is only a feature usable by integrated GPUs and only in identity
mode.  Instead of leaving a policy knob in amdgpu, just turn it on when
an integrated GPU in an APU is in identity. Re-use the heuristic in
amd_iommu_def_domain_type() to make this decision.

This drops quite a bit of compatibility glue.  There was a refcounting
system, exported symbols, and device attach/detach logic.  By just setting
it immediately it's a lot more straightforward.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 --
 drivers/iommu/amd/amd_iommu.h              |   2 +-
 drivers/iommu/amd/amd_iommu_types.h        |   3 -
 drivers/iommu/amd/init.c                   |   3 +-
 drivers/iommu/amd/iommu.c                  | 234 ++++-----------------
 include/linux/amd-iommu.h                  |  11 -
 8 files changed, 48 insertions(+), 268 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0e53a02ad1bab..a9c6f5d4a6397 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -156,7 +156,6 @@ struct amdgpu_watchdog_timer {
  * Modules parameters.
  */
 extern int amdgpu_modeset;
-extern int amdgpu_iommu_perfopt;
 extern unsigned int amdgpu_vram_limit;
 extern int amdgpu_vis_vram_limit;
 extern int amdgpu_gart_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bfe4d90343c4e..9269e780feb73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -33,7 +33,6 @@
 #include <linux/console.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
-#include <linux/amd-iommu.h>
 #include <linux/pci.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/apple-gmux.h>
@@ -3753,28 +3752,6 @@ amdgpu_device_should_register_switcheroo(struct amdgpu_device *adev, bool px)
 		       apple_gmux_detect(NULL, NULL)));
 }
 
-static inline bool amdgpu_device_identity(struct amdgpu_device *adev)
-{
-	struct pci_dev *pdev = adev->pdev;
-	struct iommu_domain *domain = iommu_get_domain_for_dev(&pdev->dev);
-
-	if (!domain)
-		return false;
-
-	return domain->type == IOMMU_DOMAIN_IDENTITY;
-}
-
-static bool amdgpu_device_use_perfopt(struct amdgpu_device *adev)
-{
-	if (amdgpu_iommu_perfopt == 0)
-		return false;
-
-	if (!(adev->flags & AMD_IS_APU))
-		return false;
-
-	return amdgpu_device_identity(adev);
-}
-
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -3982,16 +3959,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	if (amdgpu_device_use_perfopt(adev)) {
-		int perfopt_ret = amd_iommu_enable_perfopt(pdev);
-
-		/* Optional optimization; a failure to arm it must not abort probe. */
-		if (perfopt_ret)
-			dev_warn(adev->dev,
-				 "Failed to enable IOMMU PerfOpt (%d); continuing without it\n",
-				 perfopt_ret);
-	}
-
 	/*
 	 * No need to remove conflicting FBs for non-display class devices.
 	 * This prevents the sysfb from being freed accidently.
@@ -4361,9 +4328,6 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_gart_dummy_page_fini(adev);
 
-	if (amdgpu_device_use_perfopt(adev))
-		amd_iommu_disable_perfopt(adev->pdev);
-
 	if (pci_dev_is_disconnected(adev->pdev))
 		amdgpu_device_unmap_mmio(adev);
 
@@ -4727,20 +4691,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
-	if (amdgpu_device_use_perfopt(adev)) {
-		int perfopt_ret = amd_iommu_enable_perfopt(adev->pdev);
-
-		/*
-		 * Must not return on failure: a bare return would leak the
-		 * SR-IOV VF exclusive-mode acquisition taken above (released
-		 * via the exit: path).
-		 */
-		if (perfopt_ret)
-			dev_warn(adev->dev,
-				 "Failed to enable IOMMU PerfOpt (%d); continuing without it\n",
-				 perfopt_ret);
-	}
-
 	if (adev->in_s0ix)
 		amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D0Entry);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3ca98091ce487..5c33c19fd9bc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -185,7 +185,6 @@ char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
 int amdgpu_enforce_isolation = -1;
 int amdgpu_modeset = -1;
-int amdgpu_iommu_perfopt = -1;
 
 /* Specifies the default granularity for SVM, used in buffer
  * migration and restoration of backing memory when handling
@@ -393,17 +392,6 @@ module_param_named(fw_load_type, amdgpu_fw_load_type, int, 0444);
 MODULE_PARM_DESC(aspm, "ASPM support (1 = enable, 0 = disable, -1 = auto)");
 module_param_named(aspm, amdgpu_aspm, int, 0444);
 
-/**
- * DOC: iommu_perfopt (int)
- * Control the AMD IOMMU PerfOpt DMA-latency optimization
- * (0 = disable; -1 = enable on supported devices).
- * This arms the IOMMU PerfOpt control (IOMMU spec, MMIO Offset 016Ch, EFR PerfOptSup / PerfOptEn)
- * Arming it disables ATS, PRI, PASID and SVA for the GPU and removes IOMMU DMA containment for it,
- * trading isolation for lower DMA latency.
- */
-MODULE_PARM_DESC(iommu_perfopt, "Control IOMMU PerfOpt DMA-latency optimization (-1 = enable on supported devices, 0 = disable)");
-module_param_named(iommu_perfopt, amdgpu_iommu_perfopt, int, 0444);
-
 /**
  * DOC: runpm (int)
  * Override for runtime power management control for dGPUs. The amdgpu driver can dynamically power down
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 93845b3c3fbf7..276fcd4394778 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -49,7 +49,7 @@ extern unsigned long amd_iommu_pgsize_bitmap;
 extern bool amd_iommu_hatdis;
 
 int amd_iommu_perfopt_clear(struct amd_iommu *iommu);
-int amd_iommu_perfopt_restore(struct amd_iommu *iommu);
+int amd_iommu_perfopt_arm(struct amd_iommu *iommu);
 
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1c1624b7c9a36..9d873819304fb 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -657,9 +657,6 @@ struct amd_iommu {
 	/* Extended features 2 */
 	u64 features2;
 
-	/* Devices requesting PerfOpt; the shared PERF_OPT_EN bit is on while >0. Protected by @lock. */
-	int perfopt_refcount;
-
 	/* PCI device id of the IOMMU device */
 	u16 devid;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8ec8a6fccaaf3..e66e3ce466813 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3070,7 +3070,7 @@ static int restore_perfopt_all(void)
 	int err, ret = 0;
 
 	for_each_iommu(iommu) {
-		err = amd_iommu_perfopt_restore(iommu);
+		err = amd_iommu_perfopt_arm(iommu);
 		if (err)
 			ret = err;
 	}
@@ -3115,7 +3115,6 @@ static void amd_iommu_resume(void *data)
 	for_each_iommu(iommu)
 		early_enable_iommu(iommu);
 
-	/* early_enable_iommu() cleared PERF_OPT_EN; re-assert it from the refcount. */
 	if (restore_perfopt_all())
 		pr_err("Failed to restore PerfOpt after IOMMU resume\n");
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c9b28e5e582ea..c07f44c896b02 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -11,6 +11,7 @@
 #include <linux/ratelimit.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/pci-ats.h>
 #include <linux/bitmap.h>
 #include <linux/slab.h>
@@ -2345,6 +2346,42 @@ static void pdom_detach_iommu(struct amd_iommu *iommu,
 	spin_unlock_irqrestore(&pdom->lock, flags);
 }
 
+/* Program the per-IOMMU PerfOpt enable bit. Caller must hold iommu->lock. */
+static int __perfopt_write(struct amd_iommu *iommu, bool enable)
+{
+	u32 old, val, readback;
+
+	if (!(readq(iommu->mmio_base + MMIO_EXT_FEATURES) & FEATURE_PERF_OPT))
+		return enable ? -ENODEV : 0;
+
+	old = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
+	if (old == U32_MAX)
+		return -EIO;
+
+	val = enable ? old | PERF_OPT_EN : old & ~PERF_OPT_EN;
+	if (val != old)
+		writel(val, iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
+	readback = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
+	if (readback == U32_MAX ||
+	    (readback & PERF_OPT_EN) != (val & PERF_OPT_EN))
+		return -EIO;
+	return 0;
+}
+
+int amd_iommu_perfopt_clear(struct amd_iommu *iommu)
+{
+	guard(raw_spinlock)(&iommu->lock);
+
+	return __perfopt_write(iommu, false);
+}
+
+int amd_iommu_perfopt_arm(struct amd_iommu *iommu)
+{
+	guard(raw_spinlock)(&iommu->lock);
+
+	return __perfopt_write(iommu, true);
+}
+
 /*
  * If a device is not yet associated with a domain, this function makes the
  * device visible in the domain
@@ -2407,6 +2444,11 @@ static int attach_device(struct device *dev,
 	/* Update device table */
 	dev_update_dte(dev_data, true);
 
+	if (dev_data->perfopt) {
+		ret = amd_iommu_perfopt_arm(iommu);
+		if (!ret)
+			dev_info_once(iommu->iommu.dev, "PerfOpt armed\n");
+	}
 out:
 	mutex_unlock(&dev_data->mutex);
 
@@ -2512,192 +2554,6 @@ static int iommu_init_device_caps(struct iommu_dev_data *dev_data,
 	return 0;
 }
 
-/* Program the per-IOMMU PerfOpt enable bit. Caller must hold iommu->lock. */
-static int __perfopt_write(struct amd_iommu *iommu, bool enable)
-{
-	u32 old, val, readback;
-
-	if (!(readq(iommu->mmio_base + MMIO_EXT_FEATURES) & FEATURE_PERF_OPT))
-		return enable ? -ENODEV : 0;
-
-	old = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
-	if (old == U32_MAX)
-		return -EIO;
-
-	val = enable ? old | PERF_OPT_EN : old & ~PERF_OPT_EN;
-	if (val != old)
-		writel(val, iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
-	readback = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
-	if (readback == U32_MAX ||
-	    (readback & PERF_OPT_EN) != (val & PERF_OPT_EN))
-		return -EIO;
-	return 0;
-}
-
-/*
- * PERF_OPT_EN is a single bit shared by every device behind @iommu, so it is
- * reference counted: armed on the first requesting device, cleared on the last.
- */
-static int perfopt_get(struct amd_iommu *iommu)
-{
-	unsigned long flags;
-	int ret = 0;
-
-	if (!iommu->mmio_base)
-		return 0;
-
-	raw_spin_lock_irqsave(&iommu->lock, flags);
-	if (iommu->perfopt_refcount == 0) {
-		ret = __perfopt_write(iommu, true);
-		if (ret)
-			goto out;
-	}
-	iommu->perfopt_refcount++;
-out:
-	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-	return ret;
-}
-
-static int perfopt_put(struct amd_iommu *iommu)
-{
-	unsigned long flags;
-	int ret = 0;
-
-	if (!iommu->mmio_base)
-		return 0;
-
-	raw_spin_lock_irqsave(&iommu->lock, flags);
-	if (iommu->perfopt_refcount > 0 && --iommu->perfopt_refcount == 0)
-		ret = __perfopt_write(iommu, false);
-	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-	return ret;
-}
-
-/*
- * Force PERF_OPT_EN off without touching the refcount (used on init, shutdown,
- * and suspend). The count is preserved so amd_iommu_perfopt_restore() can
- * re-arm on resume.
- */
-int amd_iommu_perfopt_clear(struct amd_iommu *iommu)
-{
-	unsigned long flags;
-	int ret;
-
-	if (!iommu->mmio_base)
-		return 0;
-
-	raw_spin_lock_irqsave(&iommu->lock, flags);
-	ret = __perfopt_write(iommu, false);
-	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-	return ret;
-}
-
-/*
- * Re-assert PERF_OPT_EN from the refcount after the hardware was reprogrammed on
- * resume, so devices armed before suspend keep the optimization without each
- * consumer driver re-arming.
- */
-int amd_iommu_perfopt_restore(struct amd_iommu *iommu)
-{
-	unsigned long flags;
-	int ret;
-
-	if (!iommu->mmio_base)
-		return 0;
-
-	raw_spin_lock_irqsave(&iommu->lock, flags);
-	ret = __perfopt_write(iommu, iommu->perfopt_refcount > 0);
-	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-	return ret;
-}
-
-int amd_iommu_enable_perfopt(struct pci_dev *pdev)
-{
-	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
-	struct amd_iommu *iommu = rlookup_amd_iommu(&pdev->dev);
-	struct protection_domain *domain;
-	int ret;
-
-	if (!iommu || !dev_data)
-		return -ENODEV;
-
-	if (!(iommu->features & FEATURE_PERF_OPT))
-		return -ENODEV;
-
-	domain = dev_data->domain;
-	if (!domain)
-		return -ENODEV;
-
-	/* Already armed for this device (e.g. re-entry on resume). */
-	if (dev_data->perfopt)
-		return 0;
-
-	/*
-	 * The bit is only architecturally valid while the device is untranslated:
-	 * identity domain with ATS/PRI/PASID off. The identity domain is
-	 * SVA-capable so attach_device() enabled ATS/PRI/PASID and built a GCR3
-	 * table. Re-home the device onto the same identity domain with
-	 * perfopt set, so the attach_device() skip_caps path leaves
-	 * ATS/PRI/PASID off and no GCR3 table. This follows the detach/attach
-	 * pattern used by amd_iommu_attach_device().
-	 *
-	 * Locking: this and amd_iommu_disable_perfopt() run only from the
-	 * consumer driver's bind/unbind path. group->mutex is not exposed to
-	 * drivers, but a device bound to its native driver cannot have its domain
-	 * changed concurrently by the core (VFIO ownership is mutually exclusive;
-	 * sysfs domain changes require an unused group), so the detach/attach pair
-	 * is serialized without it.
-	 */
-	dev_data->perfopt = true;
-	detach_device(&pdev->dev);
-	ret = attach_device(&pdev->dev, domain);
-	if (ret)
-		goto err_restore;
-
-	ret = perfopt_get(iommu);
-	if (ret)
-		goto err_rearm;
-
-	dev_info_once(&pdev->dev, "PerfOpt armed on IOMMU%d\n", iommu->index);
-	return 0;
-
-err_rearm:
-	detach_device(&pdev->dev);
-err_restore:
-	dev_data->perfopt = false;
-	if (attach_device(&pdev->dev, domain))
-		pci_err(pdev, "failed to restore state after PerfOpt setup; device left detached\n");
-	dev_err_once(&pdev->dev, "PerfOpt failed to arm on IOMMU%d (%d)\n",
-		     iommu->index, ret);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(amd_iommu_enable_perfopt);
-
-void amd_iommu_disable_perfopt(struct pci_dev *pdev)
-{
-	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
-	struct amd_iommu *iommu = rlookup_amd_iommu(&pdev->dev);
-	struct protection_domain *domain;
-
-	if (!iommu || !dev_data || !dev_data->perfopt || !dev_data->domain)
-		return;
-
-	if (WARN_ON(perfopt_put(iommu)))
-		pci_err(pdev, "failed to clear PerfOpt\n");
-
-	/*
-	 * Restore ATS/PRI/PASID (and thus SVA) by re-homing the device onto its
-	 * identity domain with the flag cleared, so a later bind without PerfOpt
-	 * sees a normally-capable device. See the locking note in
-	 * amd_iommu_enable_perfopt().
-	 */
-	domain = dev_data->domain;
-	dev_data->perfopt = false;
-	detach_device(&pdev->dev);
-	if (attach_device(&pdev->dev, domain))
-		pci_err(pdev, "failed to restore caps after PerfOpt disable\n");
-}
-EXPORT_SYMBOL_GPL(amd_iommu_disable_perfopt);
 static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 {
 	struct iommu_device *iommu_dev;
@@ -2744,7 +2600,7 @@ static void amd_iommu_release_device(struct device *dev)
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
 	if (dev_data->perfopt) {
-		if (WARN_ON(perfopt_put(iommu)))
+		if (WARN_ON(amd_iommu_perfopt_clear(iommu)))
 			dev_err(dev, "IOMMU%d: failed to clear PerfOpt on release\n",
 				iommu->index);
 		dev_data->perfopt = false;
@@ -3131,7 +2987,7 @@ static int blocked_domain_attach_device(struct iommu_domain *domain,
 	 * don't fail teardown if the WARN-guarded write doesn't stick.
 	 */
 	if (dev_data->perfopt) {
-		if (WARN_ON(perfopt_put(iommu)))
+		if (WARN_ON(amd_iommu_perfopt_clear(iommu)))
 			dev_err(dev, "IOMMU%d: failed to clear PerfOpt for blocked domain\n",
 				iommu->index);
 		dev_data->perfopt = false;
@@ -3421,6 +3277,8 @@ static int amd_iommu_def_domain_type(struct device *dev)
 		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 			return 0;
 
+		dev_data->perfopt = true;
+
 		return IOMMU_DOMAIN_IDENTITY;
 	}
 
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 104817e8d8977..5c9dcf720f846 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -76,15 +76,4 @@ static inline int amd_iommu_snp_disable(void) { return 0; }
 static inline bool amd_iommu_sev_tio_supported(void) { return false; }
 #endif
 
-#ifdef CONFIG_AMD_IOMMU
-int amd_iommu_enable_perfopt(struct pci_dev *pdev);
-void amd_iommu_disable_perfopt(struct pci_dev *pdev);
-#else
-static inline int amd_iommu_enable_perfopt(struct pci_dev *pdev)
-{
-	return 0;
-}
-static inline void amd_iommu_disable_perfopt(struct pci_dev *pdev) { }
-#endif
-
 #endif /* _ASM_X86_AMD_IOMMU_H */

base-commit: e74db71a3530740bb783e3a01420f6af245630b4
-- 
2.53.0

