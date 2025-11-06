Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4B630C344
	for <iommu@lists.linux.dev>; Thu,  6 Nov 2025 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435416; cv=none; b=HExqsrdP6ZVpDuPJ/zLofmPC619cGMTgciFDLYJI5pncxPAH57eMmQowsxyRKdO2XfMj5zaYM2DhGUuKz7aff0+siU44i1S/nsWV1ZUQAHNR1ddduMoZqU2NmbVQXsuBjYmpEUG4sDxRShJM3JS1xDer/0lrvcGPHCCaIh+/N9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435416; c=relaxed/simple;
	bh=TTc1YZVFGADWKQiiPY6uw5gCc7UQJC9CAdmxWiCLymQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxUk6ou3y4jFf/Z1l781ctomdKmF36edmTqlkFUILjOGnlo50rSuCYa+WGNZTU9Q7EAL8G2tdQ/yr3/EQ4OC2RV459ugkHRtIeJA7cTrTrlqhWNKPaa1OAQj1onQP6+aGZlvOBrODi2yy82qrYlPj2S83sLNDU4dUAsfGjEXAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mgAvYVjT; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mgAvYVjT"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eba6e28d06so6877731cf.2
        for <iommu@lists.linux.dev>; Thu, 06 Nov 2025 05:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762435414; x=1763040214; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7wtPPBtmobTf3tpzGJgjCZN1OD+0vuddCl5gz261Lk=;
        b=mgAvYVjTwJ3ohb57b/AtuK/Bi4K73dm5WBt8NGF7LUExqUE5TF7K+0NohO7J6gg07+
         9Uq3+kAv5gOjdEEwkG5RblhgDR2hWSiZHMvQgqe5wiq30ergxwYXZ735a1Usne9tNsJW
         LZbvUw4JUofKETrOiEVkRuGCOozW6OcoGIR/PcE0kYc/y1TEhUeIn1qcGff1UClx1neV
         GWXd2V96o8H3DgDpxvG+zNvxamLh1qxaQ4VRXeM/L/pii/ghA9Eq5mMWWPfu4kHnXqBx
         5h9J4J7EujTatThzHRLSm9SKRdQIjOe1OTLYflOpHvl1c14g8KZC5jTCu3Zqokw/PHA8
         N/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435414; x=1763040214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7wtPPBtmobTf3tpzGJgjCZN1OD+0vuddCl5gz261Lk=;
        b=Atf3yFbKotJIMG5Vtf8Cj7y/gRHPx9fiMSerjex/txxfn3haSJTk4P8ZKubxGKXU3F
         d7f4JsJv0Soy8vilTdKXML5d5SZZSYF25KFtaPct7V+KRRwqmR54iOVbft0aPT/sOJxr
         h+B/k6ryuVWUzjn71fNC5K5PD7Ipa7kRSJAapuikhsnWO6u6XKfg2gnNJqpTYTxOJyFw
         EEM6RCMuLt+ujV3NBrrvmOsoE+t6AxQPJQmtdnLc6HJGVseHcE7kGiGgbCgDlv/t3AYx
         6nQUIWTCkI7/+uJOhHCsWYB2TfQzVdjcAujmLkA/hSgvSl0JaVLQpElAv4HIAvSs6l4Z
         Wc/w==
X-Forwarded-Encrypted: i=1; AJvYcCXLr7IMBFxNwRI1ZgNAAe9MXKgb17pD0mlMJ4H49TGBtn6XvhlainmQJfpgdl1OFaMuP2pXDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVdcUyWJKT2IHTxx8qQLpqfX3JNvEbVmlTkg2VCLxAyVH2nNig
	/prCKjT44DGR7EDMvm4tVmhy/xrvesAP3Kko4DlNaLu4vIEEPERbVnGzLaiFkzudvOs=
X-Gm-Gg: ASbGncuigUH4zcqJ7i35xG59S1qSqK6UlTYB5WlbXq8FRP3XZN6eCeg3FWQSxp92EIU
	HBEhGG6PhiuDo05gNdd7YY+UiqItiSkNDs7jNWS8oMdtm/ZovHasvg+OHYnoBmx66rXpoE9rUy/
	a7lBvs5q7cTu8xAOGlmTB7wJcskbQJWWMPVIbtBVi09vc9AsYIGIiAuJGVgIImilokTNpGMm6r5
	cA672yW36sT7AC9CUijaCUYzhCJoCiL0Ga7zIis51nVlcsfEQXwSfcxQNQsGFD3Uc5haUNNCWOn
	NIsD9RF6dbGbVt2hTs30IyQ8V2CngRwpMDn8LYISx3ZyCEMPeDe0FXnHq5fWmaDE2ZyiH3JJI1L
	oESpZhrDTBN2mt8OSZWwihIwO3Jp8faF0mphsIc2Ucsw5T304Wa76tbzyQo5irD8fYX85kIyVH4
	fCt9aN37f+y3HOYjbypkgus1SxT6JM7cG9W/hPuXOE1MTPwA==
