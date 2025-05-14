Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2051327587A;
	Wed, 14 May 2025 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747224346; cv=none; b=EOc2uJGWmqcFiElV1a/AYXKy1GpF98mmF5F7B0EsHkNUHjrsA45LO7UqEcIDvcZGlnWUIX1VXkntMPAym3m7+rmixuGX0AanZkW4uuUr+r8ua9W+uv9TfFpkRXTQUufcCqkUddcXCHoNBm3LU2YkJYFVxv43oRR21KROauNG0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747224346; c=relaxed/simple;
	bh=sKIP/22I1SQvo6tkkmk2GpLfv/4h+uB9iEuhkOzX7dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suSdf8Qr58FvobkrJIYGib6aVB1AhHEXe9zd/qhpxfJzoxumPx33SFMQBbke7YJm6sOed9keM07PQcBq17/Y9QAOO5HGH1csTDLgwk7vY1feiXhQ/tX5yh2MUWfTjo/3/lHKc3/YwJ0QNFmjUghSy61V6XCxMZkjVe9rTV+ayGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E27C4CEF3;
	Wed, 14 May 2025 12:05:40 +0000 (UTC)
Date: Wed, 14 May 2025 13:05:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	yang@os.amperecomputing.com, corbet@lwn.net,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	akpm@linux-foundation.org, paulmck@kernel.org, mark.rutland@arm.com,
	joey.gouly@arm.com, maz@kernel.org, james.morse@arm.com,
	broonie@kernel.org, oliver.upton@linux.dev, baohua@kernel.org,
	david@redhat.com, ioworker0@gmail.com, jgg@ziepe.ca,
	nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
	smostafa@google.com, kevin.tian@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [RESEND PATCH v6 1/3] arm64: Add BBM Level 2 cpu feature
Message-ID: <aCSHESk1DzShD4vt@arm.com>
References: <20250428153514.55772-4-miko.lenczewski@arm.com>
 <20250506142508.GB1197@willie-the-truck>
 <78fec33d-fe66-4352-be11-900f456c9af3@arm.com>
 <20250509134904.GA5707@willie-the-truck>
 <aB4nqtMJuvvp7Vwm@arm.com>
 <015746d7-ca46-4978-a441-09fba781fdd4@arm.com>
 <4709ff5a-f89c-426e-ae95-f8356808f4f5@arm.com>
 <99079d56-428b-4bc4-b20a-dc10032f2a2f@arm.com>
 <aCIiwrA_MOeVhFre@arm.com>
 <c5a74dfe-68e2-48f1-9bbb-06db8e62ffea@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a74dfe-68e2-48f1-9bbb-06db8e62ffea@arm.com>

On Tue, May 13, 2025 at 10:15:49AM +0100, Suzuki K Poulose wrote:
> On 12/05/2025 17:33, Catalin Marinas wrote:
> > Stepping back a bit, we know that the MIDR allow-list implies
> > BBML2_NOABORT (and at least BBML2 as in the ID regs). In theory, we need
> 
> Please be aware that BBML2_NOABORT midr list may not always imply BBLM2 in
> ID registers (e.g., AmpereOne. But the plan is to fixup the per cpu
> ID register - struct cpuinfo_arm64 - for such cores at early boot,
> individually, before it is used for sanitisation of the system wide
> copy).

Ah, good point. We can then ignore BBML2 ID regs and only rely on MIDR
(and some future BBML3).

> > So how about we introduce a WEAK_BOOT_CPU_FEATURE which gets enabled by
> > the boot CPU if it has it _but_ cleared by any secondary early CPU if it
> > doesn't (and never enabled by secondary CPUs). When the features are
> > finalised, we know if all early CPUs had it. In combination with
> > PERMITTED_FOR_LATE_CPU, we'd reject late CPUs that don't have it.
> 
> That could work, but it introduces this "clearing" a capability, which
> we don't do at the moment.
> 
> We had an offline discussion about this some time ago, with Mark
> Rutland. The best way to deal with this is to change the way we compute
> capabilities. i.e.,
> 
> 
> 1. Each boot CPU run through all the capabilities and maintain a per-cpu
>    copy of the state.
> 2. System wide capabilities can then be constructed from the all early
>    boot CPU capability state (e.g., ANDing all the state from all CPUs
>    for SCOPE_SYSTEM or ORing for LOCAL_CPU).
> 
> But this requires a drastic change to the infrastructure.

I think it's a lot simpler to achieve the ANDing - set the (system)
capability if detected on the boot CPU, only clear it if missing on
subsequent CPUs. See below on an attempt to introduce this. For lack of
inspiration, I called it ARM64_CPUCAP_GLOBAL_CPU_FEATURE which has both
SCOPE_LOCAL and SCOPE_SYSTEM. It's permitted for late CPUs but not
optional if already enabled. The advantage of having both local&system
is that the match function will be called for both scopes. I added a
mask in to cpucap_default_scope() when calling matches() since so far
no cap had both.

---------------------8<-----------------------------------------
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index c4326f1cb917..0b0b26a6f27b 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -331,6 +331,15 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 #define ARM64_CPUCAP_BOOT_CPU_FEATURE                  \
 	(ARM64_CPUCAP_SCOPE_BOOT_CPU | ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
 
+/*
+ * CPU feature detected at boot time based on all CPUs. It is safe for a late
+ * CPU to have this feature even though the system hasn't enabled it, although
+ * the feature will not be used by Linux in this case. If the system has
+ * enabled this feature already, then every late CPU must have it.
+ */
+#define ARM64_CPUCAP_GLOBAL_CPU_FEATURE			\
+	 (ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_SYSTEM_FEATURE)
+
 struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
@@ -391,6 +400,11 @@ static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
 	return cap->type & ARM64_CPUCAP_SCOPE_MASK;
 }
 
