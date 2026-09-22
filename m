Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B5F54938A
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082813; cv=none; b=WvRiTYZU17n6UimnAQIRG2/eTB/RHsrHdQ2777zyF/LFxlXNa02vQ/ZkWCW+9GrUYixbKNa+7lmviodYt//9ZU2QaXKHvlBc/1k4O+roJ7L74aI+CBOSlqd9c67+EAnCPByI7nguwqgLqNT1kq/b5zHsRDuYV/wtx5WbGkM67Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082813; c=relaxed/simple;
	bh=HCmVazmRy5W0CFgeQvUYM2FGPxm2BiIy/ZPSTmdmcFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gFoUsK03UKx1TIZfdr1iYUEWug3lkxUosI5dY+DYt3G5gwcrcGnkNC9o0XMBLoC7/9j4+lNMcwLb7gesaj0HtHFXLam/tN8iRbgp5O5CVIIg1LPOwxRMz9YrGn+U8n9Vqc+wmkeKOXIzykzFwgX/9mhx2iL6uDQkX9FxHsak9VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ceF9H5R3; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ceF9H5R3"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49953abe51fso26292215e9.1
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 06:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790082806; x=1790687606; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NRBroGKsK/EO8xs+s+H8im0EjosulEEiERGNVqEejnQ=;
        b=ceF9H5R3vYI9jT1gdyqapapYGUEK0LNxJfqfQZzTMV2zShdsOvbR92MNi3W5yekZ7r
         cRLgxcudo8LNNxVDAenuXQGsw6qTeK7lDf+OMJGb28xFAnYT7HeWQisOGqsgM2qqtLDw
         PBgdQmcQR9YKhhFNZ47E1NsD4gfG78D1eQl+GCXygK8mJvVGAbaEAYOY3XkOWPSPV+u5
         d6a1fPwmreKyBJp59qg/L8IqSpN4AD/2d+TwJ7hHClDBqZVQphoM8rmM3ndFMoVKg/pP
         fphXGIijqEzXrURs/hgie/O9u9OkI5l1ostd7I4wbgoeeEjIdHXz3DT4DOaNa3PsXvkt
         S1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790082806; x=1790687606;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NRBroGKsK/EO8xs+s+H8im0EjosulEEiERGNVqEejnQ=;
        b=fu97Y1OICeRwusHDsal1P/UOxenUgtTTn5jGO5T0rgBqLpmpQMr7GaC98nWrDfFhhb
         flJfZOaNGaDHyDdSM0fLcgs6cOlqW5X8H3veL2FhlLTraUPaNSuwMm7p3Pp4y2aaUC2j
         ceAYp1AbhCxLYpP4x94djSOiJhXsAvZnjLVUfcjYTKFu0bD+qvHbeKOI3wQ7e572kbmJ
         o0pVrgugNHK+q7OkRBkNXbMLO3GO/42WBape9IY52GGOUiNuYslO2eMqZl2i1HxRGSJT
         DF5eIaeBADr/CL5zo7ThVMO1IKPw50UDZHLfYoNoFZ+c1CIEliS4esszvM3QVcljepdZ
         IzIw==
X-Forwarded-Encrypted: i=1; AKwUvBzGunI9xsG4BXExcL9RIqrWY4FrKZ71kEhY/7Kxque2V03Am3ysyuU0GiOh5nwPA+aJ/tkkTw==@lists.linux.dev
X-Gm-Message-State: AFuF++mAoLcnThMiE0A3fLGsSCACgvKwIgeg80Ps/5VbiV7bw7nFu6xa
	ei0Q3l7wvDidA4Ps0rGTqqU0WFkahkzmXhmlPT8gHfYXMek6qu9GOR81+2f0nQc/oDtDXtdpK5D
	oGPP6hD/VxoQkWg==
X-Received: from wmga20.prod.google.com ([2002:a05:600c:2d54:b0:49e:6308:e0bf])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:548a:b0:49f:ce73:7ab with SMTP id 5b1f17b1804b1-49fce730859mr138765725e9.34.1790082805696;
 Tue, 22 Sep 2026 06:13:25 -0700 (PDT)
Date: Tue, 22 Sep 2026 13:12:52 +0000
In-Reply-To: <20260922131259.2975334-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260922131259.2975334-1-smostafa@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922131259.2975334-20-smostafa@google.com>
Subject: [PATCH v8 19/25] iommu/arm-smmu-v3-kvm: Share other queues
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca, mark.rutland@arm.com, 
	qperret@google.com, tabba@google.com, vdonnefort@google.com, 
	sebastianene@google.com, keirf@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Other queues as PRIQ and EVTQ do not need to be shadowed. However, we
need to make sure they are in a state that disallow them to be donated
to the hypervisor or guests. So, keep track of those and share them when
they get enabled.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h    |  8 ++
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 81 +++++++++++++++++--
 2 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h
index d4700d3a3c10..ffc57182e57e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h
@@ -32,6 +32,10 @@
  * @host_ste_cfg	Host stream table config
  * @host_ste_base	Host stream table base
  * @strtab_cfg		Stream table as seen by HW
+ * @evtq_base		Host evtq base reg
+ * @priq_base		Host priq base reg
+ * @evtq_shared		Whether the EVTQ was shared
+ * @priq_shared		Whether the PRIQ was shared
  */
 struct hyp_arm_smmu_v3_device {
 	phys_addr_t		mmio_addr;
@@ -58,6 +62,10 @@ struct hyp_arm_smmu_v3_device {
 	u64			host_ste_cfg;
 	u64			host_ste_base;
 	struct arm_smmu_strtab_cfg strtab_cfg;
+	u64			evtq_base;
+	u64			priq_base;
+	bool			evtq_shared;
+	bool			priq_shared;
 };
 
 extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index cb9aa7e4a394..00528380774f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -80,6 +80,16 @@ static bool is_smmu_enabled(struct hyp_arm_smmu_v3_device *smmu)
 	return FIELD_GET(CR0_SMMUEN, smmu->cr0);
 }
 
