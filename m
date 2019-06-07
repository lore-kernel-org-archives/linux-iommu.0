Return-Path: <SRS0=pxo5=UG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B0DC2BCA1
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 05:50:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9AD7208C0
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 05:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AD7208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 68BB6E1F;
	Fri,  7 Jun 2019 05:50:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7F5CEB4B
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 05:50:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DF6EBA9
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 05:50:00 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 78FD368C4E; Fri,  7 Jun 2019 07:49:33 +0200 (CEST)
Date: Fri, 7 Jun 2019 07:49:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Message-ID: <20190607054933.GA8267@lst.de>
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<7dfeb7d8-b777-b4af-d892-2829cd05241b@arm.com>
	<20190605123808.GA12529@lst.de>
	<OSAPR01MB3089448A3D44BE61B127AA73D8170@OSAPR01MB3089.jpnprd01.prod.outlook.com>
	<20190606070059.GI27033@lst.de>
	<OSAPR01MB3089E3E79B0BDF24610FBEC2D8100@OSAPR01MB3089.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OSAPR01MB3089E3E79B0BDF24610FBEC2D8100@OSAPR01MB3089.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Jun 07, 2019 at 05:41:56AM +0000, Yoshihiro Shimoda wrote:
> > bool blk_can_use_iommu_merging(struct request_queue *q, struct device *dev)
> > {
> > 	if (!IOMMU_CAN_MERGE_SEGMENTS(dev))
> > 		return false;
> 
> As Robin mentioned, all IOMMUs can merge segments so that we don't need
> this condition, IIUC. However, this should check whether the device is mapped
> on iommu by using device_iommu_mapped().

There are plenty of dma_map_ops based drivers that can't merge segments.
Examples:

 - arch/ia64/sn/pci/pci_dma.c
 - arch/mips/jazz/jazzdma.c
 - arch/sparc/mm/io-unit.c
 - arch/sparc/mm/iommu.c
 - arch/x86/kernel/pci-calgary_64.c

Nevermind the diret mapping, swiotlb and other weirdos.

> 
> > 	blk_queue_virt_boundary(q, IOMMU_PAGE_SIZE(dev));
> > 	blk_queue_max_segment_size(q, IOMMU_MAX_SEGMENT_SIZE(dev));
> 
> By the way, I reported an issue [1] and I'm thinking dima_is_direct() environment
> (especially for swiotlb) is also needed such max_segment_size changes somehow.
> What do you think?
> 
> [1]
> https://marc.info/?l=linux-block&m=155954415603356&w=2

That doesn't seem to be related to the segment merging.  I'll take
a look, but next time please Cc the author of a suspect commit if
you already bisect things.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
