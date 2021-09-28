Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB354C433F5
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 10:11:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C29610FC
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 10:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90C29610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5BB78401F7;
	Tue, 28 Sep 2021 10:11:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KpjkVY77DCat; Tue, 28 Sep 2021 10:11:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 95AF2400D8;
	Tue, 28 Sep 2021 10:11:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C0C8C0011;
	Tue, 28 Sep 2021 10:11:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C06CC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 10:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 20547401A0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 10:11:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Cv8256xXgpm for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 10:11:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64F82400D8
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 10:11:38 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20210928101135euoutp02c0165570a38f060a422b4f4cf204e407~o9K6e6Mlu2261122611euoutp02M
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 10:11:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20210928101135euoutp02c0165570a38f060a422b4f4cf204e407~o9K6e6Mlu2261122611euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1632823895;
 bh=Uq7JRZfgtgIv8od+MEX1Yfq8ZJs11gdCeWJ7IvAJEEA=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=HjxN/tf7pdMxGuOY9ZboCv30dvt0rlPvMCjj74WHuW6wIU519w9hrRRXqq4+zBpdg
 oIieXU7Aqez4eSTcQZFL6RF4cYdykaDU9DdY/rRWtfOEHBac2mqxIcH8VNmq/rPe2e
 jCcXGKwKk29AzMSZ/I3uekDn5rovvlvd9zVBnlBA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210928101135eucas1p1bb9f8b528c94e8bfac0bdd9a60404e72~o9K55rkHy1386313863eucas1p1Z;
 Tue, 28 Sep 2021 10:11:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id DB.67.56448.65AE2516; Tue, 28
 Sep 2021 11:11:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20210928101134eucas1p107ae33386004de51bdcc1d240b097980~o9K5kBEmR2078120781eucas1p1p;
 Tue, 28 Sep 2021 10:11:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210928101134eusmtrp1fb43c49b5403cc6df32cbe8848fd4994~o9K5i38nM0481104811eusmtrp1_;
 Tue, 28 Sep 2021 10:11:34 +0000 (GMT)
X-AuditID: cbfec7f5-d3bff7000002dc80-27-6152ea56b9d1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id F2.FC.31287.65AE2516; Tue, 28
 Sep 2021 11:11:34 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210928101134eusmtip219257f3df32cf3a26d2a67ad319979be~o9K49EOtN1684316843eusmtip2q;
 Tue, 28 Sep 2021 10:11:34 +0000 (GMT)
