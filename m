Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9BE1D7E5C
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255809; cv=none; b=oLuBFAEDMtA2YbPeJ3Gm6AfCmlwZ+W9nvUEFWg23Z5fuvNdgESjI040lgLKXSx2IPcPzET+8zykmRgTyP5IdHYY3n+exp8N+XQF9MpI8+qFkV5DHVfdbyzXAhN30Ts+MShl1r9ajSQapS8bCXNsqiYbomK50EVOXuOKzXWAmFr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255809; c=relaxed/simple;
	bh=E+0MHEcl9OhNpjHwlUX8s4UQQWdN8Z2XAb90prdG7rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1VvF41CU/27CuaiXks4uLskaASxFZOaXTS4o9tov4ljjTK1oH2ykczgXr710g0D6p6Nu4UHo9e/CDh/nqYToALDpVeKDRzqrGY7ZLZeAGR5999f6q4S+wk0zhSsKvKsgs6VNGAJG7Sx2DTOY8gZM3A/oO/OXmFm6oV++2cUShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iBEEdel9; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iBEEdel9"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7ac83a98e5eso163071585a.0
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 05:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729255806; x=1729860606; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8CbN+1AYWTpKoQIQta2pKjRZa8Uaw411OrlN5wX2M8g=;
        b=iBEEdel9BHa+bMFHNSQVqy6jas3fKMXJfSOQDWo1CHbl/RKBSg1Zn+22Dop1rEBB7F
         HIYUbx+3qDOj0wIHTxchkT3707yMElwEZdFbzoxrNXUe9vILvbdoRC23f7jdRHNywm80
         5LBVKvbTD3cr5PUY3P09lYZ9229kq/rvc+CMQv9RCku+Xghha1LG6Cmvu0/5q0N9lkji
         njbVbd6sqNloGvU15h/IjBHzgcta6kSmpcf3IMWklE29UijmS3KpE1scVxcOVQ/La38h
         6ROSsLcurl4aettb1Hxb/yG6uN+0aFlHAHo5XY9Ne5MWZUXXLKmpiQh91ayK0SRKlJ98
         S3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729255806; x=1729860606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CbN+1AYWTpKoQIQta2pKjRZa8Uaw411OrlN5wX2M8g=;
        b=UrSYNtkprXBEydUkaQlFAwDF6uI9povX57lpa1LlKBv2NEx34W9yeLTOJatva5slgY
         0mcyd1vaClPffy2vGXA+UBQBjYV7nMReMxoTxPNE6jG5N1PAjCHSrEgd2dKzt3zcmjsV
         3C0n1Ejw+LeRuUCYFIQCWoapQJ7d7WVbB2bKh8D+VtNv9R5qpPI8kXOHuq/qyqdVDMx/
         hR8yuZjBGt6fwxlMfDeqoxCbfSguXr6e42Jsp+FR3DsCQisIHxCfIRhNK7V5A28Tocqo
         YJrL1t+yMT5Hl6t6pm21w/8sNz9bWbfo/ZbknS3Sy5YY4/m2TnmbGZMGKVaQ5SPJ/KIQ
         zb5Q==
X-Gm-Message-State: AOJu0Yw3WK76XKCEK22652RhYO4GYrvjBtLxsghsbJA1XdVs97F8T3vR
	ljXJ6ufPt049h7BirtWAVEIN65iy1qkPEKa7BP4tvyoQA0u1mXyTRIZmaZ4omoc=
X-Google-Smtp-Source: AGHT+IFy1gUgj4NMYIFe5QU0FukIsdH6ZIKzDnbqKhZrzS3MXgM/knSwrthFM+e/urB5SxMehjHKfQ==
X-Received: by 2002:a05:620a:29c3:b0:7a4:d56a:a928 with SMTP id af79cd13be357-7b14d54cd31mr1207566185a.21.1729255806489;
        Fri, 18 Oct 2024 05:50:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156f970bfsm66133385a.49.2024.10.18.05.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:50:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t1mQf-007hBv-GF;
	Fri, 18 Oct 2024 09:50:05 -0300
Date: Fri, 18 Oct 2024 09:50:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v3 00/12] iommu: Domain allocation enhancements
Message-ID: <20241018125005.GF948948@ziepe.ca>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017140137.6028-1-vasant.hegde@amd.com>

On Thu, Oct 17, 2024 at 02:01:25PM +0000, Vasant Hegde wrote:
> This series adds iommu_paging_domain_alloc_flags() which takes flags to
> pass additional details for domain allocation (like domain with PASID
> support). Also adjusts core code to handler variuos domain allocations.
> 
> Also updates AMD IOMMU driver domain allocation code. With this by
> default it will allocate domain with V2 page table for PASID capable
> device and v1 page table for rest of the devices.
> 
> 
> TODO:
> @Jason, @Kevin, @Baolu,
>   With this series if driver implements domain_alloc_user() then we assume
>   IOMMU always supports PASID. If IOMMU doesn't support PASID (ex: AMD driver
>   not supporting V2 page table) and device is PASID capable, then driver will
>   return error. Device probe will fail.

We shouldn't fail device probe just because someone plugs in a device
with a PCI PASID capability into an old CPU..
 
>   I think if driver return error, core layer should retry without
>   IOMMU_HWPT_ALLOC_PASID flag. 

But this makes sense, and it solves the other problem where if the
driver doesn't know how to support IOMMU_HWPT_ALLOC_PASID it will also
fail. Retrying with 0 flags is correct there too.

>   Other option is indivisual driver in error path
>   of domain_alloc_user allocating non-PASID capable domain.

This would turn IOMMU_HWPT_ALLOC_PASID into a hint, where you might
not get back a PASID capable domain type. That seems like a slightly
worse direction

>   I prefer first option. Just wanted to discuss before implementing. Any preferred
>   option here? OR any other better way to solve this?

I think you should fail in the driver with EOPNOTSUPP and then the
core code allocating a DMA domain should detect EOPNOTSUPP and try
again with a 0 flags. Is that what you mean by first option?

> Note :
>   vt-d specific changes is handled in separate series [1].
> 
> [1] https://lore.kernel.org/linux-iommu/20241011042722.73930-8-baolu.lu@linux.intel.com/
>
> @Baolu,
>   Do you want me to include above patch in this series so that it doesn't break intel driver?

I think trying to avoid inter-dependencies right now is a good idea,
so keep the order where 0 flags calls domain_alloc() first and intel
domain_alloc_user() will always fail with EOPNOTSUPP.

We can sort this out next cycle when more stuff is merged

Jason
