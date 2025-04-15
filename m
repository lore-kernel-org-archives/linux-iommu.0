Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A327B50E
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744704784; cv=none; b=urNdB1QRoaAeqnK6iHN+rzQ6N4X9+y+2XGP/e+FLBq+DmsVLUxcjk4wQcJJdxZuKHRV2bhvhyRbSRmo73SuWUXZcdu+W1LmWGTIIYtUqn1Cg4WFF3e1K9xQNzOjgPN+d4+5+VwE58Qx/+qvIhHLKmPOuLL8X5ijQo7iu+IBNFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744704784; c=relaxed/simple;
	bh=iar+0k1goXrt2gDKA32KAA8nbIZUL966Tk/tGujp4zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=QaxQu/uOEgGHSinL7N87VUgEGEVmqbN1roUeFKiydhaGfJUlObC51SqIaYSrRLK0nDycK7YDngoIrIMuE4FcASLcvi0CGP8rokuCyt8XlkMVaEa3alCLaoJwJ+mWtxIc1wDFPfN7v6fvelEiFKLcySj1OoMWfXfG8H7w3prHjBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VQ2u7HGG; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VQ2u7HGG"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250415081300euoutp021672900759308a3041fd2a290c44a892~2b8Dwvqg60688506885euoutp02a
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 08:13:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250415081300euoutp021672900759308a3041fd2a290c44a892~2b8Dwvqg60688506885euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744704780;
	bh=XuQLzxBEX4bfeiKE7Ksi3BVYEcCH5WtIRocEfpLB7Yw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=VQ2u7HGGnNG/nnvif+ki0wPLVeg+oWJzzMv8/F7D+TrpzLzFw80REwCH/js1JuECR
	 6SVLyFv0LgRBHZeEfPB6c5vQrFJ1QKwOOLFM8MUbpvRZpWyT0NYl8OIBltDSggjSp0
	 jMwQKYzwBCgnew2vzjfmDfRSIibYTMAUvRoZEDHE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250415081259eucas1p2e1f2ba577e0e6286c259d2dec96debb1~2b8DRLI_D2500625006eucas1p2y;
	Tue, 15 Apr 2025 08:12:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 5D.B9.20821.B051EF76; Tue, 15
	Apr 2025 09:12:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250415081259eucas1p28bccb19d833359ed6eedeea9969f33cd~2b8C4HQ7o0334203342eucas1p2r;
	Tue, 15 Apr 2025 08:12:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250415081259eusmtrp280d9be7e251135e363c2d2931031eae7~2b8C3Nko-2581025810eusmtrp2c;
	Tue, 15 Apr 2025 08:12:59 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-4e-67fe150b4817
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id B7.D8.19920.A051EF76; Tue, 15
	Apr 2025 09:12:59 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250415081256eusmtip114d33610863b4348035f03c44492ffae~2b8A1YQYB1557015570eusmtip1g;
	Tue, 15 Apr 2025 08:12:56 +0000 (GMT)
