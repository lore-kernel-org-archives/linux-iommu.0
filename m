Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECB9145345
	for <iommu@lists.linux.dev>; Fri, 31 May 2024 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144209; cv=none; b=r9Ofdu0qcM5fv5X65j6RGhpbS34TR/ioelzBAkbPwXCixeM+roH2zwxmikITM9CdVOFQiKdrBv2YAKfCDrYqlJJvE0WRAlR5fvqoxXRFmnwQSVM/v1lH9REsWeo0TORHx0+n8nr7Eb6MPFM/B+XnxWVwTo4d0T84EcgLEn6F1kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144209; c=relaxed/simple;
	bh=JwEvemvtK/1wTfGHg6yJ3qXXIAH7p/eOW9e9F+pMgE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsFvhZPKYQ3Uv4AEL4TulPH34e33xXzZirrPMVdoELrgfSxiE9cMdH0eVLlZ5NhrZnrK1X2n1Vluw7jyNhgIuD3glJHwmOeEmNJ3dOTGzlAqZLHSHpu06iKTr9tFM77Fx8ruSeHThfhxbMdVigIjSjiEI1e1xP0fzjvfEmu3lKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B8IUI6oY; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8IUI6oY"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e95a883101so22619971fa.3
        for <iommu@lists.linux.dev>; Fri, 31 May 2024 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717144206; x=1717749006; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HcAJw5T3D3kyswsNGvVslEG9tp9kD/iRcABuGT3i7lY=;
        b=B8IUI6oYU9tsShszRucObQuxF2KJJems7YlYj3a3G5BODmVYrutDS9+zZI2nbm5rq/
         OCY/gxX8oItwBecvDiBVpquAcCI9a+nqv0WuIXF6KeUzyoGv2YhHQ4DOWdbaCupbUQ76
         d+XlS8zkKDr87ijmdAG8D3W140DfHy0VB7fL66JF19WKI7eDC4yZRg9yv2yrtPy9E4lb
         LHZgyx/03gqYsoOhFYt7G1qXxHZszQJJfRdpKg4eStLTsa7x+zdAGwv/DDjvLXWYy5R8
         6ro3R1qzpkiGdC2N/q1c/DyjA97hNDv8GdkTheAkyVe2LL74KjlCGqLldAmmsi1OxnRv
         fQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144206; x=1717749006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcAJw5T3D3kyswsNGvVslEG9tp9kD/iRcABuGT3i7lY=;
        b=QUtFdvAsYoMME9sOsaPzeRw3zuuaMrH1TP3Rer3Zu0FVyDHpILJIYjclUbxEEt/Hn+
         Y7gf32jMKGbhdHRhntSiAmZPw3846t85dkH512BA14cG2mXoata/c0Kzau7Vc0ONmD2c
         cLXzC/szYBg9BJ4wCM2yGE+oC8p3lybUWHDxvaagXt1NgGQaTQUPhU9s1CiYWbrmCslr
         ogPvY+EjKTmeuKKkNASwfRfk+MKcZSLVUelHzddplCHafEYaIRj2NJNfn8IJ5x8wV0Mg
         JLsNoKHvfWp+aGL2iwm5b2wg21S1SRTuU/9NrO5tA5ayUNxucUMfhDIJdugAbeA4S/Ce
         WHyg==
X-Forwarded-Encrypted: i=1; AJvYcCVm7G4dHrBJnVCdXn5lDsyhBj6DrwJgqxEubUxxWKq1GHqIeupUXCLH325i65LOF3vS85y8x/MUsFweY79VE3Zeu7zHLHQ=
X-Gm-Message-State: AOJu0Yx5NsPQbCgVDk8yoLddBQ91DLs80iCXWK5ORzzeYaj020t7QMKw
	WXaa3POErvY7VUSu4yJWgm/ofD9g2ekcd+tXvtPMNii+c5wrgppN+GN0LMVbHBQ=
X-Google-Smtp-Source: AGHT+IF3eVe9jEydIDWHlerWPOn8og1StxlgIvlxcfACNv4BlCP8zs9gy4BRbJwlet+sV0prmpPQJA==
X-Received: by 2002:ac2:4d92:0:b0:52b:3f91:fa62 with SMTP id 2adb3069b0e04-52b8958c003mr794238e87.30.1717144205906;
        Fri, 31 May 2024 01:30:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d8974esm253556e87.256.2024.05.31.01.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 01:30:04 -0700 (PDT)
