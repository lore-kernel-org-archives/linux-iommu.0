Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA311CA9
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 14:10:34 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1bb119be881so17549245ad.3
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690553434; x=1691158234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5tUP+OZ94/C5k9X+LV1phua+DPB2PJTob2bFOeUyPk=;
        b=HlvyyLpE3v8P/Jm9N/Ihf1hJUbwu1rV1tEgSgPyrz69HwvULWLu8/X4/tvFDqeib55
         ruE67dS/JKXk4KDK4zn/5BfWKvqJ1C8RNVIZPIOx9bWl11rEhOWAw29uLAp4wt37M2WK
         HhtoaEBPHOL+Aify3gfo29Zp2j8lyvUZkO1Eh3VWIJwO1ardZWZHDy5qsr4EuY3MXTiW
         TB5zsKbIPYcV6WxE+hte0Sgq2SjcsWsAsJjoIRd3peHLLTgILiflx5d1VLdsufJLmWrf
         n/V43aM+xv9XfGY5BqPgJ+AxBD1rpKqcdpwK6Yz9khHRYPHQPKdRgI74fE50bXwVJLr3
         +Aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690553434; x=1691158234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5tUP+OZ94/C5k9X+LV1phua+DPB2PJTob2bFOeUyPk=;
        b=cn0wwe3RPKMswYSp/zJHiusb9tKR8q+fuWGZfRbs+2VxiTgiomxSYu0p9OEUPB767W
         3vmZn3e5Ig/Mpo3hXfamQXwgX+Iz80jsozmIaYQ4K77Z9o7A0B4HfSYShht/6jwyeAEN
         eIHfdrfE/9Wk8tfVW912B5/W+WlZLHM7/6pWV9plwD1DWDyKe1semYCU4EOkYbQb/OT4
         ykdpcj/NBEfhXGogxiCsOdfhYbmOTgY6gBTsSXy3VS2YRb5JyyGqbb2Xr8IFpqM1G5wS
         UOFHLuqtpbpz/XobNeBWQgziBnENEhxbSpU+hucKjRkqz5IbCk7ZOIYOYSROQEcNu8wn
         vFAw==
X-Gm-Message-State: ABy/qLYBgWAB5rG5+RHmuE5eqal7MFllTlv0fLZdMHITKk/GWLhyk6nk
	x0WmI8+7ug4pEUVhW6NcR3JC+Q==
X-Google-Smtp-Source: APBJJlGq8jyt0wzanYa4RK8CW/qB6yYdYh14mqDajPFoKEDeexqFFstOe6TWQNfb9K/drSQBi3OXAA==
X-Received: by 2002:a17:903:456:b0:1bb:77a2:edda with SMTP id iw22-20020a170903045600b001bb77a2eddamr1724788plb.36.1690553433974;
        Fri, 28 Jul 2023 07:10:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902ee5400b001b9de67285dsm3611641plo.156.2023.07.28.07.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:10:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPOAq-001bbj-6Z;
	Fri, 28 Jul 2023 11:10:32 -0300
Date: Fri, 28 Jul 2023 11:10:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 07/16] iommu/amd: Use struct protection_domain in
 helper functions
Message-ID: <ZMPMWKpe7QaR2J2P@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-8-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-8-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:36:00AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> To simplify the unnecessary use of container_of() on the struct
> iommu_domain to get the container structure.
> 
> No functional changes intended.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h     | 13 +++++++++----
>  drivers/iommu/amd/io_pgtable_v2.c |  6 +++---
>  drivers/iommu/amd/iommu.c         | 18 ++++--------------
>  drivers/iommu/amd/iommu_v2.c      | 11 +++++------
>  4 files changed, 21 insertions(+), 27 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
