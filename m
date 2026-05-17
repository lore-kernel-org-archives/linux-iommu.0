Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43FC257844
	for <iommu@lists.linux.dev>; Sun, 17 May 2026 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779020997; cv=fail; b=YD6KpTiPmxEGFTAo3uCwcNdqbsqOkQVglU0cfKE3XiKOppf49xe5bFc3Il/uqIJTW1eYcrntYPSNi/3q6mvVb1XaS4/JcX3a+002j2s3okXUpyHhhT86zcFFZowl7+Qf89bDUT0sKSSot/SaibIglc9THtLJ8IlFV5Fs70nVPUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779020997; c=relaxed/simple;
	bh=gBb5q02Cf0GZC/xpO3ZKc2cTwQKWhZ8OD5+swbVA7xM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LvUrP4hIbd14YfmuLiMXlgvTTPt3GSPj4+rtyzegAfPJfEn5BFzvA5+5uvRLYOad4RKf8cd4YrkYMpsYIzS/L86cppaq5XZJ6LWcNevEbl2y81K5x+HJ7hmKOozVsCcniCeVQnBBNIJzBMj7v4gK/On40FkfkA3kzDfmws0FwNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gYINb/RD; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gYINb/RD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6na+eSGLhJhEuQ0SMR0nlJS4vzOb0PwAzxa4U6PsEm+2KWuBg6IxQ74o8XJU7V6AmROxoE/tWiGXiruXY+3bRcQ0zdBFN75gfdUA9IJPGskJCfnxWez8RJBHyXIEbfjhafv5m1CPeKDnOzVWsCvIulmNhIscG6QH3wYAkbEuMk0qBofuyS970m7hq/9eth6Cvt0rG8YGQWEwRP9REvFM/m9R+80tK0M3Jr71DGZfB7e3tTcWmNhF9Wp6hq5N0l+JAKbCRyvjlOUmtJ3rQbB3iZycvzRtpET+ztmjc3qxwN6fPFbxsI8MjXmkuvcSY4uMy4LKu1Pcf9q6Wd6gURl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDbgsB4j67rsQfrgysgCLn8pw7BkQ7JPSfyj3n3Ms0o=;
 b=I5GGVTBP9+pWkdmIlGwV3DCu1zdhskZRJBw0vw6nPWJVuiacROkmi2IO1d2GQ1PQ1RkEk3fmA7GYSzBxFAgaDttm2edczbV4u5GU+IS1j675aT5LsOqviMlQUdMkCAT2nZFbINVtlqj9V7PhUKvrtBMem5RWFVmrL7V40y9r4VXGpHFV5rG1thprDXiL+JL4xZmENfBV14d6kLX0lFFJmyQeF1aXsbeWApBIDxJbfyYM0FMHOYfhACJPUv7M+zT2OpyilVERMp+gcprfNEkKjjyDF0IcnMiFWXojXBwJ3rCEjCn3QQm83dX9R55drCYLr54NFHUd/wr5d2b/yTVlNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDbgsB4j67rsQfrgysgCLn8pw7BkQ7JPSfyj3n3Ms0o=;
 b=gYINb/RDn19ILCBmlJEcbTQBwvLNqAV+I0lIWBvN0OOpPoVyF8yJEfT9dsIoR9IMYpYOkS8xW6D3H8UpNUvYbJHakn618uECix4XzLHR5hM/y6kwqG9gmvK7z2kshcT6CITerc9WA/7jItNo6aCLrjPCxuyzu8pTaNUOQSmMGIM=
Received: from SJ0PR13CA0121.namprd13.prod.outlook.com (2603:10b6:a03:2c6::6)
 by CY3PR12MB9578.namprd12.prod.outlook.com (2603:10b6:930:109::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sun, 17 May
 2026 12:29:52 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::62) by SJ0PR13CA0121.outlook.office365.com
 (2603:10b6:a03:2c6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.10 via Frontend Transport; Sun, 17
 May 2026 12:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 17 May 2026 12:29:51 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 17 May
 2026 07:29:48 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"Sudheer Dantuluri" <dantuluris@google.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH] iommu/amd: Fix premature break in init_iommu_one()
