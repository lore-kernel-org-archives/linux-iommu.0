Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF37880A
	for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 21:00:30 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id o5so11367021qtr.11
        for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 13:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXDL5RuH8txeRC32pIrNwcID1tphIyL0d4ewJC29Z2k=;
        b=Jp7IYY9SFAf0Bb7VotdhTUvYg7B6B0cvQHe4FKQX6C3QHoscsyLUJz0f2xvjeftLZV
         5JeCwh27TIPuUoaoS51XmkfP1mxlhfXH7KXMC3cYG2JDqJrsZ1XzsuVDrQXRoT+X+g9d
         tWq1eep+fLdZyB95A8ZGYK3YxzWMIP4hvefJ4GISVx72x5PiKeyZaMF7zDDElCerPNpD
         ZuWXabLdyaH+1E00GRrb2ydrVguomBAn0izjQDmw8IO1P4p1RWN3M77BUxuVVUbNHnp+
         PJ3VibU5aXiqbu3hIIsKZY5sgkajitLLCW9gvb6CAv9A0K0SMh/4/hI0iH20gFgIS0X2
         Ofgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXDL5RuH8txeRC32pIrNwcID1tphIyL0d4ewJC29Z2k=;
        b=37HI41UGeTQV4SawkOLt0gbttVs2T0bqAFo7zxXktUBsjriGBcfSmr17UPcrXVlh8I
         qwWfQbjsbe6r6Dm/+aHMPhDEVkG3uIUhTmi+3e7ch5NpL8OEXkYWUKf2O37NDTQ7QTFw
         46+l2LjKjj78qtyoDTeck2XiSt1a9PMK2RJqA97pzuC/7DlthA0R6sySEnthSuiKRtKh
         ot9aXD0+8el6LA6WFHnmc2m6dGJqxsF69drMI1D1e9HLN5jFQcCBPcqmEg3RkUu256kM
         cjnQgXTuNtH177XnZSED0BKaTOrGl0Uk9CyZganPVjNJQ1eEqGYqxV+aLBMYxuxey9v/
         UOEA==
X-Gm-Message-State: AFqh2kqxsj4NbaHeHFf1YCgai6YvY3b0HHwATNonwVwLyJNt12fy++r+
	LDtetoAYIvY10KD1imiTwP6toPk0858IGycM
X-Google-Smtp-Source: AMrXdXvk0lKk3hog7WDGIvJKXmhpeR0Oamsk2YOzXOrJOL5dD26wKyjUmFgat09PiP8CQ1mRLtE3MQ==
X-Received: by 2002:ac8:760b:0:b0:3ac:7f6b:ed11 with SMTP id t11-20020ac8760b000000b003ac7f6bed11mr35732463qtq.15.1674507629037;
        Mon, 23 Jan 2023 13:00:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id r3-20020ac87943000000b003a82562c90fsm11274878qtt.62.2023.01.23.13.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:00:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pK3vX-00GND6-C4;
	Mon, 23 Jan 2023 17:00:27 -0400
Date: Mon, 23 Jan 2023 17:00:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	lim Akhtar <alim.akhtar@samsung.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/exynos: add missing set_platform_dma_ops callback
Message-ID: <Y871a3elCP1gmPQi@ziepe.ca>
References: <CGME20230123093116eucas1p19b8fe8afc4b631debbdc5321c53009e9@eucas1p1.samsung.com>
 <20230123093102.12392-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123093102.12392-1-m.szyprowski@samsung.com>

On Mon, Jan 23, 2023 at 10:31:01AM +0100, Marek Szyprowski wrote:
> Add set_platform_dma_ops() required for proper driver operation on ARM
> 32bit arch after recent changes in the IOMMU framework (detach ops
> removal).

Thanks for looking into this!

Can you explain more about how this actually solves the problem in the
commit message? I don't get it.

> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 6fc58e89712f..c4955d045855 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1346,8 +1346,10 @@ static void exynos_iommu_release_device(struct device *dev)
>  		struct iommu_group *group = iommu_group_get(dev);
>  
>  		if (group) {
> +#ifndef CONFIG_ARM
>  			WARN_ON(owner->domain !=
>  				iommu_group_default_domain(group));
> +#endif
>  			exynos_iommu_detach_device(owner->domain, dev);
>  			iommu_group_put(group);
>  		}
> @@ -1398,6 +1400,9 @@ static int exynos_iommu_of_xlate(struct device *dev,
>  static const struct iommu_ops exynos_iommu_ops = {
>  	.domain_alloc = exynos_iommu_domain_alloc,
>  	.device_group = generic_device_group,
> +#ifdef CONFIG_ARM
> +	.set_platform_dma_ops = exynos_iommu_release_device,
> +#endif

This is ugly, if you need a set_platform_dma_ops it should not be
called release... Release is supposed to be about putting the HW back
to some idle state because we are unplugging the struct device.

Jason
