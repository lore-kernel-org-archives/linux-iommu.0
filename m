Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4531914D6E6
	for <iommu@lists.linux.dev>; Thu, 11 Apr 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842944; cv=none; b=gUYkG0E9rQ5XmSb558EVsb9zQKu4v2A2WAA4zFl1ZnGToHrfwHojFhFlQzK1db0j+BN+NdXQBau98xW41Mli67JxaSUMMPXOtzLA1siMJPnqUPM5VdmfIhwG97VtTka3XInl1HTgdAAVEwBsvDziF23+augoS3aeRQrDQYsy/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842944; c=relaxed/simple;
	bh=zgR0cR6ogn8YFChqfla+EM8IAhBegygR7tw+SMxmgNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFAQcZM6McWrRQQQzxM6UGbSy85HGDqOzPWHv7U1SGKWgaFI4EiqxR72hnGX3Pb2EjtfPyMwUoKKUeSC19atw+iKFdc0Ymy7zYVEfWIas3w0y0BeFHoq6FCI9Lxdz2SVJTbnlhUkn36jWFS8bVwQCLbTsz/7mEDJB3bQ9pvXNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=N/VwAF5U; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N/VwAF5U"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-434a6024e2fso7104081cf.0
        for <iommu@lists.linux.dev>; Thu, 11 Apr 2024 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712842942; x=1713447742; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFCmlim2ishqWRIA11SEYbkXYRYiuK5KGvMdScupqjg=;
        b=N/VwAF5U3SaHTshDHjATfQJGP1Gv8l4mTGyC3fvAMOS7+NUxSbNFc2ojqLCMsBGQ81
         /k6sdVP5cKyhTUBt3suhYP4YdQi8l0jPxorpQ2a/Wn2xH85Dq0gjM3/zwPKKLy3/tF2n
         /B/Rlc8ievjZbTITcYU6yMNyBobMw1wSJC7vfcFoULcc5e8geUmvvTL90kgBYhWYctf+
         qgFHs31CPPMxsXA+dejH+MFAU9hxNo/UOwq4bQ1kBwhvHCOHX9viNhyuTjHboK6Iqhsb
         xMzu/TtsN40DYkIRfZ8dBUrjfj/aa9J14P3hgiyx6XpwqYsq99JJhQAB0OS22+iegCs1
         O63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842942; x=1713447742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFCmlim2ishqWRIA11SEYbkXYRYiuK5KGvMdScupqjg=;
        b=Ro8H/zODNgEfmVvFlEBGKEe9Z22Feod5B667CJP75IAGPVCgYeRI4tBHXnqvtwOlAh
         MDvG2DseWF1nUUNIVEFqvxcmsBHFkjz8EnolUZbXlkiw3YyDKjeuu+/+KsLLtMTukfQo
         M54kN6s1+9tvD96RTHDBR04Kb2t2wp1NewPnQ2gad4Vul9xruEE1j5hvfc+BR+kQ6U+U
         CeyPocWBgR+D2EGw/LFMf2qhDSagv57RyKLOfHuUZPBZ+n0lnxW7FSx5KEhPJZ5qAHgw
         1w6/R1zI6RZPgpU+OziTj1qRG1QHoypgvGiGENP+sJiRgCtcq75nrt6/sCSCfh1Uxswn
         HZUw==
X-Forwarded-Encrypted: i=1; AJvYcCWYSvybR2bsFuuGf/QrVWZQEO5+BeAp7JvGwM8XdLaVea59m2F6sRbJSbF46VCuyk4yqozvxcGpO1jBLOK0nBCA46kTmfk=
X-Gm-Message-State: AOJu0Yzuw+cjHUf2VkvlHjKosaVHDUpQD6RYXFgcgeAJL5YkRh2i7paK
	SdmkFA9G8f8Kjc7gxCUD2EECuB3N3i7++o6l2EkS78gPjxHv5Tm6EWWBwu0fYRA=
X-Google-Smtp-Source: AGHT+IGL2cbOKCZcGzgMbJlL2z68v+tK6zD101PWXggW/pcyy1RmCVHxVJqaYVopM1k3wQoJqHy5qA==
X-Received: by 2002:a05:622a:138e:b0:435:fff2:2d57 with SMTP id o14-20020a05622a138e00b00435fff22d57mr4397147qtk.22.1712842942315;
        Thu, 11 Apr 2024 06:42:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id jr13-20020a05622a800d00b00434c25cb61bsm912364qtb.73.2024.04.11.06.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:42:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ruuh3-00AkQa-C8;
	Thu, 11 Apr 2024 10:42:21 -0300
Date: Thu, 11 Apr 2024 10:42:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Zhang, Tina" <tina.zhang@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
Message-ID: <20240411134221.GL223006@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-2-baolu.lu@linux.intel.com>
 <20240410154134.GG223006@ziepe.ca>
 <BN9PR11MB5276B57D6E72870C9B1798838C062@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4e47aff7-aa65-4c60-a5dc-b7e0f2737a3e@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e47aff7-aa65-4c60-a5dc-b7e0f2737a3e@linux.intel.com>

On Thu, Apr 11, 2024 at 09:17:41PM +0800, Baolu Lu wrote:
> On 2024/4/11 7:14, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Wednesday, April 10, 2024 11:42 PM
> > > 
> > > On Mon, Mar 25, 2024 at 10:16:54AM +0800, Lu Baolu wrote:
> > > > +static int __cache_tag_assign_parent_domain(struct dmar_domain
> > > *domain, u16 did,
> > > > +					    struct device *dev, ioasid_t pasid)
> > > > +{
> > > > +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> > > > +	int ret;
> > > > +
> > > > +	ret = cache_tag_assign(domain, did, dev, pasid,
> > > CACHE_TAG_TYPE_PARENT_IOTLB);
> > > > +	if (ret || !info->ats_enabled)
> > > > +		return ret;
> > > 
> > > I'm not sure I understood the point of PARENT_IOTLB? I didn't see any
> > > different implementation?
> > > 
> > > Isn't this backwards though? Each domain should have a list of things
> > > to invalidate if the domain itself changes.
> > > 
> > > So the nesting parent should have a list of CHILD_DEVTLB's that need
> > > cleaning. That list is changed when the nesting domains are attached
> > > to something.
> > > 
> > 
> > probably just a naming confusion. it's called PARENT_IOTLB from the
> > angle that this domain is used as a parent domain but actually it
> > tracks the child tags in nested attach.
> 
> Is NESTING_IOTLB more readable?

Yes

Jason
