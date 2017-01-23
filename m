From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH/RFC 1/2] arm64: mm: Silently allow devices lacking IOMMU group
Date: Mon, 23 Jan 2017 21:12:16 +0900
Message-ID: <148517353630.18128.12799811817831597628.sendpatchset@little-apple>
References: <148517349585.18128.10696161017872202809.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <148517349585.18128.10696161017872202809.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Consider failure of iommu_get_domain_for_dev() as non-critical and
get rid of the warning printout. This allows IOMMU properties to be
included in the DTB even though the kernel is configured with
CONFIG_IOMMU_API=n or in case a particular IOMMU driver refuses to
enable IOMMU support for a certain slave device and returns error
from the ->add_device() callback.

This is only a cosmetic change that removes console warning printouts.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 arch/arm64/mm/dma-mapping.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- 0001/arch/arm64/mm/dma-mapping.c
+++ work/arch/arm64/mm/dma-mapping.c	2017-01-23 20:54:40.060607110 +0900
@@ -827,11 +827,19 @@ static bool do_iommu_attach(struct devic
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 
 	/*
+	 * In case IOMMU support is excluded from the kernel or if the device
+	 * is not hooked up to any IOMMU group then be silent and keep the
+	 * old dma_ops.
+	 */
+	if (!domain)
+		return false;
+
+	/*
 	 * If the IOMMU driver has the DMA domain support that we require,
 	 * then the IOMMU core will have already configured a group for this
 	 * device, and allocated the default domain for that group.
 	 */
-	if (!domain || iommu_dma_init_domain(domain, dma_base, size, dev)) {
+	if (iommu_dma_init_domain(domain, dma_base, size, dev)) {
 		pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
 			dev_name(dev));
 		return false;
