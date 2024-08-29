Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1026618A6DF
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971833; cv=fail; b=h+QBuD9ijjrWG77D+DdcvZn30ZgyxfioLU1y1zutKbQHsjk+DGw+qBGZR2gJpOuy24u0w6etPnT19KNBKjNQbziTGnGeq67eMtUsMLIAGRBKCiJz1JQN3xbQu/5BxvUhHsmkMXCKubwRmjaPQYW9vJAHooJ9lJDKI5Dgn3C/A6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971833; c=relaxed/simple;
	bh=zsj97ac5XjOD+TTTMzWUr4KttOyCgnz6UQjW/RpVXoY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKdx2SyHhQRYytz0rb2K0XP2AF03zoaH0gK/6qVV+RmpCds7l1o7c/K0MAccKRbnIvthwQPLwzp0oe+LTtd2uGpPEN4p7rfyGzKl3o/feXKXkSVLBGzx3Vdt1ovKYW9acVmaG7irjV3j6ko0hsAeZiQTgU/4hHQ4cXdQ5k4FxzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B/RJtR3/; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B/RJtR3/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lv1qcMaC5F8zxXJpZAFOq0lAkf1iFELDbOhHIXBllJohEjP6g6d6lc4g+brevurDpkTAxxX606jsvgaePPqltPAqNRXxMzPZT/OaBVHWBxWMlfET8MPewWpLKeUvrhJHubQ7g612wkH0czTQan5aSLFY484l2yUWvpMlySHY7emUsiQxsgA3micGiEHznF8dx9EgBRsZXAnUjSMVHXB3xXsbMsl2O+AeUhIGf1reZav7SSsCIcberK11iTG2uT0EtT28aL61zIK88F4o0AnzrjE1oB7GIFaKk0llJVMjvNJ3I4h+/B06M6frC3ZBPNxYGkeGKHMSG+iAo2kAjZX8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Syyan/nrs9fEO5gwC8WhVkKwLnJATutM5IdxtUo/QI=;
 b=E5TWXc7oLU9YhYk4PVvoU5VityvxhJI+hkIpBzQgS5r35Q3Vz9aF8HcZIDRJWIkSIC0Pt+TV8dgqjMNnKtzE8GW6rWsSAwEFeFzgZBFuoNdFu/2wuaHZtZ3wXvcJYzDF1WrIdGEdaVCWACV/T11MyjRkUiuRm3ZoYvdQD11yF6h6Ne9Q+khTFZMCRrypPyufirLWOJmeg/Hrjqg5CbxoYnJFy/h7hiIWDig3P4dNYWP2psLoyablCdZ/WyFc1pa42W6tAPGTlnIm+UQZy+R0RhLAA1rBIanH+sn+iZ7SEGh8kgsrdS5fAoOdfVkS2EBL/stHoHcQszE3pdjG1ngwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Syyan/nrs9fEO5gwC8WhVkKwLnJATutM5IdxtUo/QI=;
 b=B/RJtR3/zt5+aCqEnpwcxfkuV9aoOUEbtT3I85TNvD0YXiqP8Ca/GdwnlR+K7Ix2A3Ur8UxBPWBu5+8qqPN30gdo5+MwyhwcHeKdyOA9AchsY760UN/zPXfKVrL/WZyWjUBqPlLzXCinw7EwlcKHeSuRlEamZn+9xCfSPoqB5zOJoHLNYH1ZjDuzE3Qgk3L/g+bOF4uO1wpdDZ3ZlL/husybhC9iQgF2Ezf+wqOUcMXB1iTAQBHg5xPldsuwYhWUfCZEJOy/xgMVJ+xpSlHpesC5YQ2AzeA6SJFpgHir5KH3WnEVFVBkhlcKibtbUCbotaVC+DA8FFdv9htrUl41ZQ==
