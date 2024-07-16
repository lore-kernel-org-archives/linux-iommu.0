Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75819AD90
	for <iommu@lists.linux.dev>; Tue, 16 Jul 2024 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137298; cv=none; b=QDyHlCTZ/vpxNr4V89PBwlV2fB5iXAjPGr97kMVmCRjM6lYzVsoLELH5jxkidlw4QpP551mJKHR6nV1hAmFQs4JszZEYFx4EKp5/Yavf3PXODi0NZqJSQyKzDRIUOUpzy8qKxIOWqENUTgSz5WjyDzVJN6s7c9XJj0GABFkOpDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137298; c=relaxed/simple;
	bh=IY98PCGOl3hqC1EY2XVKptak6dMiCmoMXUoEwDWjoNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTICFHsUfe+79M0h8O4ZFv4bHynAyTdP86zb+xhz2weFnsWmPrqLJps+O6Ed1iZMhTIQrmgB4yAWE/FQGtZTwvrRgVC/M4MW97sbtph/QNOfdStPsGz++Ho4Eou2/IkDyOryJpPtU1OSWc3MjX9BkV6qE2GUE/vkbLUBh1wYckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=o7pjYDIe; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="o7pjYDIe"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e03c689addcso5488855276.0
        for <iommu@lists.linux.dev>; Tue, 16 Jul 2024 06:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1721137296; x=1721742096; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSoixpefhw5er17Qhui0yd8YZFV8BSlK/c8a6OQCAVM=;
        b=o7pjYDIeoQENhn5GAMVmvDylMisI1SkQBZ0sNliRHpj5NSG+pAd/lJEO3cpujFTJF2
         3l7X1LS7PCiY1LEl2QWMNS8vjUx4MHTvSJlrngzzwda6BySODo4xpgy08MzJlLdwe5vz
         4bbV1VDHqFi5Pht9nhzH+I/Fu1x+RlQBBByDyYWecvMIU9jc/V+nmbxilKWev2k2BxRb
         N9S9Iq1dunc4VtWjcVTVsZa+8SxBsXEFGJb5cJk9uNrZ593ASn1dvWt10Nw/uyKblslv
         P3Dy7twzONqGa4EFsGOaeFwZbJbRCW92PC26LvIluqKA32sAeegTGIK5DQnlwaYBnoW2
         wFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721137296; x=1721742096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSoixpefhw5er17Qhui0yd8YZFV8BSlK/c8a6OQCAVM=;
        b=lvGQFBXfsPV7i0WQRCKNZr0mbGVdkVHe4YmAT6IIb7TcvRVwDF5gVPJYo+WFHnZUpK
         VNw9CjsOHci13SFr/6cCC4+cUfUyoyedCOzgj/VPwkvCKIlH78eNSmkV1Ujag5VRUwJk
         rpfN4Ha2zJBhgJzPA6Li2oUl2GE43KCCpXpSe938eF9L422Ht1PVpG322pq/Axqx8bCK
         RwR/dBFs4VCawI1jSIFiGjBw6VyuN1uVN0krbxkqUqAyuyH4UQHI32bIy2kBMJpyf460
         ZKCU6ek30Xc6y9qelG97BDCyPiI7ZteDx++SbvI4JDGDt0g8yPxWibygA1+UCw2itTQk
         74/A==
X-Forwarded-Encrypted: i=1; AJvYcCWyWM8EoX33W1XB6EIb8dPmH9mfKfFHk6x4kaaSZHoH/+hXyifjP9lZRRk9uo+W/IJBKJ/NlFfB48oyE5MofKLV7pDJh3M=
X-Gm-Message-State: AOJu0YwxEJ8Ph1VY7Iu0oeDY9EyuMeYDMzsyQm+jb2cwbe/o+QCQJmKy
	WfehLsR+sXpfCkR1Q+pp7e/yO36qgJ+kPEnK1I8Vf4CsvVPSZmi8OkC+0ma5t60=
X-Google-Smtp-Source: AGHT+IEXiLBqZf2OY4ZTbtsOEWKwZSA42/xwjXDzEnD0xfmJDlRaURE3OPlxOrQ1vCmrJux9nwUAHA==
X-Received: by 2002:a05:6902:1206:b0:dee:6070:693f with SMTP id 3f1490d57ef6-e05d57e9b2dmr2644636276.37.1721137295946;
        Tue, 16 Jul 2024 06:41:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7678980c2sm28077226d6.86.2024.07.16.06.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:41:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sTiQx-009RMD-1H;
	Tue, 16 Jul 2024 10:41:35 -0300
Date: Tue, 16 Jul 2024 10:41:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support
 AMD IOMMU driver
Message-ID: <20240716134135.GG14050@ziepe.ca>
References: <26524622-971f-47f5-936e-d0173d342288@amd.com>
 <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com>
 <ZoLmyOzOVYGLKjmn@ziepe.ca>
 <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
 <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
 <4ffc953f-4968-46c7-b6a0-b7b2fc454564@amd.com>
 <71880aa8-adb9-4f3f-ba9a-7862e8d30b46@intel.com>
 <97538ddf-57e4-481c-9429-ab5a4b88710d@amd.com>
 <85821ad4-5fe8-44d7-ae8b-4bf13e960c81@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85821ad4-5fe8-44d7-ae8b-4bf13e960c81@intel.com>

On Tue, Jul 16, 2024 at 03:43:35PM +0800, Yi Liu wrote:
> > Right. My understanding is with vfio IOMMU we will not support PASID. SO it
> > should be fine.
> 
> then you only need to take good care of the iommufd hwpt allocation uapi,
> and the domain_alloc_user() callback to achieve your goal of this thread.
> Anyhow, I'll still loop you in my pasid series in case anything missed
> here. :)

Right, Yi's series to add PASID support to VFIO is the primary issue
here, that has to be done in some way to accommodate this AMD
situation.

Jason
