Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F96214F92
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 14:06:30 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1bb84194bf3so27642065ad.3
        for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690812389; x=1691417189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pa7cGW4W/MPG9hUL3P5hpU5weF7Rx+d0K7w3Fuzzs3Q=;
        b=L7ITYL7P+uulwVwJKluiZuJDAzsahWD8bgS3HSZYmiLOaBFxE1Og6cj835CgFjBS/y
         grgwLozwC5FnWfu86rN6CePl6XVxOxP3oCH/23hOr95KV/3WpAar+71MquAVb/B9s1rr
         9yxpFGVdxaRHrB9hxL0fvekzYqX3bD6AALwWrUrx2LiSxiuxVg934jL0ZW2bO97c7n8k
         g/ksCDu/trk90AkszU1ndDtOSFutlbjOAQ3JrSoma0otc0QCwR4WWQiok85GtmCFK49U
         zEsu6XXIQq7rKXxR/XK65eLzfA6IWXPeJTwSxAN7CUF2EjJ4l/++o77YG2OiX4QN5dxr
         FbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690812389; x=1691417189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pa7cGW4W/MPG9hUL3P5hpU5weF7Rx+d0K7w3Fuzzs3Q=;
        b=AJ+KN3yVrTiZw5RDIwDuAVkgLOFf+yroINbL545wTvrvcd05A8GRhboTXnLx+HCAyv
         uxJw+BTxO059ZU5AMlR1y4C5lrEScqBovsMCjnD+mi494tWp10OfpQpKWbWof7wXsIHm
         pQqoKBaKFT4+NH7B+H/dpt7idz27Km1UAxXBy2HgiMRQrmeI0o4ymr6HkTjJpSj84YcO
         i9jGc1YRenM0h3QJaqATMGJzuBazh76pLXHK0NFx5yWQram71w10aBLKI1wy/adfoLFX
         pEYzveAmo2nXTPUKfn3TW9N6q3glhGaAraZd57wWB9HD/Gz00OL7JOhHW6M8ZhiUQM/w
         8VZg==
X-Gm-Message-State: ABy/qLYEEIvIkaDjRUnQjHLJUGHanP/SCXyMVOsKa6mTpaP0Ir0/wAqt
	INe2EmXqIi/24T89bEGNJxBB3Q==
X-Google-Smtp-Source: APBJJlGDrATk6TUeAu/hcMxCnFgiOv98ZsTHWO06QWyCLO3wNbryUeWdtSWMBOc/zzhkpkxGEvO5AQ==
X-Received: by 2002:a17:902:e551:b0:1bb:a125:f831 with SMTP id n17-20020a170902e55100b001bba125f831mr11941624plf.58.1690812389487;
        Mon, 31 Jul 2023 07:06:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902ead100b001b8b07bc600sm8610330pld.186.2023.07.31.07.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 07:06:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qQTXV-002U6x-7Z;
	Mon, 31 Jul 2023 11:06:25 -0300
Date: Mon, 31 Jul 2023 11:06:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhu Wang <wangzhu9@huawei.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev
Subject: Re: [PATCH -next] iommu: remove kernel-doc warnings
Message-ID: <ZMe/4UNOq9LnKGcZ@ziepe.ca>
References: <20230731112758.214775-1-wangzhu9@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731112758.214775-1-wangzhu9@huawei.com>

On Mon, Jul 31, 2023 at 07:27:58PM +0800, Zhu Wang wrote:
> Remove kernel-doc warnings:
> 
> drivers/iommu/iommu.c:3261: warning: Function parameter or member 'group'
> not described in 'iommu_group_release_dma_owner'
> drivers/iommu/iommu.c:3261: warning: Excess function parameter 'dev'
> description in 'iommu_group_release_dma_owner'
> drivers/iommu/iommu.c:3275: warning: Function parameter or member 'dev'
> not described in 'iommu_device_release_dma_owner'
> drivers/iommu/iommu.c:3275: warning: Excess function parameter 'group'
> description in 'iommu_device_release_dma_owner'
> 
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
> ---
>  drivers/iommu/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Fixes: 89395ccedbc1 ("iommu: Add device-centric DMA ownership interfaces")

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
