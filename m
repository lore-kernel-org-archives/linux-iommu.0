Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6941DFCE
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960928; cv=fail; b=ArsU9OMSYVaTBrj0APQvganboq64JveGBqDVC0iHGcq7pgEghLPko2w5qzNhz58pQNFFaDx/WvKpuZnGriEQcdL5w9APseVP0I5Pdvi1IbW08UlF70j723WqTYd72ESOUEDS4oA2Q5GvW1I9tIs3EtPl57/PrJR6jferxwFCK+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960928; c=relaxed/simple;
	bh=KUS/7bBvABCRjmDqF4fYKFmbDToalaTcy7AW79xO9+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YORLQiKyHju2lfgAJbwh0jt+FvpXsXrfx2dG0E3xt2DGYqRHmbRH44N/kvUoIeWnViiNdGcWml/Qju0xToK9UQne5HpNGQPEwLrX/4K5Y1sOF0QVWRJ7xvo29+z4ER0BXH2CztmCjHMIz/zDCIOYGYdJGFKYSZ4YDzgeCvolyJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oFW8+a+F; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oFW8+a+F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1mUJYFN1tCU5d2fH7sT5Ag7wskhTVhqTj+0wXT4ZlF4qGCQR5JzdjMFLCYgJZJV/yOrA/mgwSx8bkIu5XqkGTjuDKc4lVJ2MxINTx5NpxdbmsVVe8VZQlC4jrQJXn+8AM1H24j39X2L4naCWZbflZ0o1bjK2Yii30CcON9nP3i3TWxmulSyYhSgiX41FTeoL16OH8tgJv6Cq3FmBqKHTmuTYspctSVOm+D0Z4lWz7KX9OPHTYT/F37Ac6wP0p5w6uug8RMhAVGRwsg+ppoRnMZT4L4oq1rBHXoDioKqBzEyOKodw5bDPVDdtguLZ+vWuZxAIEY2v+QoGt2xmvRzNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUS/7bBvABCRjmDqF4fYKFmbDToalaTcy7AW79xO9+4=;
 b=Nj2uEkr6jk59PeM+Rxj3Y9m5SnFIlGCn58jdm7DLGO8b51Hvx2FFRFwE3Ft+dy0L3JnEMHVdBQ+at7OaxiOMfNgexymVd9oBnaRaODjPzGP1ro67itjR9FtlhWcR8WkQ1Fx/p38k/zD32lX2XL9Uh4RVyctQ5/4Ww6NZGKgs0251GAkekMudcT244TxxpnyMn3xmvLp0E/MBGwny15/VF3raLz5PSq07sPRbrPAx0jC963QIREXhNUFr0Vx9Mth30zXDm/LT980MADxqZcRjhOLtSzPoq7C18wSh+A868gQKBwXjVr5JRcDo9PxMuRsshCInLCUilI15PB2dWJAmmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUS/7bBvABCRjmDqF4fYKFmbDToalaTcy7AW79xO9+4=;
 b=oFW8+a+FxusASq2Ub1DKvXw9ux9oZRt2xAPmMxgY1EHYE/1RFsZHgU5+3kFDRmyKSyuwAgG10NHyNVdz+JfA/5coI0vRaVASUrfDa11glRsArAF05AVEmyZ4p1zB30Fs6yIB92pMz2BddrrEmVX8mUFPuMJrHNh7VQQ8oZ/1dNQ6XIIb4p1ZseEIXzzpa16aZ1C73MKURE1BTages64Au8SeRC7DzIjjBVya6zzv2P/ECwpEhJ+GA4kKDurdfDSazUcMAbNbR8XxLgc74iOTdfkEFkUNicbzuqfW+4YsaCZZNWWlW2mWzXutFhjxlPGLat6cLRkrado3YIs11NH9Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 12:15:20 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 12:15:20 +0000
Date: Wed, 24 Apr 2024 09:15:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	joro@8bytes.org, kevin.tian@intel.com, nicolinc@nvidia.com,
	mshavit@google.com, robin.murphy@arm.com, will@kernel.org,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v2 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Message-ID: <20240424121517.GG941030@nvidia.com>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-5-shameerali.kolothum.thodi@huawei.com>
 <364b6a6f-048c-426c-a9c4-aabef551e0c0@arm.com>
 <20240423173202.GB941030@nvidia.com>
 <adbd2725-25c9-469d-a9e4-14fffc1521aa@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adbd2725-25c9-469d-a9e4-14fffc1521aa@arm.com>
