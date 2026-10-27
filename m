Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793122706;
	b=IwtpDSG0m4/34Tj6neqwYbOi/rp6Cl8JxEX040FSHRwuuhe7sLaejuHXmkROj/BfdTyZ
	 uehT81dw6LvJLZCcJomH+RYXymQ7cznrt98i5bUDc5R8sCwbA/3jMxtGN07RR2oXF62tR
	 wp1pPrTWKwXafKD5jlNwwVUiT0ZQG/LAvgar02ox439VaJqscHoWfvcRPo/XeCLjnrbn5
	 K9As+rrVggHv31lUwsXM9G7z0AxCReVrJ4iuCd4U5lvN9trTjO/LgsqwjmGB7WhDg4aWb
	 b1bz3iIR5MaifX+fyL57i0TqWnyWD2qMbCUh6eGZBJqc1bQOAl0MOWtdErrSJ5q3hMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=;
	b=uI1PRtFETL3GfNOdqfNVbfJjtQUAW94Wuq6ezx4VG9W1Dl3RF/IsagLImy5PfbfBM642
	 XiN3mTaM8Cegg+vQtxWFAszW6moQ22Z0JNBHvl0K3Yq4DO5nRuIenAqJeMQNcGrKZiGuw
	 rbbniEjyahbOOXqoh97iuKoWoEZkJMxmw8NUIug8r5vD43vdJ30M/32cQoxn4uGlt7328
	 iWQbT/9AfxhkyYLwYbWFfZJT85ZE4P/AyR491h4gDYV7afaMTbmr/lOoVXFFRPYeYFkD9
	 AS//t7x2hNi49HOXqM6dMTjpVJutZdB4/McGiyhfdjZnPIU9ky27s1At/5TSB9Zhopw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AJ+10usr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97139606A31D
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 17:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97139606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AJ+10usr
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4322d310e7so12734366b.0
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 10:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793122704; cv=none;
        d=google.com; s=arc-20260327;
        b=byo+nxjhZG24ucUhuxuLwKiKHi2urow5My+Clke4dfyR4d8xK2+GsEFqvKgKnmResu
         5oQOhZyxGhYGuviNAuH4Ideq4yingcdJoBOsMDtWWM6enJleVxYJ3Q6zAnQJw+K4bSx2
         96MkkYFC4sWACFgoOvYrIf3dVqyxyt9R5CMA76M+N9ekTdG0GIUVnupdhDUzVZydnfTH
         fgLt8RudZCjd5y/TdKfKNGGagXaR4a69IUO7kBgT7bPx/x4OPbe+mYW2/opNxQRE6pMG
         DflsUY1RdB+qSPT/nwwH3JOxBRFqxoMDsGyug7s+yqiWiTbn8sEau7VTNcdhQTNhhsB/
         ExFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=;
        fh=ciUyWwWB8WUxF7swZbZwCKmagkrt44X9EZuhYlmxb2Y=;
        b=qxe067iIpRVk5ZltNh/lC6q/xJ/R3fsOztYw2f17y3IfTo3ti68yUoZTDySMNaI5ox
         IfLcbUCqr2ozBhxovQKFKTCdX2XusIAw0gUs8tHy0HFfahTU5PDfPgomgYtMhWGj0j0e
         REjyQMsjdnzzTbRLz6AuprQUZX4o3ovhxbNk2xvTqoWPyK9238EUMnybFoP2CDHe06+G
         W9/LbQ/SWIcJkcwYEawnFjpZ1FqX3Io26Bh40/+vPteyAJvyv+htWtDXpfG5IQSYLF9h
         TbYcX3YqNNmvkEk5I29jrGb4kdjOnJOH+ItODWBte0mpBf5Ejx0gHLjW1ujQ3yJwXxgg
         57dQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793122704; x=1793727504; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=;
        b=AJ+10usrmZjWNCyDncW1l6JD47/wAFJwDFJkObiLpkhi33w/YnrbT1dfWkC1YHfINQ
         HlPyFw83ZMLLzCPZBd5ZVpEsJ2oCBEjny4eY3o/UG1y+wK+gEacmRKdHp2om1f5E0CGa
         h2nUvDw2mi0kPGyJ+a6hqGRw9BeRNV9FGfyeCftbGPhYSohyiXTd1nB9eWSEw7lAeiTE
         pHVKw1oRbzjlSqAyedWa+jl/Pj+psR1Ls7+Oj5BMO9N9X/NmN5Q+akwWK6FThBHAh8Mq
         wheJ5vpHYk1LXCUuyDVUnG6SYIlsCRZ2hQJmAJExd4EMmnTS1nKb67OgI03bLgBebUgK
         vKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122704; x=1793727504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=;
        b=m3q46n78K6WXJ6tG/f/9DG6YFP+0aCAg9ZMPhYDCbSTNJQCz1/qfvaTWuX9x0MvYhF
         L9PqrpyVkVFjLQZlRm/z2W2ZoAjG18GQ8eytsAWPdWfmbY5sqRnPN2jUjBe/RVxqSroo
         2lf6LuUq7o40xObVIacrISFYfrC+KMi3JACPvkhQ2gEBz+CvvhhGchEyx4zTeZalZDvM
         0CUm4L4ON8qZZsi7dLUc7G4Nf3ZuT7uUiivgiKGm+z8vDY3pUdNGCGiLOuzzkuKf6+w9
         lkvdjXYA2XNwRyT9cMpqy91Y8wN425pp2KedTKpTD5HxOmvQOrMTLbhNrWJUA1x/yJMw
         dASg==
