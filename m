Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FE3C433DF
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 15:05:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DBD20658
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 15:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nfxhzymF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DBD20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4117125AB7;
	Tue,  7 Jul 2020 15:05:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nTJDeflzfQ9u; Tue,  7 Jul 2020 15:05:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 80FEF2353A;
	Tue,  7 Jul 2020 15:05:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D618C07FF;
	Tue,  7 Jul 2020 15:05:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F245C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 15:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6B32187C20
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 15:05:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bk6+JfBqHW16 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 15:05:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 725F187C16
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 15:05:25 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200707150523euoutp01f8fc475a86b469c2a481691b1b442b15~fgLiWZBqU3133531335euoutp01A
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 15:05:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200707150523euoutp01f8fc475a86b469c2a481691b1b442b15~fgLiWZBqU3133531335euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1594134323;
 bh=Ul3xV45A0w73X27Z+PVPXTqqjiNMubiJqyOLv4lqhqQ=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=nfxhzymF2/t5wQ3GadNqNa7iMfNJc2c/hYUATf9XVpO5S+9MfDzuIy8f+zOW9GzZE
 yEO6kSUH5CZ+ouf2aFcLF+IrulE/GbZCIgSRTWxxvpfFEY2l/UdXlM4sHNvdJIai21
 8J8c+FxnEBOSUO5bSPJhD1uo6Ze57SdRVlhTGV+I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200707150522eucas1p12dd71ca62e476410ca18578db56a6f37~fgLh9MLjy1234012340eucas1p1D;
 Tue,  7 Jul 2020 15:05:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 4C.9A.05997.23F840F5; Tue,  7
 Jul 2020 16:05:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200707150522eucas1p13258746a2576727a0728ad66b11be070~fgLhn_XgW0840008400eucas1p1T;
 Tue,  7 Jul 2020 15:05:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200707150522eusmtrp26bf7ecc2b7b00335eecdd00ec5fb2901~fgLhnGruj1585015850eusmtrp2S;
 Tue,  7 Jul 2020 15:05:22 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-c3-5f048f32454d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id FC.99.06314.23F840F5; Tue,  7
 Jul 2020 16:05:22 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200707150520eusmtip1ab7f010f05d147d45fed6f64064d89df~fgLfV_5mR0354903549eusmtip1Z;
 Tue,  7 Jul 2020 15:05:19 +0000 (GMT)
Subject: Re: [PATCH v7 08/36] drm: exynos: fix common struct sg_table
 related issues
