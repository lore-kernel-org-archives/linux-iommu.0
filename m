Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B5337690
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405322; cv=none; b=gM4bjdgrY1I9LzQr4beGHsKLqfCUaedER+S+fjiMln//P+2l3jAlD7erMACb+skiA9FWV4UA+gcNd4ntRffdQzSLe7bWFKfV6B9gmwEUZpO8S6KAj2F43dc4RvswiSgq1EkcsupjSBXT37s9wl8zRN/T9zxNN6/2GjMZjCV2gL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405322; c=relaxed/simple;
	bh=X1SB8xBsyDP9CObrHvadpvuvmKMLHDjQeJHpDgXwBrU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EQxmE26mCGqtEwKlhfyeEAG2HArNcTDrUij/K3UH5egH4br/teeYN8uz8/mqbBbsJXwQ5YsBQgU4ewKWMfAmC9HtSFXM2NZcuTMslfbjMFh6wMNCD8alqOvYx+v9OAQXqkG7DDariOdhML95MeeXfYEAgaYaj8QnNhzoEDBQxOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUPlv6hb; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUPlv6hb"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b3086a055so3070798f8f.3
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 10:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763405318; x=1764010118; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VXBWv8Dw5hE8mlU4Sm4VTohDwotOri7T9rWgww1xmos=;
        b=HUPlv6hbdLEasy1TJDwPw/g3D/wY3JxLgf75UAi6l1pFIvXig9/dC6Oyf6CRftGmHO
         QA/6pXcqXv7mFG0jBZKDgA7W2T98T2CuXMR6b/2GwCwNwkPNCLjuvEzwmhcdu7E7r26b
         gWK76FRWCzG4KtcFl+wTSsbk4S+amj5xjoqbr9p3g8IeCb8ZmcfeBciIU1szoJouGEE4
         lKksCdEJzD3qtRFx06qpf7GZXYDWYBOhl/ssJzweLaJxAzsSo/s6tWbW0SqWR76AEz1w
         SIkoiyix6M4f++aOckTRKvQDWZDORVU7dStVDa+fdGxCHxRv1ABjgFt/DTVDDxCZP7Lm
         +RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763405318; x=1764010118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXBWv8Dw5hE8mlU4Sm4VTohDwotOri7T9rWgww1xmos=;
        b=Dwu4bg+2aCUR7+s6M+AcWVIFhH7lZ+kK0WieZou3Zq09QBhzadM8BvbL/NN00OzKDU
         DM/mSpFFcxZOmWVHclvp3/EbBic3itlJAC//Vi/QvTmZTAnVpKJzKIThieQa87ZNhKdI
         Nhodvnxn8cAh0mWVJLbxAhV2mHOEAFOpSJWNT6IdZblekX/tqNMTCYFB32N+3OhZxHv0
         0jAmV5kO7Edq178Y/ROE2LSdamzE/driea/WSGYtHYSLpIo6792AyKoS4eOZjXX63K+o
         R3Bz9TPNeX/P7fHyDPBffrBrnIxuQdAplrf/uNDxSGQud5jnWPdJI61y6Ac0DfXwHxXq
         dAHA==
X-Forwarded-Encrypted: i=1; AJvYcCUxpW2cHoxHTR5vqmdCpEF5E7sRQqSEM4UXtU16Ots5CVipWQngh2mN4Nm1pyOzNVqMVkal+A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd/1PalI6GrcHO5D/KM+r96gegaQttwQ2WLrP90bzhSC+e49ij
	L2mZlcvgh6hpHIOPWJ940MxdcGY973QTVz8gowkIWYD6msGTle3NmeIAkRZ2oBaODiRCveeaBdD
	QrgDOVFaZUl3LXg==