Subject: Re: [PATCH] iommu/dma: Tidy up Kconfig selects
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <e88879bf-cd4e-1018-da50-6f0a1dda4784@samsung.com>
Date: Tue, 28 Sep 2021 12:11:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVLgw1nfEf7U13Mh@8bytes.org>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se2xLcRTH97v39vZu0bqqsmPYpIt6zDaLNW6MBhEqXssWFhKmqatEW9Ka
 V0yWeu5i80pNN7XQPc3IwsyEaanGq15LNibxKtMyM5ttLBprr8f++57z+5zzPd/kR+GSEkEU
 tc6wiTUa1DoZGUHU3vnhic/wp6knVYiZinMujCluSGFyCy8Kma/7vwiYZ/VFJOP46hUwu18q
 mN6L7wQzKJXXYcNUVbYqpKqpzCVVx5rLkOra8xxS1VkTnUouj5i2mtWt28waE5WrItb2FtrR
 xnPk1mvfnHgOyhNwKJwCOhlqbp8mOBRBSehyBO0HehFfdCGwd7WgICWhOxHUcaK/E5++nMJ5
 qAyBq9X+Z6IDQevJZixIDaWnwJnaAiKopfRcsObXCYIQTp9FUFbXG4JIOgm4No4MahGthFuH
 PCFN0GOg++7V0IHDaA1YfplxnhkCd096Q0vD6QnQUPE9pHE6Bq60FeG8joQX3tNY0AxoLwXX
 ufx+iOovZsN7n5aPMBT87ktCXo+E+8cOEjy/C8Ebz3khXxxE8MxcgHgqBV56fpLBRTg9Hi7U
 J/LtmcDdsAn5/WJobhvC3yCGo7UncL4tgv17JTwtB6u7+p+t4/FT/DCSWQcksw5IYx2Qxvrf
 txgRlSiSzTLptaxpsoHdkmBS601ZBm2CZoO+BvX/pPsB9/c6VO7vSHAijEJOBBQuk4rSicVq
 iWi1ett21rgh05ilY01ONIIiZJGi+stVmRJaq97ErmfZjazx7ytGhUflYOYnlcexvr57wkGd
 9Z+v9zE7w9umx+/4qWuXxS5a0555ddTyxvQwKBjT0xllFjO5+mJLWvnrBQFVSbIv1fugpTTG
 8qBjqsaPJVXKXZg35bi7o0s/TtPUl1EWZluwbOI7uXJXIM5z86MhTqd86GspGv9R1rP00YuA
 v3vrK65k1JHC8tY9XPJMvz3mxLeGOcUXFmYv3Ocbnv+hCRMekBr9sY/lipaSOY7obNeS+HaF
 /dErccHYPIt32srGaqonLtMy3ZfHbLdFxwZyzVLt7rh0m7ixdtlIjVIowlzO+WFOhWPGvEkr
 spnS0tHPMxLl1U3Vc8Osb2cNVmQRn93N3VIZYVqrTpqAG03q35Dv+4O4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7phr4ISDZZ2aFisXH2UyWLBfmuL
 ztkb2C0+dLxjtbi8aw6bxcEPT1gtWu6YWvzY8JjVgcPjycF5TB5r5q1h9Ni0qpPNY/KN5Ywe
 u282sHl83iQXwBalZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZ
 llqkb5egl/Fj9hLGgtVsFbs/HWJuYOxj7WLk5JAQMJF4/W4ucxcjF4eQwFJGiZVzNrFBJGQk
 Tk5rgCoSlvhzrYsNoug9o8SZtVPZQRLCAuYSi7bNYAGxRQTcJWb172AFKWIWWMwoceDIPSaI
 jnOMEgv+ngEbxSZgKNH1tgtsBa+AncTh3nNgNouAqsS3kzvBakQFkiXevv7OBFEjKHFy5hOw
 DZwCWhL7V34Fs5kFzCTmbX7IDGHLS2x/OwfKFpe49WQ+0wRGoVlI2mchaZmFpGUWkpYFjCyr
 GEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiNx27Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRHeYBb/
 RCHelMTKqtSi/Pii0pzU4kOMpkD/TGSWEk3OB6aCvJJ4QzMDU0MTM0sDU0szYyVx3q1z18QL
 CaQnlqRmp6YWpBbB9DFxcEo1MOmelvZo3VO570BSSdqDZapf5vFpW3cpOn3wdZYvjMn/czpa
 smoBr0XtxiLJw1am2WyTrJaf+TLvsM1x/ZWaZ+4Udfhkt6h/6LSJn3/4qQkvi9ilX8fu/nCS
 PORy/6jOXY91Ln87o5PLHqSnnFJct1KDj0vjywbn14pv/2cvPr5nxa1Gv59KqfbtFVwNK50y
 /W7tWfdmz8RFgWH7Tz8QiMhx9tzLc+XIx+AjZQKPdUqTkza82NK/SzMx6mGZU9CNM1kua/n8
 dMrCmo+WVVn9dY8q3vgo+Hny842p30+Wrj9XeU64LCBMY69W4hfGW0LX8gpXHJJMcMn12LiX
 vXztFH159U2uDvnHpr2bpr50qRJLcUaioRZzUXEiADLqOW5NAwAA
X-CMS-MailID: 20210928101134eucas1p107ae33386004de51bdcc1d240b097980
X-Msg-Generator: CA
X-RootMTR: 20210928093051eucas1p2fc69dc7b8dff175901ac2b00be6c33c7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210928093051eucas1p2fc69dc7b8dff175901ac2b00be6c33c7
References: <9ba6f2e8568a3ff6a94fade66668d99705433c44.1631536879.git.robin.murphy@arm.com>
 <CGME20210928093051eucas1p2fc69dc7b8dff175901ac2b00be6c33c7@eucas1p2.samsung.com>
 <YVLgw1nfEf7U13Mh@8bytes.org>
Cc: linux-ia64@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, will@kernel.org,
 Christoph Hellwig <hch@lst.de>
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

On 28.09.2021 11:30, Joerg Roedel wrote:
> On Mon, Sep 13, 2021 at 01:41:19PM +0100, Robin Murphy wrote:
>> Now that the dust has settled on converting all the x86 drivers to
>> iommu-dma, we can punt the Kconfig selection to arch code where it
>> was always intended to be.
> Can we select IOMMU_DMA under IOMMU_SUPPORT instead? The only drivers
> not using IOMMU_DMA are the arm32 ones, afaics.
>
> If we could get rid of the arm32 exception, the IOMMU_DMA symbol could
> also go away entirely and we handle it under IOMMU_SUPPORT instead. But
> that is something for the future :)

Maybe it would be a good motivation to get back to 
https://lore.kernel.org/linux-iommu/cover.1597931875.git.robin.murphy@arm.com/ 
:)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
