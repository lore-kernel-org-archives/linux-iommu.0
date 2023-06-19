Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4261AD3C
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 13:24:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF785lInfRiSQd96x4F5FT6hb7YkCHjg9tAfLiRRnt96PIZ161gAqwKpTTzF1VjDfJEYBzw8D6wbJyHVvsUzSfcJ+9T0d4fiYmZPvlssQczbKfJ6mc32WAtqlmuuby1VDKth5s1btxvmBevk/JZqsUdTab4PmycPF3wB6JuIIuxEbEmJApFb7V4xLa+b81dEl03oc77GdSEPddpzUJIGEHgffo9qBiqCTuPsF5bb8bTPScB4syvbc//DkvEIc6BIs8PPsIjVl8Qt9gGXo+7EZY6lebOqI3gdMDbDISzmJz3fsHOVuIeySELGR7NQumNi0O8OjAj9Q4TU22E9ootOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+kfgjboLravQyJHE6qHvJX//3VavtL/vTWWhh7x9kI=;
 b=jxgo8TNh+bDVctsCSJlcSwd0u98iisSaWupHc/R1ba1D9ngvvowFtMXBKebiR1oJIZdTPB7f6Aqgwz+onBjQqBbDU8uU+2XCxZMaXAicGFmac8yx6uXB77Nv/cXHw2RkpgOvQAD+toQt82uIHGpCJXc+TNKJzel/735d8P5PzbmDIKYJYrdtIUsb/gd9IXxHyI264KC0sgHaHsl7orpovo3zKDiY98R9c/JC/0Tv8Q6T6rHXQAK1g2A7ZeMXSZtdgGbLgx9StlKe2pdNWChADAaAHHZJaWjvnEmNRcQLCCD2qiGCr6L3j6u7H6oWRp3hrZWrjG0J6y4e1AuRU+uo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+kfgjboLravQyJHE6qHvJX//3VavtL/vTWWhh7x9kI=;
 b=k8Ba16tMLjT9SJSUPTMN6rBLj3CuliOaSlM2uC4hUbfIMij1C1VpCBAtDJhQWp4Yt50vGSRdSzKQGJAuVcJlwRvToeQZ7xJlLp8t4Y042AzkLrdBWRSvFAlWox5q6TqZCbOr9roy7QCDgP5fKGIOoRkuMoEALPVaVUvmPI7xlcY=
Received: from CY5PR15CA0059.namprd15.prod.outlook.com (2603:10b6:930:1b::28)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 13:23:59 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:1b:cafe::35) by CY5PR15CA0059.outlook.office365.com
 (2603:10b6:930:1b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 13:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Mon, 19 Jun 2023 13:23:58 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 08:23:56 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 0/2] iommu/amd: Add PPR overflow support
Date: Mon, 19 Jun 2023 13:23:44 +0000
Message-ID: <20230619132346.6021-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 490edc90-3b53-4f17-245c-08db70c87093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hAcsEp8lt0q2H6YpkWVY0manADgQHATMnfTJ+/gnb5XAly5qpDiQmPrIoJ0h0svJelTD55/b8XK004Xs3YkD/ej5ehtyuugy8JtUlOiLuLeELboCkzVQS+laDeisUG01MAgAkWnqi2bTwO+inoaNXhlFoub7u94Fq23CdUwn9Q55Od8v4+fDL2eDHPwFYpbZhMtxNO/3UHIhmnI9kY0YMQ+N8UnEHEqAxFxB3wAcPaL5A71YZPdfwI8W8mek8PJwbEDddVzu0DHlaxBEev6Vfhqoc2jdLJqXjGdhuSY/CfD8wQyhM3DFuFinjuq1z6y3YCC7HfhcRP20OgA15AzdNHPG0Z8iQEikb1O8V3qCnYuhQtxHw8baGQyWjE0mnF2EsLfxsogxDCEPcbUM8LxCPmMDqkWvJ89oR/ZuoTpB8YQy81jqSBTunkaqnAuAwFGRHiiOkRHywMEgli5avPusfk3ICJHSFfizreJzT7ESteDrHBGMZJau7ch19dkhWons/DUxmtBSd+fDGN6lwPU8N+TWN6pq9OedU0lGFNOrIJSTB1T97+n7iJ+nEV2dED5ZUvqyjz4OVLDT2qulekJL0SV0PWd2+Ivz1qGL4YiiJoxcSVvg8tXkhncBsO9oIWC4nB9gItOGTtyxEFAEiEWFM13MMT3p3aWwmXarD9SnQAi3eVDcOIMEdpkqIOM528Yw0c6JJG4onS/h44Rr5DG+UqG8ojybY8advzMbp7kYGUSeTxXFnjmgQyyZ9a7TFqwakI6v5drA5fds0KfsJwWCWg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(4744005)(2906002)(40460700003)(41300700001)(5660300002)(44832011)(8676002)(8936002)(82310400005)(36756003)(40480700001)(86362001)(478600001)(26005)(1076003)(186003)(110136005)(54906003)(16526019)(7696005)(6666004)(966005)(81166007)(70586007)(70206006)(36860700001)(47076005)(356005)(4326008)(316002)(426003)(336012)(2616005)(82740400003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 13:23:58.6424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 490edc90-3b53-4f17-245c-08db70c87093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500

Current IOMMU driver is lacking PPR log overflow handling. Add logic to
restart PPR log after an overflow has occurred.

Patches applies on top of iommu/next branch (commit a7a334076dd).

Changes from v1 -> v2:
  - Updated patch description
  - Added Review-by

v1: https://lore.kernel.org/linux-iommu/20230609101746.6412-1-vasant.hegde@amd.com/

Vasant Hegde (2):
  iommu/amd: Generalize log overflow handling
  iommu/amd: Handle PPR log overflow

 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  5 ++-
 drivers/iommu/amd/init.c            | 60 ++++++++++++++++++++---------
 drivers/iommu/amd/iommu.c           | 13 +++++--
 4 files changed, 57 insertions(+), 22 deletions(-)

-- 
2.31.1

