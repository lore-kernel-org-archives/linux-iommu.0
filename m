Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699CDC433E0
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 17:59:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104A720823
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 17:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2OyEwIQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104A720823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9009C864E6;
	Wed, 24 Jun 2020 17:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OfF55-57bhsB; Wed, 24 Jun 2020 17:59:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 01AA186388;
	Wed, 24 Jun 2020 17:59:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3883C088E;
	Wed, 24 Jun 2020 17:59:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23515C016F;
 Wed, 24 Jun 2020 17:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 12226883C0;
 Wed, 24 Jun 2020 17:59:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B1zWrJL6SLPU; Wed, 24 Jun 2020 17:59:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3D947883B6;
 Wed, 24 Jun 2020 17:59:49 +0000 (UTC)
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 47F00207DD;
 Wed, 24 Jun 2020 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593021588;
 bh=lqF4UvFTuSVPWPvYKcQ8+owOKSTEFacagpA6y42+2I4=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=2OyEwIQ2W+yC8MeIiJn+zg6EpblYaMgeW1W2KIyhIYSiWBv27LoWjQc7whL/xeVKv
 y88icKjpG7HCb5h5QohX0bjtTPKL9DqECdzfBD8KC9GTdN07U3EonUUVOnBxKcXHUo
 yqYasuZpBgXc5lZj44gwka4tdlhLxCPXuN8CH3H4=
Date: Wed, 24 Jun 2020 10:59:47 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
In-Reply-To: <20200624050355-mutt-send-email-mst@kernel.org>
Message-ID: <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
References: <20200624091732.23944-1-peng.fan@nxp.com>
 <20200624050355-mutt-send-email-mst@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: jgross@suse.com, Peng Fan <peng.fan@nxp.com>, sstabellini@kernel.org,
 konrad.wilk@oracle.com, jasowang@redhat.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, linux-imx@nxp.com,
 xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
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
> On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> > Export xen_swiotlb for all platforms using xen swiotlb
> > 
> > Use xen_swiotlb to determine when vring should use dma APIs to map the
> > ring: when xen_swiotlb is enabled the dma API is required. When it is
> > disabled, it is not required.
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for this?
> Xen was there first, but everyone else is using that now.

Unfortunately it is complicated and it is not related to
VIRTIO_F_IOMMU_PLATFORM :-(


The Xen subsystem in Linux uses dma_ops via swiotlb_xen to translate
foreign mappings (memory coming from other VMs) to physical addresses.
On x86, it also uses dma_ops to translate Linux's idea of a physical
address into a real physical address (this is unneeded on ARM.)


So regardless of VIRTIO_F_IOMMU_PLATFORM, dma_ops should be used on Xen/x86
always and on Xen/ARM if Linux is Dom0 (because it has foreign
mappings.) That is why we have the if (xen_domain) return true; in
vring_use_dma_api.

You might have noticed that I missed one possible case above: Xen/ARM
DomU :-)

Xen/ARM domUs don't need swiotlb_xen, it is not even initialized. So if
(xen_domain) return true; would give the wrong answer in that case.
Linux would end up calling the "normal" dma_ops, not swiotlb-xen, and
the "normal" dma_ops fail.


The solution I suggested was to make the check in vring_use_dma_api more
flexible by returning true if the swiotlb_xen is supposed to be used,
not in general for all Xen domains, because that is what the check was
really meant to do.


In this regards I have two more comments:

- the comment on top of the check in vring_use_dma_api is still valid
- the patch looks broken on x86: it should always return true, but it
  returns false instead

 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index a2de775801af..768afd79f67a 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -252,7 +252,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >  	 * the DMA API if we're a Xen guest, which at least allows
> >  	 * all of the sensible Xen configurations to work correctly.
> >  	 */
> > -	if (xen_domain())
> > +	if (xen_vring_use_dma())
> >  		return true;
> >  
> >  	return false;
> 
> 
> The comment above this should probably be fixed.

> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
