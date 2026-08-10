Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC693905EF
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406107; cv=pass; b=dRASUdKDu4IHN5WIgWIw3ftuPq3IkQl+nWornrW3fdJtgo24IDPPzWOJsJqS7qr8iHplEv587tuNso9/Z/abe5PyjXoco/uLATcKBqqlSV5kAI74LhZRPWOIuN1XefKykuyOOOSsWewh7lS+qzGe3SrBFV1Xr1YzQxKLITlJ+fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406107; c=relaxed/simple;
	bh=JHfanZgIA8mK03STIk1FeUn57Mhb7JG9av6AGKnMHws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pk9QIq6S64B5bugnyFOy2xELl4MiNUEMRf/hG8P0GpHtkCC2IpFyXGI3YoWszPKav/duWMvjiqG40g+pHtynlkrp17vw9cp3BSAD6Y+VyEPu5kwTOX7tcwPtbifOev4CumQCc/9vcO9Yx3JpvbbyD/aLZm2Lma5c67LaCT+ZyIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kYS4+cpZ; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kYS4+cpZ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4994d67d260so14445e9.1
        for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 16:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786406104; cv=none;
        d=google.com; s=arc-20260327;
        b=MeCr+WdvOHyosGG/PSPDdBkqLGOqH00QEsYCmsryMG7sCh9todRpvBKLPsL++LdHPJ
         vraSgZgRQ+Tg46ySDb7iefXycuAPBcYiARcz/qLJvCmLpiO6VoTzT5lOu5yCu2Qgwd49
         L+T9sR3u9+MmeSatYa8nZA9Fo9bKfJDJPr/iEuU6KGjJm3+34TGxgLbPfmtkVcLBlqed
         5kGQaMtihYpVlc2vRVyBplOXLmikbGUCFhtrsDlTXHxYlqbWr0K0J2Dy2SIRCjZGa+h0
         zuSu6Z2/JqPJUYT5SnrizPdQRcuy29DxfdEIZ74qA59t3fyyXAURwwqo1A/rfTNTcpt6
         tnwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JHfanZgIA8mK03STIk1FeUn57Mhb7JG9av6AGKnMHws=;
        fh=3/isU3CWNO74WKfydYz4QBYwzDGMPs2AkVH1rn8yabg=;
        b=Idt+PAR4dmSOtlYSywJTwHIcDnelW2Mb+Rq1lwd3QL7lBywQEl7nI00CvRGmZ9GQrx
         X973YfZy3TwOpHQ0+zVOHWeZILz2QswaifDz2mcwQlJdjhYgjfeYtqzZBNhVRVCRHbQn
         FPWSZ+o5IprTCyZtbh3cTCowfcT9nKQKlNlKIitI7qf0eBOZly4oFp7VbYNC8pjpbeIa
         d1H+MR8RHWf3grmhFnFg2TMKQ6hUtooV1qgEd+ev4oOpOxCqyPdkx2aS0Il05kWoimHD
         1QfPI+ePwX0+IMFm1WjQdhYROfb5QfoVEzvLKRbw5Qj6vIR8HuIM1CebsZ7U0SvovpLZ
         c55A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786406104; x=1787010904; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JHfanZgIA8mK03STIk1FeUn57Mhb7JG9av6AGKnMHws=;
        b=kYS4+cpZ6nBYXtXgGT08OhgCTHwhl7Fs7x09Be/guOmIPph6JA0GGGSdUPHzDJ+epM
         X2TA2rSor2Vhd1IVkL/1LyflomjRBiIaDEW7WWTLrVEmokUpgPeCXY1SQCR4sFF6TJtL
         BnnnNFpbpYi4j6Gjo2saji0jesO0NTIBJF8DUZInrXNs6AoOupcGRTVVV+Iw0CdrZbK8
         JQ8kj1RgMrHk6ZQohkK3twEeySdXb6smjtaGmz1sWBL4mF31KDEC8OrpgDtp9lIjljPF
         ZM0R+MQj7Q1VrMktzmKFSKYVLgqggK/+kQQAu55eRBUmdOwpvsByMeDJe3ewxjmOzyJz
         BIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786406104; x=1787010904;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHfanZgIA8mK03STIk1FeUn57Mhb7JG9av6AGKnMHws=;
        b=i+i0VAyBpnWaiKSH86GyZsHrPwh0cneg9TBk23DN7qEz/f2pfBjFJTO3JbJ7xIV+1A
         VuvvhH9PPoiRtefBajVcweArGVIGl1v5EDyQ73RzQnENySCZ5PYYO2NVIqjsmPqAPiar
         qcdMqtFcE/IN/OO5xQvwELsuLXei6RZ+Bqw+M60ucOyyD+RI3v6CReD60IMRGAtkF1kv
         pMndStWsy54caKehqokYWOYdonUL0BwTp3s9opTzjh6Vu3L6u3LBq4JPg7HBaSMlWFny
         nwOCc1xzUKysjUsUCXy+1+NsH4DK15WDZIRAEONOSA1bYsa366j93IESOiMk5Fddb62H
         /a1A==
