Return-Path: <SRS0=TI1w=FX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A1CC4361B
	for <iommu@archiver.kernel.org>; Sat, 19 Dec 2020 03:15:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A0342343F
	for <iommu@archiver.kernel.org>; Sat, 19 Dec 2020 03:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0342343F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B5115203D7;
	Sat, 19 Dec 2020 03:15:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MQUk7wTdedFm; Sat, 19 Dec 2020 03:15:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8FA922010A;
	Sat, 19 Dec 2020 03:15:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77039C1786;
	Sat, 19 Dec 2020 03:15:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34ACCC0893
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 03:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2F9FC87C46
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 03:15:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iJT3BcB-RTqK for <iommu@lists.linux-foundation.org>;
 Sat, 19 Dec 2020 03:15:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4D8F487C45
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 03:15:49 +0000 (UTC)
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CyW7c4LwGzXnKV;
 Sat, 19 Dec 2020 11:15:08 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sat, 19 Dec 2020 11:15:44 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 19 Dec 2020 11:15:43 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.002;
 Sat, 19 Dec 2020 11:15:43 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Subject: RE: [PATCH] dma-mapping: benchmark: check the validity of dma mask
 bits
Thread-Topic: [PATCH] dma-mapping: benchmark: check the validity of dma mask
 bits
Thread-Index: AQHW0HDVh4iTRa5jK0air341E8a6GKn8qv8AgAEbp3A=
Date: Sat, 19 Dec 2020 03:15:43 +0000
Message-ID: <a3b5a9bd3c444382a0a5e845d59ab031@hisilicon.com>
References: <20201212101844.23612-1-song.bao.hua@hisilicon.com>
 <69d8ff1a-8993-758f-1aec-e133024cf0b7@arm.com>
In-Reply-To: <69d8ff1a-8993-758f-1aec-e133024cf0b7@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.238]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Linuxarm <linuxarm@huawei.com>, Dan Carpenter <dan.carpenter@oracle.com>
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
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: Saturday, December 19, 2020 7:10 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; hch@lst.de;
> m.szyprowski@samsung.com
> Cc: iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>; Dan
> Carpenter <dan.carpenter@oracle.com>
> Subject: Re: [PATCH] dma-mapping: benchmark: check the validity of dma mask
> bits
> 
> On 2020-12-12 10:18, Barry Song wrote:
> > While dma_mask_bits is larger than 64, the bahvaiour is undefined. On the
> > other hand, dma_mask_bits which is smaller than 20 (1MB) makes no sense
> > in real hardware.
> >
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >   kernel/dma/map_benchmark.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> > index b1496e744c68..19f661692073 100644
> > --- a/kernel/dma/map_benchmark.c
> > +++ b/kernel/dma/map_benchmark.c
> > @@ -214,6 +214,12 @@ static long map_benchmark_ioctl(struct file *file,
> unsigned int cmd,
> >   			return -EINVAL;
> >   		}
> >
> > +		if (map->bparam.dma_bits < 20 ||
> 
> FWIW I don't think we need to bother with a lower limit here - it's
> unsigned, and a pointlessly small value will fail gracefully when we
> come to actually set the mask anyway. We only need to protect kernel
> code from going wrong, not userspace from being stupid to its own detriment.

I am not sure if kernel driver can reject small dma mask bit if drivers
don't handle it properly.
As a month ago, when I was debugging dma map benchmark, I set a value
less than 32 to devices behind arm-smmu-v3, it could always succeed.
But dma_map_single() was always failing.
At that time, I didn't debug this issue. Not sure the latest status of
iommu driver.

drivers/iommu/intel/iommu.c used to have a dma_supported() to reject
small dma_mask:
static const struct dma_map_ops bounce_dma_ops = {
	...
	.dma_supported		= dma_direct_supported,
};


> 
> Robin.
> 
> > +		    map->bparam.dma_bits > 64) {
> > +			pr_err("invalid dma_bits\n");
> > +			return -EINVAL;
> > +		}
> > +
> >   		if (map->bparam.node != NUMA_NO_NODE &&
> >   		    !node_possible(map->bparam.node)) {
> >   			pr_err("invalid numa node\n");
> >

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
