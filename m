Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034C6C83004
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 18:46:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B86206A1
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 18:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpFe5bw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B86206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9911885BCC;
	Tue, 28 Apr 2020 18:46:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2NkmzKk4A8MD; Tue, 28 Apr 2020 18:46:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F133585BC9;
	Tue, 28 Apr 2020 18:46:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C09CFC0864;
	Tue, 28 Apr 2020 18:46:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8422BC0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 18:46:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 71F9F86EB1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 18:46:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a5E7v6tIDfRb for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 18:46:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CFD0286DC6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 18:46:42 +0000 (UTC)
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 36DFA206A1;
 Tue, 28 Apr 2020 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588099602;
 bh=dhUsOr1v2mBAanhqQ0gOmvuHvZAHd5hliZZQ3LNcyPk=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=rpFe5bw3nYfTZI/Fw4t782dUbbzbY/e1wgEYuElBHaqtvWX/hfJsEsGLS2XuWDjW+
 bIa1bjuq3y0DPZGSRea+vJdpT7vRGCrl1tbdpGUSeE9+xCmrQUgbqzVktKSAA0Vkgk
 G9OeZjGFgkrrokBQpvUJ6AmBsdTd+Dw9M6vbLLqs=
Date: Tue, 28 Apr 2020 11:46:41 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: =?UTF-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>
Subject: Re: [PATCH] xen/swiotlb: correct the check for
 xen_destroy_contiguous_region
In-Reply-To: <1c01e97a-adcd-a703-55b5-8975b4ce4d2c@suse.com>
Message-ID: <alpine.DEB.2.21.2004281118130.29217@sstabellini-ThinkPad-T480s>
References: <1588059225-11245-1-git-send-email-peng.fan@nxp.com>
 <1c01e97a-adcd-a703-55b5-8975b4ce4d2c@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-325783116-1588098351=:29217"
Content-ID: <alpine.DEB.2.21.2004281125590.29217@sstabellini-ThinkPad-T480s>
Cc: peng.fan@nxp.com, sstabellini@kernel.org, konrad.wilk@oracle.com,
 linux-kernel@vger.kernel.org, hch@infradead.org,
 iommu@lists.linux-foundation.org, linux-imx@nxp.com,
 xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-325783116-1588098351=:29217
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.2004281125591.29217@sstabellini-ThinkPad-T480s>

On Tue, 28 Apr 2020, Jürgen Groß wrote:
> On 28.04.20 09:33, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > When booting xen on i.MX8QM, met:
> > "
> > [    3.602128] Unable to handle kernel paging request at virtual address
> > 0000000000272d40
> > [    3.610804] Mem abort info:
> > [    3.613905]   ESR = 0x96000004
> > [    3.617332]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    3.623211]   SET = 0, FnV = 0
> > [    3.626628]   EA = 0, S1PTW = 0
> > [    3.630128] Data abort info:
> > [    3.633362]   ISV = 0, ISS = 0x00000004
> > [    3.637630]   CM = 0, WnR = 0
> > [    3.640955] [0000000000272d40] user address but active_mm is swapper
> > [    3.647983] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > [    3.654137] Modules linked in:
> > [    3.677285] Hardware name: Freescale i.MX8QM MEK (DT)
> > [    3.677302] Workqueue: events deferred_probe_work_func
> > [    3.684253] imx6q-pcie 5f000000.pcie: PCI host bridge to bus 0000:00
> > [    3.688297] pstate: 60000005 (nZCv daif -PAN -UAO)
> > [    3.688310] pc : xen_swiotlb_free_coherent+0x180/0x1c0
> > [    3.693993] pci_bus 0000:00: root bus resource [bus 00-ff]
> > [    3.701002] lr : xen_swiotlb_free_coherent+0x44/0x1c0
> > "
> > 
> > In xen_swiotlb_alloc_coherent, if !(dev_addr + size - 1 <= dma_mask) or
> > range_straddles_page_boundary(phys, size) are true, it will
> > create contiguous region. So when free, we need to free contiguous
> > region use upper check condition.
> 
> No, this will break PV guests on x86.
> 
> I think there is something wrong with your setup in combination with
> the ARM xen_create_contiguous_region() implementation.
> 
> Stefano?

Let me start by asking Peng a couple of questions:


Peng, could you please add a printk to check which one of the two
conditions is True for you?  Is it (dev_addr + size - 1 > dma_mask) or
range_straddles_page_boundary(phys, size)?

Is hwdev->coherent_dma_mask set for your DMA capable device?

Finally, is this patch supposed to fix the crash you are seeing? If not,
can you tell where is the crash exactly?



Juergen, keep in mind that xen_create_contiguous_region does nothing on
ARM because in dom0 guest_phys == phys. xen_create_contiguous_region
simply sets dma_handle to phys. Whatever condition caused the code to
take the xen_create_contiguous_region branch in
xen_swiotlb_alloc_coherent, it will also cause it to WARN in
xen_swiotlb_free_coherent.


range_straddles_page_boundary should never return True because
guest_phys == phys. That leaves us with the dma_mask check:

  dev_addr + size - 1 <= dma_mask

dev_addr is the dma_handle allocated by xen_alloc_coherent_pages.
dma_mask is either DMA_BIT_MASK(32) or hwdev->coherent_dma_mask.

The implementation of xen_alloc_coherent_pages has been recently changed
to use dma_direct_alloc.


Christoff, does dma_direct_alloc respect hwdev->coherent_dma_mask if
present? Also, can it return highmem pages?



> Juergen
> 
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >   drivers/xen/swiotlb-xen.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > index b6d27762c6f8..ab96e468584f 100644
> > --- a/drivers/xen/swiotlb-xen.c
> > +++ b/drivers/xen/swiotlb-xen.c
> > @@ -346,8 +346,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t
> > size, void *vaddr,
> >   	/* Convert the size to actually allocated. */
> >   	size = 1UL << (order + XEN_PAGE_SHIFT);
> >   -	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
> > -		     range_straddles_page_boundary(phys, size)) &&
> > +	if (((dev_addr + size - 1 > dma_mask) ||
> > +	    range_straddles_page_boundary(phys, size)) &&
> >   	    TestClearPageXenRemapped(virt_to_page(vaddr)))
> >   		xen_destroy_contiguous_region(phys, order);
> >   
> 
--8323329-325783116-1588098351=:29217
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--8323329-325783116-1588098351=:29217--
