Return-Path: <SRS0=8b8q=EV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB85C63699
	for <iommu@archiver.kernel.org>; Sun, 15 Nov 2020 00:11:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B91F2415A
	for <iommu@archiver.kernel.org>; Sun, 15 Nov 2020 00:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B91F2415A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 11B9787327;
	Sun, 15 Nov 2020 00:11:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RHQjo9LbWFSH; Sun, 15 Nov 2020 00:11:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DF2F187324;
	Sun, 15 Nov 2020 00:11:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF367C088E;
	Sun, 15 Nov 2020 00:11:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CCC4C0800
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 00:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 60CA786D53
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 00:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fwGq5pWYa8WN for <iommu@lists.linux-foundation.org>;
 Sun, 15 Nov 2020 00:11:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 990E386D4E
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 00:11:19 +0000 (UTC)
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CYXfw0Rmtz52lf;
 Sun, 15 Nov 2020 08:11:04 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sun, 15 Nov 2020 08:11:15 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Sun, 15 Nov 2020 08:11:15 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
Thread-Topic: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
Thread-Index: AQHWuqaxiT3rvc8AvUKektYgWKvLn6nIS8nQ
Date: Sun, 15 Nov 2020 00:11:15 +0000
Message-ID: <5c4488dd28fc4869b7e67dd842ffa208@hisilicon.com>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
 <20201102080646.2180-2-song.bao.hua@hisilicon.com>
 <20201114165336.GA24844@lst.de>
In-Reply-To: <20201114165336.GA24844@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.148]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Shuah Khan <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "xuwei
 \(O\)" <xuwei5@huawei.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>
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
> Sent: Sunday, November 15, 2020 5:54 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: iommu@lists.linux-foundation.org; hch@lst.de; robin.murphy@arm.com;
> m.szyprowski@samsung.com; Linuxarm <linuxarm@huawei.com>;
> linux-kselftest@vger.kernel.org; xuwei (O) <xuwei5@huawei.com>; Joerg
> Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Shuah Khan
> <shuah@kernel.org>
> Subject: Re: [PATCH v3 1/2] dma-mapping: add benchmark support for
> streaming DMA APIs
> 
> Lots of > 80 char lines.  Please fix up the style.

Checkpatch has changed 80 to 100. That's probably why my local checkpatch didn't report any warning:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d

I am happy to change them to be less than 80 if you like.

> 
> I think this needs to set a dma mask as behavior for unlimited dma
> mask vs the default 32-bit one can be very different. 

I actually prefer users bind real devices with real dma_mask to test rather than force to change
the dma_mask in this benchmark.

Some device might have 32bit dma_mask while some others might have unlimited. But both of
them can bind to this driver or unbind from it after the test is done. So users just need to bind
those different real devices with different real dma_mask to dma_benchmark.

This can reflect the real performance of the real device better, I think.

> I also think you need to be able to pass the direction or have different tests
> for directions.  bidirectional is not exactly heavily used and pays
> more cache management penality.

For this, I'd like to increase a direction option in the test app and pass the option to the benchmark
driver.

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
