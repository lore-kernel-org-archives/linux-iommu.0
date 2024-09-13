Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D9154C04
	for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 05:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726205158; cv=fail; b=bw/EFCzFkBMrPjQGuLHZMVv8nCg934WMrUTdlLt9bOz4PYcm/CtqcaPqah3BJc1OrrCPtn/u/IXKTDx/wLSiyIUBX1m9YPhTQc9jkoX/Rs/4fU29QpkSllDk96y/K5QTYV+WMQKrNj0HOHi0yed0HP80pjG1teyQBM77FgAqins=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726205158; c=relaxed/simple;
	bh=kS7mMd3Sf7WNWOjMCf/LNoq/e9tYKVW+Jrnjq6qCmQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bahytHVE+z10ZlmkmxFFS3ZwZw+hmni8PvcLsZXn0pPPZyT3f9NQ4JNCvotJzbqGnizAT7SxlYcqzPx3lcM6XCVG27v4Pcatx3qaBVBQV9t1cr+2sRFjkl6wXlO/ovYFfWe/DGUhubmFNPcQSS4zE+kuUm/ylrd4WyZ3ihBPudM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fw9aEFBw; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fw9aEFBw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szV2pF6GhFb63gUlnTSHRuhLa/+xwklpZfl4GO4GH1L6J5L8jmocr6LgHcl1sRjZskUWkHmGlgT7I7PhUzGdC4uJZZg+PE9auNpvRulmjr6epMGD4jzUKMIGoei4juk4YcLeoxf6jRDpssBcuUxfHlTEYQTPu/pwdI3/OOAJT1ENlj2w/7wvqJ9dKsM1D/L9SlijfkIZ4QurwsYguiaabdqR/9y0AN5Bn1Dvf0xHah7tkK7MYfaVB8J7hIwAJzdKDu0RTH/PLqWNnfr3jKCJUWy4KVtyHDiQglqmKxVX8MCHO/6XuCKSL9r3tCI+0LWY8I63TmXjNIhfGFoUynZNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CgEMvQNi1+YMzm/OANmnx/mjHrdrStrHhNACOGX8Mk=;
 b=HkfUjx1vLO9+8S8kTPwA5ibHbm+uZInOejzhUge+rqY45MQRT+m5gGgz8256i4quEHZLa027738xmM6mU2MlRnfn6eKm7RKDptgVhCTQXV/pLYMfHFtmBLh+V8NyzQ9M5f0XhbHSwn1o1oNeGeGQsoDLjY1fH0uPFt9RtmxdCPlzmBdZ0xUTrXxOEiH4UC588MDPm2qJExuXnNB1UsgUPMlgs9sJJqSFoqBCFrd9vF4SFN/0L7Iukcrmflsyv0KaZGqQ9cwYhFYtrkXvFN5X6GlWWaQK3o3gELwHkIka92ncug1115yi/pLXKC5S66hAR18a166JCesUMzOq/qUM0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CgEMvQNi1+YMzm/OANmnx/mjHrdrStrHhNACOGX8Mk=;
 b=Fw9aEFBwbKp+heHA3Kal2CkshtCvBMagoYaJjEylR+LK/NWZySB0qw8sS7anaCL1UyW9Qmaj4STiH6RItJn19OY7XxXn8flmSWG1Hqd+CNLQY3QB6mu0akHeqoTSvbkjMBN15zIHWuryP+nGGJHmgoGP+jB0mesAUrXwQefr0BvzBh21xw0Gld+wGEekHsbmQRwwCCxYKHyEOXNOoCVQ7esNS//2wfko/lcLgR76YfX8uug/jqER5qBbMr520nNU0O2ihxHdxP3vpq6A3sElVkxP9saI/2yptlTFEn+hclO/oZPmVg37DzfPS4RJ5ubWMqNnjEPCPHgI0vYrO1rwmQ==
