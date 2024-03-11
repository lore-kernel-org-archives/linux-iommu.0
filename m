Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7481426D
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148266; cv=fail; b=UUx6ph6mWZMMKFRIapLEloFVsDzsDihcs/cHhnHs68+g9BAG7aHl84Ei52Ff+zxtgV4GkBffw+kD8sGZcxdpXpYCznh1QIIEmZDEziP47SFwhbFWNB5Oq9dhxCBWyz3XJprBy0t0Epxh5X7LiUa5b6seB6bE1ccZ9gDKCi6hxXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148266; c=relaxed/simple;
	bh=/q3xaVfb7zPszDP7btgDCnaEXh8t5R1c12lpXdcepa0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oyeweg2sT82rbW8VrjnM8BCA8zaMVlGcyVDTHR0ZrI4uSt6YXKRxeal5qyP9o6tuklrFCJHasLwWOiuklB785mrx/AZqFsvSaNXw/8EWh0+HOPURMPKRNNmTM46y0TqTLOqfK2Wazh7/gAj6sNdTM9vkCok62jt8hhIdTZb6Gow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZHYhtuTF; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZHYhtuTF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G16gxwCquDvNBs7J508gIZOxBTt/FCALa5PELY1X0yJHqh1OifnK8TOW63ke1ExFODV0jAybMhB1lutIS3428Jl8WHCMKnOcOR12yVgvP+J+JDmRf6dhLWRKlkOt+mu9xM2zSZ7QDnks4I4b/oTICZoWpwuZyuMcic+66NjyttQDPMyzHevlxu6eAfDBnDTNM64t/v6X1oz98P5LnOFd6CNXY0doZjInIyzBVMEBwB8+ENCoXGNHIN238S04ABA5yNUoKKozerqzT/3Sf1bXKlIvZ9NFxDmJi0MZM2+AaNvgE+Z+1VS2hdWccjbg9tBpC6KXU+mLQs/rFgYmLH2ULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/NrH3DhT4Ec68SmtRs7Xs7oC4vKZXsaxlKFdtvhs54=;
 b=cHInt5PAjmNO8JkxAaRLc68pNCPDviN6ZiQpEveEdG8lnQ5GX4VJ/oic3DfX9mZtrGgaYkDuQuXHQKBpgMFnM7eTNTB6/fOmXH3bnwtIO6GyeDJQw+AMnfJOz5NheOyJBYzbkZUz9lNAlSqnc0JuOQoSSqOmItPBm6TLkMzHd0PDtkfW9k9YbIMBsSK6nFXhwkCxaEO+CQxzxXWD/rS6aHMsjUc7llzlwcw/emaqIQ1cEPQmFQuQl1CDGl4WaUS/9Zx4br2Q4DDM0Ph02LPvcYWtbgTrmCb8J1Nh+eDLy4oWaQvRlu60hbIuwMUnLYsGPLflSwVpKDOp74tcljIFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/NrH3DhT4Ec68SmtRs7Xs7oC4vKZXsaxlKFdtvhs54=;
 b=ZHYhtuTFOVNHi5ioioprC8mLzCyKfy7hweWJnzCBjEmioGIEuCTuwodQhnBPodGGmVIrzUSpl74V2nvC4/1M3VvDOnGh1Y20/4O+0KNDNEkM7jQL2KslCUa2a3GYeHnOa4gmFKPnIefvuyqFVF6FYQ2sKhxGJTPSOGT1MJtQssc=
Received: from BL0PR0102CA0044.prod.exchangelabs.com (2603:10b6:208:25::21) by
 CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 09:11:02 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:25:cafe::e6) by BL0PR0102CA0044.outlook.office365.com
 (2603:10b6:208:25::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 09:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:11:02 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:10:59 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 07/15] iommu/amd: Setup GCR3 table in advance if domain is SVA capable
Date: Mon, 11 Mar 2024 09:08:35 +0000
Message-ID: <20240311090843.133455-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311090843.133455-1-vasant.hegde@amd.com>
References: <20240311090843.133455-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 74878ec1-b4b5-434c-45c7-08dc41ab2c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VxVzQV0B+52lOQdbf138zvurVwuywSbx/OyqeG3CakqjMLT/QshOAlztfoRDWatRJt1znWyNaoy9xX8zuJ+7/zpkM8vYsOVmKiASYz4ssFBPR8WWQrlGAJLd5VmKYxtb6dK0/+m0THzG6qHveaBTezUjBxnSMGTfk9wDomG9q1ZsYySKsbhUiHtI1jsnaxQllGiG9/xmfCIIaISRi/IXFzflVQiB3Lj82a1cbGTX5FNd46DQQoBnr9ezKBHlc/1wK65Asf2/6pdLuccshsEgJzjHVvxGMACf3UmM2llgK/cPTtEgJvwdIa737uLJWldgbi/l+Qm/xsEBFKliOHz3vvG5BsP3rkEuFxq7F3AojtnbMaLsmq65JoZuEZuOA/zJOex1q0DUux6jQT30RaVjqcnWy1LcMcHZs1oomkRC0eymwDVSlTFoEeX0mlgVMFsfYHS7MCAgY4DUKEjeFACdlg1zhPgKkP6EMZ4iu/t7wcSTsjBPTvJSojIDf9XiQ+bbR0K3WKDa0gO5EKUtHPJHhM80F2INcbiNGlfSprAtg0W2SmhPQYxWNrKdgQ7VPjnilDSSjnsp/gizY4uO37uno5bjBGIp3SwIdS+D/Wr/8a6WiwvCZgYXBTGfBxA8RW/O/oLfwW8QLXlj+1/yBQmDurAo+bK9K5DrPgZpxGnoIe53dSrNblEWx3cZHQKPPky3IMGDONVsxlOUX3sg31CJxzRhE4DBaR8YP1bf+5o+o6CkHAEnFtRBYNeSE21zRhJi
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:11:02.2295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74878ec1-b4b5-434c-45c7-08dc41ab2c92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316

