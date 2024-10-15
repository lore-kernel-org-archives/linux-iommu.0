Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C3F1D9A5F
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996022; cv=none; b=hmg9DFCgw3na5WlpL2SRiAzHLLl/HpTsPqiERLEBoOp6t9ooPGkm2BATAYKA7ldEXn580dqBrJKuFsKCbQDo0T4nlfUH+jgwjkp9m3xYOBdFMfEFo44LO2K+sMYdQtM5pwjcOr0W79VhtKbdfeaGJptrdn39m63Suyfh3G/UICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996022; c=relaxed/simple;
	bh=2SuS9lz7/A/gxw1IxgTVUE0I2KiL2dMWY4+hHjd9jq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAtERjUxLiY/2L2MKpS7ieyqCaEXHkDof8YL2BZU8JExdnaR6HG9ruj1/nUw6zjHKJ+x92mV3a+QC9NUWjxROk76XI9Qqrg4gMwv4zWyWSrBbC+o0+XFm3JvMWOQmgT7V0hDTvMU8ToPPEVcNnqXtYNuwOUD9ZZ2DyRV66rc0FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fXl32iY0; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fXl32iY0"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-50d85d7db19so117958e0c.2
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 05:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728996019; x=1729600819; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvFbyi+c3/+P83BoATPCErlQAYA7FwWdQqItg9JvJTI=;
        b=fXl32iY0OsyyvhwfdOfU7awcKP8/AVyyd6bMGQj1Lk/1Gk8h8uuyLKtv6RZ9hxLLeY
         4ScYA/aXXeTYB+37dfNRS+rdXdXBIvhXkPgxLJJRhut5CXTrmAyKaAPAKQoo45cI259B
         qJCp4I9sXv43Ht1RFXacMqNAVIOn7tkFkmUJHyjb/a9HLggNSULlNPKqs1S2bk5Mc3Kt
         HfInhv0l4Zg5fKXseIGQcOi0rEp2Cc2Rh7BQXrIeR5rTTWyy05ZME25P1xtnvB4ArSZm
         0Whwx0hBgtIciU+RU/k2swXbCOTvjpKLQilZIScgCidrrnmEYZGaJAANYuXz5bk7Zhte
         z4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996019; x=1729600819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvFbyi+c3/+P83BoATPCErlQAYA7FwWdQqItg9JvJTI=;
        b=AXJ6Jbwq5b9UC75NZ0hPAzpFmcGDOAD4NgfUcOEC2tyK9ECRtK/oZ6pX4bv9RV/AgV
         jkPSFRSm0copbwmcrnJE2rt+jmpBrhg4m8tzCNdC3H0PFJCA5hPZuqYgpadezoH3bSIw
         kCtZ4Zidpg20U/Ch8GDww+Co0zSRj7iE+IUo6WX7K8W7JhuUoDnsjapYrkNL//89Mz8O
         s0XspbyGqfo5GC3fJNqWQbZmMXPMsOGkqjh1ND/FWsdPVQU/9plwLxTrgEG2LIWYKifG
         52lfY8xaXpM2Q2W8TIaZ8nvPTjJt9Ttl1v/HyY1CLmaddVG6O/3d3GfxDmOXOcjEMPKK
         wTgA==
X-Forwarded-Encrypted: i=1; AJvYcCVC0XtAgof9raATEoXkAUsmNoJVq83gVwk06wFuTSrq52bSFfDNXOmYItXi3jHrUIIJs22fxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfHXdDPmPGBFjIPPdtAv4mdkLed+jxNdo951qasBu+hmPJRfsH
	kC2ByyccOJB2kQghwtjtowlGDYcY3FtVD4Cxv8V2FvXUJa0pxOoh/ZqvFlbEyiA=
X-Google-Smtp-Source: AGHT+IFiXZpGJD0Id3kWMRslFtVcC2YoB9xL09Y1E2d0nG448B9oEqi1OMgOnWo0f+gZPbdkyiViZQ==
X-Received: by 2002:a05:6122:1696:b0:50d:85c8:af3e with SMTP id 71dfb90a1353d-50d85c8ba28mr882976e0c.3.1728996019432;
        Tue, 15 Oct 2024 05:40:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13ed821cdsm23946585a.33.2024.10.15.05.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:40:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0gqY-00D0Ze-Ct;
	Tue, 15 Oct 2024 09:40:18 -0300
Date: Tue, 15 Oct 2024 09:40:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
Subject: Re: [PATCH v2 6/8] iommu/amd: Enhance domain_alloc_user() to
 allocate PASID capable domain
Message-ID: <20241015124018.GG1825128@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-7-vasant.hegde@amd.com>
 <BN9PR11MB5276124F430867613D7117E88C452@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276124F430867613D7117E88C452@BN9PR11MB5276.namprd11.prod.outlook.com>

On Tue, Oct 15, 2024 at 08:41:48AM +0000, Tian, Kevin wrote:

> > -	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
> > +	/* Allocate v2 page table if IOMMU and device supports PASID. */
> > +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
> > +		if (!amd_iommu_pasid_supported() ||
> > +		    !pdev_pasid_supported(dev_data))
> > +			return ERR_PTR(-EINVAL);
> 
> Just check the iommu capability here? IMHO it's a sane case to first
> create a PASID-compatible domain for a device which doesn't support
> PASID and then attach the domain to a PASID-capable device later.

The point of this series is to allow AMD to select the v1 format as
often as possible because v1 has better performance than v2

Jason
