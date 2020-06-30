Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86410C433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 08:49:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9C4206BE
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 08:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JpxC2J4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9C4206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2FC8B883C8;
	Tue, 30 Jun 2020 08:49:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dsUz1XaEkmBr; Tue, 30 Jun 2020 08:49:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7C55C88367;
	Tue, 30 Jun 2020 08:49:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60636C088F;
	Tue, 30 Jun 2020 08:49:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B413EC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 08:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A2A1286BB5
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 08:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kHul8LLgWK2q for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 08:49:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 985CF86B9A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 08:49:46 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200630084944euoutp02cba1a9f81ef4326a64afa7c6be60d583~dRijU3ZaM0837508375euoutp02S
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 08:49:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200630084944euoutp02cba1a9f81ef4326a64afa7c6be60d583~dRijU3ZaM0837508375euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1593506984;
 bh=O6hwU0/ZbS8O0w3UsaeSLAcNBQv6ONEsbFj4G3YFm7k=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=JpxC2J4RBaebRmR854QrBNmXgeHsx+OdGWOJqGIBdDGUsdPx3Pi/UFBXXHb3smFLt
 PSoi8okVh0p6v63aLhzPpbpHxjeZJk1NSB5newj9jJG+7WwOUiXUC1nr9l2Ph9OzXl
 BYFHIOLF8iCBtxSw/yFKD+Y1cnbydjLadHfavKcQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200630084943eucas1p1397de9f1ccf058b4b07a0ed22ce94e9e~dRiiuUVvF0988409884eucas1p14;
 Tue, 30 Jun 2020 08:49:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id A9.87.06318.7ACFAFE5; Tue, 30
 Jun 2020 09:49:43 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200630084943eucas1p175574f4a8f74aab87afea7c6186b0256~dRiiTvzjs1664516645eucas1p1i;
 Tue, 30 Jun 2020 08:49:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200630084943eusmtrp242fb2a7e8ecdac333a82831d2b9b16b1~dRiiTHClV2302923029eusmtrp2W;
 Tue, 30 Jun 2020 08:49:43 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-df-5efafca73d42
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id F3.92.06017.7ACFAFE5; Tue, 30
 Jun 2020 09:49:43 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200630084942eusmtip2a2f37341c3fc97e834a6be1f0bbce556~dRihvINNA1683416834eusmtip2f;
 Tue, 30 Jun 2020 08:49:42 +0000 (GMT)
Subject: Re: [PATCH v7 00/36] DRM: fix struct sg_table nents vs. orig_nents
 misuse
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <10cb27c9-286a-5ee5-dab1-183939e5b12d@samsung.com>
Date: Tue, 30 Jun 2020 10:49:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619103636.11974-1-m.szyprowski@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e/szOPY5DQ131wkDQoTvGHEIcvMgs7HwupDpbn0MCXdZNO0
 vrhKw7yRpZRr2tTM0qll856KWlsmLa+VFVhpd0xFExXRdnZm+e33PO/z530f+BOYZAD3JOKU
 SYxaKY+XCYT8RvOi1bdyeSkyoOOFjMq19vKoR7fqcGq1MR+jhv9MCagH1c94lKEzmJob/sSj
 6sdf49RQq15AdU1P4KFC2lhiRHT7vIFPN81/xOmxbAuPfnw3jX6/Mo7RN95WIrptVCug80xV
 iJ6t33JYeEK4J4aJjzvHqP1DooSxhWN7E0elqYsFmU5a1LwxCzkTQO6EK8ZpQRYSEhLyPoKb
 +XrEiTkE33L6HWIWwexyhdPak4WyBpwbVCIYLP3pEFMIRoZq7ClX8ihM/f6NsexGZiB4niti
 Qxj5C8F46bQ9JCADIWsyS8CymAyB6oFLduaT22DAqOex7E5GQF6FwZHZAL1FE3yWnW35X+ld
 OMsY6QVNk3qMYw94N3GHx5066QTF7eEcH4SrEyUO3xV+WkyOOpthtYXNC218GcEnK9uAFTkI
 hi7dQlwqGD5Yl2xXELYNO6Cu1Z+z90Ph5y92G0gXeDu5gbvBBa433sQ4WwyZVyRcejvoLLX/
 1nb1D2LXkEy3rpluXRvduja6/3sNiF+FPJhkTYKC0QQpmRQ/jTxBk6xU+EWrEuqR7aP1rVj+
 NKOO5TPdiCSQTCSOsi5GSnD5Oc35hG4EBCZzE4e97IuUiGPk5y8watVpdXI8o+lGUoIv8xAH
 lf2IkJAKeRJzlmESGfXalEc4e2pRWpiXtABvjxjdKi3/mvdVZZ4ReZuaL95OVI0caDtWtTs7
 4Iip501Rz8niQ0/HFgqb0h9ag2rdzU98+hUrY98H+LteZZi1we3Gqs5T5nvS9FStZWtQp/vx
 jJnvu/2hJu1wX7ikxBjq7bqv0m1bq+f9+dXS8pSWosIC0aZO3+iGO5iMr4mVB/pgao38Lz1J
 +/pkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xe7rL//yKM3h9hsei99xJJouNM9az
 WvzfNpHZ4srX92wWK1cfZbJYsN/a4suVh0wWmx5fY7W4vGsOm8XBD09YHbg81sxbw+ix99sC
 Fo/t3x6wetzvPs7ksXlJvcftf4+ZPSbfWM7osftmA5tH35ZVjB6fN8kFcEXp2RTll5akKmTk
 F5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZUy9b1twU7ri55QO9gbG
 HWJdjJwcEgImEj8WbWXtYuTiEBJYyihxbNIsFoiEjMTJaQ2sELawxJ9rXWwgtpDAW0aJ1o88
 ILawQIjE+3fvmEGaRQRaGSWOPnjHDuIwC7xmlHh25QwzxNiJjBL/H+5iBGlhEzCU6HoLMYpX
 wE5i9cUmMJtFQFXi4po5TCC2qECsxLd7W6BqBCVOznwCdhInUP3rloNgJzELmEnM2/yQGcKW
 l9j+dg6ULS5x68l8pgmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn
 525iBMbwtmM/t+xg7HoXfIhRgINRiYc34dzPOCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlal
 FuXHF5XmpBYfYjQFem4is5Rocj4wveSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5N
 LUgtgulj4uCUamAUfRmw9XOo4GLf7Q/Xn/zXtjW+izNDsrLg3i7R7dt0X6pnbtTSOPDt68xp
 C5/MY0111xBflc/Mw/VH+cqRzrn3hTTKT7t5ZTisSRCr51VfkysVF1Iv5D3jVbrDo2Ovr0+L
 /DRZl71XcPLl9C0adaI8lfvu8ywsFj87adqa3fkJjx2Yp/vlxq9VYinOSDTUYi4qTgQAM+BS
 v/cCAAA=
