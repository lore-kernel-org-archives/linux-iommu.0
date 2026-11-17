Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794899979;
	b=OmBUWsiSvQHksbk/ajSZHyKzZ/Na9z4lY7/MX0VWE6wpI5PnWPrJa/nFlB9UhE0FpBSL
	 BtJ1SIrp0+hkhtXReAyF9wXIWpV9bwTITr4lP2HT1wvWVAH3TNuYxg7OtUZLvwW1oP5Qy
	 B/PWT4TbZdAV7yd3V+kDoMsznrJRevxFVlCqzGK9CNDgAC8OQZB4zhwas4kawYee/AU4j
	 QE7nH9y+LXxBKOvfDrriL98/+Dg7C4eoWvxgQ8l/wMpy+qCzGqsg09DQyOlwrv1JseSCY
	 9cIKzpgHVCNFAi4+UCwFbu7Nap+OQ+ETduPRH3AjWF4/i9x0D1IQKwZikB5gMji1vyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899979;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=Q//SZLRFFaAyCG3qB5iY50cbLTFHcXgC8CYVEp5D8Q4=;
	b=rq00PYY+kSlwhcQjhsTn0BUwSRrS8ttOYYpahJHJtlztLu+BgJHdYZ8lH9L9lwo79sQ7
	 dTmCjueRnKxhtrvMkM7bULze3cJNszLCl4ySJ1RrExJHEbjjTqosDB39Rj+UG24RF5Vgn
	 0v7zTB294oCrvTu/JhUYdRWVZ6YJXhWmjUhy99wKvEuc2oZcElZwxUT4IdiTtg2OpAkHb
	 WLt7kmgsgoIR/yLjG6UNPvCTvhBI+mjKnKscxOz8Zgo3a5H3Z35MZ1nwTMu1KfVQi3Nca
	 nQZnqXepZHcZGFoFbJ19/K6OCSwcvNmK3LaXxU3EQhbtlS8zhIrEhtuxaYnWdibjdgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=qqARvYpf;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3D2606A323
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 07:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE3D2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=qqARvYpf
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261117071935euoutp018cf980ed298a62c6db4a1e5caae3b616~oxASSILPM2410424104euoutp01M
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 07:19:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261117071935euoutp018cf980ed298a62c6db4a1e5caae3b616~oxASSILPM2410424104euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794899975;
	bh=Q//SZLRFFaAyCG3qB5iY50cbLTFHcXgC8CYVEp5D8Q4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=qqARvYpfEWjHpZTSRB8oTQOxU9660cMVU10zFd1CfAaqN5iNwZeg6ZqviU0WxlGcC
	 Zgz25VQYyMenrgZARMvj9KWt7qv+b4+9kvmyRp6033xXgBR7RuW34XQJvg8vS8Jw3V
	 1NyQ/46lRqDO13yFrmxwKMGhnbg9NWLflQy+wRuY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261117071934eucas1p1c2b3463f652c0dc4aa8cab83fb0cedac~oxAR2_SL60133201332eucas1p1I;
	Tue, 17 Nov 2026 07:19:34 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261117071934eusmtip289126959c34c6d307007c4129949eb75~oxARN50Ay0656606566eusmtip2W;
	Tue, 17 Nov 2026 07:19:34 +0000 (GMT)
Message-ID: <e69146b1-74cf-451a-9598-cc85ea992263@samsung.com>
Date: Tue, 17 Nov 2026 08:19:33 +0100
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
Subject: Re: [PATCH 00/11] dma-mapping: add dma_alloc_attrs_node() and
 dma_alloc_coherent_node()
To: Jakub Kicinski <kuba@kernel.org>
Cc: robin.murphy@arm.com, netdev@vger.kernel.org, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261116145420.2b533196@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261117071934eucas1p1c2b3463f652c0dc4aa8cab83fb0cedac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261112161622eucas1p131619576b0d4e6d201197007f3d7c951
X-EPHeader: CA
X-CMS-RootMailID: 20261112161622eucas1p131619576b0d4e6d201197007f3d7c951
References: <20261106184433.761422-1-kuba@kernel.org>
	<CGME20261112161622eucas1p131619576b0d4e6d201197007f3d7c951@eucas1p1.samsung.com>
	<20261112081616.13b81fab@kernel.org>
	<17fd14e7-41e3-4658-a62c-1206fd2b5e0d@samsung.com>
	<20261116145420.2b533196@kernel.org>

On 16.11.2026 23:54, Jakub Kicinski wrote:
> On Mon, 16 Nov 2026 10:57:06 +0100 Marek Szyprowski wrote:
>> On 12.11.2026 17:16, Jakub Kicinski wrote:
>>> On Fri,  6 Nov 2026 10:44:22 -0800 Jakub Kicinski wrote:  
>>>> Stable tag on top of v7.4-rc1, so that we can also pull this into
>>>> the networking tree:
>>>>
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git tags/dma_alloc_coherent_node  
>>> Marek, Robin, would you be willing to pull?
>>> Or should I respin the tag to include the latest Ack/Review tags from
>>> the list?  
>> If possible, respin the tag with latest acks/reviews, then I will pull it to
>> my dma-mapping-for-next branch.
> SG, added the tags and re-pushed:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git tags/dma_alloc_coherent_node

Pulled into dma-mapping-for-next, thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

