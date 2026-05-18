Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B24E2D838E
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129230; cv=none; b=RdUlJM4ZzScQiAwfIasrneyvqPv55kxJUZcVkMf7M/ignDK+NZ+5ns66K76GV/KeU7EuSVu52BkjbcLF9m5247gmz8m1gInlKd1OCV8oseMBI0A9lyEpwii85LQORCdEhSwsjuxnV0z9+ORoy2R+bqKiGXBAQqXncEVEaFOQ4Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129230; c=relaxed/simple;
	bh=TyOWWPWoGocXqSwMD+MG/Lr0Gd5wpTyR5wdZ+yXhOuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjGNZ1csfDIie1f7REQVp/ZV1Vtfr5lB1GDHvannhVXNwqMJt9gxs8QbxWtfcJW8mqw++nfNwVXkZDdHb71n1dXKf1rLW57hZJPJG72WvRrk0hGTmvWQjjAJAivwiGsyxe4wHNnwIMCVbnqbwbUMlWfUT2tCwSKk+gkYykD9dUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HOZDXhBG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOZDXhBG"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba180a022dso1155ad.1
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779129229; x=1779734029; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KANnHv0swkPJJWZfqLe5jM5UVpVbFidl0DzMhA68oc=;
        b=HOZDXhBGQNjZt9aZUXwrPmrpIvJRHtq1T80ukbU40OYC5PGp7E7bIUlChjz1GM9QNZ
         ld545ev4htZQY1L/KyDg/27wBTuaTz7SrFLwj1IKQRRkD+lZeEbt0Dp/SLciBDP1WwPU
         3myGeGFY6xHEODID8lPxYHw67oDkDcJ18ocmDTm4N+bkgUPeu2OfAfuoW9Mz9stVQuU2
         wvNXqa9It1WYvtwjeQfiQgmD9iMeWoZWYsSjYZ2TJNN9sXNYfo3WafkuS5ZqTWdCi0jH
         xXE0CuCpR0hVLqe5xmpGUCtuw/SvfKdhPdxOzk8b1PhSXsdle4pl46blE5BKzIZ/SZZV
         fcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779129229; x=1779734029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KANnHv0swkPJJWZfqLe5jM5UVpVbFidl0DzMhA68oc=;
        b=A8jdL15znv09JJ1s0uiyDEM6gj4o3dfeP5yhghhGnLB/4CDre5XMX592LCHm11G+MD
         m/CcTK5THjzcpjXXn5scWoiYrgOKio88IwplGNvi/9X+F4nFpRB7hLk66LZoc3rG2qmS
         h4oTwaEvK0m3dL+hDFir61dD8Q4fcQ9x7xskA8zMlX07aH6wgmlwIPT8sxHKDVAtOvpU
         cZBT6QJuugUgjrALs7V9K++8tLoJe+VftDAuQrqySCVJsvh8cFK60SAgGTa0oG26ZeqC
         3LChc4+SPp8BVoa1eEanrM9aKfhCcnFr74dtxEWmyKsfJ0BA0/YnN80Gdy8i0tiSj4Ej
         Vomw==
X-Forwarded-Encrypted: i=1; AFNElJ9EIQlxvyEzkzWvhpNu3whGuPVZf6fvRxSIkfq3FccE7inbhH5KWsq6a9y8KYAOIPdyRHJkCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwF9uVptQM8gqqikOGcfGgN/PONPe/F90SPbzEMTceiwWWerWN9
	DKhKTu0aoTYjzUlyEL9Lw2YX0ZtkoiYvXUFoKT+Re2ffTQ75Iv8F1nFC/ON4+Jhdjw==
X-Gm-Gg: Acq92OEKH8M5uzE3L/GmyfCAT+Q34MMVRwh4lPlG8AYfWGxAtqIFAeP9B4bFrepcIVh
	Ig+Rbdh+CRzscEXPIFE/VUIkVI5Vinx2lO+dhytlMfN/EhXjoSIgpmxcAEQ48dBeEaboT72rL92
	vjHYwgzyu5BX+sC9jW/A5kWbJqoEUQ4K0RCpyZCFjuCpXy1VURgX8rNPkm/Ku04d33onx9sQ5nu
	IiyU9CB2f57QuKakymJwFuauk7L9DS12ZitjlpFwn8otZiJ48dVnTfqOdwj3b7tMfJl5PXvDUoe
	Xjuz+QZpWRce2E3SA1/RHNqyF5l0eUYN1jpskkFS5jEB+Ac7HWNWLKwpdir1LIncny2Dg1fD0Bf
	ldvi/1DRv4FJ21fuEB7BijY4AG0JLbHCUWtT4uZd1A1RNITc7WSjCNGIyMgX5UT+Edflx2bbmS+
	WRH7BVSTpUgoU25MwRkVRuqvKG9BdCQH46OUVjGgvS+XlPXDcCxcFlDfDigC7nzH83BRl+ZA==
