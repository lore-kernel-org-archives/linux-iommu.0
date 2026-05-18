Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A0347505
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129876; cv=none; b=PFDudmdY1QaleZlV6d8LOwZg+VR0PhFPUjkkvoWtyN8oLwL5sdKn8uww26OLOutsXfBpk6gnn1INrYRuzDOMeW/QIWb0eABgzy4dwPaZuOpH0UA5ybMFS9neEJ4rfLvgErxjcKs2akHREPwzGnfTU2tUPWmL8S52cU1CvvdoNRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129876; c=relaxed/simple;
	bh=Ic1nHyDVe0+lHF29JSEClWUQfaRhDT14d/5L38QtIwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8u6kJOgsvfOY4CcMI3V5JxdKSxiX5omb4Rqpu914Y+h29FaEvMy0xIfvhDIXPtqz+kRPho5JJyocBHV6TE9/pGmogcuDxvXaU9b9qxM3ysTh7WyjTl3+AoN/fha27dIAMD7ZMAfiuq+GZtywl1srEkndEv/8vX+b10XYGYcqfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BSdz7Uvy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BSdz7Uvy"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba180a022dso75ad.1
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779129875; x=1779734675; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=42Co3FfgxAP6Wa+6cQjpccW4rhzcESaNN3XiEoxLDQM=;
        b=BSdz7UvyRNDNHMAhSIxsdXJwjBP3XWixr/7mBUm9LCHTDpnmHn8H7pYNecDM+5auPh
         zpu+jsvWJhLVAekJkXeIZB/l8tK7u44CBrzXgTw4kar7bZBlssurg57wC71GFI1uiGa2
         mkFm+ePGltmnSEnE7sM1TXSixRwe84HGY9fFqnW1s1c5Xen/ghDWl2cjiqr2lwVhCSLE
         xWHGPdXBKUeo4Fh1/Xs3cBbOrJsOQvnBoSjjsC7Elf6FoA8G2xw7DMKYuVfEvxl+Ym20
         e6eiDr+AIr5oQHdfEYVlDa/0CmWWPmQun85PDYOFatGSLF9YtEgHa/Dlq0fNpgv+/06b
         6z3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779129875; x=1779734675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42Co3FfgxAP6Wa+6cQjpccW4rhzcESaNN3XiEoxLDQM=;
        b=fLL6UW4pd/KxO0HWopqRvxOVivuqq9tNJs9d5K6n8iQTG9Fiv4o/usCMhoo8yqHrQP
         xWoEaxvvbiJDvucEIXriFnDFyfbO27P++hm3Rgb+3V0IYvCdIU1mo7VxXxOhaBLY6NEJ
         hRfp/7RS2dKjy4ZP/SlAl+EMmZRJ1CfUGZGoSJ2oZAErm3d93rTTASNEbv5+7SZU0lsG
         otltPDqTEMcdCZOU2e3LERcrYc6eGB/0WKP/MR62vQEuFdU7PQfHbk9BjAu0sutVGgbQ
         5VFxIYoPEjs+BqZ77bOUhf9PfJGXVJNTSTUn69nXP/5MDyp0xCk95UmM0IJw3aD3pSnl
         wnVw==
X-Forwarded-Encrypted: i=1; AFNElJ9qh+mqe4AefQMDHv1G7uUURdz5IxBR5Vv6QuM/KOA7FSdCqIWyjmh4CPhg21WOM88UkpJhdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrfRwY+vv8ng9fXMXsBbG4MuOJKQjRDfJdnuaOZY1spJRmMWiB
	+RylI06YjlLUA+NovKbExHL6NjX4VPiUC+cibISA6Q0KTJZZZ5pQNsqZahwhZJA++w==
