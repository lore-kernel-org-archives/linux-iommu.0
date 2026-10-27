Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793062547;
	b=RilaSk+zG++iAm1mR37ghMHQl+klyY2tUmCf2HdMQBhH5hRCgpegZqNv+jaCHDFlp+KF
	 VYMuHSzVOTZocdrZ/ALHGNYMr/qqgDQoDmKEWK7Rz6Kb/bbwDmkSTGPxJAfkodi78IXgI
	 UVPBkGdlej0y8aO28ats9ObB+qNkcM2b2AberFbCOk5o/ruOfn+64L3pHXpV1AaSYasFz
	 bWJYXmrW5Hf9ZiOVt5CnIQqRRqn2xB9KJx+ELPTHWJiim5SFVLHVfmGmmq7K37O9onBYp
	 ZWElx8tXfu5DbzzuewhooN+5eniyePrOZbYiQlXVsejanESMowFKGnOmPWZdRF9kl5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793062547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0rDUgYp8MSkkxbz0QJpm44/zZryJwi/MN1DJH+bVzxg=;
	b=ObFC490glhORoa/6UbJcg1HMTtOMAvZy4LjBxRYqzs4LyiPlPfFF/5xZs284vxT9AX7M
	 YXrpNPPAxUgQwwNnFTijeQTOIWq7G7uCuQynM+GtXTrcPgKDYWgNfUfNKbD/7aGme5LNM
	 4ixaZmUe3XyYCI2t+shWeGb5wGq0yw91MMarSpp7yXSEC410wMxkqzr7v90j00IRaY6CR
	 3W+PZsoG9hOQq97Mu0UsdEXyWdaeUKhVvGC5mxwrQ5FciWqkD8LnCE6+wHwx3yIL2RXTf
	 29RfVXFUR9zwS5dPBvGBG6I91jEFumrBZOr5knshkJv4XMma0Cl68yc1cOR3C95zQiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mKtPv5pS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EE2606A31E
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 00:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4EE2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=mKtPv5pS
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-676858d42f8so3194166d50.2
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 17:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793062546; cv=none;
        d=google.com; s=arc-20260327;
        b=iQigkw+16hcp5OCezDHHcTdRFxGNRauqza3itzheQigD0+TVxCBliPMVHZ5P0NVFUu
         B4kkzgSrxJDueSFO9Yk6YOl6mrJOFM6/uZo+CNkrNLkmGHOlOkA7lDLWWyp42l4srMEU
         HKqnqkRKicepjmBslPXX1YLXO9/NBfJ3KZftODzJRxW4VJTKx4AhqVeJPe5eaw1yC6PE
         O5/5QlUT2+YmrzQDG9o4Oj5XYjNjqiRatxTUm/+u/vLUSaxuAyOSztcYbDU3vK3YYTCU
         Zj/VOzl0eVcQaqy8VtvXh+16iSB4Ue8Abiqh/vvRtspuK7xBMWt5Ja80u5gjrx/MmUeN
         jaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0rDUgYp8MSkkxbz0QJpm44/zZryJwi/MN1DJH+bVzxg=;
        fh=eUGnPEwhXMLWU6KjEXmPuzEj4s51EIVrQWH78NCIA1M=;
        b=PEx2lA85GvqRMoFqjFqUQRSBZtlaM7lWgsl0mWjR+qSYCZk+g/ZEJl0qezduP2Kpvj
         daA9J2uJ1SS8SgmLDqpTG9EYyWDyWkdoQ12PZA1N5jq4oKghXffzwfzk727+/GjOulYp
         rKiZ9BLKOqVc9BKzMjM2xWF4f39krpp06l0Qr5vtftvS3vEpGIkVkb6RYrbXwnNekQUF
         Mw95UWTFaG7Ed5cMJondhjADcViUOFiMezpvVBaWRq/Filu/lSatN471R9HzewYRn4KF
         6pioENoGYJ1H0ljTct9uzf2J0YHPJYYTVxSQ18lv760NOOQLcV0xcefsKW7qDPKtvrTV
         qXTw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793062546; x=1793667346; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0rDUgYp8MSkkxbz0QJpm44/zZryJwi/MN1DJH+bVzxg=;
        b=mKtPv5pS935YKfi5HVr8I9CkhqTTGdwIIiKRKJ1Riis/ooqonadC4FFG5Q39LxSJ8y
         m2e8cb1hdjkKoBRrS0/j3Ed8it1KUp4/DRmsS4b1HOh2MfrlyybAV3Rg/y7Zen4bLd4H
         wo+iB47eNw7ZId57Ph31hT5oyOg6A/B5FzJ+WdtzwlLEpDoZt1UuYKsQNHdJbNCEvimi
         zguYIuBW7i/H0b0xxcqT2JJycD+WTtUZ6zYZGeQ9My5enKv6vaxodhyT0vVSNRLBtEF4
         YA2N4qvb9I4pwtaulXDuwtw5Tab+yNiQuO2+cn2h5peeVLRI0PruA9g7oUCWgn8ntGAl
         TbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793062546; x=1793667346;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0rDUgYp8MSkkxbz0QJpm44/zZryJwi/MN1DJH+bVzxg=;
        b=kbvqG7vKJwEqvUT5fWcE+xEdsIAUatsHvFaeTe38E65wNAXIufj+jNJ5wWZTBKEs+l
         DKXNczv+ydFyN/7Hu+QcylWYXWHNo+UMlmLQLbZ7As5b+JtW25yg/J850lQ1ZlOcPzW8
         6/kATSYdIobmi24l02SJH8txOC4uOv78wGeFkVufk13IAteK+yFAzgtEKus+V9F8WFjN
         wNnmVvHA3/1HUSfF1lKZjP5CTP4qFgBiHdSVFqqU1PsEYsVNp/Wk+j8RK8tQJjxVUalo
         GhOMgsSjvyRWwBio5BocPOXatjaF/q4+GAm6OT3B6fiec2J/+4I6p8wM9LESzBpLxB6W
         Nt0w==
