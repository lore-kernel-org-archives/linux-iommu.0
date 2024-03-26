Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1112DD9E
	for <iommu@lists.linux.dev>; Tue, 26 Mar 2024 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468777; cv=none; b=TJDFls/bce9vn/dwpQuK0uLm61Fp0fUG5LXzvfvj5qQBUi3t0LZsE8JHZW8glWUVQ7RSQSFis4kwBV6V0JRgiyCN+uR8vsCBWBYXrilP8IMQlXpEQFAT0lsbKW/J5BTjsfgiS9reDod9jq40zrGlWccuNGfO3ujnCVqr6AVeScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468777; c=relaxed/simple;
	bh=uIDA+qfvtQb0K31mBBmZfAOm2EF2v0rpbL8b210RRzw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2nNwPEGvxuzXSZfKd+MiAvRYJMofJsI+hk6Ngh37eu6n95ezk7sIWs6RvyJfCZu7voojeUX5FVIvKpA6AQCXBxcw4khkiRKI4xDT1QtgYI1eGntRl+8r7dmYWC8Pg2gt/jKAylTmmomm8L7V9GLVbmlFpkX8+Nbpk6fks8drRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/7AdboJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/7AdboJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711468774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIDA+qfvtQb0K31mBBmZfAOm2EF2v0rpbL8b210RRzw=;
	b=L/7AdboJ2CT8z/bG37GvIWEG9VgL4t5smjOQxYbnhNN3S+vvjZ0JPsRjA4+/7F3mNp8Bwf
	AbTDgHL5MWwnuXymhJrZ0lt8iTN2vQpPdKF5MRmhc4QkXO8ausu0iSoo74iJmw1q8taZJ6
	rzwY86AIjZCpeFF9HqE7tmaMh9fJeoE=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-pjfc01zMNyC3VnhXploDXg-1; Tue, 26 Mar 2024 11:59:33 -0400
X-MC-Unique: pjfc01zMNyC3VnhXploDXg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-22a1bb369f8so2657966fac.2
        for <iommu@lists.linux.dev>; Tue, 26 Mar 2024 08:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711468773; x=1712073573;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQ8clIjXc4soz7eWewvwlvASClEQyBetLO4fGly13aQ=;
        b=CIQVPfoax1A4gV9hVysQCjnjiEVu0IsjtD9Dok/fkwkFu2p/fATqkrXTt/2e6frR5K
         uQyNFoa4DiQbR47OvJp5ty3DhiH3UOhm3DY9onhhKVPXkeaW6f8i6myslzD30uY5L/lr
         /xlYoa8lmERskq76HFnzJQncosDUzg8buIW1K70fpbANHdslrbm+uGxz4c2K7tprCaYc
         i9qVTNT8LFe4LB+xrL0iS7Kl1myBQaWTMRjm9rT46VbpC1VkqkG/LV8Hl2Z8yxgc9ZdH
         9VFJZS5jVYMskBZWqjFpExJS6ymrStCjsqhiz2If7QdMWGCu17jof+Bmc3JPJHKEMLaU
         QSqg==
X-Forwarded-Encrypted: i=1; AJvYcCW9RZcuO65PHF7yHkw+lgERE+uuA4XKHdxBoUoQMSDWnxgc7T/4BTtr4v9jOJ+nGdFM7MIwP5ixgYTmEEOSQEgKl1AGf6U=
X-Gm-Message-State: AOJu0YyQRbfpYBld5bfRGKEmEWr/M6Ul7+93vZH1tgVixZoLUxHuKgF/
	4mqtuvbPbTKkMqtVCCHETyfwuGFEFPrv9YxL/Dr3BE5s6TZ1U0Teja6nbwel5IbJOR6Ee+sLHKE
	6onnTJaI4Z6nKTZKlL1xA1eMptpYl2/UC/Cmv8uFcBp3jSH38MB3/
