Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B0617BB5
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715528399; cv=fail; b=fqA6L6wsyLE1HU0fUT8WDaIf3lgR7dhcwEputhr7taMGl90ovYeC8Abn10Tp7D/YPCL+oitaPicJSsZaSwdTCpkRDSe98sE7pUzeF9u0fwEMtRDh10+gDsWYijENZ9wXgZsn9/+aXUn3D/0SFya1vNd1wZ+kRvTSpzrjPog8oR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715528399; c=relaxed/simple;
	bh=M33sbEXzsnsxc+7GUiYJRrgAgS52b6VKuRlTE+4BKq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ax0rk/ckmFDS15uOrckFZEKRlPWbbP/JD+sJeoNF1ZXa1kHhRklI1zAOqUS5MyoMObWbK2xqeouMmVjwGzAnsfysNLujCi/cm+KURedbxjbSGt3HMGOqgQYI5usUMqaphk1dVnpBYDOraCYJEKX8ybo6YElO9Ey9O9nd0PP6jDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MV/TLB75; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MV/TLB75"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHn6y27l2YikwXpXsFxMlMO6TfNJCKMuaUp5r1y1AQDI3pflCucELIrcM5bkD8MiMmMBi8My3kU7rUPM59kTwOWboQ1Gp5FDILkOGJTFp1+J9YL1mxp1UY9ejsw7mEAg0M3dmcQGU2SZwvGyDtV1db58kt6K+yt2zd5hxXC1C6v6BqMrdNFSVC3cqujO6eLv/8JiToLWNseqzNp2qTrvNuX1CFi9r2XgphiDmPY53M1rt7sjyrrpr6MnaZjqKKuoHplrGSbaPpy64EnYVBIvhzeCtGWnZXtlgLex8XH6Ain8ArwsPoqo45xO96QcunvkqE1PB2LdoKCJVaU8/8E9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8sGSdkM2LusJV85I+N0UP+xPk2lSE7opqD+z8fhk4E=;
 b=Tg5ef9NpCEyHKyeBftHI0dxpgsVU5pQyZrkkXM3SwSypgC4U82qohDOZBnoYryYU+VQ999I6a4enc8bwbgM/E+TJJNF8ccspxk2mFL0cc667d4v0YYniUP9gYCD5AiaYTjbMeC1unusod5UwmP5rfYoJ1acM/sHz7SwrW7Az7k7nN5Hcoz90mcbqIRDJozf0rdvQduUf5EBrBtsKUKxASNOb8ghNgwlts80dvxUdBfv7xtJ/fOadhcgzO8GOwpQwgtnT08c7afqZJmOvmzNC94NSsdB2YkdcPFFHSIzkUrPD/q+dwqOT+u4O+EauUzLCcSs6CjUFk9ddso64xiVEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8sGSdkM2LusJV85I+N0UP+xPk2lSE7opqD+z8fhk4E=;
 b=MV/TLB75EStJr9kEc1/KqAgC0tr0Z6mxM1DrQ1fI9LvFk6EuztwugHOZjVf3NKgXwX5i9Bw7eCsqOoyvYIYgH3Jm/NuvfSeLfx8LcQ3hczYS+4tMVDYb230AKxj2R0e8Wj/43y9HP9AdAPyA5H882OTO169Cy3OROdtxLnXIfgeUADqAKAL5jiItuJZ6glCRJ9ulN0riMQj2ADM1O9zJnRhIOfrQFcSwMM1KVj0CsX/fIjXQJKnTUkIPkvvnxA2If0eInsCbQ9iFU2e3Jsts3aEm44AReok/ussL/8JNpy3qIppzCa/kmHPOBjKi5+YWfKupCa+G0o6OnWP9AR7pJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54; Sun, 12 May
 2024 15:39:53 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 15:39:53 +0000
Date: Sun, 12 May 2024 12:39:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 3/6] iommu/arm-smmu-v3: Enforce
 arm_smmu_cmdq_build_sync_cmd
