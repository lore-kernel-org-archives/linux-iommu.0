From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 2/3] iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
Date: Sun, 12 Mar 2017 14:38:41 +0900
Message-ID: <148929712105.20744.4083416494740711767.sendpatchset@little-apple>
References: <148929710090.20744.10912918031085568693.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <148929710090.20744.10912918031085568693.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Bump up the maximum numbers of micro-TLBS to 48.

Each IPMMU device instance get micro-TLB assignment via
the "iommus" property in DT. Older SoCs tend to use a
maximum number of 32 micro-TLBs per IPMMU instance however
newer SoCs such as r8a7796 make use of up to 48 micro-TLBs.

At this point no SoC specific handling is done to validate
the maximum number of micro-TLBs, and because of that the
DT information is assumed to be within correct range for
each particular SoC.

If needed in the future SoC specific feature flags can be
added to handle the maximum number of micro-TLBs without
requiring DT changes, however at this point this does not
seem necessary.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---

 Changes since V2:
 - Added outer set of () to IMUASID() and IMUCTR() - thanks Ramesh!
 - Added Reviewed-by from Geert - thanks!

 Changes since V1:
 - Added support for the second I/O range at 0x600.

 drivers/iommu/ipmmu-vmsa.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- 0020/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-03-12 14:11:23.020607110 +0900
@@ -213,7 +213,9 @@ static void set_archdata(struct device *
 #define IMPMBA(n)			(0x0280 + ((n) * 4))
 #define IMPMBD(n)			(0x02c0 + ((n) * 4))
 
-#define IMUCTR(n)			(0x0300 + ((n) * 16))
+#define IMUCTR(n)			((n) < 32 ? IMUCTR0(n) : IMUCTR32(n))
+#define IMUCTR0(n)			(0x0300 + ((n) * 16))
+#define IMUCTR32(n)			(0x0600 + (((n) - 32) * 16))
 #define IMUCTR_FIXADDEN			(1 << 31)
 #define IMUCTR_FIXADD_MASK		(0xff << 16)
 #define IMUCTR_FIXADD_SHIFT		16
@@ -223,7 +225,9 @@ static void set_archdata(struct device *
 #define IMUCTR_FLUSH			(1 << 1)
 #define IMUCTR_MMUEN			(1 << 0)
 
-#define IMUASID(n)			(0x0308 + ((n) * 16))
+#define IMUASID(n)			((n) < 32 ? IMUASID0(n) : IMUASID32(n))
+#define IMUASID0(n)			(0x0308 + ((n) * 16))
+#define IMUASID32(n)			(0x0608 + (((n) - 32) * 16))
 #define IMUASID_ASID8_MASK		(0xff << 8)
 #define IMUASID_ASID8_SHIFT		8
 #define IMUASID_ASID0_MASK		(0xff << 0)
@@ -1164,7 +1168,7 @@ static int ipmmu_probe(struct platform_d
 	}
 
 	mmu->dev = &pdev->dev;
-	mmu->num_utlbs = 32;
+	mmu->num_utlbs = 48;
 	spin_lock_init(&mmu->lock);
 	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
 	mmu->features = match->data;
