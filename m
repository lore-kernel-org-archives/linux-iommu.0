Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33031C14
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 05:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZNth1Ao7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrZK+V2xrMy0wWHUK+5KtdetZxZ+Pkg8xjhL+dMQUK1WmpZofArMsoNEq2knZCAIOo6K+UG9uA+Th667uYF+1W0bou3rptn315ABf2LohOYx5N+DMZgdzzVlTrUiiLvAAuQ28a/DJATHnP1vPe0uwHYgqdPFN076eD3375n/fZLfEZv7Ti03zTp9VpCvKYY+rkNvl9VxFWGkIVMExbAybI/FwOwZ7kwwC1wyJdqTwciCjYFiU1PQik32d0XhofeMlvV3EscHBOwj4wMDhd242QXm0mUIWmBtOMw2k6omDj+C+kh4RihdFxu874CSdd9HVghgEj26WGTFAIoLkvsZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7v7kXpj8E1c8GQCLbvEkT512NPmKjh7JFeZ2FacV34=;
 b=dmY6W3w+0GAoosuWLOIwb6Q0iBo/4Clr8NKVt+9iNTz2KMRxiaBi9gGnAZqMk92aYyLsX0dQ5qXSmEWYcuYk3kd00+Gq9RTrYCzXx9j1fNe6sKq0axZDBRmVJ0e8uRCkJUgY5XETMx/1MjLE0FD2RQXTN3Qkxw+6Ij4EeY5WhSHhRJMy82pRzc11VPfrtNIHj7kHJVni3j/KlQ11gf022/9+BvG1Mgbw0lA/uF1gmwWj5cerBJxYnqDPtE8fpD1b+jBARDcuAEz17Yr9aXhBGY99p7IdyFpMk/Z4fSwEbIVI6xHXzbJh4eqsThIQXlyunE0KHK7ObinMBQdLUhxxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7v7kXpj8E1c8GQCLbvEkT512NPmKjh7JFeZ2FacV34=;
 b=ZNth1Ao70Sa4Sobxi/xV72qFShHWnL1OJen8dMVSZ36DJ+vvs5qyEYs/2K4Hsiu2i974Eq9/qhPlTJ692BsBGHFmBJI7vKNJN5nZu9pczEbCo+ga/CExL19l8YOJ5+HVZKyUSkteLBM7rFZqWkEjYac5OaCQyzjIIugMskwoKcg=
Received: from MW4PR03CA0043.namprd03.prod.outlook.com (2603:10b6:303:8e::18)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 05:13:22 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::72) by MW4PR03CA0043.outlook.office365.com
 (2603:10b6:303:8e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Mon, 16 Oct 2023 05:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 05:13:22 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 00:13:19 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH trivial] iommu/amd: Remove DMA_FQ type from domain allocation path
Date: Mon, 16 Oct 2023 05:13:05 +0000
Message-ID: <20231016051305.13091-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: a92cb48f-9cab-4471-1c66-08dbce069e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y2ZTQqQDzGu6L5ojanU7HYAKQtSVlWmbDhV7b+QgBaSGDDbrkGhhU/QCoRSPNcVZZwM62Us6O9D+HRKXq+uQhgF+Qa+9mwFUhVUyPkbDMEMI+a7xhQ0rj3H+wWSqip/98Vp+99YDk9gtImTU94i84VffkbW7Fkl4Se3VNZE3aNGZJtPNGcJS4Ev+lkHspmrahOHNcGE1kSLV3lSkVP1W9e1cgtiNrNOmEkSNgA/I9np1JyetjOmfqaFZXHy50w3uMRQmj28emzaJP/OxWP6OYFC1og/qXeSR0QlXP+CN4wj/TGQhPB0KqL7LDImV+aj2fl0UUVc5mvq2nqDGeGkH9n1vwkdTbpaf95qvmiv8LAI1Fu1diFQZF3OImOmFE1CP4j+yKbUxDkQ7QkwGqISZU82AQTeTKZ++detzoB4AR+U7YlS3841xnW6ZyIDUb/j4Ul6rI9kq4VcJsKYACwTlGw7bsCNWWVDi90IBzyfbT2aVVH2gF9VRd1GWXXyPLEspQtb3YXR8jfkMsBF/ohApFRVWM0TdLxWKkzz53fx/bj729sSycQenitktYX0Ndqsq4rKXfzTSDWCOIcFbex17ZK4HZAZ5M4VU0Of57WkZFmYUV9TwgzKYb9B8hFO5tTHkuPaWMPECcpUKMUxujfnrkP67akAsn15tIi4EMtklf3cFEDQujh0PlEcUXzAG+Da0hDYmJJ47DwopIH/oLGdhp4w+PB+CYLzIY8EM4cZ7KXrAQtaRFdovt34ejnT4J0ViCnHc7/Ugky7Ywlf1yoLcqw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(36756003)(86362001)(82740400003)(81166007)(47076005)(36860700001)(83380400001)(7696005)(6666004)(26005)(2616005)(1076003)(16526019)(426003)(336012)(54906003)(110136005)(356005)(70586007)(70206006)(41300700001)(5660300002)(316002)(8676002)(44832011)(8936002)(4326008)(4744005)(2906002)(40460700003)(478600001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:13:22.4858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a92cb48f-9cab-4471-1c66-08dbce069e6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091

.. as drivers won't see DMA_FQ any more.

See commit a4fdd9762272 ("iommu: Use flush queue capability") for
details.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8b459a2aae3f..dc8f9eaa2452 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2394,7 +2394,6 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	case IOMMU_DOMAIN_IDENTITY:
 		return domain;
 	case IOMMU_DOMAIN_DMA:
-	case IOMMU_DOMAIN_DMA_FQ:
 		pgtable = amd_iommu_pgtable;
 		break;
 	/*
-- 
2.31.1

