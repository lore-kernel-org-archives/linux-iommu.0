Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB81946D0
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083800; cv=none; b=eGs/TkFvhQrW98Uy/srtAt9NPW2bok9ezeHvblsIL2zQ63bfVEtBQbqX0/aps9AVBx1hetufzmfW7N5d48l3Q/rsND34fntXx44Rdst/SNyBDdZiO0g3apm2sroUBz4EWSywqoGQPtIqYPi/X26rKrzbAItl3x87yhNTHrJjaz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083800; c=relaxed/simple;
	bh=JxlWTKfLKfV1N7stRJBPiFZggE9mXH97QTo/q/pDES0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UGCaIKS6A6RkMvPXvG7jj/iSaFX0m2j+NeR8DgP1nZmQKNOjWePPmLJX293clIimSgdaUfu1HR6t9yP74G+YMIuaH0CW799jSokEszfB9gzYjDFllBlm4kj2AVG8+tCgBGdgmRjE5VSGqwaZfKAq09P/J7cedL9/qbTvgAgIjes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TuYSLLhS; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TuYSLLhS"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7e6af43d0c5so135363a12.3
        for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 02:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727083798; x=1727688598; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxlWTKfLKfV1N7stRJBPiFZggE9mXH97QTo/q/pDES0=;
        b=TuYSLLhSt7ZOla/3IncEFTm4wTc2ppNzKLhZ/VmqmXz+GRASE3979+4qUPLlIhoTSr
         6wLVpVXuU5RYxq3VCxSiXpvGFXmsv0eDOg3vMylolMYEApaACNekJQZrBZCZBQIgVJtY
         Ape4WsGE2Zh1mnl84FHStdgvfKphZxiMAlTFC/pI+CA0mvKvxOote+ZM/mj/Z6gccpIH
         EirnxQjWMBxzbKdsonblEiR5lao0vDiZUFzzR3ZKc7EhSdmY4lCf2P3+IgjItYId721k
         mxaBigAjlfpv1I9MGY38iaEUGivlvg+CBlUWp4pCZvzjdqteo36JHcKOBntUrvjk3Tpy
         fUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727083798; x=1727688598;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxlWTKfLKfV1N7stRJBPiFZggE9mXH97QTo/q/pDES0=;
        b=MddjtP9hXVonEOIiJUR/j9lxtKnJQju0/ahbd3p7pXmh8lYGn6lgEpunczlwAY44GQ
         fbzhNyyQBtC1bRUZB4n7jk+AqKtOFEDpI7FM1CahwJ+exVibNHPxEazDI4VgrVR3BUMI
         vuPuM5RI+/I8ZDsxxA101//TVBXcYG+7WfZyqfs57cn/V/btChq1T7//DCSV0EmDEtfe
         TaNrPo+jm9KkPtH05y9sApMvR/lXXp4rRu/TSDS0AmAfeyHiAmjuibR4vcc+gCif601l
         N3h49PWz9LtnU6UBh34J/pmMtNyN0vYH+R+WFfXCPQnwLQuKXiiqaEJFQGTIrV2Ozj4b
         px3A==
X-Forwarded-Encrypted: i=1; AJvYcCUJgz8javIVxQtVlu4HNG19OkdKD8Ram0oYsirejdKDCCC6n6B9c0MecjES2WetLGGpZ2njYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbB2Vb76hMLv/vraEyVyOGNYsKYpV7lKlbGmaNF1AluzUNMK2R
	vTl+P4WLX/sLnAw1uKDTw0BR2e5moZvjWlPjvNGCG2veJVtpMz69gu5FK98HUuTrcSFe/bNyVNZ
	njw==
X-Google-Smtp-Source: AGHT+IFSZX5FuNM8tCzpug601r0FUEjufJORJGp2xW2npv3HHNvfqWh9QPhzOBODH4in3nPCT3E6eApyC4U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:2305:b0:7db:2689:f6ee with SMTP id
 41be03b00d2f7-7e6ae037512mr783a12.7.1727083797611; Mon, 23 Sep 2024 02:29:57
 -0700 (PDT)
Date: Mon, 23 Sep 2024 02:29:55 -0700
In-Reply-To: <e5218efaceec20920166bd907416d6f88905558d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231002115723.175344-1-mlevitsk@redhat.com> <ZRsYNnYEEaY1gMo5@google.com>
 <1d6044e0d71cd95c477e319d7e47819eee61a8fc.camel@redhat.com> <e5218efaceec20920166bd907416d6f88905558d.camel@redhat.com>
Message-ID: <ZvE06wB0JGWXGxpK@google.com>
Subject: Re: [PATCH v3 0/4] Allow AVIC's IPI virtualization to be optional
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024, Maxim Levitsky wrote:
> On Wed, 2023-10-04 at 16:14 +0300, Maxim Levitsky wrote:
> > =D0=A3 =D0=BF=D0=BD, 2023-10-02 =D1=83 12:21 -0700, Sean Christopherson=
 =D0=BF=D0=B8=D1=88=D0=B5:
> > > On Mon, Oct 02, 2023, Maxim Levitsky wrote:
> > > > Hi!
> > > >=20
> > > > This patch allows AVIC's ICR emulation to be optional and thus allo=
ws
> > > > to workaround AVIC's errata #1235 by disabling this portion of the =
feature.
> > > >=20
> > > > This is v3 of my patch series 'AVIC bugfixes and workarounds' inclu=
ding
> > > > review feedback.
> > >=20
> > > Please respond to my idea[*] instead of sending more patches.=20
> >=20
> > Hi,
> >=20
> > For the v2 of the patch I was already on the fence if to do it this way=
 or to refactor
> > the code, and back when I posted it, I decided still to avoid the refac=
toring.
> >=20
> > However, your idea of rewriting this patch, while it does change less l=
ines of code,
> > is even less obvious and consequently required you to write even longer=
 comment to=20
> > justify it which is not a good sign.
> >=20
> > In particular I don't want someone to find out later, and in the hard w=
ay that sometimes
> > real physid table is accessed, and sometimes a fake copy of it is.
> >=20
> > So I decided to fix the root cause by not reading the physid table back=
,
> > which made the code cleaner, and even with the workaround the code=20
> > IMHO is still simpler than it was before.
> >=20
> > About the added 'vcpu->loaded' variable, I added it also because it is =
something that is=20
> > long overdue to be added, I remember that in IPIv code there was also a=
 need for this,=20
> > and probalby more places in KVM can be refactored to take advantage of =
it,
> > instead of various hacks.
> >=20
> > I did adopt your idea of using 'enable_ipiv', although I am still not 1=
00% sure that this
> > is more readable than 'avic_zen2_workaround'.
>=20
> Hi!
>=20
> Sean, can you take another look at this patch series?

Ya, it might take a week or two, but it's on my todo list.
