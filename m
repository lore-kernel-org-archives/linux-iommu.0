Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793896404;
	b=Q5qtQrfIVn5aA+yi/WyTKdAP6Gwds+SutOGT2Kgzjmqg6KjbFA8aufS9H3QYNkXthtJ1
	 55/lJwuW15s+gOiOJAU1EK4wEzufvtX+oJbu0N/rOBaW7gi8ej//Lcuhzvh8+qIMywEbR
	 rPDucVGZqS5yv1Ajpth7HMIV+2MXuuDvXASA7ivXvb8xqQj5jg1bCuWmJ5timOWSQNFom
	 ZnnSGxF7yijuJPaIgiZqZxCny+LfTI4GrJxv+vRH/qMDT2wC45iJN8Hti18B/nR6fsTXD
	 wx714TNi1bgFxN++hNhzVHpCw917k4rz+EpBAk///Cd3ZMN7Ad2fG0skcLNRy7cwgMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896404;
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
	bh=1dMXDokCKwtFvu3MdOJ+q9gQau4zy+5XVN8dbT0hQQA=;
	b=k+flvqB6YQMqZRPorHry4wj32oMBMlj7ojK1zhvwqSNWK9yHVkdKe5AUus/cNCmfAjRE
	 0VMnagrDgSHQ/k9R7UeOOImz5LTTD52JwwRe/K4NY3Bab0z79LJa/I6fOH4qCVBC4hOSh
	 qICoTIGIHY+TkZTluvdAgSlbj8k4hHTOzgU1C+xg/6FGF6sbZpT9DD8q4CGnaHmhmiscg
	 O3JJVG0nqzlq3QkFYZYnp5QaCWyQQmlv9TrSsi/4kmNEWJJ/kssJDVbe9Hjsq7QcCZniN
	 7ggvsbaE1T66/xK8f20fXvTZcMupaUswksu2nD4e+iZbUVvJjunMWxUHGDUSpPwq7vA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t7p+P0hL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.36
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771860A3803
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 16:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6771860A3803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t7p+P0hL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xE9hU0Qb4wB8yK26FapaNZ0FLq/lZzE1ChD0aQzjzhtJD7JofxVtjBmCZl/waTKnCTsskctW3c7KbUHhpMsb37CR2r15qM1RsXSSD1CfKHge+Kz00nDgOGJuMt3Dmf9Kcv8/FbLKrQcX/sDmkE1BbLgzT2LbLus6RctWYB1omGGCXsuinbRe4FMxEJb2odFly2XukU5eJRWxHWKDkCo+Sm1cxbLSf2YduG++64mx/rzwOK7vta4iNtGG6wDlSQA+GZY1adfWGzAq8k0uxzU1Gqs/+reRtjSsOBrqpy3mNkCO5BMsmC/DCUM2VKP2id1W1w4gRsjFkrdnmab89aS1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dMXDokCKwtFvu3MdOJ+q9gQau4zy+5XVN8dbT0hQQA=;
 b=sKk19+6MXfUdfXCzPK2F7XTR6ypXywm4dLp6SFxIt6cO/F3E/FIWeXtCzpMkAZVR28+MR5g+cVflVLAI2XhMEWbe8Ab3cBzvGf/x2POvcVnR3I47Yo35G08LcjP48DRBr1EpvkoCsOpNq+FME5IDirPxpTBQIXKYo5bxnveLq5P6hVegMytmNFoc0LBzVjDdqBm0jT0KDOS0iB/vqzkyzoXzH/PbGnx6x/lvJRUFXcpwG8ZZBRWSBSUVc+dYH0QRj/jFb3tYnIttkbNQaEUBcQ2HHOthtV80YTZsdovr42UTB5YRXsoGCBvTGlr+/ioyeSJ4lWoQA/AkTnJNxqghjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dMXDokCKwtFvu3MdOJ+q9gQau4zy+5XVN8dbT0hQQA=;
 b=t7p+P0hLp8vc8m12P4LpG24iMC5PhxHQTs95j5uowIzLcY7iqJrLXpmYbh1aUiL0v4ZWldGEw/n/aJT9/3T41c65sElZnWotxdXMnMrPa5zC2W4D4gMhsFXFdUrPjmkAApvJKVOe7XleIC6mf+xQ8khJT9HV0FdNaDbAdha4vKs=
