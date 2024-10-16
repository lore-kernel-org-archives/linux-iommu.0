Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525D203708
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068633; cv=fail; b=JIKB60To9rLmyvlNi+P92BMzo0jVA2OgNdqtyl5xpZ/onwQRjkg6c2U+zWRaZQ1FookKWQH3JhUL32afGKdWxQc/DuKRwfIYDsMEV2z+MCW4vtgaZ8OvOiE9WOsN+jYf0QLsAujQByBmQ+YIFDETJqNVQ923C/glqGFStD5YhD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068633; c=relaxed/simple;
	bh=uYp+7cnZm2mxjgB/UI9YqyZm9eMPANN0uEikKjMIdWM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IcBNWN97AfCRjVM0KJvjKQ047O6R9AfZ9D8JBSBGIPQ0oNWRZy5QgY3u2+6+ERzdYqJYrdAhR9QxbX/ejG4/kPj8XL0kZCmab2GF3VECWWSBVLOdobXDNKHIwME4O4LVAncCBCUPTxKngHl9Qm7YCEEM5BE+1AWHzeAkjwFs6rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qvn0lDkZ; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qvn0lDkZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWpKgaET50sdEiPdZ1doUpKo1R4qfIuN4yDiZggJdyJCcaPx+Tx96MrtoCW5sosO7h60mHwW0QoLrAjjByi+dPJ6Vr5Xr04FEXhO9d+JGdH/WUvyXtt0N208SkfXZ9Jj7WREiJDgDwoRTmDMQHcofZ++jprm4FD5uRG33fqbB5gMKFHDN14w/FeK44k2FqLV14Fa0WcPGwgrHNu1uj5UX9k5q1ORwe4OVf4D3jMhkS5Tuvzsvc74skdSeOIEjyOYKzyhuFqBmaBEHjEaaDNFZB9YoH69dBbXrqZensaG0iG9+UeVGhvEnREwuaiXB2J0M8Rqvjbr/J4g0oWSK4awDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEFhgTlAaLZizlDqFtJOqDPIOMoM310AXRq9Q1PMwFQ=;
 b=HeJUpOsatBlzEAlRwbfZ+sVFv14+g+tl4pIHUsBnph0uMLNPDooat4d/Q5Nq/KGALyE1RUIXC2xGfhdtoKGDYfk9MTM0hfc05++ecZhYU3CxOoWLrQO1oAWXPS0LjVQrvJuwfXeObYt6vaRAEWZK78+NZ/OIbbxWSOU++6foK/RUS6G0w2DCqEOj6ws1RTViqp0YNk/bAxusL6SV1sTApVPccjxo40dDFkT6eNgl0lj+rLxcdKr2b+LeVQ6gSy0OIS/sVndfkiZXW0qmVHkCX4OVONV6e/brXMiYd14I08NkuXuBFBfxn0wE71aWHVSjLtpyCueeS4jFbftoK9EEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEFhgTlAaLZizlDqFtJOqDPIOMoM310AXRq9Q1PMwFQ=;
 b=Qvn0lDkZxyZ6AS87j57gJrnHJAyWw7+zp480GBBXX0kgiZOB4O2UEBpXfsIAXjdHS/HyHCTkhoqAKEfb7C2zB4ioBeSkCLIKYCGqNnKU0tWyKVpdkZ0Gjrv8ho/zVX9Vea/jIJhqAfOVrXKpv3onRtzaRe3Sq00egEb4mTiLqtQ=
Received: from BY5PR16CA0026.namprd16.prod.outlook.com (2603:10b6:a03:1a0::39)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 08:50:27 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::cd) by BY5PR16CA0026.outlook.office365.com
 (2603:10b6:a03:1a0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Wed, 16 Oct 2024 08:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 08:50:26 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 03:50:23 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH] iommu/amd: Do not try copy old DTE resume path
