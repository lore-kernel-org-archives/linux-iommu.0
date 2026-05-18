Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012061.outbound.protection.outlook.com [40.93.195.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDC138AC65
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127921; cv=fail; b=h77EEDscIKGGBup1AtfCT8kGQwVwH9AuS39n/bEpdZ8o9aFmGkiPe4QGqGkbFMzuGVrAV2MMVXRvUnSSO6vHE37/sXD7UE8qQoRtWQyJoWQSgcaSLWvM+DSIYQV6nWd16f+qKkJgZMHIZZflVplSTz0tJrP8gso2Vcun1ES7mWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127921; c=relaxed/simple;
	bh=HaA6MR0KBIu5coYQZ1ji38E06LXsqYy98B8sOUbrM3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tpQtZKwa/wi5H+QG1XBt2xg9QoXVcq/NIjeksWhgTgfJ/2rBeSJmUFUBf49yYDwq9mw22rNt0wARf1Y86uZdGlANbnIG0bqnujbreLPBi2mLtgJPK4S3rlLCoZ+jMvAIDvK2H9mPThCcchs2+/eDzDiR/6RAwKgRl26GdJKgnrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ib4GSAPw; arc=fail smtp.client-ip=40.93.195.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ib4GSAPw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1jdtfvTy+hUdfsVBojvkMwqg5FwzbfPdnL4ZQaOTKdyqYTCR5HteeVRHUvL+1ERcD8hQRltPsthuXHfglzW9FCsForUS34071HvKzk0r0S+hCsUzJ8M8H0W2sqf2vrX8r5A3RZ4LIbZa0kki5BrYPn0s5rhIGYBVJ2HhWqlEXS4dsDOLgqqDWSiY7Fxlb9N4xLMRyTqVslq626gHWx37fSyqQ1TeLTNBmjMWP7PJVaGcKBt4Guzh/6qrP5h8t3MKoW0aeMb+FOKHfW4BQWaxQaVeDygMqJwz0rugHQASQrTlhPMXs7pKDQJ/6blaUgTKSATtw9kZEPfuMOVn2q0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46JIqYWxY0Lx5Ih4L++Q3NwHtkhoLtJfDsNbd86e2xU=;
 b=nZcwfL6iAisCGUsVgY43dJZfscL1k9MVqddK8+TAB4HUbLrmTXXhYdSWAmiGuTfDhzVK5OI57i10x1FVLcMzviWBMd3n5ooM0MKrHkoFavuGsGFjXxW68MOiR/5lKZwNrKX0BRF8MX8pIWgCcjEDHVWycKJY7JEsguzRXoGnqBV59jiQ4eJAgVhRNSrf5KS8Q2OdomEqSF/gVqjz+sjv+voXROKHbUtmDvQHElLlNjq4l1/U23rLRZ06568z4M9i/qsAmQT2f3eAd3bvc0FXtxuThFf/0w1G/5U2kebGT3P97uBdGtQ4nrITDqOlWWiiF/DAU5pE6NEL3eyo7MIW0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46JIqYWxY0Lx5Ih4L++Q3NwHtkhoLtJfDsNbd86e2xU=;
 b=Ib4GSAPw6lhQ3pZ0GrkBtntqonem696moZaUpBCgIc3l0IDV/U36J+6598oM+2QS3VBqJkCJBXoe5e/RlYZqn8U/YU3s+3ODH0MMiwHW9kN/Fbj1MH2YCEhaowkHZ8kDW4vqhYrNONxpYkYON3hIYbRzV70Phdm5LvthK7gxTM8OZkHEED/BFNl8zVzd4CFFVW2zGs/oQPmNDV/30LHwyuelxMTS+zOyU8vTzJXbhWHFQIVbMlRK2k0dQ8B+4XgsD2oqUwYFmhoBK1gPNNw6wUibgPJCX2CXjoA+MNZuvByeqIpfieV6uHet/VNcIpUM7JLfoEc3jbeH4FlFeehRGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 18:11:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 18:11:54 +0000
Date: Mon, 18 May 2026 15:11:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH rc v1 0/4] iommufd: Fix veventq_depth boundary
Message-ID: <20260518181153.GN787748@nvidia.com>
References: <cover.1779070992.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779070992.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0389.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: d39a843d-776b-4ec2-ba0b-08deb508f11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cljrOWJxiPUcfGdZt62USbNPcSWCveD+f8UtYIzxCHme9E7KTTnM9y0ECqgBvEdVm52Su4RsbD5CG7iY71z5c/Jj0cCmamsSe1PjE/7rE1jKlSy1i/Mon6eB/oDwNnH6Ow01EZviipC/DAX1zrUhRTbseV2tgWQxuF2WwYYU29AYYbQMSiKoE0oB11s8C9dofjoGbcPTWaRIeiE8s2l0ZwBt3TLgKXZWkwUQ046pAQpsQEizBqjD9mt6pe8aliXCeM8pA1uhxpYKae9HkKPWUYYSlzggLPuxKe7YSvuh9XqO+SBiEGMJw4ijY/F0u9T1Ix6YE/mrqsT8NRCTnegvNg5NL+C2+xM15GKK3G3HttcLu0U0GetMTSKoa1pG3P1haPBJmw0IGbaECYSHStT3V6fDgbfZxjadJweZtAzUOLYIJ82t3MZJl9nZ74Q1bmS/JaKPi7SH6S22LmS/oUVe+k+jEImNNj65McC6nwY/V5WTGRNRtM/+NHSqnqGhCifwgGh2Z+qUeE1J1Uq92tx/HsVa8lDeeP30UdJLfVYB/JfenUDI7itcp6BpNt6ITuXX+pvdSvJgIuQbc+0nQd73Bx3fD4YY9r1Q8PHfd+lIEL4uj/70FE49yCCVp98d3NGtqMrXH2VDsrxfIWiJ/17i6rMFep1rHdJFWNoSKjowXv8ngTrGizrebdAifcxV7sU61xadc/ZiYIuKCkaLNLj9ow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z7/bQ/s9eCYVPPCpsLttLSz9HEAXruqImFcoaUZlBjyr1b2oIo2s6xzc76tC?=
 =?us-ascii?Q?UR5rV40LPbJib2KcfZzQnt555DXS2LY/bGB8VfidUPqRA9k6XZUiDzoP5tE+?=
 =?us-ascii?Q?pdolU7km3Qbsoa5pDHieSd9zThoXUj4mA2XtvN8QauUQ/jLllYzCPRmCNsIA?=
 =?us-ascii?Q?xnnT5GQYQu24eQQ4HDrWLHOVu/mqgWAk4Wh98i+JKBZVaHCtqYUjQmrmk5Al?=
 =?us-ascii?Q?WO4IboDyUDPa7cNuYfo5kjKow3HtHfyA5PQ8pyrs5GMdmEnoDCiZj7z5/sCt?=
 =?us-ascii?Q?cm5syVrF6Hs24ntniXJs+tcrl3SGpEHqXXb/l7RtWpUFDU+vXqixqDHEeII/?=
 =?us-ascii?Q?LfdSlmFU8/h1EoYtfsHaTZ1WDAAXjcgs0nA7gmuY0FyqJOf2tBdSC7SVDWzP?=
 =?us-ascii?Q?kEX1/RtkByBV8iyCcTE80QMPW6CQMJ9QFBnLwhzrg6gWeXGaX3E20Za53oem?=
 =?us-ascii?Q?HMizdVb0CEhswQwnw2+aA8YjvhAI/NP3nB1hsDIOuHEXrXA43EiKw249oc65?=
 =?us-ascii?Q?1c0pYvoBoozlOFw0TfjCegzyQPoTkSxehNdx3phx7goR9wEP5N1PLhlnM/lR?=
 =?us-ascii?Q?IlO4tQYSo8lD89ST1Gf3fPbT9kIsTrTPOzRHvWK7RwemzPwFoQZ1+oISAQqE?=
 =?us-ascii?Q?7AGOgB4Gl4wfysMcMDI4OtAwlJQu3tn72wC6iXV21k4KOez02KEWxHSOVSqi?=
 =?us-ascii?Q?O7glouxAfCr06rw3ltKtH5WJVWH1GPWBYgzvxG0L34I60bPJ2ykWMMdq7zwb?=
 =?us-ascii?Q?k+ywapsSfSP/0mTEY/7IAeI7m9N32PKTvkl3Mevimf6BednkjbUB6frsp/pR?=
 =?us-ascii?Q?FTH6s3QcFZyUIc1cqRqji/E2PMeBhBO+WjD8x3hbhmcxVGPNt4u4zC+33LVH?=
 =?us-ascii?Q?klSYc/L/GQDya/TKkxDwknQD4rVNBeryx7im7o43gGmolMzNCD+agkyF8lbb?=
 =?us-ascii?Q?v+B7AAS4hFGH6Qw0MyHWJmYBt2hNozUDyP6josDw1Eh+LTda4uD3sTJ9rWZ/?=
 =?us-ascii?Q?3UB3ybjEN/ze4M1ZSDPaiQAThkXthABWYpGsTGaianlV6Xgjqz8/Z01BmFAI?=
 =?us-ascii?Q?sx8oMrzuVd1WqrAN1TEuPgj0qvq82BwI7yUU6XhIEnKMKgwBXaBfhjEaQ9UI?=
 =?us-ascii?Q?LUc0d2JmR0m61Eaw04MsHXM6HFhrOZsqSATXGJ5UTum3MuBNsA4vL+H6jh9w?=
 =?us-ascii?Q?xuIjHk1oglQzbAhtusFPy/XBsNmW2Y4lO7ABZeNZfByaG8nsKAglU+Xj1KzW?=
 =?us-ascii?Q?uyRqlzPqv4xx0CMMH0tfyFuycy2ulQPeGLMkPcg0utqyOZ7tZADx6jbcLT0F?=
 =?us-ascii?Q?2zp19luTRDc3rRi9cnT7LhT2Avc74UygbFKO0cqAk5vOJXuoja1qPzElUAEX?=
 =?us-ascii?Q?QQ0Z6TEUF5aFjc4NoWUvfTcsNU9L53GGfQZQQ4dOmp5Yoik3/QwjUl80bP9f?=
 =?us-ascii?Q?9gcWf1Irwlj9MBADjMorT9CV65vSMWEDDpJEZFVWs4JcenGVcv6hunmqzP6c?=
 =?us-ascii?Q?9kNJTgse7GZe++tP+U2U8o98sVtycJSO5otol17g7UahvXv57pyPtnZacjlE?=
 =?us-ascii?Q?62zGk7632/5DIqpwNYCVSxruFjasYMsdc5bodP0kpCBGESKS6EAr3ovTzFKK?=
 =?us-ascii?Q?pUQfGlE+D8UG2djb37CBdywhbV0Zi46hAyw4Je50Umi6M+yMtKJnwGSG2K2I?=
 =?us-ascii?Q?kINBSdRpJsf9IMBL9aEw4eW3yKdyw76n55KwvGc7aZDbq6pr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39a843d-776b-4ec2-ba0b-08deb508f11f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:54.4938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5iIKek5O8ivnWSTnkZxIf8UGTQ+I2z0wxeKBtjFm1sQTdmafm5NfwCOq6ZdDg5R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847

On Sun, May 17, 2026 at 07:28:45PM -0700, Nicolin Chen wrote:
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
> https://github.com/nicolinc/iommufd/commits/fix_veventq_depth-v1
> 
> Nicolin Chen (4):
>   iommufd: Move vevent memory allocation outside spinlock
>   iommufd: Set veventq_depth upper bound
>   iommufd: Fix data_len byte-count vs element-count mismatch
>   iommufd/selftest: Add boundary tests for veventq_depth

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