X-CMS-MailID: 20200630084943eucas1p175574f4a8f74aab87afea7c6186b0256
X-Msg-Generator: CA
X-RootMTR: 20200619103652eucas1p203d684adff0faa672ff5c8d383b52f23
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103652eucas1p203d684adff0faa672ff5c8d383b52f23
References: <CGME20200619103652eucas1p203d684adff0faa672ff5c8d383b52f23@eucas1p2.samsung.com>
 <20200619103636.11974-1-m.szyprowski@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi All,

On 19.06.2020 12:36, Marek Szyprowski wrote:
> During the Exynos DRM GEM rework and fixing the issues in the.
> drm_prime_sg_to_page_addr_arrays() function [1] I've noticed that most
> drivers in DRM framework incorrectly use nents and orig_nents entries of
> the struct sg_table.
>
> In case of the most DMA-mapping implementations exchanging those two
> entries or using nents for all loops on the scatterlist is harmless,
> because they both have the same value. There exists however a DMA-mapping
> implementations, for which such incorrect usage breaks things. The nents
> returned by dma_map_sg() might be lower than the nents passed as its
> parameter and this is perfectly fine. DMA framework or IOMMU is allowed
> to join consecutive chunks while mapping if such operation is supported
> by the underlying HW (bus, bridge, IOMMU, etc). Example of the case
> where dma_map_sg() might return 1 'DMA' chunk for the 4 'physical' pages
> is described here [2]
>
> The DMA-mapping framework documentation [3] states that dma_map_sg()
> returns the numer of the created entries in the DMA address space.
> However the subsequent calls to dma_sync_sg_for_{device,cpu} and
> dma_unmap_sg must be called with the original number of entries passed to
> dma_map_sg. The common pattern in DRM drivers were to assign the
> dma_map_sg() return value to sg_table->nents and use that value for
> the subsequent calls to dma_sync_sg_* or dma_unmap_sg functions. Also
> the code iterated over nents times to access the pages stored in the
> processed scatterlist, while it should use orig_nents as the numer of
> the page entries.
>
> I've tried to identify all such incorrect usage of sg_table->nents and
> this is a result of my research. It looks that the incorrect pattern has
> been copied over the many drivers mainly in the DRM subsystem. Too bad in
> most cases it even worked correctly if the system used a simple, linear
> DMA-mapping implementation, for which swapping nents and orig_nents
> doesn't make any difference. To avoid similar issues in the future, I've
> introduced a common wrappers for DMA-mapping calls, which operate directly
> on the sg_table objects. I've also added wrappers for iterating over the
> scatterlists stored in the sg_table objects and applied them where
> possible. This, together with some common DRM prime helpers, allowed me
> to almost get rid of all nents/orig_nents usage in the drivers. I hope
> that such change makes the code robust, easier to follow and copy/paste
> safe.
>
> The biggest TODO is DRM/i915 driver and I don't feel brave enough to fix
> it fully. The driver creatively uses sg_table->orig_nents to store the
> size of the allocate scatterlist and ignores the number of the entries
> returned by dma_map_sg function. In this patchset I only fixed the
> sg_table objects exported by dmabuf related functions. I hope that I
> didn't break anything there.
>
> Patches are based on top of Linux next-20200618. The required changes to
> DMA-mapping framework has been already merged to v5.8-rc1.
>
> If possible I would like ask for merging most of the patches via DRM
> tree.

David & Daniel: how would you like to merge those patches? They got 
quite a lot acks and some of them have dependencies on the DRM core. I 
would really like to get patches 1-28 merged via DRM (misc?) tree. Do 
you want me to prepare a branch and send a pull request?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
