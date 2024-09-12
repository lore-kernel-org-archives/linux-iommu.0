Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EA6282FB
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726107337; cv=fail; b=nTA2ga0I6NTstIHoJCsy0MZCiSBmLo7TRH4BqLhtpjd45tLKsJP8NRmKQMVSOf5jQidwL0YNANqLL6RRBA00hSRXyMu1ngA9UrvHmBa6EYpdHSoCk4mN0pbLPIzFa+GGLQdgCDd3oSZm4GLHaS+OVQwH3GKyGnY3hZIvL49bay0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726107337; c=relaxed/simple;
	bh=ir6Rr+JTMBe/A9X/pd9BovTofXJsThX8WLutdufD0sY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=owffaKlQ3F1YIQHLtUYRsBhUXdLkFl3nDRSkrpYHmGLHyce6B8rElXAiwzIucvWrTEqFvSx3ZV1EnENaQBn3r+uzfVz7hCJIJ4AAu3Xe+2xxMg7hnc4Mte6S0XBceoCjCJ2Jyr65GTPiccE2nQMW041RGxHIOw8BFwgONDVf5FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M1AvS1/b; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M1AvS1/b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/mxGsAFtvEhclGpq4B0wxpOoha6BB575U5S+glY/O7MFrDn4lhEphP92BsFrZgMNrJ4sbV/Z5bmlT917tO7vhJSi7jGU2resTVbZBV6o+xnwaObxcFLDH0vCTch+gf7X6kmxYWKrfhJ9VY7SIvswGDKVY79duBBi1gOlv5WLLnwyBWhW5kjvqsU1AFiRC9q3Q8QfWF0xbJxI/NosLTZVy/a91l2dWAeOOj+EtzzJ/U8x8KWOWme2Jg6oXrka1IxmqRZkcbGi7ZqkiSxNoITLpFWlqQq4f/YDSv1Dg37L9Mlu9ESza6OqPCl8pud8iZKR5wbfg6WhQe/X/CN+RvBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1RMrQrdrHpdrL3/d5X4JOxU2jOs3GXfFrjSWHUhGmU=;
 b=cY/wt/8vnVshAAOIPRSpG9RhNubpyMTIVGOWB7WHgAerZWme8HJ3B2S0ZiIJ3Mj2rcBPepnUX0V9AtECY67CaqyWcbmoe8B1FZWFyaUYkcocwSSQAGzh38hGGxd18ypJ+ARK0hHaKYaKKPqQ/i/D1KTvHt8xJaZ8XKR2GpuP9Qw/yBtUsTL5ZAAPSo39DUtwVxV9jcqAAQWrAiN1Zaqu8ccpzMS8XRVBwumjPRXubF+oJbW58NPJwkO9B+V2zFtRygbnN+DNbflM8uYpbaU3q7r4q6Rn2NJyAE5R0dCro54My/0fbrJu87yJCjlkLQjAW+buy2NpOluhvSTx7BSvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1RMrQrdrHpdrL3/d5X4JOxU2jOs3GXfFrjSWHUhGmU=;
 b=M1AvS1/bHt+nLjpjx8EbXZy6kbysY5zDvVOZhCZe9IZtIhQNsL4mXeyGPCuuA81DPZdKYXNdEveBVFYGatxI6i0P7RLf7mqkivp9MypBofYuQ1/hTF5/6fviWjShVqFBQjwEOay4Az1jWbViGZauxbN9sVuMPK57NUdved0HbGH+16ASKT9NZHNGzZ3ei7z+vobLdQ2Q49SczpxX0Okx5YmBILgd6iBeUATqzk0ttTaMbmdfk2X1ngjCrImRSasWJ7jmQ9JvOgye7F5Q7gUVq6oziGgwIfXNubRRpYYLK3plNQJFuoJhTzep/qQLYHs3HONR2+Rmg6pAUCvkZWVbYg==
