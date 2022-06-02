Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521D0C433EF
	for <iommu@archiver.kernel.org>; Thu,  2 Jun 2022 15:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6B2B418F1;
	Thu,  2 Jun 2022 15:58:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8btxYaPwXtD9; Thu,  2 Jun 2022 15:58:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EE99741557;
	Thu,  2 Jun 2022 15:58:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B702EC0032;
	Thu,  2 Jun 2022 15:58:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7542C002D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 15:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D582060F8D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 15:58:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=samsung.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bZbh96HFFiks for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 15:58:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F83F605EA
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 15:58:35 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220602155833euoutp0276a9f7fe115d292cb557083accce4e3f~02PW7ECpY1653616536euoutp02C
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 15:58:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220602155833euoutp0276a9f7fe115d292cb557083accce4e3f~02PW7ECpY1653616536euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1654185513;
 bh=9is9KntIc7xcHZ305mCMR4xCbJAMm/+bcbh6KLQmhtk=;
 h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
 b=Mf+B8tVqHAqISpMhLS4ZKhHs/qkaGmvRGscU/O5hH0ltNE6sOzQwloIyREGz7I08q
 OzBJyXLKpZMtgxj/zlbMiMieDjmsGpoHjhQAHz96Z/csy9phOXH+cBeKPcKCPCaDm7
 JNv1lwEsesA0E3Xyvo3Es5/a2iSPOYK/oaPw2w9k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220602155832eucas1p230863ac601e4a20e4a499d325cc86a0f~02PWYyyr72814528145eucas1p2Y;
 Thu,  2 Jun 2022 15:58:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id C1.58.09580.82ED8926; Thu,  2
 Jun 2022 16:58:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220602155832eucas1p28312933c96f4155c43050ed887b2597a~02PV8vAeS1269512695eucas1p2P;
 Thu,  2 Jun 2022 15:58:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220602155832eusmtrp2914bc0130d153361a4daafcc98e5c30b~02PV8DnMT1313513135eusmtrp2p;
 Thu,  2 Jun 2022 15:58:32 +0000 (GMT)
X-AuditID: cbfec7f5-9c3ff7000000256c-d3-6298de2845b4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id DD.D8.09095.72ED8926; Thu,  2
 Jun 2022 16:58:31 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20220602155831eusmtip219f9a232ab3aaedf3d5eeb0810eb75d5~02PVZs7gJ3028430284eusmtip2Y;
 Thu,  2 Jun 2022 15:58:31 +0000 (GMT)
Message-ID: <00c1f1c7-e3e5-5f22-0a15-b57b329d6d56@samsung.com>
Date: Thu, 2 Jun 2022 17:58:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH V2 2/6] iommu: iova: properly handle 0 as a valid IOVA
 address
To: Robin Murphy <robin.murphy@arm.com>, Ajay Kumar
 <ajaykumar.rs@samsung.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, joro@8bytes.org, will@kernel.org
