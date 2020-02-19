Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EA5C34047
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 12:29:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D28E321D56
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 12:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Umn/1xga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28E321D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B5CC520498;
	Wed, 19 Feb 2020 12:29:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m0fscXkR+FsZ; Wed, 19 Feb 2020 12:29:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 03CDB203A8;
	Wed, 19 Feb 2020 12:29:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC982C1D80;
	Wed, 19 Feb 2020 12:29:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81069C013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 12:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6F8D8878F0
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 12:28:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j-WVoprU-HvJ for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 12:28:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 72F7B85829
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 12:28:57 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F004B21D56;
 Wed, 19 Feb 2020 12:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582115337;
 bh=pZqcXAmiIFw4IeJtWb4Wcj8aOi5Y83+K1GOOaMEDO7E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Umn/1xgaV43oz7F197cgo+A0c9gYfvgLHah+dwfpDMlsoOlwhteZSYiflE5BPlul/
 DX1Ql9t919o+Z0DaA7Z7VQQKBfY019XpUOFh7TO8hKi2JKQYjXO1rIu44zNL5jANbV
 ZCHllR7RHSdLV8ZMw/usUo5/sCFW64rEnm3GA6uM=
Date: Wed, 19 Feb 2020 12:28:52 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommu/iova: Add a best-fit algorithm
Message-ID: <20200219122852.GB19400@willie-the-truck>
References: <1581721602-17010-1-git-send-email-isaacm@codeaurora.org>
 <b9d31aa9-fb57-ad31-52e4-1a5c21e5e0de@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b9d31aa9-fb57-ad31-52e4-1a5c21e5e0de@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Liam Mark <lmark@codeaurora.org>,
 iommu@lists.linux-foundation.org, pratikp@codeaurora.org
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

On Mon, Feb 17, 2020 at 04:03:54PM +0000, Robin Murphy wrote:
> On 14/02/2020 11:06 pm, Isaac J. Manjarres wrote:
> > From: Liam Mark <lmark@codeaurora.org>
> > 
> > Using the best-fit algorithm, instead of the first-fit
> > algorithm, may reduce fragmentation when allocating
> > IOVAs.
> 
> What kind of pathological allocation patterns make that a serious problem?
> Is there any scope for simply changing the order of things in the callers?
> Do these drivers also run under other DMA API backends (e.g. 32-bit Arm)?
> 
> More generally, if a driver knows enough to want to second-guess a generic
> DMA API allocator, that's a reasonable argument that it should perhaps be
> properly IOMMU-aware and managing its own address space anyway. Perhaps this
> effort might be better spent finishing off the DMA ops bypass stuff to make
> that approach more robust and welcoming.

Anecdotally, it appears to be a fairly common problem for 32-bit capable
DMA masters to hit fragmentation problems with the current IOVA allocator
but yes, some numbers to show how that is improved using best-fit (as
opposed to e.g. worst-fit) are definitely required here.

It might be that we can simply swizzle the algorithm to focus on reduced
fragmentation for smaller (i.e. 32-bit) address spaces, but leave larger
domains with the current approach to avoid increasing the allocation
overhead.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
