Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859C1EF087
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730999567; cv=fail; b=O2KDj47y3x7XawT2d/g+4p6nB4Za53cv5iF81Iz6gwDiRp4nhjc4BeZZd7TW4jaODRII8USmg0napg/qvOd0eT6N90FeBw2N+2za2TlFYFRu+0g3JO2kVPIux5hrio1FNiVRMKWeqrq3sIAB4Ii8UHXTjMN5JRKZwxaMDitNa2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730999567; c=relaxed/simple;
	bh=t+lpoD3144d/0924cGE9UwIqrn9yafyZQul9rNKI5oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V0LYYXB1JovM3WQAsMN/6ZiT1s0D0LMcTHUHA9C51egcET8rG4t2DhlgdFGT9JXkRhVP95n/TmPa+vjWmyaS2imw+hvn/rjbxnGF0XTK9QG8gP3Kf8aCOmbkKy74sHQTAzJYP3oPd1znuwdiY9jCbuxYImsdCa4TQ9WezeYjF6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zy+yXrSi; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zy+yXrSi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8iyGd3x+0j7yRmra29P6P08WHcLjEPwUtY6zneymoUFbPkDSWHsqn0sXUlaTQBjyQIQz1NrMgDjEJ9UKRR5XNTt901OVf1JxCWenz9imbCEfvNsxS/ntKGsCPNWxX8FZj2A3PdIq3Mux7i6pwm1/4S30lcwnxACq7ecXx0HiWOfeWEeYT79wCugIXEsRCxL+MtkQgG7zNOEwtYPLtJ+9A+vsiuQHsgq1hX71FEDRidhxin0Ki9wUlZC/KlDr0mAhXwM8fFbGlxDvQelQdC0p1P3AW1IlvCCRuwkvvi3h+AG53pBZlyj2e3NOsnnjJUCY2IOLQIk/vh6hLSgwt/WEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udFC8v0Bf5b9gGwNFNn24f6p4ihimGb6fLkLJ/a5Hqw=;
 b=B2rWiGsmsu1ZeeaJwq++eyJ2DYGmsZd9DrTDVgJLAkRzEtV1nRcYzSYKZ1mOZGX07hoEO2f4tiIdb5WcbUavyJHlQwhUNDjxZS729PYCnuw7aKl+YVWrN9kZFrT87Z/9m5p9/LToqjvBcW5ghIxSy2dSVDS/y3Z6ee1/sgjDkt49kB9CXM+VRDXXEXlbwdDllfjUi5dzRGOjtpkjDiLPvlaI0SY7InjIMeKwn6QLBixsluzoInwLGhVo98MmA9tsPxAQ5+PM98r0fmLcHsq2o+3X/6Pm5FfKDge8aQHFt811/C7fxQYLMMcCaWgFQOXrMqhwsn79YTwklhl0N/UIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udFC8v0Bf5b9gGwNFNn24f6p4ihimGb6fLkLJ/a5Hqw=;
 b=Zy+yXrSidxvBxzVhbDpNcUMom230gHd7q1BrJe5G4Oyb91Y1vZT/1HIxzAqm7/Z3aOI/cc6cP81WtzYVe7h+f6AIONaliwmaYLzbB7YHlK8UTyVi96o/SYn68/odDel/8AKbvx6jPuRB1rwk7jmy+LmZjrS1LYndcKkel5ZNAwlObLaix85rLKkgdQjZ3mJV+9cJFQYMYQLoYs1g0kYpOrdtfhbAFpShxnhfBkzInZn0zFoNLgnWEp9eyLxQoPtQ5c4d9JBn5dgvHTnoI/WOvh6Ok1vVlN2+LNZICUAnbXzut+GhaXxJLrX8a3ry1SQ30CYOl2AnCHPzZK5i4pLt7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 17:12:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 17:12:38 +0000
Date: Thu, 7 Nov 2024 13:12:37 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	jean-philippe <jean-philippe@linaro.org>, baolu.lu@linux.intel.com,
	shamiali2008@gmail.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommufd: modify iommufd_fault_iopf_enable limitation
Message-ID: <20241107171237.GA539304@nvidia.com>
References: <20241028113209.123-1-zhangfei.gao@linaro.org>
 <20241107043711.116-1-zhangfei.gao@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107043711.116-1-zhangfei.gao@linaro.org>
