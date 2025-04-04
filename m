Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E497224B0F
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795615; cv=none; b=tnWhPFBWJWjij2gPUgBgRWaQDhBBKqNOR7hVR5AiESzCH65YS0JSt8bihmmx6hu39TsCwjcuoUVN78qZkUeLe0G5NRg3RFF/+ExqO+kBICjw1ny0dt3SNpwFa7r25kuE5C6Z8zkWHky/RzGw2WHr+ZzFlHl38n5E2YrxOMQB+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795615; c=relaxed/simple;
	bh=5nhNidq5kKCw8cPZzC/2EhhNf9DP5bsK6q2EHVi+AUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MYeUfHGOJE6YViq1p6WnGsULEC77oi7l3pGKrqcLfz0XfF/JO27ivwkhMfWURWF8h92ViCLyENEm6hHoELemYDbEF66eISU5c4Gsc+rPQOg2gC7R5TL14eT5kiRVqpCUHMgFPj6dZHsUBznd1d1xPzjnAZMB7lsPjHdEFwOhXxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hbpwOs7x; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hbpwOs7x"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736abba8c5cso3046447b3a.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795613; x=1744400413; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7R6CjC9nxAlVYVI0vNC7khUHTwDmf+yRrkIu6OvCEfg=;
        b=hbpwOs7xM3r2JkvmEL5Ug9iQaoZvW/inEyd1Nk7nXxyD1mRipPBxfAFw6cXSFapB6s
         kGBDvAlYgltq87RFLLP4xzhXkTA+oBcDQre2GW52YIlVPDkJ/LzZjURXfp9gTEOEMZya
         SX3DgHSfr+c5B0kZdjXNj1pkSvj5WuerX+B+ovSZCKAV1Mf2i0wqWoX7NwtLyE8nkQ4C
         KzVo6vDGJaKfVQz/w+DdUHTQmuCHlemCpYyPISu0iMZvjtAhhLwevmPs5luIFBmNsSwn
         HrCbJMTEWn7iOL/xyO6JGs8yDzFFhM9LAMqEeuXfhYk4wCo6l4cfmUpA2/RgaVY0cgqN
         PpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795613; x=1744400413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7R6CjC9nxAlVYVI0vNC7khUHTwDmf+yRrkIu6OvCEfg=;
        b=sfSoaiQ80bxyZxn37ZgX5kr3/dry4Z/2zvc0O/4J/4LVeBj9mtlXolPDH005y6ZPkT
         qpvNaZ+JEfd8iDjmsuHfmmk4d4CcFAYl8wSBX5BY6hxRonIqEmI2IrkxrffiQo1EWA+g
         /vLwI8tkZ+O910C1A0cYO8lfvPzpR8HF7R8ElzE2f6gjccVOyzmxose/1laZf9dWuf68
         VTd+GddYPqs5fBT7wImZxjzgwJrt3fvhY8Xokhb6WQwPB8igUSTE2QxxsvI0MvnjGWbb
         LeDCis+DtKbFdoxyNLPJzszmWMOp4axN5ksL5CYbtwOoP8b+cEZXZ71t6NBODITb4vq+
         903Q==
X-Forwarded-Encrypted: i=1; AJvYcCUd6Zwb7hyBJ0GlDGmCBHyfRw/q+zyl2gJaG1CKrLhz2SZA5mXLNqFiOHzICwjvkoeWjGj/Xw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrvdGAnUifBgC34cFfFS1UsC8a8jmPwX9qn+WpA1yZszdcvYD6
	ovnjMp+dy0HvdO7y2BR5b4ndCUaPOwUjeZ/t5H2xVGTucjXViXmXvZCkqKQAmqncncBFNBh+wOx
	cmA==
X-Google-Smtp-Source: AGHT+IE1EIppngaCdboWmAsyGLdJBGl6DmfjRI9oduZtmRDlzdb3XCSaEM1nhSyczDVhV3HThe+yTT0lId8=
X-Received: from pfblm21.prod.google.com ([2002:a05:6a00:3c95:b0:739:45ba:a49a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4606:b0:736:592e:795f
 with SMTP id d2e1a72fcca58-739e6ff6b02mr4668862b3a.9.1743795612853; Fri, 04
 Apr 2025 12:40:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:30 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-16-seanjc@google.com>
Subject: [PATCH 15/67] KVM: SVM: Drop vcpu_svm's pointless avic_backing_page field
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop vcpu_svm's avic_backing_page pointer and instead grab the physical
address of KVM's vAPIC page directly from the source.  Getting a physical
address from a kernel virtual address is not an expensive operation, and
getting the physical address from a struct page is *more* expensive for
CONFIG_SPARSEMEM=y kernels.  Regardless, none of the paths that consume
the address are hot paths, i.e. shaving cycles is not a priority.

Eliminating the "cache" means KVM doesn't have to worry about the cache
being invalid, which will simplify a future fix when dealing with vCPU IDs
that are too big.

WARN if KVM attempts to allocate a vCPU's AVIC backing page without an
in-kernel local APIC.  avic_init_vcpu() bails early if the APIC is not
in-kernel, and KVM disallows enabling an in-kernel APIC after vCPUs have
been created, i.e. it should be impossible to reach
avic_init_backing_page() without the vAPIC being allocated.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 6 ++----
 arch/x86/kvm/svm/svm.h  | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index a1f4a08d35f5..c8ba2ce4cfd8 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -245,7 +245,7 @@ int avic_vm_init(struct kvm *kvm)
 
 static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
 {
-	return __sme_set(page_to_phys(svm->avic_backing_page));
+	return __sme_set(__pa(svm->vcpu.arch.apic->regs));
 }
 
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
@@ -290,7 +290,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	    (id > X2AVIC_MAX_PHYSICAL_ID))
 		return -EINVAL;
 
-	if (!vcpu->arch.apic->regs)
+	if (WARN_ON_ONCE(!vcpu->arch.apic->regs))
 		return -EINVAL;
 
 	if (kvm_apicv_activated(vcpu->kvm)) {
@@ -307,8 +307,6 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 			return ret;
 	}
 
-	svm->avic_backing_page = virt_to_page(vcpu->arch.apic->regs);
-
 	/* Setting AVIC backing page address in the phy APIC ID table */
 	entry = avic_get_physical_id_entry(vcpu, id);
 	if (!entry)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 294d5594c724..1cc4e145577c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -301,7 +301,6 @@ struct vcpu_svm {
 
 	u32 ldr_reg;
 	u32 dfr_reg;
-	struct page *avic_backing_page;
 	u64 *avic_physical_id_cache;
 
 	/*
-- 
2.49.0.504.g3bcea36a83-goog

