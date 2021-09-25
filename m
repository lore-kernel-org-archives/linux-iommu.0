Return-Path: <SRS0=58fP=OP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AD2C433EF
	for <iommu@archiver.kernel.org>; Sat, 25 Sep 2021 14:09:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3ADF61279
	for <iommu@archiver.kernel.org>; Sat, 25 Sep 2021 14:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3ADF61279
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AF28605D7;
	Sat, 25 Sep 2021 14:09:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WjIJa5OTnmWi; Sat, 25 Sep 2021 14:09:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3F71A605EB;
	Sat, 25 Sep 2021 14:09:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19EE8C000F;
	Sat, 25 Sep 2021 14:09:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D9A8C000D
 for <iommu@lists.linux-foundation.org>; Sat, 25 Sep 2021 14:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2962E82540
 for <iommu@lists.linux-foundation.org>; Sat, 25 Sep 2021 14:09:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a5DRuljOUOhg for <iommu@lists.linux-foundation.org>;
 Sat, 25 Sep 2021 14:09:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CDDCA824EE
 for <iommu@lists.linux-foundation.org>; Sat, 25 Sep 2021 14:09:43 +0000 (UTC)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
 id 1FA167F5DA; Sat, 25 Sep 2021 17:09:40 +0300 (EEST)
Date: Sat, 25 Sep 2021 17:09:40 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2] iommu/amd: Use report_iommu_fault()
Message-ID: <YU8tpKhnehH34niv@wantstofly.org>
References: <YP7jbfRFxMeFONKl@wantstofly.org>
 <8cc39d3c-6086-cfe3-9743-901c51ad4bab@amd.com>
 <YQNksD4G1SS/yGM2@wantstofly.org>
 <0d353fc0-79d0-36b7-eeee-ba27249bb258@amd.com>
 <YSEfZyrLSWR0gFDu@wantstofly.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YSEfZyrLSWR0gFDu@wantstofly.org>
Cc: iommu@lists.linux-foundation.org
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

On Sat, Aug 21, 2021 at 06:44:39PM +0300, Lennert Buytenhek wrote:

> > > - EVENT_FLAG_I unset, but the request was a translation request
> > >   (EVENT_FLAG_TR set) or the target page was not present
> > >   (EVENT_FLAG_PR unset): call report_iommu_fault(), but the RW
> > >   bit will be invalid, so don't try to map it to a
> > >   IOMMU_FAULT_{READ,WRITE} code
> > 
> > So, why do we need to call report_iommu_fault() for this case?
> > My understanding is we only have IOMMU_FAULT_[READ|WRITE].
> > So, if we can't identify whether the DMA is read / write,
> > we should not need to call report_iommu_fauilt(), is it?
> 
> I don't think that we should just altogether avoid logging the subset
> of page faults for which we can't determine the read/write direction
> on AMD platforms.
> 
> E.g. "access to an unmapped address" (which will have PR=0, and thus we
> won't know if it was a read or a write access) is just as much of a page
> fault as "write to a read-only page" (which will have PR=1, and thus the
> RW bit will be accurate) is, and for RAS purposes, both events are
> equally interesting, and important to know about.
> 
> It's true that we currently don't have a way of signaling to
> report_iommu_fault() (and by extension, to the io_page_fault
> tracepoint) that we're not sure whether the offending access was a read
> or a write, but I think we can just add a bit to include/linux/iommu.h
> to indicate that, something along the lines of:
> 
> 	 /* iommu fault flags */
> 	 #define IOMMU_FAULT_READ        0x0
> 	 #define IOMMU_FAULT_WRITE       0x1
> 	+#define IOMMU_FAULT_RW_UNKNOWN  0x2
> 
> (Cc'ing Ohad Ben-Cohen, who originally added this API.)
> 
> I don't think that it would be a good idea to just not signal the page
> faults for which we don't know the read/write direction.

I had another look at this, and from some testing, it seems that,
contrary to what the datasheet suggests, the RW (read/write direction)
bit in logged I/O page faults is actually accurate for both faulting
accesses to present pages and faulting accesses to non-present pages.

I made a few hacks to the ixgbe driver to intentionally cause several
different types of I/O page faults, thereby turning an ixgbe NIC into
a poor man's I/O page fault generator, and these are the resulting
logged I/O page faults, on a Ryzen 3700X system:

Read from non-present page:
ixgbe 0000:25:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0010 address=0x1bbc8f040 flags=0x0000]
=> flags indicate PR(esent)=0, RW=0

Write to non-present page:
ixgbe 0000:25:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0010 address=0x1bdcb70c0 flags=0x0020]
=> flags indicate PR(esent)=0, RW=1

Read from write-only page:
ixgbe 0000:25:00.1: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0010 address=0xbbcc1c40 flags=0x0050]
=> flags indicate PR(esent)=1, RW=0  (and PE(rmission violation)=1)

Write to read-only page:
ixgbe 0000:25:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0010 address=0xbdcb70c0 flags=0x0070]
=> flags indicate PR(esent)=1, RW=1  (and PE(rmission violation)=1)

In other words, it seems that the RW bit is reliable even for PR=0 type
faults.

I assume that the restriction mentioned in the docs regarding RW and
PR ("RW is only meaningful when PR=1, TR=0, and I=0" from AMD I/O
Virtualization Technology (IOMMU) Specification, revision 3.00, Table
55: IO_PAGE_FAULT Event Log Buffer Entry Fields) is either confused
or refers to a restriction in older hardware that has since been lifted.

I'll resubmit the patch to unconditionally pass through the RW bit.




ixgbe hacks:

to cause reads from non-present pages (in the TX path):

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8232,7 +8232,7 @@ static int ixgbe_tx_map(struct ixgbe_ring *tx_ring,
 		dma_unmap_len_set(tx_buffer, len, size);
 		dma_unmap_addr_set(tx_buffer, dma, dma);
 
-		tx_desc->read.buffer_addr = cpu_to_le64(dma);
+		tx_desc->read.buffer_addr = cpu_to_le64(dma + BIT(32));
 
 		while (unlikely(size > IXGBE_MAX_DATA_PER_TXD)) {
 			tx_desc->read.cmd_type_len =


to cause writes to non-present pages (in the RX path):

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1604,7 +1604,7 @@ void ixgbe_alloc_rx_buffers(struct ixgbe_ring *rx_ring, u16 cleaned_count)
 		 * Refresh the desc even if buffer_addrs didn't change
 		 * because each write-back erases this info.
 		 */
-		rx_desc->read.pkt_addr = cpu_to_le64(bi->dma + bi->page_offset);
+		rx_desc->read.pkt_addr = cpu_to_le64(bi->dma + bi->page_offset + BIT(32));
 
 		rx_desc++;
 		bi++;


to cause reads from write-only pages (in the TX path):

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8220,7 +8220,7 @@ static int ixgbe_tx_map(struct ixgbe_ring *tx_ring,
 	}
 
 #endif
-	dma = dma_map_single(tx_ring->dev, skb->data, size, DMA_TO_DEVICE);
+	dma = dma_map_single(tx_ring->dev, skb->data, size, DMA_FROM_DEVICE);
 
 	tx_buffer = first;
 

to cause writes to read-only pages (in the RX path):

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1545,7 +1545,7 @@ static bool ixgbe_alloc_mapped_page(struct ixgbe_ring *rx_ring,
 	/* map page for use */
 	dma = dma_map_page_attrs(rx_ring->dev, page, 0,
 				 ixgbe_rx_pg_size(rx_ring),
-				 DMA_FROM_DEVICE,
+				 DMA_TO_DEVICE,
 				 IXGBE_RX_DMA_ATTR);
 
 	/*
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
