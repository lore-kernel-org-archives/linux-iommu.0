Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793852619;
	b=EaZVG5NtzvBteQLmLaBylLEVDSr1n4C5eGT3LMkOox6hyj0fIUT+d0tKwBYYpbCwfNvV
	 kGHpBuW2vKs0m3JRz+MxEVvLXaPVtHTsxZneR//QSCEF/v/Wf8hAGHNmAOGNSfe51OMmD
	 SXW7edNU2997HSwInJ+hiPQvy/VC1bKCwEOj+7aVyS5rJM11h9fmiVtk36nI5T00fjPll
	 mSADXuYMVtCssmLrOwKONa3jlPET9aLuezwJ32IWhaOyQlCIaK21609stg64CQm98oCet
	 lbhleRa/mcIkQ/xN+vY6T0Qcc+w3RihlEGyJ+akFyZo7X5ZkqPntlLOdpbvHjFhEngA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852619;
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
	bh=hmPT4edh7m84IGmZcjiwPayedeB+EwabTHREj2xtVtM=;
	b=cfijku2shGrkL4+nZA96O2QrTP3a/xfWhqiXtvVOyHVHRPyR09U0TlV50pueFt/uqkzD
	 0xS2R6Q8Jmz697bn6XKJCAxwTQasCCib8gvA3bcUNDggpMsS1EnyRMTnpyIStBFh7orH7
	 pbpKdFleMKdZtgTteTYPHmmJXmLXZAGwtX17M3Xvl1SAXiFqlrpXaT9oSzRTW3S1KJu4D
	 fMY3nWqADL1UT4qcP7uMy+Fo6cXYsgMoV0/NtEhbH1fnvWlvDWH1KrZBKgZ76RLhqSBDW
	 bt6waaJlM8NdZ/C1bJnZ1XY3xeJnDlbNCdE3xagTun8EtNWr/FHN0P5/R4NLgj6DqEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rjKqylBi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.0
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F925606A328
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F925606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rjKqylBi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZf4njyGP1tJmehgPq72yF6vcEkJRMr6WfpEmlQqIGQ5Wse5yo0eoXp9WRYm6wRQk5oxVDCWNC65BDQDsGZPq2jlxwZpXOI5o9T0YTmjJgeFs7OFcizWNM3Rc0M5C6OG8mexS23dQx1AOIxNsV2KRvz3OtnS1tIRpwXAEELKjeNWUMyE8bv3rH6C5LpuHkcVUYsZZ5SQJEMX0+tIW4EeKgKcrOetLf+q9Ikbx5RwsU46/GeFJnaQrWykW6B6eX0oEqeMrZSgsfGV8ONil+OV4ZdS4/QVqxO3cxy99z+Ub0dH+9AuiRCvqO2loPATMGNXOjHKEQ/zFTTPUujBHk0HLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmPT4edh7m84IGmZcjiwPayedeB+EwabTHREj2xtVtM=;
 b=vBn1QE+ycWm6zMp471uXvkUh3dIlSajvnIZ3fo35IbiFH1yO98LZBm4U0MFWXyXGwVeIEwvVDQG2kt0bdPctLITeYX7nXL0NedygbxZ44d3Gd8Bor4+M01SUWfHQyY/PY+8C2xHtYGPf43/1AE//FuB4tzf5dAXeSidrktAHBmSzXl+DPnNRZzyhufyEThYNGSWXOBRNo0EUVrwRm/llOUU24jy5gaanayMDvL4Jm7+1oinMHzJDUDDuF1O/RirGNUFsydnOQy+6RT2/jcVs7VsZvmFBiJeXD1wlM5pPL2u7KAJqmsnYRdnnuSFTvt94Y9eHpyafPDgrttxDehqtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmPT4edh7m84IGmZcjiwPayedeB+EwabTHREj2xtVtM=;
 b=rjKqylBiEousGxMD3NRTE5A9nW/QCd156zrVwe4TdZUl1o3Zis3W5br1sNchjZKPy1NiUAnkISkoJWBvepsWOSnuLMFBiZreYHaUDFgF85rriEPPn0KmXucMkD7tKNcJWKyJrv8c5PcpD8EOYFOHvx9ZBuKyI7twnbUHbQssl94=
Received: from BN9PR03CA0654.namprd03.prod.outlook.com (2603:10b6:408:13b::29)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:23:34 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::8b) by BN9PR03CA0654.outlook.office365.com
 (2603:10b6:408:13b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Thu, 5
 Nov 2026 04:23:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 5 Nov 2026 04:23:34 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:23:31 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 1/7] iommu/amd: Drop redundant flushes when the page table top changes
