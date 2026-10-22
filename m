Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702015;
	b=w9ZCG01DxvDXdMAer2r03pxMWQh7GCnrWSRVBVKXQLPRwO5m+EiiedVXchZuaI/dYzW5
	 aYMV2ABz3wP7r8GKZNL9h5E8J9aQTd29bvTx9qwJf9ZCJGdMt+lDzcyy0JD3ucozNwor7
	 qZwyjqa5FkrzXBq3kBkZt/s2SjagzIs5NNt9Ld5hqfuZthbU26Fy0xeurRztDXx4plXvB
	 33VDXOYF93Y0m8UrWFX9jOTR/aNXTPdsW2iTbc9Ko7MiIGlplaYMs8VazLUsxLpek0sE8
	 yDJiUuoguG0kySId7B5JquulMgmqf5zlXR28n9CuGZ269tlwLMoXYGiYLdPuh7+Nh2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702015;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=xS2kcNE9+/0XMt1i5fJrUnXcNBD6FHNb/R7Def1nv+E=;
	b=kPq4xg1pLloyOZGPFAbRYYzCya2gI0kYS9m0IMnoeixV/LdkNY4AAEYpK7iaz8YjD0mo
	 7bnBKYsyU17ocV6LRcYL/NDvzpPehU+2fa7bZv4jn47NACRLdAffPR77n26aizDrU+eFv
	 QbnHyRwj0MgJ8vqm8va3ek+mZzwWu4erLRUIO0uWcRR3QsBvssHA/hF9zYS8HLgww2P1m
	 xyPW4T4ZDKgX0KPReWq6p/8U/1aH53LEkKXTBAyOmcfK4+CY1uOXhLB4vzrD+Fpxk4gAE
	 4RNoh04KDREeoqXppfkxG+GmVYXvEr9L5pmyITpUHDzBEPniOw7wIf2m8afeajBZjCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCqhJv3E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA230606A319;
	Thu, 22 Oct 2026 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCqhJv3E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779B91F01825;
	Thu, 22 Oct 2026 20:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792702014;
	bh=xS2kcNE9+/0XMt1i5fJrUnXcNBD6FHNb/R7Def1nv+E=;
	h=From:Date:Subject:To:Cc;
	b=cCqhJv3ETlhV7JgUUWGytYQ2Q4JsMhZCZhI1dsDlTn9FeJf5qd87M14YEe9BVG8dx
	 jWD0Ta8P1z7PHt6oSc1HrNsdUPwn4WmvMmDH6sYQMT2ljd3Nxhet1U0CRuTU0SUPeY
	 bJHAcMkCPLrh8N4ah+kTEic1HaS501eidR9SFe8FpC1Iv380ZNZob/6jHfDhfmo/Lx
	 ++GNPQ/cNvE1Vkz8APSQ4FN47lY7TvRnwXTThwKWrb8X903zMu3MyKIe2c2Z6jk9lQ
	 jpQkfhx7sVqvjfXQVkWSUFPE5isMw+TaNj0eERniHIy+zH9c3A4BfDXF+/TOFR8y/S
	 OtBO9zRDathgQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Thu, 22 Oct 2026 15:46:46 -0500
Subject: [PATCH v5] iommu/amd: Enable PerfOpt automatically for integrated
 GPUs
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-superm1-perf-opt-next-v5-1-dfef0b78b7b9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOQQ6CMBBFr0K6tqRtqKIr72FYlDJAVVoyLQRDu
 LstxsStm0le8v/7sxIPaMCTS7YShNl442wEeciI7pXtgJomMhFMHDkTgvppBBw4jbelbgzUwhL
 oSUvdSHXWtQISuyNCa5bde6s+7Kf6DjokWUq06AYaegT142ecl6LgLOdSSFFKyr971weghWfus
 Evt3vjg8LW/PRdp5S9DtW3bG95YhzT7AAAA
X-Change-ID: 20261022-superm1-perf-opt-next-7c5cd5a9cbae
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, 
 Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, "Mario Limonciello (AMD)" <superm1@kernel.org>
X-Mailer: b4 0.16.0

PerfOpt is usable by integrated GPUs in identity mode. Enable it from
the IOMMU driver's domain attachment paths instead of requiring an
amdgpu policy knob and exported enable/disable interfaces.

