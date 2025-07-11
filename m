Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59C62EA15D
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252155; cv=fail; b=DPNEqzrKsctcNhRpQZwsQwXz+2Jc1j88uztUT4zsYPxW4AeDdWEGbV4jmVMncMie7JUCSCofZ3BBwAgyvIREq+45iv1epMQ0NlMejJWUHIbrdAOLdWaMrtdGS6lgxIxZqzv7xTbGXsIVg6GK7rTtVDgA2lf31Dz5ycK5hQhaPFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252155; c=relaxed/simple;
	bh=ZitX1gf7Qm/6cNdLbUEvDoJi4cBtvW4EoSUVXUrlqxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PIDPgLlz7aWPP+D2f2bhspn3ToG7k0V5EHfc8oUdKCfUww3bRE33biDJKVlDpoMJJKUsoAflMOl076sxQEZzaLlhrZRDqIa4HC3nYA1lZpAhfAyCDDZZyXz8zyQ0Nh1xZTdCcKdyx5aG8D2GywLDVb9Vf5NX74iMqZlPPqedYHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AbxMZHXY; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AbxMZHXY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx52BlnK1QA6i2ueUCmwr3SgSS2xbGwguhlNy1zaPoLLYrmkjN4zW8BCA2+9TpOXE3Fb/h/AVQQh8WZ3jvgFFfs1TRR1K/XAoUc+uEt1MewFzsSgfRaOE5WTjUaRsy8gM0bGruTuckXXa9WPq8KOjrBmT4PUZvoRXw8HqOufrL/N1jQE0O6uSqK8uhvL7crzO5VnTJXUtnKcPF0YoUawJPqdyl9QAlzyI/m9MCb0HK6/uVamNqffvRDMqyOKEeEBPh3gt4sX7nGcgs0XiDgR5tpcz/QHfz/5rcc8JL4KTQroWaAp5F8Afm4nROf6VTWiIRy9anOFuX/sm8TZlah4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vch4nhSURKJBRxP6HlyhqPKYX7GoAcWmFtzhWy2KyrI=;
 b=NJMjTlcIAUPcQOKjgqyK8Gy4zBo0GIq7dU4YZmx1+trVNvCxrfWCAoNny8oNo6n2JM1LNy74aWXoYvQeLrrs+1Wa7FMlswvvoisLJGjypLs13okVi7fgyyALMmmgyM9+bo/Zts+8/A1ODFSrkembmdfExi4NCn8y/Jsov4U1nAT7oa2wiGHmWedn3Mu93VHyoI5zQ67NsHi6KU9ML3QA8uj+lQYA81SasnlYR7D9uA0q3vsAUYPIRkmWjpInk2wWqCm9Sz7hGXNRcblQ9TCtNdxbkuCV+O/mEmPh4LemIR7I38XVaXtTuO/+ONYi6MckqRArbgb7VnUj7B1VyAvFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vch4nhSURKJBRxP6HlyhqPKYX7GoAcWmFtzhWy2KyrI=;
 b=AbxMZHXYBcTsWCj8a6Vp9/DphSSFJ2ZrDoJnopoJjOUuLSS+TulI4fnLuGnBdbBaejArWaGN9y5ViXL8aG8DPqarrGe5GPf6ilHSAeMQoA7188dl86VDd0u6tG6JzAKs+d1cd69WG8ns8RMtI2wBfKinjCp6Z0wotN/ZgqO2JsKNvEyxgbUjHYRcSCI99TJfhCX4FloiUTc9okRXZaicdgt9MeSwDceH6pdNJuKdMdzX0LLfuT87t8dvRmBAtHYrXOuX44nUO0nEeta/ZJJR16pR76osP+UvnF5hL1+mNpAojfBk6OrWILoTBn4EvCWB9I4ujeFvmanyYK5X5zUP+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.23; Fri, 11 Jul
 2025 16:42:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 16:42:27 +0000
