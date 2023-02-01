Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3E2F49
	for <iommu@lists.linux.dev>; Wed,  1 Feb 2023 12:59:53 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id q10so17233956wrm.4
        for <iommu@lists.linux.dev>; Wed, 01 Feb 2023 04:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZemYmGEwO1gb7z6YKtNUBIsszZurcCZTkm3NxNyR8KY=;
        b=JOD8m4yzhH9gPfdkJLa+7RNLQC7WIcJKjPQe2frqePj3MBMrnCqzRD8MnDLYyAJrI/
         Sg6Sbu8gNVeKJMv9yIUPA0lfo7Aie2omWbfh5YXJZbVUOKZL/DAneVLlWJdqDAMeaC1y
         rt2gbxdwPcUDyWQue47pDhzBpMR8EIcp6xqnOz+OyULHG4gI7L3PuBoNhffsm/JJXmzN
         U2m7KVpH3hkYk4tNgNgBr4V0gW1hOSVX7R1i4YPkmllBg2AMkelRDVo4m4/NYXGs1lPc
         Y3M5oZWSzjMx5G1IYBHDukSiGPsJqeK/YQJf+C7BbbeTCW42VGlJlC2miKsxNH4pSDqj
         XApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZemYmGEwO1gb7z6YKtNUBIsszZurcCZTkm3NxNyR8KY=;
        b=4tXdK4F+qP+hqfE2pRWbviuZZNpYf54DHdNeLH4QVfVjqE6kBw4ILLpLwggN4xO9DC
         uD0Q8URJACJPT6QnYptD3ym9qHAaMdrwqmG4orPmZCmfkJo99vdayB7PnfNvUyHOgsCo
         fEgVgPVzeFWw8LgKBOrJyOjLbZo3usdz7dvY2q+BMk8b3ITIFjUT2LjV7EZ4XxHrao4O
         6zQLKZxhAWFKsustCSR863N2KGXAxHvVk1ViB2BiR87t/3ersumo5S98lI3H3yxR+9S2
         G9MQxm2uOBz18VfnmLbJ66XMxFQh/vIL8VsW+2X6VD1uG6yugWale5+htKniIfj4ULcb
         CyJg==
X-Gm-Message-State: AO0yUKUtq/IYo4Gk3vNaSHgW4qbsF+oXutrog3UHH+ONKcE99dQFPF2e
	SwqAhQScQIlHZzdf1k4f7a5unA==
X-Google-Smtp-Source: AK7set/TyPhNoqKUzXf4QDTT+ly131TfiVmHNekKz3oVZiuW5PpzJGZ8W/3imN/eBr/WwOkzC5/vTA==
X-Received: by 2002:a5d:6110:0:b0:2bf:b9a4:f688 with SMTP id v16-20020a5d6110000000b002bfb9a4f688mr2377463wrt.23.1675256393453;
        Wed, 01 Feb 2023 04:59:53 -0800 (PST)
Received: from localhost.localdomain (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id m15-20020a056000024f00b002bfae16ee2fsm17972811wrz.111.2023.02.01.04.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 04:59:53 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: maz@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	oliver.upton@linux.dev,
	yuzenghui@huawei.com,
	smostafa@google.com,
	dbrazdil@google.com,
	ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	iommu@lists.linux.dev,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH 43/45] KVM: arm64: smmu-v3: Support power management
Date: Wed,  1 Feb 2023 12:53:27 +0000
Message-Id: <20230201125328.2186498-44-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201125328.2186498-1-jean-philippe@linaro.org>
References: <20230201125328.2186498-1-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power domain ops to the hypervisor IOMMU driver. We currently make
these assumptions:

* The register state is retained across power off.
* The TLBs are clean on power on.
* Another privileged software (EL3 or SCP FW) handles dependencies
  between SMMU and endpoints.

So we just need to make sure that the CPU does not touch the SMMU
registers while it is powered off.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/kvm/arm_smmu_v3.h                   |  4 +++
 include/kvm/iommu.h                         |  4 +++
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c | 12 +++++++
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c       | 36 +++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/include/kvm/arm_smmu_v3.h b/include/kvm/arm_smmu_v3.h
index 373b915b6661..d345cd616407 100644
--- a/include/kvm/arm_smmu_v3.h
+++ b/include/kvm/arm_smmu_v3.h
@@ -12,6 +12,9 @@
  * Parameters from the trusted host:
  * @mmio_addr		base address of the SMMU registers
  * @mmio_size		size of the registers resource
+ * @caches_clean_on_power_on
+ *			is it safe to elide cache and TLB invalidation commands
+ *			while the SMMU is OFF
  *
  * Other members are filled and used at runtime by the SMMU driver.
  */
