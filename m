Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FFBC282DD
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 18:26:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CE72146E
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 18:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAUFCrY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CE72146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3432B85F6D;
	Tue,  7 Jan 2020 18:26:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l+kJKQ1QVhKx; Tue,  7 Jan 2020 18:26:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 09060857EB;
	Tue,  7 Jan 2020 18:26:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E128CC1D82;
	Tue,  7 Jan 2020 18:26:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 698CDC0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 18:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5326D85190
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 18:26:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XVCMXy8Jh4CB for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 18:26:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DBA9684828
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 18:26:38 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 378CB206F0;
 Tue,  7 Jan 2020 18:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578421598;
 bh=1u8pj7Qw0AQoNvxZ80zo7WkZ+ykeQKwOkuqIfoY82BI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qAUFCrY0VsgbJsWkl1Ty/fCBqJOnyXxaLaGMFEQAjMBxvtd1+0K//ZkxRuFCl5jFg
 530EHb0+8VYvKLWD+P83krZ6+TZltwhDvzlA7dEYXvsKmEKOWI46y+lWzfxm300iIJ
 HuuEgXWGWhOiBYU7MbqoZCHc7SmDn8bva79/QyqY=
Date: Tue, 7 Jan 2020 19:26:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: dma-direct: don't check swiotlb=force in dma_direct_map_resource
Message-ID: <20200107182636.GA2021584@kroah.com>
References: <CA+G9fYvMX4gMi6hmTmukzgr1xPsoJsj0WTm=AS3hC5Mq-dLvsQ@mail.gmail.com>
 <2c401e83-99d2-925f-66fe-fffe04415e1a@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2c401e83-99d2-925f-66fe-fffe04415e1a@arm.com>
Cc: Sasha Levin <sashal@kernel.org>, Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>,
 linux- stable <stable@vger.kernel.org>, iommu@lists.linux-foundation.org,
 lkft-triage@lists.linaro.org, hch@lst.de
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

On Tue, Jan 07, 2020 at 06:18:28PM +0000, Robin Murphy wrote:
> On 07/01/2020 5:38 pm, Naresh Kamboju wrote:
> > Following build error on stable-rc 5.4.9-rc1 for arm architecture.
> > 
> > dma/direct.c: In function 'dma_direct_possible':
> > dma/direct.c:329:3: error: too many arguments to function 'dma_capable'
> >     dma_capable(dev, dma_addr, size, true);
> >     ^~~~~~~~~~~
> 
> Not sure that $SUBJECT comes into it at all, but by the look of it I guess
> "dma-direct: exclude dma_direct_map_resource from the min_low_pfn check"
> implicitly depends on 130c1ccbf553 ("dma-direct: unify the dma_capable
> definitions") too.

Ugh, good catch.  I'll drop these patches, they don't look ok for stable
at this point in time.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