Received: from PH8PR20CA0003.namprd20.prod.outlook.com (2603:10b6:510:23c::16)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 22:50:26 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::22) by PH8PR20CA0003.outlook.office365.com
 (2603:10b6:510:23c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Thu, 29 Aug 2024 22:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 22:50:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:50:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 29 Aug 2024 15:50:10 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 15:50:10 -0700
Date: Thu, 29 Aug 2024 15:50:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v13 06/10] iommu/arm-smmu-v3: Add
 acpi_smmu_acpi_probe_model for impl
Message-ID: <ZtD7IBiG1BGQres3@Asurada-Nvidia>
References: <cover.1724453781.git.nicolinc@nvidia.com>
 <8a2629bb98cabb1be72b32c120bb5ed0114b21bc.1724453781.git.nicolinc@nvidia.com>
 <20240827130233.GF4772@willie-the-truck>
 <3256d9ce-2c10-4cdd-b4c4-358f2c30a9a3@arm.com>
 <Zs38ZK3XERYMgXmC@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zs38ZK3XERYMgXmC@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 700774ed-b164-4be0-cac4-08dcc87cf93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/pN+xVFi1Z3213Z4fXkiEioeG7en++9SuFn2FH+DTE1m6IlBVLhrvqjj8SeM?=
 =?us-ascii?Q?gatgAKYSs5gQo5QJ5smZbXCioRL7YCUrjt3hH/9EFv2tjecIfWstMFqBQ2xN?=
 =?us-ascii?Q?8d17p+jemMMoWeby832SWDIVbWFfWFu9cLqbUDt6hoCQiEOU4aVcnMPqcsfJ?=
 =?us-ascii?Q?GWeKAdfkXv+jIOFImD/dzWEmyYF7r6EWk3Mq0imRfMbFBfxO0kKTbSaQSLMG?=
 =?us-ascii?Q?+pJqRCXGilxLDX4r7LqJTkBAjpCVvC+zCE0FZ5WkR5VkJYxHdrehO7GHjUE+?=
 =?us-ascii?Q?2bFU91WLGMu8AJuzNGaZSYNaQ07Zx3TIbc0EQQwK8JeI5CFVt7IHN/mzN1/1?=
 =?us-ascii?Q?GULY1SzRQHKzt9onqhPRZNyBYp0kw1BCGcOoGHMpkl5AMivxTP4kMz0zvTqa?=
 =?us-ascii?Q?tLEOSHsTGQ4WRGw+naYJaUpVA1mmSbSAHdKXj7cJA7jlCmdkvXR9aKAL6PrU?=
 =?us-ascii?Q?76VAGQ+dfleSc+iEYd951NvZZItO0C/Uq5G0trMtRYP1L8Ho990e1VQ9F5WJ?=
 =?us-ascii?Q?75eU08F+l/aV16gZnl/Ib7I6ldzk2ZDfdtHtH/QvXkdaTQwqpeDig1G2kyzA?=
 =?us-ascii?Q?ZLqU4O+3SY1KI0WgnkYQfvDnBqHaojua3jXESmy/+s+6WAXubw6zT2wpaNtj?=
 =?us-ascii?Q?fcok6nuhKe3wAi4RSD0C+iHCnd+RaDxJJqSY/lF4/S2wrUfxd5uQcbpTrhg9?=
 =?us-ascii?Q?u0GSU7D7ajotFW0N477o7pmceUp1E7x9obG/Qvs51TiBR6IWij1g1Uhg7B/L?=
 =?us-ascii?Q?s/wJGKUMEQK6ZQ4HMUyyPSY/ckIxUE51m5dZkKIIDV5jJysrpTVOYVNQ+Ahc?=
 =?us-ascii?Q?SmNGVXeZT3DbYtqpioi24AUP0pkDGFXjpLf6WwiL7JEp8zcvM6bo4UZ+dBFR?=
 =?us-ascii?Q?p3MaC/f7EM1h6EmWGPH/xpUN4+dh1vun27gOmg16MGLQiUhNLDQQ3Z0WzGm+?=
 =?us-ascii?Q?R0FxIbhovGKzqyWFcycL5lXTDH5GJv/qClRxN9Fh+8AZ2hddz2mlqD+8ernP?=
 =?us-ascii?Q?VykXmkypiwyeaBegOwf4QUWi0rUrqQHS5Epu2E3w/OYwke2/9R8SvR+KaoTF?=
 =?us-ascii?Q?WcwMii1DCpc0nUqYfvDYQWJGaoEF3BHPbKMwKpxQcQ9lwP/hUmHM+6gPGNhx?=
 =?us-ascii?Q?PtYcm/X8j/wh2/gvD78jDo11+MpDu/RkzDyPRNDOHZ+cacJOchEMiTbiqID9?=
 =?us-ascii?Q?61ES3wcW2KJ3LrEgcCEOXsFenR0LZOT7optKFENi3FJT00/AiUF8fpILpP1F?=
 =?us-ascii?Q?e0SlqdBAP5Qsrfs8qXTBB8U5OnhrRF4UutX235ZcOzb0M5s0YCZVTcU/80na?=
 =?us-ascii?Q?wu8P5MuYcL5EbmhDdOMo0NJWCdbguZQCkxGiTdWTR/jxQKDn4mqFUdatO2FW?=
 =?us-ascii?Q?MEGFy3DqhBRwXyRLoFrAgWapHLkb6Urj+AWvzb+R4svjxrJomiWEL3l6Fz0F?=
 =?us-ascii?Q?o8iMTRT4w6d7CpsDkr4xrqYQ/a8b41ra?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:50:26.1437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700774ed-b164-4be0-cac4-08dcc87cf93d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

