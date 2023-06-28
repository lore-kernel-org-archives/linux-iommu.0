Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4874A33D7
	for <iommu@lists.linux.dev>; Wed, 28 Jun 2023 05:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMPQGbP/ZVhQf+66mxq0oV91BKbbbwDG8j1smj8ySZNz0OT3EqAmroUmcMyp/Wz2Ue3HTd27N/tiShr88gKjIeMTAHP64k+WzkxTuK9s5saM1OppbjjNWbneV13ZGKM59lZaJsqHDtyphCQ75/EUqEwVcjGqFBrWJK5XE6BsEuADQ+gZbJvIcWYHKrxZ0N5SVpYdIQVHngYRcgJUe8weD8tCsI7DPO9gJa+3J33bPhIqQh1i3Jvgz7YztLC9T4HhUHhD7kZCwRW9UJtAzWQME2u/8QuSgXv+BxNXocvTs78W5OulJpwhmbLBTkZu8iKwRvMogprG7+M/F8JrOo7sZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLQGmn01tBcji7jTcJ7rXsGN6O3D1ztSxvieo7toOsw=;
 b=UMrGWxYOD53zjcUynKhQDNcASdgDud9/RWqUtP7AmdIHzf/pOgpiMgpenHlCrjFaFoCmwirpOzcGOk0YAsyiyiVlBCY5nJWbuWDQdNXV1Q8SkoTVFKVr7fGLg5AfCT/rbh5u6iOQCAZWdOnSCpXRB93SEnMhjx6/Mjwwkf3j4tkl+OYP/7lbq7Bfml827WSq5q822FjzruK1DsDE1TKz7d0UxwUzgYCnG/oreiKpbA4YjylFPzGkv3n46/wCmxikX6WpWrkBvQz9MhhiAO1GFxJZNLXPryAnRreIcN0F3ozjGXDFAMh2NeU7rZ841ntHbPZRWa1tZ/VLPUi+FhyKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLQGmn01tBcji7jTcJ7rXsGN6O3D1ztSxvieo7toOsw=;
 b=k+Qn1ZUBMmPeul5u2rWVB9xZRqk4FW9A4kdU5xnnYAbBvSZpGWZ0O24uFkzc173ZR+W8iKjABGySX1QtmpU0uXnLTgU+i3iRLtFNWzZGrch7Hyb1oRtO5tyvaxf8o9DE93tD89nEK6p0qveDeMs4VHiQggUDaAjaS22/ViZceRE=
Received: from MW4PR03CA0083.namprd03.prod.outlook.com (2603:10b6:303:b6::28)
 by DM8PR12MB5495.namprd12.prod.outlook.com (2603:10b6:8:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 05:46:26 +0000
Received: from CO1NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::9b) by MW4PR03CA0083.outlook.office365.com
 (2603:10b6:303:b6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Wed, 28 Jun 2023 05:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT105.mail.protection.outlook.com (10.13.175.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Wed, 28 Jun 2023 05:46:26 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 00:46:23 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 1/3] iommu/amd: Disable PPR log/interrupt in iommu_disable()
Date: Wed, 28 Jun 2023 05:45:52 +0000
Message-ID: <20230628054554.6131-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628054554.6131-1-vasant.hegde@amd.com>
References: <20230628054554.6131-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT105:EE_|DM8PR12MB5495:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf12856-f175-4535-c97f-08db779b0373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sRFn/FkIkAzY09E8qcod4eIoLG54U8jPiDKD6/M4VVMaBLs+hRrdpskKzrXHjfRe71gdTgjFfaZcMoTd5NTOI6uZ/nyZFbub/utlw7na4mpcJh6OcnaocG8kNB3MdcmN7dl/sO7KVxHQcijnrpuW4r23eHtB87dPQcEC7QZilgqgPN78pLWdoCRU41Y2/sTOQF/6Dda5a06qi2xDQFqde0Y50jz1J8JpbpCwQN3JXZrN3PHWU9SJf1kWvFMq1NAPvqBya19jRstXBMH1l9zTW4fyRyZrCuZxBjD4W2vTn5emB0E6UkS2n18boTAaNu0Zwbe301NPSj++7ZxNjjYLXcstjV5D/44IQtvFkYz1CVBU//WqTzl2ywrWS5H72nHx0xpzLQnBqc/kkvUTD0hUiJ1aUnbkl/5r7Gkm4dRKQPhJYvB/tpjLP1Hgzs/m6ELVVQv6yvRn6Do2UfLjniUlKmVHFrmXWqKKRvPdxMsMjG9wwA8qozI7F90OronU+0VRmg4sgONINuFgFWK5gN3mF4McavV+tc4vKvbyjRvumW1vBjuR0+9r033+OI+7rmAHMJxdWGK9xeBBseVF/DUdbz9eSSlmhBuAYHFQuaED6ARHBZXyLAjj9luhD3CE0EyZN+1SkWIrZRaiOjVrF0tcTiKeifYB8Dulp4MQMZqKi2uFDhXdopwL1Z18tqcVYhi9xCx2nvDPz+Cq4SFgTheJ/JhL7M1cdHv6Y7y/Yv5iSEqeqq6voCxXyRBeTNw76D1Qp8PTtcFoXGMWHHpx5uvI+A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(1076003)(36860700001)(70206006)(40460700003)(36756003)(5660300002)(44832011)(356005)(86362001)(8936002)(8676002)(41300700001)(316002)(4326008)(81166007)(70586007)(82740400003)(40480700001)(47076005)(2906002)(26005)(186003)(478600001)(4744005)(16526019)(2616005)(7696005)(110136005)(426003)(336012)(54906003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 05:46:26.3050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf12856-f175-4535-c97f-08db779b0373
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5495

Similar to other logs, disable PPR log/interrupt in
iommu_disable() path.

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 30f09e786f7b..94c91b6ee603 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -483,6 +483,10 @@ static void iommu_disable(struct amd_iommu *iommu)
 	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
 	iommu_feature_disable(iommu, CONTROL_GAINT_EN);
 
+	/* Disable IOMMU PPR logging */
+	iommu_feature_disable(iommu, CONTROL_PPRLOG_EN);
+	iommu_feature_disable(iommu, CONTROL_PPRINT_EN);
+
 	/* Disable IOMMU hardware itself */
 	iommu_feature_disable(iommu, CONTROL_IOMMU_EN);
 
-- 
2.31.1

