Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A92EB5BE
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682104; cv=none; b=QTCrAtpiB9NU3r+HbZL1/yiQf0l23kAvpYVvM/V5yES7PDqakhF0LufzbKEF5rhkC0ItgDT6s6EEPvQjP0b+ZAnbS+6uoPyJnu5d6RyxkFahC7ibU7mVBJDGAO+gHjjUAGXP7R5Ugp+QG5C8/KQ074nz+++YCzpa7zy0RiyaNOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682104; c=relaxed/simple;
	bh=+BPYP7lpFhIXpD1YhlGCQAYJPvSe+MkxgYeLk60b/EQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cNHWfp24/MB0v7HCMFQr5nbs6Jg1RXFq92K9ZCuhvjOI3b+LscVifsDnl1fJU1YxVtcvUH5SDGDgAjzKaEx/72gqJtt1xiWOizNpdlkB22Tmksb3ncANjwTI+/wuPxri4foO1oUioZI1owDt0F4bweIstwEnsAMgw3EUNMH4Clc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1bixZAn; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1bixZAn"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747d84fe5f8so177154b3a.3
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682102; x=1750286902; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HFNzybZyx0Wu7yBkyufuhZBtndB539SrR/i7yvdQCgY=;
        b=s1bixZAnpmaXyS6xc88/qYKGtV4CfvbkQLbONZhxIAsRqnf1HVaFkBLBy3zfrCiO1g
         tA27Ywy3kvfTzZVnhUKMEMzFJ7koYTuH7IhmBM2kqUAWJave/FczBUfQ/7YlFZpqzV94
         eL1ddCR9ZbCN1+8lmHsDkbvSdEWQ2tb62xHWNcq88C+SafXzXCbnzIpmlY6DY4QZmgsy
         Uh5jj6jagrOE0qtP+olbDHrc01VReo2uhRDw8S/oU4hVSQR2OZsakDeuod+moXgayLMf
         maeyxyxdpuLEGbhSQcqXdBCQbqFIuqrciGlgF83kwT2YQM1wBP6YcPPCyDEpMRnrOK76
         kHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682102; x=1750286902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFNzybZyx0Wu7yBkyufuhZBtndB539SrR/i7yvdQCgY=;
        b=mVlr4WEmYWVhexs25Se5AfwaMzFiuUNNE1QImlG2f9/OK+jc+erUFeQev4dVqK0kTR
         EtwFyQrFx3l3fhA3CAVwRfJ2cdsTarMuLJQ58tUU6DMjIFPCcdsnqa4JdOkOk6abjkfM
         PY2jvRHTeaqLQOzyckVPtTH1mxYSueUA139F7ZjDI8HC2HT2GrQlIz0kj+4NT9oJ0quQ
         Ngq5njpX0AQfglp5oGPZ0a6D5Ir7HAwoiyhQkb9W8QvLit0LjZ1FjDdqS/AA3CzMygvf
         j1KsL91A43YYOopN8wxUxi+JugYF6rI9keBTQpkYowVM9Z50PzJn601ULttMmuWRrNLQ
         Mlqw==
X-Forwarded-Encrypted: i=1; AJvYcCVWiUIWLcY4b/2nh72tn979okn9t3utBjFgniUhAvFpApdwOB3VJB3S8gcUwmz7FivMeVzo6A==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywd7jFA3PJCo18f55VkS6h1Dxrq4siglTw4vZfs20CILeduk096
	rU7MtU674gUTb5mgFok2bhXw953+XKlerwqS2mfho154PQqf+RpRKOhshgugG2bPK3KbRpdtUcr
	Psxy+1Q==
X-Google-Smtp-Source: AGHT+IEnvdDx8CXnODrzRbVPzUSjqGM5XPwQPio/AeEGGkkzZchdEypRUZqvj+dxhae05POY2+Y5SsikCKY=
X-Received: from pfbiv13.prod.google.com ([2002:a05:6a00:66cd:b0:736:38af:afeb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:92a0:b0:748:1bac:aff9
 with SMTP id d2e1a72fcca58-7486cbd90f4mr7663758b3a.18.1749682102554; Wed, 11
 Jun 2025 15:48:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:53 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-52-seanjc@google.com>
Subject: [PATCH v3 50/62] KVM: x86: WARN if IRQ bypass isn't supported in kvm_pi_update_irte()
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN if kvm_pi_update_irte() is reached without IRQ bypass support, as the
code is only reachable if the VM already has an IRQ bypass producer (see
kvm_irq_routing_update()), or from kvm_arch_irq_bypass_{add,del}_producer(),
which, stating the obvious, are called if and only if KVM enables its IRQ
bypass hooks.

Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 45cb9f1ee618..9c03a67fedbe 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -517,7 +517,7 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 	struct kvm_lapic_irq irq;
 	int r;
 
-	if (!irqchip_in_kernel(kvm) || !kvm_arch_has_irq_bypass())
+	if (!irqchip_in_kernel(kvm) || WARN_ON_ONCE(!kvm_arch_has_irq_bypass()))
 		return 0;
 
 	if (entry && entry->type == KVM_IRQ_ROUTING_MSI) {
-- 
2.50.0.rc1.591.g9c95f17f64-goog

