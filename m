Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3107E15B96E
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843477; cv=fail; b=U0bUa8HBdeiSrbr76kOGDVRA/nDsbFb/O/kZuSxV7IP3HJN8kmO7w++9nMzo4ppVDO6yaEVikVB5re083vUq2gcfeRE/gUEvJcowCIadEInvup3Sdex/sXz+C5ZsrOY+QroZrySpgsu/C2Q8JMwBSSqFdaXseEtzha0fyLcYnOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843477; c=relaxed/simple;
	bh=rIiRU2rXoiJx78MEvoMlyh95g6fEZhiseCTWgbirUns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnZ6JlN6GEY+fMdR/bZ0lACYV9tVYjKavWvwllLGLuIZTbz3WPQpAv6M23axz1eAXBlLhdJS4JaZjXs6IfJk6m1XG+7PzGN3O6XnQkLNG2SCpzQQ8IsK0GVaSA26Z82uWX5EzpeTM9QCsH6T+chQdAx+H84J32kFhHpRYifHRX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bHK1LDXl; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bHK1LDXl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pM/NSdPpoISHwz3ukvNydbv978FjQwI4aFOM9T5Mk4rV8kHDgRKTNZiBOxB9HSeFU74A92/iImO0aI+odfvagy/2FsghuQy4P83Nz5rJzK2LEKHXtX+JeJlvM8BOoWcw/UAD0of014r2L8Ui8uFZP81ZRDiZ9IdV87PFYU2wre11N9eKhUQM3wxG4iJCsrsTq6l+XMJ1OCrgs8vPAxx+1dWpoVy0FnttPWoW2im1huNlRTeHWQOh7TQMDCRTTAZXNrvCb7I5kgUAkMUlCM/nkSXM3JbBz+VveFaH/zLAR8LCywHFHbWNVKbuZJRsbR6ClT+Neme5opIvonSpN/hJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGJO1EVndNcCH0OXtttaXAq3Q2aBsP3l3BFbxtZt2Ks=;
 b=x592eRRLuBgPDt+zn2X6uYwaKlV6Wpiyxsjlor5VltJb7OZZBg60ftjtqs0cHacIHVxsSJcYI4XKubIsmTL3GZvgm2e02JuS8C1q+66jw0c7UWPbNTLxdL8X7vA+DWDx/HO8Lj5Ab73KEdnD9Oj9r8x/mEOH+ncwiAf5otEh3DELsAZKLCt8RLvnP/MfVcF7TWWmla02ZMlCcADBaBx4lImQWIlLDvm79tDlkxbJJmAFZ/kENvQDAPygP6OkJKEkKNyZVcB0qNtQ3PIGKSYlXZ9AO6yj+RnaXK3KcE7h3eqQkj9v705u88+0h58xao0KBQ7HeYYkDiMNz7I6uTOXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGJO1EVndNcCH0OXtttaXAq3Q2aBsP3l3BFbxtZt2Ks=;
 b=bHK1LDXljoyGXXztBg0cw5id85uflJEVPj1c+FFOQbL6uo+HL8k6/PknE3ltUYSL0EPzo7OEt2RaKhUeA4IlY7Ub3lFdjDwQk7T15v3Yi9xMOcDJvZ+JIlEQBhq7pGDfXia7vNvSvfsNM5G4lra3iAB4Zr28fH2UuOh84yUgzT0=
Received: from MW4PR04CA0051.namprd04.prod.outlook.com (2603:10b6:303:6a::26)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 11:11:13 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::b8) by MW4PR04CA0051.outlook.office365.com
 (2603:10b6:303:6a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Wed, 28 Aug 2024 11:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 11:11:12 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 06:11:08 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 1/8] iommu/amd: Update event log pointer as soon as processing is complete
