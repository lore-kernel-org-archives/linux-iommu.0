Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6C5C90
	for <iommu@lists.linux.dev>; Tue,  9 Aug 2022 07:20:52 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id v3so13384574wrp.0
        for <iommu@lists.linux.dev>; Tue, 09 Aug 2022 00:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nDZGjC3d6RgPiYxCgLnPjqhoXy38nST01tp2NFMdLgY=;
        b=xN4KUUb5LpDRsXDr3lg6VqfiiGJiAKnuy4OZkG8jx1/2Heekel3ys6nLkYYNoK6MiQ
         tEBcu5S5opzm2fPc+3FFmoClgEfRYpsvPM2BKrPp6quT426U1LXghDTLf2eSzG8FKRPU
         7jkicc6XssGkFQRU3KtP4P4Gju3ebDqXaqouM/CCZPp07GXJTXx9b+mC0puznB4+DTqN
         Ld8RB/cqU2XQ/R78lAQg/0oZRszHYNaJEEtWvc5nF35NISlUXUEmC51qfir5OeO2srFJ
         m5FXiL/1kSfn+poFKNQHXg1kTunibiDTeqMn9+YsCithA3QLL4lyGOtIs6HdZryQCWP7
         NccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nDZGjC3d6RgPiYxCgLnPjqhoXy38nST01tp2NFMdLgY=;
        b=YjbH6zN3fiCrMrbIiQWWrmhywk8y5XEkjSidUZQb/t2bNi2FlCA7V/zs94kwRHikAJ
         onhdIUstkaBsyTNxw5VIV2DClxbrfL2jI9DCYXdrA18g/hhbIrUctpaykq2hp3pmvxGT
         1GwheaTEB7YZZft9LUKINK6mBIpi6wYpEae2ioGw0Q5S7zWBeJx1rpoH8nys4vX5NOAG
         WguAhFPkNbImB1S8nLbf/1wVezHn4CLqKEfJi94XkFyg1OD5CZmrOWidchKFp0Wiqvq1
         jl7n3ZlY9l/EDqRcSXNxYt1zBvGqA0NZzM8AMWDlOhoQksOWlw8v7sDwckRahamauebZ
         kP/A==
X-Gm-Message-State: ACgBeo3+0TNesF7llDPkBNfFUN8d8kRTg6n1LhQisfY7e6pNKBKUb7ee
	n2csX1jnefoDGRyNbFFT96f4Kg==
X-Google-Smtp-Source: AA6agR6QHnlDD3qjHO/gSC+OOdUtehf/UYh9OOQN8/22GLn0m55iV4WWOcGucEL0AAtwWiy4oMW0jw==
X-Received: by 2002:adf:d1c1:0:b0:220:5ec3:fb62 with SMTP id b1-20020adfd1c1000000b002205ec3fb62mr13237098wrd.69.1660029650688;
        Tue, 09 Aug 2022 00:20:50 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b003a2d47d3051sm17651203wmr.41.2022.08.09.00.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 00:20:50 -0700 (PDT)
Date: Tue, 9 Aug 2022 08:20:48 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joerg Roedel <jroedel@suse.de>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v1 1/1] iommu/virtio: Do not dereference fwnode in struct
 device
Message-ID: <YvIK0KMi1yECL9vc@myrica>
References: <20220801165142.20898-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801165142.20898-1-andriy.shevchenko@linux.intel.com>

On Mon, Aug 01, 2022 at 07:51:42PM +0300, Andy Shevchenko wrote:
> In order to make the underneath API easier to change in the future,
> prevent users from dereferencing fwnode from struct device.
> Instead, use the specific device_match_fwnode() API for that.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 08eeafc9529f..9fe723f55213 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -925,7 +925,7 @@ static struct virtio_driver virtio_iommu_drv;
>  
>  static int viommu_match_node(struct device *dev, const void *data)
>  {
> -	return dev->parent->fwnode == data;
> +	return device_match_fwnode(dev->parent, data);
>  }
>  
>  static struct viommu_dev *viommu_get_by_fwnode(struct fwnode_handle *fwnode)
> -- 
> 2.35.1
> 