X-Forwarded-Encrypted: i=1; AKwUvBy2/ZqTrrv01v3lkBMfhMyDseET7JRIs5DAkwBVRI3NL7U7w6T16YFBhzRVcQgIoLIqfaDG7w==@lists.linux.dev
X-Gm-Message-State: AFq9FYLSKYlci2/BbUsM6Q56f/64sHmQI/hmPpx7qaK+dHM27IZla8gB
	Umz+n7z41pXsjwzwnui0NU5QD3sk+glvXcgKm9Bq6zTMcO6wnghIBtivBP5pxvVKtsu9MMGJltg
	t96qi2FBIOgnD7xM8Dp6ky+GpbAHiOJRbnYCEKit4
X-Gm-Gg: AYBFou2sQP1YrXN5z1Ux2GMPvI5StAWpuEQ0FQrHo0LHcSZkWXGCZBdPqTGYMFefhkN
	ZWjEUfldOU3R+0UR2wG9cPvfZraEcSQiDjk/xXTTuGmciu18RaytyvxgEwRhY7gFZnOTJgiQHfB
	PKoNyZM18HMYzAIXXTNXQNb0KTguWdZeck7FB6RNt9EkhRWyCq7hk2CyBLqPf43Ebd2+BQD6hLF
	LoyubknxgiJl4j4FojYTdzx8jGoRt2g3/4XuLyYWxfVplkkCkQlO7wkl84eEtqO33B4rKIgv6m9
	gxvlGN+2zfbmzYJHpZhDWMKT2Qvij0ctWhv0ajMFo4ybuYpp66smYzSgMP/krGeQMGknSO8H0G8
	VpEmOuf/8Sa0j75D8bqIRw2BAWjqHsxyKfkCnOg==
X-Received: by 2002:a17:907:d308:b0:c2e:378c:8ce3 with SMTP id
 a640c23a62f3a-c46bde8c44fmr1091193766b.32.1793122703439; Tue, 27 Oct 2026
 10:38:23 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com> <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com> <at_CncIPYCxOVkLo@google.com> <auDT5MjXYq3lcQjE@google.com>
