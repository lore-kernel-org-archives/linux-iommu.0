Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794103555;
	b=fL3sqffxyb5oyNVGdnk/5M7stG1pB4YfVKFPzetu5RUwzDaBNM1o0HdbgoMIscZseInj
	 4DSqXIoavM/7n5coqcGAxKrHHMHZSqa1iax4CeKnu8KaAKwvy3Obq8Z5x0/cSFiiOGQnv
	 DXUhSMrPoP9luwYL7rtM9gnyxTXI/Nt4xWyMygznLp0iljSHIG628+fzha+MXRM4gjT8y
	 W/7tR+dCfD6/DgnRsrIPgvkkj9Ll38HhqQArdnm2K1r8Eeg3UHyy+MEeloxSN12wYABZh
	 yWR7S0StmVRLMo6LKGmUOhB2n3fQ9lj/As+G5PRxHw43/rmqfOjTviGXC+wVWlguS4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794103555;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=tZ3cb3vI/JlKWC9M4GlF0iTBKf/jfDE7Mio5RIYSa5U=;
	b=CrkUdw8AaSRb07MSejS3sOSAvAQMqk9PK10J2Bb+frHPnZcZzt4Wnb6P1vbz/yFAdkWM
	 ZIBjdj2QX/d+ZvkusB+qUZARccih82eqA/poEoQ3isKP/InDek1yBQ/HtQuFlbm0C4HVw
	 mO99OT9i+150RX/ISZYcDAVmhrY91EXp9zXXtvxuG9Zij3PWpKmfByG57PK4JDsTOc08P
	 90jUpWfcxSkKoge3bgzCrdBwfs7ws+vHXDOpgBopETDp80YTs7kQEWC6fQ3orlr3H9hCM
	 MDrWookmMAWzYCIU2sPaSFSKNIpOt+pWsIxmZK6guFpBTK3r252kDe8cIcJnGPlLrFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R7iOdzj0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07225606A31C
	for <iommu@lists.linux.dev>; Sun,  8 Nov 2026 02:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07225606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R7iOdzj0
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-54492d8a988so4031cf.0
        for <iommu@lists.linux.dev>; Sat, 07 Nov 2026 18:05:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794103554; cv=none;
        d=google.com; s=arc-20260327;
        b=lsD1Du+fIV7vsf+7glvIrm6eX0x0ZWpaWv1m7jbBlkESGCJebJrq/lGptpTMTWK9u6
         uoFszD8i9QZxYUdthnJK06SXI5UThC5Sm+G9tGSgGVJ+c/3GDQ1KwoV8gHN1z/l0DKw6
         dLnsF3OwLZKCKgRmLUEJiEkit6m0x69BxDYTKQEhIH+DU1GDSV/2Kf4B6WTIGKBWTjI9
         ytKXb1fF2olt0YnA4c8iVl5dQ/eOzBYlDD5OUySVPqrmgKz369n1KxtFxIaWUKXv495B
         S6rDpzAAcvHkqpRERBJz4BwGxscFTeIty2OrNEnOlpgDNUDwDYg7C5X+DPDCVumtTChC
         nOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tZ3cb3vI/JlKWC9M4GlF0iTBKf/jfDE7Mio5RIYSa5U=;
        fh=tE67N7RfFyukiUoLNb6goSpOWcOsVAOgwwwl/IFlBL4=;
        b=sTXLwQVeEJaB7IjvJ24a1Fr82E7POJbOG//hKvWCqhFrYv2i3+oP47PvwBWR2lAbwq
         HLlA+oBBgdrvY7I/a/+ijRiRbqrPD9lSoJlCaLCqMEiZi9mlMiVZ9wXOaxT1z1dOYzXH
         ofdaKXoVtFnXT50okBryTXiDHoo9H7Jq46BvwzbdK26wlGpbP7zmrTAgVW2i8EAmDDPN
         B2cltz35IwVlyqDGQBp03uXsahzwYaCxhTK40ilJgDkmYkz36l+W71qWJEEF9mc2LfZx
         y7v14BPzmznTGsnb5+CiHfcq9IL71pwU3xQ3FdniXyrSZ1zIKFPa0A0TSaNAVLatO0bp
         vW8g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794103554; x=1794708354; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tZ3cb3vI/JlKWC9M4GlF0iTBKf/jfDE7Mio5RIYSa5U=;
        b=R7iOdzj0cZ8JGaGPT81MCzLjpFQgDVtzGScHOBKJc597lx5D7C3jCR+dE8lPlgjl09
         aFsQ4PS4TYOYJzq3BBEQtaLV/HpuG/IDJAOGipUq8QbS+lSGcL4jNVldB0RSD18wSgPe
         1GW1upy/Vyrr/2oTy7ssDLemmayXPrXVzHXHzfPSwjUISZ6dgDYWM3FkZy7sWLCqY6/4
         Do8ChL/FYuWA1X9kg87W0J3nchyzMDoPH9EDa/xDLfNrZg4pnajfsGDhfIRwgyrxtnQs
         VzaBdEP7fNbis5CLVcqE6qlcvQTTVB39mUzqCutimop/IbiXtf0Rlr+zmDPSeFqgncfj
         JcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794103554; x=1794708354;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZ3cb3vI/JlKWC9M4GlF0iTBKf/jfDE7Mio5RIYSa5U=;
        b=QbSHDYecXIuC7fdnwRE9Ibmy83hQawz8fWU+OyS4qyEcBoJ0XzSeCIc1FkiythDyWh
         P9pHId8bGXZnFmHflvH1YJVt82k0NczBNK7jNyOXkhn0ACEeRJNV2o1H6xgysJfsZhKm
         Xvsdz4iMURRDO1kQ2S3RdvIB47Cp9Arq/CzF9riKIvjo+5wnrFv3RbHp2t1c4LUPDeto
         zgK8i5yvFEXnRWmp5KsJvE1lOLkCD8wptoLg0hPsCnavD5BnGpCsi98yXvVvUAv6zc53
         8AnxmcdF1Nx1dfzu9rpR+WfkuCwE8GIvejiR1myn5tiHEv7gXsEOTNkxxya3or2v6H5s
         /Gyg==
