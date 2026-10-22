Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792627492;
	b=aS9U0yawsK6tmcRSQRYga+Xe1Wzt/xuCsDqAh/SRE+S7PkLnQEZcR2R+K5clAhvJHMk2
	 bsFNVASVNJVcPKTjw2BHHPWQK8HOmFmVmRi3DL2RoaWaNgnqZtcxQWG6o52ldr9UFypLB
	 +OnElrNFk7p2Cc4ws01v7yQqtgVmezzWLuYiLwsB3U6+Kh2yt8Y86Sz3/ONQw8iFmicJW
	 t8K992R4OEdtQvZTDgIGWgOvVH2it5sXb2ouHcHbHRkUxxc+dE9tDsB8C3MR0+PFF9Y2R
	 pxovlSzbX6dv5tNOcEY25P7yRBCH1LHfC7mGLUKw/p2Hw/E0tluzJQuxMbzzgrXSFbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=voL3QXhcF0nQ+Bl+k+0kNlvS+kVkqIaUYWi4xHN4x/I=;
	b=S6Cz5eJKCxGePC2qe9/PJneo40IWFZ2nPQiCtZoQmkpTcer9faG5JsQoV7Cc004iH/z5
	 vFWSB/MP9/fKYuf4mjLScXqBZMM00i0XXNosSkC5yTLSXxK7TgWS+VbBPKU2wpNOmMpCe
	 LNDGoAQF9m+Hhu1bA/uPcvfU5T2TTcVHFTouUYAt0UZVGwgufDh2iJcKRLmL32miZIQb1
	 31Lz36QVbYYN9VnBsbwNfJCUs3bFRzcAY0gZz11ntTBlj9BuV9908B/boXvHVz6c7anfU
	 I0YniuQjlemzVcxNMUxoUOzuJngQ5rmoXxQMR6T70Zqrp2pxEsHrTgXTsQGbajCPUZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PFE7lRva;
	arc=fail smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C759606A31E
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 00:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C759606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PFE7lRva
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4395d31228so182628266b.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 17:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792627491; cv=none;
        d=google.com; s=arc-20260327;
        b=bLKVExZIrhPyhVJV7sb5ZVqPjaAxVTN0ii3lPw715FJoxPkdIVVq43FBWBrhqJjz41
         JryJdrfpq9YQhCPy6NszjILw65VsdafJP75cKb/OqtV6vu6bbAmZ+saGwWQUJwRpkBI6
         G8jePFmZf+g/BuJqVWqlUNfDC+cGaPtZVyfBZAxGVCgr63c2GtqS5IA9fHuImSYRJx5e
         n2yEWrn35knO8jJKdStRbM71wp8pWNDf1gtYVc6kE9ZRouGr8wtkzVqtxq8zQ2k+ioyZ
         12inRP+WF+ftz4avyKT+YoCQof9c0FkyMx2ZePN64VlWEUPkw+bMYE6uJTBVQ6Oe/snU
         5EqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=voL3QXhcF0nQ+Bl+k+0kNlvS+kVkqIaUYWi4xHN4x/I=;
        fh=HXp/XIDUh2qbs8hznbE9da3ndcL2r8SyZPjp6cp5+AY=;
        b=PEJBM3+YqVQRKYhtZN6pK/IFvyhjQxWocZOGL/oZffJcZXxAbsvGGzAr7er+7VOO20
         gX++FiMHBV/e26mNGSX1uiNuotJWkVHtTlUQJn3AAVYYtKHAlD9l3lqLyzbmntjZG/6h
         QpH6EG+Ceqi7tJz/GGrzTDmZRvCCZO4Jb/yMOlsRcYcApGsCYyR6yx8kzBKT5XPLcvQf
         QyJFpd9z3GjnwKxNUxSXvz9fZQtgAEjjwQK3hi+IwJRonolpjxsuhHRPDeqnxZMh4X/6
         zdeyCyPsnIL48Wb3fuUmJKX/qJJNZJwFjpTmABlC6y2d4BshiE+1XR1g6qKNAfBbKDAf
         2LPQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792627491; x=1793232291; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=voL3QXhcF0nQ+Bl+k+0kNlvS+kVkqIaUYWi4xHN4x/I=;
        b=PFE7lRvaLr5R+mBeTiEyI9aaEry1bjiSJkbYSt9R+Qppwef3fMRtRSu2/10AAaEs0B
         t4O1IcNA/TgvyXsYgcbR5caxG2bo3yW9HcuYM8bEgNIsY7xyi3K/Oj2LnrZGPeRXaQqv
         3nbnm7oznTggfA1dxqMiZImcaIb+TBOuFznJPX3903+8QuVWYo7Y67sep7WrfDOyhd9+
         8Gh11/TKCxTVsXmgj/MUyntb44IxzukJyYDHxyNsfGB0PpeS9JdGNMxcqogcWRNjAX+C
         M3vRGofdScpNirDQYfIBaeBIpb/z2cBp+BwTYVYgTIGAhLcMzh8Q3fzyY0yx+QEjZbbG
         3aMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627491; x=1793232291;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=voL3QXhcF0nQ+Bl+k+0kNlvS+kVkqIaUYWi4xHN4x/I=;
        b=n9occIjDMO0z8SxCwmS/xevFEOZ7+0FH/lNqqhWjb4KdX9BWoX0X/kOFERDRL64ZW6
         BIiG0WtTVVzc2TB9j1UyrqQf777ZovMKPQF3KlyX91qQetEd2Txr2S+tEOBPs6i9go9H
         90UKSStWMULlAN/BKMYPCasoLGdWpahRDHA2VwVZkm4Qpv/sj4nZXnFgu9KMCEM1y4Mp
         pzwS4dJq+t1Z9OOkmAivSLmSN+fUgCew8kj80ww7PHnhOMWvzJh5oOyMotP2eS+e4ge5
         Do4e53QmNXj/ZtKYOhJhn2OhLh/tieH23GrcpxSW06LvTUEAL0TQSPq8bddUCdPrvuxt
         Dmvg==
