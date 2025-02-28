Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27926276047
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767115; cv=none; b=KkB4BrmjmDoCxZleIoA/4QR1qKNFXYAJPSRCro2Gc9UJAKAbpvqgRsPK8jFLSQOobLisM08CF4Q75KdarYB5ZWUoss6u9+6BYLmD5PyfUyfdXJOCMV3TQnzYAA/eQFa5t+CV6Kt5xIFysDt2jmRnsIqjUlAioNI2CCqP/pGGGZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767115; c=relaxed/simple;
	bh=6uGwAcLbm3t+Zps/udwLTEPw6sNc32vRTg57BBTBmDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aL8ioZs4xYUjaTaJFweobDiKnaFvxiXpfvdS/3PGuRp6/A0fVlgVE2pE9RtRHi787hXlg5+CePlwvIxUO0/ZF/pYD3lgqonuc9Uq0FeVA3mCkxrxkiVpGB3f+XKreLoPLZJICuFPzbFQ+ljtjXChizlntqNuOLuiBWCgkZkSnZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F5781515;
	Fri, 28 Feb 2025 10:25:26 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 413A03F6A8;
	Fri, 28 Feb 2025 10:25:08 -0800 (PST)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	suzuki.poulose@arm.com,
	yang@os.amperecomputing.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	joro@8bytes.org,
	jean-philippe@linaro.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	oliver.upton@linux.dev,
	james.morse@arm.com,
	broonie@kernel.org,
	maz@kernel.org,
	david@redhat.com,
	akpm@linux-foundation.org,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	mshavit@google.com,
	jsnitsel@redhat.com,
	smostafa@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v2 1/4] arm64: Add BBM Level 2 cpu feature
Date: Fri, 28 Feb 2025 18:24:01 +0000
Message-ID: <20250228182403.6269-3-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250228182403.6269-2-miko.lenczewski@arm.com>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
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
support for.

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
 arch/arm64/Kconfig                  | 11 +++++
 arch/arm64/include/asm/cpucaps.h    |  2 +
 arch/arm64/include/asm/cpufeature.h |  5 +++
 arch/arm64/kernel/cpufeature.c      | 69 +++++++++++++++++++++++++++++
 arch/arm64/tools/cpucaps            |  1 +
 5 files changed, 88 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 940343beb3d4..baae6d458996 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2057,6 +2057,17 @@ config ARM64_TLB_RANGE
 	  The feature introduces new assembly instructions, and they were
 	  support when binutils >= 2.30.
 
+config ARM64_ENABLE_BBML2_NOABORT
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
index e0e4478f5fb5..108ef3fbbc00 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -866,6 +866,11 @@ static __always_inline bool system_supports_mpam_hcr(void)
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
index d561cf3b8ac7..63f6d356dc77 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2176,6 +2176,68 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
 	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
 }
 
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
+	if (!IS_ENABLED(CONFIG_ARM64_ENABLE_BBML2_NOABORT))
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
@@ -2926,6 +2988,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
 	},
+	{
+		.desc = "BBM Level 2 without conflict abort",
+		.capability = ARM64_HAS_BBML2_NOABORT,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_bbml2_noabort,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, BBM, 2)
+	},
 	{
 		.desc = "52-bit Virtual Addressing for KVM (LPA2)",
 		.capability = ARM64_HAS_LPA2,
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
2.45.3

