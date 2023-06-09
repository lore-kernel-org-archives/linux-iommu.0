Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3279FB
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 10:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvzYdQSz3H889TddbcKafSGs1OAk4Q/lGFRkLVt6UFcqabeMqALToHBzrblJsYfZcmK9mXsPZY753aLDIqgTDR93/EGjue7q6v/Hta5S9Sqib/mdN0G659Lv3qB8x+c6kXyNC/tOOp3InZs/ips9Yf9LeNvZxw6lhKtdgo2YMqQ7pX+Nd8PL4nYrp3kw/ViUKVheSrGMBIcGuCJpagCQCja5+Eu4uhYdxGFNeVWaqD4jyx/NwYyFuQ6UTNp7X1d0lJpqgqg452UgaJr6O3niwTJu5cT/XVXcH6DFh5nX3E+u/yMW0F/4sfEP40dbV+P/JRMKxxuSfzOXECa4YDtFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inYNKfSucLSoVMtj8k7a0Ajn1zF3dS0lwj80D9RwkxQ=;
 b=nIWFmmhxjWHUaAT+pSAbdYbzOb6E1Xtpyd3lp6vYmVGaGkAl5igHM9N21G5qlOw21V2je5J+G6EsVtvqcS7AmBK56YuKJ3Ub8N7zpb0lNX76lPLq1HjGObd2KGFZMuuXfAiI73MwOJ4K9xXGX6nFgeSQYBjzmrvNYEoM1E+FHlFbY8Q6RKKp4dKzZabb+vVQE1vXR20R9Pg7D0wL0zknYfuoUEz76TDFskN1u5qs6QJt4iP2Dq4a3OoVNHvlYc4Ltc7hq04Uhzlp7Sp5rDmvC2Tp5IHhptBlOF5mS91GEqPvpP7HezFSDGlW1hEmagnPWD+baE6yZGGg0Z6KnqzqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inYNKfSucLSoVMtj8k7a0Ajn1zF3dS0lwj80D9RwkxQ=;
 b=4sp7UBYONhyaD+KMDD6wvyz4Hf0H/vJM4iQlO+XWIdcnPzgl6fSqik9NcHfQLfJJMM/8iKHIPacEzbTIMyMqJ4WPRx+bIaL8iZbhLLrD6GB/olR6hADzVId9k/bzq/QoTg8XlFHGNn7ACMhn0McB/WPAHjaeigLYuXrOyOtUugA=
Received: from SJ0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:a03:2ef::27)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 10:52:35 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::51) by SJ0PR03CA0202.outlook.office365.com
 (2603:10b6:a03:2ef::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Fri, 9 Jun 2023 10:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Fri, 9 Jun 2023 10:52:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 05:52:31 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>,
	<dmarcovitch@nvidia.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 2/2] iommu/amd/iommu_v2: Clear pasid state in free path
Date: Fri, 9 Jun 2023 10:51:46 +0000
Message-ID: <20230609105146.7773-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609105146.7773-1-vasant.hegde@amd.com>
References: <20230609105146.7773-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: cb270d4f-23ec-498a-ea0a-08db68d7a1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	++SyKHNKhGQsohwF0+CBALipbHqAbXYmGo62bSDMK+otTkKtyQmj1nK65UAg3l9FRlLhz6dRKCNOfO4m1oKqjw2XbjsjeOdgIi7AzjKSfk1raaSLjxrqgHITQrZNJiw9xoYP/cljrZQBlkJQAnaGy+MEfuFJg71osjYFPkMR8M7TySn9yBVtwJ4/XcDgSoKhHIV15C0z3zkFkKbx+IyQg+Doyhymvxi82gRn5El08d20ZRrVCPT4DxMwxwo/qqALUgRz6M0O8LsF2tOv3aKOu2HkyuNYHjVbpcQrf7uAfrlvdFmTUce2J7josfjtjXNpY3O39Ni3krtGCd0u+fORSzfsytZTLyWdwe2P3l+4WwY2LPf/zwcUV5iKrrR/D6u16iXjHwqdEBRdc8PTGh7dpvJJlcprPCQpFM2fuITpoA4l2rXiybRu5q93c1pOlcXkHn4jgo874Oszh2jhuRQ0GHQ7KZaAX4fWcT5Pnp+1lsM9vZGzA5mdvnoO1to4K20WC3TROgiF+E5EMd7qdVbUJ1KvPJPuDTbk6JwL57DzNRgM/cRELmxvRZCTcpfG/vs5ZTOu9FrVGWiXpju2iPynsjEk02jkqYTf5ZEJNnrnc3k229obz929rE8zSfN8FNNBzQcDD2dPmp+PIZWwxRoGzNujKgo/HbTRL730346aUxCas613EdKjLs2TP8kDMoo+a+SmhaSzK7Eqmh4mVVsghITZeEmBMXVr/JngBxgAXtuuEIr5/KWVphY+nQ3Q+wtAoyI/I3HudQ3FgLv7X0ojXg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(70586007)(7696005)(4744005)(6666004)(81166007)(2906002)(82740400003)(356005)(70206006)(54906003)(110136005)(44832011)(8676002)(5660300002)(36756003)(86362001)(8936002)(4326008)(316002)(40480700001)(478600001)(41300700001)(40460700003)(336012)(2616005)(82310400005)(26005)(1076003)(186003)(426003)(36860700001)(47076005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:52:34.4517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb270d4f-23ec-498a-ea0a-08db68d7a1dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319

Clear pasid state in device amd_iommu_free_device() path. It will make
sure no new ppr notifier is registered in free path.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu_v2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 858748baae0b..1df1d227bd26 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -327,6 +327,9 @@ static void free_pasid_states(struct device_state *dev_state)
 
 		put_pasid_state(pasid_state);
 
+		/* Clear the pasid state so that the pasid can be re-used */
+		clear_pasid_state(dev_state, pasid_state->pasid);
+
 		/*
 		 * This will call the mn_release function and
 		 * unbind the PASID
-- 
2.31.1

