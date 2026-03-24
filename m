Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA58A31195A
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381518; cv=none; b=GVSfLHYtt7V9ESYJbIl491QO2MdN+OJxJNidyN8DgGueCjlQh+17flCF7G0R0LsMQbZ6Yw5yxQpBh1N3u+yxUEwORruwM0/X885AA52iIjvFNS+vYiExJfYSvKjRFWMF4JQEU5CscMpQrm+AMIWpq3r0JPoFvmVAnQQecx/ucRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381518; c=relaxed/simple;
	bh=cElslhTE6m9W0YImaAUJVkSxCsiQPpNOSWv/SF1fcSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxP/O8zKXvprL8vh557ClFRgsmPanhE64KwN3trSpYoZBeVRYsJ63gMWWNAqaa0EfkG1BVeRHkS9fRZ+2aIdq+kDXsZJnEe/zy8Lu4KRb6V4dnN5XYLGXCYJKEHRtiar4hiC0avT7g3F72xuJuxmQ+ztpzFaVtmsQfKtzFhGc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EXAqDuNm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXAqDuNm"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b0b260d309so2385ad.1
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 12:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774381516; x=1774986316; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lk/w0o7W4j7sim/BVALDWnCOxHkFQz3/Bh51qF9Rkjg=;
        b=EXAqDuNmTjV7Y6wbQGTC2XnhO0YGH0bkaKy4zBZyrZlzFPaXkU+Mef+UC2oqkJVQem
         od+H3RzCnxcPXfCqcNIhqMOjY7SZijQtZkmHyezMKDyJ+xYTRKvhIpkHrvcWJocQftn1
         YgeCaFuBy4/O4HPZZYm0MNDZtCBdz6xBtADTL6xKDZibujZyP9llKhesOo8MenvYoivK
         kJ071IXruHXcl7+f2fRN366/RazV5//A2VAgUVoUrwD1RUOu5VaeLDhZlFEhNjGxhsZo
         7dfULizUK2rq3trxj1fPuLzQSzGGjolqnItfeBvKJm/822gKLchWx8kc1KCQfV07Jyk/
         1Asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774381516; x=1774986316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lk/w0o7W4j7sim/BVALDWnCOxHkFQz3/Bh51qF9Rkjg=;
        b=gLzlCqpNRz04agpXnE9yZm6gSTObI33rxukblgxytp9nLRA6+lVhJ0l8NrpiKOb0bS
         qJNkxUtFumV8X2SS6MZ1WEMvRTpR+2iFwUDmgnYSG3ut76iskzNNQhFmR++syUNuoKvn
         s8G+OBSQJ0HnKfVDC2wnQOeRhhAv/+m8UB2QOKi37IMjdaR/xcPon5iLutbaW2lONJXw
         ZmZIxjgCr+B/jPcmttjz817Om0p1OLkgXbDgMeZNplrmJoKkk2kVZhrfZH2LF2MbwfNd
         c1OSfPY2itkHTF791GbgLCbo7V08fM6ROV688eHIqxskZ/A3cHFMBFT1Fs6lm53/jwf/
         sNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy/KPj2KouHP21nsWUsZHZ8pjknlizfDrDCVtVp7PPuJVt/foYpti8cn02HIs73b0a49HduA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yygg7W+4Kq96lm2PTGXraVsoyQGpDiJ/pApY6pnoJa6EsAf2JuH
	a46t122uyqw62fvtN27fsfAG5uv+beqveO2LGEtTgmCNp6HnxF1PSsSQO97loizOtA==
X-Gm-Gg: ATEYQzwMpmGAJyftSEZb0SyiNXtq8N6uJ9iS4SJD+97R3n4NHAlRwtuCKwiMU6fflh+
	d+rgI1JN+LmV6hD3MjxVPa79dZoWo+gY1UQvloonCYjTzEFIjP1+VKT4hzrQUVWNvsJwUEk/EUw
	TUVk7R0BsdulPDjVyq0DUzKXm1eCRgrC2UoQyQ+vi+x7sS6bdJoPwDEYALdM4z2SWCaJGA4YAsq
	1ttILCXt9Bd/flYjo+KgiDLKvy7OapCZ7dusgYRbi387rpmzAK0I9Vy0q2fmTOxQsGPLpO4ChIw
	cScfny0q/G9lccCgO4wkajAZIHSaxkHsCVp4nzS+QGt9O/r/WZO+Yydou1I+tMzHJZ2NDs4DxRY
	70Dhyrbk1ABPVmQoP5sNTGSCU8rsPfPFHWTIO06xlKtnwFabPlERcCwdEPStAPKMsEj8FigHr60
	PxP4clXLkhBwnl8/wSNFM2FanXHBE2ML8ulHi9lTu2spfjbu3DXrHkL5qRKsUIOg==
X-Received: by 2002:a17:903:b47:b0:2b0:aee4:afe7 with SMTP id d9443c01a7336-2b0b1568b56mr739105ad.10.1774381515550;
        Tue, 24 Mar 2026 12:45:15 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa5aa7sm13255806b3a.1.2026.03.24.12.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:45:14 -0700 (PDT)
