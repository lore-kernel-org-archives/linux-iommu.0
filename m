Return-Path: <SRS0=hwFB=ER=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A82C56201
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 09:42:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FDE20756
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 09:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FDE20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 190EA867E3;
	Wed, 11 Nov 2020 09:42:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bjYo0CrqtPfr; Wed, 11 Nov 2020 09:42:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C8B778328C;
	Wed, 11 Nov 2020 09:42:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD8DFC0889;
	Wed, 11 Nov 2020 09:42:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD38CC016F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 09:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AC11E86360
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 09:42:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oE9KEBbBcmw3 for <iommu@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 09:42:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C8D308621E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 09:42:48 +0000 (UTC)
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CWKX06cr2zVmv9;
 Wed, 11 Nov 2020 17:42:24 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 11 Nov 2020 17:42:42 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Wed, 11 Nov 2020 17:42:42 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: John Garry <john.garry@huawei.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>
Subject: RE: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
Thread-Topic: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
Thread-Index: AQHWsO+tiT3rvc8AvUKektYgWKvLn6nBDT6Q//+EgQCAAZyYMIAABiqAgACFcyA=
Date: Wed, 11 Nov 2020 09:42:42 +0000
Message-ID: <fe3cda84536849dea5cc48fe050a1cbe@hisilicon.com>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
 <20201102080646.2180-2-song.bao.hua@hisilicon.com>
 <eb317e5050b944c3aec97c5fb64a74cb@hisilicon.com>
 <0658ee16-d539-61c5-1d39-77d50f559803@huawei.com>
 <88e91063b7f041bda7d147438f1c4621@hisilicon.com>
 <51f0c148-e2e3-e084-4021-ec5883919436@huawei.com>
In-Reply-To: <51f0c148-e2e3-e084-4021-ec5883919436@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.81]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Will
 Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Shuah Khan <shuah@kernel.org>
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
> From: John Garry
> Sent: Wednesday, November 11, 2020 10:37 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> iommu@lists.linux-foundation.org; hch@lst.de; robin.murphy@arm.com;
> m.szyprowski@samsung.com
> Cc: linux-kselftest@vger.kernel.org; Will Deacon <will@kernel.org>; Joerg
> Roedel <joro@8bytes.org>; Linuxarm <linuxarm@huawei.com>; xuwei (O)
> <xuwei5@huawei.com>; Shuah Khan <shuah@kernel.org>
> Subject: Re: [PATCH v3 1/2] dma-mapping: add benchmark support for
> streaming DMA APIs
> 
> On 11/11/2020 01:29, Song Bao Hua (Barry Song) wrote:
> > I'd like to think checking this here would be overdesign. We just give users the
> > freedom to bind any device they care about to the benchmark driver. Usually
> > that means a real hardware either behind an IOMMU or through a direct
> > mapping.
> >
> > if for any reason users put a wrong "device", that is the choice of users.
> 
> Right, but if the device simply has no DMA ops supported, it could be
> better to fail the probe rather than let them try the test at all.
> 
>   Anyhow,
> > the below code will still handle it properly and users will get a report in which
> > everything is zero.
> >
> > +static int map_benchmark_thread(void *data)
> > +{
> > ...
> > +		dma_addr = dma_map_single(map->dev, buf, PAGE_SIZE,
> DMA_BIDIRECTIONAL);
> > +		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
> 
> Doing this is proper, but I am not sure if this tells the user the real
> problem.

Telling users the real problem isn't the design intention of this test
benchmark. It is never the purpose of this benchmark.

> 
> > +			pr_err("dma_map_single failed on %s\n",
> dev_name(map->dev));
> 
> Not sure why use pr_err() over dev_err().

We are reporting errors in dma-benchmark driver rather than reporting errors
in the driver of the specific device. I think we should have "dma-benchmark"
as the prefix while printing the name of the device by dev_name().

> 
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> 
> Thanks,
> John

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
