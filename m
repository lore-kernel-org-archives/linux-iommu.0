Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3482D225CC
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U11thyv1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFoTkz7KKbwbMVlXV0Rw3Z1Xn3itrP4+y+aWzEnriSS95VcBuJ7mNTqF2PAazYcG3hbhL25eNJwr1rN3kAY89Vms8OrSk+4qng6dfSGhnkTSYUdAfsjbSdnQ2CA4nd7L1f9rpejsrw1dfAG5Lqmuoi5XXFcHZA6YZADevNtDuwbeOB6sdm6EzDHmN1ZDMJcU7BNTpcQjLmbAuRwn/MsK9wFrkUFPX9ULCYmFiCLRLjVmBrvqT6h9KDrXQtwrzA5WpH7Jp86ljgckaanTSzqv4jN26xq4gxjUC2Im7u5xeGXaFG1zqCwpJw0akcbS5TFKJBF5DgvecvLm+Du2qMsf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+gCe92q013hxTdsnzbxQuXeRVJ+BFrqzRykqdum77c=;
 b=cCp3SzuaktynH5+u6Pax75HG4fz2UP2jOEyk40Uj6kGgqMUC5Bgg3/xGuE4o6jQgxL2QPVhnUEWgpzAkHC/AWNRGZfAJIgxnbRN8gyUl8xuqjQ/MPVViiUajGIBf3TqXzoQq31rTFnv0a9RuqlbXYRah3CxUX4j7A9UxiU4gGUzlStXM7Ebw51eVzSVDjRx75RxLXc4Fkx/6lPaqhoDD6io4CTtmA3/oTTZFln1UN+rIX/FvL65+38Y7i/gAY/cCNu8MrCtXv8tTjpSAY88fOcl6Mkvd1BT/TRJEt48M7LzzSO0YRTmpNBcjwmyyGWJnTUSq52z0wSrSjq6OND1Q3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+gCe92q013hxTdsnzbxQuXeRVJ+BFrqzRykqdum77c=;
 b=U11thyv1xjGotM/5oMPrS2hO2gviOBkMznpcvp8mGzCs4xHGZJofvUNfv5rEfpABEypr2A7KqLit03LZofIlFnehVsPg/tHH/fFAxqTiIwjBJ7mmiEnrGaLFclL1bsQLf4TImlAPT3BGsVuPwVyrLiQ5S7JhIhY7NvqVjITsBe0bPUc+CRuszHGBoFlIHM+/+54ht6K2exqIGFO48UAXYYV/o2UFHO/aYKQgNxGA9g5XATfPe47vL0PZPeOW41igV21sIOkGGoOUlxaFKgnxQQURV69X6LVzCN1EKypx5EmmF8sJGfRr9aXIwtE68a47nwoUnDKtquLswqmEBAhlsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 17:53:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 17:53:28 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 13/19] iommu/arm-smmu-v3: Pass smmu_domain to arm_enable/disable_ats()
