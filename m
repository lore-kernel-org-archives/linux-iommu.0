Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792702458;
	b=koB15RU5DfI2KooyFEJMcPZXjq1Gz1PV1TYktfYCMxtob97eoYq2dRp9ytp97iWQX34C
	 JftWGE05m8GqoCA8dBSOs8wijXPYFWaJEeHKYsAXvSr0SX97ak3u+HM/dB0IVq52zd6vr
	 silC0WEEA/192QB2bxyF4k4WB06z4nheMcg22YUeB8t458rEugFMSu6UCUMToKRlA60/8
	 fViHZGuZ+0bVVErhPEAXBy1umhBrJX9jywVDVWVCzZ8pNug3D4t3OBTxC75DS8YaObT68
	 vsf4sOvgTo+6zhknO973Nd6d/MVMhz1yCLt1HiIrg2FmjTD2rfB/G04GXQY5HQsIaRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=q7AHGxYo2F1tyAP4/knTgDUev2PNwFvE7RNfo85FnlQ=;
	b=mlO6Q2j0rFU6BXldyA7+5hr6bYAAoMvqaqEuXQne2pR0VaK0vfC302FOZqwvCzhc9sVK
	 LaJQPu6yH1uwXMnF4ZTm8D7Np/7xUI3NZwvIhUxe5RmP31COD5Z8l4lQOEWFv/tO+GlH8
	 vvCVoBxePeVJbK2zpQmDw/dcEl5wdF1H6K5tsNJxB1DP3zD+y0sVIhey1Zgn6EUnZqlLf
	 g4hmObW3rhgppXJck1A6H9+lOav3WD2lSKlUu1lEweP7wxUqrFxNhFmzfE8sEkT7ir40U
	 62DY+e5Nxp55MWh0nVpVQz2a93cnYeKJACqbSL/jYR+9QxqyE75A15AYpp09wPGNp5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EF8606A31A
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 20:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8EF8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6afafc89b48so235843a12.2
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 13:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792702446; cv=none;
        d=google.com; s=arc-20260327;
        b=lGIsO+I6Uy0qfnf1ezbD0o1y8VYKTpF5uostSxZmpFon4C9twTf3n4nmTNu58t+ygD
         EJeSgOv5pcWVAtmTnwN79DZW5LgpGPQGN73qIbXiZDzMY4qRgEvHxYx5vO0dsQZIxoaM
         8Xb1R8xTjHrQ7PlL9pwXnlZkNmLPrZsRfywMtcNTn3VQavdJ9+Ey8AKvAYXf3gHPENg4
         oK1RvtQJSN1X0GkcByrAvAZzXNLXnb2YeKwznJFzXETTyb8S2fJLNPNrEFx3MPYSGrNH
         XpCmvNWQlHAhF8HGCNe1v5PNJZ0XThTfRcTUfkYX1U5hUdF7iu7a3VvyL9ktv5tv59g5
         EiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q7AHGxYo2F1tyAP4/knTgDUev2PNwFvE7RNfo85FnlQ=;
        fh=CL1Sijr326n/etn5hkLboRnh7nzEZ69m/mMVFrXBCHA=;
        b=JWuxJL5Z8KegWmVEyPKXSpIbQvg0Tak7craY1Fq2OknUOhx3lByqHdRSAnIaV88J9m
         eH0cIZRKkJVYF+tzjfJ9BeBvU9iWfDAPuQjFPOLIe56wtOFhqeevksqscZKw14swwZbm
         JzoplKQVas57DiuV/9FVGvIjvqfy37y3CRsAT1bkRUb5xBk4mCOGQn7CEvM707NhHoiR
         3Z6qs6UtOXKFNvKoqiSRSpDXOmcWkqY7/jXzM6YNm7chXrRcHCfj4GIh+I3VqaxBa6iU
         Lbq264GBUwJ8vktMGOwbtFuujhIgKci/737p0yuvpZl+Hr5jdShW/O1g2+jMISoh9OJU
         uOYw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792702446; x=1793307246; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q7AHGxYo2F1tyAP4/knTgDUev2PNwFvE7RNfo85FnlQ=;
        b=VdVH63vb9xA8RkT7KWzbSVlWrBVOx+ImJJbH9fAseT+6IlStbk92F61SsEQc91MEVL
         yf6rsGBqlAATCj5KV7sOmITHmY+iYukqYTNkmAucj9rfJJCLw7xGf7lwzOBEn4vgkz4f
         UWdM7/uCFOZLTrmNw7/w//a16bh9QIUi9/uptGl7lBUfCs50jkaCeUC9YkgoetLswVtQ
         aW5odN4kKcW0gRnR+L095hrlYbntWgQvi+m2Jnw/lD7KJjBicbtJ2loesm/lumlzBrmL
         O9hwFp83uCronAW2UHdRQczUt9RX2KQfTkbiWcyRyb0oIa/RGg5AD4jQsNpdSdE9PdY4
         cwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792702446; x=1793307246;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q7AHGxYo2F1tyAP4/knTgDUev2PNwFvE7RNfo85FnlQ=;
        b=1qYgf/t4Ra/MteX1El9FGtHDr8lO6qI+a6IJdgrqHRk6pcFIj21AfCOBCdqHXiw9bX
         axYJcBykNSW12XnXbJd8IgK83MFr7EQElldAZ1RDM8i01m7MWxet1FVaCEHoTJOWvBg6
         B0m8KycRtjqvYlDOLFEDqZsDyZcy41dMazjFs5RWb1C22R+qg9jCgYEVamXmG9DFVAr1
         GCyB+TwlUcrnT2yIBAnD8fJTlFWg9ogGQ9WYQSFlUhYyVJ9SSFi7rNeT9CshE25JGGLN
         gggP0RXdByGe7vfV/fZSMrswSbzjtH1JEuQk5/Cyf47giVSj3COjFlulNE+mCbXDEFlG
         lvdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwflMtfMTYXN1YSaiIFlD3VWvfU2BjHRVtaZ/F64NAHbU6S6muYA+3iZ6XZMYQ/NPnoVkqpVg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLM4iiUJF4KLfkglZKej0BQYIki83PaIaYe9h122up69ONDSCD1
	/owOb0JYquO3H9uug5RmPrc/I+7cJ3mjuE0SDDbuJab2n5ntoEiL1UBjB78uL1/2ZqJflEeQ6yC
	1j/jrB8ddZAegCec+PU4/hkpSUo/SGG5RGXcshDP8bw==
