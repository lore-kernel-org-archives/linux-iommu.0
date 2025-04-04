Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBD3221F13
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795681; cv=none; b=VzeRgwvyQtUpxV8blNufuPLqCIHjCknhSmTS8KPXdnx3YHAhsOdWOhTyEhKo30n956YBeH9bw0qoAl2cIBTfp7KtT1rp+qr7TjqtYYe+cqVsTW747bVL2rsLI0TlBz78hlGH2mLZYgJPYsX653orB/V7onbOifDNK8d99oYNTpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795681; c=relaxed/simple;
	bh=qXJGgjzw+0hjm8DJW3ZeQr+f2lNwkUO68ihRipJZBpo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NxAE2uqGlfNrPpjVcJMKcyq3COBn0P+OjZld2FR1xmVFiiuBYt32uIrlLduh95vNbAUD7YYKAwo8uNm/y0Sl9HImlGuyxkCzCNwd6pLYosaAxq9V1cnXNU1FozXJpIkbNvTGyXrMWtUqPWj1BUPA15U7VJS8vvig1PQO7SNDirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=luHlVKKf; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luHlVKKf"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7398d70abbfso3441023b3a.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795679; x=1744400479; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7ygW7G5zQGkMJuNregye/u1PpXkO7G3h8KYVfV+6r8Y=;
        b=luHlVKKfAHOO/m/xodeAggup98JA2vSPunbAxwQLnpHsvC6aFo8+wPccKePFxsiH63
         XRNxRgZLAv6cqZfZ1twX8ONiHTB3GzRn8Qu5nuM7M0e+Ca64KwBjRLAiDD9NB/PqOx5s
         4xp56dKkEOWZPyHuXVfkGyCEoD5lCiYsjJb1KYyNFrJubHPhKbwA6lqm/uDOntKnWMzC
         Hk3jB9XW5urn6aO2qXOUXysofS1xdpFy6fETpbq+hITPD0RzwIvssykksxDVZmW0yl9d
         yMPzGpkbGD2h436YoLxK2eTEiGPNnmFv7xtzQWY69NuUgo1yHbzOuAxL7REhPEF2S5Dd
         YTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795679; x=1744400479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ygW7G5zQGkMJuNregye/u1PpXkO7G3h8KYVfV+6r8Y=;
        b=XfXNGmAKUlmHh0MtgJKNg3gq5hYCvH+7jcXgp5W6oOBQhT4iiXhRXu4OT8Ti+T16fQ
         m9t71aL66Vbsw7FGtT/1Vl1+4ncaE3YVI2fPLsPijvgsdGGl9w5Gw+NL7svBYyL8lbPV
         EIVS+7fQA+J0/2IfndeYkwKP+ZTmvsWB4yDa274REwm1E0fJb0SYohWgNEmzEEKq3pUW
         OntnU2Q96lOFIBh3ipmllo1YK7RVpcCwcEWm35am5Aqtv6pf4h/pfjLIduJ6TSRkjr97
         gP75G1wj2/VogqOGlrDdxWk3g5T2ChobVN5YyqIKRNqdscEo8n4GFd8btuNrpDpLtc+i
         E32A==
X-Forwarded-Encrypted: i=1; AJvYcCUOAfAVYo1nr96jUNDieNdUyxiV50rituj/5BT7kNwxBvXVZgRo5bPRxXxiLAmLqbcf33zVXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEoeVD89uS54gBj8bswbPvDQcugI+onbj9tfGpejZcbd0FQgFK
	S5MHIIKuXGMXQmQAQD6dsXrfFevqck5TYmP2d2/CVv5yWCeodY/iLHNlVeX+3rvQ+gbZSXb3zUM
	orw==
X-Google-Smtp-Source: AGHT+IHERn8C/szUZcLSKQMAG6WxKIsTl8yFgLvt40FKuJ8sJxPaz/AKn88FnY3pmMlvJjyBpp9M9NdBiow=
X-Received: from pfbdf1.prod.google.com ([2002:a05:6a00:4701:b0:737:69cc:5b41])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a04:b0:736:3e50:bfec
 with SMTP id d2e1a72fcca58-73b6aa3d9b9mr865356b3a.8.1743795678916; Fri, 04
 Apr 2025 12:41:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:08 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-54-seanjc@google.com>
Subject: [PATCH 53/67] KVM: x86: Drop superfluous "has assigned device" check
 in kvm_pi_update_irte()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Don't bother checking if the VM has an assigned device when updating
IRTE entries.  kvm_arch_irq_bypass_add_producer() explicitly increments
the assigned device count, kvm_arch_irq_bypass_del_producer() explicitly
decrements the count before invoking kvm_pi_update_irte(), and
kvm_irq_routing_update() only updates IRTE entries if there's an active
IRQ bypass producer.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0dc3b45cb664..513307952089 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13577,9 +13577,7 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 	struct kvm_lapic_irq irq;
 	int r;
 
-	if (!irqchip_in_kernel(kvm) ||
-	    !kvm_arch_has_irq_bypass() ||
-	    !kvm_arch_has_assigned_device(kvm))
+	if (!irqchip_in_kernel(kvm) || !kvm_arch_has_irq_bypass())
 		return 0;
 
 	if (new && new->type == KVM_IRQ_ROUTING_MSI) {
-- 
2.49.0.504.g3bcea36a83-goog

