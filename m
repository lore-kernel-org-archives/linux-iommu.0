Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CCC29D267
	for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348982; cv=none; b=Hk0rn0rQJAydK/SY6eTi6Bkywisq7pDPwQQYy1r0IyGfHWd9lQ/tZr0W5OiFX4bqJUmY6fVT0NG4OKNU8gGC4iTTEFo12f4ZMtv18QmX3sy1j3JXTY1xopbG/60/m+B/4fvr37xo0tXTg7N4OCFjfkYLDBKke1kwg+BWJt0p534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348982; c=relaxed/simple;
	bh=0byOqs9jXkwQPT2C3r9AIGUPc8DDDt6e/1nad/Jl9Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOKjz6m314Iz0QC+JyTWHJJdu8KQwey0xGD8OcvIJ77TMl7LibDdy+3ufn44LjheoFfd5hesU6/pdjq+z7QsUGU+UdW3CdbRIj/Fc+cuufjiBytl8aLqDdvNuDm6HVVoDFYb3tM1lDncACZAW16GECuTvOgwam2Xc5paIT22w3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hWqKiMuB; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hWqKiMuB"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b2a4b6876fso279618185a.3
        for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 08:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764348978; x=1764953778; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCl9X4qI8yhLb81mSCvOL49MIOZcpHAsJ/PLn0AOLzs=;
        b=hWqKiMuBu7lvEYzaq6GhMQwGvWDAZ6fClzuqIGJpmmUB2Q31KGXA249oEyZLNJDmak
         gQp4V213203O9m95grjwHK5+fPsN19g+GZNODtCuDHcJ8iMw5y55mq8SpnJw12BjjWZA
         2Uwee54+1wlOlB9GSDrJ1nbsshwFNjoZP+QmCCPUijRpmsw4gJI4icg7NLE9cq/qietY
         4KXwl3bM4LMgFaTwC1sZJnOnSndDzELl9+qi6hVsr7wq12+qr2Iqt98w0UCxGQ2Mg9T+
         P9GqE//1ipNSyEMUuhY4EnwXxfEQpU8M2SjONpLWaWf8qk2SPBK8Xnb5YB5QHD/aMZ2r
         yqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764348978; x=1764953778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCl9X4qI8yhLb81mSCvOL49MIOZcpHAsJ/PLn0AOLzs=;
        b=HNBWzb3LCFNahny2FvRKx22FzHIb9SFHz8XtazpwXnTZ314aXzh4fbpCsaCdDve3qs
         DKKerGTl+lWJFJSK4m83AL7+DCF0xDbjQHQij9t4OpH8ijmtYDIW6b8P9E4ExCuve6/8
         /0PI94bKiWxtfCOrXWRvFIFfEezvDod727WGP1bBgX9K/aztB59mTb/MCDCizX+ZKVzm
         3f3SY/Egz6F71+cwpZdW6cW6OfdLydE+5qPLh2GNFVd9ZgmOagkk+5f9ARZzvzEVsn+T
         nu/RR+P44Z6bWu0Iwx/qV+KpbXCNXyldzxcFH/x0M+rTN92KHpn1uMc41MA5ZkubhuF0
         Hfow==
X-Forwarded-Encrypted: i=1; AJvYcCWoFR1Gh9Zg/l8QPBUXZpjfUwR9Tg03CGPha4KLktBM7Z67HRZdLdNzMVdLMlSWt2jpKRTrIg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw23cK/U+USVEX9b3JNI61hheBrNCEIBOQkXgXx3bY0oM+1Tfir
	CIyeNK12a5zoYrnEH4czixd+QaSXiN14bQaFctfunEFiIhfGocH5V0I0udBdSkUCPks=
X-Gm-Gg: ASbGnctR+LxqSY3IpjDRm61Hofaw21+q7YNjEviKIWdP8qCwv3QT1r7ZjQuF4ouRbuy
	r5p8EQvB+7ug8VQCVD2BPWo+XMSCH260KQdkYgafbpBP0I6eV56dnohttny55NvstxPJ63KRTX9
	C17HO9XcZRNMnpLbm/kPaPxCIo00Dhglbjpv6pKPh9HI+WVD/1+YRribBbgZR6ZMfFrtO8h880D
	I6IA4SLkmhSUZ4fBnR6X/cCRJruXOGEYdyFvR7JgDAuKTuAtkEgasKM0a7a3PWffhueISEknx3I
	hd9AW8f/J7GbxULpPnN4hpkE368ZzvEfQtOMzB1IFlXJUIlbcNo8NIu2KddKDbynDJH9UMQQ+Lo
	mDRy+78iN3YuSnvmrgpONw9cx0k+v/MrT4LjjK37m7U/+LuUYYUAEtHh38W/wdZ7Th0SwNft7i1
	wWjFB+JJlPo4RFzZrxPi7GR8VIpKMDNuIdZRbXdlQwDYuLwEm/YlIlIVuX
