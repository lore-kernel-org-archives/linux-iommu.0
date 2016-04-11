From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Can't boot new 4.4 kernel with IOMMU enabled
Date: Mon, 11 Apr 2016 15:54:51 +0200
Message-ID: <20160411135451.GO17838@8bytes.org>
References: <56A0F221.10502@compro.net> <20160121223958.GL18805@8bytes.org>
	<56B0CFF7.80907@compro.net> <20160216162455.GX18805@8bytes.org>
	<56C35D1A.9080307@compro.net> <20160226162319.GH22747@8bytes.org>
	<56D0A565.8080406@compro.net> <20160229174252.GN22747@8bytes.org>
	<56D48560.4010904@compro.net> <56EC39CB.2010909@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56EC39CB.2010909-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Mark,

On Fri, Mar 18, 2016 at 01:24:27PM -0400, Mark Hounschell wrote:
> Should I submit a kernel bug report on this?

I just fixed a regression in v4.4. Can you please try the attached patch
and report if it fixes your problem too? The patch is against v4.6-rc2.


Thanks,

	Joerg

>From e76e8764c9265b5dec31e6a8e5be61f028866d93 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date: Fri, 8 Apr 2016 15:12:24 +0200
Subject: [PATCH] iommu/amd: Fix checking of pci dma aliases

Commit 61289cb ('iommu/amd: Remove old alias handling code')
removed the old alias handling code from the AMD IOMMU
driver because this is now handled by the IOMMU core code.

But this also removed the handling of PCI aliases, which is
not handled by the core code. This caused issues with PCI
devices that have hidden PCIe-to-PCI bridges that rewrite
the request-id.

Fix this bug by re-introducing some of the removed functions
from commit 61289cbaf6c8 and add a alias field
'struct iommu_dev_data'. This field carrys the return value
of the get_alias() function and uses that instead of the
amd_iommu_alias_table[] array in the code.

Fixes: 61289cbaf6c8 ('iommu/amd: Remove old alias handling code')
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v4.4+
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 87 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 374c129..5efadad 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -92,6 +92,7 @@ struct iommu_dev_data {
 	struct list_head dev_data_list;	  /* For global dev_data_list */
 	struct protection_domain *domain; /* Domain the device is bound to */
 	u16 devid;			  /* PCI Device ID */
+	u16 alias;			  /* Alias Device ID */
 	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
 	bool passthrough;		  /* Device is identity mapped */
 	struct {
@@ -166,6 +167,13 @@ static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 	return container_of(dom, struct protection_domain, domain);
 }
 
+static inline u16 get_device_id(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return PCI_DEVID(pdev->bus->number, pdev->devfn);
+}
+
 static struct iommu_dev_data *alloc_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
@@ -203,6 +211,68 @@ out_unlock:
 	return dev_data;
 }
 
+static int __last_alias(struct pci_dev *pdev, u16 alias, void *data)
+{
+	*(u16 *)data = alias;
+	return 0;
+}
+
+static u16 get_alias(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 devid, ivrs_alias, pci_alias;
+
+	devid = get_device_id(dev);
+	ivrs_alias = amd_iommu_alias_table[devid];
+	pci_for_each_dma_alias(pdev, __last_alias, &pci_alias);
+
+	if (ivrs_alias == pci_alias)
+		return ivrs_alias;
+
+	/*
+	 * DMA alias showdown
+	 *
+	 * The IVRS is fairly reliable in telling us about aliases, but it
+	 * can't know about every screwy device.  If we don't have an IVRS
+	 * reported alias, use the PCI reported alias.  In that case we may
+	 * still need to initialize the rlookup and dev_table entries if the
+	 * alias is to a non-existent device.
+	 */
+	if (ivrs_alias == devid) {
+		if (!amd_iommu_rlookup_table[pci_alias]) {
+			amd_iommu_rlookup_table[pci_alias] =
+				amd_iommu_rlookup_table[devid];
+			memcpy(amd_iommu_dev_table[pci_alias].data,
+			       amd_iommu_dev_table[devid].data,
+			       sizeof(amd_iommu_dev_table[pci_alias].data));
+		}
+
+		return pci_alias;
+	}
+
+	pr_info("AMD-Vi: Using IVRS reported alias %02x:%02x.%d "
+		"for device %s[%04x:%04x], kernel reported alias "
+		"%02x:%02x.%d\n", PCI_BUS_NUM(ivrs_alias), PCI_SLOT(ivrs_alias),
+		PCI_FUNC(ivrs_alias), dev_name(dev), pdev->vendor, pdev->device,
+		PCI_BUS_NUM(pci_alias), PCI_SLOT(pci_alias),
+		PCI_FUNC(pci_alias));
+
+	/*
+	 * If we don't have a PCI DMA alias and the IVRS alias is on the same
+	 * bus, then the IVRS table may know about a quirk that we don't.
+	 */
+	if (pci_alias == devid &&
+	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number) {
+		pdev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
+		pdev->dma_alias_devfn = ivrs_alias & 0xff;
+		pr_info("AMD-Vi: Added PCI DMA alias %02x.%d for %s\n",
+			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias),
+			dev_name(dev));
+	}
+
+	return ivrs_alias;
+}
+
 static struct iommu_dev_data *find_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
@@ -215,13 +285,6 @@ static struct iommu_dev_data *find_dev_data(u16 devid)
 	return dev_data;
 }
 
-static inline u16 get_device_id(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return PCI_DEVID(pdev->bus->number, pdev->devfn);
-}
-
 static struct iommu_dev_data *get_dev_data(struct device *dev)
 {
 	return dev->archdata.iommu;
@@ -349,6 +412,8 @@ static int iommu_init_device(struct device *dev)
 	if (!dev_data)
 		return -ENOMEM;
 
+	dev_data->alias = get_alias(dev);
+
 	if (pci_iommuv2_capable(pdev)) {
 		struct amd_iommu *iommu;
 
@@ -369,7 +434,7 @@ static void iommu_ignore_device(struct device *dev)
 	u16 devid, alias;
 
 	devid = get_device_id(dev);
-	alias = amd_iommu_alias_table[devid];
+	alias = get_alias(dev);
 
 	memset(&amd_iommu_dev_table[devid], 0, sizeof(struct dev_table_entry));
 	memset(&amd_iommu_dev_table[alias], 0, sizeof(struct dev_table_entry));
@@ -1061,7 +1126,7 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 	int ret;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
-	alias = amd_iommu_alias_table[dev_data->devid];
+	alias = dev_data->alias;
 
 	ret = iommu_flush_dte(iommu, dev_data->devid);
 	if (!ret && alias != dev_data->devid)
@@ -2039,7 +2104,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	bool ats;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
-	alias = amd_iommu_alias_table[dev_data->devid];
+	alias = dev_data->alias;
 	ats   = dev_data->ats.enabled;
 
 	/* Update data structures */
@@ -2073,7 +2138,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 		return;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
-	alias = amd_iommu_alias_table[dev_data->devid];
+	alias = dev_data->alias;
 
 	/* decrease reference counters */
 	dev_data->domain->dev_iommu[iommu->index] -= 1;
-- 
1.8.4.5
