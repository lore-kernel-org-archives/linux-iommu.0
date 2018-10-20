From: Shayan Doust <shayan.doust-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 10/10] x86/swiotlb: Enable swiotlb for > 4GiG RAM on 32-bit
	kernels
Date: Sat, 20 Oct 2018 23:52:59 +0000
Message-ID: <AM2PR08MB0195C661C75DDCA22CBF88A487FA0@AM2PR08MB0195.eurprd08.prod.outlook.com>
References: <20181020235230.37324-1-shayan.doust@outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181020235230.37324-1-shayan.doust-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "hello-+2Af08X+J7zOVGE6+1PSpQ@public.gmane.org" <hello-+2Af08X+J7zOVGE6+1PSpQ@public.gmane.org>
Cc: "konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org" <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>

We already build the swiotlb code for 32-bit kernels with PAE support,
but the code to actually use swiotlb has only been enabled for 64-bit
kernels for an unknown reason.

Before Linux v4.18 we paper over this fact because the networking code,
the SCSI layer and some random block drivers implemented their own
bounce buffering scheme.

[ mingo: Changelog fixes. ]

Fixes: 21e07dba9fb1 ("scsi: reduce use of block bounce buffers")
Fixes: ab74cfebafa3 ("net: remove the PCI_DMA_BUS_IS_PHYS check in illegal_highdma")
Reported-by: Matthew Whitehead <tedheadster-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Tested-by: Matthew Whitehead <tedheadster-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Link: https://lkml.kernel.org/r/20181014075208.2715-1-hch-jcswGhMUV9g@public.gmane.org
Signed-off-by: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 arch/x86/kernel/pci-swiotlb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index 661583662430..71c0b01d93b1 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -42,10 +42,8 @@ IOMMU_INIT_FINISH(pci_swiotlb_detect_override,
 int __init pci_swiotlb_detect_4gb(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-#ifdef CONFIG_X86_64
 	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
 		swiotlb = 1;
-#endif
 
 	/*
 	 * If SME is active then swiotlb will be set to 1 so that bounce
-- 
2.17.1
