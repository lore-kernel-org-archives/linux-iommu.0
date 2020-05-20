Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11276C433E1
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 12:57:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE0B2070A
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 12:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zkn/FJDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE0B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AC1B881AEE;
	Wed, 20 May 2020 12:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xMRU-0NXyfYT; Wed, 20 May 2020 12:57:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2C10B87B1D;
	Wed, 20 May 2020 12:57:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12DCBC088A;
	Wed, 20 May 2020 12:57:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A052C0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 12:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6019186D4D
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 12:57:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hoyxoXBYjJHA for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 12:57:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EA54686C92
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 12:57:05 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 836572070A;
 Wed, 20 May 2020 12:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589979425;
 bh=1P2e+BY8TZ0h6Yd53TbsOZuyfQmxWpY2o80nVEhI8us=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zkn/FJDugptcSPb2TlufybwUBXf+t2GBlQWkTf8jsh05woVtd9F2NBuNpIkwAhcPq
 vQSKaQkD8Olh0FxCizpxzW306pp2xZjyRQvbrVj7U6ggrIu87F74GQujz5nVriZfa9
 Y8Z2V42UPxkqE/DkdjVUyWIuT6YtAHiFOH8Vodt0=
Date: Wed, 20 May 2020 13:57:01 +0100
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v1 2/6] arm/smmu: Add auxiliary domain support for
 arm-smmuv2
Message-ID: <20200520125700.GD25815@willie-the-truck>
References: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
 <1580249770-1088-3-git-send-email-jcrouse@codeaurora.org>
 <20200318224840.GA10796@willie-the-truck>
 <CAF6AEGu-hj6=3rsCe5XeBq_ffoq9VFmL+ycrQ8N=iv89DZf=8Q@mail.gmail.com>
 <20200518151838.GL32394@willie-the-truck>
 <CAF6AEGswv3ZaJyy_kYv6FKAjO5=_juDwEtK+VE9TcVMLGvrdwA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGswv3ZaJyy_kYv6FKAjO5=_juDwEtK+VE9TcVMLGvrdwA@mail.gmail.com>
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

On Mon, May 18, 2020 at 08:50:27AM -0700, Rob Clark wrote:
> On Mon, May 18, 2020 at 8:18 AM Will Deacon <will@kernel.org> wrote:
> > On Wed, Mar 18, 2020 at 04:43:07PM -0700, Rob Clark wrote:
> > > We do in fact need live domain switching, that is really the whole
> > > point.  The GPU CP (command processor/parser) is directly updating
> > > TTBR0 and triggering TLB flush, asynchronously from the CPU.
> > >
> > > And I think the answer about ASID is easy (on current hw).. it must be zero[*].
> >
> > Using ASID zero is really bad, because it means that you will end up sharing
> > TLB entries with whichever device is using context bank 0.
> >
> > Is the SMMU only used by the GPU in your SoC?
> >
> 
> yes, the snapdragon SoCs have two SMMU instances, one used by the GPU,
> where ASID0/cb0 is the gpu itself, and another cb is the GMU
> (basically power control for the gpu), and the second SMMU is
> everything else.

Right, in which case I'm starting to think that we should treat this GPU
SMMU instance specially. Give it its own compatible string (looks like you
need this for HUPCFG anyway) and hook in via arm_smmu_impl_init(). You can
then set IO_PGTABLE_QUIRK_ARM_TTBR1 when talking to the io-pgtable code
without having to add a domain attribute.

With that. you'll need to find a way to allow the GPU driver to call into
your own hooks for getting at the TTBR0 tables -- given that you're
programming these in the hardware, I don't think it makes sense to expose
that in the IOMMU API, since most devices won't be able to do anything with
that data. Perhaps you could install a couple of function pointers
(subdomain_alloc/subdomain_free) in the GPU device when you see it appear
from the SMMU driver? Alternatively, you could make an io_pgtable_cfg
available so that the GPU driver can interface with io-pgtable directly.

Yes, it's ugly, but I don't think it's worth trying to abstract this.

Thoughts? It's taken me a long time to figure out what's going on here,
so sorry if it feels like I'm leading you round the houses.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
