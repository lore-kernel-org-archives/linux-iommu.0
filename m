Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC5F265CDC
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862601; cv=none; b=p6EghH4/evuiI0CBBZilZV6QgvgA8+TCHybsukqJKGd/tncTFB3sakRtvpMoXdDGBDtx6jKwfW1K/BRRqgQjfhhSdzqE3mX3SW3PG3InggodEqu3Py7BKMVcTmO8vCKJ0Hgg34+WQeAu2EP8bYh8pGKO5j54cVJDreZy5sx+PMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862601; c=relaxed/simple;
	bh=5Ah0icJcj8unsEFB2zHwTT8H74XrZn2txUr6uykFH0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzYappO11q4NK9E4g929m++DifT12gfWqH/QffdJEpup4xO1YCBHY0kgLEjKH//e9RxD8/8jGG9F26BfTyJWtkdw5sCIlPNyzivn7QS3JqQm4eNugo7zcbAmHLzW9Gv2Lwd96VSFA0cXE9osFblMmkcgJZD+I1XntZ8+BUc+4Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D38E1F02;
	Thu, 13 Mar 2025 03:43:29 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12DD13F694;
	Thu, 13 Mar 2025 03:43:14 -0700 (PDT)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	suzuki.poulose@arm.com,
	yang@os.amperecomputing.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	will@kernel.org,
	jean-philippe@linaro.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	akpm@linux-foundation.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	james.morse@arm.com,
	broonie@kernel.org,
	anshuman.khandual@arm.com,
	oliver.upton@linux.dev,
	ioworker0@gmail.com,
	baohua@kernel.org,
	david@redhat.com,
	jgg@ziepe.ca,
	shameerali.kolothum.thodi@huawei.com,
	nicolinc@nvidia.com,
	mshavit@google.com,
	jsnitsel@redhat.com,
	smostafa@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v3 1/3] arm64: Add BBM Level 2 cpu feature
Date: Thu, 13 Mar 2025 10:41:10 +0000
Message-ID: <20250313104111.24196-3-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313104111.24196-2-miko.lenczewski@arm.com>
References: <20250313104111.24196-2-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
and this commit adds a dedicated BBML2 cpufeature to test against
support for, as well as a kernel commandline parameter to optionally
disable BBML2 altogether.

This is a system feature as we might have a big.LITTLE architecture
where some cores support BBML2 and some don't, but we want all cores to
be available and BBM to default to level 0 (as opposed to having cores
without BBML2 not coming online).

To support BBML2 in as wide a range of contexts as we can, we want not
only the architectural guarantees that BBML2 makes, but additionally
want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
us having to prove that no recursive faults can be induced in any path
that uses BBML2, allowing its use for arbitrary kernel mappings.
Support detection of such CPUs.

Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 +
 arch/arm64/Kconfig                            | 11 +++
 arch/arm64/include/asm/cpucaps.h              |  2 +
 arch/arm64/include/asm/cpufeature.h           |  6 ++
 arch/arm64/kernel/cpufeature.c                | 76 +++++++++++++++++++
 arch/arm64/kernel/pi/idreg-override.c         |  2 +
 arch/arm64/tools/cpucaps                      |  1 +
 7 files changed, 101 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..3e4cc917a07e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -453,6 +453,9 @@
 	arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
 			32 bit applications.
 
+	arm64.nobbml2	[ARM64] Unconditionally disable Break-Before-Make Level
+			2 support
+
 	arm64.nobti	[ARM64] Unconditionally disable Branch Target
 			Identification support
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 940343beb3d4..49deda2b22ae 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2057,6 +2057,17 @@ config ARM64_TLB_RANGE
 	  The feature introduces new assembly instructions, and they were
 	  support when binutils >= 2.30.
 
+config ARM64_BBML2_NOABORT
+	bool "Enable support for Break-Before-Make Level 2 detection and usage"
+	default y
+	help
+	  FEAT_BBM provides detection of support levels for break-before-make
+	  sequences. If BBM level 2 is supported, some TLB maintenance requirements
+	  can be relaxed to improve performance. We additonally require the
+	  property that the implementation cannot ever raise TLB Conflict Aborts.
+	  Selecting N causes the kernel to fallback to BBM level 0 behaviour
+	  even if the system supports BBM level 2.
+
 endmenu # "ARMv8.4 architectural features"
 
 menu "ARMv8.5 architectural features"
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 0b5ca6e0eb09..2d6db33d4e45 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -23,6 +23,8 @@ cpucap_is_possible(const unsigned int cap)
 		return IS_ENABLED(CONFIG_ARM64_PAN);
 	case ARM64_HAS_EPAN:
 		return IS_ENABLED(CONFIG_ARM64_EPAN);
+	case ARM64_HAS_BBML2_NOABORT:
+		return IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT);
 	case ARM64_SVE:
 		return IS_ENABLED(CONFIG_ARM64_SVE);
 	case ARM64_SME:
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index e0e4478f5fb5..7f5b220dacde 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -18,6 +18,7 @@
 #define ARM64_SW_FEATURE_OVERRIDE_NOKASLR	0
 #define ARM64_SW_FEATURE_OVERRIDE_HVHE		4
 #define ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF	8