Received: from PH7P220CA0149.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::19)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Thu, 12 Sep
 2024 02:15:26 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::d9) by PH7P220CA0149.outlook.office365.com
 (2603:10b6:510:327::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Thu, 12 Sep 2024 02:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 02:15:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 19:15:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 19:15:10 -0700
Received: from Asurada-9440.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 19:15:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <corbet@lwn.net>, <iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yi.l.liu@intel.com>,
	<eric.auger@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <baolu.lu@linux.intel.com>
Subject: [PATCH v2] Documentation: userspace-api: iommufd: Update HWPT_PAGING and HWPT_NESTED
Date: Wed, 11 Sep 2024 19:15:03 -0700
Message-ID: <20240912021503.205502-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 3938758f-acae-4955-32b6-08dcd2d0c3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ka4yPVjCSJOPFZc2x15mo+7J6NzKoukgtpll5+Xhe4N4O+Mr1+J5Sno86y/G?=
 =?us-ascii?Q?9wTD2PyTrYwYu+bl1Dne0kdaw6tXORLZf66XTytfq3dyGzTR0JwNeJ+/1zQ7?=
 =?us-ascii?Q?uSHAv6D3wQ+ijGazseRuv4jjp89Iiw5Rc7begGnTrB1zhXJG2o7T9haUaYg5?=
 =?us-ascii?Q?VNZWwMzhmvp4C4WWODfnVlQb4u/VZIcJsw7aTd2aXHor4d5Quzh1DOCcFfLO?=
 =?us-ascii?Q?6ouLKUFd35Ufuhvtg9z78xj58rK1ttau2bkL6NoDgbLYGAzajLyN/IVX4Ls0?=
 =?us-ascii?Q?snjk/XYuxwQKvzrluHEjda6gtzIjUeO+4PwGKkHEW0wwYhnmcgh1dd0A92wQ?=
 =?us-ascii?Q?OoBLViQLie/cK//qGwpumxCITEORBFiy34AhDftR3DJYnVmR0EZwKO6MuDll?=
 =?us-ascii?Q?pJnO8N195bSqUHn2LDh250AlQgHJdpdnx0uRDCmXL651AVubVUR4W1e9Gtq4?=
 =?us-ascii?Q?MW68updmPNNBHgz8H1clZONef4QqVQZ8cJpjEce8XtVEdU4LqxhsRGzcA11s?=
 =?us-ascii?Q?0lmTOdkxhcajOdJ666+uGKoUVhppTIy1d1PeKR2EfbarYs2M/kgyZzhhCbU8?=
 =?us-ascii?Q?2idF7Sy0nHnVym9OLSxw6XRftUMO0WCPe0aZnlMUzmzgCWydFEJDxt/wZ+cF?=
 =?us-ascii?Q?lhL/n055wucfTwlr86VHINx55TPlguL840j2iqtzK7TrHDHRkBAkYZC28WRq?=
 =?us-ascii?Q?5a1cR51WJMD38DindciETy9uxxADW027xq94spoS1TGkKDmsLEeejzAHWysu?=
 =?us-ascii?Q?sIu5esAcLE4avu8buFnssYfJNUa4pc/4scdrXZ+YFukyvk8xJNmqisZEdnZe?=
 =?us-ascii?Q?e9YEwKPGDyipK94199lznJddcFC2WnKA8o1gecEn171ZQqupROR9UiY61ppV?=
 =?us-ascii?Q?fnpIuqcsE3Xn5wVk0C5NCdnNNSMjKS2ECRTST+Vw5IfNuDQGt5I1w7Bv5z7s?=
 =?us-ascii?Q?ZgbcZEhgaWYcmggLQntH3OR8+WM891b7PhhdbvpijtktC/GkuCGG14vjKikH?=
 =?us-ascii?Q?3pkGLVYVliiPVU10bFw0Z3mOE/6onpp8HIdR0bHdkoxm53Ps2ns/hgrpWzmr?=
 =?us-ascii?Q?bJgzDXeJ8ZFTk1alaKUG2Jqs9VZDq3xQlzHm8S41e0Ix5oDWUm9VEW4XP31S?=
 =?us-ascii?Q?y+n2pQamDiqltHMaIgStjPOEhCJ8Kw1N0/TuvTeVoFc1Bl74TfiLKxo0n3uf?=
 =?us-ascii?Q?EAKaNZNuNHP+Y+SktN4A0ZoumPFrGiy338LQyOJYg7UTUO1TT9tYMN6SRrUt?=
 =?us-ascii?Q?/4DfkZ4AOjQ28cjV3qK9ISgDrFBuVkbOwmdKsCNV9/2Wieqy6eB0F+/M8zoS?=
 =?us-ascii?Q?1BN2oRL9EUPSEVhWNcZLF2PaLyxC6Cyyu27X+DeBXM+5XCw1o6bg7bg/ktvH?=
 =?us-ascii?Q?wOiPVs1i4jpJt1Dgg+nhhBSYlPB/A0e1r6BWcELFm0L7t5r3rOpoXC/a8S7c?=
 =?us-ascii?Q?jXWQCzqkh7Jb5BlSXQXC3ZmL0EJWS/TO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 02:15:25.6955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3938758f-acae-4955-32b6-08dcd2d0c3b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275

The previous IOMMUFD_OBJ_HW_PAGETABLE has been reworked to two separated
objects: IOMMUFD_OBJ_HWPT_PAGING and IOMMUFD_OBJ_HWPT_NESTED in order to
support a nested translation context.

Corresponding to the latest iommufd APIs and uAPIs, update the doc so as
to reflect the new design.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---

Changelog
v2:
 * Minor paragraph changes to reduce redundancy
 * Added nested bullet list to IOMMUFD_OBJ_HWPT_PAGING section
v1:
  https://lore.kernel.org/all/20240910204111.7969-1-nicolinc@nvidia.com/

 Documentation/userspace-api/iommufd.rst | 134 +++++++++++++++---------
 1 file changed, 87 insertions(+), 47 deletions(-)

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index aa004faed5fd..a3cdfb1fe273 100644
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

