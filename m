Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679C5944F
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759169496; cv=none; b=Wmvydi32abcOwPwhnAH1u1k9JcOhdLJw8hL6Nyq1anlypXAGJ4Xge55vvYbakE9WudhV208RYyLm/Y7hkZ+6atu7y7DauksO3pDm1QRBUIANtipIJvzdquFNtnft9nQe7dJO32s1u9GaHY9W7fdOr+zIctAiIZ4Tq+fHkO+rwfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759169496; c=relaxed/simple;
	bh=oaBnKYKRtDSOkq82mNcg4j2E9t3pxhoUAjF8MG0lM7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZ9HPkfj4Z90BTY9Um+ICADVIgsJEluHTbRXlK7hs/E8SMBrEisPCA75IZavRsqJ/I22/ObNbvy7sVmIHsgE4sJbBoPFDp1ngzbaCii8+rAjJCTaJTZ14DArlaQPbKA0IKEC/5xbA70O/2IWl7yqvVsji6ucJFSENIGZjPOAgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D1/mmEd+; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1/mmEd+"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4de60f19a57so53811cf.0
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 11:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759169493; x=1759774293; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WP9Pb00ucL3q+YTHoUOjxzFDPuJDXrkNbKXJ5OVUaw=;
        b=D1/mmEd+CHdf5lIkYRJu7ETd0IizioUxulwGFw077cPUuGU19T5IjgAE4/1fVcFmOY
         KuR/25ffGNFJjtJ7s9CgxcOtZZOkSTOrM6+B9uxeKhBdKfTXvMoj/iQHCNdaYTwmy92H
         Summw0bw6yNrt80Eb3pTMxAbdZUKB9OUuaT6hZhAK87GaGgvsWLL6xv/fqXHiIAZRpko
         2+NmMVe+zcvQT0u3qyrWtpk5ClTnqmhr6JoO/LA133g7hOstP1ucn7JGzIqewIo3R7sO
         k7haQEC3DEzcWw1pyrZAVdthSFtWMLp3sJmUH2ZrX/6xc57D7siwCDxuDAquecaf3SPU
         VUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759169493; x=1759774293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WP9Pb00ucL3q+YTHoUOjxzFDPuJDXrkNbKXJ5OVUaw=;
        b=cl5PAYVe5KG6le4UzvUI6fFNZ6THxvKgQIMb7f31BzVqVDizNq+TM9qTg0qIwD2o5e
         /Z3UuyqhaG3+RGUNzDfm+yiSTiqQX4f9oUv+iLsmSzLRg5jrEw44/ZA/OPkFwMDXH1D5
         zy726k6oiw2mrga2dre9f09Ln822kXEdc0EcutU4txghRv44Ntl32ScY0P8O9ySiprYM
         a3wq2DJFY3mS0PV4i6vSmpjtKZwREE6cwueugimJaKEAQTnp3olkGQcalht01U7cJ/uP
         EaYVvaFdK976zb3/SRj56YjrhVjlUMqjtGZw0WNm2g+yA1Cm7ksK8/USFjnkwBF6151+
         a/lw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Apur55RqtjAIBYiQCsE5A4U//95GzDeGXIjgUUCFRKFtlKgkDiodh+0Y8r30Az/XKZzFeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwH78Nq1qInci6RI3b2y0+MbTfg1981edi7wa5optzas+dRCL60
	3MaxNbyCj6YvoPWwX6ybb2Bylpyg37iv3lVKrfJhg98mRQeyKqNHGV2zVS/nXTWy2CaGRaFHHHG
	5YIeHnEfwvdzg7V+AFr81W0pJGiW702P5kI7saQ6e
X-Gm-Gg: ASbGncsiv3NLHY9rBc8Ep2GcGUBT1gf8+7gKjTNisZ0pn4p3JttbGEWSLcWCaNWUwal
	tKpmIBnAoFkl/KDinp3u5zSpGk/4ZfV6xQIcJV3Ipk2P3cBsVclL9lf/QOFXBleL9QgzmYJ3IDC
	8gr7C/NZndFAOv0C2IPEX69p13ixv5sGg//nVGGJSBw5aAZ2Q1mm2+75ACA0DjjBqQV0s+mqDe2
	LKENhvSO0HO60dpUfCxRzCQpHvy1xZw5zJ4mv1lAiricsyfWUfxkG0=
X-Google-Smtp-Source: AGHT+IFk9+g5RGER16T9Rf5j3thJpIbSLaw2lbdh0SFeSMJ0I/BaCi9UDExRyE6OwQZRBGlbkaoGaNCtxagEZxiCCDI=
X-Received: by 2002:ac8:5790:0:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-4e2d49c9dd3mr898521cf.7.1759169492701; Mon, 29 Sep 2025
 11:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-6-skhawaja@google.com>
 <20250929155430.GD2695987@ziepe.ca>
In-Reply-To: <20250929155430.GD2695987@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 29 Sep 2025 11:11:21 -0700
X-Gm-Features: AS18NWBVbyJFfnqTe1gc_E_0boTIQTS5TdlZZnZSyILctEmVzhw_D3pAIZAsjos
Message-ID: <CAAywjhSnmSeiJ-GjensY4x6DMsTCtG-Gxq8WtMc7BLTFfXrEmA@mail.gmail.com>
Subject: Re: [RFC PATCH 05/15] iommu: Introduce API to preserve iommu domain
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, iommu@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 8:54=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Sun, Sep 28, 2025 at 07:06:13PM +0000, Samiullah Khawaja wrote:
> > Add an API that can be called by the iommu users to preserve iommu
> > domain. Currently it only marks the iommu_domain as preserved.
>
> Merge it with the previous path
>
> > +#ifdef CONFIG_LIVEUPDATE
> > +     atomic_set(&domain->preserved, 0);
> > +#endif
>
> The memory is kzallocated, I don't think this is needed
>
> > +int iommu_domain_preserve(struct iommu_domain *domain)
> > +{
>
> I expect this to accept some kind of luo pointer to signal what stream
> the domain is part of.
>
> Domains are linked to iommufd's which are linked to luo sessions. This
> all needs to be carefully conveyed down to all the lower levels.
>

Agreed. Currently this is based on LUOv3 and once I rebase on top of
LUOv4 I will rework all this.
> I also expect preserve to return some kind of handle that the caller
> can hide away to deserialize.
>
> > +     lockdep_assert_held(&liveupdate_state_rwsem);
> > +     if (!domain->ops->preserve)
> > +             return -EOPNOTSUPP;
> > +
> > +     ret =3D domain->ops->preserve(domain);
> > +     if (!ret)
> > +             atomic_set(&domain->preserved, 1);
>
> And if we have a caller handle then there is probably no reason to
> have this state tracking atomic.

Yes, all the domain states can be serialized and backed by the caller
handle. But we will still need to mark the backing iommus for
preservation, because the state of preserved iommus will be needed for
restoration during iommu init during boot. That is why I have a LUO
subsystem registered for IOMMU.
>
> Jason
