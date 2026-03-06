Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F1332B981
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787068; cv=none; b=Dw1iuoyZ0p3K0S4IMvlxx3kuRoiOqhWDNrdtX/V+j9Y613GoPRsAT4DCHYuJFtjEVmZ6LyWKGrv1R1IEuBzUHYfvtcnV+YeNzei9tbxYnkpC/CPRg4i/S2weAeJXBJqhya5EIy0NdBGyG0uXIhYQvlJQ8t8W1xZ1pWfRyOzCrW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787068; c=relaxed/simple;
	bh=KAsbZujIFjzYocJkJ1QqYT52E0nfns8O8gGAPlCdqfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=c0+S/U90jhZFr2bAFlV5U5Jw7wEtcJ7aoOECEhyG1RIieDG2Y/U3pB9lfUTNGIC0cXSnAFcW7k9LAwwUeYg7ZAgWtINcUKF0V+gcb6f3VzYO06cEA5b0bSAMIJKIl0bnYOn3EhJ+Zhrr7t82IaTvd7B8MtBIByne3ZtZHWohgkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Z5r5/dzf; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z5r5/dzf"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260306085057euoutp015aa8a5e63e38d3fd8db9aa25e135da12~aNG_jPxUL2565325653euoutp01E
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 08:50:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260306085057euoutp015aa8a5e63e38d3fd8db9aa25e135da12~aNG_jPxUL2565325653euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772787057;
	bh=4btbHXqql0mjJTmrn8/LSI+nD4XFEMVkzfIKnMHGmZM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Z5r5/dzffnkBxySMQCPSpkfUn2BZvSNppFPLJI1tE/euqd6PMz0rRi4CwmPXemoOy
	 wi3XOng2tl4QRu2yXUs0EACyzysIhmIdAz4LRPMZd33eYlimefe6+XODrplEjxe4G6
	 Z+hlmI0CeXat1rHdkpst6MkLOO780EZQIlHG/CLc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260306085057eucas1p176a39f28514d3c7481f5813d597086ca~aNG_W0l5C1748517485eucas1p1N;
	Fri,  6 Mar 2026 08:50:57 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260306085056eusmtip19a43c6aef5b868e09116bf4cb0630e60~aNG9tWWyI3104731047eusmtip1Z;
	Fri,  6 Mar 2026 08:50:56 +0000 (GMT)
Message-ID: <a55de232-4355-4fae-85c6-b4bbebdf345d@samsung.com>
Date: Fri, 6 Mar 2026 09:50:56 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v7 0/3] dma-mapping: benchmark: Add support for
 dma_map_sg
To: Qinxin Xia <xiaqinxin@huawei.com>, 21cnbao@gmail.com,
	jonathan.cameron@huawei.com, wangzhou1@hisilicon.com
Cc: iommu@lists.linux.dev, prime.zeng@huawei.com, fanghao11@huawei.com,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260225093800.3625054-1-xiaqinxin@huawei.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260306085057eucas1p176a39f28514d3c7481f5813d597086ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260306085057eucas1p176a39f28514d3c7481f5813d597086ca
X-EPHeader: CA
X-CMS-RootMailID: 20260306085057eucas1p176a39f28514d3c7481f5813d597086ca
References: <20260225093800.3625054-1-xiaqinxin@huawei.com>
	<CGME20260306085057eucas1p176a39f28514d3c7481f5813d597086ca@eucas1p1.samsung.com>

On 25.02.2026 10:37, Qinxin Xia wrote:
> Modify the framework to adapt to more map modes, add benchmark
> support for dma_map_sg, and add support sg map mode in ioctl.
>   
> The result:
> [root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
> dma mapping benchmark(SG_MODE): threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
> average map latency(us):1.4 standard deviation:0.3
> average unmap latency(us):1.3 standard deviation:0.3
> [root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
> dma mapping benchmark(SINGLE_MODE): threads:8 seconds:30 node:-1 dir:FROM_DEVICE granule/sg_nents: 8
> average map latency(us):1.0 standard deviation:0.3
> average unmap latency(us):1.3 standard deviation:0.5

Applied to dma-mapping-next. Thanks! Next time please CC: me directly.


> ---
> Changes since V6:
> - Address the comments from Barry, update the comment of the granule.
> - Link: https://lore.kernel.org/lkml/20260112093436.3456315-1-xiaqinxin@huawei.com/
>
> Changes since V5:
> - Address the comments from Barry, the incorrect and unnecessary 'prepare_data' judgment
>    is deleted and renamed 'prepare_data()' to 'initialize_data()'. The mode and
>    other parameters in the output print are placed in the same print. In addition, the incorrect
>    map_mode judgment in ioctrl and the wrong path in sg:prepare() does not release 'params' is fixed.
> - Link: https://lore.kernel.org/all/20251222153246.2220659-1-xiaqinxin@huawei.com/
>
> Changes since V4:
> - Address the comments from Barry and Jonathan, irrelevant patches are deleted and
>    the original cache processing logic is restored with add prepare_data().
> - Link: https://lore.kernel.org/all/20250614143454.2927363-3-xiaqinxin@huawei.com/
>
> Changes since V3:
> - Address the comments from Barry, change mode to a more specific namespace.
> - Link: https://lore.kernel.org/all/20250509020238.3378396-1-xiaqinxin@huawei.com/
>
> Changes since V2:
> - Address the comments from Barry and ALOK, some commit information and function
>    input parameter names are modified to make them more accurate.
> - Link: https://lore.kernel.org/all/20250506030100.394376-1-xiaqinxin@huawei.com/
>
> Changes since V1:
> - Address the comments from Barry, added some comments and changed the unmap type to void.
> - Link: https://lore.kernel.org/lkml/20250212022718.1995504-1-xiaqinxin@huawei.com/
>
> Qinxin Xia (3):
>    dma-mapping: benchmark: modify the framework to adapt to more map
>      modes
>    dma-mapping: benchmark: add support for dma_map_sg
>    tools/dma: Add dma_map_sg support
>
>   include/uapi/linux/map_benchmark.h |  13 +-
>   kernel/dma/map_benchmark.c         | 246 ++++++++++++++++++++++++++---
>   tools/dma/dma_map_benchmark.c      |  23 ++-
>   3 files changed, 254 insertions(+), 28 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