Message-ID: <ZkDiv10JYCjNblv/@nvidia.com>
References: <cover.1715147377.git.nicolinc@nvidia.com>
 <52845c9fdfdd7f38a694e7727f3eabbd10e9f8ee.1715147377.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52845c9fdfdd7f38a694e7727f3eabbd10e9f8ee.1715147377.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BY5PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::20) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 315bc7af-acee-48ae-36e4-08dc7299c451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NpIcUXwOblY2pr4qyjIEe+6lT974E8ifjbxBTNdNc2LoAsPJZnkDVrdHFtl6?=
 =?us-ascii?Q?9lW7i+bghPFd7gORmDwUI/zF14DDZ/V7iLn65JvM87tiU4bVfEbtcXCz/lFA?=
 =?us-ascii?Q?7RLCwdB6Tjc3HrLjjhGvik7YUe18m1DxjPXdA8TaGBHZ5dCVA/Tx6D0avYpE?=
 =?us-ascii?Q?+K75gPYvrRMZIfedXS2Nv2zy+9qug+jYowTU7rNoFFEApa1wUcOrcR9/Nlgd?=
 =?us-ascii?Q?PISkIhZ30FYxvDlcN3ewHwRS9VwPKDFoz9pefeCy2jVD70xXWMGvbaEAaGZd?=
 =?us-ascii?Q?ALKLCEiYDqB7NKCzXIxLQySrsc+YqRp0pPbBbxr/pPgC4Ed4DCK2iEsp/xKG?=
 =?us-ascii?Q?fFRFZzs25fAanv8emuDfYiBDZy7s2HxbUBbWdf1lAF1sF/m+nDlvSzbHHPjB?=
 =?us-ascii?Q?j8I3QP8plMyFgVHWYSojGCm8KRFakiRBNokI/i8rD0qYIBkZyBQB1Z/KFNXC?=
 =?us-ascii?Q?aAlYFrJvvMW5/TftFQI0nTzmG4DbThlECUmy8di0G8swlzGXLkOKA6b61TVM?=
 =?us-ascii?Q?jd4v439ULhpkuBDSWX1D24brpDimYOX3kF9+rLvMn/Z1gCxzr2SkNM1+l3AE?=
 =?us-ascii?Q?ARb4Xwy3FPFmofvNePVlruHSoH2X1eLkrfzSyWEqqu/UVWT0VY+ScpuLrN0w?=
 =?us-ascii?Q?x+0OE2gdL0N1rYS1J5JARsprEvqeWpSzxIVJ0L5bV5cRw6Fj2k870sabWd1W?=
 =?us-ascii?Q?xI6cpmFhPCnsympQFj52EMOhnV/ssAV2+4+PkJnjtnyLzlQgAJ7z9Ex+pH3c?=
 =?us-ascii?Q?Itdf6sKJI4v1Gs4mZix1WdNcn02OEtobtilZw+5gX+vlqh99/3GjCgRWyLUr?=
 =?us-ascii?Q?tB8YI7oknKPPL7s7lFlUL3JzGVedghQiI49WbqnuMYpKNf3S+25omcNkshat?=
 =?us-ascii?Q?EssgB1AdMHiKtFNaUaWyf2oIrcl3opWrBLSjsmLUZMA8uJFfKOJi45I2tXhy?=
 =?us-ascii?Q?UiNWD1vNdQ81MdXInZUP4Lv/Rv0VKCIC7L0QyeiyShH6+YnOBEmgNTiBjsjD?=
 =?us-ascii?Q?FTfGBarTQrSbjURKp/2VuNRmgy//dc5B8hdqNLQBZR4gGQSuOcWioyWR2OUJ?=
 =?us-ascii?Q?1yOjdMZ+mDJdqyjFcuvtQxWPrc8gIZCORlwGi+Ce6X/iymVPTBcR8tQpnJQe?=
 =?us-ascii?Q?Fzob4QOxE/m3LCK9MzMZARWOVDKgeWv74dL08Mc24dFF+c4vUScPWfuLaIBz?=
 =?us-ascii?Q?9NB8YZwB7Lb6IZ2mCnC2h660M3+sbq3ldqveLA/OMcYZ95l1EUTAB0SN4cLd?=
 =?us-ascii?Q?QA2CHjtDrhqPPHrf4mXh+eusCDWE5ugE9aq5Tp3nlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HRdebMU4eKU1X2jn2m6Q2zKc+il89a6cXZY8BVRieMxsZSd1ZjOsHWy5cezt?=
 =?us-ascii?Q?l/hgbr8u1Gejg6kbDANdk7sq2usgwqzcYABsdywh3GifWfKwMps52U5ttwx0?=
 =?us-ascii?Q?4+6UCdNSuvcy3XNQ6gOSsAkm2QCteN17QXmn7TkOqs/ZzsIN4FFW5noMMqpD?=
 =?us-ascii?Q?Hgm3dXxEuZOErH5k9JA/yrW2TG7orN3xSBhdHQW1jMZYmG/3aGXEZ6J2lzgd?=
 =?us-ascii?Q?m6QYv4WPuUs0qTNiba9NF3u+271BX3hiiMRSjf4LwgAL3h3AihXkVrutNA+P?=
 =?us-ascii?Q?HJZywhx+QbEwbw7nkZRQEvOgBvjlxODRLby4vUCumVzxz/p8AUM9pkys1YCz?=
 =?us-ascii?Q?nX03DY7IOXLUPSFQtRL/vi/jwQwMWszg24mmOO3/UFaLX8KAm7A0QvH1xOnq?=
 =?us-ascii?Q?mC2S3YDQvuXvnqpKV7H1qkXsesc82ov4olFHithdJPKA4eDNiitL0MlGZVgD?=
 =?us-ascii?Q?HwAOGqDMchSdnPtrIS61jW23HOtgf4p8joqPStYZnqrzXaOwtiLDi0P3Zval?=
 =?us-ascii?Q?lZ3P4JC+/kseX21NIjsBTuC8WJrVU8iJtLEoXzSCJqNglCGLJYqZo6gKnJFy?=
 =?us-ascii?Q?Zr+JU2qUusGVgo7IVVxf7gAkSJbpFyZsE4xiJD2+bkL1jLsfXog/s9MN749F?=
 =?us-ascii?Q?YZYcAswn7TXS0dHVD37emtiHAG3ZLkjjVG//81Jk4BWmFfPg3NpAdlVePl21?=
 =?us-ascii?Q?5/WqItAPV374mb6Ym2yqjUDZPtkYfwZ00/4KqEfuFxyNhtlGMOHnQyw6jaNq?=
 =?us-ascii?Q?e/Gfk1FNuaEobeOoi9hZ4Ag5lRFvnH09rUXz4W136hspHmoQbUf1dRVkTFC7?=
 =?us-ascii?Q?cA4dMpGJs+Jg8rvreyo//y5Z5x/73PBPQAFoiyMRe5v1I0PmLvLo+hj/7N7a?=
 =?us-ascii?Q?3TdiIHC+OYQhvthCDnsVLIMS6TaOOD8GcwV5RJ9h2h4gfeXR6MW1mzSHNRiO?=
 =?us-ascii?Q?2D7IbOO8tQbyi4R2iaZpyetIUVDwaS+qoCEkZ5pOl2fH+GnC9N2ZDsAOnuwX?=
 =?us-ascii?Q?TxxBewh7CgDm8o0MTwjXa79uL5mtybPjvNLPEgBqfR98juFycGWWUbQ1B0yN?=
 =?us-ascii?Q?rLXMIrm5Nk3eRuv2C7pKp0qFgchlSFnwUyK291T/Gd+iI5k5jzgQneTfzSau?=
 =?us-ascii?Q?z1XqycdrWROtEMh5kCHo6uL1+SUzjmezToxWkQ3uRQEnZO8cS9TIPxmuugc4?=
 =?us-ascii?Q?44h7v2Vi/wgJml7LTiYbNw/gquWMaqatAU4ZKkbLb7d3nDriruvx6uYZ54UL?=
 =?us-ascii?Q?BgFTwuPflLMrnr/0SCugF6ZbQc2Woj8bv5BFni9/EpEN5UAKBCaNfr7ujWLC?=
 =?us-ascii?Q?Zv6SuoR6BWwt3eXSgoXglC2QMuyDywdfFxIBHoN8NzQL7dRPwJsANv1qO3TY?=
 =?us-ascii?Q?0qTJ3G7yH3sGcIiE7IkfmyYcO9MmO/7WaGPbUAYGne7/Ty8QWGpr/yynyHuV?=
 =?us-ascii?Q?JluMmsdG1W6e1SM8gxM5h2x+1WktumsVHe5cGNWjKbepd0fI3ivcSAxesf0k?=
 =?us-ascii?Q?GytorAqQZd5i0VkrEpivl2nS2K9vZ+Y2d9uN9o8u+JMcBZ9DZVd6nVO/dks3?=
 =?us-ascii?Q?qzIKnhBJYSGYAKa1eLiAz2GERz3ANXdjYJDcpWTB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315bc7af-acee-48ae-36e4-08dc7299c451
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 15:39:53.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kZFopkrdt+cs2DDHECK3T4Xx/n1q+w27GviqXgJU5v/rq/mkae4puME41stZNHu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482

