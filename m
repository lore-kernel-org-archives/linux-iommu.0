Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2663CAD3A
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 17:36:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7aVgwM77QWA3Q5TOn25fzOnccZ+Sw8xXeSVm1uvx5MJoqqv/tcMVkUCNzRht6ZpaNoFdJSVXglN7GAeqjKU+2qxGKqXIZh0sftJvaEwQf9Nj1CaXP2LP+4Zwd51YWcai0pIkw2nifT3yQfbVXi/fJCnXvTQVSCsmSNKn9gdO+D1JZyT2KevnMG5C9dqD5sDqvJI0nZPoFbGcoryWIzQrVdzTUOyy2cuXMJTsjrG4hLlwjaWkRDr6O0xonHBxNyAEhyTVzYNrLTcfGjckynrEAf2bxz/7aRmxDe10yT1JVzIyLofzdq5Hdfr8zVmxd3oh3WfLHyP486YwzHxmOKMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhzUpueXJQYDfV2/mhdPy8mQYWIIgDetJcVL65AuZuw=;
 b=aNpL3PfCAkU9ZvgaYJgvWzzJvT/QT+WpYzjFmT0hdHsIJHvOhUfERlQekhwcYZX2tn7ib1EkzZHmEEEBo40P70yL3dfIwGOC/b1zP2t2NCjRjTYyfLFalJbviMtvofzbnth9nucbIWchj28nLKhfjwJY759o3z3ZU1UZ8I7u7HopOR4khSKGuJU/c9+dfZQWiycj3429YLgNyhOD+cy0rvrrgnWwoKbO67Lzh+BJ7KKrxKYVNxqbpNd0Ytfz6seNVO7dqnFMcd9po6pINHamdp+IxqaFO1O3K9HCtsUgUXSkFVBO6o7Grd6RtGsks6IXGnWold/e1GVQouQm6iUMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhzUpueXJQYDfV2/mhdPy8mQYWIIgDetJcVL65AuZuw=;
 b=BUSI2g4bvTnBr/O4cjVSMhrNWxNouMKxM9VvrywNHwSoZOpNCOPGQ9+qEMEkUZ42w94LWKYs4JqMgEmdJF2yVy7K74X9ceg9Tm369LtxzequGvGDF1rd5QjBu+Pvzugg3xwYPmQgfHcVG7HVVUDRaHnrhm+6LddiSfgbkyPdpnI=
Received: from DM6PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:333::30)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 17:36:55 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::d4) by DM6PR03CA0097.outlook.office365.com
 (2603:10b6:5:333::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29 via Frontend
 Transport; Fri, 3 Feb 2023 17:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.31 via Frontend Transport; Fri, 3 Feb 2023 17:36:55 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 11:36:52 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<will@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 2/3] iommu/amd: Skip attach device domain is same as new domain
Date: Fri, 3 Feb 2023 17:36:22 +0000
Message-ID: <20230203173623.18308-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203173623.18308-1-vasant.hegde@amd.com>
References: <20230203173623.18308-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 766d682d-4c9f-4e41-3edd-08db060d3e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ovZ19fBwhv20ciK1Pv5foEdwdShdcuVzFn9mgmEYwywJEL0etYJdMoVC1IjZuXAP9cRvAliCbaz0KYrFGn1g+Er6aUYKohdwuvXMbataqe5FVWz/RE4JtSQ9IX233r/PcwPgq/EEgVI//loPTdJf0ZUQSYNQRPeaJLVFz0/9dfEw2HNefa07Mr3SThYk/tNCvyf/Bx7jJrIM9YgPDTDC8yyOx+aIc+zt7pM95S52wC5QgDWEjSiOt0jo7FH1otNfi5ty9TaqnlZLib9w2cZHlXa4XyP0nFT17PQmOmI2sybNkK7RQS+OXknLfEw1NWh04E/eIlTqs1WvYfhu6OjEJxmztUS7a3HBoduuPxNJ64QDOwBIhIb5hBKO8mQdap2vgwBHttUxdHTVOPD0RYidFtHWzKzXp5CmWp11GucDeQm5C0FkwFE0qV5Oai1URD9pLYzItInM+WEsIulGGK/WMtPKaLXGyVzWue3YUkeMLKtcMVF2IIZ25o4MhvLlFhF0Lnty0mxcXrQTueJkhWquJnE6wFZbrimkTSWTVs8oVH8cATFeVbofw2iy3HsLSA0NdZWnOv4xSzbTYhRr2vSEzwedlWgcKtMAHOYs2A4YyZka1iCKBVMd9PoFz1a77tdoNje0P7qYhpQVSw+QRfjo/pprbn2m3VidqaiGxotcc+wFu+pUIZCAfSdKi+GHV+rDsAGEvDM7qtaA7mpnGT+l6aB2Wds4RvgeZiif93Mckf4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199018)(40470700004)(36840700001)(46966006)(316002)(82740400003)(82310400005)(478600001)(2616005)(40480700001)(356005)(40460700003)(81166007)(6666004)(8676002)(4326008)(336012)(70586007)(110136005)(70206006)(54906003)(26005)(186003)(47076005)(8936002)(4744005)(2906002)(426003)(7696005)(5660300002)(16526019)(36860700001)(36756003)(41300700001)(86362001)(1076003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 17:36:55.0072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 766d682d-4c9f-4e41-3edd-08db060d3e34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916

If device->domain is same as new domain then we can skip the
device attach process.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2f8c018e1ffd..26c96b821fa2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2161,6 +2161,13 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	struct amd_iommu *iommu = rlookup_amd_iommu(dev);
 	int ret;
 
+	/*
+	 * Skip attach device to domain if new domain is same as
+	 * devices current domain
+	 */
+	if (dev_data->domain == domain)
+		return 0;
+
 	dev_data->defer_attach = false;
 
 	if (dev_data->domain)
-- 
2.31.1

