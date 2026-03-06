Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853CE35E934
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772783694; cv=none; b=oB8QtY22l8QNw5W0wOyhyNBI6azx4XTSwP3BvJBfHPgLQoNJvooWGsoX6MCiS6DE52l34mft7RZWLkkHdYTSan0w5T3eerlz/5Mx8yhpjbG2V30l4Uabt7eaM9vp/1tMOK0VqttCHBxoHdrSVvCTjokNf9wHrl/sPYFM4R7ub7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772783694; c=relaxed/simple;
	bh=i4t3Tlw98SOh3+ocszXqxq/MHV4UYRHDd4YgrRT/alQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=a5xTEbU8+6wQOmoMjUeiA780T+Bqyaxe1mim0FLsoo/LX9vb6GO7IGQAnUMJdRoAio8PnF9ZiURvPrHK2JycSWuR+846P0rn08rpZfK2GJzDYEUubTDK8Tfr/wutqe6sVgbLbc/8KkPNtF6McGNICo6foA2ocricSeXT8lsknlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=C4lIyyfW; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="C4lIyyfW"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260306075449euoutp01e0f6755568c7b84c09b30176416d765f~aMV9tynYL2595025950euoutp01O
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 07:54:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260306075449euoutp01e0f6755568c7b84c09b30176416d765f~aMV9tynYL2595025950euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772783689;
	bh=OJ3vzREkqH0r/YYbHXJwUk5oLbjIgWJ2QTLSoOmCLf0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=C4lIyyfWvr3NxLjxNr0UQ9zO52HiEuJ/R3dn16CUqb0AYtdZ9FT0+9QW0P/xcTn+1
	 1MDttJHFLPJiFvOK+tJ+FovXqlKuA3lF4KxQtYxqngxBJGKTpkhVFJ+eiBIZJF8FuF
	 RRZIuLygg9jpmwy+u0slmXBJ/B0GJqdqqRtvCpo8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260306075449eucas1p25a20e387aaaeee57526a43b7614a6340~aMV9hBOaQ0434404344eucas1p25;
	Fri,  6 Mar 2026 07:54:49 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260306075447eusmtip253aed47b48460e2d772e9128552d730c~aMV8cya8L3109631096eusmtip2V;
	Fri,  6 Mar 2026 07:54:47 +0000 (GMT)
Message-ID: <636e131d-0a1c-4b88-8587-e56ff57540c0@samsung.com>
Date: Fri, 6 Mar 2026 08:54:47 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v7 0/3] dma-mapping: benchmark: Add support for
 dma_map_sg
To: Barry Song <21cnbao@gmail.com>, Qinxin Xia <xiaqinxin@huawei.com>
Cc: jonathan.cameron@huawei.com, wangzhou1@hisilicon.com,
	iommu@lists.linux.dev, prime.zeng@huawei.com, fanghao11@huawei.com,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAGsJ_4wDs1f=oPzBkHHfRQp32EoGOV6JwhFYxZX=tBXyN-AFWg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260306075449eucas1p25a20e387aaaeee57526a43b7614a6340
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260225104234eucas1p1e9680001241351f4b536f60e2332bc8e
X-EPHeader: CA
X-CMS-RootMailID: 20260225104234eucas1p1e9680001241351f4b536f60e2332bc8e
References: <20260225093800.3625054-1-xiaqinxin@huawei.com>
	<CGME20260225104234eucas1p1e9680001241351f4b536f60e2332bc8e@eucas1p1.samsung.com>
	<CAGsJ_4wDs1f=oPzBkHHfRQp32EoGOV6JwhFYxZX=tBXyN-AFWg@mail.gmail.com>

On 25.02.2026 11:42, Barry Song wrote:
> On Wed, Feb 25, 2026 at 5:38 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>> Modify the framework to adapt to more map modes, add benchmark
>> support for dma_map_sg, and add support sg map mode in ioctl.
>>
>> The result:
>> [root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
>> dma mapping benchmark(SG_MODE): threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
>> average map latency(us):1.4 standard deviation:0.3
>> average unmap latency(us):1.3 standard deviation:0.3
>> [root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
>> dma mapping benchmark(SINGLE_MODE): threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
>> average map latency(us):1.0 standard deviation:0.3
>> average unmap latency(us):1.3 standard deviation:0.5
>>
> + Marek,
>
> Hi Marek,
>
> Would you be willing to pick up Qinxin's series into the dma-mapping
> tree? I think that would be helpful, at least for my
> "dma-mapping: arm64: support batched cache sync" series[1] and for
> potential further optimizations to dma_map_sg().
>
> [1] https://lore.kernel.org/lkml/20251226225254.46197-1-21cnbao@gmail.com/

I would be easier for me to track that work if I were on CC:, but I will 
take it.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

