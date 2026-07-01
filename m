Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A173783BE
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878477; cv=none; b=hbBD3nvrfbRgrIBJsX4iG+iS+s7mQjmA185cBvF/+kUVSzwRLUjezDMmSL0K+SbLnu3u4ic/L8hNycmZi6biJY+9/bwVMFphejWSKtmyqbX5DPRLGQ159DqyHgLhADWM2ymEpyjv+veSHNxiJj6cfQ+vLFQILoJpGs3TPUui7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878477; c=relaxed/simple;
	bh=HR6LFB3M6+yB82VbVD7Uder2kK5niVbQaSw8XBBfRgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qS5b/9QnE/kG4G+DTOuiCndVf7E+S4DZ+ADCW7aqaCt9Wj15nhqyPhPjzrRe6Tu2zFBDX8QYuojI9kDZ2YI4/yWrT2nu/noXAcVi31u0ZIO2PJyQqMufkmbFx5CicazVvIG7R29Uq/NteXc3PLVeFcVK/6zXiwVtM8+MryECG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=STYzdwAx; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="STYzdwAx"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30c944aacbaso378702eec.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 21:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782878472; x=1783483272; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWN7NBari0i1/8aoHDWNlUmTk2Z27L997IJ1yNwTiBc=;
        b=STYzdwAxbJNK0T+HY57M0tne6roSOPn6QDcVKRLXRfLfo1mNUhRmFO/Vde7cFdCTAO
         4aZcLlF/qpgKPke9gmYmYKsWpY/KRCjMm2sqT1ZvcQGzhiW7FD1Cp9hxdrdOEAvRnwb8
         ugJHUZyLWDyYwOZR1N/S/HXWMX44S8oOb6zX6BCmkDgVfj4jkJtJxC7rqknB0M1xnOPx
         N6p0yEJMZJCcG7gD5ON03Lp/RXCpt23tfOiVACt9ZpJXT9XO89YYuIz8wSjxLzTko9Kp
         B9HmhP+44pZZN+KLTuP12wg6zSX5LxjXIrxt4kmpKF0D8TDCmB5qm0XJgxBiM8Q4KxxH
         ApvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782878472; x=1783483272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HWN7NBari0i1/8aoHDWNlUmTk2Z27L997IJ1yNwTiBc=;
        b=QRamsvm40jqXfYIONiK8Y9OXQeDc9OUaSRiAxa9YCEPIrEpTSs5kcymmuWuCdbWH/c
         kXH6GbH3iFuOigPJtReU8a8c4kXFVH0xFPhBA9PGMtSycBU8NxTsId9X6B/faqIGPCLu
         huyksmyzfE3hGnXG8IWNfJIU7nbhOtb/NBcrTupiiaqEolb66jSgTOpSC6PFFuH8lJWj
         LuZdKq0vz4GLVPqGlCkAoCGrWiM/vL70zNwJmO0JX8GzYBZVG4GjrnqPKaw9pZU1Fqym
         c11RAFo2XPICSLzUgU4ZYPkDpiuz+9idQM18mUg4apap3wCItMqprcvlCww0X1JZxh7j
         Kftw==
X-Forwarded-Encrypted: i=1; AHgh+RpKOH550nAPzIaes6Dageq0sHmnUAvxFZHx9hFSHx9AUIQbtDQ6wuFE1rr7lUJWUsC4rRiIUg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2vyv0Kchig8DuKthvcnjeY87ae6EYgGvY1116fwKL6VwoZIyW
	uxWsahf+n1BwEhpWP4BPDATs3GCi7ZTINn++zexH8+Jq2cPDA8B8AcOwTCcbqAltt6I=
X-Gm-Gg: AfdE7cn70IClM7XT/DvY7qkwJqzk1WJjqQT1VzaGApv0sF4yoeRBsjBsUs0ZXlu9+24
	sNhg7IyVAuwpWfQka/PLc/KRgPZdcfEGs951VaWv95uOx1XvEL6mrUmNqjR6JbAD0NRC3pzOwBZ
	c3iyGa0xXvKQj1L9KdAayqc8hsnJcI4QVYFgubMn4t3LWGZ2yrHgJKtbaIxlAX/G9KG0Gcku+m0
	dqJUDO/t810d6PaCfFBYtemYUSaXGzD/rcjg/ESfv8uwphfIsITrgjIz/gsLcxzWDCABARQkCWQ
	bZrGvdyZzI6gl2Sen6zjj52kpg0LZz15sP7eOm5beQzjtnpD8iiyZwTxu2AsvKaM+MXO6+yFlBh
	7dWbDQDWM0IRuTV3oAUrRj4cC6DZJxZbmMjnZ6Ue1lC0hKyaHUsmuip8ndemoAaFM8ZxbpcN2XX
	pjpI3/6/Y2ZUG+AHpcoK8r3I/EGKemfT6LWD9jfm75opLji4Z+U+NbLCzk+Y6l+Xmmsq0xFv8FZ
	pM=