X-Forwarded-Encrypted: i=1; AKwUvBzztF6f2ui4UC1TJiGmAdNxcCJCBOJ17Bv3TgJYyvhgct8tCbMUyPDuNSqrZfGxIAwDl1eceg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJCPq9pNWRVjPmf25WaDxa64HRyYtPgsYDvKooyTUlK+udY3+v5
	wT5ZmNzTCBPi1dgLShktOdUm3GRn83dWoFsOfMHlElak5r8HplkI6aPkb7TkEt3vrIUpe2rlovW
	2zRKKU5uqAjyurnNkhw6CYX0kXFyjmANWdRGiFShL
X-Gm-Gg: AYBFou3S4G7QRKJFXD4pL023FxfmxGWwlZClihgU42RLekh2xsMnUoEqnakRdPC+aNm
	6zJ7IzH3fkWtoCffjon91rshxySA8gpHGVrJG54cle46G8UA2KQ98Ra1S82omlTbVG6XZXVONO0
	yRuxh5TpAI5uTOK9kZzmgevHIDZ4xK3m6K5ihf9czdEqZTtULjDU+aHLKu+TYCvavw5FL86mjHv
	VspJbNjof9sSn/j5h1SPnKskAtLEu81hlCE3ckktYJPh5A5SkWUvBi7OIW6Q5cqkIutF2rRujbD
	R9ddo5LyWEsV0//CmBewPZ8pr4h8CnVorkO3fUSFY+vJkyD+M/QSifG+8FTKCy38tVBaNoVPiMT
	5sDaiS7gcTrtREnSO/EcHaHCEVVTWaeUUwdylkqQoHuRHSmZwmwKwBjM5xgHdzx0CjCAIKK4ICG
	EfcmPP3YfPO4KiROXimq0bGdpWVShpXXRj1rEggTK2nsp0NPdhd20rGvkSlw==
