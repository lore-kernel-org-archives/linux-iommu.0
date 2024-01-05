Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A5A35EF0
	for <iommu@lists.linux.dev>; Fri,  5 Jan 2024 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="U6/E/9cC"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb9b28acb4so1302257b6e.2
        for <iommu@lists.linux.dev>; Fri, 05 Jan 2024 10:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704479247; x=1705084047; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmgrWaRm0Hvh6yRapTk/4IQBaxfHVfOuJbUbOd8XBD0=;
        b=U6/E/9cC9Eidppse5YrHreRTbB/3AyB2IVFaaggUSMDTdX3Pg9aADll2Nw9w9noweI
         A2CQ/1ZkxU79wEqSD1iAzv2T3VuduoeteTafi2h1uSLWhNiGWasTgX/U3roB3+lx1uyF
         rvnwleTxCpOT/vEDIGiOTzNuHLiC1qmU4Ibba4hmmHph8BNeWjozflO90jd132KKMjoi
         qyID1ZFU7rRKLjahu3RBfglcIVHshqPrZe/Iy2UnXjSjCeuEwkJ2apup5wxL2VDjrIfW
         noHxMf7va5Un+0R+iDxe54T4rLWE09ZndtKFAi3foACxEiCmcL/a0Qyys/1Z2x/kd/D0
         edfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704479247; x=1705084047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmgrWaRm0Hvh6yRapTk/4IQBaxfHVfOuJbUbOd8XBD0=;
        b=XvAjphw2pYLQpczvrNSw0tvgV05v5DRHV8rzYaGpPtHJOzVvVW7VxucePs5eaL7tg/
         FgWdKAXvxyfp/iAwupYenFBelPWXq3+BO6muJ4L3Iw1yRrfBe7qIWTCMTI1+lOw9fXDZ
         gC2KO+zShzuHOJuqCa0t49dtU6FEB1LteszOyAUYh5/EouoNsT0wdPa6KHycutspWQ50
         3J/sxKZPlhzbgbeg3Td+uU+0xqn2QJ+gG0XFCPg5tlArykY1dLMlxfTyekCoDBeivT5m
         B6k5KMFfSItKB5LUvrcqDqETZFmLiaW3bqfmXCeva+vVsDnfPnmwMZAs1uzszwerV/v2
         LWNA==
X-Gm-Message-State: AOJu0Yxq5hUwjzHlDrLlk8nmBorIwAtazRZrS73RfIM6DhPYCDkrjmro
	JsB0c1PGRvGDAmFsKvwuzb6oJf4yI6sASw==
X-Google-Smtp-Source: AGHT+IGRNrll7PVIOeVjlXpTg37kJL1F3+H+6uj+DIdU/CLX2d9K8iReeB3Acfl4YaKRCLhD//eydg==
X-Received: by 2002:a05:6808:f0c:b0:3b9:dfc6:7d6d with SMTP id m12-20020a0568080f0c00b003b9dfc67d6dmr2981338oiw.95.1704479246949;
        Fri, 05 Jan 2024 10:27:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ow33-20020a05620a822100b007815e176d44sm769018qkn.64.2024.01.05.10.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 10:27:26 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLouk-001V8A-2W;
	Fri, 05 Jan 2024 14:27:26 -0400
Date: Fri, 5 Jan 2024 14:27:26 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 03/16] iommu/amd: Introduce get_amd_iommu_from_dev()
Message-ID: <20240105182726.GK50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212085224.6985-4-vasant.hegde@amd.com>

On Tue, Dec 12, 2023 at 08:52:11AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> And replace rlookup_amd_iommu() with the new helper function where
> applicable to avoid unnecessary loop to look up struct amd_iommu from
> struct device.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h | 11 +++++++++
>  drivers/iommu/amd/iommu.c     | 43 ++++++++++-------------------------
>  include/linux/iommu.h         | 13 +++++++++++
>  3 files changed, 36 insertions(+), 31 deletions(-)

This is basically fine

But can you improve the core helper a bit so everyone else can easially use it too:

static inline struct iommu_device *__iommu_get_iommu_dev(struct device *dev)
{
	return dev->iommu->iommu_dev;
}

#define iommu_get_iommu_dev(dev, type, member) \
	container_of(__iommu_get_iommu_dev(dev), type, member)

static inline struct amd_iommu *get_amd_iommu_from_dev(struct device *dev)
{
	return iommu_get_iommu_dev(dev, struct amd_iommu, iommu);
}

static inline struct amd_iommu *get_amd_iommu_from_dev_data(struct iommu_dev_data *dev_data)
{
	return iommu_get_iommu_dev(dev_data->dev, struct amd_iommu, iommu);
}

> @@ -1813,9 +1809,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
>  {
>  	struct amd_iommu *iommu;
>  
> -	iommu = rlookup_amd_iommu(dev_data->dev);
> -	if (!iommu)
> -		return;
> +	iommu = get_amd_iommu_from_dev(dev_data->dev);

And I suggest to stylistically keep with the common pattern of
initializing the casts at the top of the function

	     struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
	     struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);

Jason
