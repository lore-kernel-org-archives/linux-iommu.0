Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E327620C49C
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962019; cv=none; b=Y+eF2BxrOp96vSAHoATaE5mrsTc8DSxNPV95QgEvCjXDkpORgmZFhqupiVvBAXpojgJdhrJnl+CIzrWbjC+EM/9cLuq6xRTsR/geVN5QA75VOkLkSUO2tiZyxc66vG6bycQ2UUrjGxbbjSeZj47Q/cx9XSnNiBdvGIS1rLFpIM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962019; c=relaxed/simple;
	bh=x9Js4xRf2fagahtWsIdqeRgieCQlq12uWu+DkKct3A0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iRo2Typ+iPvxqXvc/bAYn7VE6P0w9no9wDHx23bCCXuZkPVN+wlopvFNtFN/BKd4DrBiFpsW1AfMaLPhzMFv1A9h2mVVNsVttCCr50vYJ2FCSItOYYpd+ByVeRKe2BSgSnkRApX43acw6YGxSOFSC3S4dWVrw4dpj5v0BvXNBLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6yzvffi; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6yzvffi"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e9b2e7a34so4949590a91.0
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962016; x=1748566816; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=f+eDLIQHFMcpEOYcHglDhK5o4FzkgGqWkRl/nqwWdGk=;
        b=i6yzvffiN6AnixZO959nweD5KnYnEH6yNLl9cOGzfPlXIdnIp0aGKMMbOKflTmeYNn
         m1guRcYcSUk/upJsorHWDbcxbN4GcG2qqrdBAfeb7mCoCs5m2HSEy2JRPe2FxNzLaN9Z
         nBha2s6n/hsnTrBdx7xV3/3ispyfdwstnOFyL5IRi7ppAZ17ztCXBABQFq9TqCn63fPo
         UX8GMdfG8gMPlXlQGb2ADcGIUXRxZ+yK8eo2Gyyu3ffQefK6Q/mnl3h/w2aSJJXzU8eB
         t0NDv5F11lHLZZfaOygZVOhpFk5iHngu8WYydfxsY48wY4gsoC6//EVzviOw2F0JnCWp
         kcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962016; x=1748566816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+eDLIQHFMcpEOYcHglDhK5o4FzkgGqWkRl/nqwWdGk=;
        b=iCoOikJtk/Eg4zvP9NxgcpbP5lLOEYT1wdZO1xREBGGBDJUNgVQ5qS0thO69oBsNn2
         VB9g30y99cqqkMSmmyDWV0lVW5XFb7wBPioQSNLHKYmPVEh6ssZeefzCez5Hj/rij/LE
         MHJzruhR8XubE0VPq8X8lBZRQ5D+7PoMLGwoHzJK1C72jyxR/ZejveR86Sw0CeFVxWGE
         z5sAA7n15BF/CDws1Ea0uj6mtdooBPhNC1h5mVvlnhRk7K/c5A2iiOs2rcO8pigMwl0w
         Utasl0220lXbEV0NSbCV6EgRRO9BUP5qM+sDW9SarcUsgihztxTiE1x93vcmxPkSuTRN
         hbvw==
X-Forwarded-Encrypted: i=1; AJvYcCVmrUQLa/0rAF3DwiDxGQ/ooLu50EWTP66rcd5fFlF+6gnFzDu7CnWsOHXBTR0NbjDmwE6aWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+YcS0+JuYFkPCZJw1SeVyOH01BVBKsFHmw7Gd5O7LKXAqCipL
	eFWpPalbpug9PrSJUpCv2RZNFRYkm/3UsTmPaq9gV2tStWrJf3jgbzC3rCq3H/HJJRnlIqQV32d
	L5QXUww==
