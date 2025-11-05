Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37398331A53
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360834; cv=none; b=L7j2lNJvyy/x/0Y4pddngczGdYyx3G14iM6cxAq+A6Pw1w6YlXjASBzUj5Th6Yf8/Y5GXdss5kclerOp2R7eInotee+znzeYgpQU9kbJFU+MOTuFtEU+gG/RfOcfBog9d4qEww/l4Is03j5NGXPufCizYitra9e2mKZlca9JUSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360834; c=relaxed/simple;
	bh=atIZzAToir8eRpbQcVVHtDtwnLdnBANcxYeOYHDiA2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeZ+KFU7oKva211pZmd5RyLXmL+Ia8Bx3h8hiwKk+7pRj+qBXx89XiFN1ylcKZSw+ECjCwZVl2hYz8rmaeTfC5Cu6dG11c6ksD6aDgUnQwLpQGt3ny65sD4nS+JipSEYYrRlF+lUPCCJM0nlYmWlwCo7DVNNFYRg3hmWGP8SrWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z0DkvU36; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z0DkvU36"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47754e0a13bso33765e9.0
        for <iommu@lists.linux.dev>; Wed, 05 Nov 2025 08:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762360831; x=1762965631; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0eEl5tuPcKQIbbiQU4HmtriawKnG+Y/aITWPg2eK/vk=;
        b=z0DkvU36XqwPkHpms2PXgkHwYeC7Wiss5dMFwwIWavYZ/kwum/Tm308KV/GtUscYom
         rmWDvL2sEZiKy5+ovnmwopDW1Y3UmMkdJoS1hWR9YPxGFkA5VzGch4kEFCEjIF4K0AUa
         qX8MRN7s0yt9GjWoP7kwY9R/PEbNEWVAfltGc2n1TIpZ4dajQ+ZMf2xsm8JZgrFjRe4D
         +7N7rGMFhD3TtXBqqZdFIMjgWyHXExobls3wPD0ZBaU5VsoBKDZ9CsBkeTRMeEuY8TKt
         Q3S1oHnknmEhknw+XJVoZG8hJCr+x65EkMhPvtl/FHZODiMIZ+E/lQFPDimrvysAMChc
         grKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360831; x=1762965631;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0eEl5tuPcKQIbbiQU4HmtriawKnG+Y/aITWPg2eK/vk=;
        b=hcrkJAzMOLCNYmBlM9Q1koRnwaUvksIm4ez4b28MbkNpBlQz8OAc1qR4DCh+u65KbZ
         txYMQeLTIObHd5U8HRY5FIDDuaOlM8cOHAvj35fqIjBUg2u00PaBP5PyR8ovaIrrzqzZ
         M6JBjEUmy41yaEbcgfwMPsLQ2WBKYqBzuda5xUaArDFsacdRxadQA0Tn0YlnYfEiDsvx
         trNjx1Dt+R8OuNR6QSbux7BNFWfmHNn6Vff2u451jKz5bLLyLqDICv3ocLKFdACrgNX0
         ApG9A+/GpQ3yzAteNe7g00BOytoyCheDJCDwrcVlZlXT5oN0lo5o/k1JKVz/kincLpfr
         YOJw==
X-Forwarded-Encrypted: i=1; AJvYcCVWgVNLvQB6Vwm0Bgyo4mlmIg/rQHT1gv65bEgHdmHpHDkKAJLhoScx/RMHXoUd8/NGT/V7fw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzJLlnkNj7ZPRQC5uksgV1Yk5wTMsuYz4d4tq5gtGjEZzOTZ2Z
	qXEZkvoByWXN8KKEK6RsgKxIYwbd/ypXinYZSRpA/W26/nziinl54p2EPE6xFUZa7g==
X-Gm-Gg: ASbGncuDOUX01JsjS+XvVclFv75EAkIhejnsoQSmoAvnp0yG9A2748Up40cSvRWB550
	U7rXcWoDwN/wLAMQ4sif78TqgZONVBHu3GQNnDjs0XHjdnnJN2/APsYKTkinZIpX3laLXuO58c9
	UhTsbdSFCk0N1UB6pqtNEoOq30dUGhV6kL4ZufB26wqcXmZAXCix+h2IneNEWCZhmFhfATS2Znh
	7U8eMoRslNQx3RcJAOSOUOr+0LS9zzPCvU9MVaVQ1ZjGsZrpG03U3MzBoBmyY/d9KXWxb2RLPUB
	zmU+FECvJ6B4zOZF8lRcMDQpgpddOSl4q9kYgmc+QNSZzi7hvm52FLxYVOTe9E7itEWS4VVI6L8
	D5kUcfbzU07efhhiUuj+Vf99nN2r77P7Kkj8bcpwmkUytuzI8FmRDrTXoYMn3XVex0mscQ0sblV
	ipiCoS/vNp8mm2o2tx837Zc21X91nQUVtLWPQ7L4BD/FJdWSVC/ZPPZ/vYHwOC
