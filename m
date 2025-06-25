Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B1925DAE2
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851294; cv=none; b=jYkuGxLwpfcx5DuH7IY+z5ZLz7a07Yu1xYugObmxgiph2tl9+stpHLslyMOydVqbN/T2fJ2g1Gr97iOMNWnQXM8Irv36/0o8XyYeouUnr5z8vPNlb91dpVaVQi7aVcRlzbcd3uafmyvxQm98JzdUT2T8w1QaJX0OLx7zhy9QIy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851294; c=relaxed/simple;
	bh=RbP84HcCEnwX9DUuFw/tD8N6Pg3hmMFQLfZUlLdOBs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHxOcN+A8SJrFSXJOFgrwD0uCMmZyiYL36zWpjx698QvSAiuVTLJysBIsBeJdxSVjnuroB9vda5Ruunl6ENqJ5zn7S87D+2/XGvTvBZqamj4oKh7MSLzuwaRZPSJoKncbojNM/jQyupWglTUMAeuu4viRZyRS7AI84SRwG4sH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4D9C204C;
	Wed, 25 Jun 2025 04:34:32 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 134DA3F58B;
	Wed, 25 Jun 2025 04:34:46 -0700 (PDT)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	yang@os.amperecomputing.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	jean-philippe@linaro.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	james.morse@arm.com,
	broonie@kernel.org,
	ardb@kernel.org,
	baohua@kernel.org,
	suzuki.poulose@arm.com,
	david@redhat.com,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	jsnitsel@redhat.com,
	mshavit@google.com,
	kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: [PATCH v8 1/4] arm64: cpufeature: Introduce MATCH_ALL_EARLY_CPUS capability type
Date: Wed, 25 Jun 2025 11:34:32 +0000
Message-ID: <20250625113435.26849-2-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625113435.26849-1-miko.lenczewski@arm.com>
References: <20250625113435.26849-1-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Catalin Marinas <catalin.marinas@arm.com>

For system-wide capabilities, the kernel has the SCOPE_SYSTEM type. Such
capabilities are checked once the SMP boot has completed using the
sanitised ID registers. However, there is a need for a new capability
type similar in scope to the system one but with checking performed
locally on each CPU during boot (e.g. based on MIDR_EL1 which is not a
sanitised register).

Introduce ARM64_CPUCAP_MATCH_ALL_EARLY_CPUS which, together with
ARM64_CPUCAP_SCOPE_LOCAL_CPU, ensures that such capability is enabled
only if all early CPUs have it. For ease of use, define
ARM64_CPUCAP_EARLY_LOCAL_CPU_FEATURE which combines SCOPE_LOCAL_CPU,
PERMITTED_FOR_LATE_CPUS and MATCH_ALL_EARLY_CPUS.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
Reviewed-by: Suzuki K Poulose <Suzuki.Poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 23 +++++++++++
 arch/arm64/kernel/cpufeature.c      | 60 +++++++++++++++++++++++------
 2 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index c4326f1cb917..155ebd040c55 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -275,6 +275,14 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 #define ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	((u16)BIT(5))
 /* Panic when a conflict is detected */
 #define ARM64_CPUCAP_PANIC_ON_CONFLICT		((u16)BIT(6))
+/*
+ * When paired with SCOPE_LOCAL_CPU, all early CPUs must satisfy the
+ * condition. This is different from SCOPE_SYSTEM where the check is performed
+ * only once at the end of the SMP boot on the sanitised ID registers.
+ * SCOPE_SYSTEM is not suitable for cases where the capability depends on
+ * properties local to a CPU like MIDR_EL1.
+ */
+#define ARM64_CPUCAP_MATCH_ALL_EARLY_CPUS	((u16)BIT(7))
 
 /*
  * CPU errata workarounds that need to be enabled at boot time if one or
@@ -304,6 +312,16 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 	(ARM64_CPUCAP_SCOPE_LOCAL_CPU		|	\
 	 ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU	|	\
 	 ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU)
+/*
+ * CPU feature detected at boot time and present on all early CPUs. Late CPUs
+ * are permitted to have the feature even if it hasn't been enabled, although
+ * the feature will not be used by Linux in this case. If all early CPUs have
+ * the feature, then every late CPU must have it.
+ */
+#define ARM64_CPUCAP_EARLY_LOCAL_CPU_FEATURE		\
+	 (ARM64_CPUCAP_SCOPE_LOCAL_CPU		|	\
+	  ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU	|	\
+	  ARM64_CPUCAP_MATCH_ALL_EARLY_CPUS)
 
 /*
  * CPU feature detected at boot time, on one or more CPUs. A late CPU
@@ -391,6 +409,11 @@ static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
 	return cap->type & ARM64_CPUCAP_SCOPE_MASK;
 }
 
+static inline bool cpucap_match_all_early_cpus(const struct arm64_cpu_capabilities *cap)
+{
+	return cap->type & ARM64_CPUCAP_MATCH_ALL_EARLY_CPUS;
+}
+
 /*
  * Generic helper for handling capabilities with multiple (match,enable) pairs
  * of call backs, sharing the same capability bit.
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b34044e20128..f9c947166322 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3370,18 +3370,49 @@ static void update_cpu_capabilities(u16 scope_mask)
 
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 	for (i = 0; i < ARM64_NCAPS; i++) {
+		bool match_all = false;
+		bool caps_set = false;
+		bool boot_cpu = false;
+
 		caps = cpucap_ptrs[i];
-		if (!caps || !(caps->type & scope_mask) ||
-		    cpus_have_cap(caps->capability) ||
-		    !caps->matches(caps, cpucap_default_scope(caps)))
+		if (!caps || !(caps->type & scope_mask))
 			continue;
 
-		if (caps->desc && !caps->cpus)
+		match_all = cpucap_match_all_early_cpus(caps);
+		caps_set = cpus_have_cap(caps->capability);
+		boot_cpu = scope_mask & SCOPE_BOOT_CPU;
+
+		/*
+		 * Unless it's a match-all CPUs feature, avoid probing if
+		 * already detected.
+		 */
+		if (!match_all && caps_set)
+			continue;
+
+		/*
+		 * A match-all CPUs capability is only set when probing the
+		 * boot CPU. It may be cleared subsequently if not detected on
+		 * secondary ones.
+		 */
+		if (match_all && !caps_set && !boot_cpu)
+			continue;
+
+		if (!caps->matches(caps, cpucap_default_scope(caps))) {
+			if (match_all)
+				__clear_bit(caps->capability, system_cpucaps);
+			continue;
+		}
+
+		/*
+		 * Match-all CPUs capabilities are logged later when the
+		 * system capabilities are finalised.
+		 */
+		if (!match_all && caps->desc && !caps->cpus)
 			pr_info("detected: %s\n", caps->desc);
 
 		__set_bit(caps->capability, system_cpucaps);
 
-		if ((scope_mask & SCOPE_BOOT_CPU) && (caps->type & SCOPE_BOOT_CPU))
+		if (boot_cpu && (caps->type & SCOPE_BOOT_CPU))
 			set_bit(caps->capability, boot_cpucaps);
 	}
 }
@@ -3782,17 +3813,24 @@ static void __init setup_system_capabilities(void)
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
+		/* Log match-all CPUs capabilities */
+		if (cpucap_match_all_early_cpus(caps) &&
+		    cpus_have_cap(caps->capability))
+			pr_info("detected: %s\n", caps->desc);
 	}
 
 	/*
-- 
2.49.0

