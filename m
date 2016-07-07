From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH -next] iommu/exynos: Fix return value check in
 exynos_iommu_of_setup()
Date: Thu, 07 Jul 2016 11:34:43 +0900
Message-ID: <20160707023443.GF23620@samsunx.samsung>
References: <1467807354-26503-1-git-send-email-weiyj_lk@163.com>
 <CGME20160706131005epcas1p2f8c6a70cbacbcdeb3e5293f37b0140ce@epcas1p2.samsung.com>
 <577D0316.1050502@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <577D0316.1050502@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: weiyj_lk@163.com, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene@kernel.org>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi,

just a question,

> >  	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
> > -	if (IS_ERR(pdev))
> > -		return PTR_ERR(pdev);
> > +	if (!pdev)
> > +		return -ENOMEM;
> >  
> >  	/*
> >  	 * use the first registered sysmmu device for performing
> > 
> 

is ENOMEM the right return value? of_platform_device_create()
doesn't fail only in case of malloc failure.

Shouldn't it be ENODEV instead, which might also mean with some
imagination that there is no memory available for that device?

Thanks,
Andi

> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
