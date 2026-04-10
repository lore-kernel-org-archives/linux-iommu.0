Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E232D877A
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781390; cv=fail; b=iGUrI9/FdDlSWOVRdFurxSxuWhQFxb1H66uiSMftZHxWvhX0p8QTTr5zctEKA8p0ivbneojjvP34h6aMrj4+jHh2RskOLW4izUigvbFgPipcbByGEooRapCLIoZklkOYB64uoa2zx0lru9xmNe0gbNSdNJfVRbPj169XDL26314=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781390; c=relaxed/simple;
	bh=I0fsxIhz0ITNbeGh4GNC4eyV9CX1UwWXQfZxXk/HcjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mFiil1eISou4K7r8Fd0iqSwodY6HuVi3pOrwfMdEaqgrkhBL13jqOolOTMhmxFP71zXOl7os5jedapKlFEayTG8i9RuHCvmdZzABGKAgsvJlMSr2I/G6YHL0+vvKCOtc55JBanWnO+QOsLXwSKhcZRUX1XBfp/WyC+sXm3FOOQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l7k0K7gy; arc=fail smtp.client-ip=40.107.209.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l7k0K7gy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKkSbcTQJEzqcGRS5UK4IXjEPc8RDmRze5v5qFF7B6HwXWvN+3CUGXd+QuSRdTy+/uom8MKIcYZWnZg+g3bZX25zIlNFBdZZNg4lmuA0Y2oSNeLKT3KrV/8GJRyaT8/MPDzBJsgbaJy+AiMyxx/CthnlKI6jmVEv8XJbhIcHg7KsBNEBuelRUFmNyuK660SLt4KWBRldrL/ELeodra5maHZVHTD9et73PJgcZ98DAamrqMGd9FnusSP7PAXiJEDbjk0NYx+5nnIM1tll2lSFl4l4eToIj8xB033WZ2k+csVNxppaXC94Uezoy35emAKYaHgXMpZEP46zDD2rE4TUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TSMAFk6dwRAZyxFmsiZ3Nsk8QbWbYIEiJCUQLBoQ6o=;
 b=kANF5BHv53jS1ZKKy4VMHcVDD0kKYvYbnobp4v8ij5mC95EWSZdLgTPlAxmmpdLQ5VetOgG2WFWimRDZvyMHYqA/u2AfGU5fpbqHTWL7GGd2Nr69Kb/H9QfBt7VbGJtJJ5cJe2PrxzE6R3zETKnyD/xMYzdUO8/0FOqtsYuYoEZuQslDuqInESeoZo5IKNG0B0fowDZ/G/YNKdL62HnHA1BCDSUezjeqN+7ZUES+f0+eRKsxVJxXJw64ADCfwt59TMx+fTVTQ88LGSR/86MihVz04fYTSW9k9P6952mmhAenPQFD1VaaNECaRGrtN7Sd90Bn/DbPRpgX51hdOZ/Gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TSMAFk6dwRAZyxFmsiZ3Nsk8QbWbYIEiJCUQLBoQ6o=;
 b=l7k0K7gyVG0E3E3/POl8MmsLzzCa2jYwBCpxp+dnI71NUVrDAQHKQdt04FXdjf3n6L+FmnRPrs//RUCzxlQ8sB4u4ISge36z1HTgvRAeX57WBuyZJz82vB93d6NUKQGBhPnbTgczn4q5jdd5gKsjRw/KyHd7Lt3295M33tKTL1VrTyRL2r73FBz4s5KbbjZz3fj+6y3NlS97HKzXURthKhJzfUIT+4rlhyOJmdX3uen0Ha8PDJpfIGPpPVZEAUiLXcjWD7P6QTkYiIk4qPaCZ+Oc+Fe+zajdndKMpkciaBANI9GURfhdLat7k9FpI9y9S3eNqQIUTBk5NILUEgaMZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Fri, 10 Apr
 2026 00:36:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 00:36:25 +0000
Date: Thu, 9 Apr 2026 21:36:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
	praan@google.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v4 10/10] iommu/arm-smmu-v3: Allow sharing domain across
 SMMUs
