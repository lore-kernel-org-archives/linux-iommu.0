Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DBAC49EA5
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 11:48:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA51613DC
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 11:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA51613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF7A4405F2;
	Thu, 24 Jun 2021 11:48:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UOBfdpQd7_5i; Thu, 24 Jun 2021 11:48:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 56592405E4;
	Thu, 24 Jun 2021 11:48:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B8A8C001A;
	Thu, 24 Jun 2021 11:48:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D40CC000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 11:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B9CE405F2
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 11:48:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Na8SkaPGQF3u for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 11:48:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BA98405E4
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 11:48:42 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E399761185;
 Thu, 24 Jun 2021 11:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624535321;
 bh=tIEzJbFyzrkVCHoPFZv7EiSn5eGdWcktY1hM7567WC4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cnBL/cs5jq0gzsWpdW01qPqR4FhnbZYA5FARUzRbfbTnReSUvqYZg/5d7fMfMzzLB
 Yi5ocgI40U2CdP0yPBgaSH4aMAy6kTVPwJQovsDfnM8E0ctEFfmI50PYyqPNdilEHT
 wiHUoLZz+z5T3P7Nu0n1FHp0CT0+Mpa9kCcUzUXOGKpJLUcEA7B6eF0lhIA1fVOD2N
 8hTi4ZzKBg0KOAPGGETjH9KnPn8WseTFQmhg5QfTMY6mH9TlCuMS+A5EiYaVCFxL1+
 hxLlyRsIfAlqe3aZtbbg/Ry8xq+FvG9CW/Y0YZqD103SdYwufpVGkDaukfSWqnEWQs
 pjV7QbcyVw3Kw==
Date: Thu, 24 Jun 2021 12:48:30 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v14 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
Message-ID: <20210624114829.GB1382@willie-the-truck>
References: <20210619034043.199220-1-tientzu@chromium.org>
 <20210619034043.199220-7-tientzu@chromium.org>
 <76c3343d-72e5-9df3-8924-5474ee698ef4@quicinc.com>
 <20210623183736.GA472@willie-the-truck>
 <19d4c7a2-744d-21e0-289c-a576e1f0e6f3@quicinc.com>
 <20210624054315.GA25381@lst.de>
 <CALiNf288ZLMhY3E8E3N+z9rkwi1viWNLm1wwMEwT4rNwh3FfwQ@mail.gmail.com>
 <364e6715-eafd-fc4a-e0af-ce2a042756b4@arm.com>
 <20210624111855.GA1382@willie-the-truck>
 <452155d2-c98e-23f6-86d6-3a2ff2e74783@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <452155d2-c98e-23f6-86d6-3a2ff2e74783@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: heikki.krogerus@linux.intel.com,
 linux-devicetree <devicetree@vger.kernel.org>, peterz@infradead.org,
 benh@kernel.crashing.org, joonas.lahtinen@linux.intel.com,
 dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
 grant.likely@arm.com, paulus@samba.org, Frank Rowand <frowand.list@gmail.com>,
 mingo@kernel.org, Jianxiong Gao <jxgao@google.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Saravana Kannan <saravanak@google.com>, mpe@ellerman.id.au,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Dan Williams <dan.j.williams@intel.com>, matthew.auld@intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, thomas.hellstrom@linux.intel.com,
 Jim Quinlan <james.quinlan@broadcom.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 intel-gfx@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 Claire Chang <tientzu@chromium.org>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 airlied@linux.ie, Thierry Reding <treding@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Qian Cai <quic_qiancai@quicinc.com>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, xypron.glpk@gmx.de,
 Tom Lendacky <thomas.lendacky@amd.com>, linuxppc-dev@lists.ozlabs.org,
 bauerman@linux.ibm.com
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

On Thu, Jun 24, 2021 at 12:34:09PM +0100, Robin Murphy wrote:
> On 2021-06-24 12:18, Will Deacon wrote:
> > On Thu, Jun 24, 2021 at 12:14:39PM +0100, Robin Murphy wrote:
> > > On 2021-06-24 07:05, Claire Chang wrote:
> > > > On Thu, Jun 24, 2021 at 1:43 PM Christoph Hellwig <hch@lst.de> wrote:
> > > > > 
> > > > > On Wed, Jun 23, 2021 at 02:44:34PM -0400, Qian Cai wrote:
> > > > > > is_swiotlb_force_bounce at /usr/src/linux-next/./include/linux/swiotlb.h:119
> > > > > > 
> > > > > > is_swiotlb_force_bounce() was the new function introduced in this patch here.
> > > > > > 
> > > > > > +static inline bool is_swiotlb_force_bounce(struct device *dev)
> > > > > > +{
> > > > > > +     return dev->dma_io_tlb_mem->force_bounce;
> > > > > > +}
> > > > > 
> > > > > To me the crash looks like dev->dma_io_tlb_mem is NULL.  Can you
> > > > > turn this into :
> > > > > 
> > > > >           return dev->dma_io_tlb_mem && dev->dma_io_tlb_mem->force_bounce;
> > > > > 
> > > > > for a quick debug check?
> > > > 
> > > > I just realized that dma_io_tlb_mem might be NULL like Christoph
> > > > pointed out since swiotlb might not get initialized.
> > > > However,  `Unable to handle kernel paging request at virtual address
> > > > dfff80000000000e` looks more like the address is garbage rather than
> > > > NULL?
> > > > I wonder if that's because dev->dma_io_tlb_mem is not assigned
> > > > properly (which means device_initialize is not called?).
> > > 
> > > What also looks odd is that the base "address" 0xdfff800000000000 is held in
> > > a couple of registers, but the offset 0xe looks too small to match up to any
> > > relevant structure member in that dereference chain :/
> > 
> > FWIW, I've managed to trigger a NULL dereference locally when swiotlb hasn't
> > been initialised but we dereference 'dev->dma_io_tlb_mem', so I think
> > Christoph's suggestion is needed regardless.
> 
> Ack to that - for SWIOTLB_NO_FORCE, io_tlb_default_mem will remain NULL. The
> massive jump in KernelCI baseline failures as of yesterday looks like every
> arm64 machine with less than 4GB of RAM blowing up...

Ok, diff below which attempts to tackle the offset issue I mentioned as
well. Qian Cai -- please can you try with these changes?

Will

--->8

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 175b6c113ed8..39284ff2a6cd 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -116,7 +116,9 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 
 static inline bool is_swiotlb_force_bounce(struct device *dev)
 {
-       return dev->dma_io_tlb_mem->force_bounce;
+       struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+
+       return mem && mem->force_bounce;
 }
 
 void __init swiotlb_exit(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 44be8258e27b..0ffbaae9fba2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -449,6 +449,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
                dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
        unsigned int nslots = nr_slots(alloc_size), stride;
        unsigned int index, wrap, count = 0, i;
+       unsigned int offset = swiotlb_align_offset(dev, orig_addr);
        unsigned long flags;
 
        BUG_ON(!nslots);
@@ -497,7 +498,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
        for (i = index; i < index + nslots; i++) {
                mem->slots[i].list = 0;
                mem->slots[i].alloc_size =
-                       alloc_size - ((i - index) << IO_TLB_SHIFT);
+                       alloc_size - (offset + ((i - index) << IO_TLB_SHIFT));
        }
        for (i = index - 1;
             io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
