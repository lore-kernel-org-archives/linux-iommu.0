Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4B2D3224
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962091; cv=none; b=JATcTC1FS4EX/RL0uO1VckBq6Yf72OW5E/OWlAyMZQp3UH1Rh4AR4IH0VA3Atg05tzPXtv0O+TptD4F3JhFzDNK5STpvZqf4mx7+dTVpuC5Kh2JxdEom6mizUnAxdi1nm51sHNBx5A60L8i4y+paDzZs5PF71RACtnFotdms/UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962091; c=relaxed/simple;
	bh=AMRZmDoiaK20f+IpNDlcqYN2AhFBOCz2nspxKJfmrw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NOT54EYurCh/9weZ1usxwuKYWQoVgwY/y1EZ69qwjNvUtp2sTW/I3aCcnXaeqpBs23UTFuxoqxwWnrqpeMavsu62kUvFoHmwkLejYdF+AZXb43mhT8V2GveE5SmsyofDemHr8LdVtY4kyTAbt6HPEEczn/4Cg2EE8v5++tLAeHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEqVBvR0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEqVBvR0"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e895056f0so9231967a91.3
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962089; x=1748566889; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=j1lrYko58mfUpTnz/5S46tcMBGz9QzsmcN9d4X8ezso=;
        b=AEqVBvR0C+FPKo+1TKxF8V22fFb4xwaAyrvZbVhZtecG4mrHi9qppnfBHpWIKScON8
         qBEBC3Es11ABt+0ut3Z5y/iJk3D3Kx6OALsitUUgq4d3AP/zVr9yX/A19fVpikBgx88t
         rl6vJHwdR/2PiRWjz1f4vQnAi28cJYYnVNEStB1hccnBfjjwe3T1fJBrExRics9MoLe8
         ShM1dQbsilpAChD4z+75Szs+1XFPND3ervruR+N401P0E1hexO8aYLcxxrejoPnS3esx
         isLoNv64Xk2iVF18JWbeCAd9YwyeO+ZLGTtTsaGMp4npoUptVygrDPx9qSyj2ENHxVdD
         zyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962089; x=1748566889;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1lrYko58mfUpTnz/5S46tcMBGz9QzsmcN9d4X8ezso=;
        b=Q+nv34FehioNJARx33CB5poSmFnrbGP6cafJz4U3YvaDausmJRKT9P2gCIj9oIr2/e
         rFlgwDjHiBWUt70hrRrTpcjziwl3M08vtNq+imv0jA9xIc9lNMNGjNcbIxyuC3sBQLMH
         rEXPa/Q9UbVTgiWYs2B9n6z9j7kzw4XhjXDytswHonNNrwSZzsaHutIPSk6/elXuR/Sv
         9mlgWe6dM+wVjbBoAJTNFn3i3Q9X04oPRec19saaJkxDaAZd0GVsBp+ZqJMlckA8lhX0
         7OUWRlH3swtkSzHFTa1w2JLkMU/XMsxspYzpt3KujsJ2pu8WBH1Vg1OAdUEElOeFA485
         YJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+BS7YpiX2C2i8MosqFTtGKuEKHNnW8EHcyUn5FteLXb6ksKsFrCAmU1ZQdEFb9Ax0p1oibw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3oQFWez2NuYZSzo+ItLcjrOdoDVtYGTCeEWQ9kaGXgCZysre5
	MoL+QzEdY4gcxd/X+6eaCTPLh0ETbaPRv5/hmrXOftM2R8iz/3+AIo4h3qtMkZBYR1/bcVVo5Pa
	QQiYdJw==
X-Google-Smtp-Source: AGHT+IEiUGctmed5Jm4/azl2/SL+jFNyFyoqxOj4Sx+0n2i6EPF2TpT8R/3hGNPh8Oh64n+PfETUY1WDfs0=
X-Received: from pjbsu5.prod.google.com ([2002:a17:90b:5345:b0:30a:4874:5389])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b8d:b0:2ff:5c4e:5acd
 with SMTP id 98e67ed59e1d1-310e9740a23mr1736244a91.35.1747962089593; Thu, 22
 May 2025 18:01:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:52 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-48-seanjc@google.com>
Subject: [PATCH v2 47/59] KVM: x86: Drop superfluous "has assigned device"
 check in kvm_pi_update_irte()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
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
index 19fa3452d201..904aac4d5e08 100644
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
2.49.0.1151.ga128411c76-goog

