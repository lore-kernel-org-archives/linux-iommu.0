Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227561BD001
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819379; cv=none; b=S+d8F+opMZz6AqLSO1kjGuyxnb8z+/EzluBNCYfv0IFusju4BdJ5TH45ptMdgGnaG9GITTKD+G6J0tbxq65MCqk5+nDMBXqAlZiERbJ4IrtghyRpt8FK2ahLHp/8AZMJwchmt1yNMz/Z7uA6V67ANyeYLOu8FawRR4v/6WHh83M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819379; c=relaxed/simple;
	bh=/ZcdoQZgWUioXpD8yYGIrCkiY4QmlOOvZmIkF3rOxVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnlwPkT3MkE+TdTWN9AM1roGCH6XjJtGnbbsXxP7CPo7c035R2jvEon+b2ZAPdUUWc+KK7oLvbxpXnogoVj4sSXWew1f1YVhSaNnAg5l8EQE78B9gnvp4yzvp6/fnz41qc/18a3mekxwkyvLkYiCLqLCwY6ulgZQx6dZ9J0TQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KO/dg+fn; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KO/dg+fn"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bebc830406so7291a12.0
        for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723819376; x=1724424176; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=opFPN7f3AVgmlYBsPIGvsO2bTRdIA2J78NUkiklHncQ=;
        b=KO/dg+fn4mHCaL+eula0mKIxL3Npnwh8a87C2kdvZMTcmn7i4Kbe25TbmXlNrKfvW8
         3GjM7PrkZTWBusK7smrjsgMqQ/g5zj7OXvMiaOoRbmFnpR6pZ3UG5qprkprghDF72FVj
         5xHRWs03eGjg7BUpGICopar08ZD5OWGIbyoNbNoh5Wwuxe84UBYCsGXBY7OdnSpHXWbf
         RY5sroR00z41/JFGQ90VX2NJmWuUwsFIffMgZVtoOsplgpAk/26o0YbGezGE7fG3LYmD
         ygr+efXFxtkjJDGMDAfzG8PM24+pkYEagfJHIUvncXDLgVXDVb20ApXwa1KSOueZNMgI
         eozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723819376; x=1724424176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opFPN7f3AVgmlYBsPIGvsO2bTRdIA2J78NUkiklHncQ=;
        b=pLsygxgp51V03DOO0zG09SLX8hdYx4jBfizN+beZSgOBK3LD3cR2/BsRchAypvYECZ
         dBGDnCLV28ifsXc+kILD0MZvJ1g8/WelbQ3Xo23xY9Cv57M/6I37TIE6ivgc18p39kDx
         Ea2Pg5L+R+nER6fROK5T208xJ8dsheqUOMCuOa/PFLgcq7f5PlgX9q9eaq9vuSgsyEqp
         9hBQoF0PyNuturwHd6vZo5bcdphB6L+H0jw0lBMI5Dj2IX1P3NUoPqlaZK4RthEuptPm
         15suVb/iUYgMKZAYvcBBNlLmTZpgF8mGv7Ga4OIDl4Z7W0usWZNS1E4XuSQG71XiZF7g
         0pig==
X-Forwarded-Encrypted: i=1; AJvYcCXswsE7SkxLH1eUbijmQBpUvpQalTwXSN0T3H9EU1Tr7XRflIfVTBK/rHuiOO9zd1LywYYbcJyZB1+zhALIkfLnYr30ZDk=
X-Gm-Message-State: AOJu0Yya4DuXNq1AsUr/i+N/qbcXsJoVh8gunhqbqpEC/YVcXZHZeZJ1
	v0TcPV6UfOKrHw9gwbayt806KsCDTar0DGjZ/80T5gnyrUvMnyw+eBusWWxbFA==
X-Google-Smtp-Source: AGHT+IELDozvOpO3OAJVEnbrz3xGHmp3wJyCr54Jrj7tBHZQPhYLug8LXtro0KRrV9QeYK401189nw==
X-Received: by 2002:a05:6402:40d4:b0:58b:90c6:c59e with SMTP id 4fb4d7f45d1cf-5becd6e59d2mr86465a12.7.1723819375968;
        Fri, 16 Aug 2024 07:42:55 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984c0d0sm3764157f8f.38.2024.08.16.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 07:42:55 -0700 (PDT)
Date: Fri, 16 Aug 2024 14:42:51 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <Zr9la0hy34IDgbGd@google.com>
References: <20240816125901.3773388-1-smostafa@google.com>
 <20240816133135.GP3468552@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240816133135.GP3468552@ziepe.ca>

On Fri, Aug 16, 2024 at 10:31:35AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 16, 2024 at 12:59:01PM +0000, Mostafa Saleh wrote:
> > According to the spec (ARM IHI 0070 F.b), in
> > "5.5 Fault configuration (A, R, S bits)":
> >     A STE with stage 2 translation enabled and STE.S2S == 0 is
> >     considered ILLEGAL if SMMU_IDR0.STALL_MODEL == 0b10.
> > 
> > Also described in the pseudocode “SteIllegal()”
> >     if STE.Config == '11x' then
> >         [..]
> >         if eff_idr0_stall_model == '10' && STE.S2S == '0' then
> >             // stall_model forcing stall, but S2S == 0
> >             return TRUE;
> > 
> > Which means, S2S must be set when stall model is
> > "ARM_SMMU_FEAT_STALL_FORCE", but at the moment the driver ignores that.
> > 
> > Although, the driver can do the minimum and only set S2S for
> > “ARM_SMMU_FEAT_STALL_FORCE”, it is more consistent to match S1
> > behaviour, which also sets it for “ARM_SMMU_FEAT_STALL” if the
> > master has requested stalls.
> > 
> > Also, since S2 stalls are enabled now, report them to the IOMMU layer
> > and for VFIO devices it will fail anyway as VFIO doesn’t register an
> > iopf handler.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > 
> > ---
> > v3:
> > - Set S2S for s2 and not s1 domain
> > - Ignore ats check
> > 
> > v2:
> > - Fix index of the STE
> > - Fix conflict with ATS
> > - Squash the 2 patches and drop enable_nesting
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +----
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Actually this misses adding S2S to arm_smmu_get_ste_used() as it is
a new bit :/

And that is not detected by “CONFIG_ARM_SMMU_V3_KUNIT_TEST” as it
doesn’t test stall in masters, I will fix that and add coverage in
tests for stall for both stages and respin.

Thanks,
Mostafa

> 
> Jason
