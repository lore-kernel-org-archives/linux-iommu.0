Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7452366
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709908291; cv=fail; b=Y83h+g9F1j2hqI5JPxp26VJUj3cveTcig3rqh07HJOoGFmUHBHEoVCd9Y14mXchjbPn5O7Vr3ZEhped4HMUDXB8SwYbR+0CKJL2j0fllIN0+9eUHqFLAiyNT3hTr3Svxixk75tFG0/eHba6z7WD4p0A9g14vuwHT1OuBHrmbcQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709908291; c=relaxed/simple;
	bh=t6nwQmLvFiuAxoJ0MbxVL2KqIEKeD2HISZI2U8xDlNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M2PZnSL431Sdj3onV+pkKeZCgXKSoT975vqbNKSpzrIqgnV5HuKQNe2jYK7SWazj9zqI6Jp99LoU7sGnhqNgTFCSwoYhgnbMX9qOJNCFnTUT6aW8LPeUP/xOKDcFAJwUoDq7HmgsQsV5UHy+AvCSjn7vM72rqKggjh4TlCj62aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hpcmx++l; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hpcmx++l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iM8DWk7TvMuQrCaCWZtqaB367HJ/0iTuhWfX+1qQLSbOULsbPZDrLIUdb7NxY93b3XrgfG/wmie1k9FDUjbdjTQYbLpRZU5l8spfn/ukhNGSaFa7ZAEtE+uKWoYdkXe6BHdMIpsUDsfFAbtPk3plmW4e1mBCkSNsEfcOdfCpB/yk4fbyyE7fGLE8HpjXJbQG/+oOLx+hWOFVEIHjoWC241r5mXER+f2BXKx77WrymOl5YNvg86VplYnsIvvSjd1WARU3QQPYPEUrKe5NRoPtYhN34V2QB97yVMyoIGx6Op2p2B4kOtyHYN7m4mof5Ldtj8T/zElvOmx7H5l1pabTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7TsfK4Anz0uAZmyx9QxpgwvxQN5mz8mXgQw/bE0WXc=;
 b=Zt3PSkT/IP8EjZfJ9QQiInHx9A+99vRRfpt4bdKGAvJEYn5FkMZViPxYah8sAvbtCUzQsAcOU3gjxdCXWKl85+GswCztK5JfB9RnCzCOwnx92JaAfAFgjZ84WKysuMYWbkbFREJ3HVbO/u3eVhpRv00x/FgPJ4AfTJUUfIGWvsJXFuzpvnCLunl1bcK9qh1bb83flwm+tg+KyipQJaNHcrJtHu/4cAY90pp7qPLhMDo94sQiuL/PJIEVtyzsBEjCTw2bKM6eR2BsMKwDQkm7zLDEAko3spUOxLf9zL1tAXoyGw6AP0G6rRUE44d++u5l4W7Zn/3NEUQ+B+XR4gr7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7TsfK4Anz0uAZmyx9QxpgwvxQN5mz8mXgQw/bE0WXc=;
 b=Hpcmx++lk6XM9czoFsC5j9F+J2vfWwx1bhS7o1DDH/loC0rsWoQB3y6hZ0wAl46YISw68jo5bCMrdGgVEvivpNCCYaoJIvgIbYl5akwl53zrTy5udhQD+9Yo0+M8yvzMXXohEX778X7bN6P+wrj2TzVkWVfitOjGo6EJ03VuC1g53J7kba9QJgMCWv/sEm0RNuilGqoiPgGFp0e5VcFlsyZDBRXE9t1VdSgtzXYog+yiPlBwClMV0ahja/z4OnjYJTakqylB2fbdP8UsBT/kxY24WBsYHIXlnJpjaoGTg1JquuZzt5ktkG8KOVxerK558FgPpg5LVRSKNPCGSpj6zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 14:31:26 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 14:31:26 +0000
