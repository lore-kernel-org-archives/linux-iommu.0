Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967CB79FB
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 10:52:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASCOJMT6cM+osokMLBrqeMYahHgY5pSEIq89z8sdlcEN1dc6jZfw0OpeIk4kuLUVYRPZcfRmtFEMY26JTAahR22iroVGQulOXlNj3n03K2cseEtLIhWhTvRGznaTWvzTw0vBUp8u+GsTU7iKlyhEXlvvj69W8LWe+QuseA6GZOx+1BxAD3B/zXfIGRJia1n3WuBKnxe3OzT0fEV0OemD9gbQz8mXUHRFb3xVAwC1/7qXGkP/7cFzJyHH57ZF/3GY4xm0RF1f2Mze8GVTJzgPY3l2QMXYW/jS83Z+EnGUKIJQi+axjoNYwTSRjy79cflqjdOz/cOEd2SGnHY4JvA4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAUn158EngRzC6SZrSmOOMH+c7tzlWpH7Y5VTQanZwk=;
 b=AhKOJUW7EBoy+adtReyEHHmHF8kuDP4MothxrC5OvxoD5DUz+w7dMwyyjb09J6CPNnI2YPh96Pg2Yaj8UQ9TVQ1WEZwHSKnVRlD4yW/lAYtJJb19Rpm8eosBUgWgmXWFmhZ4dHaYtQ5LtFbPHR/GpWvrHSV7UDZPXCFdQMiMFnRdqNrt2uPPnlesbBE+Q8RR86O4i/ghoUyJ3lfe4dl7i+po49IL37N/4gGl4lDIgXob63RSn2Sy+enUeBuxGDWoxwITGZydj4ZDmGo4frXmoDI8PQNBJv284zvWQ+XVez5Gu2XAeyFXmhXXUHSKf8rBcP+QDl3tBR2jSKJieuwoBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAUn158EngRzC6SZrSmOOMH+c7tzlWpH7Y5VTQanZwk=;
 b=RIZiRSIBOVmSo/+gQP8fc6SEfL9LrDUb3LP9lClh/W92i7jUhPBvSirpwcZQFw6OiKzit/26dvVU3tmLlvxlPk4qhOCAZQzmJ7Yi8EjmFxaSockR2fNl2Sgrje5BnVqR5Vsho+frbCEmagL7Dyu92jyhMBUpZD42jfFkMSux1Vk=
Received: from DM6PR13CA0044.namprd13.prod.outlook.com (2603:10b6:5:134::21)
 by BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 10:52:04 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::90) by DM6PR13CA0044.outlook.office365.com
 (2603:10b6:5:134::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.15 via Frontend
 Transport; Fri, 9 Jun 2023 10:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Fri, 9 Jun 2023 10:52:03 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 05:52:00 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>,
	<dmarcovitch@nvidia.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 0/2] iommu/amd/iommu_v2: Fix refcount related issues
Date: Fri, 9 Jun 2023 10:51:44 +0000
Message-ID: <20230609105146.7773-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|BN9PR12MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 19dbf9b2-04ea-4504-8f9d-08db68d78f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3z7VnIAjXTxa32K+mIxTzwM5ja+QqcCMCncdWYqCnnVonYzRDxX1ce46SyEgCEh7H4BsbQeKlmm+HOhE0iZ2ZSm7H83TKhl2iPyKQh7F7SxUnqWafxW2TgAS4g8Gf6BZf13pw6ZAlYmbChzaG2dEnt1jb6PIXaKTaUcB0bu+fPu/x/kCtN8iaYKMJzJRaMhdnpFSpyglkknH3WJ/5GgTw2DUua/SROKkZn8zYLp/5TeJSMekCfiXmmwBnolDd+evrSIkzW7nqZK4CppVkVHKkbCpeo/GdxkHX/bvnK1y7sETs9qdge7Txy0XyYGYkE40sO3XC1BLWVcsf0NDIf+oVZkT20zh+zqPh5snzXcjvvO90fK0bUNof0xCGoCafhR1RR+UzXzrg3BrHGeOrseTFapDfR9U9qmmUkYf6ZKmwq5kdVZlQMnCT9UL3UFZrdA6D8QPIixlY/wFCgV0NfPJB5l/dHnnRUVDyddpALlhoUHo0wZ494Z5bAZXsSPVW2R7eOd8xnq/K6fQCYmXP8vzyHJeywzoRkB8jrZ4S4Lmem3qKR8p+tnufOXJTVrWhHJEX1O+FoeUQEs3wrMbjxzwJisPB+ynFJwGhYMv8gf/p9G3tbnaDfNfE1sU8Rf3o2MLhb8sHVAKgBzwXD+ghI9PqCnMcefftbHUQg6PPO/kwKhxjuGlldUGU3yjGfsbzUuyaYN+ZeEkcKn5eeh46uQ6GPXhjqM8dyJI7O0xL45fF+XYXg9VolZAS1y5ZOdj/H1QxiROedC/e660lzANyLnBSg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(41300700001)(47076005)(86362001)(83380400001)(966005)(336012)(426003)(82740400003)(40480700001)(44832011)(478600001)(36756003)(316002)(110136005)(8676002)(40460700003)(8936002)(356005)(70586007)(4326008)(70206006)(81166007)(54906003)(5660300002)(4744005)(7696005)(6666004)(82310400005)(2906002)(36860700001)(26005)(186003)(1076003)(16526019)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:52:03.3919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dbf9b2-04ea-4504-8f9d-08db68d78f59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5180

This patch series fixes the refcount warning and pasid state in free
path.

V1 : https://lore.kernel.org/linux-iommu/20230124104355.119166-1-vasant.hegde@amd.com/

@Jason, Joerg,
  During v1 series review Jason had suggested few things including
  moving to xarray to handle PASID. We are planning to implement
  xarray as separate series.

  This series fixes the kernel warning we are seeing because of
  commit 8bc54824da4e. I am keeping changes as minimal so that
  its easy to backport.

Base commit: d11370bf64c57a (iommu/next branch)

Daniel Marcovitch (1):
  iommu/amd/iommu_v2: Fix pasid_state refcount dec hit 0 warning on pasid unbind

Vasant Hegde (1):
  iommu/amd/iommu_v2: Clear pasid state in free path

 drivers/iommu/amd/iommu_v2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.31.1

