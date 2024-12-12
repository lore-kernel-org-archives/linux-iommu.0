Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B91A2368F2
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026739; cv=none; b=un9DZbn3WsXu3230je/F4y8LSer8OomDiUoAAXE/EOyp2VAzfq+O0cXIFn0V3thi+iRvfZv43WHTSfUC5+2LpStLtQpjtpIY5wzbkU2nkYeezPRee7ieqUwhInZ0gsDL8VIfBbw6cMIrhXt1dF5M0QHwsaDyugtkLxbzLSYRGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026739; c=relaxed/simple;
	bh=Z2UHwzkM46eNyOELnlSu5KplZV6dyg6FmiiX5LeoOuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rVObOU9fjidHbhD37TcPBx5MqxskpzQVLxW54Rvqaa8pbNAJm4cDjx81GbU6fBxGQDKYnamatEsWGWvrRm7jbM3AOvCr2s8Y8gEedKVYHrFJRgwaaiz+eLyuv9jfLvElYfooY8kuvjmaFTM6x9UZmpXBk4lrmLXTcxKyOcwj1lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oWt8sXhN; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWt8sXhN"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4361f371908so8309485e9.0
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 10:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026736; x=1734631536; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YdMuO2gtmeL3RMqWaakXFL6M4DlcZZq40B5WqzcNta4=;
        b=oWt8sXhN6sh/am+PHKKo8QiiibU28Vnpibnbtu5AUf6C7NM2DzMkSEsC36MTDe0NLB
         cyHrZtIFsWOqj4zgOSxMRhxyNtBuiZ6nqvwZu1WHJFyhxIzQg57tji1desRdWjVNHcpV
         qq4ZAVbEo8u0a6kvFzM95kyM47vQliAzkCDVoy1QUcffpsfBbAh0ao3F4nCiqDaIB2Xu
         2OjR4gJkYRDu8NMCwoczJhO+hLVufr72u960yhpNBFo8Gn5jtFDuwFKNWjd8AvAAbQyn
         YgkEyyF49l1yEQQVMaXLtdAph9MkLNlRb5bKGVgnwAXrNCgfG1J5HlYcj1VtYc+NXK0H
         TLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026736; x=1734631536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdMuO2gtmeL3RMqWaakXFL6M4DlcZZq40B5WqzcNta4=;
        b=pZsNx1dEyrl32Pg7t5TZZkZY8tx8Lk6abWkQJ9zEl0rN3PFk1ZGt6qNb51LBVHE41v
         CvqJqR337BLlKUBzzSk1CQGN3nrARN57OyyI7RFGJvIrFvcfnPmwZEENncFAfocTlsTp
         h4lEumnYwDblQXyner9DBY3e+6Ijyn+ZwlsFcHStliAIQpGLk7xwPabyb/ZhHmt1WEGu
         3Z0fJDgR0IiZ/pdvGWR2UxgRwOyPH0YMegGDk2si0Qse29evDJTILDLOhLsRdlDezw8Y
         tlM146/O5gBPRax+hphZra+LmnKuRbE35fuO9WcyVXnbhuLVf4SxEoJDaafiixQfNfPv
         WZXA==
X-Gm-Message-State: AOJu0YyfHDnB3ZaSCyDxSU5ENelBUcB066K7uS9+nFmgZ/mWhzqaYMiS
	wSjOu6F0JlmkoI9Yj4yvBzLl2F1yH+MelZbG4y723/Ad9+z9FcbueZkIeD/xAchr2V9Ry0uC1b/
	B+AizCtNX/L7zmEGb0nhQL3B8lIFQoA3M2qCutGQllSa+yk0N8EIfnDmh/bZGw9h6o5DWKjCwtA
	7/F/4NmMFMY2+w+yDZaVukbd79h2xrU/U65LsXFJwkwg==
X-Google-Smtp-Source: AGHT+IFhLgvU2Rm+DNubCv6JNasQpuX6sd+/DiydVh4HkRumx8mqOJN1mpnAimZm+KH9fDL3y3s/kc2a4/LuEQ==
X-Received: from wmso20.prod.google.com ([2002:a05:600c:5114:b0:436:1abf:b8fe])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5028:b0:435:172:5052 with SMTP id 5b1f17b1804b1-4362282768bmr38379225e9.1.1734026735825;
 Thu, 12 Dec 2024 10:05:35 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:49 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-26-smostafa@google.com>
Subject: [RFC PATCH v2 25/58] KVM: arm64: iommu: Add SMMUv3 driver
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add the skeleton for an Arm SMMUv3 driver at EL2.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile            |  2 ++
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c | 22 +++++++++++++++++++++
 drivers/iommu/Kconfig                       |  9 +++++++++
 include/kvm/arm_smmu_v3.h                   | 18 +++++++++++++++++
 4 files changed, 51 insertions(+)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
 create mode 100644 include/kvm/arm_smmu_v3.h

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index d846962e7246..edfd8a11ac90 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -16,6 +16,8 @@ hyp-obj-$(CONFIG_TRACING) += clock.o events.o trace.o
 hyp-obj-$(CONFIG_MODULES) += modules.o
 hyp-obj-y += $(lib-objs)
 
+hyp-obj-$(CONFIG_ARM_SMMU_V3_PKVM) += iommu/arm-smmu-v3.o
+
 $(obj)/hyp.lds: $(src)/hyp.lds.S FORCE
 	$(call if_changed_dep,cpp_lds_S)
 
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
new file mode 100644
index 000000000000..d2a570c9f3ec
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pKVM hyp driver for the Arm SMMUv3
+ *
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+#include <asm/kvm_hyp.h>
+#include <kvm/arm_smmu_v3.h>
+#include <nvhe/iommu.h>
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
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index b3aa1f5d5321..fea5d6a8b90b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -437,6 +437,15 @@ config TEGRA241_CMDQV
 	  CMDQ-V extension.
 endif
 
+config ARM_SMMU_V3_PKVM
+	bool "ARM SMMUv3 support for protected Virtual Machines"
+	depends on KVM && ARM64
+	help
+	  Enable a SMMUv3 driver in the KVM hypervisor, to protect VMs against
+	  memory accesses from devices owned by the host.
+
+	  Say Y here if you intend to enable KVM in protected mode.
+
 config S390_IOMMU
 	def_bool y if S390 && PCI
 	depends on S390 && PCI
diff --git a/include/kvm/arm_smmu_v3.h b/include/kvm/arm_smmu_v3.h
new file mode 100644
index 000000000000..521028b3ff71
--- /dev/null
+++ b/include/kvm/arm_smmu_v3.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __KVM_ARM_SMMU_V3_H
+#define __KVM_ARM_SMMU_V3_H
+
+#include <asm/kvm_asm.h>
+#include <kvm/iommu.h>
+
+struct hyp_arm_smmu_v3_device {
+	struct kvm_hyp_iommu	iommu;
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
2.47.0.338.g60cca15819-goog