X-Gm-Gg: Acq92OGzZxca1Ry1JzUtUHdlDEgOVKDOtUI7B02jRJ6pJaG6cLuK8pS8xwmXDvAVT0s
	kSw86ajkuiQnCEpS0t2idGjO7JcT/VHfXCRGVAq2gs0lz2SdsCa9mOzkvG+zsMu7kiPgF27REam
	JjdLic8JJoL1Aprpqm2zn61CF6GZl2Y1OcE0T/ormuxcbL5RxAcwZ1k7dYqmbRNEWPgcMBAGiZG
	AleuH/2xdJAgWYb6og/gxny8kw/V7EQgMMqnTEYTENnUR0uAxiHUc3WUxHALIfXS6oTfF6hyOrb
	cLBPGlLPiNLHbFbL3lI8dEueEaT6dEcwflKGKEWsb6F/0c+yaF0oLOXBmcIuKXJw24n4255Imx4
	0t6qNfv+nMsluRK0iz1VQp6yIbcV3YhuWyZpY7X3dO5Umy+rgo+c+JhHjxPfTzMhoAZkUENL1w8
	iJ7zx9ct/8VizneNw9JAnOAmJjrObqWOGNWunvZSoI8ot/QUD1QV5DzRtpDF8UHsR1uE+SsUF68
	Vl2ToG0
X-Received: by 2002:a17:902:cf0d:b0:2b4:6529:7bae with SMTP id d9443c01a7336-2bdb329b56bmr3672775ad.17.1779129874166;
        Mon, 18 May 2026 11:44:34 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe64a9sm158941345ad.53.2026.05.18.11.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:44:33 -0700 (PDT)
Date: Mon, 18 May 2026 18:44:30 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
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
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 04/16] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <agtcSw4s0M2ArWI4@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
 <agsaY9714WS1N4Zu@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agsaY9714WS1N4Zu@google.com>

On Mon, May 18, 2026 at 01:55:47PM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:21PM +0000, Samiullah Khawaja wrote:
>> Add IOMMU ops to preserve/unpreserve a device. These can be implemented
>> by the IOMMU drivers that support preservation of devices that have
>> their IOMMU domains preserved. During device preservation the state of
>> the associated IOMMU is also preserved as dependency.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/liveupdate.c       | 162 +++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h |  33 +++++++
>>  include/linux/iommu.h            |  20 ++++
>>  3 files changed, 215 insertions(+)
>>
>> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> index f71f14518248..765d042e22e3 100644
>> --- a/drivers/iommu/liveupdate.c
>> +++ b/drivers/iommu/liveupdate.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/liveupdate.h>
>>  #include <linux/iommu-liveupdate.h>
>>  #include <linux/iommu.h>
>> +#include <linux/pci.h>
>>  #include <linux/errno.h>
>>
>>  #define iommu_max_objs_per_page(_array) \
>> @@ -293,3 +294,164 @@ void iommu_domain_unpreserve(struct iommu_domain *domain)
>>  	domain->preserved_state = NULL;
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_domain_unpreserve);
>> +
>> +static struct iommu_hw_ser *alloc_iommu_hw_ser(struct iommu_flb_obj *flb)
>> +{
>> +	int idx;
>> +
>> +	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_iommu_array,
>> +			       iommu_max_objs_per_page(flb->curr_iommu_array));
>
>Nit: Same thing about brittle casts here, shall we make them void ** and
>cast then within alloc_object_set ?

