Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DFA205E23
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092530; cv=none; b=bUBJb4LSZdqYAqjRyNIrfU5tLNn1SBRVGs/+/Ou+uRQMO4MiKoZfroqDc1juR3doTqqBgTBQBliET7CQLkcLK1MdnnbCytkBqlS6cXgdmSSju3EA4lpJ+g4ixufEPNjM9RZ+emG9alVyJ3gJwh/Y5rawqcbDalC/JHCYMoikP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092530; c=relaxed/simple;
	bh=K78e2OrsMi8B6LhnffW8TOrhQfRP/Vi3FK30qVXcQOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbwzXx9cOlzRH1SOeHVNOLFXNkOBns7TsW0537rC4TvqJ7y0OdUfppPGQTmNI/eMj11lxESih3Aa/O8WsP8Wksjbnnf3NR/8GYjyD3gLC9ybkqw1toXrAonP662hA1TiTvzPg0nVE/ugWlAxHgVIGbLb5Pgf2QuyNubypLy18jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OfHMwVb+; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OfHMwVb+"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5fa17a79dso109892b6e.1
        for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729092528; x=1729697328; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKUDKDxb1lD0KlzXidJGyKdvsct9Zam0VrVdvkKFd1U=;
        b=OfHMwVb+OMx8R8MKnp6OYC4SzAKVHtnqbljk5Bkz293kmD40vyxv9xp7DNcXnguDlH
         omw/kB7Wpd8tRO1N8ONmTxEdg1UDiOYAMOY3MeoMlqslnWywUv0o5UE649GQTuFGEnX7
         lh5+eFhFUN5wmTRDbsWNbBRxm/Dx1OWPJAd2Eec1o+LQjn2VqBnVvwuLWFPvuKTdrQuL
         mmy3wpp2JH4m5+xEDC74xUtgHahVGf2H6hnv4tZT0yU8E+0eVJ7YpjTeiKEXEJ/fgqnd
         2SQvLVtfAj9UqTT/BJH0mY3I/Bde0tv11LKHutCKqRgsTMuSs9KoazElNDn807lZdu1c
         T+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729092528; x=1729697328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKUDKDxb1lD0KlzXidJGyKdvsct9Zam0VrVdvkKFd1U=;
        b=eS5HTzmlEizYsfVIoZ3MOJqozfRAp6RvT2OHEgnz8e8eXErogpK1P42hTjCm9YRsKi
         TO/V3RWw0RwoBqaL1wSym3SwRxfBGHOtAIOPtSvRgpPYo+ntxIoQ8iUVUQ3gInfRoGRZ
         b2Rywd2BTynBbbItmEqp38+GijK+LTxlTU9fr06/eWZvpjKx4Y+7F9XtudtnRSM+usUx
         gxfU6dD1HrgTeJEPREkijUGaLgZILqxdIOb265KnaOZ8ITf24jKUOrx0KnCf92PS0Ge9
         AnmmSfVWf9WsdIMfZ1a3o39cT+RpkASz5ERg73+53ggycyn/ziMB+sqEF1hxxDi8MmQQ
         /GbA==
X-Forwarded-Encrypted: i=1; AJvYcCVSo7wTG3bxrgyhNcz/DXo+MXeEuVAp3hBSskLXKQMOmceEyV8YpaaqUFmsmiMmp3ry+Zrv2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyB3qvGLZ7tHAVuVkPFQeb1XSCV7NouF5y4RcXBHDxavv5qcnPN
	WlbKQ9FCPrPvYFpHGXEUuTeLcfDKOZoqNG6W6e7x/rxrAGlvg5OEBtqPJkTSSfgtKeNoED/Stem
	C
X-Google-Smtp-Source: AGHT+IFHcnb4harKiwb4QPyWAQAfM4Io4+g0luEYbN2Ot1qwfFdwY3NO9Lwik6CkjCoic+sKjHjxAQ==
X-Received: by 2002:a05:6808:188b:b0:3e2:8483:dbe3 with SMTP id 5614622812f47-3e5c91196dbmr14977726b6e.35.1729092528057;
        Wed, 16 Oct 2024 08:28:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22959a7csm18639746d6.100.2024.10.16.08.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:28:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t15x8-0009ct-UK;
	Wed, 16 Oct 2024 12:28:46 -0300
Date: Wed, 16 Oct 2024 12:28:46 -0300
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
Message-ID: <20241016152846.GC4020792@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-7-vasant.hegde@amd.com>
 <BN9PR11MB5276124F430867613D7117E88C452@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241015124018.GG1825128@ziepe.ca>
 <BN9PR11MB52769DE1B3AED678713550D18C462@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769DE1B3AED678713550D18C462@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Oct 16, 2024 at 02:48:04AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Tuesday, October 15, 2024 8:40 PM
> > 
> > On Tue, Oct 15, 2024 at 08:41:48AM +0000, Tian, Kevin wrote:
> > 
> > > > -	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
> > > > +	/* Allocate v2 page table if IOMMU and device supports PASID. */
> > > > +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
> > > > +		if (!amd_iommu_pasid_supported() ||
> > > > +		    !pdev_pasid_supported(dev_data))
> > > > +			return ERR_PTR(-EINVAL);
> > >
> > > Just check the iommu capability here? IMHO it's a sane case to first
> > > create a PASID-compatible domain for a device which doesn't support
> > > PASID and then attach the domain to a PASID-capable device later.
> > 
> > The point of this series is to allow AMD to select the v1 format as
> > often as possible because v1 has better performance than v2
>
> If the user wants better performance then it should not set the flag.

Well, I do tend to agree with that, you mean remove the
pdev_pasid_supported() ?

Jason