Date: Fri, 8 Mar 2024 10:31:24 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	joro@8bytes.org, kevin.tian@intel.com, nicolinc@nvidia.com,
	mshavit@google.com, robin.murphy@arm.com, will@kernel.org,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v2 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Message-ID: <20240308143124.GO9179@nvidia.com>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222094923.33104-4-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: SN7PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:806:f2::15) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca2f3c5-04e6-4292-fc6b-08dc3f7c6fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1OJUDSS3aiVjK3CBTRbuLhKfjk4Cd4xiHtmcThr6kLRUn6uuDj+bu1IlUt1m1uoXhcMomt+L8bpxqeo0eFNGz6UcuP0mGQ2o763gkLdB1daNZFD/Wcs4fLEgKjm4WCvPBLHQeGiDSSGiNhx/PwId0oHrlgaE9TTmCPRBuTScfIPSyKtTgFZRfltB1oSUBKaNN6HISDwgkFcemSkrWlcj/YoIh7azS1KsKHD7qhLNPJ1HELiJPUlx3x7zvHXjQrrrgA9hH5EwsEg5f4p0J0OOGXy5kD5G7hNAkw/ufCXZvd0W9Gtjv+IXSn+m0Ln9+yzjkZg80z2umxocYu6lJUS6NErYupJK05nmxxErYVZA1jwzCPhUTCZHxYmmoPwsoYpmnrbjZbS4vxAGAY8i7UMeZllzE3Hyt8FkOjFOxNQGgTlxw3nyY99e8WqrtsU8yuv8DbE6JBI4T2k1DNujGTmZApE7Jamwq3oU1/tG5ya1yi6+F8ISyQcWHhu59hgYZxwdy5rOlEMtNgrugMFkeEiTAT3mVjvvT0Ifq9CwZ2ZfNwnfXQGY+xB1t36nqsm1qhphMJPyTyC6WLnm58aH7kz4uAfjJ0LicLB0XfIBf6+gIJHvTGjHF57KEQXiJxXEcb0uTCpe0u912WYx+7LzF+voK9l3twU+hzTqWlhD02zeDvo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Y1k9712DxVu+kWzCPiO6BBaqXELGgEmNCju15rN8iGqYAohykNaFwxR9tQt?=
 =?us-ascii?Q?x4RYbQDlD392jJC7w2RqnI4NHrK83dxIF4T1RNCiPHGcsj0PTtP1T5kc2Xlj?=
 =?us-ascii?Q?dMl5/bgm7s2O3MzwEuMqST+8nz+7gZsBY9zjb7evu2GbAUQxdvZquXX9vYcV?=
 =?us-ascii?Q?Q5ab+MzjBeKgueAtRHrOGazjNQWDLzDYqEDRI0a0r3uOu/bS0TX+3EZ4pjo6?=
 =?us-ascii?Q?VgttCUyAuYAcsOzBMXCzk2Y4alxh3d4ao02j0FHUWhRE1QWkj1uwMxHB7PhT?=
 =?us-ascii?Q?DztsDxbGbmFpBUlK7RQVonv4enyMGcJEIvB2kEncJZicQU02Z3Tva7Z6pRqt?=
 =?us-ascii?Q?vo6Rr9wkhyme5/22zaViv+Yn1z+OFqBKymM055iyI9BG84TRRCfFVY5g6XJH?=
 =?us-ascii?Q?qq77deawOF6QHj2cJkn+Es9Ct4x3GPnj+Fzqxf/yUAN1SEAKcy4iZtTdPkug?=
 =?us-ascii?Q?bWRwOLj3M0VGTHAaUlNQdHKv/R+tspdenqCRy/8ENatjDgu7BsleZOw2kFu0?=
 =?us-ascii?Q?h0pnIQf9qMgu9B7DYA/MvKzXLLB+kOR71Gk/RnwpzR4kZR/clhjGFrtgDW9t?=
 =?us-ascii?Q?b0Y9kq6gxrG2YMWhv1R5T9Qr8dCJGa3FNFuk0QJoOA7ZMj4OLn/yM8GrATj6?=
 =?us-ascii?Q?DZ6enXP9DkUY40pb2HaYfvxIXYyDWXRxde85H/wjqlhX2fVarZwqjA98HYrN?=
 =?us-ascii?Q?Ggn8AsHYynp5sVdf4LOFCEhX04bXMq+n3OSp7heBIyo0xtjM0/O/HXJwYyQQ?=
 =?us-ascii?Q?KR0tVXn4I1iWEpKpTe8Uym0BedFkXfdyqRvRB+B12d6XsZlgsV8Scv1yiDoh?=
 =?us-ascii?Q?hq91i5FqFlh0nQLfLYCRQaclhyN8f5zfFNJZehIBMqVDr/Y2hKK8Op0mWKjg?=
 =?us-ascii?Q?SlQ67Vm4xfk0ACKjplapLhapXpfw1hsNYICjGexBvHiNZM6UaOivR/tXqAhw?=
 =?us-ascii?Q?gke06V2ohwAyEeqti22z8zD+fkUyvN0pXGo9mCuQDyGk6tOnIAa1BqIVFBhz?=
 =?us-ascii?Q?OjkZPcyd+/6AsWF829YpdVbJyVm6K63nfpJ4t7d5pUhq/kLGQYOvlZes/q6w?=
 =?us-ascii?Q?FwwnmRsVIKiTWDjV8jSAWIu6VodRb/3JGepKliCcZfdjBcka9FuwIfzbjMr0?=
 =?us-ascii?Q?Jk7YmmYsc0rynY5zSF8VOtrA4Y25YHkXDQkvXZqntyCHFD8F1LXDQnB8FWRi?=
 =?us-ascii?Q?E0s4toSTtdejZs9SQD3EnBwNRhK+8zzvzayFbpAS3JC8Kt7fjjFB1lbEOBjU?=
 =?us-ascii?Q?MUNdxQAdxW5+qGmUXvy2AhTEQyDobQbbZ7adAWHQL4ddd47ePmeSK/vQhsY0?=
 =?us-ascii?Q?8L/rDsduBM9Lzu2hqtdIUStOXe00NQ9vXQuynbUxYSPHtSPmGBfU08Y8dtoh?=
 =?us-ascii?Q?fYBU5d2XiilB4w6XvwvTP5QVBzD26fVGzV8fH17tTRPpE04WSjQG+R8EkdB+?=
 =?us-ascii?Q?m6tfBdN+v5zJuW4s8KoTHFYob1+7/JO7CfGFWdqB+y+/2PSc+mMiM7F3yps4?=
 =?us-ascii?Q?D30yEdPyTB0eH0UYlXldntTRCwq26G8Yz2A3ZYKFfym6C7vq4KONAwVh5V08?=
 =?us-ascii?Q?qyE6TCVBqFpegT1obOE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca2f3c5-04e6-4292-fc6b-08dc3f7c6fcc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 14:31:26.5343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmfIQzEMineuWvlyUF+Wn2hDJ+b0hMc0m/9Dj57/sfQc/y7vPVRNoALPRCEHy53A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976

