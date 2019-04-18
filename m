Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20604C10F0E
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 23:42:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D71CC20675
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 23:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/qBST9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71CC20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A4B7C2131;
	Thu, 18 Apr 2019 23:42:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 60570212D
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 23:42:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 00E61828
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 23:42:43 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4953920675;
	Thu, 18 Apr 2019 23:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555630963;
	bh=JEAOgYJlOvZdMdVyDXHifM67i+2PUhKtJ1YzNTJp9lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/qBST9ORsR60kh4OyKwZYSNPLU1KtkPCKOL2msKqvW3FvPnRVcysWhpIFE8F4jnK
	Bcc1w4IWiGv3jVOdq+RBcREQuURZ/9F+kvZtdPtL8nCOrd5kkKoTpYUdzS2ZZgkRyq
	Og5o5Esmo8zurb+diXzEdBOfP6V4B5PxeOi4MEZs=
Date: Thu, 18 Apr 2019 18:42:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
Message-ID: <20190418234241.GF126710@google.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
	<20190412223409.GB126710@google.com>
	<CABe79T7h9t_Obmo3+B0MHgLZ4ff9GxpBBBLGtSf0C=zmLrWVBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABe79T7h9t_Obmo3+B0MHgLZ4ff9GxpBBBLGtSf0C=zmLrWVBQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: poza@codeaurora.org, Ray Jui <rjui@broadcom.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190418234241.ftna1U9X4dyKBeJkWpYQ5HbvdGkzUzlXukK-ta0aAbQ@z>

On Tue, Apr 16, 2019 at 05:28:36PM +0530, Srinath Mannam wrote:
> On Sat, Apr 13, 2019 at 4:04 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
> > > Few SOCs have limitation that their PCIe host can't allow few inbound
> > > address ranges. Allowed inbound address ranges are listed in dma-ranges
> > > DT property and this address ranges are required to do IOVA mapping.
> > > Remaining address ranges have to be reserved in IOVA mapping.
>
> > If I understand correctly, devices below these PCIe host bridges can
> > DMA only to the listed address ranges, and you prevent devices from
> > doing DMA to the holes between the listed ranges by reserving the
> > holes in dma-iommu.
>
> Yes, devices below these PCIe host bridges can DMA only to the listed
> address ranges,
> and this patch prevents to allocate DMA(IOVA) addresses in the holes
> of listed ranges.
>
> > Apparently there's something that makes sure driver dma_map_*() always
> > goes through dma-iommu?  I traced as far as seeing that dma-iommu
> > depends on CONFIG_IOMMU_DMA, and that arm64 selects CONFIG_IOMMU_DMA
> > if CONFIG_IOMMU_SUPPORT, but then the trail got cold.  I didn't see
> > what selects CONFIG_IOMMU_SUPPORT.
>
> IOMMU_SUPPORT depends on MMU.

Yes, I see that IOMMU_SUPPORT depends on MMU (in
drivers/iommu/Kconfig).  But that doesn't *select* IOMMU_SUPPORT; it
only means you *can't* select it unless MMU has already been selected.

I think you only get dma-iommu if you choose to select IOMMU_SUPPORT
via menuconfig or whatever, and the current config rules allow you to
turn that off.  Maybe that's OK, I dunno.  If you do turn it off, I
guess we'll ignore the holes in "dma-ranges" and devices will be able
to DMA to the holes.

> > This does look like what Robin suggested, as far as I can tell.
> > Hopefully he'll take a look and give his reviewed-by.  Thanks for
> > persevering!
> Thank you.
> 
> Regards,
> Srinath.
> >
> > > PCIe Host driver of those SOCs has to list resource entries of allowed
> > > address ranges given in dma-ranges DT property in sorted order. This
> > > sorted list of resources will be processed and reserve IOVA address for
> > > inaccessible address holes while initializing IOMMU domain.
> > >
> > > This patch set is based on Linux-5.0-rc2.
> > >
> > > Changes from v3:
> > >   - Addressed Robin Murphy review comments.
> > >     - pcie-iproc: parse dma-ranges and make sorted resource list.
> > >     - dma-iommu: process list and reserve gaps between entries
> > >
> > > Changes from v2:
> > >   - Patch set rebased to Linux-5.0-rc2
> > >
> > > Changes from v1:
> > >   - Addressed Oza review comments.
> > >
> > > Srinath Mannam (3):
> > >   PCI: Add dma_ranges window list
> > >   iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
> > >   PCI: iproc: Add sorted dma ranges resource entries to host bridge
> > >
> > >  drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
> > >  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
> > >  drivers/pci/probe.c                 |  3 +++
> > >  include/linux/pci.h                 |  1 +
> > >  4 files changed, 66 insertions(+), 1 deletion(-)
> > >
> > > --
> > > 2.7.4
> > >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
