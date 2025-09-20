Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B572E0B5C
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400755; cv=none; b=rpJGb41fE5++Dz9BQgY1spga3GCTfhHqnnkkydrzU1ZIgTw0EgS5yQKs9FVoMrYj7Qm8x40xPQGmIjhi5nv//V4aReJb5VJL4oe5ve5ZQai3uRb+CiA0hO3aRsGVA1U5r7Eo0hN3Hte9PujNCDRlROGGVLVuGYWuiPZfqMSVXZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400755; c=relaxed/simple;
	bh=90dTZ5WTYxruDRRzj/RinWLqbDaazkEeEcCzoZV1q4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaULJ86IiswbLIIjsatJcBQjhkfPl6vJ3nvV0/LNAQbRtbM3Era41SMLbeYvY/wdWGVRvdsYsYSVQfpEpQTkt9VmTPP1px5XiXYecxDZw0syKNao6dkaxxMkSMjXSDZij/TncZQMLmkOR1v58i9aDZBv1cF/gLKRHIFMi6tb5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FrXp79km; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FrXp79km"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8876de33c86so293557139f.3
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400752; x=1759005552; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8WX1C9GPAWWC8UTFlF9ZhDr+Hidw1k8q7PXizEBEqk=;
        b=FrXp79kmboISG2sB87uaEkJmBf3LNaja6zDWl/lvYuoOuKA4Mqcxn7x/5Zl3vKv9Pj
         UPux/kmvwGS49mcAOitr1mHnwu1elfJwkuyvmkAk53xnt+V/+uM/gk93dM7ZtZS1f8p0
         Nxtec/G9L3tqfdHuNpxTRpfDRj3sWdCnYyGvRwPOR4f/QKysRhoq7AjQnl8mHuh5lrol
         Eet/YdP821fmhex/OYGc9Ba1KnJZgb1siNSpWyLN7jSTls2gyzRDnuf8FTmSF+DiWjf4
         +KOnCsx/7hQcKnhRfcErl05nLgp1pu4PLFLa2uDefjoMVXobl4KJTQhStXkZ0Xbf/fW5
         ZDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400752; x=1759005552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8WX1C9GPAWWC8UTFlF9ZhDr+Hidw1k8q7PXizEBEqk=;
        b=eDtKLahMb22TpiU4IwNuAoF5L8w9Dy6PT54ymtY/cZNU61N27s5N1qf7r7vHbXLXjV
         S+ksF2Qbasp84g3Vo8I6lgiB89awxoF+mBG1BnuJDNHp4mmVq8e+y2BX9A53NShWs8yV
         QFMRP63cNSj+ubTfmexUbidD0yNxiyAOc8+UC6LVf5dc7AkzZf+u7DiD4LxMn8/+M82M
         10Y/uB1Nr5TMyBUsJvblVl9FAIhygbIMgWSmLTi1/tmBBO81D05gM2g1/Dne0OW/bUMz
         PMLCCUFrhInv/InJOgFB8kgTP80VbPl7GCTGyfRTbQtf0pYR/HYIjMPqiziq5FPcGP6e
         HxjA==
X-Gm-Message-State: AOJu0YyPeZZtw/gcgk2mn/44Ierm0SHC6R/USBSUeTYZbu6Phmb2khV1
	iGDDgpBuwS7kA5UR2iNflu1+Dcw452lz5F/ACc9PgxK3wV8ZE+VrQHJb0C4PVmamPL0XYm8pgF5
	qZPtlWaE=
X-Gm-Gg: ASbGnctuLbzLBlZPbdGl925IKQA15pvpoRAfdD9Gaa5AbAY1WWHlZAeQ/5A7Uah1LzF
	SvHV0iDsNYErmRhSnqk9AjlPD+JSWROpnQK30s/C2QUTpv6cgQW6VBeRlYlTrkj/rnHBSNV5Fyh
	WR0B5d8ebNJO4NJQ56ok9vUvKj8iQKZwAt4/xsKgGkydxHARx4tKiopeEzu1QnX1XkytY4ezGHt
	4vFWcrJ9qpVhO2N9h3R7z8JfMxr2NYN9KbztYVvbGCP1wKhrrfJioBZvwBGEXKZZp5zp6rm8VeV
	2klZsuUqDlhvd0tYjKYoIBDWDYpFlAgH/+J8EFkyTTIDa2bgg3GZBWkahR24ErNM6bA3UKcpedO
	WFsucEbxTqg1dAqvaXUXlrO2B
X-Google-Smtp-Source: AGHT+IEw0TKfGEJ+b3BMNokPnUzbTHiLPG9/O6bJ0/KE+jKkggTkLT3hwVdxbWwTqoRlHAMYp3DVrA==
X-Received: by 2002:a05:6602:3809:b0:89a:674d:93aa with SMTP id ca18e2360f4ac-8adbd77fbafmr1269552139f.0.1758400752391;
        Sat, 20 Sep 2025 13:39:12 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a4832339c5sm292330039f.26.2025.09.20.13.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:11 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com,
	zong.li@sifive.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alex@ghiti.fr
