Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE86C3D62
	for <iommu@lists.linux.dev>; Wed, 14 Sep 2022 14:45:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCLGjs0PsLP/ZpApL0CGgXT8ffzaaplHwlY89Q0SMTIHEvhQrhh2ozR1mCQdbWzUQm+DhmWFiBVAK+AnQNKgiSYaI/PQ9W/hmOVbvg6kyk97os7s1VO0ba+ZLb4/mXHl4e47JXQdoYVJyFg01jCy1aWYlLZaTIz0j6ULmUJzwbBDK0gZmtlx/W8shTcaw/X7aHtWn3aRKdKaSy4ja34Y9LStFZtnSGds4C+iGAMUAdf0kz9HxijaNXUO5NBVcD9ykoUvIapkViTr4UAvC1bqQi8liUnSRRB0rUi51Adda+ITIgOG8Aa6GVZickr9Ub+dfsCLectZpM91SU1T6hR5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jD9aXOFMn0TVzuRVVaDu6TwrVCNuP/BU0U+flUetOQk=;
 b=fT3XjDZwE1E4EKaweWi6nM2SxyLGwai9Hw+p0EFLSFUZvkBZCS8iAOxq0ef2xmISVBbj1dLjrFHNWbIeCpouPv3E+RBjYI0DK0cxEyUQB7dVawMgwMDT0/Y6hNmSv6TQeX5FFkJvjJh3pfju+z+naIlUePeVguGemKVboWqQRnfy55721Z3EtKgcGmZzg0eFL27bs6zM871BiOXsD9KOQ8IKaLAfL24B3He2TM5j3yf1W7AR6sEE0gY6M1szLhqoF4NK/q70LWYrKheDrIac9aOyHX/ZY66fwH5gkUnllOmq3AxDVPbE35V7xIuGvuy+pE1kbXb2OvzSvlNNm5VjVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jD9aXOFMn0TVzuRVVaDu6TwrVCNuP/BU0U+flUetOQk=;
 b=JacZtGBsPbpnkcjx0VXWSiSzbopsnbtO0zZ5SEnW3iVjxSeL/zR9ZLwykQ12oCVzLUnJXs2hTnrItYF432FLM8BbzfG9ADxH4bXEFCQqmuNUc5mp8wdQo+6eRj9Wn9UAu88ig30aAf6Rj++ErZg2iffcRcr1Mzu05KiiPSQyL9E=