Hi Will,

On Tue, Aug 27, 2024 at 09:18:47AM -0700, Nicolin Chen wrote:
> On Tue, Aug 27, 2024 at 04:57:48PM +0100, Robin Murphy wrote:
> > > > -static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
> > > > +static int acpi_smmu_iort_probe_model(struct acpi_iort_node *node,
> > > > +                                  struct arm_smmu_device *smmu)
> > > >   {
> > > > -    switch (model) {
> > > > +    struct acpi_iort_smmu_v3 *iort_smmu =
> > > > +            (struct acpi_iort_smmu_v3 *)node->node_data;
> > > > +
> > > > +    switch (iort_smmu->model) {
> > > >      case ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
> > > >              smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
> > > >              break;
> > > >      case ACPI_IORT_SMMU_V3_HISILICON_HI161X:
> > > >              smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
> > > >              break;
> > > > +    case ACPI_IORT_SMMU_V3_GENERIC:
> > > > +            break;
> > > > +    default:
> > > > +            dev_err(smmu->dev, "Unknown/unsupported IORT model!\n");
> > > > +            return -ENXIO;
> > > 
> > > We probably don't want this 'default' case, otherwise the driver will
> > > need to be updated every time there's a new model.
> > 
> > ...although the intent is very strongly that there should never be any
> > new models, because by now hardware should really not be failing to
> > implement SMMU_IIDR correctly. In some ways, having this might help
> > further discourage people from abusing the mechanism and making random
> > stuff up in their firmware :/
> 
> I don't have a strong feeling about this, though Robin's point was
> my intention here.
> 
> Apart from this "default case", I typo-ed the function name in the
> patch subject and commit message. Also, there's a missed kdoc line
> in struct tegra241_cmdqv (PATCH-8).
> 
> So, I prepared a v14:
> https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v14
> v14 changelog (attaching git-diff at the EOM):
>  * Rebased on Will's for-joerg/arm-smmu/updates
>  * Added a missed kdoc for "dev" in struct tegra241_cmdqv
>  * Dropped the default case in acpi_smmu_iort_probe_model()
>    (did this before seeing Robin's mail here.)
> 
> Let's see what makes the best for you, Will.

I just sent v14 by keeping the default case, given Robin's remarks
here. If you'd like to remove the default case, please feel free!

Thank you
Nicolin
