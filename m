Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B265578C68
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792227; cv=none; b=XfE54B4bWQHcKATJ08coFWGMPlKrVHzJhe/dARa4qx7Y7SCqU/98MODf68j3NJIJ7q+0YxcBwe+a4RysaA6pA2YNI4hcS8shp/UHnLtJIvqiq9OTZL+zurB8kHZ01r2lghyBupmWI/qkVNTrB0idls9woOTdnkNg/tWAnMp8oBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792227; c=relaxed/simple;
	bh=gpACkrs/uXjBbg5a/oR+9AEnUS0Juz7EFhPJC3gb6pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIIuRlnoe7c1oDbk+zjMxSOppngaIY68afuH03wTf6+GDAf/wbXAstlCb0Ul8ECYjoGor+yQqhB61YruAuGmk0ot5ubub4VrfnuOm5a83Hwm33Ui/p1QEVfj8gMNUVRHUFGd2PNQsuQ4sbYuDl1nVXO7I+VUxgwRUXZ4ekXS6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4RaCtxz7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4RaCtxz7"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd7509397bso72145ad.0
        for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 00:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723792225; x=1724397025; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+HhIAvJgppXux4d6IVcmtCnIpK4pC74U+LNaCgWgVfI=;
        b=4RaCtxz7IXwjnAVT7b39TvFM8HRDDT7N5eDhQZcrMn3FUNH15C9POkNGi8U+CrQhxW
         jAy4vLtmlSqjZi6De9vzryumEjwGIo6pKwW6f6tS2WLq2gIgVQIQNPcUqnLEwr7BTab9
         g/myH4EyrP1hENc6NNxTah/54iF4jsVphxEZzQqVF3EIdDwRk7Oqx6nGXT5daCY2Z+Rf
         aY2XRhArpm7cHCY5/G9sEPL971G3poElrOPqDLglBGvBiDm+SNTYVqExOYMuQpzefmmH
         bPZd7o7ahhd1MAARTXMzMrCsKrrJ0W3MmUhUp9/35w4Ag2k6ZKOXC4hQvCYN2iTC6ydJ
         Yz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792225; x=1724397025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HhIAvJgppXux4d6IVcmtCnIpK4pC74U+LNaCgWgVfI=;
        b=TTWs8/1B2PBNNI3XSjqJp4ROVsZgvZuYRbvVEpLT4vw2jkWrWwtr53fQlAUJQ9IyMC
         nYcOPXXEzRlaIDJWkQbC9dUAoa1DIdDIslhGL7sWZeiJABDK2Jli9ozrPAEvByG4URPt
         3mUbGoqWnPicMd1mhgMrYxnSSRR+dpXEsszpYPAvwevyY30/B2JCnV4wybu8lRhd6o7i
         hpvLCk0QZFpbXB6hcbwsutZos6HX13IsrBvfKm96sb9bu2awu7GvrjV32+E1fETYpykc
         4r3HyMGSTNQQFlxJ/rpx6KpmHEvsjl47kDSugV/l+U0UvcFmtAnSruySz7lMFShFn88c
         0k5A==
X-Forwarded-Encrypted: i=1; AJvYcCW9Yg04q2O9X2P4iTD9puCH+XY5+8FFlatt3sHMipR+RxZPR3P3M6enrBatF78k0+V05P5CIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTcqjs1dmQIS/PLm225qPJ9kZFrDujf/ymaFbQa0B6NtaMuwaN
	zqq4Z/fxDdxc9ZVGKECYoQfqpDEqGoqP5ZRtLI/gBxuHz6vV3xcGxzvCsE4jAG8p7NrxX/1wMY6
	+uA==
X-Google-Smtp-Source: AGHT+IFi2rqIING0pGXRGB52/CE8TbVSMLIv9oxxcRwJ/yHJ5P/iRSKwihPSr/qArD7mySmxxuaZIw==
X-Received: by 2002:a17:902:e886:b0:200:7d11:e8e3 with SMTP id d9443c01a7336-20206034f28mr967445ad.14.1723792224474;
        Fri, 16 Aug 2024 00:10:24 -0700 (PDT)
Received: from google.com (202.141.197.35.bc.googleusercontent.com. [35.197.141.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61a6d1bsm2291179a12.10.2024.08.16.00.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:10:24 -0700 (PDT)
Date: Fri, 16 Aug 2024 07:10:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Kunkun Jiang <jiangkunkun@huawei.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rc v3] iommu: Handle iommu faults for a bad iopf setup
Message-ID: <Zr77VvlEVypQMGjw@google.com>
References: <20240815182423.446137-1-praan@google.com>
 <c35a4976-7b36-411d-9f4c-4fb3a3bf204a@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c35a4976-7b36-411d-9f4c-4fb3a3bf204a@linux.intel.com>

On Fri, Aug 16, 2024 at 10:17:59AM +0800, Baolu Lu wrote:
> On 8/16/24 2:24 AM, Pranjal Shrivastava wrote:
> > The iommu_report_device_fault function was updated to return void while
> > assuming that drivers only need to call iommu_report_device_fault() for
> > reporting an iopf. This implementation causes following problems:
> > 
> > 1. The drivers rely on the core code to call it's page_reponse,
> >     however, when a fault is received and no fault capable domain is
> >     attached / iopf_param is NULL, the ops->page_response is NOT called
> >     causing the device to stall in case the fault type was PAGE_REQ.
> > 
> > 2. The arm_smmu_v3 driver relies on the returned value to log errors
> >     returning void from iommu_report_device_fault causes these events to
> >     be missed while logging.
> > 
> > Modify the iommu_report_device_fault function to return -EINVAL for
> > cases where no fault capable domain is attached or iopf_param was NULL
> > and calls back to the driver (ops->page_response) in case the fault type
> > was IOMMU_FAULT_PAGE_REQ. The returned value can be used by the drivers
> > to log the fault/event as needed.
> > 
> > Reported-by: Kunkun Jiang<jiangkunkun@huawei.com>
> > Closes:https://lore.kernel.org/all/6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com/
> > Fixes: 3dfa64aecbaf ("iommu: Make iommu_report_device_fault() return void")
> > Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> > Signed-off-by: Pranjal Shrivastava<praan@google.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   2 +-
> >   drivers/iommu/io-pgfault.c                  | 116 +++++++++++++-------
> >   include/linux/iommu.h                       |   5 +-
> >   3 files changed, 83 insertions(+), 40 deletions(-)
> 
> Nit: can you please add some words to the comments of
> iommu_report_device_fault() to explain what it returns? Right now, it
> looks like the return value only matters for certain iommu drivers, so
> it would be helpful to add a clear explanation.

Alright, will update the comments in v4.

> 
> Others look good to me,
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Thanks,
> baolu
> 
> 
Thanks,
Pranjal
