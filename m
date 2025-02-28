Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0211F8739
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740771567; cv=fail; b=HcQdn/1js6BnAFVtuPbSbG1p1mjf9uHgESJUB6QjGY+MIfOSe/vRe5CYId65AgHS99pgKWrVsw66TuX9DzHS5TeMrBJCUIOBgDWGYWyFCYx6GVOm6rW4uEgvLvfxbAVMxEBBzc8AzBdIRkkdkN9kvau7ynd3WhIFaUZzwjFJveg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740771567; c=relaxed/simple;
	bh=4frMqwM/Sa+GwSuiTlMT+L/YGUDoRUEY6uaaV9LnmOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f5AvXuSAoippWfQ2JEd/MfnL8buXSgK1OBmFo5ZBVMku93UEaIp2Tva/LaBpnOnqnfNdswyci8JjcOwp9VIJxYMBJRKMhFyhKWh6/GhtA3MQ06OVD+/tiZT8eNUpNEQl8/Fapf/eIxhyZahaSf4peS7n0AKwYHaql6oYiXUYB1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZdI0TqMo; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZdI0TqMo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPFHOKoPaVso3IjF+sEJqeZkb4+4dvs+KVTC/oyk9E3nJ8KFFZ4F9qi31Vynp3IEKu39C+QGaGP7hD4vceX/hTePiH3gxgtJRGmksvov2vxnAbV8OXZ9L4R40sbelitGBZxTURetApEuucsggW7NtKzte59HV6tK8MTkeI8sRlv3cHDEPGxEDY80dIbiaenJqWI3lx28OvZKY6EMv/r6asIJSooxmTae0WR8n/azs4KlYLq9z61e4rvNLFCwOi+1G7GOAwiYizBW/9keMWE8R1S6sm2FQIBqGfaUhIIfwdHmimMBslL7SdbBAm28ZAFUNj4Rx4q0n9Cy14rkdT8WAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSynAbyJNOy8ADW15SEeHHUG4QazZBTKBfZFI43a9dE=;
 b=fpGGySXEGypq+iSv7B/PrrDTAuxAefLKZfQ3EBqQWVKYDR5DV3Dz4QGF2tbYp8cg36KW7JTG+nSk1GuE2SBAid4klAcbdctB188yGv35DXqP2L8I18+LYPb3t8nQWvTHYTBnI/VMgML+zGRrD4OAIJ4ZGjbhb0lsFDIab2mA7+otg5RTJAdJ7qyFnYpilxNRIzyZGUg9bHGPs+8MLBvj6G+H2HxZ3tP1J7XAAXbFlWzvJL/o4jDjNYsRwUpTuW9eOqagV/uqStN23hcZ5KsLmS4xMiStmpjXcNqb/Pa38S0T8AYGnIlJzBM/h/+ofYshiAaVi8IMZS1qSsuOZKg/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSynAbyJNOy8ADW15SEeHHUG4QazZBTKBfZFI43a9dE=;
 b=ZdI0TqMoijwkJYP/jrkOjrmil948t9JgGwpNUkHHeRJVFLjYIfh90iijOCjAup33deDszZCRdQP9MqlyMztGMC7b11jyrWFLLoxmLeNiLfaI8kS/QtowCTVIfV36EKMXcekCVJzRYpPyshNqE3XvIvUHBguag/MmGZIYgL7I6lJsTxtmrTpKQGbCYlsquE0OyfX3Oa3igXqTU5j7ZVF0TirnGc6kBZ/kPucv0a+uYB5bNfcysVy8JttCirt65Vb76kWDNKozU2HSsLa3ejdMlZ9gsHv4EdPe+5EimLy0pRIqthiHD1SAY4sReMoHpPuB8nt9if3QGSN99W5OgErLEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB7594.namprd12.prod.outlook.com (2603:10b6:610:140::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 19:39:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 19:39:22 +0000
Date: Fri, 28 Feb 2025 15:39:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v8 07/12] iommufd: Enforce PASID-compatible domain for RID
Message-ID: <20250228193921.GI39591@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226114032.4591-8-yi.l.liu@intel.com>
X-ClientProxiedBy: BN9PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:408:f6::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d186b0-3c80-48b5-68ae-08dd582f99c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m/KfHhLWukab75VIr6O5CFkUuP3CpeOkfoT2HPYbGVCLBlhfO/vJDPqU9Q/P?=
 =?us-ascii?Q?rpkVygDqoqsrhjx91Wgk+DCE2dyn6sTzGt+19KwksdqSQ6yJIu/NzQo9yW2Y?=
 =?us-ascii?Q?l97+D2KmM9ykMKlabTfio3wUCpCKL/8HnvaSFraA3bSeEwc3q8PiXtVd9xp+?=
 =?us-ascii?Q?BB4fcRmYbMZnJfgOoBoh4YR4GMfu2ZAwZRcbifrLGdWQzH+Q16i3V2nwHmmy?=
 =?us-ascii?Q?64IRalBROdG0xJLDvN1OIlC6w7/gkC137BGSl6U1gc5OnrwTQd2H2H0Yd+ht?=
 =?us-ascii?Q?6p5PtntTW5CBU4zelHX/b1535wxeWApfdNw0cvNxvcKMpyi+mPeC+M7Ly6by?=
 =?us-ascii?Q?O4zDiOEaMsUpxIf7gASbRUhIScfbqDlWVO12lpiCSsPTIxaodTWurNn/Vem+?=
 =?us-ascii?Q?TXEiQngBIwrhCYtRjptbRFw2N47vi7YM8j6bwShQiy/nF7a7yFVFthkkvmFf?=
 =?us-ascii?Q?9wAecedGFpMHWXMiYuGg34P5rtK79RUZn/lG/x0TLFpfyBQQy9+kfFckAI/f?=
 =?us-ascii?Q?yklY6NZZLeme2Wla6FsCfDIS9ECcUxZ2q5KzwPvJJwW7NuwDxtBX9MEIUlDg?=
 =?us-ascii?Q?j0M1Fd4bjyTdwlYp/UU8gXyAkxW1SFjC8SyWWHJdUmWPMt/XQYM642eaAlG7?=
 =?us-ascii?Q?rdZu4zI7KeDvUj+mVtMhsP8kYTxh1eM0LOv/BAC3R6qRzJ3eXM7dldhm5fdp?=
 =?us-ascii?Q?Pvs8Ghd/Yg3I/27bzGJouCXUfKAWNTr9UHSMFPtlMIsBZsB86+vXHMScuQ8R?=
 =?us-ascii?Q?UU//4vZLvqbJ5OUx6JhLgxaQfFy2i6dqjC1+EkTtrCmbcs71VMGXW3odUSok?=
 =?us-ascii?Q?Pr9joykKseRC3HUKky79m8tQPohLbN9R01Fxe3CHSxgiQxRpC124opLAKda+?=
 =?us-ascii?Q?IqlwBUm8bV7AGftR2kr1VNfqstPgKhSKfB14uk+ws+Ei983hfw8TxRGNTdK5?=
 =?us-ascii?Q?gGfDC6SIefWIIiqcfYsM/jTnd6uKV2jjAht/nFp+K+/ES0El6JfZG9iJFQJP?=
 =?us-ascii?Q?PaGlVMQbgMmcCbE3QCcmtLxFL5p7DNlBMAsF61x327nTLPpE4zBc7Sd15cPx?=
 =?us-ascii?Q?/Hl/ibmFZ+Kz7XGLQkxma9fX9cc0iq4c+S/Sf2TdzzjN+aFsyWv4vmi5XBPq?=
 =?us-ascii?Q?RJRbhQsMxOVkN5mGjcp5D2zPPErZWhJVxe28Bkv95EaJWeh33E/4fKUc5T5N?=
 =?us-ascii?Q?cpvuCAWMjL0BN2HNTHtQuQZP62Up1YMAPJRjYWq1czB0XDOwkkFQievqrGG1?=
 =?us-ascii?Q?DP5PbOy+uaR8XeJJqPEP+V0dNcNleEHft1UklMDVFLiEhknA96Ad6QlOvSp1?=
 =?us-ascii?Q?++JIY1WHT+exQVd23jO4n4kI+5ikYpP2esdPEHEmmxTW5qLBxKI+IhO+ankj?=
 =?us-ascii?Q?Q0YHftr9OgWexxrbn8UKshPN/Nn4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I4O93Ji0dGF1RjYpBXqloOTGVKKGr+ofrpck1pEqIWtF4KOmlWAQsu6L4V+9?=
 =?us-ascii?Q?YzrpIYdgLUULKTEBZFh/Q5kkcZ6nZO76/vmSpJL6XaVPgm7Lq1giKHYl7TGD?=
 =?us-ascii?Q?8W2Xgz7YtJlbsh+V/aWxcLJoj4RpDQZKNgv7h0VbByGJlV+yMoYVBzWuzEYX?=
 =?us-ascii?Q?kRnRbtbI8Bra4vtwuy2tx4ERyzKvlhzTF+Di9I76mJMGzpbMkM6zVgY6pXsQ?=
 =?us-ascii?Q?1qFrBcqWhkzRoGOASPdE0rVITueNDa9C7ssF88h5Ec+1ytTiY+iHnq1jLmGI?=
 =?us-ascii?Q?uKogCRYj16rDWKEpm8ZWgVTCDy+1lQ5HeiXa4XjO4ZP+Qw/A21hHBJ6+lX6X?=
 =?us-ascii?Q?zgRqPrJA9YaVPDx/KWz36DpxKht/8sVVdVW9WeMcm8JjBzWhZm7PLrv8siFT?=
 =?us-ascii?Q?8/Xf5OtHVEqTpUWwmiDoY6P1Mmu4s/jk3n8KWyC6+AO6Y280sBF7IQ1iwS5N?=
 =?us-ascii?Q?Jsfn5MWUYyoojVeKbq2ZNj8ou27QDGcAr1r2WskO9vl9TRS/hmNzgIfAjII+?=
 =?us-ascii?Q?yfCuP2v/s5wfP+i7e+SoJbH04LW8zb6cVaJGeiR95M6IKaTVmaZqyAJo1DXf?=
 =?us-ascii?Q?8kLQQK6/i8OslweW5v7HB10nf3XWzORivespeXxc9n64lTV8UrQr+QXcRzOQ?=
 =?us-ascii?Q?H3itnzARgRDkUzkhK8yabZOrwuC7OqJtvyu5zER4QcoYShZuqXlmG4Ru+L0E?=
 =?us-ascii?Q?TuSxbZ/49okHohK+rGaN7p0nPA4K8ukrlaK5Gru4347lW9ab7S/9PIX1Uj47?=
 =?us-ascii?Q?Ytv8NSJbS5j8/eCakW+KGLBznzovS7vUm0lZMxvTxae7CmHHa9vPwh2BEfGA?=
 =?us-ascii?Q?YNPtlc3y7Ajapg7nDa+YHgdMfg2p1hh4Lo1Z2XSKnPSRZsG3BIcpk8I7akPU?=
 =?us-ascii?Q?A9GRI6ciTOw7Nd7TjLjkcxrLTiOlGAcci/PnkwXSYHgp3Q5ynVn95Jxl7pw/?=
 =?us-ascii?Q?+C9ScFkWNgI70jEbhdIOGEl/zEZ77ELapEjF8zs3Cytw2zXRIYUIb+aFJl+S?=
 =?us-ascii?Q?yV/CdsIg3We4KcyTM/KdNhcWHhXtoN000qNBKaCRwZ0aT1EkeWy6sJ4o1hul?=
 =?us-ascii?Q?FukoCktRMmb75MYTmhi+kb2QPQqCmPJ8LXCn4tIZgxh4jLCNSJjD1V+kYxNO?=
 =?us-ascii?Q?fxzKZ6K+nkwswmtz5zXEyTSLoJGQklyxqcqETnSG9QvtlBDyU+4aHVMhLIRk?=
 =?us-ascii?Q?sqa9RzDDHVocsKseX56Rae29S2eJMTTM/64hmWXE+JS8AyCi18/P7k6SStP/?=
 =?us-ascii?Q?hXQJYn8NC7tvpyqOthDZ0jnvdX7ryv5ldfIi/4k/iIQeiZDuVEF80I1RgIdr?=
 =?us-ascii?Q?mv42vEsr7L6olTMVmrn3q+ZhsvxpXYWR1taeCUDpiNVdIibLA+HInt1kMajE?=
 =?us-ascii?Q?QKJMpHnld5VwVotDIlXT3KQN4b+SifnEG94xFupeSFP//PQhAQUNPnKP2p4j?=
 =?us-ascii?Q?RFXJFGSeJ5uBAfrtpL/oU64Zx/t0jxib5HwHktI8eYmsT3ZGWxNNQjj3s+vz?=
 =?us-ascii?Q?SXKgZl/7EreydxIJ0QaGPK4kLIdJJNBIopwneyi6mdPFaSMuGgG/qgACuZav?=
 =?us-ascii?Q?eMBUgs+jUXRbJF85aMgLeESAbxjxpBSqudsviNSe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d186b0-3c80-48b5-68ae-08dd582f99c2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 19:39:22.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFhPgrObcgxFd5Io9URvbKQleHh0KzO8c/JHvbDpJHQIp7idxi7U0HsVEaZgbMSo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7594

On Wed, Feb 26, 2025 at 03:40:27AM -0800, Yi Liu wrote:
> Per the definition of IOMMU_HWPT_ALLOC_PASID, iommufd needs to enforce
> the RID to use PASID-compatible domain if PASID has been attached, and
> vice versa. The PASID path has already enforced it. This adds the
> enforcement in the RID path.
> 
> This enforcement requires a lock across the RID and PASID attach path,
> the idev->igroup->lock is used as both the RID and the PASID path holds
> it.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> @@ -357,6 +357,22 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
>  
>  /* The device attach/detach/replace helpers for attach_handle */
>  
> +static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
> +				     struct iommufd_device *idev,
> +				     ioasid_t pasid)
> +{

Though you could move the hunks adding this function earlier in the
series

Jason
