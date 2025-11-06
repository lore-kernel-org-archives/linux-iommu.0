Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C546A30CD83
	for <iommu@lists.linux.dev>; Thu,  6 Nov 2025 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427179; cv=none; b=GvhGmbL4evgBiuK4CpW+xI8bJznWnxQMGZevByIUlcTcd2TATsgb0t/1xeGq8G80ax9SmBB3HYLZXoXilYx6T+CLnj0pGUvmZKgWRLgUFzcsNXjaNj6AhmiJRA7KU3D9UfevJrxHjL1unt0JLuifz6Tslt9DPUOEWNko053M6/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427179; c=relaxed/simple;
	bh=4cS4awkDakBBGs7QL/xXO0LyzLmqQrXz8qdFmMEuZhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEnUyUOLnmZREb1rlApYVztBUP0ikD/tksiqgYiKXoX0yQaDfgsAxVVxzNmwjEHGbvGE0XrjidNIRTyU1CkVXP8acDnzbE2yom6pI4jBF2rW2ShTLrf3hhE2RRkx4pt93HP7Q7UdwbYuV2Ju9dCJkj1fPorg/bbO2GRbd8CaaCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OatDnBtt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OatDnBtt"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47754e0a13bso57145e9.0
        for <iommu@lists.linux.dev>; Thu, 06 Nov 2025 03:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762427176; x=1763031976; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xP2QazUoPgLd8bd4CuoIUWxA+WJ3ehNooABdbD8w52A=;
        b=OatDnBttRf1EjzvOI6MKBjVHdN5pe8dDGYQsNhH0jt1qZ4ltKwB4qIjXu2+9rjU+JB
         +sTDu5ft0OzrQKlOwu65d62T/medrBlZ8bL5sDsLsfNG8rk/jlocfdMZ9e/4/qtUhDOA
         Gv1QLU3XnK/eG9Yc60mezPEhh1481BWj4Ko9Fd95xbYCzwlUqW1E7oAmbesW/76PT08v
         mvNz0Km+SohAJmYPUP1e/Kvch2Lzko07NXVsSxYWbzDB2G4xVSRxEZZGqIx4WSqoV9i0
         pbLTVS6j9zbzDGcOiBh0s6SBcJlazqXjWWXsI/Q9gSgVJCn+OU8DvOMCdgeD4mfzlFXp
         Jvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427176; x=1763031976;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xP2QazUoPgLd8bd4CuoIUWxA+WJ3ehNooABdbD8w52A=;
        b=h3ggwUopZGYmZzPi3Lml2Y0q5dL6Gr1P1UqOEmnFYRafiDwJNXdTQxpWqsuXhLVCa0
         9mtp/nVFz2R8PshV836VbTYwmyhIdInAh6FT97qcHSxI/uLDgI7+SyzUx5uACQaeCqRE
         DcIPpNYAPXRfUpUxAjRGfJgXnB0vVuMniC65o3YgjNHebDpgET/YguxUCbE4sN1mnDoM
         1hXgz+0OrsrpmDFHUiWnjpFjm/b6qB+MoUoySGVbrvqe4v9mMNkpmZHB3RAUcOUD8Nl/
         HVzPzbFgeLwCKQDFBf+tY+rwHTUDgcbb2xL4+SJgGo7KwCoxQHFQMUuq0StBZIoMbl7m
         zKgg==
X-Forwarded-Encrypted: i=1; AJvYcCVX1KsWj9pT9KuatxhPDqGWAJWxjW5bSsp6w5iL/OTYarKXQAQjVjpO+UV6C5ACYBDpHNIjAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKiK6oooPBjDRUOvsbbfx7rZO05US0e1+RL3jUHt8WpApUoFeJ
	9W+HgMq/Z+IeAJ9R7R+3No6dYPQ8eDwAvxyTfJ9yM0lpRhIbm9R1MjRnayPF3jSLuA==
X-Gm-Gg: ASbGncvtXCHtsRKBG856lvEqXOf/qnE7xx39J/17Ng7r2/zSCJPvp4xermgzfTCmjE9
	kS4yn/le3V1fhNSbKt+G8jg/41gDObYOXNI2AxUqAvT8iCyX7dGt10wWf+uVfiooN1skIC3B7iW
	pd7XsQSsFAm1UHsLI6R412OAxJYsCiho9XhAMBb8Eg8g+elbJq8BYG8oBwdUpbHdb1nrEqQq47w
	tnKjpo/Zi1SG8h3ThY/IFFzqnVFBWT0/DO4AtC7wSqlAnGLKolscEd/tQD6k+D+sj+3prAhl0NU
	P+998am1HpjxGkrNPZjDfZ8lllplW494X5Cl5Wx3A6H4z/bPCxIl48QMLaz6ndNCO2KMAhuOZl0
	Bw1/lBMfwVrEBd6U2mNn/BnKBz9Xmkn6v7cGojhwsdIJz8EbyaO87ds8uU98Ca1itOx08eP3R1a
	1by0fEiy4VMnFCSTEyUwZcExZqAGrLi47O0J+N9XIf2Z6Ai+yVWw==
