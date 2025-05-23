Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF711283CAC
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962066; cv=none; b=Mjjm4FyVPV9xfuxbITksXVgar2r75wN2cblwiMp6cJJWXbKP3e0o0lHpGR6fIRYifvZ4LRCdgl8VB+pCRhhHIjlhIEGUGKUR9cj0UCTxOVeRRJ6JJDYqCD1SanyED0vAFFaGqGKnYKvuOYPfxkHHEFl6YrVdq6SwHr+rVpyMjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962066; c=relaxed/simple;
	bh=lF7pC8sohabNgcaIb1E8HB/O7nTwbIatU6uqVNQw5dg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DRHHGZZdv61rEQbDulNFCgmz0EtLbakvD3xbRBuaWe4SrHhA50NeWRX33acIRLNc2diq5A45h5qD7FhLc01JpouVtc675zksPzp8LB7EHfdBbw3HrViNv5/amKwBMzeRe8i7/qngeeThUPJ4iz319vhM+ByQhJ23RuT73BTBwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZ+hN5tc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZ+hN5tc"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742c5f7a70bso6877290b3a.2
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962064; x=1748566864; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VEEMumgPPOxuu5AKa6Opm2ERFPwrtqEfeM08GKoEFwc=;
        b=jZ+hN5tcruN2AA9+ocMuiSAX/bKvYaEUqlpPSxN8drOn9jYpIa5bOmckJpUg7Vf34t
         hH61l+tevJIKyS48lVo9qul7ow7xD3OSUV454YlASiC3SGF4ZO1V4Q8qmBPfQmGsXWtu
         +GIn3E9ufk61EVXrU7Dyxj+yOgbisseLkMmWuhbrX1XB4A1zSgKaGjYmSge/xjiX1Ah9
         vDHHCfL53i45zGqM9B/0Lg++gC89nH0cGZPgejElkZgifbd+pRi0uStOJuLF3nZI8uWX
         59AwMcpJtLjSYgV8b9wx54AV6Ii5hpg75vthLj6/OiTkrG+g3x9z61C8QK8IoU2xDjfq
         iY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962064; x=1748566864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEEMumgPPOxuu5AKa6Opm2ERFPwrtqEfeM08GKoEFwc=;
        b=rLCihe/dJ3KMbdrPe06AlWTqDqFVDP3c7A2pQRKhD7NmnDRALR5Z+4BgDCTfaGp5ZF
         qX9HGrbhq90AG8IReNO1gjLLYMHoiHP8dsGG4xj91RfyHZa4lSepl0FtPwYt6KEEp4wo
         +SzjditOkjc1c6UJM/IzTUnpOFp8z9RtGDJqd/7bfYB07bGcmkzuIoXWinPGn4Lk7ri7
         PWFBpNXDd/ko2Bo2QsXC/p/aRIA6FRihjIOFBqNo3txmhmFdkkjC7bXLqhER6nzGX2hO
         n1zfBY4vNvc1Rtyj4PFNc1iZC0Wttna9XKOrM341SlPV/goYmoZiJIaJv3qRwr/c4E66
         sD9g==
X-Forwarded-Encrypted: i=1; AJvYcCUZuEeA5kdoFPPBeMRfO/cAELPl9NyKYt9Vx0Sli/ln6lwCUfjBG/nSjwxIZc5uU1cqDclagQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIhaRgUm28p6DD8N0w9pN7h8O/79rK/b9461aqE4o+cYuKFiQN
	MpIExLRo4vesw6PrVJG0hzVYHaDK8fHZ9tuqD1av7HGiDA0BsrE5kL4cOv9NLdZC/N8ByDk0p05
	w9x9ygw==
X-Google-Smtp-Source: AGHT+IETqKO87aMFsUZqxCg0LdZa+zJR5n+2fRyhOgSEe0vCrHKlfeYquaUmcKRaIo3hs3+dxPHGjYw4zFc=
X-Received: from pgbfq25.prod.google.com ([2002:a05:6a02:2999:b0:b26:e54d:d7dd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a129:b0:1f5:8e54:9f10
 with SMTP id adf61e73a8af0-2170cde51b5mr47706400637.34.1747962064242; Thu, 22
 May 2025 18:01:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:37 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-33-seanjc@google.com>
Subject: [PATCH v2 32/59] KVM: x86: Track irq_bypass_vcpu in common x86 code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Track the vCPU that is being targeted for IRQ bypass, a.k.a. for a posted
IRQ, in common x86 code.  This will allow for additional consolidation of
the SVM and VMX code.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.c      | 7 ++++++-
 arch/x86/kvm/svm/avic.c | 4 ----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 582fc17ae02b..3a0f28e98429 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -544,8 +544,13 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 
 	r = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, host_irq, irqfd->gsi,
 					 vcpu, irq.vector);
-	if (r)
+	if (r) {
+		WARN_ON_ONCE(irqfd->irq_bypass_vcpu && !vcpu);
+		irqfd->irq_bypass_vcpu = NULL;
 		return r;
+	}
+
+	irqfd->irq_bypass_vcpu = vcpu;
 
 	trace_kvm_pi_irte_update(host_irq, vcpu, irqfd->gsi, irq.vector, !!vcpu);
 	return 0;
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 6085a629c5e6..97b747e82012 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -767,22 +767,18 @@ static void svm_ir_list_del(struct kvm_kernel_irqfd *irqfd)
 	spin_lock_irqsave(&to_svm(vcpu)->ir_list_lock, flags);
 	list_del(&irqfd->vcpu_list);
 	spin_unlock_irqrestore(&to_svm(vcpu)->ir_list_lock, flags);
-
-	irqfd->irq_bypass_vcpu = NULL;
 }
 
 static int svm_ir_list_add(struct vcpu_svm *svm,
 			   struct kvm_kernel_irqfd *irqfd,
 			   struct amd_iommu_pi_data *pi)
 {
-	struct kvm_vcpu *vcpu = &svm->vcpu;
 	unsigned long flags;
 	u64 entry;
 
 	if (WARN_ON_ONCE(!pi->ir_data))
 		return -EINVAL;
 
-	irqfd->irq_bypass_vcpu = vcpu;
 	irqfd->irq_bypass_data = pi->ir_data;
 
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
-- 
2.49.0.1151.ga128411c76-goog

