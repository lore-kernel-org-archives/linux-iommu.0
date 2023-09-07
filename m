Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A65695
	for <iommu@lists.linux.dev>; Thu,  7 Sep 2023 12:04:42 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-76ee895a3cbso54211785a.0
        for <iommu@lists.linux.dev>; Thu, 07 Sep 2023 05:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694088281; x=1694693081; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wTwRgqdQIzqbrQVReLAS0ja2qn8xe1ecJIq4ztY54IE=;
        b=R6xBFK2rguIuMZRqnsps6gW8Sqt0iHp0Y9bZ3YFv6xzoSrHTOq6yMSQF3fpFg222pL
         5LLOarIAzqWzBoOFHf+2AVFg4I0dGWhS5F6xyOfdbolNP+4SjHK3ATDY+PX2H2AAWQHs
         TUwZsAXlWdxV2H+sRujsv2r57nCjFfWymk4FMIeAiERlt4YrU/QEOPxNJvdG3i73ty9/
         XtmRVhhzG/ak2KaaA4hn46zpttpTUFe6Sby59zaBwt7YDNN1Mv04F+//6bPH8qCeX3pv
         UulvNhSX09GqHPaEOzbUZbPlEmnIB9S6to9toXu9oRQ+mODYPIk35grSd74XgaZ9ypyE
         BtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694088281; x=1694693081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTwRgqdQIzqbrQVReLAS0ja2qn8xe1ecJIq4ztY54IE=;
        b=fM6hjrSOfpW+QzgXYtWt4WLb17YEhNuC/fkGQMZEZa2Nn3WUagorlOa9O0JsH277c6
         mcxaeg34uMtp5bwPfaesjmbQ13ztdxwfq+YaCmHGYc/kjMpCIv715K9clojBOaTEoXxh
         Gjjr3PvUnW30BJ3HKQGT8f7/Aj05x7lWaxspjNzZgqgF3+b4r7mfDAsDNGBHXAYiOQMO
         hFz5koCx2Uy2AlpRVw0Rm/I/yAGXomujoidz3ag36e/IDN1Jk7iJJfVG+69b19Rl8oDu
         c02p6zkD88EiUeGxdTtMbLebjOx7HalAczNLAG/P5JgpQWFRLyMvErUdV/l+lrHBJh3m
         /Tng==
X-Gm-Message-State: AOJu0YwRtiNE3Ki827YS+TTuSPKzJeiSjKvmjRfJsoxpPeFaZBqW83lN
	CLff3htETpg/j3pTI3yDfn2c2w==
X-Google-Smtp-Source: AGHT+IEyk0Aw0D2u3XuqbUHZDGwLcYzho8FmAvdDysIUEQbV8PiUuSfmHid1fcoC7EMo2/yPoETkHg==
X-Received: by 2002:a05:620a:2f2:b0:76e:8403:8b2 with SMTP id a18-20020a05620a02f200b0076e840308b2mr18811212qko.42.1694088280949;
        Thu, 07 Sep 2023 05:04:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id d4-20020a05620a140400b0075772c756e0sm5708436qkj.101.2023.09.07.05.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 05:04:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qeDkV-0015P9-Gg;
	Thu, 07 Sep 2023 09:04:39 -0300
Date: Thu, 7 Sep 2023 09:04:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH RESEND 04/10] iommu/amd: Add support to enable/disable
 SVA feature
Message-ID: <ZPm8V5C28scC0kgi@ziepe.ca>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-5-vasant.hegde@amd.com>
 <ZOYljfDOgbzVeBeX@ziepe.ca>
 <cbf043cb-aa4e-ff00-5d13-7b09ceaf0986@amd.com>
 <ZO93zPITePX52FaE@ziepe.ca>
 <7f231d1c-30d8-d30c-8cc3-82179066909d@amd.com>
 <ZO/U6WfzSerXUaj7@ziepe.ca>
 <e1e3b265-c39c-3288-092c-4293b7f3b83a@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e3b265-c39c-3288-092c-4293b7f3b83a@amd.com>

On Thu, Sep 07, 2023 at 12:45:01PM +0530, Vasant Hegde wrote:
> Jason,
> 
> 
> On 8/31/2023 5:16 AM, Jason Gunthorpe wrote:
> > On Thu, Aug 31, 2023 at 12:30:21AM +0530, Vasant Hegde wrote:
> >>>>>> +int amd_iommu_sva_disable(struct device *dev)
> >>>>>> +{
> >>>>>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
> >>>>>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> >>>>>> +
> >>>>>> +	if (!iommu || !dev_data)
> >>>>>> +		return -EINVAL;
> >>>>>> +
> >>>>>> +	return amd_iommu_sva_gcr3_uninit(dev_data);
> >>>>>> +}
> >>>>>
> >>>>> I think these features are a mistake, you need to implement them for
> >>>>> now but I wouldn't touch the gcr3 table, and disable should be a NOP.
> >>>>
> >>>> We need to configure Device Table Entry when we enable/disable SVA.
> >>>
> >>> The DTE should only be changed by bind/unbind of RID/PASID - it has
> >>> nothing to do with these APIs.
> >>
> >> Above functions are called during enable_feature(SVA) path. Not in PASID
> >> bind/unbind path. In PASID bind/unbind path we just update PASID table.
> > 
> > I know, which is why they can't change anything about the IOMMU
> > HW. Only attach/bind/unbind should change HW state.
> > 
> > I intend to remove these APIs once ARM is fixed, so please don't start
> > to rely on them. The driver is doing something wrong if it is changing
> > HW setups outside of attach/bind/unbind.
> 
> 
> If you intend to remove enable_feature(SVA) API completely, then you help us to
> figure out how to handle below issues?
> 
> 1) During attach_device() we don't know whether device is really going to use
> SVA or not. So we want to start with minimal GCR3 table (that can handle just
> PASID 0) and during enable_feature(SVA) we want to enable GCR3 table that can
> handle max_pasids supported by a device. That way we can avoid performance
> penalty if device is not using SVA (extra GCR3 table walk).

Resize the GCR3 table when the first pasid using attach happens.

We can discuss if/when it should be shrunk back to minimal.

> 2) If we boot with passthrough mode, then during attach_device() we are not
> allocating GCR3 table. It will be allocated only when its needed. That way we
> are not wasting memory.

> Do you suggest that the driver setup GCR3 table at the first PASID binding to
> the device?

Yes. PASID must work correctly stand alone.

Jason