X-Received: by 2002:a05:6871:2b0e:b0:222:5ff6:43f1 with SMTP id dr14-20020a0568712b0e00b002225ff643f1mr1841627oac.16.1711468772789;
        Tue, 26 Mar 2024 08:59:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgzBoNk7aHkGsNEwNVhcEMsbOfldxjSZnKhmacfHPBzgsBueev9oXHbaC3XghCk7h6QPy9yA==
X-Received: by 2002:a05:6871:2b0e:b0:222:5ff6:43f1 with SMTP id dr14-20020a0568712b0e00b002225ff643f1mr1841604oac.16.1711468772497;
        Tue, 26 Mar 2024 08:59:32 -0700 (PDT)
Received: from [192.168.8.125] ([173.34.154.202])
        by smtp.gmail.com with ESMTPSA id fv24-20020a05622a4a1800b00430dbd6edf9sm3788120qtb.68.2024.03.26.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:59:32 -0700 (PDT)
Message-ID: <22be7d6156e38dfba1a055cc3e9cc3d10de75dbb.camel@redhat.com>
Subject: Re: [PATCH 0/5] AVIC bugfixes and workarounds
From: mlevitsk@redhat.com
To: Jim Mattson <jmattson@google.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
 Robin Murphy <robin.murphy@arm.com>,  iommu@lists.linux.dev, Ingo Molnar
 <mingo@redhat.com>, Joerg Roedel <joro@8bytes.org>, Sean Christopherson
 <seanjc@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>
Date: Tue, 26 Mar 2024 11:59:30 -0400
In-Reply-To: <CALMp9eSSCUSOpP64Ho16sU6iV1urbjfTafJ0nThAWGHE6oOkLw@mail.gmail.com>
References: <20230928150428.199929-1-mlevitsk@redhat.com>
	 <CALMp9eSSCUSOpP64Ho16sU6iV1urbjfTafJ0nThAWGHE6oOkLw@mail.gmail.com>
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-03-25 at 20:15 -0700, Jim Mattson wrote:
> > On Thu, Sep 28, 2023 at 8:05=E2=80=AFAM Maxim Levitsky <mlevitsk@redhat=
.com> wrote:
> > > >=20
> > > > Hi!
> > > >=20
> > > > This patch series includes several fixes to AVIC I found while work=
ing
> > > > on a new version of nested AVIC code.
> > > >=20
> > > > Also while developing it I realized that a very simple workaround f=
or
> > > > AVIC's errata #1235 exists and included it in this patch series as =
well.
> > > >=20
> > > > Best regards,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Maxim Levitsky
> >=20
> > Can someone explain why we're still unwilling to enable AVIC by
> > default? Have the performance issues that plagued the Rome
> > implementation been fixed? What is AMD's guidance?
> >=20
Hi

This is what I know:

Zen1:
=09I never tested it, so I don't know how well AVIC works there and if it h=
as any erratas.

Zen2:
=09Has CPU errata in regard to IPI virtualization that makes it unusable in=
 production,
 =09but if AVIC's IPI virtualization (borrowing the Intel term here) is dis=
abled,
=09then it works just fine and 1:1 equivalent to APICv without IPI.

=09I posted patches for this several times, latest version is here, it stil=
l applies I think:
=09https://lkml.iu.edu/hypermail/linux/kernel/2310.0/00790.html

Zen3:
=09For some reason AVIC got disabled by AMD in CPUID. It is still there tho=
ugh and force_avic=3D1 kvm_amd option
=09can make KVM use it and AFAIK it works just fine.

=09It is possible that it got disabled due to Zen2 errata that is fixed on =
Zen3,
=09but maybe AMD wasn't sure back then that it will be fixed or it might be=
 due to performance issues with broadcast
=09IPIs which I think ended up being a software issue and was fixed a long =
time ago.

Zen4+
=09I haven't tested it much, but AFAIK it should work out of the box. It al=
so got x2avic mode which allows
=09to use AVIC with VMs that have more that 254 vCPUs.

IMHO if we merge the workaround I have for IPI virtualization and make IPI =
virtualization off for Zen2
(and maybe Zen1 as well), then I don't see why we can't make AVIC be the de=
fault on.

Best regards,
=09Maxim Levitsky