X-Google-Smtp-Source: AGHT+IEUOv1ZE3UbDFaV92jPApWKF4Ndj0TjhhcPgVhbXYQBhOFnOW3XBZWOwcR3RPC6W7WWXNjURQ==
X-Received: by 2002:a05:600c:58d1:b0:475:d905:9f12 with SMTP id 5b1f17b1804b1-477628cece0mr1822875e9.4.1762427175811;
        Thu, 06 Nov 2025 03:06:15 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm4426519f8f.32.2025.11.06.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:06:15 -0800 (PST)
Date: Thu, 6 Nov 2025 11:06:11 +0000
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
Message-ID: <aQyBIohAuxNHV-XI@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-16-smostafa@google.com>
 <aMQmA9cLaeYWG5_C@willie-the-truck>
 <aNKwROPzDCWgJBGQ@google.com>
 <20250923173806.GF2547959@ziepe.ca>
 <aNppE9A3PDiDg_1W@google.com>
 <20251002151308.GG3195829@ziepe.ca>
 <aQt9-kTCe8TpuyVq@google.com>
 <20251105171208.GN1204670@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105171208.GN1204670@ziepe.ca>

On Wed, Nov 05, 2025 at 01:12:08PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 05, 2025 at 04:40:26PM +0000, Mostafa Saleh wrote:
> > However, that didn’t work because, as from Linux perspective the
> > nested driver was bound to all the SMMUs which means that any
> > device that is connected to an SMMUv3 has its dependencies met, which
> > caused those drivers to start probing without IOMMU ops.
> 
> ??
> 
> What code is doing this?
> 
> If a struct device gets a fwspec attached to it then it should not
> permit any driver to probe until iommu_init_device() has
> succeeded. This broadly needs to work to support iommu drivers as
> modules that are loaded by the initrd.
> 
> So the general principal of causing devices to not progress should
> already be there and work, if it doesn't then maybe it needs some
> fixing.
> 
> I expect iommu_init_device() to fail on devices up until the actual
> iommu driver is loaded. iommu_fwspec_ops() should fail because
> iommu_from_fwnode() will not find fwnode in the iommu_device_list
> until the iommu subsystem driver is bound, the kvm driver cannot
> supply this.
> 
> So where do things go wrong for you?

Thanks for the explanation, I had a closer look, and indeed I was
confused, iommu_init_device() was failing because of .probe_device().
Because of device_set_node(), now both devices have the same fwnode,
so bus_find_device_by_fwnode() from arm_smmu_get_by_fwnode() was returning
the wrong device.

driver_find_device_by_fwnode() seems to work, but that makes me question
the reliability of this approach.

> 
> > It seems device links are not the write tool to use.
> 
> Yes
>  
> > So far, the requirements we need to satisfy are:
> > 1- No driver should bind to the SMMUs before KVM initialises.
> 
> Using the above I'd expect a sequence where the KVM SMMU driver loads
> first, it does it's bit, then once KVM is happy it creates the actual
> SMMU driver which registers in iommu_device_list and triggers driver
> binding.
> 
> This is basically an identical sequence to loading an iommu driver
> from the initrd - just the trigger for the delayed load is the kvm
> creating the device, not udev runnign.

SMMUv3 driver as a module won't be a problem as modules are loaded later
after KVM initialises. The problem is mainly with the SMMUv3 driver
built-in, I don't think there is a way to delay loading of the driver,
besides this patch, which registers the driver later in case of KVM.

> 
> > 2- Check if KVM is initialised from the SMMUv3 driver,
> >    if not -EPROBE_DEFER (as Will suggested), that will guarded by the
> >    KVM driver macro and cmdline to enable protected mode.
> 
> SMMUv3 driver shouldn't even be bound until KVM is ready and it is an
> actual working driver? Do this by not creating the struct device until
> it is ready.
> 
> Also Greg will not like if you use platform devices here, use an aux
> device..
> 

But I am not sure if it is possible with built-in drivers to delay
the binding.

Also, I had to use platform devices for this, as the KVM driver binds
to the actual SMMUv3 nodes, and then duplicates them so the SMMUv3
driver can bind to the duplicate nodes, where the KVM devices are the
parent, but this approach seems complicated, besides the problems
mentioned above.


The other approach would be to keep defering in case of KVM:

@@ -4454,6 +4454,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
 
+	if (IS_ENABLED(CONFIG_ARM_SMMU_V3_PKVM) && is_protected_kvm_enabled() &&
+	    !static_branch_unlikely(&kvm_protected_mode_initialized))
+		return -EPROBE_DEFER;

That works for me. And if we want to back the KVM driver with device I was
thinking we can rely on impl_ops, that has 2 benefits:

1- The SMMUv3 devices can be the parent instead of KVM.
2- The KVM devices can be faux/aux as they are not coming from FW and
   don't need to be on the platform bus.

And this is simpler.

Besides this approach and the one in this patch, I don't see a simple way
of achieving this without adding extra support in the driver model/platform
bus to express such dependency.

Thanks,
Mostafa



> Jason
