Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6348956773
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KzrAcw8g"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b843fea0dfso695885b6e.3
        for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 09:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701366701; x=1701971501; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4q0ie9LD2pex/Wpt1lCOfG6/3m4+A3rP6x0oYN0JxiY=;
        b=KzrAcw8gmtlbU1kGdZLjqPn2hTgvDdgDKL8JAxSa8o3IAxwi0SQ/6o9iVxN62EvXp3
         jWifbFYJimhNU2R/RxM/l5hTOI1E19KWITlLIu0tYCkZOyHLNwldKMPMIB4L/8PY+wO9
         P/OcygxWGN0EtMGXjbyF2gSezy0Lu+11R+2qc4duZWuk9hwn0a5i+J71dd2fCkFpNByn
         eQ7jwrwrIPUX2cPBhVAeFJVwo4xCT2UrMTmPyLQ7ni6DvzDjg0dOSPp5FM/t0IMKqvhl
         F+wnua+rLnigSghE9vJkk0x5BsOETnxSVnX6okydavkZcostnbUku/zghObiM6UWQXWl
         lxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701366701; x=1701971501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4q0ie9LD2pex/Wpt1lCOfG6/3m4+A3rP6x0oYN0JxiY=;
        b=IA6ELFhkSMRGT0/r53CvgxPZmR3vp6tUd1jTm3gs4YqPEbg/YyeF6XBUERFbYJB7Hw
         jaqDzyMxD+0ntcXa2kWez0AB1U0T0HR0QnGVRs86sAAtYTo2y3eWJy2oYLnuXc9vJGrt
         PG8oqbnCzYBZzvvrO4NPVLDoROIfcfMrnFl4kRO7IAq34ZjBcbXWxWrZLoxtYGP3plOu
         AKsEnr5OSC7vZcsciDjbtXyXf1qKVI3iUwDTGtd4m9NCoeqry0N/p3Vtd/eC3hsRIQK9
         dA0i2TSk3vNd/RgiybJtljUpTqQj+KBpTrNdeRiI2/cUrqxvkL1A2dR/u2UUl5zYrJpI
         +5+Q==
X-Gm-Message-State: AOJu0YwsVSGglYpm0GUR/tPqCQk7a4PW3RUMjcufWnMBQPg9BGWWh37b
	sywHqd6CztY41tsw1WFMGuCbww==
X-Google-Smtp-Source: AGHT+IEYVXSwXfOZIyJw8KiFO4U+S6o4WP1jsAjOPsh4l1A94LVADC82SbrpaB0EGuCDN2HCnvIWCg==
X-Received: by 2002:a05:6808:229e:b0:3af:6595:e53 with SMTP id bo30-20020a056808229e00b003af65950e53mr402577oib.13.1701366701396;
        Thu, 30 Nov 2023 09:51:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id z26-20020a54459a000000b003b845ba61c8sm252057oib.12.2023.11.30.09.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:51:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8lCO-0069nx-10;
	Thu, 30 Nov 2023 13:51:40 -0400
Date: Thu, 30 Nov 2023 13:51:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 7/9] iommu/amd: Consolidate
 amd_iommu_domain_flush_complete() call
Message-ID: <20231130175140.GE1394392@ziepe.ca>
References: <20231122090215.6191-1-vasant.hegde@amd.com>
 <20231122090215.6191-8-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122090215.6191-8-vasant.hegde@amd.com>

On Wed, Nov 22, 2023 at 09:02:13AM +0000, Vasant Hegde wrote:
> Call amd_iommu_domain_flush_complete() from domain_flush_pages().
> That way we can remove explicit call of amd_iommu_domain_flush_complete()
> from various places.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/io_pgtable.c |  1 -
>  drivers/iommu/amd/iommu.c      | 21 ++++++++++-----------
>  2 files changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
