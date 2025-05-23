Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD6122126D
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962026; cv=none; b=i4ksBxXeFuDcJBTrMOcil+4Ur5U6L2mRjHZqLsVnD7Blx/G90gesuJTgYPOTOPnjmPcgBbWHuE3A3FPf2DLIRorM29Z5HXQwYbwxnZ2t+kYNgxCcsQ76iyYAmOvvxQxgLAY5O+4FQu5KNkvBtvHMpgBQK20mDMyFtESTwnrkB0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962026; c=relaxed/simple;
	bh=5virlWR1yyo4ENo07jjtWumRwvWVsFnmiSwna+Ulx/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nOzVDZ0hoGqQZmofw3Az8wylNSmxyvz1OFbD51YHMfThJ1UKVd0Sw4VP3ZYfKi412H7oBfOYVaeamc6rXyhjuD/9JvURON/qh5DTWrt1pWtSRdYuV/G/86lxAJik07CUZs2QsJOUOrexYe6F99v5jRn+SdZBH4zfVAq1oDCZaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X98PE7rf; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X98PE7rf"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b26e73d375aso8482797a12.2
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962024; x=1748566824; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sR1Ojn0ohf6sLFNiGoBcbnqontvMAHQrTSIwGVP+aHg=;
        b=X98PE7rfvs3hKpaM7aSW6A2xOfemZAeEeuWjT0LqenBK0hPU4rkXEmuIffilOWuOZH
         QETpBXj6JebySzeI1O/ujm7hUNJR16V/FFLK4QiKnEwHWFTQElaXyPdPkqBf/Hj07DPE
         Pjjg4rbSaCc9+RojfBAnurDBqEXd6zN/q5jpnco71CZXzSNcEnyHUn4q7D7NGhu/GcYa
         9qYOf36XDatzJCqCrneYz+OjBczUeyC0qyb3ufpW5vqEI7mYIRslBRfVyJyh4ZYPDNre
         ouzFlrYSu6UfulII9+uuMZcWAu5ieTMidbUhdho91lmFrqNEa3PU6hA+qjvLNHUBXL3/
         dDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962024; x=1748566824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sR1Ojn0ohf6sLFNiGoBcbnqontvMAHQrTSIwGVP+aHg=;
        b=H7KqYUBs/TRht7wwX/ciyxEviKGvAbXcf1h4z79Bp/JPVQUygzQlSxU4YRBS1+vxm9
         rpMVpyOPr8cOLIG2qnRsjQb8aw8H8nIkPl2G4YID2RgiJ948wvOEiKNjf1dxi3M5Wn52
         FW34VXdRpyRPIQ+UXuHRlSAMgAQhT+LWIx/5EaZZRvLtYA2e97P9YbIEKFmgz+/YKmJf
         Ep5ve29UDov/zWUa/xC/7FOuqGWA5ShQUWe0ZyfHmK8x1AspjAssQONgm5b17mqqR784
         pwNknOQoR47J+UuxMN53emD3meQ0PcEJwWCH2misRj4fqB7IIbtT/SphwRaoiV5NcAAY
         cfIg==
X-Forwarded-Encrypted: i=1; AJvYcCUqV49CG8HbnnqLxnnLYhySvNJb43gfjHIrJ8oE+AmUaeP1FD35ApRSm6yN7Q6iDt/xWPdgrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjBW3vTFIL6qYfj3k67n2pFG2Jk2HJADwUdWbAjNw4i67XOk7G
	j1JVZq3Y/ZYQJ6awbGs7P5WlKHhUi3pOB9jzPTHxEQDLtOU4NvApbEG+glN3uua7NWxIq8CJZxu
	tk4vimQ==
X-Google-Smtp-Source: AGHT+IG7kjhiAPt1VbCwrIgMAeCdVOr8h4q7zUqtkF3UVUBioDojmu3vxag2uDQB19/1vOdzds+ONUhBcgo=
X-Received: from pgar17.prod.google.com ([2002:a05:6a02:2e91:b0:b21:868e:36fd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9012:b0:1f5:9175:2596
 with SMTP id adf61e73a8af0-2170cb260edmr38962920637.13.1747962024381; Thu, 22
 May 2025 18:00:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:13 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-9-seanjc@google.com>
Subject: [PATCH v2 08/59] KVM: SVM: Add helper to deduplicate code for getting
 AVIC backing page
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a helper to get the physical address of the AVIC backing page, both
to deduplicate code and to prepare for getting the address directly from
apic->regs, at which point it won't be all that obvious that the address
in question is what SVM calls the AVIC backing page.

No functional change intended.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 4b882148f2c0..c36f7db9252e 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -234,14 +234,18 @@ int avic_vm_init(struct kvm *kvm)
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
@@ -305,7 +309,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	BUILD_BUG_ON(__PHYSICAL_MASK_SHIFT >
 		     fls64(AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK));
 
-	new_entry = __sme_set(page_to_phys(svm->avic_backing_page)) |
+	new_entry = avic_get_backing_page_address(svm) |
 		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
 	WRITE_ONCE(*entry, new_entry);
 
@@ -845,7 +849,7 @@ get_pi_vcpu_info(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e,
 	pr_debug("SVM: %s: use GA mode for irq %u\n", __func__,
 		 irq.vector);
 	*svm = to_svm(vcpu);
-	vcpu_info->pi_desc_addr = __sme_set(page_to_phys((*svm)->avic_backing_page));
+	vcpu_info->pi_desc_addr = avic_get_backing_page_address(*svm);
 	vcpu_info->vector = irq.vector;
 
 	return 0;
@@ -906,7 +910,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			enable_remapped_mode = false;
 
 			/* Try to enable guest_mode in IRTE */
-			pi.base = __sme_set(page_to_phys(svm->avic_backing_page));
+			pi.base = avic_get_backing_page_address(svm);
 			pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
 						     svm->vcpu.vcpu_id);
 			pi.is_guest_mode = true;
-- 
2.49.0.1151.ga128411c76-goog

