Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117E19E961
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601148; cv=none; b=NQ85e3I/HlJA5wt74AoDausXCU+Jje7N9Dd1w8jQYumOhppMSwUWo9ccLu4uGQMzk5ApWSyhbfB/fJVt2nzXYPj99otmp7QURbj3Atj3ETQelO8Av070JkCHKyDJony8PxulxZ9BQM5HuzyD1bRTwpWFVfNAFwTlWLYsJ0VfCV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601148; c=relaxed/simple;
	bh=UESyK8Uc8qhnyUFE7sWCeUfzwrVwuw9Qm2LYqZNp+fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tk4cCE6KJKBvvCk3jrjNXccEERZF6NAtTMMRWyvUpy7FsciZpHg6YsLvbRmufeb//+5marDcssx8KcyfNPGIfNIJBwaiein21BdlJFmkNH7bRnf9IZqwJbVIMdiN3cOfuLvaCRuEp+2VfVddTf2GV3aW8e5KA2Mz/GU/xorPTV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=I7gkSRdI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="I7gkSRdI"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d50fad249so606912f8f.1
        for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 08:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601145; x=1732205945; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmyAZwFmuLjn3p39hRK9ePQAJ1PSqwbQ6F/1nOHrEzM=;
        b=I7gkSRdI6vuUmahwH+eHKTXdHYG3D1Z158lr9+z6hU/ZdSfMy+Hq+Ol4vB3vRcth3i
         /esDQUTkist6GzuIsNDp3al5LniGDzlbn5FhyfAyzLZ+lVVw/S0Ug+LUQvOFIW54IPnR
         uFc6i4Al0VYuJVkPSIJ0lfB4SUY2is7eedm9KJ9LXt+HJodFaHSkRwYtmLQV5qJ6vdg1
         iDMDEH/oo/myop4iL7wWDB4Keji8fN80rRvduSBT9Aa3fqA3WfI9mKu39VrPqg2nIDXy
         276VHHxH6lbIaEMDNqI5tjsxSnerRwT1KALoMD1dLlVR6gTPFZLd6zeYZGAKolPW0VMv
         nJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601145; x=1732205945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmyAZwFmuLjn3p39hRK9ePQAJ1PSqwbQ6F/1nOHrEzM=;
        b=vjhfm1Cs9JyxF0JtP3rubQ37XLMcOxmLISy1+qIvlYZpMWAJC2O8PuKrOKneVm5uuj
         wncw3+3/HnpbMO98NmOXoJt1OwLAHPDJQHs4du2JIOtcLJV9HEKUPJrGyHUY/Z26j++S
         aG81kmX8rgrHcCltPLsIddFNfCw5D2cRpUlAnyguWqClVEjVe6M4szSRGInsooHAORjZ
         hzg3HDyndscLM6mjtA0NdjjTha6SvJsbKEXLzDN2jdf3Zl62hpboA6BzqzZ4f0wgjELF
         /g6BmYuGSoX7wJXw/jcfgzBaY8neSSYPhpXy7iWLj3nSXs4K83VMI/9mD3qAQ6GxSvCK
         WyjQ==
X-Gm-Message-State: AOJu0YyFxfiRf0PmH9ah0qKaS5OEvPAycyET49MhhEHgAPfJUKbir8a6
	KOEHlxOd2r1cpEYkn/3Ne18kg0NtnTEKEy7nb9b0eLCck6fJgNjkYsHolWMdF5Zs0pyOEslvbic
	KyV0=
X-Google-Smtp-Source: AGHT+IEn3qlHsw/D0PT2IEwLbgj1uEV7tnlyKBH8z2H1adqlOAImJaC/GmimW4BKxNwCPjE/Y1igiA==
X-Received: by 2002:a05:6000:210e:b0:382:424:94fe with SMTP id ffacd0b85a97d-382042495edmr11613726f8f.36.1731601144686;
        Thu, 14 Nov 2024 08:19:04 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae161d8sm1901964f8f.78.2024.11.14.08.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:19:04 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	zong.li@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 10/15] RISC-V: KVM: Add irqbypass skeleton
