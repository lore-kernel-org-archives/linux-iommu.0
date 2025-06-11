Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964E2C3249
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682106; cv=none; b=SYbtDRu7NvqFNayVhSi0BHmFeHh6cy4FKe7sbSf/jLefUsY2SuPCglQ1N8AkxlowEDwEago5dMdedRqPmm8W9LP4fyC9tfpiRORYBY/szkP9gqkPNAFQzekdRoidjD8w5sgAnNQV1bEhxFtaEvXf7gFNxqPN2xyTedjYAe4z7js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682106; c=relaxed/simple;
	bh=XZYNkX0i7jSO000S8PXHyo4me3Uz0WtZJb8h9nqk90s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sXI9dujqj+n5HyvnKxAVy8w3quYl2vNFOWLKRRYPjh9q/6fNEeHOdC5ROfLBXrubu661DNp3KV6VlrLZa+u+SKDmrL2/wbM4De9ZFBNtgxlEQFZQMoU3GcFMbfkLGE7hLyEbXlGGqqgyhMYqyw7MGYlWrQx/ddZ9WlgmZKP+krA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4IKYhnw/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4IKYhnw/"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31366819969so290645a91.0
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682104; x=1750286904; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HL/zmEfedJaVYRCaVWCVwHvRFcjp3FGRcd4gYxRqVws=;
        b=4IKYhnw/7o68ej4qPtv3e83IOEN6pEQFai4+9QRJh60/9UIC171IE5z8+8KEs4Jw3O
         9/0fRRbiDL8CPMQiqVkqy1qnRZpNxTukZ+O09hw9c+EgC8pNbIOqYGRF7Qio437OoBbz
         qJ10hdufmgbWn40f9Cc5+PXFTvH3b5dnfIII6gyOSvM0wvbCApy/bkdODkfOa1GpYW2e
         FlJTnDbvun+ELVXOhjwnWb6kArFsB/iz866R/Kwu1JhrJjmu3JC7bwnpm4O6jRY8ENr/
         rt478bcyH8jmslOxGjrSYt/6D01YxpEnX1g8KdX2TlilU+M4lD5x/zm5mwjCiIOW7CvD
         3SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682104; x=1750286904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HL/zmEfedJaVYRCaVWCVwHvRFcjp3FGRcd4gYxRqVws=;
        b=qD++qkFK0bPzX4MCmuENbVvJdG5YvjtNCcasaxWDoRfoSW07ZFDn3nDWBp2Cv0q/dp
         yOd/lK7VBzWggUIH8zzOccxd3evSUK5oQyYCZKLdYVfjhg7CNzg8q+pCBuTo50RcDv1J
         SQug9nMxVq7ZV2gAcwNfcwrv9I6Ac4A/kV9Qc7qMEE+DHfE4M1J7NjM7sgAVBFt7aQZI
         FPJywbyD+VZGuYgvt93aqTDGJ8mO4G2/pvTGacOLxC9tnJYH4fHhgDRUUBQghqlnWBUY
         PitdIwj901hFidBh3D/mwQCA8/3uDVrycAj4DSBbBeUfHsIeoyQ66YSYKQgPE5EYcTrl
         ZlZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOt00roMD2wZjoUVV8Fq3Ow1dZObW/t2lGgQLiAkfEAQUNiP0xiQlripyWZ/XC/08yU7VP2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvQYwEv5Zv0PEOSunfpVTLdR8SeiAX76k80bXDJpAcgJfwDQY+
	M4l8aZAQxzngOZlDgpXnvHIrDnVjIAdM1qtioFlfl99QeozYDRye2Nanm1Fgy/cwpzh1cKI1I/1
	fXat1uQ==
X-Google-Smtp-Source: AGHT+IGhHNFSgThb/kvZUf4kLsDMQ1oq0Au4sXs0Omc7Pt0JkF2VfQnLMbJPUM3t5xwiyldmiRdw4k1+Wjw=
X-Received: from pjv12.prod.google.com ([2002:a17:90b:564c:b0:313:2b27:3f90])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3952:b0:30e:9349:2da2
 with SMTP id 98e67ed59e1d1-313af0fd336mr6601829a91.4.1749682104030; Wed, 11
 Jun 2025 15:48:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:54 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-53-seanjc@google.com>
Subject: [PATCH v3 51/62] KVM: x86: WARN if IRQ bypass routing is updated
 without in-kernel local APIC
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

Yell if kvm_pi_update_irte() is reached without an in-kernel local APIC,
as kvm_arch_irqfd_allowed() should prevent attaching an irqfd and thus any
and all postable IRQs to an APIC-less VM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 9c03a67fedbe..02efa7162252 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -517,8 +517,8 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 	struct kvm_lapic_irq irq;
 	int r;
 
-	if (!irqchip_in_kernel(kvm) || WARN_ON_ONCE(!kvm_arch_has_irq_bypass()))
-		return 0;
+	if (WARN_ON_ONCE(!irqchip_in_kernel(kvm) || !kvm_arch_has_irq_bypass()))
+		return -EINVAL;
 
 	if (entry && entry->type == KVM_IRQ_ROUTING_MSI) {
 		kvm_set_msi_irq(kvm, entry, &irq);
-- 
2.50.0.rc1.591.g9c95f17f64-goog

