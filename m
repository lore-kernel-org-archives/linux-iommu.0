Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7F629670D
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962081; cv=none; b=J7i/B0x3LXCKSzWvN13byTtD4ZvVXGelAYTTV7Gu+FMeQ+Sck16aJ1g0iKZGeRwT7GM9j15LhaTukg+oFwmIfOdt2Lkeyicux6gjNbnx3gTCmzIUXYYYralYtB8V0DS1VaaWJSztbo6MSgbaugH/cNjS2qADswp45HFUmObpxmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962081; c=relaxed/simple;
	bh=xeyn+RxaGBxwSWBZQAPqlCwxh3rYfve9eQNJaUpZTwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LGhQvcjwqycYS3qvAs+b2CZ1gQYilmsoY6D7rOURSECNJ2Rz36qUJ6L1fDlU/Rb+kH5MlCX1CB6LHl5G4Iu6Zgb2EQF4629PanhDiGnLl7WPFIlsmu+s9NgP7/6fVjSNHUBbOaYz+4pkS9SBcUfZkKAQudohfvGGBTONwvLCCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PyBujsaf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PyBujsaf"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30ec5cc994eso4818190a91.2
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962079; x=1748566879; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sv4CvuHYTDrFzn739/UZWBkxNDDiJssoZ41UjvZmRoU=;
        b=PyBujsafoeD+7YvK7pjEYJtzFWbJxigLmg/+qw/Hz5Zzd4SfSyC/b069d13Bpm2axn
         w7qs/ajduhw56CWI2Tceb4mPhsP8NDk3jZSSA7sJDDOwAhxjtAtOqbnPj6m9Gs/lIsBS
         G8XR091v6jutJMMx6ODWmD4c9LairU7CfDuuOg3BJRvuYZDR9BONRwuc+gaj+Ut2uem1
         5488QRJtZi6IlR/sqLhQPmGQEdx0revdeu5vRnc3Xuv4Hak81FG3wLZYoPRHg+f4GqQJ
         SMUoUVNVtv+gEZlSrZ4pDX89WZLLFu6bouEuPUS8NzS/wSeR+Nr2XS1g+clLHrbZZ4pE
         bSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962079; x=1748566879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sv4CvuHYTDrFzn739/UZWBkxNDDiJssoZ41UjvZmRoU=;
        b=chiJDNVJBSA2G5bQQRX2YGRcCDMK1GzvYheHXTnfRjbkVQfcwYWUS6V9hzxAF+Utn9
         eGfmC0Zw1tBIkIRViwzb4s5rqokaejjoN2VhgLbIHkSbX3Tb3HvAuMUnYijBxwFWRwfY
         8H/9AZPpzg6WbwXyfmyMEjZhzAszw6NihcU7bNmCSX+iM4vkYW7ipEjSPv0sS5lOovx/
         QwG8UrQYOHtTaOS9AmbI1F1RIuyxnv4LT1W6FnKjv1cN5HKk0abvkvZXzvE4h2gNJ4mJ
         QcgOcEqVJSmgslzbfrtDvIg1vLloJ3+FFKGJZmVPew3zjJHJPRTiQOwgeBDAQQzFOKc6
         JrTA==
X-Forwarded-Encrypted: i=1; AJvYcCX0r/rAOB1JMAYVg5a2V0ZgVGJg7ySpmzhrKX3yR5fiwHg+Sml5GaQgBdq/KARVxKXhhLi65A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzmf3yZ5sX/KnZEE3roICjDH1f7/ZTJu762kkcEEeMnjoghw8wf
	/Hc9u+wMkwkVuAyiktq3orcURFF7c2WYrEBpnTFpAiXQqZcJB0aznXB0NafTElApoa8EzncleT4
	TX4Gp/A==
X-Google-Smtp-Source: AGHT+IFmimbvYwJ03lxstnhA7yCM94NNBPUvAkLOj/+0cXnXxDC/143/hDROJrXgXM94OCkZkRbyoWrpgOE=
X-Received: from pjbsu5.prod.google.com ([2002:a17:90b:5345:b0:30a:4874:5389])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:37c4:b0:310:8d73:c553
 with SMTP id 98e67ed59e1d1-3108d73c662mr13416575a91.10.1747962079117; Thu, 22
 May 2025 18:01:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:46 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-42-seanjc@google.com>
Subject: [PATCH v2 41/59] iommu/amd: KVM: SVM: Add IRTE metadata to affined
 vCPU's list if AVIC is inhibited
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
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
index 16557328aa58..2e3a8fda0355 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -780,21 +780,17 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
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
index 718bd9604f71..becef69a306d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3939,7 +3939,10 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
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
2.49.0.1151.ga128411c76-goog

