Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE8D12EBED
	for <iommu@lists.linux.dev>; Fri, 10 May 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715358538; cv=none; b=bHTv8z5H12THgwHv0hb1lKRvvZGdT2cST+7AHIyJ2lwXwi1Hu3wGX7fNlZJYWfl8BTyi8oNaXgyrMQBJ9ecpb4N4KwjDwDJjh0GpGuzyvsUJEmC8wUfBnxGfPbksN2ceOuBu7KoCYLpRXGG+iuIDtQ9qtVTZmKIQ8ZOwJ9Mcfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715358538; c=relaxed/simple;
	bh=qRAfYIuRtk26fUbO0g/YhxEfQgubTQ5I5K3SO5qx7O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi+OWTS/B4OTkoF2sorPhtFGirk4pOus6yf6djupi6osVIR7RIuA+MN91rEcw5UPFBPZ36zDcp10Z7hprFTwANytu2bta9VitbTT7aCIUTkCVDtOvPzjK1t2Ns9XmjaWzGgGzGW9nIOxQM9bem8yja4/3QwZ5K8YI9W35vEZBlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Aqm8Fa7h; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Aqm8Fa7h"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-69b782287f9so8487616d6.0
        for <iommu@lists.linux.dev>; Fri, 10 May 2024 09:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715358535; x=1715963335; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YgVJGtSdSQoxiH/JwZGPbdmDn+FTEW1VhqEVzZ5vcs0=;
        b=Aqm8Fa7holdxRM3NGSZ/rEgy2/EKxj8Ll9Re6wNI+629WdnPCbWpmDqzdMf3tJVqDA
         hCRZJ6uQSBtwbP0Co/PWKuLuojKlVYfD3VsFkzMSD62tV5q6SyzZKzTM2z27c/NOL/z7
         OvlrgQ9tcVl1aHD54PfIjwnksqJ7w+Mj918vXbrdKzFkY8iVuEn+Jb5bWPmDpHYPLV2J
         ggtfneEB92bGF1CHBnd3hRI9UCaRT0EwnK3hj80ia6nAZ9PU5uxlcQxRR/gYS4Q/f7DU
         FnoHnHIa0zw/FtGZmj3uL9EahpD7/ABF7/Mlby6ytFqQMtDmxzbRQa1PvCdTT8iKHmx1
         FGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715358535; x=1715963335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgVJGtSdSQoxiH/JwZGPbdmDn+FTEW1VhqEVzZ5vcs0=;
        b=mpOqu8wnf4OVrQxOO4s2BOQAO4wmdSQITTfoQZ3l4RLc0vJxauKh0Pj/RqDbQX8pzn
         dVflBlu5McHh2DVbACRW6TVBojM9UtSI6ePLFLEwoOAPGUuFHR9vSW1NS88/HFi3c/7h
         XLcn2s8WYWmjiVK6KVDGuOxESDjoAEGOEGpYhFRPFnHU/+UbE2l9m+u0uxGL3PhARU+M
         b7vrQTLSTdv6oWe03+F8MAYW7Z/GiKArVehCMNX66D6Sf3G5G9xrA74Wo4o5rIJbFcxP
         hbQqO4nag9TGau2XjsO3f0+BzygcK2jnbVOtn2Rf9wFZvn4LRFo//edvnfkh8SsNmRI5
         OT2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrETcKSXJAZD0Z9EstxP3TbmF9ONaKN3O/8nTZ3U6go68YEwhOtziQHvo15yOzDrj1uwUqEh8uxUMCQ9owaVb3W0pPnEw=
X-Gm-Message-State: AOJu0YyFfDq8otbJEmrWQs/nqZH31gUKWYF1aexIhHThPZnoPSPjYNrU
	dF+bO5mwHJdzjixjRxRj51jvBns8uqz4wK2xaWWoFffqrfwt9/9DeiPIM5l1rOI=
X-Google-Smtp-Source: AGHT+IEBNBZwJ7UY/w207T6liKWy0qcUwPh16uAcjxrCG90REmApCaJsv6Dn931r+vPN21G8/a76Hw==
X-Received: by 2002:a05:6214:3186:b0:6a0:ae8a:e8ba with SMTP id 6a1803df08f44-6a168141010mr32027096d6.10.1715358535647;
        Fri, 10 May 2024 09:28:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1cd35bsm18630826d6.87.2024.05.10.09.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 09:28:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s5T78-006c0p-B6;
	Fri, 10 May 2024 13:28:54 -0300
Date: Fri, 10 May 2024 13:28:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Message-ID: <20240510162854.GY4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
 <20240508000454.GM4718@ziepe.ca>
 <21ffbcc7-1103-4481-af14-5ee8856b9625@linux.intel.com>
 <20240510133824.GW4718@ziepe.ca>
 <0de7c71f-571a-4800-8f2b-9eda0c6b75de@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0de7c71f-571a-4800-8f2b-9eda0c6b75de@linux.intel.com>

On Fri, May 10, 2024 at 10:30:10PM +0800, Baolu Lu wrote:

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 35ae9a6f73d3..09b4e671dcee 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -173,6 +173,8 @@ struct iommu_domain_geometry {
> 
>  #define __IOMMU_DOMAIN_NESTED  (1U << 6)  /* User-managed address space
> nested
>                                               on a stage-2 translation
> */
> +#define __IOMMU_DOMAIN_PASID   (1U << 7)  /* User-managed domain for a
> +                                             specific PASID*/
> 
>  #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
>  /*
> @@ -204,6 +206,9 @@ struct iommu_domain_geometry {
>  #define IOMMU_DOMAIN_SVA       (__IOMMU_DOMAIN_SVA)
>  #define IOMMU_DOMAIN_PLATFORM  (__IOMMU_DOMAIN_PLATFORM)
>  #define IOMMU_DOMAIN_NESTED    (__IOMMU_DOMAIN_NESTED)
> +#define IOMMU_DOMAIN_NESTED_PASID                              \
> +                               (__IOMMU_DOMAIN_NESTED |        \
> +                                __IOMMU_DOMAIN_PASID)

Yeah, something like that, I don't know about naming though..

How about

DOMAIN_NESTED = Attachment to RID or PASID
DOMAIN_NESTED_PASID_TABLE = RID and the entire PASID space

?

Jason
