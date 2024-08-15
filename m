Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691B37DA9B
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726594; cv=none; b=Huwa+LPrd4mJ+yIQiQ7ezGwqP3pv8tjFkHjoKSUGvTnOIdgPmv1GBNsvjoFgzYnpZm6k1T9TSaoO0uWdxalUXOdx/Fq4NNzCDh7twBNppeMsd6srL0nLsa2VZni2UovGUdTq4CqqsNLX081fYWD2NHkMJy1QqBPs7yFZvczLrhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726594; c=relaxed/simple;
	bh=ee113TH9rqWZLj2L2cepHpWJ4FDQ8ARKOYAsUfWjq0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSGu/oWZpn9JvgsTPuu9A3l66H0+vTWr2oiTEik48h1oSrMmazib3J1dInfGlatSgCTAORVpgxqEM4MZSccr6YLx8LeT/yel1AoF+Yh2Xk24946TIcX7F9UDi1QgcwWF34fuGKArwcl14/HgerOspPPmPUYY4qYXbxmqsH2zTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AgVJul4D; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgVJul4D"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-202018541afso1105ad.1
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 05:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723726593; x=1724331393; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDT3aIVeWOv+0c5s7HzT1tKvm6H+9pOCwFIimNKPKpk=;
        b=AgVJul4D3U+CvBiP5go+osEbRzPOftmW402WOBJSCvMpIoOTqubzQsC56faXPTtCRg
         SlzPW7NJXyRKLSPlPrPsj0PyPt8ETzyzPIx+rVM2mCl9SUBiCxwE3ZhQuJEiJYGhHh9T
         3oTTvH5jl8nfe3WJVASx65FJ0irDtrUsFvwfUStpkxLwJUdrYKbP7JajLvNguQHQW9NE
         eZ6VxgzuG1jVtELc14pj3+Z2adf7u+f5nSsVQAWZEID7NBMARgIKBDkp+T73hyASmxHK
         xg1BrdjhuIebKkDnuFwo1mvC2sapiz6h0KpXbUU6rxIvADLeKPUNbH+QmWNW6yb3aRIl
         x2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723726593; x=1724331393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDT3aIVeWOv+0c5s7HzT1tKvm6H+9pOCwFIimNKPKpk=;
        b=lAzVG8/bkJ7roXup5LL+pUILfHqRwTxQsBoDbXGHtV+c9+QGpIJRWwFVaRO3/ZGB2T
         PEHBdkLMknCt/mSOVDWDsfkBj7g7VcrWZcu7PCWSC85zv1jFPu/ptEVLS+/8zyl65I+B
         LunBasQ6QrIS5z4JiathkKcOGVmQhnCR2qHaQ4+KEkV1kuqSZjgCkSVkZPzY/A2U4Wsx
         38AFJbR1zbcm78shhn4Cs1i2cQoByzP9n5jdO1WCNnapKAvSHXg9CRffWFvLQoUCb7Wl
         DN4oIP8hqFJGU9RJZCfjgnjuXbWOWM/A/RR/jaN0yCVNmHWZNpO5NHLGZ4fV1ptj9AUt
         KDqg==
X-Forwarded-Encrypted: i=1; AJvYcCVtho1E+yXWVE7bqNrRPx/kKLA+Du28skmG2ke5AbIg++/V5kQDbbEl0gEQ0hxE9nR++FLa8A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzhw/Cg0rRXeoE90eJjoU08RX0VXhD+JnkIO21U67YZFaWTmcca
	yDWEDyNVKDga8UJmOcGKtNBxq26hUAFDacQ8wxU4BmRRvMnpkT9pArN8uq4pQw==
X-Google-Smtp-Source: AGHT+IHeJ27kvaYBvs2okzntqeuVsfe85LU9Z94TzYgfQyqY487wdY/lCEe8modQx6P/dWbtnKVHXg==
X-Received: by 2002:a17:902:f547:b0:1fd:9590:6584 with SMTP id d9443c01a7336-201f069bc56mr910265ad.19.1723726592191;
        Thu, 15 Aug 2024 05:56:32 -0700 (PDT)
Received: from google.com (202.141.197.35.bc.googleusercontent.com. [35.197.141.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f039fa24sm9607825ad.260.2024.08.15.05.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:56:31 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:56:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	y@google.com, Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev, Kunkun Jiang <jiangkunkun@huawei.com>
Subject: Re: [PATCH] iommu: Handle iommu faults for a bad iopf setup
Message-ID: <Zr36-J4fZ8PlcvV6@google.com>
References: <20240815123223.7116-1-praan@google.com>
 <Zr33pnFDbuJntl9H@google.com>
 <20240815124611.GE2032816@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815124611.GE2032816@nvidia.com>

On Thu, Aug 15, 2024 at 09:46:11AM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2024 at 12:42:14PM +0000, Pranjal Shrivastava wrote:
> 
> > >  	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
> > >  		report_partial_fault(iopf_param, fault);
> > 
> > Apologies, I sent out an older version that missed returning a value.
> > Please ignore this email, I'll resend the updated version.
> 
> It is probably Ok, the merge should resolve it.
> 
> The fix is already in linux-next:
> 
> commit fca5b78511e98bdff2cdd55c172b23200a7b3404
> Author: Barak Biber <bbiber@nvidia.com>
> Date:   Thu Aug 1 09:26:04 2024 -0300
> 
>     iommu: Restore lost return in iommu_report_device_fault()
>     
>     When iommu_report_device_fault gets called with a partial fault it is
>     supposed to collect the fault into the group and then return.
>     
>     Instead the return was accidently deleted which results in trying to
>     process the fault and an eventual crash.
>     
>     Deleting the return was a typo, put it back.
>     
>     Fixes: 3dfa64aecbaf ("iommu: Make iommu_report_device_fault() return void")
>     Signed-off-by: Barak Biber <bbiber@nvidia.com>
>     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>     Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>     Link: https://lore.kernel.org/r/0-v1-e7153d9c8cee+1c6-iommu_fault_fix_jgg@nvidia.com
>     Signed-off-by: Joerg Roedel <jroedel@suse.de>
> 
> 
> But doesn't look like it made it to rc3 yet

I guess it's there on as it gave me a build error as the `return;`
statement was returning void for a non-void function. Fixed this and
sent it as a v2 of this patch.

> 
> Jason

Thanks,
Pranjal
