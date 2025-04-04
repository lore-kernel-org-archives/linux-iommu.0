Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062E24397B
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795682; cv=none; b=gVA6tKtLEukrWjq0yC9kcKbr6UxkKBn3BcD5EUhmFeTBQxp9TewdGFTCQ2YuO8X/dA8tm2abh3FBgloj5YzGR9UGAAExFP62OWwRmx3MJHAWmvLeHGEA4uPzvZQC1BcNw6CDOJEnc0mn5FvM22qrRgKInBrRHRjdef6iejv0sxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795682; c=relaxed/simple;
	bh=J9UHey9VIc8H5csAImsrOgY9HzHt7VovS5PXam2uYYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Na/x1GVcArgV0RzD/XRwnVS/TzeSrLvnDOG55P/9hLzEthwm61d8VuaHbk5WyNyMKGja3VmALe0QvW6vvaRUmYzVipR7JumdAopB+ituiahUH5ePAzHsYEz11SjrPu9PsMcmaEpQLLek/CpfrZ3j5NOdDXYCbXpSWxZCfYCWUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5Y2Um2/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5Y2Um2/"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c135f695so1931734b3a.0
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795680; x=1744400480; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IDnMFjaPTKzyH9hORg6vpYe0KsdQWNftCfPGoTAAZqo=;
        b=T5Y2Um2/QQTleNySebIOu34aPUEOMcZbiOWkyqr++GtYLJzOulNBJlSdzpf1+TgvX6
         3fUWGRW54nWmoAR1LK7fPYW8eSmCWtGDdoz+1Volu/B8rnXNgDoe5ntnR906eCgIyQxN
         cNYU494jeaz8YeXZ++F6iXO1uBzFXaod5Ps+cN68X3W7+YaIbLvwXoL/nfhSY1CLfv+4
         Gyvu0X9NEnklxaTlHXXi/llloyHMC+wzu5TNZHAVm+T6bOOISQlHrUruRlb11h7/j4EV
         5p62M7qzf8tiO+A1GcsRj3eLhH5qR+fZhnWZSEjD5VtMPb5COckzO2vm2olDNBXpB0hr
         0r2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795680; x=1744400480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDnMFjaPTKzyH9hORg6vpYe0KsdQWNftCfPGoTAAZqo=;
        b=X5673Mc43syMwuqvom0Xa2N4u5qED4PgWeLjehp6rHFfLBo9y6RU74DJXK/qITGCGG
         gNqrsKmHTgmwaL+LglM/PSMcT8yKB41MnNIDZZADBPrZ7rcSmMSkrJ/wZgWqADsb0fXo
         ewF0MD9LX9kwOzRailKrEMJ3Y0sctQWpA2nv+kuICTHCXHuqMCOcIxADpD1+ICEkgcE4
         oHqdQi9PxhTP0toK4cLKk8wpB5rt7sGu8xVLRbDVr1jxaW+uVbTPt1+PVbODL/x6uvOC
         N/OfRUALFjDATp/qb8TvU8JJFiEmL4ScmYhH9XoBCMn8XRgQbaEX7DbYHg1MXbmNEMLT
         T2+g==
X-Forwarded-Encrypted: i=1; AJvYcCWBTJpMpQrG07BScv50qA9OP9p+llK/bR38O+DA2IK2LdUkTDEI2UV53aAUzZY4geL6rw31jQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVJGqqht6aFDkz/H4AQ5y09FK6mRxtERHih99WZQPS8/a8Qd4z
	a8UjdwZBdpl3tTqdqONWcgomX9nv2bmCmhk87gt6TTmOOpLdyooOAKTCT404sFdBni3P7Z4cXOo
	I/A==
X-Google-Smtp-Source: AGHT+IFagPC1G+waMHkD10dBI62GEqlh5wfS6CoEd/HxTrdq6pLQQhec1FekF/zXyYVkQR5iehzlh0kK5pU=
X-Received: from pfbhw1.prod.google.com ([2002:a05:6a00:8901:b0:736:7da2:53ab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1148:b0:736:a682:deb8
 with SMTP id d2e1a72fcca58-739e493138dmr7548244b3a.8.1743795680602; Fri, 04
 Apr 2025 12:41:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:09 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-55-seanjc@google.com>
Subject: [PATCH 54/67] KVM: x86: WARN if IRQ bypass isn't supported in kvm_pi_update_irte()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN if kvm_pi_update_irte() is reached without IRQ bypass support, as the
code is only reachable if the VM already has an IRQ bypass producer (see
kvm_irq_routing_update()), or from kvm_arch_irq_bypass_{add,del}_producer(),
which, stating the obvious, are called if and only if KVM enables its IRQ
bypass hooks.

Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 513307952089..d05bffef88b7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13577,7 +13577,7 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 	struct kvm_lapic_irq irq;
 	int r;
 
-	if (!irqchip_in_kernel(kvm) || !kvm_arch_has_irq_bypass())
+	if (!irqchip_in_kernel(kvm) || WARN_ON_ONCE(!kvm_arch_has_irq_bypass()))
 		return 0;
 
 	if (new && new->type == KVM_IRQ_ROUTING_MSI) {
-- 
2.49.0.504.g3bcea36a83-goog

