Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0C1A76C9
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000914; cv=fail; b=RMFkVDvTKnSDL614KlyczigRiqdH+xaB0cf/JfMC1DKySwRQ5/MdjViJ6Wr7RrgHSHI+K9N8NoltvhkRbw030kAa0xPvqlaEtCnkHzBK8iszWnT9HlQtOpHtMNXhOGe8d4XF2iaRWL1oZjP/a3rheOp4S7P+wDHaTYYeyc1bzJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000914; c=relaxed/simple;
	bh=2pWRwSd+Gc5o+ja40Qrw49l3v3+aIi9Y/kdPneJoz7A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KkQlJbNpSp6mpyLKY3oKzX8fDBfIM3poJdZJmhYjHFcbwR5FHauO0s2VnuoXx4E64b3v0VFgI6jicuAD2rfQCLKbDRNbtiaIzdbFmqUvxC2EnTL7a39043WvBBZc9xPKZxdTmiOqeBeZKpWv0oXdV4p7skKisiWnRkQ1SKMRA2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sWdOYIUU; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sWdOYIUU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8Ppgy7+ssScw7HIhtbsuCz+6qzQu5oGXLpVJdBlF6uBeTb6Pbp5llu3fKf5reO50qiIKBLRSglHg1ynuy2ThAjqMugcazBI8emNXi0KgNbKvPSkKpJXbm+1TS9HFolxexJMRF8WlLkWPwhawe/sRCyILiqhpHFb6GoQAAVn3w6vPiA/QBcgaCQMd3ai+kBfJ9zccz3CYPSyf3XjW3Ku7Tsw3RjSx0739USiTs57GWzYEkWd/NtksaDyyqyLwsdxCOw5CZIaEgTbdQMHG4obl5vUo1Etz61YP4OxjGSIRMjENnC9cnEmyKIe0O4i8GnbrvyHlJ4F9Dey8vNfpRkpCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0uHozzWz811i2pojcrClwyeC133/2l9qaA9oielkDo=;
 b=db+fmocOyPVh0NNzTO0aZFcMUEa3QHXVA8J62xQYlGMsrTBHfZ2WPmj+CuslvON3CWwe5ecr+FFsNnJilGZk51JhReF5Ql8FG2d8FzQu4n2FdynIz6+x+QLd0ckdpW9eYIOs/y5GGBvaBCdIVsEH3sWMIlgfvZaFDLiaGhkA3WpUB53arjHqDAa4tE9bTHb/92LrU4LMgyXDIlKDKLpcHJ2dll9ngA7RHT1mjmaOhI3dP+8Fms/VjNqUDcC0QxpbgYK/nWDUZRT/CDy79AL4VLcRQmf7hpwmBDHK3JB79Vqyv+Vv6h7GzIvzZruryTaBLViBIUIdOcMTcVp0eepTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0uHozzWz811i2pojcrClwyeC133/2l9qaA9oielkDo=;
 b=sWdOYIUU3L1hiSGXTVy2yM9wXDzFXYx/jVLiw5fY6nDwbTkwgb7xlIcU8BSQmDckBNBVB90vEOgR6dxpdzafgAENLRrO/WB3PYfhmXgUfVBTO+8qzGFWu0xcVrq5Dj7QkngVqxk+rujKufNJQeOvSz5ONDt7vZLLnvo9zZxH2PU81iWTdgMFD42Ndw4d317oddJwj1qPcmLRx5ys1cK3Czfrk+EHO3wgM8SCT1NWtrMGvHKtKUXB5ejt1o2O0Jdn4JiMDkPoXkZVVVERsFQPk4QxyhR9aARU7md6nEITjNuV34X4kfolDXSP/ZBWgWtn02nqNuyO+hhJ0L7mJApcVQ==
