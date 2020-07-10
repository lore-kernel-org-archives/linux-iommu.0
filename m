Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ABCC433E3
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 13:05:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E8E2077D
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 13:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnRVM/8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E8E2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F271888CA;
	Fri, 10 Jul 2020 13:05:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g0aUpRbXX_1G; Fri, 10 Jul 2020 13:05:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 98FD8888A8;
	Fri, 10 Jul 2020 13:05:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D5EBC077B;
	Fri, 10 Jul 2020 13:05:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D7B4C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 13:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EBC2488252
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 13:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7DWB53v+F4kT for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 13:05:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CA1B788236
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 13:05:31 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 02D9C20748;
 Fri, 10 Jul 2020 13:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594386331;
 bh=EDql9LXT2itJkdhBRq+W0xaKADE3RTfhQuAty2vmxuo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TnRVM/8nu6yid3DGoPwuPeKeWJebZK5Gp9pEALAT1xgI2b0x1fade4Xmvt8jN7NXM
 1UFZgjEFLUyYtUD2ARniQ7l9C5exu7qfh8cKLJdz0qQdka4Z7dM95ETYShr8fyiusf
 7NM8UBJW94sAgoG0yolNnJEiHjitQugvwimRz5Sc=
Date: Fri, 10 Jul 2020 14:05:27 +0100
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag
Message-ID: <20200710130526.GA30578@willie-the-truck>
References: <20200703162548.19953-1-will@kernel.org>
 <20200710125831.GI27672@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200710125831.GI27672@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Hi Joerg,

On Fri, Jul 10, 2020 at 02:58:32PM +0200, Joerg Roedel wrote:
> On Fri, Jul 03, 2020 at 05:25:48PM +0100, Will Deacon wrote:
> > The IOMMU_SYS_CACHE_ONLY flag was never exposed via the DMA API and
> > has no in-tree users. Remove it.
> > 
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > Cc: Rob Clark <robdclark@gmail.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> > 
> > As discussed in [1], sounds like this should be a domain attribute anyway
> > when it's needed by the GPU.
> > 
> > [1] https://lore.kernel.org/r/CAF6AEGsCROVTsi2R7_aUkmH9Luoc_guMR0w0KUJc2cEgpfj79w@mail.gmail.com
> > 
> >  drivers/iommu/io-pgtable-arm.c | 3 ---
> >  include/linux/iommu.h          | 6 ------
> >  2 files changed, 9 deletions(-)
> 
> Applied, thanks.

Ah, I'd already got this queued for 5.9:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates

and I've queued a small number of patches on top of it now.

Are you planning to send it for 5.8? If so, I suspect I'll have to rebase.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