+#define ARM64_SW_FEATURE_OVERRIDE_NOBBML2	12
 
 #ifndef __ASSEMBLY__
 
@@ -866,6 +867,11 @@ static __always_inline bool system_supports_mpam_hcr(void)
 	return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
 }
 
+static inline bool system_supports_bbml2_noabort(void)
+{
+	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
+}
+
 int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d561cf3b8ac7..b936e0805161 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2176,6 +2176,76 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
 	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
 }
 
+static inline bool bbml2_possible(void)
+{
+	return !arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_NOBBML2);
+}
+
+static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
+{
+	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
+	 * as possible. This list is therefore an allow-list of known-good
+	 * implementations that both support bbml2 and additionally, fulfill the
+	 * extra constraint of never generating TLB conflict aborts when using
+	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
+	 * kernel contexts difficult to prove safe against recursive aborts).
+	 *
+	 * Note that implementations can only be considered "known-good" if their
+	 * implementors attest to the fact that the implementation never raises
+	 * TLBI conflict aborts for bbml2 mapping granularity changes.
+	 */
+	static const struct midr_range supports_bbml2_noabort_list[] = {
+		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
+		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
+		{}
+	};
+
+	return is_midr_in_range_list(cpu_midr, supports_bbml2_noabort_list);
+}
+
+static inline unsigned int __cpu_read_midr(int cpu)
+{
+	WARN_ON_ONCE(!cpu_online(cpu));
+
+	return per_cpu(cpu_data, cpu).reg_midr;
+}
+
+static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
+{
+	if (!IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT))
+		return false;
+
+	if (!bbml2_possible())
+		return false;
+
+	if (scope & SCOPE_SYSTEM) {
+		int cpu;
+
+		/* We are a boot CPU, and must verify that all enumerated boot
+		 * CPUs have MIDR values within our allowlist. Otherwise, we do
+		 * not allow the BBML2 feature to avoid potential faults when
+		 * the insufficient CPUs access memory regions using BBML2
+		 * semantics.
+		 */
+		for_each_online_cpu(cpu) {
+			if (!cpu_has_bbml2_noabort(__cpu_read_midr(cpu)))
+				return false;
+		}
+
+		return true;
+	} else if (scope & SCOPE_LOCAL_CPU) {
+		/* We are a hot-plugged CPU, so only need to check our MIDR.
+		 * If we have the correct MIDR, but the kernel booted on an
+		 * insufficient CPU, we will not use BBML2 (this is safe). If
+		 * we have an incorrect MIDR, but the kernel booted on a
+		 * sufficient CPU, we will not bring up this CPU.
+		 */
+		return cpu_has_bbml2_noabort(read_cpuid_id());
+	}
+
+	return false;
+}
+
 #ifdef CONFIG_ARM64_PAN
 static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
 {
@@ -2926,6 +2996,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
 	},
+	{
+		.desc = "BBM Level 2 without conflict abort",
+		.capability = ARM64_HAS_BBML2_NOABORT,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_bbml2_noabort,
+	},
 	{
 		.desc = "52-bit Virtual Addressing for KVM (LPA2)",
 		.capability = ARM64_HAS_LPA2,
diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
index c6b185b885f7..9728faa10390 100644
--- a/arch/arm64/kernel/pi/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -209,6 +209,7 @@ static const struct ftr_set_desc sw_features __prel64_initconst = {
 		FIELD("nokaslr", ARM64_SW_FEATURE_OVERRIDE_NOKASLR, NULL),
 		FIELD("hvhe", ARM64_SW_FEATURE_OVERRIDE_HVHE, hvhe_filter),
 		FIELD("rodataoff", ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF, NULL),
+		FIELD("nobbml2", ARM64_SW_FEATURE_OVERRIDE_NOBBML2, NULL),
 		{}
 	},
 };
@@ -246,6 +247,7 @@ static const struct {
 	{ "rodata=off",			"arm64_sw.rodataoff=1" },
 	{ "arm64.nolva",		"id_aa64mmfr2.varange=0" },
 	{ "arm64.no32bit_el0",		"id_aa64pfr0.el0=1" },
+	{ "arm64.nobbml2",		"arm64_sw.nobbml2=1" },
 };
 
 static int __init parse_hexdigit(const char *p, u64 *v)
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 1e65f2fb45bd..b03a375e5507 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -14,6 +14,7 @@ HAS_ADDRESS_AUTH_ARCH_QARMA5
 HAS_ADDRESS_AUTH_IMP_DEF
 HAS_AMU_EXTN
 HAS_ARMv8_4_TTL
+HAS_BBML2_NOABORT
 HAS_CACHE_DIC
 HAS_CACHE_IDC
 HAS_CNP
-- 
2.48.1

