Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE133BBFDA
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031300; cv=fail; b=D4KHRSP7zZ/G8nk3bnb8ZPmBVn9YkyJQoiP389M+IP7nrMGkizo+WccjYlRfS/Z//PZ6zHZc0jGwAJe3/0m6Gf2qTePBLhMsnNGefuRDtrZFXa4IBKjvGkMKx2mn99l6GPNZFxKnzX5X5WUW9ag2/a2h+foVS4eXCmy735WLWKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031300; c=relaxed/simple;
	bh=+r0f1xeetQiRE19aV52Es3Y4/gt71Nrdbx8heY4lEWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VXbHAeYHvmUussqf3QPHZe5IHHZb+v1WE9iOjaXSSuwTuLNWUWObRzEqQWlI95HImOVrVi9FrCGoV2DuC8CeWdZxBkd0EElxxcW1ysnZeiiQq3/JLBe4ls8Il2lrltOiTujr6FwuY8sHf3oku3GpEKy92LN+NMXJ5/03QA0LGUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YASo8Ppd; arc=fail smtp.client-ip=52.101.48.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YASo8Ppd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mzv9D1zfkPVvsr3DT0G4R1zGb2jdzBaEeMUa5JhMiU+gDkhDhYadliUarWvznYgGJZ0/9EtEQd2Mq1QQTIB9+vC62qKns6+g4NeVw23/AZM0emKQDzq3evqCAzBK4687Sc1lVsu7gKv+iLvUm7AwQVhxzQNOL7d3Mr/+X7rmiDhRddxM9JvPnGraJ4uZAufs8EzPwhuZf6R3m0vOaDTy6Ius4PKonGgmcrwu0Z0bvEsyPzk9Wp1+2JAjtj6BPMiG506Ea2JF7Z+icczqUsqJHgJZzYz8ab/GFmhYapuyYuTdty/s4LNe+PzOlKslnU0nzM1x9wAC/81WWAkflDwqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrRHfZFwGInew6tUBEvzZHHpSp2kLmR63FMbyiUIDUk=;
 b=W7xGl3yBLR2IwjyGFPEpvKryEJ1m4xvGcP8HaLoB6FV23DUDsHT8vC+SOA5eHdqRAbt20KAWFn6aJ5hFHRbIhiwIbT3ClpiHVmm+9yiXZ0ZAuyNqZ4MVxhZxaHeoUQvcUVnggQ5y/zWigjxX5GIzrrSrA4seBMYpaz4f1rVNTlELTtNGv3sD1X/Djp0krSW0gErdmSiDS6RcqxJ9LW9qY860cOGJvDrdgbnsBqfgSqIuX43Sjx/3NmpObQHhrc2ZAdGdaGxpw85/VmWir+RzH+55hsiI2BkLswGvj0fxhHQSTTpLgnc543FJVD5j0fuvt5bbJkWltIRow31IAiZjHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrRHfZFwGInew6tUBEvzZHHpSp2kLmR63FMbyiUIDUk=;
 b=YASo8PpdYYKogLiipeFXovy4miE+KBpDlqv0EmqMJ8o/hHI+jXjw7ImUrf57uo2F+nH4C3lKBF+0+ZgsIz58oAjRRGZTjJ96CzP5XuW+larJDYaqcRhIUDCnMTUlk/49u1PBuxgJFV89UcWOjhDdQvl/f/1QF4o1H2bfo8nJ9OBXVM5DJ2MNRIf8ClZqntsa5IcJWUWNxOD303v6y6WXFzql6J4H7PGmItHDhtdOSjWUaO4tZEwQeQzx5+LREZ8KvRWAOU6bvmOQkmTauwgb5ZHbueiLRgZAZFXNG7ZC1Ls+LX5P7/n9NLRN4Bwsq1hoAcDfpA4laz2iIFcdGXGDsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 12:14:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 12:14:52 +0000
Date: Tue, 14 Jul 2026 09:14:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	David Woodhouse <dwmw2@infradead.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iommu/arm-smmu-v3-iommufd: Reject unsupported
 bits in invalidation commands
Message-ID: <20260714121451.GJ674038@nvidia.com>
References: <cover.1783539724.git.nicolinc@nvidia.com>
 <194fec44b30b7b4233d218686cd76d63208932ff.1783539724.git.nicolinc@nvidia.com>
 <alYC3bNbXY9l0eVn@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alYC3bNbXY9l0eVn@google.com>
