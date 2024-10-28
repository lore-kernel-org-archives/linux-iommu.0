Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB86B1D54FD
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115154; cv=fail; b=cU+34a95ftAX8lblNIqOo1khI8yQJgsyhE4Sa/7wdFygK3TU8Nmaky27zgN43QQ8rf3EWwzWVnZjDfn/O3NLsiYFt6i/1vkuIogAkJRuszN+WVQMEl2tDXaAHt8+zrD7fw90Sz3gvwJG7/H+nOtJYpfo3WO1QycFJ3DrfMA04vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115154; c=relaxed/simple;
	bh=Eh6gLkwMloiQksxPbswL4vK/YGkAS3zF/3Qb+OUy9u8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3lCrCZWBg3gBe9tMa3YWynG5xLHR23L3B8gu18F2oNWc4ys1cWQYYeqmos9DEaZNnWFLwTHhSzE3Udj27ypHW1bKd+p91uH9Y+pMWHsfkIr22MVmp0HcrfByKI4v17ElRvrfsZ/0TNq/z2D617GBWLDH9wxSMP6ws1ic5Tv/r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FpIYsq+b; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FpIYsq+b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDSZ1F5kHV669mL31TeTXMqmko+UeArgE0pUrbQONFbLoy3O2u8V0pZoyURdYqZ8vkPhByUXzId5+LzcHLv9NMmOV3HWiyMIBxYhTW8xTPG+IcRc+XOz3HfEdhULU6IqQDfzdVGCJ17S223o7Q7nLD64rZO2AHxTVZaHQHrHcozpU51iKHG7RY2LEE1Er8Q5Kf4+M2o/xF5CBslT06vymtY8dLwI2SvI0fjqwE0cZVAM8kqyQwuefNd2ohPosvi5+Q+qJ2kS1xZ4Z8w2hyTfpFpEb6ACw7Lzwx0jmDvUhQdZ334tsZmKYNtgzuofNQtPx2feiVlAxKuYJS54ceM6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xphPZGncLTfo1OjpKIysBe/ib52YRi9AF7dJBiKk8G4=;
 b=Hx68aLHurLwyatAjo6HhB3TYIFZqU2ypqdS19ckc5ENR/iCW8wHe5je/qjLGMZhrZCMEqexc0NbLJAuvkm2U6buOJ0t3plPb5soZlXUGkgTvXZDuR03fFIQmcyeHIAKfnBlnW2SGoSlNinjymrMYYaFbXWr/39D+h5YPHwtQd1u6IpEWrisUcJLnR9bsfcEMzUtLif3Lt16CN3wZsEhvA0iofrayZ/9XMDxSBKp7njPMEmGpPt6Ymhz7Rj0SAt91TemPAwKhPqy31v+eF/ZDt5w9XVqvCAUxwVfkXLc3OAr8e/JBZcGs7s4NqkF+BovF/+yPnPwSpq0ttQ380C8vkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xphPZGncLTfo1OjpKIysBe/ib52YRi9AF7dJBiKk8G4=;
 b=FpIYsq+bA6FG9mI7RBSywVaa2UTT3Y5KRJOv5oeCoPJ36Ub8S2hxqgqsBZtEzHKzZgz3JMFFxbFG2SNCHD4kEQCbgjFtW10Zz19ma0dyak3Zf6zMyZJIoXaJzs4Bwoi057h2QHTHd4Ji3TRX0oZzVC+yg+cdLIkMAzFdTBN9o9U=
Received: from PH7P220CA0098.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::9)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 11:32:29 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::ac) by PH7P220CA0098.outlook.office365.com
 (2603:10b6:510:32d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 11:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 11:32:29 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 06:32:26 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v4 01/12] iommu/amd/pgtbl_v2: Take protection domain lock before invalidating TLB
