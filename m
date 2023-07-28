Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7487113AD8
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 14:24:49 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-267f870e6ffso1287831a91.0
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690554288; x=1691159088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4C4EfRRC5UQuATdElBoLpFdC5Mo3mnnoF/3+cpkB0I=;
        b=cdsjFJHEijP5TsowhzD4xFiVLskXYQzyHwlrQeGuvnwIjhUuA9i5h8p+4bC1aVlGbG
         ARaZFWT5vsY8BvBIWKzxA4txx+ZI55UMYLvOzDX2EPf7BB7w4evpniB1O96XrFBvwnwP
         eX+ogicu26HdQA5L6rBqtEwbaH9F+lQnIHKH4wxB5G8FxaoBUbkD6U/j5chPC7bJM2B3
         ff0XgsUOODZ2CzN1RoCtVDyQ8KF9M8aZUEaHvuHwBMqzqzY4mYzzGd74o+dpNVcA/y8s
         koFL6pDJcB5Vw/K9mOKPeH8+QxMxAjfUhTuXgeM/tVRc+JQtulI009ZgXhQUy8SSv1SM
         fquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690554288; x=1691159088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4C4EfRRC5UQuATdElBoLpFdC5Mo3mnnoF/3+cpkB0I=;
        b=VNS09SvnVz+agzyFk8yDQOWF7AfoConAUuOUwUZc9H38BOUJfqoI77FY4C7533aw3d
         eG/LE7demUke+tsbqO+jyTqxI5VpimT1y3evbCosqTnjAdmjOcUIcO+RT047qv+QZjCu
         sYhUwXan851Fc+tBraMr2h1qMs+uTfkds0CCb/rLxymQ8S0QxZK/puAkL7y2kGuzScrE
         G5g8xJ/AqjNOHB44AhfTZfQ+0by9ZOhfPs9VBJAuILIR/HrK6Q2/NjqXi4Z206r+SVdr
         aygK1O8VNQIYXNMqcGtuAyr6G1puifQYDbdwITKZlRK2QiAawStL++eyWE407qffjdHY
         Tr7g==
X-Gm-Message-State: ABy/qLYxkd0rM7qp+TvkzPOy3D7Uf9N/ohsZkthx4PWEkW38GSaMAkAE
	Il9JkJohTieJfPMIhOwGXhl6Yg==
X-Google-Smtp-Source: APBJJlEt7z+AlIT0iKPlfrdVVtdCCgbUBTsiv9IyCw57j06mvyc497u5ThQH//5dAokPZpdwAdNfKA==
X-Received: by 2002:a17:90b:4a8b:b0:260:e256:27c7 with SMTP id lp11-20020a17090b4a8b00b00260e25627c7mr1599480pjb.15.1690554288560;
        Fri, 28 Jul 2023 07:24:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id jm16-20020a17090304d000b001b3ce619e2esm3650922plb.179.2023.07.28.07.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:24:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPOOc-001bkr-K1;
	Fri, 28 Jul 2023 11:24:46 -0300
Date: Fri, 28 Jul 2023 11:24:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 10/16] iommu/amd: Modify logic for checking GT and PPR
 features
Message-ID: <ZMPPrkzm7KnxzLV1@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-11-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-11-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:36:03AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> In order to support v2 page table, IOMMU driver need to check if the
> hardware can support Guest Translation (GT) and Peripheral Page Requet
> (PPR) features. Currently, IOMMU driver uses global (amd_iommu_v2_present)
> and per-iommu (struct amd_iommu.is_iommu_v2) variables to track the
> features. There variables area redundant since we could simply just check
> the global EFR mask.
> 
> Therefore, replace it with a helper function with appropriate name.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       | 11 +++++++++++
>  drivers/iommu/amd/amd_iommu_types.h |  9 ++++-----
>  drivers/iommu/amd/init.c            | 14 +-------------
>  drivers/iommu/amd/iommu.c           |  2 +-
>  4 files changed, 17 insertions(+), 19 deletions(-)

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a0b0deb6fbcb..1f707944b23f 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -392,7 +392,7 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
>  	 */
>  	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
>  	    dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
> -		dev_data->iommu_v2 = iommu->is_iommu_v2;
> +		dev_data->iommu_v2 = amd_iommu_gt_ppr_supported();

This doesn't make alot of sense to me, we should not have global
functions and data in drivers. In this case I would expect the driver
to consult the amd_iommu linked to the struct device it is working on
to determine the capability.

Eg just directly test:

	iommu_feature(iommu, FEATURE_GT) && iommu_feature(iommu, FEATURE_PPR)

And remove all the other copies of the iommu_v2

And arguably this can (eventually) be defered to an attach that
requires the gcr3 table.

Also, if the gcr3 table is supported or not should be entirely up to
the HW, policy inputs like "iommu_default_passthrough" and
"force_isolation" are nonsensical here..

Looking in the history this looks like a bodge to cover up the domain
type mismatch during allocation. We need to get to a point where the
device is known during domain allocation so the driver can provide a
v2 page table if the device could possibly use PASID and remove all
this hackery.

Jason
