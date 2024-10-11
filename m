Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF0839E4
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663469; cv=none; b=NF4n8hZWw2G/qxbCRbjYZl6AIUM+60iTzngNdTe+aIf+w51E+5uxOMDUytg+xhmsNLg8ZveOrZzcbulsiq9bCpy057Uo3OQk7PP/j6ABnr0sCpkxBe+YbZTOX7D3WxQsjqGcjIkROpyzIWh/Vq7brE5e3eFf0E/9/37Nwb48CZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663469; c=relaxed/simple;
	bh=6LHOnL9js5JpiK6Up4Ip7xSByYfXX+0ciPYwyn8Ual0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3EIxR3e8Pr01aC+ZV4c3etTPAN5miB2i2qLpcj3iEvEgf7Tk6Pnp1toh6WmAVuyV6Yg/DKh2rT8ndJror13Iy1uhzwHBBwa/MDUH0FOqUlLoocwKMpyXKQqC2f3x08n+7m9C1taj9cpzOsz//r9uu8zJyCOUvI6MaPJ4OlBu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TaJCKppM; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TaJCKppM"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbce16d151so11542916d6.2
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728663465; x=1729268265; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+UKpbHrZYVo3z7RG4GImvYUh7LTzAZY0h9E01fy0uS4=;
        b=TaJCKppM716iafSZiCO9/NrJg7qC9dbmCELjDRkUQRqgOEvFU3PU0r4bOsb0P6GSD9
         GsxKfJinBT/GMAwm8OmYYzBcaUbbCNepccJug6KVXhDRmwACM73fEjos7PTSlnj9UH7M
         4vXMmUqPvdKU9r5NVV1l8/IR/jwyv41o531+ZnHBReStbNncpE44OGD5pG8Iz9wFTyTC
         EunTPRSfC42OEK9Ih0H9ggNH/t8beRKj4+b1k7DKDn8aiXwmX+qC8M5kFxAuXdt5J84d
         1Bio9ca93Q0PUB9WxKbzytACYp9O6r/n/wbu4LTzWRrLE9+LZ0QxLhXFRntC7FDkxfZE
         TiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728663465; x=1729268265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UKpbHrZYVo3z7RG4GImvYUh7LTzAZY0h9E01fy0uS4=;
        b=NuNzb/TqNih8AtUsMtFyI/iN8ygzd1ZWsn2hm2WkSQKvLMl3x2wRANzLhSE5iovMPU
         WntyL+qG25CtLFiDmiYzSD+QYCIQ+rvC48fRJjiFkGIbg+5OfLuZzvkIqNo8VBWw7npO
         O3MvAb9Vl2B+RvH2lQOOlwCBxw0aUhcv4q2m29UDODw7XmQKi2nhnLNwtb5+aFRRL/jX
         Ciu+Zn0kXy+VtVcqY28INmy5xMr7Nn2XbJA9A3JtTwdzKrQs6BZVgjsavHppVhNUxIhx
         qiiKBqb8JVo+QbQ8DFjTKsseLnjo0bzvUiN3Zos4ucVzwFtoyAarZx6iol/4d1oAt1By
         B9FA==
X-Gm-Message-State: AOJu0YyohYdcNj3vdsKwXTQhUah/a55IMX5wBkXgIP7+efC68pbfeJ08
	P9aTkuYJpD7n47Zvvdu72OJBgHipxYNwnFS1qhuVhIAeqLoMQom6jSNPqdzUHIc=
X-Google-Smtp-Source: AGHT+IHpDIVQFRzj504Zk+f3/vKgKGmhDgAK7B3kpCWJ3cuNby9GPkXv5Gj6L8nhBBMuQOMUCmm0JQ==
X-Received: by 2002:a05:6214:5890:b0:6cb:c9d0:df32 with SMTP id 6a1803df08f44-6cbeff80f57mr35886636d6.11.1728663465301;
        Fri, 11 Oct 2024 09:17:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85a5d3esm16930336d6.10.2024.10.11.09.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:17:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szIKm-007akF-AK;
	Fri, 11 Oct 2024 13:17:44 -0300
Date: Fri, 11 Oct 2024 13:17:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] iommu/vt-d: Remove unused domain_alloc callback
Message-ID: <20241011161744.GK762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-3-baolu.lu@linux.intel.com>

On Fri, Oct 11, 2024 at 12:27:17PM +0800, Lu Baolu wrote:
> With domain_alloc_paging callback supported, the legacy domain_alloc
> callback will never be used anymore. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 90 -------------------------------------
>  1 file changed, 90 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
