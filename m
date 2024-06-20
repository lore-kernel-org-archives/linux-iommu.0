Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654F1CD2F
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 05:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718861157; cv=none; b=JY9CmYAe0g3lQ/IY4tsm3rO6HwP2JYJRDkGeE4SHaYiH0p3IgKWKAtN8Uz/ebNNH+osGHkQip20jMBiUowpY6r3wM619QQypf6kgxxe3GL1T1rHSuZdRPYhwfVmLC6k9l+3JcE2ng/9lGTb84NRhdaBS43yZhVzfCdpoeiaivyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718861157; c=relaxed/simple;
	bh=M1LofhyO4/O1SdHlsAN9TLNYnVnBvPTKxhzIyjDBn9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JrqhO5P0hGKanF1dELkUJfKp1evkOWY8MmjUt296KIRe2UkoUpdxzICIJwhbPcuv8WtQXxE8wioYWMMLKE8ydrUbq8XZn9rZTDullxDR0wP2UC+Jii7iaCyZvmA2ynGhBekcX2pI+x8HOcUbBVFwGaWcWtlfSH2oFfL/uKtV8Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kyteatRF; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kyteatRF"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44056f72257so559001cf.0
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 22:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718861154; x=1719465954; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6tUvPLMuX0Si34+bMI1Mx7EP574KGyUuASR1x1qZr0=;
        b=kyteatRFLGb1cYUWMoL3wtvsrwSQI3thKuuURK4LLF0ZYD1BHpLcMPptazIrvvKeNw
         JpoEJwZxUdWba8iPd7+wUxDeGy111q2APLyn1sJGR9iMOsXHJwW2O6P8vYLwO/3RCWdD
         r2VLGLF1qKhbPoO2mzlaX0UB7mnd4G+JgxFNYa/jzFX8PwfvMKfbbZCxTuzvSSYxKDFC
         HvMt6zCQb32EJa8F00LzrkTEnShJZGFDS2viPKiVuhSdocTjc1W7UuSiQTIIJrZSYnGR
         FeiimVQGvSTHNCMsM9GWX6zOo5vx3SyCEbh6b9VjN04T9AKgD3h58j66figPV1c+9QDB
         hFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718861154; x=1719465954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6tUvPLMuX0Si34+bMI1Mx7EP574KGyUuASR1x1qZr0=;
        b=R+3N5L54G1l29xuxlCD6CRbDxbJEXUgo6yWuiHbqizdFeOz6EM8lRD5INWnpP4xnrv
         L7uOi/hEYK2jGuarRkLAt+shQFb0LD7XBR5+Jnz4qakZQdDusuvM/1LqJlXlgyV9qM7W
         0bWEktvdPUTz65cnuj9YqrTjZniOLkV0QHD4mLL2vjgQr+PlkSth+wWeKZmr8N7+TRiD
         zZZhBHWejEVQu1sAS2AqSPXPL8QqQGZ7z+PrYR3wi7TrcLtSvKKVyxPt880Gr69x62sX
         vCWbviDnCTNmuaX9orxJ90O37RXWmqwXKvGn1NwkVO4emVFniT4HNHQMXOduOU7U7Ngv
         l8XA==
X-Gm-Message-State: AOJu0YzjNj98d2Lr3dHC7SFU47HHV/I4JdYrmWRMHAjPD9DHIx+c5WQe
	L+EG57DWBmIunrxk3pkz8bJYwi+6AjF3U9uKXATsrEDtdtVS6MrkCZvgoPNbbcde1W6NcAaY3oT
	dfx/grGMlLJ8qAsFl10MGp2SIcx4PPANkAEau
