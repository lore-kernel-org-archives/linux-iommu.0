Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B03644A6
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063871; cv=fail; b=siQhvhmlfjiKQKHR0lV8LXEhePyHtAv68M2FLPPvnE4MWmMMYQxAkSFWVDpbweKPoBS9r2Bzbw2uDJ1oFXvHhhTjEEaTTsm4p0BeZ0vX4NI7dkYKZIyexq3BQd/nxz6e6NLM5q5WgERs84gqux1a3oEsP85BFs19Mwa0ZeClpEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063871; c=relaxed/simple;
	bh=i8BigMXi2TjXSwtq2NskQAeBB2NhH1lkjgsYSashgWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cnSDnf1oDxtj7UZPFMEON+DdnYj+o7kiHAaQ/CpUjOCdjwHCQvXvEIS2yuOiZQJ7VcJrtIXr1UBDR3CrXKBR8MssDyop8dwRjVSJ7XfdzS273nY5XO/9N4i37AorYIU4rxpkeMjmlZ/JXyb2hT/22wTDFHfZIHyzCejqeKCbxYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BTzC3Sv3; arc=fail smtp.client-ip=40.107.208.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BTzC3Sv3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhL/7Tbl4xQsX4I1TLEMGZcJ4GJvEsrjHYYXlGZbPW2TYxfQm+wI+ewLeUaFGiBAze6gyZB2skZW/kboOOAT+XfLqD63y+rnccEW2MRRBW//geslMYZ+1Oub4qA6ElcQYbVO7+4HmSEuywdpdO8QTeuBg3Wf6hi1WorYVxQLwttGmySZNYdcD0Xu4NPxoERvvOwbJdyU0tiQ9GWcCIP9QPmTsfPGMlp4q0JJkdSJr6sSyza3+ttsCyeVz+7i9v6DNEcTeZlm6nDm2ZniHzXeCLkpHfvNGZKRJ8dXmnmrfQ552a2z613HtlVNkYOaZ582x9yTSJzdz1CDIn02odh5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrFFVQJFoSFKzwZv0bd4I3UIGIPRzK+St9TtX/c2Vgs=;
 b=gM3mBKnH0s1lUv/NI2Jdk13SQp+mptJhOcWppX0Oa5dlN6smqxYAhoVpNeQfJYni8qXXy+S6ISnNtF/anj2/xmae5LZv9gvwJvoKC3CJtEYYh6D/Kn3pTizw1mWMOHjFl3eMJvl4Nex9r4zjoYwwNFrbfOQIxYzesrmH5ZLfPg4LX5V2W6mM3tLN0mMTPO2JZ4dIfiKq7tLGURMvy8MBOh5lK4L8fvevSjVISNp8zxzSusyToFPe6iW6Cr5tz53KkwY3MVuiAFLW/pD5PeMWmaqGefV+LLrrnYe5CZZvHy8lZqz/PdF0Z+APGWVgW8UfuRssFQjwI7+om5eKg3yh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrFFVQJFoSFKzwZv0bd4I3UIGIPRzK+St9TtX/c2Vgs=;
 b=BTzC3Sv3fYsd2OgNHEG0r5I9QLJqnB3cN5iGcoxKrrVk97wvAaBueWWQvJC2rcZvA98eNhQbHJPD2Jhd3nrcskf9UvdlSSou/vjzkgcbdZPQeFkss2k9Y9CbXhurIcbZTQC+vtOu5/NCw6heCZE38LzQYyXsRCk+BOP6bscdTkRxTvCKsEKTlVsNrwjHbBc3L9Ds/F4M37CDczhXDJTYHgaZVRv6qwmcjMSZZ47oi923xr7YvJe9IGpuUT7mxl9cJt1sEG+M7YyP6ctCjXraUo180osb03cdjPQA7IluPbTXbslXEnwfTXb2DxI7SoLyXWP5rHFmTz/YExzm9E3nGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 20:51:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Fri, 24 Apr 2026
 20:51:06 +0000
Date: Fri, 24 Apr 2026 17:51:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	joro@8bytes.org, praan@google.com, baolu.lu@linux.intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v2 2/5] iommu/arm-smmu-v3: Implement
 is_attach_deferred() for kdump
Message-ID: <20260424205105.GL3444440@nvidia.com>
References: <cover.1776286352.git.nicolinc@nvidia.com>
 <7637d66c0f6c1fb16da4b5c9c4cec71752cf4d23.1776286352.git.nicolinc@nvidia.com>
 <20260424165927.GD3444440@nvidia.com>
 <aeu5/HsLwfhNWpbm@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeu5/HsLwfhNWpbm@Asurada-Nvidia>
