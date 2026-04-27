Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7931195C
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298667; cv=none; b=YXPuBlXF0bM5shE2MWv0pEPu2awdzKEwrIjtYTACNID6cOTvRh6kyEK4+AQxqN56K51pNAjurqLG6z3v7SPbPV9u5Jw8aoVL+LpW6l59cVLOgHkthKcySxgu1AilbBk3Fhy+HEHkiniDII3V6L4vb3iQjhCFgjT+K0Nc3oZdXx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298667; c=relaxed/simple;
	bh=jEMMmfGSdoox1VvMk7/uQfRnvnb9SxPsH9ArA5SHRF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVXyPmjD0/smLrODQTWvwuceN5UutwJ/ZCkIdbXkAk+tcJxi/tQebK8udcCX7v2LQOKpZXFQQnNqkp4VkMMfTEUNs3oiC8MFZFIzyVEJLnMvJsKACHxdJzz9WrgJUxiS4fEE3jI7gda/yS5wqkAtSHbleqbLIcMo4EmLRzWADzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bCSOJQvD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bCSOJQvD"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d90833cacso6371241a91.2
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777298664; x=1777903464; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xsNytmMTjP7HFXqAqLQl9kJMS/VlfS6FjoNqX+XGHx8=;
        b=bCSOJQvD9mSlWyalqsMlRi4oda295QqeCg2yN24bCaZ6MFnpH7bhXl+zlMqmlmNTC9
         agE3x4DksWTbRnVoMGHbgw777ziZe9Qj+t1Wh5upqhEVZmI8twRbu7oIueRUU/YrHdFu
         elz67k5a9yckYkewzX1S2o1PDrBTe5g7OOJnwO1Vtng0OyyW+5WY8kXrlt98StescGBD
         RzcWLViY07vbu7R09/jHAvJQT/eJTwM1z4YCaXRcc/ht6fiyQ5eSHDYYw2Nqj2WtQmDS
         /ACIV29TQIiSpMbTO5m/RvocTJ/BOmN1GKw/Rv+5pbN72Ez4vtYSzlPKh1qUJbHHR5Qi
         hc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298664; x=1777903464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsNytmMTjP7HFXqAqLQl9kJMS/VlfS6FjoNqX+XGHx8=;
        b=gwm5x8Fa9oicJuEfHT2Z+64jx3SwqZP+3UFpYzIwocArlEKxVi0OCLuaC8RRkVcfd3
         hdh7smARt/Z+TZ2h2qaJq4OiC6cLFwoSpMSrhUy2VMWtcvUNV7GGd267XPm99+JJNI3u
         WGI0MRxrYX9LyDpn40h8Bg+R2XYQCi9029eiuJIFjZk6hrdSe9FFn2RbkquUTHUV+0AZ
         B9hHuOPK9HS1FXHAMVeOhglRMDX/zIikUwrtvx7BvOHU6vrxKsGobrfpSY9Nj7Fk8Nsd
         6VkkVMkhtqEXpeGa5Oo76RkpBzCkFi2XWwmHyCvCpDD6KCX/R1qHNiNk5Dk5qNOUY6VT
         10vA==
X-Gm-Message-State: AOJu0YyDnIQw+2AAH4q6rECPiH07Cs8d4r3q+83fkbpwRiOZCY6DxLIC
	hVrdOlugRdPPVvg2p9sOhsZsWMT/h5x5GWLjdtlqXNiXveYKwARo6KzYhxKOTAdc9uHi0B7FkP7
	phl4JDeA=
X-Gm-Gg: AeBDievIa5Cax9YfR6wdOcYqOzDQELYliEq/rHzHHgoSOeKJEC3jL1H/UuUFDgVqI5i
	WWi83WaRnuiadEO+Ut6Tr04ZgCs4w7dtIAXExcp/LS5aVhKp5W1w6efdduh4U+LMVb+ftjGuZTh
	4UZNi8C9fS0y3RYJni9l8Yc+53xnJJUi0YejLNgsxusBUeVTV10AFLInLe8kJS98fWMu0CJdjOK
	zMsnfi/xgNF49KUsF/5eqcSDpdZ5e3ZpIIGCFENKDNy8lAwmt7wWmqWoC5itofVobrW9cltokpi
	iI+ZdZJVGo2FnLgQp6dmMKh0RJ58B0Ja3LhbmYhjrdqxJlOqs4xSc898muBeh5gIWrJn/swhHNd
	59L3tMK7R0JaZSFsICAn9DnQvlhKA+k/h5Qsn5SULUKrGl+U/H7H0lMS6OuGVUyHefaHeHLpUGb
	PE9l3LLMQaTeoBBhKfGXPn/S6fEUPyIbnnOo9349LV4pKylPjVLw+qr9FCCFsWHAeKmYfHoFATb
	kB76I+ZMMmLqCG6
X-Received: by 2002:a05:6820:2d04:b0:694:a02f:75ad with SMTP id 006d021491bc7-694a02f7af1mr14826616eaf.59.1777298592445;
        Mon, 27 Apr 2026 07:03:12 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fb92db861sm165173551cf.5.2026.04.27.07.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:03:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHMYI-00000003Xlc-0XFo;
	Mon, 27 Apr 2026 11:03:10 -0300
Date: Mon, 27 Apr 2026 11:03:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v4 2/4] iommufd/viommu: Associate a kvm pointer to
 iommufd_viommu
Message-ID: <20260427140310.GD740385@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-3-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427061005.901854-3-aneesh.kumar@kernel.org>

On Mon, Apr 27, 2026 at 11:40:03AM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -68,14 +71,22 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  		goto out_put_hwpt;
>  	}
>  
> +	if (idev->kvm && !kvm_get_kvm_safe(idev->kvm)) {
> +		rc = -ENOENT;
> +		goto out_put_hwpt;
> +	}

Can we actually do this or is this circular module references if kvm
isn't built in? kvm->vfio->iommufd->kvm isn't it?

This is why I want to use file *...

Jason