Message-ID: <20260410003624.GE3357077@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <5293b61417f96dd58f25fe797e7d0c20dbe30da8.1773949042.git.nicolinc@nvidia.com>
 <20260410003223.GD3357077@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410003223.GD3357077@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3e4251-c362-4e32-ac76-08de96993246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WoeGL39TNbfbWipCYiSU29ofYXND4aQb1tFXdpicVfLtpNTWhWljhdeHrbACII59HpzzH9s7WK/SUq5C3TS3MlWQZkGlhGL0o7ubu+pKhj4NLUC2z0jtBqQtV4iWPyxS7wB/drCvthu806450VsI3Mg/i11jYnq8Qk5l8u5w0WYWs2kFUTjtQ5uUfwUbUkCbF95cEAkrugP7PWSJmT+S5MjQZo+CTd4Gd1PkDXiHff0Ge9H4mo66XQA1eGwiO45V0uqZIjTHx6nt/U7dudU1uJw+1vtI8MW8PF8nocyWXOeVi30sL0RQSGy3HesfB1vgv0bAECrqnKNPe9NTE7nbVEmYvCk29ES0L3ORxTPFriA15pG9C1Co1GzAUZW+njy6YwNS89gyw0s9HNMxiivDb5MMg1JtXgBSFS1+imeI/zPZqsMvTQhHV5O3VNMEQnrQCrIs7zqovAhy6/IUhVm6MDqWgSlBCecO6zDb94YvNpaPMZYb2NGNu8iTwvJ4EjAfdER7krwVNLrw+I0JsSJEdbd+UfW5DooKhMLYmyN69t2CyGxlu2nObo/LRizPHF4LyzIyBXTAjKdWcABciw68UE+NQhjgFT1i3DbRDuqxgtN1kJwFgGk7RSxsEBR10czdp1mIwbpcoa3irlo8xjVj6Y156rdwUQpA/Tetu8b+h7rN1fgsqeV4CRVXtfB8YXFDvQpWhBuOj1hyR2l60AWyySbQMGyIDG8qjXmcIOKGogI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s/Hj7e6vvzvdIjzwO3r/xknkNAtDGNXqwT2/H1RDx2na7JfGirnEJqeeJqWG?=
 =?us-ascii?Q?7lkcsQ5EXifzuwCGRloVimi6H7TIulRlKSO8aXj3Ectk2JPwyhU0o+IL/iD3?=
 =?us-ascii?Q?L6TrpN84oHuSTkRa9CxQ74DATBJDAHfcG73Bms3lKKuFLJwHEBNH4X8SdUAd?=
 =?us-ascii?Q?0RbhKfIsrxMNa9naLhHPYApRQdU1Tq4XaW9qdZeeuz/uqU5i5UULRYwHGWba?=
 =?us-ascii?Q?Bt1QmnSCkcb9ioUppECw33dqekMyQyZfVJceV2E1yK+gPXxAUGlOy36ebIpf?=
 =?us-ascii?Q?ql0RpGUfRa9ydxGHrCu7PDadzVKfKS+Ql3/x0Z09wFvQy/b8u5GALkcwsrm4?=
 =?us-ascii?Q?3od5xGeQX16hlrP6QuZXzsXbnNSKHYbuy1+Wv7CK6uzRGg4tsvQOuLpreoyV?=
 =?us-ascii?Q?ekPro/eyGl0lIqMjtwbOTyqLmoSD4uQDARD6J7UlFnj0wA0UHR8KZurFyg+J?=
 =?us-ascii?Q?P9K+cRdyqsjcxVkJUl8ysrVBLtJ5M3hBd9wFeBI/7oroURbYlkSNZDds3HNB?=
 =?us-ascii?Q?qRmMzjBtdLJpeQSZLHC1oSiMqbWf2gKyDCsvl7dhSlkkC/0gN7Zc8+QH/I33?=
 =?us-ascii?Q?4XQSyeJTAcJJeJwS1v/Dfzpn5Ol+n94xFZGSmXeoG1HRDHOVJ1yrytkVa+Ic?=
 =?us-ascii?Q?tWyE/aJMQrsDxnigvhok9MBsLn1pkawB4Qs0ISUjvBwtRXpfQCpBYfr/31Zv?=
 =?us-ascii?Q?+aql7JLYQgVfXKXTrozqSoVdjYKI0Pfmqmm+kY3yRTGvByAf9P5rVhJtiwxL?=
 =?us-ascii?Q?8xZs9t4EAw/Olnf9rYwiVuW9vyXkmET8GUOlAbB6h402B7kFPHo7vTGnryXs?=
 =?us-ascii?Q?vC0E5oiplfqFX57ryz6l2b77rLKaW4Q0ZWhnnRECYylmkuKaq8wYulAXSGMF?=
 =?us-ascii?Q?Vfjn9GliF/1M6oQbnOnOS3X7PNYsXpwaVtkNL7OnbI3Xw8/+Kh20H9LIa1kH?=
 =?us-ascii?Q?yz1QZ5X4AQbOmOCQM5p3Xg1plO35tn6rXF9ndLvJYYSoEp1DLv8db04eLQ7L?=
 =?us-ascii?Q?+UWZiksuFLiiwzeFWXZaC7e+I0YXBNqnQ4jy7OOd+Hvjt4eVeMDx/G6QKZVz?=
 =?us-ascii?Q?s9gTJJvJTQTTWwyf1uuti4viLp7E64g7rl7Lnd8Fj+L6e+V7w/+y+qhZJt/N?=
 =?us-ascii?Q?3v6w8XVZC0vLaqWxRvqtGBXdoxyr5eXLmHf69eFpa/Rfp/sMmMPQv2RbSqjR?=
 =?us-ascii?Q?cjv6EdEjXz94BUfm95TcV/Q/GBmItqRA5nHQ+yAKUtFvH1jItZ9iMqNIPMQB?=
 =?us-ascii?Q?J+cb4VeHNprX2zS6q7mvtfWjxMexEZfotSwXrcmqFs3177ylx0uChx2kI8Md?=
 =?us-ascii?Q?cUZU/Suecu/O/+fE55RWORwcWyed4b1+mmMv0+vJVj/2hxgDwUNlSJc4h41g?=
 =?us-ascii?Q?B8leCaR7E6zpdxp/pN6IL9a+EVG6O4OqwZ+A3kZss0EBr+VN5AiuSnKGbbo4?=
 =?us-ascii?Q?QG/+Co8lV4gGUpTm5DXFj3Y+4dHZAHGGYsOZDttEF/ETLaIVcK2WAOMu3o63?=
 =?us-ascii?Q?iBfrDyovtXWWPYv3b20zMVOgPyj5vQShYQf9+ohnZWQYHxhJ8mG5K1XOHZKG?=
 =?us-ascii?Q?hMOJ/4eJ6EHqaiFchM81LJRS+VaNz1AmTl7GA8piCGx5KWqHGmH8ccYBdSQq?=
 =?us-ascii?Q?wC0H3TVjifH2uX2qk3tzwcDEq0HhSZ8sVry+JQqlou7adlcwjuR+ayyXCv6S?=
 =?us-ascii?Q?EKfT3cNgH7u837oYABFnuV0KdZpiJanglnXALgvDR8ldUtUN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3e4251-c362-4e32-ac76-08de96993246
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 00:36:25.2354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYlP7N/S7a/QSG/hhZL6JE+MwHY+5K4+5UNNHVvqshqVoiDoWD87sIn0CL29KdBp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136

