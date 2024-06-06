Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C254F615
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715475; cv=fail; b=AOXQvA1lygPYYQj3f7aYKkC4hBzYsciXrAigqXs0K8Ac8lf/CMVohoo+G5xZubBhSYOdswSumEoGNvCt/wzWaFKeh0iGYnhgmmd0DlRxqoFqIDohu5HC/zwej3n16VdWjdbK1pfxONjq08i3AZw7VAG2BnVUYv3OZsqaCHXdadU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715475; c=relaxed/simple;
	bh=gD2G8jY2tx8qtLDAPgUeSsQIJ/nUGOID4Z0igzt7kvg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiqo6M6hsS4/QYRHTeAqQYp82ViXtBqzqAez1GjamSTleoa7vf/Gwav1sccZ06Xs2wfX4AkX02XEPpsbBTAVmTUIhK5DZlqsFpCdzWCsNxxx6LFy0mE7Yqn3YLW9oHuZM2l5NLaKksWLxYO1njf99jSFDmSXy7er8/Mf7b7CrpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MK/n4Aub; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MK/n4Aub"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5oxGJdROQY55GinDBPsVSkozpMsG1nwIlAai4JDbBgRSJoRjkqGzxlNdZpiYl3jRac6IO7CLIg5Z6XBRVxlIwC156tm9dxLGHO3CrL8wJaFywVBTZR17foM4tmEiMmd9M+CaGuASxkbgfEpfM7GC8ZxbXON9WKdnPU3ndV5+XVYv2ZDUbjOtKWh66UIo/4eVTFWoXbtiXuFwtWsdig1c8sqhUS+PvHIj/+x4bFfr9uwt4XEQUfOZwhPCREingd0MF8v/p2hTFZke4rKa5zSW0/1jitGhw/7L3UHOPZGx3LjNxIX1xp/Cgocdj9eFFSotRhU4Rt/AkKBsVziBfGdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLmBlSTjjZ3VKSJo7A2eXMWKBKjGIaedDsTtatoE7w0=;
 b=SFmG+2acMsGLU7YGTbD0SWRz9I3/shjO/7JYYooMcu9Lnlf3rj1Sq12JcB7Zfyv9sYArufnqjFA/J7ZKQeUkRT+yxgUYNrC0X8bAbixBGTNXRTIVE+lpVbWBndfjFHAvMR62YtdxnW4A4lB4KYMoglQzh1g4Po05brASHilwowdVW5Fe3VmSvjFEwMxeUTI87alfnuP7ZL4/Mjkpf8+SJ/+8Cl+4J01CzRhMaXiD3EKMVYKZuZYe25VhBOhNay+eiXUF9zs+HgcnwSPyufwErXEV8WrW79gxyJoyiMcEVbvOGoOrdnBnz/w2XtIMTgRDa/m1A3tSB630cNfD4Pbr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLmBlSTjjZ3VKSJo7A2eXMWKBKjGIaedDsTtatoE7w0=;
 b=MK/n4AubEvpmCgt6XpCbxYuMhWDIpPTsyVY/gOuvqaMQ4sQ+OMxEbFunDUhrEFI44PG693g3uG+nVolPquuGokaHPBapHNK52aL+4lkQ7lYeZVCDN9xYOW/jwOS47w44GJ4E5lxr21pYzcrZFscJu/CmQ0151R1L0G7KJmHBQZoVi6P/lkmwlsHgBtcbVV5tq0nx0SMuzeiJPK1XH1xRP5pbOcJHype5ZuzhrQMOz2c3ZkNcP0Naij4N1oA5H9V9OAkq7tvn60r5yibw32cl68CxgyrBZr3suRyG7K8ZtqDaWaPIWCc9lP+P5Y6wobZ4uM4njCRdoKbURN7UVaKftQ==
Received: from PH0PR07CA0016.namprd07.prod.outlook.com (2603:10b6:510:5::21)
 by IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 23:11:10 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::5c) by PH0PR07CA0016.outlook.office365.com
 (2603:10b6:510:5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 23:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 23:11:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 16:10:54 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 6 Jun 2024 16:10:54 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 6 Jun 2024 16:10:53 -0700
Date: Thu, 6 Jun 2024 16:10:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <kevin.tian@intel.com>,
	<mshavit@google.com>, <eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v5 3/6] iommu/arm-smmu-v3: Add feature detection for HTTU
