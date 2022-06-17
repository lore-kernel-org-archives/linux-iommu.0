Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110D7C433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Jun 2022 14:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DC3A4188E;
	Fri, 17 Jun 2022 14:30:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8DC3A4188E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=QefTeyNu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z3FKB5DTSQ1Q; Fri, 17 Jun 2022 14:30:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F394C41711;
	Fri, 17 Jun 2022 14:30:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F394C41711
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C89B3C0032;
	Fri, 17 Jun 2022 14:30:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC8B6C002D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 14:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9061540ACE
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 14:30:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9061540ACE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com
 header.a=rsa-sha256 header.s=mail20170921 header.b=QefTeyNu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rxa73fAKkbFJ for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 14:30:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4FED400E5
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C4FED400E5
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 14:30:06 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220617143003euoutp016a46550fdfcf5186ad09d307a322164b~5btYY-93f2064420644euoutp01l
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 14:30:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220617143003euoutp016a46550fdfcf5186ad09d307a322164b~5btYY-93f2064420644euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1655476203;
 bh=LCbEc6Tp6uQ+xLDkMAny+arMkrz5C0Fk7jR9Q8TS4vY=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=QefTeyNubqDaHtgo+tqnvLT5l3TyMR5wiMevsLnlyDdwGjIhpz2GrZyQ8Z0PqxEv9
 BIg3nmASL3LHl+9ePD68Eg7RndVEnrx7SABBozDjOWHnPBGBUbodvL4ixMquJ70dAa
 N9euIpbAA6gYQNHMZVUfTvUuTmzbrPjFbwGjPrSQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220617143003eucas1p21e8683693765b3b828889243be09336f~5btYDl_P01114111141eucas1p2I;
 Fri, 17 Jun 2022 14:30:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 8B.D8.09580.BEF8CA26; Fri, 17
 Jun 2022 15:30:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220617143002eucas1p17fe6039a2bd078ee46df6bdac3ac2f76~5btXfeMOf1420514205eucas1p1K;
 Fri, 17 Jun 2022 14:30:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220617143002eusmtrp214e6344c8075d27b528f705b67093164~5btXeuCwA2963329633eusmtrp2h;
 Fri, 17 Jun 2022 14:30:02 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-55-62ac8febe125
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 10.7E.09095.AEF8CA26; Fri, 17
 Jun 2022 15:30:02 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220617143002eusmtip161825d03cd954840e54a90f4c17321f7~5btWwILPo2864128641eusmtip1J;
 Fri, 17 Jun 2022 14:30:02 +0000 (GMT)
