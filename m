Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780565;
	b=i1ODVucGzObHU/AjeclFOlIbfCKj43jRAwZxdxcBmzCVKJFy7h5QIl06vKz1mfBYxV6b
	 82wOkN2REAzA/m1eB5e2X6OMZLjqW/DnohqxPXnHGqeXQuFF0Gm1sACGi1divryAl5rV1
	 kPW2qwwWwUmkUVvICab+/7omla90yrLTOosvWVs0vrjzfGUCu0Z6rFoFHSdyuvgVAG0hj
	 kS7qI+YQvLQDgdATBeU2rZ0Xp7tbTdZsIGs6C22TAkrq/ScaVze8pRxuacqfBwo047vxC
	 gI6eIbBVGIV1/u2ncYQIa2LxToTQhpEFC3nlXFjMsZsIMPUDFO34QhG9EAnA0SlXBKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780565;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=O6a58BrJ9DiBY5ixsfVs53A2IBA5qdsSyhQdb5met5M=;
	b=MVTx7SNkUPOmxRoyzMkQo0pNl5i2ocqoGCQtw3y34Im1NM4Xons+3TSL/N2vAX+L9Tq3
	 e7df7edVDVsnZJ+POv/sd4Ttr9pR53wmjq/P+WMKoxAMD2ZJ9zVKCuLBWgXAQehdh+MvO
	 UqqNfqiBOQYXwDNw8mRdatcaKgvLpCSmQ3Gp19ZLBpHzceWyqVwKDha80j+hi26blWo1F
	 iUoEw2R2DyLEzIS894lkEyAq58qDjOgyl9deh2lDe/2C2GiO5oH/0LjwXdaHVSziGSVnc
	 eabThebfmwK2PVWy1c2/BApcxdjJf1tN3Iu57lVjut7LapuiMEcp45EcOjPdNsbMUeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="pm/Rx+6l";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.2
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BD8606A31E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9BD8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pm/Rx+6l
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJZTSywH0jRyf4IQ790rUQTHyQJxBt41HfpOScCTVDS5rbZAwaGL1VXkuvSQ86ojUBzZCLEr+KYR6iq0NQj+o6UzGEeFUUSeAWHmzhLefQxqxkl92Uj/8aKtc76Z2horkKoyB2n3p7hXsYvAc33/ECwHScmCSjrIU2txrQoAme8/AVsrYga+y0P++VrI88okpuPVHN8s0FvWJGgjaeHIv410ybZCYQq2oM/jOFV2LI7dPOrUNP6AmR2FK90xGwNBJUg97QXuKFW2GmHYXUfpURqfseCF6uuXznu7mdX4oDwjL4imYPIBasNiPSdSmTvItRy3oR8JZDpvg+o22BJ41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6a58BrJ9DiBY5ixsfVs53A2IBA5qdsSyhQdb5met5M=;
 b=JztonY9MMr1KW3hiRqeeMLEORY+TIHsPp+3WH2Ss0NhSCT7U469BxIpyHQW0tKnNOhhb+jlq1xAFBQz4NzS81kBgvaxnBAjT7wRox+eOl0FDFE+h0Ze48LUotiYm3Qk+lzb4oOPs2fvtRru7am7wMee7aaNNMwmVW9CZ5FSg+eXRmDYe8FqbBOk0ndOFg3p3md0ZYnDnEXRrU8FgPdJyv0tKsU0w0aGcTl3OVw70b4h5PCiw8MZMDdvv76S2S+4dxAJrNQWd9AOIxmKJQEYYZYNt4hxJTkQ58Y46oQEK+sGUvtL6nKCo0k0obheF4aNuhVIr/EZLzty6xHuSj7R1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6a58BrJ9DiBY5ixsfVs53A2IBA5qdsSyhQdb5met5M=;
 b=pm/Rx+6lFQz3n+CYe+kooSUpOpQbAfQ7bXkzOSJA6gCnkTtT+kbB36p9CAEIn7PBBi9BhL1ND4Cjbsu+2VZTwLfly+VcIzkRWXLVpuKphMH+fm4rYWWfWEvM2Dm7GJZtjHkhvLHkifDBRpg1at/rio67VM6RlqHfMjTsIaQN7+I=
Received: from MW4PR03CA0140.namprd03.prod.outlook.com (2603:10b6:303:8c::25)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 11:55:58 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::3e) by MW4PR03CA0140.outlook.office365.com
 (2603:10b6:303:8c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 11:55:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:55:57 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:55:54 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 01/12] iommu/amd: Disable PRI before ATS and PASID