X-Gm-Gg: AYBFou0uEj1rfEMC3ihIjmq+nFLzWlCtDnDxdcvJvo+iyUhVaTR2O+SzjLnSX0q2Kd6
	lFCMgX2VANP/JowiUA2X/uAU+wpytIW9JHLp7g+AjpYRmiMY1RUIvYAv7aHrytIz/0WUp30+ZVX
	122dY7Z55GMvBT7OS0bExZCuEqlviNy2F3z2XIEHqqcAN5NUzu96sUF0WLDybiqyOO1is12aMSY
	jA91OFuEMiktbquM92KqSdb9rMMEcXvPZ7UlFXB1Ez7GaQ9T4SwYy68UYUP8P1pxfuxKKgtZyKs
	93iuCe7/VUUhaZSuLCGjgbW8xgDtkWC8sXIf8EpEJK0pTnJZLfkVTdQ7OWDtMP6onbPiPw1ol9E
	W1fA59oM40idzNZwQNY91u1/lXr6QjyvnGq2B7RrCFabE13wb3t5qtiS9W9TqhMZD1HYZ
X-Received: by 2002:a05:6402:321c:b0:6b1:c299:b3f8 with SMTP id
 4fb4d7f45d1cf-6b432c1a486mr859420a12.33.1792702445990; Thu, 22 Oct 2026
 13:54:05 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com> <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com> <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com> <atpNFEFIlqAoYIwH@google.com>
In-Reply-To: <atpNFEFIlqAoYIwH@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Oct 2026 16:53:28 -0400
X-Gm-Features: AclHuK_o-bcMo-_bEmG9OJEk39HO6mWdZ96jtolFahfwsqDnw1LYQXgLWQ4gcJk
Message-ID: <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
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

On Thu, Oct 22, 2026 at 1:51=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-22 12:11 AM, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 11:53=E2=80=AFPM David Matlack <dmatlack@google=
.com> wrote:
>
> > > > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count, paylo=
ad_type) \
> > > >     struct name {                                                  =
         \
> > > >         __u32 size;                                                =
         \
> > > >         __u32 flags;                                               =
         \
> > > >         __u64 ext_flags[ext_flags_count];                          =
         \
> > > >         payload_type payload;                                      =
         \
> > > >     };                                                             =
         \
> > > >     static_assert(sizeof(struct name) =3D=3D (expected_size),      =
             \
> > > >                   "LUO struct " #name " size mismatch!")
> > > >
> > > > For example:
> > > >
> > > > struct luo_memfd_payload {
> > > >     __u64 pos;
> > > >     __u64 size;
> > > > };
> > > >
> > > > DECLARE_LUO_SER(luo_memfd_ser, 24, 0, struct luo_memfd_payload);
> > >
> > > This looks pretty reasonable but I would name the payload
> > > luo_memfd_ser. The combined struct that DECLARE_LUO_SER() creates
> > > should never be used directly since the offset of the payload in that
> > > struct is only valid in the current kernel. So I would give that
> > > struct a special name that makes it obvious you shouldn't be using it=
.
> >
> > Lets drop the fourth macro argument and generate the combined struct na=
me:
> >
> > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count)          =
    \
