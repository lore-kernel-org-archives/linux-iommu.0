Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5608273D8D
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771764; cv=fail; b=MC9h0yLUNwyTPTihYMXnrgyeCykjqFodlHAwGGvXN52VtCnMa7nK2IvsXrW/FMiL+cKijYWX7hu1qQwOYGKa3Uj1RMP1iUE9BjTIaodZLqQDWdJNMvJkzylKhJM4bHxpEJaEGC9OBbLuq/lY0NU5awLIMU9Gu7MiMCZ+pbqxBuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771764; c=relaxed/simple;
	bh=B9T5uTB1KgVurq3hHD01aUIqyL+ghSAghfp3aW7JGyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aqn+F4+7qO34VT0LRxFsSTAmi1DQtvO4rOMeQ7Th2j+mC+HmoEbEDqkpzEF6JFEN72SSUpVd5JIN/oiT1J/sHo+hOthKGLxblxmtbPbSR7BY/O8PsC9nUcdtL5JxsHptOwLCndej5pDEtJyr/yDdmG3+icer3dLk4aabzXXzt5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=koASJHFF; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="koASJHFF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5JdCrg09ujmWwQjVJuwOAbnDImA+DeJr+c56uNEjC4ppABWzB0Xzd17P10x+ImDYcSla31+IuD3kZ92v+mF+wLKTLPXkARqrQOr9vCiUdbqV62gjp0mdq1jQpjVniStRtCG4ousLSIwGRM/ZaVcxUMAqlGtKQd2yALjGvGe80/crG7cxloXq1zyDhgwdF5bWtCvKnZ1uFAbJXO1M6wNImWEDmYuNBm6mUh/2VyBQar7AqI101Z/f8zRV/6R+ZwviP2bAYr8E2U9gG6tYjOBLymueZsDAWmRuiWRNH7FbHQ3DA2LiZYqfbOtkzH8BMTyq5sDb2AACQMgXPiIKNV2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2wZ+hgM52hwT7uw5uNIBBbXsTKzdPG+XHPeOPy49NQ=;
 b=gfUURfrUzolOBbhaIPvi+gk3fpv/e9MIgkzAJBUWMLpRNtnoQ2hMEEwe4KfrGb72tMo/+ZWIWoKofz+eS0+6C8EXhD2Yv/mQuid9UoRc46vxnRyKPc01+IQ615hs0Jv8i/MHPYlhqAYLu3G6fhwolg/r94RJ7Ca/l3NRcS9jX2GG3Wwvo2J9RFWRHYvI0NPuTC8RCCG6NrFGfJJYeYJYoQexauJgKk5hbR3Zq1Ucqu2CHp0FkMKz4y80qlwwAWkWK6ZZPXUE6zd/7E8e/WbobqElhyIjgt2R2k0SGTqYAWyew7oKvSrU85Xjiy4MaruXVnvboVvNzeLpFfITPqexow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2wZ+hgM52hwT7uw5uNIBBbXsTKzdPG+XHPeOPy49NQ=;
 b=koASJHFFvDazKyC7VFHAKFVo1B2b8R6aIPAyc9kM+GY98D2zE5vRXiYKC+UHLsGnbiQPMl3Wu6oFAGTPWplnFIRfwj7xs9aG0aIq4pJDsP8bi7ZFLmngsaJ3qAYcIRCzwFxi7Ua2GGayfxz/2tQJ4XnSAphFcw7J50ssD0VdRLB/4YLHnFEXfqlAVRquNqWmy8fp7KvjlZtmDh/Z8aC3BmK6F/RJgZ3wM6qWtRTGI3dkYH96t4Qalcbdbpudiq+jOwaBPejnE6YNRt95VsqWHjnk44CsBhphVvJW3GrQ5aPzexQ28CgFSyZ3n8CRSyLZ9yK4JvvOzwg0P7fEsj0Y5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 11:42:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 11:42:39 +0000
Date: Tue, 21 Apr 2026 08:42:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/amd: Remove unused IOMMU_IN/OUT_ADDR_BIT_SIZE
 macros
