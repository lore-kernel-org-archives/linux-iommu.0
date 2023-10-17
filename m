Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA222D7AD
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gFYtshqB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0Sh9B7dD2kwqyED76JFIMCeelf1O+q1HMVDBsR+eVksS6LVProosf9njBMvq9OPrixZcMohYaJq8QMjT2Ol+IYADeXiRAtfnZ86WnFwfYoeHTHZtLkqkHNqYxMG3x8cs54CShrtbt+dC0uwmr8iEhslI++wlxUX7+o57Z535ehnp3mrV+TK28scaq7Yy+y656QCGwndTIaPqyXnSDVvLLZtkelvsYdD7qEaonpKk0S8O6JOvHkuJxYSygcEG1uZ+dsNaju1jT1HmHbob+ztEfpG3fnZ+/t5fc7VDl07E2ElUh5gPxkWTjRGcsogSWHLjWt9Vk/ZM2RpBZ924PCkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StQSqzKwhoFAaHq2B8OGVtpvqmb8X67Lf9dhcw73CtI=;
 b=MjGgXvwmMEX+D4ITd0x397rQCm7NVO7cPfQdWkgSxuY1LYShLPjZziKVKwE5lPaEQzSIfkMdYJi9rBFdDVIjBxvdozv4eyQabzIc4bzxIHhWCpPocYhB2nbB+FFsTKt5uYsfVSuedgn5OwczTeUybmMRNp63C+ZNPCcRTMRqZMIJ3sG6OK5zaZJro35iTYXOprlCKhrQ2Mvy7Uz0xBhLYb+9BZV7+iZ6NZiyPg8Dl2Xg0vF1hL3OvAeQ5T1R7eEXZbsqoSZls08z2mh4eAx7u4YfAxTVvqovxVjapYZzGRNUbM4fKVHkBnui+R0MoZWminYou+24BaI3iiZ8foxpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StQSqzKwhoFAaHq2B8OGVtpvqmb8X67Lf9dhcw73CtI=;
 b=gFYtshqBgJ30txbEkKd1mmjgyzwZZZr1EdqKiKiI9p6+dXZus14zdkBglaVdimt8Jpko0bD1tYL/buRZRd8TkTQXFSMt6Lkwd+H9FhTce3SX7GdsI425w4Ffz0qTilRtozqvkBLjmnDovEru81Z/onZwPXXdWckzQXRtz2I3LDd4c7Bz/4B7E5UBQV6ALdGL7RoEy79WlzCLJuqdkbKsk3Sxs7gYbLVZGVBCzRnDQJjvv5wpwznXo7jafGgRH/LXTNTyWhUEe/aedI7WcaGBtIc2n3UPLL+DBn4RlrtjL88mqHUIrwwSumSqGQt9ao9no7rA8qZSCZvXogXdu4ZC7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Tue, 17 Oct
 2023 18:11:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 18:11:49 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 3/5] iommu/arm-smmu: Implement IOMMU_DOMAIN_BLOCKED
