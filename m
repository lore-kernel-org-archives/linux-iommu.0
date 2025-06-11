Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E966277C94
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682102; cv=none; b=h/Y08WXWyNvTbi8lcXXWKubnO3E3DhuBkO0c5rMsD6SqT6A/Txu3CooTF4RwTPwZ4N72mz1zYFaitYlESY2dzKtwmq+4raFoJHUy6fPAiYCeVgrFCXFuZpL5uHTyGo7tCM1wnLQC1lIKgHJzky0mwi1ajd4sI/mB+SufNUNRgwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682102; c=relaxed/simple;
	bh=NAxK4l2+eFBLeYnDW4awSCXzYKBMMUzoga23UMMP12s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gikHurdILsfkRiqzbkka/3zkdLJjiWJYeTuDUSpOjYOA197TdPxYuOHA4IsRw+2pzsSxWxRxTraT4O8srQMNUtd9eVtb7AEcHnJk9v+ddpHA+cZzNHoXv7MlII5waxNyLcOmbOFatDuw2TUDS9DdgXIDuYwXXPO6D6eLWDYENA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eueUOpry; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eueUOpry"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74880a02689so84420b3a.0
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682100; x=1750286900; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4mZdmaSdm4nN9o3kcSmnCQqm8oVomLbyxtnfKwvcz+Y=;
        b=eueUOpryV8JRlGTSaE/NxdNHhNz6r8kFwtREL1SRVetXlhMIX+LQYUtgFpeUpmkUop
         OlaMBlLe048DqBwri0Io2g+XQFkgohE/kxipQ+vlk4yM0oQxbzaaxIvO0ba1yzYvpA0c
         4z1oXKvLvPi/mdja37/DXziXzoZD7ajBwN6acO+nXN+I5WEbQDAp193sQY6HFlE+rLFb
         m2X9Zq4fDc9Lnt+fk41PcFWTfSBZmNuwyjDz41WZcunILVHsZI9ApDQ/19o7m4IEBrNb
         Yz9JxxIIiyxwBR9i+sUCbkggSE+1Ba8LSOiwOHk78UCY6Q96MRNjO1DUPmz7SNMwN2fx
         VMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682100; x=1750286900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mZdmaSdm4nN9o3kcSmnCQqm8oVomLbyxtnfKwvcz+Y=;
        b=jSOV7WBzriaakBtzIOiVusa+yR2x13s/Sd+qhlQqL27mv03+pFBDdegrxo2QTLNky0
         YtHcJqy+gwn2N7tbek3LqXMPIROKoZV7PQRDm8TYeBJicWi/UmEwC8ndWHXio6YolcuR
         1Rg+UqVrOWnW6lBokYaM3Rvl60kLg7ZwCdTSAwiVBqOWZTzY3tZLnUIAgHiZRr0d59e0
         U1J8gqssvKZN7AtmKQMri5zb+s09XFVcEUgSoFdgULKNW8E40Xrz5D3WIeU9jiHXMHlR
         hJpwJsYvPve7VMH+dVOye/p5HX9yZ48ceKy2DLoicid0N4X7VRj9ZTeXPzRK9AP4Biew
         X9YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfXai3PfQlHiG2vzYBX2jSVr3nuIVKggJsNxTm5+xEdFWu8ZKxGhwvhWevixwtyx7Kk4bHIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrtY5SIQEzAPQkzYQHWDuKCANHQSN9xKRcFTgxBqA3GoD1e/Ay
	/v49C9jTT55+FYyU1PH6rahQWG2WbUOstLBSVFBZjA1cT7YpCFBpDR01aqSkUTaQQNSaAiC7hjc
	IIvlsgQ==
X-Google-Smtp-Source: AGHT+IEg+AS8QoF49j7jfT3TPcNYHFW9Ujm+mi8oTh+WHeby3lk+SesimVareIU6PzlpR4BED7xC7oESYEc=
X-Received: from pgn7.prod.google.com ([2002:a63:d47:0:b0:b2c:4d7e:b626])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2d43:b0:1f5:56fe:b437
 with SMTP id adf61e73a8af0-21f86727b69mr7698366637.32.1749682100654; Wed, 11
 Jun 2025 15:48:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:52 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-51-seanjc@google.com>
Subject: [PATCH v3 49/62] KVM: x86: Drop superfluous "has assigned device"
 check in kvm_pi_update_irte()
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

Don't bother checking if the VM has an assigned device when updating
IRTE entries.  kvm_arch_irq_bypass_add_producer() explicitly increments
the assigned device count, kvm_arch_irq_bypass_del_producer() explicitly
decrements the count before invoking kvm_pi_update_irte(), and
kvm_irq_routing_update() only updates IRTE entries if there's an active
IRQ bypass producer.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 4119c1e880e7..45cb9f1ee618 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -517,9 +517,7 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 	struct kvm_lapic_irq irq;
 	int r;
 
-	if (!irqchip_in_kernel(kvm) ||
-	    !kvm_arch_has_irq_bypass() ||
-	    !kvm_arch_has_assigned_device(kvm))
+	if (!irqchip_in_kernel(kvm) || !kvm_arch_has_irq_bypass())
 		return 0;
 
 	if (entry && entry->type == KVM_IRQ_ROUTING_MSI) {
-- 
2.50.0.rc1.591.g9c95f17f64-goog

