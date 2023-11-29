Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB04121A0C
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lwBqWYqa"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1fa619735c1so60702fac.0
        for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 12:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701288806; x=1701893606; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmvK7iHRPD4drkhDHPt0FzrLQ9Gqv9eBxE9BLp7oDgo=;
        b=lwBqWYqa5EWThLMHxgTURObe52rY6++s3451KfTiNIW/HZOrav4bQVIbX47tuolqM/
         M7znzaSVop8YHrIvyHKOHM7ovETtHE/N6RgfjmjLiNWhhANrnmtq+nioRjGdpiZhm+KQ
         sgnsqXE0cxmhUbDmZtAABzNOrgYMfDu/iqQBrTNOmo2j5vs4SWRTxGfLrVrIWyvVE+Zn
         wuKN6h7IixBqClsO5/GU3X4DezqBfo+dMXmUr8nyICW+NTv1hsFLx2sWzXXPLVDlh0Q5
         ykMkBoaOYzCspxuVYmh06IzkSgCqq4qScQfNzcmOH5LJnp69SdGLn8lJ8tzxBLZoZd17
         C1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701288806; x=1701893606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmvK7iHRPD4drkhDHPt0FzrLQ9Gqv9eBxE9BLp7oDgo=;
        b=AusLN+Gp6XbBRXQxUYIfCQGVjYrjpeGuHFmEtwnHWualGG2UlBKGRjTvro2JIfEKz9
         yuUncJ2rqOhDkSVFzHBRhhyluxy3Jz0hfe1EUq/rpoPPz5VYzVW+XyYbb1hQJreNzdb6
         F4/j/kJeYs5+FAfCXlq/Q3E4Km5a1fmU73vW1G5Uu1dleJo7TJ7ABbRnIEu6T794z0qk
         +pwi8zkITosBGbmQfyLgAc3fIJzJvpB/24NC6apiKF5e/cwFzCOf8LweKyOpthz20LqL
         45wogBWXMUJQk3hiWIGIDR7wlOsWiKZ+abXbHTwzRhmyRXfOx2AeGw84pmV8rQ8Og2I8
         I0Jw==
X-Gm-Message-State: AOJu0YzXnPGGlWa+7rRnhamYG6ETfXvEy9wkq7IGhieQta1JRXcdtT7Y
	qoCAfCuLkLaENVfNiPOvbM/CFGJ0LdGCPy35tQo=
X-Google-Smtp-Source: AGHT+IHDvOIdEFEEYA5mpwqmFFuD4VQhNSBzRUUw32RQyjUEYG/3aTKK4gbxat50WL0ewYuq2y3Y1A==
X-Received: by 2002:a05:6870:d88d:b0:1fa:25df:4031 with SMTP id oe13-20020a056870d88d00b001fa25df4031mr20698625oac.4.1701288805852;
        Wed, 29 Nov 2023 12:13:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id lk7-20020a0568703e0700b001fa35df2cb7sm2226220oab.6.2023.11.29.12.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:13:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8Qw0-005pRb-Cz;
	Wed, 29 Nov 2023 16:13:24 -0400
Date: Wed, 29 Nov 2023 16:13:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Disable PCI ATS in legacy passthrough
 mode
Message-ID: <20231129201324.GL1312390@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114011036.70142-3-baolu.lu@linux.intel.com>

On Tue, Nov 14, 2023 at 09:10:35AM +0800, Lu Baolu wrote:
> When IOMMU hardware operates in legacy mode, the TT field of the context
> entry determines the translation type, with three supported types (Section
> 9.3 Context Entry):
> 
> - DMA translation without device TLB support
> - DMA translation with device TLB support
> - Passthrough mode with translated and translation requests blocked
> 
> Device TLB support is absent when hardware is configured in passthrough
> mode.
> 
> Disable the PCI ATS feature when IOMMU is configured for passthrough
> translation type in legacy (non-scalable) mode.

Oh.. That is the same horrible outcome that ARM has :(

The issue is what to do if the RID translation is in identity but a
PASID is attached that should be using ATS - eg do you completely
loose SVA support if the RID is set to the optimized identity mode?

I vote no. We should make the drivers aware that they should not use
ATS on their RIDs instead :(

Jason
