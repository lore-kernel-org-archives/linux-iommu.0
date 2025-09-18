Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC011E25FA
	for <iommu@lists.linux.dev>; Thu, 18 Sep 2025 03:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758165670; cv=none; b=NWUlouGrn2cCspsO/7np9dmhP6UurVOj5uAQagaDcBd5LflIu65PD97+/yg2tVBmF98CmqLr/wlZWgO6pyxuC7zWC8byCxJ8bhT6iExGWLwI0Zq3YJXYnW8RyyLmpPgbIo2yVmB8GJfdO2N49pOGhqiwRVeBM/eb0cnnHOMeY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758165670; c=relaxed/simple;
	bh=AaHG4BnEsD25cTGFbi4zBqbmzvFH00NrB6tx1K5LtH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLXrOtNeviIPTozHEe8tQoeJ8AtwiizDF/pwD7MJbUnEvmH+ChS98HDjenjArfB+nSsQCGmYbss6+BqAov/AqtUA9lgX4mx+OrwxAajS/aIKjCq2ndbWebxu2cvak2aGGf9iejaUtO0KLiY9zD1pXpYjGNitoYCTrZA5kV8zoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=115.124.28.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from 172.38.29.243(mailfrom:guoyaxing@bosc.ac.cn fp:SMTPD_---.ehi8CF8_1758165655 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 18 Sep 2025 11:20:56 +0800
Message-ID: <48b8385a-ad44-4098-a647-109a3cfe3bbb@bosc.ac.cn>
Date: Thu, 18 Sep 2025 11:20:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] iommu/riscv: Add iommu perf driver
To: Will Deacon <will@kernel.org>
Cc: linux-riscv <linux-riscv@lists.infradead.org>,
 iommu <iommu@lists.linux.dev>, tjeznach <tjeznach@rivosinc.com>,
 joro <joro@8bytes.org>, "robin.murphy" <robin.murphy@arm.com>,
 "paul.walmsley" <paul.walmsley@sifive.com>, palmer <palmer@dabbelt.com>,
 aou <aou@eecs.berkeley.edu>, alex <alex@ghiti.fr>, anxu <anxu@bosc.ac.cn>,
 wangran <wangran@bosc.ac.cn>
References: <20250915020911.1313-1-guoyaxing@bosc.ac.cn>
 <aMfsj1U7NY2m68T4@willie-the-truck> <202509161827232434929@bosc.ac.cn>
 <aMqlR4vDOgrFuCUj@willie-the-truck>
From: =?UTF-8?B?6YOt5Lqa5pif?= <guoyaxing@bosc.ac.cn>
In-Reply-To: <aMqlR4vDOgrFuCUj@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Sorry, I tried switching a new email client and made some settings...]

On 9/17/2025 8:10 PM, Will Deacon wrote:
> [nit: your email client has made a big mess of the thread here]
> 
> On Tue, Sep 16, 2025 at 06:27:23PM +0800, guoyaxing@bosc.ac.cn wrote:
>>> PMU drivers are better placed under drivers/perf/
>>
>> I did a quick reading of SMMU pmu driver in drivers/perf/.  However, If
>> the RISC-V IOMMU PMU driver is placed under drivers/perf/ as the SMMU did,
>> it would cause an overlap in the iomem resource region between the two
>> devices(iommu & iommu pmu), because it needs to share interrupt-related
>> registers (such as the IPSR register) with the main IOMMU driver.
> 
> Is that not something you can resolve with IRQF_SHARED?
> 

Actually IOMMU perf is using stand-along interrupt, so might not need 
IRQF_SHARED with IOMMU driver.

What I mean is the IOMMU and IOMMU perf share the same registers, such 
as IPSR. This could result in overlap on this iomem regions between 
them, which is highly undesirable.

For now, two ideas come to my mind:
1. Integrate IOMMU perf functionality into IOMMU driver, just as 
previous version patch.

2. Let IOMMU driver export external api for IOMMU perf
(to obtain virtual address of IPSR register) for perf related operations.

So what's your suggestion?

> Will

Yaxing Guo

