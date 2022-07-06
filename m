Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641B33C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCuTukG+ICT0ueBdGT+1x3gqgfdm12Hy5xahyIFRA7tnJDCeSBxEfw6W+hlOgLqiGyquVtNhLlHn2F+rm5s4HhpmD/Pl5tKen0i7QGnLZo9nSHYq0PfQDZbXJcJsom16saNr9I9ud6cvhLWNIZA91J6h0JN2+F/rYozYoKys9gY8i+Ncw3nefMw5mh5rX0KRh5XRyIJCFMWvX6f5vPTPLa/7w19rUPhjI6cop3K4DCClqBUakCrKd/TFXHlFHucIvUdAbdjQ1dih5JK0BaPQ9fuFGpnE2np+Yt2KVbNpYzqLAa+23VEL9D7afxU1qJMm/GZ5D1qi1hEIpveyw/7JCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWbDQhscbhqucrlrRvrRn/KC5qGcMJNFOSNDAcpHWI0=;
 b=ahGRRjvOMoEexHyxWaa9Qt1jlMm/hIKsw2fwxCm5EGIziS9PsvwySWNHueh0K2EfH7pJkAfKHR6GNOdcq99chWIhsr/7Tyldzg4xCDZ6MPPMeCyfVHrnCmTzBet/yxz1qU8Px4QPGtQPV5vem0MXqiYbTy7h6vlwM3twGHLZyudsiENKimQo8bt7Hvuk4yRVGDZwI5Y4ET2X4/pu2UQP3t5z8Oekov0OgAdIrVCfzus0lqpiSRCqByF60NCAttApfk7cRS54GDOb1d3aZRarHx9taKdT8LbCVyfEOkURZ55G2Wk3PWgmCvBmLtQ//5wTdcCfQ+My4LmEG0pLPPad+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWbDQhscbhqucrlrRvrRn/KC5qGcMJNFOSNDAcpHWI0=;
 b=FtRxg2Kogtd6Vt4YcuW63blmdiyfXK4087pvTvjWwmYjqJheDTecgwfnZfcj3l3t3X7mw4PTZbNwjJM791J3yvUfMsjKNgpYkFF1nDLeKNdAu1xYmCHQKLZND2b2ukgoHKkkKK6YUOwqXLTvVX+eHyEBeKsKo7/aQW1UsqeGb1c=
Received: from MW4PR04CA0111.namprd04.prod.outlook.com (2603:10b6:303:83::26)
 by CH2PR12MB5562.namprd12.prod.outlook.com (2603:10b6:610:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 11:48:03 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::d9) by MW4PR04CA0111.outlook.office365.com
 (2603:10b6:303:83::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Wed, 6 Jul 2022 11:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:48:03 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:48:00 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 22/35] iommu/amd: Update iommu_ignore_device
Date: Wed, 6 Jul 2022 17:08:12 +0530
Message-ID: <20220706113825.25582-23-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 397570e3-a2c7-4491-5daa-08da5f456247
X-MS-TrafficTypeDiagnostic: CH2PR12MB5562:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FRWEOxb2L5gkol9ZUaX0z1hwOAV+eDo9imQMmTJSA8XW6242+6BOVZqxq94j4rM5EXNZzuDfZVIp8+WySEzQCIQuSFNJ/GZ3zxBHvRvdWHojbzkQdN8HdVA5KIrSnyozAFkpKCHATDN/S360MGpoTmkB4XSMVuNgHUwQcl2v2yFGgCsPAA0ZofqYryto8IRyLxog3TOuxDo3Ornua1efmWBzgpQjHl02CU+qTZkW8Cz0nmaQUgPF9F4ME0ESpe1pJtWIwk3hy1YLa69fgnsHRIv7iLBCYz3AH1wzduxg3+mjlCfuPCADmm3o/XucaTlnufL6H1fcUwb0X4S49C/s+Yl4zwfs6JRK008IHc1ITQncPXarHRWMytradHQBeym5L4Wu+G/z70tG2oMHTLShI9iAQ0VdILEVswMlWawfrKWlmUjFTM+z3XTzjU8iq5SmKbdm4qIsu9VoHHncBDZQGOHqWf17OEiyhdoLd5P6LBHlC+KZEvfZp6lESdsdtGkRO+6JEZf1r+gaulCDmU7VzXodg9nSob2oHiJEF8BsOCK6HGHC4L06VTDfJTPUc1MELFonA/8Rv2DLQJA6rbuKSKS4zhTjkKdfZK3Hsx1BXRkdN4SDgw/XsNblOmB/tMpyhI+vvu1V8ATo/0Rb81ovRpMZHZpYyz4dB+M3LzkDZpb0RuwPFgVKlecM1LKTtaOrANbQGO2uUVuV459m+vWaJn43A7oJVqSyP8qW73LQ6ELFXNfYOGHmdZehUy7Cy7W6lShW27yE+4aJm+eObk4RGjZwVJpUD9yI0GTvInNVtNwe0U/2bATgXN8RzRo1/F0+gLN6OoznY0X5zZiQJSathoci0O4KNHm24FAqVGsN6D4wsT3WX+gZbCfRFPhLMSr6
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(478600001)(86362001)(2906002)(82310400005)(356005)(316002)(4326008)(8676002)(70206006)(70586007)(82740400003)(81166007)(40460700003)(40480700001)(36860700001)(44832011)(34020700004)(54906003)(5660300002)(8936002)(110136005)(1076003)(26005)(2616005)(41300700001)(336012)(426003)(7696005)(186003)(47076005)(83380400001)(16526019)(6666004)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:48:03.0697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 397570e3-a2c7-4491-5daa-08da5f456247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5562
Message-ID: <20220706113812.anZnlpB40M4d3B6nDwfO2IT6Tuod2New3XvMO5opANQ@z>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Start using per PCI segment device table instead of global
device table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 493cda5e0246..90755da7cff0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -413,15 +413,15 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 {
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	int devid;
 
-	devid = get_device_id(dev);
+	devid = (get_device_id(dev)) & 0xffff;
 	if (devid < 0)
 		return;
 
-
 	pci_seg->rlookup_table[devid] = NULL;
-	memset(&amd_iommu_dev_table[devid], 0, sizeof(struct dev_table_entry));
+	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
 
 	setup_aliases(iommu, dev);
 }
-- 
2.31.1

