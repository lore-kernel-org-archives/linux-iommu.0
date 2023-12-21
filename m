Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DA26BB44
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DkIKQnWx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOpO0HrUnZdzPPaeSc+31k3JMNpbO3K6/kGRj4/ZxtHEoqZjrdhlgDgCHeP5nFb0AaskVJqoFdwH7ubpDErZmLnzqiAs05O1ylPb1BPlJkjagKveszGAEb9RiIFNpzrYA08e4WBRUJDq16V4RlO3tYsXClKm++YWaA7Rj0Q7C2hMBDZs5+vK6gWpP0idJ2UuAZpztmcDGvrrVZ0zhJMgtlFgx51HZCohTwkhvE5AHmRGZ5mIK6TTqWbH4d2kC+hkAvP66loMKg7jBVuWtfK6IH1dxoTmrksYsyNmJ9cuVDpWC8syq9NO1ZSxt1hKsdHtbE8+f4e/IdkKZxqE1JAQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzaDGEwcVmp+uNIB7N3OL9SDJ3hOPqJXDJmtvitFZSs=;
 b=Rgn8/2AypGiESPmNnf9p9yPtQRc1VeaCT2AbKcShnU0iPw6AV6He3CcwtUlfUUxPew4OBVQxK6GR/QmxPYksTNN29QtnoJ1LzgTnAcwVgXBnAWsUByUKbIeXlEphcOOyrayBGM3UhMvmQtgW8QoBmAKeypDFJ6blvdBY4cSQCpbYXFiOsk4+BMrqAmEEWLCdR8bzRdT1+AbzC62mE9aYfJTlqA1m3uSp6Bi1YgO7APibq5LWQm1A6VQL8nYCN4viYCOuQ2r7pMTsWLEV1zDRHXkqy7A02304nRZnhHlOJWkkBwExnNZpARLxbUonRvszj0H26eIFaRibabfAW6UFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzaDGEwcVmp+uNIB7N3OL9SDJ3hOPqJXDJmtvitFZSs=;
 b=DkIKQnWxz9xhB2OFcGfZVtBnL2UL4Ib5QIBFScIQm4fNQvJSQXBr/ryXqW8cMSyV+Kz7cDrAiXWQGxJw9yEyoLRbqac1tipCs8U3XbWOkfq31I2d+1VNjOzeq8PCVlE6w2Q8lYPXS83P2M1UveAPqSk57CeLE2t6+Ny4fU8+184=
Received: from BY5PR17CA0013.namprd17.prod.outlook.com (2603:10b6:a03:1b8::26)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 11:17:51 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::d2) by BY5PR17CA0013.outlook.office365.com
 (2603:10b6:a03:1b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 11:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 11:17:50 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 05:17:38 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v4 05/14] iommu/amd: Fix PPR interrupt processing logic
Date: Thu, 21 Dec 2023 11:15:49 +0000
Message-ID: <20231221111558.64652-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221111558.64652-1-vasant.hegde@amd.com>
References: <20231221111558.64652-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|BL1PR12MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ff7fe5-8e3c-4c04-17fe-08dc02167824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IJxUEIiJPwDMCTYogP4L+Zo4TxOZGBV1sxPl93MpriuSQL5dj1m2mHI0AaBhSJN6rQeak2o2lecRbK7HdgV/WWL8DYodT7ugVDSY0Yx83YJUxK/RjckZ0dxhbpvwTT1sbePYqY3IPHwm9HpsjWyOBMDu+RjWQLjsRiW4RggryTky8NaxOwvdLz7oUnnfyPNpISrS/1Quug8ecfN/BxSq8CpE047pKlQI8PauKxyScrz4YnIF/lhskBQBTcE9di+R86TCz12GHTPNWQRovEHy9CrhsID07M1w7ScJpivcfPIuB9/2ncnnnOnr0wIGX+gYybnQwGuclNDb0/5V+K0ZW1ie99/7PhJGCPUi3V6gxRIy/Eql+cGB0ii6dxxzyT2WAObEFJyF/JAAGHG66/TW9RwkTPnCLRgKv+w4ECFVF6hbDn5XscjQAV3k3z2z2cAsxsFPTLalps2N5XBmHaCYrkC2kUWPjmnKqAP0ZVBQ5xguYTTXLYFfZ6SfsHK4uOXRCc522yYO/vB8gK+ts3KfXg7EhqxAwkAjJ9y20YIW3qKkDjDOV0IwIgfrHiUrR91She+z08wICIixzcCHmAIztp8L33b+O7hHHA7nA6rKp2csnEuMS+qxv5LAYfFBAbQlArs19r2wFNeiUFMR0rW/QY6WK2a7J96znSIdz1GA7NfCw6Ur3hv3JipNBWpV3axCLeoUbieQrQ/47DyCm5xGQObexIMu4KeMdG02ntYnnDNtUIuFOBR2LhY86PzyrK4wC7ESZFrzDpP0CMtHxojY3w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(40470700004)(46966006)(36840700001)(356005)(82740400003)(81166007)(41300700001)(86362001)(8676002)(8936002)(83380400001)(4326008)(70586007)(70206006)(54906003)(426003)(336012)(4744005)(316002)(40480700001)(5660300002)(2906002)(47076005)(44832011)(478600001)(36756003)(6666004)(7696005)(1076003)(26005)(110136005)(2616005)(16526019)(40460700003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:17:50.6372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ff7fe5-8e3c-4c04-17fe-08dc02167824
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048

* Do not re-read ppr head pointer as its just updated by the driver.

* Do not read PPR buffer tail pointer inside while loop. If IOMMU
  generates PPR events continuously then completing interrupt processing
  takes long time. In worst case it may cause infinite loop.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/ppr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 673fcc30f9dc..d43a616c0c36 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -104,9 +104,5 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
 		/* TODO: PPR Handler will be added when we add IOPF support */
-
-		/* Refresh ring-buffer information */
-		head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
-		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 	}
 }
-- 
2.31.1