X-ClientProxiedBy: MN2PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:208:23d::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2a57f4-e853-4a5d-ef2a-08dee1a181ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|11063799006|4143699003|22082099003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	h8/V588kOHlpoB3U0bmtVOwWtp/XVFtXjn67emykgotTxx5VPiT5jUtUAuDumqaTOeOJA7QDDKzXcWu42dqTfXDD5Kn355NO9Wsgo8ptsGu97lbjIzPAEQ0fL02yZYykQeD2KKhXjjN5vm2i2ZQq0qCtdpTDoa9Jwnhh5gX4Ux2K3d3Hhu5zOnMglBR+Rhmke8Bvm4WBvmHz9VtJZszs28oe6lH9i3dFNKYZ0pyDA6X7JvBk1xU9IScQ2RP1zzPhnPaVsqWZb0JaM/cYEJHomcez30f150+AovztCRvHU4EGQ0mlqe3+q4Qf4vtg9nWJffvJLCiqsCCr+PLkp5+5FAanUO8ZAtAbho1pbgE8Pk0QGor6dUc6X1dZ2WNS6PdylZMaAPPP947VXj0PAJq5EOsv7GwA/JvJYzGXxnsde/N5i7K+r2bxFFanchn8NsnaaARwcvMTTMKxtzOo5l48ta63IWOTD1kFGNnSugJ+cPNBzD4WiiYL+yBH9YJvnE7HPxS3lN1xoGfVCQ46EPSCo2Dgz1kXnm8cdl/iAOxN7CmqLX4H12pEUfMdrSU7yhtlGvE9TxmABzHCTANbIyFJxc9O2H3G4iTEEU4P4ATmPFJ1ZAqgPGjORxJcfmOuvkQNTi0h84jfXELAOCSjuwPsnLjFwx6k+nE6BmAz0Gi8dqA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aAf6TJ3J4R4p6depYDYe7tv/p8djOkZdRAzgcSKNfawZNxjDsSfgV92Jd+NB?=
 =?us-ascii?Q?gvXLxXsKZYePohO8m8SHhrQNjMPJ/VChHglXy986QtyA5CelVI6qb8NZ/qu0?=
 =?us-ascii?Q?28kDKa3SB85noIFaBssqxkKAxGeknXK1r0D5ZwUm0VPrf8bmeIXYX8UXskaf?=
 =?us-ascii?Q?9tpYhIK3WOYehioL8BB+rWN36Z8WJKNVsfeSTqoFMSujlNmfB+Uf98My1qNP?=
 =?us-ascii?Q?GokgcNcug92NVmFB7coY+qBCmqd2PLCkCyKRhvxyWu2UpiN2vlvhNrZLAENg?=
 =?us-ascii?Q?T0JXriD9stvQ9tZrA5xkoo4Ziaio+5Ccmuxt6PvJSLXqq+FqMqsBUaXz7bmL?=
 =?us-ascii?Q?p/oc4YHhmMNDdRN5hbHkQG4Qr1jEic/B0o4OLLzXFeEm2GFWW/B+uHkOfPfo?=
 =?us-ascii?Q?dglAkuPGYuQpdFp1B8ZIO07a+B74rbJsrZfmQxpjtLaqTAm+/VBaVSsvLcCr?=
 =?us-ascii?Q?qnhhU/oPefpiGJtH3t049bi3o7EPxPvE0MF4FX/jWdw1FinSYsTGJFgYuNYo?=
 =?us-ascii?Q?EdW/5xw19q+Yy06HVPoIDh28u1hx4VEqYZEuqmlA/uJQMRYuckp6BY89c7Bj?=
 =?us-ascii?Q?lxphX/soTDH1tSKB7a7Nz3kdhPQTzPK/Zp4lz5zzrKgeD4Aqc48bVgQ00Qw1?=
 =?us-ascii?Q?1WSSpMLqHGFctjtD61G8/J4zq+oaSiFLOgHKDXHwL0OP9TKyMDOpJTa4DEsO?=
 =?us-ascii?Q?b6QZKTcy6Bg6PkGPpcykOO78xdLMiQ0ZjF25/iOdMjeulGsKYx2ebUfFIPsQ?=
 =?us-ascii?Q?Phd8ArkIjhJP4OGTN/xk3h5Wc2/znXUPnXmVCHhbYdovkKIOO6OClSNsbUA+?=
 =?us-ascii?Q?8WLW2fIdJiEGy+GmyehKlwBmawPO+3YbnT41hYGfZjhRfLFTmdS8oQpBe2eH?=
 =?us-ascii?Q?MCFG9sg76V4DQvLqbm8XoiGseUVd2Qyf/p0p2gnba/IP5aPS+MGiZs4zdYWf?=
 =?us-ascii?Q?7FJJqkdiPk0cZbLozlpFeqjUKlaXrMjnnYgvFbBARXOptV1vbaYNvakmXCfQ?=
 =?us-ascii?Q?teaGfQ4Z0GbnqBZY3NUXX5MZYBtlDj2OgXK4n2XZY4XYrXMv4HNtkTz9nHhE?=
 =?us-ascii?Q?H5NXJwdXVSX2VlIGhfTE6Vgphbo5qnYTqp8PpmbOca+R6w+iZx8nF7DzuOkH?=
 =?us-ascii?Q?aIQ7bjdNgVtylqMcMJsmwUG/o7/Bvb0svXNs4rnL+9E/6KexR/BIRV+SlVox?=
 =?us-ascii?Q?D6JuWMPXn5UrBHkm8KSgLgmHXLsyyWafCVktUumWAMpDcPR439orwxmvxGy8?=
 =?us-ascii?Q?jEH0SW7nvoK6Orcuid53tXaTLg7F3rUFfkRam4Im2ba545ZsovNWC/5Ww+rD?=
 =?us-ascii?Q?cvz+pcxyzDfMfAJAKS0oznZSKoAml0xGV2vZzkCDmnj70orPtLp8Ftc6k91d?=
 =?us-ascii?Q?rEZ6qniWDq7eJWPVDJOoTQtizGpAUDjkLAuy+4QAKUUk+Yur806/YVsJzaTc?=
 =?us-ascii?Q?YZrmnH9n+g+fw9k2lnMmrLxnUtRV3PYDgPfv2ouHI2kp859XlBh8YIlOv4LS?=
 =?us-ascii?Q?mlQilzDhZ5Ptl0cN8Pq8rPimV7TJQQgx8Ct7vK0JzK1whpbvUyCU2N/1SfeA?=
 =?us-ascii?Q?Nee+LngJ1a2J+66z+ccLbAbDsjfHwTHpblhQfuZKhbypFoxCv6hDGKGG1eqO?=
 =?us-ascii?Q?G6zC6dHCG9ih2+UbePJeCT+UtkrvurDnM+bdyZwge3FroQy0Pc7kmy3wPvvT?=
 =?us-ascii?Q?kJ5UlHp7oyOdnZeAw+84P9rJxxyB7HV1P9mT5/dTVmSfmoNl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2a57f4-e853-4a5d-ef2a-08dee1a181ee
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:14:52.0960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFkQXigpzk1xQguB7b1HoDLfLOO4mzdCXIrXlaEnSjZPc0HJ8F8uEvzt0YPxh+ri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083

