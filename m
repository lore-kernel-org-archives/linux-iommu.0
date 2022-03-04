Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9C8C433FE
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 17:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BFF4C40521;
	Fri,  4 Mar 2022 17:43:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id liImXi9B8Twx; Fri,  4 Mar 2022 17:43:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7756140160;
	Fri,  4 Mar 2022 17:43:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AAF9C001D;
	Fri,  4 Mar 2022 17:43:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B56A1C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 17:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D79360AF0
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 17:43:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3eCmHbCYXAnI for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 17:43:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D92A5607BC
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 17:43:14 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 18C7068BEB; Fri,  4 Mar 2022 18:43:09 +0100 (CET)
Date: Fri, 4 Mar 2022 18:43:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 11/12] swiotlb: merge swiotlb-xen initialization into
 swiotlb
Message-ID: <20220304174308.GA13515@lst.de>
References: <20220301105311.885699-1-hch@lst.de>
 <20220301105311.885699-12-hch@lst.de>
 <alpine.DEB.2.22.394.2203011720150.3261@ubuntu-linux-20-04-desktop>
 <ca748512-12bb-7d75-13f1-8d5ec9703e26@oracle.com>
 <20220304172859.GA12860@lst.de>
 <fc3992a8-896b-f0fc-e500-9010ec085c57@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fc3992a8-896b-f0fc-e500-9010ec085c57@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 tboot-devel@lists.sourceforge.net, xen-devel@lists.xenproject.org,
 David Woodhouse <dwmw2@infradead.org>, Tom Lendacky <thomas.lendacky@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
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

On Fri, Mar 04, 2022 at 12:36:17PM -0500, Boris Ostrovsky wrote:
>>> I bisected it to "x86: remove the IOMMU table infrastructure" but haven't actually looked at the code yet.
>> That looks like the swiotlb buffer did not get initialized at all, but I
>> can't really explain why.
>>
>> Can you stick in a printk and see if xen_swiotlb_init_early gets called
>> at all?
>
>
>
> Actually, that's the only thing I did do so far and yes, it does get called.

So, specifically for "x86: remove the IOMMU table infrastructure" I
think we need the one-liner below so that swiotlb_exit doesn't get called
for the Xen case.  But that should have been fixed up by the next
patch already.

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 2ac0ef9c2fb76..1173aa282ab27 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -70,7 +70,7 @@ static void __init pci_xen_swiotlb_init(void)
 	if (!xen_initial_domain() && !x86_swiotlb_enable &&
 	    swiotlb_force != SWIOTLB_FORCE)
 		return;
-	x86_swiotlb_enable = false;
+	x86_swiotlb_enable = true;
 	xen_swiotlb = true;
 	xen_swiotlb_init_early();
 	dma_ops = &xen_swiotlb_dma_ops;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
