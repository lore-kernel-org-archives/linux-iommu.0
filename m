Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9F0624
	for <iommu@lists.linux.dev>; Wed,  8 May 2024 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715126698; cv=none; b=Oy3nIuc6agrm83rzmxd8pHGfI33hGoLhEP8Fvv8LZptQ2fBWIbdLNS9nNYcPMiZWypeeQQVjugZGVcUQiY7mWkcNoFrHa7KXymet7vp4s4cd8BKfuvBwtdhArb3cTlSk1Zv035IA0JvTbWUXmkcvaZocixhJhuQZYlBr3sDmsgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715126698; c=relaxed/simple;
	bh=EJN6mlEQptyW+8QYnpWcKaJ9kN9jPZky98kePf90PeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtAisCGQ0g4JWSfVKcvLuOsCclZDtBgTGZKfa/zCg1QiGLVFR0hCkXBmh44iic+71V35PNqdhgC++rHEEPtL1GeytsVLcarhxseGSVyjXQnJlSBBEJ0ToLswfUsWX2udtRsDUHr5vMj5BCv0XSx038ECv5ujzmJO2nktzYlY8XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gmKYJjBf; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gmKYJjBf"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79291262dc2so356246685a.2
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715126695; x=1715731495; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vwwfu9gXxuRQ/Lnag+3klP7eYPeDRNPyKKE1ARsN48s=;
        b=gmKYJjBfaMRQ0fSDvDJ7fmm87hkgHJuDjsp2yQJCjoRJDkj/nCR+n6JDK9P8H4d4ru
         XNh6/vN4noeUOgviOAsvk+bhjvbvAxm3NFW1rnbDuTNCpLoXCtLCRJu7ZrHY4b81Zsv4
         VeL4ji84pZX/ErIESu8rQ/A47OzrP1S0Qxp+iTt07lbeCzV4vbvz19jCCg+Omry0b620
         bLVwWMoJtuoOgx9jy0uR6ediaA90yaNzlyl1aoRC9Ut2YqyRFiuLbbqy3qyaBrRcg84x
         Z/jY4DGHTOsO5kSgRlCD5isEU4gMRQ4E2oAhrbZQawZH0toTODt87SbiUiabOQkgJCVa
         syag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715126695; x=1715731495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vwwfu9gXxuRQ/Lnag+3klP7eYPeDRNPyKKE1ARsN48s=;
        b=lpxsi2fp1nfZi8X79em9+gepyyhr4hu+CdGMVboYDD91bHBVBj7WORItdQ9bB1HIkH
         dN07amdmzRs23FVNBXUt+LSFwV4E9Ppmj/AxN0K2Sg1rDdIznJypvKvKzjSYeLXy2Ql9
         uTbHVs2zlHzgmGNXNDYN5c/O1F7BwPa08Z0Zz6ZUQQCiOLIOxXjouHDQcYZnLaI4KMOS
         fPDkT70FCgGtYDvSmLYtDypczUykHBBGO7IkNJzOBY8NcHa22h3K+uLzlyrImJknoMxz
         GjDhnJATB/ilP5DKHk3axYHqaql50Pw3AOWbmGdT9TidDDv126RxOUhNhZv6vRlMykba
         xeqA==
X-Forwarded-Encrypted: i=1; AJvYcCVLA7y4L5ka9PPcw4yCIKOCcU4N1yD58FkSk27lqqRI4kXWNPLiteLDByFWsVqlwtFlcfNeOg7sANLobtgvhMaTI6KCFfg=
X-Gm-Message-State: AOJu0YyqDhEa5uUJmTgPksETEWIV9wei2oRGegYBVd0WP7kLec0CsbQ4
	9OVaHxhTudsw/f0RPQQsafyxxNUWTIwD8EYdqe+mT5lyT9z2A/brNkvnkCMcK6s=
X-Google-Smtp-Source: AGHT+IHYYyzxl2qn3bcVXy98/9Q/oTYtmKwzIdmiSS76208dyr73dlmOHTUi+Oep8QKsaSqr7cfBKw==
X-Received: by 2002:a05:620a:c07:b0:792:9167:5982 with SMTP id af79cd13be357-792b26ae168mr130112085a.15.1715126695290;
        Tue, 07 May 2024 17:04:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id n10-20020a05620a222a00b007929914d7cbsm2454612qkh.81.2024.05.07.17.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:04:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4Unm-00040d-AR;
	Tue, 07 May 2024 21:04:54 -0300
Date: Tue, 7 May 2024 21:04:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Message-ID: <20240508000454.GM4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-4-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:04PM +0800, Lu Baolu wrote:
> @@ -206,8 +197,11 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>  	if (group == &abort_group)
>  		goto err_abort;
>  
> -	group->domain = get_domain_for_iopf(dev, fault);
> -	if (!group->domain)
> +	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ||
> +	    get_attach_handle_for_iopf(dev, fault->prm.pasid, group))
> +		get_attach_handle_for_iopf(dev, IOMMU_NO_PASID, group);

That seems a bit weird looking?

get_attach_handle_for_iopf(dev, 
   (fault->prm.flags &
   IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ? fault->prm.pasid : IOMMU_NO_PASID,
   group);

Jason
