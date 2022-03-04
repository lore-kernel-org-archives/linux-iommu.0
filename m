Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5033BC433FE
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 16:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F01B760881;
	Fri,  4 Mar 2022 16:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8bzlI-ZW9Xou; Fri,  4 Mar 2022 16:34:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E5CA760810;
	Fri,  4 Mar 2022 16:34:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC280C0012;
	Fri,  4 Mar 2022 16:34:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A86CC000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 16:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7400E60810
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 16:34:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GPJ9otjo_N_l for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 16:34:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C36F60758
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 16:34:37 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id E2BFF68AFE; Fri,  4 Mar 2022 17:34:30 +0100 (CET)
Date: Fri, 4 Mar 2022 17:34:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH 11/12] swiotlb: merge swiotlb-xen initialization into
 swiotlb
Message-ID: <20220304163430.GA12317@lst.de>
References: <20220301105311.885699-1-hch@lst.de>
 <20220301105311.885699-12-hch@lst.de>
 <alpine.DEB.2.22.394.2203011720150.3261@ubuntu-linux-20-04-desktop>
 <20220302081500.GB23075@lst.de>
 <alpine.DEB.2.22.394.2203021709470.3261@ubuntu-linux-20-04-desktop>
 <20220303105931.GA15137@lst.de>
 <alpine.DEB.2.22.394.2203031447120.3261@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2203031447120.3261@ubuntu-linux-20-04-desktop>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 tboot-devel@lists.sourceforge.net, xen-devel@lists.xenproject.org,
 David Woodhouse <dwmw2@infradead.org>, Tom Lendacky <thomas.lendacky@amd.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-mips@vger.kernel.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
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

On Thu, Mar 03, 2022 at 02:49:29PM -0800, Stefano Stabellini wrote:
> On Thu, 3 Mar 2022, Christoph Hellwig wrote:
> > On Wed, Mar 02, 2022 at 05:25:10PM -0800, Stefano Stabellini wrote:
> > > Thinking more about it we actually need to drop the xen_initial_domain()
> > > check otherwise some cases won't be functional (Dom0 not 1:1 mapped, or
> > > DomU 1:1 mapped).
> > 
> > Hmm, but that would be the case even before this series, right?
> 
> Before this series we only have the xen_swiotlb_detect() check in
> xen_mm_init, we don't have a second xen_initial_domain() check.
> 
> The issue is that this series is adding one more xen_initial_domain()
> check in xen_mm_init.

In current mainline xen_mm_init calls xen_swiotlb_init unconditionally.
But xen_swiotlb_init then calls xen_swiotlb_fixup after allocating
the memory, which in turn calls xen_create_contiguous_region.
xen_create_contiguous_region fails with -EINVAL for the
!xen_initial_domain() and thus caues xen_swiotlb_fixup and
xen_swiotlb_init to unwind and return -EINVAL.

So as far as I can tell there is no change in behavior, but maybe I'm
missing something subtle?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