Message-ID: <3927f2b4-a9ec-4717-86f6-6d5ac4e89804@samsung.com>
Date: Tue, 15 Apr 2025 10:12:56 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] dma/mapping.c: dev_dbg support for dma_addressing_limited
To: Balbir Singh <balbirs@nvidia.com>, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Ingo Molnar
	<mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter
	Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Alex
	Deucher <alexander.deucher@amd.com>, Bert Karwatzki <spasswolf@web.de>,
	Christoph Hellwig <hch@infradead.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250414113752.3298276-1-balbirs@nvidia.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7djP87rcov/SDebclLeYdmc3q8WSuceZ
	LZY0ZVi8vQ/knZ6wiMni1xcLi3Vvz7NaXN41h83i/K61rBar/51itDjee4DJ4uCHJ6wWryfe
	ZrV41PeW3YHPo/XSXzaPNfPWMHos2FTqsXmFlsemVZ1sHidm/GbxeLF5JqNHb/M7No/Pm+Q8
	bj/bxhLAFcVlk5Kak1mWWqRvl8CV8eDHJPaCJomKGw/msTUwPhHuYuTkkBAwkbi29R1LFyMX
	h5DACkaJ5WeusIMkhAS+MEq8+cQDkfjMKPH/zlR2mI7td9axQiSWM0rsf/kTqv0jo8Tppb9Z
	Qap4BewkDv/cBWazCKhK/Jy+lR0iLihxcuYTFhBbVEBe4v6tGWBxYQFvifXNq8HqRQRsJNo/
	r2QGGcoscI9Z4u/FdrAEs4C4xK0n85lAbDYBQ4mut11sIDangJXEvAVH2CBq5CWat84Ga5YQ
	WM8pcf/qGRaIu10kTrx5zgRhC0u8Or4F6h8Zif87QYaCNLQzSiz4fR/KmcAo0fD8FiNElbXE
	nXO/gFZwAK3QlFi/Sx/ElBBwlOg7nQhh8knceCsIcQOfxKRt05khwrwSHW1CEDPUJGYdXwe3
	9eCFS8wTGJVmIQXLLCRfzkLyzSyEtQsYWVYxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIE
	Jr3T/45/2sE499VHvUOMTByMhxglOJiVRHi5nH+lC/GmJFZWpRblxxeV5qQWH2KU5mBREudd
	tL81XUggPbEkNTs1tSC1CCbLxMEp1cBU0cZkZbK9j+FE/cstN3IzyhZHr/x85ZJHtDfHE9Mn
	Sx8uN90THiTTEnR46qHdYfM/uRzbLzr1T7HW/OcM9tetuzXfNHbHc95/Pvn6z9tPf+0L7tWs
	v6t1K11xksRa+R5mzhPBMn4PbkYw+i5/s+QIy5y755Yleyn2uN1b6jj/ZLbxw4RXK57n3wz2
	25l6tXhf6u7t+mtO/mGL9nxxfm9XsYpmQfOtSycvX3nZm1FcYZYV+zsi9YGs9e29r148Zp0f
	OWPRDyfBAEvNjOzDTn8fZF7sPORq9tlq4boj8/gd18eXP8nS/Hn7zLJvChqm7jm/HqqE2hbu
	LXa/ni6qqn7NzunmZftDU2KTP3sHX6jRUWIpzkg01GIuKk4EAAMJO/rpAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsVy+t/xu7rcov/SDWasZraYdmc3q8WSuceZ
	LZY0ZVi8vQ/knZ6wiMni1xcLi3Vvz7NaXN41h83i/K61rBar/51itDjee4DJ4uCHJ6wWryfe
	ZrV41PeW3YHPo/XSXzaPNfPWMHos2FTqsXmFlsemVZ1sHidm/GbxeLF5JqNHb/M7No/Pm+Q8
	bj/bxhLAFaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRv
	l6CX8eDHJPaCJomKGw/msTUwPhHuYuTkkBAwkdh+Zx1rFyMXh5DAUkaJ5tdvGCESMhInpzWw
	QtjCEn+udbFBFL1nlNjb8gsswStgJ3H45y4wm0VAVeLn9K3sEHFBiZMzn7CA2KIC8hL3b80A
	iwsLeEusb14NVi8iYCPR/nklM8hQZoEHzBJnHx9hAkkICfQySqzdXgBiMwuIS9x6Mh8sziZg
	KNH1FuQKTg5OASuJeQuOsEHUmEl0be1ihLDlJZq3zmaewCg0C8kds5CMmoWkZRaSlgWMLKsY
	RVJLi3PTc4sN9YoTc4tL89L1kvNzNzEC43zbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEV4u51/p
	QrwpiZVVqUX58UWlOanFhxhNgYExkVlKNDkfmGjySuINzQxMDU3MLA1MLc2MlcR53S6fTxMS
	SE8sSc1OTS1ILYLpY+LglGpgkvS/+7F00QyfVq6wxUGH1m1K/dQqr7HAdP8q9d4Dm1Y5hvWG
	ZDS4aJX9/qOWvKA0sFnVonvlvH9RT9hq5WsOO/PWBZqVrs9d/8TIrHOBU9LuvifFywPerDpy
	vPzyxvvySXvMwsrPfzdmfGy/fY9syoKfDuKlVYd+tSpbHbgt+CbCrtt4P/tPh1WphYwfJNef
	FPi72vtj5qW5a91lYy1LpKduzWLQ6ncuTLrOuudtqFC9kPHrLT8fJfTZHa6d9ZjRU/bI+QVm
	Bw6nvuJpu/Pn9qIn8WKnZNY+rUlOTz/28FzgvH9iF76tXNb98/rlAtWpCWwzm1qtFxkpufRt
	5/ItnzptBlMny+Rr668HXxTdrsRSnJFoqMVcVJwIAEnG7x58AwAA