Date: Mon, 28 Oct 2024 11:31:37 +0000
Message-ID: <20241028113148.5774-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028113148.5774-1-vasant.hegde@amd.com>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e2116b-b17d-4e36-367d-08dcf74434b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MJNKpcLGxLAiDobA4BGQ0LpJctvK0h49zwqCkWlPPn4OxomLCUfFR9tSRuJF?=
 =?us-ascii?Q?imBQAkG0KGd7Yb+CG3qXGDrsC+zSSrdORP90EtBSyjnkI8x6YZpU4oXKfXcd?=
 =?us-ascii?Q?p+dhtGt20P2QvCo31BA9i2oUQF1btSoLgnIPYSBJeuxK3ZdK9mt+NOk1f9mx?=
 =?us-ascii?Q?5FCRzIUAnY+aQAWnNWsiIIhDD6V8GN3TaKcoyBwGDsgEOw377cp/pEQAdcQ2?=
 =?us-ascii?Q?GQ0Jx64hMHB6EOI6sv3urT5v38IXZLzV1jTiboCRTEByKtR5y8ts/oelJ+Qm?=
 =?us-ascii?Q?8k9TrM6hQ3R9KnXMiTinCkWdFBTada5C4OWXVKgC3UVAhUurQFNtj02K20DL?=
 =?us-ascii?Q?AIL5ykyqyF7if2hb1J2XMXLz1jNd9JDx2izfGNs2cJEeUR45Anbnd25p9FQW?=
 =?us-ascii?Q?ti9trMof2DSZfcbPxaA6qjR/Oph6HKo+QvHPAgI7CefvIBTrfl/ZB+awGMfb?=
 =?us-ascii?Q?VfZcpUpqT82IKyiGIHdLbXK/v2R7ZBWfF47R+AoBepr6gBXLr5LS/q60YMZk?=
 =?us-ascii?Q?R51nNHBGcHz5TZYgMbL1a+AI/TA8NloYnrsQ4YxLcy2mNV7rds9/dtzKSJkZ?=
 =?us-ascii?Q?YxEHO4+T2YokO9ZVM36ggBVtL2VWgaW6+x0rshfxWoSaiy4Me7EqP0zN4Ex0?=
 =?us-ascii?Q?Gu3ZRIEYx9le29TBWYxceUpH6AINSei0rfQX5iEutPkTWDLyY4/c/hrgwb8q?=
 =?us-ascii?Q?mTDee3P8rUQYOguKq0dujtTmpKvIjWd48XyrMr6xv4G73ITmlbc9bFp2OM0F?=
 =?us-ascii?Q?lSgJgWBoIPYr23AEgU+n2Dwb3jDBryQ2xthFpQefDJvPWy/X5WlANGuZSLOk?=
 =?us-ascii?Q?7az6E78RbF7yF8bgky8fECSPtEQShFyLvLLGuJguLvZ/+Hxp7M3j/JqW86GS?=
 =?us-ascii?Q?eWGkMRVPUdwD0L/0+Ix2ZWjNDFTcQXXucO0v1l5FNQXm5yEl479kMTSnhlWv?=
 =?us-ascii?Q?g4zcMwHfytxyJl+3wV6jkNLCm6RSjxf0O/kQ8c5dyEow6lSG64u0vUi2+80E?=
 =?us-ascii?Q?nmshD1XXGmWHurm/uAX+jyUqx39hTEYzeAit3Eni1OHFFvnqtcCMeZ3iJffh?=
 =?us-ascii?Q?QfnzLulyZbWU9wLNP8QMLHatDLXXhFJ2CYzgKnbLhBpEO6L6Ox3i88zRm/Oj?=
 =?us-ascii?Q?c3WLjrH9PBSQo/hx3GmThXEih5HzFYGmXYbk5KjwUH2zRpZvPyaT85gNYmd3?=
 =?us-ascii?Q?iwy4tSuO7uqsP7nI8CAD64q5ZmdVJxBucaXMZQijDeELnP9jQtWFQCQzMBQZ?=
 =?us-ascii?Q?DNvJyejmOywqIJY/CdnpzulsGYcZTPbSnC1I0G9OY0cGwN9x2Rrx35BLC/pX?=
 =?us-ascii?Q?lReRutmjxCVz//X8IZiHo2wf+rIAfEEaB109iziR3c79aA8vybWgxXiLrSjL?=
 =?us-ascii?Q?eq2bHL7v8eRFSNBiELhnm5WLEKwZgQalmLk3xtzYYM4b6gyQrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:32:29.2983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e2116b-b17d-4e36-367d-08dcf74434b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005

Commit c7fc12354be0 ("iommu/amd/pgtbl_v2: Invalidate updated page ranges
only") missed to take domain lock before calling
amd_iommu_domain_flush_pages(). Fix this by taking protection domain
lock before calling TLB invalidation function.

Fixes: c7fc12354be0 ("iommu/amd/pgtbl_v2: Invalidate updated page ranges only")
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/io_pgtable_v2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index 25b9042fa453..c616de2c5926 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -268,8 +268,11 @@ static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 out:
 	if (updated) {
 		struct protection_domain *pdom = io_pgtable_ops_to_domain(ops);
+		unsigned long flags;
 
+		spin_lock_irqsave(&pdom->lock, flags);
 		amd_iommu_domain_flush_pages(pdom, o_iova, size);
+		spin_unlock_irqrestore(&pdom->lock, flags);
 	}
 
 	if (mapped)
-- 
2.31.1

