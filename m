Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD38122D799
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795644; cv=none; b=gBUKJ1AP4XVQKgff8HsITZMnSiELbmfmvMpkxaJ+vRm+5gPieH9Jg3aYTDX10BeNZi9cjmMJ2uCPefvQttvEWg+HoKrvb7dpdia1BpBUtRvK1aFP9BExDT94g7K6K0XvUGQt83r6HjcL+zo7e0CKaOOVnYhc5inprMN48TYkXU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795644; c=relaxed/simple;
	bh=NSXiAizTL3IE0tHV1Xvoqym6aO30iQa3+NNj5eRfrOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZXrv2zyQLzkqMSULELhjLENL2MTEafKIXwefwLCaeX7dw4u3ZzlDvuExdKXAIF4FflQYPJq9qzQHdlFdORu3cjZSeVjEKQPXaJ5RGCp1eGBrI0lQPAnwH5pbvzfamC6OoJAmP3eFPNWtgDJE/7dcVfMyRg3AVTf5gyfZ0HXhRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2KLqC8rx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2KLqC8rx"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-739764217ecso2160748b3a.0
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795642; x=1744400442; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4tJsBeG4t1G+TPijwvZhdI7bM9ZuzjVrHlwd3hub/NM=;
        b=2KLqC8rx9yRwf7+EWGAMGrHx9L50k3TunJHgT56IK4kpt3DSOjwFq2atAgo54koYUR
         AIzCzov+cvW7E/XgT/01eU0p8f8rPA+Ee50e8QeNyPBUHjT1gMCcpVHzyB2sS6CdPwCV
         wH7UtGoGSGLyT3As7PSmVdZ3gRaBLqosl2W8pUqlbsgkI4NtI2YneD8k6MYo3UvcN+N7
         jNq6OpQVFt06L5xxFUkAI+UKRNLbdX5Nz2oEL/ER11Rrx9YR3WLD1Ar2+SPeVvDEMOwM
         EMAkbw+MwUxWvbR7f9L6L4YE7mctH1tvq+sZPDGjQ5Xbr7/XKO5JFBWCDRzdMWKl8w7Q
         kdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795642; x=1744400442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4tJsBeG4t1G+TPijwvZhdI7bM9ZuzjVrHlwd3hub/NM=;
        b=MQOh5FusGtRF4HpVGQ9t3XCQ6SWIHjFIHkoZK0eI0yOVOoRAEWBEx4WGfWqdxBeUmT
         35obyNVty+eehnOnSupTW5ov61R1XrswdC/0BYiG2FSpkCcCrhkjMAFy436+C2TPTIOk
         pBPpqhk21odRb+Y6myHZ5yxtEdaGunijIH/t0nfH7Dgn5j8jqWKatr1Jm8Pw8TT9dJ2H
         aG+4vLWBo3F+M8MVNIEKrDg7CZkxHrnQgl84AcgfNN1j2fFHfs6jWbBAwPpJvx9LBvch
         QV4C3cxxiYgkT3OhZMR/M4GXtG38yxR64sx/3WGH396kOAhtt8OlskDj0YACp3u0XPUj
         xrfg==
X-Forwarded-Encrypted: i=1; AJvYcCUiNc86YMQRjbsojhoAUER7t7g7db4V0+11otCPgFcz42oMAdgXcdbYKYNusZOS9sGb1f+nOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbpTnXi8s4GpXMgyV2X3FZ8u9w5d7xCpMO7SbSXKDN4TLPVPTt
	7UO5xGgqnOvmTGo/2CBSwN99sjkiLeHrupaCISQFVVHQjtaIxDwo9JAYw7QhHIPfkse+gdQY6RP
	/xA==
X-Google-Smtp-Source: AGHT+IEScd25fZRgSV6IjIzWui2u8dQv3YbcYlwFjvNFPD/+/iSxPK7V9mIz4jseM9arXmR9ykpZDrdm3xw=
X-Received: from pfoc24.prod.google.com ([2002:aa7:8818:0:b0:736:a1eb:1520])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3996:b0:730:9637:b2ff
 with SMTP id d2e1a72fcca58-739e5a567admr6139702b3a.7.1743795642377; Fri, 04
 Apr 2025 12:40:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:47 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-33-seanjc@google.com>
Subject: [PATCH 32/67] KVM: x86: Nullify irqfd->producer after updating IRTEs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Nullify irqfd->producer (when it's going away) _after_ updating IRTEs so
that the producer can be queried during the update.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 52d8d0635603..b8b259847d05 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13608,7 +13608,6 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	 * int this case doesn't want to receive the interrupts.
 	*/
 	spin_lock_irq(&kvm->irqfds.lock);
-	irqfd->producer = NULL;
 
 	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
 		ret = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, prod->irq,
@@ -13617,6 +13616,7 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 			pr_info("irq bypass consumer (token %p) unregistration fails: %d\n",
 				irqfd->consumer.token, ret);
 	}
+	irqfd->producer = NULL;
 
 	spin_unlock_irq(&kvm->irqfds.lock);
 
-- 
2.49.0.504.g3bcea36a83-goog