X-CMS-MailID: 20250415081259eucas1p28bccb19d833359ed6eedeea9969f33cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250414113810eucas1p2d3b2f60d567a27a2c22930229b4bccfc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250414113810eucas1p2d3b2f60d567a27a2c22930229b4bccfc
References: <CGME20250414113810eucas1p2d3b2f60d567a27a2c22930229b4bccfc@eucas1p2.samsung.com>
	<20250414113752.3298276-1-balbirs@nvidia.com>

On 14.04.2025 13:37, Balbir Singh wrote:
> In the debug and resolution of an issue involving forced use of bounce
> buffers, 7170130e4c72 ("x86/mm/init: Handle the special case of device
> private pages in add_pages(), to not increase max_pfn and trigger
> dma_addressing_limited() bounce buffers"). It would have been easier
> to debug the issue if dma_addressing_limited() had debug information
> about the device not being able to address all of memory and thus forcing
> all accesses through a bounce buffer. Please see[2]
>
> Implement dev_dbg to debug the potential use of bounce buffers
> when we hit the condition. When swiotlb is used,
> dma_addressing_limited() is used to determine the size of maximum dma
> buffer size in dma_direct_max_mapping_size(). The debug prints could be
> triggered in that check as well (when enabled).
>
> Link: https://lore.kernel.org/lkml/20250401000752.249348-1-balbirs@nvidia.com/ [1]
> Link: https://lore.kernel.org/lkml/20250310112206.4168-1-spasswolf@web.de/ [2]
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Bert Karwatzki <spasswolf@web.de>
> Cc: Christoph Hellwig <hch@infradead.org>
>
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>


Thanks, applied to dma-mapping-fixes branch.


> ---
> Changelog v2:
> - Change the debug message to be factual
> - Convert WARN_ONCE to dev_dbg
>
> Testing:
> - Limited testing on a VM, could not trigger the debug message on the machine
>
>
>
>   kernel/dma/mapping.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index cda127027e48..67da08fa6723 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -918,7 +918,7 @@ EXPORT_SYMBOL(dma_set_coherent_mask);
>    * the system, else %false.  Lack of addressing bits is the prime reason for
>    * bounce buffering, but might not be the only one.
>    */
> -bool dma_addressing_limited(struct device *dev)
> +static bool __dma_addressing_limited(struct device *dev)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   
> @@ -930,6 +930,15 @@ bool dma_addressing_limited(struct device *dev)
>   		return false;
>   	return !dma_direct_all_ram_mapped(dev);
>   }
> +
> +bool dma_addressing_limited(struct device *dev)
> +{
> +	if (!__dma_addressing_limited(dev))
> +		return false;
> +
> +	dev_dbg(dev, "device is DMA addressing limited\n");
> +	return true;
> +}
>   EXPORT_SYMBOL_GPL(dma_addressing_limited);
>   
>   size_t dma_max_mapping_size(struct device *dev)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