Message-ID: <20260421114236.GB3199414@nvidia.com>
References: <SI2PR01MB4393EF02E213EA4111DBEF74DC2C2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB4393EF02E213EA4111DBEF74DC2C2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: SJ0PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: f552060d-1625-4549-cef2-08de9f9b1737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YkTloyhPXqGt/Qc5JhE+n1vMBHZz3LMHiZ83rDCrv5kVrYR7nEuIRCxmOXP+6tGNaBrgHmx4gM6Blyv2uGnL8xFDub31fbR1TAQ5KmthBxEQtNiR07LkeNrnaX/RlJ7nKRkEA00CGGK2OjIwbgIFGG0MB4xAMOBIBxntc3hE4CZA0AwcXcNiwgcST+0uJ73cRrxQfCzeftNpC0FyW2uTMV+qMN08TT6Bsqhu6roKKgp4a8AuQm3C+BPCbI5hCwdnKqAXpmMGiy6M86eIzizV48lvoEPwdkFSoVPzXI5kmm4Al9YOpYs5E8Z2kMtUFZP5CHn5KsXaKy6CRJfYHIQ1V16Tkt0/WwMrjJONdSonuWUHAIWoQLNiKN4++ZwqYmt7rTKug/vDqsGzURQ6xsTg46Uj2wjq291CDaxOrf/Wu6Jx6UZmrhCv0vES7S/QJ+Z7wiC4kbKKG+Kf9v8Srt/2lR6L8HRgsCQ9kbGPAlPAKmv2c8wN2psvOMPr8sD5azsg7OFje3X+0k0j01ZQ/YIM4Sd6/YdhjV9d81WYBkpX2QrvFD6UL4Oq6ZjzCmqkQ46CJ/PD5dgUZ/07w8hsw21XY9a8dkyV6QeLAsejtxILZNTZOZn8j0bAimPsXddoN2Mu4QYUhsohfgcoYF673O3REupnEGyG9SII+MIFNVqY5KyvWffglgHXQkBj7eynE49mlDViLfT3mjj9f9LLjuLbvBsmFcyEPFHrxUJF1TQnH0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YscIDL8VjcWrHoqnoYpLWxvSil5Lcz//0MrFY9+lHe06IGuJlsagsvOx4v/b?=
 =?us-ascii?Q?6S8Pdl7zUblvM1pTuz2e9ARkJUtvg4SYbU01z5q7areEjmPvKm3lq3hJi7k5?=
 =?us-ascii?Q?YGXvDCyOx1iSB3PPo7nS012g+2q8hVGiBEWD3tikYrtajwhdsKM2o9iIPqig?=
 =?us-ascii?Q?t3pEdLT65P1X60blBKpK3vYmLCd6GWqPu5ZHqWJK/CJnHWqY1dyvsoUTCtET?=
 =?us-ascii?Q?CKGEa2QOvo/QlselMuOxP8dhGALW101n415Tp/jWCU+Cw00d49NKYZfo5YyB?=
 =?us-ascii?Q?3+SQV4hDlVv4kQ0qf+zLSe9TgtB8FQWhMlC/soWjewxR0Kgl571G7w9Kk0r5?=
 =?us-ascii?Q?EIWd2MQ+dufrgTOeGWO54jMgXqpFRUFrWVRLDXHbBL3oUNi/fHBOza0iUEOb?=
 =?us-ascii?Q?atIqvnosrcLcBOeskbS/VooSBJDwzce05LEML3yDKZAUJY7sYIn7onXkP5W9?=
 =?us-ascii?Q?vGz606K3fz4eA3/y26FaTyOOEujO9rEwQvk/7yQGWrvF3BcIHD3Tn0Og35KA?=
 =?us-ascii?Q?ngvDZ0VoGzRW5ykuYLdlmoMIJGurviH03+2aNMSay5F//U4k2J2WIYWcHsBD?=
 =?us-ascii?Q?kMcoPJdJRRN5EcbPU+2TCNpegRwfeTKntxrcix1AFXhRPad7YO/SQOEThFM6?=
 =?us-ascii?Q?HglLgySy7PXgy6UCNfT18RtLOzb3+C8cPk2r+YLtrnuwLSslqztNuLR8UG6w?=
 =?us-ascii?Q?0iSnIM5vbB/g3HD/X47Qm60Yd6qPPfnWn7rZOQoL8IvYXHKPSe77sfFjkd8B?=
 =?us-ascii?Q?rkR/Buu+AfkljyJglqT0X/4DOXhSt5jQXPaeFYEdYGmjJotnTw2jQQqmBTZX?=
 =?us-ascii?Q?VO82/ekC2kiHcBR+B+jFSGIP9eJBKCypI1+tYbfJ7btwpA9WGhRTM3OU9ZRV?=
 =?us-ascii?Q?FbJNpC6nCxbZgPLbbD+9l4kRxQI2ecQngTR39T4HGPYYvTW0FMwPS0pWRRr6?=
 =?us-ascii?Q?MwHw3GZJZzRCtmeBy3WCRplDHvcI1UUsARvEbMvGe1iBQzUUh+4slaGbX2lk?=
 =?us-ascii?Q?xvhlas36VhQQwpMgIq+IGOVmU7lcijSRA3N5zZyrq50eEnG06fXm7H54J1ZO?=
 =?us-ascii?Q?pUKteuuvWa8btmHO+euw0uiVUUIB9gDEbPE3pru2JyCEgfQRBpCdYTHH5HL8?=
 =?us-ascii?Q?TyTrT+v8kdHe7SJhtCB1qGcXwK9GvBzJhpu2HwrH4d2ujX3RcXgFyl2WPgaq?=
 =?us-ascii?Q?PSe/uE/hTU+XyNJx/DJKSCf/cCvY3yxkhpeeQjmxrmlI8a3tK2mP9TP6CqWL?=
 =?us-ascii?Q?087Kv1KJw/Oc/d/GXlUwpwVxa4qTdj5/dPiLxAZwGgTbOmm4/0GOLECDy/qq?=
 =?us-ascii?Q?/IoCCIWX2zdg71umK5lesMoiFs8ar/YnZJ3UE6kstXDrKu4/DO53OBx+Llwe?=
 =?us-ascii?Q?S0N2JCFuKnkau2pYvv1WgfF/sDofDcFAfS55mOjBVSAooshP3BfAmZR5Roe+?=
 =?us-ascii?Q?DcSuBCR2c5NmexMVFQ6SMDCmwkZwh0ZEo3Uzu3cknuEXtWbioOQopp+PVGS5?=
 =?us-ascii?Q?5TdUld+qVLgfDhjdFJmSSXN5Y46rh50t5Xn3akW24xiQPL1SdcT9ZTv2mfMM?=
 =?us-ascii?Q?PJXZztNDTJpPwcwQG4V/n3mtwHG3qC+u+Vd0+0v3+WPsT2Ei/ZAEf3a4Ugg2?=
 =?us-ascii?Q?CLqSZWi8XDYcq+qq2bYEJyeosbc5pc6NmdL+INrYXujXYvsWVlhWT131QqwY?=
 =?us-ascii?Q?Tpxbw4kXL1eF5K9bxx0zEwETnFQooPD8LZCDaHAnWbXziW5o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f552060d-1625-4549-cef2-08de9f9b1737
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 11:42:39.4193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eb6GPj4QRbPjsWcnvxlygx5QyweuHxWkL/4nCLlFwBgghQ+muvB9nJKf2CbEk3TI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541

On Tue, Apr 21, 2026 at 06:00:38PM +0800, Wei Wang wrote:
> The macros IOMMU_IN/OUT_ADDR_BIT_SIZE became unused after commit
> 2fdf6db436e3 ("iommu/amd: Remove AMD io_pgtable support"), which removed
> the last references in io_pgtable.c and io_pgtable_v2.c. Remove them to
> clean up unused definitions.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
