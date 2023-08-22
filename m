Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC561D2E6;
	Tue, 22 Aug 2023 16:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXAY6x0lHGpQ3qk71UWA7In7OsC1KL94YtT2dqERIC5yigFMk7Y7CfmzCmFm5u2CXKvdDC1GLX4p72AuGWn70DXquBprVVSYd0i6Rs4oxO3KglJKXVKWpfHXf1NG0T44lGMIO0T+zHAvp+RAiQ7i/HKXudISh/EH+6bloLePjQTqlMsWP5h8OoZjlmeyfV9aE6aqpfixLY6qyAz189DnLeBGgrfaoPwNi4k0+aDdmHW6cMj2p0UvfyYhwKF4hlCsHK2opnLFQaAYB4JSLSNHIlRgfBaD/QQwSIlG3nTVWje6PCLEitpruq24MWQiUs8DjL2qII/3/N4qaeR+5ZScTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCojKI/W5M3s3vHbMVLtKa/z4qtT7egQpecWd6L2jls=;
 b=RmTWfZVHzA8YLabfk7ajLAIKPIs2I1H0MElEvrmJl4RKEMWaAp3TrTN6hQHyxAO7Mm67u4BTdR06EqTiiUwgCEL1jJ6Yxi0D/sp5btkDVESV86KN2EM8z6qahN93okDlLtRn5PLsRclxhc7E1oKLozzYIYncgUDamjb7TA0HbwYxoAlq8Rm3ZS3yGvw4fZKVwpBfppCsaX0YIkOKUUhLvMxu6d2KSJs7Sri1wDa07UZ2TQKp/Q7MncS0MyKzjNttbHXwyFp8HL9iQHgCLYj3BfSNeZVKNvdrqbfnvrCb/Wv1KbzRnWUMKnKBtA7eEQEqogn8wyQU5FiVq7/ThlyfOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCojKI/W5M3s3vHbMVLtKa/z4qtT7egQpecWd6L2jls=;
 b=gJcJlkI1CmhWLfT7t89syWJqT2hqeNaYVyd0gvHKfjm3eIjMzCpaenbScGinWU3oZvcnV08vJqcAOqdak8WbSy6gd0a3McOYtLv+HZvenZUrQj1d2IJAgheYprspm3rtMq5q2CUInzmpg8XZDkU4R+eo+btIhkxHu8EHY5nMcPAQeAkB67YyFUQShfOu998pw6naM0XRwnPHvxbiN5SwxfrTpGBUl9o8OFWzY0N87yTgsdZ/uybQHcbalwoiGkyLwPdyeHmHGh4YLbsap6txEJ6l86VJsr2SZRzmYW2R4JRpJ45yZwzbtddixLVOjEV4eRsZljzHDbH7ZzAyR3BwjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 16:16:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 16:16:04 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 4/7] iommu/sprd: Convert to generic_single_device_group()
