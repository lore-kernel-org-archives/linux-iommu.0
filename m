Return-Path: <SRS0=APMu=WT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93EAC3A5A2
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 07:19:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBDFC233A0
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 07:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDFC233A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7462DCA5;
	Fri, 23 Aug 2019 07:19:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 886FBC87
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 07:19:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D47E189E
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 07:18:57 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Aug 2019 00:18:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,420,1559545200"; d="scan'208";a="180619520"
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by fmsmga007.fm.intel.com with ESMTP; 23 Aug 2019 00:18:52 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 0/7] iommu: Bounce page for untrusted devices
Date: Fri, 23 Aug 2019 15:17:28 +0800
Message-Id: <20190823071735.30264-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: Juergen Gross <jgross@suse.com>, kevin.tian@intel.com,
	Stefano Stabellini <sstabellini@kernel.org>, ashok.raj@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	alan.cox@intel.com, Jonathan Corbet <corbet@lwn.net>,
	Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	pengfei.xu@intel.com, Ingo Molnar <mingo@redhat.com>,
	jacob.jun.pan@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	mika.westerberg@linux.intel.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The Thunderbolt vulnerabilities are public and have a nice
name as Thunderclap [1] [3] nowadays. This patch series aims
to mitigate those concerns.

An external PCI device is a PCI peripheral device connected
to the system through an external bus, such as Thunderbolt.
What makes it different is that it can't be trusted to the
same degree as the devices build into the system. Generally,
a trusted PCIe device will DMA into the designated buffers
and not overrun or otherwise write outside the specified
bounds. But it's different for an external device.

The minimum IOMMU mapping granularity is one page (4k), so
for DMA transfers smaller than that a malicious PCIe device
can access the whole page of memory even if it does not
belong to the driver in question. This opens a possibility
for DMA attack. For more information about DMA attacks
imposed by an untrusted PCI/PCIe device, please refer to [2].

This implements bounce buffer for the untrusted external
devices. The transfers should be limited in isolated pages
so the IOMMU window does not cover memory outside of what
the driver expects. Previously (v3 and before), we proposed
an optimisation to only copy the head and tail of the buffer
if it spans multiple pages, and directly map the ones in the
middle. Figure 1 gives a big picture about this solution.

                                swiotlb             System
                IOVA          bounce page           Memory
             .---------.      .---------.        .---------.
             |         |      |         |        |         |
             |         |      |         |        |         |
buffer_start .---------.      .---------.        .---------.
             |         |----->|         |*******>|         |
             |         |      |         | swiotlb|         |
             |         |      |         | mapping|         |
 IOMMU Page  '---------'      '---------'        '---------'
  Boundary   |         |                         |         |
             |         |                         |         |
             |         |                         |         |
             |         |------------------------>|         |
             |         |    IOMMU mapping        |         |
             |         |                         |         |
 IOMMU Page  .---------.                         .---------.
  Boundary   |         |                         |         |
             |         |                         |         |
             |         |------------------------>|         |
             |         |     IOMMU mapping       |         |
             |         |                         |         |
             |         |                         |         |
 IOMMU Page  .---------.      .---------.        .---------.
  Boundary   |         |      |         |        |         |
             |         |      |         |        |         |
             |         |----->|         |*******>|         |
  buffer_end '---------'      '---------' swiotlb'---------'
             |         |      |         | mapping|         |
             |         |      |         |        |         |
             '---------'      '---------'        '---------'
          Figure 1: A big view of iommu bounce page 

As Robin Murphy pointed out, this ties us to using strict mode for
TLB maintenance, which may not be an overall win depending on the
balance between invalidation bandwidth vs. memcpy bandwidth. If we
use standard SWIOTLB logic to always copy the whole thing, we should
be able to release the bounce pages via the flush queue to allow
'safe' lazy unmaps. So since v4 we start to use the standard swiotlb
logic.

                                swiotlb             System
                IOVA          bounce page           Memory
buffer_start .---------.      .---------.        .---------.
             |         |      |         |        |         |
             |         |      |         |        |         |
             |         |      |         |        .---------.physical
             |         |----->|         | ------>|         |_start  
             |         |iommu |         | swiotlb|         |
             |         | map  |         |   map  |         |
 IOMMU Page  .---------.      .---------.        '---------'
  Boundary   |         |      |         |        |         |
             |         |      |         |        |         |
             |         |----->|         |        |         |
             |         |iommu |         |        |         |
             |         | map  |         |        |         |
             |         |      |         |        |         |
 IOMMU Page  .---------.      .---------.        .---------.
  Boundary   |         |      |         |        |         |
             |         |----->|         |        |         |
             |         |iommu |         |        |         |
             |         | map  |         |        |         |
             |         |      |         |        |         |
 IOMMU Page  |         |      |         |        |         |
  Boundary   .---------.      .---------.        .---------.
             |         |      |         |------->|         |
  buffer_end '---------'      '---------' swiotlb|         |
             |         |----->|         |   map  |         |
             |         |iommu |         |        |         |
             |         | map  |         |        '---------' physical
             |         |      |         |        |         | _end    
             '---------'      '---------'        '---------'
          Figure 2: A big view of simplified iommu bounce page 