From: Andrzej Hajda <a.hajda@samsung.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Message-ID: <ffef20f2-bafc-18af-7219-ec7c38fc1ab5@samsung.com>
Date: Tue, 7 Jul 2020 17:05:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <53d2ae18-3d60-773f-4544-3c8f55749038@samsung.com>
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+d3X7qzZdaY7PUgc9keCZmpxQ7MHUhf/ioiSIG3VRSU3x672
 /MP5Cl1Z0RBtmlopPkpd87E0WmWWrMgExQcWrjTIwgc4o8Jl3u4i//uc8z2vLxwaVw6S6+k0
 XSZv0GnS1ZQP0fHqZ19Y5HUiOcL5MZot7nNi7MOyFpIdXJil2Ib7LzG2+mkM6x78iLG2iSGS
 HeiqoNiydw6Mber5IGOfz02SbJl5itqzmntQ+QBx9u8ukhu/0otxrTXZ3NjvCZwzj9Qh7vGo
 keKutTUibt626aD8mE/saT497Sxv2Bp3wif1R84LUv9t1fmZaa0RueQmJKeBiYYmawVlQj60
 kqlHcLuyBJMCN4JbBcXeYB5Bjqud+Nfyq+A1IQl1CD7lP/NWzSIomB8jTYim/ZkjMLwUJDZQ
 zBbwtI5SIq9l2hDklewX63GmBIOJDgcuCgomDq563stEJpgQGCj9+jcfwCRBy5Qdk2r8wHlr
 8u8VcmY3lA5bSZFxJgjs0xW4xCrIdTeQ4gJgFmRgLPrkPTseyj09SGJ/+NrbJpN4Iyx1VmES
 Z8N4fT4uNRciaLd24pIQA+/7flGiM3zZTkvXVhGB2QvteZsl9IWRaT/pBF+42VGKS2kFFF5W
 SjOCYfxtu3eeCmr7F6gbSG1ZYcyywoxlhRnL/7XViGhEKj5L0KbwQqSOPxcuaLRCli4l/FSG
 1oaWf+3N7173I9S1eLIbMTRSr1akaohkJak5K1zQdiOgcfVaxb63b5KUitOaCxd5Q0ayISud
 F7rRBppQqxRRd6eOK5kUTSZ/huf1vOGfitHy9UaUNtH4pXmmLujSgVzFM9caU19//JORzyqP
 O2I4N19oDgxJ/FA1FzZ0OGJ/ODs6frFWNxKrPBbn3KXDp2qstkL7pcLc861n7iWWpz6PMjeF
 6meKjOdKF/UdpnX8aILdnMMEOm4k6GtCsnI6A+yBR9ft3H6ndceaQ4O7HUP9rhhzsJoQUjXb
 QnGDoPkDjpzSw2cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsVy+t/xu7pG/SzxBn3XFS16z51kstg4Yz2r
 xZWv79ksVq4+ymSxYL+1xZcrD5ksNj2+xmpxedccNosZ5/cxWaw9cpfd4uCHJ6wWMya/ZHPg
 8Vgzbw2jx/ZvD1g97ncfZ/LYvKTe4/a/x8wek28sZ/TYfbOBzaNvyypGj8+b5AI4o/RsivJL
 S1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyfjQeZi14zV3x
 7m1uA+MDzi5GTg4JAROJX62nWLoYuTiEBJYySpx5v4QZIiEusXv+WyhbWOLPtS42iKK3jBJz
 t25iAkkIC4RJnOi4yQpiswloSvzdfBOsSERgC6PEsxWHGUEcZoHpTBI3u36wQrT/YpR4f+4v
 G0gLr4CdRM/fO+wgNouAisTl6a/A9okKxEks3zKfHaJGUOLkzCcsIDangL3E9OsbwNYxC5hJ
 zNv8kBnClpfY/nYOlC0u0fRlJesERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nziw31ihNz
 i0vz0vWS83M3MQLjeduxn5t3MF7aGHyIUYCDUYmHNyORJV6INbGsuDL3EKMEB7OSCK/T2dNx
 QrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTDV5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE
 0hNLUrNTUwtSi2D6mDg4pRoY1XL7nHYvuV1Sl9yVobf55OreyhVr1JTWPei4zL7c5FGIdfCZ
 Gfvns7b93pP9hlNd3W6KIhvXmrVHWrmn+6qe/WGX5arefNxY/UHtS5ZC4Y+2DrJX/pglSh5v
 PXqw5/ue+WcZt6bf63vy7Z7cpisnePuvX3aKEhV4UOrOvtn6G0+Q+uvXFrr5SizFGYmGWsxF
 xYkAcGZ9ef0CAAA=
X-CMS-MailID: 20200707150522eucas1p13258746a2576727a0728ad66b11be070
X-Msg-Generator: CA
X-RootMTR: 20200619103658eucas1p1c3236e2de2798c2d8c02279a9263e9a9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103658eucas1p1c3236e2de2798c2d8c02279a9263e9a9
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
 <CGME20200619103658eucas1p1c3236e2de2798c2d8c02279a9263e9a9@eucas1p1.samsung.com>
 <20200619103636.11974-9-m.szyprowski@samsung.com>
 <53d2ae18-3d60-773f-4544-3c8f55749038@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Seung-Woo Kim <sw0312.kim@samsung.com>,
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


On 07.07.2020 11:40, Andrzej Hajda wrote:
> On 19.06.2020 12:36, Marek Szyprowski wrote:
>> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
>> returns the number of the created entries in the DMA address space.
>> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
>> dma_unmap_sg must be called with the original number of the entries
>> passed to the dma_map_sg().
>>
>> struct sg_table is a common structure used for describing a non-contiguous
>> memory buffer, used commonly in the DRM and graphics subsystems. It
>> consists of a scatterlist with memory pages and DMA addresses (sgl entry),
>> as well as the number of scatterlist entries: CPU pages (orig_nents entry)
>> and DMA mapped pages (nents entry).
>>
>> It turned out that it was a common mistake to misuse nents and orig_nents
>> entries, calling DMA-mapping functions with a wrong number of entries or
>> ignoring the number of mapped entries returned by the dma_map_sg()
>> function.
>>
>> To avoid such issues, lets use a common dma-mapping wrappers operating
>> directly on the struct sg_table objects and use scatterlist page
>> iterators where possible. This, almost always, hides references to the
>> nents and orig_nents entries, making the code robust, easier to follow
>> and copy/paste safe.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>

Just fixing my signature :)

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Regards
Andrzej

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
