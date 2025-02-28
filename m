Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B45426BDA4
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754601; cv=none; b=RFXFdTAl0OuuunomvT3bMjyt43QTpHC1l4z+ki4EGMv5Ho7Wmr3ptYtVwKBfZq+rJ0QeSdw4NCmqbA0Cc61RRJIVdvghzrDe6Mh+z0MM0Xgv1RcCziSf9kKzwDzqS0f1y/lRkqD/7KvXHsH1Rz1VWasd9U0O/Npxy8w27IOJwlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754601; c=relaxed/simple;
	bh=6Rc3l9ChFfjofU055dOGGd+tNJ1mMeKshove2uuBuqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxkgxj0uCLqxm61rqvNbYacVfKHYsP5x8t1Gh5XV5lXCmUfM5Y4LB61Q0ET/1mqO58GFjorUZTI0Peo4/vmLNMEthBsBof/a6Tvgic978h3VgtN5vMtmLbBUXZQ+FHVyyrqtBF1xoluZ1Wxdp2qKpMptM6N3u/tSDJFrYLUGsd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CdwVc9Xc; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CdwVc9Xc"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4721aede532so21874831cf.2
        for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 06:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740754598; x=1741359398; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cIWVFxmwazcb6ZNADduKHN7eirVnyNuD7bscVHLVrOQ=;
        b=CdwVc9XcRmqrYjGrTmiXkiucI6GdITrnqdbHeCtoBnPBBKWkvr/xDFPDEup/nbhXW2
         5c9JmMMSFIKsLToMvMu1w+GtHarbEScDzQuVNNJZombid4Xl5Q4JHej//f4zi8inmz+X
         D2df2xOC0x6K1wkh/vNhF2OaNYNs3SQvsc2mmeCtT1Z2ZXFkvh9hFHTxN4T9XjRcxSNL
         lROSnj7EZHnolm5lAue1TIE03NeCfyTu4z/oLHds82euIHkzTFfJ+mSb0VsC9XjS/MdX
         4c2Lqz9Qk5Eo1tGKRVJ3IeErR3s373gyB67exdaFWos7lZTjXcjTkVIk54Qz60IC5exB
         zu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740754598; x=1741359398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIWVFxmwazcb6ZNADduKHN7eirVnyNuD7bscVHLVrOQ=;
        b=roJGegqOOsAAMVYRBVag+ELQWYfjScX6DFgyN7coBm+Cta474ny6DIZsa1t5VJFOYP
         IHKAK+f6lyJuhMEkEBDYSWYKJjRORMbJCYp1ePY7XIdcGFcy0jctg91jqmy/yIS4cnWm
         8fe/gSJRybqWmoKU0eUrfWsD9hFTVnccKPtfZhFrQ40xzLMi/cOA1TAQa2InRvOoNPiC
         qCc2FvovVus+yTAccAIqi8JQtEYAzITLKKPJSHSHtV/TsfkRaH8hw7JFMJZvJfUkNVie
         TdvEqRLCJhm0G1matC3eCMZTGHmt73qw2ChRCXhhSTZopj6n045fYy/pW8JHZh2jIzvs
         Uzzw==
X-Forwarded-Encrypted: i=1; AJvYcCVy+3UqiOJamw+tJNNy+8IyyOWG0aDHUdjY1SB9Aq+rZRqupCG6CH9oWCSwgr4lyoEAmCnHWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfOMODwiXRzSYij/F7hNKrFzQxwS0OiC/e/B6HqakNX7G/bBic
	0JquwrvOR/kEYf+P4dP+h8OJnIFlMLBn24AbivsuzDl8EViYxcdEJw/i8vK3cAw=
X-Gm-Gg: ASbGncux5BokCQpmBYi2cH4t3zsgUaQX8VgZfDeggtevSDOdm1QE8H9Z7NZvInPsKGe
	ihkgMilhKfMUZEcB7l01gfLnuOFW07TCFCBoIoHkxcXJyRaZMFV2Or7bvC55FfcGK6BVnCEmdOb
	qZY/wWmYZiyk3Mm3FiO4ZHjDxweSLwfYZzhxLbDdFGOf19WvWmndPWFUWG1USCXdF7lVzhFs4FM
	f1LJyIz6mJT+EHD12NeTOx0Tn2pKJ2U+F2mnp8VBtZLzdgssrq+KuYYMhwF+HqiTo18asbLuCqH
	vucZwde3+S8Fmt32sAcSsdqOPH3R+udZpZMOGQSeUPv0YPe1t7G2kAh2a4+7cAhhaEI/WUzuNCY
	=
X-Google-Smtp-Source: AGHT+IFEi1VQJZBeaLcvA0QWHCDrC9Z/yFW8nI3e8ix2zYXXLHY/I3iPzKs2U4U0iv9seYyc17vtsA==
X-Received: by 2002:a05:622a:190c:b0:472:1c0c:e4eb with SMTP id d75a77b69052e-474bc0f42a0mr39002871cf.36.1740754598311;
        Fri, 28 Feb 2025 06:56:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4747242e3adsm25490711cf.65.2025.02.28.06.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:56:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1to1n2-00000000RfZ-3KQI;
	Fri, 28 Feb 2025 10:56:36 -0400
Date: Fri, 28 Feb 2025 10:56:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <20250228145636.GL5011@ziepe.ca>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>

On Thu, Feb 27, 2025 at 08:57:45PM +0530, Vasant Hegde wrote:

>   - If HW has a enforcement required (like AMD SNP case where Secure ATS is
> must), enable secure ATS. But do we need some way to inform core layer? If yes,
> may be have an domain ops similar to def_domain_type() ?

Yeah I think that is probably the best option, some kind of callback
to the drive to check if a platform forced secure ATS is neccessary.

I assume if you need forced secure ATS then you also are disabling
IDENTITY and disabling PASID?

Jason
