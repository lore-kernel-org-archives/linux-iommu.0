Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC318134C3
	for <iommu@lists.linux.dev>; Tue,  6 Feb 2024 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240901; cv=none; b=u9HeKxddyLqFTkbJNJENXNjt007U/TrSybNV3PsSZsuGwWUr/Dh1g963ObBp2FjaLNn+snahCNKlDMA1TexwqXm4izdWD69cvb2JdWooWkwviXZK0hnAOCD9kH5ek8nzXEEgEEsYEuGSCJU0aq1so4H/cyOXJjaEDRfUAz7UyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240901; c=relaxed/simple;
	bh=JLdsc+Ra291K5HYsrdGCYeFf+phA7j5EVTv4W1kgJk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFJVEU1gAaMgqJqtfzdcW4fvSwpjNO+tcLJwSJyFnRoia+JXbSQJFGxiiSs/pN2TvRNoR5/7OY0TgJ8SdR5DlaAZFYX8o7BjpxS7s+AaaYDLmFKIvNXfCV6uOf9kzawOBCs2XKBFFYIc4bECJL1rf25GZexSdLPn8Hf+Lk+FUlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cB+6K25I; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cB+6K25I"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2185a9966bcso376499fac.0
        for <iommu@lists.linux.dev>; Tue, 06 Feb 2024 09:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707240899; x=1707845699; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8RO1efz47TJpCoNoxnw/RTJO2p3kKiaEZAkuLupQO4Q=;
        b=cB+6K25Ixdo1QmZ4RJDhpAl03StNMuEVIaMXh5+iIGk3ecrqDAT1Vp/GZ9ht4g1vmY
         gyCveebV9FmffoiUiyBQX/mn62Qs4zqi8PnVAmCKKwdD2d6o3CG3lL4OSfPVA6DaW+RV
         Il4HewobAnXoKcCelXvkZ0+YywqXufyU5Toh0y7onK5a4F3t/nq/oFRvFCZv8D1hpv2q
         JMKLauWtY6kexAMaeMnv5ezgvCbsgHXqgt5QCpAAVmWPdcAAph5BLAUAe05IcLRKdTL8
         N2udjFPBhr6G8vVGLEM2wt7l/IZSRPTlh8btm85zapMP2qribCfLB7Rz0pBV/NlJ9vp7
         tVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240899; x=1707845699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RO1efz47TJpCoNoxnw/RTJO2p3kKiaEZAkuLupQO4Q=;
        b=rwWeCvjnZDNUtNO2nDFwV8K17Gjk0sRDtYgJIK+4P8yGsSCZ3xLqQJkfQIvU/Yy9ct
         sYVEbf7ZpXlzP/pH7A+rlOzfKDnjLf2cRs6FtR8ifvBz7J5H8z7LBNv2a2zGeA5vNRVD
         cDb7pkWl2Al0tKejfy0ezhDFOJtRNCKXZ0oKUUti8vIYk3JsKgY7uHi/YnLMS4BRxX6C
         UPkwo87oFPf6h7uObMcMrBrYFoiO84OzPmHNUD7W5xJ6Y6O1RyMjfCT3OzdsOEMULZwY
         qFWknLmdCIejBq/0M6SLhFEXTGrLKEhpMd/EbklAnqA21G5KWaXmx8Kj+ltAPGzK34VR
         PEFA==
X-Gm-Message-State: AOJu0YxcIOQyWKN3OCNk9CC4M2i8aNidL2ECgTyP3AgINjtj6pdTHdWz
	yCrdNDhlOLmYpK+iZLqOUgfnEbUgUUCwiwuz7E8oVGuL1WG8yse/f9YXf6RM/qE=
X-Google-Smtp-Source: AGHT+IHdYlTX+fKpIfvN9aKEkoG+b0l2ganT4VVZn8VzRC8Dfh6FUEQebZDlThe32myaVC220eFN4w==
X-Received: by 2002:a05:6870:a10c:b0:218:cc0b:f5f1 with SMTP id m12-20020a056870a10c00b00218cc0bf5f1mr4465252oae.4.1707240898769;
        Tue, 06 Feb 2024 09:34:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVpQ7/fdVGvcEqGHjBRzpZhRAMhVLvwHBiIzv/8T/5tpQimfFrUwmKiWOG/RyPEbmpm75iMYMgTFa4KP5Q+YqS4Moej+RvrtiBufelDtDyiJJ7PyL5LYyZAzuJHGXSJLWIGbtqf8p7lw3i5oPJ4xi7g9pOy5xsFEeIJjGpXe8KF0q85dxpiQjk=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id e18-20020a056870451200b00219b86b32b6sm212753oao.46.2024.02.06.09.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:34:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rXPLV-002rAQ-9M;
	Tue, 06 Feb 2024 13:34:57 -0400
Date: Tue, 6 Feb 2024 13:34:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 12/14] iommu/amd: Initial SVA support for AMD IOMMU
Message-ID: <20240206173457.GH31743@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-13-vasant.hegde@amd.com>
 <20240202152524.GA2606743@ziepe.ca>
 <f36ea0af-23db-7653-32e0-0a7b3941f801@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f36ea0af-23db-7653-32e0-0a7b3941f801@amd.com>

