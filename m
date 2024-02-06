Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D212FF72
	for <iommu@lists.linux.dev>; Tue,  6 Feb 2024 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224312; cv=none; b=uoYiDzGPW3NemAr51Xwz/n7OEbv2oFFL/sXzWxQqZaIemBuHU7ID7iASmLUFXUToveNJJI+zCiFylo1XyNoCZaKRDfJOa1ICggFPeUx1tM1irCLtPYfClORbn1aZImHw0L6CJxyLCwyqiYFM8MCU/Y/HWRP8PqxcES/AeYvt7pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224312; c=relaxed/simple;
	bh=TPinO4RvNHpEkL3Or4LNwSg6n5PKXwqA0aGUnr8Zytg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfN5UvYXycanQEx3G2rZY2o6IoVBX4svpnj8uGeNWYHc4gHggyAwPEWjrcz4v8BrqJEN5bN1sey1VYczRiN8ohPeBh+SA/uJ8FBt+9eVVQ/WZ+2yTxgl+nbCDXexMtZ7Pc/4h39DGJu3UH6CkGo2XECCJclcUmd3FWV/Tgxd7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Y4YCenyf; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y4YCenyf"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-686a92a8661so28645946d6.0
        for <iommu@lists.linux.dev>; Tue, 06 Feb 2024 04:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707224309; x=1707829109; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=meuV6bX4mMB0Phqi8LNun02esREqylDAHsPHGqWmCU8=;
        b=Y4YCenyfXOc8FTOR97f2E8NxbYHi5ZzB23hq5ToPoM/oUP9Xcn+TcIuJTUTLJaR+tC
         o/AcWcYUHXq1iKezSKNoVTYFOU6rf0pVlKjooJtjXTRf5bEkySiEKK65wLHyHV4wF0ox
         Ha++LwhTpc2H8HJW40DQnLGgPvmFo3C+U6Njg5n/O+N4vlgt7XddZqI7wQBB/WED1Q1S
         yZRQi2RJNFO0S9NPxyhq705GdJDGN3IQ/0jOMsmwTgWZ8fvrLWH7BrGk3PJb8BR/zcqJ
         GRCVKbc1GsktjGskbMNUZYk1YssY6JKU9XK+RLk2gCZ1zgP0ePiKenvxLLXXpdbJG6jX
         1Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707224309; x=1707829109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meuV6bX4mMB0Phqi8LNun02esREqylDAHsPHGqWmCU8=;
        b=lzYePRIaXBVawN7DXaOLqwA9y86rbviUw/VFVELuBGuFCcjFa1D5zc1nw4TMXJjJer
         pEYWpVfsqFWhdK1eIkI4HY2dkeTNwJjsWNww+u7+py6l5ENlqs8clCrMtoFguBnEngTc
         MdN7L01oqoe5vWXbJBK2TJSdMhqW2ul17fT2+1KIctE9C8hhgLZ2vclzqoRr8pa1aIzI
         4NvT8f83UkoJSs//PQGCzN5NIIzJN1jEF7YUwAm9pTwomy9pSJPi047SJ/goGzODmchZ
         joHgI+4qSbj8a80sTWUgw2hZJeonQB2sdH75v09gymQCjOxkYEMJARPDmBciExqZC7xW
         UCNQ==
X-Gm-Message-State: AOJu0YzKOWMBr0m3cqfmpWit8EhGFRHJGYk8ft7mrE5qJofNamyRGII5
	G4cTqq4da5oim//s+/Eoe6wupaD4s5XyjFPVH8recDdJglvdRoAjDL4/UoRB3c8=
X-Google-Smtp-Source: AGHT+IHlMKWcDH/cVuXy/D3VBsxvQh8xG3wdZPi3FzbqJTYGiD3kJ0CDII9BBnW4A9yBJRNpHixiRQ==
X-Received: by 2002:ad4:5943:0:b0:68c:7a7e:d59f with SMTP id eo3-20020ad45943000000b0068c7a7ed59fmr3059446qvb.15.1707224309325;
        Tue, 06 Feb 2024 04:58:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUuOWRPkngf4+SfJntDYvyvWJ51q7Ww97N1F/YEyZoepVEJNrz+ncuq38GRnl23aC4iQBeRAWsmA4PGTDnsAQPWeZaW5T1hLOTwJtPZQQq7OmrhB1T1oKVUvI5vUfit
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id mw8-20020a05621433c800b0068cb008e832sm773769qvb.28.2024.02.06.04.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 04:58:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rXL1v-001zlj-Nu;
	Tue, 06 Feb 2024 08:58:27 -0400
Date: Tue, 6 Feb 2024 08:58:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 0/6] iommu/amd: Misc cleanup
Message-ID: <20240206125827.GE31743@ziepe.ca>
References: <20240118090105.5864-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118090105.5864-1-vasant.hegde@amd.com>

On Thu, Jan 18, 2024 at 09:00:59AM +0000, Vasant Hegde wrote:
> This patch series removes unused macros, redundant check and
> unncessary EXPORT_SYMBOLS. No major functional changes intended.
> 
> Thanks,
> Vasant
> 
> Vasant Hegde (6):
>   iommu/amd: Remove unused PPR_* macros
>   iommu/amd: Remove unused IOVA_* macro
>   iommu/amd: Remove unused APERTURE_* macros
>   iommu/amd: Remove duplicate function declarations from amd_iommu.h
>   iommu/amd: Remove redundant error check in amd_iommu_probe_device()
>   iommu/amd: Remove EXPORT_SYMBOL for perf counter related functions

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