X-Forwarded-Encrypted: i=1; AKwUvByaZmnIbWh94VxtMdmOBvCkFi+jzcdtGd2s1rnxnMzSyoACNHPyu4/yCovX2R1c829vM0/BFQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIRXaIXhf2Ujk9YbMq9qfnOSuGff2o6KSQk9KV5rUToUyVRjAQT
	+DICnWcyOeGVPmEXLn2CMwmNqa+TbWMe+K5DaPtwJunQ127uHF5B2919von8HXao39Nmf8LKcPY
	C3j+YMWPiK3GrND+VqGvym1e1UlUqxU5kpZNw5LRO
X-Gm-Gg: AYBFou04wvD9YTCMJaDRmuu0/3Q+1koN8nZ/MBg7G6h4ixv1V+5fA307F7SnRXQ+ulH
	arbUjZXxNp8MBYAg32kDBJLE2d40cVx5UooDBbTMiSb+Y/aCvK884rDlDUgmDL0Bzmwa7oG4mKx
	4g3PD6gtjAcdFKVBkpDjnCb7HbFoBkoJK/AnydetZC0vaMmvPzPA8gTGSJb5eagM567DQkJ8J9t
	N+9wYe/6cpldXJL0cG6ReJG332tET2/LBH4ia8zdoP8YB1a9ERdhVaC5c0c14PB6/S0DVwkALBk
	/IAXmGhJ1QFd9bNQxAfl6hxEugFpr4dQ8GwoN6GJIJfX+tQxKrz8D2Qb7BGrdh4pXwycSafkjbX
	BVmpNIczf0B/EALEGThgmzTnf+BrsRZi3+7RvcA==
X-Received: by 2002:a17:907:86a7:b0:c34:cf13:a930 with SMTP id
 a640c23a62f3a-c4679689896mr324348966b.34.1792627490183; Wed, 21 Oct 2026
 17:04:50 -0700 (PDT)
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
 <atlQ_Er0Ig7CCSxv@google.com>
In-Reply-To: <atlQ_Er0Ig7CCSxv@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 21 Oct 2026 17:04:22 -0700
X-Gm-Features: AclHuK9LuxkFhyY58-PllQ_xn35qEFAv5-F2hDjCZHaof6GARbd972qVOi8lSVA
Message-ID: <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Tarun Sahu <tarunsahu@google.com>
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