On Tue, May 07, 2024 at 10:56:51PM -0700, Nicolin Chen wrote:
> There is an existing arm_smmu_cmdq_build_sync_cmd() so the driver should
> call it at all places other than going through arm_smmu_cmdq_build_cmd()
> separately. This helps the following patch that adds a CS_NONE quirk for
> tegra241-cmdqv driver.
> 
> Note that this changes the type of CMD_SYNC in __arm_smmu_cmdq_skip_err,
> for ARM_SMMU_OPT_MSIPOLL=true cases, from previously a non-MSI one to an
> MSI one that is proven to still work by a hacking test:
>   nvme: Adding to iommu group 10
>   nvme: --------hacking-----------
>   arm-smmu-v3: unexpected global error reported (0x00000001),
>                this could be serious
>   arm-smmu-v3: CMDQ error (cons 0x01000022): Illegal command
>   arm-smmu-v3: skipping command in error state:
>   arm-smmu-v3:  0x0000000000000000
>   arm-smmu-v3:  0x0000000000000000
>   nvme: -------recovered----------
>   nvme nvme0: 72/0/0 default/read/poll queues
>    nvme0n1: p1 p2

Nice
 
> @@ -350,20 +340,23 @@ static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
>  static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
>  					 struct arm_smmu_queue *q, u32 prod)
>  {
> -	struct arm_smmu_cmdq_ent ent = {
> -		.opcode = CMDQ_OP_CMD_SYNC,
> -	};
> +	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);

The command would also benifit from its own type someday :\

Maybe this should just be cmd[1] = 0 ?

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