On Thu, Feb 22, 2024 at 09:49:22AM +0000, Shameer Kolothum wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
> 
> This provides all the infrastructure to enable dirty tracking if the
> hardware has the capability and domain alloc request for it.
> 
> Please note, we still report no support for IOMMU_CAP_DIRTY_TRACKING
> as it will finally be enabled in a subsequent patch.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 95 ++++++++++++++++-----
>  include/linux/io-pgtable.h                  |  4 +
>  2 files changed, 77 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index bd30739e3588..058bbb0dbe2e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -43,6 +43,7 @@ MODULE_PARM_DESC(disable_msipolling,
>  	"Disable MSI-based polling for CMD_SYNC completion.");
>  
>  static struct iommu_ops arm_smmu_ops;
> +static struct iommu_dirty_ops arm_smmu_dirty_ops;
>  
>  enum arm_smmu_msi_index {
>  	EVTQ_MSI_INDEX,
> @@ -86,7 +87,8 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
>  
>  static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu);
>  static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
> -				    struct arm_smmu_device *smmu);
> +				    struct arm_smmu_device *smmu,
> +				    bool enable_dirty);
>  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
>  static void arm_smmu_tlb_inv_all_s2(struct arm_smmu_domain *smmu_domain);
>  
> @@ -2378,7 +2380,7 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
>  		struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  		int ret;
>  
> -		ret = arm_smmu_domain_finalise(smmu_domain, master->smmu);
> +		ret = arm_smmu_domain_finalise(smmu_domain, master->smmu, false);
>  		if (ret) {
>  			kfree(smmu_domain);
>  			return ERR_PTR(ret);
> @@ -2445,10 +2447,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
>  }
>  
>  static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
> -				    struct arm_smmu_device *smmu)
> +				    struct arm_smmu_device *smmu,
> +				    bool enable_dirty)

It is possibly a bit more readable if this is a flags and the test is
on IOMMU_HWPT_ALLOC_DIRTY_TRACKING

>  {
>  	int ret;
> -	unsigned long ias, oas;
> +	unsigned long ias;

Isn't ias unused too?

> @@ -3193,7 +3197,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  			   const struct iommu_user_data *user_data)
>  {
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> -	const u32 paging_flags = IOMMU_HWPT_ALLOC_NEST_PARENT;
> +	const u32 paging_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
> +				 IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +	bool enforce_dirty = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;

Ah you based this on the nesting series.. Once part 2 is done we
should try to figure out what the order should be..

> +static int arm_smmu_read_and_clear_dirty(struct iommu_domain *domain,
> +					 unsigned long iova, size_t size,
> +					 unsigned long flags,
> +					 struct iommu_dirty_bitmap *dirty)
> +{
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
> +
> +	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
> +		return -EINVAL;

This is not possible, these ops are only installed on S1 domains.

> +	if (WARN_ON_ONCE(!ops || !ops->read_and_clear_dirty))
> +		return -ENODEV;

This is not really needed, if this is corrupted then this will have a
tidy crash:

> +	return ops->read_and_clear_dirty(ops, iova, size, flags, dirty);

If you are worried then move the WARN_ON into the finalize function to
ensure tha tthe io_pgtable_ops is properly formed after creating it.

> +static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
> +				       bool enabled)
> +{
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
> +
> +	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
> +		return -EINVAL;
> +	if (WARN_ON_ONCE(!ops))
> +		return -ENODEV;

Ditto for both of these

Otherwise it looks OK to me

Jason
