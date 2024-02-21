Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD3DA35
	for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496825; cv=none; b=PLEJDEYNndBSpqg47NvZEZ036Hlq52n4sxsLy12fJX3TAFgzC9F4JyPATB8aoWrL+1dPPXuPndOku0eGtdmkDLyrIyOTh7LDoVP39JZarHB9oUJAO1ei8witJOl8cXpEkIeNW5iCtoOQyoMUil0piyTna0ZesE7MjX1ommyQVcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496825; c=relaxed/simple;
	bh=/V5T+YQftfD2tRWQGhzHzmXn6qVrJBWkMhBmJM5xGrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnLXwx7h3m0/dVxxxRV/kzbRanO4XAwUunRlkUIIvN+UahtzCvpb8DdyaiHdrx+n50wQrbwcRyM8aTl3zmpmsIx2Xn2yT1l2FP7RLifsgC3cwg07ylCm7fzNWxnwdMC+VqPdI4G5iW+L6NktnWCJq/a+KZenYAt+ePWbFgwVgtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BwrRqAvV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwrRqAvV"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0cdbd67f0so87842161fa.3
        for <iommu@lists.linux.dev>; Tue, 20 Feb 2024 22:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708496821; x=1709101621; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O4SCakJf3fMGKD4Pc9DX3Fmx60D6/XewjZTTvU4lsUQ=;
        b=BwrRqAvV4eaJ8Eg1OwiwCCscmnPZpTQhpOsPUMt8EAQYUHd4TgqrC8SZBWEjRlGk/A
         2b67oIZKv64d0p7gO4A4jNrhh3DL/b1HJgHFFrgfXsLy6E3U3clS2pnzTbKd/aN1pupF
         hx9xuudzwJ+5xa/myn1PNqJ+ZW1JkLBoVMzLmx3ThMKba4VgUh0v1D7umy5d11BWAvp5
         P+BTs5TTxaSxZWo55VCVXDO1omqJHF8BhmBKm19TPdY6chArxZQRpaN1A0ZCv8oMrFnJ
         xyHLrwciWPE26MrkNzJAE4+MuYzGkYlU4/zHmy8SuMPirPHD5wwCVfl4gFbwrS8RlQFI
         97SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708496821; x=1709101621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4SCakJf3fMGKD4Pc9DX3Fmx60D6/XewjZTTvU4lsUQ=;
        b=l83+gHHPFqSSEQloG+06HHTS+i1Kxe8fIfDC52RqpdzgdyCCkG0qP1BrqPxViQX5Xk
         pTfRLmXZ+HyhZ6pwbbpZbmjqBvdXA0sVvji+q2BJD7tQAbiiAnQhBW0sbS5KdBmX364f
         YA1HLWaHKjI6B0BMBvEqICtkHkP5domyAF4xpSxnV+oh9QXY3vCe/6AxnHygvXu08HUv
         7H7IeIEI3Moav2rkKfUmtBdVYbAZroz1GKUBzUKiXorn7CnMhnv+TNFgMSAYda1NPRMi
         rea4zlVIxgNu3TxCLcGBwlXgGbVzBHtrT3ZPe6EvPqRvfFDGSw7RDf8yFCpvDqT7f19B
         GbbA==
X-Forwarded-Encrypted: i=1; AJvYcCU8u46WSOidwAnz0wwpe4sdpH4aHivnxrTQ5UHXOnGNYVGPK6/oavF81CK/AXmPCPfVMBAhuRiE91wngOdTeVdLqbNgPW4=
X-Gm-Message-State: AOJu0YzbZpK3QkmyRBWf1E1es7Syz+hmC5nTpwHrchiKWDdOFFiWnoGb
	jKZO84vuohcR3I+cWVWyJ427J3uJVDnV728Q14NCc/aV4Z7ag20+jwLPEavsaeiWHN3LArv5jmN
	ELUJ1C1pop307B7N60JgbNs2sEx1yLAckNiQhX24BO/Is0U6FsA+eETbC
X-Google-Smtp-Source: AGHT+IGAk9uU00zF5FiQ3NZBmkalTm/vo9IQ4bsTZa6Kjs7HQJX88+nLTvnpaddJgnUhtZkssQt6m05of8wqFGM+sVc=
X-Received: by 2002:a2e:988a:0:b0:2d2:31f1:1a2e with SMTP id
 b10-20020a2e988a000000b002d231f11a2emr5776674ljj.12.1708496821260; Tue, 20
 Feb 2024 22:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-6-tina.zhang@intel.com> <CABQgh9GWcqUeBkHQCpj5tzu6FnEgpOp3KOQ6s9c0X0KU7Ov1qw@mail.gmail.com>
 <MW5PR11MB5881C5CC15452017867B412889502@MW5PR11MB5881.namprd11.prod.outlook.com>
 <CABQgh9GxQmGU2HR73bSoZLuf4XZFhThXwUs_HJx6KwxDmXrXgg@mail.gmail.com>
 <b05958ba-0c47-45ba-8159-372779f9cc8b@linux.intel.com> <CABQgh9FFpL=mEZ-7PqRRVg1eniYV176B7USbGP5MLPvhJaGo9A@mail.gmail.com>
 <55a4b5e5-e0ad-4aa4-a29b-5fff4ef69063@linux.intel.com>
