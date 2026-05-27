Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3019481DD
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844176; cv=none; b=IcD+98HuINpd3p+u+KjISWlp6RT7UL04Wuy9NvcvypwIeUgOxebX6we47hrwAeH0fkxmGQznEfdR3VFXH2y9yTxzgWi2UatdEKSIZdXKAMKIWM10197jDkZDW71oYyqrutaaa9bwJe2mQqSNYIviR1sHdA7uGVzoaPErAOwKK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844176; c=relaxed/simple;
	bh=cGrM1sxNEKiIfg/I056NCGfN/rFdLQSkKIHQp9mo4Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IF4d6sp1oC0Q0t4AcheGOzjGH8YHLZzDYgJhEv/z6DWkr/M5Wnu1sgb4LJAYYrKo26ktXPb/cuTdPoqqf5n82RMxYQT69vFdYBdFCuU8pNWKh3P0kuDky/7e8Qzqei1eGTqPO67Wqq3sU7c7i+TW3LcinfxKWnvOZzxbbsyh8ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MibV3tQh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MibV3tQh"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4C1B620B7167;
	Tue, 26 May 2026 18:09:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4C1B620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779844164;
	bh=kXrQCVtkulGgej4aC/z0EB8PlQ/KjX/0N3n7pjaUBTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MibV3tQhoZBzNmKdSw2KnC+zkGX/k7c2kXxpMR9fELOsiH0VtEY056XTLYBOaSbvF
	 cyoCxZi8gpLyzksnuUtSlFO2SOsr1zru6CQ9BCmeALBOe2VR4DsZRDXYMyMBJMWhRY
	 Wosb7EmuU7yLccCh6mw1u79LepIwSobxN5Zpaxk0=
Message-ID: <70b0835f-29c1-ef3a-ef51-ec39612862a5@linux.microsoft.com>
Date: Tue, 26 May 2026 18:09:33 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V0] iommu/hyperv: Create hyperv subdirectory under iommu
Content-Language: en-US
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 mhklinux@outlook.com, wei.liu@kernel.org, jacob.pan@linux.microsoft.com,
 schakrabarti@linux.microsoft.com
References: <20260526012037.3874959-1-mrathor@linux.microsoft.com>
 <kqzr5ue5g5pdlp6pei37mfrymoln6y63iizzuiehtj3uiurfod@54fugjcdtuqr>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <kqzr5ue5g5pdlp6pei37mfrymoln6y63iizzuiehtj3uiurfod@54fugjcdtuqr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/26 08:59, Yu Zhang wrote:
> On Mon, May 25, 2026 at 06:20:37PM -0700, Mukesh R wrote:
>> Create hyperv subdirectory under drivers/iommu in anticipation of more
>> hyperv related files for upcoming PCI passthru and pv IOMMU patches.
>> Also, the current file hyperv-iommu.c actually implements irq remapping,
>> so rename to more appropriate hv-irq-remap.c and move it under the new
>> hyperv subdirectory. Lastly, this file should not be tied to
>> CONFIG_HYPERV_IOMMU, but to CONFIG_HYPERV and CONFIG_IRQ_REMAP.
>>
> 
> Thanks for this pathch, Mukesh!
> 
> Jason raised a question about whether Hyper-V's IRQ remapping file belongs
> under drivers/iommu/hyperv/ at all, since unlike Intel/AMD, Hyper-V's IRQ
> remapping is not co-mingled with the IOMMU hardware:
> 
> 	https://lore.kernel.org/all/20260520133807.GS7702@ziepe.ca/
> 
> Though we don't end up moving it elsewhere (the IRQ remapping framework
> and its internal header, irq_remapping.h, live under drivers/iommu/, and
> all existing backends sit alongside them), it would be good to acknowledge
> this in the commit message and explain the rationale,

Ok. Also, I missed the Kconfig file, will send V1.

Thanks,
-Mukesh

> 
>> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
>> ---
>>   MAINTAINERS                                             | 2 +-
>>   drivers/iommu/Makefile                                  | 2 +-
>>   drivers/iommu/hyperv/Makefile                           | 2 ++
>>   drivers/iommu/{hyperv-iommu.c => hyperv/hv-irq-remap.c} | 8 +-------
>>   drivers/iommu/irq_remapping.c                           | 2 +-
>>   5 files changed, 6 insertions(+), 10 deletions(-)
>>   create mode 100644 drivers/iommu/hyperv/Makefile
>>   rename drivers/iommu/{hyperv-iommu.c => hyperv/hv-irq-remap.c} (99%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d1cc0e12fe1f..b651ee0c6e6b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11914,7 +11914,7 @@ F:	drivers/clocksource/hyperv_timer.c
>>   F:	drivers/hid/hid-hyperv.c
>>   F:	drivers/hv/
>>   F:	drivers/input/serio/hyperv-keyboard.c
>> -F:	drivers/iommu/hyperv-iommu.c
>> +F:	drivers/iommu/hyperv/hv-irq-remap.c
>>   F:	drivers/net/ethernet/microsoft/
>>   F:	drivers/net/hyperv/
>>   F:	drivers/pci/controller/pci-hyperv-intf.c
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 0275821f4ef9..d9683422aecb 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_AMD_IOMMU) += amd/
>>   obj-$(CONFIG_INTEL_IOMMU) += intel/
>>   obj-$(CONFIG_RISCV_IOMMU) += riscv/
>>   obj-$(CONFIG_GENERIC_PT) += generic_pt/fmt/
>> +obj-$(CONFIG_HYPERV) += hyperv/
>>   obj-$(CONFIG_IOMMU_API) += iommu.o
>>   obj-$(CONFIG_IOMMU_SUPPORT) += iommu-pages.o
>>   obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>> @@ -30,7 +31,6 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
>>   obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>>   obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>>   obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>> -obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
> 
> Any reason why we are removing the CONFIG_HYPERV_IOMMU? You are leaving
> CONFIG_HYPERV_IOMMU an orphan configuration now (and also the  backward
> compatibility issue?).
> 
>>   obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
>>   obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
>>   obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
> 
> B.R.
> Yu

