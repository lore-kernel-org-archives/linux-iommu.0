Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D992D3A89
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962093; cv=none; b=colxBtIqXqHoydcbPouPGe8iQurLBYt333/xNqxR1bmvWxO5V6W36ayZRh1GlTW2LuJMhBsZzlN23NS09WQ5RgKR4ZPvoOvTCyslUbREUx18BjxHD6SkF3U1xGJaE8DdC5bbYyuBC4Wm7hoQJd4U8NqN9o3fEWfHIqd73uSBj6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962093; c=relaxed/simple;
	bh=6xj74XotH+Q4CRZUCiYbLA659UygnyGaE+O2rFb5mnw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VJzKrbIgfU83UE3sLQ06/AO5XvmElSwOBnqGDIXETH/DLuthPrhzvqrblVzLmhB0a7AqdH1Cjigb6Mu6hljphc50PnbPEfREu9dSq0D7X2FRnpi6gCVJJGtQtwwdOh3oVsx0slOkOzzrNoLkHnCXV4kA8XCkaHMGzRjtfNtYkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sF4N7NSy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sF4N7NSy"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3108d5156e8so3442754a91.1
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962091; x=1748566891; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SI8/xkDYLLYF6taZwnw26LAv3lyi2NrQBm7/9JBUNzc=;
        b=sF4N7NSyg50zi5gXz4S8eAIQXBN0llPzr0PgxkGp5/s7AH/ZIod3F9MuNPUKBvQgDk
         Bv7L55jDNXiPiBET6wp2eHeL6W+qKYBoyalELbLtWBd1atC2bYDMe+O7tpT8rdln4pbc
         zwV7nXycfuavy0PmOh1NIpIukF7Ifivkx8n2ubzZfN9CkqKjZRBWFxc2IqyitGZ7JxnY
         hAS5FHwWGS4D4GB1wFw3jDr2qc3tuD3Brn6zphAKU2+f2/2VZ/BGIGBb3uEgn4E+ROws
         GP3t4X72Ns1Awy+KAbicSGYVFMAag8spO1nxm+X+U6HfBYRQ53bykAbQGXFp3eSNT312
         KecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962091; x=1748566891;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SI8/xkDYLLYF6taZwnw26LAv3lyi2NrQBm7/9JBUNzc=;
        b=P03DPRTvkJa8nboehTgxgxvKZddAdX7Ufo1gd7uDg86XyGRbKSEBZemF4k6NfnLbq2
         RlMhKw0/cwbdsCPS0iJokQxmnr+ZvGLeKQp3Lx2WKttpsmOqRqS8WtbsaB6i3/KIbGLz
         aOFcBTfxOY67sTwtKrN1KF1mZVXxQsf7hWt6+GNsmYgGMrxnjVVf2mkRlXg8ZwYNBfVG
         LeKTAM6epnDNiKSeHRSwb9VhUbXe2Fl70PMK2HbuEQyL8DMRLI+eBDmmrcsx0t9NXL/h
         8/kODgslJJDHUYGVrWbj3apMUzKJHRSKvtdwJfh0rCEl5+w6D4U0lnzUlIvHtFrC56hq
         nxhw==
X-Forwarded-Encrypted: i=1; AJvYcCXEwQnwamU5dMCVMT66LfRykX2Epal3YpWbvP6cIsx8Rv4XiodIs6OcMUbX66IDVfVOViy8fw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjAI7xZGJIIyUVKf19NxDD0RqNHV0Ug4XiRJ6XGRMIGORmcckR
	17NIh9QIipznjM30QxYgNg/1XQU8Wjg1fYI4IBCDQM3pcxWt2kCPnoUaxkGu1AncS1Z366V3+pk
	M3mSE2Q==
X-Google-Smtp-Source: AGHT+IEfo9l+n8Wtly1vR+PcVTI5WpP1pj3psfcNyO0/y6H1bp5kCb0/Tv8svuMeGn96uoIkUHhB1SnsRmc=
X-Received: from pjbee16.prod.google.com ([2002:a17:90a:fc50:b0:2fa:15aa:4d1e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3147:b0:309:cf0b:cb37
 with SMTP id 98e67ed59e1d1-310e96b615bmr1979932a91.7.1747962091171; Thu, 22
 May 2025 18:01:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:53 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-49-seanjc@google.com>
Subject: [PATCH v2 48/59] KVM: x86: WARN if IRQ bypass isn't supported in kvm_pi_update_irte()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN if kvm_pi_update_irte() is reached without IRQ bypass support, as the
code is only reachable if the VM already has an IRQ bypass producer (see
kvm_irq_routing_update()), or from kvm_arch_irq_bypass_{add,del}_producer(),
which, stating the obvious, are called if and only if KVM enables its IRQ
bypass hooks.

Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 904aac4d5e08..af766130b650 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -517,7 +517,7 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 	struct kvm_lapic_irq irq;
 	int r;
 
-	if (!irqchip_in_kernel(kvm) || !kvm_arch_has_irq_bypass())
+	if (!irqchip_in_kernel(kvm) || WARN_ON_ONCE(!kvm_arch_has_irq_bypass()))
 		return 0;
 
 	if (entry && entry->type == KVM_IRQ_ROUTING_MSI) {
-- 
2.49.0.1151.ga128411c76-goog