X-Google-Smtp-Source: AGHT+IGIckk1twmdF2dvhlgnAkNoETKwIZpnGAw6TiBLkZPFGsmOSfaowEINSQpVofG9sVXQPmMVQQ==
X-Received: by 2002:a05:620a:4546:b0:8b2:ea33:389d with SMTP id af79cd13be357-8b33d203829mr3744011185a.4.1764348978095;
        Fri, 28 Nov 2025 08:56:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b5299946dbsm342827685a.7.2025.11.28.08.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:56:17 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vP1lY-00000003Q4b-3UBP;
	Fri, 28 Nov 2025 12:56:16 -0400
Date: Fri, 28 Nov 2025 12:56:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com
Subject: Re: [PATCH v5 14/27] iommu/arm-smmu-v3: Support probing KVM emulated
 devices
Message-ID: <20251128165616.GD812105@ziepe.ca>
References: <20251117184815.1027271-1-smostafa@google.com>
 <20251117184815.1027271-15-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117184815.1027271-15-smostafa@google.com>

On Mon, Nov 17, 2025 at 06:48:01PM +0000, Mostafa Saleh wrote:
> When KVM runs in protected mode, and CONFIG_ARM_SMMU_V3_PKVM
> is enabled, it will manage the SMMUv3 HW using trap and emulate
> and present emulated SMMUs to the host kernel.
> 
> In that case, those SMMUs will be on the aux bus, so make it
> possibly to the driver to probe those devices.
> Otherwise, everything else is the same as the KVM emulation
> complies with the architecutre, so the driver doesn't need
> to be modified.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 58 +++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 7b1bd0658910..851d47bedae6 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/acpi_iort.h>
> +#include <linux/auxiliary_bus.h>
>  #include <linux/bitops.h>
>  #include <linux/crash_dump.h>
>  #include <linux/delay.h>
> @@ -4604,6 +4605,63 @@ static struct platform_driver arm_smmu_driver = {
>  module_driver(arm_smmu_driver, platform_driver_register,
>  	      arm_smmu_driver_unregister);
>  
> +#ifdef CONFIG_ARM_SMMU_V3_PKVM
> +/*
> + * Now we have 2 devices, the aux device bound to this driver, and pdev
> + * which is the physical platform device.
> + * This part is a bit hairy but it works due to the fact that
> + * CONFIG_ARM_SMMU_V3_PKVM forces both drivers to be built in.
> + * The struct device for the SMMU is used in the following cases:
> + * 1) Printing using dev_*()
> + * 2) DMA memory alloc (dmam_alloc_coherent, devm_*)
> + * 3) Requesting resources (iomem, sysfs)
> + * 4) Probing firmware info (of_node, fwnode...)
> + * 5) Dealing with abstracted HW resources (irqs, MSIs, RPM)
> + * 6) Saving/reading driver data
> + * For point 4) and 5) we must use the platform device.
> + * For, 1) pdev is better for debuggability.
> + * For 2), 3), 6) it's better to use the bound device.
> + * However that doesn't really work:
> + * For 2) The DMA allocation using the aux device will fail, as
> + * we need to setup some device DMA attrs (mask), to match the
> + * platform.
> + * For 6) Some contexts from the pdev as MSI, it needs to use the
> + * drvdata.
> + * Based on the following:
> + * 1- Both drivers must be built-in to enable this (enforced by Kconfig),
> + *    which means that none of them can be removed.
> + * 2- The KVM driver doesn't do anythng at runtime and doesn't use drvdata.
> + * We can keep the driver simple and to claim the platform device in all cases.
> + */

It is OK I guess, I wouldn't insist you change it, but I think it is
kind of gross. Registering the iommu driver against the platform
device instead of the aux is pretty ugly and denies userspace the
ability to see that the hypervisor is sitting in there through the
sysfs topology.

Not sure why the commentary about built-in though, what does that have
to do with anything? If the aux driver is not built in then it will
just module load later and everything should be fine?

Jason
