Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B13229
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 12:16:07 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id h130-20020a1c2188000000b003b4cadadce7so1208744wmh.3
        for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 05:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=V3njlNS/W1cnzODZRFa5ldtODvq/kS+YBNJviRrwzEI=;
        b=BuZ3ZD/Pl73AQge/vPuBk3J+Tt1Nv1H08VGJyH7deEcYuTJPiaGn/ZxCvWVGrGYcdv
         SWUBCiv0qqCrbgDCP1lX8iHvAsg/H2rRgYeePweCaq3SkWmyouj8BsVrGzVWm4Y2Fr+6
         Aeyc1A9ujj5xqn6ZDFtgpcEMcwaNJ4Pig/TCm5BLeRBm1pld4noyiZRouoWVJobJNyLW
         AQDbbAnprazhZVIdaQJ5YSrhmj4+LnFRQpUUVYzUnzIj83n9eoH1v978B09j+6CQLUUN
         3eCCC2cGv7lFse9cGUkE6ri7h9kUL1rV06u0LidrI4iPfr+S40VTl0tzQ06NzGxUalhf
         rEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=V3njlNS/W1cnzODZRFa5ldtODvq/kS+YBNJviRrwzEI=;
        b=WvaRCdhBrcquvW/DurxknOqDuAxgMV5QD1WDJG7z61Ko6VFNLF1AGNvVuwSzcpzXC6
         NUUB3CzcY3buWEyqX4h15+cFQw+ufjJTmyE+rwUHN6pWNDQDONKL7XFMiKYXONQfb7EH
         df5pkxKcjBtTihDyRN9A4H4bz/88iRF/L9BHmf+aMtXOYtp/QL4SDFmFePHkWLHbqvYY
         b4QoOBPL36Ps4BcVOd5fTWTToUEBI9bT5jNxqWusX1z37M+EzIsogz+pH3HWC3SMTfGY
         gyRR0tyfSTZVF+bP0SLsKORDCGuj5BJxQcpF8TbPB3Xc8dIb/rhJARHQ1RNlTwVGBkSR
         4Iuw==
X-Gm-Message-State: ACrzQf0MTxobRkA5ofuty+vXcXHHZIIiiILwjqYUcfP8DDTxjQaxvHD/
	qGt7ZFHxd+kpkRP1ykiNCJ0NXQ==
X-Google-Smtp-Source: AMsMyM4Ieaj6+pGd/A3oHY98mVdCpFlR7m+NIRzSX98hYMb5FVmrgWjR/KL5FJU8llftI4/QDVougQ==
X-Received: by 2002:a1c:2507:0:b0:3b3:3681:f774 with SMTP id l7-20020a1c2507000000b003b33681f774mr9393191wml.134.1663848966234;
        Thu, 22 Sep 2022 05:16:06 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c3b0700b003a2f2bb72d5sm7510389wms.45.2022.09.22.05.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 05:16:05 -0700 (PDT)
Date: Thu, 22 Sep 2022 13:16:01 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Liu Song <liusong@linux.alibaba.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu/virtio: __viommu_sync_req is no need to return
 a value
Message-ID: <YyxSAX9UpAyoq01y@myrica>
References: <1663845886-11341-1-git-send-email-liusong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663845886-11341-1-git-send-email-liusong@linux.alibaba.com>

Hi Liu,

On Thu, Sep 22, 2022 at 07:24:46PM +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> In "__viommu_sync_req", 0 is always returned as the only return value, no
> return value is needed for this case, and the processes and functions
> involved are adjusted accordingly.
> 
> Signed-off-by: Liu Song <liusong@linux.alibaba.com>

Thanks for the patch but I'd rather improve __viommu_sync_req() to handle
more errors. At the moment, if the virtqueue breaks then it spins
infinitely waiting for a host response. We should at least check the
return value of virtqueue_kick(), and maybe add a timeout as well although
I'm not sure which time base we can use reliably here.

Thanks,
Jean

> ---
>  drivers/iommu/virtio-iommu.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index b7c2280..fde5661 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -151,7 +151,7 @@ static off_t viommu_get_write_desc_offset(struct viommu_dev *viommu,
>   * Wait for all added requests to complete. When this function returns, all
>   * requests that were in-flight at the time of the call have completed.
>   */
> -static int __viommu_sync_req(struct viommu_dev *viommu)
> +static void __viommu_sync_req(struct viommu_dev *viommu)
>  {
>  	unsigned int len;
>  	size_t write_len;
> @@ -180,22 +180,15 @@ static int __viommu_sync_req(struct viommu_dev *viommu)
>  		list_del(&req->list);
>  		kfree(req);
>  	}
> -
> -	return 0;
>  }
>  
> -static int viommu_sync_req(struct viommu_dev *viommu)
> +static void viommu_sync_req(struct viommu_dev *viommu)
>  {
> -	int ret;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&viommu->request_lock, flags);
> -	ret = __viommu_sync_req(viommu);
> -	if (ret)
> -		dev_dbg(viommu->dev, "could not sync requests (%d)\n", ret);
> +	__viommu_sync_req(viommu);
>  	spin_unlock_irqrestore(&viommu->request_lock, flags);
> -
> -	return ret;
>  }
>  
>  /*
> @@ -247,8 +240,8 @@ static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
>  	ret = virtqueue_add_sgs(vq, sg, 1, 1, req, GFP_ATOMIC);
>  	if (ret == -ENOSPC) {
>  		/* If the queue is full, sync and retry */
> -		if (!__viommu_sync_req(viommu))
> -			ret = virtqueue_add_sgs(vq, sg, 1, 1, req, GFP_ATOMIC);
> +		__viommu_sync_req(viommu);
> +		ret = virtqueue_add_sgs(vq, sg, 1, 1, req, GFP_ATOMIC);
>  	}
>  	if (ret)
>  		goto err_free;
> @@ -293,11 +286,7 @@ static int viommu_send_req_sync(struct viommu_dev *viommu, void *buf,
>  		goto out_unlock;
>  	}
>  
> -	ret = __viommu_sync_req(viommu);
> -	if (ret) {
> -		dev_dbg(viommu->dev, "could not sync requests (%d)\n", ret);
> -		/* Fall-through (get the actual request status) */
> -	}
> +	__viommu_sync_req(viommu);
>  
>  	ret = viommu_get_req_errno(buf, len);
>  out_unlock:
> -- 
> 1.8.3.1
> 