X-Received: by 2002:a17:903:32c5:b0:2b9:e831:5e5c with SMTP id d9443c01a7336-2bdb03a42c2mr3898675ad.4.1779129227834;
        Mon, 18 May 2026 11:33:47 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6487sm156913305ad.54.2026.05.18.11.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:33:47 -0700 (PDT)
Date: Mon, 18 May 2026 18:33:44 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
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
Message-ID: <agtMUUYyc1qx6GG7@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
 <3874a086-98ae-4b94-8c1b-20e13f5a92fb@linux.intel.com>
 <afzcqWa8iVqrhJLs@google.com>
 <agsbtV4oargwX45d@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agsbtV4oargwX45d@google.com>

On Mon, May 18, 2026 at 02:01:25PM +0000, Pranjal Shrivastava wrote:
>On Thu, May 07, 2026 at 06:47:07PM +0000, Samiullah Khawaja wrote:
>> On Thu, May 07, 2026 at 10:07:43AM +0800, Baolu Lu wrote:
>> > On 4/28/26 01:56, Samiullah Khawaja wrote:
>> > > Add IOMMU ops to preserve/unpreserve a device. These can be implemented
>> > > by the IOMMU drivers that support preservation of devices that have
>> > > their IOMMU domains preserved. During device preservation the state of
>> > > the associated IOMMU is also preserved as dependency.
>> > >
>> > > Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>> > > ---
>> > >  drivers/iommu/liveupdate.c       | 162 +++++++++++++++++++++++++++++++
>> > >  include/linux/iommu-liveupdate.h |  33 +++++++
>> > >  include/linux/iommu.h            |  20 ++++
>> > >  3 files changed, 215 insertions(+)
>> > >
>>
>> [snip]
>> > > +
>> > > +int iommu_preserve_device(struct iommu_domain *domain,
>> > > +			  struct device *dev, u64 *preserved_state)
>> > > +{
>> > > +	struct iommu_flb_obj *flb_obj;
>> > > +	struct iommu_device_ser *device_ser;
>> > > +	struct dev_iommu *iommu;
>> > > +	struct pci_dev *pdev;
>> > > +	int ret;
>> > > +
>> > > +	if (!dev_is_pci(dev))
>> > > +		return -EOPNOTSUPP;
>> > > +
>> > > +	if (!domain->preserved_state)
>> > > +		return -EINVAL;
>> > > +
>> > > +	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
>> > > +		return -EINVAL;
>> > > +
>> > > +	pdev = to_pci_dev(dev);
>> > > +	iommu = dev->iommu;
>> > > +	if (!iommu->iommu_dev->ops->preserve_device ||
>> > > +	    !iommu->iommu_dev->ops->preserve)
>> > > +		return -EOPNOTSUPP;
>>
>> I will check for unpreserve ops here also.
>
>[snip]
>
>> > > +	pdev = to_pci_dev(dev);
>> > > +	iommu = dev->iommu;
>> > > +	if (!iommu->iommu_dev->ops->unpreserve_device ||
>> > > +	    !iommu->iommu_dev->ops->unpreserve)
>> > > +		return;
>> >
>> > Is it considered a driver bug if it implements the preserve hooks but
>> > not unpreserve ones? This would at least cause a silent memory leak. How
>> > about adding a WARN like this?
>>
>> I think the preservation should not be done if the unpreserve ops are
>> not implemented by the driver. I will add these checks in the _preserve
>> functions and return EOPNOTSUPP if it is not implemented by the driver.
>> >
>> >    if (WARN_ON_ONCE(!iommu->iommu_dev->ops->unpreserve_device ||
>> >                     !iommu->iommu_dev->ops->unpreserve))
>> >        return;
>>
>> We can add this warning here also.
>
>I'd rather have the iommu device registration fail instead of solely
>relying on these WARN_ONs here. We can simply add a snippet inside
>iommu_device_register():
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
>We anyway don't support hot-pluggable liveupdate ops atm.

Hmm.. I understand your point, But I think we should let the
registration go through so the IOMMU can be used. Its just that the
liveupdate preservation will not be supported. Failing the registration
would be a big hammer that I think is not really needed.
>
>Thanks,
>Praan

Sami
