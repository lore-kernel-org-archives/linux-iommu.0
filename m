Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6237063B9
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380093; cv=none; b=t8eaxR8bbY7XOJ31WW7OjVpKYtiReLbE6W0pbsD1eQ2PH3plid7uNss/a3XIT973U+sgTz+IA7ypRsvRHQ4DQL71z8mDAf8z6d7bvS1Hld/eZM/U1pyR6K+HiJGAZ7XfX94FG4PzdHoMpn+5qaeeguvr5MpNDrSmwJEEFaRlews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380093; c=relaxed/simple;
	bh=pDyKbO56Ddz2WZ550CfuDnQcBTRpV4zOKeY8l0cY+wQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MePDv+zCNttR53HtWG1MyXQ/g4RF9nOh/UQtPOpOn/nqbxYPhI0oJvx02a8lh42ZVeMRo1R4bMtECh+xJY00GwuPrxHDKa2ooQPKIgVZgcwHJDWvPYtLROEX9WNFjYzu5tjpm/AmXhSTA+ooev9Bj410VIn9cMnfdsnOnu++KAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xezjDSHw; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xezjDSHw"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7398d70abbfso2618251b3a.2
        for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 07:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744380091; x=1744984891; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XcPVK4CSR1aU1haxpBUR9PW1y+UHdkqysUSf0PjchSg=;
        b=xezjDSHwKLNNmamPaT83kdVM5J3dDJ+U3Mnnjwu3vxeXaNWeFVeaEb7msjkXuAlbnD
         kETpW1IkAj4hWFn53i4TqwHU+JfGaDvtyoxYQFF+jdjA/e6TG3goCyE78f2fe/ab7hH2
         PJcSdbymF5n9MJ7W/ZwuDLNF9X+6Cg5Dqa6DTWBn5aLmjKq2xa9w0TTVZSnWPQRMXGsk
         mz/8vgeUresCWFBchW9DKAqW2yMBGSyF1gZ+WgIYbceiXHUNEpR6cU9YRlrJO4fcjUIG
         VQyozMdOOFHJl/8d+lF8lgziXsRzvhZ1c3e4nwceEml0A8iTwcxitB757dbiWg8by7Or
         /CuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744380091; x=1744984891;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XcPVK4CSR1aU1haxpBUR9PW1y+UHdkqysUSf0PjchSg=;
        b=jopSjcPJAeGeF5GkAuh6keZ0rlDM6oeafQdCKN5igwb3Cgtf01ZmDad6lBEPL5CGFb
         JWb5mHLvziz12r+xLRMTUdc8r1HzFkAdu1oajhzPURmwpSUIeOebTc3zRG5fdu7EKYL6
         LiT2g/kTt8rrMoQWkjDon+MgC6SQwGxHjoXFAJwvJElXlDXdVERCN0wn0I/1F0iwTYm/
         o4mdtXX58ox/uFD6LuEJSyjebYB1umvGoaFOlE0sXwvxt49VApqhVxxcW0KFkXTd0bxy
         4z/11By5v0oez8gTxxeV4+xzYfIdXhOmH9vjRlDUbnF2LsKyX6KlfJQK4jIcRtiObgiO
         PjOw==
X-Forwarded-Encrypted: i=1; AJvYcCXfewf0vHz/YTJ5mAUFb6XPmerQGTo+bgeJxAnHkcHkUVkRERBxxriuVMr0wUBzPGABpqIB2g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1jIMYNv+2vb2Yt91Er6XVuO+an8TZMd+Uw+UwlgAerbOF7SQQ
	HSUcavpD6S8flipy9l/W3ZtxmGf0cRccOyiEfI7VprL+p2OwINCKU3h5dmOujZjMyQwZpVpDT51
	X6g==
X-Google-Smtp-Source: AGHT+IGZRfCJBvkjvkPw1lUwltol4QErnPiBwQVl7jFbl+mdLZpKnJ7rCvLlx42UvY0fGa+iXwvt2U/eiSs=
X-Received: from pfbln21.prod.google.com ([2002:a05:6a00:3cd5:b0:730:743a:f2b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cc2:b0:736:bfc4:ef2c
 with SMTP id d2e1a72fcca58-73bd0e8f5b1mr3705655b3a.0.1744380090507; Fri, 11
 Apr 2025 07:01:30 -0700 (PDT)
Date: Fri, 11 Apr 2025 07:01:29 -0700
In-Reply-To: <6f76183f-a903-47fd-8c84-0d9892632fca@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-9-seanjc@google.com>
 <6f76183f-a903-47fd-8c84-0d9892632fca@amd.com>
Message-ID: <Z_kgbna7grb833Fy@google.com>
Subject: Re: [PATCH 08/67] KVM: x86: Pass new routing entries and irqfd when
 updating IRTEs
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Arun Kodilkar <sarunkod@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>, Naveen N Rao <naveen.rao@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 11, 2025, Arun Kodilkar, Sairaj wrote:
> On 4/5/2025 1:08 AM, Sean Christopherson wrote:
> > +int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
> > +			unsigned int host_irq, uint32_t guest_irq,
> > +			struct kvm_kernel_irq_routing_entry *new)
> >   {
> >   	struct kvm_kernel_irq_routing_entry *e;
> >   	struct kvm_irq_routing_table *irq_rt;
> >   	bool enable_remapped_mode = true;
> > +	bool set = !!new;
> >   	int idx, ret = 0;
> >   	if (!kvm_arch_has_assigned_device(kvm) || !kvm_arch_has_irq_bypass())
> > @@ -925,6 +919,8 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
> >   		if (e->type != KVM_IRQ_ROUTING_MSI)
> >   			continue;
> > +		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
> > +
> > 
> 
> Hi Sean,
> 
> In kvm_irq_routing_update() function, its possible that there are
> multiple entries in the `kvm_irq_routing_table`,

Not if one of them is an MSI.  In setup_routing_entry():

	/*
	 * Do not allow GSI to be mapped to the same irqchip more than once.
	 * Allow only one to one mapping between GSI and non-irqchip routing.
	 */
	hlist_for_each_entry(ei, &rt->map[gsi], link)
		if (ei->type != KVM_IRQ_ROUTING_IRQCHIP ||
		    ue->type != KVM_IRQ_ROUTING_IRQCHIP ||
		    ue->u.irqchip.irqchip == ei->irqchip.irqchip)
			return -EINVAL;

> and `irqfd_update()` ends up setting up the new entry type to 0 instead of
> copying the entry.
> 
> if (n_entries == 1)
>     irqfd->irq_entry = *e;
> else
>     irqfd->irq_entry.type = 0;
> 
> Since irqfd_update() did not copy the entry to irqfd->entries, the "new"
> will not match entry "e" obtained from irq_rt, which can trigger a false
> WARN_ON.

And since there can only be one MSI, if there are multiple routing entries, then
the WARN won't be reached thanks to the continue that's just above:

		if (e->type != KVM_IRQ_ROUTING_MSI)
			continue;
