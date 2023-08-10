Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E57200A4
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 18:59:10 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-76c93abeb83so92378385a.0
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691693950; x=1692298750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Zq0l3xZQiEDwcrtH7vACzt2kdLllz4ciH/cpuUOM4s=;
        b=JErK18ADkD1dTNzsRq+SbbDprsUFNPoAzYx9s7K3M7nQd4oYJ8BsxhMmdmA1bSkIfv
         GX/X6fvYVS2EirYupvLRfaflRZ8AlzSSf7IxxSnx/Sxqj1fNZVITtmtwr1lmFaYqDjCo
         2WnIMuS+4K7fNeZl565GjLMYfTsFMeBCZO23OEILH6+zwY5YgwK9GDpmJt3RsZJyWYNE
         ueFugH93WIMVJkZ6McBqGcXVwCwHrp7/koFcUsoqa7C+IUMeCG6fYZ/uzqi4RfCZ38uA
         PT4aRO8JFn+voySym+TaRdDPTw3tMDhJaXKMVIrulLNZFGEA9f0h0j2fJpWdJNtAu/yz
         OOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691693950; x=1692298750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Zq0l3xZQiEDwcrtH7vACzt2kdLllz4ciH/cpuUOM4s=;
        b=BK5zARFsbYviDv4rS4x6r0hehuAmSWbdopHWoQXkdaKx8lPrrqRBRBe5K0jZ0IHY1h
         mtl0BgQBp1uWxZP/UocQl/UfQwSiu9PWKVOLQXomOsNKBnyBTbt2k0L/rHYHdvpoIg3W
         Wgsja81/ktA9+GhII/dg+x4R86fT9wDpuakhQHcY5WhR19bhejwkTQr4+T0qO6HvB/j0
         7YJdP5QdNCiTDet8rHIRj2rzdMFJDjMiSJu3EHkLwKq3UDnjAxaI9Y3sNnIRnzo28mFw
         5T8TxIsXNdALbnsexkxcj4pTZolsQlosQAenXv7SwDT0Q0hSBidjVXgzPykxeVQkcxs/
         wXvw==
X-Gm-Message-State: AOJu0YzycmnYIQcN4P3WAST08FcLPLVbr7xv4b3ocSVD99GYPnnvxlTK
	31Xpqlj+9Y+NYk1iFKxn4DkgnA==
X-Google-Smtp-Source: AGHT+IFKkMDEkgSctGof3sz+jJvzI+ZC32d6umGv4kDgoGWJhf/GlnIZ8OsWb+JmdP2TnPFsZEEmxQ==
X-Received: by 2002:a05:620a:3191:b0:765:3e03:10db with SMTP id bi17-20020a05620a319100b007653e0310dbmr3454229qkb.48.1691693950008;
        Thu, 10 Aug 2023 11:59:10 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id j10-20020a0cf50a000000b006300ff90e71sm679584qvm.122.2023.08.10.11.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:59:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qUAsG-005IgH-N2;
	Thu, 10 Aug 2023 15:59:08 -0300
Date: Thu, 10 Aug 2023 15:59:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/12] iommu: Remove
 iommu_[un]register_device_fault_handler()
Message-ID: <ZNUzfFDyT6/VZgfW@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727054837.147050-8-baolu.lu@linux.intel.com>

On Thu, Jul 27, 2023 at 01:48:32PM +0800, Lu Baolu wrote:
> The pair of interfaces are not used anywhere in the tree. Remove it to
> avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h      | 23 ---------
>  drivers/iommu/iommu-sva.h  |  4 +-
>  drivers/iommu/io-pgfault.c |  6 +--
>  drivers/iommu/iommu.c      | 96 --------------------------------------
>  4 files changed, 4 insertions(+), 125 deletions(-)

Some of these hunks should be moved earlier, but

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Happy to see it go

Jason