X-ClientProxiedBy: YT4PR01CA0179.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: edfeab65-7194-4f49-4014-08dea24334b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3iYqNcrod8GRvT5vSFLTKQcqgJen4Nt7kNgL8JVJcX5UuCn02Z8/+bsdsxz3sab28uDU1Xu7ZG+NntZD+VUJuhcodMs/vfQDc+xWMjS4V/6tXp+t2cjA9ccepQ1PJ40d9zflFcGmFzKtymCpL2+X2OwMz+HK3M66AEM0wYjosmmilvgCBR62PMotIQBm27S6NTRcTHVlDUiEQs8DOqYFq1lF6zvd8crp86BWg/s9egHVGod8tulmi8dJMFhi709Fu6hgEXpv5Qk/kKEV3hawFsDBPVYl2TAo6bLQiz1x1jHUuGNtQLojcxM9CiQKBqgou1qM1tvZNJENJAvV3JXxhItJULLerR0KhyKSXp4x/tMiJMEpDVQjX64vBJLrWHRIVrrFez72jPLkHVxGRzIPtEr6k319X8qi5CfPiXpu1HyZd8Vr9g6AgtUjwPP5Ku7mM9/2AzEl1JMxJZ1S8FaqN2CETo5qnqITx5Jt0CJSs2L9SQXDlnx6cZcigfd3T/kpC5g5s5/lMtIkxmCLFosaSkHPRhLA8iCbsTCgBXW1G3Bm5lo5wZATphIuB2py3Sdv5DcxSjF/yuN/PlaoHn4kSF7gxpgW06c40Lxsq1tJ1F9rhPqpS73RyS9LKmnbwJnpmGgVNyQ21FH8f8OnkDiRjEJ58/1pJivvb6OjAqjGvUy2Le6gMxbtPVtTG324nItmz3g9y0C2csJ4tKeWsr+mQvR334ir4ZVIDcWL5Tx8Rjg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E31UbvmM8/pyyIaA53FnxfO1iXlCZJKj7cF7WMm+9YTP1XThU7Vn12vSrvF1?=
 =?us-ascii?Q?1rCZ4XHtORIrQ1ImvKq+NU9f1xIu/+VAQTWmjK9m/48wmqOfdisRKnAXNigm?=
 =?us-ascii?Q?+3mIT1HeCyqxwEMd9AvK+Gn+rWdX7SzczVBotgurdiSkCDxfpD+k0QkDEWhc?=
 =?us-ascii?Q?R7ky924TAu7w2XQ69a6CMiQVndm/e2CXxe9c3Qayptn6QEJNq991SR+dvBif?=
 =?us-ascii?Q?a11Sluj73Z0yZSpYnv20WH1AETm7UtRc5qqXsmPpkmnphD8AgDeglOsZ39Ki?=
 =?us-ascii?Q?rXqJrM+bU5EYu6daLDzsa6lMGFdoBwReAXQ5a0lmay3OGkjaAGTUue3jasGr?=
 =?us-ascii?Q?f7K28WhxzS/9D2aztfIahbqFN11/QxSmk2jdx8Nf+MmiUgyqJIFRiRqyo2mc?=
 =?us-ascii?Q?5D+yGUK1vy9aB2glvAV//ssKLsr5uG4xkVCA/CZORe8t3ALP4pb9tbbxdXIS?=
 =?us-ascii?Q?CdjW8jDvZIxna/yf+Tf+3BlCXOptNljqRCTYU+mCWyyuOWw8eTrhGm0wcZz/?=
 =?us-ascii?Q?t59/betKYVPVpZ55tSHlx1T4st0gLybpSC8X6pgDLjcl1xDUUQWa7aSWUz0a?=
 =?us-ascii?Q?lUxLBZV2AdjRo1OWlZg5P0GmaLh+9IP6TsYrAPbpF5mKz3Zd6O7vqdlndLlX?=
 =?us-ascii?Q?8JRzlpP3Fj77rYnFYkIZqVoSz+fQ3BL3yE/84uUFG6JEePY1BEMTb88cmcPi?=
 =?us-ascii?Q?SVcvxBV820dl5hsz6P2fs/zhVpsP6Tt9ijvOJzY5NunveSjr/9oZOeNDiBuS?=
 =?us-ascii?Q?nccE6Jb6dsIW8GyHBjPcS+20Y390ajrk5/Y0lWOO7PIwubAM7+ZRZrR2gvFZ?=
 =?us-ascii?Q?GrrQpAmO+IdsfEKV83dU9lV6n8jsaXNPI1rUXX88rQe9AJOsvqhyuVyJzMMb?=
 =?us-ascii?Q?1bquPpDv0DV3r3rEJ/g+OmCCAKJow8hGsPCnrAgEh9wHwvehcjO4ZhUrKUrl?=
 =?us-ascii?Q?NDdZ5J+bori6Sgc3laeqsiNG7YY0pfP81jFhLjW+Vu5WJnTs/SybyTXrOplt?=
 =?us-ascii?Q?8OhjyUtqDkp0iDDMPx18kErciAW3k1x500wgwOKkJH3+0H3X77zx1ssT9LGX?=
 =?us-ascii?Q?0LiKK+hwVYcwmcUqK3jU/7yt7Ru1mjJgzlPjo2m1O9n1Vvvt2rtuEH7ws6kJ?=
 =?us-ascii?Q?E3yyphsQVqn3z91FnbH2VSg/lLuBm9laUbvQDUrZz/6cDvm7vh7bvB89x+LG?=
 =?us-ascii?Q?puShiZxwO6Reerio2y1vBob2wdk5E8ICbLFeJuQpvbn9LTvscwqDu5hUAWRH?=
 =?us-ascii?Q?+uUdVhGov1xyz+ha/SgbJjaNB95wqc0TL/Ew4c4mS7EZiQ8PD+qTU35BN7UX?=
 =?us-ascii?Q?CJJrx0P+C52950/scnwFHkem86lyugqrqfQO9DKnOvB6klapYxKbUgTJxzGD?=
 =?us-ascii?Q?V0xqTCeMwOCQ6Q5fkWDFeygTKBqDxCZsIxUeMAOhLVUeC4bF1TBN27Jp9sl+?=
 =?us-ascii?Q?Vvr7vdUIFqM04lp3lWboBWmypa/2c9ijbs9htluO1BXvjygClLaf8hsu8oga?=
 =?us-ascii?Q?G/yov3AITyEQ7F7ZVPB/lh8QXbTpcrO8ZQSiX0GUiJFlhVlVOaT9jy/DSefj?=
 =?us-ascii?Q?pbygGwDD8JMMhMBi1RJf9RheT9UqYN65p9r6CBpMixlowxECa9/YEVtBb8O7?=
 =?us-ascii?Q?2Dfb2/U6Hu3VAAqpRyB0P4gv+BgtcLiQFcVXyZU9r7mS+wOXy0tEFmr6kK/q?=
 =?us-ascii?Q?W8m4WJSrnw9pSPD8TG0BOeB5pyhj3fsrr3BuMNDvP7g1hzIc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfeab65-7194-4f49-4014-08dea24334b2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 20:51:06.4972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lh2AvjldxZi1DxeL0uBwwCA9qYSAveLDIhN9VvnLinPgBhCT74upNz7aGCmTS4ly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131

