Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B9926FA77
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011094; cv=fail; b=Sfyblo4NaFmPPC0N4xdLURBAQ5GuQfR5/7LWfbg4Zd6Y+fSxDPWnqkVbTnAZiB6e7OYyGuCbemEzGxZZu5hc85gIHgJumK+SVh7NpXCHVC93z99yst+JmEORNc7XrzicvR7qD7/VLksuCg3mnGSv/9gJ6qKrDrNiGKBa7w9kVTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011094; c=relaxed/simple;
	bh=A9edhFBXdjTaNowGKnYXQhFz3LzesRigwAlyQU+r/No=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9wKlj+JrWgavyl+FfWosVvvAW1RjrkMlTMuHDDld2TEa5zEle8aqeSoKxlSAPA5oB34xezHTgRrNbaTgydEzj6BOGmLKTlUNvIMRmtjamLwrHhr6SGe0D6WbVLNuAcp1xt2ylCS8O9wX8DxvJXBn+1ci3zKSXffg9XN6DRd6dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i0MAA/wp; arc=fail smtp.client-ip=52.101.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i0MAA/wp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1Nw4aJKo8hVlMNAKzrF3wS2u7jlDbZajo/lmWOxCz3NVyuaMUTHLIgwQB7rtFhwltUXEbX1sl1swrXLPJkpLRT3iKx8nTYU/KXkEhZuFjxYxLPF8nMgk8yW1p/OV+Ts0m6BJ3JS1kEaRqs+af0FzDz8PBchBupkO0WYE9A1iCXnmxLFE3eewnKWpcvLjP1ekd32dQoMrdKSAh6kLEj6vcn4EGkvwWSP10WLQdQo8SYsguqHLFqJnn6NgH395QF26boI4wUN85ToJH9j/m25cSdU9qt9PGcQujAhwR3GgTY9FBnGCNcnNvMJgUFEU2Rs5he9/Oqa59Da5Zvkoe3eJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgfCS9+DlXq8cEmo+iUS4VirQw1rdvkQM+ndwzxnE4g=;
 b=a4YQv/5z0TQLgJ8sCG1IhpOtoAJCOf13fA3vUA9XmIXXulijAxlcchDMBlIK4oME15u5ieVbbuULByR3AyEUUjLUNoRFcZEK1NjruihhMty5cicsRSZrKforc1Juw8aE/Desnpy9QiAaEHjnZhHraNeZVWYDihSPs0OZSitot3CuVbtSd0+MSA9Pey03miKhaBSPU/Heu/bNCDb0lW2+ii7yT5auWQN2T2DwKXMAMF0JuYjgBqmcI3qzleBfpGNrTI3TgJ1CV7J0Tz2MkjJvRLlTqexRCevJC+5ehc9mZIBb86LWZvJg5KkUPJ8dCw44gGmzMOzJbbmek5cA3TtrTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgfCS9+DlXq8cEmo+iUS4VirQw1rdvkQM+ndwzxnE4g=;
 b=i0MAA/wpd0RTG1ebg7sLXkCUkVJO0CO/H9l/g1bx9tmNF9BR76aXKALkFHegEvBYs870WHbcwVDW5xyO2Ty+Y4Z898tW8X0Jz4yALirtbkSHTmAT+9I08RH9UDm1NSo/TWS5KSBaJBW/iqhuwf3OuXrq9qYsb0w7iIia+tOscZ4=
Received: from BL1PR13CA0441.namprd13.prod.outlook.com (2603:10b6:208:2c3::26)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 01:44:47 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::65) by BL1PR13CA0441.outlook.office365.com
 (2603:10b6:208:2c3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 01:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:44:46 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:44:40 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 10/16] iommu/amd: Add support for nest parent domain allocation