Agreed. Will change this.
>
>
>> +	if (idx < 0)
>> +		return ERR_PTR(idx);
>> +
>> +	flb->curr_iommu_array->objects[idx].hdr.ref_count = 1;
>> +	return &flb->curr_iommu_array->objects[idx];
>> +}
>> +
>> +static int iommu_preserve_locked(struct iommu_device *iommu,
>> +				 struct iommu_flb_obj *flb_obj)
>> +{
>> +	struct iommu_hw_ser *iommu_hw_ser;
>> +	int ret;
>> +
>> +	if (!iommu->ops->preserve)
>> +		return -EOPNOTSUPP;
>> +
>> +	lockdep_assert_held(&flb_obj->lock);
>> +	if (iommu->outgoing_preserved_state) {
>> +		iommu->outgoing_preserved_state->hdr.ref_count++;
>> +		return 0;
>> +	}
>> +
>> +	iommu_hw_ser = alloc_iommu_hw_ser(flb_obj);
>> +	if (IS_ERR(iommu_hw_ser))
>> +		return PTR_ERR(iommu_hw_ser);
>> +
>> +	ret = iommu->ops->preserve(iommu, iommu_hw_ser);
>> +	if (ret) {
>> +		iommu_hw_ser->hdr.deleted = true;
>> +		return ret;
>> +	}
>> +
>> +	iommu->outgoing_preserved_state = iommu_hw_ser;
>> +	return ret;
>> +}
>> +
>> +static void iommu_unpreserve_locked(struct iommu_device *iommu,
>> +				    struct iommu_flb_obj *flb_obj)
>> +{
>> +	struct iommu_hw_ser *iommu_hw_ser = iommu->outgoing_preserved_state;
>> +
>> +	lockdep_assert_held(&flb_obj->lock);
>> +	iommu_hw_ser->hdr.ref_count--;
>> +	if (iommu_hw_ser->hdr.ref_count)
>
>Shall we add a defensive if (WARN_ON(!iommu_hw_ser)) ? I'm aware we
>check this on within iommu_unpreserve_device() but we don't seem to
>check it before calling iommu_unpreserve_locked() in the error path of
>iommu_preserve_device.

Agreed. I will add this.
>
>> +		return;
>> +
>> +	iommu->outgoing_preserved_state = NULL;
>> +	iommu->ops->unpreserve(iommu, iommu_hw_ser);
>
>We seem to assume we'll always have unpreserve implemented? If so, we
>should check it during the iommu registration itself and fail it, i.e.
>
>inside iommu_device_register() we could add something like:
>
>#ifdef CONFIG_IOMMU_LIVEUPDATE
>if ((iommu->ops->preserve && !iommu->ops->unpreserve) ||
>    (!iommu->ops->preserve && iommu->ops->unpreserve)) {
>        pr_err("IOMMU: %s: Asymmetric live-update operations detected\n",
>               dev_name(iommu->dev));
>        return -EINVAL;
>}
>#endif
>
>This prevents a half-baked iommu driver from ever spinning up, completely
>eliminating the need to check for it inside the live-update session paths.

Replied to this in the other thread where you suggested this inline with
Baolu's comment.
>
>> +	iommu_hw_ser->hdr.deleted = true;
>> +}
>> +
>> +static struct iommu_device_ser *alloc_iommu_device_ser(struct iommu_flb_obj *flb)
>> +{
>> +	int idx;
>> +
>> +	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_device_array,
>
>Nit: Same thing about brittle casts here, shall we make them void ** and
>cast then within alloc_object_set ?

Will update this in next revision.
>
>> +			       iommu_max_objs_per_page(flb->curr_device_array));
>> +	if (idx < 0)
>> +		return ERR_PTR(idx);
>> +
>> +	flb->curr_device_array->objects[idx].hdr.ref_count = 1;
>> +	return &flb->curr_device_array->objects[idx];
>> +}
>> +

[snip]
>> +
>> +	ret = iommu_preserve_locked(iommu->iommu_dev, flb_obj);
>> +	if (ret) {
>> +		device_ser->hdr.deleted = true;
>> +		return ret;
>> +	}
>> +
>> +	device_ser->domain_iommu_ser.domain_phys = __pa(domain->preserved_state);
>> +	device_ser->domain_iommu_ser.iommu_phys = __pa(iommu->iommu_dev->outgoing_preserved_state);
>
>Nit: Should these be updated to use virt_to_phys as well?

Will update these.
>
>> +	device_ser->devid = pci_dev_id(pdev);
>> +	device_ser->pci_domain_nr = pci_domain_nr(pdev->bus);
>> +
>> +	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
>> +	if (ret) {
>> +		device_ser->hdr.deleted = true;
>> +		iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
>> +		return ret;
>> +	}
>> +
>> +	dev->iommu->device_ser = device_ser;
>> +	*preserved_state = virt_to_phys(device_ser);
>> +	return 0;
>> +}
>> +
>
>[...]
>
>Thanks,
>Praan
>

Sami
