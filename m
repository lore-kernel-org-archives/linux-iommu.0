Return-Path: <SRS0=Vrxx=HH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F29C433DB
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 10:32:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5EB64F40
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 10:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5EB64F40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9E29F2E123;
	Fri,  5 Feb 2021 10:32:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2myYz8T3l3V1; Fri,  5 Feb 2021 10:32:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 829EB2E122;
	Fri,  5 Feb 2021 10:32:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FD43C0174;
	Fri,  5 Feb 2021 10:32:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45BE2C013A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 10:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3276E871F4
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 10:32:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EqqXNuvopiNf for <iommu@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 10:32:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1F831871F2
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 10:32:29 +0000 (UTC)
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DXBWX44nRzW78d;
 Fri,  5 Feb 2021 18:30:16 +0800 (CST)
Received: from dggemi712-chm.china.huawei.com (10.3.20.111) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 5 Feb 2021 18:32:26 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi712-chm.china.huawei.com (10.3.20.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 5 Feb 2021 18:32:26 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Fri, 5 Feb 2021 18:32:26 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v2] dma-mapping: benchmark: pretend DMA is transmitting
Thread-Topic: [PATCH v2] dma-mapping: benchmark: pretend DMA is transmitting
Thread-Index: AQHW+2OBR5g3s4IewkuPPN58KPwDpapIw5uAgACOkOA=
Date: Fri, 5 Feb 2021 10:32:26 +0000
Message-ID: <e4c784d93cdd41d285bdddb650fb9471@hisilicon.com>
References: <20210205020035.25340-1-song.bao.hua@hisilicon.com>
 <20210205092113.GA870@lst.de>
In-Reply-To: <20210205092113.GA870@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.19]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Friday, February 5, 2021 10:21 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: m.szyprowski@samsung.com; hch@lst.de; robin.murphy@arm.com;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> linuxarm@openeuler.org
> Subject: Re: [PATCH v2] dma-mapping: benchmark: pretend DMA is transmitting
> 
> On Fri, Feb 05, 2021 at 03:00:35PM +1300, Barry Song wrote:
> > +	__u32 dma_trans_ns; /* time for DMA transmission in ns */
> >  	__u64 expansion[10];	/* For future use */
> 
> We need to keep the struct size, so the expansion field needs to
> shrink by the equivalent amount of data that is added in dma_trans_ns.

Unfortunately I didn't put a rsv u32 field after dma_dir
in the original patch.
There were five 32bits data before expansion[]:

struct map_benchmark {
	__u64 avg_map_100ns; /* average map latency in 100ns */
	__u64 map_stddev; /* standard deviation of map latency */
	__u64 avg_unmap_100ns; /* as above */
	__u64 unmap_stddev;
	__u32 threads; /* how many threads will do map/unmap in parallel */
	__u32 seconds; /* how long the test will last */
	__s32 node; /* which numa node this benchmark will run on */
	__u32 dma_bits; /* DMA addressing capability */
	__u32 dma_dir; /* DMA data direction */
	__u64 expansion[10];	/* For future use */
};

My bad. That was really silly. I should have done the below from
the first beginning:
struct map_benchmark {
	__u64 avg_map_100ns; /* average map latency in 100ns */
	__u64 map_stddev; /* standard deviation of map latency */
	__u64 avg_unmap_100ns; /* as above */
	__u64 unmap_stddev;
	__u32 threads; /* how many threads will do map/unmap in parallel */
	__u32 seconds; /* how long the test will last */
	__s32 node; /* which numa node this benchmark will run on */
	__u32 dma_bits; /* DMA addressing capability */
	__u32 dma_dir; /* DMA data direction */
	__u32 rsv;
	__u64 expansion[10];	/* For future use */
};

So on 64bit system, this patch doesn't change the length of struct
as the new added u32 just fill the gap between dma_dir and expansion.

For 32bit system, this patch increases 4 bytes in the length.

I can keep the struct size unchanged by changing the struct to

struct map_benchmark {
	__u64 avg_map_100ns; /* average map latency in 100ns */
	__u64 map_stddev; /* standard deviation of map latency */
	__u64 avg_unmap_100ns; /* as above */
	__u64 unmap_stddev;
	__u32 threads; /* how many threads will do map/unmap in parallel */
	__u32 seconds; /* how long the test will last */
	__s32 node; /* which numa node this benchmark will run on */
	__u32 dma_bits; /* DMA addressing capability */
	__u32 dma_dir; /* DMA data direction */
	__u32 dma_trans_ns; /* time for DMA transmission in ns */

	__u32 exp; /* For future use */
	__u64 expansion[9];	/* For future use */
};

But the code is really ugly now.

Thanks
Barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
