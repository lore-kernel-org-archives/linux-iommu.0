Return-Path: <SRS0=ZmA0=Y5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4DDC5DF61
	for <iommu@archiver.kernel.org>; Tue,  5 Nov 2019 16:29:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6472087E
	for <iommu@archiver.kernel.org>; Tue,  5 Nov 2019 16:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6472087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2B014DC6;
	Tue,  5 Nov 2019 16:29:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 31011DC0
	for <iommu@lists.linux-foundation.org>;
	Tue,  5 Nov 2019 16:29:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D3F8E189
	for <iommu@lists.linux-foundation.org>;
	Tue,  5 Nov 2019 16:28:59 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id D251368AFE; Tue,  5 Nov 2019 17:28:56 +0100 (CET)
Date: Tue, 5 Nov 2019 17:28:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: Bug 205201 - overflow of DMA mask and bus mask
Message-ID: <20191105162856.GA15402@lst.de>
References: <20181213112511.GA4574@lst.de>
	<e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de>
	<ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de>
	<e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de>
	<008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
	<20190103073622.GA24323@lst.de>
	<71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
	<1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
	<3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
	<46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Nov 05, 2019 at 08:56:27AM +0100, Christian Zigotzky wrote:
> Hi All,
>
> We still have DMA problems with some PCI devices. Since the PowerPC updat=
es =

> 4.21-1 [1] we need to decrease the RAM to 3500MB (mem=3D3500M) if we want=
 to =

> work with our PCI devices. The FSL P5020 and P5040 have these problems =

> currently.
>
> Error message:
>
> [=A0=A0 25.654852] bttv 1000:04:05.0: overflow 0x00000000fe077000+4096 of=
 DMA =

> mask ffffffff bus mask df000000
>
> All 5.x Linux kernels can't initialize a SCSI PCI card anymore so booting =

> of a Linux userland isn't possible.
>
> PLEASE check the DMA changes in the PowerPC updates 4.21-1 [1]. The kerne=
l =

> 4.20 works with all PCI devices without limitation of RAM.

Can you send me the .config and a dmesg?  And in the meantime try the
patch below?

---
From 4d659b7311bd4141fdd3eeeb80fa2d7602ea01d4 Mon Sep 17 00:00:00 2001
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Fri, 18 Oct 2019 13:00:43 +0200
Subject: dma-direct: check for overflows on 32 bit DMA addresses

As seen on the new Raspberry Pi 4 and sta2x11's DMA implementation it is
possible for a device configured with 32 bit DMA addresses and a partial
DMA mapping located at the end of the address space to overflow. It
happens when a higher physical address, not DMAable, is translated to
it's DMA counterpart.

For example the Raspberry Pi 4, configurable up to 4 GB of memory, has
an interconnect capable of addressing the lower 1 GB of physical memory
with a DMA offset of 0xc0000000. It transpires that, any attempt to
translate physical addresses higher than the first GB will result in an
overflow which dma_capable() can't detect as it only checks for
addresses bigger then the maximum allowed DMA address.

Fix this by verifying in dma_capable() if the DMA address range provided
is at any point lower than the minimum possible DMA address on the bus.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 include/linux/dma-direct.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index adf993a3bd58..6ad9e9ea7564 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -3,6 +3,7 @@
 #define _LINUX_DMA_DIRECT_H 1
 =

 #include <linux/dma-mapping.h>
+#include <linux/memblock.h> /* for min_low_pfn */
 #include <linux/mem_encrypt.h>
 =

 #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
@@ -27,6 +28,13 @@ static inline bool dma_capable(struct device *dev, dma_a=
ddr_t addr, size_t size)
 	if (!dev->dma_mask)
 		return false;
 =

+#ifndef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	/* Check if DMA address overflowed */
+	if (min(addr, addr + size - 1) <
+		__phys_to_dma(dev, (phys_addr_t)(min_low_pfn << PAGE_SHIFT)))
+		return false;
+#endif
+
 	return addr + size - 1 <=3D
 		min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
 }
-- =

2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
