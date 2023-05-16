Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA3CA20
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 00:27:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5pZTw8alFX4kqvbkWVxsKD1BIguHLczFM6vmyfnnal1RYt7U01HeteOFlaxcNpuG0igB3FHXA3LVdYRkSVhkwqni/RPteoBt26tozvBNWuCCB+96eht0sV5+xkJuWS8fWlrQwK3byFhoNzpo/9ILAzEXH1Mh1clHakLoPI72o5jjKPjhe23zh3h8Mh6rijuWZMwzm2e0HI1EEXR4IZX66RAVwpXVFr8IEMbjxLZerHBP8JknoWdhM7+oyVbEpiB5cqRSYK6fiD8bqIdExUPTRu1eMVC0EBEZkQCCTHvJdEHii47Lbg3ZiJti/3D+BPBgT++6GMW8sextwbURkOwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HykdOOkS9wi9I9MtFao+Ov4wJVdW5PPqZ70hE2RZICo=;
 b=NjQcx5OdTTNMG8x2lTYezKfRYVD0buIPBI1986o1+Xz3blI1SnZ3dNlqOlyKCPjA8FpdwlN8iIq3weJQhI8sgGx9Kg7c7Nosl9ogKmrg7FnqrwNMrtGmvDmXwFTJ7pCH7O9t1XFn6RAqTEb1iWj7wcXXsYXAhZQOTasH5XJ65sRxOvWExboXCO8Zy9bq93SWt9mYJCYxCd6YWC8JFmhxlOWF4IwW5Y9WqBHnY+aahYjxdpPfLtvYsraKjTi4zMYy/U/mffwqUcmDKfpaLMZsnJifLEu5vCDVeDrjj8xqtennhnfg9k99WaOeEHXJcTBiiY5fNzFgx+J0nGYJJ9kN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HykdOOkS9wi9I9MtFao+Ov4wJVdW5PPqZ70hE2RZICo=;
 b=BJM/fpQRDFEJKWFOs93Eqf5MYUAh7rWLNNAErFFLZ8QghPKhtlnLxy5bz7Fz0DgQNSA96tLEcITxxaAkVmffFj7fFY2N//XshHcy3jmU9Sy9QuiayAiyEP5/X6kIJxvMPPqWqM/COKqckW7yzcEwxPfZ7DDieAB2caOZM/ItXbu5IBfVHHF/wXOw6FhVa7O+eMfKw8oZLz3FJXavbgHqwS/IxFlU/de/HO+PJY6JbgYZOO2WJ5VKU9Scrwmtg1uBoQf7wVEsBDRIAkbxZgv0ROcyqnEx6IbY+lXNSo9j4o2SoLOd6XE52E+OnMEo2JeGP0SjdHRX7EsuhhTQtx0h7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 00:27:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 00:27:11 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 2/2] iommu/fsl: Always allocate a group for non-pci devices
