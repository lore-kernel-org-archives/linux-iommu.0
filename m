Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60F64A21
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 01:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532675; cv=none; b=bub/TNN7Z+etLGWkSqkLCufPDB5CSN4tFXaesPyA7sY6crLnAm0J/iK793xENkgxQ45u485pKQwN8e8f9Y3WDKw8GkPGojn1CeiZB6KHJecSQFvl1hYAJ5AFBBi5QzadE+HlzNdiKM5aGh0eL9+PK20vWUi0DMSslSKzKIDE1U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532675; c=relaxed/simple;
	bh=uUKozBAzJHqnum3CjoKVLaHgWX1mER1lMUZrxYk9fio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0zZe+JmMKrJ3YOac1k0cP2dWJD6apv+5orJa3UCAU8aV2BN7+XM1rXNGO2/4Y/ucFFqkFeKDfqd3EXkh4vJQ04VPwCVERe3KwqqtS8+02bL+Ss9mpd99aZ7izb0vYydyZQsSnGxUkNnuKGkW6zTIFOovr7CitcIexT9GSIuLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EAqJELZ0; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EAqJELZ0"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471f257f763so62197661cf.0
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 17:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740532672; x=1741137472; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G3wugZBgFcODIinDTLHfwyMQx9+fVLUtniVqyC3nlN8=;
        b=EAqJELZ0nJYO//3z6cVX5P2Usi4So5Bbq+bvTs7TmrTVOrkzYdTI7Z1FjHsS0PRHAG
         0RM62gdCrg9kkuCdmDi3fnGpKkvItNTO4p4Ok8fR2v61coJ7VG7w6Ojd7eDDthr4iNjD
         1Qn0b3xOZ2K4pJMcquXmPWUs7OU96dZRkPhb8d2p+I1Acj/NInr5SpopWaCJAKHVFQww
         g5JWvnLIoCGonYS5jLUbGtJ2tpo3SxU689El25KiQOWi2Lsk/g454A6N12N4x4rUCYEj
         WIVrMtcAoxq8rsMND/4R7aRhW4b6yN+PNKy5THNqVK7E1ZvdWq3Haih1SeReF37Mg+CB
         Z1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740532672; x=1741137472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3wugZBgFcODIinDTLHfwyMQx9+fVLUtniVqyC3nlN8=;
        b=HUjMC6s/vI+UvSfIm1f8hA710xU4kCYDthLeFyF9bDZWyDL2OX1MDLn1/5sRBmu+Mg
         ZiAXV9mDIK4CI6yP78CvkQUidFO0Eu3DzmBvsQBeaqM+3/oGT9CeeVSD8So5oaw3Iu13
         cTzQdmeXYZNGKtxfj/MJRbadxDMgKChidwVLiSrtxLFJ2x4FcyGXH49WYagkvVzGZGdQ
         UwsG/71kAcRxHn7F/je7sD1g31Z77ZgAymrUOLTe9zAaZWeoJc3+2yhqm3+byzAEGN2a
         QM8MZfKyj3YXm/PT7IPDwzQP/sQQaFcBqUdVlrJgNSx05j59U4+aIZv+a7cQ+Lrpv8Uv
         HfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfQJuwuqAIrU5Gc+pAPZuNEweUSPyJBFYst8CMa1omQ4Ht9vsiP994Cof9hYXihOVB1EyV9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZA5kpTdF3KuCTHDniWAIE9oFOwFFSc1Jha2wrNlQkJ/0vrIIQ
	DvtABp8RpmyigLZN/Ta3Z6xmsvIWHWPlf19HNkohrwvIJs9KU30VoHznqgvS58ukVtjqSAzGHq+
	7
X-Gm-Gg: ASbGnctW5n/r++FvLEV6AZ3CQyMKbOgtEsN/IzW6irXlGIOkQQRNGo+IjaY+f9NKV3F
	+pIccDDewjA9Enke19Y2dBFQtAlFxt179iS0oNh4bC5OD0UJTXbcPZkID9foeCuoozkXiJa9XVI
	PjoWdEUetCYP1KWA1R45CnL8Pdsn7HqX8Utu40Py059FenSHc/gEMOZzoahx3GcEqcAkW/+qMgz
	j1muKub74NVLoP6HeW4beWkoerALfWVONAN4OwXISiATnUovvAt08HqPwiH5EcsCubkiWtqL36j
	3Upkypmr3AKMoeACFtcsxTRvkg00roQDoXuoo0XGEJ+FrApAD/zil6QNoOuRzgvRHAjYdXzsdKQ
	=
X-Google-Smtp-Source: AGHT+IEftAugmOwox0NANepi8vI7DGrDsVVCL85fLuyv7dI7ow4UmJLWlNz5PwbKDseHCr2CMZOOYg==
X-Received: by 2002:a05:622a:180d:b0:472:a26:7450 with SMTP id d75a77b69052e-472228c7deemr313623341cf.19.1740532672417;
        Tue, 25 Feb 2025 17:17:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e24caasm17696861cf.47.2025.02.25.17.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 17:17:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tn63a-000000003w7-1ST3;
	Tue, 25 Feb 2025 21:17:50 -0400
Date: Tue, 25 Feb 2025 21:17:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <20250226011750.GB5011@ziepe.ca>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Feb 26, 2025 at 01:12:38AM +0000, Tian, Kevin wrote:
> > I see #2 and #4 clearly in the SMM spec. Is #3 a special case of #2 (a
> > STE with a S2 and S1DSS bypass)?
> > 
> > I think AMD is doing #3 from the docs.
> 
> my reading of AMD spec was #2. also backed by Vasant's words:
> 
> "
> With Secure ATS, for ATS requests IOMMU return GPA to device instead of SPA.
> When receiving Translated DMA from a device the IOMMU performs in-line
> GPA to SPA translation.
> "

Maybe it is both 2 and 3 if the GCR3 PASID 0 is setup to not translate
but do identity?

> If above understanding is true, my preference is to support a sats flag 
> in domain alloc (nested_parent only and PCI/CXL.io only, as the start). For
> AMD it turns on the sats bit in the DTE. for Intel/ARM the permission
> structure is created and updated according to the map/unmap calls
> on the parent S2.

They are functionally different things, and have different
requirements on the PCI topologies supported (eg CXL.cache vs no
CXL.cache)

I think they need to be different flags

Jason
