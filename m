Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ECA41E6AE
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233528; cv=none; b=mvDWqbzUOldBEePUwtiXoEwo2lQeX1Z6/lvXZHIthPGczbNHzhDWHLH0NRyA0UR5X1GadaZHIgrfGIz1y3EqcLmnY9mjHlFCPL+UkuL9yH667MIJxH/GOZQwFR6aQniAdrYTbvWooXP7CFk9/vAag8fN16ea+TmBh/Zzz5DVQsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233528; c=relaxed/simple;
	bh=6leiCN3pkPFLqMLMC2KNnK0hii5X5/tbQFOo1FGBJk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1lZd700H2Gp57pF1f1tqBAJxMcW+6H18Md2f1j4HSnNChRDbo4yIOOlOaQjlBFwtan+Xc5dr/RRa0T1aqU7NC+rR1TUQf1UIgjeBZ17IdbnOGgB9qTFDh57U6g6UcZHdRbeCmX16JGgFKcVKASnUxuVh/Qy1YViPmSZ7y4GoVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jr55sWKr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jr55sWKr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B07631A9A;
	Tue, 28 Jul 2026 03:12:01 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3FF43F66F;
	Tue, 28 Jul 2026 03:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785233525; bh=6leiCN3pkPFLqMLMC2KNnK0hii5X5/tbQFOo1FGBJk8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jr55sWKrM6w7NW1/ChujHXK+E0TIMr3fS42fwHeT/P4R9tYPUbk+ggMLGaklc2iNN
	 qXo8dsc8k8kpi1MOkCXKUiAaqgImrc0D1xKNIu0bcjLkASurDnc3ueCYrIyV2rbb0Y
	 yziuFMs+CoQ3rw21jbLEr5J+3L2+rVZIX5pgrn/0=
Message-ID: <ac70a08e-0acc-4cee-b615-fdf552ef645f@arm.com>
Date: Tue, 28 Jul 2026 11:12:02 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: Add override for MMFR1.HAFDBS
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, joro@8bytes.org, jpb@kernel.org, jgg@nvidia.com,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <cover.1785153415.git.robin.murphy@arm.com>
 <d7b31cbcd984c1efa61d2fc97111150cc18e21b0.1785153415.git.robin.murphy@arm.com>
 <amh-aW67-ifCUXXF@willie-the-truck>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <amh-aW67-ifCUXXF@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/07/2026 11:03 am, Will Deacon wrote:
> On Mon, Jul 27, 2026 at 01:03:28PM +0100, Robin Murphy wrote:
>> In general it might be nice to have the ability to disable hardware
>> access/dirty bit management for debugging or performance comparison
>> purposes without having to rebuild the kernel. However once FEAT_HAFT
>> comes into the picture we also start to have a real functional concern
>> where the decision to use HAFT based on the boot CPUs can prevent SVA
>> or late-onlining if SMMUs/CPUs are later found to lack HAFT support.
>>
>> To that end, add the appropriate MMFR1 override, with an easy "nohaft"
>> alias for the significant case, partly since the feature/field naming
>> isn't the most obvious, but also so it could potentially be redirected
>> in future if someone wanted to attempt a higher-level means of turning
>> off just HAFT usage independently from FEAT_HDBSS.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v3: No change.
>>
>>   Documentation/admin-guide/kernel-parameters.txt | 3 +++
>>   arch/arm64/kernel/pi/idreg-override.c           | 2 ++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index b5493a7f8f22..7f23e5b8dc44 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -565,6 +565,9 @@ Kernel parameters
>>   	arm64.nogcs	[ARM64] Unconditionally disable Guarded Control Stack
>>   			support
>>   
>> +	arm64.nohaft	[ARM64] Unconditionally disable Hardware managed Access
>> +			Flag for Table descriptors support
>> +
>>   	arm64.nomops	[ARM64] Unconditionally disable Memory Copy and Memory
>>   			Set instructions support
>>   
>> diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
>> index bc57b290e5e7..0e051fec5afe 100644
>> --- a/arch/arm64/kernel/pi/idreg-override.c
>> +++ b/arch/arm64/kernel/pi/idreg-override.c
>> @@ -64,6 +64,7 @@ static const struct ftr_set_desc mmfr1 __prel64_initconst = {
>>   	.override	= &id_aa64mmfr1_override,
>>   	.fields		= {
>>   		FIELD("vh", ID_AA64MMFR1_EL1_VH_SHIFT, mmfr1_vh_filter),
>> +		FIELD("hafdbs", ID_AA64MMFR1_EL1_HAFDBS_SHIFT, NULL),
>>   		{}
>>   	},
>>   };
>> @@ -246,6 +247,7 @@ static const struct {
>>   	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
>>   	{ "nokaslr",			"arm64_sw.nokaslr=1" },
>>   	{ "rodata=off",			"arm64_sw.rodataoff=1" },
>> +	{ "arm64.nohaft",		"id_aa64mmfr1.hafdbs=2" },
> 
> What happens if I pass this option on a CPU that doesn't implement
> HTTU at all? Will that then end up *enabling* HA and HD?

Nope - that's what I checked, hence my comment on v2 being grateful to 
Marc for making the framework so idiot-proof ;)

It combines the override value with the detected CPU features in the 
usual way, and since HAFDBS is a LOWER_SAFE feature it all works out. 
Booting a Juno with "id_aa64mmfr1.hafdbs=17" has no effect other than 
printing a message that it ignored the override.

Cheers,
Robin.
