Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76EDC4338F
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 17:05:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CF061019
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 17:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94CF061019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FDD4606EB;
	Mon,  9 Aug 2021 17:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Q_JdHf7UtOS; Mon,  9 Aug 2021 17:05:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 346166065F;
	Mon,  9 Aug 2021 17:05:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C637C0010;
	Mon,  9 Aug 2021 17:05:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 036C1C000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 17:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D90C2606EB
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 17:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lLuc6rvWkq2B for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 17:05:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B7246065F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 17:05:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CFFE60EDF;
 Mon,  9 Aug 2021 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628528714;
 bh=RMEf6LXCfJbK+5TTchOmMqltVVe9V4z4Y8ERl5RAQFM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bZ4bYvr9of3IX6/kJXELIQD0M2qMjKO/Tan+GITh8wWQ1xSzJ15p8SsyetE3oiIzO
 WyMXatW+Of8xKEO76q4JvIbfaWjyTrAmrDnTn03Q503o1YabO6BzpzyD9tdCVwzs5I
 eH4f56y7dm5DgKRASUgB9iQ13s+qNMpQhL6oc/4sFQk0CdetzetYY7mJA3DwCXK1qW
 5uSLMUin1RmapmmEFqeNsfczb85mWu1PRd2oq13lek/PmL4Wzw3iacr0/KIB6Orr97
 eMicvuMLzITfHMHptVFn045cthfAOhVRD1nrz8TIKUivzvKoiTlrQWzD/flcYUY50Z
 ESCe01X25SoOQ==
Date: Mon, 9 Aug 2021 18:05:08 +0100
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [Freedreno] [PATCH 0/3] iommu/drm/msm: Allow non-coherent
 masters to use system cache
Message-ID: <20210809170508.GB1589@willie-the-truck>
References: <cover.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <20210728140052.GB22887@mms-0441>
 <8b2742c8891abe4fec3664730717a089@codeaurora.org>
 <20210802105544.GA27657@willie-the-truck>
 <CAF6AEGvtpFu8st=ZFNoKjP9YsAenciLxL1zMFi_iqMCvdby73w@mail.gmail.com>
 <20210802151409.GE28735@willie-the-truck>
 <CAF6AEGtzvyEUm0Fc8QT5t9KNK7i0FbFyi7zDM2_PMCzZBp7qbw@mail.gmail.com>
 <20210809145651.GC1458@willie-the-truck>
 <CAF6AEGsSUojA=V0n2iRWTCn++buqN=Eoxo0r3=+=PBu1O=H-AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGsSUojA=V0n2iRWTCn++buqN=Eoxo0r3=+=PBu1O=H-AQ@mail.gmail.com>
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

On Mon, Aug 09, 2021 at 09:57:08AM -0700, Rob Clark wrote:
> On Mon, Aug 9, 2021 at 7:56 AM Will Deacon <will@kernel.org> wrote:
> > On Mon, Aug 02, 2021 at 06:36:04PM -0700, Rob Clark wrote:
> > > On Mon, Aug 2, 2021 at 8:14 AM Will Deacon <will@kernel.org> wrote:
> > > > On Mon, Aug 02, 2021 at 08:08:07AM -0700, Rob Clark wrote:
> > > > > On Mon, Aug 2, 2021 at 3:55 AM Will Deacon <will@kernel.org> wrote:
> > > > > > On Thu, Jul 29, 2021 at 10:08:22AM +0530, Sai Prakash Ranjan wrote:
> > > > > > > On 2021-07-28 19:30, Georgi Djakov wrote:
> > > > > > > > On Mon, Jan 11, 2021 at 07:45:02PM +0530, Sai Prakash Ranjan wrote:
> > > > > > > > > commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag")
> > > > > > > > > removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
> > > > > > > > > the memory type setting required for the non-coherent masters to use
> > > > > > > > > system cache. Now that system cache support for GPU is added, we will
> > > > > > > > > need to set the right PTE attribute for GPU buffers to be sys cached.
> > > > > > > > > Without this, the system cache lines are not allocated for GPU.
> > > > > > > > >
> > > > > > > > > So the patches in this series introduces a new prot flag IOMMU_LLC,
> > > > > > > > > renames IO_PGTABLE_QUIRK_ARM_OUTER_WBWA to IO_PGTABLE_QUIRK_PTW_LLC
> > > > > > > > > and makes GPU the user of this protection flag.
> > > > > > > >
> > > > > > > > Thank you for the patchset! Are you planning to refresh it, as it does
> > > > > > > > not apply anymore?
> > > > > > > >
> > > > > > >
> > > > > > > I was waiting on Will's reply [1]. If there are no changes needed, then
> > > > > > > I can repost the patch.
> > > > > >
> > > > > > I still think you need to handle the mismatched alias, no? You're adding
> > > > > > a new memory type to the SMMU which doesn't exist on the CPU side. That
> > > > > > can't be right.
> > > > > >
> > > > >
> > > > > Just curious, and maybe this is a dumb question, but what is your
> > > > > concern about mismatched aliases?  I mean the cache hierarchy on the
> > > > > GPU device side (anything beyond the LLC) is pretty different and
> > > > > doesn't really care about the smmu pgtable attributes..
> > > >
> > > > If the CPU accesses a shared buffer with different attributes to those which
> > > > the device is using then you fall into the "mismatched memory attributes"
> > > > part of the Arm architecture. It's reasonably unforgiving (you should go and
> > > > read it) and in some cases can apply to speculative accesses as well, but
> > > > the end result is typically loss of coherency.
> > >
> > > Ok, I might have a few other sections to read first to decipher the
> > > terminology..
> > >
> > > But my understanding of LLC is that it looks just like system memory
> > > to the CPU and GPU (I think that would make it "the point of
> > > coherence" between the GPU and CPU?)  If that is true, shouldn't it be
> > > invisible from the point of view of different CPU mapping options?
> >
> > You could certainly build a system where mismatched attributes don't cause
> > loss of coherence, but as it's not guaranteed by the architecture and the
> > changes proposed here affect APIs which are exposed across SoCs, then I
> > don't think it helps much.
> >
> 
> Hmm, the description of the new mapping flag is that it applies only
> to transparent outer level cache:
> 
> +/*
> + * Non-coherent masters can use this page protection flag to set cacheable
> + * memory attributes for only a transparent outer level of cache, also known as
> + * the last-level or system cache.
> + */
> +#define IOMMU_LLC      (1 << 6)
> 
> But I suppose we could call it instead IOMMU_QCOM_LLC or something
> like that to make it more clear that it is not necessarily something
> that would work with a different outer level cache implementation?

... or we could just deal with the problem so that other people can reuse
the code. I haven't really understood the reluctance to solve this properly.

Am I missing some reason this isn't solvable?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
