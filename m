Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792632406;
	b=Mc1AbumHrCAjDe06cQxdWbkzOTFlCsYwKbXBvt8LK6TTHglnD/UyiB/W+/bBKttbcDm0
	 hHT0I6LvKYh7uVvQ0fS3Z7wFgQEGuxsB27P4LvdcS/eMH6KdDb8NLjNHNxDTzN6Hu2x7G
	 Lyemadv/DQ+zJ1TeInPgokpgXbJV+pXekYDcr0I4H0NC0++vMAIoTb6EqSq8VkCszhfxU
	 2cAOkgxsy9EhlIDWLLnW0DKLxKTGLdAMVxlffBITBudvnjVRRD3dxDI2GyebD5Z4+w5Eq
	 S0LbMXJPvO5NVVw6pHRbjmg6MdZ7lM5Zd14FbUwbCNFMQOKwanPj6zp3zKgcCat9fyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792632406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
	b=WgyvpGxLWdcKZ5fyKGyt5Zm5Qpkr/MIVqhUWdDfWdp2crxcfGjLToYCC18ZVYctVYIDI
	 C8H6TJ6CzjvhVg28DwD0TBWK4SQIxnFPbOXO/YKWX1xvOhGGkkMNZhNaEzQCo98HrT89H
	 TAm1IYZgTOyt2Bt578usThQT1aspcVGylMkzBn9MR0bbupDnKuTIkaoio8PQ/6+55tyTL
	 2Jw3VzdQX2Mv1MRdjLjQrMHhwZsjvj7bIzFcCE8eBnMkJZ/mWG8fqX+Zl63j2HPNEwqqR
	 AaW8cLW+dcgaeC59FKtiEBTgseIGFmajFmkaZ0OY8ji7kk1AqRdQztryjcX3otr5x+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=jXamviZv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7B606A31E
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 01:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36C7B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=jXamviZv
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1ab2ad719so2162366a12.3
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 18:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792632405; cv=none;
        d=google.com; s=arc-20260327;
        b=FQGPxd2m2d3W09xZ+DIo5ENGCkfW1mAtEDzVSdK8b7yvt8eN2tKsw6YGbX5qBb1hcf
         f2tswqarh3k4UfXlUV1I5hhUdKE1qvj7UEO8GtgMyXnUuLaxJlOovCQrYH1DKcHYdhZJ
         ycrQJwcRg2IpJ6bKvtw9oEgEHJtmi762960RI+SMGqa3b00P59VdY0bu4Dwcbj2D3J/j
         NsLcPKdvTh+Vb417eLp982GoG+FmfY0QIp3Cq49mnX2XrzfNL4dUWtVqWLssVfSozqos
         m0jAAYL/5qWCoQUguWFwCAUh2VD0Z7XsW/vTkwPrbOzYqgB+p/xvJD0s7N7eSxMGsUTM
         PKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
        fh=8o1CvTycW/0CT04MtUkexObsrYErnzDd4T1kK27LuOE=;
        b=EhEFPZTh8jfkXFjX6Nrz6zsI/cd1jJA5TcUuHppf2dzfoGGswGfrt2Rmjbmg9SGmBJ
         f76IEmpLfNR5CVUem0KfIC3KACKM3MU4ODWukWu1uQZ7JiCkx9YXdBJ/8RZTIC4DrlEV
         IiS5s8NjFJL91jghLVBVs+P+3ipQFzkk/60pi3Ur9UWDUJwm/NIuceXKRaTKIQqkFPZi
         AgIa8buKv3Yis0Fpb9+Ev0aRAeNZ4u29KpaJvpe/qp5VhpLgp8y+eIwP2RcPtOygC+9m
         Jyr1ZBgx5RU3e4goQXWJWPdemcKll2A0aOo3wT4hOoTR1mV2kZUegzJzt4uJIl5sCGGn
         M1BA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792632405; x=1793237205; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
        b=jXamviZvVCw6d6EuWowG9KbcuOmiIIHa60jvyMw286WfUF9Ki3KTcL/YQYGP6eO+TK
         KFmkrNZBPp5NrMauIT2ocxc6o0g4KfwZH473AHfAcWVjMtz7958Ef1J5RtTqy+ct2it8
         V7dpqiAPDRRSvTD+X9ZJ0hUTf+Ez2npO1TWgbKG2gNJj0WlGzxJVAHQ0UxU/SfDwPlt7
         njFc8dNJlA7w6agj7+gY0yV81IMCG/GTMmrddjIM3os0oVgJehcnifEceRWGN8OxzxAM
         k1aFcD80dCQD53loIydci/T3d+mOEcpx5bKNl51UwSRW6jUccDZDdz/aFtmqUJBPR11S
         Ysmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792632405; x=1793237205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
        b=mlxANwBMbx15QCagxVzTW4xDDB/0PP+VmG1a16OhiTtrDDvN//jAC3315VYnN84QkQ
         9h7bQsuYCu/0iTwFZTneIilTYR3J2RPL6mUBw/G87zKF8zah7lXA5w7wzNxX094MfjYE
         PtipRhyXE3HyAb99TGGNY3SIiSiT33ELuLSpe8z/5gChTUqBoaOhCdZfcWXiT5EyRKbq
         9UYJdNpN6tBOPZa5GrsDG/hl6o8b+FqMX6lo9QHXVUEn6Hs4V170bkUvAXQ7NpWcGD2J
         utS14CtU/yHKKNgDHcdGF860W2KoNbDLcw03GAHNH8fxzLxP2k8DTioShksn2+WQV7Pc
         MtMg==
