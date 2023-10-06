Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A915C2
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CdskBlb1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoMx1kR0nGqns7BdirmlqHSv8eWTiH+/Bsu3EEDS27uyUrh+wdjB7X9HEI5fUBpMgD16QPsJNs8o53lVVROpGuIEyWwwUWEd9F5EddSIhAjXFFiR8tz8rXhXxSdaLvPif6aqpEQBwnHQbU9kFjSMbNPxk0KBSFfSlI4w9eDokQ5jHnci/TYEZ/tmEzoq3MPv+r9TV4crM49JtwNCqkekYXau+KxHuyag/ylGMD6q6mHzGtENPYlzsirYAi/Ed4o8jwSWNRQL4yncktedmU9B23jPl9eNE6y5ih+rHaQVzqCn1lBfVXkwmxLxMr94BR5DiWuP7hIYnlaCE/+KtAgA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S3ecASbmeUZz6XEIWazFUNFwsnjs8Y4BvJnO5Dx43U=;
 b=IP3qa/vPTWlh58iKDc8yVZ0uUpKjUbvCAcuy46brswskLKYGpQX4TkXr6moOXXs9lVocmqXXNR9o4+K1UotV6F2h3pQ9jhORwJumE743QACONkHnKmPOJvSQ0zbPcS4rrZGcgbYXm5+1M8AHFNkxSuv2VEkMh+WBZvP7dNttfPKlPu8zQwKrmIxRtgX9EpeLDO9mt18gR/yb73GdVOFs6nVBD+6+wxP8YIs3tXbzSywIOy4/2n1t40/uwMKxsambtZTAiqhoKrx24RdeJ3KAgs0RpHE0a0C3a8rVvluIqP/r4Ap8J/92o743wcAKwtJwwprv/6dI996guInS3WVGFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S3ecASbmeUZz6XEIWazFUNFwsnjs8Y4BvJnO5Dx43U=;
 b=CdskBlb1QEKMNR+1rrN82KGHkA2lT6JXUio4GKFbDBoJrgdVRYlXzkAFNZBNC4R5lf/3bg7oCjXagLWNrmulwgtQuWJxhLyodMrbn1BuvcDaDuxzvIT4WaMzMn2v+1z6gj0pIpisRi7Ilsf6CIW5FY6nX9Qr5erx+38R/ulMo2M=
Received: from BYAPR02CA0049.namprd02.prod.outlook.com (2603:10b6:a03:54::26)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 10:20:12 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::cd) by BYAPR02CA0049.outlook.office365.com
 (2603:10b6:a03:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.31 via Frontend
 Transport; Fri, 6 Oct 2023 10:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 6 Oct 2023 10:20:12 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 05:20:03 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v1 12/13] iommu/amd: Remove unused flush pasid functions