X-Google-Smtp-Source: AGHT+IEy+8V+O2C0Flc9TdN/DCHlTtarKl1lxRtJWgoMhvht/+272KjjM3JvTIZWVNcKN9O18oV/xA==
X-Received: by 2002:a05:600c:3ba3:b0:477:1afe:b962 with SMTP id 5b1f17b1804b1-4775dae9364mr3187645e9.1.1762360831358;
        Wed, 05 Nov 2025 08:40:31 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc200878sm11360022f8f.45.2025.11.05.08.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:40:30 -0800 (PST)
Date: Wed, 5 Nov 2025 16:40:26 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 15/28] iommu/arm-smmu-v3: Load the driver later in KVM
 mode
Message-ID: <aQt9-kTCe8TpuyVq@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-16-smostafa@google.com>
 <aMQmA9cLaeYWG5_C@willie-the-truck>
 <aNKwROPzDCWgJBGQ@google.com>
 <20250923173806.GF2547959@ziepe.ca>
 <aNppE9A3PDiDg_1W@google.com>
 <20251002151308.GG3195829@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251002151308.GG3195829@ziepe.ca>

On Thu, Oct 02, 2025 at 12:13:08PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 29, 2025 at 11:10:11AM +0000, Mostafa Saleh wrote:
> > Another possible solution, to keep a device bound to the KVM driver,
> > is to probe the SMMUs from the KVM driver, then to create child devices;
> > possibly use something as device_set_of_node_from_dev to bind those to
> > the main SMMUv3 or find another way to probe the main SMMUv3 without
> > changes.
> 
> I do prefer something more like this one, I think it is nice that the
> kvm specific driver will remain bound and visible so there is some
> breadcrumbs about what happened to the system for debugging/etc.
> 
> Not sure how to do it, but I think it should be achievable..
> 
> Maybe even a simple faux/aux device and just pick up the of_node from
> the parent..

I spent some time looking into this

With the approach of creating new devices as:

	pdev = platform_device_alloc(dev_name(dev), PLATFORM_DEVID_AUTO);
	pdev->dev.parent = dev;
	device_set_node(&pdev->dev, dev->fwnode);
	platform_device_add_resources(pdev, cur_pdev->resource,
				      cur_pdev->num_resources);
	platform_device_add(pdev);

That is done from an init call after KVM init, where the KVM driver
probes the SMMUs, which then does
	bus_rescan_devices(&platform_bus_type);

In the KVM driver probe, it had:
	if (pdev->dev.parent->driver == &smmuv3_nesting_driver.driver)
		return -ENODEV;

Which causes the main SMMU driver to probe the new devices.

However, that didn’t work because, as from Linux perspective the
nested driver was bound to all the SMMUs which means that any
device that is connected to an SMMUv3 has its dependencies met, which
caused those drivers to start probing without IOMMU ops.

Also, the approach with bind/unbind seemed to not work reliably
because of the same reason.

Looking into the probe path, it roughly does.
1) Device / Driver matching driver_match_device
2) Check suppliers before probe (device_links_check_suppliers)
3) Actual probe

I can’t see a way of adding dependencies in #1

For #2, there 2 problems,
i) It’s not clear how to create links, something as fwnode_link_add()
   won’t work as one of the devices won’t have fwnode and device_link_add()
   will need the device to be already created (and not sure how
   to guarantee it won’t probe)
ii) Assuming we were able to create the link, it will be set to
    DL_STATE_AVAILABLE once the nested driver probes, which won’t prevent
    the main driver from probing till KVM initialises.

It seems device links are not the write tool to use.

So far, the requirements we need to satisfy are:
1- No driver should bind to the SMMUs before KVM initialises.
2- Back the nested driver with devices and possibly link them

The only possible solutions I see:
1- Keep patch as is
2- Check if KVM is initialised from the SMMUv3 driver,
   if not -EPROBE_DEFER (as Will suggested), that will guarded by the
   KVM driver macro and cmdline to enable protected mode.

Then if needed, we can create devices from the nested driver and link
them to the main ones in same initcall after the devices are created.

I can to look into more suggestions, otherwise, I will try with #2
with the -EPROBE_DEFER.

Thanks,
Mostafa

> 
> Jason
