Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012067.outbound.protection.outlook.com [40.107.200.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0936922D
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863508; cv=fail; b=Q5wKKZ/F09yjaan1D7FfX1xd3tbf7W8teRLlruF+IjKwmfOzhTUT2I4mYwAtCsRGbZjCE+4FQ4o3qsFPjCq0jEOSJW05pRQUzXFEwdBqN+a2N6RYFpc+/eicivmiMMet/D2fcon+kGKnJ4KZVRx07DoCmivrZymL58AkQacT8uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863508; c=relaxed/simple;
	bh=1FCO3t6Vpy3aYb2eG/9TqjdmGVIgLI6c8Yc3CK0n1jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BZ5A8UO5YpzHRjwDirZM6QwuHz+D0gQYzFukSBBSBw1EZd7MJvLbPh0M1sGXeQZJM8o8L6YHX/G0zGwzSrx2uFGlkNoSU1B2uL4gHuupJbceeCGTPZ0LXUm/8figYMXdaqKd7PRIOgLwTNK2mVUkGaAQFgbT5LeoNYCdUqT4wvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AfeEor3g; arc=fail smtp.client-ip=40.107.200.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AfeEor3g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x200PQYWub870DSr7+Y9DV4/+NY+rn1DaJsK8uXzUupMc9dc+bma9Rvy8EQJuCLC7bni7JOusBQebWrj/O3iwobbg+W6BxL4e/dZXBAzoj1X7xppU08BSfTOO0wMyJGBkJBwUtpX1OZ8jhec35kft0DebD2A3A7gEJf86JeU/7uNtTmi2+j635Wk7aOS+YRFhLifh/lPLWzhBy2LHNdPM7hfWLtkp9n6otQE2/jhtZHSb8M6ntLtCc1z/NjJD+PnUkbWsqXNEf7i08GwpLB8pQE6BmIM301vjUikJYxOoK030x7icf134vdee6SM4PDqoTVT4X526euQydW87ZskHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHS9mBulvV8iERcwjS7N8DfUQYwDFWthNEUlctDV3hg=;
 b=hVRr27Uc9Parn6o+/iT6/2sMcQvBCKbzijPNGYowZ7QalF5E52ZVpLS/CYtm/2euULzSJBfh5h+xagrfIhDi2gp9zJlAwCkuSgUdg0iAVMspBwnXfmrt2IDnqA1E4Dc6RtR7DlB7JklFAZJXtXmCbkag63s05jAg9knm+ItV0OB7l9UCEu5Ul7zyn3aL//al9gLjjDPk0O2u3naGqZNm4tJeGkNxoC3EHwYVtW+2OC3v3cDCdzhxnEOpKM4pcZ9gdFeNNmRd7eMGCu5MLWkLXCkDn90FILgYztlApFuCIWxowyFUA7sdBy7/TKhSpqxptluJ6b+k83pzDpXfaixRNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHS9mBulvV8iERcwjS7N8DfUQYwDFWthNEUlctDV3hg=;
 b=AfeEor3gtzdMj4059izytGRR8MlTh/YAWCYg07IV1dDekxAvHXkoSrjAYvLHRZ7P/DwW9OKr3JsD5p0xZwmlzI1nBdXH6C4YIpt1lHde5YfLRnmkKuGU+h8/afWuUJsW40WewuSTFDazEivm5HkqviGJ5/pBKuI9gM501QWXWsGH4XRzgD5hqIpZfsYjGmwNXMXTfCt5nqFLGYogmYDSlTwxbbG50rSR63GohEQbyxhxvpoaBSGz75ogdbw9vStO2qYlr80xKmDtEmgmQxE7rMmwYT3419TpODazmZewbqa+B9D/Q7v9aH5WuJ+ETB4D1ErlXkR2qgGsMxQe5Vhssg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Fri, 10 Apr
 2026 23:25:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 23:25:01 +0000
Date: Fri, 10 Apr 2026 20:25:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
	praan@google.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v4 09/10] iommu/arm-smmu-v3: Remove ASID/VMID from
 arm_smmu_domain
Message-ID: <20260410232500.GD2588311@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <b6d87a722635d29e896b277cb60f0208859073d6.1773949042.git.nicolinc@nvidia.com>
 <20260410002734.GC3357077@nvidia.com>
 <adl0aEfBAKmBsMs6@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adl0aEfBAKmBsMs6@Asurada-Nvidia>