X-Gm-Message-State: APuU4Z/oP2I4J8QY6le3W0uRD08q1nEvzUc8xSm8odw+/kjDtrjzf2L5
	vDyfAL58NqK7ujWpIZkjfNcIctjVyu9ygOJuoZ8zm/zf9qaFI3CkF32fNxfqeS7ASF8F2ELMTcU
	guasuImLp5gXW66JKBYKFdlK1eCtEelstJMb7nSvF
X-Gm-Gg: AYBFou2I8O8tEgQ4Iop1Sm+I+a0xPmV6TN17m3Q+b5kwIU/CaupKV4BUZYCki4r5iJq
	mtLKzdHkf/AGu6oGAZy1y3b9YpMm/L+E87rH8dNq9uE7j5VLUJKF/IC+1yg3gRbfVwiwvt82IWz
	uOm+VhHTnj9KspcUDM80Sb9+fPNmSgkgvThNvsofPkWHSOTBwuWmfMRG+3QslIye4XDpR4z0J7I
	sqy3DjuWvAunlVcFyK+Z7n+9oYLamVBo4tBcxRNQ7LhlP9ZqfeOxm345x4SqjbL8UbnZKRFWFPX
	/n2AIFkWpOj2PXndcwzIn6iHm3gGVGAQOaE3+hqVpGy7fzwafOWanVafsI27MWjKT6a2ByN3fl6
	eb9izTxQhozUUrOhbXjX/jHVOOFqA2k4Dyw==
X-Received: by 2002:a05:622a:8842:b0:536:353e:8d2a with SMTP id
 d75a77b69052e-54f9de1134amr17137481cf.1.1794103553216; Sat, 07 Nov 2026
 18:05:53 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261004195027.227748-1-danielmentz@google.com>
 <92758f79-d5b7-4c15-a55d-6bea5f84a028@arm.com> <CAE2F3rAJdC9pAqMKcXhxpw1keGzH_kQUNBoPHXjTP8+7TOhfwQ@mail.gmail.com>
 <ae8db5bf-9f9e-4f0d-afa1-91718323568e@arm.com>
In-Reply-To: <ae8db5bf-9f9e-4f0d-afa1-91718323568e@arm.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Sat, 7 Nov 2026 18:05:42 -0800
X-Gm-Features: AclHuK9EOG_P4byoqFnHT9I6oYEPYHsXYF7yVIBFj_Z2u0jA_efLpQYmTCcKiXc
Message-ID: <CAE2F3rCocgqvmfhALrdo2VfLuyt0=oQD0zFUKLb5E+0deWgEqA@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Align memory attributes for
 SMMU-originated accesses
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, will@kernel.org, joro@8bytes.org, 
	nicolinc@nvidia.com, smostafa@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dawei.li@linux.dev, jgg@ziepe.ca, praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 9:40=E2=80=AFAM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 05/10/2026 10:26 pm, Daniel Mentz wrote:
