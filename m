Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA120C433DF
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 14:45:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9731220671
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 14:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9731220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D75F89B13;
	Fri, 15 May 2020 14:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N3FEMwvE-HSS; Fri, 15 May 2020 14:45:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9E1BF89B5F;
	Fri, 15 May 2020 14:45:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DC2AC0178;
	Fri, 15 May 2020 14:45:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2930C016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 14:45:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B3C73875D4
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 14:45:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SzD3K7yEzPn8 for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 14:45:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 533E38745D
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 14:45:29 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9060968BFE; Fri, 15 May 2020 16:45:22 +0200 (CEST)
Date: Fri, 15 May 2020 16:45:22 +0200
From: "hch@lst.de" <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: Constantly map and unmap of streaming DMA buffers with IOMMU
 backend might cause serious performance problem
Message-ID: <20200515144522.GA25652@lst.de>
References: <B926444035E5E2439431908E3842AFD249F263@DGGEMI525-MBS.china.huawei.com>
 <36d67d68-4381-c7a7-dcf1-6383bd9ae0ad@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <36d67d68-4381-c7a7-dcf1-6383bd9ae0ad@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "davidm@hpl.hp.com" <davidm@hpl.hp.com>,
 "ralf@oss.sgi.com" <ralf@oss.sgi.com>, Linuxarm <linuxarm@huawei.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "sailer@ife.ee.ethz.ch" <sailer@ife.ee.ethz.ch>,
 "Jay.Estabrook@compaq.com" <Jay.Estabrook@compaq.com>,
 "dagum@barrel.engr.sgi.com" <dagum@barrel.engr.sgi.com>,
 "andrea@suse.de" <andrea@suse.de>, "grundler@cup.hp.com" <grundler@cup.hp.com>,
 "jens.axboe@oracle.com" <jens.axboe@oracle.com>, "hch@lst.de" <hch@lst.de>,
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

On Fri, May 15, 2020 at 01:10:21PM +0100, Robin Murphy wrote:
>> Meanwhile, for the safety of buffers, lower-layer drivers need to make certain the buffers have already been unmapped in iommu before those buffers go back to buddy for other users.
>
> That sounds like it would only have benefit in a very small set of specific 
> circumstances, and would be very difficult to generalise to buffers that 
> are mapped via dma_map_page() or dma_map_single(). Furthermore, a 
> high-level API that affects a low-level driver's interpretation of 
> mid-layer API calls without the mid-layer's knowledge sounds like a hideous 
> abomination of anti-design. If a mid-layer API lends itself to inefficiency 
> at the lower level, it would seem a lot cleaner and more robust to extend 
> *that* API for stateful buffer reuse. Failing that, it might possibly be 
> appropriate to approach this at the driver level - many of the cleverer 
> network drivers already implement buffer pools to recycle mapped SKBs 
> internally, couldn't the "zip driver" simply try doing something like that 
> for itself?

Exactly.  If you upper consumer of the DMA API keeps reusing the same
pages just map them once and use dma_sync_* to transfer ownership as
needed.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
