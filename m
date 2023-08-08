Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1512B6C
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 15:12:45 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7679ea01e16so463412285a.2
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691507564; x=1692112364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tCc1UHSmLrCN4Qj1bGiz7L7tPa3C3ijmKD+nZL6nYGQ=;
        b=XSBYe9brSDI6sJHBx8ZKDTtoleeoFIB/k6B8YPYmZULOoXIV7pHwQ1BZ/L/ogFNyvB
         6JKPMUNm6cut3BRHj+aez0GOsDj/IKuYipR3dGsHdnHimCUj1jU7pkX4w6mYeNQ0+RYJ
         D5FJM7wAvHiKwhS+CCdqmAPCOGB3Uzjttp0kybIg80pDTR+03K7Hvso41eB3vUduHi4H
         yqXfk3ZVi//IE2jaaU55agqLZizHV3CWN0Ou481WmEybV0w7rmuEuD6zm5n2g9xQFtr2
         sCuJg+P/yn94rE9+FEhN/OFMQ2o2RcNWSCcPETzQrSoIQMdYovjnp/YOpaXjmDHp5Jx5
         nmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691507564; x=1692112364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCc1UHSmLrCN4Qj1bGiz7L7tPa3C3ijmKD+nZL6nYGQ=;
        b=ipjbCp7WLwbQbCcsixmXBM1d+SrtI8z5SEjerm+39YBaDp5NDwCFA74MWujt1j7Cfn
         7tcUAa39jH7SaTOTn3/KM98njKRbcoYx3LYewalOFbzx3+vHVSDiDtGvTVqlwvXqWjqi
         5pX60nV5Y5pA3OnvQO1L18LFtBGa52bFwdNBL4NW7+tUBTmAhF9z+ng+k4N3uNi5aTvr
         lnwDh5hSNmJTWz0D+8RYJasl/DdwsRo7WkbXuBDfmUJMaG+0TZFcz8cYP5kw9J9ynqC/
         6vIgWWDOXvSkVLW7l9CR4Jn9lOYoioy2HCvkEOTBDO+BduYpCovYkKL6HRkr5zDsg7Wa
         zIFg==
X-Gm-Message-State: AOJu0YxAh51l2HvR/p+DCn218TZUtmRNo5dkgYMkCxlp/n5+WVxP+kOG
	ZPy4lqFwY2ApqJsoGY8DfcnzwA==
X-Google-Smtp-Source: AGHT+IFzrrTqeR30y0Ocpf5EcBwjJlaKJeQEmsrYs8bPjImvTGvp6mVAN6gGXRZBpxRj5Gzog4nk6Q==
X-Received: by 2002:a05:620a:21c6:b0:76a:dad9:8889 with SMTP id h6-20020a05620a21c600b0076adad98889mr12720117qka.43.1691507564018;
        Tue, 08 Aug 2023 08:12:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a10b400b00766fbeb3e7csm3320994qkk.132.2023.08.08.08.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:12:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTOO2-004d4y-Hd;
	Tue, 08 Aug 2023 12:12:42 -0300
Date: Tue, 8 Aug 2023 12:12:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu: Support mm PASID 1:n with sva domains
Message-ID: <ZNJbaiTDG+YTgpDP@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-5-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808074944.7825-5-tina.zhang@intel.com>

On Tue, Aug 08, 2023 at 03:49:43PM +0800, Tina Zhang wrote:
> Each mm bound to devices gets a PASID and corresponding sva domains
> allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
> field of the mm. The PASID is released in __mmdrop(), while a sva domain
> is released when on one is using it (the reference count is decremented
> in iommu_sva_unbind_device()).
> 
> Since the required info of PASID and sva domains is kept in struct
> iommu_mm_data of a mm, use mm->iommu_mm field instead of the old pasid
> field in mm struct. The sva domain list is protected by iommu_sva_lock.
> 
> Besides, this patch removes mm_pasid_init(), as with the introduced
> iommu_mm structure, initializing mm pasid in mm_init() is unnecessary.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  drivers/iommu/iommu-sva.c | 38 +++++++++++++++++++++++++-------------
>  include/linux/iommu.h     | 10 +++-------
>  kernel/fork.c             |  1 -
>  3 files changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 0a4a1ed40814..35366f51ad27 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -15,6 +15,7 @@ static DEFINE_IDA(iommu_global_pasid_ida);
>  /* Allocate a PASID for the mm within range (inclusive) */
>  static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>  {
> +	struct iommu_mm_data *iommu_mm = NULL;
>  	int ret = 0;
>  
>  	if (min == IOMMU_PASID_INVALID ||
> @@ -33,11 +34,22 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
>  		goto out;
>  	}
>  
> +	iommu_mm = kzalloc(sizeof(struct iommu_mm_data), GFP_KERNEL);
> +	if (!iommu_mm) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>  	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		kfree(iommu_mm);
>  		goto out;
> +	}
> +
> +	iommu_mm->pasid = ret;
> +	mm->iommu_mm = iommu_mm;
> +	INIT_LIST_HEAD(&mm->iommu_mm->sva_domains);
>  
> -	mm->pasid = ret;
>  	ret = 0;
>  out:
>  	mutex_unlock(&iommu_sva_lock);
> @@ -82,16 +94,12 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm

Lets please rework this function into two parts

The first should be 'iommu_sva_alloc_domain()'

It should do the list searching and user management. The usual
'iommu_domain_free()' should be modified to clean it up.

Then you have the 'alloc global/enqcmd pasid' function

Then bind is just callling alloc sva domain, alloc global pasid,
set_dev_pasid in a sequence.

It will make this much more understandable what all the parts are
supposed to be doing.

Jason
