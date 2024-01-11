Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CBA15E9F
	for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hSNhI9dh"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2046c724383so1646911fac.1
        for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 05:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704979585; x=1705584385; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kK53vAUk17tEjoB5cWPD3r/c50LTGxAyt8OESDmDH3k=;
        b=hSNhI9dhyZXy68NL/oZuuGlbgiaqSb9+Zo4B7gF4RcTEMxaUW0pHH6MQ2SxBGzmy5G
         QlICO8ZOPhqjjJSZYh8ElbWxL4kNtliha3Kp2040QTmaxRZ38Xvajn97/jyyRMoK5oRr
         bcC0DzWrgSojlqLk9A9SSfXTad0i5dol+gy41CEngBLrkbse+23u9oKJfHHZPEoV73Et
         IiZnSII9nlEv2UsgkiiOLeGxFBzOYVNEEKupyMpvDN6EYXafEOg4K6sD/glDu8zjwpwS
         MPNnk+Ract4dI5hHHpamrK3iIrQwmPbYAz5mDrNV5CSWABX7PWONXZP0fGBXG1Z8a33/
         t9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704979585; x=1705584385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kK53vAUk17tEjoB5cWPD3r/c50LTGxAyt8OESDmDH3k=;
        b=tVBGhgUkTJDbTxXTkFhoazAoRt8xlF9CjURq14uWH7m2F+sQPJtKCTLkxzcZTKisKg
         furUbeXZcxI3XF1WjLnP9LmDrPr5MzpScv2BBswAwbW2y05trnFHd99XwHsDER1xapcA
         28fRIkVXer0IFHdf9hw6+LUw/DDJ0me5Zv3jDqtcVpVIjd0iDCo6i+EzqBHwFlFXcGN5
         /UqxAym4APQqt+8QqzIXX5/WQZZJGgcDzWwD8U/53a9qRlcUUu9LpKsmMezMDMFY4xdN
         4P+V0qCiL841QzFaOR2Ve1Psi04PwSe+RS853i5RVuOG7TNbMKk0JQIyFMCO7Sw2YYhi
         UJgA==
X-Gm-Message-State: AOJu0Yxfz6q/jk6XApU5J5C+rfXoCAYCLDC8bBRNYFngYzARhoh8mKfr
	X6MY0HlZcx65CZDeKiLL2ryyTGPybTSnuw==
X-Google-Smtp-Source: AGHT+IF7p9/c0StpeY39cp4b3p4dsmTcUn7efh9D3Gdqgs++TStzd7j4zNCJ8Hhkh173DaBJIFZZhw==
X-Received: by 2002:a05:6870:b07:b0:1fa:e1c8:8bb0 with SMTP id lh7-20020a0568700b0700b001fae1c88bb0mr1143037oab.28.1704979585311;
        Thu, 11 Jan 2024 05:26:25 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id sk16-20020a056871801000b002064e3ae6e7sm223357oab.0.2024.01.11.05.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 05:26:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rNv4h-00313E-II;
	Thu, 11 Jan 2024 09:26:23 -0400
Date: Thu, 11 Jan 2024 09:26:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 10/16] iommu/amd: Refactor helper function for setting
 / clearing GCR3
Message-ID: <20240111132623.GU50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-11-vasant.hegde@amd.com>
 <20240105191207.GP50608@ziepe.ca>
 <434bd095-0cbb-8220-66bc-371172a2312f@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434bd095-0cbb-8220-66bc-371172a2312f@amd.com>

On Thu, Jan 11, 2024 at 05:22:02PM +0530, Vasant Hegde wrote:
> 
> 
> On 1/6/2024 12:42 AM, Jason Gunthorpe wrote:
> > On Tue, Dec 12, 2023 at 08:52:18AM +0000, Vasant Hegde wrote:
> >> +static int __set_gcr3(struct iommu_dev_data *dev_data,
> >> +		      ioasid_t pasid, unsigned long gcr3)
> >> +{
> > 
> > IMHO you've got the ATS layering wrong here.. The ATS invalidation
> > should be pushed out by attach/detach functions and has to be
> > carefully sequenced with the ATS disable bit in the PCI control
> > register. I don't think you can do all of this right with things
> > organized like this. Indeed this looks like it over invalidates the
> > ATS quite a bit.
> 
> Currently if device is capable of ATS we just enable it. Then we invalidate
> while setting/clearing GCR3. This is extra invalidation if we always clear the
> PASID before using it (as clear path would have invalidated IOTLB).

It is simpler if ATS can just be left on, but I'm not sure you can
actually do that when you get to nesting.

The guest and the hypervisor need to agree on the ATS state, if the
guest thinks ATS is off then the guest will not generate ATC
invalidations, which means the physical ATS has to be off too.

Thus all this needs to be carefully sequenced to be dynamic, and this
doesn't look layered well for that.

> > You should only need to invalidate prior to doing the enable and when
> > a GCR3 value is changed while ATS is turned on, which is something
> > that the attach op can caculate.
> > 
> > So, these functions should have a signature of:
> > 
> > (struct amd_iommu *iommu, struct struct gcr3_tbl_info *gcr3_info, ...)
> 
> Not sure I understood this. This path is adding PASID to devices GCR3 table.
> Hence I pass device_data. It will set GCR[PASID] and invalidates TLB (Because
> its per device things, we can get the iommu details from dev_data itself).

I think it is wrong layering to make the GCR3 table linked to the
device, it should be an object indepdent of the device. Any place you
are passing a device into a gcr3 layer function looks suspect to me.

This is why I said you should put the domain_id in the gcr3 table,
because that is the proper layers for the objects and data.

> > [and the locking can implicitly rely on the core's group lock, don't
> > need more locks]
> 
> I was waiting for group->mutex to export so that I can add lockdep_asset with
> that and remove device lock here. May be I can just remove it and expand the
> description.

If you want to use it just add a 'iommu_group_mutex_assert(dev)'. It
is a couple of lines

> >> +static int __clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
> >> +{
> >> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> >> +	u64 *pte;
> >> +
> >> +	lockdep_assert_held(&dev_data->lock);
> >> +
> >> +	pte = __get_gcr3_pte(gcr3_info, pasid, false);
> >> +	if (pte == NULL)
> >> +		return -EINVAL;
> >> +
> >> +	*pte = 0;
> >> +	amd_iommu_dev_flush_pasid_all(dev_data, pasid);
> >> +
> >> +	return 0;
> >> +}
> > 
> > What is the point of clear? By the time the attach ops will want to do
> > clear it is already certain that a non-zero value was installed in
> > pasid, and this doesn't free any memory, so what is the point of
> > 'alloc=false'?
> 
> This will fetch GCR3[PASID] and clears it.
> 
> We use same __get_gcr3_pte() in set/clear path. Hence alloc=false is passed.

Just call set with 0 - again there is no point in having alloc=false
since this isn't called in any case where we don't already know the
that the entry was already allocated.

Also, most likely this eventally needs splitting up like SMMU did so
that allocating memory to get an entry pointer is separate from
setting that entry pointer as a driver should strive for "fail means
no change" implemenation of their domain attach function.

Jason
