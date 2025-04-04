Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9FA222572
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795606; cv=none; b=aSapdG014y8jMJ44fmi7/9Ydg91hq3Jf4e6igrcSYjjIPWVlPMB8TEsWOAPJl9KkEOw81qi3gh5yE2MwMbME41GIk0HzPq+tTN4m92MnA96rjBbuDBATN4Wu5My9fnlSIhNo8JM0lPPLEsTmFK/7HsZ3aT1cbbnGjRH9pSaNYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795606; c=relaxed/simple;
	bh=Gz9aIMimbdwkNGt7OPfLnkRhIKwp18RPumjkvSLqEHM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mNTxnXtgmWFIJUKH5oH5gQvD4iKHZ4lx67UeOjTZ0ZPFUJxLGPUYwIjecC0MsxUhTHm9HPccbK3pBy2ajha97etSik1x+u6esNRZgqsdL6jWQ3WOSFcR6kIPW/QUF0sNsD4xe9QXkb6NKHImVdZAHjLl4NsLvzj+Z6aMrmSKcoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EtGcr3k2; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EtGcr3k2"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736c0306242so3285572b3a.1
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795602; x=1744400402; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NJ2AwZ96IG0rnLVApDhmCehhnZWDzfbxNCDQQeJNmJo=;
        b=EtGcr3k28Lye0WBr8ScHaq3BjBCalwa075X/bdIGVqQkmc1Zyhi7NvCpYnR72PUpOW
         BEyyAtZ/KEFhf98lVyVJwyuzxlq8jav9GuYRaHzEXgo6Tf0VbAqMPVC9q3AgekY6zSJE
         2kwB0wffpXL9f2Dy8rwuKKrpSXVTAdd/UqQdqQs0oz6x/a9fbnWxjHpHXjVhSTzAvgue
         qvR6z4VapRjlzpKQNLMPLPaxbwygelgUU3mk81feCFuWL/y/IDz7PF2/kGgL0ctwsOK0
         8heJeaMKyAICXUqYdhKw+FW83MZUPbZ48IJlh7DtFcw2isU5QnWdVolGYHjMFYNA3luH
         FjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795602; x=1744400402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJ2AwZ96IG0rnLVApDhmCehhnZWDzfbxNCDQQeJNmJo=;
        b=jZo6PJwWNaJLg+Ql5X9HSkVGm4G7F+vqFroR+9fKsxBQOSplgOgScKU6+mGZD5giIp
         Ef0ZYWIQE9f0nhqSEZRFxNA6AwHF0TEmiwTfalGJu2cqxlrjBfv0nPwrUaLiVsLSxHPq
         6tGr5yTxzifFx6/5HxjoaofzzCDBr2I7DTheouE7jjLbj2ggm5RdXQBkl/InV9NYfGAu
         leEWq8xb725MScYrGlbrilrkpaUVpm9fhe5n9XKG0SuUfE02T0uRFldtIMrffPDIp5p/
         yX5bprWjlwmqxXO40Tdu0dwX4MTh2iGj36rXbz5CkNFPieqCmu8lk8RPNui5Czq7E97a
         jfBA==
X-Forwarded-Encrypted: i=1; AJvYcCV3HDr30mk9SQ6GjeZ7tOkExsnwFvO6ASF1xEetxbmmtSw+miLwplmdOzoMoeDwcUoDf2cnuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyTQiCLugKJO7kWdmk95Q/xJ+u2fcBWvxuXa9arMf7qhHI7dFd
	MTzvE1+h9YWHQGXCbUb6quoDk1LO4YUvKcR8hjG/AKHPFjFy+PN5WAft9GJPLl7t6yzZhNbL5Yn
	RcA==
X-Google-Smtp-Source: AGHT+IHUTfAFvmnRXzxBNmSCJ462dhgG2sdJTjm66unWjPqXxcSiOT2PYCNJZf1pPqjK0XlU7MmQ9tlS5gg=
X-Received: from pfmx24.prod.google.com ([2002:a62:fb18:0:b0:736:5012:3564])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:13a6:b0:736:42a8:a742
 with SMTP id d2e1a72fcca58-739e4b4aa8bmr5807564b3a.11.1743795602558; Fri, 04
 Apr 2025 12:40:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:24 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-10-seanjc@google.com>
