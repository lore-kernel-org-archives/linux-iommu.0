Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53310C4338F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 20:46:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0CC661002
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 20:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0CC661002
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DAC140275;
	Mon,  9 Aug 2021 20:46:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VGRSEcbuDFmb; Mon,  9 Aug 2021 20:46:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 37B5B4020E;
	Mon,  9 Aug 2021 20:46:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A474C0010;
	Mon,  9 Aug 2021 20:46:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0002C000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 20:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C49C54020E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 20:46:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="QQskr6fY";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="f/NIoDm2"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T92YBy17D_L8 for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 20:46:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4134B400E5
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 20:46:14 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id F09095C01A1;
 Mon,  9 Aug 2021 16:46:12 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Mon, 09 Aug 2021 16:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=1/VjXgCRC6+q3zzEKgB7gy0Xhwek
 RoHaQ8AappivcG4=; b=QQskr6fYCEOoTjwXgN37+CxOvYoF8XM6/8d/sb8TGcUt
 o1edM2Ivgq/2F9Ct8Z8wkbRJOow1LNd6Sfa3TY/zSYjvWogEun/I/cs7GRdeP36+
 zEGgmys0b6Oc+jo9teMcsrvh59zepNIMXcBfzSYIZJPmU6572In18orod3/wGbcm
 rJiUe+5Rb/m2NNHCLWkh7ajIYC+Lxx/LmAemubZAbo+yTM8/qR4XLDKj2tbkzjYa
 xaeHyIrBtnxQMeEfxfcOjtxkCjUtkQR+RUwHf321zV2lzBPwFkoDWikTAMNRgSDy
 wtMsl1PPiA0PTQX1lY17SrNJ87OtFGXip4ngnmhW2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=1/VjXg
 CRC6+q3zzEKgB7gy0XhwekRoHaQ8AappivcG4=; b=f/NIoDm2ZE7VsPI8/RDth/
 CbmKm8usFDpAPQrh9bkRKwOqKCCLmZ6nXjvB6e2RpTyvFZse2C5TYXl9PQOpbpZx
 MA9gx8dZr5Xh9Xn3qEnyIuigOHEhJVKzCvxSt9op+/WH8JonZhTvhhI2IZxajPn2
 IHvGbD4JmuhqJ+xolm20GFtarK4hgw6CgK3rWZSHEPvOU34FU+BLRMq3siIxjWYr
 dfcyMinUeBR1dS826RcLi7dR2tn3XDkdjDtWMu8ZRanWP/zcX9XAEF1B/E2gDaoY
 0C7U0Cqgj8JyUbzDd3uLEPBrjFucCx+J6vJpVYjtRwYyXW+gvSNcSAL0Ft0CW68g
 ==
X-ME-Sender: <xms:E5QRYaaEF3FujFElFNm848ASR1GBL9KuT8pyhgd_IdLhjd-i6fDMDQ>
 <xme:E5QRYda6Ls1zr2gF224x53ZYPq1Z701rJ5JJNUtTN4rIqZiJzaKM0QH9wV7gtYu8_
 FXAzIKJfgQAZxtZYrE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeejgdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdfuvhgv
 nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
 htthgvrhhnpeehjefgtddtfeelfeetjeeifeduueehleektdegtdejheeiteeuleehuefh
 geehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:E5QRYU8paiGgfiMtZHbA8JuNCDNkHoQo06C209s53L7_RZ-WRxtXgw>
 <xmx:E5QRYcr8B3cD0xjPB3fxGRq2vfXh9xNsvRFdiUmLEVmMEB2a_OjmAg>
 <xmx:E5QRYVri_02IipEL2N8lgKXtIZEZeWVwe6eFpBuWukyaLgPBLtrI_Q>
 <xmx:FJQRYeDzsruhv6QiOjibN9_Vhx9p9qPIXBQqnRDll-0m2T8bgrnSEg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D092151C0060; Mon,  9 Aug 2021 16:46:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-552-g2afffd2709-fm-20210805.001-g2afffd27