X-Google-Smtp-Source: AGHT+IH6OeaRl+HUJY8z1bTmGNcxaWThfBfxjejpcWLHT2/dLfkEn4f9D1Z692IZ1OETvfExTMVYVNALX3SempjUF9I=
X-Received: by 2002:ac8:5906:0:b0:442:8548:d7f9 with SMTP id
 d75a77b69052e-444a8d47211mr5969811cf.8.1718861154250; Wed, 19 Jun 2024
 22:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v8-6f85cdc10ce7+563e-smmuv3_newapi_p2b_jgg@nvidia.com>
 <4-v8-6f85cdc10ce7+563e-smmuv3_newapi_p2b_jgg@nvidia.com> <CAKHBV24ANjwSF=YpzxdtOR32N2y8v+Phh5jbxxmw-tLopV2Lyw@mail.gmail.com>
 <20240619184337.GA1364936@nvidia.com>
In-Reply-To: <20240619184337.GA1364936@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 20 Jun 2024 13:25:18 +0800
Message-ID: <CAKHBV24HkoRXcWta-p+dhnuPui5+H2BFnw6w=s0z8Qe1+BcLjA@mail.gmail.com>
Subject: Re: [PATCH v8 04/14] iommu/arm-smmu-v3: Make changing domains be
 hitless for ATS
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 2:43=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Jun 19, 2024 at 06:20:56PM +0800, Michael Shavit wrote:
> > > +/*
> > > + * Start the sequence to attach a domain to a master. The sequence c=
ontains three
> > > + * steps:
> > > + *  arm_smmu_attach_prepare()
> > > + *  arm_smmu_install_ste_for_dev()
> > > + *  arm_smmu_attach_commit()
> > > + *
> > > + * If prepare succeeds then the sequence must be completed. The STE =
installed
> > > + * must set the STE.EATS field according to state.ats_enabled.
> > > + *
> > > + * ATS is automatically enabled if the underlying device supports it=
.
> > > + * disable_ats can inhibit this to support STEs like bypass that don=
't allow
> > > + * ATS.
> >
> > This comment is out of date since disable_ats was removed between v7 an=
d v8.
> > A nit, but "automatically" is also a little imprecise IMO (almost
> > sounds like the device is automatically enabling it). How about:
> >
> > + * ATS is enabled after the STE is installed if the new domain and
> > underlying device
> > + * supports it. On the other hand, ATS is disabled before installing
> > the STE if it doesn't
> > + * support ATS like bypass domains.
> >
> > Or something else if that's too redundant with the next paragraph :) .
> >
> > > + *
> > > + * The change of the EATS in the STE and the PCI ATS config space is=
 managed by
> > > + * this sequence to be in the right order such that if PCI ATS is en=
abled then
> > > + * STE.ETAS is enabled.
> > > + *
> > > + * new_domain can be NULL if the domain being attached does not have=
 a page
> > > + * table and does not require invalidation tracking, and does not su=
pport ATS.
> > > + */
> >
> > This is also confusing, new_domain is never NULL. It's
> > to_smmu_domain_devices(new_domain) that can be null.
>
> Yes, the comment didn't survive some of the edits..
>
> /*
>  * Start the sequence to attach a domain to a master. The sequence contai=
ns three
>  * steps:
>  *  arm_smmu_attach_prepare()
>  *  arm_smmu_install_ste_for_dev()
>  *  arm_smmu_attach_commit()
>  *
>  * If prepare succeeds then the sequence must be completed. The STE insta=
lled
>  * must set the STE.EATS field according to state.ats_enabled.
>  *
>  * If the device supports ATS then this determines if EATS should be enab=
led
>  * in the STE, and starts sequencing EATS disable if required.
>  *
>  * The change of the EATS in the STE and the PCI ATS config space is mana=
ged by
>  * this sequence to be in the right order so that if PCI ATS is enabled t=
hen
>  * STE.ETAS is enabled.
>  *
>  * new_domain can be a non-paging domain. In this case ATS will not be en=
abled,
>  * and invalidations won't be tracked.
>  */
>
> ?
>
> Thanks,
> Jason

Looks good to me.
