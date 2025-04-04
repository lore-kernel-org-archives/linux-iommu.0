Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE22459E9
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795686; cv=none; b=MtHeFXp80g5HgqEymHueXzQNrlrKpooQj5L+VBBlQiym1A2nE2X3X+SF16WssRFD2NhonsWbDJpFX2OBHS51ziOhff4c+TrzX0I6fGkYIfq7Xo8eFNyVts4YWvToyoRB9RolcdiYUyODQMvCRO9vQFDBTeckG2vPJyy9Et4J/GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795686; c=relaxed/simple;
	bh=mBywmRA4/NC4/3ktj7swW5HzxdRaFgk8AKVqnst2exc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e9raHB2nQGouBJg6AgW20SJzsQP7vm14JqRi/7VKsgpcRdvLcjxVuy3izqyRQZI2lgQAe4MvKzPoeqARGfci0SDRaH2GvDnlIU47AMuemDfk6FkCYILIiaCpFqxqlyiCKRNWDJLAPl691xdiyeprTZnn9osCbgr0KOPLpYImYwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=udT9uWr6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udT9uWr6"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736cd27d51fso2261050b3a.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795684; x=1744400484; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BWR485RXwpxC9/TJjlnr5W4WV3qeOulIgWhB0Aow57s=;
        b=udT9uWr6NiE5l/9pDPrGzRpUMMkyIJG8m0cL6h/O6KN5ub0xFXsBZxL0iZERDDbr6k
         nd9W9rbSAW0/zqBtVd4HwGUDdXJYLjYLhDvy2Vf76kT1/dj7cQrUeQxAVJJpiS8uOvCB
         iUdOJUlmLYhl+MPwfeB1WbFF9KHsXYt8qGWoao65Em11eNY9+GuKPv7fvzcPNmW2jK9j
         aOVMK3rsS61XOcJEcLLStiS9oE0/1CT0RCjf0NQ5+UscPbIEwCOlPecP4jlYqs4HlYWd
         mTLoT2zq5GvHDQ8Mzf8cu5dAHXKY4b7GzDwoVl4M1O9/2qYvx0aLm8TTyQ5O/Nd2ZAiq
         d+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795684; x=1744400484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWR485RXwpxC9/TJjlnr5W4WV3qeOulIgWhB0Aow57s=;
        b=ItyDJrI/keJq4vbwcp+XL6JsRjkjMe0C79tyapxvPqcnmbVBT27mhmxk9rnSirXsK+
         Ge2fQK5AJmeun8xE5rQKxOP75C4aRherYTGyhNkJDhdUA40PAzLEZnmjwr3LvJGbS9oE
         MSm+5aOj4beiWIAhDeQOGlwaXseDZcwxEHf3EgdO+DTfCgP+Fsphg/zp8DdgZiSQaKr4
         1OgH3Xz88tMStbKDC1i/uncsA0oDU/s/YlqkudeLHIp30I9lN0GvjQ6iRdKgTI5hZzbE
         zbWHrp6vlAjlSqPrHxAkg0DbIfEFvdrGkzrc8Oq8LeNZa7U4XuA/2eB+wDZIcY+iE+5z
         OylA==
X-Forwarded-Encrypted: i=1; AJvYcCUy1JO/gffcbd56opV831kokqUMYReT9XfT0ya4HmREuXi0uENDFp945gyfdKLt4M+rH+kgqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWNCMK9LkjPX0XNgRgcMx1j1jPPhKGZ8wELUuKopHMj0nkT2sE
	CvO1bbd87qLVtqalzowEN5s9dZhtWrFdS5yrLwRR4IGzUPDdt39I07pA7ZN5QdVWMjL3SbhbGNC
	ARA==
X-Google-Smtp-Source: AGHT+IFrhugesHcYwD2EtEVR8p7v599AXO0yZ1dLVE7YlsaYY7QqtLthcLHvdmvsan5d8gnX4rE1BdgAjQI=
X-Received: from pgc8.prod.google.com ([2002:a05:6a02:2f88:b0:af8:c3c6:e3f1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1304:b0:1ee:ce5b:853d
 with SMTP id adf61e73a8af0-201081b2d99mr5653839637.39.1743795683722; Fri, 04
 Apr 2025 12:41:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:11 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-57-seanjc@google.com>
Subject: [PATCH 56/67] KVM: SVM: WARN if ir_list is non-empty at vCPU free
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
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
index a932eba1f42c..d2cbb7ac91f4 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -713,6 +713,9 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	int ret;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
+	INIT_LIST_HEAD(&svm->ir_list);
+	spin_lock_init(&svm->ir_list_lock);
+
 	if (!enable_apicv || !irqchip_in_kernel(vcpu->kvm))
 		return 0;
 
@@ -720,8 +723,6 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	if (ret)
 		return ret;
 
-	INIT_LIST_HEAD(&svm->ir_list);
-	spin_lock_init(&svm->ir_list_lock);
 	svm->dfr_reg = APIC_DFR_FLAT;
 
 	return ret;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 43c4933d7da6..71b52ad13577 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1499,6 +1499,8 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	WARN_ON_ONCE(!list_empty(&svm->ir_list));
+
 	/*
 	 * The vmcb page can be recycled, causing a false negative in
 	 * svm_vcpu_load(). So, ensure that no logical CPU has this
-- 
2.49.0.504.g3bcea36a83-goog

