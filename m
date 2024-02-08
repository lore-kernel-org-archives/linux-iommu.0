Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A882D65
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414123; cv=none; b=Ct7v8iLDwoVfLXtRErnH0iZbgByXF8y9fv5OBM9+Xc35kIOD5SNe5vdvxzrWZ4aPUFYHHDZkn2Tt6Grs3xyMciL8jD5zZ6nWGx+Iv7B+OpkFS5H93Sq+NRB5lYdxg7TMSVv/kV7alI/tuLAUwoRGypB4urxYbNsryYNvtQd1DK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414123; c=relaxed/simple;
	bh=r4fat6B4yH0ovyam02B3ZCQCmIKM9Ggo6UqmKZ649Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUV3Paw/Z1aiGvjkocZ+jBQDv1i9IGAnxekoJeqEtdo/ng98RXFPGicdwCEsVjhg+zmI8Cgs2GY74ZOVr/06d0zT9c5HIQWCkIK2FuEt6/yuAjTze77V+h5R0M1OLB7BP7jXBahAo4+7MOhuh/6bJu3WwkS4pD1jgBPdj/vAW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dK1snU3t; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dK1snU3t"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-595b3644acbso521361eaf.1
        for <iommu@lists.linux.dev>; Thu, 08 Feb 2024 09:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707414120; x=1708018920; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ju0dQeyZLQE8P97uXThaBlttCLmdzcSF7glU4KjKvTA=;
        b=dK1snU3tSlrlE8ZjD8vYKpcyGDzhzNwAWYPalab0NV56/DKXeyyz7faTQewcRCJ3YO
         w07WDUouiFayJuiBg6dO/7gH7DbkZ7NfojWy7NeHKPOP8YqQ81ZMfQU43bGh7nocob/Q
         IABMESh9vg8RXq/34vnqzvFoLiC2vCg5VUsx8DuieqJRc5tkPbcxmSSz2JXY8tBOU6q3
         Mwcy0fyCwH6vDQZRTRMIW+z959ERICrHFj+usvIY+UhTMsqNhR7w163OIBmFmJmHJxvb
         OHtDsxvPfZJSWyYnD499ip2IpgZ4CQmZBnfa7cVi885q8rr54s4zyW96w67W+iMEvGOu
         9vdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414120; x=1708018920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ju0dQeyZLQE8P97uXThaBlttCLmdzcSF7glU4KjKvTA=;
        b=XtzY2n3s0VbZyjpYVZJ0t1vh7fC2HRLHAH+KnralRLtYpcH2DhYu98LPec+t3ElyOt
         jjVc4UNVu4ppgxBVVAlhQGP+KPOEnyMEISBHLfTBZHZDtP8f1XoHLw2V4fv+VfDcGfdU
         LfvfizQGob2UBMVjQksgplh/ApUSfzjdnFLch12KKmkTxcVjC4UUk2LXy6MSz4XfRxDY
         tpuZipQe5IgZI88O1RYmN9X9dQpJf72YCfqrmo+sETbPQuQh4uUQzfakoPhkKvkL8qsV
         kEZ3sY6ayiR/rqUGjEa6lM13oU3HQ2ARGcfX8CgDBCVKMs1RUyB1crmdatCcUicIKiR3
         2+2g==
X-Gm-Message-State: AOJu0YyI3WF18ZRarBUSejR7cTcG0/ltM1A7dlT1OviacgBv4SalYf8e
	NoK/QbQKiFuq4kW2SqHW3KP97HiiVOpJ9GRsdjs9yaTErlgIXPvwTp6aXUMJj0M=
X-Google-Smtp-Source: AGHT+IF+dwKt/IxDbhZHi+ZIc5w0rgYHg2odtPDAW3ZS4AteLq7jZ9BZ2MHt2JtGq0uGaSNR/l1NNw==
X-Received: by 2002:a05:6870:2b12:b0:219:8a03:e671 with SMTP id ld18-20020a0568702b1200b002198a03e671mr164540oab.4.1707414120466;
        Thu, 08 Feb 2024 09:42:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhEuRhmMzp6GJFGt1hDJxMzhfyZUciDrohJ93/xYs5lKDDlEQkmql0ugw6oB0t82vOnusZ5lNg1cZrSqUpJrp8xcOPJxDglz9w+ziW4y6jY+oZLGIXeaIRed6qXZ2GPzTIEfrCYvWa5+ZDmsMDrNzX1CFBg113RjopDSr0Z/WnNLcsZ3G7SE0=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id oo26-20020a0568715a9a00b0021998dc2bf1sm10599oac.36.2024.02.08.09.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:42:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rY8PP-00FJfW-6i;
	Thu, 08 Feb 2024 13:41:59 -0400
