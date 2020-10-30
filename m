Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834A7C55178
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 09:39:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA1A2076E
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 09:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Hh+5kowh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA1A2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4525D862C9;
	Fri, 30 Oct 2020 09:39:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id unBeDgNvchg6; Fri, 30 Oct 2020 09:39:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4DCEC84E0A;
	Fri, 30 Oct 2020 09:39:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A19FC0859;
	Fri, 30 Oct 2020 09:39:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34562C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 09:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E402A2052B
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 09:38:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jKZ6WUK5d250 for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 09:38:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id 88584203A0
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 09:38:56 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20201030093828euoutp02ba6868f1c466ec9cdf058623e5688957~Cu579BFU81591815918euoutp02h
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 09:38:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20201030093828euoutp02ba6868f1c466ec9cdf058623e5688957~Cu579BFU81591815918euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1604050708;
 bh=DPwF3bxN+Cc2XnEZqgdTkdloCkuZVnRXdYypETg8mf8=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=Hh+5kowhVx6PiX+0TrbLVahuGKAq+EUeLNnUvTXvpU17HZZrmyOUGI0kok/U3GEFc
 wVD2wQHBeHbZBG64DTdnHTLpzbhyFA8OctqEe2P1iZO3D5Iu4VfPM+KthsvS1y94lv
 Un08ftByNcR6r+U8hMAnlRUO/X3RjXlq38O6YTc8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20201030093823eucas1p21159cba7ddf588d2f5ddc6746fdd9df9~Cu53JxNDP0257102571eucas1p2H;
 Fri, 30 Oct 2020 09:38:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 49.BD.05997.F0FDB9F5; Fri, 30
 Oct 2020 09:38:23 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20201030093823eucas1p18c63df9a5c3a4c42314bda8d13a82f1e~Cu52l8IOh2325023250eucas1p1z;
 Fri, 30 Oct 2020 09:38:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20201030093823eusmtrp1a0cf8ff1272958dea8978d6a2b3c467a~Cu52lOa1m0707207072eusmtrp1V;
 Fri, 30 Oct 2020 09:38:23 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-f0-5f9bdf0fe4ef
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 5F.07.06017.E0FDB9F5; Fri, 30
 Oct 2020 09:38:23 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20201030093822eusmtip28209a9dc3375e309b188a9e79428d91c~Cu52Hq_Qo2372423724eusmtip2N;
 Fri, 30 Oct 2020 09:38:22 +0000 (GMT)
