Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793852207;
	b=NiuJs3eFQ6s6eJJ6N8qiLYNGl9r+tJDQB3xGO2gWgsVXDtfmuwdNdyaJqKjpCLeSrCZe
	 b8cy2XOg5kL0ZRpQ3+0HPlFa5d27u8toLTAnXp46r5CZARnlGRU5FnCcF7lBDEwYkBuzg
	 kv2QhFT2I5JltshMVFYlQmH02QElCOWk0SSswRga1tT3V0PLGovolB6dhQP2zu6N8ViIp
	 i0XUxoKQlkfrEduE2PpsSkpcOOakNzfz0PLDx8+COsCKi1MB5/yG1CzDg5xj+NKFUQM9E
	 rDUgwfR+YeE2d8FJ6acdxUVy+8iR+RkkFMD8r7CGQ699GGOYQzYLXscz8Y6EkYOTK7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852207;
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
	bh=hwsG1Men5avJOBzvf9t/Nx903qw702uONQ/bFOph1ZY=;
	b=PNo4HG0lJUv5AMcmwTV5jlKq7juZZXs1Bmfj6t9e5rI/RuoTff//zSa2fHWIAkzVES3d
	 5goGs3BopbcOqm9HoErU1DgNcKf8tGvTiEKOho8tCV3Rdbz3lSgcNUSwn1lt2hdOXV4/6
	 LS215o4vwBcr4b92NTDmjVrw6IoZaLYx+ZaLMis0cSI6kuazJ0MKMBixzwdOESxGeULN/
	 0DzNl/r0bs90jxVTF971c2vKTTXfRjVJkFlstlkDEKBmuCeZR/4rm2cc01Ey5Aj7E8vm+
	 i4vQl4f3D37CLcMq9reZCS19t4NIW7LXaENOmxFoqslt0KBVoL6m666VveB1Cmlxw5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WFqnL3tX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.11
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6FC606A32C
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E6FC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WFqnL3tX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pS2ca+j21Ah6u4l7JRctyfjQeiuzZGrchabyIIsRxUmisPJilpqc1rcirnv5I3HzjdRK923e44+IJVSi79lDuWfygD0SXtJ8xW4Wokf+WeC2nwhm6ErYr+hxpT1N1Xd8hq+YXRbyTl2VzvF+TS3qT+q5907Xl6ozlXKYpWN9KtJvxxKTPCuQR+A48W+0G4XVzsAQviU4TGdD02ddWvC1XxcfDpSW8s9wCoUKyinudTtla5SaB4PQ5uR9qFO7sz2rzpiq3S0sQlFWHuWO4BdGI3iYxcxheqA6LOTR493XZO8w38lwSZI6b0Tlk3ftGZc6hjkIUi68a6VppZiFiw799g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwsG1Men5avJOBzvf9t/Nx903qw702uONQ/bFOph1ZY=;
 b=oMHn1X3+kv5wOtq3XuuVjcQ4DZrgipx7g1iZlQXjpfajdk43BiWt5lhMxjvPo9HnZ0tCLvOurNoAtrz/3CDKde2ueEJwY2S/tChDzzQJ1bSf5dHBCD/LsHKcuNwfaqZ/aRd7PUnXfxR13klkdD9+5jvCYYqcU8zUdyxNX/WGVtzLyMeoM5kVMXvFiPweykHlePfjut3izTHzTZaJSOQ/dVPOLjNbdKrOEWh+7hzOsG4dt9WKIChFzTyXuFi/HH0SUidD85Y7FaYEMqtfhWfwLQ22SeDZU2oUweqFjUt2O9BO1cOZ07th4N0rZhwjCuhx667MsiGR+YF3xkfAhsnwOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwsG1Men5avJOBzvf9t/Nx903qw702uONQ/bFOph1ZY=;
 b=WFqnL3tXhXDdquw74RmmwRSHfrOcOapPRzb6rJWXdq8lyrHsFj60mYLVtbbRxFV9UMJiQuE+VZ87em0qb6LRGepsa3NlmMpcAr4DydT/pXIkAicqo72C2Zrp5u6x09AUxjsqv4t+c65AAd36AFnjdBA8CmEBbMp6kSaU8dR/dkk=