Received: from BN8PR03CA0016.namprd03.prod.outlook.com (2603:10b6:408:94::29)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 05:25:47 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:94:cafe::4b) by BN8PR03CA0016.outlook.office365.com
 (2603:10b6:408:94::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Fri, 13 Sep 2024 05:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 05:25:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Sep
 2024 22:25:38 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Sep
 2024 22:25:37 -0700
Received: from Asurada-9440.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Sep 2024 22:25:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <bagasdotme@gmail.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>
Subject: [PATCH v3] Documentation: userspace-api: iommufd: Update HWPT_PAGING and HWPT_NESTED
Date: Thu, 12 Sep 2024 22:25:19 -0700
Message-ID: <20240913052519.2153-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: d773786f-9915-46ce-f064-08dcd3b485a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rq+TtykBOwsdTP2pL5wRy/50oKdAgtwlllULzv+EWG9weajv07NEA3e3yf3m?=
 =?us-ascii?Q?ObNHLX+SwOi2RfkIhNfkh2VbLQfqiUU/a0NiuKHCsbNVwgVym2+rtDDtkXo6?=
 =?us-ascii?Q?ctIbecB0us5lYU/GDxuBEqB4RQT7L7VzbrHd8+zekq6Ia3D5PqrDGBWI55ZM?=
 =?us-ascii?Q?A6v4XxYQWbYwXM0EEaDvD5RFlk6I17AelkyYLK7yLUtMV/Ft6h59KPe1MNOi?=
 =?us-ascii?Q?gNA38tmjSEljStWWjzow+pnWKT1mrjyAHMR+EgCynyYrg4GP80n3I19/A95i?=
 =?us-ascii?Q?JjDBYZO2l30iPIRJ0xjatzEjVN7aTiIYRPhmj83yCeEY/RAOigjl7SgZBT0V?=
 =?us-ascii?Q?IDu4JLKtXZGXNEqZJI7d34MzZz/vQT7fMS5R+kxNie3lI2uFhTAdEqoEY8mT?=
 =?us-ascii?Q?7VH9evwsmN4u9yWT7iyMSCDVQW/QwidEiznHN7lJHB8BrIW36+z8LRp1/WUL?=
 =?us-ascii?Q?h34Jvs9wbn1pznXcu+zHvD3sSb5aRHw8V4aS3oUW1K+BF1CqxFwLXaBSbGQX?=
 =?us-ascii?Q?+R++4s0Jz7KoJ8PjS/eaIXmTcR1LVcLQ3UEr+lD/4m1d8uWrd0ik2JBnnlAZ?=
 =?us-ascii?Q?kSgCZ71BqaJcUV4qEY/pUBQBriKW/MFxqOqkIpVMQPDB50VxMCMNrMFEY72K?=
 =?us-ascii?Q?ttH7vENSb0o07F+PrXSpftO0N90fVChcRl0FTBQHe066Ipsp7TCLsmWaFrEt?=
 =?us-ascii?Q?gbiEgCAaRjXIZhvLoFHCvz/AgYeafoy2OeHlqTnzijJaxk8zI904KgbyCKW1?=
 =?us-ascii?Q?ka9hcDZpAl+zlOLLh6ka/GkfHoGJ3cprQ/ldB+iLskQE/VcBkeqZDREY0JQV?=
 =?us-ascii?Q?XhgcDNOsYUi0L3jrXmDqBXsBCyS/yZlUemNzl5oOmsu2oJLpPtqA4jZgFFvi?=
 =?us-ascii?Q?q5FKVdkwkvZK7ZF+xTxbJ594/lFZIM9+VwiKuM6bmTqRE//Tz1EAbv2T7OMp?=
 =?us-ascii?Q?I/SVa6UAcazRphbCXRvVw2hELOChYqnO0C6WvofFrOlLahgwjlOxwLMCk8E4?=
 =?us-ascii?Q?ljTPXgrQE1vF+WJgeRuxbyulRwg9qCuvxl82mmqK6JLWWdaNrxuBikqdn9rw?=
 =?us-ascii?Q?VBe5pFMgQwJ2tDKYbLDXfFXMIpY+84eIEFkH1lEgPzYsklmtOic3uI5/J0vR?=
 =?us-ascii?Q?shCmI9kmXLaFSYvoJvbQMCBg9DtOPTPPk3UKlm6NE0Q5ScFr+crz4I+WxeIE?=
 =?us-ascii?Q?0IKpeQAgTOsXzFoDUM3vA6CsTFFNcAKWYXEAXIWzaypoJYglLGuBIdGxp8xC?=
 =?us-ascii?Q?OFKU7ND0Sk4oHH1Q1i4REg9IwSiQR4H1vci3LZRj1ijO53kASN+hdlSSLwFa?=
 =?us-ascii?Q?6q3gs+U9px+++5YLFYj2gbHvxnLn3T0M2rYJRy9IQQl1eX0wW0XF41IaMMxH?=
 =?us-ascii?Q?8AfipB+5p6u+aog/E5ZMfUs9Oa8VBBpvS4Atlj8OB3Q1FeUkn/fQPCfigDt1?=
 =?us-ascii?Q?Q89Uer/g+du4WaAZD3OJen0jMdFxWqSa?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 05:25:46.7514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d773786f-9915-46ce-f064-08dcd3b485a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171

The previous IOMMUFD_OBJ_HW_PAGETABLE has been reworked to two separated
objects: IOMMUFD_OBJ_HWPT_PAGING and IOMMUFD_OBJ_HWPT_NESTED in order to
support a nested translation context.

Corresponding to the latest iommufd APIs and uAPIs, update the doc so as
to reflect the new design.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---

Changelog
v3:
 * Minor word changings
v2:
 https://lore.kernel.org/all/20240912021503.205502-1-nicolinc@nvidia.com/
 * Minor paragraph changes to reduce redundancy
 * Added nested bullet list to IOMMUFD_OBJ_HWPT_PAGING section
v1:
 https://lore.kernel.org/all/20240910204111.7969-1-nicolinc@nvidia.com/

 Documentation/userspace-api/iommufd.rst | 134 +++++++++++++++---------
 1 file changed, 87 insertions(+), 47 deletions(-)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index aa004faed5fd..2deba93bf159 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -41,46 +41,65 @@ Following IOMMUFD objects are exposed to userspace:
 - IOMMUFD_OBJ_DEVICE, representing a device that is bound to iommufd by an
   external driver.
 
-- IOMMUFD_OBJ_HW_PAGETABLE, representing an actual hardware I/O page table
-  (i.e. a single struct iommu_domain) managed by the iommu driver.
-
-  The IOAS has a list of HW_PAGETABLES that share the same IOVA mapping and
-  it will synchronize its mapping with each member HW_PAGETABLE.
+- IOMMUFD_OBJ_HWPT_PAGING, representing an actual hardware I/O page table
+  (i.e. a single struct iommu_domain) managed by the iommu driver. "PAGING"
+  primarly indicates this type of HWPT should be linked to an IOAS. It also
+  indicates that it is backed by an iommu_domain with __IOMMU_DOMAIN_PAGING
+  feature flag. This can be either an UNMANAGED stage-1 domain for a device
+  running in the user space, or a nesting parent stage-2 domain for mappings
+  from guest-level physical addresses to host-level physical addresses.
+
+  The IOAS has a list of HWPT_PAGINGs that share the same IOVA mapping and
+  it will synchronize its mapping with each member HWPT_PAGING.
+
+- IOMMUFD_OBJ_HWPT_NESTED, representing an actual hardware I/O page table
+  (i.e. a single struct iommu_domain) managed by user space (e.g. guest OS).
+  "NESTED" indicates that this type of HWPT should be linked to an HWPT_PAGING.
+  It also indicates that it is backed by an iommu_domain that has a type of
+  IOMMU_DOMAIN_NESTED. This must be a stage-1 domain for a device running in
+  the user space (e.g. in a guest VM enabling the IOMMU nested translation
+  feature.) As such, it must be created with a given nesting parent stage-2
+  domain to associate to. This nested stage-1 page table managed by the user
+  space usually has mappings from guest-level I/O virtual addresses to guest-
+  level physical addresses.
 
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
-The diagram below shows relationship between user-visible objects and kernel
+The diagrams below show relationships between user-visible objects and kernel
 datastructures (external to iommufd), with numbers referred to operations
 creating the objects and links::
 
-  _________________________________________________________
- |                         iommufd                         |
- |       [1]                                               |
- |  _________________                                      |
- | |                 |                                     |
- | |                 |                                     |
- | |                 |                                     |
- | |                 |                                     |
- | |                 |                                     |
- | |                 |                                     |
- | |                 |        [3]                 [2]      |
- | |                 |    ____________         __________  |
- | |      IOAS       |<--|            |<------|          | |
- | |                 |   |HW_PAGETABLE|       |  DEVICE  | |
- | |                 |   |____________|       |__________| |
- | |                 |         |                   |       |
- | |                 |         |                   |       |
- | |                 |         |                   |       |
- | |                 |         |                   |       |
- | |                 |         |                   |       |
- | |_________________|         |                   |       |
- |         |                   |                   |       |
- |_________|___________________|___________________|_______|
-           |                   |                   |
-           |              _____v______      _______v_____
-           | PFN storage |            |    |             |
-           |------------>|iommu_domain|    |struct device|
-                         |____________|    |_____________|
+  _______________________________________________________________________
+ |                      iommufd (HWPT_PAGING only)                       |
+ |                                                                       |
+ |        [1]                  [3]                                [2]    |
+ |  ________________      _____________                        ________  |
+ | |                |    |             |                      |        | |
+ | |      IOAS      |<---| HWPT_PAGING |<---------------------| DEVICE | |
+ | |________________|    |_____________|                      |________| |
+ |         |                    |                                  |     |
+ |_________|____________________|__________________________________|_____|
+           |                    |                                  |
+           |              ______v_____                          ___v__
+           | PFN storage |  (paging)  |                        |struct|
+           |------------>|iommu_domain|<-----------------------|device|
+                         |____________|                        |______|
+
+  _______________________________________________________________________
+ |                      iommufd (with HWPT_NESTED)                       |
+ |                                                                       |
+ |        [1]                  [3]                [4]             [2]    |
+ |  ________________      _____________      _____________     ________  |
+ | |                |    |             |    |             |   |        | |
+ | |      IOAS      |<---| HWPT_PAGING |<---| HWPT_NESTED |<--| DEVICE | |
+ | |________________|    |_____________|    |_____________|   |________| |
+ |         |                    |                  |               |     |
+ |_________|____________________|__________________|_______________|_____|
+           |                    |                  |               |
+           |              ______v_____       ______v_____       ___v__
+           | PFN storage |  (paging)  |     |  (nested)  |     |struct|
+           |------------>|iommu_domain|<----|iommu_domain|<----|device|
+                         |____________|     |____________|     |______|
 
 1. IOMMUFD_OBJ_IOAS is created via the IOMMU_IOAS_ALLOC uAPI. An iommufd can
    hold multiple IOAS objects. IOAS is the most generic object and does not
@@ -94,21 +113,41 @@ creating the objects and links::
    device. The driver must also set the driver_managed_dma flag and must not
    touch the device until this operation succeeds.
 
-3. IOMMUFD_OBJ_HW_PAGETABLE is created when an external driver calls the IOMMUFD
-   kAPI to attach a bound device to an IOAS. Similarly the external driver uAPI
-   allows userspace to initiate the attaching operation. If a compatible
-   pagetable already exists then it is reused for the attachment. Otherwise a
-   new pagetable object and iommu_domain is created. Successful completion of
-   this operation sets up the linkages among IOAS, device and iommu_domain. Once
-   this completes the device could do DMA.
-
-   Every iommu_domain inside the IOAS is also represented to userspace as a
-   HW_PAGETABLE object.
+3. IOMMUFD_OBJ_HWPT_PAGING can be created in two ways:
+
+   * IOMMUFD_OBJ_HWPT_PAGING is automatically created when an external driver
+     calls the IOMMUFD kAPI to attach a bound device to an IOAS. Similarly the
+     external driver uAPI allows userspace to initiate the attaching operation.
+     If a compatible member HWPT_PAGING object exists in the IOAS's HWPT_PAGING
+     list, then it will be reused. Otherwise a new HWPT_PAGING that represents
+     an iommu_domain to userspace will be created, and then added to the list.
+     Successful completion of this operation sets up the linkages among IOAS,
+     device and iommu_domain. Once this completes the device could do DMA.
+
+   * IOMMUFD_OBJ_HWPT_PAGING can be manually created via the IOMMU_HWPT_ALLOC
+     uAPI, provided an ioas_id via @pt_id to associate the new HWPT_PAGING to
+     the corresponding IOAS object. The benefit of this manual allocation is to
+     allow allocation flags (defined in enum iommufd_hwpt_alloc_flags), e.g. it
+     allocates a nesting parent HWPT_PAGING if the IOMMU_HWPT_ALLOC_NEST_PARENT
+     flag is set.
+
+4. IOMMUFD_OBJ_HWPT_NESTED can be only manually created via the IOMMU_HWPT_ALLOC
+   uAPI, provided an hwpt_id via @pt_id to associate the new HWPT_NESTED object
+   to the corresponding HWPT_PAGING object. The associating HWPT_PAGING object
+   must be a nesting parent manually allocated via the same uAPI previously with
+   an IOMMU_HWPT_ALLOC_NEST_PARENT flag, otherwise the allocation will fail. The
+   allocation will be further validated by the IOMMU driver to ensure that the
+   nesting parent domain and the nested domain being allocated are compatible.
+   Successful completion of this operation sets up linkages among IOAS, device,
+   and iommu_domains. Once this completes the device could do DMA via a 2-stage
+   translation, a.k.a nested translation. Note that multiple HWPT_NESTED objects
+   can be allocated by (and then associated to) the same nesting parent.
 
    .. note::
 
-      Future IOMMUFD updates will provide an API to create and manipulate the
-      HW_PAGETABLE directly.
+      Either a manual IOMMUFD_OBJ_HWPT_PAGING or an IOMMUFD_OBJ_HWPT_NESTED is
+      created via the same IOMMU_HWPT_ALLOC uAPI. The difference is at the type
+      of the object passed in via the @pt_id field of struct iommufd_hwpt_alloc.
 
 A device can only bind to an iommufd due to DMA ownership claim and attach to at
 most one IOAS object (no support of PASID yet).
@@ -120,7 +159,8 @@ User visible objects are backed by following datastructures:
 
 - iommufd_ioas for IOMMUFD_OBJ_IOAS.
 - iommufd_device for IOMMUFD_OBJ_DEVICE.
-- iommufd_hw_pagetable for IOMMUFD_OBJ_HW_PAGETABLE.
+- iommufd_hwpt_paging for IOMMUFD_OBJ_HWPT_PAGING.
+- iommufd_hwpt_nested for IOMMUFD_OBJ_HWPT_NESTED.
 
 Several terminologies when looking at these datastructures:
 
-- 
2.34.1

