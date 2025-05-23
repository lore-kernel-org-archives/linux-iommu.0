Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D05228AAFC
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962070; cv=none; b=P5juzr74bgkbCDmbUCJVvUcwnlwDkvp5ahO/N0dfeUWiTiAoIEly8ft4U0e8yd4opkgwwEzRH3Y6DkCDrDX2KArCwEgSdKyiM5cWPvk8VVuIiBL9gjVIjgQFIeTlFjA2P0yQxr9v7Gaes/ouzwOj/sGMaU/m5NN1fw3zOWFdHLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962070; c=relaxed/simple;
	bh=U0lXuztKsbQ6vOwPvXvlCRdfHq5pEEfqlrsbN4zSEW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lL0H8a0qpzgkHqnHZ1RS9+TXO7CnDl+HrBuUX8M/1hMDwZSF0ZnS2MMm1BTDi8dl/V+CNMHN6GCeNKSdtYdlC68Lv+u4domB6uKWGvBrqh79l2xvanX7jl07kLs0xgdw6EzXym+GaWotMc72G2qscj7c61fwFW8NhDqd4tJ6J24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GDjNaU1n; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDjNaU1n"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e896e116fso5606537a91.2
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962069; x=1748566869; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kq0Cy8cDTnLLgDeX9paVAv72AILfWzwvKgS57Jhig+k=;
        b=GDjNaU1nZrGVcrmctLmHxkjZmHpkyT0fsYxW3W4Ml0XWkRIBV1pUfFb7SHix3v55u6
         6EwBnSzENGuA3X1pOKKQxHsyDF4LQ5Yk02vkXdk9hBjJlrElJE4vi8Dtnfg4BlS48JCI
         Y9sH8Viv3Bw9DgVl6Q45ICWUz7EQ1Li2sxvVhR4rubFnB+qwbLXYehBlk+xLdpHpK9nS
         jzFdEG+PDiZT+JKgfQckUc6mVjfeTvPJfz8OTHdoM7Ox6JfYPZy4QJSQBeY+CAn1mH5V
         6K7dWF350Si24Upv/9zmjtNusb+MTLhqarW8J95vCm7iTYaHig77bBc/EUl3dsNRUYBG
         1wvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962069; x=1748566869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kq0Cy8cDTnLLgDeX9paVAv72AILfWzwvKgS57Jhig+k=;
        b=TuXe720sA6mDG8zT9yX/v2pcn2VX3IevAo/kUQoMtbd7yR/+CKxo1HRwnMpKNA9yO5
         j4nq89J4DB6JIW2peC4w5Yplk9dp6atyQMfvCeNfoTJqdw2AIo9+CtA+EfAsGelPREZg
         xVW0xCSvSuA0Dw0of/SmCLNcOhRGEIRwWzffNXlFDOEcYFX2XeM/XHA6S7fYrACITbO4
         BMaaHuEvJb8caS/Z3nCCfE4q6FW/DQ5evbYVwa2G9I37UkpoPjA83AHyQKUY6nmYQXfN
         zr3yUGv/Vs3gZfZVse26erzv6xwND028B051S9WmTF89aYD2Uti/4LyK2qe6iPJiNcy/
         HUDA==
X-Forwarded-Encrypted: i=1; AJvYcCVsZZXg3WRBqN7O7QtcY+aoUKYd9WNA03adnWyGIlD3Pi6eMD74sfedVvVFw2gSgiTa6AskwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsNpM8DJ+M9iroGfag7vMUJ84up8fnvSgB2BoesC71jkpxqd9J
	nxReuIjltiVsx34qCQ8k2u3R++6buERVJPIOcp3EyTRkVBohtzo5mHG+7RM61MFN9Sd9FDt4DH7
	pOd+82A==
X-Google-Smtp-Source: AGHT+IFtGk6LcnmjIj0taAHjAXYUJ8hEzTCCNrk1y9BpY/2QgpzZNWMJPoqJgLycpc+0uJxQVWlfD9j1X1g=
X-Received: from pjbpb5.prod.google.com ([2002:a17:90b:3c05:b0:308:670e:aa2c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec8c:b0:30c:540b:9ac
 with SMTP id 98e67ed59e1d1-30e830ebd3fmr44143328a91.10.1747962069037; Thu, 22
 May 2025 18:01:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:40 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-36-seanjc@google.com>
Subject: [PATCH v2 35/59] KVM: SVM: Revert IRTE to legacy mode if IOMMU
 doesn't provide IR metadata
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Revert the IRTE back to remapping mode if the AMD IOMMU driver mucks up
and doesn't provide the necessary metadata.  Returning an error up the
stack without actually handling the error is useless and confusing.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 97b747e82012..f1e9f0dd43e8 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -769,16 +769,13 @@ static void svm_ir_list_del(struct kvm_kernel_irqfd *irqfd)
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
@@ -796,7 +793,6 @@ static int svm_ir_list_add(struct vcpu_svm *svm,
 
 	list_add(&irqfd->vcpu_list, &svm->ir_list);
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
-	return 0;
 }
 
 int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
@@ -833,6 +829,16 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
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
@@ -840,7 +846,8 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
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
2.49.0.1151.ga128411c76-goog

