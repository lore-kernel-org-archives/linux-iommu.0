Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05E9C433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 06:21:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4114F60DE5;
	Tue, 12 Apr 2022 06:21:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mcxCpg6NPCDY; Tue, 12 Apr 2022 06:21:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F1DD360F39;
	Tue, 12 Apr 2022 06:21:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2E20C0082;
	Tue, 12 Apr 2022 06:21:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B94A4C002F
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 06:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A07FE83E7B
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 06:21:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KGcdEWcruodz for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 06:21:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B22588348C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 06:21:27 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id CD9FC68AA6; Tue, 12 Apr 2022 08:21:20 +0200 (CEST)
Date: Tue, 12 Apr 2022 08:21:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 10/15] swiotlb: add a SWIOTLB_ANY flag to lift the low
 memory restriction
Message-ID: <20220412062120.GA7796@lst.de>
References: <20220404050559.132378-1-hch@lst.de>
 <20220404050559.132378-11-hch@lst.de> <Yk4vfAd0J5u+wUsq@char.us.oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yk4vfAd0J5u+wUsq@char.us.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-hyperv@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
 tboot-devel@lists.sourceforge.net, xen-devel@lists.xenproject.org,
 David Woodhouse <dwmw2@infradead.org>, Tom Lendacky <thomas.lendacky@amd.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Apr 06, 2022 at 08:25:32PM -0400, Konrad Rzeszutek Wilk wrote:
> > diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
> > index c5228f4969eb2..3b4045d508ec8 100644
> > --- a/arch/powerpc/platforms/pseries/svm.c
> > +++ b/arch/powerpc/platforms/pseries/svm.c
> > @@ -28,7 +28,7 @@ static int __init init_svm(void)
> >  	 * need to use the SWIOTLB buffer for DMA even if dma_capable() says
> >  	 * otherwise.
> >  	 */
> > -	swiotlb_force = SWIOTLB_FORCE;
> > +	ppc_swiotlb_flags |= SWIOTLB_ANY | SWIOTLB_FORCE;
> 
> This is the only place you set the ppc_swiotlb_flags.. so I wonder why
> the '|=' instead of just '=' ?

Preparing for setting others and not clobbering the value.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
