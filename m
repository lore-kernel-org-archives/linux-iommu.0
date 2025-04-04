Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B70424060E
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795680; cv=none; b=pPZGU4rU6WhPxNbQojQw9C7T19ke5YjmFCKZFgzorWLX5j5GmNSvpH6s6ycXlyd4qs17Fc6jvjh9yBnN2HDydYNsPV8bbC+YwjQdP2+0mObZtqRBJGhyQQnCgRoUqUAbvgtm7PGeHFt/w3X5LvBeL6hMqe59FXBfafJKYpW/Mv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795680; c=relaxed/simple;
	bh=pUv+Xc96YlFs/6EQOBDk/1ZAyvlUymEt7XHqJtNT7IA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NV/c/VURgUNN1xb2Nx0Utrq2IqVL9dQAthwXlOuSnv5++mFpG/XjFU/ZfH0OyxwQDU820PKoj1FatOU0hDoebrdsRndQ1VmPOOJyrBHPX/cRMYfFTG2FZ+roHx8ycF+GkEAglwVJVWtfYeNH81GAZQOHBbtltUlfxzWMgSgDltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wfpeYdHk; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wfpeYdHk"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736d30d2570so2143001b3a.1
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795677; x=1744400477; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2g+yUGZiG4yfMHeUUYgs9UInpjAc1fZElggf5I4uJ3E=;
        b=wfpeYdHkZZ8RjDqL8hHQ1ArmU+uAap8GcuXV5w1pXtDuwJWEqV7OtPX2QzLD+batRV
         a5hJ74HvymWbf8p6ezUxiu/X6Ym28H4zPY38wMhOZdKa19QtJDikmzZNqtPd4Ncc2fL3
         NGojkOSAVahwdKDfh/i7LXcZEQX9oZdbTXijlvEKxDEjXePTyiC86qk6O93lgTjkIFh0
         P0NGhyyQHU9NPrWzspxrauii7789ZCOXvpmWtLV/Zq+AAIfUt14Uk2RXOwFo/HLHjcE8
         07TptDnQEvJCO0H5e3cPY+EGwqrNc0Z4G/Aku1/cP0oTH2/O3deTtAPtiMPv9vznHSut
         kOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795677; x=1744400477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2g+yUGZiG4yfMHeUUYgs9UInpjAc1fZElggf5I4uJ3E=;
        b=vg+DBOiRxJC4liTH9EQdWaWpJeyuoUwvFe5BhDL4vStlBmHUVkP2S+n+ElipPFSWe8
         Y89Q8dxsifkzqCSjyn5L3WaBzikljhDgGPlAXTl7wpImfTFj+DQmLrzxhU4fEYHJu8iP
         1WQGscoSeY90fWgasC7Z5kKf9pq/NNT6+FmQXF0AFKZLi3FBP4nFZ1PsFIgQD7z72MXX
         4UffZfWDmhl/4Yusat98vES1QZamjdEx3nHspgEJD4lilXqKZrt9n0V2cdB2RFrrAlah
         idMCtartkN+wRAIC7MErH2FoD7zMvNv/0CG5spwTP47txFu6RNV81euVt4Gr1ckTQ2Ho
         Wo8g==
X-Forwarded-Encrypted: i=1; AJvYcCWI+aXZURb1RZE2nqUIhQghDWJ8QsTP2cZ/X6tVfAhtqOQ3fTucnXL/MJhHnKY065XVq1HbMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzF0iuwhlHq6mTR6HnxKzGc3Mto5lE2rR9X2Y9M19YfzPvu5Lyw
	kOUmdaAW2gxCkvKjy8zHhZBBaUxaNg4JxdP1UK1YcAFPrfDaxwgYeE7jVIO8Hz79rEyHhjG46M2
	kwA==
X-Google-Smtp-Source: AGHT+IGWwBLEvimkzUQGQ+6a6AS7T1fRIlofnqD1LzuuuvVqr1b/zIjzTOQVerQA0BKJhk3Q69vR5NQVKu4=
X-Received: from pfbjw34.prod.google.com ([2002:a05:6a00:92a2:b0:730:5761:84af])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9c99:b0:1f5:769a:a4c0
 with SMTP id adf61e73a8af0-20113c71809mr1061441637.22.1743795677060; Fri, 04
 Apr 2025 12:41:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:07 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-53-seanjc@google.com>
Subject: [PATCH 52/67] KVM: SVM: WARN if updating IRTE GA fields in IOMMU fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN if updating GA information for an IRTE entry fails as modifying an
IRTE should only fail if KVM is buggy, e.g. has stale metadata, and
because returning an error that is always ignored is pointless.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 5544e8e88926..a932eba1f42c 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -842,9 +842,8 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	return irq_set_vcpu_affinity(host_irq, NULL);
 }
 
-static inline int avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu)
+static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu)
 {
-	int ret = 0;
 	struct amd_svm_iommu_ir *ir;
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -855,12 +854,10 @@ static inline int avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu
 	 * interrupt remapping table entry targeting this vcpu.
 	 */
 	if (list_empty(&svm->ir_list))
-		return 0;
+		return;
 
 	list_for_each_entry(ir, &svm->ir_list, node)
-		ret = amd_iommu_update_ga(cpu, ir->data);
-
-	return ret;
+		WARN_ON_ONCE(amd_iommu_update_ga(cpu, ir->data));
 }
 
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
-- 
2.49.0.504.g3bcea36a83-goog