SVA can be supported if domain is in passthrough mode or paging domain
with v2 page table. Current code sets up GCR3 table for domain with v2
page table only. Setup GCR3 table for all SVA capable domains.

  - Move GCR3 init/destroy to separate function.

  - Change default GCR3 table to use MAX supported PASIDs. Ideally it
    should use 1 level PASID table as its using PASID zero only. But we
    don't have support to extend PASID table yet. We will fix this later.

  - When domain is configured with passthrough mode, allocate default GCR3
    table only if device is SVA capable.

Note that in attach_device() path it will not know whether device will use
SVA or not. If device is attached to passthrough domain and if it doesn't
use SVA then GCR3 table will never be used. We will endup wasting memory
allocated for GCR3 table. This is done to avoid DTE update when
attaching PASID to device.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 86 ++++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 257b86495388..cf727db66d61 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -89,6 +89,21 @@ static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
 }
 
+static inline bool pdom_is_in_pt_mode(struct protection_domain *pdom)
+{
+	return (pdom->domain.type == IOMMU_DOMAIN_IDENTITY);
+}
+
+/*
+ * We cannot support PASID w/ existing v1 page table in the same domain
+ * since it will be nested. However, existing domain w/ v2 page table
+ * or passthrough mode can be used for PASID.
+ */
+static inline bool pdom_is_sva_capable(struct protection_domain *pdom)
+{
+	return pdom_is_v2_pgtbl_mode(pdom) || pdom_is_in_pt_mode(pdom);
+}
+
 static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
@@ -1961,6 +1976,58 @@ void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	iommu_completion_wait(iommu);
 }
 
+/*
+ * If domain is SVA capable then initialize GCR3 table. Also if domain is
+ * in v2 page table mode then update GCR3[0].
+ */
+static int init_gcr3_table(struct iommu_dev_data *dev_data,
+			   struct protection_domain *pdom)
+{
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	int max_pasids = dev_data->max_pasids;
+	int ret = 0;
+
+	 /*
+	  * If domain is in pt mode then setup GCR3 table only if device
+	  * is PASID capable
+	  */
+	if (pdom_is_in_pt_mode(pdom) && !pdev_pasid_supported(dev_data))
+		return ret;
+
+	/*
+	 * By default, setup GCR3 table to support MAX PASIDs
+	 * supported by the device/IOMMU.
+	 */
+	ret = setup_gcr3_table(&dev_data->gcr3_info, iommu,
+			       max_pasids > 0 ?  max_pasids : 1);
+	if (ret)
+		return ret;
+
+	/* Setup GCR3[0] only if domain is setup with v2 page table mode */
+	if (!pdom_is_v2_pgtbl_mode(pdom))
+		return ret;
+
+	ret = update_gcr3(dev_data, 0, iommu_virt_to_phys(pdom->iop.pgd), true);
+	if (ret)
+		free_gcr3_table(&dev_data->gcr3_info);
+
+	return ret;
+}
+
+static void destroy_gcr3_table(struct iommu_dev_data *dev_data,
+			       struct protection_domain *pdom)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+
+	if (pdom_is_v2_pgtbl_mode(pdom))
+		update_gcr3(dev_data, 0, 0, false);
+
+	if (gcr3_info->gcr3_tbl == NULL)
+		return;
+
+	free_gcr3_table(gcr3_info);
+}
+
 static int do_attach(struct iommu_dev_data *dev_data,
 		     struct protection_domain *domain)
 {
@@ -1979,19 +2046,10 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
-	/* Init GCR3 table and update device table */
-	if (domain->pd_mode == PD_MODE_V2) {
-		/* By default, setup GCR3 table to support single PASID */
-		ret = setup_gcr3_table(&dev_data->gcr3_info, iommu, 1);
+	if (pdom_is_sva_capable(domain)) {
+		ret = init_gcr3_table(dev_data, domain);
 		if (ret)
 			return ret;
-
-		ret = update_gcr3(dev_data, 0,
-				  iommu_virt_to_phys(domain->iop.pgd), true);
-		if (ret) {
-			free_gcr3_table(&dev_data->gcr3_info);
-			return ret;
-		}
 	}
 
 	/* Update device table */
@@ -2006,10 +2064,8 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
 	/* Clear GCR3 table */
-	if (domain->pd_mode == PD_MODE_V2) {
-		update_gcr3(dev_data, 0, 0, false);
-		free_gcr3_table(&dev_data->gcr3_info);
-	}
+	if (pdom_is_sva_capable(domain))
+		destroy_gcr3_table(dev_data, domain);
 
 	/* Update data structures */
 	dev_data->domain = NULL;
-- 
2.31.1

