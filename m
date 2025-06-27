Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E070A298270
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751020974; cv=none; b=P59466i9IAMeUpYscsRJurIIRt+CdZzFekv7DubTk+04SYx6ZEKEu/MFJbF8yMj22S7HIWDrRFnU7hYZhOOG1vY9lREV9m1g4UJ7HNOhHwi87N2haOEBK/1Dcz+P1m5PNrajF+g3eV1ujQjZvpr2OC75OrGrLZ7BjGE8RqsKkwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751020974; c=relaxed/simple;
	bh=kQlsDwXrPFgl1A/aQW7glaPsDNQH27Vku+YZxYijmN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BH8YNzv5J0F+y51gt3v7wevcJPVxIufxZkwSPR7DOVE7VJvdCCPAwziwe+/dwZJ3yW4XxXU5KP2oipqJZslLIxfcS9dIRYvueQpAWm8YMMamEHQlikcep8hRY9aqnN/udh5WU0GfDndJ+FlDzxfk7s8H5FhnsIR61lNPGT++PXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0907D1A00;
	Fri, 27 Jun 2025 03:42:35 -0700 (PDT)
Received: from [10.57.30.59] (unknown [10.57.30.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9D143F58B;
	Fri, 27 Jun 2025 03:42:50 -0700 (PDT)
Message-ID: <43acfcd8-b359-448f-bbb6-da1b71a64f45@arm.com>
Date: Fri, 27 Jun 2025 11:42:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SMMUv3 interrupt handling via custom logic
To: Michal Simek <michal.simek@amd.com>, Will Deacon <will@kernel.org>,
 "Stabellini, Stefano" <stefano.stabellini@amd.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Sarangi, Anirudha" <anirudha.sarangi@amd.com>
References: <0482d84e-871b-4522-b94b-29a97c87ff66@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <0482d84e-871b-4522-b94b-29a97c87ff66@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-06-27 8:19 am, Michal Simek wrote:
> Hi Will and Robin, (+Stefano, Anirudha)
> 
> We are using smmu-v3 in our SOC and I would like to ask you for 
> recommendation how to handle our interrupt cases.
> 
> here is description which we are using
> 
> smmu: iommu@ec000000 {
>      compatible = "arm,smmu-v3";
>      reg = <...>;
>      #iommu-cells = <1>;
>      interrupt-names = "combined";
>      interrupts = <0 169 4>;
> };
> 
> but it is missing one important detail which just arise that actually 
> there is additional HW logic which deals with SMMU interrupts separately.
> There is a secure part (global, cmd, event - gerror, cmdq-sync, eventq 
> in DT)
> and non secure part (pri, global, cmd, event - priq, gerror, cmdq-sync, 
> eventq in DT).
> Based on my information all these interrupts should be acked once 
> handled to be able to get another one.
> The driver itself is able to handle them separately but we didn't create 
> any solution to reach custom HW to do it.
> 
> I looked at f935448acf46 ("iommu/arm-smmu-v3: Add workaround for Cavium 
> ThunderX2 erratum #126") which introduced combined IRQs but it looks 
> like that there is no need for additional ACK of that IRQs.

Per the architecture, SMMU interrupts are logically edge-triggered so 
there is nothing to clear at the SMMU end (the "interrupt status" is 
implicit in whatever condition caused an interrupt to be sent, e.g. the 
event queue becoming non-empty, SMMU_GERROR becoming different from 
SMMU_GERRORN, etc.)

If this is an Arm SMMU IP (MMU-600/700/S3) then the physical interrupt 
outputs are most definitely rising-edge. If somone's stuck some 
interrupt combiner in between those and the main interrupt controller, 
then yes, that interrupt combiner really should have its own driver.

> The HW logic itself is handling secure and non secure settings for SMMU 
> that's why would be the best to avoid directly mapping it in Linux.
> 
> One way to go is to create secondary interrupt controller driver
> a) ioremap one with notice about secure part because we are using SMMU 
> only with NS world
> b) firmware based to tunnel accesses via SMCs and allow only access to 
> limited amount of registers
> 
> The second way is likely create any hooks in the driver to be able to 
> provide additional SOC specific hooks.

If this thing is munging *all* the SMMU interrupt outputs as I suspect, 
then the big problem with that idea is that "the driver" is at least two 
separate drivers (SMMU and PMU), 3 if it has RAS and you ever want to 
entertain the idea of kernel-first handling.

Thanks,
Robin.

> 
> I am not quite sure which way would be the best that's why I would like 
> to get some recommendation from you.
> 
> Stefano: please correct me if any of my description is not accurate.
> 
> Thanks,
> Michal

