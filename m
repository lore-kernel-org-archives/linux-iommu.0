Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E5D2E62C
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775545; cv=fail; b=GEhXX5yBzzXyQ6nsO1X+uV1ApuNsR7nStyzhx7uh0+q7zNyMXcQSovAbFiPofK1wOdhC21JteEdqggAo3dPTGb/fmkbUMcXQY67JP5rtPtJq1eXoR6auq7/4OJqTM5CjSfmJ7fVKcuH2yERmd2Bed6i/4U0H8PiVfIcDYS15DJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775545; c=relaxed/simple;
	bh=WMvRAxXXmqgDzK5FhWRep/h4qth55ZT+2wejfwb3bGQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+VszRNMKL53zUY2k8Qxdv/VW2EZ6TXfZFYt0n5j8JFtX3WZ+zv5xxo7Jam3O0i8z3BD3Di6ecQX1NkN3aHZe9TjEvwueh6LQwfphIFCxRXKET5davuodGeBuEWHDihWPMCB8FpwRUTo7rUee0Ka+tToixWpVFHE/oGUGeMGCzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pAbvqgIf; arc=fail smtp.client-ip=40.107.96.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pAbvqgIf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMn+vMaDjc/6n0OjnBmu7A/bLxlrMSfAfCeByDiHHv3b1yQNaU4Wyzea/061j7dzJTvNQ/6g2KG7g1fSqrsRsK0292cWc20Bw0XRFEKxWhu0EfwFPB9ypjm5H+UtuH1gcKIjXKFINcEgjib7iINfbXgp9cvA/75W/BRwlncsVd/kGGuSDhSUmeMArfgsMAlhe3gJVP43NfNj3voOT/94IIT9unYOVvBexMilsoCHG9oSEuCLqzFIFu4w01snfXBW/yeGtYaZzT/v4LmfYCoQ85EpatjD6NrAKVECVkc7IeRLgdrkxz84GQ374OV6xrVZqPAgjq9PrsAJEbI9g9XViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrmKXSzm6G/0wLyeLOVNYeJPtw/J96eBqyhVaem5ziY=;
 b=AUJ/2CinYFhLpt+EWMivoKH731EppxHP0CryXS02dOBAaPwdxq4WL50Gig2U9jAJ35plYdsC8i/9dFzbge5VnAvJk4MgbAy+IlOWULwpeQ4uGn1E8SjN6F0DaG1keRz45jk4qLoTyiTF5ZtEfGCwrveTnc3H26JAdj0OEJ9Yas2zUpYev5JMrgiAFvltC4iJ5hkFMfuL1sw9KEpM/ne01IPIzcXDWGF98UtugrEXvfMsYn/JVq0i2KrWLDkcJ3uDaCjm2T3YVjtfjXEclPSfhl73mhfrBXUw+RbsJL4pOUSO/Pm0C02CRjUykGfp05euDMzvHPBKT2WQPVc6rC5Y/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrmKXSzm6G/0wLyeLOVNYeJPtw/J96eBqyhVaem5ziY=;
 b=pAbvqgIf88YaKk/VGP1eUFD3Hsvq+cLT6sMENaL7vGPYCY6Pkxu5BkwajdftSUvGRN/g8VrT29KGiJsfKlqawLp5fR4u2QC71pHP6T54MzXnTRVk6riFP+tFv8a7bxLwO68iDfgb1jDYPxfvaEyfVcbIMVHQuuEqIsMuueP1h8Xql17pz5hFTC8vRg7jgy0qoXRrDHaNc7E271wZ8t4WJ6YEDHyKZzrEFVOzLhZmaK47zojtWgj+MgZtVHywp43ic19p/hXEBkdLTolK45kmPVZ/wBYZjA5bXvlRKoA30gtsB+XdmpJKClrBRsnu14d7cjkOdZUWGlDPudeq0ENfkw==
Received: from SJ0PR03CA0250.namprd03.prod.outlook.com (2603:10b6:a03:3a0::15)
 by DS0PR12MB7703.namprd12.prod.outlook.com (2603:10b6:8:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 16:18:55 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::94) by SJ0PR03CA0250.outlook.office365.com
 (2603:10b6:a03:3a0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Tue, 27 Aug 2024 16:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:18:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 09:18:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 09:18:46 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 09:18:46 -0700
Date: Tue, 27 Aug 2024 09:18:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v13 06/10] iommu/arm-smmu-v3: Add
 acpi_smmu_acpi_probe_model for impl
