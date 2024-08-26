Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09971E531
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724679946; cv=none; b=psCvI7T/Xcmi7nUzkL1qKuCAWTRBUNxPGcUh+1vTYX2W7yV228IVMYi6Blph58OtQuWHNi013lnNt9yJM4/qG1Kvhr6uCktx7k8UXWWNnyoEeJD30PRvtWvEP1RcM/cf7UDnXW1TsVVIzktI2Zt1VHgIHYrjoy8brH51gd+gtRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724679946; c=relaxed/simple;
	bh=CxB4EcJPsdl1W+ocm52AWx9j/vm4LH1VwxGPXCukEzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/rRN7Jmn9l+Q2o5tRAAgrJPgNfllTaoo/K33gZG49XzgWMzCfWpDsrzY+RSfPNP9YSFFT5SCU8HX6qO2LHOUCoJZK3K195gjMUHqUElvAZ9SMFgoa7DCZMI35snwQuTJKMDgqT/E6n9Yv4O+obFyhHxng13nrDLIdDEirCh9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JDU1cQGO; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JDU1cQGO"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf6beda038so24092886d6.2
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724679943; x=1725284743; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jXPRtfWAuDrYyvHS5VfJ9vU6VyOrCYRMCjdcNy8vKzI=;
        b=JDU1cQGOTbEizAQgLRP86AUIwuhgoxlEkSh2Tmz5vkiOoaxQBvJ9GVAKtDilGZRx+u
         t3zcdX9cfHY0yHVYrZyCPk0CL2YSZJlo1Mb460ys1YugAJWYnupUKmGYywVxBkTZRkXx
         LUyuPvJ7GrAESE6B/MbZzlRlMGu+ufgM4sGJqWjK5Nv0ViFavY7VC6YciDnajUde8vVr
         olm86J5RU643hhRVVO92wrTYYpg1zTkseRaOkid9QZtzqQfc9Aj11emhKI6jxkyTolHw
         oq90P50dEMcAmpNWcT3ND/BHvDOU2Ka27CNZMcnke+JJ47bffnv5X+2R3I2txWCaJThQ
         RDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724679943; x=1725284743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXPRtfWAuDrYyvHS5VfJ9vU6VyOrCYRMCjdcNy8vKzI=;
        b=Basi2EzIM0kLJSeYpkx13JkEt9TPPXg2hz9UP3oMyYKa90k617Tk8w1nbr3lqkasCM
         fZilLyTDV/hSNv9K8Olo2BjNTBYf1ED59W90sln80d+GJDbNPWFA/FUwx3m1a7a0OT7x
         fVq2DgDrr0p2Qo0MBwaNAsN6FaEC81oK+6CTJigyL5D2VEAHY6tX1Ab9sW+h22tGvQNQ
         LuXwmTdrvNI5rVT6jY3OTKdCa0cSzk83huWsrIYa0TWHQ7yW8ZhmoXi3KjfJSg6fLPAJ
         OFckQQP/uf/SxXAqBUSOoFXdBNqlr/sStE6qbE982potY9Xo7ysAEBI3LB+m02JL/ozi
         fe9w==
X-Gm-Message-State: AOJu0YyjIhVo0CFPT6tUuQLRZB0cm/SoQuCuKxIKtKvuTMedXfdyhmUH
	6clQR1LWyTzgNZmpLHH1CkUhC7Otbxo8ecHJeWTK0rJEpsV2gddBbbY52CQT4LM=
X-Google-Smtp-Source: AGHT+IHcOPZHDQuB9y3rKxionJ1F7T5yo5QziUBOGTRsmSY5eEFR7t9vJddLXCkAAahNHnvpPTCf4Q==
X-Received: by 2002:a05:6214:458a:b0:6bd:7efa:ee4a with SMTP id 6a1803df08f44-6c16dcc34b1mr121769986d6.46.1724679942559;
        Mon, 26 Aug 2024 06:45:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dd1dbesm46632906d6.128.2024.08.26.06.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:45:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sia2P-00BtOR-5x;
	Mon, 26 Aug 2024 10:45:41 -0300
Date: Mon, 26 Aug 2024 10:45:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, kevin.tian@intel.com
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Message-ID: <20240826134541.GF3468552@ziepe.ca>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <689eee1c-4b84-454b-8dc5-a5f35abe1631@linux.intel.com>
 <20240822124307.GC3468552@ziepe.ca>
 <ec556b8e-4a8c-45ed-a3d2-319ef9fdd04f@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec556b8e-4a8c-45ed-a3d2-319ef9fdd04f@linux.intel.com>

On Fri, Aug 23, 2024 at 10:47:46AM +0800, Baolu Lu wrote:
> > Why? What exactly is the issue?
> > 
> > It is inhernetly wrong to behave differently based on DMA API or VFIO.
> > They are not different things.
> > 
> > If you have different behaviors and different properies, like AMD's
> > PASID, then they should be described and mapped to some kind of flag.
> > 
> > Otherwise the driver should always allocate a paging domain that gives
> > the highest performance.
> 
> It relates to Intel VT-d's nested translation. Intel VT-d has two types
> of page table formats for DMA translation: first level and second level.
> In nested translation, the first level page table is used for first-
> stage translation, and the second level page table is used for second-
> stage translation.
> 
> The iommu driver for vIOMMU in the guest kernel must use the first level
> page table format for kernel DMA. This page table will then be nested on
> a second level page table in the VMM host kernel.

The guest kernel must know that the IOMMU can only support the first
level format in this case! There is no other option!

> Our current design uses the first level page table for both the host and
> guest kernel for simplicity. This is why we use different page table
> formats for IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_UNMANAGED.

You should just always use the first level format for every paging
domain except when IOMMU_HWPT_ALLOC_NEST_PARENT is set.

IOMMU_HWPT_ALLOC_NEST_PARENT was added specifically to solve this
problem.

Ideally the guest kernel will reject IOMMU_HWPT_ALLOC_NEST_PARENT as
not supported when allocated or attached. ARM does.

> I am not sure about other architectures, like AMD, ARM and RISC-V.
> Perhaps all of them have the similar need?

ARM/AMD/VTD all have the two page table problem.

ARM informs the guest if S1/S2 is available via IDR which is like
VT-D's ECAP. Only S1 can be used in the nested guest VM.

AMD has a global amd_iommu_pgtable, it must be set to AMD_IOMMU_V2
within a nested guest VM. The only way I saw for that to happen was
via kernel command line parameter? Was expecting some ACPI or
FEATURE_XXX thing? Vasant?

VTD should add some discoverability that the second stage is not
supported and behave as above.

Jason
