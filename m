Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5216281531
	for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725235; cv=none; b=nylL4miVh8TymZcRWYLldGjh4cA3WhosijQ9kg1D7h06KWVgWZrHyETbgvpRRyiYo44e5AD0FXW5BaxIVqzy3BoPuMfpE7LNTOyMCdrLLr5esZ4IrSRtf/B3nuJp1vOcgOfghcsjaaSI3QhIKCDpaXZRHqAOs8Hhq6jrODpB0lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725235; c=relaxed/simple;
	bh=95chHff3zz7czkSoAmCuKp67OLtQgVr9l5n9sMY6pcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HNK5UE4lftGr7Gbkp3TwMIPMuuEgf7B67aZr3u6hQG/txiO2U2WRleUdRI/eVRx6js1uR5g6tirVg8B+XxG5v5i5fZ8SDcZMQXrurwVXO37lydGKY42QPapB1N7lXEoQh7ECvdyZZHDv9odRSU0zo1WSWKfW5yYfJb8hw770MwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=of6NdjJC; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="of6NdjJC"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b7865dc367so986713f8f.2
        for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725228; x=1754330028; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9jYddvCz41uASA7Sa8Gd38u2bIDrZAA55dbZYiHYK0=;
        b=of6NdjJCJ87YccDxLBzoB9VWrd0M2MbvaBpGQtLCzRjRwZATUFflM/b9lKh6RUgx1n
         hxVwqrJ44QNVg6kaAZxIuKsKgfiRZdhfgWwf6OVRFty1WUXK4cjGfPXVNTRNaOFo9k/d
         SQlGSNzhns/HKmdEQmMYmnTJRvnzBjf7JoDYOXqEHKjHDFfe+GJ0XNjiRbXIDNmqZOAA
         oZF9Ii2HPkhGttzEBSgolDoj8G7+vrS8E9FdAKk7aExpmfdXP3WXxjqlV/CLbDHL9OYr
         EhwDqNCuhFLiZSEdGAarSuhNbla7Sd1/TX72qBXWXiiJDzCHezqZN/bUs0yqL5RUoxMV
         0naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725228; x=1754330028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9jYddvCz41uASA7Sa8Gd38u2bIDrZAA55dbZYiHYK0=;
        b=C2QhvLT+Fb3uCgthQVsqu6XO8wixgljf1yjVv+0cxTkAAmLMQf5+a9kV1ed9Q4qKyd
         1EgHaw2oDy2OVaKThcUj1LZUgQiTVyPd2YsXYO+R7kiFPojuL0KVUNCUDJvfP54AY4sa
         v9Rok5iHy/+uIicORxckf52EF7vAcmjiYxSs69ArNw8ghCUL/j7OjdxmtjJ0ytmxgx6e
         3HV9a4out7cMl7OnBCe8tQppcbjq1KPbN6UtdpME9ZEPy7jlC4J32Dyi/veb2Eproud9
         lPUZ657mGMikMxc/BkCKQfwB6s7bshrxxDN/+mnvRbNTsGFPMu2guWj1/IoCC7H2nysR
         0FCg==
X-Forwarded-Encrypted: i=1; AJvYcCVC5fDnj3t3ocXXUOF+21ZIBZR7+Opj29qyDCFJ46cLnWzQzCcWJiBF7BhHnmPvjiAHDvTJ2w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh8rR9gtVtqz4aGVBN5ctQfRXSgwqL6BbVhdM8C5K7+Ab4LUb1
	NGZ9bgf4VtEdJypIHzJvIIvjGIHqvUnZLjoylsV91Pwu9hxhGTPnSprIYkyN9v6+5qvWJC5eoWI
	5o4ZI3Yr0MCl6og==
X-Google-Smtp-Source: AGHT+IEIq4MuTZmAyjvY5ywUEpjJvcVv09tn1ZoK52Hz7k9v+do6OvW02sN+sKfvQsmRTrBRzkW0d1TsmWpcEQ==
X-Received: from wmbhh14.prod.google.com ([2002:a05:600c:530e:b0:455:76a8:b3a])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:a3d0:0:b0:3b7:899c:e867 with SMTP id ffacd0b85a97d-3b7899ceb31mr1880112f8f.59.1753725228115;
 Mon, 28 Jul 2025 10:53:48 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:53:05 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-19-smostafa@google.com>
Subject: [PATCH v3 18/29] iommu/arm-smmu-v3-kvm: Add SMMUv3 driver
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add the skeleton for an Arm SMMUv3 driver at EL2.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile              |  5 ++++
 drivers/iommu/arm/Kconfig                     |  9 +++++++
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 24 +++++++++++++++++++
 .../iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h  | 16 +++++++++++++
 4 files changed, 54 insertions(+)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 393ff143f0be..c71c96262378 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -31,6 +31,11 @@ hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
 hyp-obj-y += $(lib-objs)
 
+HYP_SMMU_V3_DRV_PATH = ../../../../../drivers/iommu/arm/arm-smmu-v3
+
+hyp-obj-$(CONFIG_ARM_SMMU_V3_PKVM) += $(HYP_SMMU_V3_DRV_PATH)/pkvm/arm-smmu-v3.o \
+	$(HYP_SMMU_V3_DRV_PATH)/arm-smmu-v3-common-hyp.o
+
 ##
 ## Build rules for compiling nVHE hyp code
 ## Output of this folder is `kvm_nvhe.o`, a partially linked object
diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
index ef42bbe07dbe..bcf4001521ad 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -142,3 +142,12 @@ config QCOM_IOMMU
 	select ARM_DMA_USE_IOMMU
 	help
 	  Support for IOMMU on certain Qualcomm SoCs.
+
+config ARM_SMMU_V3_PKVM
+	bool "ARM SMMUv3 support for protected Virtual Machines"
+	depends on KVM && ARM64
+	help
+	  Enable a SMMUv3 driver in the KVM hypervisor, to protect VMs against
+	  memory accesses from devices owned by the host.
+
+	  Say Y here if you intend to enable KVM in protected mode.
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
new file mode 100644
index 000000000000..2f43804e08e0
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -0,0 +1,24 @@
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
+/* Shared with the kernel driver in EL1 */
+struct kvm_iommu_ops smmu_ops = {
+	.init				= smmu_init,
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
2.50.1.552.g942d659e1b-goog

