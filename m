Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E2B27D780
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754892685; cv=none; b=oy+CPpNshx5e0O7Hkr6hglgwb+4HVbKmxlMXK1037HXzB8gp3M/82tZSJCdiLqkVdwARx+k6C1caQQsTdi5fVzq8VYSXx2H/Km7A31ZudNgNRRcz8qo8djmIC3KHjHQqK1ZAmY0cW1xdq5osoE3Z8TRiVlWGl0smm3E/6NISdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754892685; c=relaxed/simple;
	bh=TykNv5gkgpZAOZDIW+MRRdfsxuTLkyNVFKonDaW4f/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OL/bjIM7ojjML0Tg594vuo1nvKeWH1oecl0DiLHwNodIh7CDOmInsZoJASD4xbTRBaF85tbCclNYTGY6cECcwhTd+1hpnvLKWhEbW1peP0Z2kp+JejGcJoDSTfBDRvm841vaKOqPaGplx3i4si8yUpcMKqeGuIcf3UrRHr4EWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m+NSBNAb; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m+NSBNAb"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754892676; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=whyJDouuAuGf1j7b/5M2xWcx/VsvP58NxkP1IN3I0Kg=;
	b=m+NSBNAbwvEI6hnCGbFnB/zClgX0akO+BxXSVAx/lNc/W8GltP6athl7XNo9ABZ7RKf1zRw53v2fQGEPTXNfWko8U2u8JucBwt43mFiPVXm9e1w2IojH04eAfvvsZ9NKOaB6sjI+/cFmLQ/oOgs6jl9UorqPDcxgalX6n3FiQtg=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WlP-v9-_1754892672 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Aug 2025 14:11:13 +0800
From: fangyu.yu@linux.alibaba.com
To: anup@brainfault.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	atishp@atishpatra.org,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	sunilvl@ventanamicro.com,
	rafael.j.wysocki@intel.com,
	tglx@linutronix.de,
	ajones@ventanamicro.com
Cc: guoren@linux.alibaba.com,
	guoren@kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [RFC PATCH 2/6] RISC-V: KVM: Transfer the physical address of MRIF to iommu-ir
Date: Mon, 11 Aug 2025 14:11:00 +0800
Message-Id: <20250811061104.10326-3-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250811061104.10326-1-fangyu.yu@linux.alibaba.com>
References: <20250811061104.10326-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

According to the RISC-V IOMMU Spec, an IOMMU may optionally
support memory-resident interrupt files (MRIFs).

When the guest interrupt files are used up, we transfer the
physical address of MRIF to iommu-ir, and enable MRIF  mode
if the iommu-ir supports.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kvm/aia_imsic.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index 8f5703d9112a..e91164742fd0 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -21,6 +21,8 @@
 
 #define IMSIC_MAX_EIX	(IMSIC_MAX_ID / BITS_PER_TYPE(u64))
 
+static int kvm_riscv_vcpu_irq_update(struct kvm_vcpu *vcpu);
+
 struct imsic_mrif_eix {
 	unsigned long eip[BITS_PER_TYPE(u64) / BITS_PER_LONG];
 	unsigned long eie[BITS_PER_TYPE(u64) / BITS_PER_LONG];
@@ -717,7 +719,8 @@ void kvm_riscv_vcpu_aia_imsic_release(struct kvm_vcpu *vcpu)
 				 vcpu->arch.aia_context.imsic_addr,
 				 IMSIC_MMIO_PAGE_SZ);
 
-	/* TODO: Purge the IOMMU mapping ??? */
+	/* Update the IOMMU mapping */
+	kvm_riscv_vcpu_irq_update(vcpu);
 
 	/*
 	 * At this point, all interrupt producers have been re-directed
@@ -795,13 +798,14 @@ int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
 
 			read_lock_irqsave(&imsic->vsfile_lock, flags);
 
-			if (WARN_ON_ONCE(imsic->vsfile_cpu < 0)) {
-				read_unlock_irqrestore(&imsic->vsfile_lock, flags);
-				goto out;
+			if (imsic->vsfile_cpu < 0) {
+				vcpu_info.hpa = imsic->swfile_pa;
+				vcpu_info.mrif = true;
+			} else {
+				vcpu_info.hpa = imsic->vsfile_pa;
+				vcpu_info.mrif = false;
 			}
 
-			vcpu_info.hpa = imsic->vsfile_pa;
-
 			ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
 			if (ret) {
 				read_unlock_irqrestore(&imsic->vsfile_lock, flags);
@@ -844,6 +848,13 @@ static int kvm_riscv_vcpu_irq_update(struct kvm_vcpu *vcpu)
 		if (!irqfd->producer)
 			continue;
 		host_irq = irqfd->producer->irq;
+
+		if (imsic->vsfile_cpu < 0) {
+			vcpu_info.hpa = imsic->swfile_pa;
+			vcpu_info.mrif = true;
+		} else {
+			vcpu_info.mrif = false;
+		}
 		ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
 		if (ret) {
 			spin_unlock_irq(&kvm->irqfds.lock);
-- 
2.49.0

