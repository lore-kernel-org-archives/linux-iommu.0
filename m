Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB224CEEA
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795691; cv=none; b=WYbD3WzNw9MPq97esxTQqhBgQQbt8KSwtzKJ6/KjlZt6yZrzQehhp8CBtBNnIYHjNn63XevkvdzNEDhE4LLm6+HmifzHoT3JAkaJzHECqCQbgHt1AVoy6neE+Ce6IQf1R6BDMD7iRZd7n6fmZuo6oxp9mFtzThxr8E2u/I8fw2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795691; c=relaxed/simple;
	bh=U7Bv3Mou19gPLSngEjr+1RsKLIdn0l5YTp9cdhCcRAg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sml8F6G8ZBk/NZIvhet3vVahrRP5+rWSGIph6HbnEOa1+p82rvrmZV3kc/aVDSO+2DTwZoaWUggrVEco+7lpchW6vhxNeaESLqJquGYCXmqf0OL5IuUVM8vZUMlLyZPdYGSGuv3mvZpNrN8Us2MN5bNUBIvvpLg+fAo3iA7cqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/Zvcl6V; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/Zvcl6V"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7369b559169so1803628b3a.1
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795689; x=1744400489; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mt07Qxkb97s5FkZiQg7yKT2x8NR3KghJCfR+NZxwIRc=;
        b=O/Zvcl6VafcoVvyMNnwX1Dxrxhk+Fy7nPs5VXjpxwxr+83rjT+OanQsv52wF5d0p2C
         H3NWpw2m1hPwBS01vpcuU7mSC/VxTkqDMzXYtkySh78li+9ULfd1JeV8tP60llz5r7Qy
         oSKDfHPahZFznDP0BPdGx4GkK0n/gg25aYQDE/eL+cmkA+gDTY8G/otAcq4jVFjYL8NG
         m5ikV4D/5quZKHZsjGnZGHTv8Mxcnx3d68nJVJeFib3I+uCmxsXVJnYSg8OGlJusRIJz
         LSDAwR2JeUlsQyUJL1oIkIC3i/9xN3VlOIYfwuVcf5qOO6jNxSvqEAXUQ7Wrd5k+yxRL
         /UUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795689; x=1744400489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mt07Qxkb97s5FkZiQg7yKT2x8NR3KghJCfR+NZxwIRc=;
        b=D5vJ/3q9DYI+LNWXjl2Da8GEEfUV1yUFbNkh7mKQoR5+2BSQjIyk7fiIsmI2ya2UPY
         YtIttxU8tnsjYKCO/4PVd+m3vJVQbI75vTSkFa63gWH+/XOv50iGsNZtynBJddDHzS/9
         ozDsVYrBsKiVe1YlgRSYAcnMhDJBGgQS2KLghTeo1YLPYKu9lSNnWQeyu4pa665OO+hV
         YmyB6mO1VSG0oscM9HS8X2q0gMNxEnmp0tadT8T3Lx0k8V9h3SOobsgvgH+zzPizVJ+y
         Dy1ruMPTAJKO5Fv5WSNN+Tv2/yePm8O/3b5svLGNNco383v+4L6HTQaFFbzM6CxSDbSu
         983A==
X-Forwarded-Encrypted: i=1; AJvYcCV3ICSMt5bFhmwq4adxWww+/mU0GhTW4VOvYuJjPeXUbBHYMc7u+ts+zkYNDuUyJGM/Tuc0Yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiQaQ9lLhA3QxKCsbNx4DctmgERamqvWJAJSfDw+ixrkl8W6ZN
	INw3Yyz3NnlMRDMVyYeU/B4B6zAkj3pKYYz0W1lFH8bgFNn+lO6sDtyDUMm2BKud6mbhJmMNqJd
	mUw==