X-Google-Smtp-Source: AGHT+IF7ECca/wRqtLDQUCBhDGbisYdGUoI40f4LwZi2mrfI2AA/kkhA/v5r6hx61UdEeG1jvFSALQ==
X-Received: by 2002:ac8:7d82:0:b0:4ec:f09a:4faa with SMTP id d75a77b69052e-4ed7234f780mr81238951cf.19.1762435413664;
        Thu, 06 Nov 2025 05:23:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed8131b8d7sm18568161cf.2.2025.11.06.05.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:23:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGzxb-00000007LoB-2m3P;
	Thu, 06 Nov 2025 09:23:31 -0400
Date: Thu, 6 Nov 2025 09:23:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 15/28] iommu/arm-smmu-v3: Load the driver later in KVM
 mode
Message-ID: <20251106132331.GU1204670@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-16-smostafa@google.com>
 <aMQmA9cLaeYWG5_C@willie-the-truck>
 <aNKwROPzDCWgJBGQ@google.com>
 <20250923173806.GF2547959@ziepe.ca>
 <aNppE9A3PDiDg_1W@google.com>
 <20251002151308.GG3195829@ziepe.ca>
 <aQt9-kTCe8TpuyVq@google.com>
 <20251105171208.GN1204670@ziepe.ca>
 <aQyBIohAuxNHV-XI@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQyBIohAuxNHV-XI@google.com>

On Thu, Nov 06, 2025 at 11:06:11AM +0000, Mostafa Saleh wrote:
> Thanks for the explanation, I had a closer look, and indeed I was
> confused, iommu_init_device() was failing because of .probe_device().
> Because of device_set_node(), now both devices have the same fwnode,
> so bus_find_device_by_fwnode() from arm_smmu_get_by_fwnode() was returning
> the wrong device.
> 
> driver_find_device_by_fwnode() seems to work, but that makes me question
> the reliability of this approach.

Yeah, this stuff is nasty. See the discussion here.

https://lore.kernel.org/linux-iommu/0d5d4d02-eb78-43dc-8784-83c0760099f7@arm.com/

riscv doesn't search, so maybe ARM should follow it's technique:

static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
{
        struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
        struct riscv_iommu_device *iommu;
        struct riscv_iommu_info *info;
        struct riscv_iommu_dc *dc;
        u64 tc;
        int i;

        if (!fwspec || !fwspec->iommu_fwnode->dev || !fwspec->num_ids)
                return ERR_PTR(-ENODEV);

        iommu = dev_get_drvdata(fwspec->iommu_fwnode->dev);
        if (!iommu)
                return ERR_PTR(-ENODEV);

It would make it reliable..

> > > 2- Check if KVM is initialised from the SMMUv3 driver,
> > >    if not -EPROBE_DEFER (as Will suggested), that will guarded by the
> > >    KVM driver macro and cmdline to enable protected mode.
> > 
> > SMMUv3 driver shouldn't even be bound until KVM is ready and it is an
> > actual working driver? Do this by not creating the struct device until
> > it is ready.
> > 
> > Also Greg will not like if you use platform devices here, use an aux
> > device..
> 
> But I am not sure if it is possible with built-in drivers to delay
> the binding.

You should never be delaying binding, you should be delaying creating
the device that will be bound.

pkvm claims the platform device.

pkvm completes its initialization and then creates an aux device

smmu driver binds the aux device and grabs the real platform_device

smmu driver grabs the resources it needs from the parent, including
the of node. No duplication.

Seems straightforward to me.

> Also, I had to use platform devices for this, as the KVM driver binds
> to the actual SMMUv3 nodes, and then duplicates them so the SMMUv3
> driver can bind to the duplicate nodes, where the KVM devices are the
> parent, but this approach seems complicated, besides the problems
> mentioned above.

I don't think you need to do this this, you can use aux device and the
fwspec things all search the iommu_devices_list to find the
iommu_driver. You don't need to duplicate anything.

Create the aux driver when the emulated smmu is ready to go.

> That works for me. And if we want to back the KVM driver with device I was
> thinking we can rely on impl_ops, that has 2 benefits:

> 1- The SMMUv3 devices can be the parent instead of KVM.
> 2- The KVM devices can be faux/aux as they are not coming from FW and
>    don't need to be on the platform bus.

IMHO this is backwards. The kvm driver should be probing first, the
smmu driver should come later once kvm is ready to go.
 
> Besides this approach and the one in this patch, I don't see a simple way
> of achieving this without adding extra support in the driver model/platform
> bus to express such dependency.

You shouldn't need anything like this.

Jason
