Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D59229406
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013498; cv=none; b=dJwz9pfTxR/X9dYVxf/1gw5Euq88M7G6ZmW3jh8wj69U1Gn4B4+DEAcytmWeZisSaZs1LCk45yWe9VCt/LSs+kOWeYtxKAcJ0eyC7UesfZ0B2svzYKULNwVfo7dNmFTblxpU37RQwOEt11euDfeMS0rdg145tiI/bU4hepGSA80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013498; c=relaxed/simple;
	bh=JeYy4pG+I+Mr6dMRTEgew65StItnooXP7D/DpPk71P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPuicwBSOAcysRufPvxCxWRFinSoWjhnwGUQwYbEUHoMWS4sSFckX4N9OfS06/WpunvBtAc1RhXLuqq9tyv31oNnWupeQ7lRPZHS4V2aOiSvrv9DbdeF70J7Hj0EzEsYghL3CLWCPMnjvR0CaXZawxqMF92Gg8DftheOaMccoiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=N/HyQ8Hq; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N/HyQ8Hq"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e65d6e1f12so4352076d6.0
        for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 17:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740013496; x=1740618296; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1MWBwMxYKDvEMb5Nsgpje67CQl23BipqyXlvrUrw49c=;
        b=N/HyQ8HqN3CzAwFNckjfVinO3msa6rNNoph15Dgn16YGFJzjmsJ2+nW/azYY01Wp2P
         /U1daZsCImLhhipnkYMMG4l2L26TissV6QbCrqt7qO28O/qtogswL3+eOFNMyOFo9LnJ
         JiFktB3bUJ7TNiIE/fZFGSOOhOdR6ax+bI20AXdb2J0L1tnD52mqEWZXHaClq7bMvbKT
         tIqThi21qGAcgXSvoJPtyFM+og64+IfKL27FX7W2+0Bp6NxIp+TNTwEHfp+6Z19DEXfh
         PuVcMwIi3YE97AFhNiZTtkzAKI/H3I24NN9ogFyVUiZWKb0u4G/DYU272KmtgAQ64zKD
         z/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013496; x=1740618296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MWBwMxYKDvEMb5Nsgpje67CQl23BipqyXlvrUrw49c=;
        b=M8NksR9KN6nE33NsI6F5Netvliy/X8OScWk4+ZyFe2genTw7UVsHwMI3dKsWDdS7mP
         tnAmhvi+UWYSxixOL0RXqqAgJJux4aXC+wT8imw/hy/xYEe900A1QCARL0E1R+fLop1w
         1ohTd1kPmzxiweKnPVodA6hHGHkDd7PfE0zcwix8kKHgoR+KPXN0tXZIyqxtRp5DKkgK
         YBN7pBR2/YyOzgsYqFSnjV3nIxacOMt/PLWS5VHx9SiM5F9WSGhUObY4PY/MX7W/zpC4
         m7X7qlgY9Fs0Kg6cKHtU7NJcl1G/zRmvW+Q0AjNi1lX2JOKnPhyhogLTvCVNMD7L8yFu
         7QYg==
X-Forwarded-Encrypted: i=1; AJvYcCUVhqzfkdddlGzDw1dWSJOn+Kn3S1AjlO79B/wC+sWoNafhYeo05cpTDFVOD6PeRDoVBjDW1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywbrmumi3uRd1o5XzIVJvoAqY3EQqcxT7n1xp5MChFiPhdH8McE
	X/OEvWcSg1EA7vdwo6LHQh4s4sJHQ9Fpc0yTlCjWAGMDl/1R62CzQ7fgPGuPA54=
X-Gm-Gg: ASbGnctMuArw4nqDaJRPyBbIyQ0TwblWmKDZSIdIubS+JfNVHT0WAZerXCK2sJMhoBz
	pBq4gFlJo6SrD2kPzHHT2srhNKWLJwjLY2SA5e4arKvXCxVZ/QmgMfBMZonK4MZgfuqhV8opw/O
	U78pdqdKy4JaCU0CxVb9ImNLx7h0ip4tY9fil79FE3iu/Euk6flcbAZYvztu9otxlReyxJfDOnE
	BnA/l4KK91HNh7x7Owva7ZtdBHJV3GM+R/RlN1ZfG3JqeS7/KtTGLgsAppbr8bUeHFRSf8mJTCB
	5q20hYoftjEB9iRfdpz6uHUYARD4zMsKElzwTfuOrTMn/VOB7IPlUnkDN6wMtjme
X-Google-Smtp-Source: AGHT+IFzEq0526xTcxemb2Cr+hRhWjxAyU9EvBZZD37sIHxTHpA3ldPJFUOlpPg8MYbowsx6pgY/ZQ==
X-Received: by 2002:a05:6214:21c8:b0:6e1:697c:d9b8 with SMTP id 6a1803df08f44-6e66cc8b653mr315657496d6.9.1740013496437;
        Wed, 19 Feb 2025 17:04:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65daff4a8sm80630306d6.97.2025.02.19.17.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 17:04:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkuzn-00000000D8m-2TxB;
	Wed, 19 Feb 2025 21:04:55 -0400
Date: Wed, 19 Feb 2025 21:04:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] iommu: Remove iommu_dev_enable/disable_feature()
Message-ID: <20250220010455.GU3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-13-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214061104.1959525-13-baolu.lu@linux.intel.com>

On Fri, Feb 14, 2025 at 02:11:04PM +0800, Lu Baolu wrote:
> No external drivers use these interfaces anymore. Furthermore, no existing
> iommu drivers implement anything in the callbacks. Remove them to avoid
> dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/amd/iommu.c                   | 32 -------------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 34 ---------------------
>  drivers/iommu/intel/iommu.c                 | 25 ---------------
>  drivers/iommu/iommu.c                       | 32 -------------------
>  include/linux/iommu.h                       | 28 -----------------
>  5 files changed, 151 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
