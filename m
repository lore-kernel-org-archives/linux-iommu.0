Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE513EE1D2
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921606; cv=none; b=B1y9AT9h2P6gi/lxaZTloR/M+yas3c4DY6a7I5jYZQz6K6lpJch/ee8xVhlN+IwZAWhlULONLo00jxsyE94ojR/Vdt98BZYEfqyy5SF95UMkeJ1gkimJ7eSsK/BRAVSj3r0O982vaFF3xS+Hh1pAP0CFB54fmLH9TqONXYkXUx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921606; c=relaxed/simple;
	bh=xSEaTTVUVlwKE9SMgvY/jxSjdT4lw2aY23m0oR9BIGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIrvb52DHqy5m31lmRzLSW44GGpd6YFM6xwPMQSTxyMr8usOSKA9h2Kq/N+7cqhoL4d7JHfD/1RH4JOGQ9iIgr+I/fESRfZq8jX2zQzJ/54XuCk/bNhKJQeVf49MbdE9GuQLVDM9Y4Pn8RdgQxORlHl1oyuVjpvJw0zJOtn2sjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qfmxqsxd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qfmxqsxd"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso355ad.0
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 12:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777921604; x=1778526404; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6F35o67JJ+BgMKb1KLJGbh+gKAaYW0m1XJ+eMW24qM=;
        b=QfmxqsxdUVcjMo77NdSJU6z9ue+B2lbaGHVYbvwbRen/1yJ3t1P+nnY0mtzzaEsogv
         eLwDR7vzg1qwbB6YX2z7akNMpuNCfGiyjhY9rKx6BQvUFhlrDW3P+UV6joqFlXoNi7oj
         TOOHoBVWi2pfTf1qEmMAjmh4MBPxnjQ2CQ30c0CphemkWZDwIBpfZ5gwlvb/YR8JVTIn
         o6JTgHHgQ7sFZsFO2YRszXVm4IUeQ/8o+OHd5gieCb22vLrB8MWExBnSCj63ZAe5Z7Y+
         h/2ca6ZnbqFQWESI233nO3HI9WHvrilHH/gCmatqjmcz6zFGjehjr9Srxx7KySCeE1yG
         RBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777921604; x=1778526404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6F35o67JJ+BgMKb1KLJGbh+gKAaYW0m1XJ+eMW24qM=;
        b=cK3DHKmCK4V+foGWLiFirP0VTWzgpOIax8O4YGanEbiaJFnPKg2M7kRJsMSn23NBtF
         dyQC3CmA0+D3LFYvzX41W18I18wcMzwEFPU7nvqiComIIsVJxiNEafo4A87maFQJxRRN
         WxAFhXgxm6VsqZf0sDRDMdj1Kvvy1L/DtQ8YjmPhy0374AWjBwh+Ug78P/jAQ895c/qt
         zxMQPro4DxZ71No8cU5hUS9CArKcqdJv54griMr3A2gZXj+9eu4/PO0D1qyPGOd/TZ8Z
         2CfixAJVOLk/N1qwTcUOeUwIa3RzbM5T1iXTsxL/WzpOfRHOIOYhLcxOtOGfavvR+mVU
         wjrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9w5I7ndHkUnOkWY1AQl7OW8EmIAtT3vhfcUFpGrP2xkAW3QynVY6vi3z8D+tYKDWpXLNA94A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSsg2JC+yLAkZztOBsRqy97vJTHjTRI/TCJlxIVEwPPSS92Q6b
	ldo0g8L1gz8EARlh7s6K4HziVXhZaO65b2xQ97mLrkrym/U1n4uJ0gaPbcllKPbdEA==