Date: Tue, 17 Oct 2023 15:11:42 -0300
Message-ID: <3-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
In-Reply-To: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:408:94::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: f3aff064-0029-4536-e7f1-08dbcf3c8798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hohNdFIX1OFQ623JFxS2wT84HjMO+WB3ZOOb0vTvg2mZoStaAKGwoKgyhZaea/ss2KIWTI7MxT9r06jR64wE/jsvxArCkvivUsagPti67FDUeoZNWD/Dg57hVBvbwSVQUnSMrG5GjtOFwmbtgwntI0ZsgmWo/vpVeCuIZCvphSuu3xyJ8WYTlL3PdDtVJu0b67/INQnUPoKFsI+lmZbS9GaBIMm8epJGVaESklQa9f5RmpHnSKyFYh61KpevNEAAypcawn8Zxb21oxTNLu6/EQcweOtNVCpPZBEnoh+aFQWOsfbYAudlZxovM/xdy887fd/QZlMMokGAZRlpHi8Ef/fPMtY2eJA5Y4SAjOhfLAt62LoOkFxLs3JdtvLKZPi/l5Dum5nCxJX6izMPeZeg9DzObNhiLLwdnzajBT+GG8h8semn1EuNIKj0UR6lOH6qfG9ekZu9Slzg96eRVyU0tfkGEPv7V3x7yFBFWaenaBBzBqeFTB5h5+nFrj1x4yV1AOoU2xwLQNwEo/kipaPUyPny9W4O+jmPxRW1sDTxLTEHbsZzcT6isSB2wjP6HJF66qmekTJJ68NOVwFyzXCKUoKuiisPN/bhK4luoIATG0g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6666004)(26005)(2616005)(478600001)(66476007)(38100700002)(36756003)(86362001)(41300700001)(107886003)(6512007)(4326008)(2906002)(110136005)(6506007)(8936002)(66556008)(8676002)(6486002)(83380400001)(66946007)(316002)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CIwNvGTRrH+pnZgsjr3IBgnrMualhKtDY7FRsZbNnrsQLqQzovIMzmzZnjoc?=
 =?us-ascii?Q?8l23idfoc/OhVRKuQ2ZMnyQpCndZm1Coaj34vA8v2fEHdxTPT/7hiZ4iatBk?=
 =?us-ascii?Q?zBv4Iy+R9Lelwwh7poSZhR0ibNgL+Xarn+YR0eydVLtEwszl6fPGdMxDCGtv?=
 =?us-ascii?Q?3/7Ei+/d38Ur7M0dZdeu8Xs6Y46GaI4orV9iRTg8ZA12Wctm16ra486dpY/N?=
 =?us-ascii?Q?E6D7q+Ok6ZATGlvPhvpIBErYNfsz48A6v9GhIUb8AZTCY07E7ncD+PLzJwkS?=
 =?us-ascii?Q?M/g1p7HNx/XGMFIvQJE1IyInCuq1DedE1X+n/rVMvc2Sx04hxfUNZ/WfXIav?=
 =?us-ascii?Q?ShrGmZpLLvuslpcEWwP7JvXoabTPpRzq1/IRwENSgvBCRANyZF9fy6cLoYHj?=
 =?us-ascii?Q?1NzAwdSHbTIHB1BKp4th5DvRxH6JSUl5NHO9VO+ubLgnpyu15G4YrBqk9yDY?=
 =?us-ascii?Q?Hd24UduGE7/o2FS9rfCeEFbNH/aveNidejvbgz6g5rjF8OVYdZ1HV1rTbXyF?=
 =?us-ascii?Q?d+PoOTQ3YsRcQlxeJhtRIuLD09ewo+XFTM1zuVD6X3qR0b+/ug6WXbndD4y9?=
 =?us-ascii?Q?DFiF3eU4RXE5JoQZkGYT2ek08Ia8LWsKeCSJCg5jqGtmuMK+Z30/uylz7Gd5?=
 =?us-ascii?Q?FqtVtJmBbwLIoHjLVQ2pG9FH3+Wp2D2TBSwU7ESVfEvcsZDGhtk84HI/zj/Y?=
 =?us-ascii?Q?/n/1ymc7RVIQp3poGB8J7ATi6V4T3UYkDstJHbNxN0duhZeji9B50ceiS/Rw?=
 =?us-ascii?Q?UvMTB9sk7ryWSlcP+ag9A9k3579BNyH4/keiLS3zdtuBd6DNCHVTXycdzT5j?=
 =?us-ascii?Q?CJBiahKB81GWJmckE7am1oq0aXh/1P+E0pocJNrEV6IZaJfsIm1gWvAHoZOh?=
 =?us-ascii?Q?GxalEf9ibK5q4fgl/EZhjzkVTfjTOt//kZYvDAbBNsegj0BdfZvFFBr4M+PQ?=
 =?us-ascii?Q?377AFd9ibTSPekhmCgcTPbN4uUDX0dx23HKFhgMYU3l0/voRG3LyWB1chJ86?=
 =?us-ascii?Q?aPePOa3p1+OnBYdCDFq4GLhy4TDjnWkM/tKx5cxAjRXJ35RJha2w53lfu9Vx?=
 =?us-ascii?Q?ycir0lug3rd46wuOvuCEdseChc8yJc36uXy4TX94WiEcNfSXeXJPkfI/SKtv?=
 =?us-ascii?Q?CB1Pz9sei5B+NMpfEs4on3MPPFbo3jgSxU39KCQW7Y5hewBEx9Z02dBOGFbN?=
 =?us-ascii?Q?BJl6q+MGEpCtGWOZhwPb5TVfXdVPLIljXfWGrgl8r9NRwi3uDGE7uDYjW8+f?=
 =?us-ascii?Q?GtWk3R0IPVGVra/Pej4jFA7NUPyRUvBj+2578Tg8BITwZaR+Nj3FdkunvQJL?=
 =?us-ascii?Q?hCdma+KyNwCbiqu9UxicuI2DthE7cyuVO9BSlg03UDxWM380UMMsZF+wG24J?=
 =?us-ascii?Q?nVoPaIlpv70GaZ1ICd24Aqt8RWMGi2xGivlns6tuAEgNpUzPInzg1XsoRr6/?=
 =?us-ascii?Q?CRf60/GBP+sE8uVeeVMquuFh3q424Jmhjx2C9JJuqjmnFngVDERQiYaZ5CNI?=
 =?us-ascii?Q?dvg9tfKCZt76/TmVCZOG+bb1QwYQYOdxyYISqaw9YiXpNyoA+YJUlOi9Mfuj?=
 =?us-ascii?Q?XWKZ+tzKWHwGMB/XFqqyW6cV4Sz6VPAIgJmuj4hQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3aff064-0029-4536-e7f1-08dbcf3c8798
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:11:48.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCXhbhxA7sU5wytLSK/I2HePnmqz41MiveP4keR2HkRoLdDnIThxEQifsdCc8nMY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265

