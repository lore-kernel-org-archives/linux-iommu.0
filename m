From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 03/06] iommu/ipmmu-vmsa: Break out utlb control function
Date: Tue, 15 Dec 2015 21:02:39 +0900
Message-ID: <20151215120239.26216.43390.sendpatchset@little-apple>
References: <20151215120212.26216.61530.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151215120212.26216.61530.sendpatchset@little-apple>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Introduce the function ipmmu_utlb_ctrl() that shares code
to enable or disable utlbs.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 drivers/iommu/ipmmu-vmsa.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

--- 0004/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-12-15 13:17:40.580513000 +0900
@@ -279,9 +279,18 @@ static void ipmmu_utlb_enable(struct ipm
 static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
 			       unsigned int utlb)
 {
-	struct ipmmu_vmsa_device *mmu = domain->mmu;
+	ipmmu_write(domain->mmu, IMUCTR(utlb), 0);
+}
+
+static void ipmmu_utlb_ctrl(struct ipmmu_vmsa_domain *domain,
+			    void (*fn)(struct ipmmu_vmsa_domain *,
+				       unsigned int utlb), struct device *dev)
+{
+	struct ipmmu_vmsa_dev_data *dev_data = get_dev_data(dev);
+	unsigned int i;
 
-	ipmmu_write(mmu, IMUCTR(utlb), 0);
+	for (i = 0; i < dev_data->num_utlbs; ++i)
+		fn(domain, dev_data->utlbs[i]);
 }
 
 static void ipmmu_tlb_flush_all(void *cookie)
@@ -503,7 +512,6 @@ static int ipmmu_attach_device(struct io
 	struct ipmmu_vmsa_device *mmu = dev_data->mmu;
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 	unsigned long flags;
-	unsigned int i;
 	int ret = 0;
 
 	if (!mmu) {
@@ -529,24 +537,16 @@ static int ipmmu_attach_device(struct io
 
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-	if (ret < 0)
-		return ret;
+	if (!ret)
+		ipmmu_utlb_ctrl(domain, ipmmu_utlb_enable, dev);
 
-	for (i = 0; i < dev_data->num_utlbs; ++i)
-		ipmmu_utlb_enable(domain, dev_data->utlbs[i]);
-
-	return 0;
+	return ret;
 }
 
 static void ipmmu_detach_device(struct iommu_domain *io_domain,
 				struct device *dev)
 {
-	struct ipmmu_vmsa_dev_data *dev_data = get_dev_data(dev);
-	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
-	unsigned int i;
-
-	for (i = 0; i < dev_data->num_utlbs; ++i)
-		ipmmu_utlb_disable(domain, dev_data->utlbs[i]);
+	ipmmu_utlb_ctrl(to_vmsa_domain(io_domain), ipmmu_utlb_disable, dev);
 
 	/*
 	 * TODO: Optimize by disabling the context when no device is attached.