Message-ID: <ZmJB/IjP+RVTKp/5@Asurada-Nvidia>
References: <20240606133302.17540-1-shameerali.kolothum.thodi@huawei.com>
 <20240606133302.17540-4-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606133302.17540-4-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 321862b2-ae41-4e78-794f-08dc867df3a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p0RtIvH22g0GEfn/8pZ8NH6s/ub+FRKOR3IQTx3i5uGQprkM+zGuRFTOJxrR?=
 =?us-ascii?Q?vV139KKt6M0Da0NYhjUjPmYZuIcf22S7BkiZhyHpow7XXxNqxwCITGPyqlk4?=
 =?us-ascii?Q?f/Ow4vd3Qdgo21VmsRqqI37/CtYVn/OZPvPJe8a5fhatESDcl5Jm7qbrrv/z?=
 =?us-ascii?Q?LztGutcdpx0/yP7674VssILqgEsWBsGCzZ7G699tnkpRrMepcMIJRBDFqFNH?=
 =?us-ascii?Q?LLECHhOoPJpXgy728yDxM7eUA6lHj6JnWYTe4WIptI3IeSgdGO9LTj+Pk5t2?=
 =?us-ascii?Q?3E9IjTKGEb3xaVuHsWICSzk6osX2I59t7ps/9MMVhoawUwDM22JtilYBpOZP?=
 =?us-ascii?Q?M3mQdilUDbQPCy7P5+x9PWojIR2MMKQBcKyQzOY472oiQKFEHMnnbHCIFcYV?=
 =?us-ascii?Q?Hd8iVCfCGu7NVjn9OrBqzqlyx3ATU3vhVVe6g4odrqpQ33wpTva+WkMAklqo?=
 =?us-ascii?Q?+fxoJ4jsWr4TcseyhIdG/0DeBJWjTSs/RJs/NiwfTbnX5fL+xFMg+FAoEuvO?=
 =?us-ascii?Q?3Zj7ASTh9fxSVV6Ozf1C/dO28KE5vPD0FzZAjP1cegyis95MXCj5p+9yMMzf?=
 =?us-ascii?Q?awbBTywp95aPgv3O9zMmPpQ7WV7kMxJWt7Pak3djdHLKInhIdn4i0JeAAR/c?=
 =?us-ascii?Q?jlneAf6Z2of+4wSUDPEgRBkaYxec9xvMnAl/kx1I8dxA3iRIk1XW1dxRyJOM?=
 =?us-ascii?Q?nkuoswfKlDihk3ApWCrTRvKKhsY1R41psLGPvSQEZlx4uXIvknLLv8PEigz8?=
 =?us-ascii?Q?jXly8Coq6V8bAVBqSAF+5CCGO2dMp73dlUWN8zz5E+VeaZQ/MzRPn78jXLKD?=
 =?us-ascii?Q?7Pm2lKvDENdN48C7g0TGT6fBoHA6IbaE4EY6BrLwOYxxsGsjrVVonEeDNxFM?=
 =?us-ascii?Q?906lLkeLMGjPZ8ZTukcrrxikX4c0546K+cK5u5eZVIfZyvtOk4IpBR4Uq1Cn?=
 =?us-ascii?Q?Wz80b3je7Mnym+iA9tjBMUvrNCkGcx1ZNZuY1ZULZKheulsn7bItnWz7MoGh?=
 =?us-ascii?Q?aEGjr8uh118xCp5yqnJXbGM3dA1T1IkXsBPlDY8XZTq8qStMDu48n+UxhvIE?=
 =?us-ascii?Q?f9c1QUGPk3hS6jq9uHWqR8i8JCGFRnLU4WOmIrWMzWcEIbfAEBlqc1QawL6k?=
 =?us-ascii?Q?U2k/k7s+vhLGPbNhafil7NtqnVyw9VMXhgEviqJrV/haHzDd7rKPHVcF0G+c?=
 =?us-ascii?Q?wfNkTkXX10WBYDtwNLlOXkQEq/Ya/EPmz7bc5hxdKKgfiyq01ltpj3uWWLf+?=
 =?us-ascii?Q?4eWOudTB6FWFeOI6mD7g5o0RH4doKYmbjA819WEVvkN7Pn7Tq0LiSfG0DmXO?=
 =?us-ascii?Q?aAo+ysfEZvF8M0lHJ1L/TIpWCOQXoyubpgZnb3GkWj4ChT/6YhJEjcxX5bCA?=
 =?us-ascii?Q?KPO03xCBGbFDRV0uQc1wu3ydhuAp4wG2aa/ZO/mUNL0GwPfN1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 23:11:09.5128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 321862b2-ae41-4e78-794f-08dc867df3a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205

Hi Shameer,

Some nitpicking inline.

On Thu, Jun 06, 2024 at 02:32:59PM +0100, Shameer Kolothum wrote:

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index e30ce55ed1af..c05a74aa52a4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3738,6 +3738,29 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
>         }
>  }
> 
> +static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)

Following the other helper arm_smmu_device_iidr_probe, how about
arm_smmu_device_httu_probe?

And we could pass in FIELD_GET(IDR0_HTTU, reg) too?

> +{
> +       u32 fw_features = smmu->features & (ARM_SMMU_FEAT_HA | ARM_SMMU_FEAT_HD);
> +       u32 httu = FIELD_GET(IDR0_HTTU, reg);
> +       u32 features = 0;

How about "hw_feats" v.s. "fw_feats"?

> +
> +       switch (httu) {
> +       case IDR0_HTTU_ACCESS_DIRTY:
> +               features |= ARM_SMMU_FEAT_HD;
> +               fallthrough;
> +       case IDR0_HTTU_ACCESS:
> +               features |= ARM_SMMU_FEAT_HA;
> +       }
> +
> +       if (smmu->dev->of_node)
> +               smmu->features |= features;
> +       else if (features != fw_features)
> +               /* ACPI IORT sets the HTTU bits */
> +               dev_warn(smmu->dev,
> +                        "IDR0.HTTU(0x%x) overridden by FW configuration (0x%x)\n",
> +                         httu, fw_features);

httu and fw_features have different shifts -- could be odd to see:
	IDR0.HTTU(0x2) overridden by FW configuration (0x600000)

FIELD_GET(ACPI_IORT_SMMU_V3_HTTU_OVERRIDE, iort_smmu->flags) seems
to be overcomplicated to reference? So, how about just features?
+			"IDR0.HTTU features (0x%x) overridden by FW configuration (0x%x)\n",

Thanks
Nicolin
