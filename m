Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAE71EF366
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756441; cv=fail; b=R4FqwVeDbbVtTwWtlzI0Ro4y4PrwrWVA2pNUyn+xvwTf7LWFhltg8iuZgiATY7QSccKUkNyoYwxnK+uNsV5YW8FORWvSYhJDHRGARlU0bkCCUZLoAADsgIPadDp68xqKMIZR9N83hrrFa0TMsxdUAThDes+X7bJTas7zwp9xQzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756441; c=relaxed/simple;
	bh=tO6HhQaPVw/dBGvux3W8XSzCzyvI0wotPSyY4sx98z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oyoUGeyorjsYfLF+3Yp8g5FF9Kt/6l0RjK4AEEugxqdysfMgRMSo2uHvBsgtPjA8964R4rdCyhKJPTRzHYsL2dn8wkNbXlSVnQOoCzUGuc3emAUvPmMtbkW2AMAatJlNzluj6ay6M9v+sj1YSSMv3zeHiGN+jWd1rx+N9duCTJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e0AjaXhN; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e0AjaXhN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jq54jMlxu10aNZSDuIidNwE6cv6iIW8N/QFYbDKPjA9v4B9loYcD1exeDFiWDb0dBorPW0J5Aesj7Mwp+7gaJjAtcjwPBviwmnfS44MtmGQMDkjFO9ee4NyHpiC4X+CcXlmuBEkj7289AeXpVWBO3AnGvmFjEvlbA59s7Qv8KEgIlTlZYf3Zz7h1j+SDWAgvMl/Llf9Hkx7HNCRUgaUSZktyZ6M8uP3j7azzhFZn2F1oDEeL+9pJeFR50YQIROLB18ykQgZ1PsFxILos65OkdjWz7wh7mdsm1SIzefiT14diYK82GRkyCc4dPDo+VCgW+4YIkLH4JDAN39gVrs2XGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/96D+sc4RS5TEi1G9C6Ezivx1xuO8kV1os+g7u6oPw=;
 b=ELmbH42t4w2rXw/3IJZhNV2qWLSetdbugAM9iNsD8YGndymOeH+YN8jKoznNGM+Op18IclrF8tPGEK8YNkExdhlwPQYfBHTUrEYTC3hpB0CQdCM5157qWcKQQUB3+WgamJWF248zLryFgd0/owkWdiJdEZERVECotGAOQMVnPN0xF/fOUdO2eCCwkd7agGNTyPp1v86T1sICTQdky1DN8vOkJ9Am2lD0ulLFfjEF63d7Pm9vJZAAdbMyzDqArq9yLCXSPyYeCDj9//Z1tzw7AkgdOGcJwN69GCLPGK1L2ciRDGB75x5hMnfLbYqyueMKRU0l8INxrLXu2Bzbj3zwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/96D+sc4RS5TEi1G9C6Ezivx1xuO8kV1os+g7u6oPw=;
 b=e0AjaXhNx0P+M1OMGDTO0lxT9zFQ+G2yS1r5/yzs5kvyukT32KRMUbfOJmKV0gl89znBO7QK+elmfxO6bN9BLsIMcdk9KDo3x2TrJVH7ZcgK5hLp5XN9xVUia3TTncuqqyPUmBQpYKoQA3XtZQagQ4ibkOw7cWwrrBFgBsx2sGKoNu7Pv14wiPUKXs1LTthJ++52WWpeMahS2xZVbPwjwVcIIy5mYbSJ8usUwM/ZlV7tj15iqxBRg5GVZGQING8R1IdJ2HJxTHlNDTxLIrFvSTlRkJw68mNQhPsUUNMq/XIiqJuPyjilF0mMJFysm6RiSHAtt70gHRi9cxyz98A8wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Fri, 28 Feb
 2025 15:27:14 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:27:13 +0000