+static bool is_evtq_enabled(struct hyp_arm_smmu_v3_device *smmu)
+{
+	return FIELD_GET(CR0_EVTQEN, smmu->cr0);
+}
+
+static bool is_priq_enabled(struct hyp_arm_smmu_v3_device *smmu)
+{
+	return FIELD_GET(CR0_PRIQEN, smmu->cr0);
+}
+
 /*
  * CMDQ, STE host copies are accessed by the hypervisor, we share them to
  * - Prevent the host from passing protected VM memory.
@@ -660,6 +670,20 @@ static void smmu_emulate_cmdq_disable(struct hyp_arm_smmu_v3_device *smmu)
 				   cmdq_size(&smmu->cmdq_host)));
 }
 
+static void smmu_emulate_queue(struct hyp_arm_smmu_v3_device *smmu,
+			       unsigned long q_base, size_t ent_size_shift)
+{
+	/* Q_BASE_ADDR_MASK is not enough as the SMMU also ignores bits > OAS */
+	phys_addr_t base = q_base & Q_BASE_ADDR_MASK & ((1ULL << smmu->oas) - 1);
+	size_t size = 1UL << (FIELD_GET(Q_BASE_LOG2SIZE, q_base) + ent_size_shift);
+
+	/* The host must program the base first and it must be aligned to size. */
+	if (WARN_ON(!q_base || (base & (size - 1))))
+		return;
+
+	WARN_ON(smmu_share_pages(base, size));
+}
+
 static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
 			     struct user_pt_regs *regs,
 			     u64 esr, u32 off)
@@ -764,12 +788,34 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
 		if (is_write) {
 			bool last_cmdq_en = is_cmdq_enabled(smmu);
 			bool last_smmu_en = is_smmu_enabled(smmu);
+			bool last_evtq_en = is_evtq_enabled(smmu);
+			bool last_priq_en = is_priq_enabled(smmu);
 
 			smmu->cr0 = val;
 			if (!last_cmdq_en && is_cmdq_enabled(smmu))
 				smmu_emulate_cmdq_enable(smmu);
 			else if (last_cmdq_en && !is_cmdq_enabled(smmu))
 				smmu_emulate_cmdq_disable(smmu);
+
+			/*
+			 * Share PRI and EVTQ to avoid the host using them to write to
+			 * protected memory. However, do not unshare the queues at disable
+			 * as that is more complicated, unsharing from here can lead to
+			 * use-after-unshare issues, and requires ordering with cr0ack.
+			 * The host can disable those queues during shutdown, but it never
+			 * changes the base address (even with RPM), so leave the queue
+			 * shared and assert that multiple host writes do not change it.
+			 */
+			if (!last_evtq_en && is_evtq_enabled(smmu) && !smmu->evtq_shared) {
+				smmu_emulate_queue(smmu, smmu->evtq_base, EVTQ_ENT_SZ_SHIFT);
+				smmu->evtq_shared = true;
+			}
+
+			if (!last_priq_en && is_priq_enabled(smmu) && !smmu->priq_shared) {
+				smmu_emulate_queue(smmu, smmu->priq_base, PRIQ_ENT_SZ_SHIFT);
+				smmu->priq_shared = true;
+			}
+
 			if (!last_smmu_en && is_smmu_enabled(smmu))
 				smmu_emulate_enable(smmu);
 			else if (last_smmu_en && !is_smmu_enabled(smmu))
@@ -792,6 +838,34 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
 
 		mask = read_write;
 		break;
+	case ARM_SMMU_EVTQ_BASE:
+		if (len != sizeof(u64))
+			break;
+
+		if (is_write) {
+			/* See ARM_SMMU_CR0 */
+			if (is_evtq_enabled(smmu) ||
+			    (smmu->evtq_shared && (smmu->evtq_base != val)))
+				break;
+			smmu->evtq_base = val;
+		}
+		mask = read_write;
+		break;
+
+	case ARM_SMMU_PRIQ_BASE:
+		if (len != sizeof(u64))
+			break;
+
+		if (is_write) {
+			/* See ARM_SMMU_CR0 */
+			if (is_priq_enabled(smmu) ||
+			    (smmu->priq_shared && (smmu->priq_base != val)))
+				break;
+			smmu->priq_base = val;
+		}
+		mask = read_write;
+		break;
+
 	/* Allowed 32 bit registers. */
 	case ARM_SMMU_EVTQ_IRQ_CFG1:
 	case ARM_SMMU_EVTQ_IRQ_CFG2:
@@ -821,15 +895,12 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
 	case ARM_SMMU_EVTQ_IRQ_CFG0:
 	case ARM_SMMU_PRIQ_IRQ_CFG0:
 	case ARM_SMMU_GERROR_IRQ_CFG0:
+		if (len != sizeof(u64))
+			break;
 		/* These are RES0 as MSI support is hidden. */
 		val = 0;
 		if (!is_write)
 			goto out_update_regs;
-		fallthrough;
-	case ARM_SMMU_EVTQ_BASE:
-	case ARM_SMMU_PRIQ_BASE:
-		if (len != sizeof(u64))
-			break;
 		mask = read_write;
 		break;
 	/* Allowed RO 32 bit registers. */
-- 
2.55.0.1082.g2b9226bbc0-goog