Mime-Version: 1.0
Message-Id: <cf78f795-1e75-45c9-a759-018f17cfaed9@www.fastmail.com>
In-Reply-To: <5002ed91-416c-d7ee-b1ab-a50c590749c2@arm.com>
References: <20210806155523.50429-1-sven@svenpeter.dev>
 <20210806155523.50429-3-sven@svenpeter.dev>
 <d289a555-9e3b-b948-1883-2ee4c915da4c@arm.com>
 <dadbd8b0-171a-4008-8a2e-f68abfed9285@www.fastmail.com>
 <5002ed91-416c-d7ee-b1ab-a50c590749c2@arm.com>
Date: Mon, 09 Aug 2021 22:45:15 +0200
To: "Robin Murphy" <robin.murphy@arm.com>,
 "Sven Peter" <iommu@lists.linux-foundation.org>
Subject: =?UTF-8?Q?Re:_[RFC_PATCH_2/3]_iommu/dma-iommu:_Support_iovad->granule_>_?=
 =?UTF-8?Q?PAGE=5FSIZE?=
Cc: Arnd Bergmann <arnd@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Will Deacon <will@kernel.org>
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On Mon, Aug 9, 2021, at 19:41, Robin Murphy wrote:
> On 2021-08-07 12:47, Sven Peter via iommu wrote:
> > 
> > 
> > On Fri, Aug 6, 2021, at 20:04, Robin Murphy wrote:
> >> On 2021-08-06 16:55, Sven Peter via iommu wrote:
> >>> @@ -1006,6 +1019,31 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> >>>    	if (dev_is_untrusted(dev))
> >>>    		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
> >>>    
> >>> +	/*
> >>> +	 * If the IOMMU pagesize is larger than the CPU pagesize we will
> >>> +	 * very likely run into sgs with a physical address that is not aligned
> >>> +	 * to an IOMMU page boundary. Fall back to just mapping every entry
> >>> +	 * independently with __iommu_dma_map then.
> >>
> >> Scatterlist segments often don't have nicely aligned ends, which is why
> >> we already align things to IOVA granules in main loop here. I think in
> >> principle we'd just need to move the non-IOVA-aligned part of the
> >> address from sg->page to sg->offset in the temporary transformation for
> >> the rest of the assumptions to hold. I don't blame you for being timid
> >> about touching that, though - it took me 3 tries to get right when I
> >> first wrote it...
> >>
> > 
> > 
> > I've spent some time with that code now and I think we cannot use it
> > but have to fall back to iommu_dma_map_sg_swiotlb (even though that swiotlb
> > part is a lie then):
> > 
> > When we have sg_phys(s) = 0x802e65000 with s->offset = 0 the paddr
> > is aligned to PAGE_SIZE but has an offset of 0x1000 from something
> > the IOMMU can map.
> > Now this would result in s->offset = -0x1000 which is already weird
> > enough.
> > Offset is unsigned (and 32bit) so this will actually look like
> > s->offset = 0xfffff000 then, which isn't much better.
> > And then sg_phys(s) = 0x902e64000 (instead of 0x802e64000) and
> > we'll map some random memory in iommu_map_sg_atomic and a little bit later
> > everything explodes.
> > 
> > Now I could probably adjust the phys addr backwards and make sure offset is
> > always positive (and possibly larger than PAGE_SIZE) and later restore it
> > in __finalise_sg then but I feel like that's pushing this a little bit too far.
> 
> Yes, that's what I meant. At a quick guess, something like the
> completely untested diff below.

That unfortunately results in unaligned mappings

[    9.630334] iommu: unaligned: iova 0xbff40000 pa 0x0000000801a3b000 size 0x4000 min_pagesz 0x4000

I'll take a closer look later this week and see if I can fix it.

> It really comes down to what we want to
> achieve here - if it's just to make this thing work at all, then I'd
> favour bolting on the absolute minimum changes, possibly even cheating
> by tainting the kernel and saying all bets are off instead of trying to
> handle the more involved corners really properly. However if you want to
> work towards this being a properly-supported thing, then I think it's
> worth generalising the existing assumptions of page alignment from the
> beginning.

I'd like to try and see if we can make this a properly-supported thing.

That will likely take a few iterations but realistically the rest of the drivers
required to make this platform actually useful (and especially the display controller
and GPU drivers) won't be ready for a few more months anyway. And even on 4KB PAGE_SIZE
kernels half the USB ports and NVMe will work fine, which should be enough to install
a distro and some third-party package that just ships the distro kernel with 16KB
pages.




Sven

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
