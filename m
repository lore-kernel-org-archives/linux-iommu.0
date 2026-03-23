Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2643803F8
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303840; cv=fail; b=np+2OwT10rZP8JNohGn5lW3gqC0PS8RnbZYfnSqHbUp21KcUNfmJTlepHdYyHbAdNcecMF6JKSa4j0PVkI4bAE72BHAtHzu1zzXJaIwYUxYqhmFRZKQDtZiUE15GM+0AYroDbDlZGfZG4TzZlzsdDiMRXlWyoY79Bl+2QYH1NQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303840; c=relaxed/simple;
	bh=lTaWOkO0m0IwAOt+e2qcfQlRk3BK7Uyjk0Ag7Svl1Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FJvKZL1ICGqCjlXmnnmkUziKg/2yVJG/bml1Dz1VbuiKD/oXA5W/1eVT4oIMVYpg7vye9U8LNmzM4JKzvfMcv+rQsGwOQOr10LtZzggt2anC2vd1HdI8Vkm3iMDSLNZ1n/sa9LK/Xm9Dk3c5lBtDcvakacuvlfijRwVCuFr6P+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bcsMrwyg; arc=fail smtp.client-ip=40.107.209.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bcsMrwyg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxS2TY3qdwRCIJJ83ZvT1JNNWrCSs6D9VzfwxKtPg1NLdiYEV18CmygI09jBmY21vStiJhHEo/N6I26Kq6/fAR9CPC2pdNoTcnhIE13XBPET5RoqbvSWhuzvOxw0ma6QAFVdvT6WxeaEQnBtmrLPhWCUNWwB2N+uSZNakqUq0VkFWGk7VzaAKWx7SOCNa7MreaLUacP46IpwYoDj4CaZH05YGD+A5KV4t+IkkkK0gAagl1T5L5QcsWoCUKoguBfGv3MUcgcIunJ3EyWVVmQE0mAtNlHrcXo21URITbNKJpcr7NxK0kICfKqGP/4sBlOuTkEjESmc6bMTN6leRZT63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gr1AI5pW0CO8STa67HCB4lOtvgON0JcJ0bdkG8RYDFw=;
 b=tV+7h3+aPsulzTwlle8WdDhFzAtQxSfcq7BS43ZU8sO3ui0qk1kMIN9ht8b3lmI9bNetj+Ei+m8tqUyx8yo8n9VSi/vxyvNibe6VO0sLytFXYLa8WQIqRiSppw8fARIlOMV3Mer2sUUUJ0cxo29kI1WCffe/ucPnF4g/Ks9gNXKsWj6o1XMZ+xPdVFHVyguJSioUHarGDNMXOqLunLHPerw1nj6tdKfgj1/cCBSyL54hyTl9hKmmB9EsVS/GvmUXHcJKtzmOjfV1K9087TjMWG42Hjm4mKQTj9NMUA9Kx9iIq/sgM97xopxA5wipwB6NOuiJNhhXpbmh+SV8t0EgtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr1AI5pW0CO8STa67HCB4lOtvgON0JcJ0bdkG8RYDFw=;
 b=bcsMrwygp88WQVhrsl/bOvw35UJxtlc/qWOB/UojCGAQdOpM5Dzz1MuPBoju/QKLrilzhr/F0ug5lXxNfwNcuNBBJPzAb2v9SdhhBRz1HVqTNxnnL6wzbJOxLvXl6Wxp0d/zztVzhifNO556rAm0nFvFekR/hj3wsV47MTFmvwVvwsr1uagOjSIOlBPiqS3XTFDVG6crczuvvv2AGM1JQJu6uKcy1NAuErlSKHJkdg15CqODYjMFjb8q/mQY1UnXhhy5p4+LhG0DmZ93DzzhJALxBFxN+vwoRbEs2ShyOuxBdb5AaAra76VeAJ7K9CS4IpDDRuueuarb/QHuHSkDnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 22:10:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 22:10:36 +0000
Date: Mon, 23 Mar 2026 19:10:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	skhawaja@google.com, pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 01/11] iommufd: Support a HWPT without an iommu driver
 for noiommu
