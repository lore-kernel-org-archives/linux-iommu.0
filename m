Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A890C433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 12:19:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3726382897;
	Wed,  8 Dec 2021 12:19:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IlSvXURm25rW; Wed,  8 Dec 2021 12:19:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1D40282B08;
	Wed,  8 Dec 2021 12:19:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02752C001E;
	Wed,  8 Dec 2021 12:19:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65D60C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 12:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 54B3D41D93
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 12:19:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4glHvR7zoxyk for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 12:19:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 441D841CC5
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 12:19:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 885C81042;
 Wed,  8 Dec 2021 04:19:02 -0800 (PST)
Received: from e123427-lin.cambridge.arm.com (unknown [10.57.36.149])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4DB33F73B;
 Wed,  8 Dec 2021 04:18:59 -0800 (PST)
Date: Wed, 8 Dec 2021 12:18:54 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jon Nettleton <jon@solid-run.com>
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
Message-ID: <20211208121854.GA7317@e123427-lin.cambridge.arm.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <e24df2a9-1332-0eb3-b52a-230662fe46ba@arm.com>
 <CABdtJHvY5XnQN7wgQ9D8Zcu-NgHRmaUMFPgaPGZwM+AhmVpULw@mail.gmail.com>
 <3225875e-ebd9-6378-e92c-ed3894d8aedc@arm.com>
 <CABdtJHsOShKrRMp33JvbVKuTMLEcHQKaDw0wtZ0igoeGeWJTQg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABdtJHsOShKrRMp33JvbVKuTMLEcHQKaDw0wtZ0igoeGeWJTQg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>,
 Steven Price <steven.price@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>, Sami Mujawar <Sami.Mujawar@arm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Tue, Oct 12, 2021 at 10:00:24AM +0200, Jon Nettleton wrote:
> On Mon, Oct 11, 2021 at 4:04 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2021-10-09 08:06, Jon Nettleton wrote:
> > [...]
> > >>> +             if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
> > >>> +                     type = IOMMU_RESV_DIRECT_RELAXABLE;
> > >>> +                     /*
> > >>> +                      * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
> > >>> +                      * normally used for allocated system memory that is
> > >>> +                      * then used for device specific reserved regions.
> > >>> +                      */
> > >>> +                     prot |= IOMMU_CACHE;
> > >>> +             } else {
> > >>> +                     type = IOMMU_RESV_DIRECT;
> > >>> +                     /*
> > >>> +                      * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally used
> > >>> +                      * for device memory like MSI doorbell.
> > >>> +                      */
> > >>> +                     prot |= IOMMU_MMIO;
> > >>> +             }
> > >>
> > >> I'm not sure we ever got a definitive answer to this - does DPAA2
> > >> actually go wrong if we use IOMMU_MMIO here? I'd still much prefer to
> > >> make the fewest possible assumptions, since at this point it's basically
> > >> just a stop-gap until we can fix the spec. It's become clear that we
> > >> can't reliably rely on guessing attributes, so I'm not too fussed about
> > >> theoretical cases that currently don't work (due to complete lack of RMR
> > >> support) continuing to not work for the moment, as long as we can make
> > >> the real-world cases we actually have work at all. Anything which only
> > >> affects performance I'd rather leave until firmware can tell us what to do.
> > >
> > > Well it isn't DPAA2, it is FSL_MC_BUS that fails with IOMMU_MMIO
> > > mappings.  DPAA2 is just one connected device.
> >
> > Apologies if I'm being overly loose with terminology there - my point of
> > reference for this hardware is documentation for the old LS2080A, where
> > the "DPAA2 Reference Manual" gives a strong impression that the MC is a
> > component belonging to the overall DPAA2 architecture. Either way it
> > technically stands to reason that the other DPAA2 components would only
> > be usable if the MC itself works (unless I've been holding a major
> > misconception about that for years as well).
> >
> > In the context of this discussion, please consider any reference I may
> > make to bits of NXP's hardware to be shorthand for "the thing for which
> > NXP have a vested interest in IORT RMRs".
> 
> Ultimately the spec doesn't mention what IOMMU properties the regions
> should have.

It will have to and that's what we are working on.

> Even marking them as IOMMU_READ/WRITE is as much of an assumption as
> using IOMMU_MMIO or IOMMU_CACHE. It just seems IOMMU_MMIO is the most
> popular since all the examples use it for MSI doorbells in the
> documentation.

We don't merge code based on assumptions that can easily break because
the specifications don't contemplate the details that are required.

> I am interested why this concern is only being brought up at this point
> on a patchset that has been on the mailing list for 8+ months? 

See above. We don't merge code that we know can break and is based on
assumptions, we need to update the IORT specifications to make them
cover all the use cases - in a predictable way - and that's what we are
working on.

> This is based on a spec that has existed from Arm since 2020 with the
> most recent revisions published in Feb 2021.  The lack of RMR support
> in the kernel is affecting real world products, and the ability for
> SystemReady ES certified systems from just fully working with recent
> distributions.

I answered above - if you have any questions please ask them, here,
as far as Linux code is concerned.

I understand this is taking a long time, it is also helping us
understand all the possible use cases and how to cover them in
a way that is maintainable in the long run.

Thanks,
Lorenzo

> Even worse, is that without this patchset customers are forced to jump
> through hoops to purposefully re-enable smmu bypass making their
> systems less secure.
> 
> How is this a good experience for customers of SystemReady hardware
> when for any mainline distribution to work the first thing they have
> to do is make their system less secure?
> 
> -Jon
> 
> >
> > Thanks,
> > Robin.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
