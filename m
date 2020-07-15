Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7595BC433E1
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 17:06:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C23E2065F
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 17:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBPLDZ0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C23E2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3C8248AEA7;
	Wed, 15 Jul 2020 17:06:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w+VKKtrZigoF; Wed, 15 Jul 2020 17:06:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 517E78AEA2;
	Wed, 15 Jul 2020 17:06:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3226FC07FF;
	Wed, 15 Jul 2020 17:06:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E763C0733;
 Wed, 15 Jul 2020 17:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4C9098891B;
 Wed, 15 Jul 2020 17:06:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7VxAeuq8vaYs; Wed, 15 Jul 2020 17:06:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BAAD18890F;
 Wed, 15 Jul 2020 17:06:01 +0000 (UTC)
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0D53F2065E;
 Wed, 15 Jul 2020 17:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594832761;
 bh=MVQs60eyaseKttygMi5Okmio5UqpxovjpBaGYM2KopU=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=CBPLDZ0a2kofL5+ir7rsYDlbbpzpSFpGzRjY5GXtgxKoOkAVo9rx/IXw2nZaAg6FP
 0PGoTpRFSOeEWLcCxLE4J3D3xFoVDU+sXxptoew5BleNGM0IN0YcxXbu+SlhudGRTe
 VCtmQZUU53N6u7CQ+nguMHVqQdrr4STCBfllpVWM=
Date: Wed, 15 Jul 2020 10:06:00 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
In-Reply-To: <20200711144334-mutt-send-email-mst@kernel.org>
Message-ID: <alpine.DEB.2.21.2007151001140.4124@sstabellini-ThinkPad-T480s>
References: <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
 <20200626110629-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006291621300.8121@sstabellini-ThinkPad-T480s>
 <20200701133456.GA23888@infradead.org>
 <alpine.DEB.2.21.2007011020320.8121@sstabellini-ThinkPad-T480s>
 <20200701172219-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2007101019340.4124@sstabellini-ThinkPad-T480s>
 <20200711144334-mutt-send-email-mst@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: jgross@suse.com, Peng Fan <peng.fan@nxp.com>,
 Stefano Stabellini <sstabellini@kernel.org>, konrad.wilk@oracle.com,
 jasowang@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 linux-imx@nxp.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
 linux-arm-kernel@lists.infradead.org
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

On Sat, 11 Jul 2020, Michael S. Tsirkin wrote:
> On Fri, Jul 10, 2020 at 10:23:22AM -0700, Stefano Stabellini wrote:
> > Sorry for the late reply -- a couple of conferences kept me busy.
> > 
> > 
> > On Wed, 1 Jul 2020, Michael S. Tsirkin wrote:
> > > On Wed, Jul 01, 2020 at 10:34:53AM -0700, Stefano Stabellini wrote:
> > > > Would you be in favor of a more flexible check along the lines of the
> > > > one proposed in the patch that started this thread:
> > > > 
> > > >     if (xen_vring_use_dma())
> > > >             return true;
> > > > 
> > > > 
> > > > xen_vring_use_dma would be implemented so that it returns true when
> > > > xen_swiotlb is required and false otherwise.
> > > 
> > > Just to stress - with a patch like this virtio can *still* use DMA API
> > > if PLATFORM_ACCESS is set. So if DMA API is broken on some platforms
> > > as you seem to be saying, you guys should fix it before doing something
> > > like this..
> > 
> > Yes, DMA API is broken with some interfaces (specifically: rpmesg and
> > trusty), but for them PLATFORM_ACCESS is never set. That is why the
> > errors weren't reported before. Xen special case aside, there is no
> > problem under normal circumstances.
> 
> So why not fix DMA API? Then this patch is not needed.

It looks like the conversation is going in circles :-)

I tried to explain the reason why, even if we fixed the DMA API to work
with rpmesg and trusty, we still need this patch with the following
email:  https://marc.info/?l=linux-kernel&m=159347446709625&w=2


At that time it looked like you agreed that we needed to improve this
check?  (https://marc.info/?l=linux-kernel&m=159363662418250&w=2)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