Subject: [PATCH 09/67] KVM: SVM: Track per-vCPU IRTEs using kvm_kernel_irqfd structure
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Track the IRTEs that are posting to an SVM vCPU via the associated irqfd
structure and GSI routing instead of dynamically allocating a separate
data structure.  In addition to eliminating an atomic allocation, this
will allow hoisting much of the IRTE update logic to common x86.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c   | 49 ++++++++++++++++-----------------------
 include/linux/kvm_irqfd.h |  3 +++
 2 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 04dfd898ea8d..967618ba743a 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -774,27 +774,30 @@ static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 	return ret;
 }
 
-static void svm_ir_list_del(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
+static void svm_ir_list_del(struct vcpu_svm *svm,
+			    struct kvm_kernel_irqfd *irqfd,
+			    struct amd_iommu_pi_data *pi)
 {
 	unsigned long flags;
-	struct amd_svm_iommu_ir *cur;
+	struct kvm_kernel_irqfd *cur;
 
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
-	list_for_each_entry(cur, &svm->ir_list, node) {
-		if (cur->data != pi->ir_data)
+	list_for_each_entry(cur, &svm->ir_list, vcpu_list) {
+		if (cur->irq_bypass_data != pi->ir_data)
 			continue;
-		list_del(&cur->node);
-		kfree(cur);
+		if (WARN_ON_ONCE(cur != irqfd))
+			continue;
+		list_del(&irqfd->vcpu_list);
 		break;
 	}
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
 
-static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
+static int svm_ir_list_add(struct vcpu_svm *svm,
+			   struct kvm_kernel_irqfd *irqfd,
+			   struct amd_iommu_pi_data *pi)
 {
-	int ret = 0;
 	unsigned long flags;
-	struct amd_svm_iommu_ir *ir;
 	u64 entry;
 
 	if (WARN_ON_ONCE(!pi->ir_data))
@@ -811,25 +814,14 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 		struct kvm_vcpu *prev_vcpu = kvm_get_vcpu_by_id(kvm, vcpu_id);
 		struct vcpu_svm *prev_svm;
 
-		if (!prev_vcpu) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!prev_vcpu)
+			return -EINVAL;
 
 		prev_svm = to_svm(prev_vcpu);
-		svm_ir_list_del(prev_svm, pi);
+		svm_ir_list_del(prev_svm, irqfd, pi);
 	}
 
-	/**
-	 * Allocating new amd_iommu_pi_data, which will get
-	 * add to the per-vcpu ir_list.
-	 */
-	ir = kzalloc(sizeof(struct amd_svm_iommu_ir), GFP_ATOMIC | __GFP_ACCOUNT);
-	if (!ir) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	ir->data = pi->ir_data;
+	irqfd->irq_bypass_data = pi->ir_data;
 
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
 
@@ -844,10 +836,9 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 		amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
 				    true, pi->ir_data);
 
-	list_add(&ir->node, &svm->ir_list);
+	list_add(&irqfd->vcpu_list, &svm->ir_list);
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
-out:
-	return ret;
+	return 0;
 }
 
 /*
@@ -951,7 +942,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			 * scheduling information in IOMMU irte.
 			 */
 			if (!ret && pi.is_guest_mode)
-				svm_ir_list_add(svm, &pi);
+				svm_ir_list_add(svm, irqfd, &pi);
 		}
 
 		if (!ret && svm) {
@@ -991,7 +982,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 
 			vcpu = kvm_get_vcpu_by_id(kvm, id);
 			if (vcpu)
-				svm_ir_list_del(to_svm(vcpu), &pi);
+				svm_ir_list_del(to_svm(vcpu), irqfd, &pi);
 		}
 	} else {
 		ret = 0;
diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index 8ad43692e3bb..6510a48e62aa 100644
--- a/include/linux/kvm_irqfd.h
+++ b/include/linux/kvm_irqfd.h
@@ -59,6 +59,9 @@ struct kvm_kernel_irqfd {
 	struct work_struct shutdown;
 	struct irq_bypass_consumer consumer;
 	struct irq_bypass_producer *producer;
+
+	struct list_head vcpu_list;
+	void *irq_bypass_data;
 };
 
 #endif /* __LINUX_KVM_IRQFD_H */
-- 
2.49.0.504.g3bcea36a83-goog