X-Received: by 2002:a05:690e:4193:b0:679:ab13:5517 with SMTP id
 956f58d0204a3-67a454185a9mr4463627d50.104.1793062545192; Mon, 26 Oct 2026
 17:55:45 -0700 (PDT)
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
 <9huzzew0el59.fsf@tarunix.c.googlers.com> <at_CncIPYCxOVkLo@google.com>
 <9huzecdcghxu.fsf@tarunix.c.googlers.com> <at_pxoULR1Tp5anN@google.com>
In-Reply-To: <at_pxoULR1Tp5anN@google.com>
From: Tarun Sahu <tarunsahu@google.com>
Date: Tue, 27 Oct 2026 01:55:34 +0100
X-Gm-Features: AclHuK8fanKHLtbPQb3b8Hh9aMr64vlKSACVWw1UZzkklpf-Ls0Hu1JyLQFmaw8
Message-ID: <CALe+6DxTR0BpvW7mXMjq_+dczT2jO=R_qLbHhSduhnuSPcXhzQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 1:01=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-26 11:28 PM, tarunsahu@google.com wrote:
> > David Matlack <dmatlack@google.com> writes:
>
> > > But looking at this again, I think the required bit is redundant. Whe=
ther
> > > a feature can be safely ignored is a property of the feature itself, =
not
> > > of any particular file. Every file that has a feature present will ha=
ve
> > > the same required bit for it. The only thing that actually varies per
> > > file is whether the feature is present.
> >
> > The required bit is subsystem property not the per-file. e.g. memfd_luo=
,
> > it is set at compile time for a kernel. So every file will get that req=
uired
> > bit set. It is not per file property.
> >
> > struct u8 memfd_luo_feature_state {
> >        [MEMFD_LUO_CORE_FEATURE] =3D LUO_FEATURE_REQUIRED
> > }
>
> Right, whether a feature is required is a static property of the
> feature.  That's exactly why it's redundant to send it in every header.

I meant the different thing.I was saying if a Feature in a kernel will have
constant value either required or optional which is fixed at compile time.
But the same feature can have different values in two different kernels.

I am not finding a good example, But I am skeptical about making the
assumption for all future kernels that the features will always be
required if they were required before.

Maybe a seal added in kernel version M. Later in kernel  version N this sea=
l is
deprecated and replaced by a new seal.

So transition from M->N
source kernel will preserve the seal values and flag the feature as require=
d.
target kernel will mark it supported and use its value to translate
into a new seal.

From N -> Z (latest)

Old seal is no longer required, But the new seal is required, so kernel N w=
ill
mark the new seal as required. and Z will support it.

This is hypothetical example. I'm not sure this is enough to convince the p=
oint.
So, I will rely on others to chime in with their thoughts.