Date: Thu, 8 Feb 2024 13:41:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 12/14] iommu/amd: Initial SVA support for AMD IOMMU
Message-ID: <20240208174159.GW31743@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-13-vasant.hegde@amd.com>
 <20240202152524.GA2606743@ziepe.ca>
 <f36ea0af-23db-7653-32e0-0a7b3941f801@amd.com>
 <20240206173457.GH31743@ziepe.ca>
 <0af9b44f-c78a-7e79-5c10-fe8d6e92f5bc@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0af9b44f-c78a-7e79-5c10-fe8d6e92f5bc@amd.com>

On Wed, Feb 07, 2024 at 03:01:22PM +0530, Vasant Hegde wrote:
> Jason,
> 
> 
> On 2/6/2024 11:04 PM, Jason Gunthorpe wrote:
> > On Tue, Feb 06, 2024 at 10:46:58PM +0530, Vasant Hegde wrote:
> >> Jason,
> >>
> >>
> >> On 2/2/2024 8:55 PM, Jason Gunthorpe wrote:
> >>> On Thu, Jan 18, 2024 at 07:33:37AM +0000, Vasant Hegde wrote:
> >>>
> >>>> +static int iommu_pasid_enable(struct iommu_dev_data *dev_data)
> >>>> +{
> >>>> +	struct device *dev = dev_data->dev;
> >>>> +	int ret = 0;
> >>>> +
> >>>> +	spin_lock(&dev_data->lock);
> >>>> +
> >>>> +	if (is_pasid_enabled(dev_data))
> >>>> +		goto out;
> >>>> +
> >>>> +	if (!amd_iommu_pasid_supported()) {
> >>>> +		ret = -ENODEV;
> >>>> +		goto out;
> >>>> +	}
> >>>> +
> >>>> +	/* attach_device path enables device PASID feature */
> >>>> +	if (!dev_data->pasid_enabled) {
> >>>
> >>> How many times are we testing for this? Just check if the gcr3 table
> >>> is installed once
> >>
> >> One time for IOMMU capability (amd_iommu_pasid_supported()) and one time for
> >> device capability.
> > 
> > Again I think this whole thing is out of sequence. The main focus
> > should be on the gcr3 table. You should dirctly know if it has been
> > installed or not via some direct means. Test all this stuff when you
> > go to install it the first time.
> 
> We are doing 1 SVA domain : 1 PASID : N devices model. That means we need to
> check all these things while attaching *first* PASID to device. (That's what we
> had discussed sometime back when I had all these things in feature_enable(SVA)
> path).

I thought I said you 1 PASID is not technically correct, but you could
get away it it for a short term. You should be planning to support N
PASIDs because that is what the API defines.

> Ex: If device is in domain with V1 page table tries to attach PASID it should fail
>    If device is in domain of PT mode, then we should setup gcr3.

Yes
 
> So I don't see how we can infer these things unless we have something like
> enable_feature(PASID).. which would have taken care of setting up things.

You just trivially check these conditions at the top of set_dev_pasid, look at
what I did for ARM:

	if (smmu_domain->smmu != master->smmu || pasid == IOMMU_NO_PASID)
		return -EINVAL;

	if (!master->cd_table.in_ste &&
	    sid_domain->type != IOMMU_DOMAIN_IDENTITY &&
	    sid_domain->type != IOMMU_DOMAIN_BLOCKED)
		return -EINVAL;

For AMD "cd_table in_ste" means that the DTE points to a GCR3 table
already. This is trivially tracked in the DTE programming in set_dte
because you know if the dte is being configured with a GCR3 or not.

The other cases represent the situations where we know how to upgrade a DTE
for those domains to one with a GCR3. Everything else is blocked.

> >> is_pasid_enabled() is checked twice (once without lock, so that we can avoid
> >> lock in most cases and one inside lock to be sure no one else entered and
> >> enabled gcr3).
> > 
> > That never works, don't do that.
> 
> It does work as second one is lock protected. And the intention was to avoid
> locking for attaching second PASID onwards. Only for first time attaching PASID
> to device we will have check for two times.

You can get racy false negatives, that are hard to reason about.

 CPU0                               CPU 1
                                    lock()
                                    change state to !a
if (!a)
  forget it
                                    a = false
                                    unlock()
lock()
if (!a)
   forget it
change state to a
a = true
unlock()

There are ways with atomics you can build those kinds of lockless
patterns, but they are tricky and not justified here.

Jason
