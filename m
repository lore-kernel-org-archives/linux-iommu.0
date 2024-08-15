Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DAB13C673
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727112; cv=none; b=aYpkTzhW0Zht7B0tPVQb1H5C2J1W2UaUgmO8NX2MoRHBhB6UH/57kL1Jxi9RCL/6x/jimrAy8M/D2AjelC90xMhtSuWWvZgcgzSX3PO5b+G4KNMiynehtn0C2nfcX8bjGQp+81yHEFiGV30TTpt8WP+bTljVEvfuW8sirnSf1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727112; c=relaxed/simple;
	bh=m7TJQQCJV5Xl56Yc4OCta/+d/MXTHiDA1+OgL6y2WjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdC6ERhj/aAi7Q8i27JBVPydE1B9eUhbmI9VxxFEnkcxV2ymBLCX2bOwjoUS9MZGG1HpULT30PBu8/6jJrq4QLjYlXEtSRQu4FBEG+2aY7l/DoHrZckUW2ywVzTpK0GSytvABO+Lb9k2nNvegL1QVEoIrcVPwpY5u/XzBQeeVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=omhX/Xwk; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="omhX/Xwk"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4503ccbc218so16844811cf.1
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723727109; x=1724331909; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEwMWrTOn3wviwCIlbNoIo355OoCdjOgEbqGWgKz6NM=;
        b=omhX/Xwkznid6hZRqkuLN41EiH1VkiiCFxUh5KVDo3/O8juz7m+xxPwE1C+HixjajO
         k154vgpe7exxmMGSBd7hiqbeZoG6hys2ReDr5L36ojAvtK5sUU9R/ZENGzOmjx26RbvL
         qZV/cFAjBYRLn0GNn+FLasKE0wgqfmLjJIM5EEHF/tAlkCWE/LhIS/aZ9D2Sh6mHoEYz
         T42Oz/SxV0Y3T8J3Tj7tEwMPqa0XkcboicG4KTmlo/9SELub2Hq9rqhKm6vVvOAdDC3k
         st8lzodYbGpmEltMFYRuZ/R9iRQxZr9znkOoQlmUOtdrsTKEca6tEel3OoXJjF+w5AFX
         dDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723727109; x=1724331909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEwMWrTOn3wviwCIlbNoIo355OoCdjOgEbqGWgKz6NM=;
        b=AEfw2NBEKQp1ImN+kJ8OUmi4Ym5J3ebCJGId1Nqb/BnwPtRGv3vRs98kINH/N5Z91Y
         21Qj+/RIdS6fI6ddNEuNPI5m3uwuEuO38AJu4FKZkTAyx5pDLqxSN7po5lIwsBNNaZwt
         xZH/807UT+CswfFkBuT60RXhcjZUfXYbEZkqEzzVqBco4YeN5Q9vpnLbfEnIbrB9dfM+
         mZjxQHDLnAk2ENTYirE/nze3lW+0eq8Q2SwDfCprmI/EJASHZ8fMnH3LEfsM2Q/uKkUs
         9UZhjr4mdTz5VZcteXEQbxudaDwHSFqe/x0WplyMh2pf/8XBYtDY4CWK0VNvnyAbsES3
         bIWA==
X-Forwarded-Encrypted: i=1; AJvYcCWUvYvdzhAQnCGh9JDMGgRqURsn73LQj+6nTyBBwaIVsRr6Er07u73WdY/B6zVudXRWzJIMcLPXCMvNnXj7QlGWkZtJS/w=
X-Gm-Message-State: AOJu0YwJCcxjvqFBzWdR2oFn5IurHk9mAqv8s6bnSuwAP4WJTceV1sse
	L3Bvbx7MmV9wePuCM+SHBy/6wfIxxb0HiHUOiC1SjsRF6RHbgsA80YdY2NcK+FLF7Ti6TeDjzJq
	s10Y=
X-Google-Smtp-Source: AGHT+IEkeUscxI7yebZ+3NHwNRrOzQoPgEfeGPi/4ShlLtS6c62MlUBZRfr7zJHIF6QUkJpMHaH/EQ==
X-Received: by 2002:a05:622a:d5:b0:43e:1231:1040 with SMTP id d75a77b69052e-453678d70ffmr55977731cf.20.1723727108983;
        Thu, 15 Aug 2024 06:05:08 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a04e638sm5680171cf.71.2024.08.15.06.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:05:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1seaA7-0032XD-8m;
	Thu, 15 Aug 2024 10:05:07 -0300
Date: Thu, 15 Aug 2024 10:05:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Message-ID: <20240815130507.GI3468552@ziepe.ca>
References: <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240813162044.GI1985367@ziepe.ca>
 <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240814224045.GC3468552@ziepe.ca>
 <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>

On Thu, Aug 15, 2024 at 08:58:14AM +0530, Vasant Hegde wrote:
> > I also know of no HW that would need it to be different on the RID
> 
> Ok. Single macro with `IOMMU_HWPT_ALLOC_PASID` which allocates PASID capable
> domain if both IOMMU and device supports the feature. If not allocate normal
> domain -OR- return error?

I think fail if the IOMMU does not support PASID.

> Also I would assume we want to enhance iommufd_get_hw_info ioctl to get device
> PASID capability. Is that correct?

Yes. Some flag to indicate the device and iommu together are able to
support PASID.

Jason