Content-Language: en-US
In-Reply-To: <a21f3016-a9f1-dc86-8604-ae651a763fc8@arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7oa92YkGTRul7T4euI3m8WB9wdZ
 LB7M28ZmsWC/tUXn7A3sFpseX2O1WLT1C7vFwQ9PWC1a7pg6cHo8OTiPyWPNvDWMHjtn3WX3
 2LSqk81j85J6j8k3ljN69G1ZxRjAHsVlk5Kak1mWWqRvl8CV0f3iGWPBDeGKozPa2BsYz/B3
 MXJySAiYSMw8+56xi5GLQ0hgBaPE+Z7/rBDOF0aJltcr2SCcz4wSjZMnMcO03Or+DJVYzihx
 +MdZdgjnI6NE655NbCBVvAJ2Ek2HV7GA2CwCKhLbZ39hhYgLSpyc+QQsLiqQJDF/WytYnE3A
 UKLrbRdYr7BAiMT5cyfB4iICexglfq4Bs5kFgiU+z3rACGGLS9x6Mp8JxOYUsJZ49e0sVI28
 xPa3c5hBDpIQ+MIh8bF1JxPE2S4SC/9DHCchICzx6vgWdghbRuL/TpBBHEB2vsTfGcYQ4QqJ
 a6/XQH1sLXHn3C82kBJmAU2J9bv0IcKOEvev7mSH6OSTuPFWEOICPolJ26YzQ4R5JTrahCCq
 1SRmHV8Ht/PghUvMExiVZiGFySwkf81C8ssshL0LGFlWMYqnlhbnpqcWG+ellusVJ+YWl+al
 6yXn525iBCap0/+Of93BuOLVR71DjEwcjIcYJTiYlUR4S3ZNTRLiTUmsrEotyo8vKs1JLT7E
 KM3BoiTOm5y5IVFIID2xJDU7NbUgtQgmy8TBKdXA5HT7ReAti0D2hXlaWbmMj7Okq+1yLI7W
 /H4zYcaBYwxT7sqEf0udvfdP7KQn5+8cPtlifn1iU7qL/EEm3T9qUVvydlouOdF6er7OwdfO
 wstlDn9z+10r9b3h25rq0KZXy0pmMPuF9vBIvsmWsS9JeuZ853mc/pGprvVr7j2quVnUfkt5
 y8Jl52fY5Tiw5kk3TZ11Qsxtk9jUlDPK4ic6PQpD3j/bwVN6Tyabb9/EtZcTDuipfTz+ffYj
 PmX3PYsDn2qldp0Iiw4L39rYcfzQhrJu919JrWbro4X7V59N/Byxar5Gcf/Xh1MFT36c8nJ5
 eXLkvsymD5m610zeaTVVfJzzXVVt4vudsTOldWL3LFFiKc5INNRiLipOBADoiLu1wQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xe7rq92YkGfRdMLf4euI3m8WB9wdZ
 LB7M28ZmsWC/tUXn7A3sFpseX2O1WLT1C7vFwQ9PWC1a7pg6cHo8OTiPyWPNvDWMHjtn3WX3
 2LSqk81j85J6j8k3ljN69G1ZxRjAHqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5r
 ZWSqpG9nk5Kak1mWWqRvl6CX0f3iGWPBDeGKozPa2BsYz/B3MXJySAiYSNzq/szWxcjFISSw
 lFGi8dxUZoiEjMTJaQ2sELawxJ9rXVBF7xkllh19xA6S4BWwk2g6vIoFxGYRUJHYPvsLK0Rc
 UOLkzCdgcVGBJIl5e1czgthsAoYSXW9BBnFyCAuESJw/dxKsXkRgD6PE/2nqIDazQLDE2faj
 UMu+MEosOd7BBpEQl7j1ZD4TiM0pYC3x6ttZVoi4mUTX1i5GCFteYvvbOcwTGIVmIbljFpL2
 WUhaZiFpWcDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwNrcd+7l5B+O8Vx/1DjEycTAe
 YpTgYFYS4S3ZNTVJiDclsbIqtSg/vqg0J7X4EKMpMDAmMkuJJucDk0NeSbyhmYGpoYmZpYGp
 pZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAOTXE5Cju1UpSNBKxNFTl3ubFwo9VuA2fPF
 hmslLkLvuKWTg9bFc/WdbnXs0vub+zhwbk7KrEnmxau5XAS+P8o/z9u80HUmzy+3haL23WLX
 StfuOjv3Tpv/gj9vRXjq7k1vyXstf6iFv0yAT/7G8j7NXWGHpI/2GF8Xqdib3qLGwzKn5Y8S
 p8HCq08LprxNuTPfOtt6SlWo6M383N2/liT8Z+o+Xl/Hutz1nUM3SzyH51S7/KBgRVf7GXVz
 tbaKpExyvhk2bekp1651067MX1PtHyxoc//jqYxPNww6rf3XrHLLjJZM5lL9ZLZMa2Pbce2v
 Cs/EDFl0W49vnl807/OBO7MO5lharjbOLJtkfF6JpTgj0VCLuag4EQDF2cSCVgMAAA==
X-CMS-MailID: 20220602155832eucas1p28312933c96f4155c43050ed887b2597a
X-Msg-Generator: CA
X-RootMTR: 20220511121433epcas5p3de77375a85edf1aa78c0976a7107fdfa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220511121433epcas5p3de77375a85edf1aa78c0976a7107fdfa
References: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
 <CGME20220511121433epcas5p3de77375a85edf1aa78c0976a7107fdfa@epcas5p3.samsung.com>
 <20220511121544.5998-3-ajaykumar.rs@samsung.com>
 <a21f3016-a9f1-dc86-8604-ae651a763fc8@arm.com>
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

On 23.05.2022 19:30, Robin Murphy wrote:
> On 2022-05-11 13:15, Ajay Kumar wrote:
>> From: Marek Szyprowski <m.szyprowski@samsung.com>
>>
>> Zero is a valid DMA and IOVA address on many architectures, so adjust 
>> the
>> IOVA management code to properly handle it. A new value IOVA_BAD_ADDR
>> (~0UL) is introduced as a generic value for the error case. Adjust all
>> callers of the alloc_iova_fast() function for the new return value.
>
> And when does anything actually need this? In fact if you were to stop 
> iommu-dma from reserving IOVA 0 - which you don't - it would only show 
> how patch #3 is broken.

I don't get why you says that patch #3 is broken. Them main issue with 
address 0 being reserved appears when one uses first fit allocation 
algorithm. In such case the first allocation will be at the 0 address, 
what causes some issues. This patch simply makes the whole iova related 
code capable of such case. This mimics the similar code already used on 
ARM 32bit. There are drivers that rely on the way the IOVAs are 
allocated. This is especially important for the drivers for devices with 
limited addressing capabilities. And there exists such and they can be 
even behind the IOMMU.

Lets focus on the s5p-mfc driver and the way one of the supported 
hardware does the DMA. The hardware has very limited DMA window (256M) 
and addresses all memory buffers as an offset from the firmware base. 
Currently it has been assumed that the first allocated buffer will be on 
the beginning of the IOVA space. This worked fine on ARM 32bit and 
supporting such case is a target of this patchset.


> Also note that it's really nothing to do with architecture either way; 
> iommu-dma simply chooses to reserve IOVA 0 for its own convenience, 
> mostly because it can. Much the same way that 0 is typically a valid 
> CPU VA, but mapping something meaningful there is just asking for a 
> world of pain debugging NULL-dereference bugs.

Right that it is not directly related to the architecture, but it is 
much more common case for some architectures where DMA (IOVA) address = 
physical address + some offset. The commit message can be rephrased, 
though.

I see no reason to forbid the 0 as a valid IOVA. The DMA-mapping also 
uses DMA_MAPPING_ERROR as ~0. It looks that when last fit allocation 
algorithm is used no one has ever need to consider such case so far.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