Date: Fri, 6 Oct 2023 10:16:23 +0000
Message-ID: <20231006101624.5912-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006101624.5912-1-vasant.hegde@amd.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7ae1ff-a273-458f-14b4-08dbc655d350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tplvoUCCRO0jTmrAh+tEDRB6dqH1EHTqieTLuOA8eUFJqD78JkAM5Ov4P1lvcdpNYFVK8sAiQE3BAB1OcytPUbA63nqaDjRuDRY7EFVySWx5c1ecujLqTs9ij+AYYsBaQCZL8R+KyPiqXjdBK4DJF3yB/7QeF/RAju9RbprGnJdip9cd5QKunM0iD2qOpheKzRKsubTpwFSmulZNEBP1c/Vmi5qW+tOXe9uT6Uhj/QpdtltdMJ3hX4cjrmZ9y6YNkmZI8FLSoUTgOv1j1CMvv28qT9sro4GWku1jluw079AwW2gOj0sEn3Firj5Ws/AUkEr0yX+h1RPJjs+hUm268RNf9bSBQF/gW92cBc5aaf1s+W/e5vQZgBGRceDZSj8ZLif2Ta/44ZDLJ2QF+rHR5fcYyCVpVPfwSQJ4dbOIrcON0mfUcr1bw2sbImmH32GlXEiOJSpalOl1wrzrje/G2RGSwle+4Wjn6rT9pG1QrHgfkOrTPCAZ8ufOiXl6CSm0TtnfvXPFIHxPqbMmjb0bltHyBd47LOz2f5BHqhjDIEcHBVT9qLykBbOX1ihFl/Qs+tC8EudWAkd2f2Iw7l7oq4vuc4YcymYQn74qHxkny79BIDh1kh4/dSDLQiOkHEpkMRWrtRxI1KXMa4J7pMyaPQRYa2S4K0OpPV9Q8F4jJ9URAq4aRXmfb9fFF/CRKlIeXAbpcm5It4kSgKH14oaP3R7rGDDCEV5QGtzzGQ3TtjfT+yz/afpPjX6U8lydYzKFyZQcHJkHZTPyn+kaW61fWQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(7696005)(6666004)(478600001)(336012)(426003)(83380400001)(2616005)(26005)(16526019)(1076003)(2906002)(316002)(41300700001)(54906003)(110136005)(70206006)(5660300002)(44832011)(4326008)(8676002)(8936002)(36756003)(70586007)(36860700001)(47076005)(81166007)(86362001)(356005)(82740400003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:20:12.1255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7ae1ff-a273-458f-14b4-08dbc655d350
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037

We have removed iommu_v2 module and converted v2 page table to use
common flush functions. PASID related functions are not used.

Also when we add SVA support we will be moving to per device GCR3 table.
We cannot use current flush pasid functions as is. Hence remove these
unused functions.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |   3 +-
 drivers/iommu/amd/iommu.c     | 100 ----------------------------------
 2 files changed, 1 insertion(+), 102 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 088890f9618a..38b3f4562f3b 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -53,7 +53,6 @@ int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
 void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
 
 /* TLB flush */
-int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid, u64 address);
 /*
  * This function flushes all internal caches of
  * the IOMMU used by this driver.
@@ -64,7 +63,7 @@ void amd_iommu_domain_update(struct protection_domain *domain);
 void amd_iommu_domain_flush_complete(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *pdom,
 				  u64 address, size_t size);
-int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
+
 int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 			      unsigned long cr3);
 int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 764a5656b56b..fca1f969845d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2552,106 +2552,6 @@ const struct iommu_ops amd_iommu_ops = {
 	}
 };
 
-static int __flush_pasid(struct protection_domain *domain, u32 pasid,
-			 u64 address, size_t size)
-{
-	struct iommu_dev_data *dev_data;
-	struct iommu_cmd cmd;
-	int i, ret;
-
-	if (!(domain->flags & PD_IOMMUV2_MASK))
-		return -EINVAL;
-
-	build_inv_iommu_pages(&cmd, address, size, domain->id, pasid, true);
-
-	/*
-	 * IOMMU TLB needs to be flushed before Device TLB to
-	 * prevent device TLB refill from IOMMU TLB
-	 */
-	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (domain->dev_iommu[i] == 0)
-			continue;
-
-		ret = iommu_queue_command(amd_iommus[i], &cmd);
-		if (ret != 0)
-			goto out;
-	}
-
-	/* Wait until IOMMU TLB flushes are complete */
-	amd_iommu_domain_flush_complete(domain);
-
-	/* Now flush device TLBs */
-	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		struct amd_iommu *iommu;
-		int qdep;
-
-		/*
-		   There might be non-IOMMUv2 capable devices in an IOMMUv2
-		 * domain.
-		 */
-		if (!dev_data->ats_enabled)
-			continue;
-
-		qdep  = dev_data->ats_qdep;
-		iommu = rlookup_amd_iommu(dev_data->dev);
-		if (!iommu)
-			continue;
-		build_inv_iotlb_pages(&cmd, dev_data->devid, qdep,
-				      address, size, pasid, true);
-
-		ret = iommu_queue_command(iommu, &cmd);
-		if (ret != 0)
-			goto out;
-	}
-
-	/* Wait until all device TLBs are flushed */
-	amd_iommu_domain_flush_complete(domain);
-
-	ret = 0;
-
-out:
-
-	return ret;
-}
-
-static int __amd_iommu_flush_page(struct protection_domain *domain, u32 pasid,
-				  u64 address)
-{
-	return __flush_pasid(domain, pasid, address, PAGE_SIZE);
-}
-
-int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
-			 u64 address)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	ret = __amd_iommu_flush_page(domain, pasid, address);
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	return ret;
-}
-
-static int __amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
-{
-	return __flush_pasid(domain, pasid, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
-}
-
-int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	ret = __amd_iommu_flush_tlb(domain, pasid);
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	return ret;
-}
-
 static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
 {
 	int index;
-- 
2.31.1