Date: Mon, 13 Nov 2023 13:53:20 -0400
Message-ID: <13-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0328.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: fc93690d-3446-4064-42b4-08dbe471702d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uHJJsGOs4xwr74vWESqedlWwSWd/Vt1GDoc4vKM6HKpPkxOVBLBjnnLUb5ABptRdrayq0t2gg0PJnwIPU6MhaGMcd9xKeGup9Gf3NSz/Z55XLaWSjW1ETTPPkQ46fBGt53KidieQLHM9ce2t2dxjXvnfCDH5eIxVnhg2YXk19NuN8GZppNTrhh0w9JCdIiHBhuaO3KBFXEqj65MMz5lKlilDMNApuciJ7A+vJ0HS4U69QKvdR4HglP7HiKWnLFowq1f5vzbQZUTwWbdxDsFoY46sPM6wzdzcFMd8JPF9fiEnCznBWghji4AlyY1P5MClDkENoBi4i2fdM6wUMgLzZ2MxkmoiPJNASUTsnH8rloseBHgwRzhIIyeN7XCmhP845SsSpd3v9BSkmxzM1wY3Fv7GHZyJSPqOOJWJbVRcku0IsZkJ8YYer+JlWGAlBMs92iDE1fptozWoN7euAqbdJCb2kopFhC5md/vh2x1tjXPsMT6vtL8KsLPkKN/tPPJmFd6wbs3fIrYqG5gBXuQTvEynv8fsPOKSAkbvzmY3Cac+67UVOVhZN2I6LS5CavVZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(26005)(478600001)(6666004)(6486002)(6506007)(316002)(2616005)(6512007)(66556008)(66946007)(110136005)(38100700002)(66476007)(54906003)(5660300002)(8676002)(8936002)(4326008)(2906002)(83380400001)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6A7XcaJ0lRLsNaimFhS9+QLIpgQ85RjzhLSxBcEPzqpXGKHf8J4G2Ggb+2wv?=
 =?us-ascii?Q?qcK4GX8CPDW7x3IhO34PD5vUI/55VYGX0v9cVrkmYOiC/9p2BsxYHtUK9t1r?=
 =?us-ascii?Q?QeoV/9+V4+9MkySJBb/jrQti6XkSrTo6tyJFTMLHOAlNlCSFw0ZoaboBJkR6?=
 =?us-ascii?Q?wP0yGSLnrVonxFa/fO/wGZosuvZSdkZUc5ASOw6sps7ZE/AV5M5GH8N0ZJXZ?=
 =?us-ascii?Q?E756d3dCoqQgRLzQIGtZG71IjwxDzTZGn59Ksg8gVmoV4/um4PWO0gmQ5Rtq?=
 =?us-ascii?Q?9C/ymQHMNEeTtkFYuu06Ft7I42qHNnNDbagNyCvceL2zbbDiStlrurqSQqKG?=
 =?us-ascii?Q?Itn0jWs6Lhq2iMIpnY6W2QVhDPDeJhPPOwkOKLU5ozkHKulb8mI2Dlnz85u5?=
 =?us-ascii?Q?MpCFwbK/BDA7R1MCBPVJaE7bDDcbVKqA4kTi4sM1v48expTriPDXlSuQdtQb?=
 =?us-ascii?Q?lqeSpjktd/KTQm8ROaupeEDHZQAUVw6tWSWpaj8Wgv3wgXYTe8u1NZeL1PVZ?=
 =?us-ascii?Q?cPFsq54UPufdmuTINOV6x3da0H5YUVvy5oLBgLVXZXVikn25WnM0POGrqA1+?=
 =?us-ascii?Q?MIWlSod+uTlGWO6RQHSsvEv+dKYeGxz2GLy40nFk1PSWj7h7SDXvv2hW4Jtl?=
 =?us-ascii?Q?u2y021h901AyZXQavU3c3SN/7APeirYWhcCFjJsS8bIW2U6bkjjiVkfKnqrT?=
 =?us-ascii?Q?wr6dGZF7x76/9EE01FFaju8+OfpXG9pAaHmostZqbNWmGNEk+lS5EnouJY+E?=
 =?us-ascii?Q?OpOCja63471qtLazVTh2ffuzzvjFoTQxm578vYCHgmZEsRKHotLWtAuDnh3Z?=
 =?us-ascii?Q?0WeZC8DpKZWqvvtqtlNwOlUnf+m3uitmfdYSwjQtccIepzN/izbkuuhVS6B6?=
 =?us-ascii?Q?EntmxmH7FcY0CtL//UlKnmAAl9K/XpPrEK2B38Ljf7EbMlZhdBpC2PobFhuu?=
 =?us-ascii?Q?yQEYsgQvv31nCm3ggRRbNbTNzhu1cgihr2y/srCu+nr3VCJFwUvIGGJai329?=
 =?us-ascii?Q?5afiZmKn4ri3LcZ/0VyHQ3oCbktAwbNtaMhHcEtPNFbXGv05kHZsmjxFEwLg?=
 =?us-ascii?Q?CRO1tgrLK+//eefdFX3CXhq/POXzE5yYLrYckB14g6YOi0cLXK14pziwfBp8?=
 =?us-ascii?Q?nfeQfpdF13q7Zm1xHMCl51qJ+56lqRX1S8OjE4wysWMis2QoryXzq3MLbf5d?=
 =?us-ascii?Q?wODlHYIamonK3BO4XjFCjBI+7BhIcJpR51ssWbk+QJ9ttKdH9ueOgTKtjTAx?=
 =?us-ascii?Q?2IVcevSeoQCPEbwfMIicAz3xIqc3XGRRpS4JobvbfE3H0xjoGcSvVx7Vlmht?=
 =?us-ascii?Q?Onx7eej0EiXM062qDsltGQzyht4rFewly+glAPVkjs8acEdAQL5uTU5QqJ0n?=
 =?us-ascii?Q?I07ucfBfPeiQPfCYfhKfZFaFCIkMKpf9uvYIal5KQeg/IUbt4jY/AfrTAJrb?=
 =?us-ascii?Q?3p9HvHDi2+R0n2NxKA0pyPIC2EdC2P1zKH57yb87E39DQA3/VxO2PHmRfkQ3?=
 =?us-ascii?Q?Vj/mybUGARgM+8Nh9P3hUJG2nAQoEb0VxfdCEyztjEHIe9LjplBR6WlVVYgO?=
 =?us-ascii?Q?VRYDUaBr3FGClmbk1eg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc93690d-3446-4064-42b4-08dbe471702d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 17:53:26.8744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xcqn81BjF12o9xnL+no+Nl27Ka6tO8Z34r6Ds1DaL27eQA9SLtqBsfmq0+B5zUbC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

The caller already has the domain, just pass it in. A following patch will
remove master->domain.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index eb5dcd357a42b8..7d2dd3ea47ab68 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2394,12 +2394,12 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
 
-static void arm_smmu_enable_ats(struct arm_smmu_master *master)
+static void arm_smmu_enable_ats(struct arm_smmu_master *master,
+				struct arm_smmu_domain *smmu_domain)
 {
 	size_t stu;
 	struct pci_dev *pdev;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	/* Don't enable ATS at the endpoint if it's not enabled in the STE */
 	if (!master->ats_enabled)
@@ -2415,10 +2415,9 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
 
-static void arm_smmu_disable_ats(struct arm_smmu_master *master)
+static void arm_smmu_disable_ats(struct arm_smmu_master *master,
+				 struct arm_smmu_domain *smmu_domain)
 {
-	struct arm_smmu_domain *smmu_domain = master->domain;
-
 	if (!master->ats_enabled)
 		return;
 
@@ -2487,7 +2486,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	if (!smmu_domain)
 		return;
 
-	arm_smmu_disable_ats(master);
+	arm_smmu_disable_ats(master, smmu_domain);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_del(&master->domain_head);
@@ -2609,7 +2608,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		break;
 	}
 
-	arm_smmu_enable_ats(master);
+	arm_smmu_enable_ats(master, smmu_domain);
 	goto out_unlock;
 
 out_list_del:
-- 
2.42.0