> >     struct name##_hdr {                                                =
    \
> >         __u32 size;                                                    =
    \
> >         __u32 flags;                                                   =
    \
> >         __u64 ext_flags[ext_flags_count];                              =
    \
> >         struct name payload;                                           =
    \
> >     };                                                                 =
    \
> >     static_assert(sizeof(struct name##_hdr) =3D=3D (expected_size),    =
        \
> >                   "LUO struct " #name " size mismatch!")
> >
> > For example:
> >
> > struct luo_memfd_ser {
> >     __u64 pos;
> >     __u64 size;
> > };
> >
> > DECLARE_LUO_SER_HDR(luo_memfd_ser, 24, 0);
>
> I think we are getting close, bu I have two remaining concerns:
>
>  * Reserving bits in each flags word for continuation leaves gaps
>    in the flag space that users have to know to skip.

Yes, but callers should never manipulate the raw flag words directly,
and we can provide simple accessor macros or inlines that take a
contiguous feature ID (0, 1, 2, ...)

enum luo_memfd_feats {
    LUO_MEMFD_FEAT_HUGETLB =3D 0,
    LUO_MEMFD_FEAT_SEALS   =3D 1,
    /* ... */
    LUO_MEMFD_FEAT_FOO     =3D 15, /* Automatically lands in
ext_flags[0] bits 0:1 */
    LUO_MEMFD_NR_FEATS
};

if (luo_ser_get_feat(hdr, LUO_MEMFD_FEAT_HUGETLB)) {
    /* handle hugetlb */
}

>  * struct name##_hdr only matches structs written by the current kernel
>    (in terms of length of array and offset of payload).

This is not an issue on the incoming path, we never cast incoming data
to struct name##_hdr or access ->payload directly. Instead, we parse
the incoming buffer, dynamically compute the header size from the
continuation bits, and cast the payload offset to "struct name *"
based on the negotiated feature flags.

>
> How about this instead:
>
> struct luo_ser_hdr {
>     __u32 size;        /* Size of header + payload in bytes */
>     __u32 nr_flags;    /* Number of features encoded in flags[] */
>     __u64 flags[];
> };
>
> Each feature occupies 2 bits of flags[], so feature N is always bits
> [2N+1:2N] of flags[N / 32], with no gaps:
>
>   00: Feature not present
>   01: Feature present, safe to ignore if not supported
>   11: Feature present, must be supported by the next kernel
>   10: Invalid
>
> The length of flags[] and the header size are computed directly rather
> than by walking continuation bits:
>
> static inline u32 luo_ser_nr_flag_words(const struct luo_ser_hdr *hdr)
> {
>     return DIV_ROUND_UP(hdr->nr_flags, 32);
> }
>
> static inline size_t luo_ser_hdr_size(const struct luo_ser_hdr *hdr)
> {
>     return struct_size(hdr, flags, luo_ser_nr_flag_words(hdr));
> }
>
> static inline void *luo_ser_payload(const struct luo_ser_hdr *hdr)
> {
>     return (void *)hdr + luo_ser_hdr_size(hdr);
> }
>
> and bounds checking is just luo_ser_hdr_size(hdr) <=3D hdr->size. The
> payload is always 8-byte aligned.
>
> Payload structs are then declared on their own, with no header:
>
> struct luo_memfd_ser {
>     __u64 pos;
>     __u64 size;
> };
> LUO_SER_ASSERT_SIZE(luo_memfd_ser, 16);
>
> The static_assert covers the payload to catch embedded structs changing
> size.  Asserting the header doesn't add anything since its size varies
> by kernel. And because flags[] is a flexible array, the header can't be
> embedded in front of a payload in a combined struct; it can only be
> reached through luo_ser_payload().
>
> I think the only downside is that the header increases to 16-bytes when
> there is at least 1 flag. But I don't think we need to be so concerned
> about an 8 byte difference...

I would prefer to keep the default header at 8 bytes. With 15 features
fitting directly inside the base __u32 flags word, adding the first 15
features to a struct keeps the header at 8 bytes and does not shift
the payload.

Computation-wise it is also very similar: for the 99% of structs that
have <=3D 15 features, LUO_FLAGS_CONT is 0, so computing the header size
is just a single bit test with no loop. Even if a struct ever needs
ext_flags, the loop will walk at most one or two extra words.

Pasha
