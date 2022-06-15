Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C147EC43334
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 15:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EFDA83DFC;
	Wed, 15 Jun 2022 15:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MTbASizeou99; Wed, 15 Jun 2022 15:16:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2A3518316A;
	Wed, 15 Jun 2022 15:16:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00E92C0039;
	Wed, 15 Jun 2022 15:16:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94A1AC002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 15:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90E8440181
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 15:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ticWaWDhxaDE for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 15:16:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82FED40169
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 15:16:29 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 c130-20020a1c3588000000b0039c6fd897b4so1325982wma.4
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Wau0fGW8yZsKjnuoyb0VTR4qVyMVH48h3qQAcCmJxHM=;
 b=gsDwJdxlq2oa/E5drVyaHd8AqIB5EsHJGZX+yJs4Bh3IZRZWhyJg1tzAiW9vxJl9/Q
 I6bZWcAHui00mntM2ACoE/BL7ZEWL8139NyKHCSm8617afMK4Qeclks5GiCSExeiU6QX
 YOaHEWYs3I3Hy3jaUMZzD7qnubmVcnZR/NDqb/+uIGuUaw2hDDyLoyP5qkD1GvKWhAUq
 D1AXeoyOXog3gnba1I1g82Fzhom0FNx8iA6Uw1p3+kcd+hf9bvi1GtqbfUn9njQEvqDm
 FiY1W9rhvE/Z600Vn+e3KWPJ+NcO0SSJof7Hrm/ZFynpXA4M3t1Sc0kVO+U1Gzj+5tOg
 l9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Wau0fGW8yZsKjnuoyb0VTR4qVyMVH48h3qQAcCmJxHM=;
 b=IvadpBHG9bA2hiFv46Fr8ponG57GOXDMTrlidv4uIpGH9RZvEt7lmXAtIi4WWPNexd
 Nv09IVhfy7+3rDTMAXvYysWMJs9+US3s/XXicA5f2WPptduimuIZ2yf0ZSregVU4abNs
 Netdhpn1e26g7XLlPwbXZre8p64KQslwR0lOiRe0TJZf1RyY/xqYoaM1NDiWzWVSvQjn
 FXxGdZWGX518dYn6ab1/RsBfoh3prMZ88hGffMhSCNaov76lzseMzi85jN5G3EioFjUD
 wUgI3JOfbO2axdOxaAHU3ELocvRMFqm7Ws4b4E+Y/nlY+0YJGFjy5K7k46qUVHkPUZ/7
 J0xA==
X-Gm-Message-State: AJIora+MMt0SwKbRBkvaqoALjyRQCwMXDFTKgUcEP+a//t31TXqsQinI
 ewE3ryQK7tl1CzlpLBdAGMIKGQ==
X-Google-Smtp-Source: AGRyM1vZvWOxzMMfyRsf49tj6gKTfsbDDI74LUEsue+sAc2CHuDIhWC6vvd1UMApy4oTjuKCS103AA==
X-Received: by 2002:a1c:29c1:0:b0:39d:86c0:3ece with SMTP id
 p184-20020a1c29c1000000b0039d86c03ecemr9939wmp.138.1655306187683; 
 Wed, 15 Jun 2022 08:16:27 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 q16-20020a5d5750000000b0020e63ab5d78sm14781591wrw.26.2022.06.15.08.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jun 2022 08:16:26 -0700 (PDT)
