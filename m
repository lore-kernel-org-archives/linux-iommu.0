Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4121CF96
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184821; cv=fail; b=G2CkvhtvngarPbxtBWDswZHd4nj+R7Ek5TJnOXPHs3tIRQQwOf+6c8sWTfJT0LBVYaSXTTRTwKIyCF8KQP/yWwwR26/NPVXnMZ57N00+C0J5IubxVycTDM42xJ2084JucWq0pS6W9bs3XnBFoMuMOL5nnkvFy1EgD9aZYSrQSNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184821; c=relaxed/simple;
	bh=e5Opr/rClA7++RPVzXfmh7MQ7AzqQUcvdHhLAzmGJns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLqz/JP9mED9iLkrFvuNKM/DSR31zBugvaycrj8LpAULi8wXjwprA8vdvYm25y2tikc/uvI+Yhq+ucKvAV9/3/rdhQnPp8DR/CoIg5lekkvs0sMan+avLyRdORDDRCpjexQc1ah8SNws2+jpg6OEe+L6RbfsXcdWrjmfRes6GvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JaV7m8Ky; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JaV7m8Ky"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRiv8Na1olEhfI5tc9nzesH7y3m1A7+BCAh7U9DNLFOmNpxCcHVLzrmeCBPG/3oYbU8p3djEURZdjy32xKhSV+yM/SdNDXhq6Tibif5a8oyeLvoMa2pzwecTIRFG+90Jh8usCfAYY2xLaz5F45n+bEgHQc2mB2swxPQ5pBQlVzwMeVN4sqm6Z8ooofXuijEmIi0d86aqsoV/qZqfr2nk6a6iwSxmkcPk4j4dnM9gX1L9kA0q4lC9GKWYke/IMO+E9DacrU53G1whCX+NSVrIPBj26yh/iEJUEi7EXWwuR8p7sKnvdjWuwbBMIPCdi0WxPScMwQzJ0HcXiqsQXu3piw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msKd9Y1RgKJfFXq8jTfrve7Iofx7e9BNQMUL5l5fZdI=;
 b=PQlT93ngOwqhSS6Dm+MyRK7mr4O8g4/VGeZHbWLUW3v12Le292izWxxIQFxR5K9JClpqJq3uGm59kdBUs7zM38ngS7hJYb5zK9AOckNHS0oiOOZcUoo23senqO7dbaU2IESLod7zLcoRGynzkNiJaKwsAuPte00Fts0YXqJBJb2A+JYkzN/Xf1gNVzaQS4OMTU1idaASwYPHwM1aOqpshdbtS2sVDa4Y60iydkwDBW/CynAN+4n/bFmA+vXPQVI0SDiVguWbYQIzD5jlFokPUqMUemllGAdFh4QXDUWrlq9WG67joYsGc25l4HlhNpi0ctL2yw1HqEThAC4kZlpr8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msKd9Y1RgKJfFXq8jTfrve7Iofx7e9BNQMUL5l5fZdI=;
 b=JaV7m8Kypd+mQaSTfqc1gRoQ2WQu7H+QSMIh26nWzpYInlWk083G4kJGYbzWsAfyoy5KcTKQJCJTQM/Cc3mUIDhIznOr+hs4799GH1nn9zbwuLHvHJ9j9/ALkkOt+2j7rsK8NeEZPaBPiHQjCBjwrsMJSC2e2w4T47oayuyHdZo=
Received: from BL0PR02CA0129.namprd02.prod.outlook.com (2603:10b6:208:35::34)
 by SA1PR12MB6678.namprd12.prod.outlook.com (2603:10b6:806:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 12:13:34 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::17) by BL0PR02CA0129.outlook.office365.com
 (2603:10b6:208:35::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Thu, 25 Jan 2024 12:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 12:13:19 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:13:16 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 03/17] iommu/amd: Introduce get_amd_iommu_from_dev()
