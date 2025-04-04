Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD27822171B
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795596; cv=none; b=itbpl/oJPcXFTtVhT8D4eNeqT5tXHYxnHbqmq4j4/0iz6jXP1TD7grVdUveRy+DA9BofwnhmN7LR7BhggaKTJ7eqzqDM0V1c0bbjxOjMaZupLnnnJewy/NqL/oSn8CHoeVPPHcmWLjJ/IeGRWEcU+K4e2yPIY3VJv10G4mo5duI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795596; c=relaxed/simple;
	bh=zvROXmjtL1IIWkXeJFgdhMrAr1KnWI1Z/K2ADvFL0ug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TBLVgApWn7NIpYUlaMCCvl1w1f69Qk2zz9Fxe+lhd9HvVt4I/waUTosOqmAzReBzKIE2a5Y1ZzSrV2Sk6Cfir8z4qJRuLgUp3cCvIFh96RnVh7WtPT+6RvX6QTBywLtIeV240qcG/1Fo2XbD4rRV+W+97B7xmqvviQJCuSzQxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CnqYFWJP; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CnqYFWJP"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7369b559169so1803027b3a.1
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795594; x=1744400394; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RGxOMNtpRYtvYPUfMG5TmBHR1pFGxtORoL82B7xlqeE=;
        b=CnqYFWJPoMLkMpc10oVouSmZFrbjsE8UY8S6l8VOHUYqYWPKK+fvSXr2jYlTcDZZUk
         DMc2tuNyZVVNcfUj3i4MGnmLSE2fnTPOjNgaMY8xi/uk4CLlWI6FAweqBMUJkFdgSF/o
         c7OAoyF5hLRR4RUbYr3K9LIjQ7JYg2yYLTPZyZ3btqubRFU7oEQiA0nXtf/QY+nu87i3
         sPFh8DydszrW4ppQw5AWZIq0G6vWqSdX63pAc2BGJVw1mnEfbIvRshNwIWdtPWOokwb1
         MxD/uasCtjtCpTnP5RthCPWSy5PfyNKUgJXaO3sUzpxZTBOb85lcR4nNOUbFXYGzc+K5
         dr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795594; x=1744400394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGxOMNtpRYtvYPUfMG5TmBHR1pFGxtORoL82B7xlqeE=;
        b=fEPuDGFBn7pqGVFalspcLhM9UbNl6HFk5XKBYAqnU8QNyOFLIIdWEHULry9eeoX1dy
         8JMdEsokH2zYDrDJTDnEbKcaUVanQ5G+MVMK8Xvdq02vIE11KO+4V3vqq4q8kf4sUHw7
         CDy2E8TJo1tJ/NvsUXW4u3XhpFZxes4tkHzLDqmN1M+W7TqNf0V5ebTrtV4NNv6YSQyK
         vChXo8bnijmQL5/6JECbMeoMo8Yuc14lkKv+QXl0PZi5+My/t5o8QXaO0eXGVF1uAY15
         6BNKwWg7xI8z64uFY+H3tgM68Apg8Rf9UthmEuSOWXvZE9LoNvW3vt8LpEHJiijC9XUx
         jikQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3+vtNUN7vVCjJ8Fco4Kjfiu3xGDa3/V1uX40FMYDNPpuU66TXL7msocqMWAlPyXTBIpfWaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yye25cOXlG9ziYuT7cymAbd8bpAQBfV7aKBqwRWDFDFu6Rj84bQ
	53pFGdOmTVZqwQPawzCP5Ax4xMT9PyawE4pNwVVuiYqVtE9yXTH/rWLusQ8IyW4Pnbc6tPYEf3f
	vxA==
X-Google-Smtp-Source: AGHT+IEQIRfv5MQyN5FPXlDH0jiZdTHciPaHWXw+Tn7fs2rQ/C2nsY1CH5202uPXIoXMn1X9vHNvV8pVCeI=
X-Received: from pfbfa9.prod.google.com ([2002:a05:6a00:2d09:b0:739:8cd6:c16c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2442:b0:736:6ac4:d204
 with SMTP id d2e1a72fcca58-739e4855dd7mr5053725b3a.11.1743795594255; Fri, 04
 Apr 2025 12:39:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:19 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-5-seanjc@google.com>
Subject: [PATCH 04/67] KVM: x86: Take irqfds.lock when adding/deleting IRQ
 bypass producer
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Take irqfds.lock when adding/deleting an IRQ bypass producer to ensure
irqfd->producer isn't modified while kvm_irq_routing_update() is running.
The only lock held when a producer is added/removed is irqbypass's mutex.

Fixes: 872768800652 ("KVM: x86: select IRQ_BYPASS_MANAGER")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f94f1217a087..dcc173852dc5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13569,15 +13569,22 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 {
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
 	int ret;
 
-	irqfd->producer = prod;
 	kvm_arch_start_assignment(irqfd->kvm);
+
+	spin_lock_irq(&kvm->irqfds.lock);
+	irqfd->producer = prod;
+
 	ret = kvm_x86_call(pi_update_irte)(irqfd->kvm,
 					   prod->irq, irqfd->gsi, 1);
 	if (ret)
 		kvm_arch_end_assignment(irqfd->kvm);
 
+	spin_unlock_irq(&kvm->irqfds.lock);
+
+
 	return ret;
 }
 
@@ -13587,9 +13594,9 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	int ret;
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
 
 	WARN_ON(irqfd->producer != prod);
-	irqfd->producer = NULL;
 
 	/*
 	 * When producer of consumer is unregistered, we change back to
@@ -13597,12 +13604,18 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	 * when the irq is masked/disabled or the consumer side (KVM
 	 * int this case doesn't want to receive the interrupts.
 	*/
+	spin_lock_irq(&kvm->irqfds.lock);
+	irqfd->producer = NULL;
+
 	ret = kvm_x86_call(pi_update_irte)(irqfd->kvm,
 					   prod->irq, irqfd->gsi, 0);
 	if (ret)
 		printk(KERN_INFO "irq bypass consumer (token %p) unregistration"
 		       " fails: %d\n", irqfd->consumer.token, ret);
 
+	spin_unlock_irq(&kvm->irqfds.lock);
+
+
 	kvm_arch_end_assignment(irqfd->kvm);
 }
 
-- 
2.49.0.504.g3bcea36a83-goog

