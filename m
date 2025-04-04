Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE93A24397B
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795684; cv=none; b=he1z502gyrvJfARcFeoGA9qWVO5ZZnWUMNrK30AQmvDySBogJPx1RAJbHpcfHHcCWtQHzSx49+RKSBT3acaHQbLquAwfg78/bG2YKyhvoW46SI/ipD/CQyNT8AnJ9roKupQS2I/qv2w2nzBfw56i9YMSqBDHu/AMYAXGkmrxzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795684; c=relaxed/simple;
	bh=O8Jtgnd04lzwalcRZpXtJREHuwR/9U8Wy9xXm5Q/t8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ei3TSvpaXkbk3UuQKTP1mqwg1SEpWIVQGOq1i/cCYiS8rI99HViUqx0M+qGIjKaVhcxSxE7YDjqQQe31ayza7mpOO9QEJrOCyvAgfVQlZVnpEY1uuE8MJVVSqId5JnGlPvOPQS2QlegM/10DX9OGxi2cpezydmywCcIszByMXEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4x2fghqS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4x2fghqS"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af91ea9e884so1321379a12.0
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795682; x=1744400482; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5ipvbDW4TsHmSl/et8/oy0jhI2aY6XeoFvTlaXxC+Z0=;
        b=4x2fghqSRmxp0wKbveZPulkGfGoOt0YxG/x6/WRG8+tYyRgmw4u80SgsLPVmlNpGOu
         XJKk+5ZT2K5FqYR5LSLuIU/LQltOSTo8Evxm86ndseTjAny8CaM0rbAzeMjrZICeLk1S
         FGH1Ve4Xa0TeN0uKDiDnW5ITA1Z6l8xkEsqyb9CEscLbi4JHieUyDFwEP7CDYUMtoLwZ
         cWD0AS8w78HaVKZdO7ZSf6IFpdcVdYeYh+/GTQ9wlNhvLXzu5GQKTUG6Xigv3o/jTmQx
         tOegQTf7gfQIpYW5mLzjcJis5xTpHRYF7TcFBfJm6i6E3IDEFFiOKKGPDQoX+NX2MFIc
         FLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795682; x=1744400482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ipvbDW4TsHmSl/et8/oy0jhI2aY6XeoFvTlaXxC+Z0=;
        b=AVNSEwX3JjNt8yImjM1GwdFuCK+QUmHp5rHSOeRH9eY4jsHNF/nC4GKrJw0efzMrkR
         kJS7rzt+fFuKIKt9FKDPj3oJCf/syPCevZGkKAywH6TdrySSCd8SSAp2RrgCaQqkLXN4
         OC1R8FFUVL+nuwad0MwOiRixZ49eQzRNYIEgEK97Wa/WSd8pLmLlKvGh/2Ra7n8J5uKt
         Uuipn6q5DuGzaKX1Oa7iAfesm0Nu+swZ9dt7B2/MolyXpjWBL8G6/y7oScJtXQbSDWAS
         e/uU7tWvFq65KzRYKrLDiW8jnI7lgN6+G2fDs2lPteax5n03wLdhfLULP4Xx2VmeAJil
         seMw==
X-Forwarded-Encrypted: i=1; AJvYcCX91HNyw4b7Bx9V0sA18U63xeJML5mcQ4zmTZb+U2FB1tI0QV5cnn9+Z+IciwGaLf0eB/j9lg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfG3WrT6cPpGYqoGROtNWe1VKHowR0NIBJynEURw3r0Ce8eHGx
	foRsRMt9y2xpE63dv2Na5/Jd+K6UPgF0+sbBktGTLGklalsXJJKKGgwQcZNjXtVrjMy81gC5JWs
	ojw==
X-Google-Smtp-Source: AGHT+IF8vEX1BRq7iqbtezxSkX3cXerhUEkRR8Wpf5vTHNdIS8Aw+5Af2q/0JmJ4ODDazjlc49NfshTSImw=
X-Received: from pfbfb23.prod.google.com ([2002:a05:6a00:2d97:b0:736:47b8:9b89])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef4d:b0:220:ff82:1c60
 with SMTP id d9443c01a7336-229765d1b70mr135066285ad.14.1743795682327; Fri, 04
 Apr 2025 12:41:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:10 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-56-seanjc@google.com>
Subject: [PATCH 55/67] KVM: x86: WARN if IRQ bypass routing is updated without
 in-kernel local APIC
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Yell if kvm_pi_update_irte() is reached without an in-kernel local APIC,
as kvm_arch_irqfd_allowed() should prevent attaching an irqfd and thus any
and all postable IRQs to an APIC-less VM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d05bffef88b7..49c3360eb4e8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13577,8 +13577,8 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 	struct kvm_lapic_irq irq;
 	int r;
 
-	if (!irqchip_in_kernel(kvm) || WARN_ON_ONCE(!kvm_arch_has_irq_bypass()))
-		return 0;
+	if (WARN_ON_ONCE(!irqchip_in_kernel(kvm) || !kvm_arch_has_irq_bypass()))
+		return -EINVAL;
 
 	if (new && new->type == KVM_IRQ_ROUTING_MSI) {
 		kvm_set_msi_irq(kvm, new, &irq);
-- 
2.49.0.504.g3bcea36a83-goog

