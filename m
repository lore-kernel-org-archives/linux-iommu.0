Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A409E2EBDE5
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682108; cv=none; b=f5QKHnYc4mHiigAvYqPgmuV9ROR57X9gNt8nFoUR6iZ7BCJZ3NV1ghOb1DuKJ7w9rsiVYTqteaE2+LKSMKQlcR17KJ0R/2hvzY2vqrXFM3SGOgG8p6g+/cS8XPAufjgseAYjIigaYDx5P6Rpcb/kXrRkY6cafl5F78CSdeJVWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682108; c=relaxed/simple;
	bh=r1qowrD+5mrr7O3Q5l0aT1/ECvFqb3PfiIao4Lw8ZLM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dCBd84KzrN8MU6R8OLJYU5jmrEM+T+NfwFWqoXkdKXsRHr5E6BGbL5Js02cwN5KgCGlQprUzY9YASyiGVbqFCS13W6ZZJs56klYV6sUB5JO2ZWNoU+2+zSHdgnTyjMvThSRQMq8FJTb8ismULApEvG6KQMp2ar9Q/XtxWIsz8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqztLZ5+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqztLZ5+"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311d067b3faso462296a91.1
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682106; x=1750286906; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IGf99uYfCeKKIiWjOntmH0IBPd07aaYxxPMUaWxgCJ4=;
        b=kqztLZ5+gjsJEaBBOPoAbsOfZeU3tdpTQGYZ1XaD8JEPxwit/tUATCM28LQm4AUv54
         lgt/wlttrjk51QrsOAmD8Z1Fjxma9zV5brMO298P+355U0YIZdFDLh8c99IZrIZ3sIiy
         wmj6vQn8QopgSW2veARHvTAT20XePNd+Y/hz/i+Wpf3q2y1Lp9mTo8JlazM0TBWkPF/Q
         tl1WIk885YypoUTx47iyuJGdY6dXmEId3ZqXKMKu8vmYomwmg9B3EhN2pZOXGG+YzGxx
         DPkXU6NcwaeoipheGi43ujnY2XGcwHpB0fTwI/UrWKn2q7o/Dy7PItYzm1g0KX+ABF4q
         QmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682106; x=1750286906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGf99uYfCeKKIiWjOntmH0IBPd07aaYxxPMUaWxgCJ4=;
        b=WgJeDP3UMh0VO/2ygRmFT/XawuWqAeMzMXAvJQW6UWCabjNA1jByeXWxBS0wV/QvxC
         0kjC2kHoYF1JxeiD2am78nQ4FEGb3ZVAbpj1/cXpa+y+poqAwcs21XsSCq/e9FseMbPg
         AxlwSpjPHc2VbOUutuoMtT0fA3Brj2AttMIJ1yUcVbiNXKtUGzaDOTBivws4rr4w+bHK
         XsnOLga7GgXNJdgbepAmx4XF6zBstdgxUe0ATRwHrYsJtlIVgMThcFADA6rstMlDhBoE
         3T9Bcc22nbc2pzx1ZTYoZ8qSMjY68sdwEUbYEDGY8U86AUxVKJrMHgs8t1HAMV50fUG8
         Pl9g==
X-Forwarded-Encrypted: i=1; AJvYcCUxr526zsYFiu3YljNbCdpWtwImdcSHS/Efm4Z/ZAEmS1BMVxk7Nv31O8Wo0UuVFfNmRmpzIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YykQDM9HYt2pqyt7w8Cmi2CSJFtvqZ/p+zanAE+Y6afVj4edAKI
	AqxslplehO9ANq8gaKC2JI2m8nIYWEG2qSZynXZpm//iNSPJ6HUo/OPbUeMiO/Zz2wWhUTGhce+
	amNDv4g==
X-Google-Smtp-Source: AGHT+IGG/WcYDrf0RYZY38gj5X+aWB3PmGw41sTQaNqsS8Agp4VOiMJxViIe5RHbEl0OLW/p9vLLmH6GAsE=
X-Received: from pjee8.prod.google.com ([2002:a17:90b:5788:b0:313:285a:5547])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3510:b0:308:7270:d6ea
 with SMTP id 98e67ed59e1d1-313af22d60bmr7017390a91.30.1749682105816; Wed, 11
 Jun 2025 15:48:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:55 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-54-seanjc@google.com>
Subject: [PATCH v3 52/62] KVM: SVM: WARN if ir_list is non-empty at vCPU free
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

Now that AVIC IRTE tracking is in a mostly sane state, WARN if a vCPU is
freed with ir_list entries, i.e. if KVM leaves a dangling IRTE.

Initialize the per-vCPU interrupt remapping list and its lock even if AVIC
is disabled so that the WARN doesn't hit false positives (and so that KVM
doesn't need to call into AVIC code for a simple sanity check).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 5 +++--
 arch/x86/kvm/svm/svm.c  | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index d1f7b35c1b02..c55cbb0610b4 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -704,6 +704,9 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	int ret;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
+	INIT_LIST_HEAD(&svm->ir_list);
+	spin_lock_init(&svm->ir_list_lock);
+
 	if (!enable_apicv || !irqchip_in_kernel(vcpu->kvm))
 		return 0;
 
@@ -711,8 +714,6 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	if (ret)
 		return ret;
 
-	INIT_LIST_HEAD(&svm->ir_list);
-	spin_lock_init(&svm->ir_list_lock);
 	svm->dfr_reg = APIC_DFR_FLAT;
 
 	return ret;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 56d11f7b4bef..2cd991062acb 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1497,6 +1497,8 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	WARN_ON_ONCE(!list_empty(&svm->ir_list));
+
 	svm_leave_nested(vcpu);
 	svm_free_nested(svm);
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog

