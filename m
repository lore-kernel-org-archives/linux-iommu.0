Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895FC36C59E
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777059605; cv=fail; b=MuIPm5ZPa3JjGUHvRbTji8jchqjp+jxCzOXwPK4zVn89cpBiHYr7rS5dUZHADF4iEhFMYrSVRGSNImu+JVTubhMcwWjhWrEfYLBgK2mKtyV0kAdCmNn78lAGh0Z7DcTFOSHcHGT3QwlU0pdt55Qx9coufGO2x2U3C0fE7/1Gsm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777059605; c=relaxed/simple;
	bh=LuZWPNHqAjBt97K0EvxhWIaHziwFYReLwqYb+/CUspI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm0yYu7EiyBmR0af29ogJIdXI1LKo9i/f/L19dTHpbReSxA1+Go9u8ufGyJweDBLzrXoleFAmVE1ZYEs78eIfRWXoESGsSo1+MoquL9feTjlCqe/Bgrwx8pJQ6qpUboivREpvCrzVDroytCgQKbZ3V0O+LqLaAPFg2+09Ch26tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aCiIDlqy; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aCiIDlqy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiCRXTqfYSG1yIjlFiaBVXOddewVTvf3h74v111ICxcj6iRSO4jS5pl6ropuVq0YKcwfCfBp4TW35J9ar72ArrUgUY5Ivo2ysr2lEldGb1hgJhTLX0mfyszvSOZRdyE0Ax7h5My0u5iHsl5WWYSejWkXn3fPuINGzzPlhcPoz4D4cSkYIXVmWVn423R7f+PzHNpiAg3C4G8EiJdhUu3y+/cUawLF6DWXWa/B+7/9GTrEM+M1K2puoMlBLSRrMIcqn6TVX2XiJljVarBYtgDfHehJyrnTU2zulmO7aneDa64XM9bESEFbXx8XFPhZr6QC7lFdbAS6fJyI3HYpSL4uRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8EfM5fhgYQh5Qxg/VD6q2E2tdKP8XAcTOh6f1eDA7A=;
 b=n1f9RkoutNgz153raT0PuaLvk/oVVr6JCg8Nb5Xw6QXiXXydjRhS+oVELzzF+oA/FYrvxGQNdedDONnYorZ+YyQ6Xh7uzrFxx5sJUJfoPG6SFqBM7cxIdvLYVvcbadKs/bnbpWsvUnPPLiMZ4W3/ex3QtaHAHPjMgJuBu1OeTlUd3oUC+K0EdU8qb9aUMOXRJJSZiB+ZxCB5LqBPMZx9+1i5uROf2jUIzfUEoY06qHPYxHU8MzvXp83xLj9qa82auqXTVk1Nn8mXDOeL2rLMbekZyoW2bA8/O0afPd+zte9GWXkZYYUghXLbf5s2YmXxCiRi6xiwE92qC9uPALbHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8EfM5fhgYQh5Qxg/VD6q2E2tdKP8XAcTOh6f1eDA7A=;
 b=aCiIDlqyV8ktVZodujlkMbYJec1mUSjm3ImTcc5aiTpYw7FaJYg21H9hcdkwXly114fkjDfXJiP7j03Qp7OvoA5PdvQEzc2ry8vWDM91dw1Auw4Z+jdng1u8ydjJtceYUh2RfA17cENrVQ22nEj97gdzFrBeapVmmX7vkqB2jabCXnl96f0V8aiFh0cxMb/ax4Zhk2H5zjqFuELa85yd1WAAb1W21bHGyXDjBnJ0QnZL0OAalpMYQW33mMoTvIT3uMFdkvxJm4RWZxqdimgGX5BoF3VPwY6VMoEEazAlC9EkhF2WB1jaes2WzLC3RJx62XpZbbEoFc2p8F7JQ8uw5Q==
Received: from SJ0PR13CA0173.namprd13.prod.outlook.com (2603:10b6:a03:2c7::28)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 19:39:57 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::64) by SJ0PR13CA0173.outlook.office365.com
 (2603:10b6:a03:2c7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Fri,
 24 Apr 2026 19:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 19:39:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 12:39:44 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 12:39:44 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 12:39:43 -0700
Date: Fri, 24 Apr 2026 12:39:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v7 5/6] iommu: Fix ATS invalidation timeouts during
 __iommu_remove_group_pasid()