On Thu, Apr 09, 2026 at 09:32:23PM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 19, 2026 at 12:51:56PM -0700, Nicolin Chen wrote:
> > @@ -987,6 +988,32 @@ struct arm_smmu_nested_domain {
> >  	__le64 ste[2];
> >  };
> >  
> > +static inline bool
> > +arm_smmu_domain_can_share(struct arm_smmu_domain *smmu_domain,
> > +			  struct arm_smmu_device *new_smmu)
> > +{
> 
> Probably a bit big for an inline
> 
> > +	struct io_pgtable *pgtbl =
> > +		io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
> > +
> > +	if (pgtbl->fmt == ARM_64_LPAE_S1 &&
> > +	    !(new_smmu->features & ARM_SMMU_FEAT_TRANS_S1))
> > +		return false;
> > +	if (pgtbl->fmt == ARM_64_LPAE_S2 &&
> > +	    !(new_smmu->features & ARM_SMMU_FEAT_TRANS_S2))
> > +		return false;
> > +	if (pgtbl->cfg.pgsize_bitmap & ~new_smmu->pgsize_bitmap)
> > +		return false;
> 
> I think this should check the lowest set bit in the
> domain->pgsize_bitmap is set in new_smmu->pgsize_bitmap
> 
> ie that the selected tg is supported.
> 
> The cfg.pgsize_bitmap is something a little different IIRC
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Though something else is missing here, I expected this to be removed too:

struct arm_smmu_domain {
	struct arm_smmu_device		*smmu;

What is left using it?

static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
				     struct device *dev, ioasid_t id,
				     struct iommu_domain *old)

int arm_smmu_set_pasid(struct arm_smmu_master *master,
		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
		       struct arm_smmu_cd *cd, struct iommu_domain *old,
		       arm_smmu_make_cd_fn make_cd_fn)

Thous should use the new helper right? It should work for a S1 domain
too.

static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
{
	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);

	if (smmu_domain->smmu)
		arm_smmu_tlb_inv_context(smmu_domain);
}

I suspect that is just dead code now, it is from before finalize was
part of alloc?

Jason
