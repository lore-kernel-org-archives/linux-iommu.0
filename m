Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCAC1F179
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 15:12:17 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-64f383be0d4so43854896d6.3
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 08:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694617936; x=1695222736; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7rcFMTUwaE8unpfD7v4J4ZlHlh2i4wAEz5vYSaZQuKI=;
        b=G7S32NOkjLkvzwd0xS2ekOb7MONx1ue4fOKfJ/HH8t/HglPFIsUIrb1nhrJoBZwztZ
         9rP4XPSqDXOx9LKmIRGwcC9+YGtiqPfreDLQ9gfJ8OIS1K5AdlcQepPLtQHcmiG04ETP
         suAeccUs+uLaVPdV9d0WfLk6fqOTv12hTc8uJgYDGWB3S9Y61hhst6QgO4SU4cH2H84/
         HpYqFW/0jDT9hEvRUs5SRKX3pKQNpI3fiIgKS/ecwyiKiJxqLd+1ojgKrdBSeXAIS5js
         lGwNI6JoqCVKUuW7KGxk9OPaxAGPsF+WMrzPw6+KXEAeQY1k03E1yDvOsIRVRy0KmRrn
         A6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694617936; x=1695222736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rcFMTUwaE8unpfD7v4J4ZlHlh2i4wAEz5vYSaZQuKI=;
        b=ZRQXv0p5J+Fi6HL5mfAmG4AQlldiE8Kf7K8Y6sBSvyGoAo7UpXWLo1m1JzbIN64fQX
         tW7AkyXdes9+ssnoUvQUISRHeVSV0M0PjqNf9TfcT68ftTvhZ4mw9msiD7aAUrjo+kLB
         EFw/S3PWsM+tuVvIP2BmmsBdkPzHfxNTvSsqfzHcLlBt1d90nboORh/BYS26Vm4FHzvp
         8YjmVf6HZ6USb/TQEGkrQsLZ77tbydwydW2N2sHD2alciY7a7W7fjAxkP9iI7LOFXiJt
         QryJ4iQRlOFBdWbxRuy00qUHgU8Gz33tDLtyp9JHAF6NQqudPbSsIV1Y3fED+zO8Jp2x
         lp1g==
X-Gm-Message-State: AOJu0YxiRwixdz2uHS9VYMUrnyEa0mzrV1T0LS5OUmG7WCvVd3RHQt4j
	MioJ0+1TQHYQp5vWL9gSwo/RZg==
X-Google-Smtp-Source: AGHT+IFskH8bGb2miJlxnR0J57s7aGn0kUlWlWxBN+zZ9GRVCKHNXh98CfFrwKviMprIs8XZwXZLLg==
X-Received: by 2002:a0c:e188:0:b0:64f:5137:f668 with SMTP id p8-20020a0ce188000000b0064f5137f668mr2656811qvl.6.1694617936743;
        Wed, 13 Sep 2023 08:12:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id b14-20020a0cb3ce000000b0062def68f75csm4524626qvf.124.2023.09.13.08.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:12:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qgRXL-003epB-4s;
	Wed, 13 Sep 2023 12:12:15 -0300
Date: Wed, 13 Sep 2023 12:12:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 06/10] iommu/amd: Refactor helper function for setting
 / clearing GCR3
Message-ID: <ZQHRTwYN4doUte5E@ziepe.ca>
References: <20230816174031.634453-1-vasant.hegde@amd.com>
 <20230816174031.634453-7-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816174031.634453-7-vasant.hegde@amd.com>

On Wed, Aug 16, 2023 at 05:40:27PM +0000, Vasant Hegde wrote:
> @@ -2651,61 +2656,71 @@ static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
>  	return pte;
>  }
>  
> -static int __set_gcr3(struct protection_domain *domain, u32 pasid,
> -		      unsigned long cr3)
> +static int __set_gcr3(struct iommu_dev_data *dev_data,
> +		      u32 pasid, unsigned long gcr3)
>  {
> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>  	u64 *pte;
>  
> -	if (domain->iop.mode != PAGE_MODE_NONE)
> -		return -EINVAL;
> +	lockdep_assert_held(&dev_data->lock);
>  
> -	pte = __get_gcr3_pte(domain->gcr3_tbl, domain->glx, pasid, true);
> +	pte = __get_gcr3_pte(gcr3_info->gcr3_tbl,
> +			     gcr3_info->glx, pasid, true);

It would be a nice touch to change these kinds of functions to take in
the struct gcr3_tbl_info instead of two parameters

>  	if (pte == NULL)
>  		return -ENOMEM;
>  
> -	*pte = (cr3 & PAGE_MASK) | GCR3_VALID;
> +	*pte = (gcr3 & PAGE_MASK) | GCR3_VALID;
> +	__amd_iommu_flush_tlb(dev_data->domain, pasid);

This flushing doesn't seem to make sense to me, it shouldn't take in a
domain parameter.

At this point we changed the gcr3 table for a single iommu_dev_data
and so this change has exactly one iommu, device, and cache tag that
needs flushing.

I'm reading the spec here so I may get this wrong but.. It looks like
the IOTLB cache is tagged by (DTE.domain_id, PASID)?

So in v1 mode PASID is always zero and DTE.domain_id should refer to
a per-domain ID.

In v2 mode PASID can vary and many DTEs in the system can have
aliasing PASIDs. ie DTE A and B may have different translations for
PASID 0.

Understand that the core iommu code does not provide a guarentee that
PASID is non-aliasing. It is perfectly allowed that the same PASID can
point to different translations on different devices.

So this looks broken to me. The RID domain should not provide
DTE.domain_id in v2 mode. DTE.domain_id needs to reflect a global set
of non-aliasing PASIDs.

The naive way to make this work is to have DTE.domain_id be per-GCR3
table (eg per-device) when in v2 mode. This will obviously make the
cache tag work correctly.

This HW has a similar, though IMHO worse, cache tag misdesign as
Intel's does. The choice of cache tags makes very little sense for the
SW model we have. ARM got this correct where (in AMD language) there
is a per-GCR3 entry cache tag (ASID) and a per DTE entry cache tag
(VMID) for the v1 host translation. The IOTLB never uses PASID as a
tag.

Jason
