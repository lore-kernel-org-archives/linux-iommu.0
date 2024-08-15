Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99727DA99
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721449; cv=none; b=pvIIMxAo1/FGyl9G9SAm9nttdAAk1BcKVsPaBYFFlVNiGcMi5MomNsT7G+TQV91XOSyMG9ZqIbFQMvJsqHjqh0mvmKF1VudZ9rUgtH0w4G3HZJK5kNLKIQsHqcUxoxmNQjzoBDU9u8mXJDOE0pzAp5S00yohrxS1l5cnSk7+Axg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721449; c=relaxed/simple;
	bh=3hPeB0miGi08HxbqeR2o5mZeyed1ipEcLe4OJB8eAHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQ+ksrgAW7PkKjGH4BIQ1q5H2SJIAzxwm52kC/pe7u1GWRRHzgJwDLSysCFiIEkgH7L/KqncRufuQAqwb/aqlKzvFVIhKu+MbD8fN5r50iaDzqN6ag+/7Ff/rfbQCvDzhvfXW7zI9bFxqtT3KQWBt97cgmiw//bU8DE+9gC4XpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LuVvuuDb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuVvuuDb"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso21065e9.1
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 04:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723721446; x=1724326246; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nph2IWy3jC26Kw2+GT803V7uudXWcralv4F4DFT3HI4=;
        b=LuVvuuDb3wTicPZtk5WmNjhDum7RSlyIqovNtg15PumLUQUCYXAS8Q6a+rbWLUCcbW
         0uQ+a/k5T6eXufyB0vAjnPUbvGg9rg6hC2v9CC8B/2L066dh0oGvcwsWbsJnKme0LZXI
         A53vHTMw59Xs37KbPm4bPq3qD2sEcAUpZB9yql6o6pdyW7g3oVc7e2Te8xbxsUeOQ0HI
         BbjmO5fVAUGz2bk27Jlthyh9aUDWvQ62kRzAKB9m7/WSuS6SDoH2fdS+x0b1bU9tGFGb
         o4WuRP02PjtxIrs98v2HLAETVQuP83Ra+lliXH99XB9RTVX0IZ3n9gmsBQGXEw4TqzkJ
         kcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723721446; x=1724326246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nph2IWy3jC26Kw2+GT803V7uudXWcralv4F4DFT3HI4=;
        b=xJQ++551uBIK+IVTNyP6HouxPyJ3/RWgeagPXsaygCb1bRIh4w6an0myGHc7m+ygBd
         XyOpEBKML+b6j/v70c0EYsKpuIBrzF1aKj4vxlO3t2ULOLi22fWwGe2Yeub/9HXyIN6Q
         8dw74mueZrGTy0mJpC23PkvnCtSm8H3jp/2/mOALn4yA0PHuKgAIyvNRuu9RFw7yxb4C
         VmZgr4dgTjOE391tp9c/Q8KDbvpL6I3ynpQF8WS/Y6FxKlqW7u4951rV7evJ6upT92EE
         TS7eOIhv/RbnrChZ/4qjaavIXZO25uksHRaaqxr0sePy/4hSTMP0sK40JhSbXmsVG98n
         rc6A==
X-Forwarded-Encrypted: i=1; AJvYcCV3uyE1k/y8vOc3gAIku5O9+WoZjGpXDJCBbBorOz21njQpTTZGDt5PqDA5BZes3C6rmd4t0yknm+nMaORaVbCBWJTsNx4=
X-Gm-Message-State: AOJu0YwnkoZ41gx8dLGYdcex7QElnkAERrUpvaQmGT/kkMgBr/430lN5
	Zve4unIhY2U141wM5kmW5ZOVExKNjhlUwP0poN1fJekDcgDuMqUEAHx6m1Zxpg==
X-Google-Smtp-Source: AGHT+IFpzQX/OizeMLkTPYCQLbf3yV11OTBYRepBz5eYNmZ1H3l9hqm/tpwdPV0j1jS4WBe1B2eN5A==
X-Received: by 2002:a05:600c:cc7:b0:426:6e95:6ea7 with SMTP id 5b1f17b1804b1-429e6bd665amr450785e9.0.1723721445377;
        Thu, 15 Aug 2024 04:30:45 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7c03d53sm16680175e9.19.2024.08.15.04.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:30:44 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:30:41 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <Zr3m4YCY7Ape3R6y@google.com>
References: <20240814145633.2565126-1-smostafa@google.com>
 <20240814155151.GB3468552@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814155151.GB3468552@ziepe.ca>

Hi Jason,

On Wed, Aug 14, 2024 at 12:51:51PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 14, 2024 at 02:56:33PM +0000, Mostafa Saleh wrote:
> 
> > Also described in the pseudocode “SteIllegal()”
> >     if eff_idr0_stall_model == '10' && STE.S2S == '0' then
> >         // stall_model forcing stall, but S2S == 0
> >         return TRUE;
> 
> This clips out an important bit:
> 
> if STE.Config == '11x' then
>   [..]
>   if eff_idr0_stall_model == '10' && STE.S2S == '0' then
>       // stall_model forcing stall, but S2S == 0
>       return TRUE;
> 
> And here we are using STRTAB_STE_0_CFG_S1_TRANS which is 101 and won't
> match the STE.Config qualification.
> 
> The plain text language said the S2S is only required if the S2 is
> translating, STRTAB_STE_0_CFG_S1_TRANS puts it in bypass.

Yes, my bad, this should be for stage-2 only which is populated in
arm_smmu_make_s2_domain_ste()

> 
> > +	/*
> > +	 * S2S is ignored if stage-2 exists but not enabled.
> > +	 * S2S is not compatible with ATS.
> > +	 */
> > +	if (master->stall_enabled && !ats_enabled &&
> > +	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
> > +		target->data[2] |= STRTAB_STE_2_S2S;
> 
> We can't ignore ATS if it was requested here.
> 
> I think that does point to an issue, ATS should be fixed up here:
> 
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2492,6 +2492,9 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
>         if (!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS))
>                 return false;
>  
> +       if (master->stall_enabled)
> +               return false;
> +
>         return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
>  }

Makes sense, I will add that to the patch instead of checking at STE
creation time.

> 
> And your hunk above should be placed in arm_smmu_make_s2_domain_ste()
> not arm_smmu_make_cdtable_ste()
> 
> Not ignoring the event still makes sense to me, but I didn't check it
> carefully. We can decode the S2 event right?
> 
Yes, s2 translation fault events are the same but with an extra bit
set (S2), and with a new field for IPA which is not relevant here as
we only report the IOVA.

When full nesting is supported, as iopf_fault doesn’t understand
nesting and only have the IOVA in addr, we would need to filter the
event by stage.

Thanks,
Mostafa


> Jason