Message-ID: <Zs38ZK3XERYMgXmC@Asurada-Nvidia>
References: <cover.1724453781.git.nicolinc@nvidia.com>
 <8a2629bb98cabb1be72b32c120bb5ed0114b21bc.1724453781.git.nicolinc@nvidia.com>
 <20240827130233.GF4772@willie-the-truck>
 <3256d9ce-2c10-4cdd-b4c4-358f2c30a9a3@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3256d9ce-2c10-4cdd-b4c4-358f2c30a9a3@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DS0PR12MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff164ad-f2af-4724-44f5-08dcc6b3f2e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IChl+v2xKOK7LK89CTKl7DrUcXxHcQd4+4X/JBXfI+A8CF2jvmNYUnyJfo/5?=
 =?us-ascii?Q?MsdKQoGu63qpweI4KIChfGlJ9zJE7S23v980Qs6zNbPHVq9LBSn0snFI4Xk+?=
 =?us-ascii?Q?dBFkCDH/QCsK/AU0t8Sydk4dkVnyB8xgF26i4011uQvUiNOpf1Jh1AlNVjCP?=
 =?us-ascii?Q?5a1pB8+Vg57ry92hkc3W5A2QkCCEATtOrTTDWNielEmxU/2rIFg6tb9jnIuY?=
 =?us-ascii?Q?H7MEQPhfYmKQKGY/WVdF2nQh1wrfRfOU84SQhhEEf9Gl6Lu75Gunn93rzW9w?=
 =?us-ascii?Q?v7D4x+0NtISIjGXPHSkGV261OBNLpbY/KY2/cywoOh+GLtlrcgfprOutBRvq?=
 =?us-ascii?Q?5lMoRv/HWBp5zYcqs9ew1Ap1CcvjEdghQ3cmkezDjyFHhI3zTG2OOpYhPLmr?=
 =?us-ascii?Q?DUK2J9McIU2zgms1lt55VjuKlWM5AqJIm3BMgNi0ZEf4G4eu/Z6hPWiyxUwA?=
 =?us-ascii?Q?zpc4rti1UvlmKFAx3dBIgDsuytSantOyzygLxx8uddX3zwtmr5Ahaic2Oeqk?=
 =?us-ascii?Q?YFXcx7VjZECAzwIwZJcFU+gr27SJYdG1aV+eZqt2XGqXGr5E55aH09e0Deij?=
 =?us-ascii?Q?ZwjTLdSzrcCbiIE9cmkKBU41XXebXUiOrdUnfWDcDSs8A7AQsLzBHqhnG+HJ?=
 =?us-ascii?Q?hSouinxLN5HN7hb7xrb77WDCKEXFb6sBggGu13AasD8FVwU9RL89tkJbWqkI?=
 =?us-ascii?Q?4Tsxn0cgfv9NnfOk9r7NB2f6AxFO4+XpE9Y0CQxRki1OZ9B4VNX0UEGb97Yu?=
 =?us-ascii?Q?Zc4vRVHZAIhUpxBNwhnnyvB/JXhuHoVQWK6fwmORCqkK3KfwogNkVYqL/wcY?=
 =?us-ascii?Q?A/GC8SN5eKw+k/1uCA1GOXxItzSO3w1u9lsYjLJ98EF8iDfpxWGJJ9wIeARg?=
 =?us-ascii?Q?yAs3gWto+mqcCquhDQs/3INAWO2B6HhoJz72sOokH9JVZZ2Fluez14hgCrEA?=
 =?us-ascii?Q?Ozbhr0WFAn90ncS4yGlBoNb4BEPFZh1tFibpa3NpFcWY0GyJzdcPWPHlZqs/?=
 =?us-ascii?Q?PWcOMnCIRCfFD1LS9JaO4DWPFYi2XSBhR/VeWnO+YAR8Sj2hBNaLdV4rWRXi?=
 =?us-ascii?Q?+PPoqrVQPyr8a5K66cZTvsg4+9JLMygDIqIoF1jyFAbdIG2nZTJqgBVD7Tmy?=
 =?us-ascii?Q?YC63fqQaGNiDfdXp0KwavGqa1UY88tHlZejNezWz2vDrzoMZKa19dAHCCUyU?=
 =?us-ascii?Q?JuaJQz0BlLX0LgnyhS2hM9DXFIi4uH2fo2AyfCunABi/2NxdTv7kDt7mJKMU?=
 =?us-ascii?Q?HfkybtdiBh3yLxlunNBan1dob/dMjhFFYWOEOPx8Dkgi0+YMHVS5RikaFptZ?=
 =?us-ascii?Q?hJBnbbgMcGI0fCb+5B7pPsv8/zLcn5NZXY5soOTGqU2qAKJ3covJoiucLOGM?=
 =?us-ascii?Q?Kjc9nLUZ2dYbiE0ic/Mf/9BxnQaCcfABwVeTqWKUk1Bu4qvzcVWVtGy7J6uf?=
 =?us-ascii?Q?F1DmAXqfr2nWVpvowl7LGICRpeXimUoa?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:18:55.6143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff164ad-f2af-4724-44f5-08dcc6b3f2e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7703