Date: Tue, 24 Mar 2026 19:45:11 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 02/14] iommu: Implement IOMMU core liveupdate skeleton
Message-ID: <acLiWVezdOKY4qO0@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-3-skhawaja@google.com>
 <20260316221854.GC1768676.vipinsh@google.com>
 <abm2C-8xRstbuzIe@google.com>
 <20260324184809.GA190066.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260324184809.GA190066.vipinsh@google.com>

On Tue, Mar 24, 2026 at 12:06:10PM -0700, Vipin Sharma wrote:
>On Tue, Mar 17, 2026 at 08:33:39PM +0000, Samiullah Khawaja wrote:
>> On Tue, Mar 17, 2026 at 12:58:27PM -0700, Vipin Sharma wrote:
>> > On Tue, Feb 03, 2026 at 10:09:36PM +0000, Samiullah Khawaja wrote:
>> > > diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> > > +int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>> > > +				    void *arg)
>> > > +{
>> > > +	struct iommu_lu_flb_obj *obj;
>> > > +	struct devices_ser *devices;
>> > > +	int ret, i, idx;
>> > > +
>> > > +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&obj);
>> > > +	if (ret)
>> > > +		return -ENOENT;
>> > > +
>> > > +	devices = __va(obj->ser->devices_phys);
>> > > +	for (i = 0, idx = 0; i < obj->ser->nr_devices; ++i, ++idx) {
>> > > +		if (idx >= MAX_DEVICE_SERS) {
>> > > +			devices = __va(devices->objs.next_objs);
>> > > +			idx = 0;
>> > > +		}
>> > > +
>> > > +		if (devices->devices[idx].obj.deleted)
>> > > +			continue;
>> > > +
>> > > +		ret = fn(&devices->devices[idx], arg);
>> > > +		if (ret)
>> > > +			return ret;
>> > > +	}
>> > > +
>> > > +	return 0;
>> > > +}
>> > > +EXPORT_SYMBOL(iommu_for_each_preserved_device);
>> > Also, should this function be introduced in the patch where it is
>> > getting used? Other changes in this patch are already big and complex.
>> > Same for iommu_get_device_preserved_data() and
>> > iommu_get_preserved_data().
>>
>> These are used by the drivers, but part of core. So need to be in
>> this patch :(.
>
>Sorry, I am not understanding why it has to be in this patch? Can it be
>its own patch?

I will move it to a separate patch as per discussion in other thread.

See:
https://lore.kernel.org/all/abrk39_M8k45myXJ@google.com/
>>
>> Note that this patch is adding core skeleton only, focusing on helpers
>> for the serialized state. This patch is not preserving any real state of
>> iommu, domain or devices. For example, the domains are saved through
>> generic page table in a separate patch, and the drivers preserve the
>> state of devices and associated iommu in separate patches.
>>
>> I will add this text in the commit message to clarify the purpose of
>> this patch.
>> >
>> > I think this patch can be split in three.
>> > Patch 1: Preserve iommu_domain
>> > Patch 2: Preserve pci device and iommu device
>> > Patch 3: The helper functions I mentioned above.
>
>I understand that this patch is adding some helper functions and not
>doing any actual preservation. I am suggesting to split this helper
>function patch into three for easier review based on the above suggestion.
>If I am not wrong this is biggest patch in series of approx 500 line
>changes.

After moving the getter helpers out to the separate patch as mentioned
above, the size of this patch should significantly reduce. I will split
the remaining into domain and device + iommu preservation helper patches
as you suggested.
>
>> > > +static void iommu_unpreserve_locked(struct iommu_device *iommu)
>> > > +{
>> > > +	struct iommu_ser *iommu_ser = iommu->outgoing_preserved_state;
>> > > +
>> > > +	iommu_ser->obj.ref_count--;
>> >
>> > Should there be a null check?
>>
>> Hmm.. There is a dependency of unpreservation of iommus with devices, so
>> this should never be NULL unless used independently.
>>
>> But I think I will add it here to protect against that.
>
>Okay. Since, it is a static function, I am fine either way.
>
>> > > +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>> > > +{
>> > > +	struct iommu_lu_flb_obj *flb_obj;
>> > > +	struct device_ser *device_ser;
>> > > +	struct dev_iommu *iommu;
>> > > +	struct pci_dev *pdev;
>> > > +	int ret;
>> > > +
>> > > +	if (!dev_is_pci(dev))
>> > > +		return;
>> > > +
>> > > +	pdev = to_pci_dev(dev);
>> > > +	iommu = dev->iommu;
>> > > +	if (!iommu->iommu_dev->ops->unpreserve_device ||
>> > > +	    !iommu->iommu_dev->ops->unpreserve)
>> > > +		return;
>> > > +
>> > > +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>> > > +	if (WARN_ON(ret))
>> >
>> > Why WARN_ON here and not other places? Do we need it?
>>
>> Basically this means that the upper layer (iommufd/vfio) is asking to
>> unpreserve a device, but there is no FLB found. This should not happen
>> and should generate a warning.
>
>Yeah, but other places iommu_domain_[preserve|unpreserve](),
>iommu_presreve_locked(), and iommu_preserve_device() are also using this
>function. I am having a confusion on why it is important in his
>function and not others. Those functions are also called by upper layer.

Ah yes.. That makes sense. I will add it to the unpreserve variants of
functions you listed, as during preservation the FLB obj should have
been created.
>
