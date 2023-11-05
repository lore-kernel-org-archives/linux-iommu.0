Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46458F77
	for <iommu@lists.linux.dev>; Sun,  5 Nov 2023 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kldnwU9l"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-77063481352so385822185a.1
        for <iommu@lists.linux.dev>; Sun, 05 Nov 2023 10:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699207517; x=1699812317; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BOFvE5BxXumZq+X3e2z8ke3X9IP4rQkqWv36evFoPFY=;
        b=kldnwU9lPN0eYSdSGVFBye0OM/GG7YBKPi0KQBgnBhxHLnwx9xDaXtlvQA7j1I39Py
         YZmHhX2nvMWQVsw0GMg0ly2mjt2NWNtzqE5Jh1h/MsmnVEJcdSJBlXYqg17bUuxXg31U
         b1owN6/7zj3FbK0hNgCFJ/DeXMOC5fQ2L9qVzSPDdZT5Og+KMtT55pM7bGF5YcQgPu7V
         jDDmlcl+8rsEjdbvFGXVUMSIWwy0wa7/qBZq/Al6YFwhlJqKMTnOlOsdFGLVuT+aEyTp
         1k2JN66XTRBcf2wJzbZsU7v0RC5SyAMM6kJYCgij2Kjy9YzS4TGxS5dWWZeytCYrcvgF
         +0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699207517; x=1699812317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOFvE5BxXumZq+X3e2z8ke3X9IP4rQkqWv36evFoPFY=;
        b=OoItuUvOLhVWGrb9EZIMAGanqr2nufZJMCr0BvOOxdN4sTyC1PeTwyQw9SDFsXUtt1
         gJE1eFdqQQQKxjou7DxGUq9rw9FxRo97t0z0+7/9SRZGvWs6EVOj5tPqKKNX5ps/UsvJ
         mqL7UW63xRetPu4SgeAbXKSgGBPbs/aKJubzCH9HeRJWoeH8wrTyWQdWihoaQEfr/LbT
         HJ81hGOIbcxPwlMoFa3tXJ5am8QBF/Hbmh+K7A5O3LWFbR4/OOWjfUL3xyUHSuijdN4N
         5aP7XKjCTj0DnU4y30C+fg3w9C9qjBRjjdbCjDNRaU8oEvZB0pmM5Bf8oYHrktiTycfT
         /WOQ==
X-Gm-Message-State: AOJu0Ywumw0Wv12hdEdTRNo4gTYX3zK2fbpr1viH3+GGUCzm0OkDcHQX
	cXBn0vEmP1IL8XImXxZLyanZHQ==
X-Google-Smtp-Source: AGHT+IEj6KfllrsLkrCJUkxeO8xhfgHJvNXwhpH+a3RB2WUCKN0agFDhagUoPkaq1W1S8ZnSmDUX0A==
X-Received: by 2002:ad4:4a12:0:b0:65b:134:ed27 with SMTP id m18-20020ad44a12000000b0065b0134ed27mr10502966qvz.4.1699207517745;
        Sun, 05 Nov 2023 10:05:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id l10-20020a0ce6ca000000b0066d15724feesm2714194qvn.68.2023.11.05.10.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 10:05:17 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qzhUq-001FcP-Je;
	Sun, 05 Nov 2023 14:05:16 -0400
Date: Sun, 5 Nov 2023 14:05:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 02/13] iommu/amd: Introduce get_amd_iommu_from_dev()
Message-ID: <20231105180516.GF4634@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013151652.6008-3-vasant.hegde@amd.com>

On Fri, Oct 13, 2023 at 03:16:41PM +0000, Vasant Hegde wrote:
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
>  drivers/iommu/amd/amd_iommu.h | 14 ++++++++++++++
>  drivers/iommu/amd/iommu.c     | 20 ++++++++++----------
>  include/linux/iommu.h         | 13 +++++++++++++
>  3 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 38b3f4562f3b..b2071ebc73b5 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -150,6 +150,20 @@ static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
>  	return page ? page_address(page) : NULL;
>  }
>  
> +/*
> + * This must be called after device probe completes. During probe
> + * use rlookup_amd_iommu() get the iommu.
> + */
> +static inline struct amd_iommu *get_amd_iommu_from_dev(struct device *dev)
> +{
> +	struct iommu_device *iommu = iommu_get_iommu_dev(dev);
> +
> +	if (!iommu)
> +		return NULL;

This shouldn't be done. See the comment for iommu_get_iommu_dev(). If
you are calling this outside an op context it is broken and the if
won't save it.

Ideally you'd put these calls only at the top of functions
implementing ops and then pass either the amd_iommu or iommu_dev_data
pointers down the call chain.

> +	return container_of(iommu, struct amd_iommu, iommu);
> +}
> +
>  bool translation_pre_enabled(struct amd_iommu *iommu);
>  bool amd_iommu_is_attach_deferred(struct device *dev);
>  int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 4f1b356adb8f..eedfa341085c 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1408,7 +1408,7 @@ static int device_flush_iotlb_range(struct iommu_dev_data *dev_data,
>  	bool gn = is_pasid_valid(pasid);
>
>  	qdep     = dev_data->ats_qdep;
> -	iommu    = rlookup_amd_iommu(dev_data->dev);
> +	iommu    = get_amd_iommu_from_dev(dev_data->dev);
>  	if (!iommu)
>  		return -EINVAL;

Eg here we have an iommu_dev_data which must mean the device is probed
and iommu is valid.

> +/**
> + * iommu_get_iommu_dev - Get iommu_device for a device
> + * @dev: an end-point device
> + *
> + * Note that this function must be called from the iommu_ops
> + * to retrieve the iommu_device for a device, which the core code
> + * guarentees it will not invoke the op without an attached iommu.
                                                  ^^^^^^^^^^^^^^^^^^

Means the function never returns NULL.

Jason