On Tue, Aug 27, 2024 at 04:57:48PM +0100, Robin Murphy wrote:
> > > @@ -4341,18 +4341,28 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
> > >   }
> > > 
> > >   #ifdef CONFIG_ACPI
> > > -static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
> > > +static int acpi_smmu_iort_probe_model(struct acpi_iort_node *node,
> > > +                                  struct arm_smmu_device *smmu)
> > >   {
> > > -    switch (model) {
> > > +    struct acpi_iort_smmu_v3 *iort_smmu =
> > > +            (struct acpi_iort_smmu_v3 *)node->node_data;
> > > +
> > > +    switch (iort_smmu->model) {
> > >      case ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
> > >              smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
> > >              break;
> > >      case ACPI_IORT_SMMU_V3_HISILICON_HI161X:
> > >              smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
> > >              break;
> > > +    case ACPI_IORT_SMMU_V3_GENERIC:
> > > +            break;
> > > +    default:
> > > +            dev_err(smmu->dev, "Unknown/unsupported IORT model!\n");
> > > +            return -ENXIO;
> > 
> > We probably don't want this 'default' case, otherwise the driver will
> > need to be updated every time there's a new model.
> 
> ...although the intent is very strongly that there should never be any
> new models, because by now hardware should really not be failing to
> implement SMMU_IIDR correctly. In some ways, having this might help
> further discourage people from abusing the mechanism and making random
> stuff up in their firmware :/

I don't have a strong feeling about this, though Robin's point was
my intention here.

Apart from this "default case", I typo-ed the function name in the
patch subject and commit message. Also, there's a missed kdoc line
in struct tegra241_cmdqv (PATCH-8).

So, I prepared a v14:
https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v14
v14 changelog (attaching git-diff at the EOM):
 * Rebased on Will's for-joerg/arm-smmu/updates
 * Added a missed kdoc for "dev" in struct tegra241_cmdqv
 * Dropped the default case in acpi_smmu_iort_probe_model()
   (did this before seeing Robin's mail here.)

Let's see what makes the best for you, Will.

Thanks
Nicolin

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8b1437240ce5..f23245012681 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4356,9 +4356,6 @@ static int acpi_smmu_iort_probe_model(struct acpi_iort_node *node,
 		break;
 	case ACPI_IORT_SMMU_V3_GENERIC:
 		break;
-	default:
-		dev_err(smmu->dev, "Unknown/unsupported IORT model!\n");
-		return -ENXIO;
 	}
 
 	dev_notice(smmu->dev, "option mask 0x%x\n", smmu->options);
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index b794a4dcbce1..5ac3032ee6dd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -160,6 +160,7 @@ struct tegra241_vintf {
 /**
  * struct tegra241_cmdqv - CMDQ-V for SMMUv3
  * @smmu: SMMUv3 device
+ * @dev: CMDQV device
  * @base: MMIO base address
  * @irq: IRQ number
  * @num_vintfs: Total number of VINTFs
