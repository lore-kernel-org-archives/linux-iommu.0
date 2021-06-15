Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C90C48BDF
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 07:20:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B76F61417
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 07:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B76F61417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D191283B42;
	Tue, 15 Jun 2021 07:20:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L3xK6k_5s8TI; Tue, 15 Jun 2021 07:20:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9692883B29;
	Tue, 15 Jun 2021 07:20:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 491E3C000E;
	Tue, 15 Jun 2021 07:20:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C495C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 07:20:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E8A414055E
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 07:20:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=samsung.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c-adxxp6NAxl for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 07:20:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E152404B9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 07:20:02 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20210615071959euoutp014d01a8a8ee8a07cc1313397b790d4e1a~IsGHVrueF2947629476euoutp01f
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 07:19:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20210615071959euoutp014d01a8a8ee8a07cc1313397b790d4e1a~IsGHVrueF2947629476euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1623741599;
 bh=SL1Ft6VWY/RjURdlPpMzqSKXBcYq78k+CzNlalELtNw=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=B//buWfHqa/n9KDFqYVwPXl+fDXJddaFvzPXrCWmWdAov0cDyD7kBwGkcc4Pmud05
 vUZsVZfbjXVcLoxSxIZ3bLSubAHFp6UxgzF/1PaBzGGeYl8cPV/jEQ5VskWbxT6c2+
 Qzl40T8lD1mTAPSnkN+Gfa171LPymvqFCFPTy31s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210615071959eucas1p17d73b40993aca625921fa2df1175e2ff~IsGHFn4ot2709327093eucas1p12;
 Tue, 15 Jun 2021 07:19:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 90.70.09444.F9458C06; Tue, 15
 Jun 2021 08:19:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20210615071959eucas1p29ec7b2d9fa2f206a99cd3ec757e4a6bf~IsGGtUCjs1417614176eucas1p2W;
 Tue, 15 Jun 2021 07:19:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210615071959eusmtrp1e135f6e3b85c08046694ef8b87a1a6d5~IsGGsgOEV2144721447eusmtrp1G;
 Tue, 15 Jun 2021 07:19:59 +0000 (GMT)
X-AuditID: cbfec7f4-dd5ff700000024e4-be-60c8549f0815
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 18.10.08696.F9458C06; Tue, 15
 Jun 2021 08:19:59 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210615071958eusmtip12e3c533f64d669cab1d9e3f5aab42c52~IsGGF7Mdn2836228362eusmtip11;
 Tue, 15 Jun 2021 07:19:58 +0000 (GMT)