X-ClientProxiedBy: YT3PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: ece942d6-b5ca-470d-1b34-08de97586382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Y9nYVV5Qyd6BD63a6MPQsaP6pY3IsHhJ4aMTiiqozD2vI6PWqgOgi4/qad3zBCW8mNzLRvF/FVGNuj/WPqT62jY/gOqkLFfD0esiLH/1mAxo3MzVQXv1TyB4aCuM8MBA5KLZ3qnZ9Lpm1ROtbxZDCCJUIpaGYKs1hJlO2Sgd46vJ299zmKwpSmE18NhC2pVzQyuzSSShwgmWE+cXEcB1vsZfuBqxfXiWYESfeetgJDaqZcryUv8NJ5pVsAYBwTVY/TqFysmRuZIp+OR9SNbFL44N6KvT2wDp/9n7JxGxsg3rVN6R0AEoIHEn2gIZgyhCLp1elXytlal/URQw0Uydl/QFbUH1REWPYlP9pIwEodb4B6J6EquxPMlAU5LNk8Yqlmqr9vkwGfFHsnt+yfkfGvqZh35FxJFP64BSkimjLyjZynUy+KgMpxMR1953AMCDuEwqsJSvklYT06oKqzf/m83ruuSTvQ9lGGKyYKcbu9c6L4LsLwxnXCpwtJ1TUSWAAwvDOsvvUdsgIeIvdcw+13mi3SKUNr0NjvZ30TXQ61M690UGEWZ68DQpBbjieoxocbItTaOd5DYX9pcEexachJFMhUPDGYKdy6QVTiEjIKg4CSfsNR+tmlm4ckRxlqKXlcR4vdJoyl6XAw21CHlaxLanKW+uHG4sjGt/xwP47Z6fUliu6yjm3CS8emRXmlH6GrQATgxSGR7qCtNSCQH5gH6dx/y4/b4MYjjut9DkMKc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FSWkMqytM2QtcLwLR1Q38ebA8kqeRdTJDXF+cgy5joqN67UgMmD6SbcoXNpO?=
 =?us-ascii?Q?WKQ7M5eQI188dDj7MSQ6Xdpc6FKNaEoH8VUDLu7oihDkLsRb2bABI3cBAOde?=
 =?us-ascii?Q?TnrmwaKDCypvv2gxGggj5lAYsPOPvNnyXynEYcHCM1J/bEB6YXzOYANbPmDX?=
 =?us-ascii?Q?ydeGh1j0wnTtyMqh9s+XhLYMCAQxGy9jrnjLr2TxalJO26n6EONXLANcH/BX?=
 =?us-ascii?Q?GRzLiXrDhtPXXAVJtjRjAZNiLZ9HjDHKdKlQyBuy5PRUg+9PmJnmi3LGPzQY?=
 =?us-ascii?Q?ytlSP4izpCbL1iMe3g6AePD/PZZvF+dfzh81lhuj1q/9YollNrM0lLspOgwD?=
 =?us-ascii?Q?IHAfFS/5t1AHF6mf3WOWXDjknlaKA6lZaJhqP0S3UB8W8YFbe0UZqnCNJcWq?=
 =?us-ascii?Q?VZoo958nLcdakxO2L1MzBCEE+0eD09tKXMxZXJQZNKagwzxH5L5R8ZGJAZAV?=
 =?us-ascii?Q?Z4xQeE44F5oHKxXs+dxvrhFRkMgGhJFdeYKOtuqL4FaumcxlhnbYPvDPax9M?=
 =?us-ascii?Q?8QJWK+hyj/fpMx3TDRohQTwPiO/TO+fmFx74dslMXi2RKqXjk/PT+7TCqOYR?=
 =?us-ascii?Q?q99oXPi9JlczqEI2nXbAjcUs4FJqjhNBEKpzscFg8O3ewvvkAjDViDfIP92O?=
 =?us-ascii?Q?AjF+RqNZAyvlY3vmzHuADzwLT60ClxipjQLCcp7BUg5Y0ZD4Gu7HmBI6V2eJ?=
 =?us-ascii?Q?Sgmm5EfeWwwi2OTBtpNETDpbdLOa8WrXKeoVtPimxDFEgsKUyI5K+hi9q/Ua?=
 =?us-ascii?Q?x+vz+Dtr+4kRtFZY/kIim7B+914/qG7Is0+CPO21w1GcuFzVMIxFZL7vWNyV?=
 =?us-ascii?Q?Iu5Y2vUzISiMV2vzrmBQUe4vd3KJgR20/rm3IAN/BVmZRlrFGB2p64JFXgoe?=
 =?us-ascii?Q?cnZSKrdqI9yBCZ/IknfhR1lz29KqIZo3xEI2IQs54ItRE0WFzXA8Ssbiw+XF?=
 =?us-ascii?Q?ERdawvmkMPSAoseRxyTstve/6f2XhVP63tQmklVxtIbdCWkUxdJTnVexx7MM?=
 =?us-ascii?Q?4L/6Tx1stG+ykCzHHTrb/hoy9f+iGpuOA2GPWLmiQGlk2X2eDGEGaUJ8e5mA?=
 =?us-ascii?Q?aRe1EADPh54EBB2KMzHwk39m7aZDE/EKkUbvOWSi3zyKDvsc1h/fJUZ/F4Y8?=
 =?us-ascii?Q?Uzvx6+71B9DdOYP4v4nnpCQOc4zrevXVPGBhjS9p3bYtUcZRMxDT+AFd7XkO?=
 =?us-ascii?Q?LJU1KugaSZsjph57BY00GGGaz1S+rVE/dM59ijjeghAYCzov0K9WnaVSCjnP?=
 =?us-ascii?Q?Kx1zHX7VUqKBHZhUbxGNhKcBlCQlsH0c0XeaLw10i0qzqowNnoK55SW+KRYt?=
 =?us-ascii?Q?LGnOb1BOt7KbUY/r9UPDFOCZ4ZJdBjXdZyquukw7iwHqt1MedyuB1zrRmlcb?=
 =?us-ascii?Q?E2S9jkoaGpM8hdH1ZnJje3uRvGrNrcQQmvgBvnzXs008tzYxtJed36MiQPOl?=
 =?us-ascii?Q?JkypyCcQDUugphKqcJsrJQdT4HhRBCGcFituP15ILfvFS7x80WFHFqNjggW3?=
 =?us-ascii?Q?yIO5UPVAWi7VFvZsgvcEPu2khX/sDRagigTQCyQTdgKdqu8dxiach/M37SFG?=
 =?us-ascii?Q?oQYpXY8GvliBLtZ945oTh/bMXOPCun3OfE/bi8IA6W1DPyqv0wXPSo46OggS?=
 =?us-ascii?Q?t6/2RzBBecEJEE11XUHsJ0MkVHEi4JGzrgKukSsV9stsPFgCO101kfEAqTzR?=
 =?us-ascii?Q?fucYnq+PgMzJSmv/mdzJIZKCA4M2IufMcOVNscLBXs2/Xw/k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece942d6-b5ca-470d-1b34-08de97586382
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 23:25:01.7981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvugZdzyZIrjS94nov9kcjJyuy2f117i0X5r1R3PUxAWuLWj3ywf5dM8K6TEdqsi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

