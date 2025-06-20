Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533E025E479
	for <iommu@lists.linux.dev>; Fri, 20 Jun 2025 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750446262; cv=none; b=CcMu9mzy4x4TT5aHLa3jYpNQw1XlCNFrEy53V5BHiabXMrgnl/+7kvnyyc3wyzsBznl03QNWaBX9mcVv+RT5Cy9hFyQXZQg+AN+wmByOYXNVV6KEVpD5+bl5zpN9piHkROmSYVrHGmNRuI8IhArFCYAbwedqtnC3ZMCjiyo5inc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750446262; c=relaxed/simple;
	bh=OLvgJGuXcx3y3Cr8WfBTX53IpLfHL0hGq+vYXbhOGw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tOTbHLj5i+4mDjpmhCwDBKQ3C8+fXaq0Crex9cM1f29OIARHhW7/IkdtNhGB+2UjyVmoyglJ0BxP/ofs1avBtkzhfWuMt9ugSC2+Qt1cmqdAssV2PvoZGAcn+L4OismRC85i1l77uaSwp5U7W3ANjaGB0Z1sz+aMqQD2FKpISQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8kUIooV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8kUIooV"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313ff01d2a6so2016265a91.3
        for <iommu@lists.linux.dev>; Fri, 20 Jun 2025 12:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750446261; x=1751051061; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5V4eEdTfLNGKvwTMu6gpmcWM1DlkOACRK3Iq7ll+QeI=;
        b=m8kUIooVLq3++5FCgfPznZUN6ny5CUWVt9OkwDIDQ52090gpMP0upvUgFAwxj5SL23
         eJuSGExkDajaLhrdfTolIpLEpp/TXG4xK8O90vwzPbYwUK7uYbLA555u7z2AwcVYFog+
         8KM7vQtDLF7q5d+hppHWUlhnf2vEQvuonk37qfohXkK1jVXQc7GSEHxDILBn23ilq2No
         8zwToWgu882qfbWdY2tOxvf/kWf/+sqAr3oYu3n6gCHKHAJizjAPwsAAh2DabKK7x2D+
         ejBfKr8m4JCEXct9HWznIEAb0LBjS3hAP+oYVlfuDNJ35wglDMUfcihr+AnyALnC+kTw
         C9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750446261; x=1751051061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5V4eEdTfLNGKvwTMu6gpmcWM1DlkOACRK3Iq7ll+QeI=;
        b=NasqbMIHzYPH/ZvC67jqX3vNuxY7Gs48Z/aUJi9An/k10Fvc1Gw3xXNY7CHgua4tPu
         1zAGK15QlhYC0M70aReqtNdg4qQcftvshPFU0y8L5c7SYHoxh+YFJewGQTZme8R54yL4
         5NLIFpp7TAXVxlAyjmv4On+Zcki2ZWFXiDfCStzgVqlhZrZ6oEVPZ+tFJ2maRjpySBUD
         AhgQzDwUW44qYzeED7PoxXHljWST0xvXgwUqkAOwhyc9QW0SBY4f+Y4eAlQhgkRljliU
         mkIjbxl+7+WjtuhwQDcgOEDk3nsxqCjqmPBTtGRUFgBkvnE2tdQ5QpiQ8yb5r9aHbp/o
         6l/w==
X-Forwarded-Encrypted: i=1; AJvYcCVyQJbGjuRBbN8QxhoDhkZEKFfwKuX3W6IYknmzvptED/j0eDeqaohAEdA1ADyi6Px5iq7TLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQm/rWYwCfenfMB7/xC5um9NjBWunN2lWAX6rEgK5j8Y1hsU0V
	NygCAWx3zODcpptPunzXHR3peivNDOfmbiSsgtHDa/lSdIYFIfSjfcX6mQNrw6mHKmFlXMftDbb
	E6EOwRw==
X-Google-Smtp-Source: AGHT+IF1HEaBNlmc+Q9tLzc6oMTF1bn1vxvg37edQgx2B9G2cFY6EZBuAhcrhbwMKilEdjhrXVyorY3eseo=
X-Received: from pjbsr13.prod.google.com ([2002:a17:90b:4e8d:b0:311:8076:14f1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5143:b0:311:fde5:c4c2
 with SMTP id 98e67ed59e1d1-3159d6361damr6100280a91.1.1750446260678; Fri, 20
 Jun 2025 12:04:20 -0700 (PDT)
Date: Fri, 20 Jun 2025 12:04:19 -0700
In-Reply-To: <aFWtB6Vmn9MnfkEi@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com> <20250611224604.313496-4-seanjc@google.com>
 <86tt4lcgs3.wl-maz@kernel.org> <aErlezuoFJ8u0ue-@google.com>
 <aEyOcJJsys9mm_Xs@linux.dev> <aFWY2LTVIxz5rfhh@google.com> <aFWtB6Vmn9MnfkEi@linux.dev>
Message-ID: <aFWws7h3L-iN52sF@google.com>
Subject: Re: [PATCH v3 02/62] KVM: arm64: WARN if unmapping vLPI fails
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 20, 2025, Oliver Upton wrote:
> On Fri, Jun 20, 2025 at 10:22:32AM -0700, Sean Christopherson wrote:
> > On Fri, Jun 13, 2025, Oliver Upton wrote:
> > > On Thu, Jun 12, 2025 at 07:34:35AM -0700, Sean Christopherson wrote:
> > > > On Thu, Jun 12, 2025, Marc Zyngier wrote:
> > > > > But not having an VLPI mapping for an interrupt at the point where we're
> > > > > tearing down the forwarding is pretty benign. IRQs *still* go where they
> > > > > should, and we don't lose anything.
> > > 
> > > The VM may not actually be getting torn down, though. The series of
> > > fixes [*] we took for 6.16 addressed games that VMMs might be playing on
> > > irqbypass for a live VM.
> > > 
> > > [*] https://lore.kernel.org/kvmarm/20250523194722.4066715-1-oliver.upton@linux.dev/
> > > 
> > > > All of those failure scenario seem like warnable offences when KVM thinks it has
> > > > configured the IRQ to be forwarded to a vCPU.
> > > 
> > > I tend to agree here, especially considering how horribly fragile GICv4
> > > has been in some systems. I know of a couple implementations where ITS
> > > command failures and/or unmapped MSIs are fatal for the entire machine.
> > > Debugging them has been a genuine pain in the ass.
> > > 
> > > WARN'ing when state tracking for vLPIs is out of whack would've made it
> > > a little easier.
> > 
> > Marc, does this look and read better?
> > 
> > I'd really, really like to get this sorted out asap, as it's the only thing
> > blocking the series, and I want to get the series into linux-next early next
> > week, before I go OOO for ~10 days.
> 
> Can you just send it out as a standalone patch? It's only tangientally
> related to the truckload of x86 stuff

The issue is that "KVM: Don't WARN if updating IRQ bypass route fails" directly
depends on both this patch and decent chunk of the x86 crud.  I could probably
trim some of the x86 crud by reshuffling patches around, but I can't get rid of
it entirely.

> that I'd rather not pull in the event of conflict resolution.

LOL, why not?  :-)

If I post it as a standalone patch, could you/Marc put it into a stable topic
branch based on kvm/master? (kvm/master now has patch 1, yay!)  Then I can create
a topic branch for this mountain of stuff based on the arm64 topic branch.
