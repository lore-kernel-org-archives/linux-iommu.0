From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.18 33/34] x86/swiotlb: Enable swiotlb for > 4GiG RAM on 32-bit kernels
Date: Thu,  8 Nov 2018 13:53:02 -0800
Message-ID: <20181108215140.924758534@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Matthew Whitehead <tedheadster@gmail.com>, Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>, konrad.wilk@oracle.com, iommu@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: iommu@lists.linux-foundation.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit 485734f3fc77c1eb77ffe138c027b9a4bf0178f3 upstream.

We already build the swiotlb code for 32-bit kernels with PAE support,
but the code to actually use swiotlb has only been enabled for 64-bit
kernels for an unknown reason.

Before Linux v4.18 we paper over this fact because the networking code,
the SCSI layer and some random block drivers implemented their own
bounce buffering scheme.

[ mingo: Changelog fixes. ]

Fixes: 21e07dba9fb1 ("scsi: reduce use of block bounce buffers")
Fixes: ab74cfebafa3 ("net: remove the PCI_DMA_BUS_IS_PHYS check in illegal_highdma")
Reported-by: Matthew Whitehead <tedheadster@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Matthew Whitehead <tedheadster@gmail.com>
Cc: konrad.wilk@oracle.com
Cc: iommu@lists.linux-foundation.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181014075208.2715-1-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/pci-swiotlb.c |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -42,10 +42,8 @@ IOMMU_INIT_FINISH(pci_swiotlb_detect_ove
 int __init pci_swiotlb_detect_4gb(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-#ifdef CONFIG_X86_64
 	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
 		swiotlb = 1;
-#endif
 
 	/*
 	 * If SME is active then swiotlb will be set to 1 so that bounce
