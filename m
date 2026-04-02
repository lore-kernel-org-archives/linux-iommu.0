Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C08F3CA4AB
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129172; cv=none; b=hh8RYAR9bSuQyOFpVQaBK8P6TAg+hubJgwCmwDjfxE+JP0MidBxb2BrETgUwaB1cNNlabcuIJdiE7NP5R+ZsuzCD4OYFn5llyzAUApOFBo02kDfTy7mFtbSL3TSxLlaJhW6jhXMAFApuI+/ReJGOPchDXHNW1I/8gomnofqIGFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129172; c=relaxed/simple;
	bh=M6U4j/NLiQ+/4aHjkSTAmvKfIhe8Sr7hjNTZaZUG7ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okdq+ZXVDdeJIQZCgQ+m68wxJlncI3gD6K99kg3MUxlzzdo8SLA3BMVZJTYHy7POgBaJCbug2ulZVfAHCdFR3wKRIyFlEZQzqbtWPWfB+6PzD0TrS3MunOO7E4vcCdZaltEaCqRwXHlbU5p1Siud/AQJcZkQwpajBUlwPJO/kag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sz2ypk6x; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sz2ypk6x"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4888cfa003fso6036945e9.0
        for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 04:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775129159; x=1775733959; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5JQGdVakt/jSwsp5LQgcZLl+3LElhn2BfzsSs+MpKc=;
        b=Sz2ypk6xl2T70eipXGk7KPwVTCfoSZhB8wNx5GMazAhgWoglRHJ9dFQU3Cs/9yR1QL
         xNP+tHqRtQbQ5pc7OWwwvgYokJi4pPp2GkdCdb9/NVCSdYoFYOP61rc2UDL2VKzDNMEb
         oZEr+cWi/Xv8XDKxMX9outLLS+Icm6R60jYSLJyWaZXIOcrlY760ScZIGXOhBe4qeCxY
         05gPhSoTlkfFE98eRG6G8V9w+KLn6DYjaqT+Y4ulObnyxiDAIDGSz84x0JZ37jbuVK75
         BiLx0NGKqtDmm1Uz4mKPkjyhQXr/WIOD+dTzscFWOBzgJAjQONTGNVZLtN/um3uYFMle
         rSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775129159; x=1775733959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5JQGdVakt/jSwsp5LQgcZLl+3LElhn2BfzsSs+MpKc=;
        b=m4BwPzOybIDv3za32httBHFxZAxwd5ads2hKfM5emRWbv7JWVIv3WYCba638ux0R/X
         YprhgCM647ytbDUsIRYGg6cGOp4g8OYMlOnhw7zjP0Ic1mzcSZpzk14H4u638HXFhP7/
         dmzAUu76BuL0Un4sM2tqZqDBF9g+sW98p0MOY6O+AzeYxr98CE1qhZO6GDETy2hxw4HX
         PsiGazJRTrZEzzrXiITEvkv/FfnekyrsVSJat7kh1SUabMVvggZ8RxtHifqH3tdv5MLK
         eB0+8wX+DeatiZh4suavDvBmDKvHpwnV/qfnCVm0PcYMijIDiPKQBA96Y61PR1vWKd2r
         6Cag==
X-Forwarded-Encrypted: i=1; AJvYcCWL7L3mrNoUFeyLxYVkCQ55rQutslAkEsMN6RLzRrcnk3Cs9D9y0QL1WyirVxfNY7iZiArxCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTIs8PVQFSW4F0bqFB+B16mtQhylSFptilnh3pgafAqYJKA70m
	8WBeJAipYQj8w+CyELeRX6ujt7MrvRiMe7WPsnZKRdF9GGv3tNoo/E/u5vra/IB3hhE=