The implementation of bounce buffers for untrusted devices
will cause a little performance overhead, but we didn't see
any user experience problems. The users could use the kernel
parameter defined in the IOMMU driver to remove the performance
overhead if they trust their devices enough.

This series introduces below APIs for bounce page:

 * iommu_bounce_map(dev, addr, paddr, size, dir, attrs)
   - Map a buffer start at DMA address @addr in bounce page
     manner. For buffer that doesn't cross whole minimal
     IOMMU pages, the bounce buffer policy is applied.
     A bounce page mapped by swiotlb will be used as the DMA
     target in the IOMMU page table.
 
 * iommu_bounce_unmap(dev, addr, size, dir, attrs)
   - Unmap the buffer mapped with iommu_bounce_map(). The bounce
     page will be torn down after the bounced data get synced.
 
 * iommu_bounce_sync_single(dev, addr, size, dir, target)
   - Synce the bounced data in case the bounce mapped buffer is
     reused.

The bounce page idea:
Based-on-idea-by: Mika Westerberg <mika.westerberg@intel.com>
Based-on-idea-by: Ashok Raj <ashok.raj@intel.com>
Based-on-idea-by: Alan Cox <alan.cox@intel.com>
Based-on-idea-by: Kevin Tian <kevin.tian@intel.com>
Based-on-idea-by: Robin Murphy <robin.murphy@arm.com>

The patch series has been tested by:
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>

Reference:
[1] https://thunderclap.io/
[2] https://thunderclap.io/thunderclap-paper-ndss2019.pdf
[3] https://christian.kellner.me/2019/02/27/thunderclap-and-linux/
[4] https://lkml.org/lkml/2019/3/4/644

Best regards,
Baolu

Change log:
  v6->v7:
  - The previous v6 was posted here:
    https://lkml.org/lkml/2019/7/30/18
  - Remove the unnecessary bounce page iommu APIs

  v5->v6:
  - The previous v5 was posted here:
    https://lkml.org/lkml/2019/7/24/2134
  - Move the per-device dma ops into another seperated series.
  - Christoph Hellwig reviewed the patches and add his Reviewed-bys.
  - Add Steven Rostedt's Review-by for the trace patch.
  - Adress the review comments from Christoph Hellwig.
  - This patch series is now based on v5.3-rc2.

  v4->v5:
  - The previous v4 was posted here:
    https://lkml.org/lkml/2019/6/2/187
  - Add per-device dma ops and use bounce buffer specific dma
    ops for those untrusted devices.
      devices with identity domains	-> system default dma ops
      trusted devices with dma domains	-> iommu/vt-d dma ops
      untrusted devices		 	-> bounced dma ops
  - Address various review comments received since v4.
  - This patch series is based on v5.3-rc1.

  v3->v4:
  - The previous v3 was posted here:
    https://lkml.org/lkml/2019/4/20/213
  - Discard the optimization of only mapping head and tail
    partial pages, use the standard swiotlb in order to achieve
    iotlb flush efficiency.
  - This patch series is based on the top of the vt-d branch of
    Joerg's iommu tree.

  v2->v3:
  - The previous v2 was posed here:
    https://lkml.org/lkml/2019/3/27/157
  - Reuse the existing swiotlb APIs for bounce buffer by
    extending it to support bounce page.
  - Move the bouce page APIs into iommu generic layer.
  - This patch series is based on 5.1-rc1.

  v1->v2:
  - The previous v1 was posted here:
    https://lkml.org/lkml/2019/3/12/66
  - Refactor the code to remove struct bounce_param;
  - During the v1 review cycle, we discussed the possibility
    of reusing swiotlb code to avoid code dumplication, but
    we found the swiotlb implementations are not ready for the
    use of bounce page pool.
    https://lkml.org/lkml/2019/3/19/259
  - This patch series has been rebased to v5.1-rc2.

Lu Baolu (7):
  iommu/vt-d: Don't switch off swiotlb if use direct dma
  PCI: Add dev_is_untrusted helper
  swiotlb: Split size parameter to map/unmap APIs
  swiotlb: Zero out bounce buffer for untrusted device
  iommu/vt-d: Check whether device requires bounce buffer
  iommu/vt-d: Add trace events for device dma map/unmap
  iommu/vt-d: Use bounce buffer for untrusted devices

 .../admin-guide/kernel-parameters.txt         |   5 +
 drivers/iommu/Kconfig                         |   1 +
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/intel-iommu.c                   | 268 +++++++++++++++++-
 drivers/iommu/intel-trace.c                   |  14 +
 drivers/xen/swiotlb-xen.c                     |   8 +-
 include/linux/pci.h                           |   2 +
 include/linux/swiotlb.h                       |   8 +-
 include/trace/events/intel_iommu.h            |  84 ++++++
 kernel/dma/direct.c                           |   2 +-
 kernel/dma/swiotlb.c                          |  46 ++-
 11 files changed, 414 insertions(+), 25 deletions(-)
 create mode 100644 drivers/iommu/intel-trace.c
 create mode 100644 include/trace/events/intel_iommu.h

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
