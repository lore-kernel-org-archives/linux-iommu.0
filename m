Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC522206B8
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795594; cv=none; b=tIIOQT/837ORqOuqySg9FsbgaPSmOcgJMpCa32L16gd/ZJNXdDwHYJyKV5ioxYz1HRX73KitFyi6I8o140MsU38RNuUa2vhWVstFEbsGqBpAuO7EMmHjTOLzwMHTNTJkCzQlfZtAfRdbJq1rHjC+WiDFZy52MXLcBoekOglXDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795594; c=relaxed/simple;
	bh=PLM9Oe14dNa7pkRo4U5ot9bvtj2ZhI28uVdi+hfPu3s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ie819QVswa48tfD4C5Ua97Ax0xKa/ehM2Xuwi9Zp5Ep2AViO0/jNW+skLVkCLmE96Lp3lERpLgQkkBUJmTYR518DhmGJeDSoxMaA5eHRwNmkHaGxs9UvGKf/wMyXPEjwhzsLwfgyO2M0PWaZH5BTtqhGaoZDlRcgp4K4omofqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xzCUUXDL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xzCUUXDL"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736c89461d1so3576276b3a.3
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795592; x=1744400392; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+47iTNmbRmU5QNEmm30tIBdVVPpOMLVIBC3EbiK88yI=;
        b=xzCUUXDLeoMQwbVUK9JLqv1TN/h14wddCrWLAzOkIIAU0rv5Ld7ZkKVquQ0D2t56qc
         JTTx8BVMj3iHPiYETZp0ASamzfT4OxJ6m5kSbqQlMxwaAf8pwkeHDZMnNAZ2sPAGeBpu
         d6Rje9IGPeur8etTV5bsIzpIdQtbZoHgtYF2EHCPKgFvGGOxuNLSZCEGITmmkYDx2Ncf
         y4iiOn9FGCY3SaUnw/Ft1llZVrsE4tzHT8p+GmpyipbiyNohnQVFz3sj+uQ0OeIsDYCF
         2cqQO5NG+dPEnHX1O/I8WU8U90+8hyuCsUXJvCqvw5aPi8IebbfTj3QNiUX6tT50kv0O
         utfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795592; x=1744400392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+47iTNmbRmU5QNEmm30tIBdVVPpOMLVIBC3EbiK88yI=;
        b=VasaGwy9W9u+FI8QQOGqxZq+y100HlMj/0v5es7xkUDbZRZsXsEtQd6cdHslh28uGu
         DP6Wt/+dHo8XmjC9E50GLHO45hwYnfEpCwHRcVNwFYRe6VDjCcuDo2kDTO/Q4L5uodvx
         wUuYOjdJJ5fTh9tAooT4NfmCeBlBSznTzzuFtSpHFgxdjSqf0l9IYjz/RlJrOgYzlBwU
         zvVcN0CFUZv67EY5RtJMLoNXN/lOwy1rB18mlXp6PA6J6VyMjO98ml04d8PmfF0o0RCe
         6Q2U9cT1gl9/MAeLipoJB71q8w4pd94zCdtZx8+x6Ox8Wy+dxDOWpRExq9V+ynJ0jc+q
         yN/A==
X-Forwarded-Encrypted: i=1; AJvYcCX7ETQ2+4D0E6I0IX2mgPYnBsyDmOANCQQoP5hDidN1wQGXnKyttRNN/ipaaooSfrDPCzjq7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhsF3XX+vEbZ/4jR1rAvAYe1oT96MnIhNDEYIjWkzR4L6itDHa
	NJG4CICCqbufw4GysIFv/ycDrd59ZyNbEBoOyQmbAl8vtB1kcLiwTMjyYCsqoBsVizma9ntbTSe
	afQ==
X-Google-Smtp-Source: AGHT+IHIboGmLY9qchPfpX/OHkXoE4myUPKEgmdV2feQwjMagq50m8siYeTr/9yoolpfmy2JLnd8BDCKG1I=
X-Received: from pfbln13.prod.google.com ([2002:a05:6a00:3ccd:b0:732:20df:303c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1897:b0:730:95a6:3761
 with SMTP id d2e1a72fcca58-739e6fcbcebmr6002912b3a.3.1743795592333; Fri, 04
 Apr 2025 12:39:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:18 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-4-seanjc@google.com>
Subject: [PATCH 03/67] KVM: x86: Explicitly treat routing entry type changes
 as changes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly treat type differences as GSI routing changes, as comparing MSI
data between two entries could get a false negative, e.g. if userspace
changed the type but left the type-specific data as-is.

Fixes: 515a0c79e796 ("kvm: irqfd: avoid update unmodified entries of the routing")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9211344b20ae..f94f1217a087 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13615,7 +13615,8 @@ int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
 bool kvm_arch_irqfd_route_changed(struct kvm_kernel_irq_routing_entry *old,
 				  struct kvm_kernel_irq_routing_entry *new)
 {
-	if (new->type != KVM_IRQ_ROUTING_MSI)
+	if (old->type != KVM_IRQ_ROUTING_MSI ||
+	    new->type != KVM_IRQ_ROUTING_MSI)
 		return true;
 
 	return !!memcmp(&old->msi, &new->msi, sizeof(new->msi));
-- 
2.49.0.504.g3bcea36a83-goog