On Fri, Apr 10, 2026 at 03:06:32PM -0700, Nicolin Chen wrote:
> On Thu, Apr 09, 2026 at 09:27:34PM -0300, Jason Gunthorpe wrote:
> > On Thu, Mar 19, 2026 at 12:51:55PM -0700, Nicolin Chen wrote:
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > > index 846a278fa5469..0e48264ccd01b 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > > @@ -300,14 +300,6 @@ static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
> > >  	 */
> > >  	arm_smmu_domain_inv(smmu_domain);
> > >  
> > > -	/*
> > > -	 * Notice that the arm_smmu_mm_arch_invalidate_secondary_tlbs op can
> > > -	 * still be called/running at this point. We allow the ASID to be
> > > -	 * reused, and if there is a race then it just suffers harmless
> > > -	 * unnecessary invalidation.
> > > -	 */
> > > -	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
> > > -
> > 
> > I don't think this artifact has disappeared so the comment should
> > probably remain too. It has become slightly different because it is
> > now running under RCU protections so it will clear alot faster.
> 
> By taking a closer look, I think either the arm_smmu_domain_inv call
> above or any concurrent arm_smmu_mm_arch_invalidate_secondary_tlbs
> call is a NOP now?

That sounds right, with all the changes there should be no cache
flushing on the free path since it is now always flushed on detach, so
the arm_smmu_domain_inv() should be deleted here too.

> We reworked the ASID lifecycle, which now ends when the last device
> detaches. So, ASID was free-ed in arm_smmu_iotlb_tag_free() that did
> a per-ASID flush also.

Yes, so the comment is:

 Notice that the arm_smmu_mm_arch_invalidate_secondary_tlbs() op can
 still be called/running at this point. Like the normal detach flow
 the RCU protected ASID may still experiance harmless invalidation.
 However unlike normal domains the SVA invalidation will continue
 into free until the mmu_notifier_put().

> So, when freeing the SVA domain here, the domain should have an empty
> invalidation array and the HW cache is flushed as well, right?

Yes, but the parallel thread is still possible even in free which is
unusual compared to normal domains where it is illegal to call
map/unmap concurrently with free.

Jason
