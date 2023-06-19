Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0C8BE5
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 13:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIwFO6LmipJgNNYjMUqqHyr9DwX22BGHFqzm3ZlCjiklLnZTUBlmf/PxTj4ubdQhJ7QCQR/aKd9dgeEln4raLPnpdhJj4o2dh7zgo7koQaXcooSR+IlUEGW8ij6KS9fznIpIzfG8iJPq4sKzaNEt1+1JrcJaBwRbMmxkRW57CiUBULUWG2PHryT0LiQMDwIyCpRIMBqWCk7SNrxyTU2Pb7UJWtcleOvf9hMRVJTQSrFUL9NDbFFkVn1wH5Wl5KpN5laLaueG+8fsFwSj/TlFx+jIVHnAmttp1ZlBolUL5Nx92YMxinkzBXlRXBUQcMWm4/92gxyqEMcmmThMJv6e/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Gc5FvnkAVcXn/LA6VYjYewfzLSJDahHT89Jz+KiXkY=;
 b=ms7TH6+WVm7+lQq78+3CXbXIWlRzoYZRZ3c3xpVbeExTPNvH/01ij1FfmDtrle4sR+sA3N4/YENx0zs9WGg5gajH/FWX5/3ehmWRVBJHHk9tbIu8kAKE/yf7YES+lLcts/6yNYHvYI0HLtI0Mj3pYGI2EKzZHmv+nv+z3TldjjscEM8pVNzJowcayBaI9jZvG5sMRw1wkohyflEijBIJWSYg/34kjVGNbm3pBDv2UjQNI6ltaa0dzV/TkEQl0Mi6R5YrquAOn73g6uO+ghgfK60RXnHhtiKKvUNs/1oxwgUsObdZb6mOR0CWfihnDGk1krvhQVlm0oBIT5R6FdNbPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Gc5FvnkAVcXn/LA6VYjYewfzLSJDahHT89Jz+KiXkY=;
 b=irkMhkvoTRwCg+LqBSQPVJUBgvIcRM6ZX1f1bkWYWz3v/Grw2mNvCtCDXjiAkrapssSFPVCriLEVHHO26Pt0dAKnFOihg+ooywsDxpH5MVOdVCZOJK5gl6XdrqtrMgwDAnZ5G81fvDbuS5pEVtAhS02VevpTt3jYs7WlAPhjoSA=
Received: from CY8PR12CA0008.namprd12.prod.outlook.com (2603:10b6:930:4e::12)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 13:19:26 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:4e:cafe::1a) by CY8PR12CA0008.outlook.office365.com
 (2603:10b6:930:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 13:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Mon, 19 Jun 2023 13:19:26 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 08:19:23 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH trivial] iommu/amd: Rearrange DTE bit definations
Date: Mon, 19 Jun 2023 13:19:08 +0000
Message-ID: <20230619131908.5887-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 742e222f-6d3d-423a-bac5-08db70c7ce75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OO+UdworPOiF8IlBJqMUaaJDpo73XTq7c2bI8CNsnxTWhsZ1fCDQxmo+1AmY5t+5OWrckXOOyyzrJx4S//Xgb9Rt6T2FtGL/EYqu6Ifl3MuctWFHRRvirVbI86gc8whKNbkci/X5/Of5dw2PEiaAeEcNAhro/zGV5bNT76Frr12gII+CEg1YWQmXnIkvv49pphP4TjBIahFFMm/LhGnhF+OiVE2NIi/8SX071CHQyYZQdQWFPLpK7M19fzYix7pGE13dDdwZGx2Ir57YNgV1o3hZTEtZMV7BAcTgbMxcvYo6R3tzZR+pHD+GPAjy0WAwNX4GWHmywWBKFes3Em4gpZxRuBjSKHet040vY49ZnZjEez2bKnfCWbWDSr41BKjObI7Ug87h+M74BbjpBDeouQfyK5ic3xvhzUOklJSw2AuSD1QMshBIMrn+29nYhLgGgzlp5LKdF58vWomz1QL+oc15W/u5XcAVKp996uEe5yKC8m5L1xqUi36iJpFFBqWIZzCgND1jRtIbiYvlCny+Df+tPaKxFrrwaXBJpOsbK7A80LcNyu1BL69dyeHx0/ReMwEBGSYG5Gydu9rYoFpp56be1jcN6bxuVTjwdr0KOcax4UfZOtvU4NYYVXm8T0e3CqXFfDEa2vfjUXseP/OvbI1EGKD+HRFn5LxxAKecb8VMCGlgK34HMuZpD9X8l7/puakIdhlFoJ8av6UJw68d1rEfbk0zOMOwBcjY/85aOqpdiuTRfVW1ITDhCdf9WgtZ1m6vnbN602AqCr2N4XSoaw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(8936002)(70206006)(8676002)(70586007)(1076003)(16526019)(26005)(186003)(36756003)(83380400001)(41300700001)(5660300002)(82740400003)(4326008)(44832011)(316002)(36860700001)(54906003)(40460700003)(7696005)(81166007)(2616005)(356005)(6666004)(40480700001)(478600001)(2906002)(86362001)(336012)(110136005)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 13:19:26.6744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 742e222f-6d3d-423a-bac5-08db70c7ce75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015

Rearrage according to 64bit word they are in.

Note that I have not rearranged gcr3 related macros even though
they belong to different 64bit word as its easy to read it in
current format.

No functional changes intended.

Suggested-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 53443d6f7b13..082c57b8c2d6 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -381,15 +381,15 @@
  */
 #define DTE_FLAG_V	BIT_ULL(0)
 #define DTE_FLAG_TV	BIT_ULL(1)
+#define DTE_FLAG_GIOV	BIT_ULL(54)
+#define DTE_FLAG_GV	BIT_ULL(55)
+#define DTE_GLX_SHIFT	(56)
+#define DTE_GLX_MASK	(3)
 #define DTE_FLAG_IR	BIT_ULL(61)
 #define DTE_FLAG_IW	BIT_ULL(62)
 
 #define DTE_FLAG_IOTLB	BIT_ULL(32)
-#define DTE_FLAG_GIOV	BIT_ULL(54)
-#define DTE_FLAG_GV	BIT_ULL(55)
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
-#define DTE_GLX_SHIFT	(56)
-#define DTE_GLX_MASK	(3)
 #define DEV_DOMID_MASK	0xffffULL
 
 #define DTE_GCR3_VAL_A(x)	(((x) >> 12) & 0x00007ULL)
-- 
2.31.1

