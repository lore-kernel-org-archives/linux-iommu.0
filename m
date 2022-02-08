Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789FFC433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 09:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 282C3401F8;
	Tue,  8 Feb 2022 09:22:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YxXzlO4287Do; Tue,  8 Feb 2022 09:22:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A6F2A400D1;
	Tue,  8 Feb 2022 09:22:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6161EC0011;
	Tue,  8 Feb 2022 09:22:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94C49C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 09:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 732E881AF3
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 09:22:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XBm6qiuRc_pJ for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 09:22:36 +0000 (UTC)
X-Greylist: delayed 00:18:36 by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5189281AEF
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 09:22:35 +0000 (UTC)
Received: from dggeme707-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JtH6Q1xHLzdZVv;
 Tue,  8 Feb 2022 17:00:46 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggeme707-chm.china.huawei.com (10.1.199.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 8 Feb 2022 17:03:56 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2308.021;
 Tue, 8 Feb 2022 17:03:56 +0800
To: "chenxiang (M)" <chenxiang66@hisilicon.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>
Subject: RE: [PATCH] MAINTAINERS: Update maintainer list of DMA MAPPING
 BENCHMARK
Thread-Topic: [PATCH] MAINTAINERS: Update maintainer list of DMA MAPPING
 BENCHMARK
Thread-Index: AQHYHLrvrY3eKSxYwEOdonQA5mzelKyJWKQg
Date: Tue, 8 Feb 2022 09:03:56 +0000
Message-ID: <2f855d6e368a49bc965ca5c3188d35a8@hisilicon.com>
References: <1644303891-81063-1-git-send-email-chenxiang66@hisilicon.com>
In-Reply-To: <1644303891-81063-1-git-send-email-chenxiang66@hisilicon.com>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.61]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>
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
From: "Song Bao Hua \(Barry Song\) via iommu"
 <iommu@lists.linux-foundation.org>
Reply-To: "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: chenxiang (M)
> Sent: Tuesday, February 8, 2022 8:05 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; hch@lst.de;
> m.szyprowski@samsung.com; robin.murphy@arm.com
> Cc: linuxarm@openeuler.org; Linuxarm <linuxarm@huawei.com>;
> iommu@lists.linux-foundation.org; linux-kselftest@vger.kernel.org;
> chenxiang (M) <chenxiang66@hisilicon.com>
> Subject: [PATCH] MAINTAINERS: Update maintainer list of DMA MAPPING BENCHMARK
> 
> From: Xiang Chen <chenxiang66@hisilicon.com>
> 
> Barry Song will not focus on this area, and Xiang Chen will continue his
> work to maintain this module.
> 
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>

Acked-by: Barry Song <song.bao.hua@hisilicon.com>

Xiang has been an user of this module and has made substantial
contributions not only to this module and but also to related
modules such as iommu/arm-smmu-v3.
My this email account will be unreachable in this month. And
probably I will rarely work on this module afterwards. So I
am happy Xiang will take care of it. Thanks!

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..48335022b0e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5765,7 +5765,7 @@ F:	include/linux/dma-map-ops.h
>  F:	kernel/dma/
> 
>  DMA MAPPING BENCHMARK
> -M:	Barry Song <song.bao.hua@hisilicon.com>
> +M:	Xiang Chen <chenxiang66@hisilicon.com>
>  L:	iommu@lists.linux-foundation.org
>  F:	kernel/dma/map_benchmark.c
>  F:	tools/testing/selftests/dma/
> --
> 2.33.0

Best Regards,
Barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
