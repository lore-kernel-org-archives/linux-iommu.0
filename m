Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186A3D96B
	for <iommu@lists.linux.dev>; Thu,  4 Apr 2024 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226472; cv=fail; b=civPX/0w5eC4y0d+CV8V9nkWi+IkI9Py74/MFDhUFgQA5A0zUG+8p9az+00YZ5x5eo3XW0GVSvDn12NWDlM/8f1Ot/bimuRTzmwtG+trFJHJU9PV0NdjClOdde6fnjoZMLGz/8DNkZtDL0qWG9CF9jHxbdCnweP2YWl9KNQIvlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226472; c=relaxed/simple;
	bh=TlpWYlmzC6lnBTKQ5ol1IQ7ncooD95vQgGlsVUHlEF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QklO5iAJChuZ+s65S20SDqL3OXNgvFYR4aHxlhXmSSpbk4E48R3onSlGmHM8QuAFlLB/tvJTa8D/wSJuIGKkdiF1Ogg65eQaSFETd/BJkd7ZhOqSPESCf/5rXBfDUK6DCtTlYsrw/ULTLjFNYfsl9sSe80cgVDomwMCw33Ydebs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yvu1MFBi; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yvu1MFBi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WD9ktneZMiZ6t/SKejQqi1kPOahm5PK6Q65x17qB5Nh5Cbgfyx3qz4kUfB4NkueQByVjlbMdT4eDleA2wDUhAa465w3g2mAr692woHtd3LSxdBoLrrGjEOH8uZEb+qhYMMZBRZJIRn+yk7hPlvol1JOmcn0+0pz5+Zd69W00NvxAfMF3mmfqvelPVPtqZj4aoz1r7snV3TuItKEeI6geeZJv4e+cnZCJZJbvxS/t0+0o4sliXezKxrZY9JpLJN6l4w+fEz1PgFvDeSoGqrwvip0Lq34J+EPUEIK414pXuf+Fme2bpy1tSy1bcDY/0yCYOGcHYGzwl47xV6hAdCYWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s3bMgcPhfByfg03uiKQ88tbblgxpVj3tVl8NO9KsMQ=;
 b=OY9kUhoBhXzWGSElrq0CUyaukwz+wXqP13F61G0UlL/RUrKDKroubCFAewgZH69WKPPD58kYQlOUKdn3ZmfXrg5idwmT+eD08qmzNFz783Ctn6HqgXDgZu+yR5/tp6Bq5w6dCSTNq5NmzSU9l0jjQH8X1xKC11ZHNAK1Sx1zWPq/GsVsPgjN8TbxZhA8/3yYsE7Pbn744QKJ8/psa/PGaZ7lyLFvrv0gDlf1j1DvOoQ+NlgIBtpBzIM4Y3Vfnix8JB4SUaybZKudLTbOmFrBMF3htmSL//OlTB6OMoPQZg9qYEcx0eY7gFd3dpHYTzeH9O+gfe3BunUDI0PyKxdjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s3bMgcPhfByfg03uiKQ88tbblgxpVj3tVl8NO9KsMQ=;
 b=Yvu1MFBiOjprEe/xOWZwUlX+JAnULm7p4VrWD97Q3wRne26/IJO4kA33f3GwHRUw0mHTbk+MtShrGPe2TxZuNE95/FlqI1D7YM9fICuDACBaWfrYuB5y69HttxDKUQcovXuOlPhhmStfYtzJNEBKYF6CN+PuAcsq14pD++ggieM=
Received: from BLAPR05CA0044.namprd05.prod.outlook.com (2603:10b6:208:335::27)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 10:27:44 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::66) by BLAPR05CA0044.outlook.office365.com
 (2603:10b6:208:335::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10 via Frontend
 Transport; Thu, 4 Apr 2024 10:27:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 10:27:44 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 05:27:41 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH rc] iommu/amd: Fix possible irq lock inversion dependency issue
