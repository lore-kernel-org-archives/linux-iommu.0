Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E669739BFEA
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774272023; cv=fail; b=pu0inCYt2BXgt3I4Sdmhed/Ajadxg7ERr5OK8tzoTfJnCiEQhhN183IFTDbu0poaIoF0fItE9SvDYWR6D7y732ubWc+KltfYXggHDw2q5B/wclho4DY+K6tYpjV+birr8jKdUkcRr7rIWdsSoqy81n4kNKeBjnpDA/djPDQv67w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774272023; c=relaxed/simple;
	bh=Vs9xJ4QJuG9EmrIhOLgJT8B0wO9bVv24xZu1iXWdZzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T3aurO5g16yyPEtESAGwkdk28JsroHVn8MWUStrmAnvcuoJLddA5bXzX0emn3oLKfl8mmUOfORIsMqq/PmMjGVbkNL23SzfP7kHquNHvJr1JUJmfEQG85wUZ+MPe0Qaac0l7MlOL3kTmb0uhsON62M/sdgIG+OHWbEuUaITiEOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cfLqy75p; arc=fail smtp.client-ip=40.93.195.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cfLqy75p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0GTZX0AZzxT1dl5KSLnZDyNVrOP7kihC2GbqsZbcso2JmLUHUtW4aj6rG0/7jreZAVysmB3ZwjNsRYv6V2MMMAXREHH3prBqNBEVn0tx14f5sVtu5QAlu3sgd3qXJ6BKXSDIHSF5PfkTspUhwqhBf2uWu+jXDdkZFpbNCypge2QuTJUZYt83fIazX6T2VOvKgc/DR4Z2suNNkaAwiivvugTc1bD7KOcZ14DPX1GcZ1y1pR2jO2XCZuCq+Banh+NQB+StQy+IYegTXFH/ftpPl1fnOkQdQDmSKBVEyUHUDBQd1dOYLKRYIjzUhO0fWekYSfaLOZhGSDW/NRpZUA0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNMD1cf9ikW7z8XIDF3AHJN6litjDqfqi19PD/vLZlg=;
 b=QDlbeO5l4fFLURW/e5isolZfXlVURf5rRwh3U8mvGZFFlMsSHVquEU+zA6MdbzPrqxtO6qZxeEOsvbVkspUg3n+EnsWHrkQX6c7immznrMXMnML9GvxYkk/QTJc0zLjfdfq+9IZaPdSWX7kVWdWLoTcHgB4O9pq5ysk8bdTEAr2QzIPtFqilyf98kYRUnTFcggDRMxCTjjqFEg7UmmfDYBxhHXmwJDrYhta8R7X7LPa9h3zqJyC8/wbYEOpAr5ahqVjwp9YTxLktf+Vn+DIxWMNEuScnTIiufyReMJ3U0L0czGqDeQYSriykLSqmT+eHmk/MYGWAdFPrcaHwsXJizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNMD1cf9ikW7z8XIDF3AHJN6litjDqfqi19PD/vLZlg=;
 b=cfLqy75peYc4FfWXo3RfVNKW0+N+TmkLXHJmpcwkwpxUUBa56+phZ9yS/1bzBu1ni39ejoau6qjR7DhhaUQWXi3IgsFzKqM/lsL2t4wpDE3V55fLGJwq1bwjbg9kjME8b33BNdtDnKqd+kPIi0CSfQ1OQBzqAHxWm86fNcR6E7O60Zmj2fLoRLXHoNEoAezc0cqUnYaCNQh0yANQKAwRyhrHv9ZDYlqIjO0EcxFy3TY5zOCyUg4zMjr0GKPM6ExW4N5TvNOno13PPLuLzIIT9Umgf/gSQjLf9GKvHoxSPqvH8KyVb1ILuBR6oF7p/h/pBonflLP9P7/UCnE3Cw4tKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 13:20:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 13:20:18 +0000
