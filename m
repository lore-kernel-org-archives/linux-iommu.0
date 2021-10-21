Return-Path: <SRS0=0R9D=PJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5E1C433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 07:22:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081B36109F
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 07:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 081B36109F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE328835C9;
	Thu, 21 Oct 2021 07:22:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UJv6c59x8885; Thu, 21 Oct 2021 07:22:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B3ED083372;
	Thu, 21 Oct 2021 07:22:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95543C001C;
	Thu, 21 Oct 2021 07:22:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB13BC0011
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 07:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC97E4010A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 07:22:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r-rv7FKxlE2S for <iommu@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 07:22:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 316D94007A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 07:22:38 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id D34B168BEB; Thu, 21 Oct 2021 09:22:33 +0200 (CEST)
Date: Thu, 21 Oct 2021 09:22:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 2/4] dma-direct: leak memory that can't be re-encrypted
Message-ID: <20211021072233.GA29169@lst.de>
References: <20211019122916.2468032-1-hch@lst.de>
 <20211019122916.2468032-3-hch@lst.de>
 <c116b963-1a53-bb5a-feab-2abaee6fd86@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c116b963-1a53-bb5a-feab-2abaee6fd86@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
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

On Tue, Oct 19, 2021 at 12:56:36PM -0700, David Rientjes wrote:
> > -	dma_set_encrypted(dev, vaddr, 1 << page_order);
> > +	if (dma_set_encrypted(dev, vaddr, 1 << page_order)) {
> > +		pr_warn_ratelimited(
> > +			"leaking DMA memory that can't be re-encrypted\n");
> > +	}
> 
> Is this actually leaking the memory?

Yes, it should return here.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