Date: Thu, 4 Apr 2024 10:27:17 +0000
Message-ID: <20240404102717.6705-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 581fc0b9-e105-4a75-8b8c-08dc5491dd81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WDIV7bfub+84bOeQBznJxjsoFomUb27QLLNuKngXQzjzWeBLcgmIIf4QwH9og7CfJbnQpZZlO3G85qZicXZZDNE4wTlRZlg3XtoOYwwCXvZH8xZ54J/NYxOVqEU2xb6DTO+7GVVSZOGIb7mHo844g3lKM7l0buDJ2f1qd9KYU3nkb6RgCpSSCCnJh+T2TloYK1gPexlWl25kU3LAPGxmQkAqwbUeuEnG5T/fr/+hF4uMMQ9A6Ksl3FCS6u6LlcR9PjpUlG105qo7j8NFKLEfSbV51vBoml74H+uIxJ7696A7GN5zMMgrvmHScksv0tooAxIdpiqjZgOOQaGRzqbXFSuwmNILbrDXH3vaqxz9GlqCs9sOvbVJrGOCqjb3qqq9+NTJ+GGmTTNFQQLku1sXlVsQ3BVdY2aoXe2Qnfq7TUssLAyFHpz7YLyA0pCxx90oSNeARcJMevnHJCxalAZI1acmSS3+1dM5i+T+g0bz13Cb9XC6YtTQ9+nlFyeLUgcCZoZbLGPhu7iSUVQ3L0t421iCDsG4pxbV/pLiRvz9wcK5lw9K91rWx3G+wVn5ixRkFPzNpEv+ybPx31draGDsC9Z179htubuHyfVsolYkWDvDnKFwtbS/4CRdL/Op8UchQybtk81+my6u1EVaqPh4uN3qPEn3ZbDFjc71PC7rtvypCWV8MvXh4l0uPC1zOqIOES+yUaqFtIYijKFCsXl+rnjWZPvaSv5g+FvBxnzOJB/9JtlB5h4nH5WLdGhG1AGI
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 10:27:44.0669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 581fc0b9-e105-4a75-8b8c-08dc5491dd81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904

LOCKDEP detector reported below warning:
----------------------------------------
[   23.796949] ========================================================
[   23.796950] WARNING: possible irq lock inversion dependency detected
[   23.796952] 6.8.0fix+ #811 Not tainted
[   23.796954] --------------------------------------------------------
[   23.796954] kworker/0:1/8 just changed the state of lock:
[   23.796956] ff365325e084a9b8 (&domain->lock){..-.}-{3:3}, at: amd_iommu_flush_iotlb_all+0x1f/0x50
[   23.796969] but this lock took another, SOFTIRQ-unsafe lock in the past:
[   23.796970]  (pd_bitmap_lock){+.+.}-{3:3}
[   23.796972]

               and interrupts could create inverse lock ordering between them.

[   23.796973]
               other info that might help us debug this:
[   23.796974] Chain exists of:
                 &domain->lock --> &dev_data->lock --> pd_bitmap_lock

[   23.796980]  Possible interrupt unsafe locking scenario:

[   23.796981]        CPU0                    CPU1
[   23.796982]        ----                    ----
[   23.796983]   lock(pd_bitmap_lock);
[   23.796985]                                local_irq_disable();
[   23.796985]                                lock(&domain->lock);
[   23.796988]                                lock(&dev_data->lock);
[   23.796990]   <Interrupt>
[   23.796991]     lock(&domain->lock);

Fix this issue by disabling interrupt when acquiring pd_bitmap_lock.

Note that this is temporary fix. We have a plan to replace custom bitmap
allocator with IDA allocator.

Fixes: 87a6f1f22c97 ("iommu/amd: Introduce per-device domain ID to fix potential TLB aliasing issue")
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d35c1b8c8e65..e692217fcb28 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1692,26 +1692,29 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 
 static u16 domain_id_alloc(void)
 {
+	unsigned long flags;
 	int id;
 
-	spin_lock(&pd_bitmap_lock);
+	spin_lock_irqsave(&pd_bitmap_lock, flags);
 	id = find_first_zero_bit(amd_iommu_pd_alloc_bitmap, MAX_DOMAIN_ID);
 	BUG_ON(id == 0);
 	if (id > 0 && id < MAX_DOMAIN_ID)
 		__set_bit(id, amd_iommu_pd_alloc_bitmap);
 	else
 		id = 0;
-	spin_unlock(&pd_bitmap_lock);
+	spin_unlock_irqrestore(&pd_bitmap_lock, flags);
 
 	return id;
 }
 
 static void domain_id_free(int id)
 {
-	spin_lock(&pd_bitmap_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&pd_bitmap_lock, flags);
 	if (id > 0 && id < MAX_DOMAIN_ID)
 		__clear_bit(id, amd_iommu_pd_alloc_bitmap);
-	spin_unlock(&pd_bitmap_lock);
+	spin_unlock_irqrestore(&pd_bitmap_lock, flags);
 }
 
 static void free_gcr3_tbl_level1(u64 *tbl)
-- 
2.31.1