Subject: [RFC PATCH v2 15/18] RISC-V: KVM: Add guest file irqbypass support
Date: Sat, 20 Sep 2025 15:39:05 -0500
Message-ID: <20250920203851.2205115-35-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920203851.2205115-20-ajones@ventanamicro.com>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add all the functions needed to wire up irqbypass support and
implement kvm_arch_update_irqfd_routing() which makes
irq_set_vcpu_affinity() calls whenever the assigned device updates
its target addresses. Also implement calls to irq_set_vcpu_affinity()
from kvm_riscv_vcpu_aia_imsic_update() which are needed to update
the IOMMU mappings when the hypervisor migrates a VCPU to another
CPU (requiring a change to the target guest interrupt file).

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/Kconfig     |   1 +
 arch/riscv/kvm/aia_imsic.c | 143 ++++++++++++++++++++++++++++++++++++-
 arch/riscv/kvm/vm.c        |  31 ++++++++
 3 files changed, 173 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index 968a33ab23b8..76cfd85c5c40 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -21,6 +21,7 @@ config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
 	depends on RISCV_SBI && MMU
 	select HAVE_KVM_IRQCHIP
+	select HAVE_KVM_IRQ_BYPASS
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_MSI
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index fda0346f0ea1..148ae94fa17b 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -11,11 +11,13 @@
 #include <linux/bitmap.h>
 #include <linux/irqchip/riscv-imsic.h>
 #include <linux/kvm_host.h>
+#include <linux/kvm_irqfd.h>
 #include <linux/math.h>
 #include <linux/spinlock.h>
 #include <linux/swab.h>
 #include <kvm/iodev.h>
 #include <asm/csr.h>
+#include <asm/irq.h>
 #include <asm/kvm_mmu.h>
 
 #define IMSIC_MAX_EIX	(IMSIC_MAX_ID / BITS_PER_TYPE(u64))
@@ -719,6 +721,14 @@ void kvm_riscv_vcpu_aia_imsic_put(struct kvm_vcpu *vcpu)
 	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
 }
 
+static u64 kvm_riscv_aia_msi_addr_mask(struct kvm_aia *aia)
+{
+	u64 group_mask = BIT(aia->nr_group_bits) - 1;
+
+	return (group_mask << (aia->nr_group_shift - IMSIC_MMIO_PAGE_SHIFT)) |
+	       (BIT(aia->nr_hart_bits + aia->nr_guest_bits) - 1);
+}
+
 void kvm_riscv_vcpu_aia_imsic_release(struct kvm_vcpu *vcpu)
 {
 	unsigned long flags;
@@ -769,6 +779,132 @@ void kvm_riscv_vcpu_aia_imsic_release(struct kvm_vcpu *vcpu)
 	kvm_riscv_aia_free_hgei(old_vsfile_cpu, old_vsfile_hgei);
 }
 