X-Forwarded-Encrypted: i=1; AKwUvBxRGWI1BM2JugPIiJDG1NsdknImQVCuWhIGDUqFWmJmv+6wBYL9Yqjy7V1sAqrQz15XzfganA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJvQ38gG81jKmmNJrdl3tSl/EzFLq9m3Kw8SGziVljavWLXY+Nc
	ymIi8jZ/kfEJoiz8sFwmkSC4qTWL17XM8F4z3hGtO4gGE4cw4DHiixm/eZZNdrgdDVITu1b74oL
	kfUX3NFY2K3S+bRfhJUbhcEJtY97zi2f4uucptxpKmg==
X-Gm-Gg: AYBFou2d0VLs0TqcPbjK5UBufUdLsBygVgw+hRoZ1qq7oBaQxJzvtZwApb4h6yM2YvV
	L1lNMu2vomRehC+p7Aa7B/iCes5PIpiJVncAGpCQv02JcqVaf/BjOqHOvpZAyBBRifTnT7kP/AG
	dVzR4Kocdazihw5tmRwRCyTakzWfItmdS3rxpDuqPe70npV2fCd28dtcbKFN4Mi6kditWZYbu1A
	N72HJSNfC3CHEUC3x+6UcWzXLq7CKEpQ4FpLjHdhBvtm25qyGVus7sRF37+RtOpjBlFGETzjOeD
	rVT2mbuBolqprAiJehXlK1/pTzroVn87Gjy2Zu/3e0OvWlDAQJFGlsifnPRHa3S5QJknmsHyfAA
	t819t9AjdVCfC2bxdx2jWRTyLHDAVoHlH5y/mI2zmV89yBLuRPx6zkbxhcmtciZc+/Gc=
X-Received: by 2002:a05:6402:2801:b0:6b3:a1ad:ef6d with SMTP id
 4fb4d7f45d1cf-6b408dcce19mr2969744a12.6.1792632404378; Wed, 21 Oct 2026
 18:26:44 -0700 (PDT)
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
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com> <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com> <atlKsD-aJB3mJr2j@google.com>
In-Reply-To: <atlKsD-aJB3mJr2j@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 21:26:06 -0400
X-Gm-Features: AclHuK8Appp8OBdUFGLxu0V1hBTCm-a-9f142JZiexa4wOQOsDrRrU21F_J0R34
Message-ID: <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
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

On Wed, Oct 21, 2026 at 7:28=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 2:47=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> wrote=
:
> > > >
> > > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > > >
> > > > > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@go=
ogle.com> wrote:
> > > > >>
> > > > >> LUO and its file handlers validate handed-over state with monoli=
thic
> > > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a se=
rialized
> > > > >> structure, even an optional additive one, must bump the string, =
which
> > > > >> breaks live update between adjacent kernels. Replace the string =
in
> > > > >> struct luo_ser with a feature header, so that the target kernel =
can
> > > > >> accept or reject the source kernel state per feature.
> > > > >>
> > > > >> struct luo_feature_hdr is a fixed 128-byte header: the serialize=
d
> > > > >
> > > > > This patch is all wrong; 128 bytes is far too large. For every _s=
er
> > > > > struct, we only need 8 bytes instead.
> > > >
> > > > NOO, It is not. It is intended to avoid complex mess with unnecessa=
ry
> > > > over-engineering.
> >
> > 128-byte per serialized struct is not starter.
> >
> > > >
> > > > >
> > > > > The first 4 bytes are the size, and the next 4 bytes are flags (i=
.e.,
> > > > > 30 feature flags + 2 reserved bits for flags extension). The last=
 two
> > > > > bits of the flags indicate whether an extended flags field is pre=
sent.
> > > > > Each extended flags field is 8 bytes, and its last two bits indic=
ate
> > > > > that yet another extended flags field follows.
> > > >
> > > > If we will have dynamic extension of flags, Think about this.
> > >
> > > To support dynamic extensions in a backward compatible way you want
> > > something like this:
> > >
> > > struct luo_feature_hdr {
> > >    size
> > >    flags
> >
> > __u32 size
> > __u32 flags
> >
> > >    extensions  // offset of first luo_feature_extensions (or 0)
> >
> > __u64 extensions[0]  --> but the size should be specificed in
> > declaration macro that I showed in the next patch.
>
> I think you may have misunderstood what I meant. In my proposal,
> extensions is an offset to the first extension, not an array of
> extensions that immediately follow the header.
>
> If the extensions immediately follow the header, then the number of
> extensions is baked into the struct layout. Every field after them sits
> at an offset that depends on how many extensions there are. If we ever
> need one more extension, all the fields shift and old and new kernels
> can no longer read each other's struct. That is the problem Tarun

We can structure it cleanly by nesting the payload: something like
struct { struct header {...}h; struct serialize_data { ... }p; };
That way, the header can expand dynamically at the front, while all
fields inside `serialize_data` stay at fixed offsets relative to the
start
of the payload.

Since the header size is self-describing via continuation bits (e.g.,
the last two bits indicating whether another flag word follows), LUO
can
easily compute where the payload begins in the incoming blob. This
keeps the implementation simple, avoids linked lists of offsets.