Message-ID: <27b927de-4523-1327-b850-aa389c8c8638@samsung.com>
Date: Fri, 17 Jun 2022 16:30:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH V2 2/6] iommu: iova: properly handle 0 as a valid IOVA
 address
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Ajay Kumar
 <ajaykumar.rs@samsung.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, joro@8bytes.org, will@kernel.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <1d617b42-55c7-fcf1-e569-052947364d94@arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87qv+9ckGUzYIW3x9cRvNosD7w+y
 WDyYt43NYsF+a4vO2RvYLTY9vsZqsWjrF3aLgx+esFq03DF14PR4cnAek8eaeWsYPXbOusvu
 sWlVJ5vH5iX1HpNvLGf06NuyijGAPYrLJiU1J7MstUjfLoErY/Kz12wFH5UqJpzzbWD8Id3F
 yMkhIWAi8fzrVeYuRi4OIYEVjBL3r65kg3C+MEr0vPzLCuF8ZpT49HwPK0xL3/NuqKrljBJ/
 ft9jgXA+MkqcuridDaSKV8BOov/nWSYQm0VAVWLmhoeMEHFBiZMzn7CA2KICSRLzt7WCTRUW
 CJE4f+4kmM0sIC5x68l8sF4RgT2MEj/XQMWDJT7PegA2h03AUKLrbRfYLk4Ba4mbdydC1chL
 bH87B+whCYEPHBJTXqxngzjbRWLR8qNMELawxKvjW9ghbBmJ/ztBlnEA2fkSf2cYQ4QrJK69
 XsMMYVtL3Dn3iw2khFlAU2L9Ln2IsCMwuHayQ3TySdx4KwhxAZ/EpG3TmSHCvBIdbUIQ1WoS
 s46vg9t58MIl5gmMSrOQwmQWkt9nIfllFsLeBYwsqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS
 83M3MQJT1Ol/x7/uYFzx6qPeIUYmDsZDjBIczEoivGbBK5OEeFMSK6tSi/Lji0pzUosPMUpz
 sCiJ8yZnbkgUEkhPLEnNTk0tSC2CyTJxcEo1MFXrVnPHyBdtfpdwriZca8vm1+dufkyZp7bw
 V9Ravq+z755v1t31R1Hr2+fN+/uSn+9UDAjgtzh5eXVj9O6p99f2hi8VtdA+xqznrBBxY28n
 M2NLGuf5I1+6I3fG88le37widekNf9VT7+ZXhmz9vX3/ubvnrsy5Gzg/cPE2ocMaAZ6Tw4vE
 S2Xu+iu8PMO0V/Fkn/dnYVHnfy+euXrYPctcuqN/T8wuq3JXRgvmzP8Hzu86yFwstqzZ9oOB
 9KTUrUJK7wukr6wzvCbf/uPsu3CH/jfXpyxYtPdDjrPtjF9Kp5WyGjUiDpbXdgd4GKrz+O9w
 XMj+xv6L52nrXCYHNt2T7JwGn+xsvDpq51l+TlZiKc5INNRiLipOBAD2EFAgwAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7qv+tckGRz9oWvx9cRvNosD7w+y
 WDyYt43NYsF+a4vO2RvYLTY9vsZqsWjrF3aLgx+esFq03DF14PR4cnAek8eaeWsYPXbOusvu
 sWlVJ5vH5iX1HpNvLGf06NuyijGAPUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzW
 yshUSd/OJiU1J7MstUjfLkEvY/Kz12wFH5UqJpzzbWD8Id3FyMkhIWAi0fe8m62LkYtDSGAp
 o8TU5Y/ZIBIyEienNbBC2MISf651QRW9Z5SYs2UHI0iCV8BOov/nWSYQm0VAVWLmhodQcUGJ
 kzOfsIDYogJJEvP2rgaLCwuESJw/dxJsKLOAuMStJ/PBekUE9jBK/J+mDhEPljjbfhRq2S0m
 iXeLHjCDJNgEDCW63naBXccpYC1x8+5EqEFmEl1buxghbHmJ7W/nME9gFJqF5I5ZSPbNQtIy
 C0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIGRue3Yz807GOe9+qh3iJGJg/EQowQH
 s5IIr1nwyiQh3pTEyqrUovz4otKc1OJDjKbAwJjILCWanA9MDXkl8YZmBqaGJmaWBqaWZsZK
 4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUz790/7V11UGyC2KzarVC0i9Y3dJO1/HBox1w/1
 p95awcF2QERzbe3StUlC/7cuqz3t7y1tcnpBdCjDH64ld57d+CvIq6Hh8ym6Y8KrqK4rh25e
 XvZ77Vv1ZTsLLee+Dj6U+n+p/V2HPtdgzzmZ+feOf2Xirjrk8Gt21ZOm13YNUxVeXeMKtglT
 3rzjJrtiSqPykstVWfK2D6ZqMvd0Nq9m/hQyScUxU+iAlEHs3zQ9e65FS6q1y/XMDz6cpx96
 7MzquexLRbd5ntIIWmCv+Nup/G8hg+2cyMdfbLPnvfTX2Ldqhr2MctiKDzOdfr9pZJ59IpPz
 jchNB9FJV7XyP0WUR1yWPiPRubX1paDbVQMlluKMREMt5qLiRACJ8dnzVQMAAA==
X-CMS-MailID: 20220617143002eucas1p17fe6039a2bd078ee46df6bdac3ac2f76
X-Msg-Generator: CA
X-RootMTR: 20220511121433epcas5p3de77375a85edf1aa78c0976a7107fdfa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220511121433epcas5p3de77375a85edf1aa78c0976a7107fdfa
References: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
 <CGME20220511121433epcas5p3de77375a85edf1aa78c0976a7107fdfa@epcas5p3.samsung.com>
 <20220511121544.5998-3-ajaykumar.rs@samsung.com>
 <a21f3016-a9f1-dc86-8604-ae651a763fc8@arm.com>
 <00c1f1c7-e3e5-5f22-0a15-b57b329d6d56@samsung.com>
 <1d617b42-55c7-fcf1-e569-052947364d94@arm.com>
Cc: pankaj.dubey@samsung.com, alim.akhtar@samsung.com
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

Hi Robin,

On 06.06.2022 14:38, Robin Murphy wrote:
> On 2022-06-02 16:58, Marek Szyprowski wrote:
>> On 23.05.2022 19:30, Robin Murphy wrote:
>>> On 2022-05-11 13:15, Ajay Kumar wrote:
>>>> From: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>
>>>> Zero is a valid DMA and IOVA address on many architectures, so adjust
>>>> the
>>>> IOVA management code to properly handle it. A new value IOVA_BAD_ADDR
>>>> (~0UL) is introduced as a generic value for the error case. Adjust all
>>>> callers of the alloc_iova_fast() function for the new return value.
>>>
>>> And when does anything actually need this? In fact if you were to stop
>>> iommu-dma from reserving IOVA 0 - which you don't - it would only show
>>> how patch #3 is broken.
>>
>> I don't get why you says that patch #3 is broken.
>
> My mistake, in fact it's already just as broken either way - I forgot 
> that that's done implicitly via iovad->start_pfn rather than an actual 
> reserve_iova() entry. I see there is an initial calculation attempting 
> to honour start_pfn in patch #3, but it's always immediately 
> overwritten. More critically, the rb_first()/rb_next walk means the 
> starting point can only creep inevitably upwards as older allocations 
> are freed, so will end up pathologically stuck at or above limit_pfn 
> and unable to recover. At best it's more "next-fit" than "first-fit", 
> and TBH the fact that it could ever even allocate anything at all in 
> an empty domain makes me want to change the definition of IOVA_ANCHOR ;)
>
>> Them main issue with
>> address 0 being reserved appears when one uses first fit allocation
>> algorithm. In such case the first allocation will be at the 0 address,
>> what causes some issues. This patch simply makes the whole iova related
>> code capable of such case. This mimics the similar code already used on
>> ARM 32bit. There are drivers that rely on the way the IOVAs are
>> allocated. This is especially important for the drivers for devices with
>> limited addressing capabilities. And there exists such and they can be
>> even behind the IOMMU.
>>
>> Lets focus on the s5p-mfc driver and the way one of the supported
>> hardware does the DMA. The hardware has very limited DMA window (256M)
>> and addresses all memory buffers as an offset from the firmware base.
>> Currently it has been assumed that the first allocated buffer will be on
>> the beginning of the IOVA space. This worked fine on ARM 32bit and
>> supporting such case is a target of this patchset.
>
> I still understand the use-case; I object to a solution where PFN 0 is 
> always reserved yet sometimes allocated. Not to mention the slightly 
> more fundamental thing of the whole lot not actually working the way 
> it's supposed to.
>
> I also remain opposed to baking in secret ABIs where allocators are 
> expected to honour a particular undocumented behaviour. FWIW I've had 
> plans for a while now to make the IOVA walk bidirectional to make the 
> existing retry case more efficient, at which point it's then almost 
> trivial to implement "bottom-up" allocation, which I'm thinking I 
> might then force on by default for CONFIG_ARM to minimise any further 
> surprises for v2 of the default domain conversion. However I'm 
> increasingly less convinced that it's really sufficient for your case, 
> and am leaning back towards the opinion that any driver with really 
> specific constraints on how its DMA addresses are laid out should not 
> be passively relying on a generic allocator to do exactly what it 
> wants. A simple flag saying "try to allocate DMA addresses bottom-up" 
> doesn't actually mean "allocate this thing on a 256MB-aligned address 
> and everything subsequent within a 256MB window above it", so let's 
> not build a fragile house of cards on top of pretending that it does.


Okay, I see your point. I'm fine with adding more of the IOVA allocation 
logic to the respective driver (s5p-mfc), however I would still like to 
use the dma-mapping framework and helpers, which depend on it (like 
v4l2-videobuf2, dma-buf, and so on). Would it be fine for you to let 
device drivers to access the IOVA domains hidden by the DMA-IOMMU glue 
code to mark certain parts of IOVA space as reserved or to manually 
remap the buffer (like firmware) with specific address requirements?


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
