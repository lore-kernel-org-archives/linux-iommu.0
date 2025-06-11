Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3825277CA1
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682100; cv=none; b=fugz38Ux3cCa7t16b2UP4X1QH78wOGAax9TuBNCeQgZLpw7rabpG++qyc1wtfr/7kwj4xD6w0RfU62JgsRH3wBP/p1dlqAPGxzFh6PxeJGyiDVWwH6M9uyRHdnjWM2zdaqIS8178EiTcbyEYSkrjQMcdX2kYnysIReV+hs1SeQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682100; c=relaxed/simple;
	bh=CIkDX4NeyEz+bCplX5aJPQm6IavTLLLziMyDsf7mnvM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TeGr5uH7BHjr7dYwIrH4248AEdLNQxtLohhNzafVzQEyhmj0ebOjvAjWxks6Ox66XK5a/GXb0VQzloX0SzREA5HV8YuNwMznwqYVCh7fjdn3l+n7OO0kZ7Re8gjYa3QNZpnRzRN0mWMThbyGG0WZJY6wcmK9beZsQ7p0BnQzYuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XA+ojTAp; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XA+ojTAp"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31366819969so290616a91.0
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682097; x=1750286897; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OBsMBd1i0baUKewPQxLHxyy7sMDVTDzHxDH7w12EKXQ=;
        b=XA+ojTApw8dkHjNNTP0i1dMkx79vqM7yoNuvtOwt8eyYe8wEfKHbfICet9aNhwjv0M
         RWHGikokXN1PA9jNjlZbMm1dBaunf01z428UhUhJdFaP4TvHNto5826+CIU9Ceeciceh
         ppT5F2h/ItcRObO7A0Tt0+UOSMNn33/bODyhnPD9z9oBikPFQ35yPHy+Ncxu9ZzEOiiM
         6UlAWaLVR82eDkSw14BmCX0duH+WjVO5Vr6GJPSYQwKltpq1tF+rTVUCftbMaD0TF92F
         L+cZ1lorjMB7Dk3A4tO56HiN0nAPxjFjG2V5/L1JNaVOWJ+Q/z2IqxOSlStjsbxhoQ9C
         mgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682097; x=1750286897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBsMBd1i0baUKewPQxLHxyy7sMDVTDzHxDH7w12EKXQ=;
        b=mBIoYc0Susy4Lc2NMK48RqU9YHXOa4+KCQ+ok/s4kzuROa2jhhQpMrZnUjtaeEpzmQ
         zx4Lilvx5iVx/LfYktLIrUvuNJG29/zmUZbtxR7JkY5aKAwvMeRGZ2Ws8QbJDmrxcxbw
         q4mqprcTnleVHe2/se1R0Lk/jZXBHp+6T7NBuFGAoTsBty5ZtDpUj2SvfOvJ5jSRYnGc
         LogkbFSfacw/Rn9coO5VwYBmbnlC8gtnqnNcm4O/f+BY46HtPBKgtwR7OIlELFLW65ME
         U4CMgtM2HAHVY0zLPrrVMkIlKvTj3oEbX2Qjx4ur3U3NFpCZejufi3gW5Vu9PaewPApG
         kWMw==
X-Forwarded-Encrypted: i=1; AJvYcCWhFv400rQuAqezCshp3/gfBk8CveKUpJL8nPUfmcjRN10ctFs+NBSSFKbBNYuhxW8GCKQ4Ug==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLYFDoS3ZW5DP9B1MBNqCqHucb7JxcVWXKBX7esdWObNjfeWId
	T3gC4YilC5nWnLt1qHnOASx7/QWfA1r3AV8ZK46fCPXcGmYJoHsP3IditwEHDfuGg9fDooB2Z58
	hnl40jA==
X-Google-Smtp-Source: AGHT+IHBEy8+OKJmY+A4zi/3hTeqSjfA/ttP2bWoyN5/kshTJAQ27HG4vGJt+llsgPQtOFs3CpzMzSvtcZQ=
X-Received: from pjxx16.prod.google.com ([2002:a17:90b:58d0:b0:2ff:6132:8710])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e8d:b0:311:d258:3473
 with SMTP id 98e67ed59e1d1-313af12a361mr7057487a91.13.1749682097123; Wed, 11
 Jun 2025 15:48:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:50 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-49-seanjc@google.com>
Subject: [PATCH v3 47/62] KVM: SVM: Process all IRTEs on affinity change even
 if one update fails
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

When updating IRTE GA fields, keep processing all other IRTEs if an update
fails, as not updating later entries risks making a bad situation worse.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 6048cd90e731..24e07f075646 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -849,12 +849,10 @@ static inline int avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu
 	if (list_empty(&svm->ir_list))
 		return 0;
 
-	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list) {
+	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list)
 		ret = amd_iommu_update_ga(cpu, irqfd->irq_bypass_data);
-		if (ret)
-			return ret;
-	}
-	return 0;
+
+	return ret;
 }
 
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
-- 
2.50.0.rc1.591.g9c95f17f64-goog