X-Google-Smtp-Source: AGHT+IHQBDWwjO/s1zZNuEFY1oL5kAjhY98F1o68vfkU7yeDw2zqyTvhCAFTbYHvFaunhrv4os5cxfn9oBJJZA==
X-Received: from wrxe9.prod.google.com ([2002:a05:6000:1209:b0:428:563f:ce93])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:615:b0:42b:3a1b:f71a with SMTP id ffacd0b85a97d-42b5934e2b6mr13388046f8f.23.1763405318003;
 Mon, 17 Nov 2025 10:48:38 -0800 (PST)
Date: Mon, 17 Nov 2025 18:47:59 +0000
In-Reply-To: <20251117184815.1027271-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251117184815.1027271-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117184815.1027271-13-smostafa@google.com>
Subject: [PATCH v5 12/27] iommu/arm-smmu-v3-kvm: Add SMMUv3 driver
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org, jgg@ziepe.ca, 
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com, 
	qperret@google.com, tabba@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add the skeleton for an Arm SMMUv3 driver at EL2.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile              |  5 ++++
 drivers/iommu/arm/Kconfig                     |  9 ++++++
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 29 +++++++++++++++++++
 .../iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h  | 16 ++++++++++
 4 files changed, 59 insertions(+)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 8210788d6f88..197685817546 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -32,6 +32,11 @@ hyp-obj-y += ../../../kernel/smccc-call.o
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
 hyp-obj-y += $(lib-objs)
 
+HYP_SMMU_V3_DRV_PATH = ../../../../../drivers/iommu/arm/arm-smmu-v3
+
+hyp-obj-$(CONFIG_ARM_SMMU_V3_PKVM) += $(HYP_SMMU_V3_DRV_PATH)/pkvm/arm-smmu-v3.o \
+	$(HYP_SMMU_V3_DRV_PATH)/arm-smmu-v3-common-lib.o
+
 ##
 ## Build rules for compiling nVHE hyp code
 ## Output of this folder is `kvm_nvhe.o`, a partially linked object
diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
index ef42bbe07dbe..7eeb94d2499d 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -142,3 +142,12 @@ config QCOM_IOMMU
 	select ARM_DMA_USE_IOMMU
 	help
 	  Support for IOMMU on certain Qualcomm SoCs.
+
+config ARM_SMMU_V3_PKVM
+	bool "ARM SMMUv3 support for protected Virtual Machines"
+	depends on KVM && ARM64 && ARM_SMMU_V3=y
+	help
+	  Enable a SMMUv3 driver in the KVM hypervisor, to protect VMs against
+	  memory accesses from devices owned by the host.
+
+	  Say Y here if you intend to enable KVM in protected mode.
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
new file mode 100644
index 000000000000..fa8b71152560
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pKVM hyp driver for the Arm SMMUv3
+ *
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+#include <asm/kvm_hyp.h>
+
+#include <nvhe/iommu.h>
+
+#include "arm_smmu_v3.h"
+
+size_t __ro_after_init kvm_hyp_arm_smmu_v3_count;
+struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
+
+static int smmu_init(void)
+{
+	return -ENOSYS;
+}
+
+static void smmu_host_stage2_idmap(phys_addr_t start, phys_addr_t end, int prot)
+{
+}
+
+/* Shared with the kernel driver in EL1 */
+struct kvm_iommu_ops smmu_ops = {
+	.init				= smmu_init,
+	.host_stage2_idmap		= smmu_host_stage2_idmap,
+};
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
new file mode 100644
index 000000000000..f6ad91d3fb85
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __KVM_ARM_SMMU_V3_H
+#define __KVM_ARM_SMMU_V3_H
+
+#include <asm/kvm_asm.h>
+
+struct hyp_arm_smmu_v3_device {
+};
+
+extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
+#define kvm_hyp_arm_smmu_v3_count kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count)
+
+extern struct hyp_arm_smmu_v3_device *kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_smmus);
+#define kvm_hyp_arm_smmu_v3_smmus kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_smmus)
+
+#endif /* __KVM_ARM_SMMU_V3_H */
-- 
2.52.0.rc1.455.g30608eb744-goog

