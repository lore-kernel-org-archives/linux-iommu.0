Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A185C3404D
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 11:15:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7F024658
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 11:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ywq963r6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7F024658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4755187999;
	Wed, 19 Feb 2020 11:15:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 662h10y2ZFhK; Wed, 19 Feb 2020 11:15:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9DC6887820;
	Wed, 19 Feb 2020 11:15:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AAAFC1D80;
	Wed, 19 Feb 2020 11:15:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A86EEC013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 11:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 910A385D55
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 11:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 781s9WQl-PMI for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 11:15:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C591B85D44
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 11:15:06 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1531F2067D;
 Wed, 19 Feb 2020 11:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582110906;
 bh=VrtmvhAEzN6b003vnaoKuVG14IEQHmRL14jqXjioLEE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ywq963r6rr3QXJ8K+Kdq9md8IGCU6LJ8X9byT2d/5qrp03Uj2pFHy1S7HV4Hu9d3b
 /jmBpIsLqYVEgqlvU2A2YuhjKMkx76TqlQc8qFC4ylaTX5+R22i2kN0Py3eC8SdHh1
 BehTpWPebhqUIWr7+Tf9Jekp1FQFeCUBruxXK1FY=
Date: Wed, 19 Feb 2020 11:15:01 +0000
From: Will Deacon <will@kernel.org>
To: isaacm@codeaurora.org
Subject: Re: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
Message-ID: <20200219111501.GA19400@willie-the-truck>
References: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
 <20200217080138.GB10342@infradead.org>
 <c58fd502-52a4-cb0f-6e7f-e9cc00627313@arm.com>
 <fc6e1b6689bca7a00e6b12d2bc877d20@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fc6e1b6689bca7a00e6b12d2bc877d20@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, Robin Murphy <robin.murphy@arm.com>,
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

On Tue, Feb 18, 2020 at 05:57:18PM -0800, isaacm@codeaurora.org wrote:
> On 2020-02-17 07:50, Robin Murphy wrote:
> > On 17/02/2020 8:01 am, Christoph Hellwig wrote:
> > > On Fri, Feb 14, 2020 at 02:58:16PM -0800, Isaac J. Manjarres wrote:
> > > > From: Liam Mark <lmark@codeaurora.org>
> > > > 
> > > > Some devices have a memory map which contains gaps or holes.
> > > > In order for the device to have as much IOVA space as possible,
> > > > allow its driver to inform the DMA-IOMMU layer that it should
> > > > not allocate addresses from these holes.
> > > 
> > > Layering violation.  dma-iommu is the translation layer between the
> > > DMA API and the IOMMU API.  And calls into it from drivers performing
> > > DMA mappings need to go through the DMA API (and be documented there).
> > 
> > +1
> > 
> > More than that, though, we already have "holes in the address space"
> > support for the sake of PCI host bridge windows - assuming this is the
> > same kind of thing (i.e. the holes are between memory regions and
> > other resources in PA space, so are only relevant once address
> > translation comes into the picture), then this is IOMMU API level
> To make sure that we're on the same page, this support alludes to the
> handling in
> dma-iommu.c that reserves portions of the IOVA space for the PCI host bridge
> windows,
> correct? If so, then yes, this is similar.
> > stuff, so even a DMA API level interface would be inappropriate.
> Does this mean that the driver should be managing the IOVA space and
> mappings for this device using the IOMMU API? If so, is the rationale for
> this because the device driver can have the information of what IOVA ranges
> can and cannot be used? Shouldn't there be a generic way of informing an
> IOMMU driver about these reserved ranges? Perhaps through a device tree
> property, instead of deferring this type of management to the driver?

Before we dive into designing that, can you please clarify whether the
reserved IOVA range applies to all DMA masters mastering through a
particular SMMU, or whether it's just about one specific master? I was
assuming the former, but wanted to be sure.

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
