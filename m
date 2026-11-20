Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188383;
	b=VqBVncDabm0aIHNksJP6aWT+N6pYQtH6fS0GJqmay93fGDNDh8R9lMxE1Ed0GqJ1BPXf
	 Pvi+L5XTYLw5R8t2hRiPHLqaf2yQr1PAppEMKL9ypkMZ9F1EZVUMGWNFVpXN2a/y+RnuB
	 idZbyhXEryaKr+E0a6jcqfSzM6XVLqET0x3n6xG2wsF7mi/W/NHwHHR6veZ0uSxmR5e5+
	 oBhFpt0/ZGT019GlztuMIFJuNZHoq22PaRSPOVw0yrrcyiwL67ADUywi+AaiUGCMNqAgR
	 68pSjHKd4z/zHNUkZoX4vQzqcv7LP5fQegBh9AUk9SbrEerefxUBkYGwtnlMhdLvDAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188383;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=IKp5sXqipAnu8+vOSKxoVLRtLqTLVKb0WJepsT5T5QA=;
	b=MQtWi/KDFvnPSOLfazpgCwiyDl58o2/fVTIj73/X2NDCKVliDKauCtmTPP7AgHYPR+e2
	 /zwrrmhKWQhoXqO4VESMW0p9YRlg7aP99tOgFYhReYSeDqXsrQCrw1llzJVcvZFopSX6Z
	 sOXtIZVdrK/ewmAH52HhLhcbUO9RZY2p5Rn1XaezNjo7zuHTm0p2OkSUGj6inHUzVLGsU
	 G7m9ysCdTFbAtrum6J4kIA1xvqHE14gIkZ6TXwlR5NUIJYgZcdaH9LdZfwoVuojco/nQn
	 B4KP/cAhCeeH94HtWJuD+OnDuRWNpYzfs4pt7bL3ljP0yF0UEbi0SWpKAhncZUrHYpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Qh6lSEvL;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71096606A326
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 15:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71096606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Qh6lSEvL
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261120152619euoutp014a568d4afcf857588975868288d32291~pylHXGajE1972919729euoutp013
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 15:26:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261120152619euoutp014a568d4afcf857588975868288d32291~pylHXGajE1972919729euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795188379;
	bh=IKp5sXqipAnu8+vOSKxoVLRtLqTLVKb0WJepsT5T5QA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Qh6lSEvLI8FK0PsurlPQxHOfrn/+J8znThDsLXqo0X9Y/ZdVC64l/dKqh/E+ZhY5q
	 hAjg/fKMfeFa9FdtjovK0vx2WL5iJaJyP6j5jBgHCRVlFMUPlsSTCa0y02fFSBXuid
	 TKcfwqZ9+0SDN+XmeWfrTcWGKs2mYN5tI1onBG48=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261120152618eucas1p150bf7f9becddb3cc91560dbf095639f6~pylHDNDwT1906219062eucas1p1k;
	Fri, 20 Nov 2026 15:26:18 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261120152618eusmtip28ab8b8495dadd64b1427840d1af6ce17~pylGag2Xz1849318493eusmtip2X;
	Fri, 20 Nov 2026 15:26:18 +0000 (GMT)
Message-ID: <a58ae41b-4ee6-44d6-bd4c-56e51b19df60@samsung.com>
Date: Fri, 20 Nov 2026 16:26:17 +0100
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
Subject: Re: [PATCH] dma: swiotlb: Allocate the restricted DMA pool slot
 array with kvzalloc()
To: yzddMr6 <yzddmr6@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAB63uaFw9QjjN131UjiJvpp6qHM+xw+-9wEcujuNoYVzhmXtOQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261120152618eucas1p150bf7f9becddb3cc91560dbf095639f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261120131146eucas1p2d05549af0404d6af77ce3e9385e91fa7
X-EPHeader: CA
X-CMS-RootMailID: 20261120131146eucas1p2d05549af0404d6af77ce3e9385e91fa7
References: <CGME20261120131146eucas1p2d05549af0404d6af77ce3e9385e91fa7@eucas1p2.samsung.com>
	<20261120-upstream2-swiotlb-rmem-kvzalloc-v1-1-1c5f9b503223@gmail.com>
	<7cfe91c5-4053-44bb-8c18-612fcda90e4d@samsung.com>
	<CAB63uaFw9QjjN131UjiJvpp6qHM+xw+-9wEcujuNoYVzhmXtOQ@mail.gmail.com>

On 20.11.2026 16:22, yzddMr6 wrote:
> On 20.11.2026 15:18, Marek Szyprowski wrote:
>> The change looks fine, but according to kernel rules, the patch must be
>> signed with a real developer name. 'yzddMr6' doesn't look like a real name.
> Hi Marek,
>
> Thanks for looking at it.
>
> yzddMr6 is the name I use consistently for my kernel work, and mail to
> the address in the From: and Signed-off-by: lines reaches me. Since
> commit d4563201f33a ("Documentation: simplify and clarify DCO
> contribution example language"), submitting-patches.rst asks for a
> known identity rather than a legal name, and that commit notes that
> nicknames have always been accepted. Mark Brown applied a patch of mine
> under this name to the sound tree earlier this week (bd6e011c8121).
>
> If you still need a legal name in the sign-off, mine is Zhendong Liu;
> let me know and I will send a v2 signed off as
> "Zhendong Liu <yzddmr6@gmail.com>".

I would prefer that.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