Date: Wed, 28 Aug 2024 11:10:22 +0000
Message-ID: <20240828111029.5429-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828111029.5429-1-vasant.hegde@amd.com>
References: <20240828111029.5429-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 818ecc4c-2146-4f94-e47e-08dcc7522074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gOMP/crAqeHp73yI+J913E0JlswoiN7RTckyUQaQxiXZipheQTs4qzFwXsDB?=
 =?us-ascii?Q?0IZ+GyOOK3x7H+WNduleZTV9Lw1ipnVTNMYM6x7rKMh6M4k7/efnlKRXiw7W?=
 =?us-ascii?Q?16L49i/RCP87D2IbGw3iO6zXdfjG0c6B3/ygqlsJNcV+P2PsGX2oZ6PsGp1x?=
 =?us-ascii?Q?xZOKXAtk64qQ0fsHoUc9nNun9ln2klyDfUzRQunE5D1RzQ88V3KjIBThIKrv?=
 =?us-ascii?Q?J7fjwE3zOD9OkZCyHIvxF/RR/1y58Wi7IaYVEa3dPqiy6gXg8XYS2RYQWuwd?=
 =?us-ascii?Q?M6N67hTm1owFbmMoSAe5D0Q+GcVE+zwVN49VtmZSAVrEPYiT5IgVFa2d6eSo?=
 =?us-ascii?Q?YBhSfuh1r3Cdka3pmaARRixFuYDRKsiXyTQlKX5KUMP+idzaoXfCD73IixuU?=
 =?us-ascii?Q?ukW2Ddgx63LdddfxaonGNgElHWFWtbUz0jZ4O1tqnVQzrPOD0udAC/F5hb8K?=
 =?us-ascii?Q?mEtP53UqNW68tG4J0zBQ5HeVHaeuWhBrC4bCQWD38hbJAA70nrSmO+7KtbAq?=
 =?us-ascii?Q?k4/cL6vHDH56joQvIRTRDzPOPijEOEV3nj0BzgP8zLgaIs+Z/SwVu6Hp2T2G?=
 =?us-ascii?Q?bj1JXalkGHllqqF2+dBJ0owNLd4VSfTTOeBtLiqKl79A5dYDFbjHMF4iB6RV?=
 =?us-ascii?Q?dG4FCjerJWUzvQ9xCpEcGEZBaGH4mFX5wZbHK9YWJ676aTv/893MaMwF2w3f?=
 =?us-ascii?Q?UXbu1fAjmsgAw/P8ZIbvcnEhK4YXmLRceIUiAuQMM9x69zcaOQHzI44J/FKk?=
 =?us-ascii?Q?s1LQWfMaAda5Zns/pOXvU42cG62aKhK7usroglqJBU4fA7nLE5zYQjb5TYKi?=
 =?us-ascii?Q?B2regqHEQnXLCw+Tv8uugdFG3DWNNBnpzV6ccksUw1ZWUbnnZjmo9OPPQ4I1?=
 =?us-ascii?Q?xIUAz2jUlZ9UG8cJiPA7iWq+5Gpyvv7NPt6Fk1a9/PShDvehGde+1w/VSIOa?=
 =?us-ascii?Q?TGUaYN6ICXGyPw4GJymgh3W0s0BAFWi30LTEeduYG0HRe9EoYtHKJA/Uofvp?=
 =?us-ascii?Q?m59QDx8M+jH5qeRqacVyFlBQEMMZ+lcNfWcFJQppmmkhdcIlD4Rz5ZhygLcj?=
 =?us-ascii?Q?0pdyYyEM8tH44/WSUt5hQ4YXZGaRNF5s1vIQu1u1oUh7tZxFwuTJmqjOJluH?=
 =?us-ascii?Q?OhkY9r0izjiMIWfGi7qYgupO46j30J4hPd/g6Ef7xqwVAvWfKQ0mKEWlcErW?=
 =?us-ascii?Q?qZd3GfO1HBeqvrOEJEwZmIfTguMqFpNf0j4ERrgdCw4FeeVrnx5WL4UJGrWb?=
 =?us-ascii?Q?8qRuw4dvXt1cX/yJBHNPIozy3n4D7P5f5LW7lkGj7nKi4vir9Vb6wizR3JBY?=
 =?us-ascii?Q?BeMbTkgXh70SreCLSstCVFl/ZYohsG2ZIslijx4xmzdHn+9wgtUfZDS8s4Dz?=
 =?us-ascii?Q?snx/Smh4XOZuW49PBsuBxLh3YYZBzna9Iow5vfRtAywspe70vIKD6Y7bGzHi?=
 =?us-ascii?Q?LfyvCxIoyWAJzdA/SqzaEUVjhquyaZKD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 11:11:12.3982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818ecc4c-2146-4f94-e47e-08dcc7522074
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924

Update event buffer head pointer once driver completes processing. So
that IOMMU can write new log without waiting for driver to complete
processing all event logs.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dbe838828efe..e13e401c52de 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -825,10 +825,12 @@ static void iommu_poll_events(struct amd_iommu *iommu)
 
 	while (head != tail) {
 		iommu_print_event(iommu, iommu->evt_buf + head);
+
+		/* Update head pointer of hardware ring-buffer */
 		head = (head + EVENT_ENTRY_SIZE) % EVT_BUFFER_SIZE;
+		writel(head, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
 	}
 
-	writel(head, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
 }
 
 #ifdef CONFIG_IRQ_REMAP
-- 
2.31.1

