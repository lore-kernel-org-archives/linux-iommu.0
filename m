Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423DD42A83
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512032; cv=fail; b=Imxas3AQmzixt7T6/V2hjTJ/AFYW28UKbHf/hdf/SoKOV8zQCp6zt+jbtHGRh8BrUa/pRNy7l6vQukXb7NwSri9WWuT3/MtMXaNij1Be1PjHRsaNKZ2lMDdAzC8cna3uE7XsHvmf+NSwhcoCwTc17/EuegFZMQK513PuFv2DkkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512032; c=relaxed/simple;
	bh=8pOAR2XsovIbnsdfgPRK8EY9RLnoKxHRGL+lY5K2VUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uX74wYCHQBbt7svPHqC0MpXbeWkRXnaU9gyDOxZYr3T8LFE6JgCLpPK/ZnU0JBDsjH4WzHasNEC6AJ2QJVs2+77QRYo3Y756lABj/OqLW41HSqVWJwt+/n1aFvm0qu4iNnPepHqvKrqnKMps61Vt4AHt0AoRd6K/fV/QQ/dA9JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NIfvyZ3s; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NIfvyZ3s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAzz70du+YcLKxY8xlq1ALnHQU16o0R2yN4NsCleGB2sdgZDWgXj2ln3y/+k2QKulSPXopX9D+xfoLd3EUR/iUIolYuv/jZ6Fr9fogG9NrLOg/JpI5uZuVSib60OA0SDFgEauFb1qtjL45+Rcg5StOBmIGg9iZqn1CXqKVfLHQx83CoLqoK8Ss9Su9nAlS0ex4xRBg7xzY5ZbRYRokcLWtmb+uke9n0oj3dNQDJnkqWdw2Wp8/g1tN/ErG0uDSxCSGjLCYrc1Txlaki3XnIUqzfnDWGTHf8gwJpD28oRUitVbqo/0Sr0PlBQPHrbMORVTSU1BQrVOSZiu1Qf9U7iSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0DI7B4ljCV/lrBehYsB1oTNnGMclgi5sV8mESJcLq8=;
 b=YZPMGgRjkyw518GS4fmSYzNvXlnzwQoYysHX1gXoPOunlU8nmIh3l+GYZfi8zxZM/ntvrme6r64i7qfzlPe8IVS1mxRYN5UMW+/Soa513QQCFe+tFNqAVVUThhGAIAT/WTuMhlnHF1YfhUkeIN4a9ACIyNC+csU4DbfzkdcRDXHXo1z4y8yxA3peXAtHASAVizPv6c0/LQaMN6/Q2UcBIZVWEakxHXAoyzJl6UzDq49c+pKkDlf3u7dTx4xUDgTfONtaE1LnexpHBIBEQeozKIJTI/KNezCcih8WAnellIZjXM32l+O2ZlEA5Y5HfQYniabEnhPhs57T10nvx3UmQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0DI7B4ljCV/lrBehYsB1oTNnGMclgi5sV8mESJcLq8=;
 b=NIfvyZ3suJReRWJC4kcyez2tRofWKiCHCfnGOIssh50XM2zerZ08FkFyYUCgqLwXobRvsgzFmhfYyNonzYO87FM22ViLggJbye7WPpvjLYMZRKATOoOYjStT4GyiewxF1FIc+5QCHa4uqFFB2uanIW7of3P6ExEqlXkfSqeumjFlVMNylUozfveTKhTjKPabc/qPsYyRde3Wo1+fy2rO4inwktn9WfuutvuxOcLMBW9etPxY3eAHbeOqU00mN3PVI0qu0ygsjzGqRsvy7Ol6mD6Gg9c9/B1TEGAHQq8Zm8jUgGiFTG4jyo8NcD+KeOmg55QoueewkCspMLQcky3EEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Mon, 14 Jul
 2025 16:53:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 16:53:47 +0000
