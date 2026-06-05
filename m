Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B6349CFF
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667037; cv=fail; b=BhHKSfSNwk1Oly5ERW3igjNqnVb9fmczvPSV4EwaU1AMy8fcOOIPMfUtnwHwIJCAhWJlQG8/tOirfQ0SzMW3953gbdBvJ3ZlcT79q8fC2/bYapMcJFsN0QW910vAT47EHSen5Rl6/jXLNRv3ccV7mYr7P7z/RrPJniZ6IH822S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667037; c=relaxed/simple;
	bh=8JWWaFnYcqZHesCltn8kcxoT6+Z6YLjVbt6Xy0LGU6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bRjNdByuZGa78k3vpEx8TIhRQ9VLsZJCpTYusapFr/6kdQDXlC/ezK/h9ETRAqfixouNl8RsTNvlcRXM9wWp9Q7Iz0DZi/kNyRwhP8SQJaLi6IhCr9IFOovJ7JHRotCkAYRkvVvaHuk/lkPWv+DtPwwR1olTUoXAAn78I2Cigs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bDtJLRry; arc=fail smtp.client-ip=40.93.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bDtJLRry"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMurUyUo7KcKVPmp6hVh0jtzBsD1d+w89ckuUQ6dFNXKaExJtX4NkZhFq6v6IWz2BFxDixYD9vUqDMt/5POCAVmNELJx2VdjJekrU6f+hpQ8UjVvaVaD2LysmtUvWUwJHU1zlbBxiP1Fj2h3vV8nY9GlmbvSE/i/i813GYjwH7xJAUSc6scVe46S5NhWoYukAResKuroyYmauJmRVoJJpwRm88TELuwJGQWT5cWgdng+WpFJMGAbmtYeL6dEqo0uWgC2GWGKVVJqdYOadAW9iwuBmb41G04EM6eAZdo7+4osoIqTjJEEcmjszqhm49qYbmwQNgzrZ9XsUwWUiCZNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcE6gBbhJyVeu398ZFnt3pm2/AQIwzOFzykTe2+U5h8=;
 b=tyh8kckHC5eQaTkCVqMir0mvCt5rcuqHZzSF9bIJ3efgDX+X6h9y5To1VpzsaAOGbI805E3rpkXKUlEPE5Pit7YXgO7Gn4aS+3lGJiY+P/8lJS/QOOsvtKS4J3ne8pA05aifmzbVktxVcAMWmjeYU1/79ACHTi/7JlkF0ifn0VqnYCy5OOLc+aZNyDXLGZ02efGwVjE5ZSxszeRrDQAL32NyNij92ABYoSSWnF0Noq0/nsvQvxACMClCVAdnSNUV6KTkunzK6Kvs3TVL238/+Iv0cqDtNAY1Dgb+WoN4WzA106tuCEWDqX7mCfpPtBcdNYjwClbETrSaZbf66MCt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcE6gBbhJyVeu398ZFnt3pm2/AQIwzOFzykTe2+U5h8=;
 b=bDtJLRrySG58AvoT8KUntEc/cKleRn13ZMuMhOw9Z7Ob20Mv99jtpTqsCi07GhJ+iEr+llOuyFxbxl9XzFUDzPaLlF7yXecHzoYFNDnHIZFMhg85BXGmoqqwwrf+YByDCtauZYwE0eKOCw6YMaUtlAbbGsnqxpHm5+qba344LuqOPwDmDLvAiUVgpgziBzRTRj8ln0A8Ax+ypu3Wh1lWrmIh7J/seK6drFwoBKOW8+b3oaYGfjwRxYWP9laC6C0sUQk5sL3TaV6MPr9ntPRPOOzHc14qok3kdqvtEynw8uAetCZo1eJLt8fGAyUFrQ6qtTeLpazVEbUqcIfq/74aXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 13:43:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 13:43:48 +0000
