Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBA7C433E0
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 21:33:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E9820756
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 21:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E9820756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A7C398741F;
	Fri, 15 May 2020 21:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a1aKzF4CK1ve; Fri, 15 May 2020 21:33:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 422DC873F0;
	Fri, 15 May 2020 21:33:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B531C0859;
	Fri, 15 May 2020 21:33:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 450FAC016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 21:33:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 35E8A8741F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 21:33:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NLt4Wpu_ZPFr for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 21:33:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B4F17873F0
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 21:33:19 +0000 (UTC)
Received: from dggemi406-hub.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 852FFDD090972E036997;
 Sat, 16 May 2020 05:33:13 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.251]) by
 dggemi406-hub.china.huawei.com ([10.3.17.144]) with mapi id 14.03.0487.000;
 Sat, 16 May 2020 05:33:06 +0800
From: Song Bao Hua <song.bao.hua@hisilicon.com>
To: "hch@lst.de" <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: Constantly map and unmap of streaming DMA buffers with IOMMU
 backend might cause serious performance problem
Thread-Topic: Constantly map and unmap of streaming DMA buffers with IOMMU
 backend might cause serious performance problem
Thread-Index: AdYqec9gnuD/5zUSTfGZehfpOCqtzP//6eGAgAArTwD//wxG4A==
Date: Fri, 15 May 2020 21:33:05 +0000
Message-ID: <B926444035E5E2439431908E3842AFD249F9F4@DGGEMI525-MBS.china.huawei.com>
References: <B926444035E5E2439431908E3842AFD249F263@DGGEMI525-MBS.china.huawei.com>
 <36d67d68-4381-c7a7-dcf1-6383bd9ae0ad@arm.com>
 <20200515144522.GA25652@lst.de>
In-Reply-To: <20200515144522.GA25652@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.78]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "davidm@hpl.hp.com" <davidm@hpl.hp.com>,
 "ralf@oss.sgi.com" <ralf@oss.sgi.com>, Linuxarm <linuxarm@huawei.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "sailer@ife.ee.ethz.ch" <sailer@ife.ee.ethz.ch>,
 "Jay.Estabrook@compaq.com" <Jay.Estabrook@compaq.com>,
 "dagum@barrel.engr.sgi.com" <dagum@barrel.engr.sgi.com>,
 "andrea@suse.de" <andrea@suse.de>, "grundler@cup.hp.com" <grundler@cup.hp.com>,
 "jens.axboe@oracle.com" <jens.axboe@oracle.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

> Subject: Re: Constantly map and unmap of streaming DMA buffers with
> IOMMU backend might cause serious performance problem
> 
> On Fri, May 15, 2020 at 01:10:21PM +0100, Robin Murphy wrote:
> >> Meanwhile, for the safety of buffers, lower-layer drivers need to make
> certain the buffers have already been unmapped in iommu before those
> buffers go back to buddy for other users.
> >
> > That sounds like it would only have benefit in a very small set of specific
> > circumstances, and would be very difficult to generalise to buffers that
> > are mapped via dma_map_page() or dma_map_single(). Furthermore, a
> > high-level API that affects a low-level driver's interpretation of
> > mid-layer API calls without the mid-layer's knowledge sounds like a hideous
> > abomination of anti-design. If a mid-layer API lends itself to inefficiency
> > at the lower level, it would seem a lot cleaner and more robust to extend
> > *that* API for stateful buffer reuse. Failing that, it might possibly be
> > appropriate to approach this at the driver level - many of the cleverer
> > network drivers already implement buffer pools to recycle mapped SKBs
> > internally, couldn't the "zip driver" simply try doing something like that
> > for itself?
> 
> Exactly.  If you upper consumer of the DMA API keeps reusing the same
> pages just map them once and use dma_sync_* to transfer ownership as
> needed.

The problem is that the lower-layer drivers don't know if upper consumer keeps reusing the same pages. They are running in different software layers.
For example, Consumer is here in mm/zswap.c
static int zswap_frontswap_store(unsigned type, pgoff_t offset,
				struct page *page)
{
	...
	/* compress */
	dst = get_cpu_var(zswap_dstmem);
	...
	ret = crypto_comp_compress(tfm, src, PAGE_SIZE, dst, &dlen);
	...
}

But the lower-layer driver is in drivers/crypto/...

Meanwhile, the lower-layer driver couldn't cache the pointers of buffer address coming from consumers to detect if the upper-layer is using the same page.
Because the same page might come from different users or come from the different stages of the same user with different permissions.
 
For example, consumer A uses the buffer as destination, then returns it to buddy, but consumer B gets the same buffer and uses it as source.

Another possibility is
Consumer A uses the buffer, returns it to buddy, after some time, it allocates a buffer again, but gets the same buffer from buddy like before.

For the safety of the buffer, lower-layer driver must guarantee the buffer is unmapped when the buffer returns to buddy.

I think only the upper-layer consumer knows if it is reusing the buffer. 

Thanks
Barry


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
