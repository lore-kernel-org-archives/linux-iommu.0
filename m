Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9E34D916
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580522; cv=fail; b=YxMFNr79ZLlcGs9VYTbnO3XAaXTMj7Zb6VgoXNo5Ev3TdPq/2SpiFrpY5JEWsrovnjILPU9Yqr7MH5/nN5QHGl8s3UxBuKeR//3nBhCt/oIj+5W8B6n+TcKcyJvOTFeEQxkX1IFBX0OKkuCDKf4XZELzMXdH1UtO0KFf7IujckE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580522; c=relaxed/simple;
	bh=4A3NjfL/GjgDIpf2CIyR8C1qGhA9TZvx4UH5Pb2nPrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WCiU5zJHB80mX5veLNPbX44gN3NYaX/Az+aXcdjCFXuRrLJCQ6CE6owrHcSamTLv0XUYV8BXO3vuPjE2AaG6lmKd90RgbheqYvglp+UFXAWfVN0YerB60VUIMKrpDSSnEYpabzQiKKjh4kEm1S24DL6UOSMJx46PK85z4/pmS6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X8SQyTPq; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X8SQyTPq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UddQCJAGMzbJ/4SGoJ1iurDw5v8OAOk5J3TA88HmI493vz/rcadP9NInGP9c4A1Uayy6PFC+B/9tBo8XKv+s06EUJYTHecmHdU+RIrXpcO3dhuHIUKmTsaW3/UPOmuuq2+n4hwypjTKAUISc0utPUCKeI8SjNm7UXxDAzEwg3keOClqoZ7tvSeGWQX0Vy6vqQqXiKAlvFDoD39iElxrX/8Tpsr2nEfpyHdxXtCDVMkO3fQQo4Cx0AcXwTMiHwMouF2YNP32iCrucT38unxSWIdDlqbrx8tKrlX4aLjf1wY8UNrZ3d1HE+8wNp3Qll1BanUPygKjZawEawvQ4xdI4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YLefiHQPAsVeBqMYPJJLS3y1XjD7wZ6GhAUzg7m9GU=;
 b=fTI2fzxn8LvzHf0TSSRWkBItVv1YtTD1IJKZ/veEocfUY88mU6kELFuS4L1hvT9u/K4fhy5tBM/Vlr/AiTgRWzOftK4YBkFJ+JqoGAXXgDrJ2efBhuxmFzzP3Qv3QTfaazHqn07SfGlO1Tk3sJqBuA0+5Hft/zhpvxeanzdendLSViwCgUNTc9cJf97fvBB0Srelw2ZDetOl9CFAI6N+1WnxcKlYZjebYd61IwWRhqlyTRlKSwoweDzjRegTJF57CAn2yl2G09eOgphvnnlHOfJ/pHyjffqBebj1iJlaTNS25LcFExpKNpFLxUIcN0t867UeYn6Celq+FAqMav1mqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YLefiHQPAsVeBqMYPJJLS3y1XjD7wZ6GhAUzg7m9GU=;
 b=X8SQyTPqpRC1mrtB2iXLEx90wrpW6/dUqFDLYZvW8Dgp9qMrX/r35SbLRoQc7eYUyqSjfPAKX8HogTmjOsrC5MG6O0gC1cOSxQVfr8T4SU9lEKyC9YiNFo9J04eQ3qqBxTRxbUi4IxacNzhmUXP8VeaxGaKq9xCqaqPU05nlhtOI1nIEpsH/b8APQIrjwC7EBHc6YgNcUPnpEqwzkumfE2qnoyFbguAZ8IO3URsCWOtsN3OzXUUciBZLRtlRQ6wYeXdI+tDJF4M2Tse2y0EV+PZmMfq4Dqgyz5JGmr2E0WeDy79rHAIb9qiZlAiFXm4UiW0uMLI2wk/XDpEmHvRvVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9665.namprd12.prod.outlook.com (2603:10b6:408:297::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Tue, 3 Mar
 2026 23:28:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 23:28:36 +0000
Date: Tue, 3 Mar 2026 19:28:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, nicolinc@nvidia.com, nathanc@nvidia.com,
	mochs@nvidia.com, kjaju@nvidia.com
Subject: Re: [PATCH 1/2] iommu: Add device ATS not supported capability
Message-ID: <20260303232835.GI972761@nvidia.com>
References: <20260303150348.233997-1-skolothumtho@nvidia.com>
 <20260303150348.233997-2-skolothumtho@nvidia.com>
 <p435ycx3b27d5gpzcli2kbp4eh36fq2ufgkft3hf3rqgqfx7i6@oql6hovzwkju>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p435ycx3b27d5gpzcli2kbp4eh36fq2ufgkft3hf3rqgqfx7i6@oql6hovzwkju>
X-ClientProxiedBy: BL1PR13CA0249.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: 927591e7-69b4-4ae1-6b2d-08de797c97e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	j13Q3SR5H1AyUWHOJl85JnyHbxqORpImIk01uAgCd+s1rq+kcYNbYZtok7z7q4vtC7J1cPz09q+nywxzYmWbAyBehgyjrMz/7hfVIPYWuZSHoGR+XfcH16QejRZ35YD3Z+SZJttHKQvxuN0fZhUORf31vvXL60AdEcoKejhHAynQvDvEzz9dU7HShZ7cbdlS3lAAyX/j61ED0MXUVw8PkLDLdBVPRgzVuGz8yWTAPmO5imme5mBC3raanHOgOikSVhUY5D4k9f1UrUNp2PIrm2+wSRfCr01BRQ4UGtiU9cxi3SbjUgIX2qWhOdbS+Zii1vgJxkZ5MuLc3j2u0gKiTT0pVeZOHARXeu3OdqqM9YIowSdaVrrotRmei95ueAcsKWr1jL2Jp7hkO/21gMef18i7H6uVWJwq2qU/5tEjdAiruomq+2xpknOD5HEFXBqgE6uvVxdmUsPZAnh3PrK9czltDTU4Q6a9NDQYzVVuR6f1SKcW6/3WQMdfoBzu2siGN+yExLjUOk9wRl3Cezerd2vJM5Ks4w9TUuwQrgB34v0SNM2wV4LfcAvHsacG14MZeg3HmUFvUQm5+yF7jMHHlqQEFboI+FbhhNMMSl23CJGhjJwhiQtjoaJ7zwVfq2aTZzy1AJ16ana3svrgOwkwN86U4h/GEeZlA+bRe7N1s8H9ut86y/OzPvf2J7fRlyufT/tcMOY+4nCBJtDr1z8rn+zNNHffHcyTG2OQYH/huYU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mIE6EuKNwSJf4SWx4/HP+BIRleEL/DpbtsTRO+oujfejziUl3UpRt2uCp1eE?=
 =?us-ascii?Q?f7OMBuqtP2CRQR+pv2uc5NKOR0qU+0DuWJkXaAn8jEH6hNDkN+T+yqLZCHaQ?=
 =?us-ascii?Q?eKeEs3rHjxwurIb2Yf9hp9cOmlZ/Ffivv6KxTqNx/VMdd+lmJ2zudfXlmf09?=
 =?us-ascii?Q?j210SsIwvgxkRhy9W/Sj6BHt29e1zhkSuGnGVCt0FEeevNjiNaTLkg8cd54n?=
 =?us-ascii?Q?klPYQzVNykBF4OIU5kON2rF5Be79JrD8m5XAe8AO7ZUjhS15D9143cnQD5AX?=
 =?us-ascii?Q?iQRdXQX1a03CPlcnxItiVy7NOVHauZ7ddFGhdGcZ3CIAagJzPn7Plw/XVb9z?=
 =?us-ascii?Q?126B1UTWRtRrrYF/s2h8UfAeEPAoZTjBFM6jSwCpGS4QxGwZRx3GG164HpGs?=
 =?us-ascii?Q?InTyqec33pW9My+WXW9Ns6VvQ5yAXgzqFfU7J64lJKQgggrvRZDcCy204Gaa?=
 =?us-ascii?Q?6DHCcX3/vpna+BhglXhuS6sg6nqcOwpntaXYCbXbNGiB+O0KuoCYEytRNmn1?=
 =?us-ascii?Q?oE0NX0ZtwE+Xi6ACeCUIbK8BJ4geAVoGeOfJ1ulx5yXLHNm4nRx2nAsjDkiR?=
 =?us-ascii?Q?BCk9964b+1p2IBVeuxZQNrpHdNhf1t5zHduA9qF3h+1WGKqSA7MHml7Q09xO?=
 =?us-ascii?Q?9Ncc2YNpovDnb3MuJPD1hCwWgoKBP0svUZvKNlucUI199BCv03ySmS2Vlv+f?=
 =?us-ascii?Q?rsoCRR0mDtAXSJuHCJQz+zG05D8iJZFygS4hqBiLKnxD0NSeGXdCHhkNLJzu?=
 =?us-ascii?Q?HtaPPPDH3mY0v1icGlr2i5BKEbQsKc9YvoWTIiDPzmm5PUyrDqBowy5RAjju?=
 =?us-ascii?Q?4Gd3x+5CrwDBt2eGBKJrqzDoEefo5LiIfDf+NuOdTcs+0Vp+FsL7INZZxDy0?=
 =?us-ascii?Q?nNvnnpyk33+xOBTr9IMTdIGn/3Wg9z+8Sd0575hoztMy7zylDx885Hz4YoGy?=
 =?us-ascii?Q?orwT3MtkICW+n1BXub8dl/7mBqpEpkKmCxBm5brncfugMfeOGI4mMxKvtsf6?=
 =?us-ascii?Q?EYLzLXqn8+825LWzAKPkklEgSuiLMcrSR35jiAH1HtgROtvpdGp9Br+BG/G7?=
 =?us-ascii?Q?dwhfHWN3Vs/EpeBR43NbhVhGFD5j1yQgJO098SkquAv+AZogEqOY2dYDj3oA?=
 =?us-ascii?Q?w6wO1KNL3PP2JipSHFGiRJm8Mycoqu37SkajPP2k4Y7RSSZEGQMFcVfcEkJY?=
 =?us-ascii?Q?OME3M3RvbbajNu1rflqVzQUo0vhbkakuOPa1ke5q7Ct9BvtjXKlXLh826qdF?=
 =?us-ascii?Q?0jmxIUrJaGKBB+oc9wqyeeObFrwo7fUaixuu7OHODpUIR8EKOdz/bn0qNltz?=
 =?us-ascii?Q?oBfeHhhozoVrwAvC/hI9G0I0MLQND+z3RJyjJR/HbVhS3C0rqQ5MmM9K82Il?=
 =?us-ascii?Q?hUtsdk5KlDgZ9ZnIEueDGGlaQdaHKh9S6uXKSpnfClaBpmYHd7dpSS5CzXaG?=
 =?us-ascii?Q?34i3Xy5bzZ+TZQh/cVDgoqjijCYCC7fe9DGrTek3+XU4fgQENt9uf/rDiVC0?=
 =?us-ascii?Q?3qDD9r5mLHzBIum5vjgqJjfUyY0xnjdhx4igw4x90LyYCf9KF6h0+h7eeYfQ?=
 =?us-ascii?Q?Fo9VSc4H28Qbnqg0KNBxq69j1qlgKwf41T5QSiX2Pq9GJrRMCrmEVZrFMmXC?=
 =?us-ascii?Q?wkEuoWr7N1qsfzKVVE/c1nEA/YMJseq+LcPCxTOC0Lzs8QdE2oQi7xKoPdqe?=
 =?us-ascii?Q?pJkm/h/y+qWKDc5YNRN8l4ac9AkIB+hhO/OSI2t8wui+bGY4vARb8KlOuYm+?=
 =?us-ascii?Q?dukglEWgYQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927591e7-69b4-4ae1-6b2d-08de797c97e9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 23:28:36.6631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMPWLGaLXfxrBjLAF7a+i0Y80oPelDoTmzeA/C0l7CHv67AUjbtnQu/RCKqMevvV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9665

On Tue, Mar 03, 2026 at 10:42:48PM +0000, Samiullah Khawaja wrote:
> On Tue, Mar 03, 2026 at 03:03:47PM +0000, Shameer Kolothum wrote:
> > PCIe ATS may be disabled by platform firmware, root complex limitations,
> > or kernel policy even when a device advertises the ATS capability in its
> > PCI configuration space.
> > 
> > Add a new IOMMU_CAP_PCI_ATS_NOT_SUPPORTED capability to allow IOMMU
> > drivers to report the effective ATS decision for a device.
> 
> nit: Maybe have IOMMU_CAP_PCI_ATS_SUPPORTED instead of the negative
> variant of the capability. As this will affect only new users who might
> check this capability so this does not really have to be negative.

It is deliberately negative for UAPI reasons.

Currently all userspace should assume ATS is supported.

The negative means new userspace that is sensitive will still work
correctly on old and new kernels that both return 0 as meaning ATS is
supported.

Perhaps this should be touched on in the commit message.

Jason
