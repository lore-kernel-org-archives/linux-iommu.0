From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/2] kernel/dma: Default to 64 MiB of contiguous memory on
	Raspberry Pi 3
Date: Mon,  4 Mar 2019 12:52:55 +0100
Message-ID: <20190304115255.2088-3-tzimmermann@suse.de>
References: <20190304115255.2088-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190304115255.2088-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: ptesarik-AlSwsSmVLrQ@public.gmane.org, Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

By default, reserve 64 MiB of contiguous memory for use with the Raspberry
Pi 3's VideoCore IV graphics unit.

Signed-off-by: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
---
 kernel/dma/contiguous.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 5bbb7a618a2d..c7594706efd6 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -55,6 +55,10 @@ struct cma_default {
 /* CMA defaults for various devices, keep this sorted by .machine_name.
  */
 static const struct cma_default __initdata cma_machine_defaults[] = {
+	/* Reserve 64 MiB for the VC4 graphics unit on Raspberry Pi 3. This
+	 * should be enough memory to run fbcon and a simple desktop. */
+	DECLARE_CMA_MACHINE_DEFAULT("Raspberry Pi 3 Model B Rev 1.2",
+				    64 * 1024 * 1024, 0, 0)
 };
 
 static int __init cmp_machine_name(const void *key, const void *elt)
-- 
2.20.1
