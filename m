Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98660AD3A
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 17:36:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhR9ZLOmUS0bNEdPeB0mZ0bgjGsRJ1KQpvrDTd1BDu6NYEO4HojzOkKcgqnuMRSKfrgYgzg4Rcg4q5af3jkI9rEm4iVk1knVJz9iIZi63DlyAVlipheG53p/2PQI11vxnUjeOM+m+3wEwNRNFcyBJbIiCA1vwV7X+5+MZZ6/0hkL7IykLUgC7y4cCjB9RmpDVqABEBDFqbfgFkGvhwZLHq4zAVeTKB/j+X07EXFP1GBZNJqvGU0ofTI5jg6PvrHaclLiyQGHwSrQq44AKZ+err4nwGM+XtV44Nr5rTWwAg9M8K3rJLmGKKjbY3eA/lRTbYAKbR0rE7UY7eIFMhOOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qS3La0uSRIU3l+6Mh4pyDqFlsj8Q+EX+g3KpaJJEJ8c=;
 b=lQ3cwWBYKHYQk7duHSGu1CqivSn54/Ke34Z28xUFqC7iOU14UnS4ABXlbVBEJCZAXEx6BmdxW6QBqK05lEf1x0AiHMONSbl2uySBA7OUppOb5OEPeOVZX8BeKkYgknRKSdDSJiGulF2WwRET1MCfzP1lmZSJRhB9VJ5Tw7IldY6JGCxravNHTKS8ezUXUoJHvxa9IFe9gEpWJEEg7lqNIzQDTakGyd5IJmKUx8Nd3IgUBHAyRqN0LwBvHa2YnpkBgiMAsYgDnsSyMWQ3BtQWrEBo48WRKCgPjGIajVmfW6SNvZGDrXiDdg2xluPFJN+Z5kbmji0BHahH4yVY/baZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS3La0uSRIU3l+6Mh4pyDqFlsj8Q+EX+g3KpaJJEJ8c=;
 b=Wf+KCKS0POOerUkpN0A252Ao0f8ivuJZNImDb6yWsYqPJXS2XgkcCl4xgEd0TaPmoQSK2R3W8uFib8iy3O8YdzvuwfrU3WPOCAr7PreIIhZ/9MoQOtjU233k7Dp+JuIxffGelsVr6EB9pPnMsVZ6EqEbtfYhfYRHvdpdZod59mQ=
Received: from DM6PR08CA0064.namprd08.prod.outlook.com (2603:10b6:5:1e0::38)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 17:36:39 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::2d) by DM6PR08CA0064.outlook.office365.com
 (2603:10b6:5:1e0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 17:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.28 via Frontend Transport; Fri, 3 Feb 2023 17:36:39 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 11:36:36 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<will@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 1/3] iommu: Attach device group to old domain in error path