In-Reply-To: <auDT5MjXYq3lcQjE@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 27 Oct 2026 10:37:56 -0700
X-Gm-Features: AclHuK9nhZy1yfbGSOSB3h6FsOr-7RUqfg5DsC4iepC4uLqRp9MK3EAsOEkjOYw
Message-ID: <CALzav=dYKAP7pKfoPtz32X1cT_tH4LN0X47_jTO8_HOCT4Pi=w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:40=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 10-26 21:14, David Matlack wrote:
> > On 2026-10-26 11:50 AM, tarunsahu@google.com wrote:
> > > Right, Required bit should be source kernel payload property to tell
> > > target kernel that the payload must be handled to correctly deseriali=
ze
> > > the data. It should be source kernel (userspace) responsiblity to mak=
e
> > > sure it understand the target kernel before doing liveupdate.
> > >
> > > Saying this, During deserialization, target kernel's required bit is =
not
> > > necessary. So I propose the following truth table.
> > >
> > > Source hdr  Target supported[i]  Action
> > > ----------  -------------------  ----------------------------------
> > > 00          0 or 1               Accept: feature absent in payload
> > > 01          0                    Accept: ignore the feature data
> > > 01          1                    Accept: use the feature data
> > > 11          0                    Reject: -EOPNOTSUPP
> > > 11          1                    Accept: use the feature data
> > > 10          0 or 1               Reject: -EINVAL (invalid encoding)
> >
> > Yes, this matches what I had in mind for the semantics.
> >
> > To be explicit: the source kernel should set the bits for each Live
> > Update based on what is actually preserved, rather than generating the
> > header from a static per-kernel array. E.g. memfd would only mark a
> > feature present for memfds that actually use it. That's what allows
> > rollback to an older kernel as long as nothing being preserved depends
> > on the new feature.
> >
> > But looking at this again, I think the required bit is redundant. Wheth=
er
> > a feature can be safely ignored is a property of the feature itself, no=
t
> > of any particular file. Every file that has a feature present will have
> > the same required bit for it. The only thing that actually varies per
> > file is whether the feature is present.
> >
> > The required bit still has to be conveyed to the target somehow, since
> > the kernel that needs it is the one that doesn't know about the feature=
.
> > But it can be conveyed by the feature's number rather than an extra bit=
:
> > split the flag space into required features and optional features, and
> > assign each feature to one of them when it is defined. This is similar
> > to the required_flags and optional_flags approach in struct pci_ser [1]=
.
> >
> > Keeping the same header shape as discussed with Pasha:
> >
> > struct kho_ser_hdr {
> >     __u32 size;           /* Size of header + payload in bytes */
> >     __u16 nr_required;    /* Number of required feature bits */
> >     __u16 nr_optional;    /* Number of optional feature bits */
> >     __u64 flags[];        /* Required bits, followed by optional bits *=
/
> > };
> >
> > Required feature N is bit N of flags[], and optional feature N is bit
> > nr_required + N (using nr_required from the incoming header). The lengt=
h
> > of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
> > are numbered contiguously, so there are no gaps, and up to 64 features
> > still fit in a 16-byte header.
> >
> > Each bit just means the feature is present, so the truth table becomes:
> >
> > Source bit       Target supports  Action
> > ---------------  ---------------  ------------------------------
> > Not set          -                Accept: feature absent
> > Optional set     No               Accept: ignore the feature data
> > Optional set     Yes              Accept: use the feature data
> > Required set     No               Reject: -EOPNOTSUPP
> > Required set     Yes              Accept: use the feature data
> >
>
> I like this proposal. I bet most features are going to be either
> optional or required, and even if we ever have a magical
> sometimes-optional feature, it can have its own required flag. So, no
> need to pay double the cost on every flag.
>
> Just need to make sure that optional features always start from 0, in
> their own enum, so the offset can be computed correctly in the incoming
> kernel.

Right. Instead of having a single 32-bit feature space where every
feature can either be optional or required, we have 2 16-bit feature
spaces, one for required features and one for optional features. Both
feature spaces span from 0 to 2^16-1, and then are packed into
flags[].
