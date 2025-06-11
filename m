Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932172E6D18
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682080; cv=none; b=G0Z0ncGf6wqOe5iDd7Oy2eHj8OSUNXrgnlE9FX8leGYPHZqPsARwfrFRyU5ZotgfOQvrvaHdoUAgWf6xGFFNXX3tiBB8Ypewv2W19uq1k36djkhSzIewp0Yjp54HmC4+l9AGf8qMgBL8ZkAz921b7GzmJje66MqnZ8kjEMoZu8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682080; c=relaxed/simple;
	bh=i42G1yIKz6UNXah+vwwlH6gSGjE2qsFjyhLN1QFtXLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oVVUTez2kbxE6NkGqnC8t+31e8dBaesKhRicjzVU9KYhTZ9QBw5uEjEfjY6GdYWC5Wh1cFfYxlsFlraPhYzG8NCLu5cwPYhuJPjofXFLJ6oz5ejmg6B6kyBw0DJfCJLzT5xhq7qsrkV3hPl8wvFYKPyXrl2XEk3GuwTaYgr5XGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pwq7eCZi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pwq7eCZi"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31215090074so514699a91.0
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682078; x=1750286878; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aRbYdbPjfnXABceLxP6T4VwYA6vT74WXjV6qwqEpIRA=;
        b=Pwq7eCZi3xp6CtA4bde+mTYJr165Omw0rUT9X/ERC3ixgPptH/xzQKz51beuLLmJTz
         AoZfw5Rm+xM9uhFzUtKs24cKPpIYKwNoJ+pjIO1EsFYwSd7OeKo8btPvVaQt0Kr762KX
         GlF92Nyi0MmCRSUZI/j0wGVs6ApKiiGnFf456zYj2O533S/YY/6fg5iSbAOl/IOvGu2Y
         hHQF6AGMR/aEiYCKLGR8ykOEAvYQfVuhtBdMuuJUiondePLrQ8kp5VKn6aXLiijdlqoj
         K+8cy2jG8iZkQXSM2QKtIvhOl5CyYx7j9wcr4lCPu2IRa+zyjwrEqWK5jYOHi6cZTzvM
         vtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682078; x=1750286878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRbYdbPjfnXABceLxP6T4VwYA6vT74WXjV6qwqEpIRA=;
        b=kwTbpwruKSzVDXKYPrVw8IkwgZd9yQGoIQ5yk/MyXd7A9wane2B0TlhaGvMV2hU15D
         ApsZNlaLQiL1es1g5njLvjw4ibSw1bjH0XOuMcA90MmR7mw20dX6WXAipgCagb6UBs+V
         pW7K4tZL2Nfbq24G9tn7WhNjW2v1kzJMeN+hbTUzoi0ANNUSMd/2a3KiDJQjVhvrM608
         mmvSuNPi9/PWfi6SvKHVs+A9atpZAmCJROg4TMmZrj11N5kIsfQXDv4vOrNooANqfipd
         Sg08qaaL53844LZhyQRtxA+l/Q7xYvZ6VyyLV/D6fNzpOJZTfLPuIvlNCdBrWZvihytp
         ltxg==
X-Forwarded-Encrypted: i=1; AJvYcCXVWPgHLPcFad1bfJ95044ztTWREaYfAZp6r1X6jpYDuQI8P/Fm3FnOlP33qhem8gs4ZECR4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHhLi74WqhYeF0dZgp+Gx1tHFALbrgDmcFmD1X0XVvvQhMH+8h
	vbknsikKFlDXQgrHyToFudNXv77mv/SbLfnVyoSRUpLzTZbg+UE0G4LBl+CeTcecouqCLtKgp2G
	hxcegjg==
X-Google-Smtp-Source: AGHT+IHb+Zv/4CcMgQT32iC66PSsxBVu4fJyVtFcuECRvVY6yAdTVQgUPpLO4I1bFnUpFw9nkCh9cXpZUsg=
X-Received: from pjbkl3.prod.google.com ([2002:a17:90b:4983:b0:311:c197:70a4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ec8:b0:311:a314:c2ca
 with SMTP id 98e67ed59e1d1-313c0667dbemr976034a91.6.1749682077795; Wed, 11
 Jun 2025 15:47:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:39 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-38-seanjc@google.com>
Subject: [PATCH v3 36/62] KVM: x86: Don't update IRTE entries when old and new
 routes were !MSI
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

Skip the entirety of IRTE updates on a GSI routing change if neither the
old nor the new routing is for an MSI, i.e. if the neither routing setup
allows for posting to a vCPU.  If the IRTE isn't already host controlled,
KVM has bigger problems.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 43e85ebc0d5b..4119c1e880e7 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -618,6 +618,10 @@ void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
 				   struct kvm_kernel_irq_routing_entry *old,
 				   struct kvm_kernel_irq_routing_entry *new)
 {
+	if (new->type != KVM_IRQ_ROUTING_MSI &&
+	    old->type != KVM_IRQ_ROUTING_MSI)
+		return;
+
 	if (old->type == KVM_IRQ_ROUTING_MSI &&
 	    new->type == KVM_IRQ_ROUTING_MSI &&
 	    !memcmp(&old->msi, &new->msi, sizeof(new->msi)))
-- 
2.50.0.rc1.591.g9c95f17f64-goog

