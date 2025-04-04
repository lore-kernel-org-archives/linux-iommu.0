Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23744230D1E
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795657; cv=none; b=kf6aTq1exjzlO7ESebV0miiyycUi7+VvRWWv7E5aLCMyH1QrP7nrt126quIeJUUpbHU9hLD/golgg1T2PRbeAD73bq3rjv4OE8nmR8OfcR1/0617Bo8jh54bl1l47FpfnAOMr4AiuVbVd+er1wW4/rHHWtsr2Ktda6/X+CQnSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795657; c=relaxed/simple;
	bh=rAx4qAmD55M9tfIGXl5YoCVA83RQWFiazrLX3izC4S0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wtw/InzoAT0wZDmeS7S0GdOPXnqEKYynbWMMp6VC1aFoOif3QHcvL0HpU+OS3Y4k23sD3brzrERBcrQMTUnThoLG/ogYtkjJokHHUJMfEbEqg9phWlSmoZHR4a9Ch1T/1b5ATpOr3vscML1Zehr5fDbYw0wvFWqiFxIBvucSuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aURX6CxW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aURX6CxW"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af98c8021b5so2468764a12.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795655; x=1744400455; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bZC+Ik33WL0W2RRbulovk+dibdQdMDMKKv8TRtkvhyw=;
        b=aURX6CxW0RW3hjpuEFh6zaLu/sYJ67tF8V1jD/rlhqHaOyYEn2jMJaPITeb/MV8H9l
         4HcWlZ04h+sc4htL3CEk642BS+DGryp2Ca+oplMOlaiDTFhFudKvpEgcp+GTfo08rIj0
         29bJ0yJfaEzlAka3972zWLrds1gG8NooRYltY4qB+VAB5BpgPCDcf7RXNOEL2HMIKo0O
         iAa0z+Mz9J8gbnaHV5Hv1m17QMS8j4JNWf1pWMpP0FFH9sRhl5CPuJmZ2kXk5hcQe4Lb
         whYQRBTJzZAk77lgysr6+P1bEmAm93jr4nvCfZN/v0qY7SKUB0EbQ3E4IQE+lAwQPl78
         4axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795655; x=1744400455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZC+Ik33WL0W2RRbulovk+dibdQdMDMKKv8TRtkvhyw=;
        b=JvjkTbK6j0G6jEVkAbIPuvjE34jFW+3YOkEOVYbEnB6Qx4bVEPhFKiwVjtvxIQe57L
         94wR+zS2iqBVX8iGGYnFIawD9UV3N4qb55T4tmRSeCSEKcCHzEdy9+pKAyXN84HuEtaX
         c5ERJPLOF/ZEXhbNPBDVbE168Sj4BgPwdURNzKWZK/H6hPH/OfefJuxhq+pcf1wbrLQy
         BEom+krggs8Hn+fnphafjuxUsiQXPQ8x8CvNNL99iJ5uFhf5DsNzwOWr0VgDrt5Ycru+
         DTfqLYCeG+Gz/CUSao3KvZT4m2sqM4m4m15yFfSJvBkrfMJ+ejqTYYhKIcF5T75xemSp
         ysYA==
X-Forwarded-Encrypted: i=1; AJvYcCXJHFmWaNVG8vt3bq7kW/5J7KVQan2cjVXIM+HPn18jFaClPpK9edJkChiAJpSJIKqLykffcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDx6sioqoREoqbrHpTeijczVMBeFEP6EjUALCaB8y1ei918jKo
	3k0kyt+LT0jFLNejuw0xTQidyl8BG9pWveH1Lm6asM2eQAA2accbES2lu1ovprRK313nVPzfMDU
	NHA==
X-Google-Smtp-Source: AGHT+IFQWL9LigLNP0a/K8uREP9gQEOYzG81Hr4sts6sxEYIr+yeo+mdbybE7LvF1mbotb2pbsREFg7UZT0=
X-Received: from pgc1.prod.google.com ([2002:a05:6a02:2f81:b0:af9:553c:ea73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c78e:b0:1f5:7007:9ea5
 with SMTP id adf61e73a8af0-20113c0964bmr1123119637.2.1743795655565; Fri, 04
 Apr 2025 12:40:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:55 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-41-seanjc@google.com>
Subject: [PATCH 40/67] KVM: x86: Skip IOMMU IRTE updates if there's no old or
 new vCPU being targeted
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Don't "reconfigure" an IRTE into host controlled mode when it's already in
the state, i.e. if KVM's GSI routing changes but the IRQ wasn't and still
isn't being posted to a vCPU.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0d9bd8535f61..8325a908fa25 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13602,6 +13602,9 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 			vcpu = NULL;
 	}
 
+	if (!irqfd->irq_bypass_vcpu && !vcpu)
+		return 0;
+
 	r = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, host_irq, irqfd->gsi,
 					 new, vcpu, irq.vector);
 	if (r) {
-- 
2.49.0.504.g3bcea36a83-goog