Mark supported integrated GPUs as PerfOpt-eligible when selecting their
default identity domain. Skip GCR3 setup and ATS/PRI/PASID enablement for
these identity attachments, then enable PerfOpt after installing the DTE.
Clear PerfOpt before attaching an eligible GPU to a translated or blocked
domain, including unmanaged domains used by VFIO. Propagate failures to
clear bypass, but keep a completed identity attachment successful if the
optional PerfOpt enable fails.

Clear inherited PerfOpt state during initialization, including when a crash
kernel reuses device tables. Read feature support directly from hardware
because cached features may not be available yet, and stop initialization
if the initial clear fails.

Each IOMMU has at most one PerfOpt-eligible GPU, so track activation with a
boolean under the IOMMU lock. Preserve this state while clearing hardware
at suspend and shutdown, and restore the bit on resume only where it was
active. Do not enable PerfOpt unconditionally during early IOMMU
initialization.

Remove the amdgpu parameter, driver callbacks, and exported interfaces.
Translated attachments retain their normal device capability setup.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
Changes in v5:
 * Enable PerfOpt after identity attachment instead of during early IOMMU init
 * Clear PerfOpt before translated or blocked attachments, allowing VFIO use
 * Drop require_direct and retain normal capability setup for translated domains
 * Replace refcounting with a per-IOMMU activation boolean protected by its lock
 * Clear inherited PerfOpt during init, including crash-kernel device-table reuse
 * Read hardware feature support before cached features are available and fail
   initialization if the initial clear fails
 * Preserve activation across suspend and restore it on resume only if active
 * Keep identity attachment successful if optional PerfOpt enablement fails
 * Link to v4: https://lore.kernel.org/linux-iommu/20261001182410.1525285-1-superm1@kernel.org/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 --
 drivers/iommu/amd/amd_iommu.h              |   3 +-
 drivers/iommu/amd/amd_iommu_types.h        |   6 +-
 drivers/iommu/amd/init.c                   |  91 ++++++-----
 drivers/iommu/amd/iommu.c                  | 252 +++++------------------------
 include/linux/amd-iommu.h                  |  11 --
 8 files changed, 95 insertions(+), 331 deletions(-)

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
index d27f7677a5203..d9d794a7db964 100644
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
index 93845b3c3fbf7..29355810db7c3 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -48,8 +48,7 @@ extern u8 amd_iommu_hpt_vasize;
 extern unsigned long amd_iommu_pgsize_bitmap;
 extern bool amd_iommu_hatdis;
 
-int amd_iommu_perfopt_clear(struct amd_iommu *iommu);
-int amd_iommu_perfopt_restore(struct amd_iommu *iommu);
+int amd_iommu_perfopt_set(struct amd_iommu *iommu, bool enable);
 
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 0e79c43be001c..f98770db00902 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -660,8 +660,8 @@ struct amd_iommu {
 	/* Extended features 2 */
 	u64 features2;
 
-	/* Devices requesting PerfOpt; the shared PERF_OPT_EN bit is on while >0. Protected by @lock. */
-	int perfopt_refcount;
+	/* Saved PerfOpt activation state, protected by @lock. */
+	bool perfopt_enabled;
 
 	/* PCI device id of the IOMMU device */
 	u16 devid;
@@ -824,7 +824,7 @@ struct iommu_dev_data {
 	u8 ppr          :1;		  /* Enable device PPR support */
 	bool use_vapic;			  /* Enable device to use vapic mode */
 	bool defer_attach;
-	bool perfopt;
+	bool perfopt;			  /* Device is eligible for PerfOpt */
 
 	struct ratelimit_state rs;        /* Ratelimit IOPF messages */
 };
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index de6db56211946..0cb9aeb0597b3 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -432,8 +432,41 @@ static void iommu_enable(struct amd_iommu *iommu)
 	iommu_feature_enable(iommu, CONTROL_IOMMU_EN);
 }
 
