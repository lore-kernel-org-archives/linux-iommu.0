Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76B1EA8F
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 19:35:39 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1b8b4749013so17045335ad.2
        for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689968139; x=1690572939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zzRV4jT/UtNnsNIK2YvG3L4X5UH72+69TP4OaQhmPt4=;
        b=JfMGnrE+g4/SdXqp/ILAdh8OXvsFjfzKETJHY+EhlewfKhrwUZ7RoTSzKYzg/yardc
         q8Kxwh36Uh0alOQRzLpTJiv+muY/pM/0QMO13VqRNd6mSkBAuzE8Y6Vf1Vo8IF8VaYFm
         ZM5I8a2BhNFvQNAEAJURcgSp2m2m3PC2Yx+Rwz8AdVzrHJ2A+N9Y24PPf8Vh2DLA9J7a
         ys5PbTXsComhwHn7A1jDs56BwRrB4QZzXdF2e88pkpT0JViBziznq2TDlyxDGepnE2RY
         LEfZFIh6ZBKtXl8gzi+XeNAIQCBJA3i3bAy6V+Bidl2HemJcbdaJ9FaBpp3xBvsdlW4l
         zL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689968139; x=1690572939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzRV4jT/UtNnsNIK2YvG3L4X5UH72+69TP4OaQhmPt4=;
        b=FbdUabMeYs/Nzc/Bl6BkF6C8LgO4u/11ckZJV9hgutHe27N2mawhG9vL7ByAyjMWQ5
         Y2pFZdEEGHXXaQK8147j4LyYluQShXiRx3+wtIxQUsPVLLVG5prd35FbTNY/8gdq/V8g
         LYf3ih/Hj6OUibYFz4sWJMuFVModA9Ga5i6uI7UOVo45RZKiQHQ/TcWcVge5UGTUOMzr
         iDIM5DK+Bv6Xdk2KovN3qgE5824oJC9pgoY2WLb8keyZ4AQMakfL39bS00p+yEZIbUKu
         1zLwF9aaogPlXmb+d88mK6ApXfN8xq91x8g/L2wa75qjfOEJKDyFxVXW2305trtZVJGM
         M+rw==
X-Gm-Message-State: ABy/qLZ88lkvMLgsKySv1pUpIW7ItbiY9++Py8uDS3Cn8nv1evq/654L
	WU7tx6v/Tko30aEy/5+Yf8WkmQ==
X-Google-Smtp-Source: APBJJlErhC+VIXfffdNPDZMSDd2lEyokEWsGZ4siE0VrJXPYSeMfFCGzQlYHv6H7Qp1LgMkojZxgOQ==
X-Received: by 2002:a17:903:120f:b0:1b8:4b87:20dc with SMTP id l15-20020a170903120f00b001b84b8720dcmr2955939plh.37.1689968139289;
        Fri, 21 Jul 2023 12:35:39 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id p15-20020a170902e74f00b0019ee045a2b3sm3836250plf.308.2023.07.21.12.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:35:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qMvub-003IJe-Bf;
	Fri, 21 Jul 2023 16:35:37 -0300
Date: Fri, 21 Jul 2023 16:35:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu: Prevent RESV_DIRECT devices from blocking
 domains
Message-ID: <ZLreCUIJoo1TfmVz@ziepe.ca>
References: <20230713043248.41315-1-baolu.lu@linux.intel.com>
 <20230713043248.41315-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713043248.41315-2-baolu.lu@linux.intel.com>

On Thu, Jul 13, 2023 at 12:32:47PM +0800, Lu Baolu wrote:
> The IOMMU_RESV_DIRECT flag indicates that a memory region must be mapped
> 1:1 at all times. This means that the region must always be accessible to
> the device, even if the device is attached to a blocking domain. This is
> equal to saying that IOMMU_RESV_DIRECT flag prevents devices from being
> attached to blocking domains.
> 
> This also implies that devices that implement RESV_DIRECT regions will be
> prevented from being assigned to user space since taking the DMA ownership
> immediately switches to a blocking domain.
> 
> The rule of preventing devices with the IOMMU_RESV_DIRECT regions from
> being assigned to user space has existed in the Intel IOMMU driver for
> a long time. Now, this rule is being lifted up to a general core rule,
> as other architectures like AMD and ARM also have RMRR-like reserved
> regions. This has been discussed in the community mailing list and refer
> to below link for more details.
> 
> Other places using unmanaged domains for kernel DMA must follow the
> iommu_get_resv_regions() and setup IOMMU_RESV_DIRECT - we do not restrict
> them in the core code.
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/linux-iommu/BN9PR11MB5276E84229B5BD952D78E9598C639@BN9PR11MB5276.namprd11.prod.outlook.com
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h |  2 ++
>  drivers/iommu/iommu.c | 37 +++++++++++++++++++++++++++----------
>  2 files changed, 29 insertions(+), 10 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