Date: Thu, 14 Nov 2024 17:18:55 +0100
Message-ID: <20241114161845.502027-27-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114161845.502027-17-ajones@ventanamicro.com>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add all the functions needed to wire up irqbypass support.
kvm_arch_update_irqfd_routing() is left unimplemented, so return
false from kvm_arch_has_irq_bypass().

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_host.h |  3 ++
 arch/riscv/kvm/Kconfig            |  1 +
 arch/riscv/kvm/aia_imsic.c        |  6 ++++
 arch/riscv/kvm/vm.c               | 60 +++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 35eab6e0f4ae..fef7422939f6 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -114,6 +114,9 @@ struct kvm_arch {
 
 	/* AIA Guest/VM context */
 	struct kvm_aia aia;
+
+#define __KVM_HAVE_ARCH_ASSIGNED_DEVICE
+	atomic_t assigned_device_count;
 };
 
 struct kvm_cpu_trap {
diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index 333d95da8ebe..9a4feb1e671d 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -21,6 +21,7 @@ config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support (EXPERIMENTAL)"
 	depends on RISCV_SBI && MMU
 	select HAVE_KVM_IRQCHIP
+	select HAVE_KVM_IRQ_BYPASS
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_MSI
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index a8085cd8215e..64b1f3713dd5 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -727,6 +727,12 @@ void kvm_riscv_vcpu_aia_imsic_release(struct kvm_vcpu *vcpu)
 	kvm_riscv_aia_free_hgei(old_vsfile_cpu, old_vsfile_hgei);
 }
 
+int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
+				  uint32_t guest_irq, bool set)
+{
+	return -ENXIO;
+}
+
 int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu *vcpu)
 {
 	unsigned long flags;
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index 7396b8654f45..9c5837518c1a 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -11,6 +11,9 @@
 #include <linux/module.h>
 #include <linux/uaccess.h>
 #include <linux/kvm_host.h>
+#include <linux/kvm_irqfd.h>
+
+#include <asm/kvm_aia.h>
 
 const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS()
@@ -55,6 +58,63 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_riscv_aia_destroy_vm(kvm);
 }
 
+void kvm_arch_start_assignment(struct kvm *kvm)
+{
+	atomic_inc(&kvm->arch.assigned_device_count);
+}
+EXPORT_SYMBOL_GPL(kvm_arch_start_assignment);
+
+void kvm_arch_end_assignment(struct kvm *kvm)
+{
+	atomic_dec(&kvm->arch.assigned_device_count);
+}
+EXPORT_SYMBOL_GPL(kvm_arch_end_assignment);
+
+bool noinstr kvm_arch_has_assigned_device(struct kvm *kvm)
+{
+	return arch_atomic_read(&kvm->arch.assigned_device_count);
+}
+EXPORT_SYMBOL_GPL(kvm_arch_has_assigned_device);
+
+bool kvm_arch_has_irq_bypass(void)
+{
+	return false;
+}
+
+int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
+				     struct irq_bypass_producer *prod)
+{
+	struct kvm_kernel_irqfd *irqfd =
+		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	int ret;
+
+	irqfd->producer = prod;
+	kvm_arch_start_assignment(irqfd->kvm);
+	ret = kvm_arch_update_irqfd_routing(irqfd->kvm, prod->irq, irqfd->gsi, true);
+	if (ret)
+		kvm_arch_end_assignment(irqfd->kvm);
+
+	return ret;
+}
+
+void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
+				      struct irq_bypass_producer *prod)
+{
+	struct kvm_kernel_irqfd *irqfd =
+		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	int ret;
+
+	WARN_ON(irqfd->producer != prod);
+	irqfd->producer = NULL;
+
+	ret = kvm_arch_update_irqfd_routing(irqfd->kvm, prod->irq, irqfd->gsi, false);
+	if (ret)
+		pr_info("irq bypass consumer (token %p) unregistration fails: %d\n",
+			irqfd->consumer.token, ret);
+
+	kvm_arch_end_assignment(irqfd->kvm);
+}
+
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irql,
 			  bool line_status)
 {
-- 
2.47.0

