Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9536129
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 14:40:52 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6bb231f1817so1515021a34.3
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690555251; x=1691160051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gevcktEXf4pEg6WG5LHFmQfcd/6S+14lFG1GbMSZ6Nc=;
        b=edxaKNCxxL51fskf1Ji3HNpd7GuxFoKyFC/Ao2AfLrUeqo+laXYbBjb9jCMBSA0Shp
         h03RkxIxzzNjjYENo9ulm1POUn1bLYYZMP9GumWpwFtkBCshn2DM6vzAAVuIpw5enQub
         vJWZ7WfZVZZ4I5TqDEHjGHyKHY2z+Y1o+roCJrfKrCniNJIN3QwSS5k2CLludZx3Gqe2
         RaV6Kus7ocJd+eR4TLtcuSlW60m021A8kYN2OpbRg+65Eubv8U2iJ7BE+i9SPbfiYaQC
         Wn4fdkyD0Yy73TVuIn62ZUkb9rNSejcbViqSZzPphYLS8lsrgabPQj2Oh2K6/86n7GWe
         6s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690555251; x=1691160051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gevcktEXf4pEg6WG5LHFmQfcd/6S+14lFG1GbMSZ6Nc=;
        b=FZokFg457O2BE5WkFQURBP2hlRmeiIOWzCtHpOzzOulU0hvTId8uLSXg/HKW6Tzaa2
         YRCXA831pHmkec2suKLeqA4p6QHH7/IUSDothDgK2wFXrApIIXlGzLs0DZupxpGAGh89
         iVl4Gd+SL9KnlZTZKLXAt0TOBQOH8V+B5jDqEHTPvPIn1xA22ewdGyd1Dn2CJb/4DHRM
         PXaxQLaYJ7CbYwVTNxKfS9cgVKCK+yK710m2V6NZnW6Kc43m3dwTjaWefIP5s6qso2CJ
         bKqN9TnPwHmtnl7cu2SNXg5Mm4XciG+L/vVOYXVDH0ZMrlaTwsH5rSt2IJobdVQKg6mH
         nYOw==
X-Gm-Message-State: ABy/qLY2Mxw3GXQQ+VATC+Z9FH5bON/jttEEK3Ay/bsAtJeJPZe959jC
	pW8v7X7Cc0BB/z9FOBc9nNwZ9g==
X-Google-Smtp-Source: APBJJlHg0QdZj/prZoEGnBR1+AUt5lLqNAHVk3xbwU0pufZ/isSz70SlQTP+xGkeyPbrAywpWFHArw==
X-Received: by 2002:a9d:7a84:0:b0:6b7:2515:e214 with SMTP id l4-20020a9d7a84000000b006b72515e214mr2568691otn.34.1690555251360;
        Fri, 28 Jul 2023 07:40:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g15-20020a63be4f000000b0055c3e8c922dsm3271577pgo.90.2023.07.28.07.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:40:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPOe9-001buN-Ht;
	Fri, 28 Jul 2023 11:40:49 -0300
Date: Fri, 28 Jul 2023 11:40:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 14/16] iommu/amd: Enable device ATS/PASID/PRI
 capabilities independently
Message-ID: <ZMPTcXZUjkTkIUhT@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-15-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-15-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:36:07AM +0000, Vasant Hegde wrote:
> Introduce helper functions to enable/disable device ATS/PASID/PRI
> capabilities independently along with the new pasid_enabled and
> pri_enabled variables in struct iommu_dev_data to keep track,
> which allows attach_device() and detach_device() to be simplified.
> 
> Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |   4 +
>  drivers/iommu/amd/amd_iommu_types.h |   2 +
>  drivers/iommu/amd/iommu.c           | 203 ++++++++++++++++------------
>  3 files changed, 120 insertions(+), 89 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
