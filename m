Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DFC2DFA55
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682061; cv=none; b=SD9wAKvYJn5vo+YgXSbr10780EyHkKuAa6R4nfaHOVnZBLj/6eJYVesRnhZP3DTqatVEDQpcAAilZ2EmCrfUTAlyy88wWBSWrBiq1/EVD9hTcSlOtadSakGKv2FnPSDvQsoAGj2SzHsDJL4FejBg6z70XsnZyT1H0NEy8U77LlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682061; c=relaxed/simple;
	bh=DGvP6Zuj2UF928rFFdkcq+ypjwhRo7X5XKRNjjR0TU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r5B/pgaJrpuDxVfb+tpUqwSXNX13FdsVzsQazT/vPmSq0aBt4ZHwFWTIWNPJ+qpq0ceFWOdPgAt1FzKJWv3pfveduRVEpwft1APBQYcOLxpiqhdBFbzZlGcY9JFY1gwen9SaTXoOddkRm2LbRK9X41JjjYXjFhNgSfZXSVEHyDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GEcXSgnm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEcXSgnm"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7394772635dso247724b3a.0
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682059; x=1750286859; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EWlaEFL1PUnGvKov0qrFcR2EuojVTo0yUVeuiRnl1MQ=;
        b=GEcXSgnm5CDSXhgCFxYvN9ZUMxmNVlnHH331XilXBkJ8/W5o2m2dav7x6nCVcXrUMF
         fllij0o7VMuSydbFrywPQa+FnhP8q/rY6lVAub4qUG2F9k5YuU0+KoWQetkdrR9quUme
         rDz/26fCgvHAwbURbFYv82rHePwjv98Sp0hhWRvPrnMLjRA2RwP/CWooHYbFYpBqIIeK
         3WQALewHC9ZabRMBqrPwrqGBy0Tohvj6CHEursQSGgAkhCN906/8oYvgjqhoggKm8Uwy
         cwq5SE1tlfl9vv4URBTqySDJqcRZe3iwM/0o95GHZfZ22Q4wmW9d8GS1Lk9kNii0nvxb
         fTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682059; x=1750286859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWlaEFL1PUnGvKov0qrFcR2EuojVTo0yUVeuiRnl1MQ=;
        b=KcxVB+u4s3d3JsbC9KjYimSqFzJjbyNrwF6fTHcPLc6BTJkhKtrlYIgjQT9WW95w/y
         y05Id9H8Pyw9KUKZluGWxqfaohnRI3Clje/D0mntPHRun+QL5oaeK0yCiIx2HDS+24x8
         8uAFs84Z/70u1T9qozIT0my/lFBwksL9N+JR5uxfaVEwOqFebo3Z1cWTZQKyN7Am5OSA
         cNWT9mp7kUek/cbYdBLETA3WczEpBiiGL6lLnmdlienVwdTHCktFDpPjfqSyzgzSe5fT
         0OlrR1ObzPlnSeVniOmhGJwogQpLbhY/nVvj6Cko8vt2uwHsZlXEJHTVv88sR25T8PMG
         yLbw==
X-Forwarded-Encrypted: i=1; AJvYcCViGCt7KViOU6CsiIAAr7CLLo1JC8wa8AOL6fcadnSpSMb/s5WUmPkgX7E9gUN/NhFVC5n54Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw98vR2yscuioAMLX0MV+7dzV53NZni90/jILLTpPpzJREdpk/A
	C5ZMbVnH49c/UX7sZMMv+d8qUECYqfEfUMf0R3evxLGy0C9T0duvN81QRp1e5GdQ1WTH9drEw7q
	Ny2sELg==