X-ClientProxiedBy: SN1PR12CA0074.namprd12.prod.outlook.com
 (2603:10b6:802:20::45) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 64237a31-3861-4506-1b35-08dc64583564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fbFxN4jaLfSeZ4MSpUBBW01aL96IzBVB7dnd8xo8BoIpQ0lGGacw2Wt0ZTJT?=
 =?us-ascii?Q?mQ4vC3uZXZFfnVUWsW93mlehxbZPc7DDNxPy9W5IIY4hgKoFIytFyoJAQRAK?=
 =?us-ascii?Q?2RGDrcbmdXKNkALRKdQGoxRt7L4E1Hg3bydWsSfVAY+dzJhCt6xVTAX2HxyJ?=
 =?us-ascii?Q?tTnpvgrMKy819xEmnji3WAmKdEb3iSVrzaCn3by7b/CCFKwTyv2cixLfIIlx?=
 =?us-ascii?Q?OruqE9iuJJ1M0dGkebOxSvm/HERsj0e7k08C5m+LErJMs/Sv6PhRoEOXHMks?=
 =?us-ascii?Q?/3kMDDLwQgMrxMyLERER/v+T836PvdXp1OpJUSuM02jk2pyu/HcmzoyFueKb?=
 =?us-ascii?Q?syffCza++toPruJvhKrm9mZwqBnArutKISFyH0YUI1zZDzxfQFm7GwJ7mvld?=
 =?us-ascii?Q?DvLCLW51iJZ13L48uOP1/0QAQgA5D/7lM/eSbWjAFYCNG7N5jo3aYPO/iqCg?=
 =?us-ascii?Q?ilrSWm+64Jumwq9pavf81EnDzlAFNc97wL64x/Tda+F9EHHpSfPPAMNtpq/3?=
 =?us-ascii?Q?TrAauIEU4apmQBkn2CdJ+hCw4b3Jy+aMFJR9v2PICHL0xMufWhN4ATdInKhc?=
 =?us-ascii?Q?cexvPJW4SfoZEeH7zkwpC0g0J74mjo24jVOy6rndaSnGGqgQYEBEetha084e?=
 =?us-ascii?Q?13QCc0GEbCzbV6PCstySRrf1obR4QYr0l3n00AQ0PDR9Simq7yXFAzL/gfVs?=
 =?us-ascii?Q?6/m/LHx9o+v6akr50zY2jTpvq2Jg85CMvLtmbFdaNuvh2KVg0DmmUu6edD4P?=
 =?us-ascii?Q?HVWENnT1zdf0N8ZazbHtVZ3UnYK9SXUMkZPwgftT3mX2SW2jHGPtkqhTHqg+?=
 =?us-ascii?Q?pyMBfeEaRE47EzU18lqa2OKRNlJ3SxiQ+8qNj17VFt4BHgNs3iULSCzQ/dn0?=
 =?us-ascii?Q?6Kc64TKvmOWDGxlXCQPrtrA9KQW2PGtyiJU2OHqiRbn0rS5RIbf7CIs5/oXU?=
 =?us-ascii?Q?kDpXCpXAluDt8uhj5DA3fyI3JR+frSmpH+Ba2i9gPNQamKEcosXRkgy36iPQ?=
 =?us-ascii?Q?U2iD7CqNSDPB2w33s2/AqB09IrCOZtOk32zG89atRfRfnz+rW0ug7y3tgdIA?=
 =?us-ascii?Q?OjnJxkGmDMyNKMy/pPg4eVZ5bnFcPT5uPOswOGkbgrOP+UY/wg+N/AjHEIMv?=
 =?us-ascii?Q?KqCD9igiLq+CWJv5/gUGuwcdazxz1TIjbfTdxSsLio9ElzRccLYEMr8MYfhF?=
 =?us-ascii?Q?ULpoc7feJAdlHJN13ExU91tGkBgo5irhOcXwKV5DXKYaU4ImAucGSeM6q4fi?=
 =?us-ascii?Q?HgZe9n8bNof+5y8sC81DGmyCG1wBiLn7G8wH2fIr1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/0WhP9Mb4NzPRsAvPWfMgmKwYtSr8L3G5xgDnmFKGKT7m/MyGVJWy8RIIcXe?=
 =?us-ascii?Q?KvkGza0U2IF6g77ce3rhM0ogd6K1+/yIgX6MVGH/mQ9Ur0LsMkIpUj9Y5c5/?=
 =?us-ascii?Q?qieuQMQ7we+dGthzW/b9e88wsDuLOKLJTWMQrYJn1oNuy3nqoX1zfX5Lciga?=
 =?us-ascii?Q?94fn8X4avgL97tFInBcfWD92IiynzTp0FhTMHYgwusHxaK9Xk8aXPjfsP5T+?=
 =?us-ascii?Q?gQKyhO0Pyu+3iTE6Za/W2Njqq59YSNpohL/6aAfI+Q1pdMZ1YCfdiv5uTHrI?=
 =?us-ascii?Q?2/aGnz6YX8h615OBvn9TWHqpshzp4M9Fuo8Bw+kFbGtnEtq+YgK0WIB/9+aL?=
 =?us-ascii?Q?k+JCHIU+OHQeEYbVUYZ3+s5K6Iyc2JCxUZZOCHP1+HU5fDt4Sbwp5w7aBmh6?=
 =?us-ascii?Q?ZlSE7LATRFAjDd8LKwnXDsPRktyooUuEXLWLh6kimlcfoVghWfRHxz7XYUoE?=
 =?us-ascii?Q?UXwp+sg0tjaKLa+i0tVTvovNmd1FdS7VgYSVdgihsRzJYG0QQjU5PnHonIzv?=
 =?us-ascii?Q?RtbZ0a5HaqO1atWkoYHspRSbtmgpfNGbmUZmrctLgZ2v+cZ9OhSv/Qu5G8Nj?=
 =?us-ascii?Q?Uvr2m1411e6huly81gAm8aTZ56CGxrh/a3+9cMife+4BH/YzWcGn313u24xp?=
 =?us-ascii?Q?M+Na9M7iJjFYhpmdbBqValwT4TMRmExa58xdKC/MUFJUuTbBCYdWQHDfy8Sq?=
 =?us-ascii?Q?+sAQYSmYqenRB9R0Iuzor0i51H9Z3nxBu4KCSqrMWOR93WnlNBXpMR1js7T9?=
 =?us-ascii?Q?Up2PXLFD8rrfx0Sk3RzUbI3wqVhdbQmLRucqBpMp2W0CBuq+7/vazJniN9ym?=
 =?us-ascii?Q?hCiPzYOwtkRDUlvI2AMGgqzAloNFml5HLFzCB6jcLzLb7/28+sDBDky9H+us?=
 =?us-ascii?Q?O9BGu6VJETG0FRy98jUPoUFfbMpFgoa/HFfO2aiXLB3aUPi3nkFY3ESEbBcx?=
 =?us-ascii?Q?VDOzneoSFNCtN/uEy7LXsFDoOpo7rOu2i5iU2mAp7W0LvW30bWLqd8f+ZYtS?=
 =?us-ascii?Q?N5ETf9c4ww3r4XqzYq5ftLqXbe6zHjImrUAXtYYu6hreY9ZCIPcvFcrCX+vx?=
 =?us-ascii?Q?Dp/41yh2EWSxxlLlhwMErRu09kkWb3tohUPMzNj5Hkrtbk4IYIjJqUhx3oa0?=
 =?us-ascii?Q?r9vNaem0M+fPzrHiSyROePza19CoQM2BjQg9oKZRWaoHzykCWrabGn5uIDNQ?=
 =?us-ascii?Q?4+06ixwF7FZXvctto/lwKe04ovYkwnDOAjtu4ZwpjErmJOkx6jbq65F85Chy?=
 =?us-ascii?Q?LbheyzcRO+wzcXPl2urP/ewL+SxokzFMKT2Cyf1bn7kAZNXJbrqZygo3ToLO?=
 =?us-ascii?Q?+y5oJSDIKrCd3Ap43sMLv9+fLe0QVqwUvbBBHaMFQnazKex5u9zOnM+6iJdF?=
 =?us-ascii?Q?Ap08Fcp0Uxki2SzIJ4FnwhVC4Wgfvzz6TarOacQSDrXlEpJQyl1anTNcnTLf?=
 =?us-ascii?Q?mBcA9SoAidiuAQ9iYpCghwbKoH9wDAAsgDCq/nMwtWh/7AGRhInX+WBbHecy?=
 =?us-ascii?Q?pqsgC98RqpjFV5lgcudl3VuwPDweYoIAhSv5nnSfQnOSFbI9tVR6KwUqrLr3?=
 =?us-ascii?Q?Slaid6pFUxGlhH2HUkQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64237a31-3861-4506-1b35-08dc64583564
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 12:15:20.0115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xW5P4lw3hHJx/riuym+ipQlPr7vriM5m7xv+xX4TS5ItLAJdVTipsyA1c8ey3yhP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066

On Wed, Apr 24, 2024 at 08:58:41AM +0100, Ryan Roberts wrote:

> Or perhaps I've misunderstood your comment and there is actually always a 1:1
> relationship between domain and pgtable? But a 1:* relationship between domain
> and CD?

Yes, this is the case

Jason
