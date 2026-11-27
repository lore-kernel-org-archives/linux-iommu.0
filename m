Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766706;
	b=B5+2mSuKuaYgxCTtdIX4HDu1Yo2bppmZRTgPZFUy/2K1ljiTWbeW2QywAjGH5LQUxzFz
	 HJ2M3kn5Bd1x+drwY8K2ytWRt631wZTB/cb4j+9aWwrax2XW6F7yJSWtRG4L25DIblIWJ
	 kYWfAkL+lLkvIFNsRDno8es5X8ziaRUhbiqZOrfBYBcnaubwk1c4iwMigw7zm3R+4dmNt
	 GS34tIBGG7jSEBX1hFgjqj4OLe4+JWZ+yCcK5844FwrEY4NpCzaFBEJ2d9HSQ6QAjOy8d
	 ij/GS5Kx3xoI3mVOngtY1CA/xkDcaSEcAOnPDaDpMPVS9UAu0ihJCMVFLCHrK2c6ZlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766706;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=b9EsOhhl5MbUkBFLbXLeMzsujw/yfpfNAxfoGKVG51k=;
	b=1e3UMlG9LOyJZYArZoV3GbkIQrL/00nttJ0NUlIUSDLT1dH1ZDdN2HLgYo8ruAj1kSoh
	 KGjHy9iT610dPoJAEJKZjNWMJSN5TemIoTt83cyQIl7WkbbMQ+NJpADYoFm6hUG48Qr9P
	 kwdk5Bp6XnxmqAOUMslXx+37gKSHRvqeOMMFRGJDSAcrC0B1m7Fo2cxMSN3W0/i3oIDz/
	 F5nLGkySJ1VOjmyiwpTy46h4t9+chDCAdGJW7cGzJ6RT6L4leBb3HnLZju4l161aPiPnC
	 GH0QXu+J6eex+DEBDlXh+Z9j+F5jALp1m8MLvDprJbj4JWhCh/P+5Nls2PceHKB4q/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=lmKLhork;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A6606A31E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 08:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C4A6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=lmKLhork
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261127080456euoutp02367bfe54f1afbc827439fa8ab7e5648f~r2EvoCxTM0487804878euoutp02j
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 08:04:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261127080456euoutp02367bfe54f1afbc827439fa8ab7e5648f~r2EvoCxTM0487804878euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795766697;
	bh=b9EsOhhl5MbUkBFLbXLeMzsujw/yfpfNAxfoGKVG51k=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=lmKLhorkbhc96ziVTzFCZyFRqhVWslhZeZnDqzPfl768Kl0OrzH63gjdzkdEkaj8p
	 ezMVDO853DxbSEgRO37CBAhlVcOOzG7BjxOSX9wfF0FfHqCUPWKWrkX9hG6n+jp0eJ
	 ym+Poojt1SNdAbG2//977sH6yzrW3gmKPixHvbNI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261127080456eucas1p1bd7e7242f8ec2c09eacb6e447ea94c14~r2EvOSE7M3256732567eucas1p1W;
	Fri, 27 Nov 2026 08:04:56 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261127080455eusmtip2fa0050c4f8fdaa9edae69f83622844aa~r2EuKqPjg1750517505eusmtip2x;
	Fri, 27 Nov 2026 08:04:55 +0000 (GMT)
Message-ID: <a9a5161a-195f-497e-9dae-76142a4b5997@samsung.com>
Date: Fri, 27 Nov 2026 09:04:55 +0100
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
Subject: Re: [PATCH v3 2/2] alpha: enable contiguous memory allocation for
 coherent DMA
To: Magnus Lindholm <linmag7@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>
Cc: Jakub Kicinski <kuba@kernel.org>, richard.henderson@linaro.org,
	mattst88@gmail.com, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-next@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	will@kernel.org, Mark Brown <broonie@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CA+=Fv5RttOgZp9vftYN2XfmV31TyC_o_eSejruM_bbf6v7zfBQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261127080456eucas1p1bd7e7242f8ec2c09eacb6e447ea94c14
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261124232303eucas1p10f2da7a94c8aa19fa4e406d089c1367e
X-EPHeader: CA
X-CMS-RootMailID: 20261124232303eucas1p10f2da7a94c8aa19fa4e406d089c1367e
References: <20261115103809.1288167-1-linmag7@gmail.com>
	<20261115103809.1288167-3-linmag7@gmail.com> <awVzJMLVw4wUSqky@monoceros>
	<CGME20261124232303eucas1p10f2da7a94c8aa19fa4e406d089c1367e@eucas1p1.samsung.com>
	<CA+=Fv5QJxoxEoKxRpm5Hisdf=y+VpmM-s_VBC1tDQ2FTCfb08w@mail.gmail.com>
	<3467269e-9929-4c9f-bc19-847976f49527@samsung.com>
	<awa6Owm3eDW3EitJ@monoceros>
	<CA+=Fv5RttOgZp9vftYN2XfmV31TyC_o_eSejruM_bbf6v7zfBQ@mail.gmail.com>

On 25.11.2026 12:52, Magnus Lindholm wrote:
> On Wed, Nov 25, 2026 at 11:53 AM Uwe Kleine-König
> <u.kleine-koenig@baylibre.com> wrote:
>> On Wed, Nov 25, 2026 at 09:54:08AM +0100, Marek Szyprowski wrote:
>>> On 25.11.2026 00:22, Magnus Lindholm wrote:
>>>> Thanks for catching this and identifying the interacting commits.
>>>>
>>>> I reproduced the error on next-20261123. In
>>>> arch/alpha/kernel/pci_iommu.c, I changed:
>>>>
>>>> page = (gfp & GFP_DMA) ? NULL : dma_alloc_contiguous(dev, size, gfp);
>>>>
>>>> to:
>>>>
>>>> page = (gfp & GFP_DMA) ? NULL :
>>>> dma_alloc_contiguous(dev, size, gfp, dev_to_node(dev));
>>>>
>>>> This fixes the allmodconfig pci_iommu.o build. A full DP264 UP build
>>>> with CMA enabled also passed, as did an object build with CMA disabled.
>>>> The full allmodconfig build hit an unrelated cgroup sample error
>>>> involving PATH_MAX and LINE_MAX.
>>>>
>>>> I'd prefer to keep the Alpha tree independent of the DMA series.
>> That's up to you, but in my eyes merging in the immutable branch
>> provided by Jakub into your tree (or rebasing on top of it as suggested
>> by Marek) is really the easiest option. That way you don't have to wait
>> for the change to hit Linus' tree and there is no further need for
>> coordination or others paying attention to not create non-bisectable
>> commit graphs.
>>
>> However looking at the immutable branch I see it contains both the dma
>> API change and then separately various adaptions to ethernet drivers.
>> IMHO the immutable branch should only contain the API changes (that is
>> the commits up to 31f7e12d621b) to reduce the amount of possible
>> conflict.
> Thanks, that makes sense. I guess best is for me  to rebase the Alpha changes
> onto the shared DMA API changes and update the caller in my CMA commit.
>
> As you point out, using only the four API commits through 31f7e12d621b
> would avoid bringing the Ethernet driver conversions into the Alpha tree.
>
> Jakub, Marek, would that commit be a suitable immutable base for this?

Yes, that would also work.


> A separate stable tag at that point would be helpful.
>
> I'll then rebase, retest, and notify Mark before updating for-next.

Here is a stable tag for You, I'm sorry for the delay:

https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git dma_alloc_coherent_node_api

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

