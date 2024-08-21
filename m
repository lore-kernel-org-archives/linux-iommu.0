Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB3C1A7ACE
	for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247476; cv=fail; b=L3Kl1AYxI0lp4ejPowBrBWlz735aA6LMsvL5cnJBXaSgdfJJJl9yfDq1nPrarLCorj6Tz3Qmu4546phQyPWY5CnfBYyTxi2ikjSZSwCKU6hfEEUbe5hjjpNOEVdvpjogLrobls4YE/hfxsXlJdcguM0+ElmxcjrmnKAF28ubkJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247476; c=relaxed/simple;
	bh=ZX3imIByisHjdshg2M3WtdvuOVNPMSPhdLe5ZZ50zos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o02+Msv79jqlxobKHlC+PVPjdXpp/FPKIBnWMEwT0wvImf83NAAvVp6l4tDYz0Qsh5nY3b/TY0vbrSbV7Chx5MRoSgKmarEC7zUuIrVGfnKgKakGpVzPxcd6lUG1udnMBxXPaaMQykoOvdB913G8AFAnENWScOaZT3W4Oaj9sFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SH1VVxVt; arc=fail smtp.client-ip=40.107.96.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SH1VVxVt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FegPqGXC5yuIdnwRCMYjqmMbOoSr4stWsuSKCEoGu7SUD0G6I9f5fhm1i8djT6Ji4m641adZVC6nCLYK7lMnUDqKWDVYSYr8NwxyqMGMju2Az615uLKD+QdFa3T5r84Ljs5VOffA9rC3qvLqtq6BRtYOlcrr5gwRBa2L0W94HrrgtYXi8l091UkYDkdvopviIxADk3mKQSNKZik9xMfPzDbrpJh4bICDJBGRKQ8vvIB1+GyTuG8mgiqsYAMqcK9IQb16RsUHdgOGFfU0SYSCtHKDzItHWnFfJeZJSRqkEkrBkQ05m+3ct80MH0A7xCT+CYj3IIaU2YfKKVakTWOObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axLEaO4BDKx8L7hYeOySQT6jv/sxdI3Yg3DQ9fxiFGI=;
 b=wmNljjpHfs/ju0BW77cHXidZDw7I4fCN0fuwjjEmd1X4QMI8+TXreGHKlyI8r+kTS/PyMdTSALgxTHYwxyxOUJgPKq+feLy+0TYTndApdo8gcY1SnxB170V26cnTSCLWQqFZHB9WThPol0lcwoGQV5wnQ7l8uQMaMblDt8fmR73Yh8W3RC6OSz0kpBhcS1QLuCEuwHglfiZte/roV8btvZD+0c2JES1lT+OY+WdQowPSG6InCf5iaBcl+wLvCHCKw/oEGqCmYXszperVoVEcJ8hRoz21NNhVCo1cyXLdp0kUtI+fpEOQSZg9DN+N5k4BMEG9Jd8UudFpZYPSdYuGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axLEaO4BDKx8L7hYeOySQT6jv/sxdI3Yg3DQ9fxiFGI=;
 b=SH1VVxVtejQzZwO2UnRPm+VUyJBLEDn//rkHVDJzczLmpSuEBEXldE3o2fiZDwxpk2CrDELqp6QdCPzZJdA90bw2JhMZnLAVs/M5eKzGTIlB+7I+F53Ae2zDl3OfAwRcDOCiQXSxUTuhArrk58DjNiaTdwYU/0fvp3Gvg/NtYME=
Received: from BN9PR03CA0145.namprd03.prod.outlook.com (2603:10b6:408:fe::30)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 13:37:45 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::64) by BN9PR03CA0145.outlook.office365.com
 (2603:10b6:408:fe::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 13:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 13:37:44 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 08:37:40 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 5/5] iommu/amd: Add iommu_ops->domain_alloc_paging support
