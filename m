Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA863F4D1
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uU09/1kB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxU2eIYdK2YMDkQyypv92rZkb3rHFkV7LRLVVeMAUYehwCRdxThhIJW56qygwwLaydiY9CiWDKbWasrgq2Qh/pEnSnpx+HxKvjfy0jE4dE/Wd77OaGN1y6wChRubTWeNGaEj1e3I8Ez+PsYe8qf7BDb31yffpAfixe38uBy81ZVO3y/QsKr4TrTiGk0fFRqorBfIFgavXEGcwZBv0oQ3FGmRfn2SrpS+5nWmJQvIMQIWeM+bbO1svLSlJNuRPtvEHGTDqxC7LBUhzNUH0VA92iFpdVU86mMJ05GVHEDm/YcNU2XfvneMDBc81AnFtNKzVZkWVYNRS+jSPxtabiaDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eft+LToxyAKzuWOiA3B5QATFsC5ZpocaEpFz5NuCbWc=;
 b=Zil28aKKx2/LSK1b7u531p1ZFIjnblUu+dheuJUGbApM2Y3ss8G2bkhmAAy+PsDiG4E/ic5nELIU4LshsO9Ghj0zfrE3UIbDQqZaKUkbdKuc5Q0C0KMRSyF39b8sTfhqZsUtq2JHm/sE9thBzBRbNKLVLrvvU6d4rogAm3fjAZjKzzPto8LsUeZvbE0iu652YmpYFN3UQeSdldlNUrjVwrvJPxrhuaQTeMYbuZiE9pQhrlQOMxYPUpkzITNdwBaUPFvEkb6RCtQYfnxd3OqHYH4/x9PLSkGJ8VBWuWe22jtHbwU4wXd3q795sY7DaYFSXCIW3/v/AuTDuIbS869rsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eft+LToxyAKzuWOiA3B5QATFsC5ZpocaEpFz5NuCbWc=;
 b=uU09/1kB5vSBjTf6SkIijZyBJs6FP2NMjQiFbGSfopijULZpOKmElI3DCIHyjS4WNB9AyD299BtIdJ8Bcv/BJfQ4jv4ved0e7qpYlnBoFY/tM7RQwGMjiGapJfe3q1KpBEHtzMBF1x7tyUR8TnFsW3YtKwqELrqLUMjFyCvuiWQLBuL3G82CVgstV5V7VcAaqejKBJ0iT6EU5ysg/+W8b5aJt2A4xxYXSoLelnPjcapfA/AJK4mxvGMvEmXV07A6EwTBUz07yP9NW6vNqleBHsY0wP8INH+hqV3iebNyjbMrid2Tu79ccFnOf0v4jwFpSaqGl6EZ1sKTGWGlB8Wz8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 18:28:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 18:28:21 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH 7/7] iommu: Restore SMMU "disable_bypass"