Message-ID: <aevG/Q5dGY8GUgqp@Asurada-Nvidia>
References: <cover.1776551790.git.nicolinc@nvidia.com>
 <8914b746d0e19b05a26c1fc5d14f170336faa3d2.1776551790.git.nicolinc@nvidia.com>
 <5170df16-94f0-4d12-803a-a43bc44aed83@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5170df16-94f0-4d12-803a-a43bc44aed83@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 846e5eb7-c028-4cad-7367-08dea23943f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	rVyVu1CbYqIBjtf2WyqRj2Ku5pjWAcJGimf1nUw8gvKesQ6kEFXm+r4FlCKZDE+Jq9wouyABpl5faMbLNNMAoPIjrxL1VoYtrNCjypf2GymZfTPi61IFWIQVUOAmum5koiHE5aR5pwU4DKuEXB7sjmH1cF6gDB2+wO9NqRJ3h42H/ib2IUa4gNrb94HjD9KIX58rBjpaAT/hYl3/0+E9rAmjZgWz41UEAYqVEVFlDAadfOqCtfzKiSUJdoFxLXsmiZcaWcZ/YgRfE4HWoLvtzljOGoax28Cmed6/piojfmH6DWlQ+p+P7v7kebdysIsSPHbjytFRdhGc4t7O+WwtkhJxTv99E8Slq10hGfPitjYvSCq1rQx2duS09Ja8bd7eqQkX5EXOCubNjknUtIFWgmYMCE7qidOX7TZqXenuggFvqB8MDmpMwLVCHdy3IkWg6oyBnXC8htsNjlNJxi7zDdYVcPN2f/S6//jkX4ye0z/6KtGi6zGdCIOf3Dl7cyot7wxOJBPq6HYYJiCGOW28VI8xZH+w8ELNbdYNBQNVPEzZm11GUnRQDarSO8/9IMQw4DVz6p3uKIB2SvGbJTKTnyJSR8WoUmDKB6wtUoufTiFEgmbs8c5OkC449jrikNi6rno+8GaX0W1FsN4PqdI7q/vaQPh7Xik14vGdLt7N9DalsfJ+dLGlZCg9ZYqXaTeE2JQSE3+vjKV7wmHReKzM6/XvADcfsYxfN9je/QWexkjBz+mJr0n91gCYT9dglTEGWKT+n5kxhIpWsLSCiqwZ4g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+l7RwiZmB2w7kCHS1+t2nHbh8NlipyRpxqU0ozJTn7KTtcq5hUvK0/0q6sFdev0+NDXgy4VAlGC8hplv1DQcHSADQ0OPFVw+B79gi0rvflZ/Nz6SaR3nQfRI1y8yJqImZH+r7USa6Tn7jnqG9PY/6cVSJ6QQVYeC4IIUE1vOfKWIb9aPgbdWaYVXAbUvoonB4pmkOJkgN+lxgquq3MhUfhIq7f4IJcvlncqRvuRvrZRheMyWdaxyf1A/7dKX8j7pSIzvCn9dDsK+emRMB7yMau5kZrmuad+Z0CiVcz4U2qqLqlvdo2wO9dS27Fqo1rPFJ0ULWEZeuXdkOqMyyuEclWWnrHQDUpz89H6dr8kaZCeO9KP3jH1usFriN4V6jNRyUFC44ygZQcbe+0IEojf8e/rrSji8jv6d43BM5SSkoNwZky1K4lbyZsSMcV2SzQbq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 19:39:56.9222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 846e5eb7-c028-4cad-7367-08dea23943f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350

On Fri, Apr 24, 2026 at 02:23:17PM +0800, Baolu Lu wrote:
> On 4/19/26 07:41, Nicolin Chen wrote:
> > @@ -3554,7 +3554,8 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
> >   	struct group_device *device;
> >   	for_each_group_device(group, device) {
> > -		if (device->dev->iommu->max_pasids > 0)
> > +		/* Device might be already detached for a device recovery */
> > +		if (!device->blocked && device->dev->iommu->max_pasids > 0)
> >   			iommu_remove_dev_pasid(device->dev, pasid, domain);
> >   	}
> >   }
> 
> If that is the case, why not add the same logic to the set_group_pasid
> path? For example:
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 61c12ba78206..42a979ee0ced 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3532,7 +3532,7 @@ static int __iommu_set_group_pasid(struct iommu_domain
> *domain,
>         int ret;
> 
>         for_each_group_device(group, device) {
> -               if (device->dev->iommu->max_pasids > 0) {
> +               if (!device->blocked && device->dev->iommu->max_pasids > 0)
> {
>                         ret = domain->ops->set_dev_pasid(domain,
> device->dev,
>                                                          pasid, old);

Because the policy is to reject concurrent RID/PASID attachments
on the group if any of its gdevs is resetting.

So callers of __iommu_set_group_pasid() check group->recovery_cnt
and reject with -EBUSY.

__iommu_remove_group_pasid() is exempted, because detach() cannot
fail. And it's okay to bypass a resetting gdev since it's already
detached.

Nicolin
