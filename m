Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BF0C43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 05:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08E8184686;
	Thu, 23 Jun 2022 05:42:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08E8184686
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id no8nQPRHzMqs; Thu, 23 Jun 2022 05:42:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C9CBE81B3E;
	Thu, 23 Jun 2022 05:42:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9CBE81B3E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 967D1C0039;
	Thu, 23 Jun 2022 05:42:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D4AAC002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 05:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E31684048C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 05:42:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E31684048C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QUzp9ZmQYax7 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 05:42:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC4D240123
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC4D240123
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 05:42:16 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 853FE68AA6; Thu, 23 Jun 2022 07:42:11 +0200 (CEST)
Date: Thu, 23 Jun 2022 07:42:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 0/2] dma-mapping, remoteproc: Fix dma_mem leak after
 rproc_shutdown
Message-ID: <20220623054211.GA12408@lst.de>
References: <20220422062436.14384-1-mark-pk.tsai@mediatek.com>
 <20220423174650.GA29219@lst.de> <20220622162540.GA1606016@p14s>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220622162540.GA1606016@p14s>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: yj.chiang@mediatek.com, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 matthias.bgg@gmail.com, robin.murphy@arm.com, Christoph Hellwig <hch@lst.de>,
 Mark-PK Tsai <mark-pk.tsai@mediatek.com>
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

On Wed, Jun 22, 2022 at 10:25:40AM -0600, Mathieu Poirier wrote:
> On Sat, Apr 23, 2022 at 07:46:50PM +0200, Christoph Hellwig wrote:
> > Sigh.  In theory drivers should never declare coherent memory like
> > this, and there has been some work to fix remoteproc in that regard.
> > 
> > But I guess until that is merged we'll need somthing like this fix.
> 
> Should I take this in the remoteproc tree?  If so, can I get an RB?

Reluctantly-Acked-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