Date: Mon, 14 Jul 2025 13:53:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	will@kernel.org, aneesh.kumar@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	shuah@kernel.org, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v4 4/7] iommufd: Destroy vdevice on idevice destroy
Message-ID: <20250714165346.GI2067380@nvidia.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-5-yilun.xu@linux.intel.com>
 <aHHG/H6IT9lvYy8x@Asurada-Nvidia>
 <aHKfwQ41x28bNWAL@yilunxu-OptiPlex-7050>
 <aHUzCAM8NKuFYbj3@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHUzCAM8NKuFYbj3@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 096463d4-f738-4b95-0565-08ddc2f70022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QBWwwcOh+6hprC44Ene81CTL9tzZsqgQaEcSZT8jCyqhQqzShaj91T2d5ofw?=
 =?us-ascii?Q?z0wpD9MTYMNcTiEfuRqbdDvdaAcISSpmI02pFFCNgFHbDzDpJz3U3D/oXQKH?=
 =?us-ascii?Q?Zd9ckxFHEEXe4+QZf6NllrpJqchagxvGfgVKx6Lo411f8UZBFE/M4W7i3o1R?=
 =?us-ascii?Q?SplMTrRC5ryebh84hIhXWQADZ9Ba/DHdAaLpuBzUY37QCR91LndieFe//I2p?=
 =?us-ascii?Q?lKdpZqTPkJvnty2tKmiUrZSUGDlUWsK9LldS6s77BVkTsqlioxkzFx8mffPf?=
 =?us-ascii?Q?+Vi3JwvUxjGu/WA+VCHnkQYUMYg2tWnk0pe7xQbgFAUnvgKsIrCjuLtxeADP?=
 =?us-ascii?Q?zfrOktqiu3tqD0gTxE088nvFVEp2dj4/LYbHhM+FoVz+Sefe90RkxgOQWaRo?=
 =?us-ascii?Q?j328b5yl334Y7DMfZvgG5BhBtMfKMWOoXNySciTgP1vdvyHHyB2AVpBn/FbT?=
 =?us-ascii?Q?Iohv7IqzLZSlyfNkiIcZgMQwFCzPLnYapSCZw+m9XUWB6/2oi+DvsfvCuaUL?=
 =?us-ascii?Q?Bf1FsoQSGXf3BtfSFYzewfM4F0aY6TVxaHDyDZcAo/5XgPJ9dgVaVI/J1mu+?=
 =?us-ascii?Q?zXKKSaYQhDpspCkAbXmLugVT2vZyuo5c3kLvO036uCTqaF61TlVvAABUDcGf?=
 =?us-ascii?Q?hx9uWZEBFy4y6x1ubqKqChLwnL41yQNRNoOb1Z3UDNrq8VywDU3Y5k2KvwIR?=
 =?us-ascii?Q?ZG2JsBP4/XF7IDKkAM3ASu+WIVa9Xtqyw3iKHIYIbBjT6PbOwpMWFsBJce5A?=
 =?us-ascii?Q?iY76CZS9zUXfaikyU5mz8usxfsEDO4EIJPZVGhGJ//VzOURwbcZB2FLpj6qm?=
 =?us-ascii?Q?4S1dgNcQlNx3BIF5tnZSRYOTCWD2cKIbMZfWKWjgi7kEKopWFofcX3a8ULhP?=
 =?us-ascii?Q?QONjFh5HcW7RD5iRKZTtOjQ7rq43nsv1KQL5RhqonhiYxHdXFxTTFvTNeiyy?=
 =?us-ascii?Q?jVOGY3mRsQZfDExFaCba4O5kQ/4cmDPGZcp3pXAC70YmRb5LaXGJT3RXzNhQ?=
 =?us-ascii?Q?RTCwXLqtRAJJRHz9G1Ox9LTbkL3eMrOzoOOfvtltYildinPINIiFgff63AjV?=
 =?us-ascii?Q?XE6WOX49jGyxDmg6a6AGLHTvJCaVCleIsClVR6vUIcTU3Tvmlk6qEYn5rD1T?=
 =?us-ascii?Q?aBRNDaKKVeZPH24PFX3XB9Mb9xS4PbtPFj5dvwNGU07YOdhcMLqmqfuOiFRW?=
 =?us-ascii?Q?NJAZ/LVURx3Dq8C2Vx9s8qB4nIkjTmRAN95MBryLTPi9NEj5Tb9KxCXtUw0H?=
 =?us-ascii?Q?Fe8n8jUx5kC5I4zacOeNnPjF/PJHdDFYGVi69SepWcz6BNkWGxbEbho4swvE?=
 =?us-ascii?Q?soyAsPoQbuJ2Y+gQV7t895iofWQ1se2kwNFrwK8mMA7tjzCAoNZIjPGoNgzt?=
 =?us-ascii?Q?ZHqtcEGQhG3Qdu2HxOG8v0fiQ0ORT1Xy5NPFTNELKRjo5W/MJmdimYAYoLh4?=
 =?us-ascii?Q?Pf7XSL6swJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t0iMnHrM2ztCuZDkARASs/DsTnJFBjBsCfe2JuIov1Ma6z+gNt5Xr65Lv4ii?=
 =?us-ascii?Q?xaOXNqpNlSK0sfGosOTvRPxC0Xcr82Vsm+PzQzyrcDyNjNKoWGkWPjKIZx0i?=
 =?us-ascii?Q?zRVop4mzaWWkB6Wvv2WRapr1nfTbjHPDrc0loN5E96shXbONXt6xj5LVkAjc?=
 =?us-ascii?Q?3X5lBNeJPw8gvHi2JreDHqz6PLefMGq8fjIkwP+0ZMdB1ZdJenqn2wqkkiZX?=
 =?us-ascii?Q?ZhISTgH/t+XrG7Fe8dt7/LeVw+5hYyOvLEVfiCpHcCZ3ya/iNSeC2E+e/2ac?=
 =?us-ascii?Q?V1yCTHMFvhOBi/cZi/xvuwxIaJomGsOJlUnT6qLkGXxYo7kzMjh+IhPmzBqK?=
 =?us-ascii?Q?YBEMBSt4PnN+M6larpglkARRm5RfPFnQCyzXW7+cj0FBb2HwlT/kygB0IeZF?=
 =?us-ascii?Q?UP106KLbyklOyOUEOC/dMHJU1h+XPPLXs1rw14yx7QfV3ni6Ma0mwbi9/oD5?=
 =?us-ascii?Q?P39gb2Sm/FShWS6gg25afUhDH+E9sjCn8ZpPFIg7sE6zrR9afFdRT2S2V0HW?=
 =?us-ascii?Q?OQVd1HZgPueMaRxngXSVTPi4bqJCipLeICUAxLQV2ZiWU+wT8OY93DwSm88E?=
 =?us-ascii?Q?TLhVDKI3tvo7JU8BA80UGCCPWDTCgWPybrAS4eyIIN3XbEAHXS2YxaYCafA5?=
 =?us-ascii?Q?/+KxnTxo/WpW/RNEumi4x9l4o8D0ALmxj6iciOudcRZgso9IDYlWrj21AxZX?=
 =?us-ascii?Q?4cUVljuEYG2639V5jFZXEWZoEX0JBo0e5pbKc7UtCnyfmfCIt5kiIV1tVGnN?=
 =?us-ascii?Q?T1hT7ciBi8UlOuuWLd4KhMkiMr6dERsfX4YrNZRb9m2E3+fk/p1umGn/fVoU?=
 =?us-ascii?Q?6poRV/CCJOG5k+YgMNwLkfyyMvA3ic0+yOw4SxCkbduBhGDuVMXyNxvBIocm?=
 =?us-ascii?Q?donWpSBMcPKxJ4ZHzo2C+1vobPZIueOfjzVcEzMozh2hq27EQMYG7NOzKIp3?=
 =?us-ascii?Q?Et62jLRAOQLImkpMWrvJE0O2YykilpbcAGyzrF3WDL5wMZn8XoKG8V0/tqF5?=
 =?us-ascii?Q?EHPUBviWJkPmN3gKhQaZBNkEx635eK6JfEe9Nva4p7N/znpKJI24SKHPLwpg?=
 =?us-ascii?Q?JaMMUJF3dOnSYt72JgpWnlssIUqdCkPSgdeCXzY7GKNI8ZgJa66otuMqPbJB?=
 =?us-ascii?Q?f9PrlromJNunh/hFw9zfNzhVezBRnExgX3xZpS4X7G5vRpYfTdpuC9RJ1Sq0?=
 =?us-ascii?Q?Hgpb87hoUyPnLK9jh2LEe0RoNjzufCs2NmqTssM1FLszKnqINewqn8METmPE?=
 =?us-ascii?Q?9oqohz8w0hB1Uvby58RTmHJ76bxtAeAt5hUzoxgB5eCBP1Q9ieEnRLCM598I?=
 =?us-ascii?Q?lhh/wJeiOZ1TB7/EMwJGuZffMfTpeTMDkuS/Blkw/DO6B3+dJo87BEH8iaD4?=
 =?us-ascii?Q?Rt4cTJv//kqfGn7plFYlHNPwcTCZBkoAqfVUV39YOMeu7c7JO6Ak8DXJwlcq?=
 =?us-ascii?Q?OteRRqh3HrFrJA7DJDOCu2Trd0Ez2m1ciXSnlUIqFA0AjjveTQnL/bpUtGYz?=
 =?us-ascii?Q?3U0PMlNV3TGN7+0rbCQBU9r4wMo6de/Tba+EVnz1eLX6PV9+gaEq7QHJzqhk?=
 =?us-ascii?Q?CcgVwnPC36peOLqW1/kNQUdZH1lwCs0Go4KbCrhE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096463d4-f738-4b95-0565-08ddc2f70022
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 16:53:47.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5qP4F3Hc5kdQtoNt1mbf+Eu68C1T1zxC7Ce9rBc9RHhAsf9jbWee5f2Lv9DyD8n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357

On Tue, Jul 15, 2025 at 12:40:40AM +0800, Xu Yilun wrote:
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 702ae248df17..bdd5a5227cbf 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -128,7 +128,8 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
>         mutex_lock(&idev->igroup->lock);
>         iommufd_vdevice_abort(obj);
>         mutex_unlock(&idev->igroup->lock);
> -       iommufd_put_object(idev->ictx, &idev->obj);
> +       refcount_dec(&idev->obj.shortterm_users);
> +       wake_up_interruptible_all(&vdev->viommu->ictx->destroy_wait);
>  }

I think the main point of keeping both refcounts is to keep the above
hidden in the main functions and out of the object functions.

Jason
