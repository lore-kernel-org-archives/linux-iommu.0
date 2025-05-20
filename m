Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F65728E608
	for <iommu@lists.linux.dev>; Tue, 20 May 2025 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747773394; cv=none; b=Kx899rXWneRbBQvjQVtbzB15q/qWa1cdslqZCj83XW05T82RLHD9aMQCVHeOu1Al8sbajR01Xi8TewGLDJT6y9Fjhw3essUoxsvEma2tFAoFlOxg8R29iZs7NcpMDH1TMi3ZV/0tSxmUuoqc27FhAE48Ysypa9lvm1Xv4SC+UTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747773394; c=relaxed/simple;
	bh=ZKfsnzKjHWRvUGjeYrgiENx6pawfGlJOEUf65hQxSqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N+Xmqug93Qdv1AglMgEVOE7+4JoF+8i8lEpr0Qd9GuR9OPLRZned7lBSif8prYo/hkvbERLWtiuWT6f1SDSBMB1KFKmLiww45Pcky5dNdfZfiiwWmQjLPSX0nOdTOkAEkbVkaj2XEYr9gYDIwCx+LuU2p5/vNLpn3IfhfdKWxbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8LO7t3w; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8LO7t3w"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30ed6bd1b4cso4142503a91.0
        for <iommu@lists.linux.dev>; Tue, 20 May 2025 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747773390; x=1748378190; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NikUqd8YUJYJZVQ9NNWuumuHYhTthKmVTkOJEDEId4g=;
        b=s8LO7t3w3FrHR9T+oiFOkx3sdOcrHU95hH3tdmg8/s7sJB/SnZUvmuYyTeXsW/nsvW
         TyK3HA39co+x0LLeQXON5a9LPx7d8CKuA+Keglam4EFRqHB4eXggYZU6+1Wi8rcfdLH6
         P2rWOnIC3Dq5V3A5mo7ruiKNo2M4bNHT1GhDtnlAsy6dfafaPSN3z3nJW7TtUm5snTR0
         128QdmnGjbJ4L5qREd9mLBEGHiFi4Apxtyncdw0E2hD19+CjmOj3EXX2jcpuRImoS5ay
         usuGjgFkEcz61q6d0VKopDfOmPy8FDfCKGvN5Xu80ATlqaNMd4zYoJcXs+6U3uWET7DF
         MrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747773390; x=1748378190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NikUqd8YUJYJZVQ9NNWuumuHYhTthKmVTkOJEDEId4g=;
        b=G0l7RSgcuEHv1el5vdPWBe5lTOky4X+WuwyuJgnzcJ1NfWCDldkTQB+SYK0tIW9Rwn
         adJjabbA+lf1/VpqyVGAlovo/pmg1npTlI0Q3T3C5TM/93FBrI20DEQBusVUd4aIgaNV
         RUMZL06Z3cwJGUl2WMTDelhriWJfOj9q5EVnLMyDaRoFoaEvMp1eoy1hJzcpnspFe2rl
         6Kr9vsJSxlIOY+MovSp4HBzuBHYKBdyLBK2h5KwGSDkIK6hflpcwqP9yVxF+A/tv1bZk
         y7uA7YTvYNd6xQrFMmiips4YpVctuEec/iFTpR7s+FZlTsbgxRWeWvPPLV/eJyi95L54
         LD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFI5ZU9T4fmTmv/JarrHCqPPfgOAXVV+hNd9ULmwVdqprnitE5HSWWAgS6F2RXzQbIwp/pig==@lists.linux.dev
X-Gm-Message-State: AOJu0YykraQRaRrfYM5oRXP40KswMRGXFevyNMoZHTAySxZWK1HJoeAn
	mtPM+dOfXKDTjQr9H1hJZ3v1OmmPT14EX7KAhoZ7tVONIKWudvZ0KbppS6x5CrXpfiRlc4C3xo7
	bL3gO4A==
X-Google-Smtp-Source: AGHT+IHP6rysVOKSkISEgr29agj9TpppemjJvlT6UOUwgsn7uAspuzrIU/dBu0EIRPFTBgRjNvR+rZRe+h0=
X-Received: from pjbph15.prod.google.com ([2002:a17:90b:3bcf:b0:2f9:dc36:b11])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d44:b0:30e:7d09:2a7
 with SMTP id 98e67ed59e1d1-30e83107ed7mr28064460a91.14.1747773390587; Tue, 20
 May 2025 13:36:30 -0700 (PDT)
Date: Tue, 20 May 2025 13:36:29 -0700
In-Reply-To: <d270ff32-7763-40d5-a4dc-3970383571dc@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-31-seanjc@google.com>
 <d270ff32-7763-40d5-a4dc-3970383571dc@redhat.com>
Message-ID: <aCznzZ-SN4Pf_htE@google.com>
Subject: Re: [PATCH 30/67] KVM: VMX: Stop walking list of routing table
 entries when updating IRTE
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Joao Martins <joao.m.martins@oracle.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 08, 2025, Paolo Bonzini wrote:
> On 4/4/25 21:38, Sean Christopherson wrote:
> > Now that KVM provides the to-be-updated routing entry, stop walking the
> > routing table to find that entry.  KVM, via setup_routing_entry() and
> > sanity checked by kvm_get_msi_route(), disallows having a GSI configured
> > to trigger multiple MSIs, i.e. the for-loop can only process one entry.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/vmx/posted_intr.c | 100 +++++++++++----------------------
> >   1 file changed, 33 insertions(+), 67 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
> > index 00818ca30ee0..786912cee3f8 100644
> > --- a/arch/x86/kvm/vmx/posted_intr.c
> > +++ b/arch/x86/kvm/vmx/posted_intr.c
> > @@ -268,78 +268,44 @@ int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
> >   		       unsigned int host_irq, uint32_t guest_irq,
> >   		       struct kvm_kernel_irq_routing_entry *new)
> >   {
> > -	struct kvm_kernel_irq_routing_entry *e;
> > -	struct kvm_irq_routing_table *irq_rt;
> > -	bool enable_remapped_mode = true;
> >   	struct kvm_lapic_irq irq;
> >   	struct kvm_vcpu *vcpu;
> >   	struct vcpu_data vcpu_info;
> > -	bool set = !!new;
> > -	int idx, ret = 0;
> >   	if (!vmx_can_use_vtd_pi(kvm))
> >   		return 0;
> > -	idx = srcu_read_lock(&kvm->irq_srcu);
> > -	irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
> > -	if (guest_irq >= irq_rt->nr_rt_entries ||
> > -	    hlist_empty(&irq_rt->map[guest_irq])) {
> > -		pr_warn_once("no route for guest_irq %u/%u (broken user space?)\n",
> > -			     guest_irq, irq_rt->nr_rt_entries);
> > -		goto out;
> > -	}
> > -
> > -	hlist_for_each_entry(e, &irq_rt->map[guest_irq], link) {
> > -		if (e->type != KVM_IRQ_ROUTING_MSI)
> > -			continue;
> > -
> > -		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
> 
> Alternatively, if you want to keep patches 28/29 separate, you could add
> this WARN_ON_ONCE to avic.c in the exact same place after checking e->type
> -- not so much for asserting purposes, but more to document what's going on
> for the reviewer.

FWIW, AVIC already has the same WARN, they were both added by "KVM: x86: Pass new
routing entries and irqfd when updating IRTEs".

That said, I agree that squashing 28/29 is the way to go, especially since I didn't
isolate the changes for VMX (I've no idea why I did for SVM but not VMX).