On Fri, Apr 24, 2026 at 11:44:12AM -0700, Nicolin Chen wrote:
> On Fri, Apr 24, 2026 at 01:59:27PM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 15, 2026 at 02:17:37PM -0700, Nicolin Chen wrote:
> > > +static bool arm_smmu_is_attach_deferred(struct device *dev)
> > > +{
> > > +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > > +	struct arm_smmu_device *smmu = master->smmu;
> > > +	int i;
> > > +
> > > +	if (!(smmu->options & ARM_SMMU_OPT_KDUMP))
> > > +		return false;
> > > +
> > > +	for (i = 0; i < master->num_streams; i++) {
> > > +		u32 sid = master->streams[i].id;
> > > +		struct arm_smmu_ste *step;
> > > +
> > > +		/* Guard against unpopulated L2 entries in the adopted table */
> > > +		if ((smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) &&
> > > +		    !smmu->strtab_cfg.l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)])
> > > +			continue;
> > 
> > This can probably just call arm_smmu_init_sid_strtab()
> > 
> > I think it is OK to allocate another level 2 here and it also has
> > protections for SID out of range..
> 
> Actually, sashiko pointed out that this guard is a dead code.
> 
> arm_smmu_init_sid_strtab() is called in arm_smmu_insert_master().

Even better

Jason
