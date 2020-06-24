Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3933C433E1
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 21:53:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AD02081A
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 21:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDuUefEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AD02081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 66E8887A87;
	Wed, 24 Jun 2020 21:53:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9QgeEj5IlKSy; Wed, 24 Jun 2020 21:53:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B4F9A87903;
	Wed, 24 Jun 2020 21:53:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90C7AC088E;
	Wed, 24 Jun 2020 21:53:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61488C016F;
 Wed, 24 Jun 2020 21:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5DE7886ECB;
 Wed, 24 Jun 2020 21:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VFwoANl08gJc; Wed, 24 Jun 2020 21:53:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5383586E40;
 Wed, 24 Jun 2020 21:53:56 +0000 (UTC)
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 821A020768;
 Wed, 24 Jun 2020 21:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593035636;
 bh=w8qZARSGOA9g1xMGYuTx8OCS70r3EMod3YbhLs/CK34=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=XDuUefEB+KZjHyuyMUCNlxMM+3yqNwPecpJYixRBsMh9/2+yUYJvXu9AqKwlHhEhW
 nl7+1WfJ7OnhAhI8J5EkDPKX5Gncbb5rfv6iU3kQ8YdXx/F0D6ovpmBgoHLucdQ7/I
 8F2Ziv5A/NwB7a2krphKC0K5P0pGFIklTTA1uS2k=
Date: Wed, 24 Jun 2020 14:53:54 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
In-Reply-To: <20200624163940-mutt-send-email-mst@kernel.org>
Message-ID: <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
References: <20200624091732.23944-1-peng.fan@nxp.com>
 <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
 <20200624163940-mutt-send-email-mst@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: jgross@suse.com, Peng Fan <peng.fan@nxp.com>,
 Stefano Stabellini <sstabellini@kernel.org>, konrad.wilk@oracle.com,
 jasowang@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
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

On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> On Wed, Jun 24, 2020 at 10:59:47AM -0700, Stefano Stabellini wrote:
> > On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > > On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> > > > Export xen_swiotlb for all platforms using xen swiotlb
> > > > 
> > > > Use xen_swiotlb to determine when vring should use dma APIs to map the
> > > > ring: when xen_swiotlb is enabled the dma API is required. When it is
> > > > disabled, it is not required.
> > > > 
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > 
> > > Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for this?
> > > Xen was there first, but everyone else is using that now.
> > 
> > Unfortunately it is complicated and it is not related to
> > VIRTIO_F_IOMMU_PLATFORM :-(
> > 
> > 
> > The Xen subsystem in Linux uses dma_ops via swiotlb_xen to translate
> > foreign mappings (memory coming from other VMs) to physical addresses.
> > On x86, it also uses dma_ops to translate Linux's idea of a physical
> > address into a real physical address (this is unneeded on ARM.)
> > 
> > 
> > So regardless of VIRTIO_F_IOMMU_PLATFORM, dma_ops should be used on Xen/x86
> > always and on Xen/ARM if Linux is Dom0 (because it has foreign
> > mappings.) That is why we have the if (xen_domain) return true; in
> > vring_use_dma_api.
> 
> VIRTIO_F_IOMMU_PLATFORM makes guest always use DMA ops.
> 
> Xen hack predates VIRTIO_F_IOMMU_PLATFORM so it *also*
> forces DMA ops even if VIRTIO_F_IOMMU_PLATFORM is clear.
>
> Unfortunately as a result Xen never got around to
> properly setting VIRTIO_F_IOMMU_PLATFORM.

I don't think VIRTIO_F_IOMMU_PLATFORM would be correct for this because
the usage of swiotlb_xen is not a property of virtio, it is a detail of
the way Linux does Xen address translations. swiotlb-xen is used to do
these translations and it is hooked into the dma_ops framework.

It would be possible to have a device in hardware that is
virtio-compatible and doesn't set VIRTIO_F_IOMMU_PLATFORM. The device
could be directly assigned (passthrough) to a DomU. We would still
have to use swiotlb_xen if Xen is running.

You should think of swiotlb-xen as only internal to Linux and not
related to whether the (virtual or non-virtual) hardware comes with an
IOMMU or not.


> > You might have noticed that I missed one possible case above: Xen/ARM
> > DomU :-)
> > 
> > Xen/ARM domUs don't need swiotlb_xen, it is not even initialized. So if
> > (xen_domain) return true; would give the wrong answer in that case.
> > Linux would end up calling the "normal" dma_ops, not swiotlb-xen, and
> > the "normal" dma_ops fail.
> > 
> > 
> > The solution I suggested was to make the check in vring_use_dma_api more
> > flexible by returning true if the swiotlb_xen is supposed to be used,
> > not in general for all Xen domains, because that is what the check was
> > really meant to do.
> 
> Why not fix DMA ops so they DTRT (nop) on Xen/ARM DomU? What is wrong with that?

swiotlb-xen is not used on Xen/ARM DomU, the default dma_ops are the
ones that are used. So you are saying, why don't we fix the default
dma_ops to work with virtio?

It is bad that the default dma_ops crash with virtio, so yes I think it
would be good to fix that. However, even if we fixed that, the if
(xen_domain()) check in vring_use_dma_api is still a problem.


Alternatively we could try to work-around it from swiotlb-xen. We could
enable swiotlb-xen for Xen/ARM DomUs with a different implementation so
that we could leave the vring_use_dma_api check unmodified.

It would be ugly because we would have to figure out from the new
swiotlb-xen functions if the device is a normal device, so we have to
call the regular dma_ops functions, or if the device is a virtio device,
in which case there is nothing to do. I think it is undesirable but
could probably be made to work.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
