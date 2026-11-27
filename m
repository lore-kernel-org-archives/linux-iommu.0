Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795778874;
	b=ez7dTWCx5+GfErKSH0ixEkV2NZ8dwG6zJoa2KEBAAnys3ToSs3r6hTQYNmi2KzRQb4Ae
	 jxCcbZZLPuGS/EHP49dXEKl/lSkEg7G/mRBhHQZVTC7Qg39rBc9UphsTmi8+9ixt3mwYR
	 AGg9uPDs3GZU0szMJw1KzJB5w9FUBR5pfsclVxQdtcupSjk0aMafklLVCx1hDLplgDGc1
	 4uX76DlaekiN27050tpWb1g4GAXjhWtiTfz5lv9/vR7TemG7Jz2xkRht63N1hGBAHXguY
	 35n8RafqHoDv4JXup3GPvVSUYZzgIj7LsVK7sddBft+BjUkOa1eERTA4ELlOexQDg8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778874;
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
	bh=LSKLkEwmO5mZ2BMiegVYQNoVBIbBie9UecYJVaaASMI=;
	b=zanNDolwmFGo0ZaJd633ZTTDnyHeqNgY7Awc2rON9hK3SVUBuK5sNLVUCT3iwnLeUG2L
	 DLr+iOI0QrPB19yXptF7hr9ZgDoYw77CscqhmVVXdy+7I+YyPVhm8NfW4KfCidkVM0BJE
	 pMkleJIvP3ABofs5HdFI4ApZs5wtm3NE+gnEf0UK7Iha1/mdxo2umSHuSRkk+OjPa2fKz
	 zpQhKpqvisepcsi9fhoE3u5EY54aFIAUaEt013itI0WmXgtQfsMCWb5pyH93mjYxz3EFm
	 zoPIVHFcAwHxcN4YVbXEzxtCHzpW9YAan5Qu/I36jUZ2or/JsgXFTPWPMx3L3ehtJSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=e+O6beCD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.38
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE0606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4EE0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=e+O6beCD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJGK/VYVKBpvFbMO/jcKLiMKOZ8WetRYOsnla7ciHdv1ey2hOY9qhwa81rIMH/yUaiAavmXw/X9fBgtSJEJ4D0F8Uvu0gNxfERi82DacUxnYUNZWhgV1KEr7EJAPb9/35fiHOkjdkJ1CAQHqPTfxU19XqTGCb3Sv5nxeAAnyBfaTJ63ayE1yg5tNYUdDzTgDQABi/Rg93yYeHiYwMPiLmuVnnceiN+fO4dim71E7KtvHMfT9ddL2VuWBLBoljvR2Ltth54BNF6pFXCTHH6InOy65OLIKOEjzHb9UlHiQQ9MNpJ6X8XO0ALzmOSoAML2YV0jBarJo8uov+qFt0xLiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSKLkEwmO5mZ2BMiegVYQNoVBIbBie9UecYJVaaASMI=;
 b=oBGXeY9/2MCp210t+D6dLkYM2Pps7APQ1FQg+Jg4UAJFEFniXhTyargP+3Ri+1XRU5ZS3DLCG9HaJX6NqpC/4RpbTDURtfoIYeEaBDsyOxhI+sqeS2+ZABAJ6oiZoVyV1kj5c2GT9b4CbjmPWT/0dl2TimVSzeexrvBRbAjhldvCE/+Z6JkpHTQsJZSMR9xA4azdMEmGoRsGj5kN7+8Drwg9UQExwYpfFKwoSEYFgs2rzYF4nN7nNnhD8vDW0pTtV8wVHqDhyDOL4lE7YCPXo0RM/tQLfn/Z7Kb2dBoVmqtp52nlTx8BuPSMdTEM8YHvEvWySqd2+xCZKuXYpRrs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSKLkEwmO5mZ2BMiegVYQNoVBIbBie9UecYJVaaASMI=;
 b=e+O6beCDo/EWP0W7CkuaacSLUM07XKUFWt15khcvTPlGNRTGQrliwDFKvNnEq4UzCs9vdhlaG1HooQ7QCwWMI4UmtfT8zQJ4gfrH9pRx8+efnhJA1g7Q2OolTBqZAx/TcqpTzo23kgtZM0TvgIlRwh/G7PV+oPCoM1bfmOLeMak=
