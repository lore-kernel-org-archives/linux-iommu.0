Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D342F3A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1VUO8a70UuYp0sWJVq65sbHB1249u2//Z0QsS/269fMLLLc3K394Lvjgv88xSdgGaSW89RYpQyDPT2NJTJRvq+tteklPUHltwPaIzfi9CfHPGQjIgXNWhlywsvQBKc2JRCw7+bd9zw5JPPwJQ1VwHdcj+qrD4/AH2ea4BA4Y2J9cYEvNw0mef+ATaRg+I8bwyJ+bT8ChSVScvAvXw69Oa+fpI5RzYJnqVhzVs2y3GbYHaof3W9jfIR5Knk0P28atTJXYKNJkEvBmtq4cMy8YL11DoxsjL25wBFzoXRMaVPk6WhTPYJQzSQUn9FWcdg7OR/M7ds89aPQKhVsjuWVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nczLc5Xl9TF58uAtfT80qknR6yUKg//EN9rZYQjZwII=;
 b=lGC2lsEvqC4qp/X5xVeo9VrUj41h/i/pcbd5IDJoBPEsE0h9dfUiMkLnV1ezwMNxDIUNbpjL/trOzJ2IayMQ0pa1Y1jJQRKLkEMLDdue0yn4V9lKI/sKHLTyNV0YtY4xJDcV1PpI+4LMf3fqpL11Hede2qnKTKrYSCCjKteR9YrFyNV2xv/nkVQh6U7xDsnBFJMd65bJmlJa9xpDHZqAtn0uiHXIUouePcCB+3emVF25u5YzvbUkAJU7ySzuic1NTO8esIH2rIIATlykpD+5jaPZqgH1Bho28dKK13FtxUhIA+6AuCvCrXlU65pRMBFPYFAxcmz2cZdpnnyJPw1YOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nczLc5Xl9TF58uAtfT80qknR6yUKg//EN9rZYQjZwII=;
 b=t4d4/BQGG7kh5n41hJoUyefVQ0XDikAZTZehaa2h8fbZ4fpovfTqldqTIiTBpqwxZP5BEb9vb/kHIiDhn8W7AicbGZ9g03scChHtCVTe47p0x+LS2zNhGwhQtkbBqIUmeWnCEQmg3mI87quqdX+pbCVPOaHGI9MKUvPWKkEnFEI=
Received: from BN9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::11)
 by BN8PR12MB2850.namprd12.prod.outlook.com (2603:10b6:408:95::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Wed, 6 Jul
 2022 11:42:41 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::2c) by BN9P223CA0006.outlook.office365.com
 (2603:10b6:408:10b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Wed, 6 Jul 2022 11:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:42:41 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:42:39 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 01/35] iommu/amd: Update struct iommu_dev_data definition
Date: Wed, 6 Jul 2022 17:07:51 +0530
Message-ID: <20220706113825.25582-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 629ac0ce-5817-4840-d1f4-08da5f44a280
X-MS-TrafficTypeDiagnostic: BN8PR12MB2850:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bybfNF54Alpbi3QBsAAxstYrVYPT18n/VZMaRsu67I9El3CqKldKm7x3Q3rz4mb67gWeKdRUEqTZf7/VH6y//3nPqJD2gCi3QiFDeLhufqB7Tv4UX2dViSTpPqEzlHbBLZ7/CT1OFpo9xyev9ahoSzxjlZWsjrnr8fu2vEzf3kC9YmkAHlZ2krw93NhkgGzgd5Gfo6L4MGlWGTr+d5vHrQ4qtm8ULGtmLGJzVHG1TN/QIisp5aRPmpH8x9RSQzULZGya45JDK7Gp5bNjLpQGqe7HVsDQO1zHWlaMCVcI6etPvQG0lVNg1hWobFFTmgtwJrXgRBWb71sthdnU1t3qHoWr6MzEA/uPz7taUTB0IlGku7a67DaX3cv1RUiA0nvPiST3B5uSYdp3LViH9uLc/YwKEU2EfOPnfNUA2KfIfvXilNOv4+PZrlnRCSLFBRPe5IHddpuqrqyheI+aSDyQTKmQ28W6MN374uh5AaVorRTwPedF95mG4Pgj4wthkgQ7iNOazrzWOmVcW87z9Q/Xr2Sqt2g+Mu4gkUt8t4faRC8IniSK3vpJKgTWP/YMGUOYuH4w3WkuMnqCRTG9f7FCLfzNsmDsa9KmGmA0RY5Psm7KDvClHiMlW/XeVZUYHS7+K+ejRNjEzNYXgdkyXob90syQsgUyn37JuNDfEfivwAX3X6EF3eR/iGh9qFH76CbX/vNOpXjrpB59ZIvcOto4CGmrUdqj6gmLgh6FJ3mZhQVjoRn5XU21uh0JK5krLuboM6C1opeFV1FgI7DygimeQ4vj1cbR8XrheUYsVry64uS00dCXUMsnLcyp6K7kmkr2tZgOYTlKqYyq8jT7uRurekYViNY3yJ5kuee0k742bjdXs0iH8Ka0IpgyVZ6KCNGP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(47076005)(110136005)(40460700003)(426003)(336012)(26005)(54906003)(44832011)(82310400005)(16526019)(186003)(36756003)(316002)(83380400001)(1076003)(86362001)(2616005)(5660300002)(34020700004)(70586007)(81166007)(2906002)(40480700001)(36860700001)(478600001)(7696005)(8936002)(6666004)(8676002)(4326008)(41300700001)(70206006)(15650500001)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:42:41.4487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 629ac0ce-5817-4840-d1f4-08da5f44a280
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2850
Message-ID: <20220706113751.phcashTA-7QXoZ2zpqzYkxM8vgXGTJYojQ9cfRo7HWQ@z>

