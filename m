Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F2C31E44
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 06:54:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C3121855
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 06:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C3121855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3BC81A95;
	Mon, 17 Jun 2019 06:54:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B43F22F
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 06:54:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 481402C3
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 06:54:02 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id F35F768AA6; Mon, 17 Jun 2019 08:53:31 +0200 (CEST)
Date: Mon, 17 Jun 2019 08:53:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH v6 5/5] mmc: queue: Use bigger segments if IOMMU
	can merge the segments
Message-ID: <20190617065331.GA5456@lst.de>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<20190614072459.GD8420@lst.de>
	<OSBPR01MB3590FA5DB10D9EF34F551335D8EB0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OSBPR01MB3590FA5DB10D9EF34F551335D8EB0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>
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

On Mon, Jun 17, 2019 at 06:46:33AM +0000, Yoshihiro Shimoda wrote:
> > can_merge seems a little too generic a name to me.  Maybe can_iommu_merge?
> 
> I'll fix the name. Also, only the device_iommu_mapped() condition wiil cause
> a problem on iommu=pt [1]. So, I'll add another condition here.

Instead of adding another condition here I think we need to properly
abstract it out in the DMA layer.  E.g. have a

unsigned long dma_get_merge_boundary(struct device *dev)
{
	const struct dma_map_ops *ops = get_dma_ops(dev);

	if (!ops || !ops->get_merge_boundary)
		return 0; /* can't merge */
	return ops->get_merge_boundary(dev);
}

and then implement the method in dma-iommu.c.

blk_queue_can_use_iommu_merging then comes:

bool blk_queue_enable_iommu_merging(struct request_queue *q,
		struct device *dev)
{
	unsigned long boundary = dma_get_merge_boundary(dev);

	if (!boundary)
		return false;
	blk_queue_virt_boundary(q, boundary);
	return true;
}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
