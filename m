Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC44A28A1C8
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962069; cv=none; b=HM7Hsl9zIV072qAXXth2o1s6F6TXQEvbM8DEq9EKGRVWTY5CABzHfDLZL0Ny/pQXFbLAPvt/uKTQ3SFA8rZQgDfVJfGI08s/3mLWDX25asSYF2Z0mVR8YIlmYYEjkvmKvf/ShnfDtVWLdQg4vdHUzezR04QcBPvwQI+jAaTtcHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962069; c=relaxed/simple;
	bh=7dnveniOu+/d08DxHilZb5jCCAKl0BL94CVVwVEl7eU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RpH47N73I+HHidB8P0L+AsLKagqyhMewZL/M7PbFlu5GB/rHA0dJgIjHCx+/0cWkvstIPfcjdcEkTxSiWoz1+xU8gwewQM+TXOQF9DXnodNaAfB23Oeyw+JPI6wQWjWEn/2oLDPJhe1hwyRbgmquF5X1UsPH5/3/gWWkKzJgGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxdkqSbI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxdkqSbI"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-310e7c24158so474950a91.3
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962067; x=1748566867; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=V6x9LNMhumiNfsLAp1ILmLoBe8XRi6VNornrEAAWP04=;
        b=oxdkqSbI6HoSoNR29j7i3jdT/nvN4ln5YxJ/BvovPqUzteNfFKO6Ma1PalC59GejPC
         XNltQ+2rFiMP5M7Dd9kxzWb+FrlYlejwKW1mPKK6MXhDvLHH3SbmsUd/tzgPqpYvGK4l
         9zvNQzOWSr9AlvIu9RC7sf/RTtOMGDi36lhUV42i1SG8K/q9wDUfsdLh0NfIiFIBiqvT
         IjLbJUYb8ezY9yfToslAcZ9o/Niggs2ktiP9hHOPeSkhrUv1xWZROK5ACL9J9u8Pm3H+
         grEIqlBpiVfjMaPQa/MGMmUaZV3TR8+SgSIF2GFH4/v27C//fKCyG7gOc5RoeiZNjDIG
         eQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962067; x=1748566867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6x9LNMhumiNfsLAp1ILmLoBe8XRi6VNornrEAAWP04=;
        b=Eg/oCeXdOvqOe7UCDVz2pfULTQ7HkHXVGHFbTN2dPBtMC9hmQSKIqrUUV3HmmixB1F
         8TQsfTS0VEPk77x9V5J8HzymN65kK8INUZh6Z8cDqJa+zPFsg8Dmx8oQ64fzdJ7us/F3
         l1xt/Vs13wsh6766uozXWe44akUCMKi3snzz3hmolonVNw9k+HWT0GdFjUxNxPe7A6EY
         abSWzKe2kHWYP8FAnxOKJlrUYDqJ4mAWUl7NoGJROtjnENbwKIHG1hJQvIlCrQwWB3d2
         s74At+31mwDwOGT1vSEzgEfuGjFJ/bIQBVUyGjur6IEGYBTJsKoxeF2FYlI5znsCOXba
         E9rw==
X-Forwarded-Encrypted: i=1; AJvYcCUX8YGXrCD4cyglfeic4DfeCR7/Ow+dAPI3XrX6r+47n2/SekpHf4pBkNhyxRw6ITHzSGsfVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxguPE+8++aqxpTulige+mJ0hPTPhxMMfhvIa6Vs0YZ2EZyizK9
	RuuYfprvH6lG9It27cz2ouVb5yCP3MJGS0qnqilbWeDzQH6Sk1DRdmCDTP5Tv3UVxq/8JIde5oy
	F1Pu61g==
X-Google-Smtp-Source: AGHT+IHFMNVKJa5e8umXYgZ4QtpyHnpqS+oxhyJku1m1yyj6LMAR+nnLi5IpcTUffXcAu8Fv+d+vw5Lcpqc=
X-Received: from pjbrr6.prod.google.com ([2002:a17:90b:2b46:b0:30a:89a8:cef0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c883:b0:2ee:e518:c1cb
 with SMTP id 98e67ed59e1d1-30e830c797dmr41531451a91.7.1747962067465; Thu, 22
 May 2025 18:01:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:39 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-35-seanjc@google.com>
Subject: [PATCH v2 34/59] KVM: x86: Don't update IRTE entries when old and new
 routes were !MSI
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Skip the entirety of IRTE updates on a GSI routing change if neither the
old nor the new routing is for an MSI, i.e. if the neither routing setup
allows for posting to a vCPU.  If the IRTE isn't already host controlled,
KVM has bigger problems.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 67fc8901d15f..19fa3452d201 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -618,6 +618,10 @@ void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
 				   struct kvm_kernel_irq_routing_entry *old,
 				   struct kvm_kernel_irq_routing_entry *new)
 {
+	if (new->type != KVM_IRQ_ROUTING_MSI &&
+	    old->type != KVM_IRQ_ROUTING_MSI)
+		return;
+
 	if (old->type == KVM_IRQ_ROUTING_MSI &&
 	    new->type == KVM_IRQ_ROUTING_MSI &&
 	    !memcmp(&old->msi, &new->msi, sizeof(new->msi)))
-- 
2.49.0.1151.ga128411c76-goog