Date: Thu,  5 Oct 2023 15:28:18 -0300
Message-ID: <7-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
In-Reply-To: <0-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f30f214-c536-4b7a-9701-08dbc5d0d9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bl7aw9LuxPbX+vUpnCY6rTb5aApHrgx+s6d0yuN9bib5Vag5Ulur966N6wjvgeHI1nZEIU67rnUewjWcdNa7pqGlkOELyXk3ZKQBKboTQ0SqCwWT4B+WYckArgpBjqOcdQ42g4Mms/b+Em2zrsxQhyO4wXC7FChknMyX4bmdu0GTRHTFDFOnE306ggXTRbwVceB0mDFta0Xxvp3RUOKKt6pZUvTDznTX+kqXn6CzfDI6I7FmQoBAsG+78zuCYpGetmC/03I9+x1ZklHAfNS/PsH+C9H/y9qjAiOPzkfRcJLfAWvfXb/GGIVyHsUM2oo+3uny/Vfr3e3aNZK/cuRxEgDPKtEWLpMFW5khwoDgSAyIlAscw5xpN2V+G2MQtCtYvdqkjzGXn1kqT5+Mwt/VRrEfUfqkWXoYwb3smqVp99iTWMTyKfiPRWNkpIQGYDV1cdnojU/UxKkZqwW+3+h2l4F6tajAWEOfrGHoOxtr/UCPCQhYpwX6nMlZV72aKuznCZyvylQlbe9wkPT7MuiCP+AA9Uby37/eZ+ZaKtqKvL1jQDTDJ0P9QhFeHttYYwHfqmEsqDEAWq2mbMmiDXORF1eICR/2DlAodd8iRvm7yQU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(2906002)(36756003)(86362001)(38100700002)(2616005)(41300700001)(4326008)(8676002)(8936002)(26005)(6512007)(6486002)(6506007)(66556008)(316002)(66476007)(83380400001)(6666004)(54906003)(110136005)(66946007)(478600001)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uxaN2JbptC8OWJ12Lv96P+pRPKJFFq5FFvbgumtsRFhv3x9s59qPLIIQTfQP?=
 =?us-ascii?Q?7j6bO6flnn2zviG/mH15YCsLnkaJh/SMYdy/A4cGBJYR5yiYmtKCiUv5su2M?=
 =?us-ascii?Q?dsX4hxnSraTkCpjopbCsFZVJnI9b8pF9R8wTCR9uCtZDIUmKebYtoh6PYttV?=
 =?us-ascii?Q?8JdOVEtI9ZlwoWFZv/Y4OKp15OPNfcoTJpVOXSHC3K33cidAJvUyO5KcX3ei?=
 =?us-ascii?Q?7PfPLurPolqjtQ8LNErIov3B6I3yjnCV7JUk/HbXPQBl72BLDgsDdcpTTNuk?=
 =?us-ascii?Q?GusI4E361peKaBas3tapPzhGHFI42bT2TykVLXHnK/JHezL3K+Xa/rQvxfcf?=
 =?us-ascii?Q?CXWioWDaYPDcHJhfBCZV7TT1lsd3P1izpre/MPyr5A9p/yXrFfAe0tFS3gi+?=
 =?us-ascii?Q?Btredb80XTxUVn8lY8FbZ7pjdV61kj4FCFHLjjgINqPOAy51qBKSdLCJj38s?=
 =?us-ascii?Q?4BeyW2U7z92MhD+nwhMxWrfdIT+p/F/lBxaXnLJx3aEgVXCSB+PEk1X8SDwg?=
 =?us-ascii?Q?NAXkSsnvM3zsoN1jNr8gcTkXieTGhht6C6WkIlVDmlORXc0rM6qAw0lBj00L?=
 =?us-ascii?Q?zaW3OLo2k6hIRdGWgmNTo+YdZ2orrM+hZVUy7tei8w6Osr3bMv2bhYiCeOXi?=
 =?us-ascii?Q?AXfPK8pxUFDFbJgd342raS8tZPmhd+hYCXzWyMVRIw7hyg1u5kPb6mtraYh2?=
 =?us-ascii?Q?jdLo3lNHrelF6p67Nko9AueQJ9f4Z/eaXCrlEeXewGIbbJcvZR10aJ/4ainy?=
 =?us-ascii?Q?SDBKeeG8h3J7MAYgYVndfyOzhPmQjQ7OHCOZq+E9CHSXA33rK654cVusUNY1?=
 =?us-ascii?Q?JtJeF7GZ1iyikoLUh+qLmNlnc9Vca0ARrbzctXJHvxRxbp84uE6rLoXSOrlb?=
 =?us-ascii?Q?2Bbc8JGl4OFAZE9fYQ7IKzyX+G6V0uk4uFLkM1U8IEvcx3bnUdVf/5NJq7LE?=
 =?us-ascii?Q?WNKCRG+xNGC2Phbwqa2h4nKGw2QRhnEO4CK3szomC3TnJeZWF0mqLUZJQtve?=
 =?us-ascii?Q?gcrtpb6CMhS2C+bGhViv9Rm+I+W1zib7xN+JkjPXgtw+QigQYN6xv5p6/oIZ?=
 =?us-ascii?Q?HN2/Ojw0g73Pn2zNTYk8qEinu7Xc5wv+13CBsvke1WM7X8/D/xsNeLwfdXSC?=
 =?us-ascii?Q?E2PgrMQFuintke8TdNWdSBmVEiRo8vftIt7vjXvdYvFO4kCFSiCrzlQsmO1P?=
 =?us-ascii?Q?gkIyZL/ogLOOC2AYAYh09/lMhX2OfmSndnFxw0PQ67VvaJxHozEMKvtHgzfc?=
 =?us-ascii?Q?oVXj1bV/W/kDB2ImClneoqtMQ/s75PoSLJpU7fJSYIfsVCx3QSDrzt2f2UZP?=
 =?us-ascii?Q?mlo4LJXl4Gf4aOEnOEA7fKGCtOa2yFWPSXO5DElZVD3CNw4doDmy/KPji1/0?=
 =?us-ascii?Q?444+omuLIsDNBRWJJzvAez3dBGzqe7GVT2/fiYWg3SPDSDMsZt5tcsc+rEqQ?=
 =?us-ascii?Q?mGAoXnW05S3ZQpsLgto+F7yclka3fe5UvmOshEgWbr4O8hNfOUfVNOCMPvw7?=
 =?us-ascii?Q?1lI6OtmubecT7y1Zv4cR49ni3xLXKkXzEjoxdEHdU8W4WZ7jJCdJSBS7gt9d?=
 =?us-ascii?Q?YX2hdjnF4HlHGh9r1sCkyXrsaMOcPqEDKbJpPtuz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f30f214-c536-4b7a-9701-08dbc5d0d9ee
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:28:20.4267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2aduOHCsYeS4csp4YAh+53ZO0tOexoN9QOAeRd8PcL401eP4ujilKgL/xQzAslY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364

