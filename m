Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8812C433F5
	for <iommu@archiver.kernel.org>; Tue, 30 Nov 2021 09:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A1BB606D3;
	Tue, 30 Nov 2021 09:36:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VZ9sPM__4oHt; Tue, 30 Nov 2021 09:36:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 66BD660692;
	Tue, 30 Nov 2021 09:36:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25881C001C;
	Tue, 30 Nov 2021 09:36:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE363C000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 09:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95A0A81DCA
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 09:36:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tyKSUy2SgbzS for <iommu@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 09:36:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C6D180E49
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 09:36:21 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 84BE0CE16B4;
 Tue, 30 Nov 2021 09:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B953BC53FC1;
 Tue, 30 Nov 2021 09:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638264975;
 bh=W1GU/Y+dYM9mor9VhMfyacGdkrH60iHzxrMl5d0x7r8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I0r5AYfW3e1qmmKXMhnPGFNda+jCz4x32KqmgoGbi/4llhlf6BrLG4Dh11TrqOIeu
 6t7GoYuyjI9rTSprKBeCATI3H8ZBljyKTSGOSCnipoGRBXubK/230YXB3/xb4gFMhK
 cetZdMeS2NJYt7HNccWctY4u4f1mgnZpNgCtZJRGxDgqEEEw7kR57CR0PfP0Ionr1G
 xPTqMjy/MGJ4yEDXMUL6xcvp5DKu/6CmLLEBvKhEmLc8LWxQafHEWBJGhbDleY8T/g
 YOwIzg7OkJlOKz2t3lQsamPaqomT2NSf9Bp1mKf8Gg28o2SHvwcvRn0rzb0pd0NzYi
 nyH+dmToW47RQ==
Date: Tue, 30 Nov 2021 09:36:07 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [patch 33/37] iommu/arm-smmu-v3: Use msi_get_virq()
Message-ID: <20211130093607.GA23941@willie-the-truck>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
 <20211129105506.GA22761@willie-the-truck>
 <76a1b5c1-01c8-bb30-6105-b4073dc23065@arm.com>
 <87czmjdnw9.ffs@tglx>
 <b192ad88-5e4e-6f32-1cc7-7a50fc0676a1@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b192ad88-5e4e-6f32-1cc7-7a50fc0676a1@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Ashok Raj <ashok.raj@intel.com>, Marc Zygnier <maz@kernel.org>, x86@kernel.org,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <helgaas@kernel.org>, Megha Dey <megha.dey@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org
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

On Mon, Nov 29, 2021 at 02:54:18PM +0000, Robin Murphy wrote:
> On 2021-11-29 14:42, Thomas Gleixner wrote:
> > On Mon, Nov 29 2021 at 13:13, Robin Murphy wrote:
> > > On 2021-11-29 10:55, Will Deacon wrote:
> > > > > -	}
> > > > > +	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
> > > > > +	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
> > > > > +	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
> > > > 
> > > > Prviously, if retrieval of the MSI failed then we'd fall back to wired
> > > > interrupts. Now, I think we'll clobber the interrupt with 0 instead. Can
> > > > we make the assignments to smmu->*irq here conditional on the MSI being
> > > > valid, please?
> > > 
> > > I was just looking at that too, but reached the conclusion that it's
> > > probably OK, since consumption of this value later is gated on
> > > ARM_SMMU_FEAT_PRI, so the fact that it changes from 0 to an error value
> > > in the absence of PRI should make no practical difference.
> > 
> > It's actually 0 when the vector cannot be found.
> 
> Oh, -1 for my reading comprehension but +1 for my confidence in the patch
> then :)
> 
> I'll let Will have the final say over how cautious we really want to be
> here, but as far as I'm concerned it's a welcome cleanup as-is. Ditto for
> patch #32 based on the same reasoning, although I don't have a suitable test
> platform on-hand to sanity-check that one.

If, as it appears, msi_get_virq() isn't going to fail meaningfully after
we've successfully called platform_msi_domain_alloc_irqs() then it sounds
like the patch is fine. Just wanted to check though, as Spring cleaning at
the end of November raised an eyebrow over here :)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