Date: Sun, 17 May 2026 12:29:25 +0000
Message-ID: <20260517122925.5735-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CY3PR12MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 847c4b7f-d0b6-44e8-a224-08deb40ffe5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	enNnv9y4tIGllbmy5uKlX93ZU/KNSS0vuAfol283p/Hjp6YbL9mdcUxO8mKZO7k9vUQ/gYndWBJCE4xVOVkC1kDpMsdzJ5yJ6eJ93e0EO7mdLGpJO7RHofCryakoQqH+XsBrb7f8b0l8hVAm9UiG/nzwItQS4Jm4m1sOM4rorPTdqYfhwNlMXh99/gAZ1npEzft8DSvEk7HkMjcih+rfupLCUubv/8fSzKpau3vZWrZw5Ft+d3GdvZeyO0AeFdxKt2Z0VVPPYlHYnP22g4tRrWK4sdM6OR6aoEUn7k5AzCKaI6z1gs94BBDS+H73Zs3KS+m/jznpZYctcUQWQrwLMan+0A+chgBQ4lUjbGipOeGwiZJQFsU+fWPx5F/xX73UbBvNW+g4Y525AQaVXK1mlpiEjoOUFK2cBQzdiaQKNZlDXm9sg4HB6gYkMV2vARoiFdvmwkPv1M3td57Qc3EpOVCoMU7NvpWqhXnPAa/Cxd4ZGtihJfJQhUQUId9kSmCM4HUny4YAgZ6l3O0rgiyXn90w5k1Z5OkJZ7AruYf9UlANbOQBDWAdmLW/TAyekQS5RCkLcaiIsD4UlzU6HqI6NmXiHoyV8uEd8QJH68LWaTMaB+LAMI+tL/p/0XeFZZevbHAkqolXhPQr+66SQobRE47CIZLOfqiGOrf86O6bkpgMJho1ze73n8ITWqthuUeX+odQTm8abZ2ByAha46GI9X9bgpsdoX6rbgXkxnw/EIE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oULo7wWvj+pefPgklBTcFoGkU128DjJCzmYtEvcCiVJVY3vC0vo7oOtDFJEGAHnjs1lsm6vEhQ/58X8QiOGwkCyK7FPt38niyRhTxQXn/rQcnFLT69iRZMNPLW7ChXtuIaSEaauCqIkQLvYmBHKE3NX68rEBMJeqn09l2Er4z+fX3/p/GXAae03x6wOSM4h+c9+8RhKawJnINN1u5LfCMzVszuDtsvl2cNRs63PH50PTBaESQIJ/jlcoChTL24ZchSCrlL4xFEbaVbn+o3LpFnWcYdnEsBDc8HjizEZ+VBN9lsaXNdwmK08ofihUZ0wsIZwF0kGokzK9w7+A8TUogUlOd+mzYAJyioptKKycND8fzPaY2rQRVMi88k86f5phbXh5sgkU+r2e/1hbuU43RVUmlmcqigCjxGSaRlwuWxApBEGZlFvviVESIBovciQy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 12:29:51.7096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 847c4b7f-d0b6-44e8-a224-08deb40ffe5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9578

In init_iommu_one(), when processing IOMMU EFR attributes, the code checks
whether GASUP is enabled. If GASUP is not enabled, the code falls back to
legacy guest IR mode and then breaks out of the switch statement.

This break incorrectly skips the subsequent initialization steps that
follow the GASUP check. These initializations are independent of GASUP
support and must always be performed.

Fix this by replacing the early break with a conditional else block,
ensuring that the XTSUP check is only skipped when GASUP is not available.

Fixes: a44092e326d4 ("iommu/amd: Use IVHD EFR for early initialization of IOMMU features")
Reported-by: Sudheer Dantuluri <dantuluris@google.com>
Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3bdb380d23e9..9a846dcd0306 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1939,12 +1939,11 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		/* XT and GAM require GA mode. */
 		if ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0) {
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
-			break;
+		} else {
+			if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
+				amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
 		}
 
-		if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
-			amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
-
 		if (h->efr_attr & BIT(IOMMU_IVHD_ATTR_HATDIS_SHIFT)) {
 			pr_warn_once("Host Address Translation is not supported.\n");
 			amd_iommu_hatdis = true;
-- 
2.31.1

