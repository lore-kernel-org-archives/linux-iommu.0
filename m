Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD746373C1E
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873801; cv=fail; b=Jzrqqvm7LHE+Nlrvv3bk34Hxq8w1mj4LjY0xbyB8X+uUTn539IzHRd65lJzWrkULtcofXaRmTvEY7G1jPgccX3kbt+PmCmOd3c33GLPKSsFkmE2NXwKzZ/QCA8pFWd+vdhicVbBFTuKTX1VZxqRiJZX6iEGCogRr2mYbRREzvak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873801; c=relaxed/simple;
	bh=o/5vqdhctu52fF0ccl5wMc7NFRwILYGNZFT9dR4vU1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KROWCko5vUR4X9GVCh6pxbjXFgOT4Vbg4zVsgw0e3r4YC8at2aH1s/GG9wcxarueSMYq163M6xAEpu9F9vgqnIgC49hsQYq3gIp/Cl29hCwmmA2mh29f6C7DQC/c9uz0AiloWZeym5WBEORaaP2SGPZJFkFGbNRslamU3GbZAq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CGLunqkX; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CGLunqkX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5YwyPepSAmLtkdYvXY8KvRhhSo0apDnzd1wdbfhIfHqbi2Zm6HtrHJ0BINDmSRvGm7TtdN7p1NxmDW5SQ0uSuEUPOJohcGEY8G/SJZg9stfMa/63JAq3J2U8jJdqh+i9btMPHVYfmlRCRAf6bkhi8/NdcwDQt5mm5WzNijfUbF84S+wg/wnq7rKAjilxsi713f1sDA8MAL2tNjvW4z/AQcOIF/zAtFWnUs0JWpSoJbySkvZuZ0LR1wC5VVb93GmhKU75+3quPWKsEhschx6hEllbPaG9XBHZoyHkgusdpQby1vH5tAcu4mtUwuWgNIGclbtOgxD015ijKlrbIPZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsJ3Hil7gxBHhAEWlOZm7t/0fxVBWng/X0BR9nzJlwM=;
 b=Ks+f8Gj9xJNeG8mSJmFFKmCEneb5bZuy4J9aN47om1TwBLV+Dt4x++xCmWinO6Yj1qYTO0fRW+ylyznV0+OJCpozvmX04Mn67OCm1ThHnZD7/lyI3OKzm6nRQHmt9PsJj4bRO5fngnLHG4LIsyN1zW+cPQEDveiV2BWpG4G6GU0Af40CYJtv61MZ7+BUZ58tMjppcDHVeYRTbudO2BLLgglwBpB5+xactWTZsQzPdeUK3pUAfagS+6zBcglDHUXI8PyEGwTMMOmDggs0uk1uHxqn5L5fDPDpNAvnb4ubcksgnZD6a2//dFSBtmTx+JvNg4vmPlCEhzJqTifvBlc+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsJ3Hil7gxBHhAEWlOZm7t/0fxVBWng/X0BR9nzJlwM=;
 b=CGLunqkXsb3jSpk1jNoOSEYeux+WUiaOFLEPGn3w2U6t4w/aonzDQFCkwzg0lRoAxEdX26kt8zMd5QDwm0YydOvq6vwd+UmDlcZbujy335r86XI1+Cr2bQGndpbAz6rItP8xd5SisCh0HGZoqj4ls/PovSIAgI/JIFyfokSC8vEg4dqtPfLXSsKIyluTGgf5VdGrwumLFw9FsNx/M5fjFHl+75RBgQK9sc8weBm6R/fK8VutwC6VzP4Crczo8Zh5V0ASwHAbPEWpOkSgCAHXj45f6P1s25mCobFCH6rhGibffutOuY6Xvs5eAfmQzdIsdY+ByCNy+JIEE7pfJfEaFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 16:03:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 16:03:16 +0000
Date: Wed, 22 Apr 2026 13:03:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"skhawaja@google.com" <skhawaja@google.com>,
	"pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V4 01/10] iommufd: Support a HWPT without an iommu driver
 for noiommu
