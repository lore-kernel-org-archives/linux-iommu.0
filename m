Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BA32DFA34
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962099; cv=none; b=mdyda0mxgqzQKl+a0bOgQp2eBAjLl/7byiFT80kvuJ2reLhgo/fC+JjkkEZFgINHgbTFTDMu9r8Xe1PVXCTW4LvBuVeMZiH1aQGyzGM0/kk1mQVOBpv5iNElbQeKfcU8hdxfIAj6tF77dWSa2wPiuNCw1XCMDSdqeyDiO9+1PUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962099; c=relaxed/simple;
	bh=NGIANfuyMzXoKJquKbW+ehrpEIHWV+x021PzJ4EknsQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oTh9LOAfLz2KhXAh2VFR+WmYmS3i84KNBDg9uCGPwBstzvdobbXvcnbooKX86bz4fTLGqXbFz2XKZfpH3/CpCBI0Yjsp3WDL4rUdro+y4/CqcVAPpMUnvUKcPRG+vpdVxSmIilAsnca6smyTsKuFITEzmUbQ3uojxHGR8wy0rxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PsIPHQFE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PsIPHQFE"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742b8c0eaf0so3422914b3a.2
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962098; x=1748566898; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ExoOfw9G/N1sSoTRHxtPNhWhn4iA3dUD7FqrwsLiXLk=;
        b=PsIPHQFErAh0g3qY3hAptZo5a4UboG+35FJxaQdnpzIhdsSUJyAR7w2ZC715H3wP5n
         gRf4AhaHLLr1PbOOoFp3iyp4Zss1mca2kpgPNRmNbMpkpX7M0XqO8hHeJqt9LNVoAhks
         07bhHVy9d4yhCKZeNrWjbiOMrRRU0eYRb9iZsQsrwWNJRYLCyrgBGYsV8Z+CddJ1y7ib
         eNFQaYmVrcgpPQpYPzCZp9H5SNmJzB79CFu8zYmftSN5REvii0uB5lxG0LvXmY0H9R3p
         mp/kPqzRF4fCy06lugJ1GujFGrT9kF7cBwDR2913Y8XJvEBt+NnbjXTXCmtMwew1NLjO
         e2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962098; x=1748566898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExoOfw9G/N1sSoTRHxtPNhWhn4iA3dUD7FqrwsLiXLk=;
        b=Mdpoy+erUd7/fn7HyNWhOUVF6E4P9/lUrO+a65goeO48jzUYwVtY5tsK+i3RIyBLqF
         H1DgAFmc6yzH+WmA2sWEYKKGCAs7XQiMgilqCHmf1FDmubhHlmW2ANUN2H9g7fR3y9xe
         g6dBktJy51Bl0jJlF9qbhVVEvmNs3/TrDfZBRB64ftgz1fIvc8wx4SMztlsGRtf+CeBx
         IR58wjZ57grigA1mA/MGUrgPE+0+sqztRvlx4QufrE1xlrdTMW3JMxS2NF3Pw+WnfN1S
         Hk+W/AB75DXZDwmhx2YjVvU/d1DVQmhabJz9xo4MeI2hz4AbFzGtaU1+eiBVZicVxYMj
         SUFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw1twrtoO52IopAlMBmWupvqkMevpnGClwyYzR2sfRAigQWSUm/4edXOCHg7VjMsmpBlkP6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlComMrX3VLZdvFw/nLbA0DM/MZzfY9hYrKQ4+ylpVGsR3iEYM
	D15jZrYwesyLrEuuGEn07lU8o2qmyTlP4xs2c5S7Hbg1oDQ6MCd5aiR8jHFuUvKEbP5+u0Q6PTF
	MDutPcQ==
X-Google-Smtp-Source: AGHT+IHRskctku8TAbxqTc5JSLZa7cBf4pJ0pj9pJzlkOC6dQa0UxJjlReXD4jK1iH3OFzYeZWUC+JH7b6A=
X-Received: from pfaq8.prod.google.com ([2002:a05:6a00:a888:b0:742:a83f:bc0f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:198e:b0:740:91e4:8107
 with SMTP id d2e1a72fcca58-742a963242bmr38441580b3a.0.1747962097793; Thu, 22
 May 2025 18:01:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:57 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-53-seanjc@google.com>
Subject: [PATCH v2 52/59] KVM: VMX: WARN if VT-d Posted IRQs aren't possible
 when starting IRQ bypass
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN if KVM attempts to "start" IRQ bypass when VT-d Posted IRQs are
disabled, to make it obvious that the logic is a sanity check, and so that
a bug related to nr_possible_bypass_irqs is more like to cause noisy
failures, e.g. so that KVM doesn't silently fail to wake blocking vCPUs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 5671d59a6b6d..4a6d9a17da23 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -296,7 +296,7 @@ bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu)
  */
 void vmx_pi_start_bypass(struct kvm *kvm)
 {
-	if (!kvm_arch_has_irq_bypass())
+	if (WARN_ON_ONCE(!vmx_can_use_vtd_pi(kvm)))
 		return;
 
 	kvm_make_all_cpus_request(kvm, KVM_REQ_UNBLOCK);
-- 
2.49.0.1151.ga128411c76-goog

