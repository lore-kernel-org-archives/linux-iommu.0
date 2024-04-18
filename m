Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174A815D5A8
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436702; cv=fail; b=tR3NEO4T9qCsAy2+RAw3vReqhRMHDprzedYp6vadXw1sz75/kj5x4B1UrFbGkLBoHUbLV8TXNj9gG7oplPKGLeJ0SUfzwgrFwnsMcF2MzTRTcO2G3jTXTLMvtTSe0CUEpe9uQUxdytW/NZ+uqE3DKPy9xFxJzD+QQRe4RJPc9gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436702; c=relaxed/simple;
	bh=/xJ39dzoQJFrS6dTbXBGs3aObo8/bTMJ74ogBbM7Cv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpuK6SyjHmjfmEo8+V6dTs6jRnOUM+NiLnzdgXLGH8UqOWLy3ha+tUIKjsNqhzUVjY8SmkSHnrwkYle6VRHXi4+3/gTc1PUwhdDBYClnpssMa2oDZRXUR8b8qFebSgoHm/khatmB73/5Fkb2DL+H77NsPS4os9DO5JM6FmxVV1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bGyiSDcN; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bGyiSDcN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuePNGCFyZPy4DjUE7upMAU+9bQumYrF/SayBZUSmjvLN5V5D9Nk8mLhASh0p8/Iaiq2yviHSh1TVx2YyOOsGckqKsXk5OuM5m8q1sytyNEx8+koeWz0OF7CyLxP7DWQ7jLNbTUml8KUXEnBtlbTyl8Nm/7yvxEau8mkFLe+VjbFxrX8Yzfm9leRGVHFcnXjPAkOdFAIGuzf+JFgzmgz33cFer6qgRUs6dkT3aQrt2zUqyaesirdH5uf1lLdrQZPGwOqTAakY3ygcBsz+xTYwMMYXQcOVpfd1hyZ3I0L6np8XBsRoTsh6aqHSOaqB2vJtnJ53X8pZ3CBAjSjC31TVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C29ASzg2w6Ni79vF08rDk6wZKnUgsEQmbzNb+qaALRk=;
 b=iF8kI0QiXwlIBoaDGbmyaqTktJTH0wZ5tNlbSbmGpVreLyIvhNDC6lOSqByuBhiedFcfBM/esq3Zd2mYzbdT7n5M4lHcEMYJ98Wz2zdWqEln+haWyNEhck2eG9uz6/orBFKAY4tdigWPJYrQmUuRCBUI8prcnh3PcUL5oettUnaevA0+2AwqHZmXnAteXEQz+S5zMzO4Eqg5I4rWznblnzQpTPdJZhq2cErTGrHl1NFErreUR9rMOi7SuxtqM/97QT113uFF8mLhwIZPKmJd0geT4jffiJc+vnC7wrwNZYRtkJ61LrLXz/1nwl4R769dyxOj7NzRwk+AFtjkYUiXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C29ASzg2w6Ni79vF08rDk6wZKnUgsEQmbzNb+qaALRk=;
 b=bGyiSDcN/9UBUmHVTC26xN5ZvzTurqjmAxAzYWOtr4g/BTRsCs323JF8nsV0FZ7zuYgFMGXvbR8rTyzJsp32PCouVuIQ7Jph9PqjuQtHx0nqraxxWAHzEjMphX9XuycbDMSI9/mw8P0nxVSG5Te3r6K+linInFxPaYMww3/Sqyo=
Received: from DM6PR07CA0129.namprd07.prod.outlook.com (2603:10b6:5:330::23)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 10:38:18 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::b2) by DM6PR07CA0129.outlook.office365.com
 (2603:10b6:5:330::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Thu, 18 Apr 2024 10:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:38:18 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 05:38:14 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 15/15] iommu/amd: Add SVA domain support
Date: Thu, 18 Apr 2024 10:34:00 +0000
Message-ID: <20240418103400.6229-16-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418103400.6229-1-vasant.hegde@amd.com>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7a6203-e4b2-4ae7-fc23-08dc5f93a91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NyYysB4xQkRmGnZIGM6tmfaGCX6EwjYa1LYH69zEnx++BP4ohnkj7/x17VVBAE4PLwvP4uxae57mo/HGiNNAolayI6XzVsWdPRDNToLg9zAK3ftX6GTc3yn6L0RCNLiBQePxxhr266Qp2T04hWHycxY5xDyqMNP+By26OQrJScbeRA+KfIpKtyBF20MHQF1vWN/RlWZqIkSq5n+32g83Ee/7+fdgjox+AZnmyMuB3RzJnWEH4zIBO4AD53t8U3WedUKFSuc5rE9ZWKvlOZ93by63oW1bqkXs24z2wTOzVffzs5PP1Ad9CA980aA5ePKN3DhKY/qRS8FI+KWC3a/fjbnnI8xTtMUVxqGU9q6sNa9aaWndTlbUKavxrj1gS9JetbxEgSRtQNRvsmKxvAf+OpGOl7Ii4ch56B52hujQCQg03uGdPFTWm/XqfgB5Ar7F6GWBuInTXH/zWs7MaqUve8qbifikKK7okycbXj3BRtPCQm6bLTrlgpvseTS46qpq6cw1tMoV4HurLAHxeI9z/IxUlQp2EjFPI6NsYhL/1KDn7KJlc1zR+wTplrXsZf2gxd73ajUVgQxgGDS8qNqs3XyJrUwy0zIqnZR/c24xVSCkw6Wb6xBi9D18AdJPDaAtSWRpvASgkLVZ3Pp9nHCIaqRSbs17DFUE63/OXhZkxRHdnOkBvn0s8G3H7pumXoCPBxaTj6gW6hhyy0Nd5u1EQ6tbgKTK1i/t80nvMWOVUYOgyWZTx+1EXcJQ1zUUMsQp
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:38:18.0779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7a6203-e4b2-4ae7-fc23-08dc5f93a91a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824