Date: Fri, 5 Jun 2026 10:43:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH rc v2 0/4] iommufd: Fix veventq_depth boundary
Message-ID: <20260605134347.GA1962447@nvidia.com>
References: <cover.1779408671.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779408671.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c941a80-37de-4be9-1245-08dec30878bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	bR1bJ9clLtTBCQFgY1ZTyZPNH3aZkyrynR8aN6eOTLWzNC5kfFFnuN2jii7TOn0X6r0GHBwGWy8tUSD+LdkYbdy63JmWj5F2aN6sn3atO94DjWVbBn9LwSPRkJEBchykvXOjjEYCwMInpHAAzFa3WStAEqp90pt2OGPQL26oCMeiBDnI3bQBK6czeQo0rtHGCPM7b/z8UaA0mTIoNchOehLmaWV2TMZM1N+CnpNarUG9JRXIxZa5SicmR60Bk4eBtCDMhfKPagYGT88ROs2DRqVhHgnqgTdhNWEt7ElXdUXYFPdrUN9LJjErDQOyer2/ik4853fRvOvU44vJHet6NIbqn3BFLjy7qn+2h+lWxAzNPc975/+5mkmBGsnEY4nTwGoiNW8c64wzBMnIciLpRd1TdimPeLE2smfQz0m5xS1e1Zs8vRptucidcfwPnFmDNodfMOwitSghT4U3d3+dDdBjQcNUJGWFI0Qcion3G3xi+k5AxQ6RtUZFuqiJXHOQheWwvoc3W0RDm/290gcY7oftzqasZ3HeN/I3g5qFukUJQv5axdlJXUl45+vWF8RN7V2d3A0hCoNw66YKltQchXXSn30QdHWLFW4jJBktjqewGp2/uMIw/fE4wR8Hhzx54C4K8Aqckr5THmWB1q+vv2cbZAj69tHiB9IVoiKfRypPTPCXU/vuOd24LRDNOIkOKaefE8yd3yPYHDAt+CtZMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l6FgqGgKdzR8z9JXI+MTLCEOoqnfp/sFXywU3BBLPxcsMgoJDw/TJXPWYIIy?=
 =?us-ascii?Q?4svguSFikQLFBaF58DkI0nwC9XNdImCi7hQpQuf4qY+YADKktbWHxJh83fqL?=
 =?us-ascii?Q?oiR2RbO94k9I2atMMZlyTIK72wmSIQ5uDRjK8or1+l1EKgC/r2ZwJur1strA?=
 =?us-ascii?Q?09mmtmBXaVxXihNTXyQupYfevJ5WVKSGkrKaLvV/zeT18oG5HshqBRNMALLK?=
 =?us-ascii?Q?Eq93U8mexMduHpTddavw2qRSiaJkt7fTrD8tlXmPzAUogkEjzeaa/CO5iX5H?=
 =?us-ascii?Q?VZP0ygKdBM1nBX8keb9WgNj3KDvpv1gKn32psBdNWO6wEwrFBhPmCniTBSyg?=
 =?us-ascii?Q?aBt7+2TNmQAWYfWEQV8c2vg/jtiMjeMAcRTuIgJNz5unloXLC7U8uHBYj/9A?=
 =?us-ascii?Q?XtApyg2MJdh0x7/EYkXosthnZFLUDGNCycYm3XF6uf9ZmWE9j9QypVN8r8GW?=
 =?us-ascii?Q?iqcfqOXWF6/GycVG5pFZPZ4wPXbgItVfjecvwSzUb0cgcAsY4NjaHTyqnHD5?=
 =?us-ascii?Q?t37D/TJS6jFzanZbT+sI2lIJWUXIDsKbejhazzKUZCj7oII3i5x3RsNbOO11?=
 =?us-ascii?Q?5G670mCJ9OaZyHC2tmODyGGfH7Ogyvp/tcnrCxDQEcuVHiRNLsC1C6NnSjA/?=
 =?us-ascii?Q?aR64BgQRy8SvgOZ5bgeS3xN7s05aOs2iT5vpavanr3QbZnev/4s+adw1dp+m?=
 =?us-ascii?Q?bbQ1P3a7l5D6TYILMRY2EE3XWvZVluGHXPpaTBcFph9m2o4Iqq/O08ib/ywd?=
 =?us-ascii?Q?ParYMPmM75FMY2UKigKVtGIdiq/49ccd2kAmaHDpk1v3olt7DgOzKtfrzuRx?=
 =?us-ascii?Q?tTgQ17QFCzbxqcHG3uHDKzDyZiUwFjA/enYdvx81NqdD51yIP9eYjpHbxgPF?=
 =?us-ascii?Q?z7NboiC7Hg2yIOCHpg/9vSLRQ7ie3QpumbXg1/KHAW14+xbK/myr3xxBXOFP?=
 =?us-ascii?Q?Ucbe/ot1C3DDaacyOsGzfaAPxT1/3bai87UhkT3GLpyt8Xqh0ebuHQ559QvL?=
 =?us-ascii?Q?YkmGQ/55iTRAZss75sNtZ4C867qClshHxcasNT+AnONUvoKC8wA3Gj3BCPOX?=
 =?us-ascii?Q?2Cyk0yXYcKk4QAG2p9DKmGjWbiiHiC1az+e6rXRTJQFnGGuLMzlr9GfXqIrD?=
 =?us-ascii?Q?ziuFcA+rvh6QjBfsg8iyO01jbpMSOcyBve3DDkTdUKWRQFZ373Zepor+pSMJ?=
 =?us-ascii?Q?L73Cja5hUwAz+G7wTTcgMLCJ0mBF/pq0S8uGwZj6Djsha23nNqICftSfg3Kp?=
 =?us-ascii?Q?aI8txQDBIYttqqRTUJpH7uWR0asUjPNhUQvu6x5R4c60neqdKF87kcdlfZbh?=
 =?us-ascii?Q?9yqez1g7jCwTQn+txJheRaclIs6EHrwpIqnYsMH5+iktAqE7BDvmW+MJG1L6?=
 =?us-ascii?Q?19XZvq9i9Hm9kGhZP8y1vKYkBIHGyMA2arqXzyfKCYXnM0aUewOWl3hbDYkY?=
 =?us-ascii?Q?UplVQ8LUA3k1gD30ocAum5Fxu4MS7UZbl48YuRZXbWqeHckhzGFcNjHp3qtl?=
 =?us-ascii?Q?5O2S00xw9rFQmoVNueZweLSBp4dK0gfM63cRg4y3OywE6O9s1uG10ZjWxuk1?=
 =?us-ascii?Q?mUtNuOMe9eAJDTk9PNf1rk8Ofoe5TvBt8pZ1Ah385MiZFpguAreaduibeKLl?=
 =?us-ascii?Q?t6R4qgKz5LxeJZpFNYb8RfZ8Ovrw4bjlXn0BMDsZvTii4wznhDjMD3UAiKgs?=
 =?us-ascii?Q?U0i/gHqQDOEoc8g7wiUZNxhhgfuSMzDphuNcuHTINYTMxDob?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c941a80-37de-4be9-1245-08dec30878bf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:43:48.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/ghFZmfsj5gW6Yi7Uxm/ICv0DSvOwwYjmLkYCvks46OvIvCOWswdu9gg4XzySKj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217