X-Received: by 2002:a05:7301:2a04:b0:30c:52c5:6e3f with SMTP id 5a478bee46e88-30eff0b4e80mr8435eec.18.1782878471619;
        Tue, 30 Jun 2026 21:01:11 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee32519aesm14024287eec.27.2026.06.30.21.01.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 21:01:11 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Subject: [RFC PATCH 2/3] KVM: Move irqfd arch data into route snapshots
Date: Wed,  1 Jul 2026 12:00:15 +0800
Message-ID: <20260701040017.42707-3-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701040017.42707-1-zhangzhanpeng.jasper@bytedance.com>
References: <20250811061104.10326-1-fangyu.yu@linux.alibaba.com>
 <20260701040017.42707-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irqfd wakeup takes a seqcount-protected copy of irqfd->irq_entry before
injecting an interrupt.  Architectures that need to classify an injection
by its irqfd producer need any derived arch state to be part of that same
snapshot.

The irqfd object had per-irqfd arch side state, but that state describes
the current producer, not the specific route snapshot used for an
in-flight injection.  Keeping the metadata there can race with route
updates and teardown: the inatomic injection path may observe a new route
with old arch metadata, or old arch metadata after the route has already
been invalidated.

Add optional arch-owned irqfd metadata to struct
kvm_kernel_irq_routing_entry and initialize it whenever KVM refreshes or
clears an irqfd route.  Remove the old per-irqfd arch side-state fields
so the route snapshot is the only place carrying this producer
provenance.  Userspace MSI injection uses a zero-initialized temporary
route, so it is never reported as irqfd-originated.

This provides the sequencing needed by RISC-V AIA to distinguish MRIF
notice MSI delivery from normal MSI injection without consulting mutable
irqfd state outside irq_entry_sc.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 include/linux/kvm_host.h  | 7 +++++++
 include/linux/kvm_irqfd.h | 4 ----
 virt/kvm/eventfd.c        | 5 +++++
 virt/kvm/irqchip.c        | 4 +++-
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5bd76cf394fa..254f8fd132cc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -685,6 +685,13 @@ struct kvm_kernel_irq_routing_entry {
 		struct kvm_hv_sint hv_sint;
 		struct kvm_xen_evtchn xen_evtchn;
 	};
+	/*
+	 * Optional arch-owned irqfd metadata.  It is updated under
+	 * irq_entry_sc together with the route so irqfd_wakeup() observes a
+	 * single consistent snapshot.
+	 */
+	struct kvm_vcpu *irqfd_arch_vcpu;
+	void *irqfd_arch_data;
 	struct hlist_node link;
 };
 
diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index ef8c134ded8a..44fd2a20b09e 100644
--- a/include/linux/kvm_irqfd.h
+++ b/include/linux/kvm_irqfd.h
@@ -58,10 +58,6 @@ struct kvm_kernel_irqfd {
 	struct work_struct shutdown;
 	struct irq_bypass_consumer consumer;
 	struct irq_bypass_producer *producer;
-
-	struct kvm_vcpu *irq_bypass_vcpu;
-	struct list_head vcpu_list;
-	void *irq_bypass_data;
 };
 
 #endif /* __LINUX_KVM_IRQFD_H */
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index a7794ffdb976..399ef2bdce5d 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -273,6 +273,9 @@ static void irqfd_update(struct kvm *kvm, struct kvm_kernel_irqfd *irqfd)
 	else
 		irqfd->irq_entry.type = 0;
 
+	irqfd->irq_entry.irqfd_arch_vcpu = NULL;
+	irqfd->irq_entry.irqfd_arch_data = NULL;
+
 	write_seqcount_end(&irqfd->irq_entry_sc);
 }
 
@@ -594,6 +597,8 @@ kvm_irqfd_deassign(struct kvm *kvm, struct kvm_irqfd *args)
 			 */
 			write_seqcount_begin(&irqfd->irq_entry_sc);
 			irqfd->irq_entry.type = 0;
+			irqfd->irq_entry.irqfd_arch_vcpu = NULL;
+			irqfd->irq_entry.irqfd_arch_data = NULL;
 			write_seqcount_end(&irqfd->irq_entry_sc);
 			irqfd_deactivate(irqfd);
 		}
diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index 6ccabfd32287..b163f7ed3c1e 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -47,7 +47,7 @@ int kvm_irq_map_chip_pin(struct kvm *kvm, unsigned irqchip, unsigned pin)
 
 int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi)
 {
-	struct kvm_kernel_irq_routing_entry route;
+	struct kvm_kernel_irq_routing_entry route = {};
 
 	if (!kvm_arch_irqchip_in_kernel(kvm) || (msi->flags & ~KVM_MSI_VALID_DEVID))
 		return -EINVAL;
@@ -145,6 +145,8 @@ static int setup_routing_entry(struct kvm *kvm,
 
 	e->gsi = gsi;
 	e->type = ue->type;
+	e->irqfd_arch_vcpu = NULL;
+	e->irqfd_arch_data = NULL;
 	r = kvm_set_routing_entry(kvm, e, ue);
 	if (r)
 		return r;
-- 
2.50.1 (Apple Git-155)

