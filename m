Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1B5383
	for <iommu@lists.linux.dev>; Fri,  7 Jul 2023 07:17:30 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3113da5260dso1459487f8f.2
        for <iommu@lists.linux.dev>; Fri, 07 Jul 2023 00:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688714249; x=1691306249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cpiunWH0TGWOiDXNc+28X9o/pnnF1RJUOQGrH8xZP3Y=;
        b=NdXzzH6heIdj9gyk+DA+JgVniBoWYUzhU9TzlHI0wvj5X7NrSIfTwZ+eaTuASySwye
         g4SD7s8KURAdKXuc0TY9vlgHUS+gx1NkWBsz9KP6z8eMirbLn9r4bRTw84vmDLYACuQs
         z3eKV3qBQa5ynVNjE3zOVp4MSfhGJvyUyodm9xKVctm9YYLxkqxcJjtzBMJXzdga+znN
         b3w1VBbs4c5UvpjYpte6msYz7GNyLP/MVTdGyJ9kA+e00sE3XohUk+l4I2DNYuZFjhwX
         hM1xd+5RU4n1hx0hNhORTSWFXVls7w5oNCx+PRWZrJHrkOF8LBkxKQddQjw2Oahh4Ddt
         HAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688714249; x=1691306249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpiunWH0TGWOiDXNc+28X9o/pnnF1RJUOQGrH8xZP3Y=;
        b=XAWqEjdoKrIByXae2EL9CMabTOUdSNmnyAPjSlyTZe188MVb/l8thmDFsurW2QnMRu
         fiK0fNyVCy/LYp2n1K+v92n23mfYPa+Bdqe0Y5AlaHzp9EkL2SSEu0Dpiu76nvrRsfnf
         Kj7gyGZUjNDgCZ04q18gLbj6RzcvpBD8SfudDV5AtJHgLLqqQ7UBuWsvubuFDBU5JX3K
         wSnLQsc4GJ9aTJultAs4J3ogiaqG4SjrUA4j7aDfSpMWaaLvUbvtg0wSW5EzOqL3vViJ
         RTfiQ62mNrd8wuSSqDgLZ1OETuRAoWfAzFxUoVzLJKkich1g39qJ9CzNf+SGwD0fM+lZ
         9uEQ==
X-Gm-Message-State: ABy/qLYHKLuPgT3qJGbPgEGcKNBZY1spR4Qq0Abx9gKu4EO+FJ81O5cR
	KRrYaL3tJXS7d+7/WmTkS54yvw==
X-Google-Smtp-Source: APBJJlHkni5uAtR65zxArYeN/0LK3zJBSDsUEDED74EZFi2KX7f4yl+A4hv8S3q/jiBH0vu6KAFijA==
X-Received: by 2002:a5d:4809:0:b0:314:3ad6:2327 with SMTP id l9-20020a5d4809000000b003143ad62327mr3061651wrq.12.1688714249152;
        Fri, 07 Jul 2023 00:17:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g14-20020a5d554e000000b003143cdc5949sm3743300wrw.9.2023.07.07.00.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 00:17:26 -0700 (PDT)
Date: Fri, 7 Jul 2023 10:17:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/sva: fix signedness bug in iommu_sva_alloc_pasid()
Message-ID: <5e474464-34ee-414a-8eb3-b11e74540b14@kadam.mountain>
References: <6b32095d-7491-4ebb-a850-12e96209eaaf@kili.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b32095d-7491-4ebb-a850-12e96209eaaf@kili.mountain>

Ping!

regards,
dan carpenter

On Thu, Apr 06, 2023 at 11:55:31AM +0300, Dan Carpenter wrote:
> The ida_alloc_range() function returns negative error codes on error.
> On success it returns values in the min to max range (inclusive).  It
> never returns more then INT_MAX even if "max" is higher.  It never
> returns values in the 0 to (min - 1) range.
> 
> The bug is that "min" is an unsigned int so negative error codes will
> be promoted to high positive values errors treated as success.
> 
> Fixes: 1a14bf0fc7ed ("iommu/sva: Use GFP_KERNEL for pasid allocation")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/iommu/iommu-sva.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index c4ab3c457fbc..6e4f1ba1c148 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -33,8 +33,9 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
>  	}
>  
>  	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
> -	if (ret < min)
> +	if (ret < 0)
>  		goto out;
> +
>  	mm->pasid = ret;
>  	ret = 0;
>  out:
> -- 
> 2.39.1
