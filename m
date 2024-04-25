Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E02D22616
	for <iommu@lists.linux.dev>; Thu, 25 Apr 2024 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044199; cv=none; b=IGHKrl8vYTI8mHqNglXosJVlowcCb43MtsExEuvXnmMuVPON8LhwUdwSJmea42K1fCJNXLeIaLbMMyLOv8QQNVILoBpWYvki6FL/FzeFY4FbPlM3bb9lccHL6YSYRW3vckSFBdICaxWY6TolzyvATb8s0++sSBL26TyTLcqEouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044199; c=relaxed/simple;
	bh=gfoJXkVK/lOH5itEoJQhq4vcxeidrY3EHRS0cGus9ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEGg4uK2tXu9i7jWxl6PxrF/8D/qyPxVmxf2SIC1zMaYcQesj156BPX/MlnzhJOvK1NVoevdlLmo2CMLtu7aMyOb6r87PPamQOwyPo88BFfED4Zzx5UpI/YAs6D+Wzi8BKBvNhfhqznHUAh7jZ9VRqx/P3OdGIC8vHgbmlGH34o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CA141007;
	Thu, 25 Apr 2024 04:23:43 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A8B03F7BD;
	Thu, 25 Apr 2024 04:23:12 -0700 (PDT)
Message-ID: <059ae516-aed4-4836-a2ca-aff150ff428d@arm.com>
Date: Thu, 25 Apr 2024 12:23:10 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>,
 Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux@rivosinc.com
References: <cover.1713456597.git.tjeznach@rivosinc.com>
 <741996169fef074b5d9f4f218c2a98bf5dd38386.1713456598.git.tjeznach@rivosinc.com>
 <7f9a82ea-c4c8-40a5-8f26-7cb135e91c5d@arm.com>
 <CAH2o1u6FpDWNZsQCADQQKauPYzxDE73DRHHQKw6LjNb27ePeXw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAH2o1u6FpDWNZsQCADQQKauPYzxDE73DRHHQKw6LjNb27ePeXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/04/2024 10:59 pm, Tomasz Jeznach wrote:
[...]
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 2657f9eae84c..051599c76585 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -18972,6 +18972,12 @@ L:   iommu@lists.linux.dev
>>>    L:  linux-riscv@lists.infradead.org
>>>    S:  Maintained
>>>    F:  Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>>> +F:   drivers/iommu/riscv/Kconfig
>>> +F:   drivers/iommu/riscv/Makefile
>>> +F:   drivers/iommu/riscv/iommu-bits.h
>>> +F:   drivers/iommu/riscv/iommu-platform.c
>>> +F:   drivers/iommu/riscv/iommu.c
>>> +F:   drivers/iommu/riscv/iommu.h
>>
>> I'm pretty sure a single "F: drivers/iommu/riscv/" pattern will suffice.
>>
> 
> Correct. But will required a workaround for pretty naive MAINTAINERS update
> check in scripts/checkpatch.pl:3014 in next patch.

As long as what you're doing is clearly reasonable to humans, the 
correct workaround for any checkpatch complaint is to ignore checkpatch.

[...]
>>> +static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
>>> +{
>>> +     u64 ddtp;
>>> +
>>> +     /* Hardware must be configured in OFF | BARE mode at system initialization. */
>>> +     riscv_iommu_readq_timeout(iommu, RISCV_IOMMU_REG_DDTP,
>>> +                               ddtp, !(ddtp & RISCV_IOMMU_DDTP_BUSY),
>>> +                               10, RISCV_IOMMU_DDTP_TIMEOUT);
>>> +     if (FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp) > RISCV_IOMMU_DDTP_MODE_BARE)
>>> +             return -EBUSY;
>>
>> It looks like RISC-V already supports kdump, so you probably want to be
>> prepared to find the IOMMU with its pants down and deal with it from day
>> one.
>>
> 
> This is the simplest check/fail for the kexec and/or boot loaders
> leaving IOMMU translations active.
> I've been already looking into kexec path to quiesce all devices and
> IOMMU in shutdown path.
> I'm not convinced it's ready for the prime time on RISC-V, will
> address this in follow up patches.

Yeah, for regular kexec you definitely want an orderly shutdown of the 
IOMMU, although there's still a bit of an open question about whether 
it's better to actively block any remaining traffic from devices whose 
drivers haven't cleanly stopped them. It's in the kdump crash kernel 
case that you can't have any expectations and need to be able to recover 
the IOMMU into a usable state, since it's likely to be in the way of 
devices which the crash kernel wants to take over and use.

Thanks,
Robin.