Received: from SJ0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:a03:331::35)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 04:16:41 +0000
Received: from SJ1PEPF000037A9.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::48) by SJ0PR03CA0090.outlook.office365.com
 (2603:10b6:a03:331::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Thu, 5
 Nov 2026 04:16:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A9.mail.protection.outlook.com (10.167.244.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:16:41 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:16:38 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 1/4] iommu/amd: Clear the event log entry after reporting an I/O page fault
Date: Thu, 5 Nov 2026 04:16:00 +0000
Message-ID: <20261105041603.399016-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105041603.399016-1-vasant.hegde@amd.com>
References: <20261105041603.399016-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A9:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c69293a-ede7-456f-8b62-08df3af39807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|22082099003|18002099003|56012099006|261021121427099003|11063799006|261021123027099003|261102123227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	7FTe35Bu/85w0j1Qd6/swuXNeNbRFsyXD4h9JlHH8qkXkE55yS2MwEOD9+xY8bl/tyNJUXWyXKNDsdSdsII9MlvpyLTvhaQEeTdEU58wisbrIA+q5FISBhRT0DDG6O/jIQf/fSPCEoem526XRGs0iR0lDq+nb/idGoN+kh1xHhY9sRevsGtR73jX639pk/2V1WxktqVDuGJY4WYhYthLnwfSxsW97FrNnTlHNMXwnkScGnb8feDO/os0Vj2eG4dMgADbrOs2/LD3ZjdU5u+/wyS7Z92MN7PEGMp4ZJJc8dx8tVwhuJ/tyUeWrEVXaZCdd3ct4nft+p5uCBqZukn3YZX8ymQqt9KgaTrCA0kz2VEWXoNuAFhWmlRCnoDa7QKP+fiMruAFMzOIr4ACy6BhCzK8IChX+pZocscqY3b8SgCt1BNAoT6SwhhEExn8TpjZyt77cIrt0kfn0MecTNDxAh/6T/AkHCIsaDo028DjbqKkHaxKBk5t+c1acHLw8RRLPSuz6OoN48d0TSG2A1DSAqDla+35cBakXdCNaM2WC1ZvYMqM6deAy6ufBfhUQEheIhtMjV5ugjhjU7D8R9yOsm+humloiwmp69B+QlY21c8HLAl7JpKAblZ7lxUs2ODKHgrQWytdLqZ5vzpR/lI8KeJfHKZH2y9zaUhhFHnWoin0E+dsFfjhGBrRR3SZD9iM0igrBO+xYM9MgIvWA+jeyA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(261021121427099003)(11063799006)(261021123027099003)(261102123227099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	y7LAVOt6HJMaNuYUB0avuWln7bTAzyquMl3fRmXvHFVLmrYUksCKQxm/n60o9VBC9aP7AYwRm4pnYYL/haAC1OnACeSRB/hflHHdpeWLdg8fiiwSbFyDRCewQhAMj9CbvI+WMI1YeqAOpGD5w6snBARhXGHhqIe1/w69asGDJ7r3eOmX47J2F7BSVnjWrNReFMoFBkef+1YtmVf8CxmIwpWoWtcEscYE5oylQAiPNNLCxe26RHpVCXDwRdBRetzPP5shCyqLsj9vcWId2aQ6R7HAhStFJ6yYyG9tL3jY8sLonA39KYqIHpjbSHST2i2BavMO+Td60topLbgrS07NIW7oNCqn1nmGSksqo/INF808awWvfVe4SrzHQUm9QfhR2BP/wYf5yAFvxB/lbrvvOaAYUzpwBYbGAqwxsm7Qi1fWhzDyf+YAbnZly7b9FZkz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:16:41.1353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c69293a-ede7-456f-8b62-08df3af39807
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976

The I/O page fault path returned early after reporting the fault,
skipping the code that zeroes the slot. Make sure slot is cleared before
returning.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4b57736b7c18..2d475a35c2b7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -927,7 +927,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 
 	if (type == EVENT_TYPE_IO_FAULT) {
 		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
-		return;
+		goto out;
 	}
 
 	switch (type) {
@@ -981,6 +981,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 			event[0], event[1], event[2], event[3]);
 	}
 
+out:
 	/*
 	 * To detect the hardware errata 732 we need to clear the
 	 * entry back to zero. This issue does not exist on SNP
-- 
2.31.1

