Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E723EC43334
	for <iommu@archiver.kernel.org>; Fri,  3 Jun 2022 11:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E0F784024;
	Fri,  3 Jun 2022 11:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B9EjnaDvwfZ1; Fri,  3 Jun 2022 11:21:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E96183F5B;
	Fri,  3 Jun 2022 11:21:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDFE2C0039;
	Fri,  3 Jun 2022 11:21:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A422EC002D
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 862BB83FF6
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:21:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5_08LU3JQ_LC for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jun 2022 11:21:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::617])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 482B283F5B
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 11:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWgyuF3y79qgh0B2cfv3pyI9Rlneswain7FhF3rnYdi/WbaFz2d0rqPcAHnKTYamdfGeBKO4n7qVNJJH50qh6McGpQAyrdeCaPNAWoN/+FMUtU50/bcSk6Z9EtTiVQedDkJpckgH4hO9U3LoYDqUuJ+/1/313jzeqi5VqsZoplF+svKACCfoDTbwJBIAzqM0umocWbVJ3zW+qKeAs8aoqJGx3HmAGYkiS+UekgSfb0x3AjB6K9gBypY2zg7g7/pVT4PxsCBDXOAHy3FxZ8QszEQzUIvfIFjuzQGSDhu7hORRj7RrU1C0E8Oio0pR+a6MwXRrZZw+oGn/uMrAPkACMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq+/9ZCEIO6kSNxiPz9PLDzw7HzIPo1kEiIYmshnfZc=;
 b=XSu/QmMdInKIhNF7FvZCLZtlduV0PoKV4iPedWXP3ypnEJEijgLQEprdThE0Xr7tug3qiNiQBdH33yPtuQCggXY8DfH8/EJv8sn77If4NN+JZSLK5EWoju5YXssr4iVuVD8io7gRFJ0Pmh/WDy1bcU+4FmbYyAM884/57HK7YGtBRIm95rvk85DEHvopA+CgSTg1NtHLPuP/nJfr+ConYwM5ek2G2WBPV3z6TR2qMOaOD3ReBziXPhFrE8V0VbFN2l+HiLr2F6bbvJlVylhSB9+LcSwA8o4PcO4siYgWQHU+vl+I+ViiTfdzpynHN/n/cLpvvPc1pbKF6wCszcYGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq+/9ZCEIO6kSNxiPz9PLDzw7HzIPo1kEiIYmshnfZc=;
 b=nEBiLlS3lN8NsWcANujsEyCBlQpml8lQF775AfHoPHxh1h2/wJ+/xQuUfkH/1q3z5P34/D3J0rR3irtgPqVcV+19GErYAGXgRopGBrGRe6gnZIcF7tfz7BLFej17tsjzUY5Vq3Im+tnxTWkzjAFE7RMl3h880h4nP/KKWbI0Nxg=
Received: from DM5PR13CA0033.namprd13.prod.outlook.com (2603:10b6:3:7b::19) by
 DM5PR12MB2374.namprd12.prod.outlook.com (2603:10b6:4:b4::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.15; Fri, 3 Jun 2022 11:21:46 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::77) by DM5PR13CA0033.outlook.office365.com
 (2603:10b6:3:7b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.6 via Frontend
 Transport; Fri, 3 Jun 2022 11:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 11:21:46 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 06:21:43 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v1 1/7] iommu/amd: Refactor amd_iommu_domain_enable_v2
Date: Fri, 3 Jun 2022 16:51:01 +0530
Message-ID: <20220603112107.8603-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603112107.8603-1-vasant.hegde@amd.com>
References: <20220603112107.8603-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ccd0700-9892-4753-e740-08da45533e9c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2374:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB23744B253A0FA9095E8A726287A19@DM5PR12MB2374.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxEKuNNYsH+FtCnE/Lp/FXtQXOe0QLZjDt4TXYEH+LGWF8xDfW/AnFaujNW9jK5JTAV8iduGizYTabFbnshn9QuYzUoo+EmJqfLqG2B72Mld+bBN7UmavWRURbAQ1hGGf224LQ5mRXkvcqimmDgkFfnio4rfcNlR25HNM3WZss1h6sy2ejbAXhIAC9AQ0KdJQj0m1BtqT++UCJTWOSRZpSowxBF5DeK6n6aY+WNBp4GufVqXRwsdfbtadxiqnw3+dt0sic06yj26li05qfKJnqoFB1nGA+14KFxkaLhj1b/i67o11YOgAjfFtubOaClMVyaLDS25XzAoFbJ56eH6bahQr5uWGdXUQiYogOPIf53AJRDgPi+2MNFt02sDoNanDRILy1CpAjSBpMXKvOCDU22dpieeDfG8azbZZGYB2bukTXOcAfs8T3JKsYUzma9e+ZZJ4FOFGo1i9zt+oti18HuK9013oII7NEB+4nnAMiNM2zTi/PmQecM9KVS2ccfrnpZsxxgTJZ6tcwzdvNblw+koRB6mi6GtpqrCokr1lHwFm8tiikMWA4JDAEFTU0M4usAiOUuCMboWqwTc77lfR1PKyBSbTVox2JLhqrAfdU1/K4B8JV43GSTfk6xnyH7kV8BSbCYlWzvh1fV8y2YjRaEUI2nbvkq6Y+CuAUvk3CjN4mXCJG1V5NdbmMeRrqEGYCp7fG0PHpRNO77m+Uhyjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(44832011)(8676002)(86362001)(47076005)(54906003)(4326008)(186003)(356005)(36756003)(81166007)(40460700003)(36860700001)(6916009)(426003)(316002)(8936002)(1076003)(336012)(70586007)(70206006)(16526019)(2616005)(6666004)(26005)(82310400005)(508600001)(83380400001)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 11:21:46.0481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccd0700-9892-4753-e740-08da45533e9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2374
Cc: Vasant Hegde <vasant.hegde@amd.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

The current function to enable IOMMU v2 also lock the domain.
In order to reuse the same code in different code path, in which
the domain has already been locked, refactor the function to separate
the locking from the enabling logic.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 46 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c95c09c56b37..059e699c43d1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -85,6 +85,7 @@ struct iommu_cmd {
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
+static int domain_enable_v2(struct protection_domain *domain, int pasids, bool has_ppr);
 
 /****************************************************************************
  *
@@ -2427,11 +2428,10 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 }
 EXPORT_SYMBOL(amd_iommu_domain_direct_map);
 
-int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
+/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
+static int domain_enable_v2(struct protection_domain *domain, int pasids, bool has_ppr)
 {
-	struct protection_domain *domain = to_pdomain(dom);
-	unsigned long flags;
-	int levels, ret;
+	int levels;
 
 	/* Number of GCR3 table levels required */
 	for (levels = 0; (pasids - 1) & ~0x1ff; pasids >>= 9)
@@ -2440,7 +2440,25 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
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
@@ -2448,24 +2466,14 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
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
+		ret = domain_enable_v2(pdom, pasids, true);
 
 out:
-	spin_unlock_irqrestore(&domain->lock, flags);
-
+	spin_unlock_irqrestore(&pdom->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(amd_iommu_domain_enable_v2);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