Date: Fri, 27 Nov 2026 11:54:36 +0000
Message-ID: <20261127115447.209792-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127115447.209792-1-vasant.hegde@amd.com>
References: <20261127115447.209792-1-vasant.hegde@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: de899f3d-dfae-4f87-bfcb-08df4c7d664a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|10067099003|56012099006|260925021311599003|260925022911599003|260925021911599003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	A5QyAEeW7f4lhFvAm24kq2Uuzd+wvdQOzoKqbMM2NaCMBXoB46EIfmrZFASeHKtK4DIt0XCYv0V8o4DTuQssj1t0BnqpC5lGDbL3zh0n7wJTpK35M1FzDWoZkjZYGhJWMZGSUzVZb+o2RifvAPpPcpz22Acd46nQzj0fu4rtM/2Kc7iA1nJLZzeLjBr87b8TutULFCEhydjNSETSykZqLvUjpuZqxbgxGNntiygA9Lv5hwE5DQyVmT6YmiOY/eYtbdU3PYMFGOkhBccPGAspbGUM+QAJgV5v2iXl2MnFN1FBLk0EID7M1XCJ9jft/SkWhluyQe9/9+rdezmxRz1JVrffve/5sM0p5asCzIPaoi6Vf0JXmhfvSWRmhPjme8CT0iOkFc0O7auVkAaTGPbUn4wHy4bJMlt5dlDtSg5AP0OxjwDDuiUEwxqFLsIG9LWMUTmhUzwZX1ixnV57EBAvuv5OnPJYlrb0Iwo88qzwHYAoOzL6UC0qecwp10NBstbgP+yzPYVXdzyd6l5ZUodnoQ5VpV0ke/B15yQdkf2NKI3DmMMei8r3shTaFA0OeOtjFADy/BXZNQsx6DbQpOCJaBGX/SH3XZ1sCYPWWfvWGKxc+5oYkWNEK/0iHAHhUEW9TNsqOJQJyV8mKUfXwAVMIyEYV0JWq8cmSTWpcdsUi6bnNoltKSJiFIyr2DHBC0vQiU2VuQOut/FNPxTxXdl60A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Fz4wHhVXxh3k84zmkdc8s0ONMIhaD3H0LXlVDyEH9Y3KghE1aJV4uoM19vkG9khdJoIY1XxpIu5kNxVivDg3BoA5NhSa9PdAaOMZHNByGBt0YLqCMweEEFdX/tVkEZKI5Z90UtiTeCYXd5Mjrj3ULIWNUx0bXN5mS6DBwveqAX74s3zoo1lceHeorUx/34OOz+2FrpavYS76MDrJefR199kO5m2ctmm2NrzlbWacQQVjG0+tMXahvRLBDJGQQbfLR+6SdiLLwiz87b3vpXbFxPk6VIpL6NvzsCeuf9bvzO8Kiw5wjkAI0+ADdEE0qrGS6xQIY0YgHXMtelPTQ3zLX73pT9uRoivsO+QhwKtYpzxHvkfQuRmK9X0ve8RrvQxMNrcRilmsjfuAS/nyIfCqG3lyLQuMRWV6uFZkOpxLTge5f4Y+2g3M9oMSIcRiecP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:55:57.9410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de899f3d-dfae-4f87-bfcb-08df4c7d664a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515

pdev_enable_caps() enables the device capabilities in the order PASID,
ATS, then PRI, but pdev_disable_caps() tore them down as ATS, PASID, then
PRI -- not the reverse of enabling.

PRI sits on top of ATS: page requests are issued for failed ATS
translations, and with PASID enabled both the requests and (when pri_tlp
is set) the responses carry a PASID prefix. Disabling ATS and PASID first
left PRI enabled on a function that could no longer issue or accept such
transactions, while page requests might still be outstanding.

Disable the capabilities in the reverse order of enabling: PRI, then ATS,
then PASID. This also keeps ATS disabled before PASID, as required by the
PCIe specification.

Fixes: eda8c2860ab6 ("iommu/amd: Enable device ATS/PASID/PRI capabilities independently")
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 45298d31b183..cd9179319709 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -656,9 +656,9 @@ static void pdev_enable_caps(struct pci_dev *pdev)
 
 static void pdev_disable_caps(struct pci_dev *pdev)
 {
+	pdev_disable_cap_pri(pdev);
 	pdev_disable_cap_ats(pdev);
 	pdev_disable_cap_pasid(pdev);
-	pdev_disable_cap_pri(pdev);
 }
 
 /*
-- 
2.31.1