The module parameter "disable_bypass" changes the IOMMU configuration when
using CONFIG_ARM_DMA_USE_IOMMU to establish a faulting/blocked domain when
the ARM DMA ops are not being used.

SMMU does this by defaulting the device configuration to faulting during
probe. This keeps things faulting up until the ARM DMA ops first attach,
then the faulting is lost.

Since we removed NULL domains and immediately attach an IDENTIY domain
during probe this now doesn't work properly on either driver.

Reflect the SMMU module option to the core code and have it request a
BLOCKED or IDENTITY domain directly, only for CONFIG_ARM_DMA_USE_IOMMU.

Fixes: 98ac73f99bc4 ("iommu: Require a default_domain for all iommu drivers")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c |  1 +
 drivers/iommu/iommu.c                 | 23 ++++++++++++++++++++++-
 include/linux/iommu.h                 |  2 ++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4d69bb63ba1a3e..e164477a224dac 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2211,6 +2211,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	iommu_arm_disable_bypass |= disable_bypass;
 	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (err) {
 		dev_err(dev, "Failed to register iommu\n");
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index efa65b3d1bd405..e2798d8318b7bb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -46,6 +46,13 @@ static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
 static u32 iommu_cmd_line __read_mostly;
 
+/*
+ * This supports the module option "disable_bypass" that ARM SMMU and SMMUv3
+ * drivers supported. It causes the default domain to be BLOCKED when
+ * CONFIG_ARM_DMA_USE_IOMMU.
+ */
+bool iommu_arm_disable_bypass = false;
+
 struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
@@ -1914,7 +1921,13 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
 		static_assert(!(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU) &&
 				IS_ENABLED(CONFIG_IOMMU_DMA)));
-		driver_type = IOMMU_DOMAIN_IDENTITY;
+		if (!iommu_arm_disable_bypass ||
+		    !group_iommu_ops(group)->blocked_domain)
+			driver_type = IOMMU_DOMAIN_IDENTITY;
+		else
+			for_each_group_device(group, gdev)
+				if (gdev->dev->iommu->require_direct)
+					driver_type = IOMMU_DOMAIN_IDENTITY;
 	}
 
 	for_each_group_device(group, gdev) {
@@ -1932,6 +1945,14 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
 		}
 	}
 
+	/*
+	 * For iommu_arm_disable_bypass mode the driver is allowed to force
+	 * IDENTITY, otherwise returning 0 from def_domain_type will mean
+	 * BLOCKED.
+	 */
+	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU) && driver_type == 0)
+		driver_type = IOMMU_DOMAIN_BLOCKED;
+
 	if (untrusted) {
 		if (driver_type && driver_type != IOMMU_DOMAIN_DMA) {
 			dev_err_ratelimited(
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e27d2e67e48ef7..c88150300bff71 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -42,6 +42,8 @@ struct iommu_sva;
 struct iommu_fault_event;
 struct iommu_dma_cookie;
 
+extern bool iommu_arm_disable_bypass;
+
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
 #define IOMMU_FAULT_WRITE	0x1
-- 
2.42.0

