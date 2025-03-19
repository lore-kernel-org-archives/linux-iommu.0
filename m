Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DE8211A06
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396772; cv=none; b=cspvZHg7uxVZgsjTjzFQuCeDWmiUhZZiPCMeGCmipM7Y2k42O+QPqwgMZk+Di/IghPUbCD9QCE0fmM8sOyc2imCLXJKj6QR69vWJV27IBAftG97rRVT/OfAcIMA+EJ9RL3XKLqkk+FANDsnxFS09ypjE/7NrM9OJgcVomrB9YYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396772; c=relaxed/simple;
	bh=1EjsuXTQfqF+sCmAZkUf4HSAiiysZCROH9jJou8ve5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8OEMx5ezlCoav71G4jJYgBhQ/7pzCL6IlNhgdCFNRn1kNJyBGdoboyhb8DKFMXoYX50vTXJqx7AYC9S0MdOktPwqk/SWHY+qmoACHZjFRn/sFqTIDltIW4TWPHCBhuvrubE5opVihtlTt4znsXLPIgiYjRreG3+UcyLoaWbTDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F78714BF;
	Wed, 19 Mar 2025 08:06:18 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 551803F694;
	Wed, 19 Mar 2025 08:06:06 -0700 (PDT)
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
	ardb@kernel.org,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	james.morse@arm.com,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	baohua@kernel.org,
	david@redhat.com,
	ioworker0@gmail.com,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	mshavit@google.com,
	jsnitsel@redhat.com,
	smostafa@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v4 2/3] iommu/arm: Add BBM Level 2 smmu feature
Date: Wed, 19 Mar 2025 15:05:33 +0000
Message-ID: <20250319150533.37440-4-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319150533.37440-2-miko.lenczewski@arm.com>
References: <20250319150533.37440-2-miko.lenczewski@arm.com>
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
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 4 ++++
 3 files changed, 10 insertions(+)

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
2.48.1