Received: from BN9PR03CA0298.namprd03.prod.outlook.com (2603:10b6:408:f5::33)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 14 Sep
 2022 14:45:14 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::51) by BN9PR03CA0298.outlook.office365.com
 (2603:10b6:408:f5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Wed, 14 Sep 2022 14:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 14:45:14 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 09:44:57 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [RFC PATCH] iommu: Handle domain allocation failure gracefully
Date: Wed, 14 Sep 2022 14:44:24 +0000
Message-ID: <20220914144424.7356-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: fab17c1d-d69c-4fb4-b1be-08da965fbbe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fP3xudpimlNLmKtVzmpZ9VL3/08XDe6R+S8X9qHfI9id9t1RJYgEQW1WWyIp90TDmLQ0A+Q1CDyrDyiZC7CLHu4Oc3tagMg8HpU0MQj2fSR56RTWyxKUpRCK6eLF6Q1aqbC2HlG7qcb1kBJsxNnLS0h1iQ4oCvqLchxYlt08q0DT+dD6kdq8PyFsIt7P8GrD2mE/hYlOH3peFpZR2b61Iy/0rV8pNPs852UjorARdACbK2MtuymtQj70wh4G0wn5FsvOOJsLF9aNXzvZmPh54gdo98kWLtOJlhoiaoC0Wa3sCK+e83gHBAGZd+mnhy5MJe6vSgpoSppcgw1vPM3rS2TeZidNArkOaSGO5tQZoxFVLw7j3U+UlR299XuRDrFjP+1FKFjWoxPvCs90hnvgbLCKRzAd3GuRjF9sLc/zDvJao7NE1XXOhiUCFtaivqV7DHOTU1j5Og+/zgRz2jannrAzV40iGSdSLBvyQipOKv1k/n286FmrwIYUAJ/sKMtVWvDQWylIgI8lSrA0T5mCzo3Xg61STLzbDNj7VRvaBeV7RJqXWg0nAOYxO1hj0iYPWms7n+P8Auw6gehKyL+pA10jZ1IDdxzZwmvgmwktexqs+ntVFUuIac1D2H/RN4RHsZH1pBvz7jmlRiv5hMAQNZ6kPyrRJ2jrwtWNlNhup3dkmKSB2DMbun8lPA5WkTP8QKS1ZaOIYu0vRRxLO/TzyG0s6Os99kylioLtjxCDtqhelsFrHvh5jOS+hB6+t85v3Tol9Oa5j9CsVJmRCsu9HMd2RvpCg7lOfRTotyd2s6GVnKk/XUemCsCe8VtX+YgV
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(46966006)(36840700001)(40470700004)(2616005)(82740400003)(40460700003)(8676002)(40480700001)(2906002)(36756003)(356005)(47076005)(82310400005)(54906003)(186003)(86362001)(1076003)(8936002)(110136005)(83380400001)(336012)(7696005)(5660300002)(426003)(81166007)(16526019)(6666004)(36860700001)(44832011)(70586007)(316002)(70206006)(41300700001)(26005)(478600001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 14:45:14.4370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab17c1d-d69c-4fb4-b1be-08da965fbbe8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416

Current code does not validate domain allocation failures. This will
result in random failure at later stage. Hence handle domain allocation
failures.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
Hi Joerg,
  With current code whenever amd driver failes to allocate domain we hit
  failure at late stage and it became difficult to debug. Hence I
  thought of adding this fix.

  I see that in commit 6e1aa2049154 you have intentionally didn't check
  the return value. Looking into drivers/iommu/* it looks like all
  drivers has domain_alloc() callback handler. But some drivers (like msm
  - msm_iommu_domain_alloc()) allocates default domain for certain type
  only. Hence I'm not sure whether its ok to handle domain allocation
  failures or not. Hence I have marked this patch as RFC.

  Let me know whether this patch is fine -OR- is there any other way we can
  handle domain allocation failures?

-Vasant

 drivers/iommu/iommu.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 780fb7071577..e8a1e7fbffb9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -289,18 +289,21 @@ int iommu_probe_device(struct device *dev)
 
 	/*
 	 * Try to allocate a default domain - needs support from the
-	 * IOMMU driver. There are still some drivers which don't
-	 * support default domains, so the return value is not yet
-	 * checked.
+	 * IOMMU driver.
 	 */
 	mutex_lock(&group->mutex);
-	iommu_alloc_default_domain(group, dev);
+	ret = iommu_alloc_default_domain(group, dev);
+	if (ret) {
+		mutex_unlock(&group->mutex);
+		iommu_group_put(group);
+		goto err_release;
+	}
 
 	/*
 	 * If device joined an existing group which has been claimed, don't
 	 * attach the default domain.
 	 */
-	if (group->default_domain && !group->owner) {
+	if (!group->owner) {
 		ret = __iommu_attach_device(group->default_domain, dev);
 		if (ret) {
 			mutex_unlock(&group->mutex);
@@ -1665,7 +1668,7 @@ static int probe_get_default_domain_type(struct device *dev, void *data)
 	return 0;
 }
 
-static void probe_alloc_default_domain(struct bus_type *bus,
+static int probe_alloc_default_domain(struct bus_type *bus,
 				       struct iommu_group *group)
 {
 	struct __group_domain_type gtype;
@@ -1679,7 +1682,7 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 	if (!gtype.type)
 		gtype.type = iommu_def_domain_type;
 
-	iommu_group_alloc_default_domain(bus, group, gtype.type);
+	return iommu_group_alloc_default_domain(bus, group, gtype.type);
 
 }
 
@@ -1753,11 +1756,10 @@ int bus_iommu_probe(struct bus_type *bus)
 		mutex_lock(&group->mutex);
 
 		/* Try to allocate default domain */
-		probe_alloc_default_domain(bus, group);
-
-		if (!group->default_domain) {
+		ret = probe_alloc_default_domain(bus, group);
+		if (ret) {
 			mutex_unlock(&group->mutex);
-			continue;
+			break;
 		}
 
 		iommu_group_create_direct_mappings(group);
-- 
2.31.1