Date: Fri, 11 Jul 2025 13:42:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Revert vmaster in the error path
Message-ID: <20250711164226.GE1951027@nvidia.com>
References: <20250710233003.1662029-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710233003.1662029-1-nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:208:236::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: b764419e-1cff-4fcb-d21a-08ddc099ebe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vTwFK5hZeqig8/ijAGqjMQzUWjfwds9PpkaBVstB0EKrslUfPosrYZYKvr3s?=
 =?us-ascii?Q?MNvrykPnfVoRf3JWbtqqDIm6fOm+eMj5bkWUCEPjWHmiXww6NTZWACqf5Bbz?=
 =?us-ascii?Q?oO5TVdr/Z8NQBnEGXENCd6304p5d/NsDREc0QKqQGlUINu/KIketFWCWVAMJ?=
 =?us-ascii?Q?S9RQ9jEXf2AdgjpnUUnOPzQ6S0AYVbjFQq3SxbSHbuJ/PdsVMnmSZgkWbZ+m?=
 =?us-ascii?Q?DpeHcDCDWuUG3TWG93ihFZVLBFkdNsDGtAycqdDblX3qDwRktC9gIIxUDQUm?=
 =?us-ascii?Q?PI361QNjNGIfdR4pHPzz1KuTfKjIc30eAqG56V56UUfSNhzmRqzgJ9r7RV7k?=
 =?us-ascii?Q?T/KXhSb9mzrMY20znWgix/tYiinErAZq10ojSvu5geKz8GOv5dycqZyP0AQi?=
 =?us-ascii?Q?C9nPBQyrmu5LxLRmr4hCeacN2M1dRlBt0Q27TkNMztDm4jp1PVvAMAyNNeLn?=
 =?us-ascii?Q?Sm8QamdEK40HjISj7j2ZaEmspeo+vaPDYPWIpBjZ8CIhpHR0kKTc0Fa/gJMn?=
 =?us-ascii?Q?S/pO0Kz2HgJhxfzjuPrnugnzTgrWjB4vD7/udaC9YCnq10gHWNbPJgK33vcs?=
 =?us-ascii?Q?y1/HY24gemPnvRdWsCfVmZYV5jGoHJL8WLEHGt6R3E2uzicw/xVsSLOwqGkX?=
 =?us-ascii?Q?bj97gzKlhG7dwaoMNIxiuNPS2gdptXNp6QqFWTYUa0Y+QTCGEjX91Q4bTvQy?=
 =?us-ascii?Q?GZa8ZhSLRgKwQxzLOH1K+yEfwP/BK4pLd+ZIlIf+zqTFD/4jKm4znA/yPTSv?=
 =?us-ascii?Q?KB6TQeR4TMH1empwohMNyAwWgOZUT0Y9mODk/63EL5wdS80usl8Govb2Zm1Q?=
 =?us-ascii?Q?mM9fNypKEvhDwpdDuNEBqyg64Ja/G9olEPJjnfGjW2QJdOOZjwwTvEwg7SRf?=
 =?us-ascii?Q?eVOKVRszJw8JElOypVn6+rC0TR3N+ZX7JhDQqDK9wcvOxVObqm3UKNIB9E55?=
 =?us-ascii?Q?eXl10mjBS6R//6TPoL2vBqeLvPnEsz9fDY3f3hAkLKqj1Y6r0WQcIfTi4ARH?=
 =?us-ascii?Q?0bKg0I0uxTNwo00yHAm8Eyph+ag8WGQMurqRVIbE7qezn6ZaSp5c/GUz2gG8?=
 =?us-ascii?Q?6xd5KkfW56fWJ1Bs76o9IwecuSFOA63GAv1i+5QjsGeiUOITSDmOd0vxrK4G?=
 =?us-ascii?Q?VKQqfR/3cIcHe+Iw+ewbUUXiPKp18QmLkbYH7oATNY2ATnmdNSH4S3KHXJKX?=
 =?us-ascii?Q?8rfK0FgIoAnBkFEKTv9XPNSFxOWzLWFmJKgV+prPcJHU5oWL88PZrAl/0YGD?=
 =?us-ascii?Q?gyuOMwXSm7LX6G6iiAZvIIdJmPP8qZLTaIPkiOxvbZsZPKLzVadsln3QlNHJ?=
 =?us-ascii?Q?Yc3NeaAgVYHe+Vd/zp3INV2PrYjVTnJfRcf7S2F+9K5tmeVvDjQ2GGuW7APi?=
 =?us-ascii?Q?giSbNLrsoH73AXOXjuQkcgrl829W58HTwIJaJ6L0GPGA7UxpqPN+gNUofSms?=
 =?us-ascii?Q?U5hJ+HxkN2c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TUB8HD8FgB7kj9hYF+WoPevpXGWULQVdeOkIa4cZsjAhyLhwi2dbSyuF8ttD?=
 =?us-ascii?Q?jdoGiksWRV8JnwhR7/cwxlqYhn3RvaUCmGgRD9qU/ppj3JVL2L/aPfl7I1XT?=
 =?us-ascii?Q?K4C4wtbNWMniQJtF0DawnIXQErsHZ0dmXjXOMNs3LyikY1XLVVCXr+C0zAw/?=
 =?us-ascii?Q?Fe3+pcf8SeO5KWmSD76KQuMYPekD/6VaGULHeHvbaSKz2qg8LYbUM97ChKtm?=
 =?us-ascii?Q?tlFWrtG5EBI15yPysiUrbPAEmuH+nrLiBSO1MhySJOtHQPy5J8w0gHsZdQhL?=
 =?us-ascii?Q?TniqW99nKeOYipEH8kqr1hI3cQvb3Ds/+bNhPcCsnrF4W3WeSi1UuIArJA4F?=
 =?us-ascii?Q?CWcX+sRhCW8apRg8W3Y6q4sw8ty17FrlBrPCNepv8jnhWztpHIArIcpVMf3c?=
 =?us-ascii?Q?A6t42IiKn2cjyG90n2Gyv2LKhLPVt0fkLpHczlIzBOv6077tySE0D9M02yps?=
 =?us-ascii?Q?Pl8SFcZWe4kh60g4q8xaY2SMIFa9ZbwH9U+Pz9hWK2I2YHA8ANhF8kTZb5MO?=
 =?us-ascii?Q?BjqOuXj0p2MBCtQDvvOIVKtAr6vNYO7XhI+XmGRX4vi+LQmoMZWkXQlINDxM?=
 =?us-ascii?Q?t5G7EjBk/jFFAei26dOyuwbp8vYR5bI5o57AaX/5pvZE9fDYG1DO2aZmWfy6?=
 =?us-ascii?Q?C6ZoLTBr+RJTvGHMMejzCcV2CF+lBGZv/bQplP0R17mhYjZLQycSIDm12iKh?=
 =?us-ascii?Q?XD1ypnSZa0YcPhEvzI0WHvHsteWluk3NI1l2wpprwQRLBLas+AfLonS3D4t3?=
 =?us-ascii?Q?HVl3XBohariXAQSmeGB+OLlcYTKsnuP53KOpJ8Bjv+saZJV4EcBioe0UxE7x?=
 =?us-ascii?Q?i853zTVokkRewrtzTmL9Ms61nCt9nw0vbsZUul61ngpkRuRccO/Jdve5sB7h?=
 =?us-ascii?Q?kOrzMQ3OEewTjxwp2H5NFYrutHp7f2iIUOBVNREU3BQ0i23tnvSsMPPm93yq?=
 =?us-ascii?Q?2Wd+d7OWew8hBLqn0dfSIZBrDR6VJ+7XhN6ofrq3h7VWAt6Yona0fm6wWQq8?=
 =?us-ascii?Q?j+/a07XE8ygcLxUY4yOkoCAoVX0PvMW4K4oC04jGFdisnLKZW0osXoFaMC+D?=
 =?us-ascii?Q?2ajZMYVQ7zBJBIntaQaUNNJ3ZzKKJAYMqp91NYnMVf1RyrUGwDH9M4ZEBWQU?=
 =?us-ascii?Q?aBz7KJDT7V94zybNtePJFdP202JfWTnx1SGWUOYkp1EXZtvqw8+lww17F1b/?=
 =?us-ascii?Q?EW7keHILNE4fT6QEgfT+sLbWTbGp4NgoeOx8ywKVbk9+tLpN0fFKry17+Ll7?=
 =?us-ascii?Q?GR65x++NFOsXhfmu+Q7cOcE1MXUnll9YOnevL8KKObDXeFuO8SL4mE3OQLOD?=
 =?us-ascii?Q?6syGfcJTBhpf/WFqEbTvOvydsIJY8A/iZwMCfrEZof+WWaaM0asDitvT2+QH?=
 =?us-ascii?Q?RKGRjYgSJUK0JMJ+j++OsY6/HuOzqHicgI2DtXTq2D9cpU1USpiM2oBLv8zB?=
 =?us-ascii?Q?DeSUYBKD9ZxAc41X7QiKCxYBQiC8T9VBCORNuf0MnGAIeYNpFbHnH+HFgMit?=
 =?us-ascii?Q?WHJ3vEHJN1oVFFQnsCuekCwIEiamDWJEkQthDCxvucqerQKRfP+vNuZOKdSQ?=
 =?us-ascii?Q?emX3H50gkAQ3hb2qIBADRahtmOXvKidk5VmzLRsX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b764419e-1cff-4fcb-d21a-08ddc099ebe4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 16:42:27.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OF/AQhfleo9IfojP22WHjPTfVjLKnodOAa8660HLoF5rSATw4GUKh8uUVcD6V5Bu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097

On Thu, Jul 10, 2025 at 04:30:03PM -0700, Nicolin Chen wrote:
> The error path in the arm_smmu_attach_prepare() was introduced with the
> arm_smmu_enable_iopf(). Due to a rebase issue, it forgot to include the
> revert of the vmaster.
> 
> Move kfree(state->vmaster) to the error path, to prevent memory leak.
> 
> Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

The patch is fine but the commit message is a bit confusing

The error path for err_free_master_domain leaks the vmaster. Move all
the kfrees for vmaster into the goto error section..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

