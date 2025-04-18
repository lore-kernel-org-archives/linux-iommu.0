Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BEC433C4
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993335; cv=none; b=jMEl5pxmoRqHN0sY28KoRvsMxvWbKOjzaT975LAlGFoOLyVrLUi7pKuXVUxYDD91+T7Y7tH3QRZHRMWFICwcYFZKiAzwHboeo1Nd0RPssYfkOPlj1+aItKzfvFhfVi/CXudkPbDB0TTwc9VQal0jXQByVRBrNh/Fm66/Cvyd9MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993335; c=relaxed/simple;
	bh=Xaqjq8y6sGmO1ZUk2didNrSa73aZGxUDMzs+j+Zi8/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CCKjNLnmCYTBMtUrWJdHqqYz7oTbJX+mPjwLSttjnUWK1gIn3Qls681E0By7aPEAh4c0Q2PDbZz2G1vZk+C2z3+arylLWdkjgRd5DCl+RPuHD1GBjY9f6wXy4O6IfGM4afIXR0w57QfiLmnNNQWWjdpHRPekBbdTs8xYUifdPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0VIsjon+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0VIsjon+"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224191d9228so26333165ad.3
        for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744993333; x=1745598133; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1pjtyBfSlLKyL/NS0nFvpCvZz0n/zUmSG0nruCRN+Q=;
        b=0VIsjon+yURhZpae80Oqt4Tf7nerrkil4WyBimpJnEefuCG2WOkVFYqCbZcCvX7AVh
         o8JU7SuORCqrvSnYXuwz4r96O2Ws+XspxjFmvCgQ92mbdKWPES+UubYOp34ZkWv5hdXD
         AB3BY7CVzwyylmejD0gvU3NB16nNNm9WY7LDWsIT5iyt/0NiGZXCKbCHRwhJtkTq2f1C
         pk6LX6+GqiopBV5Gd1MVRbbpr0piVvzmpuGHmg+Twqw9G1zZYwE47uY+2I3BfpUV1Hmg
         AIEGmPNh5/rMPEyI/5q5f3Mx/GIYZqTWOh9M7Q7mby3p3oUxRuX1/92amUojQPt26ccB
         4tUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744993333; x=1745598133;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D1pjtyBfSlLKyL/NS0nFvpCvZz0n/zUmSG0nruCRN+Q=;
        b=YIiGehVk8Qge2FhW3RO6KLVrLExpNf9Dt/T6JL98Kojx6/7lO/ITTwjVlSqjHetoK6
         iAl/GgsypZBa4LRz356gps1JTDkGjLCbkul4ood8QfHWLs1NTKr6w0G9nvGNTHT8/JNH
         4YT8YjXBQ1/j0DSH7w5ZekKaxexjvyB0jt7fRiVgzUcQt1oA7GTFl0BeSGOh6yHqdvHY
         4pXurrsiLuGzfvFAvZQMtolwgygXUuhwfe5t3UIbyAYLcXyUtuh2qAQRYAJr2h2xIPUm
         Nq3waZIlOIrBkdl2RsBdc4mkC01hG2/fOAUvbqCNQc1bEs27khe+oRTaaYgFN2nEGdsv
         tjXA==
X-Forwarded-Encrypted: i=1; AJvYcCW/Un0p0/jl1tsod8va7nn5m1XDbIXex/is3VHA+RJsrzRyNOoVJGpltLUYCppxpHne7Kl5jg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywnm5xiDwv9JbTekVraUR296yTQzFtN5P2k5kVyIPB2ZWneon7+
	0NLn9VDNI6CG2Mhz/EHUeapXCgnukH+xvEj10w6SCHNqznc00oTQ7K6ZP2l7jpr228Xc0+MUx6a
	JKg==
X-Google-Smtp-Source: AGHT+IHqwNO/x37hOdGCk0YIJnSIGZEumqGvWSf5j1xktHt7N62gEkfdWFum/WCMhL+WKTL+rztUgYv0GjY=
X-Received: from pfx42.prod.google.com ([2002:a05:6a00:a46a:b0:73c:26bd:133c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3bad:b0:220:f59b:6e6
 with SMTP id d9443c01a7336-22c5356798amr39350385ad.8.1744993333345; Fri, 18
 Apr 2025 09:22:13 -0700 (PDT)
Date: Fri, 18 Apr 2025 09:22:11 -0700
In-Reply-To: <6f070686a44225d36bc1086dc1643841b3d43d19.camel@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <6f070686a44225d36bc1086dc1643841b3d43d19.camel@infradead.org>
Message-ID: <aAJ8M0Mm9bv7xlVs@google.com>
Subject: Re: [PATCH 00/67] KVM: iommu: Overhaul device posted IRQs support
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Joao Martins <joao.m.martins@oracle.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025, David Woodhouse wrote:
> On Fri, 2025-04-04 at 12:38 -0700, Sean Christopherson wrote:
> >=20
> > This series is well tested except for one notable gap: I was not able t=
o
> > fully test the AMD IOMMU changes.=C2=A0 Long story short, getting upstr=
eam
> > kernels into our full test environments is practically infeasible.=C2=
=A0 And
> > exposing a device or VF on systems that are available to developers is =
a
> > bit of a mess.
>=20
> If I can make AMD bare-metal "instances" available to you, would that hel=
p?

Probably not, my main limitation is time, not lack of hardware.

I'm confident I can get a functional AMD test setup internally, it'll just =
take
a bit more time/effort (there are other people working on the testing front=
; I'm
hoping if I wait a bit, someone will solve the hiccups for me).

I'd been holding this series since ~October of last year, precisely due to =
lack
of bandwidth to configure a working test environment.  I felt that I got fa=
r
enough in testing that the odds of something being _really_ broken are smal=
l,
and didn't want to delay posting for potentially multiple more months as I =
assume
other folks in the community already have readily available test setups.

And no matter what, I want to get more thorough testing on a broader range =
of
hardware, e.g. from Intel and AMD in particular, before this gets merged, s=
o in
the end I don't think me getting access to different hardware would move th=
e
needle much.

Though I appreciate the offer :-)

> Separately, I'd quite like to see the eventfd=E2=86=92MSI delivery linkag=
e not
> use the IRQ routing table at all, and not need a GSI# assigned. Doing
> it that way is just a scaling and performance issue.
>=20
> I recently looked through the irqfd code and came to the conclusion
> that it wouldn't be hard to add a new user API which allows us to
> simply configure the kvm_irq_routing_entry to be delivered when a given
> eventfd fires, without using the table.

Yeah, especially if we gated the functionality on a per-VM capability.  Tha=
t way
kvm_irq_routing_update() could completely skip processing irqfds.  At that =
point,
other than the new uAPI, I think it's just irqfd_inject() and the resample =
code
that needs to be modified.

> I haven't had a chance to look hard, hopefully your rework doesn't make
> that any less feasible...

Quite the opposite, it should make it much, much easier.  Currently, both
vmx_pi_update_irte() and avic_pi_update_irte() pull the GSI's routing entry=
 from
kvm->irq_routing.

After this rework, irqfd->irq_entry is explicitly passed into=20
kvm_arch_update_irqfd_routing(), i.e. it removes two of the gnarliest paths=
 that
expect irqfd to go through the standard routing table.
