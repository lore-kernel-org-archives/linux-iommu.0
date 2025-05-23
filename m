Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F8A2D29D8
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962090; cv=none; b=RUA9qvQ/LQ/bNfogJEBPpXEb+bKWgy+LC5wL9A2N043uzcRZb8NqYu2Wi/EzjvEosR8GJXDvjxzq6OiLLgnk0PTni9THXfZVc/s4SX00b91aIoPmf18P2YTSyLO/9lL2aZXdAHarNfRbV9kiDv9IhvV3pbOUvVROqCVBdU4c5o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962090; c=relaxed/simple;
	bh=axZocm4dvPcmbiB/ZwqdO3wy7w4x+of0K0yBbiaqjq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fbF9zj1zPmTOjnA9Xy70XbzTMciERT99e0Y1BmuvGOe4R67/RF6VUhkgFrz2LBQ+UZT8dQ3AMn1dA+cwhNHBMW7yTGmIorzIOo+9PnHXxTPl5uwlft3WD8UAS96B5WAbHom/sDRin/YP718cMjmIY7oXWpDLbWych0ZKWG7I8oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEBevQ98; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEBevQ98"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-740270e168aso7332027b3a.1
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962088; x=1748566888; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=i45otOSm+TkhMTHaG59UwoG0Q0Wz+ReqP6qkOsiZs3I=;
        b=AEBevQ9801xABwSVQwew2fb9O6Nz0qmPdqNvaKauEfK7Ajv+p4lgKF9g41bfYoC/k7
         o59etyECyB/RMyToevuXGuGv/5ozCC5zifz2t9bSLRNPLEznDzvS+A+Jk9iHvxpgEok6
         wgYLUurE1zK1XXOrPQ1vTKT6iX9nU6O6i6o9Bp6r8ieWcGi9/OSNJHiKo0GNvmW0Y1OV
         QAF9A00mwkrPcSBa0v+lXH+Mdp/qXDylE5mn174QVzUh888g0MOL1H9PgVgbwVx4sYz7
         IaFytMjiRrQ9uhxYWjnYeFIPfcRUBTjjUPBDhILkVCC8gIO+sScJFtPw62D+FFcY3fTF
         dSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962088; x=1748566888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i45otOSm+TkhMTHaG59UwoG0Q0Wz+ReqP6qkOsiZs3I=;
        b=TgtUqWh0xIA1f1Xl0pM07QFQ5HaImTJ/+FczZSde/gPw7e/hsCPLpvEO1umhxpcQkY
         8GVyMS8mHzPVeZ92hpAyTeJwcmLHthQeevO4DxykGL92Ei7a+8bMxK3o7wEoWRHEc0xA
         PClqtphZXyBFdLUrevfv8oQuUfvtsxp1hsHv8Qm9dUrdBxuLUrBlaA5dDHQcC0zp3C6O
         +V6JI7riUdfPX7gI+vvUxpqHHWJDIE7WYnkcRg7jhIc5wZbb4/P+1GbRifQqedDh1O0B
         rN3lfj9zW7Sx+Vh9p8IOPnZ0pjr73etxw9tPTVHb8vJE/YOGTJdv32C6az4RuVmDds3P
         Daqg==
X-Forwarded-Encrypted: i=1; AJvYcCVLEK9QFLBSLKjlcALDuIQMDXlbP8tnV1B7RqLosrVLKLMasUcS9ibweARKZzKSkQoTbGIVWA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw77LnKeZ+CKcYTI8NKww5Nfm2xH1wx0BUBYKssBlgLMni1MDbi
	Qo/Xd9UP6V5nxvac14LDOEeWAYY1yVp1JvRAHVpgzOI3OGsLkGKW2L3JSf3vglIkANuKUUFq2Jp
	b0W4DVg==
X-Google-Smtp-Source: AGHT+IGKXUDv5+WdC/0P78GDw78LzUL5LFq8JfcqEQP/cHtEYBO78G4z6PZ0oz9z2Xbic1SU/rHQzxKGAu0=
X-Received: from pfbgx21.prod.google.com ([2002:a05:6a00:1e15:b0:741:cbad:dafb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:928c:b0:742:a77b:8c3
 with SMTP id d2e1a72fcca58-742a978715fmr38003734b3a.4.1747962087855; Thu, 22
 May 2025 18:01:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:51 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-47-seanjc@google.com>
Subject: [PATCH v2 46/59] KVM: SVM: WARN if updating IRTE GA fields in IOMMU fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN if updating GA information for an IRTE entry fails as modifying an
IRTE should only fail if KVM is buggy, e.g. has stale metadata, and
because returning an error that is always ignored is pointless.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 24e07f075646..d1f7b35c1b02 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -834,9 +834,8 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	return irq_set_vcpu_affinity(host_irq, NULL);
 }
 
-static inline int avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu)
+static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu)
 {
-	int ret = 0;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_kernel_irqfd *irqfd;
 
@@ -847,12 +846,10 @@ static inline int avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu
 	 * interrupt remapping table entry targeting this vcpu.
 	 */
 	if (list_empty(&svm->ir_list))
-		return 0;
+		return;
 
 	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list)
-		ret = amd_iommu_update_ga(cpu, irqfd->irq_bypass_data);
-
-	return ret;
+		WARN_ON_ONCE(amd_iommu_update_ga(cpu, irqfd->irq_bypass_data));
 }
 
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
-- 
2.49.0.1151.ga128411c76-goog

