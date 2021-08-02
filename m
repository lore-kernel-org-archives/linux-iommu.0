Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776C0C4338F
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 15:14:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31432610A8
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 15:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31432610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00660825C7;
	Mon,  2 Aug 2021 15:14:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qKn5q88hxjZc; Mon,  2 Aug 2021 15:14:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 99EB481C67;
	Mon,  2 Aug 2021 15:14:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B1BBC001B;
	Mon,  2 Aug 2021 15:14:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DE51C000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 361B88254A
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:14:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mSQs_YWEKsDX for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 15:14:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B18D81C67
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:14:16 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C9C160FF2;
 Mon,  2 Aug 2021 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627917255;
 bh=UYOjm0eFhgR8EvFjQmM1ln8mHCxXRZCUDUqH/Bvbfyc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I+L+PP6a5jTfzy3P7sMw1ozlawfViMsG4K1XbMXEN7FNMylVLZukn49Or+IvXjCFf
 vMw+jdh/BQgBnP9wNdZTsPb45W6h9jdnesphww0jMhHlT2zxHkQuOmRbK2W6OcpnrV
 XFbMBWrApX6RisQX8Meh9WBAddgraG1S8IK5FEufYZw6Sm9zaF68fW176PXqIj266L
 yG8Mc8wLP/Xmk2gtV9MIgbmfbXoe8E5XdKdDFIsApjuPza4bI/jK1KJXyIDyS44XJN
 mi0nYqjnKPxx44IFD3m4coN8gQDZOhB9FLfNIfPMHSgXy3CZUFvmibAwxdcGxAAq/p
 cLmIeXXFw8p3Q==
Date: Mon, 2 Aug 2021 16:14:09 +0100
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [Freedreno] [PATCH 0/3] iommu/drm/msm: Allow non-coherent
 masters to use system cache
Message-ID: <20210802151409.GE28735@willie-the-truck>
References: <cover.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <20210728140052.GB22887@mms-0441>
 <8b2742c8891abe4fec3664730717a089@codeaurora.org>
 <20210802105544.GA27657@willie-the-truck>
 <CAF6AEGvtpFu8st=ZFNoKjP9YsAenciLxL1zMFi_iqMCvdby73w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGvtpFu8st=ZFNoKjP9YsAenciLxL1zMFi_iqMCvdby73w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, David Airlie <airlied@linux.ie>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Kristian H Kristensen <hoegsberg@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sean Paul <sean@poorly.run>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Aug 02, 2021 at 08:08:07AM -0700, Rob Clark wrote:
> On Mon, Aug 2, 2021 at 3:55 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Thu, Jul 29, 2021 at 10:08:22AM +0530, Sai Prakash Ranjan wrote:
> > > On 2021-07-28 19:30, Georgi Djakov wrote:
> > > > On Mon, Jan 11, 2021 at 07:45:02PM +0530, Sai Prakash Ranjan wrote:
> > > > > commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag")
> > > > > removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
> > > > > the memory type setting required for the non-coherent masters to use
> > > > > system cache. Now that system cache support for GPU is added, we will
> > > > > need to set the right PTE attribute for GPU buffers to be sys cached.
> > > > > Without this, the system cache lines are not allocated for GPU.
> > > > >
> > > > > So the patches in this series introduces a new prot flag IOMMU_LLC,
> > > > > renames IO_PGTABLE_QUIRK_ARM_OUTER_WBWA to IO_PGTABLE_QUIRK_PTW_LLC
> > > > > and makes GPU the user of this protection flag.
> > > >
> > > > Thank you for the patchset! Are you planning to refresh it, as it does
> > > > not apply anymore?
> > > >
> > >
> > > I was waiting on Will's reply [1]. If there are no changes needed, then
> > > I can repost the patch.
> >
> > I still think you need to handle the mismatched alias, no? You're adding
> > a new memory type to the SMMU which doesn't exist on the CPU side. That
> > can't be right.
> >
> 
> Just curious, and maybe this is a dumb question, but what is your
> concern about mismatched aliases?  I mean the cache hierarchy on the
> GPU device side (anything beyond the LLC) is pretty different and
> doesn't really care about the smmu pgtable attributes..

If the CPU accesses a shared buffer with different attributes to those which
the device is using then you fall into the "mismatched memory attributes"
part of the Arm architecture. It's reasonably unforgiving (you should go and
read it) and in some cases can apply to speculative accesses as well, but
the end result is typically loss of coherency.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