Date: Thu, 5 Nov 2026 04:22:48 +0000
Message-ID: <20261105042254.399163-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105042254.399163-1-vasant.hegde@amd.com>
References: <20261105042254.399163-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b6aedc-c558-4273-a0e8-08df3af48e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261022075727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YyJuTUfEBJWWAf0sxlit1ftOSGUWF1/acqVpAkPt7Q7vI8uzpGVlyKPFX08RjisvDpA+jzQZrHkb+ECuxsrBoN7b/hIhOhGAhPTA/3Ve4vXfmPKXq6FaAbMKA+HgAcTenJdLWnTpERs9HGIDYAiyHZ9/WuAk/jwx4pMrk4DGHDXC/wGuyyf3WvDnKisk06yylOLfJQqSy6Z2SH3RvMQArVQro/fVOoq9o31MynZZLlBydZDqIODdhjKo6rwAz/FLG5+7VjDBE1T7cvxnwTMcupQpEjgGpQkPg6zBng96TElXwzLTcg4XDNVzypE+aP4AMuYsefPHSPREMauhi7ScGrWyvonMm842R4d9dhpCFB11OmjWwz05VsJRP3XrWa9KtdbO7OmPSVcD0aZYaNcIcwEABpH6/EPGDJt7gugh3Wff6ZCcRlL9BxydiwXSKArWcFXMy3NfXCqLs752U7yABv6zMsBLNLCXfPYS1rxhAlpkpTvSICgJONPxwewzPBTbPz0LDjlSOFiTpWKcX+JIpiKf3OfilXxNE8oyfNZ5Ijm++axD8oWLAqmoBKLMpQC2quPlZMhJlq9ix0iKvkwBXwrHb9JPInBJHfNEFFYYP6f2vp3wKPPn3HJvsBJHUlUVlRxyYD3dJzoPsSse1eBPKsKwkeScMjcLC/pxcD4iL5CgCUeY5Xl7FMWlKTuheJ2+Urj/oI6WKJQmAeI3XbMU2Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261022075727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GJEPYtd/xLJ8Nlx0XAQvSO37ZJacnlJNCnAHKqNsOWP2OJJS5FSVBUcCe+Gv2y8QVAk+zGLhcOH5MIyjO5GNpw7WZzbMeAI4RVb+4j0vLPrDh586Yr6NhlhhFR6JppxY+vihktN4dEI1CYfas9WIE7MCo6xW1rDoQEj/+86JvLyS/V2fh7qzivMWbfZh9qce+J5qL95oLEf8Qayj3rT+x5Ovi4Khm4F0gN1NvHAXriY1urD9BKwCQWpenDvHbpsloZTqIVJdSvDcvg4EVXQYhdMkx8Ods10LZkvBJUhsVF8TYFlve4QmLKYajItsjB8xtBY59xYQBzVMUy7VUBxqKh8IOh6LkyXA2LQdW9mlGJQaH5kUSQggFNdwErXHBCtApe3FxX+nUhFnCRpNTegV0VFJDsxTuo7u+gyYzKdxuzib3ynBjNIoyLlPb71gIGJC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:23:34.2758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b6aedc-c558-4273-a0e8-08df3af48e44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579

amd_iommu_change_top() updates each device's DTE via set_dte_entry(),
which already clones the aliases, flushes the DTE and device IOTLB, and
waits for completion. Hence remove redundant clone_aliases and dte flush
from amd_iommu_change_top().

Assisted-by: Cursor
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ea735ad46881..453a7a07621c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2829,19 +2829,16 @@ static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 
 	lockdep_assert_held(&pdom->lock);
 
-	/* Update the DTE for all devices attached to this domain */
+	/*
+	 * Update the DTE for all devices attached to this domain. This also
+	 * updates the aliases and flushes the DTEs.
+	 */
 	list_for_each_entry(dev_data, &pdom->dev_list, list) {
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+		struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
 		/* Update the HW references with the new level and top ptr */
 		set_dte_entry(iommu, dev_data, top_paddr, top_level);
-		clone_aliases(iommu, dev_data->dev);
 	}
-
-	list_for_each_entry(dev_data, &pdom->dev_list, list)
-		device_flush_dte(dev_data);
-
-	domain_flush_complete(pdom);
 }
 
 /*
-- 
2.31.1