> > On Mon, Oct 5, 2026 at 9:42=E2=80=AFAM Robin Murphy <robin.murphy@arm.c=
om> wrote:
> >> This still isn't answering the question of "why?" though. Yes the
> >> architecture says some things, but if we were strict about avoiding
> >> mismatched attributes then Linux couldn't ever support non-coherent DM=
A
> >> at all! Similarly while the architecture does permit SMMU
> >> implementations to be picky about their output attributes, does any su=
ch
> >> implementation actually exist at all, let alone in a system capable of
> >> running mainline Linux?
> >
> > Fair point that existing implementations have been forgiving in
> > practice. My thinking here is simply that a small, self-contained
> > cleanup that brings the driver into line with the architecture spec is
> > worthwhile on its own merits, even without a known implementation where
> > this currently causes problems.
> >
> > This is really in the same spirit as your commit 7618e4790982
> > ("iommu/io-pgtable-arm: Improve attribute handling"), which aligned the
> > attribute handling with the architecture specification on the basis
> > that:
> >
> >    "Although the SMMU architectures seem to give some slightly stronger
> >     guarantees of Non-Cacheable output types becoming implicitly Outer
> >     Shareable in most cases, we may as well be explicit and not take an=
y
> >     chances."
>
> That was more about being self-consistent and technically compliant with
> VMSAv7, which again is not relevant to SMMUv3. In fact if we _only_ had
> to support SMMUv3 and not arbitrary other io-pgtable users then we could
> point to 13.1.7 "Ensuring consistent output attributes" to prove that
> that change would not have been necessary.

If self-consistency is valuable, that is really one of the main
benefits this patch offers. Right now, when ARM_SMMU_FEAT_COHERENCY is
not set, the driver tells io-pgtable-arm to configure translation
table walks as
iNC-oNC-OSH (via coherent_walk =3D false), while configuring STE
fetches, CD fetches, and queue accesses on the very same SMMU as
iWB-oWB-ISH. Aligning SMMU_CR1 and STE.{S1CIR, S1COR, S1CSH} with the
page table walk attributes makes all SMMU-originated accesses
self-consistent.

>
> > As I noted in my reply on the v1 thread [1], under ARM IHI 0070
> > (sections 3.15, 6.3.11, and 13.1.2), a non-coherent SMMUv3
> > implementation (SMMU_IDR0.COHACC =3D=3D 0) in which every SMMU-originat=
ed
> > access configured with Normal Write-Back, Inner Shareable attributes
> > fails and records an External Abort (F_STE_FETCH, F_CD_FETCH,
> > CERROR_ABT, etc.) is completely architecturally compliant, yet wouldn't
> > work with the current arm-smmu-v3 driver.
>
> Sure, and another system could only support iNC-oWB, wherein this change
> still wouldn't work. If you want to argue against making assumptions
> about the implementation/interconnect, you can't simply make a slightly
> different assumption about the implementation/interconnect ;)

I don't think this is trading one assumption for another assumption of
the same quality=E2=80=94it is removing an assumption and strictly increasi=
ng
the set of supported implementations.

Because io-pgtable-arm already uses iNC-oNC-OSH for non-coherent Stage
1 and Stage 2 translation table walks, the driver already requires a
non-coherent SMMU to support iNC-oNC-OSH. Before this patch, however,
the driver additionally assumed that a non-coherent SMMU also accepts
iWB-oWB-ISH for table and queue accesses and silently degrades it to
iNC-oNC-OSH. By using iNC-oNC-OSH consistently across all
SMMU-originated accesses when non-coherent, we drop that extra
assumption rather than introducing a new one.

>
> In fact for maximum fun, you could even have an interconnect that only
> supports the iWB-oWB-ISH type, but the SMMU is still non-coherent since
> it's in a _different_ inner shareability domain from the CPUs...

I'm certainly not claiming that this patch adds support for every
conceivable interconnect design (and such a system wouldn't work with
io-pgtable-arm's non-coherent page table walks today anyway).

>
> Yes, 13.1.2 "Attribute support" says that the system may not support all
> memory types, and unsupported ones may abort, but then equally it says
> "[...] the SMMU is not required to generate attributes that it does not
> use. With the exception of R/W, INST, and PRIV all configuration fields
> that affect unused attributes are IGNORED." And this is why the
> mismatched attributes argument doesn't stand up on its own - without
> knowing the system-specific details of exactly what is being ignored
> from what we think we've programmed, how can we say what the actual
> attributes used to access memory really are, and thus what is or isn't
> mismatched?

It seems to me that our goal for a generic driver shouldn't just be to
support a set of known implementations that happen to ignore these
fields. Instead, the driver should follow the architecture
specification as closely as possible.

Thanks,
Daniel
