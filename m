Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF92076C2
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081044; cv=fail; b=gv76C6iRClouSTuZByP01Nf/qV8UCZpdky04EP+e0Do6Mjg8TYxwDpMU8baWbRQRHyOBHMki24hszPcuEOeK4XH2Alba/rx9gLTlIBlNCqgM+OymO2nhaoIlM2/xzJjVB8TARwod0bkKVjNig7BsuP5CWyCewRXX0u7V37mFFqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081044; c=relaxed/simple;
	bh=ddQ05s2caAsbCQPdvef73ftzZomFBWq2HqgIkEKp9dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rJq9mhj/DkDwHgxqoIaI52Oc6v4kxaNoFdQ+djsaypfK15mGhm3noh+CDw/TA0VqC30haloXhvr6WGy9FXxDaTaQHUazw0f0RwfsmLEsslHUGHxZZk3GI/R6jBROQLIMjURM20Yx7HjjQqqCLPJMsN9QPWqcIkoOQzGPjkk7EN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J1AqNfdt; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J1AqNfdt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVyLtifzK7ZoFVbCsQv1AaiZYig7s7CA1YL+nQS5YtNTkJ1+IhXt/lNdZ/Yty0TCvQ8dJAvcg+EIE5Hz9g6WWJhy24uDCWUx+zw+GMYEWHHvFIejmvRpXtG38GTdIcXOHFg8JRYt5td6pKePhPN75Gv6JyDEGg6PFwronbgbRUXWjg6tLinfciKLX4EG8dztnUaellXkyoV7BH1Hnn6QPOxtwA/5dF5wUjFeca8LJTRlipLgblOg1dNlA1E5BY1pS33hxW7hjscmZ2NrI2DobP/7g+ANszeKSGY7YoM/VCc78XVZE3zgRJbN1d3+jMpRuha7Bupt6NdIR+iwbyQz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrFV68iXVLvTG6pFLOaXIGMZhCQBkWkb01K9KiGeyAk=;
 b=ozsM2MXjlolwXIfJRl4An4GIDVJ/Hhg+AhxCqPgmWd9CSFSPm1zb+mTgMySo6fHKzE/t1mqBilqRJ+5TE+75Xo31ZFx2OX1EQe3k4/Chc32+yaT6sPtdXA6fXMNTN6uddsUXIqxK77EeZSd5J9ngek07Wr+WePEuLXTPCjwHoyBx0VLGuK5yTjlFHf7pmpEU2MzFlKdMWuv8s5NFRgdmlo8d9sbPOcvsLaOO84gi0eGnVEOvd1iKinSiIClOKVeV5I+0tR//Me05/rrweaEmCa3l5MAizImYhaEsZW97L9J0oqMUR6F6k+uOIkU1T9il2RHK0blOzvNG4cT/5CK+Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrFV68iXVLvTG6pFLOaXIGMZhCQBkWkb01K9KiGeyAk=;
 b=J1AqNfdtSr/w775ib6363zw2Vc/tgjvwxOu7Q8ot7ztgOEANQpnd9rsN7+I2ZtUFdbUF0Um+hzaCOpU3OdKsECNveRP9F4xUFNQwBnzo9YbdNKJDweZYa6xwk7t6PwYGn0pS/JnAo0y6QiRQb1etSyhdtFlnG4cDLSvw2qhTUUMZUuLijHS3W4YCPITCaswLsXz3WVwqC58zsCaVb76TdojeFPOAiPL8s3lXVYL3tfNDE7GVDifSU+LIh/Vktie+lGtLPRbXc8JA5LC0olR5o8SGNdFlxK6dudO0XivL0yOsxs990uw2ZPDGi8Ce3XN3RyhDV8rINobsV8rTHtwFsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 12:17:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 12:17:19 +0000