Date: Tue, 22 Aug 2023 13:15:59 -0300
Message-ID: <4-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
In-Reply-To: <0-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0024.namprd19.prod.outlook.com
 (2603:10b6:610:4d::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 029c95ca-c903-4198-0598-08dba32b14f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MEu6L+7IC1DLMGdiAeUmapuuVT7Yb6AXAyHwF4IrMHl95F4AXyRORN3nEWJus2Hzb+iVs2ew3adZUkRVMyq4lMTrlgEp41nUqz+oA00Qq+IzFj6I/xAXYGBrAkfBtnxVcRiGhn9NT/kuPM8uFx3LDtAzdyi2xnp5YyEYS+zr5GWNxpAWt+A/zxSP1wK4M2M923WSre+RBTkVk1Ky9kJoMJzx7W5gkgntaw1zP/jZa9RDgy6IjURHY/gU4XZLlg9KAQNO5yu+OKs24z/febrplSx+PRqSXJMgE9bmNlUvX78HzBPQN9mfqSYem2ZClDebGVJ5mkdWYHU1mH5Lv4dtH9/U3517kecpxWPBif0cMSxfscl4jKmrGsoFxPFXLCmEo3NpG5cegpeIqwYu5Nf4Ly2rqcA8H4XudUOKRp3fQ2anVo6yZElhl46d2MSRm4v6UN7NyVWqk9mXp6hIzLAdbtFtMxFXf4uDNNZ7fsqukjsQKG3u7gE0dxu3Z2TqbKfa3+27IjFprnFBcT38TfJmWooC3SCBzErCJS38bgh3etfTdWUuRld9Da6QV/h/DluvkKuNRjckvXmFCyZzMb8gmID8aGopZxgppShh3qBO5Q8pivy32EyFnAWCWZVGCc8HVBOaCWp+WuOVLV1qm+jyVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(451199024)(1800799009)(186009)(2906002)(7416002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(66946007)(6512007)(54906003)(66556008)(66476007)(110136005)(498600001)(921005)(6666004)(36756003)(4216001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IzkrZ2XqVKvD5x3MkLFvik7uZ8Yy1ub7PWDNDaufdT1cLe8zrSP+qnWt1FN9?=
 =?us-ascii?Q?v/TuwpQA+00msWDLbPFco8mym8WXgtlf3LAqlgoOgMpMS5jAU4U+EddKcoKr?=
 =?us-ascii?Q?4ZYvrz5v+6MJUXuNhatAyedcxBgmZ8kl4Bi+VKqOxePzJGNmA8jq9MLhb9y8?=
 =?us-ascii?Q?GXCt3reIrec6MpifPjQGY0QncBfTKEkJtiFqZWO+bUcVGrqpqcVlo/JXlWq/?=
 =?us-ascii?Q?odeDC+sR2wH5Xz1ymR1b/wJneu0VR0X4EL4dbNk9yi3iXCPsS4cFvNO/aJL4?=
 =?us-ascii?Q?aO6MAGU9w0Q9ABNNtHIpLTfJLMsCHxsYyz374NGLdWRiVuE6vVmCTzvp44RH?=
 =?us-ascii?Q?IHLQivYj0sU9jkgUFDbOJVpSypTTU2ampsoPeAAQzCaerZ2A8cuyyTTIkTqU?=
 =?us-ascii?Q?QAlDj9MljiDQOmEyd4GJclLflZx2MXwHubj5V59erJ9w9EEi8SK6BTXN4bRk?=
 =?us-ascii?Q?DjtmjjYvhqVxe+mqa09jHBzVB2aqI9fYe9v3zwoquW1LqNCPay6CSrgOW9EM?=
 =?us-ascii?Q?f9sMKeVNv+uoBKTdLSQGG49Cbh/ALNovxlchVCpnrTe8bmVKY8WPs5QBeJSG?=
 =?us-ascii?Q?I/Kngf7N5u9XIyBI0SqfagKMepXNSN5t4IP8kDvDEoA7Y6Kfm5OdVcx7QrTb?=
 =?us-ascii?Q?Ze5LOyaQ+MYqCuhmAkqOUSVp+g1Tp93ygJDBv8q2F1rJ5iWb3lMuxUsXkEuZ?=
 =?us-ascii?Q?rw2W7d4zpDxx+79bl+BLf2VLuKzs8J6BwsB+4agZRA7jjMp3LNUcwrvtNefX?=
 =?us-ascii?Q?qNZhqjzxAxFBIgkWTS5uY58jNYwwHf8zdcYFrGmF0A/XdCoW5Kx1oU6MBhVm?=
 =?us-ascii?Q?eqf5q3Q12eoaE1k73An419mhpSqjEmKIIBSpnhReIBDmt/xBMMQT5uYJp6tC?=
 =?us-ascii?Q?3QMTzX1tX7CTXqxae/WK6fIpOI7Spb20bJHaqbzrS2coUY5XVKdVOsfIkBnU?=
 =?us-ascii?Q?JcFfkHDojVK5vSBg5rtJsAXDCeKB4RnvkQHUBhoIiXUgHYaHu0JrAkwJ7p7k?=
 =?us-ascii?Q?rKQOtUTLjR2rjyoex4Dy5ZGC1LAa7u7ZIkf1sOn0fUT26VU+tGEupvKrlMVz?=
 =?us-ascii?Q?jNWBkildsFRI8QZTT0MUl0I0JF2jNhzhbsKoF4fQxAQXJ6MVgYYkZWSBt332?=
 =?us-ascii?Q?70erzLFnyeiOLk+W73vwMD9fDLqOglgSWFN45whOcXTSG20/eMm0o70L2GkT?=
 =?us-ascii?Q?CuWcKbHVtNryaLBgKhKxI7O7kBIKVCRMfVFXajQ0NxSETHwyr1lbv3owPqdU?=
 =?us-ascii?Q?gkxmvthiHP4cxwGO/W7B2+Y9HXr+OZNxNS70VzHxMUxIALTBNCnAn4Fum6gf?=
 =?us-ascii?Q?pWYctGT60WVk42pXrbQMpoXrxjG+7GrHZDe8OJNLivj6TsKVec1+KcCzaCWu?=
 =?us-ascii?Q?SxQtaZxBXY6gubPsumWgdjmjjmjSbV+vyGV1WBKD1JSvuJ1fXwdG01cKtH+4?=
 =?us-ascii?Q?2lXRhI5jlAtXBbZR6yq4Udgtug35CBkOJhu+drZEJtzoh1YiO1I8yu30p6Pi?=
 =?us-ascii?Q?XaI0ySK8WALHevKyhm7MfMIy+fAuNnqGdNJhMItmB5wEhb04yPPpVJltp6uW?=
 =?us-ascii?Q?Tu/oLbkcZYwysMlOQWc8BY5bPnlcCkHd1fUi2DNe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029c95ca-c903-4198-0598-08dba32b14f1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 16:16:03.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igYYTj+D1uAd61rPRjJyjCJibVmC7e2iwo6Q2cbhytH1FKe4USytkbhFHfd6Xgfi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831

Use the new helper.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/sprd-iommu.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 2fa9afebd4f5f0..1ca22368649884 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -70,7 +70,6 @@ struct sprd_iommu_device {
 	void __iomem		*base;
 	struct device		*dev;
 	struct iommu_device	iommu;
-	struct iommu_group	*group;
 	struct clk		*eb;
 };
 
@@ -399,13 +398,6 @@ static struct iommu_device *sprd_iommu_probe_device(struct device *dev)
 	return &sdev->iommu;
 }
 
-static struct iommu_group *sprd_iommu_device_group(struct device *dev)
-{
-	struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
-
-	return iommu_group_ref_get(sdev->group);
-}
-
 static int sprd_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	struct platform_device *pdev;
@@ -423,7 +415,7 @@ static int sprd_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 static const struct iommu_ops sprd_iommu_ops = {
 	.domain_alloc	= sprd_iommu_domain_alloc,
 	.probe_device	= sprd_iommu_probe_device,
-	.device_group	= sprd_iommu_device_group,
+	.device_group	= generic_single_device_group,
 	.of_xlate	= sprd_iommu_of_xlate,
 	.pgsize_bitmap	= SPRD_IOMMU_PAGE_SIZE,
 	.owner		= THIS_MODULE,
@@ -496,16 +488,9 @@ static int sprd_iommu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sdev);
 	sdev->dev = dev;
 
-	/* All the client devices are in the same iommu-group */
-	sdev->group = iommu_group_alloc();
-	if (IS_ERR(sdev->group)) {
-		ret = PTR_ERR(sdev->group);
-		goto free_page;
-	}
-
 	ret = iommu_device_sysfs_add(&sdev->iommu, dev, NULL, dev_name(dev));
 	if (ret)
-		goto put_group;
+		goto free_page;
 
 	ret = iommu_device_register(&sdev->iommu, &sprd_iommu_ops, dev);
 	if (ret)
@@ -530,8 +515,6 @@ static int sprd_iommu_probe(struct platform_device *pdev)
 	iommu_device_unregister(&sdev->iommu);
 remove_sysfs:
 	iommu_device_sysfs_remove(&sdev->iommu);
-put_group:
-	iommu_group_put(sdev->group);
 free_page:
 	dma_free_coherent(sdev->dev, SPRD_IOMMU_PAGE_SIZE, sdev->prot_page_va, sdev->prot_page_pa);
 	return ret;
@@ -543,9 +526,6 @@ static void sprd_iommu_remove(struct platform_device *pdev)
 
 	dma_free_coherent(sdev->dev, SPRD_IOMMU_PAGE_SIZE, sdev->prot_page_va, sdev->prot_page_pa);
 
-	iommu_group_put(sdev->group);
-	sdev->group = NULL;
-
 	platform_set_drvdata(pdev, NULL);
 	iommu_device_sysfs_remove(&sdev->iommu);
 	iommu_device_unregister(&sdev->iommu);
-- 
2.41.0

