Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD0638D6B8
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775822864; cv=none; b=Ou45SNO7jXPDE90X3mHUMf+Jierc6Wb0vYY/S/skCkv+7RvpelbCuujue2fpPnQ6k4lEX/9Qq6uHycEpUnE7nlOYS2iA5iF0PxDFyc2xnzU1T2Z92lDH29CYEi5ctHmh4t1YWULh3LrDtzs/I5GswXwOc0xOw2rxxAHdhjzsSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775822864; c=relaxed/simple;
	bh=PBPEIkPfiCepOPjFH4e7wRaebjN5PVqKZxeWMBytThY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDf4t2TOyvXXKlEl/CyG6BO31p/8swXZn3IdD8fFI+Bo6i33f1B69a9DTmvPK9P1y7HXOeJMxyEO0e9JzhhwvsHznlbbMzUZTrZJtGNg8jZblE9KFOg5gwDFKrD+HRQKkQbEJ99OU13eXnv+5To8ol/ehPOpQ+zQTCHPJVVQMII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MWxTRcCu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MWxTRcCu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F253F1DB5;
	Fri, 10 Apr 2026 05:07:36 -0700 (PDT)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A43533F632;
	Fri, 10 Apr 2026 05:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775822862; bh=PBPEIkPfiCepOPjFH4e7wRaebjN5PVqKZxeWMBytThY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MWxTRcCuppU6dzrIFN6G/jMv8zUovaPZLaizogO1XSuzRTKsKhTzqcPgkSkwCYi0e
	 hardPVlJK7OcUHDj8mLXeulGlOgawyIE/hmNe1PSfLr4+umktS5kKT37WPjdRuo4RO
	 SbO2iH1TVJcEMghygqBS0UZdTc+SAMciAFgNUy6E=
Message-ID: <65629411-0e1c-4c9c-bc9f-6488097bd77f@arm.com>
Date: Fri, 10 Apr 2026 13:07:29 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm-smmu-v3: Add PMCG child support and update PMU
 MMIO mapping
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20260408-smmu-perf-v1-0-d75dac96e828@nxp.com>
 <2c1a1694-9597-400d-b441-714225b5377b@arm.com> <adZcaEKm3vIYSy3N@shlinux89>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <adZcaEKm3vIYSy3N@shlinux89>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/04/2026 2:47 pm, Peng Fan wrote:
> On Wed, Apr 08, 2026 at 12:15:31PM +0100, Robin Murphy wrote:
>> On 2026-04-08 8:51 am, Peng Fan (OSS) wrote:
>>> This patch series adds proper support for describing and probing the
>>> Arm SMMU v3 PMCG (Performance Monitor Control Group) as a child node of
>>> the SMMU in Devicetree, and updates the relevant drivers accordingly.
>>>
>>> The SMMU v3 architecture allows an optional PMCG block, typically
>>> associated with TCUs, to be implemented within the SMMU register
>>> address space. For example, mmu700 PMCG is at the offset 0x2000 of the
>>> TCU page 0.
>>
>> But what's wrong with the existing binding? Especially given that it even has
>> an upstream user already:
>>
>> https://git.kernel.org/torvalds/c/aef9703dcbf8
>>
>>> Patch 1 updates the SMMU v3 Devicetree binding to allow PMCG child nodes,
>>> referencing the existing arm,smmu-v3-pmcg binding.
>>>
>>> Patch 2 updates the arm-smmu-v3 driver to populate platform devices for
>>> child nodes described in DT once the SMMU probe succeeds.
>>>
>>> Patch 3 updates the SMMUv3 PMU driver to correctly handle MMIO mapping when
>>> PMCG is described as a child node. The PMCG registers occupy a sub-region
>>> of the parent SMMU MMIO window, which is already requested by the SMMU
>>
>> That has not been the case since 52f3fab0067d ("iommu/arm-smmu-v3: Don't
>> reserve implementation defined register space") nearly 6 years ago, where the
>> whole purpose was to support Arm's PMCG implementation properly. What kernel
>> is this based on?
> 
> Seems I am wrong. I thought PMCG is in page 0, so there were resource
> conflicts. I just retest without this patchset, all goes well.
> 
> But from dt perspective, should the TCU PMCG node be child node of
> SMMU node?

No. PMCGs can be used entirely independently of the SMMU itself, and 
while most of the events do relate to SMMU translation and thus aren't 
necessarily meaningful if it's not in use, there are still some which 
can be useful for basic traffic counting, monitoring GPT/translation 
activity from _other_ security states (if observation is delegated to 
Non-Secure) and possibly other things, even if the "main" Non-Secure 
SMMU interface isn't advertised at all. It would be unreasonable to 
require the SMMU node to be present and enabled *and* have a driver to 
populate PMCGs, to monitor events which are outside the scope of that 
driver.

Thanks,
Robin.
