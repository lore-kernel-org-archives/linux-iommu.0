Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B3B19D890
	for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504020; cv=none; b=ddvccfdG0BnKB/f9eQGhoR/lYv/rGThn0XG8y0sk2/kcZjrATepRrPSt6fUAf9renAsF56dD5PJ7vDXDB7bnbahErnC+TJ7UPmHHHFvKPXWcKQGJ6ke8SSqr3tjOpwZ8BF2NKAjIwm1tdAgDKelatQEoK7HDmvhahW0obTibptY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504020; c=relaxed/simple;
	bh=IU1W/JCdrrhxdJ5WvmQGAwCklNVOFnQBmbNWHuEVJyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cCFi/WypV1XjyQ8kX12lJFJ7d3vWR5nd8tsm1WgCQLFBzq/I0oiuk+QBaPYsM08196jqZZdIZuqSAkfHeep/gcim/YV8vm/29ohlEaNaZSFYS8OkOBgeTtGYNnyT1b3OjVlgbTZiVMMx+M/T9FsKBfqonpU+qYhTw8ekWndsQGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kt3QLH+A; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kt3QLH+A"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-73dcce02a5cso618690b3a.0
        for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 07:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745504018; x=1746108818; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t921yTGj75JTSKsSLngkcs2w5nGrP5C6g0Ynh60adb4=;
        b=Kt3QLH+AO4J/HOp0/pUNAsZAvSKpSTU9bzHFO1k9/wZqETTbILasXKHc9t660L+pnK
         6PShiL0Nx2ckA8j0BnF1ckVgKbw52ZwBKLq8V6MTvW6MumHCD8kg9TU/G0pVq3mj1Wms
         HcCB2SLS0bkTB2h+SqTbLFeqF46YFsoJlMAYJYv3UkmVM3j9OiVuyt6ltvfnYWXX3Ntw
         bZf8z6udJsbw37oxBihiZUJ3N2pzW6bfW8yIrnzcZ31HD6ZxoLaU40gILzKGe8WAIesS
         J7/sLgJz/01eHU/Pibl72s7MNM7UiYTkdW+hC6QhLHOb//gi5JhjxmqiwR9eWN3jKBtj
         m5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745504018; x=1746108818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t921yTGj75JTSKsSLngkcs2w5nGrP5C6g0Ynh60adb4=;
        b=FCiY+ZPQlXw7qtouMGBImauxFryRH/x4pNz26fRQWIntsmeg1UPPU+XO8r/u4vJGdX
         cwuE5GxI713OgdCpR8s4L2nlAzRybBkGqC6hrCJyXyMaKqP9Y6DQRjsPNHg2N/ulaK9I
         3LKhd6hpLl12Hd4+dvznT/xgOykUDdrZxCwrLFE7e8RNBaxgh1DjRic1mLhTGYZ2b1Ug
         gvhRXAMA8bkA41Ta3OGVqIpYghQFiQaNba1rDLnRE+c3yxi+4xB0WF55lgwjU+vFiIn3
         6KNdJvWACwN4JLhQEPozX+pnS7T6t+p4KZ+bdbGZXpsNssO1tpver7v6UYAARBmqBHMT
         fQ6w==
X-Forwarded-Encrypted: i=1; AJvYcCWZOj6H4rWZKAuR7Yxbxr6ScptF8OA0GA0mYLuNKjjSvAx76TFLKClG8DfH3gmYKYTP+BYAVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxL14ZG9ju48NliPSOCXYz97DzMCitvhVHAbK8nHKc859shJ0pc
	OUWH6CyzMsHZIZgqePMXLaqbsboKMXncCuJ4qzVMjTuAgKws01FBfdzUYXy6D0pNyY7kAse31aP
	xYg==
X-Google-Smtp-Source: AGHT+IH1Gu9GLKfGiYTCOjMoGySHlcEjW+ds+b1IrKT29iIUpO61X0NEHkvZCaXOOFQOQ3oqS5p4trwyczY=
X-Received: from pfbkm27.prod.google.com ([2002:a05:6a00:3c5b:b0:736:47b8:9b88])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1309:b0:736:5c8e:bab8
 with SMTP id d2e1a72fcca58-73e245ba24bmr4220090b3a.3.1745504018497; Thu, 24
 Apr 2025 07:13:38 -0700 (PDT)
Date: Thu, 24 Apr 2025 07:13:36 -0700
In-Reply-To: <1fa0f7f8-be88-4617-a0b2-57d4204c6d6f@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-34-seanjc@google.com>
 <1fa0f7f8-be88-4617-a0b2-57d4204c6d6f@amd.com>
Message-ID: <aApHEK4R4tAYi5Q0@google.com>
Subject: Re: [PATCH 33/67] KVM: x86: Dedup AVIC vs. PI code for identifying
 target vCPU
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 24, 2025, Sairaj Kodilkar wrote:
> On 4/5/2025 1:08 AM, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index b8b259847d05..0ab818bba743 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -13567,6 +13567,43 @@ bool kvm_arch_has_irq_bypass(void)
> >   }
> >   EXPORT_SYMBOL_GPL(kvm_arch_has_irq_bypass);
> > +static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
> > +			      struct kvm_kernel_irq_routing_entry *old,
> 
> the argument 'old' is redundant in this function.

Ooh, and @new to kvm_x86_ops.pi_update_irte is also unused.  I'll get rid of them
both.  I went through multiple iterations of hacking to figure out how to dedup
the code, and (obviously) missed a few things when tidying up after the fact.

Good eyes, and thanks again for the reviews!

P.S. Please trim your replies.
