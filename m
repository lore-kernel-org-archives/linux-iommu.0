Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983D51714DC
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724814; cv=none; b=tca1zpAXi3YmvZ+UmgJhvSHI+D6ES8zN2dz2OFbtKqnlOlMWJTt1hwr4Sa3Tk4HRXT017u6L/g5vT0vThf18q2TaCq8WT3cHN7MLAG/dk2D44rgvsaPY9qfP7oeQnYLSCckOBfXDSgHUe5vUa1/G9HTQRkkSeaCAabPU37fdId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724814; c=relaxed/simple;
	bh=750x1RMHzIv/ueCXLwScvIKOM9dB2CXFH/BKYl7u370=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOWz6CuJV0sWzatPDkKsY3TBEr2VChjgmSCSpboxSW/bPVAImaKBp16c1wFKss2iB+hIsIpXHedAfnYzbZNkg4ixILLcm/49NEZvCfDgEGyGEqpls3DlPT+aBHv4C0+yVX6n0xvsLjFsEz7zJ5Tpgdg2h5UUSeGt/36G5sJuIiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3DLPKIb; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3DLPKIb"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bebb241fddso4864a12.1
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723724811; x=1724329611; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sRNnLXXPpV7IoEhJzOcwO3JZYHZ/+fzxuXA54WcShzs=;
        b=q3DLPKIble4cwXaDBWxlxLg49FMtyzAGvuA7k533ss/ycwrrobXwaN2rc3vVeAHR6+
         wX/4PXzKgbQH+feFlnVTy/XZTUSqcmuHOMVaRGTmQePzZLu7Pwnkh2d7uE4sEXI65mYk
         MjM+hSSEg/+7+XeVA9Pg93gV0hzYz0ZDO51U1aAB/t0menHKduPI9HKpQY52HZKoBiQS
         r+SDn1XfqM4wI80k4SjftxrkUVNBUruyqvgFXKCeJFXR0RsGtpr/cBDhK4X+4r+aYdup
         srt8GXd6QvUoR8rZibvwbK88rXvIdszmRWlss56nKHHoAbctXrF5a5syav6YPSJOmLyX
         v1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723724811; x=1724329611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRNnLXXPpV7IoEhJzOcwO3JZYHZ/+fzxuXA54WcShzs=;
        b=Tjy6eNwu3vJynX4BwdCHvYD32i8Z2wVBy+uzzT2vHEJooAq/GojMtqjk1HVfGOy8wi
         cwk17Gcy/1+KzHgOIQStsGFdX7QP7TzWQJ1gtIIk4DHNB0MJGCQUH7AV8tPD8TLUGiyR
         cZnOR118f8oqoL/Q3OatMbIbpcAi6o6KoQdjdnnM3z+2NuCTQDjPnBmaJTqXHzbkWqua
         kP8rtAd6ADvZrczNktgCl+f8IgeGmAiSvN4CW+9EMhYwSuCeh/+ZJ5mLD0Stw7mjV+OP
         IMxV2AJj5lviEfJMqhuQ/aEn4CCGJPwWi6NTiBqgR4sn8i59wt/qp28V5leR9cJpcsR9
         6riw==
X-Forwarded-Encrypted: i=1; AJvYcCU8fU5BuBNv+41NX2OmqOE3Rgh3w78Nj9+/0lc5bwQj5jui3TLtDCFR4n4UpgGJ4JlqzWSa085Qj+n3Y2HuF6RzUTyzII8=
X-Gm-Message-State: AOJu0Yy8gKdoQZdqCB0/L1qNXucWhzufUCYcDAziT7Ddzk4Aa256NXdr
	m4yZCm6Bf4+nyOdsVpelqk/QbvP4S+bUCkvIcGoSTu4qwJ+qm/xzcDEQO8oa9Q==
X-Google-Smtp-Source: AGHT+IEuekxOlZ5dLJvvllpYlIVkQLQ9BPwqLmRzpY5P2uQKac8q8/lokXLciY9vp8RMaQM8cBEPNg==
X-Received: by 2002:a05:6402:40c1:b0:58b:93:b624 with SMTP id 4fb4d7f45d1cf-5bebb9c4981mr57307a12.1.1723724810459;
        Thu, 15 Aug 2024 05:26:50 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded287d0sm48228805e9.12.2024.08.15.05.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:26:50 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:26:46 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
	nicolinc@nvidia.com, mshavit@google.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <Zr30BjAcVDKJPv3B@google.com>
References: <20240814145633.2565126-1-smostafa@google.com>
 <20240814155151.GB3468552@ziepe.ca>
 <Zr3m4YCY7Ape3R6y@google.com>
 <91d6574d-c67e-484c-ad96-91c9fd3d0c43@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91d6574d-c67e-484c-ad96-91c9fd3d0c43@arm.com>

Hi Robin,

On Thu, Aug 15, 2024 at 01:16:19PM +0100, Robin Murphy wrote:
> On 15/08/2024 12:30 pm, Mostafa Saleh wrote:
> > Hi Jason,
> > 
> > On Wed, Aug 14, 2024 at 12:51:51PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 14, 2024 at 02:56:33PM +0000, Mostafa Saleh wrote:
> > > 
> > > > Also described in the pseudocode “SteIllegal()”
> > > >      if eff_idr0_stall_model == '10' && STE.S2S == '0' then
> > > >          // stall_model forcing stall, but S2S == 0
> > > >          return TRUE;
> > > 
> > > This clips out an important bit:
> > > 
> > > if STE.Config == '11x' then
> > >    [..]
> > >    if eff_idr0_stall_model == '10' && STE.S2S == '0' then
> > >        // stall_model forcing stall, but S2S == 0
> > >        return TRUE;
> > > 
> > > And here we are using STRTAB_STE_0_CFG_S1_TRANS which is 101 and won't
> > > match the STE.Config qualification.
> > > 
> > > The plain text language said the S2S is only required if the S2 is
> > > translating, STRTAB_STE_0_CFG_S1_TRANS puts it in bypass.
> > 
> > Yes, my bad, this should be for stage-2 only which is populated in
> > arm_smmu_make_s2_domain_ste()
> > 
> > > 
> > > > +	/*
> > > > +	 * S2S is ignored if stage-2 exists but not enabled.
> > > > +	 * S2S is not compatible with ATS.
> > > > +	 */
> > > > +	if (master->stall_enabled && !ats_enabled &&
> > > > +	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
> > > > +		target->data[2] |= STRTAB_STE_2_S2S;
> > > 
> > > We can't ignore ATS if it was requested here.
> 
> I don't see much value in adding effectively-dead checks for something which
> is already forbidden by the architecture. The definition of STALL_MODEL
> explicitly states:
> 
> "An SMMU associated with a PCI system must not have STALL_MODEL == 0b10".
> 

Ah, I was expecting that as otherwise it's contradiction, but couldn't
find it while searching. Thanks for pointing it out, I will drop all
references to ATS then.

Thanks,
Mostafa

> Thanks,
> Robin.
