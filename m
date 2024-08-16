Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C6C1C3F3D
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830988; cv=fail; b=briuNGqFf4Zh6jmJ2/AcY1dXp5YWHY2XhRuEJiiYD8yTyXeYpdymgytn9WwdbbyBLoVymKaoP6V1tGK+IdFbcbk0rNzmtNyO6KthWj2eO9ZyieVGbgJDhYKc2xvIQD1/vpOYPfQZv9MviMSYVLNA5N7o62jhalUusxZfZ32ZfRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830988; c=relaxed/simple;
	bh=IfPy2GDD/P31Zw5EtJ6wgt8pK/apGeRtonxPzQWbs8g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTgN6SniGq5FbASia1C/k21idDoYBHrNxiVVmPhJEre/zLWIpx5Yg2QT7MsjH5TfYOleOsICiO+nv3N/Eg9ynEYRMUFZMtsnRa38pbRFWHj0V/ZMsGFloUaJZHxW/XkftcbJ6jjiENC+tNHvYWBGZJpGYHaVLGX5XkUjmIqVsSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V+KWZnz+; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V+KWZnz+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7nb3BQvsyHAZsumvbSJLiBm7BR7NGUQSopmy/6BgnYlBQqcOgcskUcmLcEzSbSjsVVUjemjhXk4U9vAdxO+WoESlbld6B1DKaJVVt1i8O+5B6Vnq3oEP6WHwMIaAh506Iwg/YuIuu7FagxhrAYc7tdSA2DfxT1yZLeVjCm+W+KMDscF64gKxEg2giR0sIADEkh4G9bmerwqDAXOLYyBQadMOtIE7S7NbnHHGJVPzZcirXV2Sm4yjyxDV3rWMXjWnO4RFFiw7a6bFht4rWnNpQCdNTESm8wdFsAeVJpwxlJ0bBh/QtUjlVu1diLbBtOi6FDtPuLdSetxjXhW22eBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqCFfnVqPkZOsP5sAC9Oc/nP0sAnJ0tnm2bXOadJwLI=;
 b=D+DKbJtlA17MVJBBjrEClvXZLcCSsqL06/RjMye57A+edejvFKcVY2nHBDCyXUNDS4agFxWcVyuBO3bTMz6CKBXHbWH4T0CqMt2WSuqkRly12OF1rtUG4FcjtnwNB4skdM6cX29jHSrrLwbIEwseYjGf/rBInfwU+wZRlRDSwpxb6AdGy+lNa5NFPx7F0ZNiiqG2TheX4xHBXI/1MBqEL3lgQLUE4EP7cU52l7MBrAFcezE1hFJwJAD3wE7TVtD6ylktq1OVTvVsxOkAJ9xcZHS5ehJ5dEDGsr7s19JK31RJSdK+jivEhYqwtCBbhA+ju2nD092XeJa24wC2uTm0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqCFfnVqPkZOsP5sAC9Oc/nP0sAnJ0tnm2bXOadJwLI=;
 b=V+KWZnz+fGVqtw+e9Ufhu4tuBs+5BVWD1XPaPnE5btcr1nwBCg9cl/wxqyWECkDHs5wJKmUQXO8WU7WvuljPwXTE7Q2R8gtMOorRY8GkAaRaOAIF1H4K5e6zX0iBtIXAx2jrjvf+OLQ0KB63HvnlwVEKUybD4aang+TzGxLgTZLtCVpFMWalDMjwHP7weBW9scgxsOSsCyrSePbKnriEFMc4PmCym5EF2Fn01CFD9u7yrAylUVIIGeafShvz7bndxL1UWgHlcLiGf6qwCbIGFUfPbLjD3VSfDE9m/axcJIh4Yj2owRdrLpJzZFc8ffHoETFLmfeWSW7riYI0DovtyA==
Received: from MN0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:208:530::6)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 17:56:22 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::14) by MN0PR02CA0003.outlook.office365.com
 (2603:10b6:208:530::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 16 Aug 2024 17:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 17:56:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 Aug
 2024 10:56:07 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 Aug
 2024 10:56:07 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 16 Aug 2024 10:56:06 -0700
Date: Fri, 16 Aug 2024 10:56:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v11 2/9] iommu/arm-smmu-v3: Enforce
 arm_smmu_cmdq_build_sync_cmd