Date: Fri, 28 Feb 2025 11:27:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v8 05/12] iommufd: Mark PASID-compatible domain
Message-ID: <20250228152712.GY39591@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-6-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226114032.4591-6-yi.l.liu@intel.com>
X-ClientProxiedBy: BLAPR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:208:32d::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 60db64c2-9965-425a-568e-08dd580c6053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u0UsxLmdHsL+Bdq2Xwrp+M4C9lqg3j7QgM5IouYBzhURz9+hatrOfw1yzWWD?=
 =?us-ascii?Q?G5hig9nj9aHqVrUldbZd9zCykz4pDPpfx9JB/ogxbf6Rl1LtJImgnyA5M3B4?=
 =?us-ascii?Q?PmL6k9asVKJnB0UkfYhNAB4HylL4AcUaO8LEbsSwm5k+mORb2Cx6QrK27bka?=
 =?us-ascii?Q?mDlxXGKEVxz7JFcNhBc9lCqP+s0k32N5e+pnyogzLkBlWCLtelrUAxvf6n0p?=
 =?us-ascii?Q?tABbb0wNSZxJPMXucOsWZvn2+Wm2UQ3tRNTRhezy/SK1MzDep+X3pJZ5XI9Y?=
 =?us-ascii?Q?G6BNbsBE0cuGazkdYUsDP3WJSjaNwwZTePHVc0jNAqROlO2JRPPxH9JIsya7?=
 =?us-ascii?Q?JqqwQXkgEyQ2XbecBci1fyAE0ntWp2dqFqYQHo3Ie3TQIQoR5NhVL1z7qIa0?=
 =?us-ascii?Q?TQg7HNd5yIeLwvoWnhj6Qv5T7z9odawak4zfOhF9FtL/4dmhDt+NviheK0kQ?=
 =?us-ascii?Q?6GJSJYBN/R0UcFZtCTZ7RQeV/Hv+7ka9cUO+la3RNrcbCfEzSFZd5FtAkNMj?=
 =?us-ascii?Q?dh15urNrBJQbCI1clTcLz/Gqy9txISYeakM2eeBS+B1/c+IRUiF1YUuF9I8N?=
 =?us-ascii?Q?L97KlElxR2whoo69iA1W95u0FZiLxFhUf3Z8N/ubwrH9zUz6MCLqd9UNYaVt?=
 =?us-ascii?Q?ytgzeyw1nKVmPSx48DPh0SK2oKr1km/sAhsKAGnz39bSWuhrbVC9wIPtvRzD?=
 =?us-ascii?Q?8/l5IomrBZZZ64OqIikmbIuhXTKVEdmtFv9kG1lZPdvpbsm+HJQqX2RlJORb?=
 =?us-ascii?Q?D48LhgyA+TjEyyGWD6BCA3jRhZG8dQ/FmMVxlezNMGymtpd+g1gtT3LUxqWN?=
 =?us-ascii?Q?EIjirLgLJX0Mr4OYTx1SjTU6HX19eExTySTA0qp7Pj/YI7D/Ssdp1lNcXsXo?=
 =?us-ascii?Q?xt5fse+b3SlfFEreEVX9NXzIdvFus0/3IkcGZYfqiirL6BMZLdFRORp27LwX?=
 =?us-ascii?Q?jgJ63muxXg3B2+hXDuan1SJq84ZvDrEcyXHYCY/Atu1r0o5Bayc0WdyWAfPS?=
 =?us-ascii?Q?gMf5jSQdiPQgLNk+IzpXbhY/sdXbVjfPr7lkF6YWA57+CPeZcSncH81V0Kw+?=
 =?us-ascii?Q?ILoWPyvg138MOAavn2eqXuESrgQT3uwSC0dJOE0hqnVtk0FsVZU88HaL9X1T?=
 =?us-ascii?Q?pnLV6gFi3I+RgsR2CfGgUtSVc7gZRdjlbLN7jsx1U5jk4jE8TTorrYlcIPZ6?=
 =?us-ascii?Q?0EyTYlcqL87tkk+BELsiTnNizCheJIf89LAYcer/DpK9+LzS3avN5565JX08?=
 =?us-ascii?Q?OXTwl7mbpWACuJNkwhroAiZRrTu7KaQYMOoNh/Eb1cUHp5OEBGz5wOCzgsi9?=
 =?us-ascii?Q?ml3pyg/QJVRUroU0yskm/NWnkeXE/zp56DyJyqC9pla9lcBUVMhC9ZCFscs/?=
 =?us-ascii?Q?f3zyajFXE4cwatlfIYaPDJljm/By?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wDHuMobjRl/8AIDslKqpB/Yd7MW9Igmh9rzkVfU6deS9U65rZQB7QDVkyADg?=
 =?us-ascii?Q?iaANtHCG2O114OuTQwbobrRmSTqYra/ciA0bqHBDm0NOAUPss+M00T+NFwXj?=
 =?us-ascii?Q?rj0/qDevXRv3ycGQY925z1nBWdvGnjIYJBBkjoLAXoHn88/N8U/VWSOcdVj6?=
 =?us-ascii?Q?fF9A3tD3xNfu4MwUDxgLO/B1q7bnSQoAzIPh5QwwL32BgQN+OWG/6TOEE63c?=
 =?us-ascii?Q?RpKvXweTPPACkL8vOo+Y1ZxLDulPoON8Zw8CNLgZNqugaplu0PuwndFeeD5s?=
 =?us-ascii?Q?gOn0Br9Euz9xjNPxa90HSB05ez30zwZEuvxUvhtg4AtJKxH0bzKZF66iSiuN?=
 =?us-ascii?Q?bkQnYOsEfkdztoId+xd2JnIvREEk4bZbmYfG5+YUhY+yADNmY0FS7MJ9RC6m?=
 =?us-ascii?Q?fBAv1CT/j3KC/CnwwA2Fth6LmwILLg1XETPRAsdA3LGZz5luhPa8bP7tA8F1?=
 =?us-ascii?Q?SOmi/VCPG8uto8oEChfGqk4rWtUH2bNWdvIUSrZJSqmIbZbkeBKSm5XsECJU?=
 =?us-ascii?Q?PuC3j/OWmbbVKxMLvOYuNIEn1mIWzOjTqbjgJFs4F6bM45JfjmY7i02Ni7mc?=
 =?us-ascii?Q?GnMzyZ/J/dmNoSB+S/PsHwJ6lInJZugsCgYyLflAQjTNyulsgOqv6WKSqQMV?=
 =?us-ascii?Q?QW7l8lt2v8C0Pw75Nh+X5rny5iX1cOhFc0EmZybrZcyyMWqAv5dMJydhOFHk?=
 =?us-ascii?Q?SwoqjBpaZxL4PezGtVxkyEHRLMC4WvGiDMVZLECci0X+zP0KLeQ80u9GwXkV?=
 =?us-ascii?Q?m34IEWh8EyvuJYmdSDnyDnfPY1T7tSdAohifaqfWQE9r+bosbiJjmH4nhjP8?=
 =?us-ascii?Q?00Z3WwtAhZQILyq+wCDA+rVlUgWhQ4ZV0nRStSM10uSSnKIVKkZd81JOuAkH?=
 =?us-ascii?Q?WifTLvdjGbeM/n1eGegpl13VKg/OVFp/14gj3NR33EE0NbRvUi9JSzLqnjrx?=
 =?us-ascii?Q?E1Jv/suHPdkQ1cybZm3qXoK1vnpZxtdR5jMgeB/zFZ0y9i0iGc6x7d4tWoTm?=
 =?us-ascii?Q?spDTeMK03OitRzRqXwYjxAVHJEyIGXWRUbOCFCZsVhhWqtcJ6WUYypGyZZFb?=
 =?us-ascii?Q?E2/v1SDAcJx9VHr1/KwJyIXjh+6R5kPjeM9i5rd9CZ22vtgRLWXQwBcP8M9q?=
 =?us-ascii?Q?lOkqWyFJTJprguYnqngG7IlkBwm159M5K3pRkT5W13ghTnsxj61iDUOSJ2wK?=
 =?us-ascii?Q?WhOobN0c6ZIqHzObJ39xtTrJBT/AR2AYuR4kkgIRbNCrdKGGE2A/sZfSy2Tx?=
 =?us-ascii?Q?BxAFfz/hrptW3NpdNwP537d3EamPQKMPFm2tvGSix8pR2BaGbgjEssg9mzZs?=
 =?us-ascii?Q?57cX4eNosjwYWbmZoNpm/+PYgDxmai8usaqQhAHzb9YDTJiwBomqchtWJlhL?=
 =?us-ascii?Q?/KIK68MBHcMpPsmznLmNJd+LrinPCX6zLPRHiXU8X+3JXcSdzArOVmqN+xn9?=
 =?us-ascii?Q?N+vBszd4uYdpbyRIFiZe15uPSQGmqh3zWoPLDv7nWct0MIUCOY50iLrAu4iM?=
 =?us-ascii?Q?GGOClscoYMJNdVB8zjDcOx4bP9/y8NheZ3gszIucwj+JRBpMgqWlnxwBaQyi?=
 =?us-ascii?Q?K8r1QEVBibgRyXdHGyKvFyZc5KL5369/nWh+59Yl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60db64c2-9965-425a-568e-08dd580c6053
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:27:13.8093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdLE+3R8fUaoDgx0uzsdPxfBoD1JaSkUA6gnEKNuNzbzLkhZCByKlW2NGjFWuCoG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266

On Wed, Feb 26, 2025 at 03:40:25AM -0800, Yi Liu wrote:
> AMD IOMMU requires attaching PASID-compatible domains to PASID-capable
> devices. This includes the domains attached to RID and PASIDs. Related
> discussions in link [1] and [2]. ARM also has such a requirement, Intel
> does not need it, but can live up with it. Hence, iommufd is going to
> enforce this requirement as it is not harmful to vendors that do not
> need it.
> 
> Mark the PASID-capable domains to prepare for adding this enforcement
> when iommufd PASID support is added.
> 
> [1] https://lore.kernel.org/linux-iommu/20240709182303.GK14050@ziepe.ca/
> [2] https://lore.kernel.org/linux-iommu/20240822124433.GD3468552@ziepe.ca/
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/hw_pagetable.c    | 3 +++
>  drivers/iommu/iommufd/iommufd_private.h | 1 +
>  2 files changed, 4 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
