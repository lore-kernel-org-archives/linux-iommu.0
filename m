Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78554D10E
	for <iommu@lists.linux.dev>; Mon, 22 Jan 2024 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947972; cv=none; b=V3Hl1+eoyUtX7OX7tr9GC6IfpB9AJIXHNDrRGaMeNrC6BwJep3msLwDSRce5yMN011JeRaORORtNIpzTqOs9qtVX13S3DMftOxJkgqYUEXAgE9NJNq6McmY3K/BKCywmuRMF4FSuEtq2domE+Mk9q0m1+erZxJpDaNcF07HTIaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947972; c=relaxed/simple;
	bh=uSfLoEh/Kxw/2WUjFfpCEtMLO2VA5+zXILz0XUtfoOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MATk9Rfh2/bKmM4gnJD0I0dnQBJUqCKVQKu3HSFPMRA3JqeNiABtZ2A2Cs29TmZIAePoRmNR9BbxZKca06k8SYMogETI/+XYVMCA+UY47xwoYZISJUypi+fJb6cBS7QmpIOdUwd/wUK3fc8qgyhfcTf5ywFTK+0jAGQvA3PIYBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mpjxt9CU; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mpjxt9CU"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e0a64d9449so2245387a34.2
        for <iommu@lists.linux.dev>; Mon, 22 Jan 2024 10:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705947969; x=1706552769; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYin2r9qBO3Rf5FKRY7mx/rCMz+uKJgc4bTRwjAV754=;
        b=mpjxt9CUu3EnsSUTTxyAfu6gVP2U308QL+iHB9TkKcobOYFGp6b3jo6tMGgvyINjaK
         OJ3Jdz5MRWYhStC0FpR3otlBdqm9c2ifMxjRI/VZafKv5AntKLaDvefTVKgAghGjMre+
         TO/aTK4jaxKyxXg6DvURnqH3k7Uw/4zC+SWEgSvwRv3V9N5jUfjzbykHkfhfiTLM2xMO
         M3o+iI7kITQ+sbIhTo2yYoIsKU1xU3X+o/oYgmIj0cJmJBv0JGiGVnTPTwTWTgBuy+Jw
         VgxafoSGgruPgpWSgmPTKv7ZgJw1ddMbA4eeESrsjOOgalc8p9lI9Zm0QuVzXlBdMjoR
         9uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705947969; x=1706552769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYin2r9qBO3Rf5FKRY7mx/rCMz+uKJgc4bTRwjAV754=;
        b=Xxwp25kVjEHGOaTOzRo0s+OPlhFCDl434zDT76hXs6OSZFIRN0GE645gqWad2oXqdj
         KxczZl940+meWxdbRz7v1V1/aJfztNbqZwPQSaJoFsiQWLGYP9PM890mKgJJwjFE6IYC
         Lod+Kcc99lhQKKyZ+0Hvmva/wm39c/p+0cShJTgLecTzTw78iEN7fbQzcJe1k8xAoY+x
         Bg/67nY5KZF7Ky8LCiKymjQvZrn9YjKk27UmBgRr2k3RAMOZBhPgzci+J0vpB5EKmr3e
         3in/VBwIubb1QYK55ptsiS49fcby3k/zOgsanvQDB1/MWMGx/odRXz7xPXpb0tJIz0p4
         2otg==
X-Gm-Message-State: AOJu0Yzg2a2ve9uO6Oes2fT8FsGjoox1rm/xy3K4JP8HATAKjojCq2Is
	xygL3wz/1uTv/lrogYl3WbVK09oXWWLcTFqFDmFEGrd7nfnKCbZI27S7EaQzpkg=
X-Google-Smtp-Source: AGHT+IFeY9y2TeMkrAQHo74R+h7/iR8jY6Rh0h/L3MWA/kPr9/fzEj9pj/xDRjMYEvRUgi9mjiijbw==
X-Received: by 2002:a05:6871:5c4d:b0:214:7e6b:db13 with SMTP id os13-20020a0568715c4d00b002147e6bdb13mr315217oac.47.1705947968678;
        Mon, 22 Jan 2024 10:26:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id e10-20020a056870450a00b00210e313ee4fsm1552679oao.8.2024.01.22.10.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:26:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rRyzn-006xkq-93;
	Mon, 22 Jan 2024 14:26:07 -0400
Date: Mon, 22 Jan 2024 14:26:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 14/17] iommu/amd: Refactor GCR3 table helper functions
Message-ID: <20240122182607.GP50608@ziepe.ca>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
 <20240116165335.6043-15-vasant.hegde@amd.com>
 <20240119195907.GN50608@ziepe.ca>
 <e8f2c380-acb9-bafa-c2b5-5445c0f06a4e@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8f2c380-acb9-bafa-c2b5-5445c0f06a4e@amd.com>

