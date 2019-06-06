Return-Path: <SRS0=1Id5=UF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73571C28D1A
	for <iommu@archiver.kernel.org>; Thu,  6 Jun 2019 07:01:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53DD3207E0
	for <iommu@archiver.kernel.org>; Thu,  6 Jun 2019 07:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DD3207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 370D2B79;
	Thu,  6 Jun 2019 07:01:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EE123B09
	for <iommu@lists.linux-foundation.org>;
	Thu,  6 Jun 2019 07:01:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7DC45A8
	for <iommu@lists.linux-foundation.org>;
	Thu,  6 Jun 2019 07:01:27 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 8A8FB68B20; Thu,  6 Jun 2019 09:01:00 +0200 (CEST)
Date: Thu, 6 Jun 2019 09:00:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Message-ID: <20190606070059.GI27033@lst.de>
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<7dfeb7d8-b777-b4af-d892-2829cd05241b@arm.com>
	<20190605123808.GA12529@lst.de>
	<OSAPR01MB3089448A3D44BE61B127AA73D8170@OSAPR01MB3089.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OSAPR01MB3089448A3D44BE61B127AA73D8170@OSAPR01MB3089.jpnprd01.prod.outlook.com>
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

On Thu, Jun 06, 2019 at 06:28:47AM +0000, Yoshihiro Shimoda wrote:
> > The problem is that we need a way to communicate to the block layer
> > that more than a single segment is ok IFF the DMA API instance supports
> > merging.  And of course the answer will depend on futher parameters
> > like the maximum merged segment size and alignment for the segement.
> 
> I'm afraid but I don't understand why we need a way to communicate to
> the block layer that more than a single segment is ok IFF the DMA API
> instance supports merging.

Assume a device (which I think is your case) that only supports a single
segment in hardware.  In that case we set max_segments to 1 if no
IOMMU is present.  But if we have a merge capable IOMMU we can set
max_segments to unlimited (or some software limit for scatterlist
allocation), as long as we set a virt_boundary matching what the IOMMU
expects, and max_sectors_kb isn't larger than the max IOMMU mapping
size.  Now we could probably just open code this in the driver, but
I'd feel much happier having a block layer like this:

bool blk_can_use_iommu_merging(struct request_queue *q, struct device *dev)
{
	if (!IOMMU_CAN_MERGE_SEGMENTS(dev))
		return false;

	blk_queue_virt_boundary(q, IOMMU_PAGE_SIZE(dev));
	blk_queue_max_segment_size(q, IOMMU_MAX_SEGMENT_SIZE(dev));
	return true;
}

and the driver then does:

	if (blk_can_use_iommu_merging(q, dev)) {
		blk_queue_max_segments(q, MAX_SW_SEGMENTS);
		// initialize sg mempool, etc..
	}


Where the SCREAMING pseudo code calls are something we need to find a
good API for.

And thinking about it the backend doesn't need to be an iommu, swiotlb
could handle this as well, which might be interesting for devices
that need to boune buffer anyway.  IIRC mmc actually has some code
to copy multiple segments into a bounce buffer somewhere.

> The block layer already has a limit "max_segment_size" for each device so that
> regardless it can/cannot merge the segments, we can use the limit.
> Is my understanding incorrect?

Yes.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