X-Google-Smtp-Source: AGHT+IHKRRqtQ+5sxIr+azJfU1pTEj52X3kWKBhqR+uBWAf1O7lXz3snAlLOZvwHP7CdcZyeKm5xblX214Q=
X-Received: from pfbdf8.prod.google.com ([2002:a05:6a00:4708:b0:737:6b9f:8ab4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10cb:b0:736:5486:7820
 with SMTP id d2e1a72fcca58-739e48573c2mr5416904b3a.13.1743795688779; Fri, 04
 Apr 2025 12:41:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:14 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-60-seanjc@google.com>
Subject: [PATCH 59/67] KVM: SVM: Use vcpu_idx, not vcpu_id, for GA log tag/metadata
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Use a vCPU's index, not its ID, for the GA log tag/metadata that's used to
find and kick vCPUs when a device posted interrupt serves as a wake event.
Lookups on a vCPU index are O(fast) (not sure what xa_load() actually
provides), whereas a vCPU ID lookup is O(n) if a vCPU's ID doesn't match
its index.

Unlike the Physical APIC Table, which is accessed by hardware when
virtualizing IPIs, hardware doesn't consume the GA tag, i.e. KVM _must_
use APIC IDs to fill the Physical APIC Table, but KVM has free rein over
the format/meaning of the GA tag.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index d2cbb7ac91f4..d567d62463ac 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -29,36 +29,39 @@
 #include "svm.h"
 
 /*
- * Encode the arbitrary VM ID and the vCPU's default APIC ID, i.e the vCPU ID,
- * into the GATag so that KVM can retrieve the correct vCPU from a GALog entry
- * if an interrupt can't be delivered, e.g. because the vCPU isn't running.
+ * Encode the arbitrary VM ID and the vCPU's _index_ into the GATag so that
+ * KVM can retrieve the correct vCPU from a GALog entry if an interrupt can't
+ * be delivered, e.g. because the vCPU isn't running.  Use the vCPU's index
+ * instead of its ID (a.k.a. its default APIC ID), as KVM is guaranteed a fast
+ * lookup on the index, where as vCPUs whose index doesn't match their ID need
+ * to walk the entire xarray of vCPUs in the worst case scenario.
  *
- * For the vCPU ID, use however many bits are currently allowed for the max
+ * For the vCPU index, use however many bits are currently allowed for the max
  * guest physical APIC ID (limited by the size of the physical ID table), and
  * use whatever bits remain to assign arbitrary AVIC IDs to VMs.  Note, the
  * size of the GATag is defined by hardware (32 bits), but is an opaque value
  * as far as hardware is concerned.
  */
-#define AVIC_VCPU_ID_MASK		AVIC_PHYSICAL_MAX_INDEX_MASK
+#define AVIC_VCPU_IDX_MASK		AVIC_PHYSICAL_MAX_INDEX_MASK
 
 #define AVIC_VM_ID_SHIFT		HWEIGHT32(AVIC_PHYSICAL_MAX_INDEX_MASK)
 #define AVIC_VM_ID_MASK			(GENMASK(31, AVIC_VM_ID_SHIFT) >> AVIC_VM_ID_SHIFT)
 
 #define AVIC_GATAG_TO_VMID(x)		((x >> AVIC_VM_ID_SHIFT) & AVIC_VM_ID_MASK)
-#define AVIC_GATAG_TO_VCPUID(x)		(x & AVIC_VCPU_ID_MASK)
+#define AVIC_GATAG_TO_VCPUIDX(x)	(x & AVIC_VCPU_IDX_MASK)
 
-#define __AVIC_GATAG(vm_id, vcpu_id)	((((vm_id) & AVIC_VM_ID_MASK) << AVIC_VM_ID_SHIFT) | \
-					 ((vcpu_id) & AVIC_VCPU_ID_MASK))
-#define AVIC_GATAG(vm_id, vcpu_id)					\
+#define __AVIC_GATAG(vm_id, vcpu_idx)	((((vm_id) & AVIC_VM_ID_MASK) << AVIC_VM_ID_SHIFT) | \
+					 ((vcpu_idx) & AVIC_VCPU_IDX_MASK))
+#define AVIC_GATAG(vm_id, vcpu_idx)					\
 ({									\
-	u32 ga_tag = __AVIC_GATAG(vm_id, vcpu_id);			\
+	u32 ga_tag = __AVIC_GATAG(vm_id, vcpu_idx);			\
 									\
-	WARN_ON_ONCE(AVIC_GATAG_TO_VCPUID(ga_tag) != (vcpu_id));	\
+	WARN_ON_ONCE(AVIC_GATAG_TO_VCPUIDX(ga_tag) != (vcpu_idx));	\
 	WARN_ON_ONCE(AVIC_GATAG_TO_VMID(ga_tag) != (vm_id));		\
 	ga_tag;								\
 })
 
-static_assert(__AVIC_GATAG(AVIC_VM_ID_MASK, AVIC_VCPU_ID_MASK) == -1u);
+static_assert(__AVIC_GATAG(AVIC_VM_ID_MASK, AVIC_VCPU_IDX_MASK) == -1u);
 
 static bool force_avic;
 module_param_unsafe(force_avic, bool, 0444);
@@ -148,16 +151,16 @@ int avic_ga_log_notifier(u32 ga_tag)
 	struct kvm_svm *kvm_svm;
 	struct kvm_vcpu *vcpu = NULL;
 	u32 vm_id = AVIC_GATAG_TO_VMID(ga_tag);
-	u32 vcpu_id = AVIC_GATAG_TO_VCPUID(ga_tag);
+	u32 vcpu_idx = AVIC_GATAG_TO_VCPUIDX(ga_tag);
 
-	pr_debug("SVM: %s: vm_id=%#x, vcpu_id=%#x\n", __func__, vm_id, vcpu_id);
-	trace_kvm_avic_ga_log(vm_id, vcpu_id);
+	pr_debug("SVM: %s: vm_id=%#x, vcpu_idx=%#x\n", __func__, vm_id, vcpu_idx);
+	trace_kvm_avic_ga_log(vm_id, vcpu_idx);
 
 	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
 	hash_for_each_possible(svm_vm_data_hash, kvm_svm, hnode, vm_id) {
 		if (kvm_svm->avic_vm_id != vm_id)
 			continue;
-		vcpu = kvm_get_vcpu_by_id(&kvm_svm->kvm, vcpu_id);
+		vcpu = kvm_get_vcpu(&kvm_svm->kvm, vcpu_idx);
 		break;
 	}
 	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
@@ -793,7 +796,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 */
 		struct amd_iommu_pi_data pi_data = {
 			.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
-					     vcpu->vcpu_id),
+					     vcpu->vcpu_idx),
 			.is_guest_mode = kvm_vcpu_apicv_active(vcpu),
 			.vapic_addr = avic_get_backing_page_address(to_svm(vcpu)),
 			.vector = vector,
-- 
2.49.0.504.g3bcea36a83-goog

