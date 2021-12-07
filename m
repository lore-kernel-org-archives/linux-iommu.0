Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D3BC433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 11:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F9098282C;
	Tue,  7 Dec 2021 11:49:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RBy1yF1kiPSY; Tue,  7 Dec 2021 11:49:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 53CC582803;
	Tue,  7 Dec 2021 11:49:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E6BBC001E;
	Tue,  7 Dec 2021 11:49:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88C54C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 11:49:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67AD340336
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 11:49:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1jopZ2REVy5H for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:49:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B0701402E0
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 11:49:47 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0C0D468AFE; Tue,  7 Dec 2021 12:49:44 +0100 (CET)
Date: Tue, 7 Dec 2021 12:49:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 04/11] dma-direct: clean up the remapping checks in
 dma_direct_alloc
Message-ID: <20211207114943.GB20713@lst.de>
References: <20211111065028.32761-1-hch@lst.de>
 <20211111065028.32761-5-hch@lst.de>
 <4f0109a6-8aea-185a-b73a-0b6e5ed1d514@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4f0109a6-8aea-185a-b73a-0b6e5ed1d514@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 David Rientjes <rientjes@google.com>
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

On Mon, Dec 06, 2021 at 04:33:10PM +0000, Robin Murphy wrote:
> On 2021-11-11 06:50, Christoph Hellwig wrote:
>> Add two local variables to track if we want to remap the returned
>> address using vmap or call dma_set_uncached and use that to simplify
>> the code flow.
>
> I still wonder about the asymmetry between the remap and set_uncached cases 
> WRT the memset(), which stands out even more the further we clean things 
> up, but that's another matter.

The memset for the remap case obviously needs to be done after
remapping. OTOH for the set_uncached case the memset is much faste
when done on the cached mapping, which must be done before calling
arch_dma_set_uncached.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
