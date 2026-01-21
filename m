Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064DA4921B7
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001783; cv=pass; b=c38rTBJuD/wlZ7RTLCtZeIFrPA1wCZ4WlbwEb99DVVKlEXbgsXO70CH2i9BgwxTly1WxrFt+Qt50OO+hM7m3J0qkCNHnH5bpREAaKakjV6MTNAp7kOypUntQfXGQR8IjOkXJvqzdxPAYAJ83svJ40A0+wgn4tIfzRUJzyAccvIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001783; c=relaxed/simple;
	bh=yEgcr40VQhOLEftR/t7J516ntpJIhqPO42ZC5RrF4UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAoTflo633k5aNkY6mKP+F50AvZI4FW4B3X/gd2i5ROKEzIrR+G02AFnzbnbjjgAYJJaotRGy0P60NRsdd88dnQ14FYeJqikaPgU5MFDCaCnIFsLM6mySzQUUHbM0A6PpAbhJ9RDjJ0rXZ9an3f+r0KZekXw7C/SoNdFkf5Jz7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aC6QyT1p; arc=pass smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC6QyT1p"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so12068076a12.1
        for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 05:22:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769001775; cv=none;
        d=google.com; s=arc-20240605;
        b=E9RJ4mKXilwWZwaHCzrzJn2rfPhfui1qHl2VjWd8F/kV4RplZhcDiB3up62/zRD5RK
         TS9Kh4uneZfhDQ8LiCppjPZTcaYPS2uRPb4GOaqz7qYVwhVi7UP/aLXHRe5+T5DbGjLK
         KpEEvn6ppkMUSftHfHsjcmkMzxiXwdhORYPKjEcD/UvV+W7t7KEf/9aVwFdlp+fDROmi
         BNWD8B3wjvyWdidCWZR7wabIAa2vjSgbxd5ucExwuSyYcGCnAKBwOToodgLrgEiPjd7c
         jzSiUgB9fOcF35VsvEbeP6PgmSPMyTFZKt8BL1XaAxkAojqymZzgcWispYKGc+rqFDx6
         +A3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GL+gDmFrJN5LyjvIjcwO8wjaEWmzubFTGCKPz3jpYTk=;
        fh=3zbWNeZ9P7RH1Y++l4D+99EuuhV2q16wera4dQDgVSk=;
        b=JhmjRocLegm8/Iw+/YmiiTYuHzzIwp6lboMjtoYvpQAxDn1a46Sz0OoRGEUHfbQxnY
         qLl+k+DDlOusMC4zXjA1flrWenz9gBUvIqswSuZcigQoj8CU+qQEjMsFoXefy5jtWSF0
         F4/HRPKDSTLUvDY+0zjoZuxyMiXKmDIhckduuUoxwzXKfhXJsfO7oXvzEB1cGxvauwIG
         r5R9vLKFEfgB1peS7lKcM9lPbiBJqkLiotLcYXl46GwMPKNul9kqxGRj0mvBB0GAsYZO
         tOQ0B+9ynhP52aBAc/ubxkFVWlit9HbIPTWw9XSBKk8DkuXItOWPt4l6+RfjDG8ng6m2
         YL0g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769001775; x=1769606575; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GL+gDmFrJN5LyjvIjcwO8wjaEWmzubFTGCKPz3jpYTk=;
        b=aC6QyT1pTttHTNwr/NAYfMUv9GlwOdO4fnprAH0vsyyh2IZBKmeSQyfVeezQqYh7iE
         ekYJ9q88FWZXe2cBwfsCBDa4dcwgRH8B0I2FMx9IBLjn4ZPFDq93UiZCm/r+jOKbtvX5
         +XeyHrQVz54b/JEfLuCxtJ3X9Zjn2hBjjZn5RdTTP3IX3h8VbrAOG5l4gn+Xrm33gi8d
         rAWKSfQZinfi1b00a+k9pQA0DuCo30z3wdXOgyrdzZmIYcCprmDLhaD4rzKWrkha4uIA
         4j/lZWRnw9+MuLWGTSL8eFJ2bsiq2sJdcQNOqqVCFGMek9PrswyGAR3KH1jlLfXZF0fX
         p2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769001775; x=1769606575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GL+gDmFrJN5LyjvIjcwO8wjaEWmzubFTGCKPz3jpYTk=;
        b=EAVRq3kb6e65HhT8RI0oL2jLZtoqXtNOHkgOEfj9lelqpGgYJM0Fo9NZh3n2PPahuD
         dHwbyS/mnbRjOB4l40aIPDL7Ij2W2iIkHrrVbbIOWU3Fmmzbb0DB5AQJYLsYOOCA1bk3
         GkhwBb9SXNJD+LnNqZS42N/NcZv/Qt+jzvOnbwHots0srapHwWUoXQjcq1WAATUAoX0r
         nuuEzNz9ZYOrmn7CS8Z2Foyv2LfxIqaHXcZ645vSYVw7/aTk/waJYJ4YtJMbyp/Suhyx
         GO6FPZ4neDwFdXHIU4F4sZunV5krVrIDRbr8evR+NoFVs/zC3dh5SGCR1dLcl0zpNSY2
         NoDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOtxvV4GoNH0+BkLKrqd5RoX0H4boZuFc31vRzPNf2BWkKPa7YBBWlNGfUOFEoIjKpuwkGIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXPSASyoJJG8O/Z492wmweRngtOau+VI2bbekc/qqCUI0PIDu2
	t91jQZVwsU92488qnKS6MEMqTxuO41/twRiYWWL73yaAgvKU0BgA0zKYnoed9+ozBxNw+4V0r+X
	2LwNMu7isGK8KY0fwvBQMgQWb6/jjoos=
