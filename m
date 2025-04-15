Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D13929B76E
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729045; cv=none; b=U5hWrVTmnFfrYTuE4pqXpLjZxhuJi06HWuOuhaBhmJRFXNbwcdyAjIwx45nKCxygzIZv1R9JMMiQ/v1TLyTXvIvjLIRW7jz0f2Gqx7wK/vTKqh8T1cLU5Or8SHefcGVkntCrHN0pAuZKM/c5Y/jfE/3Kl78atQci4HRlfJ+oGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729045; c=relaxed/simple;
	bh=TmbQCAQuL850VcC8mWpbyBi0guSCzKnednL7iUfUBi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LpN3dbiN09FBauHYnYW9SArgHmvyZ8p/SIWJfaAKSLnJO+dy9EVvWFpq9c5KZmIht1mNrasNO8Qs1P/z4J1D8Iuyirl26KbUBHH8Ueh6xW5wB0i+zP8n2UoI6FCaZ3Cg2dwFRXlGBVXfyM2vc48P1CD5EPOS0SQHNBoBd8co2aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g7YUr+2d; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g7YUr+2d"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22651aca434so45970725ad.1
        for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744729043; x=1745333843; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3cubAcR5buc4RrtmjyrGPOPaYzbW+tbw+H7cOkEDn8=;
        b=g7YUr+2dODdUWzHAbkNNTgiYp8XrzFU84JhqnwVAunnJDbrNN0LAJ++U0nhetTYIm/
         W6U49Ba/UKMmlgk+Q3cGX0cY5Drlwbner0ro1AbUvE+7FZ/7h5zn9/KN0MQfHTsSCm/V
         vBb1D7eiHBGm7vefdVLvi4CpczuvCUINMCSG+0fppuDe3KCtZu2zKhC1o13Q2+FyqC+l
         Lf1+tKlLwsj4BB0PXqjbUF5V6Z6c7srMG1e41NsGlfnxoEokeb0QAy6Op9R+nd5+otet
         +8RBHvBrx89Vj5eNDHUT4Ify25eaJ1FH4MUwmZT3QYsppnJZl+7U9vZ6Q69yhmRlB4dm
         X05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744729043; x=1745333843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3cubAcR5buc4RrtmjyrGPOPaYzbW+tbw+H7cOkEDn8=;
        b=urA5wKmkphyAAm10k0QTezYtCBuXamRYQr33RQzDQ+qv8GpuGhoDqiiti+ZmQKHoHF
         wSY6VRrUeLbWCEDrM/WM/yuJhxdmhQobjNDqGlFfKfI4T7f/Z+atMT/sOEyabKCowwrL
         nQeAZnY72Of/POj2D57B+n1/tjqYJS1Wk+/WmZGBCOueJrYWkb3D6ClerljQm7f2Ekgx
         XSTBtI4+mXuXEdEEFz/csY4wxrMO6WDzYs2yOZnZmiXt9QzM4DvYUP1B9K5k9xDm88v4
         s5OhMjh44C/oGKXe4A3+nMGiTL7q2bi9D2fTDslCVobjlsll7RRPt7jeGaRF7tJQ4gMn
         BriQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPdAQv+pO0RKzJ2LKZwRa6TDCi789JrPqjV/OvHRpsuAATFiNmtLfxM44peDiUn20YACRavQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmpHryc1AjDQxi67+71yoYxrct/GIv79G8TnTQbpglFfEodfna
	TnTkudiNJDwImCjIwjSwl7hwSgCkMVNvBFW2kRml9XQ9Pmb9wzY90S7YdRqFSnZ9JP69hn3jLmW
	GzQ==
X-Google-Smtp-Source: AGHT+IFaFxQFXBxv1LVPQSIMqbDfDKQXIvk2koBUD5c6YTcCNKoR1Psp7St8pkylyftGChHPBfIrP+rfE64=
X-Received: from plri17.prod.google.com ([2002:a17:903:32d1:b0:21f:14cc:68b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b08:b0:21f:85af:4bbf
 with SMTP id d9443c01a7336-22bea4b70d6mr235612035ad.20.1744729043268; Tue, 15
 Apr 2025 07:57:23 -0700 (PDT)
Date: Tue, 15 Apr 2025 07:57:21 -0700
In-Reply-To: <2cc31ce5-0f1a-41d6-a169-491f9712ffdc@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-15-seanjc@google.com>
 <2cc31ce5-0f1a-41d6-a169-491f9712ffdc@amd.com>
Message-ID: <Z_5z0an7-BJ1bTzF@google.com>
Subject: Re: [PATCH 14/67] KVM: SVM: Add helper to deduplicate code for
 getting AVIC backing page
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 15, 2025, Sairaj Kodilkar wrote:
> On 4/5/2025 1:08 AM, Sean Christopherson wrote:
> Hi Sean,
> 
> > Add a helper to get the physical address of the AVIC backing page, both
> > to deduplicate code and to prepare for getting the address directly from
> > apic->regs, at which point it won't be all that obvious that the address
> > in question is what SVM calls the AVIC backing page.
> > 
> > No functional change intended.
> > 
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/svm/avic.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > index f04010f66595..a1f4a08d35f5 100644
> > --- a/arch/x86/kvm/svm/avic.c
> > +++ b/arch/x86/kvm/svm/avic.c
> > @@ -243,14 +243,18 @@ int avic_vm_init(struct kvm *kvm)
> >   	return err;
> >   }
> > +static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
> > +{
> > +	return __sme_set(page_to_phys(svm->avic_backing_page));
> > +}
> > +
> 
> Maybe why not introduce a generic function like...
> 
> static phsys_addr_t page_to_phys_sme_set(struct page *page)
> {
> 	return __sme_set(page_to_phys(page));
> }
> 
> and use it for avic_logical_id_table_page and
> avic_physical_id_table_page as well.

Because subsequent commits remove the "struct page" tracking (it's suboptimal
and confusing), and I don't want to encourage that bad pattern in the future.