+/*
+ * Program or clear the per-IOMMU PerfOpt enable bit.
+ * Gate on this IOMMU's own EFR, not the global AND-mask.
+ * Caller serializes access using iommu->lock or during init/suspend/resume.
+ */
+int amd_iommu_perfopt_set(struct amd_iommu *iommu, bool enable)
+{
+	u32 old, val, readback;
+
+	if (!(readq(iommu->mmio_base + MMIO_EXT_FEATURES) & FEATURE_PERF_OPT))
+		return enable ? -ENODEV : 0;
+
+	old = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
+	if (old == U32_MAX)
+		goto fail;
+
+	val = enable ? old | PERF_OPT_EN : old & ~PERF_OPT_EN;
+	if (val != old)
+		writel(val, iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
+	readback = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
+	if (readback == U32_MAX ||
+	    (readback & PERF_OPT_EN) != (val & PERF_OPT_EN))
+		goto fail;
+
+	iommu->perfopt_enabled = enable;
+	return 0;
+fail:
+	pr_err("IOMMU%d: failed to set PerfOpt to %d\n", iommu->index, enable);
+	return -EIO;
+}
+
 static void iommu_disable(struct amd_iommu *iommu)
 {
+	bool perfopt_enabled = iommu->perfopt_enabled;
+
 	if (!iommu->mmio_base)
 		return;
 
@@ -457,6 +490,10 @@ static void iommu_disable(struct amd_iommu *iommu)
 
 	/* Clear IRTE cache disabling bit */
 	iommu_feature_disable(iommu, CONTROL_IRTCACHEDIS);
+
+	/* Clear hardware while preserving the activation state for resume. */
+	amd_iommu_perfopt_set(iommu, false);
+	iommu->perfopt_enabled = perfopt_enabled;
 }
 
 /*
@@ -1888,6 +1925,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 				 struct acpi_table_header *ivrs_base)
 {
 	struct amd_iommu_pci_seg *pci_seg;
+	int ret;
 
 	pci_seg = get_pci_segment(h->pci_seg, ivrs_base);
 	if (pci_seg == NULL)
@@ -1960,8 +1998,10 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	if (!iommu->mmio_base)
 		return -ENOMEM;
 
-	if (amd_iommu_perfopt_clear(iommu))
-		pr_err("IOMMU%d: failed to clear PerfOpt\n", iommu->index);
+	/* A crash kernel may reuse device tables with PerfOpt still enabled. */
+	ret = amd_iommu_perfopt_set(iommu, false);
+	if (ret)
+		return ret;
 
 	return init_iommu_from_acpi(iommu, h);
 }
@@ -2331,6 +2371,9 @@ static void print_iommu_info(void)
 		if (check_feature2(FEATURE_SEVSNPIO_SUP))
 			pr_cont(" SEV-TIO");
 
+		if (check_feature(FEATURE_PERF_OPT))
+			pr_cont(" PerfOpt");
+
 		pr_cont("\n");
 	}
 
@@ -3067,46 +3110,10 @@ static void enable_iommus_vapic(void)
 #endif
 }
 
