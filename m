Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF03C3C02
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519125; cv=none; b=U6W2UTIv3jHVRkJQP0mpL9uZUo6BL+1OVm4VviXrTnc5kNi6BeZsRzQ1wbdT4z/zX9yn8YcX7hkUwjzUvFWUap5wb886Praw3bCZGeCYrGv4SD+zIxqXh3gHM/pHT5Io1NV8QZVQR6M6aD4a9rgAGzY6VxbzW67m63KAYnmFLnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519125; c=relaxed/simple;
	bh=6IqqQfMoQbRxVazGX5hKi7O8RtJ1WBB2vj4yvCARcA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Y/vqTsnHUJxdzdmyfPm2/xZhJYDdy6ByFSmkmEwp58GL1QTjzITfy80MRHucSK4NSfuXk1ZMdX+keZxJcozz3j+UGANSR2AvcVXfje4HYwgJ1eW8rHlcUkDxR11lgTzeIel6bU8FVGYq1Uxmf9V8laFmvAZE7kIcKHxNig1thoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XVGLFt7A; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XVGLFt7A"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260326095833euoutp02e0e9f696c261134f92ad406d6570d8a6~gW7tvl4SG0454004540euoutp02I
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 09:58:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260326095833euoutp02e0e9f696c261134f92ad406d6570d8a6~gW7tvl4SG0454004540euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774519113;
	bh=guDjPoCVnwYxXsCuno8FxlAqWDyeX+17V89RQydjDBU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=XVGLFt7Apqn21yhPWeW1UNuhKNqTboOtZ+UhS0CgObFVgMXWsowDWbu+tsM39Lyws
	 WYbg+km/a8z317lu3iAH0Q8461T4DF+/r6W6OVS6Kv5p6Qa60MMn0mGJBdimobDgV3
	 0Sm0SC4jjh7ucYpJIlfauJFgIvcrvltVOJDm2l8M=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260326095833eucas1p1f993eda67f6c9a6b3e67a439f023871d~gW7tMghLC0527405274eucas1p1x;
	Thu, 26 Mar 2026 09:58:33 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260326095832eusmtip2da486e52f07287d36be8ef809ccac84b~gW7sXJRUn1854318543eusmtip2P;
	Thu, 26 Mar 2026 09:58:32 +0000 (GMT)
Message-ID: <fe9359e0-1c9a-4113-82c3-0275c932a58a@samsung.com>
Date: Thu, 26 Mar 2026 10:58:31 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 0/7] Refactor reserved memory regions handling code
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev, Krzysztof Kozlowski
	<krzk@kernel.org>, Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>,
	Saravana Kannan <saravanak@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260325141648.GA2685599-robh@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260326095833eucas1p1f993eda67f6c9a6b3e67a439f023871d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260325090029eucas1p1932917cc4839c3349932aeda37a7125d
X-EPHeader: CA
X-CMS-RootMailID: 20260325090029eucas1p1932917cc4839c3349932aeda37a7125d
References: <CGME20260325090029eucas1p1932917cc4839c3349932aeda37a7125d@eucas1p1.samsung.com>
	<20260325090023.3175348-1-m.szyprowski@samsung.com>
	<20260325141648.GA2685599-robh@kernel.org>

Hi Rob

On 25.03.2026 15:16, Rob Herring wrote:
> On Wed, Mar 25, 2026 at 10:00:16AM +0100, Marek Szyprowski wrote:
>> The reserved memory regions handling code was reworked to handle
>> unlimited so called "static" memory nodes in commit 00c9a452a235 ("of:
>> reserved_mem: Add code to dynamically allocate reserved_mem array").
>>
>> The side effect of this rework was a set of bugs fixed later by commits
>> 0fd17e598333 ("of: reserved_mem: Allow reserved_mem framework detect
>> "cma=" kernel param") and 2c223f7239f3 ("of: reserved_mem: Restructure
>> call site for dma_contiguous_early_fixup()"). As a result, the code in
>> drivers/of/of_reserved_mem.c became a mix of generic code and CMA
>> specific fixups.
>>
>> In this patchset I try to untangle this spaghetti and perform some code
>> cleanup. I hope nothing breaks this time.
>>
>> Best regards
>> Marek Szyprowski, PhD
>> Samsung R&D Institute Poland
>>
>>
>> Changelog:
>>
>> v3:
>> - fixed more issues pointed by Sashiko in
>>    https://protect2.fireeye.com/v1/url?k=c0975fdb-a11c4aed-c096d494-74fe485cbff1-5d0a8d4ece172e7b&q=1&e=abd3a151-11c5-430e-a6ac-b04cc3b34ab7&u=https%3A%2F%2Fsashiko.dev%2F%23%2Fpatchset%2F20260323100901.4079171-1-m.szyprowski%40samsung.com
>>    (restored use of _OF_DECLARE macro, extended some comments and commit
>>    descriptions, the remaining items I consider not relevant)
>>
>> v2: https://lore.kernel.org/all/20260323100901.4079171-1-m.szyprowski@samsung.com/
>> - added missing ops assignment removal in tegra210-emc-table and swiotlb
>>    drivers
>> - fixed issues pointed by kernel test robot and Sashiko: removed typos,
>>    improved comments
>> - fixed incorrect node passed to fdt_validate_reserved_mem_node() in
>>    fdt_scan_reserved_mem_reg_nodes()
>>
>> v1: https://lore.kernel.org/all/20260313150802.1121442-1-m.szyprowski@samsung.com/
>> - initial version
>>
>>
>> Patch summary:
>>
>> Marek Szyprowski (7):
>>    of: reserved_mem: remove fdt node from the structure
>>    of: reserved_mem: use -ENODEV instead of -ENOENT
>>    of: reserved_mem: switch to ops based OF_DECLARE()
>>    of: reserved_mem: replace CMA quirks by generic methods
>>    of: reserved_mem: rearrange code a bit
>>    of: reserved_mem: clarify fdt_scan_reserved_mem*() functions
>>    of: reserved_mem: rework fdt_init_reserved_mem_node()
> I've applied the series, thanks!

I forgot to mention this earlier. There are other pending changes 
tokernel/dma/contiguous.c like 
https://lore.kernel.org/all/20260303-dma-buf-heaps-as-modules-v3-0-24344812c707@kernel.org/ 
which I would like to merge to -next. This conflicts with this patchset. 
Could You provide a stable branch with those changes to let me resolve 
conflicts in kernel/dma/contiguous.c on top of it?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