Message-ID: <20260422160315.GL3199414@nvidia.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
 <20260414211412.2729-2-jacob.pan@linux.microsoft.com>
 <BL1PR11MB52710F2441FB52E2D94D37868C232@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260417145946.00004418@linux.microsoft.com>
 <BN9PR11MB5276DB15491F949DA7D8F0A78C2D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DB15491F949DA7D8F0A78C2D2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd08981-fccc-452a-9766-08dea088aa47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	F+Vk5kpGoTUguk1DqKEaSJhweajaVbllySoRfHu7/rVDrchCujscgrARHX/NQptXVOaYGraOsogLR1af4UqTbBKYAJ/kSJG1lLrswmBQik2Y+gGrsavhcrgXPXhSlQ1D+Dir/K/JO5X0zj8fF6H1tueJuQb33DCx0XcWgsb4BJgcBGdzWdDZpW5CrZ6Rbl9USf43w0T/yrG649WwlH2W2HDYqc7u1De3e6b2l284KmQIQBRHLNkM5IqNPxaObqsFeDwQFr/s1et2CfpUXmyq7BjOcG2qwnwrNxN9unN4gl6kXg5aFbkZ9py5ZUDWp9jD+CjNVOUNKdX2anN964YKI2b2CVgGzNCTkSFzAoSFY+59M1Z+vZGuwm53kVoOR8Z7ubdSB+YsDK3ZapeYd3UBE8dmFDeRCSnFyhxDVBsrhR/Yr25Vn4tGDZZK7lgDQEwHT9C+f70kYpAqedlNdVW+gDQiAHuD+8OWJCeYcevUUR17Xk6cwOyZoEy0laSHtKqSFt+/ywv7fy6l43Ri5wWuetRh21RUpE/F8Fgdh06sb6e+Of+nbWbHjxHlZzdk8lwequhCtVb8CAzBGBd7wp+wVum12KvSEaGDZxBOKQtTvVkbKYUCucsN3/UMfHIoWLPRp0E6S/zIsxQTYk1KA6IcYte2B9Td+XG/P4GHFmSbC1fdhYM4sjW8MWWnMJD7TRGRwIanBMW9nyMerBnmJ7q+RLsW2xJNpByNkiomoKQ0lts=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CVRvh5Tc6JPZfvyB+Y/l1DokRQghF22Md9nGGxQNXeZBAFC/N2PbBzyeOk5N?=
 =?us-ascii?Q?I1dwr0tUQ7NnBVIJDGAk0GupPMxZJtvIP9TIGkjtiA0JYJ7Am4shIN956NKC?=
 =?us-ascii?Q?kIeDxsvfg8PMLjDXgcfXn2nFTdsoP9/1uAs8m4j89jpM3ChAxbdtA3zM6tqm?=
 =?us-ascii?Q?TT2Vldcn+/9F07s4HsdMS/wtvcHBv/lUIyXDxw/VUeA00hMcNKAiSt1j4cVd?=
 =?us-ascii?Q?MysczvzQbTlgA4Ass2fbO9/h68IRLe6GnGQQ+0i2ot678wdwqkI0Q9x0HKOi?=
 =?us-ascii?Q?xMOtoK17L+E8Sj7BUtwezAZULgmV3S5PlTFxZR8O0tkHcn4jdrx8bv0zGaDj?=
 =?us-ascii?Q?CEo76/w1JiqHju/JocNexsDKJjyHEfG6zitEhA3azkfwKoGN48DdmNXRbYbc?=
 =?us-ascii?Q?dESpFQhAvtL3rMvASdFJ9ELjMDpu0xqySwy5wCsqE+ml/O2t3hYRTcQjZJFS?=
 =?us-ascii?Q?PFJPFpDn+97oR5qcON+4OCTAQaAi33VOP4wcP0+Mtwgx5lDuX0DmuF53mpcS?=
 =?us-ascii?Q?O2b+w1evwI4C1xFh3aLyr3jbuJpjT5gdftdFRALs3Npr05VghP3Rq7azqN1h?=
 =?us-ascii?Q?lbpv2CYlyK6HLvce3pO4SfV8ULZlVMcS4F0koDC/Lci6Gon7NjaJ8EUaCtmV?=
 =?us-ascii?Q?qST+sGmf9YIOgKEvmKbsOViqFxXlyY0lRO1AnZUxels7bQOpaadmG17iHjEj?=
 =?us-ascii?Q?bQckEElSOva1COLjjnQ/W8VPEmaZPhY9AKdDJ8kQhf9Hsju7YWptCyN7tKve?=
 =?us-ascii?Q?WZbo0pR2tdezjsIvJJ/RABRpDRtOmsQIhwOXAWm4gRg9ggvm50afeVlOIwrb?=
 =?us-ascii?Q?65IbDjnW2zWXqOyBxPqvbupComNoKByF4PU3axUCMY4s1MGpDk5+wHXVkCBn?=
 =?us-ascii?Q?FRRqbPSmMl8dnt2bJiv4MunfSLUnpaihsRjH2VE7pbw36ZhXMAMV/SKJp8bs?=
 =?us-ascii?Q?2KiZmLLfBiPFpifVukjhJDobTvoSzg18ntwifTSWmXpQeToGzdePhT25b3n8?=
 =?us-ascii?Q?BsO+xCwjGuet/S/ciGS6GjyJQZEQFPw/AXlA8rvIKqP2sAYBV44e3Fde/yex?=
 =?us-ascii?Q?mUcNxmPpE7Fz53uFk+lBTZJ4ePbhfoHJYLBg7t6Fy+VRIqLj72wE1DVbJCKf?=
 =?us-ascii?Q?V8I17xBWUE2IGOOv3EwVFaBA96Y6n4YewHclpZQIryz2qjkxdPj3AwL+ngT6?=
 =?us-ascii?Q?G/zj1MOOBb3eO8nEw2cgY9exqFDisafK3xD36g6WR2E5AvYALMn2Ouh49aSP?=
 =?us-ascii?Q?vQY0owCfD6o/jY3Fo8+lvXg+qZge1mga/GOmUKdkn1Y04Wg2/k3vTkEwc8BD?=
 =?us-ascii?Q?LacqJyZTxJcWJfUOsFlWYnSKyifLTSDkesZ3CO3YwIxSll4Z4Jsdu7yWoBnM?=
 =?us-ascii?Q?5Ll4rwGGiJV7FYnNFx1zi+Awyx2qvLndUrglrO17xwXpfqwkVYM+mwIK3iCV?=
 =?us-ascii?Q?vnCQZOamuav58rPrdIDF0oi0pNbCwOKlcwBgHNcf1xtT4wefGOTetsbsFX55?=
 =?us-ascii?Q?smiVQiy/9oO2kwKUtU5RU64mjxX0K7gclcwoTEIBGWEPYG3WiJsmasSKmT5V?=
 =?us-ascii?Q?dywFakcVRs2dbXjlXHmhJGRkNqHWCJGAbzQlkm6cX5/aCQCEtv8S8gE5AWkc?=
 =?us-ascii?Q?edzrwgFZKoDbG4Y489hBcBgosnx6oBHGQE8vzB0HmOunnj5VBTbQB0r3sVBW?=
 =?us-ascii?Q?6c14b3v4Tgo5t/3ILsAJ55lhL1HtQGZbp6o8oSoCCRK0lyn+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd08981-fccc-452a-9766-08dea088aa47
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 16:03:16.7970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaOX3Iv+5pB5uL2tQaT8ts5uZTRzqFNl5hWobBS7HaEw/v1bvFwqhznTv9+BSS2j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834

On Wed, Apr 22, 2026 at 08:12:43AM +0000, Tian, Kevin wrote:
> > Technically yes but we need this flag to match forced features since we
> > are sharing with the real AMDv1. Otherwise, this will fail with
> > EOPNOTSUPP.
> > static int pt_init_common(struct pt_common *common)
> > {
> > ...
> > 	/* Requested features must match features compiled into this
> > format */
> > 	if ((common->features & ~(unsigned int)PT_SUPPORTED_FEATURES)
> > ||
> > 	    (!IS_ENABLED(CONFIG_DEBUG_GENERIC_PT) &&
> > 	     (common->features & PT_FORCE_ENABLED_FEATURES) !=
> > 		     PT_FORCE_ENABLED_FEATURES))
> > 		return -EOPNOTSUPP;
> > 
> > where in iommu_amdv1.c:
> > #define PT_FORCE_ENABLED_FEATURES
> > \ (BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
> > \
> > 	 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE))
> 
> Okay, make sense.
> 
> btw iommufd selftest just removed the amdv1 format (will be in 7.1). then
> let's not mention it in this series.

Why? The selftest was removed because it wasn't used by the userspace
selftest, the format is still there

I wanted to use amdv1 for this because it has the best multi-page size
options of all the formats.

Jason
