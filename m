Return-Path: <SRS0=Vrxx=HH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CFAC433DB
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 10:56:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F9D64E8C
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 10:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F9D64E8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 99AF62E127;
	Fri,  5 Feb 2021 10:56:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d3hSlY4aeIvB; Fri,  5 Feb 2021 10:56:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BC6402E123;
	Fri,  5 Feb 2021 10:56:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3230C0174;
	Fri,  5 Feb 2021 10:56:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F9E3C013A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 10:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 560C58722B
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 10:56:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mxGx93utrLc0 for <iommu@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 10:56:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C284285A83
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 10:56:39 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 41BE168B05; Fri,  5 Feb 2021 11:56:35 +0100 (CET)
Date: Fri, 5 Feb 2021 11:56:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v2] dma-mapping: benchmark: pretend DMA is transmitting
Message-ID: <20210205105634.GA7267@lst.de>
References: <20210205020035.25340-1-song.bao.hua@hisilicon.com>
 <20210205092113.GA870@lst.de>
 <e4c784d93cdd41d285bdddb650fb9471@hisilicon.com>
 <20210205103627.GB6694@lst.de>
 <0509bbb11bc547d1a8d9e85e05810b40@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0509bbb11bc547d1a8d9e85e05810b40@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Fri, Feb 05, 2021 at 10:52:37AM +0000, Song Bao Hua (Barry Song) wrote:
> I assume there is no need to keep the same size with 5.11-rc, so
> could change the struct to:
> 
> struct map_benchmark {
> 	__u64 avg_map_100ns; /* average map latency in 100ns */
> 	__u64 map_stddev; /* standard deviation of map latency */
> 	__u64 avg_unmap_100ns; /* as above */
> 	__u64 unmap_stddev;
> 	__u32 threads; /* how many threads will do map/unmap in parallel */
> 	__u32 seconds; /* how long the test will last */
> 	__s32 node; /* which numa node this benchmark will run on */
> 	__u32 dma_bits; /* DMA addressing capability */
> 	__u32 dma_dir; /* DMA data direction */
> 	__u8 expansion[84]; /* For future use */
> };
> 
> This won't increase size on 64bit system, but it increases 4bytes
> on 32bits system comparing to 5.11-rc. How do you think about it?

Yes, that sounds good.  Please send me a two patch series with the
first one changing the alignment, and the second adding the delay.
I'll send the first one off to Linus ASAP then.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
