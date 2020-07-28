Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51814C433E8
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 15:29:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065FC206D8
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 15:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065FC206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BF73C86A5C;
	Tue, 28 Jul 2020 15:29:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MkRa2Ci248Nk; Tue, 28 Jul 2020 15:29:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 425E78485E;
	Tue, 28 Jul 2020 15:29:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27CB8C004F;
	Tue, 28 Jul 2020 15:29:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8ED91C004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 15:29:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 76F2487F83
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 15:29:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZpXLboOt2P0D for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 15:29:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 20D3587F4A
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 15:29:00 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8B11E68B05; Tue, 28 Jul 2020 17:28:56 +0200 (CEST)
Date: Tue, 28 Jul 2020 17:28:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH 1/2] dma-pool: fix coherent pool allocations for IOMMU
 mappings
Message-ID: <20200728152856.GA16545@lst.de>
References: <20200728104742.422960-1-hch@lst.de>
 <20200728104742.422960-2-hch@lst.de>
 <0c602a1d887d0fe38857e21aa963d51f5c772661.camel@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0c602a1d887d0fe38857e21aa963d51f5c772661.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Amit Pundir <amit.pundir@linaro.org>, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Tue, Jul 28, 2020 at 04:56:29PM +0200, Nicolas Saenz Julienne wrote:
> > +	phys = gen_pool_virt_to_phys(pool, addr);
> > +	if (!phys_addr_ok(dev, phys, size)) {
> 
> Shoudn't we check if phys_addr_ok() != NULL?

Yes, we should.  This also means the system that causes problems for
Amit isn't using the iommu.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