X-Google-Smtp-Source: AGHT+IGqrnoO1KrxPHkw7mtKYmJwMGPuKTrPb0AcYQOuUunb5B6w6dzsz0HfUlLTGR+LG8OGb1BWB2PGJ7s=
X-Received: from pfsq2.prod.google.com ([2002:a05:6a00:2a2:b0:746:25af:51c4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4095:b0:747:b043:41e8
 with SMTP id d2e1a72fcca58-7487c2afac6mr1379741b3a.15.1749682058654; Wed, 11
 Jun 2025 15:47:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:28 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-27-seanjc@google.com>
Subject: [PATCH v3 25/62] KVM: SVM: Extract SVM specific code out of get_pi_vcpu_info()
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

Genericize SVM's get_pi_vcpu_info() so that it can be shared with VMX.
The only SVM specific information it provides is the AVIC back page, and
that can be trivially retrieved by its sole caller.

No functional change intended.

Cc: Francesco Lavra <francescolavra.fl@gmail.com>
Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index a83769bb8123..3bbd565dcd0f 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -816,14 +816,14 @@ static int svm_ir_list_add(struct vcpu_svm *svm,
  */
 static int
 get_pi_vcpu_info(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e,
-		 struct vcpu_data *vcpu_info, struct vcpu_svm **svm)
+		 struct vcpu_data *vcpu_info, struct kvm_vcpu **vcpu)
 {
 	struct kvm_lapic_irq irq;
-	struct kvm_vcpu *vcpu = NULL;
+	*vcpu = NULL;
 
 	kvm_set_msi_irq(kvm, e, &irq);
 
-	if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu) ||
+	if (!kvm_intr_is_single_vcpu(kvm, &irq, vcpu) ||
 	    !kvm_irq_is_postable(&irq)) {
 		pr_debug("SVM: %s: use legacy intr remap mode for irq %u\n",
 			 __func__, irq.vector);
@@ -832,8 +832,6 @@ get_pi_vcpu_info(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e,
 
 	pr_debug("SVM: %s: use GA mode for irq %u\n", __func__,
 		 irq.vector);
-	*svm = to_svm(vcpu);
-	vcpu_info->pi_desc_addr = avic_get_backing_page_address(*svm);
 	vcpu_info->vector = irq.vector;
 
 	return 0;
@@ -845,7 +843,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 {
 	bool enable_remapped_mode = true;
 	struct vcpu_data vcpu_info;
-	struct vcpu_svm *svm = NULL;
+	struct kvm_vcpu *vcpu = NULL;
 	int ret = 0;
 
 	if (!kvm_arch_has_assigned_device(kvm) || !kvm_arch_has_irq_bypass())
@@ -868,19 +866,20 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	 * 4. IRQ has incompatible delivery mode (SMI, INIT, etc)
 	 */
 	if (new && new->type == KVM_IRQ_ROUTING_MSI &&
-	    !get_pi_vcpu_info(kvm, new, &vcpu_info, &svm) &&
-	    kvm_vcpu_apicv_active(&svm->vcpu)) {
+	    !get_pi_vcpu_info(kvm, new, &vcpu_info, &vcpu) &&
+	    kvm_vcpu_apicv_active(vcpu)) {
 		struct amd_iommu_pi_data pi;
 
 		enable_remapped_mode = false;
 
+		vcpu_info.pi_desc_addr = avic_get_backing_page_address(to_svm(vcpu));
+
 		/*
 		 * Try to enable guest_mode in IRTE.  Note, the address
 		 * of the vCPU's AVIC backing page is passed to the
 		 * IOMMU via vcpu_info->pi_desc_addr.
 		 */
-		pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
-					     svm->vcpu.vcpu_id);
+		pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id, vcpu->vcpu_id);
 		pi.is_guest_mode = true;
 		pi.vcpu_data = &vcpu_info;
 		ret = irq_set_vcpu_affinity(host_irq, &pi);
@@ -893,11 +892,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * scheduling information in IOMMU irte.
 		 */
 		if (!ret)
-			ret = svm_ir_list_add(svm, irqfd, &pi);
+			ret = svm_ir_list_add(to_svm(vcpu), irqfd, &pi);
 	}
 
-	if (!ret && svm) {
-		trace_kvm_pi_irte_update(host_irq, svm->vcpu.vcpu_id,
+	if (!ret && vcpu) {
+		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id,
 					 guest_irq, vcpu_info.vector,
 					 vcpu_info.pi_desc_addr, !!new);
 	}
-- 
2.50.0.rc1.591.g9c95f17f64-goog

