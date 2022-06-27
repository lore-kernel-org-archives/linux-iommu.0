Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F192CA2
	for <iommu@lists.linux.dev>; Mon, 27 Jun 2022 13:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C841EC3411D;
	Mon, 27 Jun 2022 13:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1656336119;
	bh=E1q1+oBwOrnDHyb2Ekxn6ULxemjx+uZKthjCDjiYI38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tK2eCWySAeRn2bVVsb40r2/51hQYbCOiWnET4CRa3SAB1XqLrGCcaBonuxa59EwsN
	 iQA/IV2qXZKBNb63s2aVIYXKMbnDnP6wDfnUcxu3muWhENpg+LLfr+X3rY7zSrve/8
	 biw0OMZBwYYjK2nyCOaTImriODMYpAp7xm/fXv8w=
Date: Mon, 27 Jun 2022 15:21:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
	jean-philippe <jean-philippe@linaro.org>,
	Wangzhou <wangzhou1@hisilicon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, acc@openeuler.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	iommu@lists.linux.dev, Yang Shen <shenyang39@huawei.com>
Subject: Re: [PATCH v2 1/2] uacce: Handle parent driver module removal
Message-ID: <Yrmu9DcNObmraG72@kroah.com>
References: <20220624142122.30528-1-zhangfei.gao@linaro.org>
 <20220624142122.30528-2-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624142122.30528-2-zhangfei.gao@linaro.org>

On Fri, Jun 24, 2022 at 10:21:21PM +0800, Zhangfei Gao wrote:
> Change cdev owner to parent driver owner, which blocks rmmod parent
> driver module once fd is opened.
> 
> Signed-off-by: Yang Shen <shenyang39@huawei.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/misc/uacce/uacce.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 281c54003edc..f82f2dd30e76 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -484,7 +484,7 @@ int uacce_register(struct uacce_device *uacce)
>  		return -ENOMEM;
>  
>  	uacce->cdev->ops = &uacce_fops;
> -	uacce->cdev->owner = THIS_MODULE;
> +	uacce->cdev->owner = uacce->parent->driver->owner;

What if parent is not set?  What if parent does not have a driver set to
it yet?  Why would a device's parent module control the lifespan of this
child device's cdev?

This feels wrong and like a layering violation here.

If a parent's module is unloaded, then invalidate the cdev for the
device when you tear it down before the module is unloaded.

Yes, the interaction between the driver model and a cdev is messy, and
always tricky (see the recent ksummit discussion about this again, and
last year's discussion), but that does not mean you should add laying
violations like this to the codebase.  Please fix this properly.

thanks,

greg k-h
