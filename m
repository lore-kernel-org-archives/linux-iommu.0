Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18601DFE8
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892499; cv=none; b=IKGWE0KqL2FD5HP6Xw8J+eM4yCsCBfwt9Ev2jx5fOcuLNq1+R5Gj8ZCp4EZGaVYN38FSomlbZKXQprFCXV6xnj158GgCgIXrYBKaQXMOplWi6f0n7hdVr9SUvY+a5PfimQq8uQuAMskE308inJBWDNzn4FjUh+tTi6cNfDFG0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892499; c=relaxed/simple;
	bh=B47SgIqbSB00u221uMK8Vw5yzOxFWsVrlvLPqZEOCxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rU/5yqedumsgs6Zm4eAS/yjgn3RedsSCT9x01tZvxE+zAAdHFrp3xo7sa8nOyEalfAD2QLWEI1tXshHH9JN2A52osfup6rLR9IdEGPL+/48RiPXlZtIYLo2fIrDnqxLxy+Vnnj4S86CBiAG0P9HDm4GRVLf5NHyZGDQPbGmMK+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NbmeYqKQ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NbmeYqKQ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-440f035214eso3610271cf.2
        for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 07:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718892497; x=1719497297; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CMDDK90K5EY+TuhzS7B/+ikXyLQKO9WMDlCewe0WKSU=;
        b=NbmeYqKQ9HBb9PexaTTzBGcvfPb63yk2NQPSjZPhUtJwfUvjhXaQToSw7LG8d3Odjz
         Jd/REpQ32UQgi1XKxEHIXSMfVM3tLaOjUbPy9f2i6G+H50BORudBBctd3YdYYspzfOpf
         VFIRuzjgF2h3KEgF+6eEbYzwVGteRTUarHy3hrCj+D6p2AR/NMk0Bid22m8d9onPPIyq
         mMIG6wP0MLBzARKwILrerL9vuqOW77LM9jtfBya9KkY95bDEIrKGapHAoTZKV0He5h6L
         MVvkPMARagQUoWc3/eHEK6dC2IUrK90tC+qqcLrokFdjjYkudJ+U5bECIBWq0q4n7cgL
         Qp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718892497; x=1719497297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMDDK90K5EY+TuhzS7B/+ikXyLQKO9WMDlCewe0WKSU=;
        b=k/iwE3hnnSPcWHhkfeHAqeHvf3w/FkXtACuuB5T/Fxn3Q52RoHo0h/fWEbp1Ijyeig
         7oy0HOxIiYFRdAsVUwL/UCq+OViSHGSSlY+6tVLReh0KGddV0b4V1Qz/kNLuHlXAPTG7
         yj10IxCp+bZb0g290/+0qRnFHKjl8wT8TM0ioow6cgrcWRnyuHtOD4CvI0lqWqEuL7bb
         H2XAidSef9JGbtsELckQrXVvRgHsBPwLvPRPiP7yEz6dSpOQqCheDG96jYWxc1K9dTHU
         mSuJ6OfPCdH4Woc7FsePDa3V3h4LeHpt0CaGaO6+CKlndNftZtEdwHgmVGUFaQbsq04W
         jEVw==
X-Forwarded-Encrypted: i=1; AJvYcCXUN+5GQy/OuXGdzneZlUvaMjfUJlB7EykHLPSDTxa6Q6bV6Hzq1NRGs4PusegGIAFEroFUA2e3eaYeZ8Jb0aPF8kJEPCU=
X-Gm-Message-State: AOJu0Yygkk1VmHCrtQj4I8amUAOk/zFwcvdSDqbEdIbxCgZ868tKgoQf
	j9TiF9cqK89RWyujRCqKGbxYUG8qHimA11ibXDQIEBQ9CLGcJI+RHGHrZIeG42s=
X-Google-Smtp-Source: AGHT+IF4IHIPiAoTsiSHrRXmlCAb4nycBoVhRBEtMZdywLymmZWk3beckDjDTiTYRXH2I5Eb7fWUXg==
X-Received: by 2002:a05:622a:38a:b0:444:976a:4a86 with SMTP id d75a77b69052e-444a7a890f9mr57015841cf.64.1718892496659;
        Thu, 20 Jun 2024 07:08:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef4de0ecsm75638751cf.9.2024.06.20.07.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:08:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sKISV-00B4in-7A;
	Thu, 20 Jun 2024 11:08:15 -0300
Date: Thu, 20 Jun 2024 11:08:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
Message-ID: <20240620140815.GO791043@ziepe.ca>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
 <20240619164620.GN791043@ziepe.ca>
 <1dfb467d-f25a-4270-8a36-a048f061e2aa@linux.intel.com>
 <BN9PR11MB5276F76798E61D231D861A2F8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <976d4054-6306-4325-a112-5cf69b0c6f34@linux.intel.com>
 <bdbb40da-faa5-4321-a58b-5fcffcbc818c@amd.com>
 <8c78f966-539c-4c81-92a6-32d32bb10e8b@linux.intel.com>
 <657c7e03-91ef-4765-be7c-1f57eb45e467@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657c7e03-91ef-4765-be7c-1f57eb45e467@amd.com>

On Thu, Jun 20, 2024 at 04:19:46PM +0530, Vasant Hegde wrote:
> >>>> seems that for all domain attaches above is coded in a wrong order
> >>>> as ats is enabled after the cache tag is assigned.
> >>> Yes, exactly. But simply changing the order isn't future-proof,
> >>> considering ATS control will eventually be moved out of iommu drivers.
> >> [Unrelated to this patch]
> >>
> >> You mean ATS setup will be moved to individual device driver? Is there any
> >> reason for that?
> > 
> > Not exactly to individual device drivers, but it should be out of the
> > iommu drivers.
> > 
> > https://lore.kernel.org/linux-iommu/BL1PR12MB51441FC4303BD0442EDB7A9CF7FFA@BL1PR12MB5144.namprd12.prod.outlook.com/
> 
> Got it. Thanks.
> 
> I remember of this discussion. May be we can provide API from IOMMU driver so
> that individual driver can enable/disable ATS (like iommu_dev_enable_feature()).

But I have a feeling if we do that it should be done by re-attaching
the domain.

For instance if you look at how I structued SMMUv3, the ATSness is an
effective property of the domain type and ATS switches on and off
dynamically already.

Having an additional input to domain attach "inhibit ats", as a flag
would be all the support the driver would need to provide for the core
code to manage this with some kind of global policy.

I would suggest to steer VTD in that direction too and make the ATS
enable be done on domain attach, and put the first ATS enable in
attach, not in probe. The logic in smmuv3 would apply just as well to
VTD, though you'd need the hitless update logic too :)

Jason
