Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842B9C433ED
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 11:39:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21682613DD
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 11:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21682613DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE03382B97;
	Tue, 27 Apr 2021 11:39:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bCtu93Zch9zS; Tue, 27 Apr 2021 11:39:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2F5582CFD;
	Tue, 27 Apr 2021 11:39:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B18FDC000F;
	Tue, 27 Apr 2021 11:39:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BBCDC000B
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 11:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77C44405C5
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 11:39:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RMJrdtH87HCu for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 11:39:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 541AD40553
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 11:39:21 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B2276100B;
 Tue, 27 Apr 2021 11:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1619523560;
 bh=TxdaOEc9CznWEwtVjOxV+KNECrQDBOoFXaJg7zjtSdU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BzmxTy6ndGTH6LDFaqWbNZF9+4dFeqwGsI2F2JTKJGFRrfo0AW52gyJJ8oa7QjOIp
 uhbS67JT8WP8ZJfUgcs9wSF5ZjkjgLQx/gmIEFmFfazdPShFsCPnP4L7K8QEdGzK+R
 XqtTYhYmBzyO8sLQKjRjPxKRXhO1ATws16xeML5Y=
Date: Tue, 27 Apr 2021 13:39:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: dma-api debugfs directory is not created since debugfs is not
 initialized
Message-ID: <YIf35EzfSY7qavWw@kroah.com>
References: <YIf2w1navFNeYjMS@Red>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YIf2w1navFNeYjMS@Red>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com, hch@lst.de
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

On Tue, Apr 27, 2021 at 01:34:27PM +0200, Corentin Labbe wrote:
> Hello
> 
> I try to debug some DMA problem on next-20210427, and so I have enabled CONFIG_DMA_API_DEBUG=y.
> But the dma-api directory does show up in debugfs, but lot of other directory exists in it.

Does it show up properly in 5.12?

> After debugging it seems due to commit 56348560d495 ("debugfs: do not attempt to create a new file before the filesystem is initalized")
> Reverting the commit permit to "dma-api" debugfs to be found. (but seems not the right way to fix it).

We have had some odd start-up ordering issues that the above commit has
caused to show.  Given that this commit is now in stable kernels, with
no report of this issue so far, I'm worried that maybe this is a dma
subsystem ordering issue?

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
