Return-Path: <SRS0=8b8q=EV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4F3C2D0E4
	for <iommu@archiver.kernel.org>; Sun, 15 Nov 2020 08:45:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE492223FB
	for <iommu@archiver.kernel.org>; Sun, 15 Nov 2020 08:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE492223FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 643118730C;
	Sun, 15 Nov 2020 08:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KJ2V-Nov5CC7; Sun, 15 Nov 2020 08:45:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 301D48730B;
	Sun, 15 Nov 2020 08:45:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03A49C0891;
	Sun, 15 Nov 2020 08:45:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20056C07FF
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 08:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 14C698730C
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 08:45:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vQVC7z98NECL for <iommu@lists.linux-foundation.org>;
 Sun, 15 Nov 2020 08:45:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A71EF8730B
 for <iommu@lists.linux-foundation.org>; Sun, 15 Nov 2020 08:45:20 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1416767373; Sun, 15 Nov 2020 09:45:16 +0100 (CET)
Date: Sun, 15 Nov 2020 09:45:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v3 1/2] dma-mapping: add benchmark support for
 streaming DMA APIs
Message-ID: <20201115084515.GA18411@lst.de>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
 <20201102080646.2180-2-song.bao.hua@hisilicon.com>
 <20201114165336.GA24844@lst.de>
 <5c4488dd28fc4869b7e67dd842ffa208@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5c4488dd28fc4869b7e67dd842ffa208@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Shuah Khan <shuah@kernel.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Sun, Nov 15, 2020 at 12:11:15AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> Checkpatch has changed 80 to 100. That's probably why my local checkpatch didn't report any warning:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d
> 
> I am happy to change them to be less than 80 if you like.

Don't rely on checkpath, is is broken.  Look at the codingstyle document.

> > I think this needs to set a dma mask as behavior for unlimited dma
> > mask vs the default 32-bit one can be very different. 
> 
> I actually prefer users bind real devices with real dma_mask to test rather than force to change
> the dma_mask in this benchmark.

The mask is set by the driver, not the device.  So you need to set when
when you bind, real device or not.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
