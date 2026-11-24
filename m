Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536685;
	b=LYc72Zn6zEAhKE1l81Ygk2wgWsriQoBLvKKf0Fo3j5hdB+c+6XmVZQL2b5PRe4xt6I8T
	 p80E/FvkJu5Qcbtdu/rj8j+05YdUluSTh0rI3eai3+WI/6vLWrwTqiguFee+PGhbcONcD
	 6tz0K30VsoK+cs1HtibA7MV3czapmEpApi+BYepHrjmv9za6EzNvdqZ2u7QJeLcD+bXrU
	 mKpy+LtIVoVAbqRsW4qkYTYf2zJbcn/TvakjTW36Ti7WQ43knTcUNZNjfg1bn/QRaqiCD
	 RO6jzGmkWIft2d1sCvHrs7E8VI+duU6dQcukChvRYiBoFX/J6Rz5ZyeLrQZnlsWUiqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536685;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=LvG5+rNFbO4xSHxe8GcQBfnFez6a86Hx5Su/xchbI3I=;
	b=JoeZjMFuMsYNskXt2kj99L8XFJ4zNS6YnUg6L79uT3TWYBcnQViI6vBJyVCgbz8WFUl4
	 QK9SjBeqzMI+pZsB48rMo6ujuOFWL9weROtFFq3KGdDRy1KkCVbPYNslXWwlGCRQaj4MD
	 X6CbHED/C6F/p7PYxV9+fFdSFRpVXAhoWCe8LaQ99X4tExyX5yWE4tcO1s+/ZCvJhcofU
	 OkbrFU69eP3JHz9qk+WGPHTPr70e+j7vs1ziRQxJMdNVcAqHxcuWRMVgwhi79T5AM5TE2
	 M1rI7vOco3PODz0xBrY/sZH2ruxcMLrSQXi+i2q+Iex0+4L8voqecXc7LbQXsNtppHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W5Obng5b;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AF1606A32E
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 16:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74AF1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=W5Obng5b
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261124161121euoutp01d9c54c4a0d13c5f12942b23cca0a3c26~rBxlEBNny0199201992euoutp01F
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 16:11:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261124161121euoutp01d9c54c4a0d13c5f12942b23cca0a3c26~rBxlEBNny0199201992euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795536681;
	bh=LvG5+rNFbO4xSHxe8GcQBfnFez6a86Hx5Su/xchbI3I=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=W5Obng5bAzdIWHFxF9I9m9C1d6+8NP9FzG+r96VD9Sb9x/xqf+U2kOQeBluLfNsGO
	 5nfhNYmeVMjLXRkjZanueL3zrF9mfZiLtZBR/M8gV3zXKAapOmy4vtbNZGgT4nTqW/
	 qNiM8nmPtLpfO5T8MQVoiZu6FlhVshppOkG2p4cg=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261124161121eucas1p111fb1f1e9e91dad3f8a68131f3951415~rBxkwlpaE2165621656eucas1p1Q;
	Tue, 24 Nov 2026 16:11:21 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261124161119eusmtip1823cc0c3de84fe9a410d638a7a7849ca~rBxizLBG81311713117eusmtip1e;
	Tue, 24 Nov 2026 16:11:19 +0000 (GMT)
Message-ID: <874dc793-7287-4c23-b1b7-0417fc43b7b9@samsung.com>
Date: Tue, 24 Nov 2026 17:11:18 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] swiotlb: clear read bounce buffers on confidential
 guests
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Shukai Ni <shukai.ni@kuleuven.be>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Halil Pasic
	<pasic@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>, Kiryl
	Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>, Carlos Bilbao
	<carlos.bilbao@kernel.org>, linux-coco@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>, "Aneesh Kumar K.V"
	<aneesh.kumar@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261124153615.GA114530@ziepe.ca>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261124161121eucas1p111fb1f1e9e91dad3f8a68131f3951415
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261123205317eucas1p2f96032281e0f5e9f17acc7ec343acced
X-EPHeader: CA
X-CMS-RootMailID: 20261123205317eucas1p2f96032281e0f5e9f17acc7ec343acced
References: <CGME20261123205317eucas1p2f96032281e0f5e9f17acc7ec343acced@eucas1p2.samsung.com>
	<20261123205302.1034348-1-shukai.ni@kuleuven.be>
	<42415609-c784-45d4-a79d-ef3cc5e6c3ef@samsung.com>
	<20261124153615.GA114530@ziepe.ca>

On 24.11.2026 16:36, Jason Gunthorpe wrote:
> On Tue, Nov 24, 2026 at 04:17:20PM +0100, Marek Szyprowski wrote:
>> CCed Jason and Aneesh.
>>
>> On 23.11.2026 21:53, Shukai Ni wrote:
>>> On confidential guests (AMD SEV, Intel TDX) all device DMA is bounced
>>> through swiotlb, whose pool is shared with and readable by the untrusted
>>> host. swiotlb_tbl_map_single() copies the destination buffer's current
>>> contents into the bounce buffer at map time even for DMA_FROM_DEVICE. For
>>> a reused read buffer that still holds private data, the host can read
>>> that data from the bounce buffer before the device overwrites it.
>>>
>>> For DMA_FROM_DEVICE into a host-shared pool, zero the bounce buffer
>>> instead. Zeroing rather than skipping the copy keeps a short read from
>>> returning a previous transfer's data.
>>>
>>> Fixes: ddbd89deb7d3 ("swiotlb: fix info leak with DMA_FROM_DEVICE")
>>> Cc: stable@vger.kernel.org
>>> Co-developed-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
>>> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
>>> Signed-off-by: Shukai Ni <shukai.ni@kuleuven.be>
>>
>> I'm not sure if DMA-mapping or SWIOTLB is the right place for such fixups.
>>
>> Drivers should be aware that doing DMA from unsecure device to the given
>> secure page might reveal its content to the host or other parties and
>> prepare for that (like zeroing that page).
> I think given the semantics we have to support partial write we don't
> have a choice but to continue them as it is the DMA API.
>
> The driver would have to opt out of partial write support somehow to
> trigger this, and in that case it is more of an optimization and
> shouldn't be linked to CC.

This has been already tried some time ago:

https://lore.kernel.org/all/20250115194659.618438-1-florian.fainelli@broadcom.com/

It looks that something similar, but with zeroing the swiotlb buffer instead

of skipping the copy would make some sense.


> I'm curious if there is a real issue here with a definitive issue on a
> driver or it is just speculation?
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

