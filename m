Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA461328B71
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398247; cv=none; b=ZvQyvtimoYuSvhnkE3fU5piyrzIic81IscEDhhOblzSSpEuptVx5rIucwrjiAbK6O124aSLSPX+E/ouX57yt+p9UMhmNMaDYPu1p+Z6sg8lWgz8TO15231RQyhyNiIocH+rWFb7z79qPDkhx+Oe7kqKAqaK3JvESftlLefHsOas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398247; c=relaxed/simple;
	bh=c1D7XRO5k0E9q4ZnSFdv3f8QUqN+hVwJQYyRnr+b4wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tj6srO/UY+0ghGF/LtnPs7Uk+mj1FMMXrTzAh3kNNnWP+PhKttERHfG6CbSymuezwAFPSTF9dKmOawg2PH5yg/dbIYW7VAu7JIH+zYGv06Cy2CZqHxIXR8ZE0D4C+2riedL/4T46O56MtRghXEfNCUZXbPWazgLBrFV5oLcyYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dI2+Wbjt; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dI2+Wbjt"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb5c9ba82bso1722938585a.2
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 10:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777398245; x=1778003045; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RtKZrl1ncUKjpwUZZLwbMETV3BCwK5wjjxZI3moEtBQ=;
        b=dI2+WbjtFPLltG1YZKoIlPJ8euoaQIi2jcy4f3eKwHCems/sRIpeMn48l3x1VGYUO9
         YrwunEKDWtdGNf58IbLoDuAYb/yB3qAjcWwA+Po0dzNt8j9oiV28xLhhyp6Qsr4Bn+9g
         liO2p1wDyIZZ8ns8qOgrYpoPEYrqQMYF8DYpUXrDm1wl+yWjlGyGTicHVSoz5ZzmqpBL
         4ifcu4sKjpfMYeSrBSbVZ1Nt0ehJFuVCBGksRE8OzUgSFKpV2j33oYUKxROgHvmZN60u
         IQpf1GorBugKQeLe7fD8ff4oFMlIzfajFm1TtsmexNFEe/JCxAL82JsZU22ZFulEhKcM
         fQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777398245; x=1778003045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtKZrl1ncUKjpwUZZLwbMETV3BCwK5wjjxZI3moEtBQ=;
        b=i65F4sNvAY4zLPSt4Bwc+Bx/vZO4np0s3DL6NsKk4IMWigIqSOVQcvZfpGrZi+pqS5
         V6ELQQk55rKdD8i9qBUPrd4sh3jv9VEiNgz0oiEvEW7qqudss6zUUW3bdRJ5hbEWBV53
         LO7GbSUWKksgcNevUfPYKFitm1kElcVbL+jzovjW6XD1f4BnSgfIvVIfItFhdlX2JmiM
         oekXxOTHyMvY2+OJyYcSpg/kbJwhC2bI+oz3hX3LiNBCVbW13xgrogpyzrMGjGGYNaoT
         4avPbKHjGjmztG3WGMdBKSOtt2vZfxgQEcKf0vd8SxHTKA7I3y8bywEh5hqwr8aDHZDH
         paBA==
X-Forwarded-Encrypted: i=1; AFNElJ/oUarToxbxKZmV2xk0X4Nobkt2KPNWA8Fq9+klagJ/2g20DZtu+vufDyhM5218thwi5dH02w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/pBLkNNj6lYHkG2AI/ZcRGtq3VagNcinceHov6Y0NroXAWByC
	AeuA+V7749vZ5uwKFiZikJtUja6Frvx6jB55oWHPwLiLP1g/nBk4QGxB5Ru0Y1/rnB4=
X-Gm-Gg: AeBDieurrSNYz/YxPfhDbCq9AKtW0/ZM3DQhEl9aTutUtToTzSCjrEQmKMiTkbHdX3q
	P78uSBjH3FD3JSoVM11E5KVNn1bdWd3QIusUw0XQKNPB3g2RqTCdzAW0NpMmkiiOeL6qZcTcZzs
	20x0p0gEg55jRAt3x9Xb/Vp6C0On9LrPooP+FEgJTW/T9zTNl3MzpLNMY74pXRJdMUla7r0S5zw
	qffQxn1NBjnQZ7UFhoWfEZPycos8sy6ULv7jHK4wlNwDDtSaLtay87h5QpYLS/43e5HONQCTUbK
	BgmrIHKnt6RNFZ68lGw5+DmgoutmcaJ4K/5TDwmcouas97BCzoWB45o0YRtjlBFLyZQ8KF+Vsbz
	bHFeQTeIz5X0Cdp9Fq2BqJ6rTd1TsIVf3S4NQACxXWZP/2ksoSwBu3LP1axYa05og99PcenK4fX
	jiiTDthTMRMISoiRnCOcpuZrh0mXa6SvdNU33jhSNJ9+VQq+kIKRcpHUQpJBoyFHoHD1sbJ5b+l
	Rbsw7T/pdNPqG8P
X-Received: by 2002:a05:620a:6ccc:b0:8ea:c7a8:5072 with SMTP id af79cd13be357-8f7d6e43f26mr522395085a.8.1777398244779;
        Tue, 28 Apr 2026 10:44:04 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c87acaacsm247411785a.43.2026.04.28.10.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:44:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHmTb-0000000C6wg-3fSo;
	Tue, 28 Apr 2026 14:44:03 -0300
Date: Tue, 28 Apr 2026 14:44:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: Joonwon Kang <joonwonkang@google.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
	nicolinc@nvidia.com, praan@google.com, kees@kernel.org,
	amhetre@nvidia.com, Alexander.Grest@microsoft.com,
	baolu.lu@linux.intel.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
Message-ID: <20260428174403.GK849557@ziepe.ca>
References: <20260424085339.3503582-1-joonwonkang@google.com>
 <e9de1b01-d075-487d-a00a-e2420b909f69@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9de1b01-d075-487d-a00a-e2420b909f69@linux.microsoft.com>

On Tue, Apr 28, 2026 at 10:38:37AM -0700, Easwar Hariharan wrote:
> process address space, and would break the DSA<->IAA kind of interaction where the
> device drivers can communicate the PASID among each other to operate on the same
> process address space. 

That is not part of the Linux model...

Each device has to get its own SVA and it must use the returned PASID,
not just invent one from someplace else.

Jason
