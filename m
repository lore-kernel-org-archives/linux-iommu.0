Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817322BDC3E
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605822; cv=fail; b=kG4aBy1TS12TxcIsVSr/duwbwlB74WaSKtCNhDpEfXC3uko4JWyli/HpjEIKdz8Q18bs+8Vf/qzt5HCegBThMUzKgM88Dy5eWNuwIbWXX2c28nO9pQDVudBXd61Xai0akav3m3/eWDr8DniBRYAo1tDVDdodxM9eBF6SAPtTNWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605822; c=relaxed/simple;
	bh=9U2P25DrWdAC0flAsxi2aMJQCjbdVUCaCtlQ2+/KS+8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewoMeHzvN//vLuyJuKBvFnJtxMfn/Ul8FhanaUtBdp78tlu104S1+VGmrUKkct8TfPMqnb+ZtgrOZKFBDfT/BgIR4dCisucQayB5tmk09kExAFMcZ8h05SxMqZOTnlccv1whCEgr/JzD5zZg4y6Jd/1zzGcW2J11bQcRY8Wky7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y773ZLIY; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y773ZLIY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPZODD9w8Ju7mwGD6WkSp+ODHU91V7eAVl7hBwNhTV/4Q4S9PsQZ/244YqdmlJlXtU+wr459l5b8XYAQsHYzn+dz8iyXItjGHvgS2Znp5EREfyNvSUWYucnLZ4UaJgYAOmHFRsKCoJQo+sH7VVBdqhzNJ4DY3wEcyGOHg8XSDNkLmBkSNk7F6xnnQbUCaOIc8qqEPA69J/ZgPDo0G78m+OiDjD+nVtaTXsZwt29L4R8r4Jndkpwy1qJ9a/hWmlcT2mab8ZZiRnff2lggMOw6Xfs6SZ3AX6wOwGBQc+SukIKituuUBZRkAPQIiaKmrvDRLulZzujUdFXD3xgqEQlltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wIMjI1SlENBp4d8UEVdX/FYeDMzGjopkmMxAXXSjl8=;
 b=LYzZMeb781uKb8FKPK18pLy2U3mc3pJKa6jbBowlZ/ftPAfdu++MZaRovRdpWO5YRrjDmIlbz1s35MHECtC3Ez91J6iX6MPAcZ4C1dibTjD6UFYO5CIGHbBVetr10EJ/EIU0+ulgHzI7a4lJMtmZVrrT9GorXuV2EWKCZsAdnZYw2T0WlrLSLjxgEP0UNIfQkoHJK/grcowyXy6e0RrJJo6xpjCktppd7DKViUksGUGrUlk5CITQ8t4LeEheeZEg7G4GlTqayJb9REiYIzyxSXIlwjrfIlDtOrkZanNcPJNZIMQ+4hU0owkxYZ4W3d/Hz8wCK6H9M3Vtagaoib9kOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wIMjI1SlENBp4d8UEVdX/FYeDMzGjopkmMxAXXSjl8=;
 b=Y773ZLIYxHRBCx9mmlRMAwQEl3zi7mCdXVT8uZA+KuYvsMgcs5/JuptGENC/n502kqeNGMxTe6kNLARDcIS/Kh5MCosKBdUJvIMrFtvYYk9eq4Xm0Vu2I6uZ84G3qZmGcXBLru17E9WPV79bCGMtEtv9Pq+VA7eCDkV8Iw0N7r8e+Ynf64b6Qlszh/+6lZkLH+pSPyPDjJ3hFBph41PzpxKlzYAq5fgu0ygqfL6Hpi2juEz5JfE21LvKCL4DlHO0cXWLcHnJhozpE/XZjD0vmooN5vdX9JK/OCxXDiDyXOV++d+zPhAARUq+vaWMR0MOwOp46C61eNJ9so2ulEp7Rw==
Received: from MW3PR06CA0024.namprd06.prod.outlook.com (2603:10b6:303:2a::29)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 18:56:55 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::a3) by MW3PR06CA0024.outlook.office365.com
 (2603:10b6:303:2a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 18:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 18:56:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 11:56:34 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Jul
 2025 11:56:33 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 11:56:32 -0700
Date: Tue, 15 Jul 2025 11:56:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <jgg@nvidia.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v5 5/8] iommufd/vdevice: Remove struct device reference
 from struct vdevice
