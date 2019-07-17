Return-Path: <SRS0=5D8q=VO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4697FC7618F
	for <iommu@archiver.kernel.org>; Wed, 17 Jul 2019 15:40:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF772173B
	for <iommu@archiver.kernel.org>; Wed, 17 Jul 2019 15:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF772173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DD94EDCF;
	Wed, 17 Jul 2019 15:40:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 243EFDA4
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Jul 2019 15:31:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 902E112E
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Jul 2019 15:31:46 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id A2753AF5B;
	Wed, 17 Jul 2019 15:31:44 +0000 (UTC)
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux-foundation.org
Subject: [RFC 0/4] Raspberry Pi 4 DMA addressing support
Date: Wed, 17 Jul 2019 17:31:31 +0200
Message-Id: <20190717153135.15507-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 17 Jul 2019 15:40:12 +0000
Cc: stefan.wahren@i2se.com, f.fainelli@gmail.com, catalin.marinas@arm.com,
	phil@raspberrypi.org, linux-kernel@vger.kernel.org,
	Jisheng.Zhang@synaptics.com, mbrugger@suse.com, will@kernel.org,
	hch@lst.de, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi all,
this series attempts to address some issues we found while bringing up the new
Raspberry Pi 4 in arm64 and it's intended to serve as a follow up to this:
https://www.spinics.net/lists/arm-kernel/msg740650.html

The new Raspberry Pi 4 has up to 4GB of ram but most devices can only address
the first GB of ram: the DMA address range is 0xc0000000-0xfc000000 which is
aliased to the first GB of memory 0x00000000-0x3c000000. Note that only some
devices have this limitations, the ARM cores, PCIe, GENET, and 40-bit DMA
channels have a wider view of the address space.

This is solved in arm32 by setting up the correct '.dma_zone_size = SZ_1G'
which takes care of the allocating the coherent memory area at the right spot
and also is taken into account in the arch specific 'dma_map_ops'.

Unfortunately there is no such thing as '.dma_zone_size' in arm64, to make
things worse it's assumed that all devices will be able to adress the first 4GB
of memory.

This raises two issues: the coherent memory reserves are located in an area not
accessible by most devices, and DMA streaming's dma_supported(), which fails
for most devices since it's min_mask isn't properly set. Note that the rest if
DMA streaming works fine thanks to the help of swiotlb.

On one hand I've implemented a function that parses the 'dma-range' on all
interconnects and tries to select a location for the coherent memory reserves
that'll fit all devices. I made the algorithm as simple as possible, based on
the existing devices limitations.

On the other I've added a new variable in dma-direct that allows modifying the
min_mask during the init process and taken care of setting it accordingly in
the arm64's init code.

Regards,
Nicolas

---

Nicolas Saenz Julienne (4):
  arm64: mm: use arm64_dma_phys_limit instead of calling max_zone_dma_phys()
  arm64: mm: parse dma-ranges in order to better estimate arm64_dma_phys_limit
  dma-direct: add dma_direct_min_mask
  arm64: mm: set direct_dma_min_mask according to dma-ranges

 arch/arm64/mm/init.c | 69 ++++++++++++++++++++++++++++++++++++++++----
 kernel/dma/direct.c  |  4 ++-
 2 files changed, 67 insertions(+), 6 deletions(-)

-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