Using the same design as IDENTITY setup a S2CR_TYPE_FAULT s2cr for the
device.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 28 ++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index dde912f8ef35be..421f3a13c6a9b7 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1161,8 +1161,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return ret;
 }
 
-static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
-					struct device *dev)
+static int arm_smmu_attach_dev_type(struct device *dev,
+				    enum arm_smmu_s2cr_type type)
 {
 	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -1177,7 +1177,7 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 	if (ret < 0)
 		return ret;
 
-	arm_smmu_master_install_s2crs(cfg, S2CR_TYPE_BYPASS, 0, fwspec);
+	arm_smmu_master_install_s2crs(cfg, type, 0, fwspec);
 
 	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
 	pm_runtime_use_autosuspend(smmu->dev);
@@ -1185,6 +1185,12 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 	return 0;
 }
 
+static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
+					struct device *dev)
+{
+	return arm_smmu_attach_dev_type(dev, S2CR_TYPE_BYPASS);
+}
+
 static const struct iommu_domain_ops arm_smmu_identity_ops = {
 	.attach_dev = arm_smmu_attach_dev_identity,
 };
@@ -1194,6 +1200,21 @@ static struct iommu_domain arm_smmu_identity_domain = {
 	.ops = &arm_smmu_identity_ops,
 };
 
+static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
+				       struct device *dev)
+{
+	return arm_smmu_attach_dev_type(dev, S2CR_TYPE_FAULT);
+}
+
+static const struct iommu_domain_ops arm_smmu_blocked_ops = {
+	.attach_dev = arm_smmu_attach_dev_blocked,
+};
+
+static struct iommu_domain arm_smmu_blocked_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &arm_smmu_blocked_ops,
+};
+
 static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			      int prot, gfp_t gfp, size_t *mapped)
@@ -1581,6 +1602,7 @@ static int arm_smmu_def_domain_type(struct device *dev)
 
 static struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
+	.blocked_domain		= &arm_smmu_blocked_domain,
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.probe_device		= arm_smmu_probe_device,
-- 
2.42.0

