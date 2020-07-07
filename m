Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E4DC433DF
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 14:52:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CC820771
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 14:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CC820771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B60AC89051;
	Tue,  7 Jul 2020 14:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rYkVOlZN0rSY; Tue,  7 Jul 2020 14:52:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DAB9D877C9;
	Tue,  7 Jul 2020 14:52:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE838C0893;
	Tue,  7 Jul 2020 14:52:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A357C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 14:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0702827EF2
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 14:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6VNaeXCxoSDU for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 14:51:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id 98DBD27B9E
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 14:51:59 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 96D6068AFE; Tue,  7 Jul 2020 16:51:56 +0200 (CEST)
Date: Tue, 7 Jul 2020 16:51:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 1/4] dma-mapping: move the remaining DMA API calls out
 of line
Message-ID: <20200707145156.GA22235@lst.de>
References: <20200414122506.438134-1-hch@lst.de>
 <20200414122506.438134-2-hch@lst.de>
 <c2572d30-f03c-450d-e257-3a8673b42d44@ozlabs.ru>
 <20200415061859.GA32392@lst.de>
 <5139e8e1-6389-3387-dc39-6983b08ff28d@ozlabs.ru>
 <20200417075852.GA20049@lst.de>
 <70296d53-3504-2645-4b16-0eb73b0cd0d9@ozlabs.ru>
 <20200509081946.GA21834@lst.de>
 <95c46afb-bb40-3cb3-bf32-3e510fcd474d@ozlabs.ru>
 <fa6c3d55-1054-b87f-9832-3418323151cd@ozlabs.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fa6c3d55-1054-b87f-9832-3418323151cd@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
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

On Tue, Jul 07, 2020 at 10:43:10AM +1000, Alexey Kardashevskiy wrote:
> Any luck there? I'd really like to cross this off my todo list :) Thanks,

We had another incident with new net code poking into dma internals
blocking this series.  That is now sorted out, so the series is back
on track.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
