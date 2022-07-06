Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC5133C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNxgGz8R6ofp+u9O7UeU95NBxqHkG/ePojXGeYJB+htvSiO4SG8UNuKGDn5RKZCHWXSibdzYnCpSHkwT/OtEUx/vZ5TXd7IOC6QAor8lS17pWLlyMZ/pSsJKNRWTtvYnbaHL7YsfTH4aN0H79rz+hedZCwqWET/Gk+LXtdxiBxischAsC5iJj5Ta+pxRu38VcNqOAshSQryxwY/gWFh8iuEGJBycUBjYL58NXv//jDmJm6WVB0+s+0rE+4qZBqn+KOxi3UOJcYUhwb6vMIUVxGoDeDFqUnSFggH5Qh/IYc/wkBqr0pbHVjj3/Wtg3tHH+z8xiZcIgEyM8UpQreYlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsvdNv0Kta3kwoabFiWZWd/zPTVFauK5qvkdiYZMc/I=;
 b=Kn6SVqneoug++1wQaSCEJmoFFICDejpbmj080HBF7W2aC0GSfPBZKOaZZBWCz4fFTSaW8lICiK8ybWNEe8WMWRGiaPcBrXw73mqcL0GGNqAq6VaS4lCT0B/nP8EVKwX/1WmrkQUPQow5sGnbVHj/LJij+f0A0VvDG/f1B70JGPj/aoShmkznh1HOfppT2pu/Vzt8IE4kho0PsWTOztkFTe4Rm53IP4QDXUAOuQtitaLVmEjdo6OyNSGtpZpFgKwtI30DYvZcCXUOa8WBH29fD1HCLRk8mj2LYTSFntmao3vfyfQO0nHZa2TBo2Wk768UhaLgQcSxrgwg6ZFLEDNiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsvdNv0Kta3kwoabFiWZWd/zPTVFauK5qvkdiYZMc/I=;
 b=BRI0Z1f9qmT4a7Gid54AZ91WjUjyKYqUTCOh7TejRCWx31Ac5dY+0pKuFvTa+JnSkOMGmJL/5Gvs+VwSJColPzquAQpB7xIlt3WKG8gmU8ycd5OoSEstqmKRwofKQdloflkxK5BQ+0+5kn8b5JVeJRZo+BNJN2qTmQGx3opzIUs=
Received: from CO1PR15CA0092.namprd15.prod.outlook.com (2603:10b6:101:21::12)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 11:49:35 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::f4) by CO1PR15CA0092.outlook.office365.com
 (2603:10b6:101:21::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.22 via Frontend
 Transport; Wed, 6 Jul 2022 11:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:49:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:49:31 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 28/35] iommu/amd: Flush upto last_bdf only
Date: Wed, 6 Jul 2022 17:08:18 +0530
Message-ID: <20220706113825.25582-29-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 92f7a08f-40ae-4405-3e82-08da5f4598dc
X-MS-TrafficTypeDiagnostic: IA1PR12MB6187:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ynA17EhSMGrW9P3bZpv6r8RLGdfxff5gbHLnB5JpvFguAi37GCQps8FdXMj1+uLcIW54iflcluM5rMrB8kdy1pJuzNgkQmgMId9xRwoyHSXdMq2cNRbLbQD80S/VLhC5ermTDIXPz8bzt/SOYZwLrn540y56SxKdXLIzIam/WZnrLEq/w275LhQYhbszHvZoef4obpDr96MuAa/aZk4Lqxq37/IeATOCAR5WgoMG77WADNYfm6zsL3rvmYOBSVoXYgzkoylBw3iFIMeORkicC8GzcvApqP/aj14G1ECENjTNVtScdGCxdtuqJhKka+biZ3jcwnYoq+sxKBRjhMfDkU7g2wbxl2R6hBzromY1Pzpg0up+mKD2y6hDABPkSys0QqIy/8BU7kBP1t1po2gA8BL3h5AYw28aoeMv8tYxjwD4gE+PyGL/ercRzuoqeGUwor0oQON3zykZOfk2LCxeH8MhS5/eEk/BOWvpk7PENdrDR44DunsEsfMBcKG048m6I+S7MNSwH4rkbQ0xOLR5R9bemR9H3NgDAqjiwS+aYzpAd4It4XYT3mQMxKbsgu/CeAXutT6GC7E+SlMPQ41y+/i450E0vAiGNl7tr88B3zBQw517tlEI8lE/o8fag5BC0NR4lUUFzyQHzTvFeVM+2foyz8gNsMm+NDXuWQ2Fn38uzVBcb5v/CROjnhAP8vTS5u9GjYuyqtlM4TH3tjm66kYE8mA6WpGBD/ecy3AuKj4loNggE26E5zs4ovU7cW2c50q5yB8/IU365C2a3eS1KfnxJS3uQg9PpGl6EMquCanbPaBI9bn/GIISWWHxy+tAh5J4n7UG4dBvK4F7Q6EAqKjWTYjLMsNcDmdxON4rVyZDYjeceDvO9mfekdyPrpJU
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(36840700001)(40470700004)(83380400001)(34020700004)(47076005)(7696005)(36756003)(6666004)(426003)(336012)(478600001)(26005)(186003)(16526019)(1076003)(2616005)(41300700001)(86362001)(54906003)(356005)(82740400003)(81166007)(4326008)(36860700001)(40460700003)(110136005)(316002)(70206006)(70586007)(2906002)(8676002)(44832011)(40480700001)(5660300002)(82310400005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:49:34.6424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f7a08f-40ae-4405-3e82-08da5f4598dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187
Message-ID: <20220706113818.3U1yoNEZ9h37SFJf0b5HtWmCgRi88Ms2GCWZ-SP95-0@z>

Fix amd_iommu_flush_dte_all() and amd_iommu_flush_tlb_all() to flush
upto last_bdf only.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 94ebffe15960..6914911d4fb6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1191,8 +1191,9 @@ static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 {
 	u32 devid;
+	u16 last_bdf = iommu->pci_seg->last_bdf;
 
-	for (devid = 0; devid <= 0xffff; ++devid)
+	for (devid = 0; devid <= last_bdf; ++devid)
 		iommu_flush_dte(iommu, devid);
 
 	iommu_completion_wait(iommu);
@@ -1205,8 +1206,9 @@ static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 {
 	u32 dom_id;
+	u16 last_bdf = iommu->pci_seg->last_bdf;
 
-	for (dom_id = 0; dom_id <= 0xffff; ++dom_id) {
+	for (dom_id = 0; dom_id <= last_bdf; ++dom_id) {
 		struct iommu_cmd cmd;
 		build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
 				      dom_id, 1);
@@ -1249,8 +1251,9 @@ static void iommu_flush_irt(struct amd_iommu *iommu, u16 devid)
 static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 {
 	u32 devid;
+	u16 last_bdf = iommu->pci_seg->last_bdf;
 
-	for (devid = 0; devid <= MAX_DEV_TABLE_ENTRIES; devid++)
+	for (devid = 0; devid <= last_bdf; devid++)
 		iommu_flush_irt(iommu, devid);
 
 	iommu_completion_wait(iommu);
-- 
2.31.1