Received: from MN2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:208:a8::39)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 11:27:47 +0000
Received: from IA0PEPF0000003A.namprd03.prod.outlook.com
 (2603:10b6:208:a8:cafe::76) by MN2PR12CA0011.outlook.office365.com
 (2603:10b6:208:a8::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 11:27:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003A.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:27:47 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:27:45 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"Dheeraj Kumar Srivastava" <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v2 1/4] iommu/amd: Destroy protection domain IDs after the domains are freed
Date: Fri, 27 Nov 2026 11:27:07 +0000
Message-ID: <20261127112710.208885-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127112710.208885-1-vasant.hegde@amd.com>
References: <20261127112710.208885-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003A:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 78233f35-1aef-4ff6-dac9-08df4c7976e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YgoP7K2o7giCxO0q5NORCDs4ci9+q2HlqRW9Epd3SpErKWoeQodMhQ45DaCgnNqOTvTBjnYNbTbNdFq0eYtaw/F4SSjT/v4JmcwVaerW4KZScqivUFN4GBR+UCbsACWG3AWZtaM8lZKevmfobKJdmixQUZ6Nwt2LyXPM9tY+PkNShRe0FJEqA8lvEpGyGb4LybWkIWQPqRc30z/XOZlOUJdHvCEicXbsM9nY+3IEkdW9HQQ7ZXjDbc6W5/ufJhezxVf4ArrLr7ppxmbtvFBoO+BEgGM8PDOE9O5WyXcNLUKBhM8yS4XjhSE8Trzn49ip71LyAKGbwdsOv2/T1fOixVXV6dbJNTp48yw87upnFU+KGdyaWbXE97LRbZHT+yINANZC0upcXfnh6C2DS9fcEqgBVVZ+huJ5jl8h5Z92wsdbWeXAQ2bXYfcR51D7YuRjcP85BifVhrY8ewLqNftplebpBgyFWxZfbrcKkdM079gQ3sftFHqpTEil7L996MVxwPv80XktmZUCXAIywwRa3Gq7dWDu/UQF8tiejw5Tgb7ASUTtK40stx/x/jD0h9k4ahg5xkHSWO9v0FPnOhak201gk1rt71y2CTu6eUgmbEidnDcotf1dFQTmNbuoaINGOJKbXMgAxX/nNS6MLynRlOev2VSXWJswd/zJhtJTKfLTVAHoMxEjDVMMgxlNnuY4yKaemPCCMD1XE77NFHC0Hw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QpJpg2PoVrzbtEqcOaOAXdE1C9N363UUhzsGnB283UGNgtwx0jE5/oabBTjnYGgn1mWpHW8DsOQ1hegPQ4IwNLemsj/kJBXX4ukDcvEg060xdjwKVfav84oIW3H3qiZlihmM4+YajK60TlFS1ccMDIQn8CAUo+OdtHPrc9bXPOZuEoqv0oZb4mwkroYGq3UQHyd15lxMZAfmc3GXQXUmxJmjfi0nD4jITllalL5rC5mQCJE5BSMzcW5izN9t6A+ilAvfB9UZyBqpNrXX7v4WUYG9mjy/oXoZULGgNBmYxiA2ceHwO0o22CR3lxXK0haYFy+ReYNmJ33bq55ufsmPv5cciU4LXw0aA6/5L6akKvdEEJJBvMKwO9OotqmihE1nrUKIwiSOhBzVD/3kskxP+KtnfyocOoiHAv0/DG5bjPVFJ4kUa9ORlP9zHcmwgTx3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:27:47.9001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78233f35-1aef-4ff6-dac9-08df4c7976e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390

free_dma_resources() destroyed the protection-domain IDA before
free_iommu_resources() unregistered the IOMMU. Unregister frees the
group default domains, and amd_iommu_domain_free() then calls ida_free()
on an IDA that has already been destroyed. That warns for every domain
ID released during init failure.

Move the destroy into free_iommu_resources(), after free_iommu_all()
has unregistered the devices and the domains have released their IDs.

Reviewed-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 10e89b5f3760..0993983e5bb8 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3214,6 +3214,7 @@ static struct syscore amd_iommu_syscore = {
 static void __init free_iommu_resources(void)
 {
 	free_iommu_all();
+	amd_iommu_pdom_id_destroy();
 	free_pci_segments();
 }
 
@@ -3308,7 +3309,6 @@ static bool __init check_ioapic_information(void)
 
 static void __init free_dma_resources(void)
 {
-	amd_iommu_pdom_id_destroy();
 	free_unity_maps();
 }
 
-- 
2.31.1

