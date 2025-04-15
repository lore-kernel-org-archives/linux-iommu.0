Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177C529E04B
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728923; cv=none; b=qHcOHZsiJUChW/wsNI2nRovmh4f/f/vslfm944IK6YtmuI7xed52DqQXOGtU2UUbt4nPeNtX5QL8OTESlz4xYrWpBHoTmQpI69L97FiuEmHxPUvAfcjiUQ6AzGDl0KPC5Bukh39ZrKDlRUrJoJsLK33PZ/7jvNHo8NQFhKyBBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728923; c=relaxed/simple;
	bh=Z25BFswi+RwDu8PUjbMKkshugsl78jlSI7Z+pvioYuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tar71aI4Efi8PLyOjP2yq1L7cNxGa7meYj7uNbs2ok2kF0Xyq+XjA9mT3hhHtcCUc776SNq5E+0f4KmYHi29JzKkEoVBG47Shp0BOnzaiB62FZVS0cDnfpWuegvfH8ccKxgUG5w1pEIkkIAyo2qbqlHjg7JH/E1hfugc/Y6IGXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QMhGVatW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QMhGVatW"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-229170fbe74so47004135ad.2
        for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744728920; x=1745333720; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OuRBmgEllaRB5ZjobobNvVAEpYQN/37Jjkyiax0k//A=;
        b=QMhGVatWGv9PysS7YbxTYGcUSrfAWtS+jqjTakdIg9Wj5alJSzmlpGAaKMzblWwI7L
         vcVV5cBTpV3VbIZdZXwBWAX2/Nx58IeJNNu5IhFiwHP5j4S2tdMqLMwwAg7hXst9XGTO
         LfUpDjUkxmHwe5JlH9RMiIuucbnZNPtsMhrO3YQNTQcHD4XlfHAeHuOC7EI1CNQiQYz2
         cCjsITxjjsDaSMgBOiKHCD+0LdL1mb4J2XqbE0IXdqfQ+DnobX1VTmzMuykZRBEwx0sx
         7RU1kCUl96o2t13Wd43BVeY1xcAg+NAImrXer3c9bMWZvqQj7NPiWMxHr9ezL3P4qXJc
         5aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744728920; x=1745333720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OuRBmgEllaRB5ZjobobNvVAEpYQN/37Jjkyiax0k//A=;
        b=ul7d+4z1kSXXNgSRJ29j5f2R1dIMeOOgxWpE/chvOJVFbBxmYzKVobo8r8YW4nvzT+
         P+n8DOuxjLz1Hl1dba9uJJKXuel3TZFExhQwMzG4h7oAJXvjC+zRdCaHa2AAUhbvxmI3
         GiAKL2BBX4t602+1iYVQkD5gFrvL4PxBDsx8ZbAma7DeTZlOfiUZO9CTlAIYHsToJdJY
         MEKBjE2N+0i2paOnV371VRvdLCx6uv4LeBSeuMKg33I9EmkuReemCeA3hYGdVD5MPEa+
         ofYDPGlJA1AirgwuhwXBm6Zy5mDPqHRInTwEBTW3tw8bRn1XudtIfbpxnNhY8E8oKQzk
         Gqbg==
X-Forwarded-Encrypted: i=1; AJvYcCVIXD9D2GOqJihEAX7hqBrxEzaSeUZm4ynVR/AoodQYUqIIRQLs2vQxT3cClSl6Ns8nmZVSZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjTcO60fQqz4U80Jxmt2/G2Ap2XuAEsrDygkiQge+oNZ5O4p5d
	9HlHKYGtfoPgRaRh9UGzltd2z+Qyuh+JwkRSvrU4jizC0w7DeLX9pZkm8GrZDraorqSI7skVOc7
	zgw==
X-Google-Smtp-Source: AGHT+IHH7mC1r9KS9+glc9Ei4mef4Tc//vYXWsg5yzy8MKjIFibb6b+8ibiq0JLHt6znMV7vWbcfa+6TwQ0=
X-Received: from plev19.prod.google.com ([2002:a17:903:31d3:b0:224:efa:ef21])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2345:b0:224:1af1:87ed
 with SMTP id d9443c01a7336-22bea4c71e9mr252498545ad.27.1744728920241; Tue, 15
 Apr 2025 07:55:20 -0700 (PDT)
Date: Tue, 15 Apr 2025 07:55:19 -0700
In-Reply-To: <d345b636-792f-4762-8c6c-2a7252294068@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-12-seanjc@google.com>
 <d345b636-792f-4762-8c6c-2a7252294068@amd.com>
Message-ID: <Z_5zV_59D3a4ySW0@google.com>
Subject: Re: [PATCH 11/67] KVM: SVM: Delete IRTE link from previous vCPU
 irrespective of new routing
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
> > Delete the IRTE link from the previous vCPU irrespective of the new
> > routing state.  This is a glorified nop (only the ordering changes), as
> > both the "posting" and "remapped" mode paths pre-delete the link.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/svm/avic.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > index 02b6f0007436..e9ded2488a0b 100644
> > --- a/arch/x86/kvm/svm/avic.c
> > +++ b/arch/x86/kvm/svm/avic.c
> > @@ -870,6 +870,12 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
> >   	if (!kvm_arch_has_assigned_device(kvm) || !kvm_arch_has_irq_bypass())
> >   		return 0;
> > +	/*
> > +	 * If the IRQ was affined to a different vCPU, remove the IRTE metadata
> > +	 * from the *previous* vCPU's list.
> > +	 */
> > +	svm_ir_list_del(irqfd);
> > +
> >   	pr_debug("SVM: %s: host_irq=%#x, guest_irq=%#x, set=%#x\n",
> >   		 __func__, host_irq, guest_irq, set);
> > @@ -892,8 +898,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
> >   		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
> > -		svm_ir_list_del(irqfd);
> > -
> >   		/**
> >   		 * Here, we setup with legacy mode in the following cases:
> >   		 * 1. When cannot target interrupt to a specific vcpu.
> 
> Hi sean,
> Why not combine patch 10 and patch 11 ? Is there a reason to separate
> the changes ?

To provide distinct bisection points if one (or both) changes introduces a bug.

Patch 10, "Delete IRTE link from previous vCPU before setting new IRTE", is a
non-trivial change in how KVM tracks per-vCPU IRTEs.

This patch is also a somewhat non-trivial change, in that removes IRTEs from the
per-vCPU list even when the new routing isn't an MSI.

Ah, but the changelog for this patch is wrong (I wrote a number of the changelogs
several months after I wrote the code, ugh).  Either that or I've now confused
myself.  I'll stare at this a bit more and rewrite the changelog unless current
me is the one that's confused.