+void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
+				   struct kvm_kernel_irq_routing_entry *old,
+				   struct kvm_kernel_irq_routing_entry *new)
+{
+	struct riscv_iommu_ir_vcpu_info vcpu_info;
+	struct kvm *kvm = irqfd->kvm;
+	struct kvm_aia *aia = &kvm->arch.aia;
+	int host_irq = irqfd->producer->irq;
+	struct irq_data *irqdata = irq_get_irq_data(host_irq);
+	unsigned long tmp, flags;
+	struct kvm_vcpu *vcpu;
+	struct imsic *imsic;
+	struct msi_msg msg;
+	u64 msi_addr_mask;
+	gpa_t target;
+	int ret;
+
+	if (old && old->type == KVM_IRQ_ROUTING_MSI &&
+	    new && new->type == KVM_IRQ_ROUTING_MSI &&
+	    !memcmp(&old->msi, &new->msi, sizeof(new->msi)))
+		return;
+
+	if (!new) {
+		if (!WARN_ON_ONCE(!old) && old->type == KVM_IRQ_ROUTING_MSI) {
+			ret = irq_set_vcpu_affinity(host_irq, NULL);
+			WARN_ON_ONCE(ret && ret != -EOPNOTSUPP);
+		}
+		return;
+	}
+
+	if (new->type != KVM_IRQ_ROUTING_MSI)
+		return;
+
+	target = ((gpa_t)new->msi.address_hi << 32) | new->msi.address_lo;
+	if (WARN_ON_ONCE(target & (IMSIC_MMIO_PAGE_SZ - 1)))
+		return;
+
+	msg = (struct msi_msg){
+		.address_hi = new->msi.address_hi,
+		.address_lo = new->msi.address_lo,
+		.data = new->msi.data,
+	};
+
+	kvm_for_each_vcpu(tmp, vcpu, kvm) {
+		if (target == vcpu->arch.aia_context.imsic_addr)
+			break;
+	}
+	if (!vcpu)
+		return;
+
+	msi_addr_mask = kvm_riscv_aia_msi_addr_mask(aia);
+	vcpu_info = (struct riscv_iommu_ir_vcpu_info){
+		.gpa = target,
+		.msi_addr_mask = msi_addr_mask,
+		.msi_addr_pattern = (target >> IMSIC_MMIO_PAGE_SHIFT) & ~msi_addr_mask,
+		.group_index_bits = aia->nr_group_bits,
+		.group_index_shift = aia->nr_group_shift,
+	};
+
+	imsic = vcpu->arch.aia_context.imsic_state;
+
+	read_lock_irqsave(&imsic->vsfile_lock, flags);
+
+	if (WARN_ON_ONCE(imsic->vsfile_cpu < 0))
+		goto out;
+
+	vcpu_info.hpa = imsic->vsfile_pa;
+
+	ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
+	WARN_ON_ONCE(ret && ret != -EOPNOTSUPP);
+	if (ret)
+		goto out;
+
+	irq_data_get_irq_chip(irqdata)->irq_write_msi_msg(irqdata, &msg);
+
+out:
+	read_unlock_irqrestore(&imsic->vsfile_lock, flags);
+}
+
+static void kvm_riscv_vcpu_irq_update(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
+	gpa_t gpa = vcpu->arch.aia_context.imsic_addr;
+	struct kvm_aia *aia = &kvm->arch.aia;
+	u64 msi_addr_mask = kvm_riscv_aia_msi_addr_mask(aia);
+	struct riscv_iommu_ir_vcpu_info vcpu_info = {
+		.gpa = gpa,
+		.hpa = imsic->vsfile_pa,
+		.msi_addr_mask = msi_addr_mask,
+		.msi_addr_pattern = (gpa >> IMSIC_MMIO_PAGE_SHIFT) & ~msi_addr_mask,
+		.group_index_bits = aia->nr_group_bits,
+		.group_index_shift = aia->nr_group_shift,
+	};
+	struct kvm_kernel_irq_routing_entry *irq_entry;
+	struct kvm_kernel_irqfd *irqfd;
+	gpa_t target;
+	int host_irq, ret;
+
+	spin_lock_irq(&kvm->irqfds.lock);
+
+	list_for_each_entry(irqfd, &kvm->irqfds.items, list) {
+		if (!irqfd->producer)
+			continue;
+
+		irq_entry = &irqfd->irq_entry;
+		if (irq_entry->type != KVM_IRQ_ROUTING_MSI)
+			continue;
+
+		target = ((gpa_t)irq_entry->msi.address_hi << 32) | irq_entry->msi.address_lo;
+		if (WARN_ON_ONCE(target & (IMSIC_MMIO_PAGE_SZ - 1)))
+			continue;
+
+		if (target != gpa)
+			continue;
+
+		host_irq = irqfd->producer->irq;
+		ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
+		WARN_ON_ONCE(ret && ret != -EOPNOTSUPP);
+		if (ret == -EOPNOTSUPP)
+			break;
+	}
+
+	spin_unlock_irq(&kvm->irqfds.lock);
+}
+
 int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu *vcpu)
 {
 	unsigned long flags;
@@ -836,14 +972,17 @@ int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu *vcpu)
 	if (ret)
 		goto fail_free_vsfile_hgei;
 
-	/* TODO: Update the IOMMU mapping ??? */
-
 	/* Update new IMSIC VS-file details in IMSIC context */
 	write_lock_irqsave(&imsic->vsfile_lock, flags);
+
 	imsic->vsfile_hgei = new_vsfile_hgei;
 	imsic->vsfile_cpu = vcpu->cpu;
 	imsic->vsfile_va = new_vsfile_va;
 	imsic->vsfile_pa = new_vsfile_pa;
+
+	/* Update the IOMMU mapping */
+	kvm_riscv_vcpu_irq_update(vcpu);
+
 	write_unlock_irqrestore(&imsic->vsfile_lock, flags);
 
 	/*
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index 66d91ae6e9b2..1d33cff73e00 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -11,6 +11,8 @@
 #include <linux/module.h>
 #include <linux/uaccess.h>
 #include <linux/kvm_host.h>
+#include <linux/kvm_irqfd.h>
+#include <asm/kvm_aia.h>
 #include <asm/kvm_mmu.h>
 
 const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
@@ -56,6 +58,35 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_riscv_aia_destroy_vm(kvm);
 }
 
+bool kvm_arch_has_irq_bypass(void)
+{
+	return true;
+}
+
+int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
+				     struct irq_bypass_producer *prod)
+{
+	struct kvm_kernel_irqfd *irqfd =
+		container_of(cons, struct kvm_kernel_irqfd, consumer);
+
+	irqfd->producer = prod;
+	kvm_arch_update_irqfd_routing(irqfd, NULL, &irqfd->irq_entry);
+
+	return 0;
+}
+
+void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
+				      struct irq_bypass_producer *prod)
+{
+	struct kvm_kernel_irqfd *irqfd =
+		container_of(cons, struct kvm_kernel_irqfd, consumer);
+
+	WARN_ON(irqfd->producer != prod);
+
+	kvm_arch_update_irqfd_routing(irqfd, &irqfd->irq_entry, NULL);
+	irqfd->producer = NULL;
+}
+
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irql,
 			  bool line_status)
 {
-- 
2.49.0

