Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334DE29414
	for <iommu@lists.linux.dev>; Tue, 21 May 2024 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314769; cv=fail; b=Tl4gK5zdUGjHDRacvJzpmUMjfW3mERF35K2Icn7wjsNKN8MLcuWfymKPuUm5yrQMrz/3xSgZfmh6J5E9Z5rwoMINFLwwHqbQPOXMHVp6ncRaUBYt52pIbIjlPg0M9llFu3o+SpoK41CBSbQUZqPwDbgT3Sfr25zr5sKFHqoLxkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314769; c=relaxed/simple;
	bh=lgLkjMHmvlmrYUtHvNjMIz/sTL/fRRrNmoKnjrtelFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DcYsoEec+HbWfJ1dwLUZsy16v+YiuuphozC2NGKtj+eYm+bVcIT6pAp3lMKTZ3b8jPHJgVLTFgEWOABSexJuNJ280RjA78sHGCGQpWC5oYtyqfgNbh8QpMLPIEYpMvfP588hO54B9ZmpX1+LLvXguUFUgR6dI2mJXw89wRaZAGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XY4LxHbS; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XY4LxHbS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhcpOadtTEYB68NGjUVp//LDU1mV3BV0fFBLRIVEgtNrWBW2NmKMy518M78bISgUX45Q2PtOx6rsLVKVOmQpyVZ4FNlGhz1EAiKeHN4Ixp60gI17lvYULc8hahmHXIbP4VbE8P8XfkPkZXkJ3do99Tv1Me/oKOEqm6lj5J46Djm069LUyadQvangswwJ8VamR0xae7fP9ZTlKtVIGPv73JLB+YRntMWtbd7FjvsvYK0/947TrFcv8pgh1o3mq/2UIP+yna6m/isV95YbwO76Z5l5dvwbTrCm3GYj1VD63WEBfnEP34ncxztGey2OOk3lyKkQgmJWyGvn3xb1sti1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QOd09pozZbiNHC3TBMpqrbSLHpKuyyBijKeCefCoCI=;
 b=FdAdQdzbNzWYbcCVc3TIrEVW1uAxd74xj49H10UlU1W9+2vKV6gIrrl9hs3HvzKwWTXSWaEEsAmWg3b9U9dCGhmEwnRwSRa9MYYS4QJQXthJ6K4+A+oBLAXSIqWgwa+FKGokmryMZjJhPzeirMVE+WmwLWFlxOIALCi3I7lbVZXme7cBIErM8Hxp/CRm1M9gQCI0Vt6ci4QkzTm/qvpfdimWY7/G2ilcLFURGlTYYo0MJLNTm+xK1ShKkbOAafyt1T9R8klbaGFHVsh5UE8IbHPxo4GNhQTRSulI0UD/Lhdsxwm0sxBPB9SskMv4x2G/JzAkuvl4uX2kuhs/2RxYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QOd09pozZbiNHC3TBMpqrbSLHpKuyyBijKeCefCoCI=;
 b=XY4LxHbSoZCYMhe3aam1P88Eg4MjdYO2C6HNNAJ1GgqZiOiztXFJNlwHx9APPKGJeLlDSmGzCrLZ5AxfSh9RooyNE5suYjTUy9f+F5QaIf8sN82jd6jeC0EdiTX4CtPGYqjiSie4UgUy8NrmleFqa7QC6KBy9VMjhtWkAECBsT6bN6LrF+YXtb5jx4bqmA0tXEnEVYMMxlc80O36efzgNoqCGR9EE2YOU6iGXBdg8W7/i+kKTrq0kaWuFGvDPHrJe2E7SKe8Qy9//P/6Ulb73p4HdYamHI9o7rBP6rah3tw1Fs9CDsIeio5KS1/82Od+jnOvYtqzSzZs8Q3YwIE2uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3843.namprd12.prod.outlook.com (2603:10b6:a03:1a4::17)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 18:05:59 +0000
