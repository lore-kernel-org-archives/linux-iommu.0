Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABB01EF398
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756334; cv=fail; b=JcLnakToRWcQ0lVp1yxhuPpYZcqJ4VGI7cXljxz/T4LsHbvcvPKtYgMMJICiiXUxpZBK2clkSkpBK8hThOH3sQz6SIb6nNo4yxFBDmpGXvO0qXR5UQPsnfAsB3BlN36aWwpoXcfpRe/3fd0ZNa8J54aaE56Sm25DA2bjCOgg8EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756334; c=relaxed/simple;
	bh=TMcCgIfMdb50PB6dbKYLjEUV6w75P0W0F6BHsQ3FHBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lcKgjy/yeUItd6IO9cazY6sqrC1CzhDruGw2SHYij+yLNMTui//7EWZ/eNb1xkSWWNpEKb/vZsRHoRY//OacPkCGYgN9VpFqqYld/9UBb82fgoAR7Dhc0ReKX4gTX0fAQH2DEM2Ps490fu9sbAoFP97dcsqnLq/xf/SkLK+pk8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HsU8CMEa; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HsU8CMEa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIqGK7E1lcXTLJlacMD1U3//kbEyomMpowO379HUExx6q5EDw6PG66M9pB+noFH+M9Zj4M4RJrf/ypErciHWfYSHuvfj7JMgu0hFB/C2YpUgxIJARx5yOuDlSCkrXXmd8yLr9UsyWht6Ter9oA75JHwA0d08sfb6c5g4e6663dYGjyZLi7shTo2g0peFZ/TpgBulOYj+UzzZXxf9HgvT+aXmldFj/FCUqJNjRt2i12tqj7IrgT6l1C+O81Q3GSemNYDB73m8sLRyC6NdAzduWmR8hinbmlV3sBqT8bbaIC5CpEXaQITVPPPfv+nRHBXst98HHilYWdrrcvJapMTf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWI9thslkHLIiOQ1Zwd5M8vUZ7a61pVSbuk//BQjRtc=;
 b=HMlM7R6+Ckz0Tzhv95/bKh6thQ0aV44I7D/XOqfT7pRDo5jBAmcYlv8WuXapUSv0T3mse0oPNzdmU+A7Dz+MY7nPqe47je4DI8H4Lkz5XdjVf+2NTYeROOb47Q3LfXcELYMZmW310WTs3TCMa8flDfkUfMEWOtdP/XyK+f0BHZbPqbugSo9xya+iLL3Qvy8+dpGEqcV2Srusvwvd/0KpDOtFhB9p9HwJ0/cr6koBM/cqtDhnlkA8RyraDZDm0FgtzqsWb5Q6fsvAnGYZXJ5qCdP3DwPzgGaGpsBXzMCMIejoAdxs673Otk1dFTBSEieQ1wxmQGGZ2SKLtFWlUNJTiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWI9thslkHLIiOQ1Zwd5M8vUZ7a61pVSbuk//BQjRtc=;
 b=HsU8CMEa6YoJBtYqa2goQJ8qQx5ssUdi8w0sqmop3aS8Wy8uGAC+/ZdGsWkbfVXNerKW2Go610A7DOSP6KHvfPGneKcBDG5ocgf6LOF1OC1ti1S0Tjd4639iE6ymw0qBvt41LZM3j7saRaYoazwEjS0xhaYx+vpEhrcoG+e500PXMSbHnnHx+gTWrx4lQlwD8Us3NzrfNdyXfPdxd68DjGdD4n4PP56Y4Bvnle49m86YWH7B95nf8PkGgsekMn6GP3wsK15+L9dQn6AxcmXm2ZNSSaSE8lbRS3+VwnSg/QRZ5BnoXoxpEe6V7FAUsxsosCku2Pz57RuADsl7mRPmdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 28 Feb
 2025 15:25:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:25:27 +0000
Date: Fri, 28 Feb 2025 11:25:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v8 03/12] iommufd: Pass @pasid through the device
 attach/replace path
