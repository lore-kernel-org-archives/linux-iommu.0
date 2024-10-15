Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4B1CB9F0
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004864; cv=none; b=BFD6YHZAGZfxz7vQk/l5XrIH2qlsBzdky0ULsfcuLioIBJkRgRoEW8fPn2V45uL5PKVBMDfkKtud7ZSLg3BKRDi1O4RyhoS6b2nKy1HZS4gvxj8X5ZXsHKruzWErntphwS+SA00nDbiUeMaxp6KWFk9GrHSe15dFKk6XyP8cb74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004864; c=relaxed/simple;
	bh=f4WuBg7WlMrKS0da9MDKLt/3P+sLy8hGoRgtuR/wpwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd2QbrfOuMRSH6lqPU1re8quahdgf9dhW8/xQZg1PZLKTs70I/1a7k0d6P7HAWcYqejRoEt89njTbD9ZtgQYzCdYP2fnbbJgmBjhy9bb8YWA3V5Ijc41Mjop1ZWZJ/c3fNeeGet2D+lRR6WS7WReCkJ/8IHEUcUKotYk7UrY0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=teZ53C+E; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="teZ53C+E"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c8ac50b79so506845ad.0
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729004863; x=1729609663; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PlA/wii2bh+bHrcTk784szy5HvJLhrYuLgVdXpT1LYk=;
        b=teZ53C+Ee69GxoOk3uL0jdh6QhALvKmh9ZO/mr6qwwd2OYVTLdNAUB9HjWcFR23gnJ
         uodSJw9kV1CpYIaI0E57IfklTBHO3c78k5UVJwp5rU9EBvZXcSz7a5ekX1buzMJwENTO
         pFYOaYHgqkoQAHItqoV89Npuoet/Fa2czEO0h+DU4qOi2HlfeUmM9LdFp6UtUPcagoA0
         3ZgxrgiFSsERAEiV8Zk3OuOD8K+/qBpxFRsWL+sldC73B8ajmH6J+fRnzdDY2kbvbYVf
         l8hwJGlMyn06aejHj0FK7/gr7EB5r4whW8HI83b5yIl2mPVdGw0RmdvWQW4oMlP95AlY
         kI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729004863; x=1729609663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlA/wii2bh+bHrcTk784szy5HvJLhrYuLgVdXpT1LYk=;
        b=i16x/EeyzJgeqRq/5bQJucr92bJVseSlRisW/HihMKN51kCf3TkmdWRFzJAMFG0YY6
         rKtvLTbRDI6l6RYoEsg8xiUjM0R8s2LyL2nCFz1jyC7l1xt8y6rvjMRieqyhtqfkALm7
         waxjlTF/f95xcijB3f5y6Zj6wYBljwXWVlyLaGZiVR+rGznsBXsUsQr0I4yR0fNhlBUt
         38OiCBFGPU+Lqcy8124DCXW8F5cG+4RvgzWVWRs0psntAQXNizBZH1YMklIgPsy9GzB2
         fe37xa1I22eYETVdQPNAObDB40D03z4OcVqzGB6mX3TUhKIqNIw1MWqy7RHGsTs4RJqH
         nY2A==
X-Forwarded-Encrypted: i=1; AJvYcCXT/wkxdpTeU6ZTqu8Vj6V0f1R6g4loNAjYKa8s8BJWd0pavPAgNn5SLcDBZVH1tcC6sUkfXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzG/igceZV/riuVjsiLu/iya2GcU4DRU0GLFQuZOH4NtELwzqQB
	p3Zg8vzey2oLk8BRaWCtSjOjlWQVPbOiY53C/J4dyKoqOCSD8RZOlK7ruPUaHA==
X-Google-Smtp-Source: AGHT+IF1l7OR0X37A5QzB6dpGx5CADv36IvHuR768YDJl8fOGKf/Ye/4uOiLVbH4UsZhcLQQ270hKA==
X-Received: by 2002:a17:902:e890:b0:20c:805a:22b with SMTP id d9443c01a7336-20cbced5496mr6942145ad.24.1729004862458;
        Tue, 15 Oct 2024 08:07:42 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6ba33csm1451237a12.17.2024.10.15.08.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:07:41 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:07:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
Message-ID: <Zw6FNCACa03nE5Cx@google.com>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <20241015-smmuv3-v1-2-e4b9ed1b5501@nxp.com>
 <Zw4kKDFOcXEC78mb@google.com>
 <20241015124723.GI1825128@ziepe.ca>
 <Zw6DekI9X7lL4f1G@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw6DekI9X7lL4f1G@google.com>

On Tue, Oct 15, 2024 at 03:00:10PM +0000, Pranjal Shrivastava wrote:
> On Tue, Oct 15, 2024 at 09:47:23AM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 15, 2024 at 08:13:28AM +0000, Pranjal Shrivastava wrote:
> > 
> > > Umm.. this was specific for rmr not a generic thing. I'd suggest to
> > > avoid meddling with the STEs directly for acheiving bypass. Playing
> > > with the iommu domain type could be neater. Perhaps, modify the
> > > ops->def_domain_type to return an appropriate domain?
> > 
> > Yeah, that is the expected way, to force the def_domain_type to
> > IDENTITY and refuse to attach a PAGING/BLOCKED domain.
> > 
> > If this is a common thing we could have the core code take on more of
> > the job.
> 
> Yes! I've seen the IOMMU being bypassed at multiple places, primarily
> for performance, people like bypassing the iommu for "trusted" devices.
> A few examples that are publically accessible: Qcomm SoCs [1], [2].
> Seems like Qualcomm have a DT property `qcomm-s1-bypass` to achieve
> something similar.
> 
> In fact, *blast from the past*, I tried to do something similar sometime
> ago with [3]. Although, perhaps that wasn't the best way (and I was a
> kernel newbie :))
> 
> A little off-topic, but I think there has been some interest to bypass
> the default substream as well while still maintaining PASID isolation.[4]
> 

Agh, apologies, ignore the following part about rmr,
it won't solve the problem here.
> Although, as far as arm-smmu-v3 is concerned, IIRC, I think there was a
> way to tell that the region is reserved and don't map it.

> 
> > 
> > Jason
> 
> Thanks,
> Pranjal
> 
> [1]
> https://github.com/realme-kernel-opensource/realme5-kernel-source/blob/master/arch/arm64/boot/dts/qcom/sa8155-vm-qupv3.dtsi#L22
> 
> [2] 
> https://android.googlesource.com/kernel/msm/+/android-7.1.0_r0.2/Documentation/devicetree/bindings/platform/msm/ipa.txt#28
> 
> [3]
> https://lore.kernel.org/all/20230707104857.348353-1-praan@google.com/
> 
> [4]
> https://lore.kernel.org/all/CAGfWUPziSWNMc_px4E-i+_V_Jxdb_WSwOLXHZ+PANz2Tv5pFPA@mail.gmail.com/
