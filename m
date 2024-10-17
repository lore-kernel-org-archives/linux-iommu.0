Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684618EB1
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729129474; cv=none; b=UHGbxl02npDot4r3e8vR7eJmOgeFiUCasdKpDsOPa+5TWlNX7eAA4qxykZt3hneWNATZyAZijPJ2ggqaJtJo5VH1b2YBbyOvpSE3TCDX4Z5x+XPIpT/BO+mcdY0GTEyoR1wfJMfU7Ah7Q1T6E6MmG+zQnPhmQ+goxtV7886NUoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729129474; c=relaxed/simple;
	bh=2+pnXpEJ3Ejed6zS36rBiZimXMhI+VQNS2H6P//GnIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6q5KMKh/gSt06CZkSDwMtELXbh/sqPZ9K9usvgaM2gBz3OPUoBWUcg07DhTawnQJnlZJq5nhQrOExjkbrIbH8b72GsckAWTDTmGmbW1CiKhVnJ/GdBkdHDc3vZy4/cKRe++r1mP6pQU2es0a3W/2zSTl138Suh2mVmpu6pZLOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gMcftHMH; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gMcftHMH"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539d9fffea1so415708e87.2
        for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 18:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729129469; x=1729734269; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bOLME2vkiS4WulapUGeKy8qBzIm8BZ3xRNuJKUmClTw=;
        b=gMcftHMHzFIl5OoYeeDleP09EXghUfl0LyQ8Ccwh6EwJ4K6UBjLjP4GsaeWpW+iHVM
         LP3aS5XobEOJJ8aDF+A6nsu9rQro6wOIscUbaautiwzd0Fh9kDqJ7jlPGdG7dkQ/if7l
         RtS0K33e9SQrWAgTr5uZWJbQU3F2+jopA9oa8xiQ8G3goM6k2tMkLk/K1hHgrJV2ey9c
         Ybm5JLvG7dZy5AyHVGmFX08NXlwGTjbQ90G+l1+pHLPK9WZAy7uaBGUz0vpGHzEFTfYo
         UDPggRzyAc1wAOxsn9ZT4VMMNnLv83omfBnxOsS+KvK8zBQkB7UkzaKclU9+FH21n52T
         QXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729129469; x=1729734269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOLME2vkiS4WulapUGeKy8qBzIm8BZ3xRNuJKUmClTw=;
        b=Npiuov/8M3ZsRxI9vlbgJSehjKrhE8mE5ySfA1XCinHuXs+67AJOAUL/srY1tpI8BA
         sOYAVii+F1+H/C8ktV5G5O6YH3bvokEJSVCG3QRRYuCbiRoJYDqUIRVMZTxQ0d4hurtR
         nn3OasrpuofnrAwD15pDGaDqEaNM16pk0JZx8hvl+lThrykAzDO32nspVPNLaEO7CR1a
         P6K/BAAyvsH1kVcqtL3sl1bSsN3JOKVTeBsl1evgNEUBlOh8Wu4MSXf5hLjJ1XPr0lxC
         NK9tP1WgtdLHMlkvOBMIoj8hKZaKBwxc4BF9Zi/P0DavkU4X7MZtscV+W/bADkYyxo67
         vXTg==
X-Forwarded-Encrypted: i=1; AJvYcCVNyZIPjA8XlovJ3Sw3Z7JRI6SeH3E4KkalMk6C+bHebzuL3vl2kleGKNna1KS67gRWd+YiCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxRMEUZnW+mWAAxKPQWYtcEvjXVObPzjwV7rolygAShfNjJi0E
	HlCmCqB9WXs24hmhEjYR952pCwXI9i6K/4S6C4MNg+NlHRDwsOmyX14hlksBOVYog5MXJhp/3WW
	sn/PxtQlsh3olO7uGKJEFA2t9UhAAowQ78ciJug==
X-Google-Smtp-Source: AGHT+IGqvkXfSOamlQfTibVlHYj9ChYt1KAqdmYe0Mwzkkqn6GXfzsT96yxwcBZHy6+yoP+eA8EwacKcwppzcsWH1y0=
X-Received: by 2002:a05:6512:124c:b0:539:e333:181f with SMTP id
 2adb3069b0e04-53a03f04762mr4004850e87.10.1729129469334; Wed, 16 Oct 2024
 18:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com> <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca> <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
In-Reply-To: <20241016152503.GB4020792@ziepe.ca>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 17 Oct 2024 09:44:18 +0800
Message-ID: <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt attach/detach/replace
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Oct 2024 at 23:25, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Oct 16, 2024 at 09:58:36AM +0800, Zhangfei Gao wrote:
> > On Tue, 15 Oct 2024 at 20:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > > > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > > > +{
> > > > > +       struct device *dev = idev->dev;
> > > > > +       int ret;
> > > > > +
> > > > > +       /*
> > > > > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > > > > +        * should not be forwarded to the hardware due to PRI being a shared
> > > > > +        * resource between PF and VFs. There is no coordination for this
> > > > > +        * shared capability. This waits for a vPRI reset to recover.
> > > > > +        */
> > > > > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > > > +               return -EINVAL;
> > > >
> > > > I am using the SMMUv3 stall feature, and need to forward this to hardware,
> > > > And now I am hacking to comment this check.
> > > > Any suggestions?
> > >
> > > Are you using PCI SRIOV and stall together?
> >
> > Only use smmuv3 stall feature.
>
> Then isn't to_pci_dev(dev)->is_virtfn == false?
>
> That should only be true with SRIOV

Do you mean
if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn == false)
    return -EINVAL;

This is fine

>
> > > FEAT_SVA needs to be deleted, not added too.
> > >
> > > smmu-v3 needs some more fixing to move that
> > > arm_smmu_master_enable_sva() logic into domain attachment.
> >
> > Will think about this, Thanks Jason
>
> Can you test it if a patch is made?

Yes, sure.

Thanks
