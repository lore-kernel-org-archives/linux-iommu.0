Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D853C433E0
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 15:18:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0389E207FB
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 15:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQlgb2ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0389E207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A62F886AE3;
	Mon, 18 May 2020 15:18:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fn4uDKYPTBKp; Mon, 18 May 2020 15:18:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8C8C186435;
	Mon, 18 May 2020 15:18:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E8CBC0888;
	Mon, 18 May 2020 15:18:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D614C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5A47C2152C
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:18:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t0VesNYnoym6 for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 15:18:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 38E8320335
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:18:44 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF82C207D3;
 Mon, 18 May 2020 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589815124;
 bh=7pn0POB44tC2n5gNnVjv3NxibG0KtevFb7C2erURwxI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aQlgb2ic/mmOg59kHAC86otewooCNikOj5trO7coH/eQB25WXcK7PtMEKDq5pBxcu
 amwAXY1BjRUtiKaElfjc3FaaluZEN7s5g9mKh0QqG7l+Vkz2HAHOAi3YVT7/tW4P9I
 fA1MHiWy8zQdn70CubreIQvELhUeLbBN/VvOkpcM=
Date: Mon, 18 May 2020 16:18:39 +0100
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v1 2/6] arm/smmu: Add auxiliary domain support for
 arm-smmuv2
Message-ID: <20200518151838.GL32394@willie-the-truck>
References: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
 <1580249770-1088-3-git-send-email-jcrouse@codeaurora.org>
 <20200318224840.GA10796@willie-the-truck>
 <CAF6AEGu-hj6=3rsCe5XeBq_ffoq9VFmL+ycrQ8N=iv89DZf=8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGu-hj6=3rsCe5XeBq_ffoq9VFmL+ycrQ8N=iv89DZf=8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Wed, Mar 18, 2020 at 04:43:07PM -0700, Rob Clark wrote:
> On Wed, Mar 18, 2020 at 3:48 PM Will Deacon <will@kernel.org> wrote:
> > On Tue, Jan 28, 2020 at 03:16:06PM -0700, Jordan Crouse wrote:
> > > Support auxiliary domains for arm-smmu-v2 to initialize and support
> > > multiple pagetables for a single SMMU context bank. Since the smmu-v2
> > > hardware doesn't have any built in support for switching the pagetable
> > > base it is left as an exercise to the caller to actually use the pagetable.
> > >
> > > Aux domains are supported if split pagetable (TTBR1) support has been
> > > enabled on the master domain.  Each auxiliary domain will reuse the
> > > configuration of the master domain. By default the a domain with TTBR1
> > > support will have the TTBR0 region disabled so the first attached aux
> > > domain will enable the TTBR0 region in the hardware and conversely the
> > > last domain to be detached will disable TTBR0 translations.  All subsequent
> > > auxiliary domains create a pagetable but not touch the hardware.
> > >
> > > The leaf driver will be able to query the physical address of the
> > > pagetable with the DOMAIN_ATTR_PTBASE attribute so that it can use the
> > > address with whatever means it has to switch the pagetable base.
> > >
> > > Following is a pseudo code example of how a domain can be created
> > >
> > >  /* Check to see if aux domains are supported */
> > >  if (iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)) {
> > >        iommu = iommu_domain_alloc(...);
> > >
> > >        if (iommu_aux_attach_device(domain, dev))
> > >                return FAIL;
> > >
> > >       /* Save the base address of the pagetable for use by the driver
> > >       iommu_domain_get_attr(domain, DOMAIN_ATTR_PTBASE, &ptbase);
> > >  }
> >
> > I'm not really understanding what the pagetable base gets used for here and,
> > to be honest with you, the whole thing feels like a huge layering violation
> > with the way things are structured today. Why doesn't the caller just
> > interface with io-pgtable directly?
> >
> > Finally, if we need to support context-switching TTBR0 for a live domain
> > then that code really needs to live inside the SMMU driver because the
> > ASID and TLB management necessary to do that safely doesn't belong anywhere
> > else.
> 
> We do in fact need live domain switching, that is really the whole
> point.  The GPU CP (command processor/parser) is directly updating
> TTBR0 and triggering TLB flush, asynchronously from the CPU.
> 
> And I think the answer about ASID is easy (on current hw).. it must be zero[*].

Using ASID zero is really bad, because it means that you will end up sharing
TLB entries with whichever device is using context bank 0.

Is the SMMU only used by the GPU in your SoC?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
