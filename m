Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AAC29B8D9
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 06:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754892684; cv=none; b=sFjyLriMU+yCv5so0JJHxdmMwV0wPN+1/HLLiNutkgsGlYWoeZH11vjx1/2p5lHU6sdk6A25dXvC/xASZPwkGwlJPl51gxfgWQHbGaU8Erh4kmqK+IyC3Js+Zf1h7M7Va3VLzLmNk0cdjp4oOO1IXh63JaGn28vxTrIcCavxmfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754892684; c=relaxed/simple;
	bh=D6bWNCnFL2Dw0JQmRi3CW5HbqgQJLdJ91ORdGPwDaLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kL5++VRz/zd0gm+yDZ+YtZF1jFIR1jCzfYR+2YH0ejef/V7nKgaN51fyoQOZGOAvW163AXhXQpT5MxWwp+6GFyWRybfTVLM+9CFMHqZndFtZlMpFwwXgb+f2lIxs6x7HQypKKcV4eYMYPmQzfIqNF0Cy1dSj7BkADjUd/T+UPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CyTu3IFN; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CyTu3IFN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754892680; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7J/clauWbQWRFTci+97Z7tJgolFj9hSh37VSydzAoWg=;
	b=CyTu3IFNVUSNNEH0LPWsZxuZhDpPPSIFNs9gYqC3x7Tniy+qJCZqCh0Vw/E/zMMp8DYp5sa1sr6RLT94t9F+5Mb1G/YUzPMqZrGEKFw8PIpFsN7XGVAcQGIuz4bdfdo6QcP4rmNkMFLKMN2E9sBq5Qk4agl4B0Oke0He/RhIDh8=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WlP-vBA_1754892678 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Aug 2025 14:11:19 +0800
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
Subject: [RFC PATCH 6/6] RISC-V: KVM: Check the MRIF in notice MSI irq handler
Date: Mon, 11 Aug 2025 14:11:04 +0800
Message-Id: <20250811061104.10326-7-fangyu.yu@linux.alibaba.com>
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

In MRIF mode,  the Advanced Interrupt Architecture Specification
defines the operation to store the  incoming MSIs into the  MRIF
and to generate the notice MSI,the software shold check the MRIF
in the notice MSI irq handler.

And without MRIF support,we redirect the guest interrupt back to
the original host interrupt,  the software update and check MRIF
in host irq handler.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kvm/aia_imsic.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index 58807e68a3dd..f0d1acde0dd4 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -867,11 +867,16 @@ int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
 
 			ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
 			if (ret) {
+				if (ret == -ENODEV) {
+					imsic->mrif_support = false;
+					ret = 0;
+				}
 				read_unlock_irqrestore(&imsic->vsfile_lock, flags);
 				goto out;
 			}
 
-			irq_data_get_irq_chip(irqdata)->irq_write_msi_msg(irqdata, msg);
+			if (imsic->mrif_support)
+				irq_data_get_irq_chip(irqdata)->irq_write_msi_msg(irqdata, msg);
 
 			read_unlock_irqrestore(&imsic->vsfile_lock, flags);
 		}
@@ -921,6 +926,10 @@ static int kvm_riscv_vcpu_irq_update(struct kvm_vcpu *vcpu)
 
 		ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
 		if (ret) {
+			if (ret == -ENODEV) {
+				imsic->mrif_support = false;
+				ret = 0;
+			}
 			spin_unlock_irq(&kvm->irqfds.lock);
 			return ret;
 		}
@@ -1182,8 +1191,24 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
 	if (imsic->vsfile_cpu >= 0) {
 		writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
 	} else {
+		if (imsic->mrif_support) {
+			struct msi_msg *msg;
+			unsigned long idx;
+
+			/* In MRIF mode, the noticed MSI irq handler will call here to
+			 * determine whether the MRIF has been updated.Since the IOMMU
+			 * hardware has updated the MRIF,the software does not need to
+			 * update the MRIF file again.
+			 */
+			xa_for_each(&imsic->hostirq_array, idx, msg) {
+				if (msg->data == iid)
+					goto skip_update_swfile;
+			}
+		}
 		eix = &imsic->swfile->eix[iid / BITS_PER_TYPE(u64)];
 		set_bit(iid & (BITS_PER_TYPE(u64) - 1), eix->eip);
+
+skip_update_swfile:
 		imsic_swfile_extirq_update(vcpu);
 	}
 
@@ -1260,7 +1285,7 @@ int kvm_riscv_vcpu_aia_imsic_init(struct kvm_vcpu *vcpu)
 	raw_spin_lock_init(&imsic->swfile_extirq_lock);
 
 	xa_init(&imsic->hostirq_array);
-	imsic->mrif_support = false;
+	imsic->mrif_support = true;
 
 	/* Setup IO device */
 	kvm_iodevice_init(&imsic->iodev, &imsic_iodoev_ops);
-- 
2.49.0