struct iommu_dev_data contains member "pdev" to point to pci_dev. This is
valid for only PCI devices and for other devices this will be NULL. This
causes unnecessary "pdev != NULL" check at various places.

Replace "struct pci_dev" member with "struct device" and use to_pci_dev()
to get pci device reference as needed. Also adjust setup_aliases() and
clone_aliases() function.

No functional change intended.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/iommu.c           | 32 +++++++++++++++++------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 72d0f5e2f651..9b563f850f1d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -689,7 +689,7 @@ struct iommu_dev_data {
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
 	struct protection_domain *domain; /* Domain the device is bound to */
-	struct pci_dev *pdev;
+	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
 	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
 	struct {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 840831d5d2ad..efa8af5a9419 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -188,10 +188,13 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
-static void clone_aliases(struct pci_dev *pdev)
+static void clone_aliases(struct device *dev)
 {
-	if (!pdev)
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
 		return;
+	pdev = to_pci_dev(dev);
 
 	/*
 	 * The IVRS alias stored in the alias table may not be
@@ -203,14 +206,14 @@ static void clone_aliases(struct pci_dev *pdev)
 	pci_for_each_dma_alias(pdev, clone_alias, NULL);
 }
 
-static struct pci_dev *setup_aliases(struct device *dev)
+static void setup_aliases(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	u16 ivrs_alias;
 
 	/* For ACPI HID devices, there are no aliases */
 	if (!dev_is_pci(dev))
-		return NULL;
+		return;
 
 	/*
 	 * Add the IVRS alias to the pci aliases if it is on the same
@@ -221,9 +224,7 @@ static struct pci_dev *setup_aliases(struct device *dev)
 	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number)
 		pci_add_dma_alias(pdev, ivrs_alias & 0xff, 1);
 
-	clone_aliases(pdev);
-
-	return pdev;
+	clone_aliases(dev);
 }
 
 static struct iommu_dev_data *find_dev_data(u16 devid)
@@ -331,7 +332,8 @@ static int iommu_init_device(struct device *dev)
 	if (!dev_data)
 		return -ENOMEM;
 
-	dev_data->pdev = setup_aliases(dev);
+	dev_data->dev = dev;
+	setup_aliases(dev);
 
 	/*
 	 * By default we use passthrough mode for IOMMUv2 capable device.
@@ -1232,13 +1234,17 @@ static int device_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
 static int device_flush_dte(struct iommu_dev_data *dev_data)
 {
 	struct amd_iommu *iommu;
+	struct pci_dev *pdev = NULL;
 	u16 alias;
 	int ret;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
 
-	if (dev_data->pdev)
-		ret = pci_for_each_dma_alias(dev_data->pdev,
+	if (dev_is_pci(dev_data->dev))
+		pdev = to_pci_dev(dev_data->dev);
+
+	if (pdev)
+		ret = pci_for_each_dma_alias(pdev,
 					     device_flush_dte_alias, iommu);
 	else
 		ret = iommu_flush_dte(iommu, dev_data->devid);
@@ -1561,7 +1567,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	/* Update device table */
 	set_dte_entry(dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
-	clone_aliases(dev_data->pdev);
+	clone_aliases(dev_data->dev);
 
 	device_flush_dte(dev_data);
 }
@@ -1577,7 +1583,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
 	clear_dte_entry(dev_data->devid);
-	clone_aliases(dev_data->pdev);
+	clone_aliases(dev_data->dev);
 
 	/* Flush the DTE entry */
 	device_flush_dte(dev_data);
@@ -1818,7 +1824,7 @@ static void update_device_table(struct protection_domain *domain)
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
 		set_dte_entry(dev_data->devid, domain,
 			      dev_data->ats.enabled, dev_data->iommu_v2);
-		clone_aliases(dev_data->pdev);
+		clone_aliases(dev_data->dev);
 	}
 }
 
-- 
2.31.1