>
> > > The required bit still has to be conveyed to the target somehow, sinc=
e
> > > the kernel that needs it is the one that doesn't know about the featu=
re.
> > > But it can be conveyed by the feature's number rather than an extra b=
it:
> > > split the flag space into required features and optional features, an=
d
> > > assign each feature to one of them when it is defined. This is simila=
r
> > > to the required_flags and optional_flags approach in struct pci_ser [=
1].
> > >
> > > Keeping the same header shape as discussed with Pasha:
> > >
> > > struct kho_ser_hdr {
> > >     __u32 size;           /* Size of header + payload in bytes */
> > >     __u16 nr_required;    /* Number of required feature bits */
> > >     __u16 nr_optional;    /* Number of optional feature bits */
> > >     __u64 flags[];        /* Required bits, followed by optional bits=
 */
> > > };
> > >
> > > Required feature N is bit N of flags[], and optional feature N is bit
> > > nr_required + N (using nr_required from the incoming header). The len=
gth
> > > of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both space=
s
> > > are numbered contiguously, so there are no gaps, and up to 64 feature=
s
> > > still fit in a 16-byte header.
> > >
> > > Each bit just means the feature is present, so the truth table become=
s:
> > >
> > > Source bit       Target supports  Action
> > > ---------------  ---------------  ------------------------------
> > > Not set          -                Accept: feature absent
> > > Optional set     No               Accept: ignore the feature data
> > > Optional set     Yes              Accept: use the feature data
> > > Required set     No               Reject: -EOPNOTSUPP
> > > Required set     Yes              Accept: use the feature data
> > >
> > > There is no invalid encoding left to check.
> >
> >
> > IIUC, I believe this will not work.
> >
> > To Communicate between source and target, We are defining a protocol, A
> > protocol which will be standard for all the kernel. And each bit locati=
on in
> > flags must have the same meaning in both the source and target kernel.
> >
> > Now in you approach, If Source kernel send feature N to target kernel,
> > target kernel must understand Nth bit as the same feature. Even though
> > the bit position in your approach is not fixed but they are fixed
> > relative to their starting point.
>
> I think you misunderstood the proposal. I'm not proposing to pack only
> the set bits, and I'm not proposing that each feature have a bit in both
> ranges.
>
> In my proposal, there is no such thing as "feature N", there is
> "required feature N" and "optional feature N".  Required feature N can
> be found at bit position flags[N]. Optional feature N can be found at
> flags[nr_required + N].
>
> In more detail:
>
>  - Each feature is defined as either required or optional, once, when
>    the feature is added. That choice is permanent.
>
>  - Each feature gets exactly one bit, in its range, and that bit is
>    always at the same position whether or not it is set. Required
>    feature N is bit N. Optional feature N is bit nr_required + N.
>
>  - nr_required and nr_optional are the number of features of each kind
>    the source kernel knows about, not the number of bits set. They tell
>    the target where the optional range starts and how long flags[] is.
>
>  - A set bit means the feature is present in this file's payload. A clear
>    bit means it is absent.

So For #NR number of features, We will end up using 2*NR bits which
is exactly same number of bits, V3 [2] uses. So this is just a different
way of encoding in implementation perspective.

>
>  - There is no invalid or reserved encoding to define. Each bit just
>    means "present".

What if a buggy source sets both required and optional for a feature?
That is an invalid case here. Same as 0b10 is an invalid value set by
buggy kernel.

>
>  - The target doesn't need a supported table. Required features are only
>    ever appended, so it rejects any required bit at or beyond its own
>    MEMFD_LUO_NR_REQUIRED. Optional bits need no validation; the target
>    just checks the ones it knows about.
>

As I explained above, incase a feature is replaced by another feature,
new kernel
can support it deserialization but it will not be required from there on. S=
o
The supported table will still be needed.

> > For the current appraoch and V3 [2]. Think the below one as msb is
> > required bit and lsb is feature present in payload bit.
> >
> > 00  FEATURE_ABSENT / DEPRECATED
> > 01  FEATURE_OPTIONAL
> > 11  FEATURE_REQUIRED
> > 10  IS INVALID (analogy: required set but feature is not present) which=
 can
> > have different meaning in future if in future, a need arises to reuse t=
his
> > field.
>
> In v3, 0b10 is reserved and not checked by the target. That means an
> older kernel will silently accept it, so the only meaning it could ever
> safely take on is "safe to ignore", which is what 0b01 already means.
> A reserved encoding is only useful if older kernels reject it, and at
> that point it's no different from adding a new required feature.

Yes, because I thought 0b10 could be used in the future. And Currently
If it is set by a source kernel, it is buggy source kernel. But I can chang=
e
back to INVALID, As you said, it overlaps with valid field 0b00.

~Tarun

>
> > Deserialization can happen per feature from right to left. without
> > jumping back and forth.
> >
> > Because of all these reasons, I believe current approach presented in
> > V3 [2] is the better. It is close to your PCI series with two flags
> > field for required and optional except I combined both field into one
> > flags. In your above approach you do have two counts but not having gap=
s
> > (which is wrong) and the way you proposed to parse with an offset is di=
fferent.
