Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF040224890
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795614; cv=none; b=di5tRXSB/i5wHMddzDHf5zgm+V/duGU16RnRZszc2gwPr/M6uHd526JDNKTzIBJnKX2DGA3c/wwJQmTSP+hHLChV8RGaVkXXVTfDuQattPKxhADVw0jpF/K3DL+rZRlwm+5KoCUdrASPshZiDSfSboCC24k1MNG7zU69y6hMVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795614; c=relaxed/simple;
	bh=Ny0M/z6O5m5Da4fXxsggB+MSjOkMNLlZ/4JPgRgDcHg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RtPnfTbT43JdRGDQ/dND1j+GhwYKxTbPlJI2uKW4XlITt0Ua8DaNq56SLfC/Wge/axZiXQ86tF4l8YTgZMY/Kd/DxRAcp+KQxv6Z+9lM+enO0HFAPuI20E353kd41+z3aqLsPgcnbbGf6/iMRL7HQdbcdAxv3iYcFFHC45oPoQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mT0+M2+z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mT0+M2+z"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736d30d2570so2142186b3a.1
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795611; x=1744400411; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=V9WmlXKIl3pG/vGS1FFPkbRmx6wE+LY/6fyIbxpmuWU=;
        b=mT0+M2+zyqZ1JZovkvC3OVl7HnydTmStnYRs1DsvrnL3Xsfyx9C1hYLDn+wHoB7xCl
         L0oDyPWToSP0SUyvGi1t4wTjjvoEXMnh5Hwe33FCFGlsy8kSypkIvqbtor9tDdoBTmKC
         af6tONC5HnG5ClKbEwSdGmUXS/Vua09iBpX3WtwtYYakQHoMU6U0G11d7juZAFmGH1jO
         ZeMQ21Oi2MHGjAQ449aW03FfE7GJF3epWAcaaF9aKJFOhw0ZFuFy8zmlCPfdev7mPDMQ
         i+wcIGlHIhcpLeBSQopoDFU9469HgQiQNt2hl7QU8qNftRNgyChAi6FkY1Fo22px4z0s
         xXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795611; x=1744400411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9WmlXKIl3pG/vGS1FFPkbRmx6wE+LY/6fyIbxpmuWU=;
        b=O19Xxh/Mdz5eaBSSOllrvOTD3OIkproXf9D8ua558MLEjfe8as32gyP8h9zoNeh+sf
         JWENDmXvoH3NRPau9LNk9dIkMj02xBCEkJjdyuePuNSO/9A0wn/bdrSHY7rCmen7AV+/
         iisrdwOHmQpy2+UclMRcr07hBK7Jj8P7WwnFWijnMEDc73wD8UCgl8jeuv3iYgD6nSgM
         iZJyMARJY9HecxpXtwzcRziXxQCDx4XL2NBQfz7s+zTuva2rIidRqL9aGN9nqOOpXtMX
         45+JrtTjdyuLRjhF0Eqp6nlxlfohcc+QKnRDJekGr59jENBOusLUGgxp0EVUjrzM+VTP
         gNBw==
X-Forwarded-Encrypted: i=1; AJvYcCUClFMwkqRxa5oIB4NDCa2MbKxfti9bGu88XQnX8IlpS2b9o+YgNskMfPe89iK/R5hfXmjmDA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzk6PpfZ4BaV0KsWyFjxnh1f+nhiAoCMVN6feMP1syYO9h+Wkk6
	9olaGxkFSE7XLBDqhmgl/4syP0JO1hyT+Igxb25ILnsFMAHcY8C+laTcctdAod4wzJUbgzveudc
	FSw==
X-Google-Smtp-Source: AGHT+IE27zbdMk+l2PrFIwUw1sH9cB4J4cN7CaOyjTIEfbMCPGg6FI6XQmyQTP9lTfdwAAei1fZlh+dM+/8=
X-Received: from pfbjc3.prod.google.com ([2002:a05:6a00:6c83:b0:736:4313:e6bc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:888c:0:b0:739:4a93:a5df
 with SMTP id d2e1a72fcca58-73b6aa6c7c8mr897212b3a.12.1743795611081; Fri, 04
 Apr 2025 12:40:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:29 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-15-seanjc@google.com>
Subject: [PATCH 14/67] KVM: SVM: Add helper to deduplicate code for getting
 AVIC backing page
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a helper to get the physical address of the AVIC backing page, both
to deduplicate code and to prepare for getting the address directly from
apic->regs, at which point it won't be all that obvious that the address
in question is what SVM calls the AVIC backing page.

No functional change intended.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index f04010f66595..a1f4a08d35f5 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -243,14 +243,18 @@ int avic_vm_init(struct kvm *kvm)
 	return err;
 }
 
+static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
+{
+	return __sme_set(page_to_phys(svm->avic_backing_page));
+}
+
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(svm->vcpu.kvm);
-	phys_addr_t bpa = __sme_set(page_to_phys(svm->avic_backing_page));
 	phys_addr_t lpa = __sme_set(page_to_phys(kvm_svm->avic_logical_id_table_page));
 	phys_addr_t ppa = __sme_set(page_to_phys(kvm_svm->avic_physical_id_table_page));
 
-	vmcb->control.avic_backing_page = bpa;
+	vmcb->control.avic_backing_page = avic_get_backing_page_address(svm);
 	vmcb->control.avic_logical_id = lpa;
 	vmcb->control.avic_physical_id = ppa;
 	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE;
@@ -314,7 +318,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	BUILD_BUG_ON(__PHYSICAL_MASK_SHIFT >
 		     fls64(AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK));
 
-	new_entry = __sme_set(page_to_phys(svm->avic_backing_page)) |
+	new_entry = avic_get_backing_page_address(svm) |
 		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
 	WRITE_ONCE(*entry, new_entry);
 
@@ -854,7 +858,7 @@ get_pi_vcpu_info(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e,
 	pr_debug("SVM: %s: use GA mode for irq %u\n", __func__,
 		 irq.vector);
 	*svm = to_svm(vcpu);
-	vcpu_info->pi_desc_addr = __sme_set(page_to_phys((*svm)->avic_backing_page));
+	vcpu_info->pi_desc_addr = avic_get_backing_page_address(*svm);
 	vcpu_info->vector = irq.vector;
 
 	return 0;
@@ -915,7 +919,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			enable_remapped_mode = false;
 
 			/* Try to enable guest_mode in IRTE */
-			pi.base = __sme_set(page_to_phys(svm->avic_backing_page));
+			pi.base = avic_get_backing_page_address(svm);
 			pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
 						     svm->vcpu.vcpu_id);
 			pi.is_guest_mode = true;
-- 
2.49.0.504.g3bcea36a83-goog

