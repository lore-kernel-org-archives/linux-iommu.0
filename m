Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED3AD30
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 13:22:38 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id l2so8644151qtq.11
        for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 05:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lh8kCd+TI/xMEHQ4yRh0KMNGAg8os9nKv0lKY/zh0Go=;
        b=LVZKY8SfY9u6FcTa9AD6FwFlVb/vZp2aVm4cbxICKH7kGpqhTxBSXHiwM7qAKvGpLh
         xN4aPKGNLPzRlvSnd2EUFrpip10r9/Q0aRRlyZsKLi5lykehd1uk/INit1NnAeCAqpwg
         I1xHTItK5QlilorDD0tu9a6PLz0bsDW2dt66QQd6qKFByK2VXY/zirFvHK2FuV6RWci/
         kSeski+7K5DoBpqI3eJZ9wwj8xPAWCXfLNc6wqfYpvwS/jP+v0GQbT2tKO7uxCM4m6Lj
         14fv+0mx4Ou+ZyF4MQ3HBOV+L7aaHFh2e2myIzi1l5pOAMy4mw4Bl0xTpB1yUAKRDFwv
         eGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lh8kCd+TI/xMEHQ4yRh0KMNGAg8os9nKv0lKY/zh0Go=;
        b=50kYogOuYNSAzW3Igh8Vi76Jlz5J5YOGE7/ln9gQgmktStHx3Ms+2pu6zewt+BoPyG
         HWdDwOPjv1fXkIzlkgyhE3rxSit7RkMfrgoJbC42l3eS7ARHvuzREyTKUGlMZc5RHYM3
         NXL/i2bxBPCQD5mn3vunp5zUWx+Jhsbv/nJSxdZtinv8e/u/tJmZQIwTfrsBIokS94cU
         PtPsr38uvg3YQrK7uu/3Cya2iB7KHEfQRyS764O7bz5O1V34jc+rC7gwAfsbfi1EuFxZ
         rOYUIQMxXtG8LeRxydwwde16s5vVDZSO5d9Q3LOaJh5fOOhjknuctpMerAspDctWJXN9
         ifZw==
X-Gm-Message-State: ANoB5pl/HveGVnJfSWwD0mXDzOr2+v6DYZVyENOkUXgaz2kxlLdZFyF1
	YhFhzaJLGLBz7GOU+/eQi8vZZbH9/ednfg==
X-Google-Smtp-Source: AA0mqf4gFHMBOCd+hxMH99i63M4A4Zz5W56sVQvjZOTc2gLX9kTF10IvIhipJtAr6YKEO2g7ttTAtw==
X-Received: by 2002:ac8:44c4:0:b0:3a5:8b71:cca3 with SMTP id b4-20020ac844c4000000b003a58b71cca3mr16457992qto.292.1668518557368;
        Tue, 15 Nov 2022 05:22:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id i19-20020a05620a249300b006fb38ff190bsm8047711qkn.34.2022.11.15.05.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:22:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ouvtb-003s6G-OY;
	Tue, 15 Nov 2022 09:22:35 -0400
Date: Tue, 15 Nov 2022 09:22:35 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Carpenter <error27@gmail.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommufd: vfio: info leak in iommufd_vfio_unmap_dma()
Message-ID: <Y3OSm9dmaQJkjL6D@ziepe.ca>
References: <Y3OKdW/WXVr1VYbc@kili>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3OKdW/WXVr1VYbc@kili>

On Tue, Nov 15, 2022 at 03:47:49PM +0300, Dan Carpenter wrote:
> If iopt_unmap_iova() fails then "unmapped" is uninitialized.  Copying it
> to the user can leak stack information.
> 
> Fixes: 32c328dc9b73 ("iommufd: vfio container FD ioctl compatibility")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/iommu/iommufd/vfio_compat.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/vfio_compat.c b/drivers/iommu/iommufd/vfio_compat.c
> index 976aa12b247d..30a13552d632 100644
> --- a/drivers/iommu/iommufd/vfio_compat.c
> +++ b/drivers/iommu/iommufd/vfio_compat.c
> @@ -189,6 +189,9 @@ static int iommufd_vfio_unmap_dma(struct iommufd_ctx *ictx, unsigned int cmd,
>  		rc = iopt_unmap_iova(&ioas->iopt, unmap.iova, unmap.size,
>  				     &unmapped);
>  	}
> +	if (rc)
> +		goto err_put;
> +

It should be inited to 0, I fixed it, thanks

Jason