Date: Wed, 16 Oct 2024 09:17:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 1/9] mm/gup: folio_add_pins
Message-ID: <20241016121718.GD3559746@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728067700-32092-2-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: MN2PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:208:236::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: dd97391f-a3e7-4c7a-aaf6-08dceddc7b4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dem6A3SfmQbFUVtVgeG/JniLuIyFAtjn6oqFeXjT0XzicEtTxXkvW4zFTG6B?=
 =?us-ascii?Q?7obdYjfCwAiYBmOZyKM/JLMaQbT3ydhrT3p7SJ///Lk3jkVI1mAncGCwNNL+?=
 =?us-ascii?Q?Tx0ZkmZ4UVkD2wWf5RCBORocGAPe8HeBmpOnzPt20ZFVOiPSPTUZNRE+KDTp?=
 =?us-ascii?Q?W81Ii4Q0jtmV6P4tQEPrbaiV8ypB1NpEG2+WenzV/hemaL3ROUDOQPAwRSRk?=
 =?us-ascii?Q?0+mUP1ejK6G8KST315pr9GSyqc/YfuMY08aahj5JaMt3Thw90aLu18w5lcUk?=
 =?us-ascii?Q?vtMvfOfIqVlJP4ETUl3Ad9Wp8ZNXi2g1VKUL1mkZRWv/FDMNVsEA7NL0qNFP?=
 =?us-ascii?Q?LkMOq9xtgt+62EXlYJtGAjDTG02HSTGa4aCKUZW1SLPwBCmLUce02h/FI2y7?=
 =?us-ascii?Q?2I4uVDDXxMKwsRsilPYNkgG42cpl/lF4cYMAbop1mOdn8DN+ngiaQmVau066?=
 =?us-ascii?Q?KQVoRjzippCIJQBR7LNCYTxGyqDT146SsKfZ5K4skQeDWf7eCkz3S/djyZfM?=
 =?us-ascii?Q?m+CMQrtIQZlqiDe2j4M3goTegoo27JDIdGoFNCTsJTcHTTz8BuOYJFnBwghK?=
 =?us-ascii?Q?Kj/Zyl1qGfKTizDjsUCurbSU3zHDoYyWT7G0NgC0x0d5DYOINGx43atq4Jop?=
 =?us-ascii?Q?olvOC1LlznHda7UvSYXog7zsQnb9EPok1zjEN6TCwApc5QycHuQnTP7YhNm1?=
 =?us-ascii?Q?WZy7X69jkKypjWeuLVawInkxDqegZ2AhnTnI+14ZpQDihkkMwaBYz2NYl0Le?=
 =?us-ascii?Q?OdPDSuSSYnGpjOh9FpnWa9GZVQHw/+PnK2DlyXzCxY6QC/3zuJJCGTCm2gfw?=
 =?us-ascii?Q?SY5Lj/xKh6IVcduQzYcoX66jtLOybodTsHjqtYON/ABYy2nIx6HPZEck4/z6?=
 =?us-ascii?Q?UxB55gSV+qUIXdT1NMSQwx+AraYEGAZHiGOrnXAWz44iMYGEDGhZkqvHkWGu?=
 =?us-ascii?Q?/zKZSFJvZMymBIOLTnbYSrqQ6lXHYZ8ZuUHtPCSbnKXbxNx5jSGZqEPa1UbL?=
 =?us-ascii?Q?Bc+iU35jYVhGPB2E2+1mFBUSvwaxo3IeZWMCwLvFHJNRtNVwmSdAyljeIbwQ?=
 =?us-ascii?Q?md2swQCL0/W03bPCYlz6ywHEJUEJaJc5nf5ypAdCAr22YRDf6PCHaJQfZyPW?=
 =?us-ascii?Q?CvfJFRQDl21ByNdCd8Znn7bb532gN7E9nwKLPYmHX4yFpIZkpio9AxM7IFqH?=
 =?us-ascii?Q?SBSB98SIuPZd5HYYlixSNt7sWkfR9+SQshlnHb0q9fwdvIkvST5VdDk/XzBD?=
 =?us-ascii?Q?hk/j9S4rXTX3UZZkRrVktM8Oi4zMFvgpOB+jCId3gQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ml0902imPKEyws26f++1V8cSO6gYKO/AQubiJPDgdiKPbdAGLlmZtZf5s+vy?=
 =?us-ascii?Q?WRLmbj7m6xdtsKof/xFsPPBv8dMfmG41O/WbtzOy9m/bXDnGuCkXnyUKZfXy?=
 =?us-ascii?Q?WytNgXx4qPGZ0TNfqq1j8p/jrGB7Q9GIXo1T7iWuD+i8lYhgI4BxQ0MSHk9O?=
 =?us-ascii?Q?BcaoobjmBdpWsCFoINNMImGL2AUqgOLCu8v1kgpIe3fEhBYh0YpEt6o4R/9B?=
 =?us-ascii?Q?grLyz+CJGU5efLCeWokdDSnALRspTN2vM7ogsLQ0+yDkaP3qPvzS66rxxnCv?=
 =?us-ascii?Q?3mpe7/m6+8yGdGpJNLtTIXEUwvOeFlA/jfFqXDYiDvMTUfmjoA+QGFcnc0Jq?=
 =?us-ascii?Q?U6QSwzc4u70xa+eRRYsiQ7Ttlu58J0gV6rBro77FZ9OlzuMh/2xKVconJ+LO?=
 =?us-ascii?Q?YVz73glWJAWSdQfpJuEl95401fkFIP95dhkr/rwoeyR8MQOxhGs3/TtYBn89?=
 =?us-ascii?Q?qKF1yAYZxemYrZBBneF5GnC8DhYgJ5A190dn1ZAtpJNWOSbbDYP1swgecPwt?=
 =?us-ascii?Q?HwSjO2nyArEjqe7ZqCmbOKfBmuxz0ElBgRf8PS+a7K50GS1gYai0TpvmAuqw?=
 =?us-ascii?Q?w4jB94QxZuuwmhD45TZkd6PmDkPUJ9u9QsKBVAOpxfFi0bW3Uwj6beaKEaHI?=
 =?us-ascii?Q?Pzx0EauueyC8fozQtsgo2hCSnYhMyaXyusx0vhQ4x5nFEgvVBjTULE4PXdZX?=
 =?us-ascii?Q?vIuhK5SFaTIDeWMc0HancQAL+Iu/8HTwV5GsyhTL5w3HI014Y0ZGHzINsHKr?=
 =?us-ascii?Q?1Y/J/E4KS93H3+6OvPSsu8vGk4Ve/tTTv48Rucy+5ZDkKP7Wr/6DsTFdOqBQ?=
 =?us-ascii?Q?TBabGaDZa48WA1MjMWmDoqk8W8uHtuyQ0hGBFz1Zj4sRxaBcXw65dpwHbMpE?=
 =?us-ascii?Q?AyuaW2NOb6c8rSRh/JzPC5oHPAiC0ryFVfjKEWuu2XPPn3bvyZOvc/cryVqA?=
 =?us-ascii?Q?YqP1a++RCnQr7tECbWJpz/4rrjJGbCMq0zUqLmvud/9N334YiEEDTR9BGi3u?=
 =?us-ascii?Q?f2IV/oAEIhd8oWJdNZYeRH093EYlwe65+SmzZgefkX/d8Izy9Y7Gd6OcTsA9?=
 =?us-ascii?Q?HyVZnAPPaXhnNazPAOeuzl5xoPOBX0Pc/tLOUd/Z0t4fUvX7YeqxMTzuIw2s?=
 =?us-ascii?Q?GChlYTY+qNdrWUDAjYWg74JybUr77Pn/zIWcyyc4YnPkguvXegouxjMwjuGC?=
 =?us-ascii?Q?vsqRNX6P6Nr+u/ieF4V0Z1YkZakzsWDVzbb1Wq5kvBw6GsjST3mm68lNNSA/?=
 =?us-ascii?Q?G4qhOBezR3hL+GbkpJyVi4v7JoLGF+jagzK2M7ojoiTNag+KjBAdF9xPJCLL?=
 =?us-ascii?Q?0QevMsYbZ1LWZ2EaSAOX4wLGisBcLd0AUnb7nVFBbVnxJoKxDixHNOBikqAx?=
 =?us-ascii?Q?9AfHwO5R8bpwDQgOb/Nfdpl1El7DeoA6wYBWp6BxQbMWKRHIIHM84BzJoTjA?=
 =?us-ascii?Q?eLyxR5crS5q+j9x3BSn82Wi1NSD3Vy0zIwHZShK9rJ0EAfWPqcmFIkQzzjuc?=
 =?us-ascii?Q?/wchOA8609GLVd3OyeF0jOXCyzSlQoEUemAXWrEKtwYuj6BWymRZHZ5N7Tlt?=
 =?us-ascii?Q?EXmsmKJDBLk6J/IBwMI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd97391f-a3e7-4c7a-aaf6-08dceddc7b4f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 12:17:19.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OaZsXi7dvBzcn9vvkPpOE7+oIt5oC4NEdPbb3axZZLY+9nQ8U5tuO+qKK7icjwy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101

On Fri, Oct 04, 2024 at 11:48:12AM -0700, Steve Sistare wrote:
> Export a function that adds pins to an already-pinned huge-page folio.
> This allows any range of small pages within the folio to be unpinned later.
> For example, pages pinned via memfd_pin_folios and modified by
> folio_add_pins could be unpinned via unpin_user_page(s).
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/linux/mm.h |  1 +
>  mm/gup.c           | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