Received: from SJ0PR05CA0060.namprd05.prod.outlook.com (2603:10b6:a03:33f::35)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 20:41:46 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::34) by SJ0PR05CA0060.outlook.office365.com
 (2603:10b6:a03:33f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 20:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 20:41:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Sep
 2024 13:41:35 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Sep
 2024 13:41:35 -0700
Received: from Asurada-9440.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 10 Sep 2024 13:41:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <corbet@lwn.net>, <iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yi.l.liu@intel.com>,
	<eric.auger@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <baolu.lu@linux.intel.com>
Subject: [PATCH] Documentation: userspace-api: iommufd: Update HWPT_PAGING and HWPT_NESTED
Date: Tue, 10 Sep 2024 13:41:11 -0700
Message-ID: <20240910204111.7969-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fde957f-5d27-4c15-1be6-08dcd1d8fc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0V+Oulc+/fyiRXFVRAgQjBEHr6ng/6izgAzkNHTrNgRCG3ZeK5Q4lUGQk/zb?=
 =?us-ascii?Q?4cvJeqiB8MXKYfXIdkYfaW4vaKm8lsh9e+wgfY5tRO93exK3M0cqNQBLv2dM?=
 =?us-ascii?Q?nDrqdMvwCQisIu2RW6bj17E4/DetKiVcH3jQnNrsGICr71CJ5ExNZkJap0vE?=
 =?us-ascii?Q?NmHIOaB52xXOFDf72w2abBAV409nq13PVuTX73nEA44CnlgYCPLd4/PCb5BD?=
 =?us-ascii?Q?GDXdF118V1RcCSanlHZQCml0yhAfqxcgOTIHfNAJrgTiYjSsdNu1lv4khFet?=
 =?us-ascii?Q?awuHRwUr8S4U3qGLZJbM2FBjoEAjpxa5CJXNauudEQb1bH9j67IrJfw1C+vF?=
 =?us-ascii?Q?RgjWPcqZt2w9ZkvMgkeYCWdRg/UoAvJIS/nkDf9up8rv3ttM/0dICUp3am4e?=
 =?us-ascii?Q?FYJwhv0RYfYJDThnX304ipyRpYTPd1ot/AztUEWyETfk4EpRgHTPNAv3P/0n?=
 =?us-ascii?Q?rf96/1grpDTy/k7fHtBAkYi6epX9E7CYFa8OKxygVd1zJsoExpgrfcT5Bhd6?=
 =?us-ascii?Q?Y3Db194r/T9LxpEc9LUygsmG/6IJM4NsGhLzTD751+OdbeCVeUvb0oEbCYQw?=
 =?us-ascii?Q?NXRYNWEFMjw5o15sGnkCXTZf7S7mXiR7WHCBtw8SgVYeIDAQ/bYQ4zsEJNqE?=
 =?us-ascii?Q?DetQjEasqIJ7AttQqz7zL6axH0OfwLKuv3/2p3xgMY+VJ74e/9maYzZzj4PT?=
 =?us-ascii?Q?7yBMMwe4oE0mexywd9t32kBj5Vv38fbH0nQys/3epZNVHFcdkGJCPsKCvNbk?=
 =?us-ascii?Q?JAf0cRPNInj4m7E8HmEPm+87LSDFgEERL+S7TXVAPtWe0iWNrJ8DGxE36Joz?=
 =?us-ascii?Q?ez9ZBZF5gozoOXwF8+uSjDxirHmiVJuSvS+ZGCq/ugaIUNngkC3+4TLKP7QL?=
 =?us-ascii?Q?6Eahkdk9X5lA6bVrecMVpP4oBEKYfK4JckE+bcW3i7K9YRHX88h5jvy8TRT6?=
 =?us-ascii?Q?T54n7O+uhr5DrI+cx5jzw8m76Z4gd5ZEfsomKjHgkGh3zPrJybfpfCWlS7k9?=
 =?us-ascii?Q?LvG+9RkfA2Df7yW6ezBqdRIIkpjUAdc4l9WXcjKcYy+MkN/qfIgRjH5WFYDp?=
 =?us-ascii?Q?gdRl2/rMkXo5LVCQPKRJN3l3EvI9Lc9iderbIdBQ4MujoZzXQO0G0Jd9fBl/?=
 =?us-ascii?Q?Rr4kP+zcoB+0Pe4cfVhKYtBlkx3d21Og8P4NAKSpiqvC/xq42JatXmxoQuWs?=
 =?us-ascii?Q?0QwX6GOuxTbjO6JR1PlRYFW5GV1G0B/FiTVBbPwOcUQOH+dPYam8mo6fgO8J?=
 =?us-ascii?Q?Lnh5YCB7/I5knYmszSG7mB1zwdGTUAAXbnXX+gp5445iIiKGjYx6YwX3CJkE?=
 =?us-ascii?Q?VCg7FW+v0h51B6rTedugAWuCwN0Qur8Qy7O9iVh+xbNY6D86CRAK3WWavgJY?=
 =?us-ascii?Q?mAyIw3xLBit6QLKmmbkEFssfYQvzqCrq4sm6KUnY1ecucQgEENrfcPjEPUS8?=
 =?us-ascii?Q?jf0ivH0og+uw8jjgsaQoAfmQl3gFASxi?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 20:41:45.9027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fde957f-5d27-4c15-1be6-08dcd1d8fc91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986

The previous IOMMUFD_OBJ_HW_PAGETABLE has been reworked to two separated
objects: IOMMUFD_OBJ_HWPT_PAGING and IOMMUFD_OBJ_HWPT_NESTED in order to
support a nested translation context.

Corresponding to the latest iommufd APIs and uAPIs, update the doc so as
to reflect the new design.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 Documentation/userspace-api/iommufd.rst | 131 ++++++++++++++++--------
 1 file changed, 89 insertions(+), 42 deletions(-)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index aa004faed5fd..3b0e46017dce 100644
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
+  "NESTED" indicates that this type of HWPT can be linked to an HWPT_PAGING.
+  It also indicates that it is backed by an iommu_domain that has a type of
+  IOMMU_DOMAIN_NESTED. This must be a stage-1 domain for a device running in
+  the user space (e.g. in a guest VM enabling the IOMMU nested translation
+  feature.) So it must be created with a given nesting parent stage-2 domain
+  to associate to. This nested stage-1 page table managed by the user space
+  usually has mappings from guest-level I/O virtual addresses to guest-level
+  physical addresses.
 
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
@@ -94,21 +113,48 @@ creating the objects and links::
    device. The driver must also set the driver_managed_dma flag and must not
    touch the device until this operation succeeds.
 
-3. IOMMUFD_OBJ_HW_PAGETABLE is created when an external driver calls the IOMMUFD
+3. IOMMUFD_OBJ_HWPT_PAGING can be created in two ways:
+
+   IOMMUFD_OBJ_HWPT_PAGING is created when an external driver calls the IOMMUFD
    kAPI to attach a bound device to an IOAS. Similarly the external driver uAPI
    allows userspace to initiate the attaching operation. If a compatible
    pagetable already exists then it is reused for the attachment. Otherwise a
    new pagetable object and iommu_domain is created. Successful completion of
    this operation sets up the linkages among IOAS, device and iommu_domain. Once
-   this completes the device could do DMA.
-
-   Every iommu_domain inside the IOAS is also represented to userspace as a
-   HW_PAGETABLE object.
+   this completes the device could do DMA. Note that every iommu_domain inside
+   the IOAS is also represented to userspace as an IOMMUFD_OBJ_HWPT_PAGING.
+
+   IOMMUFD_OBJ_HWPT_PAGING can be also manually created via the IOMMU_HWPT_ALLOC
+   uAPI, provided an ioas_id via @pt_id to associate the new HWPT_PAGING object
+   to the corresponding IOAS object. The benefit of this manual allocation is to
+   provide allocation flags (defined in enum iommufd_hwpt_alloc_flags), e.g. it
+   allocates a nesting parent HWPT_PAGING, if the IOMMU_HWPT_ALLOC_NEST_PARENT
+   flag is set.
+
+4. IOMMUFD_OBJ_HWPT_NESTED can be only manually created via the IOMMU_HWPT_ALLOC
+   uAPI, provided an hwpt_id via @pt_id to associate the new HWPT_NESTED object
+   to the corresponding HWPT_PAGING object. The associating HWPT_PAGING object
+   must be a nesting parent manually allocated via the same uAPI previously with
+   an IOMMU_HWPT_ALLOC_NEST_PARENT flag, otherwise the allocation will fail. The
+   allocation will be further validated by the IOMMU driver of an IOMMU hardware
+   that the given device (via @dev_id) is physically linked to, to ensure that
+   the nesting parent domain and a nested domain being allocated are compatible.
+   Successful completion of this operation sets up linkages among IOAS, device,
+   and iommu_domains. Once this completes the device could do DMA via a 2-stage
+   translation, a.k.a nested translation. Note that multiple HWPT_NESTED objects
+   can be allocated by (and then associated to) the same nesting parent.
 
    .. note::
 
-      Future IOMMUFD updates will provide an API to create and manipulate the
-      HW_PAGETABLE directly.
+      Either a manual IOMMUFD_OBJ_HWPT_PAGING or an IOMMUFD_OBJ_HWPT_NESTED is
+      created via the same IOMMU_HWPT_ALLOC uAPI. The difference is at the type
+      of the object passed in via the @pt_id field of struct iommufd_hwpt_alloc:
+      When @pt_id carries an ioas_id to an IOAS object, the IOMMU_HWPT_ALLOC
+      call is instructed to allocate an HWPT_PAGING object only.
+      When @pt_id carries an hwpt_id to an HWPT_PAGING object, the uAPI call
+      is instructed to allocate an HWPT_NESTED object only.
+      If any other type of object is passed in via the @pt_id, the uAPI call
+      will fail.
 
 A device can only bind to an iommufd due to DMA ownership claim and attach to at
 most one IOAS object (no support of PASID yet).
@@ -120,7 +166,8 @@ User visible objects are backed by following datastructures:
 
 - iommufd_ioas for IOMMUFD_OBJ_IOAS.
 - iommufd_device for IOMMUFD_OBJ_DEVICE.
-- iommufd_hw_pagetable for IOMMUFD_OBJ_HW_PAGETABLE.
+- iommufd_hwpt_paging for IOMMUFD_OBJ_HWPT_PAGING.
+- iommufd_hwpt_nested for IOMMUFD_OBJ_HWPT_NESTED.
 
 Several terminologies when looking at these datastructures:
 
-- 
2.34.1

