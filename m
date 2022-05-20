Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBB5C433FE
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 12:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B317B425A9;
	Fri, 20 May 2022 12:00:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2r0BrxgwKzhS; Fri, 20 May 2022 12:00:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 55541425A5;
	Fri, 20 May 2022 12:00:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 358AFC0039;
	Fri, 20 May 2022 12:00:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D975C002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 12:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E5F3425A8
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 12:00:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DyYrFOE0CB6I for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 12:00:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D95C425A5
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 12:00:40 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4C16D61E1B;
 Fri, 20 May 2022 12:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB670C385A9;
 Fri, 20 May 2022 12:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653048038;
 bh=Scz4kC4NvraS6veC/zLWgf2acAax2Vcwh4OHRl50J1E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WIdn/I3veJNvab0brCv2TRj3VbbrX+3kSUT7O7XNA1eCPNBuREyIUvuOm+Q//NIzS
 yMc/CvhK7ItiIgbKedStpGKyUHxuFSALDvi2VVes2wuglTN+LOAEE6Z9rZBKAdwwrf
 ZzJURU+rHZzS/PjLfR5WJGR/KW8VZe9SdmTEVmBEQVM7XAvJbFtwGPgG8S7x/JmxsM
 H5bCeZqrykXgzyT0Wf+HOdQdCoUOfpRkSqamgLfLf2IcHUCPIjYBHfhh1/EggOnAW2
 6E6a8Zpp5SHzvSeeuYOu2/eqI9zm4xDWhoBQEn4P0WfimTi9+FcJ+Burzj28UcLy+n
 b/4/nREQbqAig==
Date: Fri, 20 May 2022 13:00:32 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] vfio: Remove VFIO_TYPE1_NESTING_IOMMU
Message-ID: <20220520120032.GB6700@willie-the-truck>
References: <0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com>
 <3521de8b-3163-7ff0-a823-5d4ec96a2ae5@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3521de8b-3163-7ff0-a823-5d4ec96a2ae5@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 iommu@lists.linux-foundation.org, Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, linux-arm-kernel@lists.infradead.org
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

On Fri, May 20, 2022 at 12:02:23PM +0100, Robin Murphy wrote:
> On 2022-05-10 17:55, Jason Gunthorpe via iommu wrote:
> > This control causes the ARM SMMU drivers to choose a stage 2
> > implementation for the IO pagetable (vs the stage 1 usual default),
> > however this choice has no visible impact to the VFIO user.
> 
> Oh, I should have read more carefully... this isn't entirely true. Stage 2
> has a different permission model from stage 1, so although it's arguably
> undocumented behaviour, VFIO users that know enough about the underlying
> system could use this to get write-only mappings if they so wish.

There's also an impact on combining memory attributes, but it's not hugely
clear how that impacts userspace via things like VFIO_DMA_CC_IOMMU.

> There may potentially also be visible differences in translation performance
> between stages, although I imagine that's firmly over in the niche of things
> that users might look at for system validation purposes, rather than for
> practical usefulness.
> 
> > Further qemu
> > never implemented this and no other userspace user is known.
> > 
> > The original description in commit f5c9ecebaf2a ("vfio/iommu_type1: add
> > new VFIO_TYPE1_NESTING_IOMMU IOMMU type") suggested this was to "provide
> > SMMU translation services to the guest operating system" however the rest
> > of the API to set the guest table pointer for the stage 1 was never
> > completed, or at least never upstreamed, rendering this part useless dead
> > code.
> > 
> > Since the current patches to enable nested translation, aka userspace page
> > tables, rely on iommufd and will not use the enable_nesting()
> > iommu_domain_op, remove this infrastructure. However, don't cut too deep
> > into the SMMU drivers for now expecting the iommufd work to pick it up -
> > we still need to create S2 IO page tables.
> > 
> > Remove VFIO_TYPE1_NESTING_IOMMU and everything under it including the
> > enable_nesting iommu_domain_op.
> > 
> > Just in-case there is some userspace using this continue to treat
> > requesting it as a NOP, but do not advertise support any more.
> 
> This also seems a bit odd, especially given that it's not actually a no-op;
> surely either it's supported and functional or it isn't?
> 
> In all honesty, I'm not personally attached to this code either way. If this
> patch had come 5 years ago, when the interface already looked like a bit of
> a dead end, I'd probably have agreed more readily. But now, when we're
> possibly mere months away from implementing the functional equivalent for
> IOMMUFD, which if done right might be able to support a trivial compat layer
> for this anyway, I just don't see what we gain from not at least waiting to
> see where that ends up. The given justification reads as "get rid of this
> code that we already know we'll need to bring back in some form, and
> half-break an unpopular VFIO ABI because it doesn't do *everything* that its
> name might imply", which just isn't convincing me.

I'm inclined to agree although we can very easily revert this patch when we
need to bring the stuff back, it would just be a bit churny.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