Date: Tue, 21 Oct 2025 01:43:18 +0000
Message-ID: <20251021014324.5837-11-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: ea936bab-31fe-47bf-de95-08de10436a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8LYfEi53H+xFL98lZjxZt08I94707h+7GcjgeAvnP49H9M5FJVkJfmCaybII?=
 =?us-ascii?Q?MRS0TP6cYu6N2qKhy28jC67zTco2XQwqXtEOc18SA1xrGBqu1qIuV4dnzkAa?=
 =?us-ascii?Q?qDWDdcBvjzcZ4E01nAT96jbaEmzqUlcKaJ23MLS5/DQIaXKbUo9yB0aPOL+i?=
 =?us-ascii?Q?29JM0XNioTLeAMaGNmk0RmHp0KrItbhqewXw6/dlBA+QsNQbRPo1EX9/qtS0?=
 =?us-ascii?Q?hgFtocmxZ0kpXLoP64WTsNq4Vmpl+w4SNSpudPIIVdZXKV8IAW3VeOSdAgPS?=
 =?us-ascii?Q?RzmDSffKYU/4jx9ZQpvq7vNBra7ZvogRssMyjOA0ENlt5sBhT1l8OpZsNxsT?=
 =?us-ascii?Q?OL7wHFWygBGn76PGdhk+XKVm7u900xGDnuBHJovuXpqUMHICF1nvvWTeGz7B?=
 =?us-ascii?Q?zEFMPxv83GxF6tiYA5oLhosinywGaLeEkCxqjPsnGtQ9+ae9jdASFH5W+mwA?=
 =?us-ascii?Q?YYuH2KRE3GzBPK560eLZFOkojn4ggN9B5L/epA+kddcymJB+tDJuQsyCfnpT?=
 =?us-ascii?Q?LItgWytnsTbjrXXZ1+GRNs8qFH77JBtDotdXkCasrs0zVL4DUQXCn2u/iv98?=
 =?us-ascii?Q?I9s4IwztL0yVH1B4wfZP6wXSZM7H5FhPYS+WsevdXOgtrNvpznpMNIAq7n8a?=
 =?us-ascii?Q?IhgU1TlTCEKerxMokhpo+YwU9qExRN6bzuU+z33RIBrWOq4AbvFOyeeCHOO1?=
 =?us-ascii?Q?LYn1hGeLoXhHs/pZsBiQAS9d54bGk9HNT0ty2yWkEf2855FSAI2M1MgpTTaM?=
 =?us-ascii?Q?pF9Egu3f2L628tx88JNHKLr3Y3SeHb2CSzXZcoihgz51m71rsvE+fOBkIaOt?=
 =?us-ascii?Q?VDgZAE4hV/nZmzoS8oRG75MJosu7tHbujz6I2NFArQuq7/UjtleY4aUq5gQf?=
 =?us-ascii?Q?V5L8au5hPjWrO8tPKr70ugVG6NUg44YdEXUArugDNpaXdmNlKBBCblMwuXuM?=
 =?us-ascii?Q?krqUfaP5jcay0PrDMGpbz0jCI5w6EXj/ZcmJyKJuVswEZIeWw6GH5dKoglsA?=
 =?us-ascii?Q?/ZVF9SkEmRTAfba8zcLVy0xZ6NpJHQNtc0CHB+v78I/ygITz1+Tb8IggTZLX?=
 =?us-ascii?Q?FGYQdYhxzKjeYCDImGch9dWZDwRXH70L/Zn9IBvOoY6sG7kEEwnSSXz8GeU5?=
 =?us-ascii?Q?iHlSwewmAn6Z9lAoZb4vmsMS++4SMxROfOgtC7rtBsEJmBoJUI1sXGOXbp4g?=
 =?us-ascii?Q?RgQIa9/7awX66sNLm3kz/gy3ICbA90YjVRO3vKOUNma1qr3sSwT0wkQWE6em?=
 =?us-ascii?Q?NiHGRY4eApW780Th+ZpVAe7HoZKAUf5UEni27e++BfqQ9SkybRtMYjFrGP89?=
 =?us-ascii?Q?O5xVABPuuXApeh1Rbax1hp5EMtSqvXjGoM505lPKil7/VWDaYmS5F+DRTEPQ?=
 =?us-ascii?Q?1QU6xWSmT5HCS3zdcRFZWY9wLY8BZKY0yce4dxLuids7BVJ0bjvjDABvTfv7?=
 =?us-ascii?Q?i3CCtn+fNCRZhf5LmEKfKYW9YzEWEXnz/tuG4/1RHheNVW3wFlf3F9lCRXpR?=
 =?us-ascii?Q?GSFtxlnLtxIFMIi0StF7fCjlZLXfwN3VHjfG2hjKU3MReE1VsJ91mTaHonhP?=
 =?us-ascii?Q?pN7j8wGshd/uFf/jYvc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:44:46.7980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea936bab-31fe-47bf-de95-08de10436a79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889

To support nested translation, the nest parent domain is allocated with
IOMMU_HWPT_ALLOC_NEST_PARENT flag, and stores information of the v1 page
table for stage 2 (i.e. GPA->SPA).

Also, only support nest parent domain on AMD system, which can support
the Guest CR3 Table (GCR3TRPMode) feature. This feature is required in
order to program DTE[GCR3 Table Root Pointer] with the GPA.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 26 +++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 9226edd8af69..c34604cf1811 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -107,6 +107,7 @@
 
 
 /* Extended Feature 2 Bits */
+#define FEATURE_GCR3TRPMODE	BIT_ULL(3)
 #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e0bfcda678a8..e489e360bb77 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2584,6 +2584,14 @@ do_iommu_domain_alloc(struct device *dev, u32 flags,
 	return &domain->domain;
 }
 
+static inline bool is_nest_parent_supported(u32 flags)
+{
+	/* Only allow nest parent when these features are supported */
+	return check_feature(FEATURE_GT) &&
+	       check_feature(FEATURE_GIOSUP) &&
+	       check_feature2(FEATURE_GCR3TRPMODE);
+}
+
 static struct iommu_domain *
 amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 				    const struct iommu_user_data *user_data)
@@ -2591,16 +2599,28 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
-						IOMMU_HWPT_ALLOC_PASID;
+						IOMMU_HWPT_ALLOC_PASID |
+						IOMMU_HWPT_ALLOC_NEST_PARENT;
 
 	if ((flags & ~supported_flags) || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	switch (flags & supported_flags) {
 	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
-		/* Allocate domain with v1 page table for dirty tracking */
-		if (!amd_iommu_hd_support(iommu))
+	case IOMMU_HWPT_ALLOC_NEST_PARENT:
+	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
+		/*
+		 * Allocate domain with v1 page table for dirty tracking
+		 * and/or Nest parent.
+		 */
+		if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
+		    !amd_iommu_hd_support(iommu))
+			break;
+
+		if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) &&
+		    !is_nest_parent_supported(flags))
 			break;
+
 		return do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
 	case IOMMU_HWPT_ALLOC_PASID:
 		/* Allocate domain with v2 page table if IOMMU supports PASID. */
-- 
2.34.1