X-Gm-Gg: AeBDieuw8y/2rCeT3xjEj+EiD6bKeUIkfNcUta+0yrGxVGAz97V04iFudwVgAYYbdwC
	VhorB0FXfgjMMIo01BXAWhFd6ECW7Y6Giy3BO37CBlFvnqEn2IAK8sC6pTSo2IKlVoUIcnXQ4fV
	IdS3kabk4WBD9D9su5ceIIjjUrkLe2WvVPhwF0qBW3xIdiiik3c206NcO9ClLpqHyhevv6kZSw2
	ZhdrRlFWnTyr00HFQ6NiZRdqRAGtZHtd5wkYy1sGgSW+34E/I5saUqFl1Q0aOHLrBuZZxT0bYAC
	To2bV/thAJUnxUdqGcqkIlo7z48INld3nzPZsc7pmNMYVdJFgOrUpIjUiNSy+ZdCZoaJNXpItHW
	p+dn9/oQmfbPYvCAoHdvhSeGR4585ESetXOtl31Kix5yk1WqGDqF9jbfVRGnQ1SW1QfdkLlXSEP
	4/xyL6U1u4JTSXreK+CFFzpQ8v1jEXUVKXyl40PuWR5+l2iFWInerPVG86WMiIp3JfSQc00ZpPo
	d8l9u7iqjo=
X-Received: by 2002:a17:902:f645:b0:2b9:e831:5e5c with SMTP id d9443c01a7336-2ba4f6fc12dmr829715ad.4.1777921603289;
        Mon, 04 May 2026 12:06:43 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa8bd20sm114957035ad.14.2026.05.04.12.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:06:42 -0700 (PDT)
Date: Mon, 4 May 2026 19:06:37 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 04/16] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <afjnVR0OCGMN0XNf@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
 <afUscSeXKnNAJ0ZF@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afUscSeXKnNAJ0ZF@google.com>

On Fri, May 01, 2026 at 10:42:57PM +0000, David Matlack wrote:
>On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
>> Add IOMMU ops to preserve/unpreserve a device. These can be implemented
>
>Can you make this comment more specific about what is being preserved?
>Saying it preserves a device is vague and maybe even misleading. It's
>more about  about preserving a device's attachment to a specific domain
>correct?

There is attachment ID, but the preservation of device can have IOMMU
driver specific things, so in core I mostly mention "preseve device
specific state". In later patches in this series, we save PASID table
using the same callback. I will add more details in the commit message.
>
>> by the IOMMU drivers that support preservation of devices that have
>> their IOMMU domains preserved. During device preservation the state of
>> the associated IOMMU is also preserved as dependency.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
>> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> index f71f14518248..765d042e22e3 100644
>> --- a/drivers/iommu/liveupdate.c
>> +++ b/drivers/iommu/liveupdate.c
>
>> +static struct iommu_device_ser *alloc_iommu_device_ser(struct iommu_flb_obj *flb)
>
>It is unforunate that struct iommu_device_ser has nothing to do with
>struct iommu_device. The former represents an a PCI device, while the
>latter represents an IOMMU.

Yes, I went through various iterations of trying to name it in a
different way but keeping the "iommu_" prefix and the "device" state
naturally falls into this. Not sure if iommu_pci_device_ser is suitable?
>
>> diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
>> index 6019cfc27428..279c7ab04f09 100644
>> --- a/include/linux/iommu-liveupdate.h
>> +++ b/include/linux/iommu-liveupdate.h
>
>>  int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
>>  void iommu_domain_unpreserve(struct iommu_domain *domain);
>> +int iommu_preserve_device(struct iommu_domain *domain,
>> +			  struct device *dev, u64 *preserved_state);
>> +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev);
>
>The naming scheme is inconsistent... Maybe it can be:
>
>  iommu_preserve_domain()
>  iommu_unpreserve_domain()
>  iommu_preserve_device() or iommu_preserve_device_attachment()
>  iommu_unpreserve_device() or iommu_unpreserve_device_attachment()

Agreed, but I am trying to follow the already existing naming scheme
for domains that is used for APIs in iommu.c

iommu_domain_free()
iommu_domain_init()
iommu_domain_preserve()

But I think this is rare, I will update to this as you mentioned above:

iommu_preserve_domain()
iommu_unpreserve_domain()
iommu_preserve_device()
iommu_unpreserve_device()
>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 3853a3946733..1c424b32c5fc 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	int (*preserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
>> +	void (*unpreserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
>> +	int (*preserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
>> +	void (*unpreserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
>> +#endif
>
>Maybe we can make these names a little more specific:
>
>  preserve_device_attachment()
>  unpreserve_device_attachment()

Attachment is too specific. See my comment above.
>  preserve_iommu()
>  unpreserve_iommu()

These are part of iommu_ops and having preserve_iommu() instead of
preserve() is redundant I think. Note ops like capable(), hw_info() in
the same struct.
>
>?
