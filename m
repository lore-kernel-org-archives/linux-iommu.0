Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB73219D068
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727166; cv=none; b=urg2dgW0QJ9uNoN7pIXX/itSjyik+cAS1COon5tJVozL9yPEjFeVJnKlHNE9b0anEpYvIvBTviWzJ/OJ5fVd9HvLb69cgSveXGnODuENGLKzue9crQwP0za+qPDSFGbJT0ZRxbuifxem3IF3RdIt9XjIwOglMPM72HhtrvJyyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727166; c=relaxed/simple;
	bh=h5Jc5tlaVM0O46GP8ugXOYzkXc28y6nDfp+F9B4TEZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhcWz2yiWKH6tRh+tgpDoPUf1ekdyN82+eTwpKCKo1/XII6iS7+0hyRyqzCIhUDEoRVQ+hoaMELQiX/m+X3pe8xALQ87P9NgPuO/1TwotNk+eflt/hY/5xn15DeIxsNUfiYhYKwSiOoZXb1+pho9aR+FySVGgpWLe7WQp18h19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mtwybNjQ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mtwybNjQ"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b7a8cada97so4502556d6.3
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723727164; x=1724331964; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XgOFSvrJTyO/ROgGU2nmdguppr1pg7x86vpdS+D2LY8=;
        b=mtwybNjQOD3nRDGbunQTCaWk/F/0DYAu40b2HCv3oRtLu2jP6b4iMq/K0MvV7an8/B
         iO7FlqbK4ydnLfljwdn0BWCrOYlLj0peYO6fpDR7IkYAIyL9gcBXMRZTpvOh41ul6FMO
         J7aSdXR1yRpAVKR/wmCY+Nk4W/ki8XYvXt9kwHipHLFK8GgUfVM8W0BUVo0l+TWzFrUM
         eXZ55jfUhZasDrWECtPj+eJpkg/VXRGffJD9G53VcztApqvx5eXdDhCmrCbh+m6DvnHM
         XLjomeafAFV6gEVOgmeya0N8nP8al9e1XiX09rBpDGB/VGAgjyZS0oqwRCA4npX9wO3S
         edSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723727164; x=1724331964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgOFSvrJTyO/ROgGU2nmdguppr1pg7x86vpdS+D2LY8=;
        b=CwnQPvwD3PySpUMEBDEUHqdO3NuxiJGlps/Tcig3I4GcaH9vy8caUIKYSF1baCaJJZ
         w+xgLPiU67edePieTrWy0Q6x2S6+nRiB2AV4NHIEOwdR23MgjhRpo4Stv33YGWvYOIuQ
         J3HBO4c7iY4E+maztAqIM/99y4TXc82Cgpqzss1xGDz6664WSYDa8UaQu7U9KJBNVFkY
         OFpX27awFYaZTTDDIz1CKeS8qANmx9CXzOIlgHpCiob9Tlq0yZ/jUem2Lgm0coZddtrJ
         gK9lBVCT8cbTWSi1AhA1SUdfhDD5ffmck3VNWkIhi50jkhy2TfxDUcR0ZchPbr9S0S3J
         5VfA==
X-Forwarded-Encrypted: i=1; AJvYcCXV5w5sjGP+szGqyyZnP0+RrycnICbj+psm5WwbyHmA9XiaGnOOqplj1MEVtpvrZ6qgMUPofw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaSQbahtNUbL9/VgltCjRQMJN3sKU95w9wCrG+cR8TGGC7Zoga
	HaGyrQeypGzWhVoApVMogmDb4E9sJ3Iqj9uT0qjiW4UDRKG0T4iOkv/G25O4+oU=
X-Google-Smtp-Source: AGHT+IH4lMvydx8/eq+Eq7tHQUbERtNRaK00mDgHaZXLs7A9GynKgF3agaEUEeX0/Ku2vF3zBBjo7g==
X-Received: by 2002:a05:6214:4302:b0:6bd:69a1:7667 with SMTP id 6a1803df08f44-6bf5d250490mr76757966d6.39.1723727163473;
        Thu, 15 Aug 2024 06:06:03 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fdd9083sm6243326d6.18.2024.08.15.06.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:06:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1seaAz-0032n3-Sy;
	Thu, 15 Aug 2024 10:06:01 -0300
Date: Thu, 15 Aug 2024 10:06:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Message-ID: <20240815130601.GJ3468552@ziepe.ca>
References: <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240813162044.GI1985367@ziepe.ca>
 <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240814224045.GC3468552@ziepe.ca>
 <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>
 <12db4305-de8f-4b23-8957-959709ebd2ac@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12db4305-de8f-4b23-8957-959709ebd2ac@intel.com>

On Thu, Aug 15, 2024 at 12:58:41PM +0800, Yi Liu wrote:
> > Ok. Single macro with `IOMMU_HWPT_ALLOC_PASID` which allocates PASID capable
> > domain if both IOMMU and device supports the feature. If not allocate normal
> > domain -OR- return error?
> > 
> > Also I would assume we want to enhance iommufd_get_hw_info ioctl to get device
> > PASID capability. Is that correct?
> 
> yes as the below link. I would include it in the iommufd pasid series. For
> the flag mentioned here, looks like Jason wants it to be in the iommufd
> pasid series as well. I would incorporate it then. :)
> 
> https://lore.kernel.org/linux-iommu/b37a7336-36af-4ffc-a50f-c9b578cd9bda@intel.com/#t

You two should coordinate some submission here :)

Jason