Message-ID: <aHakX0SzQ9/EX3AT@Asurada-Nvidia>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
 <20250715063245.1799534-6-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250715063245.1799534-6-yilun.xu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 241ff14f-655c-40f1-a783-08ddc3d15dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z4D38xI9uCiItmtvqOynqgpR59z9bt0CqpY3grdK5h4cYsj+dKuEUe3sb099?=
 =?us-ascii?Q?3E2nfR6RUyJVOJHcJiMT+08K1L4CEWshaForJRZpZ59yi5bQwP2QetYxJuGE?=
 =?us-ascii?Q?OtqfE/Z0nAAc9QcRuwpALDPEfT4eP1HvmQd0Agr52CbT/BRNJG/p1BDtwGjI?=
 =?us-ascii?Q?9+TO3DQeZMio9e04qu7RScrgXK74/j2oNy+U+nPwaSDX4adWUGuJo/4xOJvs?=
 =?us-ascii?Q?mOQxapko/q4EHHe+g7JK34fH2mWABqlizJyUAOQsHYJP2ajRyTSd1W997jI/?=
 =?us-ascii?Q?9GMp4NG2tvdWkO34cgpJF7wd2MtJSP4k6x/vmFBI1+dSqyn9VfD6L4Y8+OJl?=
 =?us-ascii?Q?jI/vg8e2tHrWz+Y854gdAD1paeOd34hw+8APq2I8M+rUvG+h+55dtRQguiSI?=
 =?us-ascii?Q?CeYiE/AkWC7S8dqWwnxkCDgG2RvDEBIJwqa2zeTQOP03u3V5zkEK5cHjW3Eo?=
 =?us-ascii?Q?iJ8ShWK4dllMar38FHvAGmCdJQakko9QlucR4IcW6kWczjhg/VxVRtBMntnX?=
 =?us-ascii?Q?Iw7GUb2b/XiQXaUjQRoF7ClZViz9MuGU7gOtsHWlONX+DRR3enZSA/pPtLNP?=
 =?us-ascii?Q?N7vQHuZlPsPnKx9MP+qLUwQ6hVss97S97XqLsZmX8AYLjV+ucKdlLvs4ulqa?=
 =?us-ascii?Q?IyJCnn3WlkHvIzIDRg5F0OKCt6Way7K6dTWBZwKjXaANP2sYrQBwK7vta3X2?=
 =?us-ascii?Q?Kcq6GurtcX9TMXTyCNmrqdvf7Fb4XujJHDsIFNOF9OqdMCBHyNP8XXusp9hD?=
 =?us-ascii?Q?wYZII3nbgp+5oZYuqhvlCfhfsx34MX+VDlCwgpRsjV8Mfxio4mUFxsWacF9t?=
 =?us-ascii?Q?Lylzr+abghnR50ngIXUVfe68rI9toiOlLVCG9YMmYzdgMPmvwWCAkRsyPsbx?=
 =?us-ascii?Q?120FwaE0fLdlumikgxuIU/Je9hjYWL7PFGTYySltaWkxro3voh26tqwte6Kv?=
 =?us-ascii?Q?F3AR36/siiwLh+exr86NMzVVFzjk69+ZyJ07lZV+9l5zUkEC6kaZeUlqj2uS?=
 =?us-ascii?Q?7XjoQ0Ku9qtW8TkEwI/MHIrUUWQEiJOEos4QvlPCpJP1sl/DLnGZrh/kproJ?=
 =?us-ascii?Q?KLdHB18OSjddcfYJ606ke9EwwoqSleNdPpWLwSsb75x++i83eIOtZZLAfhvl?=
 =?us-ascii?Q?KBcwd2VQ3h7jFgicCGCaPbRSdvXOdTgkEvdoyoB84OmrdqqFlu8sUI+HtH6n?=
 =?us-ascii?Q?J/v8ZCMjEu4B5X/J7f/knu+9u/Gi23+od1K9EUmXLPU51C34sNWC+Zj6Eu+x?=
 =?us-ascii?Q?jWxzBKHiH0KkhZMTfLm1dYvLUz8Cvk0Z+2XVHaEdW3WRfkply9Gc3k8/8sMe?=
 =?us-ascii?Q?YWiLCr9LCkFPul1bOuKw1UJeMOhhoBVZmFW/MAf6Flk8nlgCVoGHURaQ3JIz?=
 =?us-ascii?Q?tMMkvPAFSY1woYqAVXjd8zSwPHA8MdjVwghC5Jw3lAzyYl+s1kOzfO7kIYHa?=
 =?us-ascii?Q?8BzJdDD3K8uRL9Ua5ARXU8JdDfdcGnkoRwDUCG9Zsy0/UZmxhEl1pzsHAVww?=
 =?us-ascii?Q?5b/iFy9iOnJ8Mv1/0Dgqs12lyKHj1EdJhDpH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 18:56:54.6013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 241ff14f-655c-40f1-a783-08ddc3d15dd6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104

