Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CBC22FF4E
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795655; cv=none; b=YY3WdI0f5k9SPWRjino8roRMPYVsdJC4mFRzH8Ngal/Ml4Tm83I1ec9tMmYseERsE8KMqw0c+8DkCXKcpi2UZgyVU4ZFdxy0eemGjBGGB2Uhg/VTrItL5eHppILVeDDTz9uVTqzg6f6Jeo9uymiV+fBmqdbTA9OhMoD33PzFhfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795655; c=relaxed/simple;
	bh=7OuU0INrb67bLssASox/0pk9s35pF8A3UD4uJddP1+8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y631oTVSHJ3ujhX3GXe2Xm/doMqJH9U2w28cVNSPfFy6u2Nu44fvIJg7Zyn+9S2R1ZMCS2ieWswfUjNASn7ZDj4mZyJ7GMypPemIZGy8YJY9zMvH3EAgXJSfs3fxvyNEGqysna945zO5OtLVfI6WgqjYqtvFHafFzTq6HEvucb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYiHGnnl; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYiHGnnl"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7375e2642b4so1762212b3a.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795652; x=1744400452; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=to5q3LlJ1MsoyXzAExk8MPpf5aUTO++pOYAb5QB6TBk=;
        b=UYiHGnnlNpFPlmWJ54ggyjfySppeU4JEi0EkVU4EriU8vFlwZBGqfTfaF5oBszEAEz
         WvRwm+DuTfDle7Qfcrws2RCUONb+KtmLZ8cUw27qkeGYmEKNN81kw1iDgBwA2QnKZYDJ
         zofLV/4dtuUNRiWcEj4ApDeghi5qXzP6ARKK7MuRezMBmsbX+qK9X0X0bf+1F3C7E87C
         sWzzE4s57ZkeqK5gC+YZd3b/YHtgQ7QYYy3mjxGb4MlNhWZ9uraOTibAbhUCXzRq6WMp
         2pAu59uSjESgHTk0luWOP0EaqbS4zDhmJXxo6yGCwzXAvsMUUX5Q5FT16800ZL816FHU
         L7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795652; x=1744400452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=to5q3LlJ1MsoyXzAExk8MPpf5aUTO++pOYAb5QB6TBk=;
        b=H4RxMPhq74kSkFvN348sQP3gOudBa94bee1uGT67uyZ5BcsTQilesL/1itk54kVgXh
         uQn3FQ04e9jRKIwrE/MlrwpEbBNrNMxIKkODaaA7wiC4RdMai4hsGwOCkLHEe4AHW+jp
         EUqNIZTJfyfzgPrVqWYmzoLKEFnz+2ZA/XvqVglp3wU/T6cBZjO1yxV8CP/bPAVjo1Rt
         J0xM9EpGxeZv4lUeittSmK7qdVJtv81jJXKfynEO8Xbb4xceW9Ri4uTSU9tpcjrGPPs/
         z6oK7STl2DlVh3d3jf+ufDRejbYgleZwnsdCWsl1CyUec/wmRBdQaan8dOWzFW8Pjvre
         0fVA==
X-Forwarded-Encrypted: i=1; AJvYcCUY1fyzX0OVXpjiZJGGsiCPre0RTDd/oe5yQowlrj8nYyaWfLiNOH7ZfWxaMSOLxRXz+DyGZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyggWB02BNRsSYVU6mYf4BzCTKt/e7hmjEPKlu9043MnY/BtWU8
	JpD15Nn/E1WuooamTw28Jx165bJy1cFL2QTyj5z/xd4RQAVZA75sg9sGMx+phN/U4yhR5isgCSp
	ocQ==
X-Google-Smtp-Source: AGHT+IFBZzBWaHbwwFG6Bp3HiVISkrZHpjTmYRH9gm8aunapY90POvgNg06gKNVSWknhYJ3e06jWFbrM4bY=
X-Received: from pfiu14.prod.google.com ([2002:a05:6a00:124e:b0:736:af6b:e58d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1701:b0:736:ab1d:83c4
 with SMTP id d2e1a72fcca58-739e46ba78cmr5647788b3a.0.1743795652384; Fri, 04
 Apr 2025 12:40:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:53 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-39-seanjc@google.com>
Subject: [PATCH 38/67] KVM: Fold kvm_arch_irqfd_route_changed() into kvm_arch_update_irqfd_routing()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Fold kvm_arch_irqfd_route_changed() into kvm_arch_update_irqfd_routing().
Calling arch code to know whether or not to call arch code is absurd.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c       | 15 +++++----------
 include/linux/kvm_host.h |  2 --
 virt/kvm/eventfd.c       | 10 +---------
 3 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c2c102f23fa7..36d4a9ed144d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13670,19 +13670,14 @@ void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
 				   struct kvm_kernel_irq_routing_entry *old,
 				   struct kvm_kernel_irq_routing_entry *new)
 {
+	if (old->type == KVM_IRQ_ROUTING_MSI &&
+	    new->type == KVM_IRQ_ROUTING_MSI &&
+	    !memcmp(&old->msi, &new->msi, sizeof(new->msi)))
+		return;
+
 	kvm_pi_update_irte(irqfd, old, new);
 }
 
-bool kvm_arch_irqfd_route_changed(struct kvm_kernel_irq_routing_entry *old,
-				  struct kvm_kernel_irq_routing_entry *new)
-{
-	if (old->type != KVM_IRQ_ROUTING_MSI ||
-	    new->type != KVM_IRQ_ROUTING_MSI)
-		return true;
-
-	return !!memcmp(&old->msi, &new->msi, sizeof(new->msi));
-}
-
 bool kvm_vector_hashing_enabled(void)
 {
 	return vector_hashing;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7e8f5cb4fc9a..d1a41c40ae79 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2395,8 +2395,6 @@ void kvm_arch_irq_bypass_start(struct irq_bypass_consumer *);
 void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
 				   struct kvm_kernel_irq_routing_entry *old,
 				   struct kvm_kernel_irq_routing_entry *new);
-bool kvm_arch_irqfd_route_changed(struct kvm_kernel_irq_routing_entry *,
-				  struct kvm_kernel_irq_routing_entry *);
 #endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
 
 #ifdef CONFIG_HAVE_KVM_INVALID_WAKEUPS
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 7ccdaa4071c8..b9810c3654f5 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -291,13 +291,6 @@ void __weak kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
 {
 
 }
-
-bool __attribute__((weak)) kvm_arch_irqfd_route_changed(
-				struct kvm_kernel_irq_routing_entry *old,
-				struct kvm_kernel_irq_routing_entry *new)
-{
-	return true;
-}
 #endif
 
 static int
@@ -617,8 +610,7 @@ void kvm_irq_routing_update(struct kvm *kvm)
 		irqfd_update(kvm, irqfd);
 
 #ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
-		if (irqfd->producer &&
-		    kvm_arch_irqfd_route_changed(&old, &irqfd->irq_entry))
+		if (irqfd->producer)
 			kvm_arch_update_irqfd_routing(irqfd, &old, &irqfd->irq_entry);
 #endif
 	}
-- 
2.49.0.504.g3bcea36a83-goog