Date: Wed, 21 Aug 2024 13:35:54 +0000
Message-ID: <20240821133554.7405-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821133554.7405-1-vasant.hegde@amd.com>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7a978b-a37c-4879-0144-08dcc1e67005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8xljQR/5ORt4sxyOWS5FYbGgBTqrfPPHiFD/jflPETMXvM0WVGcyidop1iBt?=
 =?us-ascii?Q?m2FVOZnYVYguk+yXMwqHC6kaSVcJFjS05d0UNs7p4uzWwtNR/eGzNdzZ5/Qi?=
 =?us-ascii?Q?PjzgazNMNJs01ZX4IwefbNdS6vx4KP0eAEXyTEW2Kv+kxrQel+odNXOloMUR?=
 =?us-ascii?Q?jWRajxKx8h8caQtsIhgI+IdcPHEXJDaDyQ9OVqAoIvck24lK3Q6jdxwBCy/m?=
 =?us-ascii?Q?ZrsJXAiYDDqTqATBUH2CXEDeDSsIMieH5ZF5xhHWPiqppuGTCxQJKVNh/cnh?=
 =?us-ascii?Q?olyU/uuTtYdLRxrAgzx9uqgbvQrJjPDVSaABQtkepEbKkfmbRBc5NdJUWIqJ?=
 =?us-ascii?Q?okxeT996JXCqPJNQkVZqceGPCBlxGJwJAXt7ueHE2VUJmbMBffnU8mrbqaJa?=
 =?us-ascii?Q?qxV8JrxR8btDL6GMbEdh7wXqbxolqe+/4qkdIIePOsggfnOqxLjTvBPRuEjx?=
 =?us-ascii?Q?x7YVX05diW+mwKiAhz/fsV0J+jioPcWS87ARuYiDKHt26xsGOAfPYn4hmbQC?=
 =?us-ascii?Q?gNl5w1oTgy3n1p1MBbkfVvH91DzbjDTgCj7rsn8cnC5SrYcvmlNRui3iqA9N?=
 =?us-ascii?Q?R7DzMGi4JxhPtiS7VfpWtDX6nQd2NwvYLN3VEnDB8LqwRRa8yU93FBYMNykf?=
 =?us-ascii?Q?WpDZwLtGkVSCcN6bWWmK7ctGYN+SblSVnsyVxsx3NgdoLQ3NxB5mvdEeDyyg?=
 =?us-ascii?Q?+VikxLHzG2VdVwNOgAWmzzvfQGKRJ59OXxHkF75MYmUNIWgWyltCx+aki+JV?=
 =?us-ascii?Q?CpguYILJrlzAr16rU52InicioTdL/sZNkCpjxfAP3k13oUUM03JG2VFFJTqi?=
 =?us-ascii?Q?+CrX95dlUDpPETr72jymQooOHC3oTK4zDTOeyOwtectLGQUA/12/mbxvzLL/?=
 =?us-ascii?Q?AHE2//QxNClwkjpZYTmftOGQzsD70qBgI4C6nJaZk4+KZzcIaDQaz4gjmV2A?=
 =?us-ascii?Q?BuQRQR3w57wfBRMit1FjbFUzaKQKESgUZJXIi7lTSqxgSXPfkzlsInwOfHDQ?=
 =?us-ascii?Q?w8QdWNpuCKUSdGKGAyKz3AtsoSCNs4kGozH7hThpCBH8rt2SRcq1XiU41YSu?=
 =?us-ascii?Q?ip0KgcW9q9MvrEHLGJGU3gABjrTBYoDXyNGMsb1CufPrrqws7jq7cGsS9VMm?=
 =?us-ascii?Q?ISaSivYJeAdYbOFRcKAlD6uoR297AH97wxdosHM/HSnNjRmZJETkWTTiwKQ1?=
 =?us-ascii?Q?TMLe4V0lH/NOBh3WqJJP5vkcnt8jEo56Ynl/auI5bg94CW+MQTb/n7jXtAwQ?=
 =?us-ascii?Q?6GWy/U2Rv8tCjDAPqDYQ382QJe6sVi5QZ+JRX2w6T6yqIQSD3JGRC6RPOf3w?=
 =?us-ascii?Q?iHyg5w9fqzuFKeQdbXq+1Tdmi4i1pbA+jq2Q2jYE4+d3YuEGD4tXFhiTBvmD?=
 =?us-ascii?Q?OJX436YWw83hGsabiPZgZakE5OyfWpF3dP6gBcmRMzX1ZP4re7gwMv8EJpL0?=
 =?us-ascii?Q?aWuYeyQKItJPqZxyzHLlFGDIXUGcZEF+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:37:44.5001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7a978b-a37c-4879-0144-08dcc1e67005
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

Add support to allocate paging domain. Note that core will call
domain_alloc_user() to allocate PASID capable domain. Hence its not
checking device capability and allocates page table based on
amd_iommu_pgtable.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a4e6789f0487..7bd1ce5469ae 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2437,6 +2437,12 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
 	return domain;
 }
 
+static struct iommu_domain *amd_iommu_domain_alloc_paging(struct device *dev)
+{
+	return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA,
+				     dev, 0, amd_iommu_pgtable);
+}
+
 static struct iommu_domain *
 amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			    struct iommu_domain *parent,
@@ -2879,6 +2885,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
+	.domain_alloc_paging = amd_iommu_domain_alloc_paging,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
 	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
 	.probe_device = amd_iommu_probe_device,
-- 
2.31.1