Date: Mon, 23 Mar 2026 10:20:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	skhawaja@google.com, pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 03/11] iommufd: Allow binding to a noiommu device
Message-ID: <20260323132017.GH7340@nvidia.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
 <20260312155637.376854-4-jacob.pan@linux.microsoft.com>
 <ab-8R5Vww5Fs2Zp8@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab-8R5Vww5Fs2Zp8@google.com>
X-ClientProxiedBy: MN2PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:208:236::31) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 647e2c68-163d-4c5c-a868-08de88deed7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ROcf9J5Psh1M2UElI8kOMROUHrMFtf6eXCwngx/iFgNjRs26tUVFxMx5lMeHyeOMej6pZsyKky7bR35BIn95HxmRVogG5Ky8ip3tJXYRs03blrrj7+5d+/PcFWzFFVB9ZqpJ0Nj1+o9WQrX9uHVbGDfibCatEVsP2KfZs2v/mhCd7e7SU8fw4AhWhgSPuUrjFJP2BXn62WmIo9OXxT5j3sMwG6fgTcbgy7t6GFbZaDCF1tCnwect2EywCzyAQ3uUaabAK5KFwGpxsjIoSQcxNymxxTTBzLtFP++f16krg5beeyKGiOAZhUZOIVExe6CSD82tbJCNvBtRk/gvyBuLL+X5QKzPA1s2NSXRrSQfwo4mIdsyeOi3L8JGYPOKIgFHUeo+781JC/EY9pOZeuW/FD2ZGz5V1vY+SQDYPBK2Kio4nFr9447mUEm8zzvIoI4KsEGdC8hqIToAgBoLZ4xH19EQmVWeY9UZc3dQJ4lWy8tB/0NlrgYLQTJtTHh9JvRolqlt+D/ihpOZIZqLtpZHc9Kx9Qzgt7FxQ43uGmSEAGrrEs0mAGpbPJmcTrFYT1aqcWAlgeV3f6nozNfdEHiwphMWDEItZTK5TpqeSScysy2H+hjtyrtdX8l9kgm7V7nMrbg2DqM+3qY5MN3hscz7uuOoevXPnsh2TSdwakijXLvN/tu/kLET+oirER2qBJCX/bse7ZjrGJFVTL+hz89kUq4xWMAf1tcY1S5q2RU3nKU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ke6z0y3ZMEOxAqY5qN4r0y+xXJPphU4ZzCf7fNhT+p6fqWm84vw6VTfKRhmz?=
 =?us-ascii?Q?dynzRgo7SlrBLUmX89Httq7mlgBiHlgJ2DsB6GNOtexDIIkVCwXUPkRhoyBa?=
 =?us-ascii?Q?GWrLqC27jpaPpOE73N4VGmSRbL1EqmIwquJc3o1y1MnXJ12ZmDl55zOFXSok?=
 =?us-ascii?Q?cS/h+vsTMa3nKqjSi4xHkiz6Ma2s6spfQYVARiQ043wHO03/p0cVwyknk3ly?=
 =?us-ascii?Q?T5C0yyTBGS/LT6HlOVUq6Yobore3vQK0JTjakgHDOMPYCKoejLy8hH/DPm9B?=
 =?us-ascii?Q?kYwa4imtLNAj3YpxWNOl+YMPim6+huJfWOQmbB5c0xMgHY1EoynConHmA3pB?=
 =?us-ascii?Q?RwIHaqbnUNyz3lO8dOfmv/4kXvC/6eYJSz9TKcnqqrM2xWglppfW+jAyFvFX?=
 =?us-ascii?Q?U8DOdt4h3VMDM1zUvTkwnKisxpFupfaqSEic+K0bC3B2n8toon5TkHzte5hK?=
 =?us-ascii?Q?mrWeZ3o1RpJoCBU9u1hqYK95mefyg+SCz1+bicfAZ41PtLlNlHVG2mXQt2cD?=
 =?us-ascii?Q?cSGmyRXvM6N/zWpzVX85Qq7IjL2GSo5Yd1klOoBWD0XkcXaTltml8z/2GRMD?=
 =?us-ascii?Q?FIoAFRS32HF7T8uC+LNVSNwpV5Avd3XLhrOrYQDWe+dOwYxoh9S/73ERqmh0?=
 =?us-ascii?Q?MqObceidJON6rp7n/0jVMxN0evYmnuyF+pb1mGt4thDi4jy6Vjdjf2q10UEO?=
 =?us-ascii?Q?fdM+9nP8xrOArLxsuDAs56xGMgA+lRzYQP3F33SItvHOPxzUeEerN7Jcly6o?=
 =?us-ascii?Q?vI2QCgk8YxMdhWguYdsKhEijQt1pR0l6QGyxfVXPozLG/lA4tHY4AqcfsgoD?=
 =?us-ascii?Q?Ea0zIUNM1soRuSKwzs4Nx6+vMGE8LJQs3yy/mx6RslgHcnpakAF18aaMhLyp?=
 =?us-ascii?Q?cnCwEK/GyrN9+OC6z5WEUEEhF+dtJdyeBsoKRu8a/8AfO2eUGwZOZqdNsdbj?=
 =?us-ascii?Q?5enF2XxD2Nplp9BqcG0PN0v9a5CIj6zJ510XJ/g0m37GM9pELdcDR/n6nayR?=
 =?us-ascii?Q?58hRTeVgjhtHVCmZqZGh+s3OUrNj6HeSwWLEvON7xeKKNF5NTX8B7LOcx36+?=
 =?us-ascii?Q?S3Fj9bW0l8TbQj6Tz0brI0R+gF+jFOAQRJGwujSZu0Cq2pmQRC8jYAF/eeVK?=
 =?us-ascii?Q?VczJ07q2+FHIMsLRAowvH5ctYmizgkggG4LmkmPTUPkt7oWKRWAKTgAnbod3?=
 =?us-ascii?Q?dnFaQ61zboc1QbIOyqlZ9fH1ufrRaLMK3mYhIUiSWQdoytcPHnmYYK0jjGPO?=
 =?us-ascii?Q?LCfnr0T+vmZDJYYsuvTegbkaBSZkeDqc0cdE9hfHXD4TNM2cvv/cGxokxne1?=
 =?us-ascii?Q?+8cWIOrtz8uttoumjAV9Et5m46R1hSNoIdfivQjhyZeogRF4bLPsOu3cgNIZ?=
 =?us-ascii?Q?5v9dNdE4fC6Ev2+JJF+ufoMWPhj2hqilDLt0fgI1laLLArhSi+TdabXDzgUN?=
 =?us-ascii?Q?l/mk1R54L1/iWSrRYg2702GxHC8WLe+JEdKl/rTD6wKAGhw+M35icUtXKWTC?=
 =?us-ascii?Q?i2a0iDGJxdwYZJMRRMWL69WorzQz2Lg755fjj97GSCMXqK+DbB72iDjdrsVf?=
 =?us-ascii?Q?EbPYycmQSl5O+0O6LI6TQrxaOigz9nL8aANm68HksztBPPUAgOWWCBYh1mOK?=
 =?us-ascii?Q?Dr3iBD5l5PJLDOs+WnLGNH5+5z1wpihGKP/OfM6pLbY1kBdYWL46omc5iI2H?=
 =?us-ascii?Q?KmPmDiFLL9na9+lF/28LZMl0o+/k+JZr7x8sf29t9+ryIsms?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647e2c68-163d-4c5c-a868-08de88deed7b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:20:18.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gql4/X4H3othXfEMDiHUznVT8sWxyrtvbpEJz1+JnwPcjlMTpC5v48+mMmNBKt1e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980

On Sun, Mar 22, 2026 at 09:54:15AM +0000, Mostafa Saleh wrote:
> > +struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> > +					   struct device *dev, u32 *id)
> > +{
> > +	struct iommufd_device *idev;
> > +	int rc;
> > +
> >  	idev = iommufd_object_alloc(ictx, idev, IOMMUFD_OBJ_DEVICE);
> 
> The next code introduces new error cases, do that need to be cleaned in
> that case by calling iommufd_object_abort_and_destroy()?

It should probably use iommufd_object_alloc_ucmd() so the core code
manages the lifecycle?

Jason
