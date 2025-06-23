Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBD7248F45
	for <iommu@lists.linux.dev>; Mon, 23 Jun 2025 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680091; cv=none; b=tCCWj5PSg7IbGF7+8EMqA+7M0iWkyozfLbMZHmCXPoWSILtG1CA5hbww5bp765HgvdlQOe3cQxOgwlohWP6vrdTU3JPKy2WOYgIA2FK3tUs52vD+UH0xpY3pTwbXJ+oj9whF990+l7k1BKeAP66aPdNT4hHMPJ6DpJKowQsilNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680091; c=relaxed/simple;
	bh=BKnx4RIjek7E/rOPu3UOodiyY/m4uTgXkFgE5y0mRIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=qrgUVJNM00OB3ySdFIfRlJMU1BscfXxEMEq38Htlcrl1y0UOVDkVZ9QCYwSc2mlJKxL4xdsEHkDShoR94B+5yNZPbtMOE0PLorZNzB0hR9euDu+/my75NA6ouizi3Nx2OHUwdbnSODVnRWS/PEaHFCRx1gXJuwfsXiNT4w1mQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J3KThsGO; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J3KThsGO"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250623120124euoutp0267df18d0b2753844a6b08fa2149eb30b~LqkL7fY810497204972euoutp02U
	for <iommu@lists.linux.dev>; Mon, 23 Jun 2025 12:01:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250623120124euoutp0267df18d0b2753844a6b08fa2149eb30b~LqkL7fY810497204972euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750680084;
	bh=QmswFbqzDq4XOvS740eYk+68L2oNBkefGQTaJgQK+NY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=J3KThsGOubEgfg0IwfVOeEA0quwMGx4pOLWaqXWJysp0fJTqskxNJWJ5sIhvynS+I
	 QKhL+ARVFJFgTl6yg8dSnhSN78CVSoAUvvNLEsPFxm/G3AWi66CtR5/ui3XMpmZc0o
	 sfBOoArXI1Cn8047YyJrRVU1IirsQxU/jVhdUnXg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250623120124eucas1p2441d1be7176d61d849aea1bd1b892b8e~LqkLj4zVB1744517445eucas1p2Y;
	Mon, 23 Jun 2025 12:01:24 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250623120123eusmtip20dfa1daf0bd30559e6dac8b8c2bf818b~LqkKytaR50067700677eusmtip21;
	Mon, 23 Jun 2025 12:01:23 +0000 (GMT)
Message-ID: <ed07e57d-00e0-44b3-b53e-b5295aee8561@samsung.com>
Date: Mon, 23 Jun 2025 14:01:23 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 1/4] dma-mapping: benchmark: Add padding to
 ensure uABI remained consistent
To: Barry Song <21cnbao@gmail.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Cc: Qinxin Xia <xiaqinxin@huawei.com>, robin.murphy@arm.com,
	yangyicong@huawei.com, hch@lst.de, iommu@lists.linux.dev,
	prime.zeng@huawei.com, fanghao11@huawei.com, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAGsJ_4wOB+cmGzuzzacwJGeUYgGLuKg94wuWC+mA-_=r0TVuhQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250623120124eucas1p2441d1be7176d61d849aea1bd1b892b8e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250616104053eucas1p1017f1af71a338aed4cbdf61930f79e0c
X-EPHeader: CA
X-CMS-RootMailID: 20250616104053eucas1p1017f1af71a338aed4cbdf61930f79e0c
References: <20250614143454.2927363-1-xiaqinxin@huawei.com>
	<20250614143454.2927363-2-xiaqinxin@huawei.com>
	<20250616105318.00001132@huawei.com>
	<CGME20250616104053eucas1p1017f1af71a338aed4cbdf61930f79e0c@eucas1p1.samsung.com>
	<CAGsJ_4wOB+cmGzuzzacwJGeUYgGLuKg94wuWC+mA-_=r0TVuhQ@mail.gmail.com>

On 16.06.2025 12:40, Barry Song wrote:
> On Mon, Jun 16, 2025 at 9:53 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
>> On Sat, 14 Jun 2025 22:34:51 +0800
>> Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>> The padding field in the structure was previously reserved to
>>> maintain a stable interface for potential new fields, ensuring
>>> compatibility with user-space shared data structures.
>>> However,it was accidentally removed by tiantao in a prior commit,
>>> which may lead to incompatibility between user space and the kernel.
>>>
>>> This patch reinstates the padding to restore the original structure
>>> layout and preserve compatibility.
>>>
>>> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")
>>> Cc: stable@vger.kernel.org
>>> Acked-by: Barry Song <baohua@kernel.org>
>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> FWIW I checked the patch above indeed accidentally dropped the padding and the structure
>> is copied to userspace so this fix is correct.  Given it's not in a uapi header this
>> only really affects the selftest I think this is mostly a case of there possibly being
>> out of tree tools with a local copy of this structure definition.
> Somehow, I feel we have placed
> tools/testing/selftests/dma/dma_map_benchmark.c in the wrong location.
> As a selftest, it should have a mechanism to check kernel dependencies,
> start properly and automatically, and report pass or fail.
>
> dma_map_benchmark.c seems more like a tool that belongs in tools/dma,
> rather than a test.

Indeed imho it would be better to move it out of selftests directory.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

