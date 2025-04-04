Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5BE230BCD
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795656; cv=none; b=eWBgw62IRH+AloI7lnlm2o4SAd8mXyPAesFq0TTjlrHhn2WFhSv578ks0tut9i3eVyf7/AhcWsfX0Z5UFhzUYc88IBEgjzjkHyRdtz1GLoGYOxMDDjMNTRRRRdfHodS3piehyu3c7B6VUulUcovmt5Svxgoj45n3saAI1nokRko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795656; c=relaxed/simple;
	bh=7iUSFx5D3yR25IHThTgAc/IOAW4zYfJ9SgblmRez7ms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jh72X8sP2YDNc6tls+sofbIVHGJQShNgUr22uPQ1VFwlJJ4vE28i+NL7XtgvmOG+wiMkIau3w8cPPn6Y9xRqKVsfI395uTfuuhljGsuOErdzyuO1bpj6r+QNm1XiwLHlgD1ZZDYXwpUSlg49BzOg/aaclvZXRl7eQhg+B4Htiu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+xy0rU1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+xy0rU1"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so3538557a91.3
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795654; x=1744400454; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4e9ffwdEp7Gqw+G1mVFy+m5vTrdwBux5yCWrxBIAEu0=;
        b=U+xy0rU1ehnVcCVoeOT9+5LmxQLTZI+mfwGuh0yYrmxm6BIG0F+XzTQygSQWtcxx/B
         dVqzdauP2zTGD0LT5ppW1cZUXjGFHfGzNcZ5HRbuymCFC98Pg+jXQBSLbVyrV6jVOjse
         +KWfDoUlu5RNbHZnCiQlVUfDeXfY7mJ1WeiXYC8CVug8ZeD5RmQz6DsvkOaYfWTmPoGm
         q0YHltSbZcz9iJY2+aGIUGLblRk/EiYtXl8F2CyF7nKxkWYqPhxCFvGOCbuVCTKuNkUS
         A73JG6EdAmMsIR6eMO/wmXGbCN6lk2HUCbgDYVA7MN+ooTr2I2CfTgakpdOw0K5TTRb0
         ZSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795654; x=1744400454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4e9ffwdEp7Gqw+G1mVFy+m5vTrdwBux5yCWrxBIAEu0=;
        b=wMuiieVP3I9iGDcQkQzyMPZLWZIAb+nbtpU9fhCGxDxmE2/DI5q4EsC0fddaJFQky2
         iPUmT43M9zyuf3Y1eA4F/cuqR2IxtxbrDTPeoyVD3qhFkmRg0KLoiK+JN17TVbTiubuY
         noiu5NeY3MWdv+FmkkJbIzR7Okhh1IF6r6z653bozz8+DxbDCLOoP3mX1KRQmsW9/J5L
         ZZVQ2ky6RIDCF9gmxs1+wTk7dcfPOhvnF8zmiWmKQXKZ6RbwXP3Dk0vSaKWz1HTXhWOO
         g+wdAfbwjCaxr0+H+MXlaA9ksXL5h7i4zoq9AJNT+asISxn1uifWvtl/JBoaMLPYOutI
         YXpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsJdcgHV4ZMBxC441QeTMBQCXqqweIUPp9dvEskJudW929PPV5pf3+k5cSDHGm6V8JfBoNOA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5pFwdN0HPuZPgfAI47ON6NX8z+5p3SBLe68cMRf+oPZmOO63S
	zaDh7FJpScEOvlFOqn3jjdMMrQBh9dgmDlcP1HfVQblNGISThBcD0ITBZd1eFfcmSU/YYTOlXnL
	V7Q==
X-Google-Smtp-Source: AGHT+IHq0WDQdQXdmkR68srWyYUi8Jk0ER178ssR+69T3RU1Hrt5+d4NUY61J9tgaeNmx2ouyINmHwrWyBg=
X-Received: from pjbqn3.prod.google.com ([2002:a17:90b:3d43:b0:2fc:c98:ea47])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c2d0:b0:2ee:d193:f3d5
 with SMTP id 98e67ed59e1d1-306a6120999mr5163910a91.7.1743795654132; Fri, 04
 Apr 2025 12:40:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:54 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-40-seanjc@google.com>
Subject: [PATCH 39/67] KVM: x86: Track irq_bypass_vcpu in common x86 code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Track the vCPU that is being targeted for IRQ bypass, a.k.a. for a posted
IRQ, in common x86 code.  This will allow for additional consolidation of
the SVM and VMX code.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 4 ----
 arch/x86/kvm/x86.c      | 7 ++++++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 355673f95b70..bd1fcf2ea1e5 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -776,22 +776,18 @@ static void svm_ir_list_del(struct kvm_kernel_irqfd *irqfd)
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
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 36d4a9ed144d..0d9bd8535f61 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13604,8 +13604,13 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 
 	r = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, host_irq, irqfd->gsi,
 					 new, vcpu, irq.vector);
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
-- 
2.49.0.504.g3bcea36a83-goog