Received: from BY5PR12MB3843.namprd12.prod.outlook.com
 ([fe80::efc8:672:884:fafe]) by BY5PR12MB3843.namprd12.prod.outlook.com
 ([fe80::efc8:672:884:fafe%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 18:05:58 +0000
Date: Tue, 21 May 2024 15:05:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 05/14] iommufd: Add IOMMUFD_OBJ_VIOMMU and
 IOMMUFD_CMD_VIOMMU_ALLOC
Message-ID: <20240521180555.GM20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <3aa9bc1df6a2ee58a03c6ea6ededbc210a2d23a8.1712978212.git.nicolinc@nvidia.com>
 <ZkDR4Rp57cy9qSqP@nvidia.com>
 <ZkGYN36N7sh2vUmv@nvidia.com>
 <ZkOFkfHhG2h2fv/c@nvidia.com>
 <ZkQNxkYv23z7i6e0@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkQNxkYv23z7i6e0@nvidia.com>
X-ClientProxiedBy: MN2PR19CA0043.namprd19.prod.outlook.com
 (2603:10b6:208:19b::20) To BY5PR12MB3843.namprd12.prod.outlook.com
 (2603:10b6:a03:1a4::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3843:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ebb558-685b-4f1b-dd5e-08dc79c0aa98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PV7uwjO2I7n0y2Dtt5GwKSVJYhR8GQXeVJXlt7tBQHVbM2e8+4T2/rIiCPxt?=
 =?us-ascii?Q?Hr7BcPZiZPo84bviTLL70vqBDKdUyQO4yfaHdH9nB0JCQPyHMqeGnWZSbuN4?=
 =?us-ascii?Q?O7sW/qvD7RQsMsXVXP0uh1VTLaIO7NSYScBr0iCo3V3a5P9MucJWf2z+P0KT?=
 =?us-ascii?Q?bfbnb1GcgIaKoNGjejTgNIIqIqS3zLWBpfiHaS3MzEneLtDsce8AQ2x6w9/s?=
 =?us-ascii?Q?p6TyNzJhpzlDteoO5AOXVOP+QQujAPR1laN4YMm0tgH740NB0QYwpLmFFEiy?=
 =?us-ascii?Q?vmRQYEFiTKM7w62KXiqQLdaJhIuubMZ3Zrp7Ox85OVKOMdplKXuE+GEXCVC1?=
 =?us-ascii?Q?9tuvtkLDMnu1NcXyHN6M1xWBH7Pf6+RL10bP0AM5dInV5oY8U2I81DbCZUV6?=
 =?us-ascii?Q?iSUzEA4GMHi0ePbX2yx5hdPx5ONewMaBr86le1/gxP6Th2ql8c14UlGxC4Ai?=
 =?us-ascii?Q?RRbeFaO72yP/8PI3rAaqLjdXYWM7AE5mfn/Jvlq1jvLL1upLhKJXjX5CVPvC?=
 =?us-ascii?Q?Fhpo3xwW7ZTt8s50Et+VZ9sC25VGUd0TmwcUrzCH2v6G+3Vnev14KOyLkYJ1?=
 =?us-ascii?Q?AQM51ZzYPl3aYys48412pJ6do4FQetsgVKk8YQuj5d9TJN2Ca8UBFNPbuehV?=
 =?us-ascii?Q?8dC1x2tCuKimFcc//MHIpp55JpnV+LwlLKXgZOKcfnRBKxt4rP+NValKq4/T?=
 =?us-ascii?Q?qQdpfwdvYTnCryz2ucgCpsHP/zZQWPDqm2uKmWMDro/W8qpcrqsCLoqPzqMK?=
 =?us-ascii?Q?zhdRk8bc43X5eio9w7tKHi2eSNaJe0Lh68GkaTUFOqQM1t9Qh4vlPkgDADu9?=
 =?us-ascii?Q?JU+fhrcMOM1K+xOuFqm9EGBCMjMzXuSjniEhfx6YOXDT0fT7MfvtWmDGyWw0?=
 =?us-ascii?Q?gjo8UwLzdRABtOAWm1EM5cA/3GcZ/X/13aUP37m1lkLGRLyO+6s6XNmAice+?=
 =?us-ascii?Q?rsP3MKdbwLJZGpVd7ELc77P4nSYS2d7/Z2ccCHhHJ39hDQ2e/kjjVJgKG67j?=
 =?us-ascii?Q?um3OrWVbF1W6qIKK7DCNFcKHpJKCZhUC2fM5JctWszw0/wKV5m5JZ5i8+rHk?=
 =?us-ascii?Q?J9JTMg4Mz7vW3fpekS2z+FBOqT3Xq2LWUkfVF+ZKy46XUULqrfziqsbtq0kv?=
 =?us-ascii?Q?mX8BGG0tTgGR7saaZAqdSGZ4sdV+cllvrvbQCUd09qEN0kP4uDx+odpd2Jsi?=
 =?us-ascii?Q?cl6gunQzdmMMZtXDGOWS91+9SNVqo7ZHJk8Jjn/0B0Y3B4VvUHdMjiZ2o+3W?=
 =?us-ascii?Q?ScpOf1JjM6NpfK75Bjs8dN6dULP76pECk2p4rrOjzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?acBHvC3IHsc99Bxde/IglpNJ4i7e7RBFQYfKOySthy6lRQ6fTvoWDx29R5vC?=
 =?us-ascii?Q?W948Q3Hs+srCu15iUwZxcsixC0PABSxoSRfT8r8Z8C/ae8Cnhlkn5ErXaMcI?=
 =?us-ascii?Q?XWdRrTzLN2sWxaWoCjeFPyvtAgPE3OZpfLWWLZ6P1Y/31Wes8sh34sZbAR10?=
 =?us-ascii?Q?37fdaRJzlymzQf38FIL1n3dWjaratBUSURv6w0Z6uls/qrHDT+/WnhoAjURn?=
 =?us-ascii?Q?/AYSG2ME3f7HtI4laeRNXs4zBmBOcAEkgkimYNaiJpkXnTEFwAG8WrWH+oxh?=
 =?us-ascii?Q?TYNjk9udSFVil4Nj2Q2U2w5b+0Go94KJ9gztW0Iw4woAmyWq+/CjTqpEdWxL?=
 =?us-ascii?Q?HPQe/29oJiAB2Z9viQYmg+tZixIa68F+3aX+T2Yj9BS7Zm7CsaAEAfK4Phkw?=
 =?us-ascii?Q?LRCtV8DXsSP6POOy4hDWVhMtpHGlsbgML6XxlCeBRV5v3fv28n96qZaOXmXI?=
 =?us-ascii?Q?40f/ctrUzKexVkWuZsbYiKI3ceZqEDQa5KQ2X7hRxKBCdExwlcJNKMW8/KyW?=
 =?us-ascii?Q?5/RJImjYj00Yz+nbT7vDVHAX21tiIBiMjZjKOIOS1hS7U0bLgNAajqCgO3kA?=
 =?us-ascii?Q?pVEGy0dVZ78TFJFdAEnoxTKNUPTYgZ7F1JSMXx79g9fqoWoIm/3rqw1NVXZs?=
 =?us-ascii?Q?OxnOaLGTTMjD6Ez/hX64F06dUrN+hXEStmZx4DzP+DL5DHow3TMMYRh5dY0+?=
 =?us-ascii?Q?W7WOtrcvP1xJ9kg52zcCD4Aaq4ycVnEnSEXIWDp+jH7NlrP83axM1TiKyCA0?=
 =?us-ascii?Q?MdOn4Lz27iFP3phKF/MtZL5yWzDVZoz+PA/JeUJ/G0FO1u8Sz8fPGjjV3WSG?=
 =?us-ascii?Q?/LW2qGUYMeGAkt7vODF9nnpctGY0p70QgnR2GW3y0eBrGFbi0abcgEOTS8si?=
 =?us-ascii?Q?Gf0CghXqipNsYIGyzqyRohSEEmj3hTMq4BwPG5F6/x7uH0nsG066gJmCrfNn?=
 =?us-ascii?Q?tDwJ9ZZuTvqp5ygGM2636dYoAz+oGpG9fZXSC2r2WugJ37LrWaZgCE0v38EU?=
 =?us-ascii?Q?YTH/Y3f9piif6p2DCBdCWsvQrYGzjwdugDXGKv9X/srcOrvoUJ4TUPIm5btN?=
 =?us-ascii?Q?/4yXeCHgr8S/10oxorEpvpr3wUT6fsjVeUHPdMBmSo78N/iMCS7qreoCccgj?=
 =?us-ascii?Q?nkJIUBU/AtNFhzrUXyIp3lCcggkQIpn00iNpVOOrRj9fMbx8TwzcIE4Ox/To?=
 =?us-ascii?Q?PE3FbR5YNpurXrYeSFIKg7zq3DMXSKXWgJKDejf0vLWqeEhvPLI0h8f3lOBI?=
 =?us-ascii?Q?E3X8rysF7p4YGP1ly7LMoG/Bmb44jEG3tGKPt+S73j5+0BcvSZ3+ChgEDbn2?=
 =?us-ascii?Q?s/0RHkn/TbmwApzLDzGVS0SVoVyer9Q5fVbVHP+3Wbu2rC81IgCPDwFC2QFN?=
 =?us-ascii?Q?nwAU/XH3CYzHRx1WPzMHLM1BkqgdbNw67Iu/V2zjE5ghsb7BX8+Ax0uiQVrD?=
 =?us-ascii?Q?FKAgMPnpJT7NAEbAvNK7iVo2zY2S0kP/9rAIocdd36Md9oS6q6gJEbzKHQ0K?=
 =?us-ascii?Q?01XwHvRuE9GTDFkA3LjXVAicj6JEcZoLjR8Um33RFTimvWlCoXL1T+wmlJWJ?=
 =?us-ascii?Q?ARgvEylRBEVbsJgvODg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ebb558-685b-4f1b-dd5e-08dc79c0aa98
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 18:05:58.4008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QH/9foUSZSIU7r3ROldXT/Et2C9/+lOyH9Ti4J+mqWySSXVJpnyPIa2t1QInn+tQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184

On Tue, May 14, 2024 at 06:20:06PM -0700, Nicolin Chen wrote:
> > I suspect 0 should be reserved as a non-set value for some
> > basic sanity in all these driver type enums.
> 
> We have an IOMMU_HWPT_DATA_NONE for HWPT_ALLOC to compatible
> with an S2 hwpt, since it doesn't need a data.
> 
> Maybe we can have an IOMMU_VIOMMU_TYPE_DEFAULT to be 0, for
> an IOMMU driver (e.g. VT-d) that doesn't need to handle nor
> be aware of any viommu object?

Seems like a good practice, and perhaps userspace will find value in a
generic viommu object that is always present.

> That makes a lot sense. I'd need to go through QEMU code and
> see how we will accommodate these two more naturally: likely
> the QEMU core should allocate an S2 HWPT for a VM, while the
> viommu code should allocate a VIOMMU for each instance.

I'd suggest that core qemu should allocate the S2 IOAS and pass that
to the qemu viommu driver

The qemu viommu driver should create the hwpt and then the viommu and
perhaps return the viommu or hwpt back to the core code.

If the vSTE flow above is used for identity then the qemu viommu
driver would also have to go an create vSTEs for identity and attach
them to all devices before the VM starts up. Then when the OS
activates the SMMU it would have to mirror the real vSTE from guest
memory to the kernel.

Not sure there is value in having the core qemu code directly access
the hwpt/viommu?

Jason
