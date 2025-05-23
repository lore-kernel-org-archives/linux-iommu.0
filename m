Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E9278162
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962052; cv=none; b=nH6tXhbmQTdYYVYkEapcn9bucY0oLPjW8aYNM1gEHHEgxQnS4Sl4Pw2p3GsHtSHGSNnCKXkUe0bAkgf7nY05O9eAsQJuSXUYPq8W473MFt/uFreTc7MDfPLmeM+6YmQT3u1qoMikF78u4I5JColsZcLsDJQZpvybeN6+JmhpoX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962052; c=relaxed/simple;
	bh=MZyvPz8cErBI6x41AwT2Y1YCOuXjfCDnsgc3RV5iM38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LrUhv1neN0WPUamn7Cf9Tf/HjonG+lNDiMzgPAqtE422OEbUNQX385GFiczZ5aTA8HVKpssRGBATOppGxNtpmmXdiEQ4Dv8KuBMExkKiM9mn0qAaymBI79XB+G+wEVI+et74TyT4KCT8tZ0bZFNDRiKGRQT/Yt08aTjj+Ql+dDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXBZM0qk; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXBZM0qk"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b115fb801bcso9188395a12.3
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962049; x=1748566849; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/QbRbxgKq4IX+c52p+RG6yGaQTEP98D8xjd3vBs8mBU=;
        b=WXBZM0qkQm4l3jArPq9lURtXKGt01n+wK3HCsaHYT7hoUNqeYqTxLlJsVv3LCld0RH
         3T2Aqgl6QA79BTkLFIKNBn+eCeKfPVWqDOvY4ndyQ+iLRj6gCvQL46My5VPf3hJ3oUM5
         Wo4xAWGQyC0vBOFSTe7OhBdinijyLrCUvsCWW6sar90IhvPUw2U56MxyX/sxmsVxFYR4
         BydQrAq9GGaL0q7mRdzRNrZ9JMeDoDH8i3Tihgd41UNsXKVWkl6iIgr2ztlLBKa9xkZ4
         TFrmBT7eZlZWd1qcDOE5ax1mVFTDy3U7RDfWkaMHEkmU0DQPgvgibRym0nRQicAeUuSq
         ii2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962049; x=1748566849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QbRbxgKq4IX+c52p+RG6yGaQTEP98D8xjd3vBs8mBU=;
        b=H5pK0ONYH3asrc/afyq8olBKSmov1Ba0jyFZRj2iRw1SR46usVQCLWgsob/iRVnuLu
         ZFCP1SN8ippmRAUyeta3ZBqjDjAxVx2zUCPYfg4rxDLiMZmseYuiu5rQLtFeRfCd1+6g
         /6G36QYzM6gZaOzDTVw/gB+QLH5mR2pZboiO6cTds145B2c2nGNS338lr3DPyCpcSW7B
         nts/VsOO0D/GnChCi8yZv+cKz7LBWmZ31E3a4HUtFdWGr/wtbVEtGEPNAi0WA/VsRTUY
         zsL5udZpl79R5leXZN+sSqSsd4iXOHHJ/sH4CenBP+2cxrdL9Aq6xbSgcMMyXDluVkDh
         +R1w==
X-Forwarded-Encrypted: i=1; AJvYcCUmi9KBRkuFqvJG/Di7FCM1IbiYTQ3vKJmR0Fki6h4rI0M0rNGnzKWMCYUCfRSOWoNBONN1uQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQNBXssLt7XF9JqA/1Wi941PS+qWo55jWDaO+rEbDa76LDHjR+
	P7Lb7+iyytDQx311QNPez4MZE8yb/zShRN1LTLdCYB/cKZiq6NX4F+lvucg9qly5cLBpOGEGytc
	ytSQbJg==
X-Google-Smtp-Source: AGHT+IEoGfxyus4zW6bOW0Hkaw5yAvIEipFHaV1PyBgzP1+WYMZEtkQ5SFyRDx1RYRCGinQDFi3EhnerZLE=
X-Received: from pjbpm5.prod.google.com ([2002:a17:90b:3c45:b0:30a:9720:ea33])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fcd:b0:30e:9349:2d7f
 with SMTP id 98e67ed59e1d1-30e9349309dmr36081293a91.4.1747962049336; Thu, 22
 May 2025 18:00:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:28 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-24-seanjc@google.com>
Subject: [PATCH v2 23/59] KVM: SVM: Extract SVM specific code out of get_pi_vcpu_info()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
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
2.49.0.1151.ga128411c76-goog