Date: Fri, 3 Feb 2023 17:36:21 +0000
Message-ID: <20230203173623.18308-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 01cba3ce-645c-4cfe-c9ce-08db060d34ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2B7CoxcEl9SfS9mNcYgom5l9nrDIIZJgeJD4JHXE+IJ5G0ObFaoTMVQXW11t86h9jBYeMJVvn0DGiw5eh1DkY27/uiUFZ8HeYnEORd9rjm8GizVzpWQCwk86yQRlwh7NWtsWBs1GqyUNIQuYwMfJnij1ifJqRPfwPOB5ywzoL/uXSd3aCUbfFrfBxWXQSXE9jePfJx3OMypDPJHR317lrSHbJcEjhzfU4Hjb/qgcMtjkSum/f3FcyOMtItIO/5SxIBysiDBJiaYKH2ZWmd5W9xCWIBlYTqXjvHVkYHH5l8pYaTHydjSpwN2Bp+cPShYNqlzQBSiGhPznFUlo0ALQ3PAINt1DutsacNGsWRA7wvj1x9DUI2ImlpI7WJ1f6/ZeREqNxcRf/Fw1MDViQFo/a1cygiDaCNb80zeeMftZJwBlYU5j06b9Emf8KXZgbXSy/r/yT8ndqFfd7au9WwgNuo4BitzS4ntVfRBXkBVqtcBnlpBmtGTM8vbkNj2s8mX4u94F68mBjmLGOsVjKMgAFT2aF3YDLz1teBNs2WPBz8eZusVthvOWdwuAHN2qROVEgy5CzFY4yGuhKjzhbmxfITk3UYW6h7YTeyDwvKEZvdLsUJyDZKadAhyA/g5G0mSxSamyg/qycUgIhgoxLfc6uu8O4k9d5tX55deAW5utktTvUFY+G1q/sN5wkYsX9GdGh+1wEkqxrN6AQdx9UBazuOPOu2yPMx2yx5brN9iuap4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199018)(36840700001)(40470700004)(46966006)(356005)(81166007)(40480700001)(336012)(47076005)(2616005)(426003)(83380400001)(82740400003)(36860700001)(40460700003)(8676002)(70586007)(70206006)(44832011)(8936002)(41300700001)(86362001)(5660300002)(2906002)(4326008)(7696005)(478600001)(26005)(54906003)(6666004)(82310400005)(1076003)(316002)(186003)(110136005)(36756003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 17:36:39.5796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cba3ce-645c-4cfe-c9ce-08db060d34ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444

iommu_attach_group() attaches all devices in a group to domain and then
sets group domain (group->domain). Current code (__iommu_attach_group())
does not handle error path. This creates problem as devices to domain
attachment is in inconsistent state.

To recover from this situation, we need force attaching all devices back
to the old domain. This patch introduces `force` parameter to
__iommu_group_set_domain() so that we can attach devices back to old
domain.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/iommu.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index de91dd88705b..e58683cd3bf7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -95,7 +95,8 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group);
 static int __iommu_group_set_domain(struct iommu_group *group,
-				    struct iommu_domain *new_domain);
+				    struct iommu_domain *new_domain,
+				    bool force);
 static int iommu_create_device_direct_mappings(struct iommu_group *group,
 					       struct device *dev);
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
@@ -1974,7 +1975,7 @@ static void __iommu_group_set_core_domain(struct iommu_group *group)
 	else
 		new_domain = group->default_domain;
 
-	ret = __iommu_group_set_domain(group, new_domain);
+	ret = __iommu_group_set_domain(group, new_domain, false);
 	WARN(ret, "iommu driver failed to attach the default/blocking domain");
 }
 
@@ -2124,8 +2125,16 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 
 	ret = __iommu_group_for_each_dev(group, domain,
 					 iommu_group_do_attach_device);
-	if (ret == 0)
+	if (ret == 0) {
 		group->domain = domain;
+	} else {
+		/*
+		 * To recover from the case when certain device within the
+		 * group fails to attach to the new domain, we need force
+		 * attaching all devices back to the old domain.
+		 */
+		__iommu_group_set_domain(group, group->domain, true);
+	}
 
 	return ret;
 }
@@ -2164,11 +2173,12 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
 }
 
 static int __iommu_group_set_domain(struct iommu_group *group,
-				    struct iommu_domain *new_domain)
+				    struct iommu_domain *new_domain,
+				    bool force)
 {
 	int ret;
 
-	if (group->domain == new_domain)
+	if (!force && group->domain == new_domain)
 		return 0;
 
 	/*
@@ -3135,7 +3145,7 @@ static int __iommu_take_dma_ownership(struct iommu_group *group, void *owner)
 	ret = __iommu_group_alloc_blocking_domain(group);
 	if (ret)
 		return ret;
-	ret = __iommu_group_set_domain(group, group->blocking_domain);
+	ret = __iommu_group_set_domain(group, group->blocking_domain, false);
 	if (ret)
 		return ret;
 
@@ -3222,7 +3232,7 @@ static void __iommu_release_dma_ownership(struct iommu_group *group)
 
 	group->owner_cnt = 0;
 	group->owner = NULL;
-	ret = __iommu_group_set_domain(group, group->default_domain);
+	ret = __iommu_group_set_domain(group, group->default_domain, false);
 	WARN(ret, "iommu driver failed to attach the default domain");
 }
 
-- 
2.31.1