Date: Wed, 16 Oct 2024 08:49:58 +0000
Message-ID: <20241016084958.99727-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe15c59-cb99-40f5-d5f7-08dcedbf948d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fRZ7f2Kox8ZRjvXeHtCBeybZDM8jx/i/xExYKaeLM1HoWDRdB1snALIpWiwy?=
 =?us-ascii?Q?bY9+jqF+ecKoeCjbhi2Lu9Q6AlIf81thxkH3TB6va+LM25jNXjJtCUEhPLAZ?=
 =?us-ascii?Q?B+jpinSkU2YGSz6v79AnwcsCnmxIRb0ndGGi5FoVKt62oU/JSLH4dUezwROM?=
 =?us-ascii?Q?qRiOryNO6A2UAusOGYUfizoMZpXflflBN2nyS8o2O+IM7hoiTdKpId8N42K5?=
 =?us-ascii?Q?SXllAbNBn2uEjWvnRWuQJnacbyMoK7yCEulw02aWQZ0ktMmiQr6mURY3nqcN?=
 =?us-ascii?Q?xicPiWNl4J6dPw3VGihJotOBStGMvEDEeEvQb7fElM4LtZCerXYIuU6QjYHi?=
 =?us-ascii?Q?UNdXYPoWFoshYekDV+J8hUyST2ZelfZhbvnKFp/NeVFvzgVJUY3LUeh88L7t?=
 =?us-ascii?Q?pXJihIxxVg6hT1yDG8lmsick2kGDjn3QRbImXgqTXw87jDO8sj4LajWNniyg?=
 =?us-ascii?Q?cG2KQHv2FJrV7omwcdvZCPOfTAl6P7ttyr4ksR88bQVS/SrP6nG9Z7i4L7wk?=
 =?us-ascii?Q?NIB5LOlsDjs5mhBQlIhEJvhE3LBzBASnhK2k4aqxHN0hCwWHyHGc7ilm95Vw?=
 =?us-ascii?Q?aOtdo5OzAQtLUSJK/PMkJegPg+2/wiKje3fVLYYtA1irGHFEwgWE/ALS9e3A?=
 =?us-ascii?Q?/dfLycB81/wWhweWeB21TJkjk86wg0cPqgbxHKQxOsCldYLMzj95U0+NEX/h?=
 =?us-ascii?Q?uP8R7Tm3aPAv6n9hFu3cq7cuoN6xZ+ePIL+jAR4tj9JGxPAp/1Bhuqws4FTd?=
 =?us-ascii?Q?sDRSrWI5n1C2Zyx2aodems6B4qQK8rLgf5Em6nuWQcYEr8c0i22N9MCacLQ5?=
 =?us-ascii?Q?q4xq1oRgK2UwCSmsoxDsNLKHJVNk6YbZ/IWsoflAsaKmKriOkKpQRW+ymMSY?=
 =?us-ascii?Q?wCe3pvDqUwjwVP1vqKkc/Yw6VKhFqAlLvAY9/s/LMkr3fn2gL2IuMUFgSXwf?=
 =?us-ascii?Q?k2hAg4oChLmhcqVVgu+w+N0Rxip+pOot+naWLmN/FrHSP4K/s6dnYozI7NKd?=
 =?us-ascii?Q?ta6DGatW0Zj2e7d5IdpmTGxKXbUkxbfh/FFtmcwnF9cwGWRXzLeorCYH03JK?=
 =?us-ascii?Q?cKCPlvh2c73Z27Ya9gCkOtTGks4OUzQX4XECm9pbRB8ML8F1fbtjdksBppGi?=
 =?us-ascii?Q?xo8LmuZCF9R9hdbrMi5k52k4HCw4Heh4LE8fWgFkWoei+tYWX3UmFHnG/n8k?=
 =?us-ascii?Q?M9vmESgCqNE/KhD4S14LU/7uPQ/54Md7AiBuyLEyLsWoAwFOHHNQ7oXmQN6a?=
 =?us-ascii?Q?e9ue/Napne+c5KegKxu2uVDkLWZ9hAj/wfblsWRl/SsoIlfs/S7ocOaztHiR?=
 =?us-ascii?Q?tzaBIodWLCz9uOPbmeJypb/NzIImp+Vi/w+iQYMoLOp4cxiEkpDXBw950WAt?=
 =?us-ascii?Q?WpDCgLKRpUzp+k/5OFmjB5l4zRTw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 08:50:26.4752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe15c59-cb99-40f5-d5f7-08dcedbf948d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

In suspend/resume path, no need to copy old DTE (early_enable_iommus()).
Just need to reload IOMMU hardware.

This is the side effect of commit 3ac3e5ee5ed5 ("iommu/amd: Copy old
trans table from old kernel") which changed early_enable_iommus() but
missed to fix enable_iommus().

Resume path continue to work as 'amd_iommu_pre_enabled' is set to false
and copy_device_table() will fail. It will just re-loaded IOMMU. Hence I
think we don't need to backport this to stable tree.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 43131c3a2172..3fa70169aace 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2882,11 +2882,6 @@ static void enable_iommus_vapic(void)
 #endif
 }
 
-static void enable_iommus(void)
-{
-	early_enable_iommus();
-}
-
 static void disable_iommus(void)
 {
 	struct amd_iommu *iommu;
@@ -2913,7 +2908,8 @@ static void amd_iommu_resume(void)
 		iommu_apply_resume_quirks(iommu);
 
 	/* re-load the hardware */
-	enable_iommus();
+	for_each_iommu(iommu)
+		early_enable_iommu(iommu);
 
 	amd_iommu_enable_interrupts();
 }
-- 
2.31.1