Date: Fri, 31 May 2024 11:30:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com, Jason Wang <jasowang@redhat.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/20] drm/msm: Use iommu_paging_domain_alloc()
Message-ID: <nxd4bnlpu75fdpbehufdorl43ehwkhshah3q5dqjktqfy74yco@55vueuzpaakn>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
 <20240529053250.91284-7-baolu.lu@linux.intel.com>
 <jd7df7jshswukstxwbfoxuswyltyemdmkx272i5mpldlfsk4t7@ad36olyvmw27>
 <960bfc23-22b3-48d1-baa6-2707767875c5@linux.intel.com>
 <CAA8EJppZU5yy4g85oMWzV_O9Qo91-Cr6d+W9Rz+K+mS6tfU8kw@mail.gmail.com>
 <dda59cd5-b227-4f42-a7f2-b9fe03e1b020@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda59cd5-b227-4f42-a7f2-b9fe03e1b020@linux.intel.com>

On Fri, May 31, 2024 at 09:57:54AM +0800, Baolu Lu wrote:
> On 5/30/24 3:58 PM, Dmitry Baryshkov wrote:
> > On Thu, 30 May 2024 at 04:59, Baolu Lu<baolu.lu@linux.intel.com>  wrote:
> > > On 5/29/24 4:21 PM, Dmitry Baryshkov wrote:
> > > > On Wed, May 29, 2024 at 01:32:36PM +0800, Lu Baolu wrote:
> > > > > The domain allocated in msm_iommu_new() is for the @dev. Replace
> > > > > iommu_domain_alloc() with iommu_paging_domain_alloc() to make it explicit.
> > > > > 
> > > > > Update msm_iommu_new() to always return ERR_PTR in failure cases instead
> > > > > of NULL.
> > > > Please don't mix unrelated changes, because ...
> > > > 
> > > > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > > > > ---
> > > > >    drivers/gpu/drm/msm/msm_iommu.c | 8 ++++----
> > > > >    1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> > > > > index d5512037c38b..f7e28d4b5f62 100644
> > > > > --- a/drivers/gpu/drm/msm/msm_iommu.c
> > > > > +++ b/drivers/gpu/drm/msm/msm_iommu.c
> > > > > @@ -407,9 +407,9 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
> > > > >       struct msm_iommu *iommu;
> > > > >       int ret;
> > > > > 
> > > > > -    domain = iommu_domain_alloc(dev->bus);
> > > > > -    if (!domain)
> > > > > -            return NULL;
> > > > > +    domain = iommu_paging_domain_alloc(dev);
> > > > > +    if (IS_ERR(domain))
> > > > > +            return ERR_CAST(domain);
> > > > > 
> > > > >       iommu_set_pgtable_quirks(domain, quirks);
> > > > > 
> > > > > @@ -441,7 +441,7 @@ struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsig
> > > > >       struct msm_mmu *mmu;
> > > > > 
> > > > >       mmu = msm_iommu_new(dev, quirks);
> > > > > -    if (IS_ERR_OR_NULL(mmu))
> > > > > +    if (IS_ERR(mmu))
> > > > >               return mmu;
> > > > NAK, not having an IOMMU is a poor but legit usecase for some of devices
> > > > which don't have IOMMU support yet (for example because of the buggy
> > > > implementation for which we were not able to get all the hooks in).
> > > > 
> > > > Please don't break compatibility for existing platforms.
> > > Sure. I will remove this line of change. Though I have no idea in which
> > > case msm_iommu_new() could return NULL after this patch.
> > So, even without this chunk you are going to break the no-IOMMU case.
> > Please don't. This will result in a regression report and a revert.
> > 
> > Instead please provide a way for the existing drivers to continue
> > working. For example, something like:
> > 
> > if (IS_ERR(mmu) && ERR_PTR(mmu) == -ENODEV))
> >      return NULL;
> 
> Oh I see. msm_iommu_new() returning NULL indicates a no-IOMMU case,
> right? So perhaps we can make it explicit like below?
> 
>         if (!device_iommu_mapped(dev))
>                 return NULL;
> 
>         domain = iommu_paging_domain_alloc(dev);
>         if (IS_ERR(domain))
>                 return ERR_CAST(domain);

Yes, this should work, thank you.

-- 
With best wishes
Dmitry
