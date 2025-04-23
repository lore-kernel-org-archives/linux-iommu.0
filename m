Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160F28BAB3
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430003; cv=none; b=QYDkTENJrxYiBmjvNDlFIlecEJ2IwZV0wU4p7ISrfnwYu4FHTftSFoT8/931UyYyQNfoGZUsmF6CEDzOBO6LQ2kdKJCIOmQu5YdQusBZX37whgPdZDakhMgZNrrdiz8hfa0vQSOgxLgoCaCUCmPbl4f7SFbhlKsBmpI7TazuxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430003; c=relaxed/simple;
	bh=fqDUwA8t2UWWpUEyQC6cAVOhBUnimvgbh866DiIXJ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsQICdrTkAIGhD1g8iYclO2OA7aFWyudKbKt62WUh8HnumULe8mKmxO5NswKJY/4KnoY+oRQhM42o9Pf+NNsk0IXUpa//LWPxcTr4eEU4peEoVyJAcTuHZYQ9GNA6ZjeoUc5L3u8A4BBOujVTq26+JRPDdMKzhTUe9Cm5azM59Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O4MbJbLu; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O4MbJbLu"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c554d7dc2aso10688285a.3
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745430000; x=1746034800; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dkawg+tdbHC9hQ8MctNRicE8hYlskMOz2aG9rt+rsDU=;
        b=O4MbJbLulzQ3zOzxHAGyAf+dEndpvITQ0zlBeu8BaZyKaccZOlNy2e1v/ZhI9bn39X
         /eZI4SEf8tt+j1LPcmgpyQqBanNlpApYiJQvnNHrYS4VUYQMG3rKh0E0qghIT6Xn5UZI
         4TvFVSnNs5/fOlD8W5o/TGCCfHZfWzNxojBP5OpRzU8CTP5geaIocUGYdWgE7kLousBJ
         AONejXzV6sW12cJBA+qYU3EmjLSYA6Ko25XmuW48VzR4Eyc1OoYlOZ/kcH4VGtmckJc6
         H1oxxQqyiPYS3A6cbJx6cP3mZ3ZxQxWrnctTyk3uRPcjCjDiaytYXF9HAyC+sERvH/3P
         AfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430000; x=1746034800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dkawg+tdbHC9hQ8MctNRicE8hYlskMOz2aG9rt+rsDU=;
        b=IRmpsk/It7Rv6JaPMzvqGOwFyG5rVeLN0ma/SzN/GBCHl5hvPvqQzd2AFtvGP18Sxn
         kZPYQohnFSxosBwNyGBjAqC7ulT1t3QGAF03UTge2+s/gYoXXdMIKgyJZLGl4W3Yfgdo
         xTEvp9mAj2W7uLANb2+xagAcQX+TpO6MD0Fl++gfhw0jUNw9OUn61VQs4mboNtXMTSb1
         sGzBHypVaTw/Z0VUznKgU8dM4hEbyfWHcpnexcn4AaM4aVIlJOgzOFjFKPLzA/OzXFLm
         ZdhVCs7TnyjLCaDP6UnI+yMcgJcD5Xix/O/AjnOKUIl5F+bfx43+lujTjVAu/FSPl70F
         /DSw==
X-Forwarded-Encrypted: i=1; AJvYcCWRWsYLNaomUbPISpL55ocQFFQ42YnA4t6yG+RCyQL/JgFs40tSV2n7o557in4Tza7dT46bVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxfnKKnHNKvxChOMyaaMPjTez2JuxRMZ28NqBPtt/Av80/R3Vb
	wBiIkVzLlm33cvojAswNNys8hWFcl7/LdkD0Dqr1q4tcsjFfAacmjsQB8xoEsLk=
X-Gm-Gg: ASbGncvMr2pPAgofFKx9/z0rLW6p4x2UboXPaxWv1Kpn87D4g+UAyDPhKIaZYzTt3kZ
	nCl0O+ilLCXzbhrfdBRhH7bVQAKdxdXyM2ov+cgKf4QJWb7fitCf+hktHD+AY/jgRc1QS/HJeXf
	JlSofn3+CmvOeJqww+fcNre9T0E8Ulv0tDF6cY8RnoT8hqwqeMgP8ZPpMf3RTTnDoM0dgAZ+kfn
	fEjrTfrSFsEENhjwHkUSrKujDDyGJU+OUUaQ+15AM6o9LzSLRp7AtY7WrnnIN1xTfvKRmmnATPg
	uYpUlNw1BS8w5pdVjIZ/twD6MM+XvR2BDpdNTIvwQYRs8LFjbp4XX5iyzi3jEE6BzdahjO6+L20
	OcbTxCGGO/B2maPSql+CFNevZTDACyw==
X-Google-Smtp-Source: AGHT+IEbQuW5n2GfFvJAnoWRo8rT/VepuLZ0gxRArfui4RxjUWT0n6IGPAbDd8GEItyJpW33RI8jLQ==
X-Received: by 2002:a05:620a:4043:b0:7c5:4c6d:7fa5 with SMTP id af79cd13be357-7c92804d68amr3534168985a.48.1745430000401;
        Wed, 23 Apr 2025 10:40:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6e9b6sm711717085a.2.2025.04.23.10.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:39:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7e4l-00000007LfH-1pvw;
	Wed, 23 Apr 2025 14:39:59 -0300
Date: Wed, 23 Apr 2025 14:39:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 15/24] vfio/mlx5: Explicitly use number of pages
 instead of allocated length
Message-ID: <20250423173959.GQ1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <f2367fb33c0716ba661d8ecbd423e7279be23a74.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2367fb33c0716ba661d8ecbd423e7279be23a74.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:06AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> allocated_length is a multiple of page size and number of pages,
> so let's change the functions to accept number of pages. It opens
> us a venue to combine receive and send paths together with code
> readability improvement.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/mlx5/cmd.c  | 32 ++++++++++-----------
>  drivers/vfio/pci/mlx5/cmd.h  | 10 +++----
>  drivers/vfio/pci/mlx5/main.c | 56 +++++++++++++++++++++++-------------
>  3 files changed, 57 insertions(+), 41 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