Message-ID: <20260323221034.GS7340@nvidia.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
 <20260312155637.376854-2-jacob.pan@linux.microsoft.com>
 <ab-1VZshPREYYuI8@google.com>
 <20260323141132.00003dc7@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323141132.00003dc7@linux.microsoft.com>
X-ClientProxiedBy: BL1P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: 6726ee96-e441-421f-1672-08de89290221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DqOwUk3dinXg04L53DmCtXhro/kSzFh/ADeF1qxlPw8u4IV9IHxHKqa4bfUfO24iY7AY0bHSgztkL271BgzKljnSWkrV92n7gTEPyHmR8jKBw302obiYVc32onHM/6UZTt2lDSgdhD9GIgQCBf+hYnss1Ak2lPb7kilQGlJB4sP44maW1gAS5Dt3gb2Y4pAbF1HLTmpODtkLUnLS+g3gPUUnkoU1NlOm/B+svrefFlxBUlWWuEz3r1X9xTphPgHBdb4elCTQdGMEs8zjP1xYbqsbKteLc/D+lb4G8wldO96Kt/wR8rk2S+Cto5g2zYZGMejDP2E2yr3dEUfQjlDPKFicvuLN6k/tn6oBnQuK0xkcwcBHb//s2R2m2KRYLbYhNSc0h7T3BuSOEvGRXC7Qp+RvJdBGeowT1PkrvYSig5Psxqzj5uGQ113u4HuLZ6UTmUIYdcbyg9fCDVVkp+egnwMyhnID8T27W/lcpfGqlleatBn8JUQHWWuF4viGhkKzESEhifsVlBz2y059EoPqF9pfwrNcUkExVHb522xrJg43v130EMcMiUmLffxErVpAWgwlZZ4V09hOyrs8+YBOHvFYxrckR7VPD4JYknQZnEiwRIf/cASFHvBqNQxjbpIeRetMonPjMzxRbKsc9o/S5tENsbxLI7rf0No1bfGWYyC4D5Kph2qHioQHvFUNbVaL/ag2B2Z/4Jh/r3MjjxL+aICp5m89BHi29NP7DJ8/AgQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j/iFwcwc7T4RlFTeGtTeX7jkhGsFdfVa/SQTBUuE/oiRlErh4cdZrIkLO/i1?=
 =?us-ascii?Q?VcO/18PJIiDU5h+PmVSr0f1Ta91yQH9LNoHtM+e4rAcB9r8mbLWNQmHNYWfK?=
 =?us-ascii?Q?iD3cLmwic9wsovqk6ZrkuP8HXEN3PFkVAFBfnKY4a4wVC2V+sqr/bXkRxusp?=
 =?us-ascii?Q?AVVEKFXG54X3YiEWd2xHdWy8sw+BitiyJ1m6XjXZR9dOMuYjVRlWu5PZimd9?=
 =?us-ascii?Q?2EJZsV40m1zGatCJW6TP35a4nJ2PompPQIW8Iyv+q0EHbO5V5gSWx4y0CMiS?=
 =?us-ascii?Q?TK/NkvRwau+hqn8nSbD8IaB8L96FxgjffDDlI1a4ZCkqP6tZRiiuIjdANdT2?=
 =?us-ascii?Q?5WC86jzZ3DySsBUsZI08H/sQbFG1+q8jnJtaZaN4cusQ+WGaE8+BawQ/y323?=
 =?us-ascii?Q?mXHg7wPe7hSw0vswJ1V9T8ltA4WyFJJ0jCbbexfqApdrt/q9obhRKLtQhj9o?=
 =?us-ascii?Q?eZc/8+Ae08Qz8IDU2W80exHH6+SQzggjkxA9JtklE6wY6Y/ibf91sJ+zgreE?=
 =?us-ascii?Q?tPv3MxJ6HNuKYTsWxjuKTj1lVQqEyBP6mt4Gqda/FDRIrROVWnmGFPbCOBeS?=
 =?us-ascii?Q?PoiM8Pd/l1gZ7ERmbGcDR149ZsYk5DpHDSqX/zSKV94bQs2Afm9/60hy4e2L?=
 =?us-ascii?Q?bbnLZNYUf4D2FuDRVJ5ReA4iUpxN2APGe/hfF+lM2NbnP3ZcbHDqbW8lHrxp?=
 =?us-ascii?Q?QDB42Heg+uAz1z9LXn5DEVr8Gvwoy0+ON/+cQkoywKJq5KsA3AyAuRWEnTAc?=
 =?us-ascii?Q?EUUeuFbr/9j6ipZH4weRD7/cmNuUtLk40j3hYgVr64L/hJaTHGli7yGi1ZQq?=
 =?us-ascii?Q?Iiat/LsiGUFTsD7NYy1cS5a602iW/n8rGSL3d7bv4gdEsOukUPQ8mHKEDKIe?=
 =?us-ascii?Q?cc5pAyZMFswiUcR+Gsd0b1tCsv0gtuAuCc3S4RCiz7wGVN+6XhHKsIvU39Em?=
 =?us-ascii?Q?llsL8KRWodSVDRpEQyiGFJnS1no3jvKpg0SolUE4p91KSELg71hicS3RiFSh?=
 =?us-ascii?Q?b3+U/Z/3NlxTyOXatsF57tiPVBIt7oZy9atSk9JC/1vd2gAS02ep7LZYh3g9?=
 =?us-ascii?Q?1ZtKSaCaebGrExkSbUTfDHIHwe3RJ27AC3dH7krVfszqTaQ9KB5c2I6l5A1o?=
 =?us-ascii?Q?G+LtKysWA8Hih38Rdx5H0/H/5tGZsopLarQ8MharWP1GY0QuCy6khiz0bT0S?=
 =?us-ascii?Q?w0jILl0Nh1grCXFpqcx4Ya/BOajNfl7JMLuwcXaX+1VCaYTL3EwZDHXTaoWW?=
 =?us-ascii?Q?kG+iYqqqoYA91vq3R423ISqoeEIt2Df+hhX3fH98eBd9YEAFSFCY22BJXqM4?=
 =?us-ascii?Q?S9IvbwEu2gEsSzJqaRO1U42GGKQQQIQ/lN+PK7/uJWuEpYiluf1xNlQiKQIA?=
 =?us-ascii?Q?0eAfWzXAc64T485VOlRb0Mw1QYPcYtDUPbrMxQFkVZjpVJhqCBBzOLopTTcz?=
 =?us-ascii?Q?QDo3gzUsVZ16pJW0jvL9B3YR84+KsB3zVxk/A2PDRJ8rmxYpwOPRpNlqmmTJ?=
 =?us-ascii?Q?zXLc5cAGeGStTT2+ccvaDhw/FGJsttFRppax2Khx2oNuD9hCxNyVW95EAeUv?=
 =?us-ascii?Q?AIl6H74xWZhqT1Uy/fBExBCC0+GQNgobdMD+QpYd4TroTYd49BmR4WB/7jcn?=
 =?us-ascii?Q?GYSYUZUfx9rSQWvnnbjLfOywl8do/B50OCxTWyOJ2vnWbg+p66koFGyZv4nc?=
 =?us-ascii?Q?7JW5hh/tNIw9mMhfYcre7dqnxmgb3KGiHNQqI0GAEGdlxyOs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6726ee96-e441-421f-1672-08de89290221
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 22:10:36.0265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7KRsur9x+R9MXTMOL7VowyvRIBblDvVUCMaVMMfobTYabewz3nfsVmV7LGRaWHT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6435

On Mon, Mar 23, 2026 at 02:11:32PM -0700, Jacob Pan wrote:

> +/*
> + * AMDV1 is used as a dummy page table for no-IOMMU mode, similar to the
> + * iommufd selftest mock page table.
> + * Unlike legacy VFIO no-IOMMU mode, where no container level APIs are
> + * supported, this allows IOAS and hwpt objects to exist without hardware
> + * IOMMU support. IOVAs are used only for IOVA-to-PA lookups not for
> + * hardware translation in DMA.
> + *
> + * This is only used with iommufd and cdev-based interfaces and does not
> + * apply to legacy VFIO group-container based noiommu mode.
> + */
>  static const struct iommu_domain_ops noiommu_amdv1_ops = {

That seems clear

Jason
