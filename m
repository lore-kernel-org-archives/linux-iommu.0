Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABF979CE
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 14:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2DPJq5cn7P8sUJ7+U7WAoK6uOko4hldaHP4/P8TfOFX0DM3jBU6UURkYiKr/MpGZaYw908AJ+eXwKjZ2JPyH2YHt1YbmP7fzVMWAK9LjwcjKpGmjVaIhDWjpBkelJihiX4QqBBbdFL4zJ+5o0IXgHk1LBsh/wSKJjGd8nI1jf3z+gXQXmsaaaVOutnrfF2NfQ7+EaGoNt6wrN9eAfHZ1qJvUuUdBx3WZgVG76jrSt4q5HS27aUjNXB57oy7Z9hho+UyFfd3FkF+1MCErb5oPsWdQjpcx8Uj1VvpgqoZTHKa3FtvUSdkDjQpd11l8XIx/IMzDbu6iSxHSnAzIrYxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qS3La0uSRIU3l+6Mh4pyDqFlsj8Q+EX+g3KpaJJEJ8c=;
 b=Rvg3MupVccXQFIXqU+fdoOFFRzF6+VqiJYyUoZAXa2RFZkfL+GZGSAVof06P27zrAui9u7/yexlcoPU6IYkMvYrmJ9jpnwbuGDqiziNHGAVESbH9SwxY0RCI+ChQ8nTjH7GF2W5E5HRvLG4LVUL3KC7ONVCHcn8Pk5MSrxCD561sPvgUNm5RV1t5Wm2+Yps5Q+sF/OKOpd/yG68SN7e5IGq0lrHtqRnjTl18r7wHvdHc7UePOHvB8hF6j2qBx09j7pY8whPnbvvliL77TCj92aq//yjD5jTSdhOjTjzA1lMy5dGlLR/4BaFnDOxc2djQk19gO+K8B4ORYR7KdLeFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS3La0uSRIU3l+6Mh4pyDqFlsj8Q+EX+g3KpaJJEJ8c=;
 b=LUpJNhIftmCPqF8IP+JGSR6D9JbstUXBHQ//pqsIWPVbe36MsFfN+2rSk5alTBhttmfQtBfK2XLZLuRfNnMJKZESiFrn0IUot0XVxJjITH+HzGxN/OIcSWK3XBdLhaJNmy+OKX+VUYCkDFurPdjTVG4GUho/ub5BBab0p59322M=
Received: from DS7PR05CA0036.namprd05.prod.outlook.com (2603:10b6:8:2f::25) by
 DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.19; Fri, 13 Jan 2023 14:02:12 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::29) by DS7PR05CA0036.outlook.office365.com
 (2603:10b6:8:2f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.6 via Frontend
 Transport; Fri, 13 Jan 2023 14:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 14:02:11 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 08:02:09 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 1/3] iommu: Attach device group to old domain in error path
Date: Fri, 13 Jan 2023 13:59:54 +0000
Message-ID: <20230113135956.5788-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 4553610f-d821-43c1-9da0-08daf56ec485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	olS0inR1GgcnDJ1M9EH+yLH8MVkad3IIx7DM18BnwMbrebQyq5aMzcNGSZ74WE8faye7h65GG/hPG62Ebd5FYe+nFr7k25jc8t22DnIeHx+lbVG+X7FnkHUFOCMBXCr4kz+9Am7G9hrJoRoTZ7cl5GUlvt7y6YR4J8frYMUKTdPvu+HB2sTfDnc3oK1+aW4xYeK96JC/nX/JCUgnd0qgT7Erzy9vR9NoBD/5sylOeDHZ1cL31r79InXvJz2ZvdXdD9vfJNEIwN8EGBF+hBAf3PhZgJ/ws5WGV18fMnY0TKKLrRbbOy7qlcU/tR+5Jz5VYy4s4pUb0sV14KkSsKtAMm3v+YPpN4iTRt7AvZ5soR2O6wbzx7DEbqEYqEhFmbT9Xca/BRVJGvuUZEfXmb0RRbNTICqaGzfTbgx8ZdX+x6sjcJ4vqvYq7wfUWi4ZN50mUv0TYLScZFyUYx8E2kDIVf5NV9nHKiRTG0npUzaaGDX7WT5w70g4kRy65q8zd3p8zJRdb6O6dFuFBcSnPbKdZ/0OJ1cp63qjapeNoTCeKTezV/BLIVkhYgPjtP7S/hopoJHkVgv4IpALvW7MCU3Y3gx2gizFXZzrE38wkVpyydn+HySNdvU/4/91IKBeNci0EjS8AWbA5/u4muVIjATNCwHlNwu9iFmeAYGxU+rgxi0+nIJoT9nhETjQ6VeaPn+/Qf45MNKENfC4LHzqD7JiKVoOdl/O8EAtvROctj65vts=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(7696005)(16526019)(26005)(186003)(478600001)(1076003)(70206006)(110136005)(316002)(70586007)(2616005)(6666004)(54906003)(8676002)(4326008)(336012)(426003)(47076005)(81166007)(8936002)(5660300002)(41300700001)(86362001)(83380400001)(44832011)(40480700001)(36860700001)(36756003)(82310400005)(82740400003)(356005)(2906002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 14:02:11.7863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4553610f-d821-43c1-9da0-08daf56ec485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271

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

