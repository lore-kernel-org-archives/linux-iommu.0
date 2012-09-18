From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [farnold-HnHVZv34qLXYtjvyW6yDsg@public.gmane.org: [PATCH] iommu/amd: Fix some typos]
Date: Tue, 18 Sep 2012 12:34:33 +0200
Message-ID: <20120918103433.GF2505@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LpQ9ahxlCli8rRTG"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
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
List-Id: iommu@lists.linux-foundation.org

--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Just applied.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

--LpQ9ahxlCli8rRTG
Content-Type: message/rfc822; name="[PATCH] iommuamd Fix some typos"
Content-Disposition: inline; filename="[PATCH] iommuamd Fix some typos"
Content-Description: [PATCH] iommuamd Fix some typos

Return-Path: <farnold-HnHVZv34qLXYtjvyW6yDsg@public.gmane.org>
X-Original-To: joro@localhost
Delivered-To: joro-bi+AKbBUZKbMVJPVWXx0r1qqcueBTJwQ@public.gmane.org
Received: from lemmy (localhost [127.0.0.1])	by lemmy.osrc.amd.com (Postfix)
 with ESMTP id 29F73138CC0	for <joro@localhost>; Mon, 27 Aug 2012 19:21:39
 +0200 (CEST)
MIME-Version: 1.0
Received: from torimap.amd.com [10.1.1.7]	by lemmy with IMAP
 (fetchmail-6.3.21)	for <joro@localhost> (single-drop); Mon, 27 Aug 2012
 19:21:39 +0200 (CEST)
Received: from storexhtp01.amd.com (10.1.13.16) by storexdag01.amd.com
 (10.1.13.10) with Microsoft SMTP Server (TLS) id 14.1.323.3; Mon, 27 Aug 2012
 13:21:26 -0400
Received: from SAUSEXDAG01.amd.com (163.181.55.1) by storexhtp01.amd.com
 (172.24.4.3) with Microsoft SMTP Server (TLS) id 8.3.213.0; Mon, 27 Aug 2012
 13:21:25 -0400
Received: from sausexedgep02.amd.com (163.181.36.59) by sausexdag01.amd.com
 (163.181.55.1) with Microsoft SMTP Server (TLS) id 14.1.323.3; Mon, 27 Aug
 2012 12:21:23 -0500
Received: from ausb3twp02.amd.com (163.181.249.109) by sausexedgep02.amd.com
 (163.181.249.73) with Microsoft SMTP Server id 8.3.192.1; Mon, 27 Aug 2012
 12:21:17 -0500
X-WSS-ID: 0M9FC7A-02-5HI-02
Received: from mail127-tx2-R.bigfish.com (mail-tx2.bigfish.com [65.55.88.115])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))	(No client
 certificate requested)	by ausb3twp02.amd.com (Axway MailGate 3.8.1) with
 ESMTP id 24BABC80A8	for <joerg.roedel-5C7GfCeVMHo@public.gmane.org>; Mon, 27 Aug 2012 12:21:10
 -0500 (CDT)
Received: from mail127-tx2 (localhost [127.0.0.1])	by
 mail127-tx2-R.bigfish.com (Postfix) with ESMTP id A98FA1E028A	for
 <joerg.roedel-5C7GfCeVMHo@public.gmane.org>; Mon, 27 Aug 2012 17:21:10 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:217.9.48.20;KIP:(null);UIP:(null);IPV:NLI;H:mail.x86-64.org;RD:mail.x86-64.org;EFVD:NLI
X-SpamScore: 2
X-BigFish: vps2(zzzz1202hzz8275bhz32i80i668h839hd24he5bh107ah)
X-CustomSpam: This message was filtered by custom spam filter option - From SPF error
Received-SPF: PermError (sausexedgep02.amd.com: domain of farnold-HnHVZv34qLXYtjvyW6yDsg@public.gmane.org
 used an invalid SPF mechanism)
Received-SPF: permerror (mail127-tx2: error in processing during lookup of domain of amd64.org: Could not find a valid SPF record) client-ip=217.9.48.20; envelope-from=farnold-HnHVZv34qLXYtjvyW6yDsg@public.gmane.org; helo=mail.x86-64.org ;l.x86-64.org ;
Received: from mail127-tx2 (localhost.localdomain [127.0.0.1]) by mail127-tx2
 (MessageSwitch) id 1346088067938212_763; Mon, 27 Aug 2012 17:21:07 +0000
 (UTC)
