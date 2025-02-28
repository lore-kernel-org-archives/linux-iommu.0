Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A858C27426B
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767124; cv=none; b=HVenO7txbQqEXojDk3ofBnkS/OzbzlVz3HHq9ypsjOIBP/Rf/MAIEyl43ShzJgjwRNpNDJnOMsAZkAvPAzmF4EjXvN5i2A40fmsG7wH2izcvyKtZs3klw1bZn6q/mtQRuzXegao0+01FJDGmNM318MomLewqow4h6jekD29G5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767124; c=relaxed/simple;
	bh=isMZCeL05jqInw1dcZFOt7OjqqcZM5ZV9+VOww44NeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjE8tBkT+KgPrTgj/RGuVQCwzpiBHC7M2c1tVvjQnDbkD7FFgB0XDpSNQWTHE3PAbxmmTDh7jpVUt97EJkYuYU11/lZhKYIs8igSJD7rUCdncNbKFgF5U+Vx+YdVQlmwhhUybQfPNaGyTto6YxckXAb1sXbj0fRk5KeDmcbdW0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4995D19F0;
	Fri, 28 Feb 2025 10:25:37 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF65D3F6A8;
	Fri, 28 Feb 2025 10:25:18 -0800 (PST)
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
Subject: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
Date: Fri, 28 Feb 2025 18:24:04 +0000
Message-ID: <20250228182403.6269-6-miko.lenczewski@arm.com>
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

For supporting BBM Level 2 for userspace mappings, we want to ensure
that the smmu also supports its own version of BBM Level 2. Luckily, the
smmu spec (IHI 0070G 3.21.1.3) is stricter than the aarch64 spec (DDI
0487K.a D8.16.2), so already guarantees that no aborts are raised when
BBM level 2 is claimed.

Add the feature and testing for it under arm_smmu_sva_supported().

Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
---
 arch/arm64/kernel/cpufeature.c                  | 7 +++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 4 ++++
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 63f6d356dc77..1022c63f81b2 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2223,8 +2223,6 @@ static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int sco
 			if (!cpu_has_bbml2_noabort(__cpu_read_midr(cpu)))
 				return false;
 		}
-
-		return true;
 	} else if (scope & SCOPE_LOCAL_CPU) {
 		/* We are a hot-plugged CPU, so only need to check our MIDR.
 		 * If we have the correct MIDR, but the kernel booted on an
@@ -2232,10 +2230,11 @@ static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int sco
 		 * we have an incorrect MIDR, but the kernel booted on a
 		 * sufficient CPU, we will not bring up this CPU.
 		 */
-		return cpu_has_bbml2_noabort(read_cpuid_id());
+		if (!cpu_has_bbml2_noabort(read_cpuid_id()))
+			return false;
 	}
 
-	return false;
+	return has_cpuid_feature(caps, scope);
 }
 
 #ifdef CONFIG_ARM64_PAN
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 9ba596430e7c..6ba182572788 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -222,6 +222,9 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 		feat_mask |= ARM_SMMU_FEAT_VAX;
 	}
 
+	if (system_supports_bbml2_noabort())
+		feat_mask |= ARM_SMMU_FEAT_BBML2;
+
 	if ((smmu->features & feat_mask) != feat_mask)
 		return false;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 358072b4e293..dcee0bdec924 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4406,6 +4406,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (FIELD_GET(IDR3_RIL, reg))
 		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
 
+	if (FIELD_GET(IDR3_BBML, reg) == IDR3_BBML2)
+		smmu->features |= ARM_SMMU_FEAT_BBML2;
+
 	/* IDR5 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bd9d7c85576a..85eaf3ab88c2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -60,6 +60,9 @@ struct arm_smmu_device;
 #define ARM_SMMU_IDR3			0xc
 #define IDR3_FWB			(1 << 8)
 #define IDR3_RIL			(1 << 10)
+#define IDR3_BBML			GENMASK(12, 11)
+#define IDR3_BBML1			(1 << 11)
+#define IDR3_BBML2			(2 << 11)
 
 #define ARM_SMMU_IDR5			0x14
 #define IDR5_STALL_MAX			GENMASK(31, 16)
@@ -754,6 +757,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_HA		(1 << 21)
 #define ARM_SMMU_FEAT_HD		(1 << 22)
 #define ARM_SMMU_FEAT_S2FWB		(1 << 23)
+#define ARM_SMMU_FEAT_BBML2		(1 << 24)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
-- 
2.45.3

