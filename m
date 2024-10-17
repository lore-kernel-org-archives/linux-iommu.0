Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D9F224FA
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 01:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130019; cv=none; b=B6C2kLsKf2d5qQBhhlpfP4PwwXvg2lX11yqh2SZvo3z6+IYLIGG+gaEEIMqhI0h2tAhCo0pc6TbVml5td3k2Y2uDRMozvKDO8LUJjbazbWPyaPT+ykXBfFGRteeGVSJyP1DVkRxETY2KN/39VRNRuKB9k3h5gbtL/BlnIUGMnxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130019; c=relaxed/simple;
	bh=T8K6e1vE2wCLDVf7N8pVhUM3BmOSL3JyhQ3sMTdPLa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVN0zqDWbwbzlwC/+Hvm4X9NYRFAxAOUxSHCrFcgGk/Y3H9pKcv5Yx3ZhEakgRM/9j0x4aHRrrnOFrU3daKIIPxNT2J9mf+TYf6+/92nt3YucTnW9hFwpVOw7ljKi4qy5TZ1xbe02hN7j3DsCChPyMeRIuem68pDubmP5CdSfw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xvZFPfjn; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvZFPfjn"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f58c68c5so647824e87.3
        for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 18:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729130014; x=1729734814; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PLiuItL1UL/0YbxnoapkbJfbI3ajFc+JHUChCko5gAM=;
        b=xvZFPfjnOdB0ypNnYusgxlse68h57xtDYUlD0O7pc6puUfb6vjT8l3YH+xDNlMlkTU
         cRZ/027kyT4tWxKU7GJZ7nh7aTEev/dGL33HP2oAr2Vha85NkCfdRgMA7S/bPtVo64e8
         iD393cfz8BgSmZOxL8hR7vsKIHkGBuyWQEwo15/JnW09tZwcsvDTJzYgt5x/LDzV95Pq
         Kv66i166LS3FDaMXr0OvkQsYh5K2QjaZKkZWeDUq83vnXyLYDm1U/ijUMSLGd0vZuWjM
         5RBcQq/s2oo1CwRch+tFxWJpfoX8OIZXqjC3Z40+C/wMDrZwYPAQhi82Jj4ynyQndqbX
         bb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729130014; x=1729734814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLiuItL1UL/0YbxnoapkbJfbI3ajFc+JHUChCko5gAM=;
        b=XtNO8CmhDttwz15j/lCoH4JMiRZnZaYYR7xtubwlabmK97xieUdHxLIECwHG8jcpl4
         fiZUUa4pI+Vg9xFsoWkcRKlhqEzKwBzcO04o+kyL0ez/evGJDHtrAuWk2Vg++SN7lHDx
         n9OBOqUv39DpMEr5tFFvvEQIuImskOgZ0vtKtjEjA3/J2nzyBgl8gqebKfqqNp8kQNyT
         zkWQGk2AB62RKEOEB4yam0VXDm43/onIecedzIw7DCITBoHku5XTANiWGFvZDsPLco3Q
         SNTQq77z+uK5XiOGkXQIDTkUp8TV+UWbT6PtX92hiisB1ded4ba8+BY+QrjTExl3CQse
         HWwg==
X-Forwarded-Encrypted: i=1; AJvYcCU/va8CkTDY7TVPSQVsnFyRydmayqXoG1gZb118Tsnn78Ejdd+s/lCYSJflQoP+mpYrMStWaw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzvsf1UHhCDzOkCL8+g36ZWoLDPdP1LbK1hiCzXxx+CQzwBbUi5
	N0WRqO0mYnNAoHI5FI1MUv6wCly/va5hcx+HKZ2HwNfkyWbz51WVdyx0PHoQ/njR1CUcuOR3BIY
	4HiZhdHkXQRg4tkPsadLJ3EiH25cHdHUp5xgWwQ==
X-Google-Smtp-Source: AGHT+IHmRyfMbHywLHUFamzust4bs2j0uBfSYysgkZSLZifh1MxXQEHcbM8EVQlN/EZKeVoV9osv3HRdY3nD8AfzzMA=
X-Received: by 2002:a05:6512:1252:b0:539:e0e6:cf42 with SMTP id
 2adb3069b0e04-539e571ce19mr12017134e87.43.1729130013488; Wed, 16 Oct 2024
 18:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
 <Zs5Fom+JFZimFpeS@Asurada-Nvidia> <CABQgh9HChfeD-H-ghntqBxA3xHrySShy+3xJCNzHB74FuncFNw@mail.gmail.com>
 <ee50c648-3fb5-4cb4-bc59-2283489be10e@linux.intel.com> <CABQgh9ESU51ReMa1JXRanPr4AugKM6gJDGDPz9=2TfQ3BaAUyw@mail.gmail.com>
 <20241015130936.GM3394334@nvidia.com>
In-Reply-To: <20241015130936.GM3394334@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 17 Oct 2024 09:53:22 +0800
Message-ID: <CABQgh9GF9vm=9Yv2AWe5wbN-mfr6Grn9=+c5zTgOvaMU+3bNSQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Initial support for SMMUv3 nested translation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	acpica-devel@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Michael Shavit <mshavit@google.com>, patches@lists.linux.dev, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 21:09, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Oct 15, 2024 at 11:21:54AM +0800, Zhangfei Gao wrote:
> > On Thu, 12 Sept 2024 at 12:29, Baolu Lu <baolu.lu@linux.intel.com> wrote:
> >
> > > > Have you tested the user page fault?
> > > >
> > > > I got an issue, when a user page fault happens,
> > > >   group->attach_handle = iommu_attach_handle_get(pasid)
> > > > return NULL.
> > > >
> > > > A bit confused here, only find IOMMU_NO_PASID is used when attaching
> > > >
> > > >   __fault_domain_replace_dev
> > > > ret = iommu_replace_group_handle(idev->igroup->group, hwpt->domain,
> > > > &handle->handle);
> > > > curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
> > > >
> > > > not find where the code attach user pasid with the attach_handle.
> > >
> > > Have you set iommu_ops::user_pasid_table for SMMUv3 driver?
> >
> > Thanks Baolu
> >
> > Can we send a patch to make it as default?
> >
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -3570,6 +3570,7 @@ static struct iommu_ops arm_smmu_ops = {
> >         .viommu_alloc           = arm_vsmmu_alloc,
> >         .pgsize_bitmap          = -1UL, /* Restricted during device attach */
> >         .owner                  = THIS_MODULE,
> > +       .user_pasid_table       = 1,
>
> You shouldn't need this right now as smmu3 doesn't support nesting
> domains yet.

I am testing with  .user_pasid_table = 1 and IOMMU_NO_PASID
It works for user page faults.

>
>                         if (!ops->user_pasid_table)
>                                 return NULL;
>                         /*
>                          * The iommu driver for this device supports user-
>                          * managed PASID table. Therefore page faults for
>                          * any PASID should go through the NESTING domain
>                          * attached to the device RID.
>                          */
>                         attach_handle = iommu_attach_handle_get(
>                                         dev->iommu_group, IOMMU_NO_PASID,
>                                         IOMMU_DOMAIN_NESTED);
>                         if (IS_ERR(attach_handle))
>                         ^^^^^^^^^^^^^^^^^^^^^ Will always fail
>
>
> But I will add it to the patch that adds IOMMU_DOMAIN_NESTED

OK, cool.

Thanks
