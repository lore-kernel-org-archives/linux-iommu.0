Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1BD18B1A
	for <iommu@lists.linux.dev>; Fri, 27 Sep 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727452783; cv=none; b=ssAwhbmAAAIZYAhoeG5A/GL5eQJna9aqTof6amrbLWTRINA+kF2KyaNBhenm2jQo6xn3ZyWjjStMpLO65HqDH9JMUrIu3/oj5p3e8OzKSaIpR8iG7sGk+One3ntaDtYFckjRGsw110EQcNm65D6UzTVDyyuPm1O6j2nS5a+GHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727452783; c=relaxed/simple;
	bh=mNcJxIvrUlKBRWm7kcRpla8DkgOPTgYac1kq5Li84zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ng4rjGqFiKkEv6SZCzEMkWcY3L6ymkSFKUnKNljBI9ErZUID1TtAIzx931823/VzVIgNiIR3X53ShJ5Fi4nRfAR+Kk67wrgdPjJpYoRcUeaWtj28uzaPYOWf3xCV4xf5XwM/O+QzvJrh6gH6OcQks+VRRLGvUWwyKy1klBzkXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O362Lqkw; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O362Lqkw"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4582a5b495cso246651cf.1
        for <iommu@lists.linux.dev>; Fri, 27 Sep 2024 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727452781; x=1728057581; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNcJxIvrUlKBRWm7kcRpla8DkgOPTgYac1kq5Li84zw=;
        b=O362LqkwWYZvzwyUjXorMLJxozcfzMwczAvVe/vOdOvsCyxN1CKgO0IKgNdVa5RcyI
         LeztXfcMtLyXL+cQMuEUwh0tDtxhsYCrqPkp4yHjrCq90jBliBoXhUwum6QcbhCFWLQw
         0vDz5o3GkJPZku2aPrjeh3wN3dy/nC1eM4vrLRNTnEbMfJOQ86O8M3E8dTAf0Rbago/c
         oMdI/XuYZM3Fqrb4I1cCTxK8ihNzb7sYuavmzU87rGE0Wc/G678awoSpHmpec08gdcSp
         kcgoJtP/KVZED+sOr6r36Io7G66s0tMTHO69dU2aQpyZMUNp7pvXdpqwH9dYh/H++c3k
         X1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727452781; x=1728057581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNcJxIvrUlKBRWm7kcRpla8DkgOPTgYac1kq5Li84zw=;
        b=IgKPybzFzzhw6uUCIVtBYRhe5/70HAz0SvaPqItXj6zzMmWudrjD7L1YKg5kW9m9B/
         QjgdUyk+vGPlj+Zc4hNkU3Div86GSlqw5jcNBTvENZ/xNwN954jitY9KQGqwocPSuQTf
         4KkeJH3+qQO3jxz7XOf6gQZE1BYcETYnyOhu2HuK0bK3bo3aqAG+y0XFdXmAFYDE61q+
         Q92OyABiayZVSlh7e8GY0ck8YVTd6LgIdprHr4vTSnTcdL74Te2EUcefO4/q0B6Gt8dm
         ZGEN3M5r5TsJFppd1Y5DOscFRS0QHvWLeN7qP3a+JfDgQ1HaF+8A7z3Es3Q7RYGXekWq
         AoyA==
X-Forwarded-Encrypted: i=1; AJvYcCUtN9R3AFzxEhTXGSbG8B16nMfPqBuqyHC3tLGnAzVWMNnVqBeyPHK6pOqGTFHEjskl325qHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRkfhcWvZIeWKRcyzONyQxh1e7BKEiR1zhiupgQG6auOhcEOOo
	E2SEL2SxT0Ko2VqDaotWCd5zjXggllegSAE1VxmnHfumw26CmYQJxkCgRTdjViZ7JRyH60k0QsH
	07f/aO4L/ZLLrmF3dlDXVWtCZdzB+QSaHrjnU
X-Google-Smtp-Source: AGHT+IFh0GldhtACuS2QaxWHGVDuBc4fpilU9wj8Ngw31fpS/kV2OS2lVOxcZUl6UKTvobIZccHNBjO0lZzjRDP7+Ko=
X-Received: by 2002:a05:622a:a491:b0:453:58c8:3fd1 with SMTP id
 d75a77b69052e-45c9feb0724mr3810001cf.0.1727452780668; Fri, 27 Sep 2024
 08:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1724776335.git.nicolinc@nvidia.com> <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <Zva4PJ3FhpMlWxhF@google.com> <20240927140141.GA4568@nvidia.com>
 <Zva_nFXZgT4MEfDg@google.com> <20240927145808.GB4568@nvidia.com>
In-Reply-To: <20240927145808.GB4568@nvidia.com>
From: Mostafa Saleh <smostafa@google.com>
Date: Fri, 27 Sep 2024 16:59:29 +0100
Message-ID: <CAFgf54q9j1NjEBxHtf8sqpx5i01PAqwpuwZg-Bt5AOAf-Rwaew@mail.gmail.com>
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add IOMMU_VIOMMU_SET/UNSET_VDEV_ID
 ioctl
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com, will@kernel.org, 
	joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org, 
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 3:58=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Sep 27, 2024 at 02:22:20PM +0000, Mostafa Saleh wrote:
>
> > > We don't support multi SID through this interface, at least in this
> > > version.
> > >
> > > To do multi-sid you have to inform the VM of all the different pSIDs
> > > the device has and then setup the vSID/pSID translation to map them
> > > all to the HW invalidation logic.
> >
> > Why would the VM need to know the pSID?
>
> It doesn't need to know the pSID exactly, but it needs to know all the
> pSIDs that exist and have them be labeled with vSIDs.
>
> With cmdq direct assignment the VM has to issue an ATS invalidation
> for each and every physical device using its vSID. There is no HW path
> to handle a 1:N v/p SID relationship.
>

I see, that's for the cmdq assignment.

> > Ah, I thought IOMMUFD would be used instead of VFIO_TYPE1*, which shoul=
d cover
> > platform devices (VFIO-platform) or am I missing something?
>
> It does work with platform, but AFAIK nobody is interested in that so
> it hasn't been any focus. Enabling multi-sid nesting, sub stream ids,
> etc is some additional work I think.
>
> But what I mean is the really hard use case for the vSID/pSID mapping
> is ATS invalidation and you won't use ATS invalidation on platform so
> multi-sid likely doesn't matter.
>
> STE/CD invalidation could possibly be pushed down through the
> per-domain ioctl and replicated to all domain attachments. We don't
> have code in the series to do that, but it could work from a uAPI
> perspective.
>
> > If possible, can the UAPI be designed with this in mind, even if not
> > implemented now?
>
> It is reasonable to ask. I think things are extensible enough. I'd
> imagine we can add a flag 'secondary ID' and then a new field
> 'secondary ID index' to the vdev operations when someone wants to take
> this on.
>

Makes sense, I can take this when I start doing the pKVM work with
IOMMUFD, in case it wasn't supported by then.

Thanks,
Mostafa

> Jason