On Thu, May 21, 2026 at 05:36:31PM -0700, Nicolin Chen wrote:
> The upper bound of veventq_depth has been missing for veventq allocation,
> leaving a vulnerability where userspace could exhaust atomic memory pool.
> 
> Fix it properly:
>  - Allocate outside the spinlock to avoid GFP_ATOMIC
>  - Cap the veventq_depth upper bound
>  - Fix event_data byte-count
>  - Add selftest coverage
> 
> Note that QEMU's SMMU has been already allocating veventq using a "HW"
> EVTQ entry number. So, picking 19 as the known use case, for a minimal
> level of ABI consistency.
> 
> This is on github:
> https://github.com/nicolinc/iommufd/commits/fix_veventq_depth-v2
> 
> Changelog:
> v2
>  * Add Reviewed-by from Jason
>  * Rebase on Jason's for-rc tree
>  * Update commit message for clarification
>  * Move "data_len byte-count" to the first
>  * Drop optimistic read in the allocation path
> v1
>  https://lore.kernel.org/all/cover.1779070992.git.nicolinc@nvidia.com/
> 
> Nicolin Chen (4):
>   iommufd: Fix data_len byte-count vs element-count mismatch
>   iommufd: Move vevent memory allocation outside spinlock
>   iommufd: Set veventq_depth upper bound
>   iommufd/selftest: Add boundary tests for veventq_depth

I applied this a few days ago

Jason
