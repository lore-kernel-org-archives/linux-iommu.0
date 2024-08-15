Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F52E146A6D
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723627; cv=none; b=Zqlazm/2NpMuLIOc66I8R1cDQGlGe4FQxZXA+CDVS9pa6L3MwIFchHUsN+H/AkQadKpiI8EX2IkbJzjxbw6kuaPHRNMUZOAbAPRdc3Zf0mEwHpbw5mv4zh40UC/+5+8o0NXhBFtqBLaCHBQ8BT2IXGiIzKvJ98HBT6ebsmkp03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723627; c=relaxed/simple;
	bh=3Q1rAzppOU68Mj0LxgiVpP+HdGRc7JoGzJl3xAJMxgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLn7kuKc0ZFCji+j5tUiNUUECcjy99qP0vp9DJmowzTWSTt5qZ2DkgrwdF2qo7N5UmQQt+N1v3Xsd2y6PXvKbQgCbPppW+TczjZluY0aUdjfyXYUJzsW1cW8RaDEoUYCN6mZGdfe93NBP8liH4SEelv4GCVdMA9PTOrPOt85RfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bjm8jpYM; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bjm8jpYM"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bd777e6623so4334076d6.3
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 05:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723723625; x=1724328425; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MlKUYLbr4p32N58TNAMOjtSmUSkM2NS95I4z4nsjtmA=;
        b=bjm8jpYMJ/Bko9eSMV8rKc0+sHQHiAhHjUiVOKK+1IJcRiv4G77H0Gt0Wpn+oGgNkc
         2zEBlwHUcmEO9wbpxcTbsHprvOiKfRi1p4D7JB/VdcUIPkwe4s7gGNVRulYb9Qv2wMiU
         7Cqmy5WmdQRguVQFZQL5FdG1PBgimE9laBlfD5zMsutk+j6ZC4EpnxYkAqENN6gavu0y
         YDPiQhettAfvhceaO5M7VPElaSPdhnG+rDO/sL+3TwF/Rh5ZheeoPQ71l7tsIGrV0alZ
         kH9Ety+/iV+bgb1dUliU3JRYnoXrSQYoz4HaMz68f7dQBmLw7y5hl06aM81/BYNRAmSk
         4jlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723723625; x=1724328425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlKUYLbr4p32N58TNAMOjtSmUSkM2NS95I4z4nsjtmA=;
        b=o01AT97PCaEgl+av1BUCdnEuQON40aKG7Rm2l5A5PsMMOu75XLx3zzrrMiY2OwC4VV
         FxRIQ5IjPsRd8uBadi9oh5iUM5yWDi5RxvqyH9GO5RdT0DeFM0sNjdnkJfhJltUcs61e
         Z1kxPM9rgudmtOVrywl3rANkpHDTuJqk8EeG/UTdfto4+/MtR2nVHbRhjrWvGged+hSb
         d97YudR7N4YbxbKt8rcqHSZvX27Mpbe8tSkfzXf7GcOQC+6+WfLpzJBnnJMRignmCcjZ
         LwWIOMhWR3P2bOeOxcMynwduPQ9fI8u14pmLXy6VY9LqiX57YAP8t2snqTojRRGH10JG
         V3FA==
X-Forwarded-Encrypted: i=1; AJvYcCWVHTKDVw63QwDjyy+9fKdhS/qKaI1nEabQMPBLqunEhyCrPvXWKM+P6Q3wYqFwb1dBpuLrmLZH5LltTYz+cmXWLStu+j4=
X-Gm-Message-State: AOJu0YxdjqXOqwaEPtTO2C5Ar2/9uW3/jDvIx+ZBE+cyib0O58R7RB18
	GFYq3GMwhwz1CbRSRMreg/xwwe7ehSUQcohH+54UnI/MIrUcTiw0T4r4NJgpUSUdJWjjfy5FUyS
	D7Xg=
X-Google-Smtp-Source: AGHT+IFJ6os7hwPpyyDCSCPryo+NPvypMcGc9/65Ds0b8hYLQ+EUOuC+28o17B/hEB9c+Ar7DZWl7g==
X-Received: by 2002:a05:6214:2dc6:b0:6b7:a118:4eb1 with SMTP id 6a1803df08f44-6bf5d1644f5mr64492466d6.3.1723723625177;
        Thu, 15 Aug 2024 05:07:05 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe4eefbsm5857096d6.70.2024.08.15.05.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:07:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1seZFv-002m89-U1;
	Thu, 15 Aug 2024 09:07:03 -0300
Date: Thu, 15 Aug 2024 09:07:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove the unused empty definition
Message-ID: <20240815120703.GF3468552@ziepe.ca>
References: <20240815111504.48810-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815111504.48810-1-zhangzekun11@huawei.com>

On Thu, Aug 15, 2024 at 07:15:04PM +0800, Zhang Zekun wrote:
> arm_smmu_sva_remove_dev_pasid() has been removed since commit d38c28dbefee
> ("iommu/arm-smmu-v3: Put the SVA mmu notifier in the smmu_domain"), remain
> the empty definition untouched in header file, which is used when
> CONFIG_ARM_SMMU_V3_SVA is not set. So, let's remove the unused definition.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
