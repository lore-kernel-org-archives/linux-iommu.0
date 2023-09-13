Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B5E9472
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 14:42:06 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-64b3504144cso38193706d6.2
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 07:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694616126; x=1695220926; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TLMIm80/NqMAwUtQeNK/AozzxGhvlZkC/vnttV9OljA=;
        b=BrldP/FhGVPuRgLTj/Orf7O3uGNG4c3rPfzSvPrcxULB6CRlKfuotYY9Sah0Mstylv
         G7Gdopxnmb3iyEt+sGJXSl5qs/XALnaL84aG5Vo3cQd7gIuEhAGKp99wS+oR95cspBB+
         tLqvg6iJqNYL4YZ7wP3B0muOxZ3lR6t5g7M/A2d6hrggwNGqAX8YN/TUWogNpbD7LcqN
         PRavRP2PUG40gkKNHFE0KXTJAbkgFAIBRSSg6XueTCofxKUfXCdOy5fKJeyecNlg/V3U
         vXzY8S/h/g1B/a48WZhMZ8rPZrUyaMFt3H7tLSzOJeEKIYmsqSfwsv35F/eYO3OKzeGb
         Yu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694616126; x=1695220926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLMIm80/NqMAwUtQeNK/AozzxGhvlZkC/vnttV9OljA=;
        b=p4i10aHUjZS0KtINO8RvBjN7kqwUDDC9ulMhK6x3qOkeSF+u4i8pCaUghm666ncAFp
         dOryyQX+KA5HOpxEDtJg0Tvn8yaH7g2isZdX+gHWY14HEtfOKZ1GX8i4ASM7YxvAXzse
         BULFLspMTdm3fZSZ5JgAxlQJEF0gTdEPKBOQBg3wmStearEGfxYObRQsry9uPt/8jkVB
         Aj/rfTyhzHXYRCqVAW9UtOQGZBwbIxbKFCxbBB4GtRGuCyMXC1nydjwY+LGEwODGGZKp
         9JgYaxB9WWlTEp+A5ox6d3RqKy1zcByRZN65M0AZQH+IA882Qxb1Otc5Z9PjIsEIW4Uz
         aBQQ==
X-Gm-Message-State: AOJu0YyV8LgL53YNK8e+F2VKJY02oHjr4fx0GNRsrNPWp6SK/MQeOPZ4
	gUhn6P9JXSePvGgDVEJHTYHbag==
X-Google-Smtp-Source: AGHT+IF+VaL/WSe1wDP7z7hBlIPxE6En7FNsMN/iw6fc3vn3U/OGIpKX6RmO0F/MH0LkfeF3d/dE2Q==
X-Received: by 2002:a0c:ca06:0:b0:64b:e16:a3c3 with SMTP id c6-20020a0cca06000000b0064b0e16a3c3mr2395417qvk.24.1694616126007;
        Wed, 13 Sep 2023 07:42:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id a15-20020a0cca8f000000b006490a9946b6sm4480524qvk.119.2023.09.13.07.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 07:42:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qgR48-003efh-R9;
	Wed, 13 Sep 2023 11:42:04 -0300
Date: Wed, 13 Sep 2023 11:42:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 02/10] iommu/amd: Introduce get_amd_iommu_from_dev()
Message-ID: <ZQHKPGwp02jUXwuZ@ziepe.ca>
References: <20230816174031.634453-1-vasant.hegde@amd.com>
 <20230816174031.634453-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816174031.634453-3-vasant.hegde@amd.com>

On Wed, Aug 16, 2023 at 05:40:23PM +0000, Vasant Hegde wrote:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f1e18e81fca7..5a44567678ce 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -446,6 +446,20 @@ static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
>  	return (struct iommu_device *)dev_get_drvdata(dev);
>  }
>  
> +/**
> + * iommu_get_iommu_dev - Get iommu_device for a device
> + *
> + * @dev: an end-point device

No space before kdoc parameters

> + *
> + * Note that this function must be called from of of the iommu_ops
> + * to retrieve the iommu_device for a device, which the core code
> + * guarentees it will not invoke the op without an attached iommu.
> + */
> +static inline struct iommu_device *iommu_get_iommu_dev(struct device *dev)
> +{
> +	return dev->iommu->iommu_dev;
> +}

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