Received: from TX2EHSMHS001.bigfish.com (unknown [10.9.14.236])	by
 mail127-tx2.bigfish.com (Postfix) with ESMTP id CEA393C0096;	Mon, 27 Aug 2012
 17:21:07 +0000 (UTC)
Received: from mail.x86-64.org (217.9.48.20) by TX2EHSMHS001.bigfish.com
 (10.9.99.101) with Microsoft SMTP Server id 14.1.225.23; Mon, 27 Aug 2012
 17:21:06 +0000
Received: from localhost (localhost [127.0.0.1])	by mail.x86-64.org (Postfix)
 with ESMTP id 8258714004E;	Mon, 27 Aug 2012 19:21:04 +0200 (CEST)
X-Virus-Scanned: Nedap ESD1 at etzel.amd.com
Received: from mail.x86-64.org ([127.0.0.1])	by localhost (www.amd64.org
 [127.0.0.1]) (amavisd-new, port 10024)	with ESMTP id dGdbfv7a8lRA; Mon, 27
 Aug 2012 19:21:04 +0200 (CEST)
Received: from gwo.osrc.amd.com (gwo.osrc.amd.com [10.97.0.252])	by
 mail.x86-64.org (Postfix) with ESMTP;	Mon, 27 Aug 2012 19:21:04 +0200 (CEST)
Received: from mendozza.osrc.amd.com (mendozza.osrc.amd.com [165.204.15.95])
	by gwo.osrc.amd.com (Postfix) with ESMTP id 6639649C1EC;	Mon, 27 Aug 2012
 18:21:04 +0100 (BST)
From: Frank Arnold <farnold-HnHVZv34qLXYtjvyW6yDsg@public.gmane.org>
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
CC: Andreas Herrmann <andreas.herrmann3-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] iommu/amd: Fix some typos
Date: Mon, 27 Aug 2012 19:21:04 +0200
Message-ID: <1346088064-2612-1-git-send-email-farnold-HnHVZv34qLXYtjvyW6yDsg@public.gmane.org>
X-Mailer: git-send-email 1.7.11.4
Content-Type: text/plain
X-MS-Exchange-Organization-PRD: amd64.org
X-MS-Exchange-Organization-PCL: 2
X-MS-Exchange-Organization-Antispam-Report: DV:3.3.9404.507;SV:3.3.4604.600;SID:SenderIDStatus
 PermError;OrigIP:163.181.249.109
X-MS-Exchange-Organization-SCL: 0
X-MS-Exchange-Organization-SenderIdResult: PERMERROR
X-MS-Exchange-Organization-AVStamp-Mailbox: MSFTFF;1;0;0 0 0
X-MS-Exchange-Organization-AuthSource: sausexedgep02.amd.com
X-MS-Exchange-Organization-AuthAs: Anonymous

From: Frank Arnold <frank.arnold-5C7GfCeVMHo@public.gmane.org>

Fix some typos in comments and user-visible messages. No
functional changes.

Signed-off-by: Frank Arnold <frank.arnold-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 10 +++++-----
 drivers/iommu/amd_iommu_init.c  | 10 +++++-----
 drivers/iommu/amd_iommu_types.h |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b64502d..450b258 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -684,7 +684,7 @@ static void iommu_poll_ppr_log(struct amd_iommu *iommu)
 
 		/*
 		 * Release iommu->lock because ppr-handling might need to
-		 * re-aquire it
+		 * re-acquire it
 		 */
 		spin_unlock_irqrestore(&iommu->lock, flags);
 
@@ -802,7 +802,7 @@ static void build_inv_iommu_pages(struct iommu_cmd *cmd, u64 address,
 	CMD_SET_TYPE(cmd, CMD_INV_IOMMU_PAGES);
 	if (s) /* size bit - we flush more than one 4kb page */
 		cmd->data[2] |= CMD_INV_IOMMU_PAGES_SIZE_MASK;
-	if (pde) /* PDE bit - we wan't flush everything not only the PTEs */
+	if (pde) /* PDE bit - we want to flush everything, not only the PTEs */
 		cmd->data[2] |= CMD_INV_IOMMU_PAGES_PDE_MASK;
 }
 
