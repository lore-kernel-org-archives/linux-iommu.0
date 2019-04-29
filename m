Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA0C004C9
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 19:11:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1C820675
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 19:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1C820675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1DC52E7B;
	Mon, 29 Apr 2019 19:11:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3C546DB7
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 19:10:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BE73B875
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 19:10:58 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 9DC0668AFE; Mon, 29 Apr 2019 21:10:40 +0200 (CEST)
Date: Mon, 29 Apr 2019 21:10:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 11/26] iommu/dma: Factor out remapped pages lookup
Message-ID: <20190429191040.GC5637@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
	<20190422175942.18788-12-hch@lst.de>
	<f8c04947-0ddb-17c5-8918-5859aabc220c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f8c04947-0ddb-17c5-8918-5859aabc220c@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429191040.fNshN8lU9233omzvm6A4HcsYFJjV8twShoawI5wAkhQ@z>

On Mon, Apr 29, 2019 at 02:05:46PM +0100, Robin Murphy wrote:
> On 22/04/2019 18:59, Christoph Hellwig wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> Since we duplicate the find_vm_area() logic a few times in places where
>> we only care aboute the pages, factor out a helper to abstract it.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> [hch: don't warn when not finding a region, as we'll rely on that later]
>
> Yeah, I did think about that and the things which it might make a little 
> easier, but preserved it as-is for the sake of keeping my modifications 
> quick and simple. TBH I'm now feeling more inclined to drop the WARNs 
> entirely at this point, since it's not like there's ever been any general 
> guarantee that freeing the wrong thing shouldn't just crash, but that's 
> something we can easily come back to later if need be.

Ok, I've dropped the warnings.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