@@ -20,6 +23,7 @@ struct hyp_arm_smmu_v3_device {
 	phys_addr_t		mmio_addr;
 	size_t			mmio_size;
 	unsigned long		features;
+	bool			caches_clean_on_power_on;
 
 	void __iomem		*base;
 	u32			cmdq_prod;
diff --git a/include/kvm/iommu.h b/include/kvm/iommu.h
index 2bbe5f7bf726..ab888da731bc 100644
--- a/include/kvm/iommu.h
+++ b/include/kvm/iommu.h
@@ -3,6 +3,7 @@
 #define __KVM_IOMMU_H
 
 #include <asm/kvm_host.h>
+#include <kvm/power_domain.h>
 #include <linux/io-pgtable.h>
 
 /*
@@ -10,6 +11,7 @@
  * @pgtable_cfg:	page table configuration
  * @domains:		root domain table
  * @nr_domains:		max number of domains (exclusive)
+ * @power_domain:	power domain information
  *
  * Other members are filled and used at runtime by the IOMMU driver.
  */
@@ -17,8 +19,10 @@ struct kvm_hyp_iommu {
 	struct io_pgtable_cfg		pgtable_cfg;
 	void				**domains;
 	size_t				nr_domains;
+	struct kvm_power_domain		power_domain;
 
 	struct io_pgtable_params	*pgtable;
+	bool				power_is_off;
 };
 
 struct kvm_hyp_iommu_memcache {
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
index 56e313203a16..20610ebf04c2 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -83,6 +83,9 @@ static int smmu_add_cmd(struct hyp_arm_smmu_v3_device *smmu,
 	int idx = Q_IDX(smmu, smmu->cmdq_prod);
 	u64 *slot = smmu->cmdq_base + idx * CMDQ_ENT_DWORDS;
 
+	if (smmu->iommu.power_is_off)
+		return -EPIPE;
+
 	ret = smmu_wait_event(smmu, !smmu_cmdq_full(smmu));
 	if (ret)
 		return ret;
@@ -160,6 +163,9 @@ static int smmu_sync_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid)
 		.cfgi.leaf = true,
 	};
 
+	if (smmu->iommu.power_is_off && smmu->caches_clean_on_power_on)
+		return 0;
+
 	return smmu_send_cmd(smmu, &cmd);
 }
 
@@ -394,6 +400,9 @@ static void smmu_tlb_flush_all(void *cookie)
 		.tlbi.vmid = data->domain_id,
 	};
 
+	if (smmu->iommu.power_is_off && smmu->caches_clean_on_power_on)
+		return;
+
 	WARN_ON(smmu_send_cmd(smmu, &cmd));
 }
 
@@ -409,6 +418,9 @@ static void smmu_tlb_inv_range(struct kvm_iommu_tlb_cookie *data,
 		.tlbi.leaf = leaf,
 	};
 
+	if (smmu->iommu.power_is_off && smmu->caches_clean_on_power_on)
+		return;
+
 	/*
 	 * There are no mappings at high addresses since we don't use TTB1, so
 	 * no overflow possible.
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
index 0550e7bdf179..2fb5514ee0ef 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -327,10 +327,46 @@ phys_addr_t kvm_iommu_iova_to_phys(pkvm_handle_t iommu_id,
 	return phys;
 }
 
+static int iommu_power_on(struct kvm_power_domain *pd)
+{
+	struct kvm_hyp_iommu *iommu = container_of(pd, struct kvm_hyp_iommu,
+						   power_domain);
+
+	/*
+	 * We currently assume that the device retains its architectural state
+	 * across power off, hence no save/restore.
+	 */
+	hyp_spin_lock(&iommu_lock);
+	iommu->power_is_off = false;
+	hyp_spin_unlock(&iommu_lock);
+	return 0;
+}
+
+static int iommu_power_off(struct kvm_power_domain *pd)
+{
+	struct kvm_hyp_iommu *iommu = container_of(pd, struct kvm_hyp_iommu,
+						   power_domain);
+
+	hyp_spin_lock(&iommu_lock);
+	iommu->power_is_off = true;
+	hyp_spin_unlock(&iommu_lock);
+	return 0;
+}
+
+static const struct kvm_power_domain_ops iommu_power_ops = {
+	.power_on	= iommu_power_on,
+	.power_off	= iommu_power_off,
+};
+
 int kvm_iommu_init_device(struct kvm_hyp_iommu *iommu)
 {
+	int ret;
 	void *domains;
 
+	ret = pkvm_init_power_domain(&iommu->power_domain, &iommu_power_ops);
+	if (ret)
+		return ret;
+
 	domains = iommu->domains;
 	iommu->domains = kern_hyp_va(domains);
 	return pkvm_create_mappings(iommu->domains, iommu->domains +
-- 
2.39.0