On Tue, Feb 06, 2024 at 10:46:58PM +0530, Vasant Hegde wrote:
> Jason,
> 
> 
> On 2/2/2024 8:55 PM, Jason Gunthorpe wrote:
> > On Thu, Jan 18, 2024 at 07:33:37AM +0000, Vasant Hegde wrote:
> > 
> >> +static int iommu_pasid_enable(struct iommu_dev_data *dev_data)
> >> +{
> >> +	struct device *dev = dev_data->dev;
> >> +	int ret = 0;
> >> +
> >> +	spin_lock(&dev_data->lock);
> >> +
> >> +	if (is_pasid_enabled(dev_data))
> >> +		goto out;
> >> +
> >> +	if (!amd_iommu_pasid_supported()) {
> >> +		ret = -ENODEV;
> >> +		goto out;
> >> +	}
> >> +
> >> +	/* attach_device path enables device PASID feature */
> >> +	if (!dev_data->pasid_enabled) {
> > 
> > How many times are we testing for this? Just check if the gcr3 table
> > is installed once
> 
> One time for IOMMU capability (amd_iommu_pasid_supported()) and one time for
> device capability.

Again I think this whole thing is out of sequence. The main focus
should be on the gcr3 table. You should dirctly know if it has been
installed or not via some direct means. Test all this stuff when you
go to install it the first time.

> is_pasid_enabled() is checked twice (once without lock, so that we can avoid
> lock in most cases and one inside lock to be sure no one else entered and
> enabled gcr3).

That never works, don't do that.

> 
> > 
> >> +		ret = -EINVAL;
> >> +		goto out;
> >> +	}
> >> +
> >> +	ret = amd_iommu_gcr3_init(dev_data, dev->iommu->max_pasids);
> >> +
> >> +out:
> >> +	spin_unlock(&dev_data->lock);
> >> +	return ret;
> >> +}
> > 
> > This seems like too much, and it doesn't need to be in a function..
> > 
> > 1) Check directly if the gcr3 table is installed otherwise try to
> > install it. That might be a usefull function
> 
> We need other checks to make sure both IOMMU and device is capable of PASID.
> Hence its a separate function.

That should be done at probe time and cached in the per-device max
pasid valid. It is 0 if there is no pasid support.

> > 2) Precompute the max pasids during device probe and store it in
> > iommu_dev_data. Just check if PASID >= max_pasid and fail
> 
> This is not required .. as set_dev_pasid() can directly check
> dev->iommu->max_pasids.

That is not the same thing, dev->iommu->max_pasids is the PCI/DT
capability only.

The driver still has to keep its own internal limit.

It is goofy and we should probably merge the driver limit and the core
limit at some point - until then it is better to follow the pattern
and keep a driver limit in the driver, doing all the work at probe
time not during attach.

> >> +static void remove_dev_pasid(struct pdom_dev_data *pdom_dev_data)
> >> +{
> >> +	/* Update GCR3 table and flush IOTLB */
> >> +	amd_iommu_clear_gcr3(pdom_dev_data->dev_data, pdom_dev_data->pasid);
> > 
> > This is in the wrong place, there is only one DTE/GCR3 remove_dev is
> > touching. The list iteration below is just to clean up the tracking
> > list it should not touch HW. Move this up into
> > amd_iommu_remove_dev_pasid.
> 
> This is used in remove_dev_pasid and sva_mn_release path.
> 
> This just clears GCR3[pasid] entry. Its not updating DTE.

Same argument, it should not be iterating, there is only ever one.

The release path is not removing the PASID, it is just disabling the
GCR3 entry. The domain is still logically connected to that PASID as
far as everything else is concerned.

> > And these functions related to the tracking list should be more
> > general and called in more places. Just the tracking list itself
> > should have a few patches to create it and situate it generically in
> > the driver. Even the RID should be using the same mechanism.
> 
> That's after reworking protection domain structure. Not in this series.

:( I wish you'd get this stuff cleaned up properly first instead of
building more mess on top of the wrong design.
 
> >> +	/* Setup GCR3 table */
> >> +	ret = amd_iommu_set_gcr3(dev_data, pasid,
> >> +				 iommu_virt_to_phys(domain->mm->pgd));
> >> +	if (ret) {
> >> +		kfree(pdom_dev_data);
> >> +		return ret;
> >> +	}
> >> +
> >> +	spin_lock_irqsave(&sva_pdom->lock, flags);
> >> +	list_add(&pdom_dev_data->list, &sva_pdom->dev_data_list);
> >> +	spin_unlock_irqrestore(&sva_pdom->lock, flags);
> > 
> > This doesn't seem right? The tracking list should be loaded before any
> > change is made visible to the HW, or at least under the same lock.
> 
> Ok. I can move that up and then have error handler path to remove it.

Because, like this shows, it is hard to get it all right and it is
even harder when everything is not consistent and there are two
versions of the same flows.

Jason