X-ClientProxiedBy: MN2PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:208:d4::44) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BN5PR12MB9464:EE_
X-MS-Office365-Filtering-Correlation-Id: 664d7d77-7e42-480a-4652-08dcff4f614a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iPvwpD+P/BI05rKyMNXUCkNLZx3cRO+rLLwC+KglYgdLm+uLYcBkelgcd3uU?=
 =?us-ascii?Q?598G+2o0ZwJPnlp7NQWvbzvK2Y6ekyAKtcg4hruQOLNd9fpiu83LZKLI8c+f?=
 =?us-ascii?Q?PYK8GvJQw3MTGgSM1RghHpTXq5gU6iEYQ5wPedal5TK7uE9ElXIAj2GgjE4F?=
 =?us-ascii?Q?5q5ArIiSrJxfTh2Z8JrkD+kRPHxr96MHPxUFi48HJ/Z6PyEF7mNWp4kpj40L?=
 =?us-ascii?Q?x/6P6+pSH5R7LSmmVroElzZFnnKNB/XjR9E+/HziF9Fh9lZzWW0iTYKta88B?=
 =?us-ascii?Q?M+ZTnkHze8WO9ZfEyLL/MCSkBMz02X7iJqZFkLFq1Jv85lfkNvLUd/vuvP+c?=
 =?us-ascii?Q?JbWGCi4iJfzdQkQzeXasJHgTc1cw2v9gFHpbzknsjI4ijwclaX6m6KM6CQZa?=
 =?us-ascii?Q?vPqnM+x93CdS7WwpiOIIyT9wW83XcxM+6uZ7bOcxjdvV/uGtXzlb8iocfOCS?=
 =?us-ascii?Q?gPPUHup5pGf8X5Y/JdZuMU5FSCc5XjECXl3FulOy7jEyi4im2JlXOM1655wG?=
 =?us-ascii?Q?EcyXQWZ8K0J8a7W/Dzi+VuV/69gKTE6eScdOuqa5JL0u6Uq4VUoEkc+ST+9a?=
 =?us-ascii?Q?fdXP/mP7HxqRuzFJ7+okPSL7mSbBuE8j86IYwioi1bOSbWoaTT6b65TCQJUE?=
 =?us-ascii?Q?zxN4WZkFDx54oWwdk+mdOCEQ8NV4AiEb0We0UhewigsDc01FLJi9sFPyrbqi?=
 =?us-ascii?Q?OGsba616mUXCEDQgczcxW0g89RJSLiSAEoAt/9xTmS353ydpnoct+IuMaUbX?=
 =?us-ascii?Q?XCzat3JSkMZjwmGP8wMGPFXKF9LntqDYT0Gy58aEQCpFS4CWVz+8sag8L9oW?=
 =?us-ascii?Q?LJSnaPR5t2V4JKhFtplTKNsxHwv/x1kr35y93l80N43FgV3vT9LxolN329cz?=
 =?us-ascii?Q?abc/9cadBKtaNrPPydYNhz7swB+hSLRbJpFFgijm0AzrdEzn++kkyRzgf/P4?=
 =?us-ascii?Q?tSgUGXwGC3J7w0oxsIsF5s2WeI2x2Ai8hpnQH59i4I3ZN9VEhwlFVMBCFjkT?=
 =?us-ascii?Q?jzB4z/7h6Hi9KbKBn0pIFtmZMHRq6Cvh9FCXVhjbQO5J+QeV/slgevCfeBdy?=
 =?us-ascii?Q?1pUGoJhSscDZQ9yaXLfwspVVGCRYtR8x6dA+cQN15+4z75CHKk/7Xvq4M9TT?=
 =?us-ascii?Q?sM/J6khINyHLcvFMNU4MscsyfSodoU8PYdD/6r2dR78TItnxCWnndRu36zlr?=
 =?us-ascii?Q?QoVjx3pUBOzsGP4dtc/T+RLoTZtoHeLGyJaaf/c8poYaaRbTGr7rgYYjtUZf?=
 =?us-ascii?Q?VFKb1vCJvPpIh3pt5pNXOuTPOrOijiX2wUGWeuEEr1TNGlROytorr3r5TmS6?=
 =?us-ascii?Q?hDni4+Yho1vLYykZA47RMfNg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5eFsLSi1pV3bD8iJm+kUMeIgs2GtFSyhYNg1zXXHacVXJ5YdXihu6ZoM+obt?=
 =?us-ascii?Q?0Byaw6ewNQs9dcdICc2MuoP7gMwLkXJuBFwVNIRJ0rLnQcSmZUYOYfdFmB58?=
 =?us-ascii?Q?sfhzr7+RSirr21ipVBTP9YlPA7oVvZMmpKq8eylDNTHLi0JgHobMqVLXnLbx?=
 =?us-ascii?Q?8V311f/J37H7wKkTBJ1WLr6m64y3Uocb5DrlNEH9Ih6H273V6Z9NcT7XHAKd?=
 =?us-ascii?Q?xysME8X4/KvdM2JLYiGegt0KDWTfrLN+KhuS+3jy8U2SMRkVX34icLbRQ3ji?=
 =?us-ascii?Q?L1DQb1nR4jJBiKO0EMB7Y8nnUU//qNkFxj2XUd9Sd8J6qqobeZiiHrC2xl0y?=
 =?us-ascii?Q?+xlyu6Aux+XuMFCCt5UJUf3ThjjzwjMiG0t+4ZQZnPC1uyvLWhZRQ4HGv+K4?=
 =?us-ascii?Q?gS3Zjp4x2i54neJP+EgYzTzJ76Uqpn2A1CnQY9xSqFi/OMN+MRchoSMAttYe?=
 =?us-ascii?Q?UCR7zBuL7ENIRXCVbkeV7JqXe0WQoWwt8Z2irEHQhd3H/tRT+6MGMFNaeaE2?=
 =?us-ascii?Q?ViKOQ746AOsobotRfqKy9MUQuvMqEhXZi8yjsAn4QysYgh36mKlXIwc6R3hU?=
 =?us-ascii?Q?L5F33J0y9aJP2LLGj47fM7I/rUk/Bi8qSsIjdFzCrpdtD+9olyjzC6s96xjm?=
 =?us-ascii?Q?e0wEhxMfTuxyH04RxoC+ybIl3zClvNbbL1sGt+wD383SGjq/s7HQumwbOlgA?=
 =?us-ascii?Q?UcVLraCHqCNS5cgSn301aH5xIkj7uB1F6oIfUTXUg3asuN4zJ+ERSbvu2xtZ?=
 =?us-ascii?Q?7GkQqm276qfbgtvqbYZSUYLcqyPO7WxKMZq6uSksU7/a6LuVx1MthscgAll1?=
 =?us-ascii?Q?p+QeDm1KZMcRlWOA0DiildLt8rjRelE/NdOj6MWfrYwnWEcIXI6h9o/hzr12?=
 =?us-ascii?Q?rHD0DMTujc/oMQxhmyzyeHt65g/Emhvr312+xTta959SauzA57byjZdnn61n?=
 =?us-ascii?Q?xgMtvk2bzfGr3GboKX0HzWEBxAAcpX9T2GhANydx80LvfAFTy0sHhBYrRUfb?=
 =?us-ascii?Q?1ZqLbMEROihPBHOEA8P7aSOg/MYhhJPO2NrS3KH6Id0JBfU+cCUYsrPoM8LV?=
 =?us-ascii?Q?xJatg0cmn46ix0LJhVUZI+4kNGXwXJ1AirwoJYxsBB8id1r+gNHY3Q22iRSr?=
 =?us-ascii?Q?C1GN+kWB84eBUd9nNb7BoJwIdUD9bS5M/S+eTqsslvOCGIzBu+D9/MbF4H/3?=
 =?us-ascii?Q?mb9MSpahcrXsquXnzkLiceed16toATaQLmNdEVfbK+A7OuSh7Fo1dzwGSLj/?=
 =?us-ascii?Q?XRRnXSuQHfd/EmLVUZyPEwtlNfqrUf9fjSTzz0ceBu1po4zcyYUMrx9BpCFE?=
 =?us-ascii?Q?Fi2toGpU7bTqmfDce1E84loGcbbvacF2vUTnO3zdR0+rOkAipC+tz2rgBp+M?=
 =?us-ascii?Q?navhCiEnYdC4eO1UTHzu4TFY3IBwU5Do8kCpP36xJzLDSVaMu4kmSuSniqC+?=
 =?us-ascii?Q?MsaUYdNJIcWwxbjSCiFWBi6B4sc+jrdDJNOKQ0v0IyCF8gT2BuWO5nWwPDq1?=
 =?us-ascii?Q?3JPbppkHM4FDNYnAtCqUBcoMWH2OeEIUzd8UfrmmtXDU5Fo26ykzlf8OqPO5?=
 =?us-ascii?Q?NYwPTnV/2mV4tmP1YGSE8QBpHInXrB1snZqz9ACH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664d7d77-7e42-480a-4652-08dcff4f614a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 17:12:38.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //lg+g+WuQJr2ZCy/8xkTwrefd/N2DF2O+JRVP7Xzg2yRF72fdTVH5D4e5kO17uN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9464

On Thu, Nov 07, 2024 at 04:37:11AM +0000, Zhangfei Gao wrote:
> iommufd_fault_iopf_enable has limitation to PRI on PCI/SRIOV VFs
> because the PRI might be a shared resource and current iommu
> subsystem is not ready to support enabling/disabling PRI on a VF
> without any impact on others.
> 
> However, we have devices that appear as PCI but are actually on the
> AMBA bus. These fake PCI devices have PASID capability, support
> stall as well as SRIOV, so remove the limitation for these devices.
> 
> Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommufd/fault.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied to iommufd thanks

Jason