Subject: Re: [PATCH 1/1] dma: coherent: check no-map property for arm64
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <7729cff3-27b4-c233-7f53-95f6140d3828@samsung.com>
Date: Tue, 15 Jun 2021 09:19:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614153603.GA1998@lst.de>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djPc7rzQ04kGDxuUrb4MnUXs8X7ZT2M
 Fn83T2ezWLn6KJPFgv3WFpseX2O1uLxrDpvFvTX/WS0OfnjCatFyx9SBy2PNvDWMHjtn3WX3
 2LSqk81j06dJ7B6bl9R7TL6xnNFj980GNo+N73YweXzeJBfAGcVlk5Kak1mWWqRvl8CV8blj
 PkvBI+6KS03b2BsYj3J2MXJySAiYSNw8uZCti5GLQ0hgBaPEpDOHmCCcL4wSxz+9Z4ZwPjNK
 HNrfxwjTsuXgU6jEckaJ251drBDOR0aJiQtvsncxcnAIC7hLLF6SANIgAmQu6z0GVsMs8IBJ
 4vae32wgCTYBQ4mut11gNq+AncStg+3MIDaLgKpEx8p+JhBbVCBZ4v28GawQNYISJ2c+YQGx
 OQW0JU5c3gxWwywgL7H97RxmCFtc4taT+WA/SAj0c0r0/rvEBnG2i0TjxKmsELawxKvjW9gh
 bBmJ05N7WCAamhklHp5byw7h9DBKXG6aAfW0tcSdc7/YQF5jFtCUWL9LHyLsKPH14Q6wsIQA
 n8SNt4IQR/BJTNo2nRkizCvR0SYEUa0mMev4Ori1By9cYp7AqDQLyWuzkLwzC8k7sxD2LmBk
 WcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYxk7/O/5lB+PyVx/1DjEycTAeYpTgYFYS
 4T1cfzxBiDclsbIqtSg/vqg0J7X4EKM0B4uSOG/SljXxQgLpiSWp2ampBalFMFkmDk6pBqYp
 mb2ytQev1Xv1TjepaP3l/il261KWg7+UUzlcfYwZHwRsebq6LJb9fWw7o5W3i5dVtlzageXx
 C3oKWeZ/ei2i8H6l7wfzF29d1u/5tF046/7ilwu55ZanqmwrPOqkel1J/9HD1XJW0awsX5J8
 21dMb0oI/f4473gdU0gYe9LjIO7lfzW+zdjLGmG8g+PzA64n5bsuev3eGTYx70mXw5XYb+En
 nt+cWZDj+Xff50CnKPvlqsFul6r3F032XN2x7+fGleEr79kzLcnTsA6tjYxuipnnLiLenu6v
 ftOuYD0nc/ujtJ1Z2rHrPKTF3SuEdvbULFh/Qkp3P3tfefixPpHjuRZpAZ69Jc3bO9KjlFiK
 MxINtZiLihMBAdtLWtIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7rzQ04kGJybzG7xZeouZov3y3oY
 Lf5uns5msXL1USaLBfutLTY9vsZqcXnXHDaLe2v+s1oc/PCE1aLljqkDl8eaeWsYPXbOusvu
 sWlVJ5vHpk+T2D02L6n3mHxjOaPH7psNbB4b3+1g8vi8SS6AM0rPpii/tCRVISO/uMRWKdrQ
 wkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv43PHfJaCR9wVl5q2sTcwHuXsYuTk
 kBAwkdhy8ClzFyMXh5DAUkaJ249mM0MkZCROTmtghbCFJf5c62KDKHrPKPFkfw9LFyMHh7CA
 u8TiJQkgNSJA5rLeY6wgNcwCD5gkXm3YzALR8J1JYvqvQ0wgVWwChhJdb0EmcXLwCthJ3DrY
 DraNRUBVomNlP1iNqECyxM/17VA1ghInZz5hAbE5BbQlTlzeDFbDLGAmMW/zQ2YIW15i+9s5
 ULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iREY
 t9uO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8B6uP54gxJuSWFmVWpQfX1Sak1p8iNEU6J+JzFKi
 yfnAxJFXEm9oZmBqaGJmaWBqaWasJM5rcmRNvJBAemJJanZqakFqEUwfEwenVAPTxnsffx5J
 7j2rzVBTE6kRUFzbuKjzIbfFwc0XpENZd1hq9npVVpeptNptYN3U9kZd6onmPN/at9Lnprku
 6mG7Vz6B/0lJzLIHm3S68/3EkrWWX738TWv53cDf175fXdCyd9/dtVGfY7+qWNWlOxolslzZ
 f1zQ7eiDZfKqpza133FbJ3Fp7kyTqSfu2pYeclok3GydkBK+Y4ZMsWmLfOWZQqPzfOnTONwE
 3255VsGuqLPhoXlAzo4Jz6d/2O53Kv+R50qjZhnjYpu5oQ3yUVMTj87M7v7r+uIg/4stl1ds
 4LVs083LFon3qUqST/zEJTbxkyOrLtdjXq2DXIoRbt7TGlv6UqdeOyb9eq5g+F0lluKMREMt
 5qLiRAD3b3J/ZAMAAA==
X-CMS-MailID: 20210615071959eucas1p29ec7b2d9fa2f206a99cd3ec757e4a6bf
X-Msg-Generator: CA
X-RootMTR: 20210614153610eucas1p209898b2e8dc013fe6ef072060609c21d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210614153610eucas1p209898b2e8dc013fe6ef072060609c21d
References: <20210611131056.3731084-1-aisheng.dong@nxp.com>
 <20210614083609.GA18701@willie-the-truck>
 <CAA+hA=S8x4S0sgAiJbqOC-wgtOshV_jhAq6eVqX5-EAeg3Dczg@mail.gmail.com>
 <20210614145105.GC30667@arm.com>
 <6f897830-301f-3eb4-785f-de446476e676@arm.com>
 <CGME20210614153610eucas1p209898b2e8dc013fe6ef072060609c21d@eucas1p2.samsung.com>
 <20210614153603.GA1998@lst.de>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Dong Aisheng <dongas86@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>, "moderated
 list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

Hi Christoph,

On 14.06.2021 17:36, Christoph Hellwig wrote:
> On Mon, Jun 14, 2021 at 04:34:05PM +0100, Robin Murphy wrote:
>>> Looking at the rmem_dma_device_init() -> dma_init_coherent_memory(), it
>>> ends up calling memremap(MEMREMAP_WC) which would warn if it intersects
>>> with system RAM regardless of the architecture. If the memory region is
>>> nomap, it doesn't end up as IORESOURCE_SYSTEM_RAM, so memremap() won't
>>> warn. But why is this specific only to arm (or arm64)?
>> Didn't some ARMv7 implementations permit unexpected cache hits for the
>> non-cacheable address if the same PA has been speculatively fetched via the
>> cacheable alias?
> If we care about that we need to change these platforms to change the
> cache attributes of the kernel direct mapping instead of using vmap.
> We already have code to do that for openrisc, someone just needs to
> write the glue code for other platforms.

ARAIR there is a problem with changing cache attributes of the direct 
mappings on ARM 32bit. The whole lowmem is mapped with 2M 'section' 
mappings. Changing cache attributes causes 2 issues. First - one would 
need to split 2M entry into 4K entries. Second - 2M section mappings for 
the whole lowmem area are located in the per-process page tables. 
Changing the cache attributes would require locking all processes and 
iterating over their page table entries, which is a huge task.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