X-Gm-Gg: AZuq6aLz5/e3+kMUUecjtQJdOnKCNDumrc60AGFh6xZKu4Sc6LWWkPgn1NtV50RQ27I
	PLeEwIuir3RYX+t1Z7h5kfd/+2r8eYs5GgNoh3y4E4s14FzU5yIiQmVYgey1uozxkfuosa1hvxj
	49AssMw+jB4uWoOscbhfc7UhITgXt2uD4DrG4UHtVbxJRfPAu/FjQ9RPe3w/KdNSfqttjFqPWXA
	iAEYyr2SIB4igJaLXGqdA5zP2KMhsnR6Oy3tYgAmsO0xPCKsV6kpr/7H0hyem+PDQ7/qNMa
X-Received: by 2002:a05:6402:5d0:b0:655:c01e:ec27 with SMTP id
 4fb4d7f45d1cf-655c01eef0cmr11842605a12.13.1769001774908; Wed, 21 Jan 2026
 05:22:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CALbr=LYt-MqGM0ua78Rt7M679WR9hNnk0Or-WrB2myZ=KhaN0w@mail.gmail.com>
 <20260121085549.165428-1-akaieurus@gmail.com> <DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org>
 <DFU7SVI5SYE5.3MJP2ECGGZK5P@kernel.org>
In-Reply-To: <DFU7SVI5SYE5.3MJP2ECGGZK5P@kernel.org>
From: Jiayue Wang <akaieurus@gmail.com>
Date: Wed, 21 Jan 2026 21:22:55 +0800
X-Gm-Features: AZwV_QiegzQ2mhV8STvOkraTfIW0vCUhW1EFG-1ihIXGD3s1KAQ_UAVxlNleihs
Message-ID: <CAFE6=PDyWwGGHbRVoLTZyUgcWC3CQ1kt1df4sLT8BWYrt6FS9Q@mail.gmail.com>
Subject: Re: [PATCH v5] driver core: enforce device_lock for driver_match_device()
To: Danilo Krummrich <dakr@kernel.org>
Cc: hanguidong02@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	Aishwarya.TCV@arm.com, broonie@kernel.org, chenqiuji666@gmail.com, 
	linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, 
	robin.clark@oss.qualcomm.com, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

>
> On Wed Jan 21, 2026 at 11:40 AM CET, Danilo Krummrich wrote:
> > So, the problem is that in the callstack of the arm-smmu driver's (a platform
> > driver) probe() function, the QCOM specific code (through arm_smmu_impl_init())
> > registers another platform driver. Since we are still in probe() of arm-smmu the
> > call to platform_driver_register() happens with the device lock of the arm-smmu
> > platform device held.
> >
> > platform_driver_register() eventually results in driver_attach() which iterates
> > over all the devices of a bus. Since the device we are probing and the driver we
> > are registering are for the same bus (i.e. the platform bus) it can now happen
> > that by chance that we also match the exact same device that is currently probed
> > again. And since we take the device lock for matching now, we actually take the
> > same lock twice.
> >
> > Now, we could avoid this by not matching bound devices, but we check this
> > through dev->driver while holding the device lock, so that doesn't help.
> >
> > But on the other hand, I don't see any reason why a driver would call
> > platform_driver_register() from probe() in the first place. I think drivers
> > should not do that and instead just register the driver through a normal
> > initcall.
> >
> > (If, however, it turns out that registering drivers from probe() is something we
> > really need for some reason, it is probably best to drop the patch and don't
> > make any guarantees about whether match() is called with the device lock held or
> > not.
> >
> > Consequently, driver_override must be protected with a separate lock (which
> > would be the cleaner solution in any case).)
>
> I assume that this should resolve the problem (unless there are more drivers
> that register drivers in probe()):

I tested this patch on qemu, and the boot appears to be normal now
without deadlocks. I encountered some other minor issues, but those
are likely due to my forced emulation in qemu and should be unrelated.

Tested-by: Wang Jiayue <akaieurus@gmail.com>

>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 573085349df3..9bb793efc35f 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -774,10 +774,6 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>  {
>         const struct device_node *np = smmu->dev->of_node;
>         const struct of_device_id *match;
> -       static u8 tbu_registered;
> -
> -       if (!tbu_registered++)
> -               platform_driver_register(&qcom_smmu_tbu_driver);
>
>  #ifdef CONFIG_ACPI
>         if (np == NULL) {
> @@ -802,3 +798,5 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>
>         return smmu;
>  }
> +
> +builtin_platform_driver(qcom_smmu_tbu_driver);
>
> @qcom maintainers: I'm aware of commit 0b4eeee2876f ("iommu/arm-smmu-qcom:
> Register the TBU driver in qcom_smmu_impl_init"), but I think the above patch
> should work fine as it is still *not only* registered when
> CONFIG_ARM_SMMU_QCOM_DEBUG?