On Tue, Jul 14, 2026 at 09:35:25AM +0000, Pranjal Shrivastava wrote:
> > +	u8 ttl = FIELD_GET(CMDQ_TLBI_1_TTL, cmd->cmd.data[1]);
> > +	u8 tg = FIELD_GET(CMDQ_TLBI_1_TG, cmd->cmd.data[1]);
> > +
> > +	/* NUM, SCALE and TTL are RES0 when TG == 0 */
> > +	if (!tg)
> > +		return (range || ttl) ? -EIO : 0;
> > +	/* TTL == 0b01 with a 16KB TG requires SMMU_IDR5.DS */
> > +	if (tg == 2 && ttl == 1 && !(smmu->features & ARM_SMMU_FEAT_DS))
> 
> I agree we must check this but I'm a little confused, How is a user /
> VMM depending on the IDR5.DS bit today? The IDR5 is exposed to the user
> via hw_info AND in the uAPI documentation block we explicitly mention 
> for struct iommu_hw_info_arm_smmuv3 the following valid fields for IDR5:
>
> idr[5]: VAX, GRAN64K, GRAN16K, GRAN4K

Probably soon we will add DS to that comment and it will be fully
backwards compatible so a new VMM following the new guidance can just
read DS.

Thus we can't have any kernel release that doesn't work with a VMM
following DS...

Jason
