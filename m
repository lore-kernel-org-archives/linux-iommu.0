Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFADC15A9
	for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 05:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNsRxUvEOU0CpQoCxcq2BDfemCxF9dDZb67cyEwLW2Snhyot384Ujwty0p3pW2ZXn3nY7Icho/+rZi5fiZmnfk8uwisLw1ejhZM0kY8/BEKhuBkja/uG992o9SaE7iBt/PiqPZsRbSz1u2sQfoRxVKOYx5UV68Au+aKFeUWvFgNDSFiGityUgNCUqLZOT26xbSSRHKuDRjqEISl78cteUkXIjUTiNQojKTnCUqSOYUmnWEi/rJHd6PuimJWnXG1e7GM4WMso8q6j8ti5666t6vxuutBG1YYMQiUnc2mJFukWdxyAHE3wJ3U5shlQ+ULsr6cilDR0NI3zVFjKIvSWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzarWPO656UqpRiioPQRdMCL3VzsOxEEKutFVrgoEVU=;
 b=Yx7RPXoU3NtiEMEh+BW1kvgL2mCMtKOUo9UjHj/jU7eA6oalFdkZTZJyooiZGMTVWwtQp83Fz0c3jFU7cS1/r7eVFItSY1Bh7qvdMgDgD9DTIDpbbyyvxz8MAiWu1iLwUp6Lu3DgN8/Liam5SjsqS63YwDODQk0YqOwnFYOP9U9MzZ1ufm+U0FlL/O+EbeJ/Jq/WJGtAblHu/ZT/Z3sSw/06N4ty3ZqiIHD/C7xdwKJ+nMk15CnbdOBkZBOXS9k4cv0u0c7tj9SWUTSS/H26ASghBC5Z+iq4JMhIEChCwReDGA9xOx2GzAcRqZXKbaZj/5VE6vxnE2DIFflFoHa4jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzarWPO656UqpRiioPQRdMCL3VzsOxEEKutFVrgoEVU=;
 b=O2Tb4jPn9n7dacte8EQsc1hD9Ttqns2m5RGZvKFWTbEO9p6YszK8tWOQA1TTiOfLPMXsxquMdUao3z/6Vxeuv8JKlIeR5j2M/zWO/s8Y61MmFJQEIm2s8TnbHt2/C22eyiVL2BniCDLh4L/WDbblhuwB63QYxE/xjw+aL0vafaQ=
Received: from MW4PR04CA0381.namprd04.prod.outlook.com (2603:10b6:303:81::26)
 by CH2PR12MB4889.namprd12.prod.outlook.com (2603:10b6:610:68::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 05:31:18 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::51) by MW4PR04CA0381.outlook.office365.com
 (2603:10b6:303:81::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Wed, 13 Jul 2022 05:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 05:31:17 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 00:31:14 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 1/6] iommu/amd: Refactor amd_iommu_domain_enable_v2 to remove locking
