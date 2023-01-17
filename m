Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294C1105
	for <iommu@lists.linux.dev>; Tue, 17 Jan 2023 04:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKVrGmqlEA4F4IMJSUVKbMUqc99WcwlLvR6ovioCPr+CGo4om+4DyrDeMYHJwEME1c7yFQKLmkjGbsI/YKHoDo1QdGncX3o0uiOgUtJuRRI09B0La0pZkdAmC624oys2xBsWdIL6n47aRadxooOyOVBixNcI3zS8CZ9IyngAUOli6zSGy5ZRrPlCcZPYE56ARRSq1Emg7njIXKv1LZeltlwQavIQyg5nWcmqb6qd7rkQ0QS2kMCX3SwWHJUDE+P+PctNrLMlijZJkZ1C6yLSrxfZI7ySka4kmNMztnErB+VtYERXpg2PudTKr9BJTzR8DNXNO/4qvozCnNwgGOOsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ke9woQTtV75vbjB2mRe2gmW6d4lvReZjmZ1GvtMhBs=;
 b=KsBMISab/4dRiV4zMgE373Nvo9Y6IoFeol9FmC8oCIY7rWM1kuQkpGeMfB1669ly0S2ahAAJNbaK2/HvmeJbZjJVfmjK9Tf1bcA50HyJ7F0hwoNgh2Kpt3Hsm0TIV81CejVjUdjv7CMiHqiNGEynOS34+uY/VL68Ektsg/lIchLmXuHXjz5mDOA/UGtJsxHkNSpnSFCbs9W5K60cEy8Tyb36CnhWI2tSbIFB9/F1brGCkbIwAXYsDQQ5ClqrO8tqKer+9EvO72v/0+i90/Q9wLfnvDxfB6AYPtDKN8snlCe9QpEdZrTBrnJhLCD1Ff6p8/xFETrJea+SuzTFdGecSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ke9woQTtV75vbjB2mRe2gmW6d4lvReZjmZ1GvtMhBs=;
 b=w9Zng8lxiZTu/bjw/xCqSiYVHAk90L1CLwURLtfO82BMpSHJoHRI/AAoDBfIBTi31n4uUsXLcZQnNCA/Qmeu/FaP9MnK1tibbywPMqcDDWmNmUXDj83Obe88roctNA0zb9+92LWfMH808poTYAEFs/TULZ8i8lodrwyJwDzi0Jk=
Received: from BN0PR04CA0184.namprd04.prod.outlook.com (2603:10b6:408:e9::9)
 by CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 04:41:02 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::18) by BN0PR04CA0184.outlook.office365.com
 (2603:10b6:408:e9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Tue, 17 Jan 2023 04:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Tue, 17 Jan 2023 04:41:01 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 22:40:57 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2] iommu/amd: Do not clear event/ppr log buffer when snp is enabled
Date: Tue, 17 Jan 2023 04:40:38 +0000
Message-ID: <20230117044038.5728-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT035:EE_|CO6PR12MB5441:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f315d11-287c-4f52-2760-08daf845092e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y2PRLJvObLDuBpGfR6H5r+Dd5V9VUT74XicMZEp5jWd5BC8V+hFiXrotXGoBM84oT16uI+XWObHJQhJVvsTK2x49MO5+T3XtviMyx3mhTo9xpFzZwf9jQNrZ+vs7fXMVavV+5U9Fg2JijXpc2A0JufiZf2xkM7B4c/xGIr15cUVTp3+pCIrJnbiAwCtdxk3Dspovr8yacCkE8C62xuv0BX8k5ukk+biwQxhqz2TPEHCXqxTnb5kWmfVVDiaIcYcgP9FPNYi5qr5CiiQivNafT5iWTzUybjbdsIH6rNl5d1ksqHE84nKa9VeQrG7IisudAUQdPP6R1Abm4z06gjJexjAMVm9G7URRj23Vjx6EHf33rrBxiW3ns92XZpDHHlLoVrSUPAXtd3ToQ9Z5FkC/FlJoxMVqC7z+P2mS4HWvasXzTBhbBqJMKkptH1hq3AIqpYDoAqbVJgIz1cCinpQljninrOL5a3vCZdkwGDcujF6VdmUbC6vFwIktq4E7CBPaAMJ7soyWY1uoABWg6sMYARgNwhoPTr6x/7MWzjKKTt3k00PvRSBqH9BzBkRQb6zqLi6rLzcCq+9uCg3dtIp+X9YHlPZsPNCJmUy0JcyoGycprmcL1By0g+arUzpzqY+6JwnZ/RKQWSZKT9dQl6wNVByt1vGcYJPe/poUVP45Zgy8KPtxVGb499TUExVVAvGzN+GniWQvfbOZnv3BE8wkfywA/HKC4NHJX39OjBzdj0tsWQUAiA/cHhL7aIuGBmmxbas3zBLL9faNRbJ/EvVEqDqnxTpHsQc8SNyA3d9XvTHfLFsV9mrXYIwNmjLmwvKi
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(40480700001)(40460700003)(7696005)(478600001)(966005)(110136005)(54906003)(16526019)(26005)(44832011)(6666004)(2906002)(41300700001)(8676002)(8936002)(5660300002)(316002)(70206006)(70586007)(4326008)(36860700001)(356005)(81166007)(2616005)(1076003)(86362001)(82740400003)(336012)(47076005)(426003)(186003)(82310400005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 04:41:01.6329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f315d11-287c-4f52-2760-08daf845092e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441

From: Tom Lendacky <thomas.lendacky@amd.com>

Current code clears event log and ppr log entry after processing it due
to hardware errata ([1]  erratum #732, #733). We do not have hardware
issue on SNP enabled system.

When SNP is enabled, the event logs, PPR log and completion wait buffer
are read-only to the host (see SNP FW ABI spec [2]). Clearing those entry
will result in a kernel #PF for an RMP violation. Hence do not clear
event and ppr log entry after processing it.

[1] http://developer.amd.com/wordpress/media/2012/10/48931_15h_Mod_10h-1Fh_Rev_Guide.pdf
[2] https://www.amd.com/system/files/TechDocs/56860.pdf

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
Changes in v2:
  - As suggested by Joerg, expanded comment to cover SNP enabled system.

-Vasant

 drivers/iommu/amd/iommu.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cbeaab55c0db..367e583ef29e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -667,7 +667,14 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 			event[0], event[1], event[2], event[3]);
 	}
 
-	memset(__evt, 0, 4 * sizeof(u32));
+	/*
+	 * To detect the hardware errata 732 we need to clear the
+	 * entry back to zero. This issue does not exist on SNP
+	 * enabled system. Also this buffer is not writeable on
+	 * SNP enabled system.
+	 */
+	if (!amd_iommu_snp_en)
+		memset(__evt, 0, 4 * sizeof(u32));
 }
 
 static void iommu_poll_events(struct amd_iommu *iommu)
@@ -736,10 +743,13 @@ static void iommu_poll_ppr_log(struct amd_iommu *iommu)
 		entry[1] = raw[1];
 
 		/*
-		 * To detect the hardware bug we need to clear the entry
-		 * back to zero.
+		 * To detect the hardware errata 733 we need to clear the
+		 * entry back to zero. This issue does not exist on SNP
+		 * enabled system. Also this buffer is not writeable on
+		 * SNP enabled system.
 		 */
-		raw[0] = raw[1] = 0UL;
+		if (!amd_iommu_snp_en)
+			raw[0] = raw[1] = 0UL;
 
 		/* Update head pointer of hardware ring-buffer */
 		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
-- 
2.31.1