Message-ID: <Zr+StUydk2tk6WmS@Asurada-Nvidia>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <9e59a460c969357a98b3434ed5007ddf9381899b.1722993435.git.nicolinc@nvidia.com>
 <20240816135331.GA24607@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240816135331.GA24607@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: eb894f5d-9d71-441f-332a-08dcbe1cbd68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AJ9QHrGGVuZ8GmvrI/W5p02WjQp5RWZuAY0VtA5oeyWuQGWDDSt3xd0av79x?=
 =?us-ascii?Q?xn5ZpG6PgFAMl942F6BQqJGTd0oJ/mEwfqUsF/dyLSPTDP6/7G5SB1XNx2G+?=
 =?us-ascii?Q?1R+UTvTni7E0+eR8PPEnE5/beoeshINC0WrLgCOklpi/ZDZup9V6lA/5wKtg?=
 =?us-ascii?Q?sSM2lqCOv1/JCJDuWtdGLy/ykcxrJouZ7iJEz4/rudRXlwYG9Maxuyatgjkh?=
 =?us-ascii?Q?5B5XGqs/3MLZUXgq/Tlim26jjU4ctTa1s9xhJ00FT7ycbMzw9ClTZnOckD0h?=
 =?us-ascii?Q?HbxFdP2Kalgls2VmFqzV/GfOYnN7OAnGLVm1qM4vSEGU3/RqXxn4UIvXennk?=
 =?us-ascii?Q?kOxMxcWn4HCJkUMNQQHN1Xz0RVHcQh4y6XO60FdRKZuaLsOxvAQ3fKP2/Jhi?=
 =?us-ascii?Q?sow8bYdEa/+X45d70WMHcQNCfZcNwD9cJKKr4l3OKnCUpk6zbilHEBjTOv0j?=
 =?us-ascii?Q?FMKaXsdhZIUwBgJmgaNGK61Nh2xC8zA2DXKFVc3Qnqq6lwMOGQtTN3+cxNfs?=
 =?us-ascii?Q?8JGSai5AiouCJXGaDd2LciYZhGqMrvskDm1TlbtxQdkNgUzyxgpyxz7ltbyd?=
 =?us-ascii?Q?RZ1b4/4N9x7aXdLS7dQ+cwF2VkeQnaiLdDgtlgBapZycJmWTuQ8gZJSPprMZ?=
 =?us-ascii?Q?rdRjvYnChV4Q0W1Ca7MNAcz3K16E+2tAZ/1843dg/zQWYMb+PQWb/ogRgjsD?=
 =?us-ascii?Q?wFtgGX1HVQJnjL7/ImVDJ9kFQ46zxYYBAMg2VxL/HOL/3aMhz1gbfYGT6G2t?=
 =?us-ascii?Q?Sv1hIwL6M+LyvYvLlzgW4FKr3r/VyoK0a0bSBCR1MQl+exi0+mVMurliJrmj?=
 =?us-ascii?Q?mupjiMIKABo3lrLUiyfilHKNsLcYrI9A2rNG+dfKSQLrJ1OUvcK22hw5RmOC?=
 =?us-ascii?Q?S1wkiYys2FAJCQocb9vTmgVgTFxovw7j3tCK6cmA2OvzQnYoAn+zsF8Yi5M8?=
 =?us-ascii?Q?eSUwhB3+Au9EiWKRidJZW+43iwWF+Ty9usyimpf7YXRVE//6K0vysAeZ92Ol?=
 =?us-ascii?Q?8PTS5C7HEOPkMQMyP0dXyZno8OY2ds/dOpKcgSdW4ouHR5Z7VE4kSR/uMMX1?=
 =?us-ascii?Q?7zUvNylefuQjjLOmUu/3OLL4JaMD11xsdHNQXFD2EtirxMOC8Q8SRzoMD/u+?=
 =?us-ascii?Q?5tHeCfBnetzGJAauCoqJNMzaf3ZCUapfyDnGHH6yesPomycxNyclrPwTez/+?=
 =?us-ascii?Q?n8qIDSjcq8sjtfo+GJe5Yhdce8Rs7fiwOfNOaD0/PqdQxabMD2WNEtdLAOt5?=
 =?us-ascii?Q?CdtkQEpfoYaSckHAMAf0WzI5ba/QEWPYGLwDOl+Yyxp+5pJ3DODReyApZmKI?=
 =?us-ascii?Q?hEDHHbS3q8P3IYolfYBnlOLMWXDh7Fcktfh9T/n29QZjYW9B7lclwvEwf/AD?=
 =?us-ascii?Q?WEOuq2IFMs59NIoMeOqMoqPtpr+TzEJ77Cs2OyRjnpjjEOztBRpZbtK6IPW2?=
 =?us-ascii?Q?v5c+nyV5XqCoeTPg4H0Eg8CKE/65HE+I?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 17:56:22.3820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb894f5d-9d71-441f-332a-08dcbe1cbd68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059

On Fri, Aug 16, 2024 at 02:53:31PM +0100, Will Deacon wrote:
> On Tue, Aug 06, 2024 at 07:11:47PM -0700, Nicolin Chen wrote:
> > There is an existing arm_smmu_cmdq_build_sync_cmd() so the driver should
> > call it at all places other than going through arm_smmu_cmdq_build_cmd()
> > separately. This helps the following patch that adds a CS_NONE option.
> >
> > Note that this changes the type of CMD_SYNC in __arm_smmu_cmdq_skip_err,
> > in ARM_SMMU_OPT_MSIPOLL=true case, from previously a non-MSI one to now
> > an MSI one that is proven to still work using a hacking test:
> >   nvme: Adding to iommu group 10
> >   nvme: --------hacking-----------
> >   arm-smmu-v3: unexpected global error reported (0x00000001),
> >                this could be serious
> >   arm-smmu-v3: CMDQ error (cons 0x01000022): Illegal command
> >   arm-smmu-v3: skipping command in error state:
> >   arm-smmu-v3:  0x0000000000000000
> >   arm-smmu-v3:  0x0000000000000000
> >   nvme: -------recovered----------
> >   nvme nvme0: 72/0/0 default/read/poll queues
> >    nvme0n1: p1 p2
> 
> Hmm, I'm still a little wary of this. The only reason we emit a CMD_SYNC
> in __arm_smmu_cmdq_skip_err() is because the SMMU doesn't have a NOP
> command. So I'd really like the SYNC to have as little functionality
> as possible in this case.
> 
> I think we could either propapate the 'cs' field down to
> arm_smmu_cmdq_build_cmd() or just open-code the command-creation in
> __arm_smmu_cmdq_skip_err().

OK. Let's go with your approach then:
+       if (arm_smmu_cmdq_needs_busy_polling(smmu, cmdq))
+               u64p_replace_bits(cmd, CMDQ_SYNC_0_CS_NONE, CMDQ_SYNC_0_CS);

Thanks
Nicolin
