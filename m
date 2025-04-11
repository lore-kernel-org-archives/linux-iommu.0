Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C735961
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386621; cv=none; b=GvwJGqESAW/EJ1PvXtjuIN2/NpfADavKIluRSZDlMY2rk/TDRHAfA6wMnG0MQVYTsQjOpFP0kHGQnv0jkdra97Qvf2TEhfCli5XuXk6HCN5CyPs9zfnPeSL4PlMmfDVrvAJuzfalhh7J0F0FclB22tSn8TT+59VuIdFZEWB0sE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386621; c=relaxed/simple;
	bh=X8m6dB5n6QY+Ao9IFNE7gEmsT12to5H0HieO8OXC6Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK9+ZcJntISmoNk3Ak6yGwnT4kUESMVCtd4t9soCb+oqiNjZiYW23XYkcPEanWvJFRSIScX+tZklIlermTcVvSyBg9iT+D+dIsvxYbZb/nob8GsuoF2g5VqlXC+rxjGzPKW+o9nd3tPG+FRQWHStbFjFvHv6Cxx/q6sg+DBJnqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPOwnH/V; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPOwnH/V"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2263428c8baso211195ad.1
        for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744386619; x=1744991419; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9gr388eDAaOABnPZrXjkZ45mWUbD3uMhzRpmwOTnLOU=;
        b=hPOwnH/VuWN25pEiqpWfpxgl5HunNvYVUK0TIaDba+AowZSYGB26QKjxfHfNjMB3Mv
         FJt7C+JXy8sM0gQ8oUH4Zf9Oy8LDZdIk4OFwsBoetU0SxLBt3Y3yJJQn+VWLI/Vk7B4+
         DrNPXa4sjrlEN2GVMCuX/8ysA562kXR7ilXBfzaVfalArzrWBeooGqhYdIKMNiFHupbA
         GX1yL9sNS1qggGGTJMyWx56vFLQ4id1EeUxFL2RC/B27iuRE4OYLJLzbFgviIDs0wg8L
         3WJ05DBe0RQAxvCtDuEqSYcQhvg06Dgyul1sEGPgCC/CPqDF80RgoqQv6MIpTErwDU8b
         6JaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744386619; x=1744991419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gr388eDAaOABnPZrXjkZ45mWUbD3uMhzRpmwOTnLOU=;
        b=M2SBERA9DImNdH+5/8bv1TURvJZslkIQSm7ajAZVkse1WEMgzqVDhG8lEttl0lewag
         JPJCTtFmCM+0jbL9zcNoGNmKLJgLhzwj8Z+NirqGuNl36dGeBcN7fWxHhdTZfwwl89FK
         ufuzz6ub35IHZ2jEXqlPWSFk2rcVAv7MK1R83PLpfN3jxiBJxSKs1dDcTlh8lLXHeAJz
         IJPumvati+7OKHAD3V9tY90qKlBd01roFtsyqi3e2ZuSfmA/U9bTTuU1+5AceR3tNcOR
         5f6tIuxhGZ4QaPF+OIJLidq/Jm2WDNyVUOox3hQTFMcaL3MUdfM82JF10wvLHEMhVF90
         rEIw==
X-Forwarded-Encrypted: i=1; AJvYcCWGfjyKC3wZ52E14piP33vRBuudV7kuHjQ/duecsEIK+ghUcmpAXwp4PU48NuSjY/g9pGP1qw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdfDqXli1NxZFhSvgAKJFUWZBVGFbARKhMIHb37TyTTFyld3xI
	TDJ9MAG580/Jrt5WhgSlwofxENuoPQSx6BcZIckiuE9PGB373fsF+qnHfZa26A==
X-Gm-Gg: ASbGncueCsPGhUA2hheJIsjbvWDxK4oKJGWE5apVN70Jpv77bE7PDMeGKOo4UWogjxJ
	FcHidsnktGI60YR1mChpfr1q0bperxvZPB58rPqtFI66LbfxHF2e/MbRoHSf7OLkVOKT6V6aWnR
	YkgOFQzDbnCyBfL4teZMcHgr0D0zG5psXvvdiIrLdR/Uk+aKwhuXtV4mpRnZZVG2vAxTXexJCrH
	fupWE+V4b65MJOR6ylc4zyaYn4eawb99zhRLvtDRuNbZ28T7TX3Wuqmcnd1RleJUXfEb41VKTWu
	Vf8zsGCSoIHPynPDzgn+QccVFXsiHa0HJxUXT22kRLl1Ej1eHx5OYbmi3u0s56Mj/Y2T7b4gNN1
	0quGRyAV21w==
