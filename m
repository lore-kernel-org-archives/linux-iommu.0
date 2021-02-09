Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E1BC433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 15:51:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94EA64E27
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 15:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94EA64E27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 883C86F56F
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 15:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kTA-SvVKT3rF for <iommu@archiver.kernel.org>;
	Tue,  9 Feb 2021 15:51:08 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 7ADC36F556; Tue,  9 Feb 2021 15:51:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E9396F500;
	Tue,  9 Feb 2021 15:51:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 340CEC0891;
	Tue,  9 Feb 2021 15:51:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38930C013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 15:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 27B6687171
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 15:51:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tqcIiPRtkBqB for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 15:51:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C274887135
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 15:51:02 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9E5D467373; Tue,  9 Feb 2021 16:50:58 +0100 (CET)
Date: Tue, 9 Feb 2021 16:50:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: DMA direct mapping fix for 5.4 and earlier stable branches
Message-ID: <20210209155058.GA8912@lst.de>
References: <CAFA6WYNazCmYN20irLdNV+2vcv5dqR+grvaY-FA7q2WOBMs__g@mail.gmail.com>
 <YCIym62vHfbG+dWf@kroah.com>
 <CAFA6WYM+xJ0YDKenWFPMHrTz4gLWatnog84wyk31Xy2dTiT2RA@mail.gmail.com>
 <YCJCDZGa1Dhqv6Ni@kroah.com>
 <27bbe35deacb4ca49f31307f4ed551b5@SOC-EX02V.e01.socionext.com>
 <YCJUgKDNVjJ4dUqM@kroah.com> <20210209093642.GA1006@lst.de>
 <CAFA6WYO59w=wif8W16sG6BnzSjFhaY6PmRUTdSCu9A+zA7gzBw@mail.gmail.com>
 <e36b8a7d-a999-da09-d7d9-cc26579a65d1@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e36b8a7d-a999-da09-d7d9-cc26579a65d1@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Greg KH <gregkh@linuxfoundation.org>, obayashi.yoshimasa@socionext.com,
 stable <stable@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
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

On Tue, Feb 09, 2021 at 12:45:11PM +0000, Robin Murphy wrote:
> It's not a bug, it's a fundamental design failure. dma_get_sgtable() has 
> only ever sort-of-worked for DMA buffers that come from CMA or regular page 
> allocations. In particular, a "no-map" DMA pool is not backed by kernel 
> memory, so does not have any corresponding page structs, so it's impossible 
> to generate a *valid* scatterlist to represent memory from that pool, 
> regardless of what you might get away with provided you don't poke too hard 
> at it.
>
> It is not a good API...

Yes, I don't think anyone should add new users of the API.

That being said the commit he is trying to backport fixes a bug in
the implementation that at least in theory could also affect in-tree
drivers.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
