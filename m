Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A81022F39F
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795653; cv=none; b=VRxbnut10ctJGPyKcgCQNvD70Lg6sswp6AzRu35g5y0KkdEvTAF7uEHqICNnF1ZM+VnYXwgB/nE471Sz/Osfmn01LeWhOzmAcQWbVQz3V3BOwbOoHOYGhQHzWPxlykw7l7AdC9ZmCBfr2xp4nDpHWI3kId52ZFXekSlybYQ1WDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795653; c=relaxed/simple;
	bh=7/g8u2TqM7J8Cn/U12YGDIH4z8F9epXVF7IH/1LlmGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YwbsJSNfvLcqUafkiNdCLa777EvaiS0lfAHHFoR/kSLED+CrJDCSawlDf4NakK9E5Gst7L2htKw+yZBxH87OSaHVsHFFBwRnj32yGenqUuIrr8c4/166dr8z0mB6QV5fj+cBhWQwyiFRteIbTpxhBzbK19jjPN1DU1kRni8SsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JFx/SDXL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JFx/SDXL"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7370e73f690so2789397b3a.3
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795650; x=1744400450; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SjSWA34yg4j7nAkSg9OWc1nxrjTv2EBF262ygp4BvLg=;
        b=JFx/SDXL1kBUOKxRH9Pc+Fk0tvtElAGTSBBKNW4YY8iy1UDaBXlZJoonTwSpA2vMnM
         9kbrkn8ieOr6JrAt0RtLxFeFpM5TTOJVOUAA46dzk0keeM3hGTEk71u5qxiIdrpysnfq
         qReFAdtXEGpY2hu5p15Fh3mvw082L2dnWAtZymueRLy/xeJohH+k/uncHCNiKtQh0qRv
         TVMA5G8ZTl6JWZVPmHZr5Gw4fEwn/4GR8ORjTwSE4gnchrqdRo6Y8BRKnTdh40SOOido
         RduNI0LqlvvRANrF5ahKj2u3PmfXkAKugmEkiCOhcMREYVemL+MwBeQOBZyPCA8dhnhm
         abDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795650; x=1744400450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjSWA34yg4j7nAkSg9OWc1nxrjTv2EBF262ygp4BvLg=;
        b=q+4D73k1+uhKsBNVzj3K24ENdJJloVpvEknYbbGidqRJinAXDW0imgIvsnPoWktP/J
         sVKFcgjNhqI2u8nBswj9UvHSkHLkLbE8pRNoUD4dmMm6kM7FY1Hnq86I9kxVLsIrXeFZ
         T4JGfz456Ca6sZBUf8AMOrWWlDnS+H1obCxSWHegzCHteoDpPi3HANTaWO9O1og2lSPg
         BfZBOPaKHfit42+45aQOLtHhW8ozAjt5Y3zw1k0eI/wI0vDwqQVFDIx8msAzqFuKimwe
         d9ol+do0mbijSlCnb5rjVzJNB/hA5k92VlrKheGxjVXj93AS3LuFAD79hjWWeD3JKnB0
         wAyA==
X-Forwarded-Encrypted: i=1; AJvYcCU+yLeDedDb5bzp5/mao6jN5ZQfZ/n9m6lCBXvsBoLs7EuNcGdCeSz7USOvBjSnTtbcy1JH/w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3xJc7Oqp7vlbYvDn5SFus/KNWhy5oCvsRmq/a2P3poUpcWz23
	cocjVIPv8SY9eUwCKIdAwyPnPQCYA2SNrEitEo+wkK6bsRm/4fzvtJ8ok1Rljy4k+lA18KC16o0
	U6A==
X-Google-Smtp-Source: AGHT+IHbhyhf2PL38jR1CfEUWzgJOUIR/lwrsr+RqHeIsaC+HvnuthN2QMdbVQyQ8EZYibpHmZF2PVBlImU=
X-Received: from pfud4.prod.google.com ([2002:a05:6a00:10c4:b0:739:8c87:ed18])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a04:b0:736:3e50:bfec
 with SMTP id d2e1a72fcca58-73b6aa3d9b9mr864255b3a.8.1743795650653; Fri, 04
 Apr 2025 12:40:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:52 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-38-seanjc@google.com>
Subject: [PATCH 37/67] KVM: Don't WARN if updating IRQ bypass route fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Don't bother WARNing if updating an IRTE route fails now that vendor code
provides much more precise WARNs.  The generic WARN doesn't provide enough
information to actually debug the problem, and has obviously done nothing
to surface the myriad bugs in KVM's implementation.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c       |  8 ++++----
 include/linux/kvm_host.h |  6 +++---
 virt/kvm/eventfd.c       | 15 ++++++---------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a20d461718cc..c2c102f23fa7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13666,11 +13666,11 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	kvm_arch_end_assignment(irqfd->kvm);
 }
 
-int kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
-				  struct kvm_kernel_irq_routing_entry *old,
-				  struct kvm_kernel_irq_routing_entry *new)
+void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
+				   struct kvm_kernel_irq_routing_entry *old,
+				   struct kvm_kernel_irq_routing_entry *new)
 {
-	return kvm_pi_update_irte(irqfd, old, new);
+	kvm_pi_update_irte(irqfd, old, new);
 }
 
 bool kvm_arch_irqfd_route_changed(struct kvm_kernel_irq_routing_entry *old,
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2d9f3aeb766a..7e8f5cb4fc9a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2392,9 +2392,9 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *,
 			   struct irq_bypass_producer *);
 void kvm_arch_irq_bypass_stop(struct irq_bypass_consumer *);
 void kvm_arch_irq_bypass_start(struct irq_bypass_consumer *);
-int kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
-				  struct kvm_kernel_irq_routing_entry *old,
-				  struct kvm_kernel_irq_routing_entry *new);
+void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
+				   struct kvm_kernel_irq_routing_entry *old,
+				   struct kvm_kernel_irq_routing_entry *new);
 bool kvm_arch_irqfd_route_changed(struct kvm_kernel_irq_routing_entry *,
 				  struct kvm_kernel_irq_routing_entry *);
 #endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index ad71e3e4d1c3..7ccdaa4071c8 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -285,11 +285,11 @@ void __attribute__((weak)) kvm_arch_irq_bypass_start(
 {
 }
 
-int __weak kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
-					 struct kvm_kernel_irq_routing_entry *old,
-					 struct kvm_kernel_irq_routing_entry *new)
+void __weak kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
+					  struct kvm_kernel_irq_routing_entry *old,
+					  struct kvm_kernel_irq_routing_entry *new)
 {
-	return 0;
+
 }
 
 bool __attribute__((weak)) kvm_arch_irqfd_route_changed(
@@ -618,11 +618,8 @@ void kvm_irq_routing_update(struct kvm *kvm)
 
 #ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
 		if (irqfd->producer &&
-		    kvm_arch_irqfd_route_changed(&old, &irqfd->irq_entry)) {
-			int ret = kvm_arch_update_irqfd_routing(irqfd, &old, &irqfd->irq_entry);
-
-			WARN_ON(ret);
-		}
+		    kvm_arch_irqfd_route_changed(&old, &irqfd->irq_entry))
+			kvm_arch_update_irqfd_routing(irqfd, &old, &irqfd->irq_entry);
 #endif
 	}
 
-- 
2.49.0.504.g3bcea36a83-goog