Date: Thu, 25 Jan 2024 12:11:21 +0000
Message-ID: <20240125121135.8217-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125121135.8217-1-vasant.hegde@amd.com>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SA1PR12MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: bc63810c-d71d-4ee3-e27d-08dc1d9f0d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HtcbaTMeoZrSwZm0z/9x4ho3hKDYewosjkt9SFi3fmHKvwr8IM7ieplnSC6S/+uF/d06jbhaSPMsvGgrdM/I6ltC862F3NIE0DcKzOrXsg/9bvc9iC3n6UkrfI4ioTidfwwSreMrUhGO4YGdu+5GKZedJT9vNBP5yvW8LWcE9dUhVQ6dUhaE2ZcwuG5XvEIucptDtwloBHoeNJ1c68j9s/UxpQSmRNtZ8ceW1/XlHPG9YyznsH1Uhu3/lr6yLnGnSQQxMXi7Mub7c1WwRgXkJgN0IRf6d61zn3pAxv47ry9VO009UO9KcPduczvZEHiVMJhMPiJuf3uX+J9Rg63n2N2pLDckzWMAMwn3iqhyfuGg5w4Srp7lpIrKLl6W6Hv3Z6ltDpK1HOsKc/NUNsIqM4Xb1jjaCXtGCbIxc9Tm/OS45IwdvLFRqC5Mkm7JwC7BJJ9W00x73wDExo/44BFLIS7Cn/UE5jCH1ZHb+pxM8KKvLSyDSoSYVjArqAoRQRr0mQsUH11A4nfQPQKCOd07/2wZWvpHCUNCHJLI/561t+6xnXoUwJyRV9hDL9bkaUy99ZBNIYPA3J2ZVs8eYkaB/N3iJvwPBP/kHQJCPQ7KM9tzCfl3g3gzCAlVWauNv+XWjKRK4rFEtBDljaovVcgCWjZgwmLyI7QBAZ2XHtKxsOzkGrqbY1y2ky6BKn9GbTAGYFw9K9/sY7eu5zhqHb/fSpTRmElYbdARl+vSZBwrB5hKYN6MdBYO/RIn7SpAPfJSAImCQNDossvf/wgV58Hs3Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(36840700001)(46966006)(40470700004)(36756003)(54906003)(2906002)(316002)(86362001)(356005)(70586007)(41300700001)(110136005)(81166007)(70206006)(5660300002)(44832011)(8936002)(4326008)(8676002)(40480700001)(2616005)(6666004)(7696005)(1076003)(40460700003)(36860700001)(83380400001)(426003)(16526019)(26005)(336012)(47076005)(82740400003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:13:19.9610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc63810c-d71d-4ee3-e27d-08dc1d9f0d96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6678

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Introduce get_amd_iommu_from_dev() and get_amd_iommu_from_dev_data().
And replace rlookup_amd_iommu() with the new helper function where
applicable to avoid unnecessary loop to look up struct amd_iommu from
struct device.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h | 15 ++++++++++
 drivers/iommu/amd/iommu.c     | 54 +++++++++--------------------------
 include/linux/iommu.h         | 16 +++++++++++
 3 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 8b3601f285fd..31275bc6e9e4 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -150,6 +150,21 @@ static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
 	return page ? page_address(page) : NULL;
 }
 
