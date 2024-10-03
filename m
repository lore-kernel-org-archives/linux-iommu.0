Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A31990AA
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962408; cv=none; b=s52kPxIJNHwQ7Zds5jAFRyBqZ6stjJXCe1zCO4J0HkQR/+XWVTiHcn0LxlVqU3dZoXc0E9wKzklpH6CKr7eEVcmcql2ad07MPPubVw0C7gPkEm235ntPbxHPiNxqAJO5+Z2NpJTFdy8bv0sQrjNnMV3QPUE3wtohzZ3KO9SqU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962408; c=relaxed/simple;
	bh=ru5EfHEC2xYx7sJrFNE6UgCz7R3Tdiv5uWDzLygWL3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPZBUSv/czPHK//IiKsnwJ0zg9VZggXHZZWZVI9I6HFfuRJxR2pL8RgVbb1VuwUrrlYEw7rUIXXnnoKPkhhAH61+dMFbayHFG1/LclN/MhfU3n+goWbFj4t+2Gpo4nKXE8TyQWPnOvwuEXX4+Zb/0jfwZUrJrreZyYlyTviEDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZD1LYMOI; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZD1LYMOI"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cb2a6d3144so5156886d6.2
        for <iommu@lists.linux.dev>; Thu, 03 Oct 2024 06:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727962405; x=1728567205; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8dQ/gk58hUlGStzLPNPz+tqcQ3+D0/hVEA8eHIyZCn0=;
        b=ZD1LYMOI2cmqYaDfaoACK7+6Pya4F5JTbPSP7vQkoc4vazAq2Gh8+G3VSxhupSxCyy
         JWKTwInJP0UHdDNYTsd0sF3B+sx284mt8tANGzUZIHiG/SszZ0ko1zNlTYG0juAWmrwi
         ksOM4urzEgKMTrTnvjMMi5/nQnn5nYrmquN3IyqbSFYkcPEzpDc7Ksyl9eycvRDR9x9G
         pag+IqiOZ7lKxUQ4/Up+jezUYcptV5UTioeLSOdeJQwrwvVQqecVVCOXCUcv9aXMDPOn
         Ues07cB7rf4ApxTHFr72cAi1ZlWEmwkTEvsRtYFtnqSDYMHIO6uL8g5lFN4f2TnSWyef
         /bUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727962405; x=1728567205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dQ/gk58hUlGStzLPNPz+tqcQ3+D0/hVEA8eHIyZCn0=;
        b=TOvYjoHn0pHyqSH7pZw7SBaleU+LLxSE2sJsrFy2iR9YD9MB8nLXDZD2hQ6MBzaCaT
         w6m9fPMVDr9NmJMMPE6BF54OGTeye4fRSNnT80cmrfEAOEgvSK8zDWwLKrM9CevO16wr
         UeV38LO/4WsReAfWwFf6TkpubGZdxUaP5jTbfzgI3DjrEvJkceB1T+vrlUjZZiW0D2wa
         WcZgLJsedycBmjYS07d8+ScmDf0Ja47oVPmw+o08PmRyNqHB/IOPX+x7fPMuSL5aYYNi
         8hpy5thPVOfBflp0POu0u8hkL16Ydm79cMf2myIFzjvmUFv87pBMC5H2iEMDx41N56QY
         pe+g==
X-Forwarded-Encrypted: i=1; AJvYcCUCgiUtZ4Xka/WL3nRaaln5oBjseagIfUjihbgG331QAFB25NJ84Zwkg5j4Qb8TzhIj8d3Rmg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxu7pVfd/AqgpNPaAuDWPl7wX24LZGoJYGUrXR7xw6NpUTWFTWL
	qVwx3m9MJwccW6K+4QecYhycQZa3l/0R4PMJuCZy003qlMlZ5FVMtCL8Xcz0m1c=
X-Google-Smtp-Source: AGHT+IHs6HB9tlbYAhVev9UHmvUhD6mUcL6pLiiMeMpBirOjKBi5OGNhsG7hwNB7h9ua6MEKwvVLvw==
X-Received: by 2002:a05:6214:450c:b0:6cb:3644:7ee1 with SMTP id 6a1803df08f44-6cb81a1066emr94967236d6.28.1727962404750;
        Thu, 03 Oct 2024 06:33:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb9359bad5sm6515846d6.5.2024.10.03.06.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:33:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1swLxL-00ASUf-OH;
	Thu, 03 Oct 2024 10:33:23 -0300
Date: Thu, 3 Oct 2024 10:33:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
	iommu@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Alexander Graf <graf@amazon.de>, anthony.yznaga@oracle.com,
	steven.sistare@oracle.com, nh-open-source@amazon.com,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>
Subject: Re: [RFC PATCH 11/13] iommu: Add callback to restore persisted
 iommu_domain
Message-ID: <20241003133323.GB2456194@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-12-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916113102.710522-12-jgowans@amazon.com>

On Mon, Sep 16, 2024 at 01:31:00PM +0200, James Gowans wrote:
> diff --git a/drivers/iommu/iommufd/serialise.c b/drivers/iommu/iommufd/serialise.c
> index 9519969bd201..baac7d6150cb 100644
> --- a/drivers/iommu/iommufd/serialise.c
> +++ b/drivers/iommu/iommufd/serialise.c
> @@ -139,7 +139,14 @@ static int rehydrate_iommufd(char *iommufd_name)
>  		    area->node.last = *iova_start + *iova_len - 1;
>  		    interval_tree_insert(&area->node, &ioas->iopt.area_itree);
>  	    }
> -	    /* TODO: restore link from ioas to hwpt. */
> +	    /*
> +	     * Here we should do something to associate struct iommufd_device with the
> +	     * ictx, then get the iommu_ops via dev_iommu_ops(), and call the new
> +	     * .domain_restore callback to get the struct iommu_domain.
> +	     * Something like:
> +	     * hwpt->domain = ops->domain_restore(dev, persistent_id);
> +	     * Hand wavy - the details allude me at the moment...
> +	     */
>  	}

The core code should request a iommu_domain handle for the
pre-existing translation very early on, it should not leave the device
in some weird NULL domain state. I have been trying hard to eliminate
that.

The special domain would need to remain attached and some protocol
would be needed to carefully convey that past vfio to iommufd,
including inhibiting attaching a blocked domain in VFIO
startup. Including blocking FLRs from VFIO and rejecting attaches to
other non-VFIO drivers.

This is a twisty complicated path, it needs some solid definition of
what the lifecycle of this special domain is, and some sensible exits
if userspace isn't expecting/co-operating with the hand over, or it
crashes while doing this..

> @@ -576,6 +578,9 @@ struct iommu_ops {
>  	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
>  						 struct mm_struct *mm);
>  
> +	struct iommu_domain *(*domain_restore)(struct device *dev,
> +			unsigned long persistent_id);
> +

Why do we need an ID? There is only one persistent domain per device,
right?

This may need PASID, at least Intel requires the hypervisor to handle
PASID domains, and they would need to persist as well.

Jason