Date: Mon, 15 May 2023 21:27:09 -0300
Message-Id: <2-v1-8fb05192ea02+e5-fsl_rm_groups_jgg@nvidia.com>
In-Reply-To: <0-v1-8fb05192ea02+e5-fsl_rm_groups_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:208:32d::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: a45babdf-712d-4bae-6274-08db55a449e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ju7nXDikVwAYa5QUgTNiZAOpWVlnjAD8exi4W1vOAJ3cV6acL/VMiCV3g5kHjGJ8Pcl15SU9mxaQkEjx4yaIuVzFfLs/rR6EQzK3g3VEjjVgiwr8SYHgMzxdUCWt/wfsL/eOkH0/jba93zuoZ/OxIWUrsQTmS0a/xL/mirtYCvXxWiKILZmlf/7Y2ODZuFo9nL1FrNDhwD7vwbQU6uzp/jcsbBc2HIpYZAwtrKittP1DL+dHv9LxzbLj0EpGPbjy7g3nRPmJvObWOLSUjQcivPr1HkQQyesiH7w5NMYQeZxi0t4YTO4JjZGluXSr5c0UGL5C6IJ/1XyuiZcZJWcAzWkKhb+gwrvspbZI/FjRUOKa13ydK97k/G+67hob1S9A4baCQc5RD6jGEZs/zLAlLtdIifLeFxyI3rWM4A3cQEYfoZvpqv3kBy+XNQFp/S1lonhmfBXr9rtD1KOBjxiGqRKSAIB+967N56eFGmdE+nWeGvKtSZRgRYObyaxh4Z/Qrh1h36WjRdoIKp8HRqLFsd8UO6qlIFCF2swsEtr0LYdGwBw51ysgPiMsn0CshYCnmf83PqmteeCQapG8i7evJjYOmCbnXGLAMN/Tf/eOK8I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(66946007)(66476007)(66556008)(41300700001)(6512007)(6506007)(6486002)(26005)(38100700002)(316002)(2616005)(5660300002)(83380400001)(8936002)(8676002)(2906002)(478600001)(86362001)(110136005)(186003)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bHHNnKNX0XEjSHqgZvC/M/xa3lhDrD/gzBwnjzNw8VDNZv6H1150oL7vaSJd?=
 =?us-ascii?Q?7pIbYTDoqRvW4wFZiLHJChbBKS2nnPN2ePJgc9Y4w7fmrOqVS9JVQHrl+LwA?=
 =?us-ascii?Q?mxtcCzGwjSVhtpisZfRNS6NcYH4eehTgi5JrZTzBmYydPcTscY6ci8WTuvQa?=
 =?us-ascii?Q?RvE/qWk99NctSPnEbeZBcvcv5pHFIcEfSK++JRH0HzdRytdUSt1p8N0eMSTK?=
 =?us-ascii?Q?K5AaEy93bQbntghYtSgaalj2pne4/x55HosU8mMdKJxbXPPSkRPjHSh05UVr?=
 =?us-ascii?Q?CJdaiXRSLwegV466A+NxeH2PPtzOb9KEqvGwf591hHbol+ZvLoeysbEfaDwy?=
 =?us-ascii?Q?Eyy7NdDgKpvLF/tLYMPkVNVXzm53b0l44K/enzNYCEXM1pWRBTPcMWrsjV3f?=
 =?us-ascii?Q?z+Yxizr7tp/wgZyCjOR9fUoVoSKKnB+xTTWuLpyfq6eZkcJ4Xd0DStdx6us6?=
 =?us-ascii?Q?sSdHHpNh/Ap52pV0Vy1Kw1tyfzU07hqShFvQ1FXouXpinlxymA5b9ezfUWSk?=
 =?us-ascii?Q?f/LBnhE2GuNGX/9MIWSaUaL2UPd7RDrLEZLUUZuHFee9/r/iHfhWzY1RJfrY?=
 =?us-ascii?Q?CfA1LbWG8Jj4Tynwsdji2ySp+q4GBeJ+b8bj5CI9Z6sMemBAe1FNGGyeyMku?=
 =?us-ascii?Q?QT6sN7Iqs3AT8jA34AiM5VOEOsF9jPjgjgotItqS+b8BV+RgpN0SYi2NAuy1?=
 =?us-ascii?Q?ZxLzPmVqE31dMn/a54+fUzvlJVaQiT7e6Ahhtvp+G4fFZJZplz42nmvi/TxN?=
 =?us-ascii?Q?SCFIgLoUUghKTpD0xnhQtpwQCpeD5W7Xrl/BQNs1ThB+v4OPAkBnvj/N1HW4?=
 =?us-ascii?Q?3duRj1LrdImNQZzWe8jhqRO4WhBpbtEOd6Zaorty7uP+e+Ufc8U9T8tVLBXs?=
 =?us-ascii?Q?FkShIJo4BVTjfcKroOXyT/dR1X/u7P19KpO3rwS6Ljrxiu17ncnKo1XfjeLD?=
 =?us-ascii?Q?zMHMnXrHc3nMlkAPySNI/Qxj+5RrWXUVYuds8QY7ML4tLhjyWBlaVVIWBk0r?=
 =?us-ascii?Q?ZNZGuw5NLptgYoZIA4jNQxECTZfJOfEAjboYdgNNGa6IWWVxZtmZTLxP8FdN?=
 =?us-ascii?Q?xq6nx+w00XzML0uMyaHaJJhw0QNL1LeDanwenTTk7NYU4ECJUt0VdXZ8JgyE?=
 =?us-ascii?Q?TR5PafNEWwxpMQnKzANXkSiyr6/lQEFks3yvvnrOwOfnCOsmGDgMuK2AgEqD?=
 =?us-ascii?Q?3r+XbM2sRA3SJohSDEDub47Ww70nvVQiin1vPc8xJbRqMAu/NHgjP/RXv2nZ?=
 =?us-ascii?Q?xcSgaO2zsizaanIYz3keChm1Ze1hUbYYpLKwe0g2ywrFsgVGSFqMXEfZgz6d?=
 =?us-ascii?Q?/WqgYkTKXigUyEHaAbLAPUthaugMChi121RH9UTs5wTAGi5CcX7cm+mdX0EY?=
 =?us-ascii?Q?hRlEZbPH+djeE02OK54N1n6HZP83n505yx759RxnL/8lhnofuownkFOzYAGj?=
 =?us-ascii?Q?AZnc3BGV8Z+Vjb35Rm3a3NxEOIAPB5KEQlVvTfq5+i501eeQbwkhNcyvX/mF?=
 =?us-ascii?Q?fR0Hqv0pmTFehPgtxPSZ1knc+jtkBeh5QHptnUHeteWXfEcZuhg2oDTiBUNM?=
 =?us-ascii?Q?R5VPYllaWpYGll7A5y0N8ZYjZxnw1m0mbmomaIqh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45babdf-712d-4bae-6274-08db55a449e9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 00:27:10.7198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcMPNuA+h0/u0Ec3sijZ+YDtV6fdDPhoK9qLzmwAwFPmGfOntImqoH7whZAWYxP6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783

fsl_pamu_device_group() is only called if dev->iommu_group is NULL, so
iommu_group_get() always returns NULL. Remove this test and just allocate
a group. Call generic_device_group() for this like the other drivers.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/fsl_pamu_domain.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index bf045f58cd50ae..f93306848a497f 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -335,17 +335,6 @@ int fsl_pamu_configure_l1_stash(struct iommu_domain *domain, u32 cpu)
 	return ret;
 }
 
-static struct iommu_group *get_device_iommu_group(struct device *dev)
-{
-	struct iommu_group *group;
-
-	group = iommu_group_get(dev);
-	if (!group)
-		group = iommu_group_alloc();
-
-	return group;
-}
-
 static  bool check_pci_ctl_endpt_part(struct pci_controller *pci_ctl)
 {
 	u32 version;
@@ -435,7 +424,7 @@ static struct iommu_group *fsl_pamu_device_group(struct device *dev)
 		group = get_pci_device_group(to_pci_dev(dev));
 	else if (of_get_property(dev->of_node, "fsl,liodn", &len) &&
 		 !is_pci_controller_parent(dev))
-		group = get_device_iommu_group(dev);
+		group = generic_device_group(dev);
 
 	return group;
 }
-- 
2.40.1