Received: from PH0PR07CA0096.namprd07.prod.outlook.com (2603:10b6:510:4::11)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 16:33:21 +0000
Received: from PH5PEPF00000030.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::49) by PH0PR07CA0096.outlook.office365.com
 (2603:10b6:510:4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 16:33:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF00000030.mail.protection.outlook.com (10.167.243.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 16:33:21 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 10:33:19 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>
CC: <iommu@lists.linux.dev>
Subject: [PATCH 3/5] iommu/amd: Skip non-IVMD entries when parsing IVRS memory definitions
Date: Thu, 5 Nov 2026 16:32:17 +0000
Message-ID: <20261105163219.601561-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105163219.601561-1-vasant.hegde@amd.com>
References: <20261105163219.601561-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH5PEPF00000030:EE_|SA1PR12MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec00f0b-2e09-438e-0b13-08df3b5a814a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|6133799003|22082099003|261102123227099003|56012099006|3023799007|10067099003|18002099003|261009223027099003|261021121427099003|261022113327099003|261021123027099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	RiZUa8COM/U7olD2FIJrqOtuezwm45MdCiV9nql54CnF/2vjegoxh5oItfbz0LHRf5VWBZ65nXvNauywkiztNSvihRGelWIZ8fRSNZk9yiuUQFc+SQMY+dbv6RnW1iDEstowAH0Jfbg/NQWQwsrIMNPKPj/RmTEzP+DFqlLsMXxwKgNLKepsLPtDBCz8Dl7YZ797zMTlI4eR63ZPmvYvrdUoOkVcy82VWisGlfE7p57wzpGFYR+/QgQjBR6RlHF4e90wNztQiaQBjBihe4KCMKCUgiaiiDyv02QRlbHi4KYGas7f9D07LhhATqv7Xk+OifyL6e4gdAkqREeIlLJUrpiuurJtPAyX/1jziSZhqlHVAAYyULJUr4kxluMKArL9OpSgEL/z74xCcueJ4w9MyzRAa6CLDk+bI4rjjhsZynw+7pQb7xMIefXOw3j5igOm5Je8DQ6ZQlHc8WShpucs+kiyuJzHDJYfY2ROvV3AptK5Hdd1jrwQ2UPeVi6Rm6yWhQxCSu3ZXvMrcVYHLfVA+f9o5Z4j4dPFoUPiAfeWcRNndEgePhjrefPOA9BTmRp1Et0FecE01Zr5FxS40as7w8k+247yQK2atECgcunOoStsqzPS6LzVqhqzYhvYNWpX343kX49EUCe7aB3RQcBwb+iMpLUsTM03KqVyvpZTj96oPfqGHvaubHn5K4clhiHg8Xp9WvtTZ2spKvwXpNjEZg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(6133799003)(22082099003)(261102123227099003)(56012099006)(3023799007)(10067099003)(18002099003)(261009223027099003)(261021121427099003)(261022113327099003)(261021123027099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d7gf1Oj066gP/EzHqB1LdhlxeUvAOdxxLys7pp/Ll3q1pVVaystW51YjYY42DHPr6blZe0Lt9CU0/murjiK399ieH4k/Tuy0PpXCwmKWLFoCy98sne3xP/84TSHlvvUpIlFi0ns3iO0LMbSSq44jEQ9r9I5B+D7viI2oCQ0z3AB29Y9RsKVi+c8nLuWvqu98Lcx5ULCfAub33IScn+sTvH0YpAmXqxH/1eWMnxV2xrTd88d71L2o/Zays31WYRC9XhoU0h4Il5z4zra3F03zfIAhNr6xgOVjBJtOABsjQeR8jJZO+qyv+7zOth+ttDTSNuThRpO2e+hSDOrbmlk1JSr51DXth+gDR2iCdkL7i9YkB5aeey8iG8bQkXbJVfJDo57960TC2r3KpDXqeVFKyXYjx+idPbEwE2vgRqvFWhMVYeM5DG97eojxV2UEByN9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:33:21.1320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec00f0b-2e09-438e-0b13-08df3b5a814a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH5PEPF00000030.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774

From: Akshay Jindal <Akshay.Jindal@amd.com>

init_memory_definitions() walks every top-level subtable including the
IVHD blocks (type 0x10/0x11/0x40) in the IVRS ACPI table. It interprets
each one as a 'struct ivmd_header', solely on m->flags, without first
checking that the subtable's type actually is one of the IVMD types
(ACPI_IVMD_TYPE, ACPI_IVMD_TYPE_ALL, ACPI_IVMD_TYPE_RANGE).

    if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
            init_unity_map_range(m, table);

IVMD_FLAG_UNITY_MAP (0x01) occupies the same bit position as the IVHD
flags field's HtTunEn bit. Unlike real hardware, QEMU's AMD IOMMU
emulation sets HtTunEn unconditionally (flags=0xD1 for type 0x10,
0x11 for type 0x11), so every QEMU-emitted IVHD block is misidentified
as a unity-map/exclusion-range IVMD entry, which subsequently results
in the creation of a bogus pci segment. Eg:

    AMD-Vi: PCI segment : 0x4000, last bdf : 0x0000

Fix by checking the subtable's type before treating it as IVMD.

Fixes: be2a022c0dd0 ("x86, AMD IOMMU: add functions to parse IOMMU memory mapping requirements for devices")
Cc: stable@vger.kernel.org
Signed-off-by: Akshay Jindal <Akshay.Jindal@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 78c7079dec9d..3dd4ff145e55 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2776,6 +2776,15 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 	return 0;
 }
 
+static bool ivrs_block_type_ivmd(u8 type)
+{
+	if (type == ACPI_IVMD_TYPE ||
+	    type == ACPI_IVMD_TYPE_ALL ||
+	    type == ACPI_IVMD_TYPE_RANGE)
+		return true;
+	return false;
+}
+
 /* iterates over all memory definitions we find in the ACPI table */
 static int __init init_memory_definitions(struct acpi_table_header *table)
 {
@@ -2787,10 +2796,11 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 
 	while (p < end) {
 		m = (struct ivmd_header *)p;
+		p += m->length;
+		if (!ivrs_block_type_ivmd(m->type))
+			continue;
 		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
 			init_unity_map_range(m, table);
-
-		p += m->length;
 	}
 
 	return 0;
-- 
2.31.1