In-Reply-To: <55a4b5e5-e0ad-4aa4-a29b-5fff4ef69063@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 21 Feb 2024 14:26:49 +0800
Message-ID: <CABQgh9FD2fup3awxNyu3LpQcB6f-HF5eb1B4fhVHxLJ0O76oVQ@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] iommu: Support mm PASID 1:n with sva domains
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Zhang, Tina" <tina.zhang@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Michael Shavit <mshavit@google.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Hao Fang <fanghao11@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 11:52, Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2024/2/21 10:45, Zhangfei Gao wrote:
> > On Wed, 21 Feb 2024 at 10:06, Baolu Lu<baolu.lu@linux.intel.com>
> > wrote:
> >> On 2024/2/21 9:28, Zhangfei Gao wrote:
> >>> On Wed, 21 Feb 2024 at 07:58, Zhang, Tina<tina.zhang@intel.com>
> >>> wrote:
> >>>
> >>>>>> struct iommu_sva *iommu_sva_bind_device(struct device
> >>>>>> *dev, struct mm_struct *mm)  { +       struct
> >>>>>> iommu_mm_data *iommu_mm; struct iommu_domain *domain;
> >>>>>> struct iommu_sva *handle; int ret;
> >>>>>>
> >>>>>> +       mutex_lock(&iommu_sva_lock); + /* Allocate
> >>>>>> mm->pasid if necessary. */ -       ret =
> >>>>>> iommu_sva_alloc_pasid(mm, dev); -       if (ret) - return
> >>>>>> ERR_PTR(ret); +       iommu_mm = iommu_alloc_mm_data(mm,
> >>>>>> dev); +       if (IS_ERR(iommu_mm)) { +               ret =
> >>>>>> PTR_ERR(iommu_mm); + goto out_unlock; +       }
> >>>>>>
> >>>>>> handle = kzalloc(sizeof(*handle), GFP_KERNEL); -       if
> >>>>>> (!handle) -               return ERR_PTR(-ENOMEM); - -
> >>>>>> mutex_lock(&iommu_sva_lock); -       /* Search for an
> >>>>>> existing domain. */ -       domain =
> >>>>>> iommu_get_domain_for_dev_pasid(dev, mm->pasid, -
> >>>>>> IOMMU_DOMAIN_SVA); -       if (IS_ERR(domain)) { - ret =
> >>>>>> PTR_ERR(domain); +       if (!handle) { + ret = -ENOMEM;
> >>>>>> goto out_unlock; }
> >>>>>>
> >>>>>> -       if (domain) { -               domain->users++; -
> >>>>>> goto out;
> >>>>> Our multi bind test case broke since 6.8-rc1. The test case
> >>>>> can use same domain & pasid, return different handle, 6.7
> >>>>> simply  domain->users ++ and return.
> >>>>>
> >>>>>> +       /* Search for an existing domain. */ +
> >>>>>> list_for_each_entry(domain, &mm->iommu_mm->sva_domains,
> >>>>>> next)
> >>>>> {
> >>>>>> +               ret = iommu_attach_device_pasid(domain,
> >>>>>> dev, + iommu_mm->pasid);
> >>>>> Now iommu_attach_device_pasid return BUSY since the same
> >>>>> pasid. And then iommu_sva_bind_device attach ret=-16
> >>>> Sounds like the test case tries to bind a device to a same mm
> >>>> multiple times without unbinding the device and the
> >>>> expectation is that it can always return a valid handle to pass
> >>>> the test. Right?
> >>> Yes
> >>>
> >>> The device can bind to the same mm multi-times and return
> >>> different handle, Since the refcount, no need to unbind and bind
> >>> sequently, The unbind can happen later with the handle.
> >> Is there any real use case to bind an mm to the pasid of a device
> >> multiple times? If there are cases, is it better to handle this in
> >> the uacce driver?
> > Yes, it is required for multi-thread, the device can provide
> > multi-queue to speed up.
> >
> >> From iommu core's perspective, it doesn't make sense to attach the
> >> same domain to the same device (or pasid) multiple times.
> > But is it the refcount domain->user++ used for? Is there any reason
> > not doing this.
>
> I was just thinking about whether to do this in the iommu core, or in
> the upper layers, like uacce or iommufd. It seems that there is no need
> to attach a domain to a device or pasid again if it has already been
> attached.

It would be more complicated since the return handle can be used to
distinguish different queues of the device.

I think domain->user should handle this case as before.

Anyway, I have sent a patch to get more feedback.

Thanks
