Return-Path: <SRS0=Joyy=FR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B851C4361B
	for <iommu@archiver.kernel.org>; Sun, 13 Dec 2020 21:27:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7C023359
	for <iommu@archiver.kernel.org>; Sun, 13 Dec 2020 21:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7C023359
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D6FE620396;
	Sun, 13 Dec 2020 21:27:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ywb6dU4RAyB4; Sun, 13 Dec 2020 21:27:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B093120378;
	Sun, 13 Dec 2020 21:27:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9532AC0893;
	Sun, 13 Dec 2020 21:27:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BCE2C013B
 for <iommu@lists.linux-foundation.org>; Sun, 13 Dec 2020 21:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 70FAD20390
 for <iommu@lists.linux-foundation.org>; Sun, 13 Dec 2020 21:27:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vnRpRqN716Yu for <iommu@lists.linux-foundation.org>;
 Sun, 13 Dec 2020 21:27:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by silver.osuosl.org (Postfix) with ESMTPS id 7053220378
 for <iommu@lists.linux-foundation.org>; Sun, 13 Dec 2020 21:27:23 +0000 (UTC)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CvHf04pRKzXmyg;
 Mon, 14 Dec 2020 05:26:48 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 14 Dec 2020 05:27:19 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 14 Dec 2020 05:27:19 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.002;
 Mon, 14 Dec 2020 05:27:19 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>
Subject: RE: [PATCH v2] dma-mapping: add unlikely hint for error path in
 dma_mapping_error
Thread-Topic: [PATCH v2] dma-mapping: add unlikely hint for error path in
 dma_mapping_error
Thread-Index: AQHW0W2iIa3g+8k+H0GczkNg20i1Mqn1hbAg
Date: Sun, 13 Dec 2020 21:27:19 +0000
Message-ID: <93ac85090ffa4313a7dc87a38d1f6aa1@hisilicon.com>
References: <39581f9a-0066-ad98-094d-d41082145e23@gmail.com>
In-Reply-To: <39581f9a-0066-ad98-094d-d41082145e23@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.9]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
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



> -----Original Message-----
> From: Heiner Kallweit [mailto:hkallweit1@gmail.com]
> Sent: Monday, December 14, 2020 5:33 AM
> To: Christoph Hellwig <hch@lst.de>; Marek Szyprowski
> <m.szyprowski@samsung.com>; Robin Murphy <robin.murphy@arm.com>; Song Bao Hua
> (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: open list:AMD IOMMU (AMD-VI) <iommu@lists.linux-foundation.org>; Linux
> Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: [PATCH v2] dma-mapping: add unlikely hint for error path in
> dma_mapping_error
> 
> Zillions of drivers use the unlikely() hint when checking the result of
> dma_mapping_error(). This is an inline function anyway, so we can move
> the hint into this function and remove it from drivers.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

not sure if this is really necessary. It seems the original code
is more readable. Readers can more easily understand we are
predicting the branch based on the return value of
dma_mapping_error().

Anyway, I don't object to this one. if other people like it, I am
also ok with it.

> ---
> v2:
> Split the big patch into the change for dma-mapping.h and follow-up
> patches per subsystem that will go through the trees of the respective
> maintainers.
> ---
>  include/linux/dma-mapping.h | 2 +-
>  kernel/dma/map_benchmark.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 2e49996a8..6177e20b5 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -95,7 +95,7 @@ static inline int dma_mapping_error(struct device *dev,
> dma_addr_t dma_addr)
>  {
>  	debug_dma_mapping_error(dev, dma_addr);
> 
> -	if (dma_addr == DMA_MAPPING_ERROR)
> +	if (unlikely(dma_addr == DMA_MAPPING_ERROR))
>  		return -ENOMEM;
>  	return 0;
>  }
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index b1496e744..901420a5d 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -78,7 +78,7 @@ static int map_benchmark_thread(void *data)
> 
>  		map_stime = ktime_get();
>  		dma_addr = dma_map_single(map->dev, buf, PAGE_SIZE, map->dir);
> -		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
> +		if (dma_mapping_error(map->dev, dma_addr)) {
>  			pr_err("dma_map_single failed on %s\n",
>  				dev_name(map->dev));
>  			ret = -ENOMEM;
> --
> 2.29.2

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