Subject: Re: [PATCH] iommu: Clarify .of_xlate assumptions
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <cbae7bff-3b1c-fd0f-7e77-19413aaecf1b@samsung.com>
Date: Fri, 30 Oct 2020 10:38:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e86ad0f733a9fe7b209bb7c5ac58760266b97414.1603985657.git.robin.murphy@arm.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm85xtZ9rsbCq+aCSOlIy8lcQpS+zy49AvK7pgqE09qHgbmzMX
 VGoiuUTmpdRNaytNsalLY6UippnTzKVl3jAkG16iUaQ/zCxqHi3/Pc/zPu/3Pg98BCYyczyI
 pLQMRpYmSRFzHXFT3w+L//YZbUzQktqHqtaWIErXFUoVaI08quXTGIfKL3jIoeb1KxjV/c3K
 oWZKWnGqSs8N59PW7rsOtOGuAdHFQ/50m+YDj87rtXHoloYCLt1ac50unahDdN5AFx7Bj3Q8
 HM+kJGUyssCwS46JqukKnrTDKeu5yYKyUS5fhfgEkCEwqn7PVSFHQkTWI6gunMFYsoyganzO
 gSVLCFb0at7miq6olsMO6hAYxyY2XF8RmF93cuwuF/Ig5I2+RHbsSlLQvWJbfxcjexHk9unW
 TVwyGFQ2FdeOBWQYLFvsOkHgpA/c6Tpll93IWPi1tIaxFiEMVFpxO+aTF2HB1LSOMdILntqq
 MBa7w5T13nogIKd40Nj/ZCP2CajVTmxgF/hs3tR3wGBpIc4u3EDw0dLIY0khgne5FYh1hcK0
 ZZVrT4eRftDcHsjKR+GxbgrZZSCdYcImZEM4Q4mpHGNlAdzMF7FuX9CYm/6d7R5+i6mRWLOl
 mmZLHc2WOpr/d3UIb0DujEKemsDI96UxlwPkklS5Ii0hIC49tQX9/V6Dv83Lz1D7WmwPIgkk
 3iYI99LGiDiSTLkytQcBgYldBceGBqNFgniJ8gojS4+RKVIYeQ/yJHCxu2D//cUoEZkgyWCS
 GUbKyDanDgTfIxs9yhq2+CUnzufwz5Zf23mk7dbpA5Fl3l7tX87Pjue7DQ94v6mMEwYpv8c8
 qPc0RE8afPf6j/VHWYbH0fK52caIOOMhdEH6s1WtB1NITe1Ikd9CTvPVXaPFFbubOq2Vr/Lm
 /KTKpbn+28Fl4yNOvmeiTiqELyYXGzuOG43+ylUsWIzLEyXBezCZXPIH38nFQFoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xe7r892fHG+ybxmQxd/YkRosF+60t
 OmdvYLfY9Pgaq0Vb5zJWi+cLfzBbHPzwhNXi/qTNLBZzFrI5cHo8OTiPyWPNvDWMHhPP6nrs
 nHWX3aPlyFtWj02rOtk8Ni+p95h8YzmjR8vJ/SwBnFF6NkX5pSWpChn5xSW2StGGFkZ6hpYW
 ekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GV13ZrAX7OauOLDtHGMDYxNnFyMnh4SAicSC
 vqWsXYxcHEICSxklztycxwqRkJE4Oa0ByhaW+HOtiw2i6C2jxLbeVhaQhLCApUTLlaOMILaI
 gIXEwR9vmUGKmAWOMEo0vHgBNXYdo8SR2a/ARrEJGEp0vQUZxcnBK2An8eXcAqA4BweLgKrE
 tP2BIGFRgSSJlxemMkGUCEqcnPkEbBmnQLTEi23rwGxmATOJeZsfMkPY8hLb386BssUlbj2Z
 zzSBUWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMBo3Xbs55Yd
 jF3vgg8xCnAwKvHwOsjPjhdiTSwrrsw9xCjBwawkwut09nScEG9KYmVValF+fFFpTmrxIUZT
 oN8mMkuJJucDE0leSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbG
 qlMLd35Yc/TMwk7TC95KO2Pueim2fPCefOT02WQ3zqseVfknV9fpP1rgw2vjvfDtr8N9bh45
 HiZnj5jqpjtmXpu69USCDdOyb8cffPz4p1QoRPHfJ7aWHfl3LaZtSuu9GnX/vXx/1bftW9uC
 /ujnrLzY/ND3ujuPJ7/FldVCv+45Lbg7y/66rRJLcUaioRZzUXEiAD0krIrsAgAA
X-CMS-MailID: 20201030093823eucas1p18c63df9a5c3a4c42314bda8d13a82f1e
X-Msg-Generator: CA
X-RootMTR: 20201029153501eucas1p1ca9cc3f19eb654e645b807ecfd87f52b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201029153501eucas1p1ca9cc3f19eb654e645b807ecfd87f52b
References: <CGME20201029153501eucas1p1ca9cc3f19eb654e645b807ecfd87f52b@eucas1p1.samsung.com>
 <e86ad0f733a9fe7b209bb7c5ac58760266b97414.1603985657.git.robin.murphy@arm.com>
Cc: geert+renesas@glider.be, mripard@kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 Yu Kuai <yukuai3@huawei.com>
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

On 29.10.2020 16:34, Robin Murphy wrote:
> A common idiom for .of_xlate is to use of_find_device_by_node() to
> retrieve the relevant IOMMU instance data when translating IOMMU
> specifiers for a client device. Although it's slightly roundabout,
> this is simply looking up something we know exists - if it *were*
> to return NULL, that would mean that no platform device is associated
> with the given DT node, therefore the driver couldn't have probed
> and called iommu_device_register() with the ops that .of_xlate was
> called from in the first place. By construction, we can also assume
> that the instance data for any registered IOMMU must be valid.
>
> This isn't necessarily obvious at first glance, though, so add some
> comments to document these assumptions in-place.
>
> Suggested-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c |  7 ++++---
>   drivers/iommu/exynos-iommu.c            | 15 ++++++---------
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>   drivers/iommu/ipmmu-vmsa.c              | 13 ++++++-------
>   drivers/iommu/mtk_iommu.c               |  8 ++++----
>   drivers/iommu/rockchip-iommu.c          |  5 ++++-
>   drivers/iommu/sun50i-iommu.c            |  5 ++++-
>   6 files changed, 28 insertions(+), 25 deletions(-)
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