X-Gm-Gg: ATEYQzy3QB5oYN43D2qDxpLGXq0GT5gyVYKsBXGrYNxo0KjwHwf0p+KpVpC7TzgceMY
	KCXTOwZLp3xmSd8x6bf1IzwnYiMRrrxceCP5HusGBfjbnf7gMTO0Q4eaoxH+xE+u4AWiGlKygXH
	E0M2uMwkj9EgE7JhX1gifOEpY9VsRJGHPtWpbf8AsaysiqCg7IKce06hCYUt2b7fafc3qczKcGC
	ceAQ6ry3sYMyURdhWaeXqiK5m5YuOcYOhTLSVMCiQ7Wn8uWL5I8UJKK2q3mRbToVuaGwLneBZoX
	NOkxrT9qoThp79Vdm9+5pONEAMb4QSeGIpDdUfsX6WZgLT0TlMFZGbbOKgWhvjjLRPF+eQuEhH4
	OBTfeB26bvbaSCHL3atuH8g+jWTEW3g/RIFyZlbgDtjwDDhtzub1WXrJNE+rtkAzA/WvXjWgE97
	Raz7+MxzZmIalTxAn8Im782110SvhoP5TAs6oh7pqWNQ==
X-Received: by 2002:a05:600c:4744:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48883591f01mr121033965e9.21.1775129158565;
        Thu, 02 Apr 2026 04:25:58 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887ad1cd86sm65951315e9.5.2026.04.02.04.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 04:25:58 -0700 (PDT)
Message-ID: <9892a17b-022e-41df-af1c-a2d684aa8db1@linaro.org>
Date: Thu, 2 Apr 2026 14:25:54 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Fix bypass of IOMMU readiness check for
 multi-IOMMU devices
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, willmcvicker@google.com, jyescas@google.com,
 kernel-team@android.com, stable@vger.kernel.org
References: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
 <20260323135414.GA8437@ziepe.ca>
 <1062b66d-e4d0-4eee-8fc2-dbb65491a01b@linaro.org>
 <20260323173138.GB8437@ziepe.ca>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260323173138.GB8437@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Jason,

On 3/23/26 7:31 PM, Jason Gunthorpe wrote:
> On Mon, Mar 23, 2026 at 06:46:39PM +0200, Tudor Ambarus wrote:
> 
>> Downstream we have a display controller that's using:
>> 	iommus = <&sysmmu_19840000>, <&sysmmu_19c40000>;
>>
>> These are 2 distinct platform devices, they probe independently, they
>> each call iommu_device_register() independently.
> 
> Sure, I guessed that is what you ment..
> 
> Do you have an example of this in an upstream DTS file?

Yes, Exynos multimedia blocks use this upstream For example, in
arch/arm64/boot/dts/exynos/exynos5433.dtsi, the `decon` and `decon_tv`
nodes route through multiple sysmmus:
iommus = <&sysmmu_decon0x>, <&sysmmu_decon1x>;

Looking at the upstream exynos-iommu.c driver, it doesn't return
-EPROBE_DEFER if all the instances listed in iommus doesn't exist.

It seems it survives the race though, but only because of the
core_initcall ordering. In downstream the IOMMU is forced to be a
module which exposes this gap.

>  
>> If I understood you correctly, the downstream driver shall model its
>> architecture and call iommu_device_register() only once after both
>> devices are configured.
> 
> No.. I'm not being so perscriptive, I'm just saying that once
> iommu->ops->probe_device() returns then the device is fully setup and
> dev->iommu will operate all of the iommus described in iommus=<..>
> 
> probe_device() cannot return some half setup device with only some of
> the iommu instances working.
> 
> We don't have any core idea of a half setup result from
> probe_device() today.
> 
>> If the core's intent is to strictly enforce a single IOMMU instance,
>> shouldn't iommu_fwspec_init() be checking
>> 	fwspec->iommu_fwnode == iommu_fwnode
>> instead of matching the ops? Because the core currently matches on
>> ops, it permits aggregating multiple physical instances with the
>> same ops into one fwspec.
> 
> The driver is responsible to handle this, not the core. It has to hide
> this mess under its covers, not rely on multiple calls to of_xlate or
> however it has been hacked up.
> 
> Probably it means something like of_xlate/probe_device has to
> EPROBE_DEFER if all the instances listed in iommus don't exist.
> 
I can probably track whether all instances are ready, and defer if any
is not ready, but then I'll force the iommu clients to use the sketchy
replay path, which seems like a bad idea, according to Robin's feedback.

I haven't seen functional problems with the races, just the "something
fishy" dev_WARN. Maybe we shall downgrade that to dev_info.

Thanks!
ta