X-Google-Smtp-Source: AGHT+IGAUGcHPS948c/RABJFlkfq9Ah9C95gnh02WA26avQXzL8VcB6UHm60FHX1cSKOUEo1ud5oSQ==
X-Received: by 2002:a17:902:d306:b0:223:37ec:63be with SMTP id d9443c01a7336-22be9971cf3mr2846815ad.4.1744386618527;
        Fri, 11 Apr 2025 08:50:18 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230dd00sm1681155b3a.126.2025.04.11.08.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 08:50:17 -0700 (PDT)
Date: Fri, 11 Apr 2025 15:50:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	nicolinc@nvidia.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fail aliasing StreamIDs more
 gracefully
Message-ID: <Z_k6MqMcVO068Mq8@google.com>
References: <39d54e49c8476efc4653e352150d44b185d6d50f.1744380554.git.robin.murphy@arm.com>
 <20250411152122.GF8423@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411152122.GF8423@nvidia.com>

On Fri, Apr 11, 2025 at 12:21:22PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 11, 2025 at 03:09:14PM +0100, Robin Murphy wrote:
> > We've never supported StreamID aliasing between devices, and as such
> > they will never have had functioning DMA, but this is not fatal to the
> > SMMU itself. Although aliasing between hard-wired platform device
> > StreamIDs would tend to raise questions about the whole system, in
> > practice it's far more likely to occur relatively innocently due to
> > legacy PCI bridges, where the underlying StreamID mappings are still
> > perfectly reasonable.
> > 
> > As such, return a more benign -ENODEV when failing probe for such an
> > unsupported device (and log a more obvious error message), so that it
> > doesn't break the entire SMMU probe now that bus_iommu_probe() runs in
> > the right order and can propagate that error back. The end result is
> > still that the device doesn't get an IOMMU group and probably won't
> > work, same as before.
> > 
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index b4c21aaed126..c06459f7077b 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -3400,9 +3400,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
> >  		/* Insert into SID tree */
> >  		if (rb_find_add(&new_stream->node, &smmu->streams,
> >  				arm_smmu_streams_cmp_node)) {
> > -			dev_warn(master->dev, "stream %u already in tree\n",
> > +			dev_warn(master->dev, "Aliasing StreamID 0x%x unsupported, expect DMA to be broken\n",
> >  				 sid);
> > -			ret = -EINVAL;
> > +			ret = -ENODEV;
> >  			break;
> 
> I don't think we should dillute the meaning of ENODEV here. It is
> supposed to mean that the driver does not recognize the device and
> this IOMMU instance doesn't translate for it.
> 
> That is different from the iommu instance owning the device but being
> unable to probe it for some reason. The failure recovery in the core
> code should be different.
> 
> IMHO it makes more sense to change this and related:
> 
> static int bus_iommu_probe(const struct bus_type *bus)
> {
> 	struct iommu_group *group, *next;
> 	LIST_HEAD(group_list);
> 	int ret;
> 
> 	ret = bus_for_each_dev(bus, NULL, &group_list, probe_iommu_group);
> 	if (ret)
> 		return ret;
> 
> So that recognized, but failed, devices are contained to only effect
> that device and do not fail the entire iommu or bus registration,
> which is more like how things used to work when the probe path would
> ignore the per-driver failure codes.
> 
> I can't think of a reason why we'd want any per-device failure to also
> abort the whole iommu registration??

I don't think this change would abort the iommu registration?
The probe_iommu_group would simply ignore the -ENODEV. Or are you
talking about a case where we don't return -ENODEV?

>
> It would be nice if the dev->iommu would record that the struct device
> is inoperable and then we can fail
> iommu_device_use_default_domain()/etc in a contained way.

Ohh okay.. you mean the dev->iommu_group == NULL may give an illusion to
<bus>_dma_configure that DMA is allowed? Even in that case the iommu 
would block the DMA right? And upon inspection of dmesg it would be
clear that something went wrong with the probe?


> 
> Jason
> 

Thanks,
Praan
