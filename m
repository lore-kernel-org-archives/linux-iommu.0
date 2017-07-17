From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 01/05] iommu/ipmmu-vmsa: Use
	iommu_device_register()/unregister()
Date: Mon, 17 Jul 2017 22:05:10 +0900
Message-ID: <150029671059.22030.9200719361237858789.sendpatchset@little-apple>
References: <150029669967.22030.8059216113725566341.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <150029669967.22030.8059216113725566341.sendpatchset@little-apple>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Extend the driver to make use of iommu_device_register()/unregister()
functions together with iommu_device_set_ops() and iommu_set_fwnode().

These used to be part of the earlier posted 64-bit ARM (r8a7795) series but
it turns out that these days they are required on 32-bit ARM as well.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Changes since V1:
 - Perform iommu_device_set_ops() and iommu_device_set_fwnode() before
   iommu_device_register() - thanks Robin!

 drivers/iommu/ipmmu-vmsa.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- 0001/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-07-17 21:01:47.140607110 +0900
@@ -35,6 +35,7 @@
 struct ipmmu_vmsa_device {
 	struct device *dev;
 	void __iomem *base;
+	struct iommu_device iommu;
 	struct list_head list;
 
 	unsigned int num_utlbs;
@@ -1054,6 +1055,13 @@ static int ipmmu_probe(struct platform_d
 
 	ipmmu_device_reset(mmu);
 
+	iommu_device_set_ops(&mmu->iommu, &ipmmu_ops);
+	iommu_device_set_fwnode(&mmu->iommu, &pdev->dev.of_node->fwnode);
+
+	ret = iommu_device_register(&mmu->iommu);
+	if (ret)
+		return ret;
+
 	/*
 	 * We can't create the ARM mapping here as it requires the bus to have
 	 * an IOMMU, which only happens when bus_set_iommu() is called in
@@ -1077,6 +1085,8 @@ static int ipmmu_remove(struct platform_
 	list_del(&mmu->list);
 	spin_unlock(&ipmmu_devices_lock);
 
+	iommu_device_unregister(&mmu->iommu);
+
 #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 	arm_iommu_release_mapping(mmu->mapping);
 #endif