+static inline bool cpucap_global_scope(const struct arm64_cpu_capabilities *cap)
+{
+	return (cap->type & SCOPE_LOCAL_CPU) && (cap->type & SCOPE_SYSTEM);
+}
+
 /*
  * Generic helper for handling capabilities with multiple (match,enable) pairs
  * of call backs, sharing the same capability bit.
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5ba149c0c2ac..1a5a51090c0e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3359,13 +3381,47 @@ static void update_cpu_capabilities(u16 scope_mask)
 
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 	for (i = 0; i < ARM64_NCAPS; i++) {
+		bool global_cap = false;
+
 		caps = cpucap_ptrs[i];
-		if (!caps || !(caps->type & scope_mask) ||
-		    cpus_have_cap(caps->capability) ||
-		    !caps->matches(caps, cpucap_default_scope(caps)))
+		if (!caps || !(caps->type & scope_mask))
 			continue;
 
-		if (caps->desc && !caps->cpus)
+		global_cap = cpucap_global_scope(caps);
+
+		/*
+		 * If it's not a global CPU capability, avoid probing if
+		 * already detected.
+		 */
+		if (!global_cap && cpus_have_cap(caps->capability))
+			continue;
+
+		/*
+		 * Pass the actual scope we are probing to the match function.
+		 * This is important for the global CPU capabilities that are
+		 * checked both as a local CPU feature and as a system one.
+		 */
+		if (!caps->matches(caps,
+				   cpucap_default_scope(caps) & scope_mask)) {
+			/* All CPUs must have the global capability */
+			if (global_cap)
+				__clear_bit(caps->capability, system_cpucaps);
+			continue;
+		}
+
+		/*
+		 * A global capability is only set when probing the boot CPU.
+		 * It may be cleared subsequently if not detected on secondary
+		 * ones.
+		 */
+		if (global_cap && !(scope_mask & SCOPE_BOOT_CPU))
+			continue;
+
+		/*
+		 * Global CPU capabilities are logged later when the system
+		 * capabilities are finalised.
+		 */
+		if (!global_cap && caps->desc && !caps->cpus)
 			pr_info("detected: %s\n", caps->desc);
 
 		__set_bit(caps->capability, system_cpucaps);
@@ -3771,17 +3827,24 @@ static void __init setup_system_capabilities(void)
 	enable_cpu_capabilities(SCOPE_ALL & ~SCOPE_BOOT_CPU);
 	apply_alternatives_all();
 
-	/*
-	 * Log any cpucaps with a cpumask as these aren't logged by
-	 * update_cpu_capabilities().
-	 */
 	for (int i = 0; i < ARM64_NCAPS; i++) {
 		const struct arm64_cpu_capabilities *caps = cpucap_ptrs[i];
 
-		if (caps && caps->cpus && caps->desc &&
-			cpumask_any(caps->cpus) < nr_cpu_ids)
+		if (!caps || !caps->desc)
+			continue;
+
+		/*
+		 * Log any cpucaps with a cpumask as these aren't logged by
+		 * update_cpu_capabilities().
+		 */
+		if (caps->cpus && cpumask_any(caps->cpus) < nr_cpu_ids)
 			pr_info("detected: %s on CPU%*pbl\n",
 				caps->desc, cpumask_pr_args(caps->cpus));
+
+		/* Log global CPU capabilities */
+		if (cpucap_global_scope(caps) &&
+		    cpus_have_cap(caps->capability))
+			pr_info("detected: %s\n", caps->desc);
 	}
 
 	/*
---------------------8<-----------------------------------------

And an dummy test:

---------------------8<-----------------------------------------
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 5ba149c0c2ac..1a5a51090c0e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2480,6 +2480,21 @@ test_has_mpam_hcr(const struct arm64_cpu_capabilities *entry, int scope)
 	return idr & MPAMIDR_EL1_HAS_HCR;
 }
 
+static void
+cpu_enable_dummy_global(const struct arm64_cpu_capabilities *entry)
+{
+	pr_info("%s: %s: smp_processor_id() = %d", __func__, entry->desc, smp_processor_id());
+}
+
+static bool
+has_dummy_global(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	pr_info("%s: %s: scope = %x smp_processor_id() = %d", __func__, entry->desc, scope, smp_processor_id());
+	if (smp_processor_id() < 4)
+		return true;
+	return false;
+}
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.capability = ARM64_ALWAYS_BOOT,
@@ -3050,6 +3065,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_pmuv3,
 	},
 #endif
+	{
+		.desc = "Dummy test for global CPU feature",
+		.capability = ARM64_HAS_GLOBAL_CPU_TEST,
+		.type = ARM64_CPUCAP_GLOBAL_CPU_FEATURE,
+		.cpu_enable = cpu_enable_dummy_global,
+		.matches = has_dummy_global,
+	},
 	{},
 };
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 772c1b008e43..dbc5a3eb5b3d 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -37,6 +37,7 @@ HAS_GENERIC_AUTH_IMP_DEF
 HAS_GIC_CPUIF_SYSREGS
 HAS_GIC_PRIO_MASKING
 HAS_GIC_PRIO_RELAXED_SYNC
+HAS_GLOBAL_CPU_TEST
 HAS_HCR_NV1
 HAS_HCX
 HAS_LDAPR
---------------------8<-----------------------------------------

-- 
Catalin
