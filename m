Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30F23C8B7
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795670; cv=none; b=AHmB0SBb/k/9C87PxklhEAYpOivh6O/wzn/J6sEsO4psjnG2jiKNJoJcQRGKxk2T6y/n8dftWOg4BwcRuGgvtsTQGsDWHCc5UAqcYx/+dA2GB3CgYX1kxgitBYQ7yGqxeRmVcz4wUz5GM6TqLgcRqt/iV5tYcyGXhb5kumqjNIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795670; c=relaxed/simple;
	bh=Gs/w7b1TpQ2M7g5MgA9NNIvjCHFPtQtwURjHeBU9J9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r47tz80yvOwKYPgmE+b+pcGpxsMJhbyV8NA+4zPP8QL3BxGLlk+1gxNv6v/TomuN21wYJVPxMTeP+05Id0AYhkhNrBS7oJyy9XtbDiWHuYVKva0o2dFQvGKlZP8t+hJcfVpVjBb3lfhAU8FvKPwP/U4UHSt47MLrjRZfi/IZfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xZUqrCGJ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZUqrCGJ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7370e73f690so2789696b3a.3
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795668; x=1744400468; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PKGLHehhFYZS7RFg1K2PZNaed8s88CqZbtq5pq5GKIE=;
        b=xZUqrCGJZHJ0/VyTvdHaWUpUmAmLB+EfvpMVO4O8uVha5npMEKKninyAoxc343ghZE
         9hHMOXVn8y86ZXLqohx3DPbG57Hzc5C1y2F6/EW5lhQz5aZ/D4cGYTHTQm4NoKfeyqj/
         AmIZUlpmZ6yx9JJkFmCpgKmr1xq3PZgbSYDas3pgN8BHC8NNRD9FJ1PEjM3hQe8jrw27
         LxMBQAzGWawOimO+cEKIKfnZAyqI8PkR70neRfbWCWCs+kkuqjYDBIIrBApQRJYq6HTZ
         bzCsikKuaOKXFdLgYzaj1JgiQNNxXocFi5/PCzl3qUu3Mfkgpq0PuoKLAfW3flxF3LYd
         9MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795668; x=1744400468;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKGLHehhFYZS7RFg1K2PZNaed8s88CqZbtq5pq5GKIE=;
        b=phjr1o/VzZvj2Jo/ZU/7EnmR8WjgunEVnS00oT4tgI1+nx9sJcDVwjbdtRncFswU2I
         h/Iq+WiD9YD+R3j5Y/ZMnZeqnywcKSIul18LZ6FBuKyU8ApWgheYo2Q2KKP/MAoJbKaJ
         OS2QWWcC04LWH4rG0rSK6YCirq06ROeSoPL/hWYaDwFzsz2RaIC2IWEH64Nj5xn+c2sr
         QC11OqtZyiJyWm4Eo+m9QgzsV6ib2swlWu/v8BnGMI48R4EvqzSPhkwQD4WjdjPdVEbr
         /ou2GTFFvpMQ9ttfxY9JWDDbp8rJR0vetn4Z5Qxytn8B6xJ0mcnagATSWqNP9rdkumSD
         1yAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXewQaZPem8UeD/Ka+2oAzPwpZMLYABLNsFRjGtg/J/JWz3FOwdxB6r5zbHFGn4BCfsI+c8Rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwoVgGF0EsVlo2/sNXW32zrV9tBT8przfUEJMzK6Vyrfw2Qk0TA
	5D5KLBQ+af3LuPTeWROQejWZ6L1/Y5CC2In4ImihzzYxzreynGG0zZQ8d11HSc1xEW9QpTZpNFB
	/mw==
X-Google-Smtp-Source: AGHT+IHe6zs/5LhCfrFgK+vj2rDDG19lUEDx00Bzgp892zED1081EdFE7G+DtTelTSRWbal8s7FZTzV1M7s=
X-Received: from pfch7.prod.google.com ([2002:a05:6a00:1707:b0:736:aaee:120e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88c9:0:b0:736:6043:69f9
 with SMTP id d2e1a72fcca58-73b6b8c2c45mr719867b3a.19.1743795667980; Fri, 04
 Apr 2025 12:41:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:02 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-48-seanjc@google.com>
Subject: [PATCH 47/67] iommu/amd: KVM: SVM: Add IRTE metadata to affined
 vCPU's list if AVIC is inhibited
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

If an IRQ can be posted to a vCPU, but AVIC is currently inhibited on the
vCPU, go through the dance of "affining" the IRTE to the vCPU, but leave
the actual IRTE in remapped mode.  KVM already handles the case where AVIC
is inhibited => uninhibited with posted IRQs (see avic_set_pi_irte_mode()),
but doesn't handle the scenario where a postable IRQ comes along while AVIC
is inhibited.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c   | 16 ++++++----------
 drivers/iommu/amd/iommu.c |  5 ++++-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 086139e85242..04bc1aa88dcc 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -790,21 +790,17 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	 */
 	svm_ir_list_del(irqfd);
 
-	/**
-	 * Here, we setup with legacy mode in the following cases:
-	 * 1. When cannot target interrupt to a specific vcpu.
-	 * 2. Unsetting posted interrupt.
-	 * 3. APIC virtualization is disabled for the vcpu.
-	 * 4. IRQ has incompatible delivery mode (SMI, INIT, etc)
-	 */
-	if (vcpu && kvm_vcpu_apicv_active(vcpu)) {
+	if (vcpu) {
 		/*
-		 * Try to enable guest_mode in IRTE.
+		 * Try to enable guest_mode in IRTE, unless AVIC is inhibited,
+		 * in which case configure the IRTE for legacy mode, but track
+		 * the IRTE metadata so that it can be converted to guest mode
+		 * if AVIC is enabled/uninhibited in the future.
 		 */
 		struct amd_iommu_pi_data pi_data = {
 			.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
 					     vcpu->vcpu_id),
-			.is_guest_mode = true,
+			.is_guest_mode = kvm_vcpu_apicv_active(vcpu),
 			.vapic_addr = avic_get_backing_page_address(to_svm(vcpu)),
 			.vector = vector,
 		};
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b0b4c5ca16a8..a881fad027fd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3896,7 +3896,10 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		ir_data->ga_root_ptr = (pi_data->vapic_addr >> 12);
 		ir_data->ga_vector = pi_data->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
-		ret = amd_iommu_activate_guest_mode(ir_data, pi_data->cpu);
+		if (pi_data->is_guest_mode)
+			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->cpu);
+		else
+			ret = amd_iommu_deactivate_guest_mode(ir_data);
 	} else {
 		ret = amd_iommu_deactivate_guest_mode(ir_data);
 	}
-- 
2.49.0.504.g3bcea36a83-goog

