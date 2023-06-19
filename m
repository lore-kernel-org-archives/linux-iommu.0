Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD1BE45
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 08:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6yuq/yc0pNwnfdOvbpJ20XTiJOOtDSpIemjld0b4NqKjfbb75fAasCCnup4yIHQdNJNw2ZyO2vj7lqwDQJKsbD21UflSJZkCoqJH1p5/oV0Ishy/W0zXBMTZMFxQJLEStwf8YPTQ6qViSLaO1fvNODFVg0i66cI/qN281g4RA/Nh71/eO3x3YxqvQ0vC5Q57TmVXPz5CL7EWydDd4Pt424+m9icU29YgcaIGOgmpGwRvNvIT3g+BpOw/mn7F88pu4bz695/gakUzP0qBhw7M5Dn/k68X461qp33/Sq9+Jc1mwVAmKpMsf2BT1OfBKOnrA+ZBF4G5x509Z15/8MNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miDNJkueRw1u6a6e4srCaYdpVWe0nhaWL8DXbxXTLsM=;
 b=h5OcEjwrv3bbcv6iU47YSvYtK93dcdiu653UMY4xL0c8Ix68V/29sEjpS2LzO+jzx+ZsBZ6Fbq9BMtZfRgHvF60kBMzK7l+/NH5fh7AzJ/hJkas5k6fqs1QnH7OeIqvz2fSx3Xhi/7p9bsro4UlfdGRyofc0uBOPjLRi2Jb93CGFd15oXU+I54rlVc1j1gA5cr9zsoufSlTNcBcr/fZp0im3KSE6Y9DcsdjUriNxzseHSLdmEe6/S2FlgiDAZu6GrAIovp2IY2kUIpf2TXrkSsruo4bAC1MEDXrLpIR6gpEZXFy08ROlgrmDYKSldAm2o4XECPUv+xUXJLSsF+OcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miDNJkueRw1u6a6e4srCaYdpVWe0nhaWL8DXbxXTLsM=;
 b=tK6HUmW5qPnjVh4/y5zxFQflr513yjTw7PcRwW4/UcYqYEPj2mj3Udsx1CxsrzcRmdMDgJbEy+590oGfT+mV/R4y0VIZXXevfXlhTIz8cqqD4b/wsikAWPEO6UQooIDFbBlVKR6sTY1G+kRtFV/b69ZwzBdTpzugwvter70RIuw=
Received: from BN9PR03CA0401.namprd03.prod.outlook.com (2603:10b6:408:111::16)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 08:50:23 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::ac) by BN9PR03CA0401.outlook.office365.com
 (2603:10b6:408:111::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 08:50:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.36 via Frontend Transport; Mon, 19 Jun 2023 08:50:23 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 03:50:20 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <baolu.lu@linux.intel.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 iommu/next] iommu: Fix default domain setup
Date: Mon, 19 Jun 2023 08:49:45 +0000
Message-ID: <20230619084945.6427-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: fd616bd4-aebe-4569-3382-08db70a2383d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EG/6KQ4wpXGjeQYcyv0TA1KsOMG+EbAEn3I0Z8EpMJ07zfUGQEItGnSJBB/HaHCCPTcTHfSyRehFBLlu5bNkNguk9wxmxrX3aCLLc7+kYpPPObDM167w7LJdECF7FysFL30+JOx71PmTMdG/Uaa75XkMc4iTlLh9haCz/P/iEs1269aqUDwt6DHQ1HcxEcDkW8ynlwYylU1ex3B3ocng1RNPLiRAh9cJ+0iXoeWThocpsOTD1YF1IrJHzF4crs9+YoWnZkdRfdt4OnijPX5wAogHGYXryxeokqTLDuXfvBfJkQIX16f3z7hgxvq5+zcRv676dBKKy3tI2bD7DlnJepYmtdPhVPchZcn9jRwQc93bV9Y418ByMGq34FFsheBBclgKyTsB3KJdqPDqQ+ajMGakgA2m59nXuIXnC9ijKyBI2cmeXDTVwYbbCjhhmWNMai+KWP9W0w7prGf/hBlGBs7IMhiQ81Ql01/EV6TuDD1Pxd9c9iY7eXU/ZCSzx7zTKPC/mFtNEPH77JYakXDMBz3SyJdFIw+/HjNkAQmYz+QVJr1iH4Txl6WA3ziHjpKmDdl3rQ/9BfNaOz8z3jyU1t+Ko8jeHJBdwwG6lQqrwsDgAc1pgCGlGE+AQU3OZTPsWxwezkU6t2MjzLdUlAlbczPnNqZ1NINRmgbUgZiW4U5SjIuxIEB+HVirGI+Qq10Ntds7xovspGnc2EeEiGvvLilLYPU9TzmGd7XOMLGnSnFjcmEh0PA5cI9G0gBQ3+chNYbg+YZP7c4BK0aIta7S7Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(356005)(81166007)(82740400003)(40480700001)(40460700003)(36756003)(86362001)(6666004)(7696005)(16526019)(26005)(1076003)(186003)(8936002)(8676002)(44832011)(5660300002)(478600001)(110136005)(54906003)(316002)(41300700001)(4326008)(70586007)(70206006)(2906002)(83380400001)(36860700001)(426003)(2616005)(336012)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 08:50:23.3136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd616bd4-aebe-4569-3382-08db70a2383d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279

Commit 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")
accidently restored "group->domain" to "old_domain" while keeping
"group->default_domain" to new domain. Also freed new domain.

This works fine during boot as 'old_domain' is NULL. But if we try
change domain via sysfs using below command then kernel crashes with
"kernel NULL pointer dereference".

Change domain command :
  - Go to /sys/kernel/iommu_groups/<group id>/
  - Unbind device driver for all devices in the group
  - echo "<dom type>" > /sys/kernel/iommu_groups/<group id>/type

Fix above described issue by handling error path properly.

Reported-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Fixes: 1000dccd5d13 ("iommu: Allow IOMMU_RESV_DIRECT to work on ARM")
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
Changes in v2:
  - Addressed review comments from Baolu

@Joerg,
  This patch applies on top of iommu/next branch.

-Vasant
 drivers/iommu/iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9e0228ef612b..e74e45f42c75 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2915,10 +2915,15 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		}
 	}
 
+	if (old_dom)
+		iommu_domain_free(old_dom);
+	return ret;
+
 err_restore:
 	if (old_dom) {
 		__iommu_group_set_domain_internal(
 			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
+		group->default_domain = old_dom;
 		iommu_domain_free(dom);
 		old_dom = NULL;
 	}
-- 
2.31.1