X-Forwarded-Encrypted: i=1; AHgh+Rpy0S/QJ9j2ndtoRIJHAZtlDiAM3CAL0xXe92iW2uROpak1+3ccRG54xAk0yidLj0mjCDKZzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRw/xOwvlKb4f4+UFhXBbNtWQoOHdLoSqMSh6qVW88pFCq/vj/
	/lhi6rAJgbplBNMjuUogkAO+PQ54BIxT4c8U6F12l3Z7U0VfK8amEn7MUlVEf9oLHF55vxzjhd9
	5Hy63idOd963FXSPGkGlP1vt4JVCR4WFbeIhBuU7X
X-Gm-Gg: AR+sD10rOV6AcN/EHIC+xZS77n8gYcGQ0cfX/CCo4bhofhQiuHIwF4zGLNKgjWBwS8m
	npYylzWKS7OvoVQxzjA36gr1W8k6rR0GDmZgyXVZk4zrr4PqnFyivCGIyi0yvTX9lVv9f1f4K6/
	rT9snkpJuWjd1ZwWr5uMrMt032Y3mRvQ5lUO6QnWP1HEs1B8PSJPWqULg2FWFsq66W70iM0iAKM
	Wzv7IRRnlrcesPbvNr/j96LvuuXzVG0UM700EMBfq0Wp4tZiw1YPb9EXBdOKgkWIuTHof9kSPPp
	8SMqCqRltNpkPuzE8WGaR1xc6OnzMGybfkteses3J4z9HEmiVjxL3MxD+rEg0LXuk4pwxgZqINE
	=
X-Received: by 2002:a05:600d:108:20b0:495:4593:616c with SMTP id
 5b1f17b1804b1-49975c21896mr314355e9.1.1786406103959; Mon, 10 Aug 2026
 16:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-6-d80f7b871bb4@nvidia.com> <CABdmKX2i_vxs3EgJgydEbXoTxqWe9g9pj=hqPKuwf0ge0SjZuQ@mail.gmail.com>
 <anSyU_-zArFch-an@orome>
In-Reply-To: <anSyU_-zArFch-an@orome>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 10 Aug 2026 16:54:51 -0700
X-Gm-Features: AUfX_mwf0uw3dVpzklPu-Nif3rg3tPQMirUP9IgK_6gn-zY2Jt3_SUQapkz0Yvg
Message-ID: <CABdmKX2Hn0cDw_aFW7Xr9v5mr=WvfhhTXgX7tpRaMMGstYp4=g@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] mm/cma: Allow dynamically creating CMA areas
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
	linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 9:21=E2=80=AFAM Thierry Reding <thierry.reding@kerne=
l.org> wrote:
>
> On Wed, Jul 08, 2026 at 04:49:31PM -0700, T.J. Mercier wrote:
> > On Wed, Jul 1, 2026 at 9:09=E2=80=AFAM Thierry Reding <thierry.reding@k=
ernel.org> wrote:
> > >
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > There is no technical reason why there should be a limited number of =
CMA
> > > regions, so extract some code into helpers and use them to create ext=
ra
> > > functions (cma_create() and cma_free()) that allow creating and freei=
ng,
> > > respectively, CMA regions dynamically at runtime.
> > >
> > > The static array of CMA areas cannot be replaced by dynamically creat=
ed
> > > areas because for many of them, allocation must not fail and some cas=
es
> > > may need to initialize them before the slab allocator is even availab=
le.
> > > To account for this, keep these "early" areas in a separate list and
> > > track the dynamic areas in a separate list.
>
> Huh... going over this thread again I could've sworn that I had replied
> to this before, but I can't find any evidence of any reply.
>
> > Hi, It looks like you'll also need to update the CMA dma-buf heap's
> > add_cma_heaps init function so that it adds all the CMA areas, not
> > just the early ones.
>
> I would actually rather not do that. The case that we need this for is
> creating a special purpose dma-buf heap that's composed of multiple CMA
> areas. These areas must not be used by anyone else. Exposing these to
> the CMA dma-buf heap would allow anyone to allocate from individual
> chunks and throw off the accounting that we need to do in order to keep
> the protected memory from working correctly.
>
> Besides, given the dynamic nature of this means that the CMA dma-buf
> heap might already have probed when these dynamic CMA areas are added.
> So we would either need to have some way of notifying the CMA dma-buf
> heap of newly created areas or we might end up with an incomplete set
> of registered heaps.
>
> If you really insist, I could look into this, but I think it's actually
> a nice feature that the CMA dma-buf heap only registers these "early"
> areas and exposes them.
>
> Thierry

No problem, thanks for responding. I see there is now discussion about
subdividing a single CMA area for this, and that seems like it could
end up simpler in terms of the CMA code for this series. So I'm
supportive of that idea.