- Allocate SVA domain and setup mmu notifier. In free path unregister
  mmu notifier and free protection domain.

- Add mmu notifier callback function. It will retrieve SVA protection
  domain and invalidates IO/TLB.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h       |  5 ++
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 10 ++--
 drivers/iommu/amd/pasid.c           | 80 +++++++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 49462d073132..0005da7af739 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -45,6 +45,11 @@ extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
 /* Protection domain ops */
+struct protection_domain *protection_domain_alloc(unsigned int type);
+void protection_domain_free(struct protection_domain *domain);
+struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
+						struct mm_struct *mm);
+void amd_iommu_domain_free(struct iommu_domain *dom);
 int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
 			    struct device *dev, ioasid_t pasid);
 void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ed9971cd3f0e..2b76b5dedc1d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -586,6 +586,7 @@ struct protection_domain {
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 
+	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
 };
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e0f770c9c9a8..f7ba6552ccad 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2280,7 +2280,7 @@ static void cleanup_domain(struct protection_domain *domain)
 	WARN_ON(domain->dev_cnt != 0);
 }
 
-static void protection_domain_free(struct protection_domain *domain)
+void protection_domain_free(struct protection_domain *domain)
 {
 	if (!domain)
 		return;
@@ -2323,7 +2323,7 @@ static int protection_domain_init_v2(struct protection_domain *pdom)
 	return 0;
 }
 
-static struct protection_domain *protection_domain_alloc(unsigned int type)
+struct protection_domain *protection_domain_alloc(unsigned int type)
 {
 	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
@@ -2346,6 +2346,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	switch (type) {
 	/* No need to allocate io pgtable ops in passthrough mode */
 	case IOMMU_DOMAIN_IDENTITY:
+	case IOMMU_DOMAIN_SVA:
 		return domain;
 	case IOMMU_DOMAIN_DMA:
 		pgtable = amd_iommu_pgtable;
@@ -2465,7 +2466,7 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	return do_iommu_domain_alloc(type, dev, flags);
 }
 
-static void amd_iommu_domain_free(struct iommu_domain *dom)
+void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
 	unsigned long flags;
@@ -2833,6 +2834,7 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
+	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
@@ -2848,6 +2850,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
+	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
@@ -2860,6 +2863,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
+	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
 	.probe_device = amd_iommu_probe_device,
 	.release_device = amd_iommu_release_device,
 	.probe_finalize = amd_iommu_probe_finalize,
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index c96384ae3442..04beb2217d93 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -56,6 +56,49 @@ static void remove_pdom_dev_pasid(struct protection_domain *pdom,
 	}
 }
 
+static void sva_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
+				    struct mm_struct *mm,
+				    unsigned long start, unsigned long end)
+{
+	struct pdom_dev_data *pdom_dev_data;
+	struct protection_domain *sva_pdom;
+	unsigned long flags;
+
+	sva_pdom = container_of(mn, struct protection_domain, mn);
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+
+	for_each_pdom_dev_data(pdom_dev_data, sva_pdom) {
+		amd_iommu_dev_flush_pasid_pages(pdom_dev_data->dev_data,
+						pdom_dev_data->pasid,
+						start, end - start);
+	}
+
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+}
+
+static void sva_mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
+{
+	struct pdom_dev_data *pdom_dev_data, *next;
+	struct protection_domain *sva_pdom;
+	unsigned long flags;
+
+	sva_pdom = container_of(mn, struct protection_domain, mn);
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+
+	/* Assume dev_data_list contains same PASID with different devices */
+	for_each_pdom_dev_data_safe(pdom_dev_data, next, sva_pdom)
+		remove_dev_pasid(pdom_dev_data);
+
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+}
+
+static const struct mmu_notifier_ops sva_mn = {
+	.arch_invalidate_secondary_tlbs = sva_arch_invalidate_secondary_tlbs,
+	.release = sva_mn_release,
+};
+
 int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
 			    struct device *dev, ioasid_t pasid)
 {
@@ -120,3 +163,40 @@ void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 
 	spin_unlock_irqrestore(&sva_pdom->lock, flags);
 }
+
+static void iommu_sva_domain_free(struct iommu_domain *domain)
+{
+	struct protection_domain *sva_pdom = to_pdomain(domain);
+
+	if (sva_pdom->mn.ops)
+		mmu_notifier_unregister(&sva_pdom->mn, domain->mm);
+
+	amd_iommu_domain_free(domain);
+}
+
+static const struct iommu_domain_ops amd_sva_domain_ops = {
+	.set_dev_pasid = iommu_sva_set_dev_pasid,
+	.free	       = iommu_sva_domain_free
+};
+
+struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
+						struct mm_struct *mm)
+{
+	struct protection_domain *pdom;
+	int ret;
+
+	pdom = protection_domain_alloc(IOMMU_DOMAIN_SVA);
+	if (!pdom)
+		return ERR_PTR(-ENOMEM);
+
+	pdom->domain.ops = &amd_sva_domain_ops;
+	pdom->mn.ops = &sva_mn;
+
+	ret = mmu_notifier_register(&pdom->mn, mm);
+	if (ret) {
+		protection_domain_free(pdom);
+		return ERR_PTR(ret);
+	}
+
+	return &pdom->domain;
+}
-- 
2.31.1