X-Google-Smtp-Source: AGHT+IFRK4pCGNx5RVFqayo33KWfIvlE7D1S00v4g5t5HPuyq20BbcD+1Y9gRM+96VncuPv0B1J4drbDnBM=
X-Received: from pjbsn15.prod.google.com ([2002:a17:90b:2e8f:b0:30c:4b1f:78ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c87:b0:2fe:d766:ad8e
 with SMTP id 98e67ed59e1d1-310e96b6d28mr1783221a91.4.1747962015762; Thu, 22
 May 2025 18:00:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:08 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-4-seanjc@google.com>
Subject: [PATCH v2 03/59] KVM: SVM: Delete IRTE link from previous vCPU before
 setting new IRTE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Delete the previous per-vCPU IRTE link prior to modifying the IRTE.  If
forcing the IRTE back to remapped mode fails, the IRQ is already broken;
keeping stale metadata won't change that, and the IOMMU should be
sufficiently paranoid to sanitize the IRTE when the IRQ is freed and
reallocated.

This will allow hoisting the vCPU tracking to common x86, which in turn
will allow most of the IRTE update code to be deduplicated.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c   | 60 +++++++++------------------------------
 include/linux/kvm_irqfd.h |  1 +
 2 files changed, 14 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index d33c01379421..ed7374f0bd5a 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -766,23 +766,19 @@ static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 	return ret;
 }
 
-static void svm_ir_list_del(struct vcpu_svm *svm,
-			    struct kvm_kernel_irqfd *irqfd,
-			    struct amd_iommu_pi_data *pi)
+static void svm_ir_list_del(struct kvm_kernel_irqfd *irqfd)
 {
+	struct kvm_vcpu *vcpu = irqfd->irq_bypass_vcpu;
 	unsigned long flags;
-	struct kvm_kernel_irqfd *cur;
 
-	spin_lock_irqsave(&svm->ir_list_lock, flags);
-	list_for_each_entry(cur, &svm->ir_list, vcpu_list) {
-		if (cur->irq_bypass_data != pi->ir_data)
-			continue;
-		if (WARN_ON_ONCE(cur != irqfd))
-			continue;
-		list_del(&irqfd->vcpu_list);
-		break;
-	}
-	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
+	if (!vcpu)
+		return;
+
+	spin_lock_irqsave(&to_svm(vcpu)->ir_list_lock, flags);
+	list_del(&irqfd->vcpu_list);
+	spin_unlock_irqrestore(&to_svm(vcpu)->ir_list_lock, flags);
+
+	irqfd->irq_bypass_vcpu = NULL;
 }
 
 static int svm_ir_list_add(struct vcpu_svm *svm,
@@ -795,24 +791,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm,
 	if (WARN_ON_ONCE(!pi->ir_data))
 		return -EINVAL;
 
-	/**
-	 * In some cases, the existing irte is updated and re-set,
-	 * so we need to check here if it's already been * added
-	 * to the ir_list.
-	 */
-	if (pi->prev_ga_tag) {
-		struct kvm *kvm = svm->vcpu.kvm;
-		u32 vcpu_id = AVIC_GATAG_TO_VCPUID(pi->prev_ga_tag);
-		struct kvm_vcpu *prev_vcpu = kvm_get_vcpu_by_id(kvm, vcpu_id);
-		struct vcpu_svm *prev_svm;
-
-		if (!prev_vcpu)
-			return -EINVAL;
-
-		prev_svm = to_svm(prev_vcpu);
-		svm_ir_list_del(prev_svm, irqfd, pi);
-	}
-
+	irqfd->irq_bypass_vcpu = &svm->vcpu;
 	irqfd->irq_bypass_data = pi->ir_data;
 
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
@@ -904,6 +883,8 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 
 		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
 
+		svm_ir_list_del(irqfd);
+
 		/**
 		 * Here, we setup with legacy mode in the following cases:
 		 * 1. When cannot target interrupt to a specific vcpu.
@@ -962,21 +943,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		pi.prev_ga_tag = 0;
 		pi.is_guest_mode = false;
 		ret = irq_set_vcpu_affinity(host_irq, &pi);
-
-		/**
-		 * Check if the posted interrupt was previously
-		 * setup with the guest_mode by checking if the ga_tag
-		 * was cached. If so, we need to clean up the per-vcpu
-		 * ir_list.
-		 */
-		if (!ret && pi.prev_ga_tag) {
-			int id = AVIC_GATAG_TO_VCPUID(pi.prev_ga_tag);
-			struct kvm_vcpu *vcpu;
-
-			vcpu = kvm_get_vcpu_by_id(kvm, id);
-			if (vcpu)
-				svm_ir_list_del(to_svm(vcpu), irqfd, &pi);
-		}
 	}
 out:
 	srcu_read_unlock(&kvm->irq_srcu, idx);
diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index 6510a48e62aa..361c07f4466d 100644
--- a/include/linux/kvm_irqfd.h
+++ b/include/linux/kvm_irqfd.h
@@ -60,6 +60,7 @@ struct kvm_kernel_irqfd {
 	struct irq_bypass_consumer consumer;
 	struct irq_bypass_producer *producer;
 
+	struct kvm_vcpu *irq_bypass_vcpu;
 	struct list_head vcpu_list;
 	void *irq_bypass_data;
 };
-- 
2.49.0.1151.ga128411c76-goog

