Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B583A23716F
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795662; cv=none; b=RqD4q/Yh5lGk2pXyncZWU+FnZEN19Rk1mdTVjPkjNzheVAXM7cQmMqrgZxliOv7Dx870zGJ1iVP+PSpqRrkN79Ni2okl6U5uFcuybCl2avQHUrLigigv6wpYJJ/TpG0hkVuMaG2VvWKgtoAFEFHNstw/6RDh4qexwJK8RihTG4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795662; c=relaxed/simple;
	bh=mZVHycZOmEtySRxY0gXT8uvd2my3ZEIARWSKiopHcCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eaFklewC1JiUaKn9pSwjtjcQKrnwQ7WiDjN5O+RGpkUps/tHKo/AH3vPAGd27qM/QoLukMZmuAjILpcXxNU7KxzFzVwPIkKR13AeZNjkuDJv05yJPQ+Yz6tm3oaIc62kCRHOO9T5VwciRvtphJYO+iCvZe+TNB/koI8AyRG6+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oK/Rsnz1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oK/Rsnz1"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7395d07a3dcso1908711b3a.3
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795659; x=1744400459; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7rkr9hfugytVpCiSi0z4IyfwHexjORIFyMklekHAhN8=;
        b=oK/Rsnz1zFFqhWrDEO9TjAGVOo/fdZGAyUD+Muvc9MviivjC+6soWOrw+mZCDskQxz
         TjUOZEsQYsAn/agB0bnDxGh1cMozKMyfqceTvpU+UxRQFEuE2kWwRGYvZGJY2pJWhz0z
         mBUj7q1YC3YFYhLGy2T9qwxmP2+nngZ+h4tz9XKXOnKA2Pzj080h1hIObp0i60Q2kKb9
         T4FnGNDvN07uT9EzThGb8UvBj1vKh6ckeWRVV2RV3/Q4CzfKJGnT1UGJ/vNWrVLAhygg
         CB6q254V0QI30lXm5Ey4YgWTgRl5Nf1dDusbBeYjHDtJnLgRz9cybo+hzUT+p8/f0lWt
         xZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795659; x=1744400459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rkr9hfugytVpCiSi0z4IyfwHexjORIFyMklekHAhN8=;
        b=GMIn3rZuDoH9B00CKUPTmBIyt+2Nx8i5fKE3sILoCRScxMk1NfhHCpiMIVrGlXfInm
         kmD217kwSB1tN6Mp4FEUhpwraM0Sat7ip6o9JgrcUHt3jNmnKoiquk0Y4WVoBBadtX/2
         k5hjmx3LD1HmsE7UfsQY/kMPyBCJdZ08PdbhOT++dFgU0kZXvBSu6lihEMhD9iaovR/a
         3TJFlWyI6BTljAZCvnhvtnyn72vrwWKQ4qsIBRZ7djon4FbdxLz10Pk/9PUOGhVYqb6x
         HuNgUPMpxNeEvnhVQsC/3Esj8AAp/bfoPFZxi9M5ktwc+7aj2qaJM+Uuu+4AidlTxZQa
         aeKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAcVbHfmTsNPb7HyzYFr1KCDIf1Kag2vn9vLo+ATDP1mu/PKxW/8XhGvhamdi7vCG2/R7ZZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUMuOkU4j6tYK5Tgn0iXe2RoxR/o/H1pyW/Z/ySGNLLQueos+a
	j+oHBANQPWth3vVQObEgUkjLyn6dIi3Emqws0oF0KGfdy6075PpymDSD6G3ZWf8e5DNoQYE3EOm
	hMw==
X-Google-Smtp-Source: AGHT+IEMUGCkESn/3vt+yaprJmAWrzZtMoy46YE4JHJL2Qn/BHhy2Ab6QzLZUQwjmyC7XuNZfNUe6UyzE3o=
X-Received: from pgbcq10.prod.google.com ([2002:a05:6a02:408a:b0:ad5:4c03:2b16])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4392:b0:1f5:6c94:2cc1
 with SMTP id adf61e73a8af0-20108011008mr6057448637.21.1743795659307; Fri, 04
 Apr 2025 12:40:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:57 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-43-seanjc@google.com>
Subject: [PATCH 42/67] KVM: SVM: Revert IRTE to legacy mode if IOMMU doesn't
 provide IR metadata
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Revert the IRTE back to remapping mode if the AMD IOMMU driver mucks up
and doesn't provide the necessary metadata.  Returning an error up the
stack without actually handling the error is useless and confusing.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index bd1fcf2ea1e5..22fa49fc9717 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -778,16 +778,13 @@ static void svm_ir_list_del(struct kvm_kernel_irqfd *irqfd)
 	spin_unlock_irqrestore(&to_svm(vcpu)->ir_list_lock, flags);
 }
 
-static int svm_ir_list_add(struct vcpu_svm *svm,
-			   struct kvm_kernel_irqfd *irqfd,
-			   struct amd_iommu_pi_data *pi)
+static void svm_ir_list_add(struct vcpu_svm *svm,
+			    struct kvm_kernel_irqfd *irqfd,
+			    struct amd_iommu_pi_data *pi)
 {
 	unsigned long flags;
 	u64 entry;
 
-	if (WARN_ON_ONCE(!pi->ir_data))
-		return -EINVAL;
-
 	irqfd->irq_bypass_data = pi->ir_data;
 
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
@@ -805,7 +802,6 @@ static int svm_ir_list_add(struct vcpu_svm *svm,
 
 	list_add(&irqfd->vcpu_list, &svm->ir_list);
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
-	return 0;
 }
 
 int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
@@ -843,6 +839,16 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		if (ret)
 			return ret;
 
+		/*
+		 * Revert to legacy mode if the IOMMU didn't provide metadata
+		 * for the IRTE, which KVM needs to keep the IRTE up-to-date,
+		 * e.g. if the vCPU is migrated or AVIC is disabled.
+		 */
+		if (WARN_ON_ONCE(!pi_data.ir_data)) {
+			irq_set_vcpu_affinity(host_irq, NULL);
+			return -EIO;
+		}
+
 		/**
 		 * Here, we successfully setting up vcpu affinity in
 		 * IOMMU guest mode. Now, we need to store the posted
@@ -850,7 +856,8 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * we can reference to them directly when we update vcpu
 		 * scheduling information in IOMMU irte.
 		 */
-		return svm_ir_list_add(to_svm(vcpu), irqfd, &pi_data);
+		svm_ir_list_add(to_svm(vcpu), irqfd, &pi_data);
+		return 0;
 	}
 	return irq_set_vcpu_affinity(host_irq, NULL);
 }
-- 
2.49.0.504.g3bcea36a83-goog