On Wed, Oct 21, 2026 at 4:55=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-21 03:25 PM, Tarun Sahu wrote:
> > LUO and its file handlers validate handed-over state with monolithic
> > compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialize=
d
> > structure, even an optional additive one, must bump the string, which
> > breaks live update between adjacent kernels. Replace the string in
> > struct luo_ser with a feature header, so that the target kernel can
> > accept or reject the source kernel state per feature.
> >
> > struct luo_feature_hdr is a fixed 128-byte header: the serialized
> > structure size from the source kernel followed by 15 chained u64 featur=
e
> > flags entries. The fixed size keeps payload field offsets identical in
> > every kernel, regardless of how many flags entries a source kernel uses=
.
> >
> > Each feature has a 2-bit pair (req, active) state (enum luo_feat_state:
> > LUO_FEAT_DISABLED, LUO_FEAT_OPTIONAL, LUO_FEAT_REQUIRED). A flags entry
> > holds 31 features, and bits [63:62] =3D 0b11 chain to the next entry (4=
65
> > features in total). Each subsystem defines its feature states as a
> > static const u8 array indexed by its feature enum, which
> > luo_feature_hdr_init() packs into 64-bit flags entries with
> > LUO_FEAT_EXT_MASK chain bits. The target kernel validates the header fr=
om
> > the source kernel against its own feature array via
> > luo_feature_hdr_validate() according to the per-feature (req, active)
> > truth table:
> >
> >   Source Target Action
> >   (1,0)  (x,x)  Reject -EINVAL: invalid source kernel (req without acti=
ve)
> >   (x,x)  (1,0)  Reject -EINVAL + WARN_ON_ONCE: invalid target kernel
> >   (0,0)  (0,0)  Accept: feature absent
> >   (0,0)  (0,1)  Accept: feature absent
> >   (0,0)  (1,1)  Reject -EOPNOTSUPP: target kernel requires the feature
> >   (0,1)  (0,0)  Accept: ignore payload data
> >   (1,1)  (0,0)  Reject -EOPNOTSUPP: source kernel requires the feature
> >   (x,1)  (x,1)  Accept: use payload data
>
> I think we have different definitions of "required".
>
> In the PCI series [1], required and optional flags describe the _data_
> the previous kernel handed over, not the kernel itself. A required bit
> means "this preserved state depends on feature X; a kernel that does
> not understand X must not take it over". An optional bit means "the
> data for X is here, but you can safely ignore it". The source kernel
> only sets a bit when the preserved state actually uses the feature.
>
> It's up to the FLB/FH retrieve how to handle the scenario where a
> required bit is set that the target kernel does not understand. For the
> PCI FLB we panic since failing to adopt the PCI state could lead to
> memory corruption as preserved devices can be doing DMA.
>
> The target kernel never requires anything from the source. If a
> feature is absent, the target kernel must handle that, e.g. by
> falling back to default behavior. If it can't, that is a compatibility
> break and should be handled by the compatible string.
>
> In this patch each kernel has a single static feature array that is used
> both to generate the header and to validate the incoming header.  So if
> kernel N marks a new feature X as required (so that older kernels reject
> data they cannot understand), then kernel N will also reject every
> kernel that does not have X, because of the (0,0) -> (1,1) row in the
> truth table. That breaks forward updates from N-1 to N, and rollbacks
> from N to N-1 even when **nothing being preserved uses X**. Therefore,
> every new required feature becomes a compatible string bump.
>
> I would drop the target-side required state entirely and let the source
> kernel decide which flags to set for each Live Update based on what is
> _actually_ preserved. Accessing a field added after the original struct
> then always requires checking its flag.
>
> At the end of the day it is up to userspace to never start using a
> required feature while they can still rollback to a kernel that does not
> support it. Cloud Providers know how to do this since Live Migration has
> the same problem. This also means we must be very careful when adding
> new required features, as they need some way for userspace to explicitly
> opt-into them. I do _not_ think we should try to have some generic LUO
> opt-in for required features. That is up to the File Handlers and FLBs,
> as they have their own uAPI.
>
> [1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@g=
oogle.com/

Oh and please see the follow-up PCI series to preserve BARs and bridge
windows for some examples of using optional_flags to extend struct
pci_ser with additional data without breaking backwards compatibility.
e.g. https://lore.kernel.org/linux-pci/20261019213054.3157159-5-dmatlack@go=
ogle.com/

I don't yet have a use-case for a required_flag.
