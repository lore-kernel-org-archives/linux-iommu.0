Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E2226FD9F
	for <iommu@lists.linux.dev>; Wed, 14 May 2025 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747225345; cv=none; b=OIHJEKJD9k9nLJjGGUI3AhWKoZlPTK3BWJMk6lfwkhdPVCXJCW+j+kq0Wss1SPiLhtU8HumErh//z7p6YvwsYOmnrdy5/RYslYuYe/yfeIExyKq+Qkpx2vB9mBoogSJpZ/oZDDVDz9Qeky8GL+0junpbWM5pL8ox2a2fTzQvwtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747225345; c=relaxed/simple;
	bh=rMgMN8R6Q7ND9q/Yqv4kQ8GRgwl0/UP4/ERz6QhnkpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=sxYdJ1MkD5JbHUck0DXX02JPkktJ9EaPSt8u4AAX6UYzNARUuyFKAr3wOpmIe/cXzhnrxnQOCMwg5L843fXk7rZyNo4t4R/Y9bk8iFtZLAT+xYRFH+xbzUqJf0SRcHsobcD4F0wFTISSMB9xv9WZvq/p7Il/QY9RAv0GxUhFVnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BqclIBag; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BqclIBag"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250514121223euoutp01b6b8bca7de2c8ee4a0a2444806c2abe8~-Y6XAozt11197711977euoutp01U
	for <iommu@lists.linux.dev>; Wed, 14 May 2025 12:12:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250514121223euoutp01b6b8bca7de2c8ee4a0a2444806c2abe8~-Y6XAozt11197711977euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747224744;
	bh=fSDRvy2fK9ZBMkD7zZdvUkDbKKAV/Jv8n/pyxdGD2wM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=BqclIBagRBc2gzEtRSFp7A+9yQOTGQoaRf99iUSnG1MZHBk6chuQg/O/ZyjXqJTaZ
	 eyNNbUYnlhzm5QbgrdgTpumpXbcDm+NR5ro6NM04mhFQyJpBitAddFW5KleQTON6UV
	 sAqfU0S6/fDKaJ+1HaSNoIHTIgU//rBL3Q3R4apA=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250514121223eucas1p1265764bb4bc28f10b65fab83b1725805~-Y6WlRww31485814858eucas1p1D;
	Wed, 14 May 2025 12:12:23 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250514121220eusmtip2059ff98b04e6b87e5195ea200a8599a1~-Y6TyZSaP1756517565eusmtip2p;
	Wed, 14 May 2025 12:12:20 +0000 (GMT)
Message-ID: <8eedf638-9fa5-470e-976e-9b18971f7b46@samsung.com>
Date: Wed, 14 May 2025 14:12:19 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] scatterlist rust bindings
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida
	<daniel.almeida@collabora.com>
Cc: dakr@kernel.org, lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>, Alex
	Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
	Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, open list
	<linux-kernel@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com, rust-for-linux@vger.kernel.org, "open list:DMA MAPPING
 HELPERS" <iommu@lists.linux.dev>, Petr Tesarik <petr@tesarici.cz>, Andrew
	Morton <akpm@linux-foundation.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, Sui Jingfeng <sui.jingfeng@linux.dev>, Randy
	Dunlap <rdunlap@infradead.org>, Michael Kelley <mhklinux@outlook.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <77afb898-fe6e-480d-9b7a-05cc31d8545b@gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250514121223eucas1p1265764bb4bc28f10b65fab83b1725805
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250514070104eucas1p1b2e420e8827d55521bd9aca3e1341ee7
X-EPHeader: CA
X-CMS-RootMailID: 20250514070104eucas1p1b2e420e8827d55521bd9aca3e1341ee7
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
	<78DB1F66-9DF5-4679-ADC4-177BED5D4FDE@collabora.com>
	<CGME20250514070104eucas1p1b2e420e8827d55521bd9aca3e1341ee7@eucas1p1.samsung.com>
	<77afb898-fe6e-480d-9b7a-05cc31d8545b@gmail.com>

On 14.05.2025 09:00, Abdiel Janulgue wrote:
>
> On 12/05/2025 14:19, Daniel Almeida wrote:
>> Hi Abdiel,
>>
>>> On 12 May 2025, at 06:53, Abdiel Janulgue 
>>> <abdiel.janulgue@gmail.com> wrote:
>>>
>>> Hi,
>>>
>>> Here are the scatterlist bindings that has been brewing for a while 
>>> in my
>>> local tree while working with Nova code. The bindings are used 
>>> mostly to
>>> build the radix3 table from the GSP firmware which is loaded via dma.
>>> This interface can be used on top of existing kernel scatterlist 
>>> objects
>>> or to allocate a new one from scratch.
>>>
>>> Some questions still need to be resolved, which mostly come from
>>> the DeviceSGTable::dma_map() function. Primarily, what if you call
>>> bindings::dma_map_sgtable() on an already mapped sg_table? From my
>>
>> Perhaps we should introduce a type for buffers which are known to be 
>> mapped. Then
>> we can simply not offer the option to map for that type.
>>
>>> experiments it doesn't seem to do anything and no indication is 
>>> returned if
>>> the call succeeded or not. Should we save the "mapping info" to a list
>>> everytime we call DeviceSGTable::dma_map more than once?
>>
>> What mapping info are you referring to?
>>
> Basically the dma_data_direction enum and possibly `Device`, if we 
> decouple SGTable from the device. So this approach would mean that 
> every-time SGTable::dma_map() is called, unique mapping object(s) 
> would be created, and which would get unmapped later on the destructor:
>
> struct SgtDmaMap {
>     dev: ARef<Device>,
>     dir: DmaDataDirection,
> }
>
> impl SgtDmaMap {
>     /// Creates a new mapping object
>     fn new(dev: &Device, dir: DmaDataDirection) -> Self {
>         Self { dev: dev.into(), dir, }
>     }
> }
> ...
> ...
>
> impl SGTable {
>     pub fn dma_map(dev: &Device, dir: DmaDataDirection) -> 
> Result<SgtDmaMap>
>
> But I'm not sure if there is any point to that as the C 
> `dma_map_sgtable()` doesn't seem to care anyway (I could be wrong with 
> this) if the sg_table gets mapped more than once?


Standard DMA-mapping C api doesn't have the notion of the object, 
although in case of sgtable structure, one might add some flags might 
there. Originally the sgtable based helpers were just trivial wrappers 
for dma_sync_sg_*() and dma_unmap_sg() ensuring proper parameters (and 
avoiding the confusion which nents to pass).

It is generally assumed that caller uses the DMA API properly and there 
are no checks for double dma_map calls. It is only correct to call 
dma_map_sgtable() for the same sgtable structure after earlier call to 
dma_unmap_sgtable().


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

