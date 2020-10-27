Return-Path: <SRS0=PKzM=EC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414C3C4363A
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 07:55:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DED62225E
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 07:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DED62225E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D1C1585232;
	Tue, 27 Oct 2020 07:55:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kj2aQaqQs_iC; Tue, 27 Oct 2020 07:55:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 10A4D8506A;
	Tue, 27 Oct 2020 07:55:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E28B0C0859;
	Tue, 27 Oct 2020 07:54:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CA68C0051
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 07:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4190A851A4
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 07:54:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JaMECxioopns for <iommu@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 07:54:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E53028506A
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 07:54:57 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2FBB867373; Tue, 27 Oct 2020 08:54:53 +0100 (CET)
Date: Tue, 27 Oct 2020 08:54:52 +0100
From: "hch@lst.de" <hch@lst.de>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] dma: Per-NUMA-node CMA should depend on NUMA
Message-ID: <20201027075452.GA22487@lst.de>
References: <74b66725883f065eb7d156f866678abb5be934bd.1603714996.git.robin.murphy@arm.com>
 <75cad228694b4f1587265a887069b241@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <75cad228694b4f1587265a887069b241@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Oct 26, 2020 at 08:07:43PM +0000, Song Bao Hua (Barry Song) wrote:
> > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > index c99de4a21458..964b74c9b7e3 100644
> > --- a/kernel/dma/Kconfig
> > +++ b/kernel/dma/Kconfig
> > @@ -125,7 +125,8 @@ if  DMA_CMA
> > 
> >  config DMA_PERNUMA_CMA
> >  	bool "Enable separate DMA Contiguous Memory Area for each NUMA
> > Node"
> > -	default NUMA && ARM64
> > +	depends on NUMA
> > +	default ARM64
> 
> On the other hand, at this moment, only ARM64 is calling the init code
> to get per_numa cma. Do we need to
> depends on NUMA && ARM64 ?
> so that this is not enabled by non-arm64?

I actually hate having arch symbols in common code.  A new
ARCH_HAS_DMA_PERNUMA_CMA, only selected by arm64 for now would be more
clean I think.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