@@ -2153,7 +2153,7 @@ static bool pci_pri_tlp_required(struct pci_dev *pdev)
 }
 
 /*
- * If a device is not yet associated with a domain, this function does
+ * If a device is not yet associated with a domain, this function
  * assigns it visible for the hardware
  */
 static int attach_device(struct device *dev,
@@ -2403,7 +2403,7 @@ static struct protection_domain *get_domain(struct device *dev)
 	if (domain != NULL)
 		return domain;
 
-	/* Device not bount yet - bind it */
+	/* Device not bound yet - bind it */
 	dma_dom = find_protection_domain(devid);
 	if (!dma_dom)
 		dma_dom = amd_iommu_rlookup_table[devid]->default_dom;
@@ -2942,7 +2942,7 @@ static void __init prealloc_protection_domains(void)
 			alloc_passthrough_domain();
 			dev_data->passthrough = true;
 			attach_device(&dev->dev, pt_domain);
-			pr_info("AMD-Vi: Using passthough domain for device %s\n",
+			pr_info("AMD-Vi: Using passthrough domain for device %s\n",
 				dev_name(&dev->dev));
 		}
 
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 18a89b7..e417955 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -178,7 +178,7 @@ u16 *amd_iommu_alias_table;
 struct amd_iommu **amd_iommu_rlookup_table;
 
 /*
- * AMD IOMMU allows up to 2^16 differend protection domains. This is a bitmap
+ * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
  * to know which ones are already in use.
  */
 unsigned long *amd_iommu_pd_alloc_bitmap;
@@ -478,7 +478,7 @@ static int __init find_last_devid_acpi(struct acpi_table_header *table)
 
 /****************************************************************************
  *
- * The following functions belong the the code path which parses the ACPI table
+ * The following functions belong to the code path which parses the ACPI table
  * the second time. In this ACPI parsing iteration we allocate IOMMU specific
  * data structures, initialize the device/alias/rlookup table and also
  * basically initialize the hardware.
@@ -691,7 +691,7 @@ static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
 }
 
 /*
- * Reads the device exclusion range from ACPI and initialize IOMMU with
+ * Reads the device exclusion range from ACPI and initializes the IOMMU with
  * it
  */
 static void __init set_device_exclusion_range(u16 devid, struct ivmd_header *m)
@@ -1141,7 +1141,7 @@ static int __init amd_iommu_init_pci(void)
 /****************************************************************************
  *
  * The following functions initialize the MSI interrupts for all IOMMUs
- * in the system. Its a bit challenging because there could be multiple
+ * in the system. It's a bit challenging because there could be multiple
  * IOMMUs per PCI BDF but we can call pci_enable_msi(x) only once per
  * pci_dev.
  *
@@ -1199,7 +1199,7 @@ enable_faults:
  *
  * The next functions belong to the third pass of parsing the ACPI
  * table. In this last pass the memory mapping requirements are
- * gathered (like exclusion and unity mapping reanges).
+ * gathered (like exclusion and unity mapping ranges).
  *
  ****************************************************************************/
 
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index d0dab86..d1390b8 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -255,7 +255,7 @@
 #define PAGE_SIZE_ALIGN(address, pagesize) \
 		((address) & ~((pagesize) - 1))
 /*
- * Creates an IOMMU PTE for an address an a given pagesize
+ * Creates an IOMMU PTE for an address and a given pagesize
  * The PTE has no permission bits set
  * Pagesize is expected to be a power-of-two larger than 4096
  */
@@ -404,7 +404,7 @@ struct iommu_dev_data {
 	struct list_head dev_data_list;	  /* For global dev_data_list */
 	struct iommu_dev_data *alias_data;/* The alias dev_data */
 	struct protection_domain *domain; /* Domain the device is bound to */
-	atomic_t bind;			  /* Domain attach reverent count */
+	atomic_t bind;			  /* Domain attach reference count */
 	u16 devid;			  /* PCI Device ID */
 	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
 	bool passthrough;		  /* Default for device is pt_domain */
-- 
1.7.11.4


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--LpQ9ahxlCli8rRTG--