-static int clear_perfopt_all(void)
-{
-	struct amd_iommu *iommu;
-	int err, ret = 0;
-
-	for_each_iommu(iommu) {
-		err = amd_iommu_perfopt_clear(iommu);
-		if (err)
-			ret = err;
-	}
-
-	return ret;
-}
-
-static int restore_perfopt_all(void)
-{
-	struct amd_iommu *iommu;
-	int err, ret = 0;
-
-	for_each_iommu(iommu) {
-		err = amd_iommu_perfopt_restore(iommu);
-		if (err)
-			ret = err;
-	}
-
-	return ret;
-}
-
 static void disable_iommus(void)
 {
 	struct amd_iommu *iommu;
 
-	/*
-	 * PerfOpt is an optional performance bit, so a failure to clear it must
-	 * not skip the mandatory disable below. This also runs from the void
-	 * amd_iommu_disable() shutdown/kexec path, which cannot report an error.
-	 */
-	if (clear_perfopt_all())
-		pr_err("Failed to clear PerfOpt while disabling IOMMUs\n");
-
 	for_each_iommu(iommu)
 		iommu_disable(iommu);
 
@@ -3132,9 +3139,11 @@ static void amd_iommu_resume(void *data)
 	for_each_iommu(iommu)
 		early_enable_iommu(iommu);
 
-	/* early_enable_iommu() cleared PERF_OPT_EN; re-assert it from the refcount. */
-	if (restore_perfopt_all())
-		pr_err("Failed to restore PerfOpt after IOMMU resume\n");
+	/* Restore the activation state saved at suspend. */
+	for_each_iommu(iommu) {
+		if (iommu->perfopt_enabled)
+			amd_iommu_perfopt_set(iommu, true);
+	}
 
 	iommu_enable_event_buffer();
 	amd_iommu_enable_interrupts();
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 960e1dc05ec69..54465e041155c 100644
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
@@ -2368,7 +2369,7 @@ static int attach_device(struct device *dev,
 	if (ret)
 		goto out;
 
-	if (dev_data->perfopt)
+	if (dev_data->perfopt && pdom_is_in_pt_mode(domain))
 		goto skip_caps;
 
 	/* Setup GCR3 table */
@@ -2510,192 +2511,6 @@ static int iommu_init_device_caps(struct iommu_dev_data *dev_data,
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
@@ -2739,14 +2554,6 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 static void amd_iommu_release_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
-	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
-
-	if (dev_data->perfopt) {
-		if (WARN_ON(perfopt_put(iommu)))
-			dev_err(dev, "IOMMU%d: failed to clear PerfOpt on release\n",
-				iommu->index);
-		dev_data->perfopt = false;
-	}
 
 	WARN_ON(dev_data->domain);
 
@@ -3116,24 +2923,32 @@ void amd_iommu_domain_free(struct iommu_domain *dom)
 	kfree(domain);
 }
 
+/* Each IOMMU has at most one PerfOpt-eligible GPU. */
+static int set_device_perfopt(struct iommu_dev_data *dev_data, bool enable)
+{
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+
+	if (!dev_data->perfopt)
+		return 0;
+
+	guard(raw_spinlock_irqsave)(&iommu->lock);
+	if (iommu->perfopt_enabled == enable)
+		return 0;
+
+	return amd_iommu_perfopt_set(iommu, enable);
+}
+
 static int blocked_domain_attach_device(struct iommu_domain *domain,
 					struct device *dev,
 					struct iommu_domain *old)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
-	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	int ret;
 
-	/*
-	 * blocked_domain is also the .release_domain, so this is the normal
-	 * teardown path: drop the reference and clear the flag here too, and
-	 * don't fail teardown if the WARN-guarded write doesn't stick.
-	 */
-	if (dev_data->perfopt) {
-		if (WARN_ON(perfopt_put(iommu)))
-			dev_err(dev, "IOMMU%d: failed to clear PerfOpt for blocked domain\n",
-				iommu->index);
-		dev_data->perfopt = false;
-	}
+	/* Clearing the DTE cannot block DMA while PerfOpt bypasses it. */
+	ret = set_device_perfopt(dev_data, false);
+	if (ret)
+		return ret;
 
 	if (dev_data->domain)
 		detach_device(dev);
@@ -3167,6 +2982,9 @@ static struct protection_domain identity_domain;
 static int amd_iommu_identity_attach(struct iommu_domain *dom, struct device *dev,
 				     struct iommu_domain *old)
 {
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	int ret;
+
 	/*
 	 * Don't allow attaching a device to the identity domain if SNP is
 	 * enabled and SNP Mode0 support is not present.
@@ -3174,7 +2992,13 @@ static int amd_iommu_identity_attach(struct iommu_domain *dom, struct device *de
 	if (amd_iommu_snp_en && !amd_iommu_snp_mode0_sup)
 		return -EINVAL;
 
-	return amd_iommu_attach_device(dom, dev, old);
+	ret = amd_iommu_attach_device(dom, dev, old);
+	if (ret)
+		return ret;
+
+	/* PerfOpt is optional; the identity attachment is already complete. */
+	set_device_perfopt(dev_data, true);
+	return 0;
 }
 
 static const struct iommu_domain_ops identity_domain_ops = {
@@ -3202,9 +3026,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	int ret;
 
-	if (dev_data->perfopt && !pdom_is_in_pt_mode(domain))
-		return -EBUSY;
-
 	/*
 	 * Skip attach device to domain if new domain is same as
 	 * devices current domain
@@ -3221,6 +3042,12 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 	if (dom->dirty_ops && !amd_iommu_hd_support(iommu))
 		return -EINVAL;
 
+	if (!pdom_is_in_pt_mode(domain)) {
+		ret = set_device_perfopt(dev_data, false);
+		if (ret)
+			return ret;
+	}
+
 	if (dev_data->domain)
 		detach_device(dev);
 
@@ -3415,6 +3242,9 @@ static int amd_iommu_def_domain_type(struct device *dev)
 		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 			return 0;
 
+		dev_data->perfopt = get_amd_iommu_from_dev_data(dev_data)->features &
+				    FEATURE_PERF_OPT;
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

---
base-commit: 20bfd25757659ff8229eeed6f048c76f9a11a4a3
change-id: 20261022-superm1-perf-opt-next-7c5cd5a9cbae

Best regards,
--  
Mario Limonciello <superm1@kernel.org>