Date: Wed, 13 Jul 2022 11:00:29 +0530
Message-ID: <20220713053034.12061-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713053034.12061-1-vasant.hegde@amd.com>
References: <20220713053034.12061-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e5e9ddc7-407c-4acf-cdc2-08da6490e95f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4889:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mXe9Gpph3jSeyB7k5QGxKzZ4QxPcTcR+WOyi7y3xKuG6qW5WsQvBxOFEAcsUQHQ+uqfx/TLbcQtn69Yb9iasH0mSj530IRLQfGC/yEcTNvBit87j9j5k6o2t3y0ozuSRay08iak5PlzMztS7N98b9K0EIlSk3fM0+T3jRtyYG9SWmoTs4xaEwPEUX658wi4vc2qw4I8J6JDtwpaB7cR9YQYzD8NNtN7GKoJxt1+ZgWImixilvV52pDiJ54KSY8lZTG2h++Yik0BzAA651I2euMmMo9mi2oDObGwQsCkWugJt7iX1Gb77vwkn/z75Cvw3Nl4BLSahh7yXP65fmpAmvrhULDAeH5LTokvDsFyYvnjZj2dIwMDjU7jtdRyFCxDU+WvzWNmKXrMdt7V0vsUI2J3RTC3wAZVgFOEgzPge7jEAibU+BLkAhAXhe6dS1d17jG3H4xcmD54WtaMRsJZXp7SjbRuSebfan4oeIIltLxXHi8w+BHvwuDCOGfpuxLPA7eYMauEUogCCwux2dZ9OIo/63nGVx9fySoCATJBS2NLWNJA/2AM2SF6kIQckSvf69XVc4+WjC6iNOhxYo4301uD0qPELlsC08hvV6OeBRrOLNIv348+0PQyJEWUdHXniEuJzejhM2n/lmdn94iF6C7vA+7DiyAPqbkvTeE0B/m2JfOzH6r5nDfm68TX2XvqxtUHgTqcjZf/6JiONt7hWbHNgijzxmZ6dREMZdo2eC3rklkfteRYhHzbNSuKKQjjqpyKDbz6CR65mS74vacTOv3xQM3WUslQ9yim6Mykw31XLs0WUeMjWCwpaTM6fPNSSVohJdyo/JbDAzAhTUe4oLG3tpue85nEmIfrwuzWmsuw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966006)(40470700004)(36840700001)(81166007)(186003)(40480700001)(47076005)(82740400003)(16526019)(36860700001)(426003)(336012)(83380400001)(5660300002)(4326008)(82310400005)(70206006)(54906003)(356005)(110136005)(8676002)(36756003)(316002)(70586007)(6666004)(41300700001)(8936002)(2906002)(40460700003)(478600001)(1076003)(2616005)(44832011)(7696005)(26005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 05:31:17.7909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e9ddc7-407c-4acf-cdc2-08da6490e95f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4889

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

The current function to enable IOMMU v2 also lock the domain.
In order to reuse the same code in different code path, in which
the domain has already been locked, refactor the function to separate
the locking from the enabling logic.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
Changes in v2:
  - Remove unused has_ppr function param.

 drivers/iommu/amd/iommu.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a56a9ad3273e..fd5dc6541569 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -85,6 +85,7 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
+static int domain_enable_v2(struct protection_domain *domain, int pasids);
 
 /****************************************************************************
  *
@@ -2429,11 +2430,10 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 }
 EXPORT_SYMBOL(amd_iommu_domain_direct_map);
 
-int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
+/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
+static int domain_enable_v2(struct protection_domain *domain, int pasids)
 {
-	struct protection_domain *domain = to_pdomain(dom);
-	unsigned long flags;
-	int levels, ret;
+	int levels;
 
 	/* Number of GCR3 table levels required */
 	for (levels = 0; (pasids - 1) & ~0x1ff; pasids >>= 9)
@@ -2442,7 +2442,25 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 	if (levels > amd_iommu_max_glx_val)
 		return -EINVAL;
 
-	spin_lock_irqsave(&domain->lock, flags);
+	domain->gcr3_tbl = (void *)get_zeroed_page(GFP_ATOMIC);
+	if (domain->gcr3_tbl == NULL)
+		return -ENOMEM;
+
+	domain->glx      = levels;
+	domain->flags   |= PD_IOMMUV2_MASK;
+
+	amd_iommu_domain_update(domain);
+
+	return 0;
+}
+
+int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
+{
+	struct protection_domain *pdom = to_pdomain(dom);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&pdom->lock, flags);
 
 	/*
 	 * Save us all sanity checks whether devices already in the
@@ -2450,24 +2468,14 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 	 * devices attached when it is switched into IOMMUv2 mode.
 	 */
 	ret = -EBUSY;
-	if (domain->dev_cnt > 0 || domain->flags & PD_IOMMUV2_MASK)
-		goto out;
-
-	ret = -ENOMEM;
-	domain->gcr3_tbl = (void *)get_zeroed_page(GFP_ATOMIC);
-	if (domain->gcr3_tbl == NULL)
+	if (pdom->dev_cnt > 0 || pdom->flags & PD_IOMMUV2_MASK)
 		goto out;
 
-	domain->glx      = levels;
-	domain->flags   |= PD_IOMMUV2_MASK;
-
-	amd_iommu_domain_update(domain);
-
-	ret = 0;
+	if (!pdom->gcr3_tbl)
+		ret = domain_enable_v2(pdom, pasids);
 
 out:
-	spin_unlock_irqrestore(&domain->lock, flags);
-
+	spin_unlock_irqrestore(&pdom->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(amd_iommu_domain_enable_v2);
-- 
2.31.1

