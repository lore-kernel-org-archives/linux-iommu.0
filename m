Return-Path: <SRS0=8b8q=EV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF9EC55ABD
	for <iommu@archiver.kernel.org>; Sun, 15 Nov 2020 21:54:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A85002242E
	for <iommu@archiver.kernel.org>; Sun, 15 Nov 2020 21:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85002242E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5D49D871F1;
	Sun, 15 Nov 2020 21:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BxIWYB5NwghG; Sun, 15 Nov 2020 21:54:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0B5EE871E6;
	Sun, 15 Nov 2020 21:54:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF13DC0800;
	Sun, 15 Nov 2020 21:54:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91BB1C07FF
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 21:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8045485F9B
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 21:54:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rnkBTUrIetWR for <iommu@lists.linux-foundation.org>;
 Sun, 15 Nov 2020 21:54:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B471D85F95
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 21:54:49 +0000 (UTC)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4CZ5Zk1rpTz13QFJ;
 Mon, 16 Nov 2020 05:54:22 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 16 Nov 2020 05:54:45 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Mon, 16 Nov 2020 05:54:45 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
Thread-Topic: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
Thread-Index: AQHWuqaxiT3rvc8AvUKektYgWKvLn6nIS8nQgAAQE4CAAVfXkA==
Date: Sun, 15 Nov 2020 21:54:45 +0000
Message-ID: <cb7a42bd21f8488f861ebfd7fa46cef6@hisilicon.com>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
 <20201102080646.2180-2-song.bao.hua@hisilicon.com>
 <20201114165336.GA24844@lst.de>
 <5c4488dd28fc4869b7e67dd842ffa208@hisilicon.com>
 <20201115084515.GA18411@lst.de>
In-Reply-To: <20201115084515.GA18411@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.73]
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
> Sent: Sunday, November 15, 2020 9:45 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Christoph Hellwig <hch@lst.de>; iommu@lists.linux-foundation.org;
> robin.murphy@arm.com; m.szyprowski@samsung.com; Linuxarm
> <linuxarm@huawei.com>; linux-kselftest@vger.kernel.org; xuwei (O)
> <xuwei5@huawei.com>; Joerg Roedel <joro@8bytes.org>; Will Deacon
> <will@kernel.org>; Shuah Khan <shuah@kernel.org>
> Subject: Re: [PATCH v3 1/2] dma-mapping: add benchmark support for
> streaming DMA APIs
> 
> On Sun, Nov 15, 2020 at 12:11:15AM +0000, Song Bao Hua (Barry Song)
> wrote:
> >
> > Checkpatch has changed 80 to 100. That's probably why my local checkpatch
> didn't report any warning:
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=
> bdc48fa11e46f867ea4d
> >
> > I am happy to change them to be less than 80 if you like.
> 
> Don't rely on checkpath, is is broken.  Look at the codingstyle document.
> 
> > > I think this needs to set a dma mask as behavior for unlimited dma
> > > mask vs the default 32-bit one can be very different.
> >
> > I actually prefer users bind real devices with real dma_mask to test rather
> than force to change
> > the dma_mask in this benchmark.
> 
> The mask is set by the driver, not the device.  So you need to set when
> when you bind, real device or not.

Yep while it is a little bit tricky.

Sometimes, it is done by "device" in architectures, e.g. there are lots of
dma_mask configuration code in arch/arm/mach-xxx.
arch/arm/mach-davinci/da850.c
static u64 da850_vpif_dma_mask = DMA_BIT_MASK(32);
static struct platform_device da850_vpif_dev = {
	.name		= "vpif",
	.id		= -1,
	.dev		= {
		.dma_mask		= &da850_vpif_dma_mask,
		.coherent_dma_mask	= DMA_BIT_MASK(32),
	},
	.resource	= da850_vpif_resource,
	.num_resources	= ARRAY_SIZE(da850_vpif_resource),
};

Sometimes, it is done by "of" or "acpi", for example:
drivers/acpi/arm64/iort.c
void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
{
	u64 end, mask, dmaaddr = 0, size = 0, offset = 0;
	int ret;

	...

	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
	if (!ret) {
		/*
		 * Limit coherent and dma mask based on size retrieved from
		 * firmware.
		 */
		end = dmaaddr + size - 1;
		mask = DMA_BIT_MASK(ilog2(end) + 1);
		dev->bus_dma_limit = end;
		dev->coherent_dma_mask = mask;
		*dev->dma_mask = mask;
	}
	...
}

Sometimes, it is done by "bus", for example, ISA:
		isa_dev->dev.coherent_dma_mask = DMA_BIT_MASK(24);
		isa_dev->dev.dma_mask = &isa_dev->dev.coherent_dma_mask;

		error = device_register(&isa_dev->dev);
		if (error) {
			put_device(&isa_dev->dev);
			break;
		}

And in many cases, it is done by driver. On the ARM64 server platform I am testing,
actually rarely drivers set dma_mask.

So to make the dma benchmark work on all platforms, it seems it is worth
to add a dma_mask_bit parameter. But, in order to avoid breaking the
dma_mask of those devices whose dma_mask are set by architectures, 
acpi and bus, it seems we need to do the below in dma_benchmark:

u64 old_mask;

old_mask = dma_get_mask(dev);

dma_set_mask(dev, &new_mask);

do_map_benchmark();

/* restore old dma_mask so that the dma_mask of the device is not changed due to
benchmark when it is bound back to its original driver */
dma_set_mask(dev, &old_mask);

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