+/*
+ * This must be called after device probe completes. During probe
+ * use rlookup_amd_iommu() get the iommu.
+ */
+static inline struct amd_iommu *get_amd_iommu_from_dev(struct device *dev)
+{
+	return iommu_get_iommu_dev(dev, struct amd_iommu, iommu);
+}
+
+/* This must be called after device probe completes. */
+static inline struct amd_iommu *get_amd_iommu_from_dev_data(struct iommu_dev_data *dev_data)
+{
+	return iommu_get_iommu_dev(dev_data->dev, struct amd_iommu, iommu);
+}
+
 bool translation_pre_enabled(struct amd_iommu *iommu);
 bool amd_iommu_is_attach_deferred(struct device *dev);
 int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 77612142f436..eefd399c5086 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1388,14 +1388,9 @@ void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
 static int device_flush_iotlb(struct iommu_dev_data *dev_data, u64 address,
 			      size_t size, ioasid_t pasid, bool gn)
 {
-	struct amd_iommu *iommu;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	struct iommu_cmd cmd;
-	int qdep;
-
-	qdep     = dev_data->ats_qdep;
-	iommu    = rlookup_amd_iommu(dev_data->dev);
-	if (!iommu)
-		return -EINVAL;
+	int qdep = dev_data->ats_qdep;
 
 	build_inv_iotlb_pages(&cmd, dev_data->devid, qdep, address,
 			      size, pasid, gn);
@@ -1415,16 +1410,12 @@ static int device_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
  */
 static int device_flush_dte(struct iommu_dev_data *dev_data)
 {
-	struct amd_iommu *iommu;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	struct pci_dev *pdev = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	u16 alias;
 	int ret;
 
-	iommu = rlookup_amd_iommu(dev_data->dev);
-	if (!iommu)
-		return -EINVAL;
-
 	if (dev_is_pci(dev_data->dev))
 		pdev = to_pci_dev(dev_data->dev);
 
@@ -1809,11 +1800,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
-	struct amd_iommu *iommu;
-
-	iommu = rlookup_amd_iommu(dev_data->dev);
-	if (!iommu)
-		return;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
 	/* Update data structures */
 	dev_data->domain = domain;
@@ -1837,11 +1824,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 static void do_detach(struct iommu_dev_data *dev_data)
 {
 	struct protection_domain *domain = dev_data->domain;
-	struct amd_iommu *iommu;
-
-	iommu = rlookup_amd_iommu(dev_data->dev);
-	if (!iommu)
-		return;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
 	/* Update data structures */
 	dev_data->domain = NULL;
@@ -2008,10 +1991,8 @@ static void update_device_table(struct protection_domain *domain)
 	struct iommu_dev_data *dev_data;
 
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+		struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
-		if (!iommu)
-			continue;
 		set_dte_entry(iommu, dev_data);
 		clone_aliases(iommu, dev_data->dev);
 	}
@@ -2192,11 +2173,8 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	struct protection_domain *domain;
 	struct amd_iommu *iommu = NULL;
 
-	if (dev) {
-		iommu = rlookup_amd_iommu(dev);
-		if (!iommu)
-			return ERR_PTR(-ENODEV);
-	}
+	if (dev)
+		iommu = get_amd_iommu_from_dev(dev);
 
 	/*
 	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system,
@@ -2277,7 +2255,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
-	struct amd_iommu *iommu = rlookup_amd_iommu(dev);
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	int ret;
 
 	/*
@@ -2416,7 +2394,7 @@ static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 	case IOMMU_CAP_DEFERRED_FLUSH:
 		return true;
 	case IOMMU_CAP_DIRTY_TRACKING: {
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev);
+		struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 
 		return amd_iommu_hd_support(iommu);
 	}
@@ -2445,9 +2423,7 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	}
 
 	list_for_each_entry(dev_data, &pdomain->dev_list, list) {
-		iommu = rlookup_amd_iommu(dev_data->dev);
-		if (!iommu)
-			continue;
+		iommu = get_amd_iommu_from_dev_data(dev_data);
 
 		dev_table = get_dev_table(iommu);
 		pte_root = dev_table[dev_data->devid].data[0];
@@ -2507,9 +2483,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		return;
 
 	devid = PCI_SBDF_TO_DEVID(sbdf);
-	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
-		return;
+	iommu = get_amd_iommu_from_dev(dev);
 	pci_seg = iommu->pci_seg;
 
 	list_for_each_entry(entry, &pci_seg->unity_map, list) {
@@ -2843,9 +2817,7 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 	struct iommu_cmd cmd;
 
 	dev_data = dev_iommu_priv_get(&pdev->dev);
-	iommu    = rlookup_amd_iommu(&pdev->dev);
-	if (!iommu)
-		return -ENODEV;
+	iommu    = get_amd_iommu_from_dev(&pdev->dev);
 
 	build_complete_ppr(&cmd, dev_data->devid, pasid, status,
 			   tag, dev_data->pri_tlp);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2f765ae06021..7f6342bc71c3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -675,6 +675,22 @@ static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
 	return (struct iommu_device *)dev_get_drvdata(dev);
 }
 
+/**
+ * iommu_get_iommu_dev - Get iommu_device for a device
+ * @dev: an end-point device
+ *
+ * Note that this function must be called from the iommu_ops
+ * to retrieve the iommu_device for a device, which the core code
+ * guarentees it will not invoke the op without an attached iommu.
+ */
+static inline struct iommu_device *__iommu_get_iommu_dev(struct device *dev)
+{
+	return dev->iommu->iommu_dev;
+}
+
+#define iommu_get_iommu_dev(dev, type, member) \
+	container_of(__iommu_get_iommu_dev(dev), type, member)
+
 static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 {
 	*gather = (struct iommu_iotlb_gather) {
-- 
2.31.1