Message-ID: <20250228152526.GX39591@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226114032.4591-4-yi.l.liu@intel.com>
X-ClientProxiedBy: MN0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc5c721-4701-41f1-9f60-08dd580c2133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7qYngt7Cm3boCoiwG5X/b2PspnLMtWgCWHSc59AmyOm+b+mrdjFfggzYVOzm?=
 =?us-ascii?Q?kp2g9mSnvYUQeIYl2gxiaPcczytxX+RAu6VFIdaMEfmUZXCEfUQc3Fi7vkpL?=
 =?us-ascii?Q?SpovH9pXs0F+pkN4vpmLfEhjrdYzwWW3n40S0ukuoAR5MyK9voHfWmNcYk8F?=
 =?us-ascii?Q?a3E633SG3UDIyeqFYV8gJdwNh6y8ur50dKC/+PPKoopCKieQNTuPWW89NSOh?=
 =?us-ascii?Q?Bam3L7iY3YXtlOkikVH2H+vVxPk5OS2QOSEuhRUv6oZf8VUKtqII1+D/fAPr?=
 =?us-ascii?Q?IHiHHw37nyyyyuyjsiHsU3+eGzHsJtjPvRr4/ME63PvLbYSx9QKRN6K88jCf?=
 =?us-ascii?Q?i/ehoSdd/3f2Hz7ydR8nsAMJe/v2+rnY4ZQKyL5uoCMjTBPH3zq58ogGY1Tw?=
 =?us-ascii?Q?traHvI9e/BfmvC8NfJUJ3QfxIoATHoyU2608bc0HOu4YFAI3VXG9qCpcTdgz?=
 =?us-ascii?Q?0xDVfsh8uvYVBioTg0n+s53/wc9EFexlAoaNZOZ4jYO/yNwxNjNxW9zQQEH1?=
 =?us-ascii?Q?X13EzLE/8qADOWWQyqU0nl/Ak809RpAYfY7FtbCUZEYglPPRhr4IA0TTVVt4?=
 =?us-ascii?Q?pyK1UmEFStTs4pQ7QBev9qpGgQLKota1ykE0sjM2jQ0z+p9e4byQLwyMNs+H?=
 =?us-ascii?Q?wU6edbmMiJkZ80W2Caa2hVBmVM5cy0ECLso1RV+rWCLJof3ApuQGYQAbGVEH?=
 =?us-ascii?Q?iLJ1Xb75V2TsR9hfmXd3p9nCTJKU8+58k70jbbQekG6LI4ECI6F6f5pizwQ9?=
 =?us-ascii?Q?QEQiT6oELe/7Gb5tsB3VF+99G+ms0K4W+jHU/uT/lWB2FJctchjwkDuNpuJ7?=
 =?us-ascii?Q?B8oKN8RDg4qdVHRMISxGqP2hEtTMifXrwo0rSEFHUinNCoY0pGcYo1vEbHFz?=
 =?us-ascii?Q?RWEaTVKECZ/sCy1vs/hilpXYzQXDEajDFmcLa9x4J/ghD+IFLxCZNngegwZo?=
 =?us-ascii?Q?Ck2O5Mdr42CmMUi6Dq54SYt5KO+j1ulCO6QCmpbdsXYqRn6kWtw7r58WPbqD?=
 =?us-ascii?Q?MvaeHeDJDq6FY8aCJJTvKgJnVjkNnIs/uedrkS8fHlIZHcz7KCKfG8Y1O8SP?=
 =?us-ascii?Q?lrpoKdWbkyDlLauGyY5wOy3nBNiyGgWJCidfpQ/ahudcWs88BTCUa6I35luy?=
 =?us-ascii?Q?IF5YtfIdDpN/XzRgDhUOAdGvmfd0S+7PeVZT7K0/hN7176T6P4ukn1iWwpoj?=
 =?us-ascii?Q?Dz4Dp1l8qfPnGQiiwcNCQ3WcRMDVM+QP3UT7ut/HQDH2CGMu4ucmxR9SWaLk?=
 =?us-ascii?Q?CMyTJtxrF+pxlcJtkKNTZDidrq19JX32Qir74SjM7moo5pYalPawi6JPdCJf?=
 =?us-ascii?Q?u1MhRGNMyhk0oxDRfFlGe/Hqj4sGyLpICP/OFKLk/8VOU4nlteuVoXKZB0Td?=
 =?us-ascii?Q?vEx667nogkOcZ9uHdqgcF/6sRdDa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gQLzfCfzS+MyuVwwm6U5mqUjpCZNePz+R0yH3uYkNZJHQ/HHGmkDWiFnTLFw?=
 =?us-ascii?Q?a+n6xzmpR40EIdyJhnRzY3mybSzfOGe35Bze3472gfwCxSWkKW7GwaYAsyv4?=
 =?us-ascii?Q?X3kR0OrkP2keR3V5cOAfzzn6BkVGk6MDuEFEm/V0UzhYzMX1IfuN/rv2r/8T?=
 =?us-ascii?Q?Jyd+oau0Ra7aGc7u9J+DnIujlLVuUf2VHivShvzYgOPssmaJhirffdNebWg+?=
 =?us-ascii?Q?lPBNQhW8chdEja2ZvGySjpSrK6p9F6pdXA2nOxMHWn4e5EoY4KssNTqO0wbv?=
 =?us-ascii?Q?FUIdNakbwKroZWreBmY+v7IIzpL1Sv895dVgW3H42ZSdYaYhEi6bg1y9/5tG?=
 =?us-ascii?Q?i4EcHKjJI+85vGj0vdF/wKJgbUS4g8PPyFaQBzK9eZnQlMveCbGIUzRQTgYc?=
 =?us-ascii?Q?SYpJcXjkWKSO4KANjgaUAW73CRLBjMW1rkJ8sjziAhKZ6+bl18j/pRU3mbde?=
 =?us-ascii?Q?UOXRw0pgohRPmS55XaYlO0zobZAGySk+5FmnpDcvigpgncky1AtTuVYtZH5Y?=
 =?us-ascii?Q?RZIHnRakM0rG8ITGYVHk7fjmrWpS8cYPO81L4sqmiaz5YGHXWNSUdYCP9NPQ?=
 =?us-ascii?Q?HRtCGIxPadmqV+rkV9SMA6eUneVcUZMclUIaBQnSgctZBkqjopB1fPOvrjSV?=
 =?us-ascii?Q?QhNtUNBRTDvbUfSvvu9qIYMoAaKkMklLs6TEfZrX6BGCg3MWH8hptdnQc9Tb?=
 =?us-ascii?Q?WuD/5ZBYDpO4BBeXzZLOEnG419wqMWS0WUOHOPQUUQ5DTgDBZXyAsHur0UDk?=
 =?us-ascii?Q?j60DcQigujfeNysfdCGItRAnqhgxh+LB+15ed6y/EfjIoihda/f6+MjGHlqm?=
 =?us-ascii?Q?XV6Q8Z1XwzCjuRCmjtA2YplUek3IdMAYfir+P53jzbBR+EXTLCjszcHrXQSL?=
 =?us-ascii?Q?Mo1BUDD64VfkHd90Tvg0Z1owx4LrLydvTC6AxHsGkaGeF/aub9WuVkEVlR8d?=
 =?us-ascii?Q?5Hbww1bMQWrtJ3sRHDIj8uLNvuZVzNeSEujogN9dMDD648f2JDqs5M2O6DZL?=
 =?us-ascii?Q?LZ4cz10itr8LNcwG0XfOuaEY2mNgjhD5Bh7/c9t8E8w9GxYhP1MCaDZkFN1R?=
 =?us-ascii?Q?M87PSi5lbzxgb1IAkahSmqwEymI8u1MZDA7spZ3VcSjcW+JI3Pmddb0+B2zE?=
 =?us-ascii?Q?T/4sTgI2kXQej7iQ1JDQibsvvvwsdOr0zXxt5RfGI3bPOwRb5Wzsq3w3Vp4d?=
 =?us-ascii?Q?P7e8jiY4mMcfASz49R+wRnmogOkaNL1ewGUdNsoM2RgfictloD6Bwl6L3rSU?=
 =?us-ascii?Q?v+SH7zTxZYWO6aEe5jXiVT8BxMxpKU6n9KMaFz3OonSlMBp5fRojmyi4pz+l?=
 =?us-ascii?Q?6whezLwi8Q0ZqMkR1CHbU+b0ZSCXPDy1lzrn+aSO9zN8XzyDxjzKySWCL5To?=
 =?us-ascii?Q?sEkJEsnET2DCqRWzsjVqWRspTt3jfyEcSd5UlZgG/lIrnNtsw0fbnDv+iCcC?=
 =?us-ascii?Q?PRVr7UTQfQFa9pfJj/2oeHRxPqbRZoEn4NunpJxxyvcrE7GFJcr1in0I9Wj2?=
 =?us-ascii?Q?07pfRZd5OqZ9ROlRvIjF14aByYEc3jsRwtPp3xy+90t1NeLed2x7VFq1CvXl?=
 =?us-ascii?Q?08uuPxAS/IxnW42fSBiVpJHhjFyjOXoCiYRpd1Ec?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc5c721-4701-41f1-9f60-08dd580c2133
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:25:27.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWOVzewuJoKCEzMsh/xMzhB1DTPTqbdBLeu2yMnrfyvHbx0rve1iV9w+QAZGydHD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266

On Wed, Feb 26, 2025 at 03:40:23AM -0800, Yi Liu wrote:
> Most of the core logic before conducting the actual device attach/
> replace operation can be shared with pasid attach/replace. So pass
> @pasid through the device attach/replace helpers to prepare adding
> pasid attach/replace.
> 
> So far the @pasid should only be IOMMU_NO_PASID. No functional change.
> 
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c          | 67 +++++++++++++++----------
>  drivers/iommu/iommufd/hw_pagetable.c    |  5 +-
>  drivers/iommu/iommufd/iommufd_private.h |  5 +-
>  3 files changed, 46 insertions(+), 31 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
