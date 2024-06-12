Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8758173334
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197560; cv=none; b=t77HuMDdjz5Oh+DKisiM8ZJhbFaQFpwvimeBF7aMEWGKBsBqZagya/ahKTM+liNVr/XqjpqCEJZzTLUIN/ixC65VMFscznMjHJIj4zZdNEs/SmMUKtZv8KEx3A6z7QYSlbjeHSnGvWoNL4uVGkRz13MNwPLuoN1OqKmGAGB3kQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197560; c=relaxed/simple;
	bh=ZEtvmtKABe5cseBf1TQXddb/XlidEBvU7pk6GOUuaPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOHguNHgPGgKOei2irzNvng8SkgJBz0WcHLdYoqGjU89pZYjEXcMCjAvTmusPCmANCw1gHP5DP8Gxoq2QzqhIMCT13eSLVcCacxYfBCGV94/J4eFNWG1nx0yKjeOBDNATwEVLAnaFzQ6tUcHp5WAXgHnH44gT+QXyPm7fR5soBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BB40SriG; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BB40SriG"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7960454db4fso187030985a.2
        for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718197558; x=1718802358; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5+L89ZKqGUTpMf1suZvMFendyezHPKfwgJALrCf+rE=;
        b=BB40SriGWumRCvlCnuKq03ysM8W/L6fT2NXbiMpIsyznIGhBhr+TBmIbFFy12Gl25e
         bFXGYO/omZyZyzmOMSgqjkVRsz3C+PJb+lLbp0jDN9fdk+PkzFhole249eBW6STSpTeu
         xLsWajG78nr7OhGZJLmoy2O3u87n+j0MZsHch5wKsaQRLwAstjZRwCO2ObovmJDZZijQ
         Tnhs7jTbCA8Dlx/S0pGG7kvvgqSoI4Tt+cTUGQoCC5hgVS1TFyyNHfDCtIp00BbMv+Hg
         A1iPAq7UFTcITCJJBD+JgXeYMfUY9oVfEiE1uksszV/Cw/fGCEVM6OdWR//LEHT4vkgU
         q9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197558; x=1718802358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5+L89ZKqGUTpMf1suZvMFendyezHPKfwgJALrCf+rE=;
        b=SlE6/s70f0khV9L4qjnKkZpZlTEz1ML/oXEs1vceKjA9wk8miPZVqe6COO7m5gIIbr
         mx5/XDXmdLoSI79PGKZwaBczss6r+NP9ld8m1BrZrWVeCVRQqvCSGs36rULu2xstv2s9
         K8kLN0U3ibRYukxtKDxgQl1myqFPa21SqojvkY+sHQ7gRm4c2m9C7Vudu3SeQ4RtUc3b
         uaH9J73MZx8yn8y45gH9yRf4KKLFUWVWUlMuFEJpNZMQWdLmM1km7497ASOV0vE+SBZw
         UjKsQtjeyYSn5wyBR4ByqB16ppkH4SPNoGeEkoVi6U8dQuWycSvQgSh+ubXC5ZIBIKrf
         n6Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVNEVlMPwGID6bI1RYljOw8ZUl7/Mjs8brcurROBqauNHnfQhjwP5asRtsFQGs3FFUVjg182n52PGY750IfzpdiK4gUVfo=
X-Gm-Message-State: AOJu0YwQbzbtpc0A8WjEDY2w/TvXlHqx8fZJsnLHwLh7GrcMNW4ZhcDb
	okX9bSjIxlaG/a9SIEfyPIr2X+yrI7dMT8rEwdXa9fMBb6tN9vk5oPFUt3D7eyA=
X-Google-Smtp-Source: AGHT+IG1BTvMWtYF5LbHSWwvjvLFjW6jHuSKJ/rLzRBprtYaUFP9m1zLl5I+VkR+7lmlXV4LBkzoeA==
X-Received: by 2002:a05:620a:4155:b0:78f:a08:64fc with SMTP id af79cd13be357-797f6011308mr167864085a.30.1718197557266;
        Wed, 12 Jun 2024 06:05:57 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955973b340sm369859385a.4.2024.06.12.06.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:05:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHNfm-008n9h-Pf;
	Wed, 12 Jun 2024 10:05:54 -0300
Date: Wed, 12 Jun 2024 10:05:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 02/10] iommu: Remove sva handle list
Message-ID: <20240612130554.GR791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527658A85092F88329EB73E98CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <afaf133b-7175-467f-a254-060b66b9cb4e@linux.intel.com>
 <BN9PR11MB527693E470478D92564A31718CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527693E470478D92564A31718CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Jun 07, 2024 at 09:35:23AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Thursday, June 6, 2024 2:07 PM
> > 
> > On 6/5/24 4:15 PM, Tian, Kevin wrote:
> > >> From: Lu Baolu <baolu.lu@linux.intel.com>
> > >> Sent: Monday, May 27, 2024 12:05 PM
> > >>
> > >> -	list_for_each_entry(handle, &mm->iommu_mm->sva_handles,
> > >> handle_item) {
> > >> -		if (handle->dev == dev) {
> > >> -			refcount_inc(&handle->users);
> > >> -			mutex_unlock(&iommu_sva_lock);
> > >> -			return handle;
> > >> -		}
> > >> +	/* A bond already exists, just take a reference`. */
> > >> +	attach_handle = iommu_attach_handle_get(group, iommu_mm-
> > >>> pasid, IOMMU_DOMAIN_SVA);
> > >> +	if (!IS_ERR(attach_handle)) {
> > >> +		handle = container_of(attach_handle, struct iommu_sva,
> > >> handle);
> > >> +		refcount_inc(&handle->users);
> > >> +		mutex_unlock(&iommu_sva_lock);
> > >> +		return handle;
> > >>   	}
> > >
> > > It's counter-intuitive to move forward when an error is returned.
> > >
> > > e.g. if it's -EBUSY indicating the pasid already used for another type then
> > > following attempts shouldn't been tried.

Yes, it looks like iommu_sva_bind_device() should fail with EBUSY if
the PASID is already in use and is not exactly the same SVA as being
asked for here.

It will eventually do this naturally when iommu_attach_device_pasid()
is called with an in-use PASID, but may as well do it here for
clarity.

Also, is there a missing test for the same mm too?

I'd maybe change iommu_attach_handle() to return NULL if there is no
handle and then write it like:

if (IS_ERR(attach_handle) && PTR_ERR(attach_handle) != -ENOENT) {
	ret = PTR_ERR(attach_handle);
	goto out_unlock;
}

if (!IS_ERR(attach_handle) && attach_handle->domain->mm == mm) {
   /* Can re-use the existing SVA attachment */
}

> > > Does it suggest that having the caller to always provide a handle
> > > makes more sense?

I was thinking no just to avoid memory allocation.. But how does the
caller not provide a handle? My original draft of this concept used an
XA_MARK to indicate if the xarray pointed to a handle or a domain

This seems to require the handle:

-	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
-	if (curr) {
-		ret = xa_err(curr) ? : -EBUSY;
+	ret = xa_insert(&group->pasid_array, pasid, handle, GFP_KERNEL);

Confused.

> > I'm neutral on this since only sva bind and iopf path delivery currently
> > require an attach handle.
> 
> let's hear Jason's opinion.

At least iommu_attach_handle_get() should not return NULL if there is
no handle, it should return EBUSY as though it couldn't match the
type.

Jason