On Tue, Jul 15, 2025 at 02:32:42PM +0800, Xu Yilun wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index eb90af5093d8..8a515987b948 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -1218,7 +1218,7 @@ static void tegra241_vintf_destroy_vsid(struct iommufd_vdevice *vdev)
>  
>  static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
>  {
> -	struct arm_smmu_master *master = dev_iommu_priv_get(vdev->dev);
> +	struct arm_smmu_master *master = dev_iommu_priv_get(vdev->idev->dev);

Hmm, this breaks :(

drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c: In function 'tegra241_vintf_init_vsid':
drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:1230:71: error: invalid use of undefined type 'struct iommufd_device'
 1230 |         struct arm_smmu_master *master = dev_iommu_priv_get(vdev->idev->dev);

Unfortunately the iommufd_device structure is defined in the
private header that's not shared with any IOMMU driver.

So, we need in the driver.c a new helper that converts a vdev
pointer to dev. Something like:

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index ff6bbd2137146..fd6b083535271 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -1227,7 +1227,8 @@ static void tegra241_vintf_destroy_vsid(struct iommufd_vdevice *vdev)
 
 static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 {
-	struct arm_smmu_master *master = dev_iommu_priv_get(vdev->idev->dev);
+	struct device *dev = iommufd_vdevice_to_device(vdev);
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct tegra241_vintf *vintf = viommu_to_vintf(vdev->viommu);
 	struct tegra241_vintf_sid *vsid = vdev_to_vsid(vdev);
 	struct arm_smmu_stream *stream = &master->streams[0];
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index df25db6d2eafc..6f1010da221c9 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -83,6 +83,12 @@ void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_destroy_mmap, "IOMMUFD");
 
+struct device *iommufd_vdevice_to_device(struct iommufd_vdevice *vdev)
+{
+	return vdev->idev->dev;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_vdevice_to_device, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
@@ -92,7 +98,7 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 	lockdep_assert_held(&viommu->vdevs.xa_lock);
 
 	vdev = xa_load(&viommu->vdevs, vdev_id);
-	return vdev ? vdev->idev->dev : NULL;
+	return vdev ? iommufd_vdevice_to_device(vdev) : NULL;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, "IOMMUFD");
 
@@ -109,7 +115,7 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 
 	xa_lock(&viommu->vdevs);
 	xa_for_each(&viommu->vdevs, index, vdev) {
-		if (vdev->idev->dev == dev) {
+		if (iommufd_vdevice_to_device(vdev) == dev) {
 			*vdev_id = vdev->virt_id;
 			rc = 0;
 			break;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 61410a78cbce7..ee88e90021870 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -266,6 +266,7 @@ int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
 			unsigned long *offset);
 void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
 			   struct iommufd_object *owner, unsigned long offset);
+struct device *iommufd_vdevice_to_device(struct iommufd_vdevice *vdev);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -300,6 +301,12 @@ static inline void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
 {
 }
 
+static inline struct device *
+iommufd_vdevice_to_device(struct iommufd_vdevice *vdev)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {

