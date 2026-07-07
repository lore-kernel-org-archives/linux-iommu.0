Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6E9375F80
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434043; cv=fail; b=b5OS+MoDoxl5CVriofptnNmSmlYAjyfn5L7DsrAQJSL1BRuBvMI9/i2TC/RdcfMLM84CcDBZ8YyIpkfK7wIB/mfGz6yyIt0A+WV6fbnE20GqlufiJNWPq7bCSVD7XpvRy9bQ1R7msNKLtunMcWQe9p4mG9WF7IvIGJ+hWaefEKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434043; c=relaxed/simple;
	bh=GElRHd8tk1hRP83wjbfle9uw+5SdU28J3tizFl9rjVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mcdKIwnZbhVfiXB9EMuVsOMEVhRn4Ba9H4G/k+/0DqsxMRRRW7DA0eWjdb+D2TDAIP1I+fANEuLjdDJMsKgeXp04WLrYuu261gTuoNt3PmzGHNrbb146HokpHwMuhGFstXmC2IWv70tbmWS/k3PDtFwi0ooBj0Tu7MGth322/bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ot/Hhjbf; arc=fail smtp.client-ip=40.93.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ot/Hhjbf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ND5ybzjy4u7gf9t0CMl5Emv5tZayuVZtCjfYWiTcshBvqk3RPs9kz1GE6oBLbht0td7Cw7RWqvyMUZra91Hd37Oqbof5uFj6LqNiHe+nV6RAUJG8uBcb0+UAAUI1n3VUnXkhuilsE/7Rl2AVijJU92VaGEaZKrxHeKaeOvaZGTZ9k/mxppdnpqgBFmRh01A7ftMiYDoFFOCaAvUjcNKU1aZWYTf/5IKhr1DMmWISyEk1xx1x3JzypY6EHszTgp1pklmjYyKzO7PLRyP+ibMdNrHDImcp2GGNJ+dfebgvq2FyLrQPbOnyQP/kWd9VZLp2ijg3APJ3RobklCAnLZowDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSwPBvlZtTsvY3KK+hOnb6ndfwl8J1sS0z7Rquk2DKE=;
 b=xFprcNp4c+miWBPbnKkHcfskdz7kof9uvLvXK81PhGP6p/Hk1H34XZC1zP1ZNubK4qSF9xPkyDKOulCEkWuAGvHCX5jmVqs3vE63xBBgWxMl6+JWWsYrFrKu45W0+TbfSZGqVk9i42I8SmRLCjqBQ7T10ShVwKzNb7UrQ0HnCbzv6LgjsE+MmSm1YR9B2ax7tREgZaTq/swzIVCoHk6QnctuAeqHKjgYwqi5+3YWwzEssoj9NTe/LnEZT/rHSw/gA1S6gOYhSK+PEJlb9kfnqzqK4E3euqGDq6UXrUVMxXp/krdJcFJvIyLMc4c21BgC6yo7rB5OrhLd09HKwYovLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSwPBvlZtTsvY3KK+hOnb6ndfwl8J1sS0z7Rquk2DKE=;
 b=ot/HhjbfP3/HgIBq6Kl2H87jU2u4skJAwjE71Zah28FXmfjsdGRAPeWJJ3XMRcwxnM/AVVcvu0cfy+1bGGmd5guBcFu//BUccDAfEUvWJ0ktE7apu9d5/o7QgmhKIBglrAiQPS8Q0Hg50/FfldDyDlO2Sf9AtcyrF6ILmFw+LbzI1wvZ/gfgYry3d/9M+sD1HsW/cVbfoD1Kl6mETecVFtKTvqioO9MEmrrBOLoCCpYPMwnIAcSA8GRT9zYsHSd8o6y3VN5YbQqRiJbF4cYkF6DJPO48Ihw1X4BID+e4qzf1SHQfYrrl+6+wqNk1V1ZA3weKddvYQpONqUDLkeGkaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 14:20:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 14:20:35 +0000
Date: Tue, 7 Jul 2026 11:20:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v3 12/22] iommu/amd: Pass iommu and devid to
 amd_iommu_make_clear_dte()
Message-ID: <20260707142034.GC220801@nvidia.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-13-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629153535.15775-13-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4P288CA0080.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 9403717b-c9e0-4f46-830f-08dedc32e941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	KqsNfi+zp0b2iAYtUeFiQc6IkuPRq+YXnipJRJLkklpltFyWbDcZb0bajmQIZZJjBZR0Ix9p6xuTt/xx8sp7gQRtIBVnYQfAq3Kqah9vZRlXl8bI0B9j8l/BQyJdoU9t0adyQB1kghxLARjnRqS7m8kFpccC6r6oYNaTyYPVdUA73B77VzcU9GYpc356n3zANF6pDjMVYesKyJOOs2IqGDPQR9539CMl98PvnPaZlQQnXJlHdh7N0PAciluLaPLAiojxmwBbc1bHgxJk/vBS2/VWRJ6R4CHNHFC3tXA5rHKZwCVV5syaDS91WSyaYHuSyy495SHOpqqpQBMmFPTB9DoC6mWyUZ8psJB1bUFZqpBZWrkWBOvmq7GElvlGHY0yUBvtAvWZIcUTpTf3bA3845Ve7kZ6drm8oABeJfOhhL/AFK6dCZn1gSORtJkqUqglOsDEvddrNs/2shytXV30TqxRYnybRe1gT+2cuP6z7MUcs6W7rrb6FBby95k3IU3f0HazXGxAbQEgKSo6WWszM0mpiWtAmklZR9IeMy3aJ0k7wsC93KkaJByhL5d1IHfDWLBdlZy07o3OaOtGeyAChsmGKFXQ+Jphml9WaUq897D6T6lwAgJplaZ/G+zd5XCLfXDRzmPt7cNA6xO3pQofaQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rfooPOj7qCWbOah4tXPSV0BhZ1Jj05KODlJSqMOggKTRyWJX8XcX14pfqz18?=
 =?us-ascii?Q?f4j/aYXVnbq7G8nbaBmKrEQWf/RHNbpsGJqZBnyFzgaHQLGELeXSRt16CJbZ?=
 =?us-ascii?Q?2uv2Kr5ZTySKmiP1SUv6HKr+YhiOSn6mHvReTt4lAl0aJFmHFbtFlWXk2HPp?=
 =?us-ascii?Q?nq4O79LotKA+2sk260bAIR8HMRkrooR3pxyW3WxPItC62/I/LM2zsxB5FqCB?=
 =?us-ascii?Q?Q/RVrUzbDL0+qLuRxBikF7qFbYeO50ZqkSbKZdXv6zTB5b3Fo9OenOOuQ/s5?=
 =?us-ascii?Q?leF6FuVzDkm736SANcNzmuTd+sUuc3Zps23gpaE32cuuA9KpEn5UysvSN6ff?=
 =?us-ascii?Q?zuPBF81O5IjT2488SXsM7nhxuwZMhj2hX4fYIUduruUHkqwDOYvPT6lkIn9s?=
 =?us-ascii?Q?65gb+0uU2rGy9bmKC3Hj/Ok/hvEUxJW8oNaPg4CUiZD430kdf9rFSyTfYVof?=
 =?us-ascii?Q?6sNLuZk5wsnjBrUiz4lfg81SM0ESBd3w3rzA550E/86VHUcK3Pk0F1NCswl5?=
 =?us-ascii?Q?Hh9SpcicAVXPNjhVd3U6LdTE12zHSqAZCm6tllM1d769o8vRTS6jAtBowEi2?=
 =?us-ascii?Q?Vtdm4ZGwwEEEKcP2Tlv5oJ7kulJkDGAOjpg9XmCGkqDY0LbWSxnS0qk2i0kj?=
 =?us-ascii?Q?0opE4Cfo24GTFSd7qAKPfQiwsbsXEPgvAVpTj+6fZSsxltYVwrSsf+7XN9UK?=
 =?us-ascii?Q?gNr8T0yLad+SZcbPKvJFJ+Tn6t6pCmBi8mJQe67mIKHYgYnQxKsxc7xzDRmw?=
 =?us-ascii?Q?dm43Ie/cNabVkkINyb3BhZeN5vPS9U6KyHTNWx+2ZvfUrYwpc46Syy/tMGdo?=
 =?us-ascii?Q?zR5ubnBi31UIS7bvI2e/URDi0xu9cVMlJN8NThZyAz9DRy4QlR8KqytH8K/D?=
 =?us-ascii?Q?T7lkZ2sjAo/fuwDJ1kPRual7hVaep+5kj8rJjOVhUeMUTsiwWK0g0wYmy6UJ?=
 =?us-ascii?Q?JBYHlsyb2gkqjT8YWGGWeHBp2tLT+rdEVTthacFYyj2rRZeDDT2PfMimUpZg?=
 =?us-ascii?Q?urp2VqMx+gf7uVRXzRGYkA/h5kTlxu1c9cQQxsPeYGctcor6BIbPblbq4aIc?=
 =?us-ascii?Q?HilBUXIMY4tk36zMpJhWAOVSq8eLzjrmJuWeI5bDq1AJPhpsvY6XF6bYAxpe?=
 =?us-ascii?Q?5IxRGmiC7kjd1K+U59Wn04xO3q6E81SMoiUatwFpKrqUer6BFotkz1Xer5Dp?=
 =?us-ascii?Q?rmUXGCYYDR3c2uAWhLqPuPp044n3JTk/6nSHIK1SLtQyTq9DKOQyoQb+lkp4?=
 =?us-ascii?Q?+PSoalhn7rXpUKUaSgxNihpidMbGMbLON3QDRNVV3CRD82YgfOVhmGU+r8Ez?=
 =?us-ascii?Q?RuyfYJ2Bjmj1z9y7a0RLj6iwcLirQCjIddGI55FxvP3IU/8ik2g+UBuJDpKd?=
 =?us-ascii?Q?X1FMwPzL1YIPG6Oq+g/m15DRa7Ner+LqcKcXh7ziQzdKKAz9ZiBkcbkEZRg8?=
 =?us-ascii?Q?dgMTEm6yV130vVXTmQkSVHoEMJiNBKpqmP5VuZezTtR/abNB//E6jwPQBsrR?=
 =?us-ascii?Q?Zo4tot8ymj16s/YQQEg6I04mf88++aC0+bvUsX2pPDuWELv0inXlrs37iCpf?=
 =?us-ascii?Q?2TRQ6Jx5WVDy572/9sPFHAGKemKIU0Yz8z9ipgsRsEL7Oo2Qq0L+X8lLTEcP?=
 =?us-ascii?Q?i27Tz+kEw8veTDsqaewdHrmR0DgXH6dzLs2Q9x6gIpfUpgHfu5SaY9BN1mht?=
 =?us-ascii?Q?6TuYlEU64ef8qS0nV9ir+ZIzWqy36u1DeLys+MhfgpV3hURd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9403717b-c9e0-4f46-830f-08dedc32e941
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:20:35.5154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwxxlzD1F6pe9KWLWIB0/qqnuFbCDKyGDv1HyJrtAud0V708vZjvdv7tOOuVp6uN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278

On Mon, Jun 29, 2026 at 03:35:25PM +0000, Suravee Suthikulpanit wrote:
> Take struct amd_iommu and device ID explicitly instead of deriving
> the IOMMU from struct iommu_dev_data.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h | 6 +++---
>  drivers/iommu/amd/iommu.c     | 4 ++--
>  drivers/iommu/amd/nested.c    | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
