Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C7F29616D
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962082; cv=none; b=kzY/AE0nopqY/E9CoEojV66n04iPSJFcpZB+BKXpA61cnhIqk24yCCagi/6GDBho1bIc2qpKjoJMbokOu+RaWpTbN+9gWvYq9Lpp6opkJ23lIdqEg2/0ZlIOOoKqahbeFkIBiiGHdyYy+E+gl8uJtj1M7UoJOQgHZEqbE0a+lBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962082; c=relaxed/simple;
	bh=hkXL8tIOvSpgs8BbYZ/kSqxwAWQJTMH+qltnqmcm2m0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H/C8Nl9zKSUKvrkfvv+QHCjhgmv8nBRp5DLekvooLunfqenmGL1fmmSFj4a+Y3M855yKPUpACN2Sl1CjGgC2EDo2CvBY0Ih6phu2sfkyYHxosLHmN5fUfJwAh3OJZqNbve+0hnWef4kbdkrItCzSqoVKKmDn5poEa6v/4oGWezU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0v0uDobn; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0v0uDobn"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b26e6b84a31so5196163a12.2
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962081; x=1748566881; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YWgBZPn6hQ/WyvsMJWVblHWlgsDadk9OyN3hzX+dlyw=;
        b=0v0uDobnLkCQJms8HxROUaaPsIOP02wEWpruRwcJ/ADlHs70SsAXUbzEyOLF7OwKDM
         BWYefeTgaQF5kiBTa2qs14DcU5kKwR00aRkfOfWBj5GR5fcQQ1KZRXuCqZjKIB7pLRdt
         rCTcv6Qd2iqB5jIzuXqL7BHFZUgtGc+1rm51gOr6gFA6O0QqhaDQqJ/Z3894KGkQFlDA
         DRh7zXyRDgeUcA1gY/dfH7aVgv2mA7w6jx36XodnZEkNuUJvd3lHa2l6IcndZk6MSiSq
         Hsr/Co8a0jpJherkNHR3wo1/WM328bnPE941ME2hgoJKTCqTNpJvGkA6+HQLSt1RYxPH
         xN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962081; x=1748566881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWgBZPn6hQ/WyvsMJWVblHWlgsDadk9OyN3hzX+dlyw=;
        b=Cya/Dt5D29hAKZkGNFvLHOVwsGBzTyRWXkxenQLuZLExJIAT0kH6QY/YlSclmRhhty
         Tpm4+jW+jQGgWkiW24npCNzpIJQl80GevnK57ho7ubUKuxiLbKkdKJ+hFG1uc7uq3aYM
         RkajvhFhCIAv0++O1FZuttgurVW6CsnVBXeaEyDij+hVdrGjx1YOPKpvgYWpEYRYe/6W
         kvRFcfXWAlt9xXWPusyJauXaqu4iCePZL1vgdqR1ycsKQrHj2h7ad8rmDRUufzYXBBT8
         EDOObeMzE8pJZqx4vypLypw1Cq5AZ3QXz8l2gOJYr1T9Nk8k250DQuYx344BPLqHeT0b
         IHBg==
X-Forwarded-Encrypted: i=1; AJvYcCULVWvXOvcq2Tky36SXVmibBr5FBJ0JAL2dwboV+I+XSUjNcyr8xhxUBJoWSgW8dlrpm/lleQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1XQss9XFy+0j43H6VDIpFaSCJqpTt5LGfym0kflkrtv7m0h//
	2ZuLIjWxNNLpa5KmBTMV7G9RBJiLQQgIfyAZJ0Tx1H30f95GzbxzwgAwAhn0UorO9l1dRtFpHO6
	r2t4btQ==
X-Google-Smtp-Source: AGHT+IENrNvN8kjYKcc8X8f5fjuZCrY8RjRuwJA8T06sgnoEuhkTZxv+Y0xj/vx377YeaaqzuMYjIUVGtfU=
X-Received: from pjg13.prod.google.com ([2002:a17:90b:3f4d:b0:30a:133a:213f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2749:b0:2ee:f076:20f1
 with SMTP id 98e67ed59e1d1-310e95f3481mr2198254a91.0.1747962080822; Thu, 22
 May 2025 18:01:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:47 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-43-seanjc@google.com>
Subject: [PATCH v2 42/59] KVM: SVM: Don't check for assigned device(s) when
 updating affinity
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Don't bother checking if a VM has an assigned device when updating AVIC
vCPU affinity, querying ir_list is just as cheap and nothing prevents
racing with changes in device assignment.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 2e3a8fda0355..dadd982b03c0 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -847,9 +847,6 @@ static inline int avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu
 
 	lockdep_assert_held(&svm->ir_list_lock);
 
-	if (!kvm_arch_has_assigned_device(vcpu->kvm))
-		return 0;
-
 	/*
 	 * Here, we go through the per-vcpu ir_list to update all existing
 	 * interrupt remapping table entry targeting this vcpu.
-- 
2.49.0.1151.ga128411c76-goog