On Mon, Jan 22, 2024 at 03:53:18PM +0530, Vasant Hegde wrote:
> Jason,
> 
> 
> On 1/20/2024 1:29 AM, Jason Gunthorpe wrote:
> > On Tue, Jan 16, 2024 at 04:53:32PM +0000, Vasant Hegde wrote:
> > 
> >> @@ -1738,22 +1744,22 @@ static int get_gcr3_levels(int pasids)
> >>  	return levels ? (DIV_ROUND_UP(levels, 9) - 1) : levels;
> >>  }
> >>  
> >> -/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
> >> -static int setup_gcr3_table(struct protection_domain *domain, int pasids)
> >> +static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
> >> +			    int nid, int pasids)
> >>  {
> >>  	int levels = get_gcr3_levels(pasids);
> >>  
> >>  	if (levels > amd_iommu_max_glx_val)
> >>  		return -EINVAL;
> >>  
> >> -	domain->gcr3_tbl = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
> >> -	if (domain->gcr3_tbl == NULL)
> >> -		return -ENOMEM;
> >> +	if (gcr3_info->gcr3_tbl)
> >> +		return -EBUSY;
> >>  
> >> -	domain->glx      = levels;
> >> -	domain->flags   |= PD_IOMMUV2_MASK;
> >> +	gcr3_info->gcr3_tbl = alloc_pgtable_page(nid, GFP_KERNEL);
> >> +	if (gcr3_info->gcr3_tbl == NULL)
> >> +		return -ENOMEM;
> >>  
> >> -	amd_iommu_domain_update(domain);
> >> +	gcr3_info->glx = levels;
> > 
> > I think this patch should also move the domain_id
> > allocation/deallocation into setup_gcr3_table()/free_gcr3_table()
> 
> We do domain allocation in device attach path only. But GCR3 table
> allocation/setup can happen while enabling SVA (like passthrough -> SVA path).
> Hence I have kept it in attach() path itself.

Huh? That doesn't sound right. Any time you install a GCR3 table into
a DTE you need to get a domain_id *for that GCR3 table*. There is no
other place to get a domain id!?

All this logic should be shared between the pasid and rid attach
paths.

The passthrough thing is only an issue of DTE construction.

If you build a DTE with a GCR3 table and RID=IDENTITY then you set
some bits, and that is it. Detect that case directly when you build
the DTE. It should have no effect on what domain ID is used to tag
translations retrived from a GCR3 table.

(I say that with some trepidation because it isn't clear to me how the
AMD IOMMU caches the DTE entries themselves)

I've said before the DTE construction should be fixed up before making
things more complicated :\

> > It is missing some error handling too
> 
> Where?

See my diff I sent, it was error unwinds around gcr3 table failure.
 
> > And domain_id_is_per_dev() is pretty redundant once you do that. See below
> 
> We need to handle passthrough as well. It doesn't make sense to allocate and
> keep GCR3 table when we are not going to use it.

Then don't, and my diff didn't - but check for the passthrough case
directly against the attached domain as identity.

> > @@ -1902,7 +1911,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
> >  	struct dev_table_entry *dev_table = get_dev_table(iommu);
> >  	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> >  
> > -	if (domain_id_is_per_dev(domain))
> > +	if (gcr3_info && gcr3_info->gcr3_tbl) {
> >  		domid = dev_data->gcr3_info.domid;
> >  	else
> >  		domid = domain->id;

Because here it already has the (gcr3_info && gcr3_info->gcr3_tbl)
test below to decide if the gcr3 will be written to the DTE, so of
course it should be the same test to decide where the domain id comes
from.

> > @@ -2018,15 +2027,10 @@ static int do_attach(struct iommu_dev_data *dev_data,
> >  	domain->dev_iommu[iommu->index] += 1;
> >  	domain->dev_cnt                 += 1;
> >  
> > -	/* Allocate per device domain ID */
> > -	if (domain_id_is_per_dev(domain))
> > -		dev_data->gcr3_info.domid = domain_id_alloc();
> > -

And this gets moved into this test:

> >  	/* Init GCR3 table and update device table */
> >  	if (domain->pd_mode == PD_MODE_V2) {

Here, which is obviously correct at this point as you only need a GCR3
table when installing a V2 table on the RID.

> > @@ -2073,10 +2077,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
> >  	/* decrease reference counters - needs to happen after the flushes */
> >  	domain->dev_iommu[iommu->index] -= 1;
> >  	domain->dev_cnt                 -= 1;
> > -
> > -	/* Free per device domain ID */
> > -	if (domain_id_is_per_dev(domain))
> > -		domain_id_free(dev_data->gcr3_info.domid);

And this got moved into the gcr3 free a few lines up that checked the
pd_mode.

Jason