Date: Wed, 15 Jun 2022 16:16:02 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
Message-ID: <Yqn3spLZHpAkQ9Us@myrica>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220610123423.27496-1-zhangfei.gao@linaro.org>
Cc: Yang Shen <shenyang39@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, linux-accelerators@lists.ozlabs.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On Fri, Jun 10, 2022 at 08:34:23PM +0800, Zhangfei Gao wrote:
> The uacce parent's module can be removed when uacce is working,
> which may cause troubles.
> 
> If rmmod/uacce_remove happens just after fops_open: bind_queue,
> the uacce_remove can not remove the bound queue since it is not
> added to the queue list yet, which blocks the uacce_disable_sva.
> 
> Change queues_lock area to make sure the bound queue is added to
> the list thereby can be searched in uacce_remove.
> 
> And uacce->parent->driver is checked immediately in case rmmod is
> just happening.
> 
> Also the parent driver must always stop DMA before calling
> uacce_remove.
> 
> Signed-off-by: Yang Shen <shenyang39@huawei.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/misc/uacce/uacce.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 281c54003edc..b6219c6bfb48 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -136,9 +136,16 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
>  	if (!q)
>  		return -ENOMEM;
>  
> +	mutex_lock(&uacce->queues_lock);
> +
> +	if (!uacce->parent->driver) {

I don't think this is useful, because the core clears parent->driver after
having run uacce_remove():

  rmmod hisi_zip		open()
   ...				 uacce_fops_open()
   __device_release_driver()	  ...
    pci_device_remove()
     hisi_zip_remove()
      hisi_qm_uninit()
       uacce_remove()
        ...			  ...
   				  mutex_lock(uacce->queues_lock)
    ...				  if (!uacce->parent->driver)
    device_unbind_cleanup()	  /* driver still valid, proceed */
     dev->driver = NULL

Since uacce_remove() disabled SVA, the following uacce_bind_queue() will
fail anyway. However, if uacce->flags does not have UACCE_DEV_SVA set,
we'll proceed further and call uacce->ops->get_queue(), which does not
exist anymore since the parent module is gone.

I think we need the global uacce_mutex to serialize uacce_remove() and
uacce_fops_open(). uacce_remove() would do everything, including
xa_erase(), while holding that mutex. And uacce_fops_open() would try to
obtain the uacce object from the xarray while holding the mutex, which
fails if the uacce object is being removed.

Thanks,
Jean

> +		ret = -ENODEV;
> +		goto out_with_lock;
> +	}
> +
>  	ret = uacce_bind_queue(uacce, q);
>  	if (ret)
> -		goto out_with_mem;
> +		goto out_with_lock;
>  
>  	q->uacce = uacce;
>  
> @@ -153,7 +160,6 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
>  	uacce->inode = inode;
>  	q->state = UACCE_Q_INIT;
>  
> -	mutex_lock(&uacce->queues_lock);
>  	list_add(&q->list, &uacce->queues);
>  	mutex_unlock(&uacce->queues_lock);
>  
> @@ -161,7 +167,8 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
>  
>  out_with_bond:
>  	uacce_unbind_queue(q);
> -out_with_mem:
> +out_with_lock:
> +	mutex_unlock(&uacce->queues_lock);
>  	kfree(q);
>  	return ret;
>  }
> @@ -171,10 +178,10 @@ static int uacce_fops_release(struct inode *inode, struct file *filep)
>  	struct uacce_queue *q = filep->private_data;
>  
>  	mutex_lock(&q->uacce->queues_lock);
> -	list_del(&q->list);
> -	mutex_unlock(&q->uacce->queues_lock);
>  	uacce_put_queue(q);
>  	uacce_unbind_queue(q);
> +	list_del(&q->list);
> +	mutex_unlock(&q->uacce->queues_lock);
>  	kfree(q);
>  
>  	return 0;
> @@ -513,10 +520,10 @@ void uacce_remove(struct uacce_device *uacce)
>  		uacce_put_queue(q);
>  		uacce_unbind_queue(q);
>  	}
> -	mutex_unlock(&uacce->queues_lock);
>  
>  	/* disable sva now since no opened queues */
>  	uacce_disable_sva(uacce);
> +	mutex_unlock(&uacce->queues_lock);
>  
>  	if (uacce->cdev)
>  		cdev_device_del(uacce->cdev, &uacce->dev);
> -- 
> 2.36.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
