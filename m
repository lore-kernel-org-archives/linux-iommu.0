Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8C1C30
	for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 06:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhkSHGaTysaU3NJRKc5rs1bRDOQA5rQpXpnLoF9rB/geU1JmODDWUE8oFkwNM9cCscQz0Zkr8KGO+pgq6JaY/hFLpKXAEU7UjLJI7VLur7D/GMQluKMflxhnCT0JqcsORKFayyy/EAb64C9mkta3pUgwKQeM2+kcVrLKv4dqwAB6AV/HKiBVClRRUcK/4qbAfSCcJ0G/GDTCRiP2l7eyXhTRSXY/s6Vi+JkavS5YBeMpyNfYXPQKrwgdJqE3BXm5o8TE30HI8BTMDjTc/XZJ12aHDzEuxaY6TxLmZUk/IZAgIYgU8BR7+Ras0vYUtB7+ws0zYLTyOdwEjr9k/a1nWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lZtPFN9J46r87gV/oFQGCz1hzu3pMkSMLJKQL73gIA=;
 b=iA5K4xw/xan+KxqP8CMrkSVTdJcTMQOylLUhsu62bD/gKJvq64FyRdMTUobwCEeyz3lQpnCqoxLcWVg8COfLwBMVGJMOFMj7cyKE0QAOQCWkSztQP6wnTcajXaIFeVnU06EakRZ/GD2CT/cMKrIzl5/uyIY80lSKyMsCXiyxIpgw4a9TxiCX04HuxnFKlh3mpKXg5AiQAQOL9THWjo/GB/sMdC+Neoy7mrENK4RFp+vhnOt9f0JACS/PpLrzRZyM6b4zAmdmvP376L2QZGJmgD5cMTIS3cenSbAdQYvMKPeNS4Rh409Nkmhjdm8abp79haSyhgZOkMFrN90Xc6VZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lZtPFN9J46r87gV/oFQGCz1hzu3pMkSMLJKQL73gIA=;
 b=JuVowxzK1jIbrW4im8DY2hCFKGMjcpjPkMqGNveJm1phgJzdRW/qYeJjMDzN+iNEG7i5reZNU4D8ko993upH0KpwPF05RdKLQSYcWsO5PO0kUeVSvtALP/USVfVCntEEbZgCE4MUEh2L79ZKgsS56NaEXz69a+KHBhyIjiOhNGg=
Received: from DM6PR02CA0164.namprd02.prod.outlook.com (2603:10b6:5:332::31)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 06:42:49 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::43) by DM6PR02CA0164.outlook.office365.com
 (2603:10b6:5:332::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Thu, 25 Aug 2022 06:42:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 06:42:48 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 01:42:44 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <robin.murphy@arm.com>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 4/9] iommu/amd: Refactor amd_iommu_domain_enable_v2 to remove locking
Date: Thu, 25 Aug 2022 06:39:34 +0000
Message-ID: <20220825063939.8360-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825063939.8360-1-vasant.hegde@amd.com>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d1f58879-773c-473f-bcb4-08da866506ce
X-MS-TrafficTypeDiagnostic: PH7PR12MB5733:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/9d6KseHEyoECAxPACQvz6sW3vlwX6nVi7Dn2x6870T+wB74PcxAoW/O7hHm+9Vi/819q/UmqYc0E6TSaJTrOLarpbQnmJNZ9zqgYgkGyLDMOK7DvbDmY+Gvcztgg/1EBuKwv9bujhyoIPTJWBtljhqT4MfCEezvua6y56W6n/zssJGf5RTqY5Tw1zgM66DbZgsATMdheWe4Wn6mtQAQG+6LoBNSOhCp91Skt9FrLkpmL5ZPF9X3PDRxTY8JzZi947mP53eq0ihUdKftdZIT5n+pl6ZbZWySn0wnaP7KbykByPJWu1fUgIf2pXUwEnRnZ9c1KRcHnJ7ZwymdEVOoF/EiEXdJt13Im8E6L87TbdpzNplqLoBJ3NSN+CdRo7/mHAfjvH3GHTGXuRHE5GxKkulM94s1ZWOg2c+UKT5HwyfPenHr9FfZk2wHuC48DnQeFKlJ0HkyQwD0TvArInkcQP+lEh/cyYDq4+jM2Ug5uNPi0WzSiy9ucBfY1byaxXPg3ibvd4wMgDF9wkDCc4XjsD/9qoxh8jmFX9PYCJBQbE8J7QuzA6XpmR8cX8ompUBrIbmTGwSwzLsS7RnSIngaNip9lLNXC2Mq23T+GUsoeh+asbMyA/b7fMzV6m7QG5OGIqRQxbz2nKw3+YbIRpDDskKgMrv7hn9Y3yUVHX3LbOB5lFBcrWPvyzynTPTeEWr5Q4HnWKHxXyQBUDucfu75cuY7X3D6Rz5AJN0Oa9E5tdZunbT0SWT+xANDLiGvx4qwfXPE+b5HvkMMUEK37A3QEow74BOhvcTGGY2w9gILEyQL+MsYgsU2QznYs4k9nKIO
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(40470700004)(36840700001)(110136005)(2616005)(478600001)(356005)(54906003)(47076005)(81166007)(316002)(86362001)(4326008)(8676002)(8936002)(40460700003)(336012)(186003)(5660300002)(426003)(1076003)(70206006)(16526019)(70586007)(6666004)(44832011)(41300700001)(26005)(82740400003)(82310400005)(2906002)(83380400001)(36860700001)(7696005)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 06:42:48.9439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f58879-773c-473f-bcb4-08da866506ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733

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
index c3733884377b..1f8067615386 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -85,6 +85,7 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
+static int domain_enable_v2(struct protection_domain *domain, int pasids);
 
 /****************************************************************************
  *
@@ -2451,11 +2452,10 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
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
@@ -2464,7 +2464,25 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
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
@@ -2472,24 +2490,14 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
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

