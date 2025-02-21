Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C21DC9B0
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158864; cv=fail; b=IoxA9gBjEYBjidLVjqiJq9c8eHa+kuIMxXsGh1BRXRQk1fMr5Bbv54PsFKMq9Ht6cadXb82cO4TONKFQRtyHGtqQ4ZxDUFxyJWM8zKFFx0XfmzGd96XwfV0jTkdLhsI0p+vOzHwQQ3cPBBbrWeuUVezTyIvPOcnqWDTqpvLPvzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158864; c=relaxed/simple;
	bh=YIO47H/bQOR6OOfwKPJMFBfniIj5d60kUQGw1zEixgo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4LrT/XjF8EgwxPlEAAxmapZDBYa5KIu2feuTpdU7PC1aOL2dZiwv2st2HkaBeE/RY+YXft0W7MUZzG8CIUqO99J/0s0gaPNdkXg6dbMyU2uhVGorj+TnkHL3+rc8nM/HmjM42gHBhLwpB7pLRGk2nvx8IlUG9vuw5UYzEllL1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MxTPH8SQ; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MxTPH8SQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uf+slO7RyhsEE7dEvY4ks+HEfid6Ma7F47eK/NU/MnW1F6YX2xNhhGSCI1OC22NwCXyy03Ua55uup0nYZssgj55L0q0ISSxIZTIoUzq+4zc1CNvYQWf/3CK3D722ThzcM35wwmE4sxxN5Elnt12UFpfdQd+S+7d5WRWdYgaC1b12SylChtCMPrcF8Av7ymmoOlQHLoaLKBRUBOX1iG2XeUS5eG5IicF5V5ngc7vXDtUihxRmTIfb/FJVFGiYspcInysa5Hy1H9d/BQgkEBFg+QEbicCXKFTAs8xrocRHPQ1yw45tw+jG5PKOMjDPkR6OgWrOVrVgoEbwOvv8QhZobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxScMXSRj+XrIfbVtVM1CgN1tjasJa4V2o5zc+gBl9g=;
 b=MdLKRdWFWNnHGyttXD8FzYP6Y3NZE6ly5aS5XnMciSed23dP2D1Rsx8d5Hx6S+XUyyzZeQje8H95VtVvi2Mg/b8A09ip1kUsB9AKfq5jDnedbR65r84elt3nfVYzQnLC24ik0gnoyeLuGUWFYk3K7w9Sl6ietD0mxh2qC/3nDP+EoCu/Cu5nIeEEVA4n8psJr41tFfNFoKh/r/UrEafiQw9ofomuTPrjtAad99XXLa5+hFIjXfPPBrOIvIsdGC/ke0jE3OsoGNPSayE9fGUJVVpHFYSG67LXTVA0EfKv9uHvKezizClkgKowbKJyLY9eeRiw4IogqzKD5fA6G9bC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxScMXSRj+XrIfbVtVM1CgN1tjasJa4V2o5zc+gBl9g=;
 b=MxTPH8SQi6tJbSkqnbwWZftSmNqOfAfYxjl/VaBB0h/2v4NQHxP/lZ1qKQLHVdHpNzS4DmyzhvIcQOzARQ0WObLOGLFR5kVHsnfj7+dKyvVe2nEHT4Rsym+Nfgl7V/P1im9FVb61Tk7VbCmrLvrYyemK93CZqxdMO3/EbTnIgTw7+i+0vb+iFycD3mZbipxDj70w0x9dDKOUMlsd3dr4Kdr0LaOBOhM10F4v4AW8PqtxgnxVUss3iZj9XLg7ATHm3XEsIn4Uj21Pyh7OZrym5g2LluAe8voB0nHoYsbW28QlkQTdwLfOsSWpug6tD3RvhuV6h7a1eXTpqvitkh4/YQ==
Received: from BN9P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::8)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 17:27:37 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::4b) by BN9P220CA0003.outlook.office365.com
 (2603:10b6:408:13e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 17:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.0 via Frontend Transport; Fri, 21 Feb 2025 17:27:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 21 Feb
 2025 09:27:21 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 21 Feb
 2025 09:27:20 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 21 Feb 2025 09:27:20 -0800
Date: Fri, 21 Feb 2025 09:27:18 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
	<will@kernel.org>
Subject: Re: [PATCH v2 4/4] iommu: Swap the order of setting
 group->pasid_array and calling attach op of iommu drivers
Message-ID: <Z7i3dvyA/opurciP@Asurada-Nvidia>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-5-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250221143335.49874-5-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: edfb9ec2-7ce8-4b42-fa6d-08dd529d08db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zve7kjHJ2wxYqPn6g44T1X8tI3jlMlMKlqPX/46G8yyQLJB1FJdck9+3rJiE?=
 =?us-ascii?Q?9BkRbwgSUWJfkVYYuOP4IuWsfuqa10gXLTGESlUp2YVE00s/QjF7Bsg38Jjc?=
 =?us-ascii?Q?UXzRfnpQT9csoYtFa3Lj0ISTRuqfBNUQXKtNrpW+hUNRHyYWjCVnmekjER58?=
 =?us-ascii?Q?H8b01CGqui/xAUQfTlWJTAQ7t4axTNklzsSiZRZphdex/G65DdqgQsP7AeeW?=
 =?us-ascii?Q?KMupkajS4fAUS+cPPkHYRUzv/2yUN0KjXA/m2WqpnyF+SH3cfQkErEC9TqAp?=
 =?us-ascii?Q?53ZoLTvqufxNUr2zatxfqEhH/kaSgQUOPOI5YnMqzUz8BKsK4Ca8EVbuN1rn?=
 =?us-ascii?Q?SgCfkdUEv4ThRUqMdvA/oRJ1xk/IReziiEVElWMNvT6dp43jRmslQZSNUxzZ?=
 =?us-ascii?Q?VDYbqxk4V0IchGErKjwJ4n1ZY6MGnJoX2Yc/COSB/wkXSYiymaO9TU79sMly?=
 =?us-ascii?Q?Fs76tPKBmiwvJp8SmtZQHITWLb4wvlAaHjLibYz4Z2s8cu1sNcdvel1vvfBt?=
 =?us-ascii?Q?wZZEjN33Bb8f3x0o2vZMdOJD3TdZEoInBKryIhwkwtyMRs04iQqhIo4qcOpS?=
 =?us-ascii?Q?N8iju23fQNNAydcuCr/aTijNgFxKzgEJXEoWW4oWMg+npwNBHj1WSP0l4JUb?=
 =?us-ascii?Q?Axx+09GcYRRhTEgFqJXlzBNYRhb3Ua5HIyv/XvOS+fdfxnq+JUhaIu+Rmmwb?=
 =?us-ascii?Q?gsrsZSCvbvE08NeKMngAMbiwn4AThKNyzR1H2+lTQzv+PGoxup8vXQCWf9q3?=
 =?us-ascii?Q?yzx/FEDe6hSeBBic3n3TjrEl4i/4JGrP6XlOx9SpFhliI8w5PABurhuxav5N?=
 =?us-ascii?Q?iZx3S8knYUcTOCZudp7MKFKZmE/t3oh+1P69W1TjlOkAXSGv1mpSYyYnZ70b?=
 =?us-ascii?Q?HJlMDzj0HVpHDfpbiU/Q31l81tPZ278lPlMalWaP1FHEifLJfquDHa7yZ4Pc?=
 =?us-ascii?Q?9Oif1L38Z1tL0UoVcuAlOkvdHtvlL55Sxs7cCU+8YscJJM4Mw8IkDIpd8W06?=
 =?us-ascii?Q?svlYSj9jerkccJhQK6irBDGxLsFenHLTy+9/DNRBJ3B7ZBH4AnYabqxB++PE?=
 =?us-ascii?Q?ltQi2F9nTkRTk89hU2Nub25rmgZaR1/MddIvdAa24A/jP9DjMnE5Z2hEIUhq?=
 =?us-ascii?Q?dk0L4YECv7UdVplRlDIsK91FqbWzS1BCXx2mvdibMb+v+/DWVjgO9Z1PzDVq?=
 =?us-ascii?Q?4RovawTEULphQVL7W0xpVu7QmXU/g65mwtPr+Rm43PH+LIGXPvMancoDRySr?=
 =?us-ascii?Q?jnjexbjDy74GckWkK+ZuGKPDOL/9Z/L6jnzEzM54Hs4di8TI6sYnK2w7fBQh?=
 =?us-ascii?Q?ZK8h8X6hpBNpXH4LuGL/FJxzjDFqmbYuGBbNsEwknal8Es7gTye242oh3itj?=
 =?us-ascii?Q?fb2iazgzwq6aI0dog7uC6MYDs9N0hGFX+RdQOVDMVcJCkpaLxLv2OU3fSCB2?=
 =?us-ascii?Q?+/wg/fifTK3qQ7lEgPAPPsBrRpFnUUvB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:27:36.6580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edfb9ec2-7ce8-4b42-fa6d-08dd529d08db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196

On Fri, Feb 21, 2025 at 06:33:35AM -0800, Yi Liu wrote:
> The current implementation stores entry to the group->pasid_array before
> the underlying iommu driver has successfully set the new domain. This can
> lead to issues where PRIs are received on the new domain before the attach
> operation is completed.
> 
> This patch swaps the order of operations to ensure that the domain is set
> in the underlying iommu driver before updating the group->pasid_array.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

A nit:

> ---
>  drivers/iommu/iommu.c | 44 +++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index eff5f678883b..73555e1cf016 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3388,13 +3388,25 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>  
>  	entry = iommu_make_pasid_array_entry(domain, handle);
>  
> -	ret = xa_insert(&group->pasid_array, pasid, entry, GFP_KERNEL);
> +	ret = xa_insert(&group->pasid_array, pasid, XA_ZERO_ENTRY, GFP_KERNEL);

Maybe xa_reserve() pairing xa_release()? Same thing though..

>  	if (ret)
>  		goto out_unlock;
>  
>  	ret = __iommu_set_group_pasid(domain, group, pasid);
> -	if (ret)
> -		xa_erase(&group->pasid_array, pasid);
> +	if (ret) {
> +		xa_release(&group->pasid_array, pasid);
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * The xa_insert() above reserved the memory, and the group->mutex is

Just in case we would like update the patch, reword "xa_insert".

> +	 * held, this cannot fail. The new domain cannot be visible until the
> +	 * operation succeeds as we cannot tolerate PRIs becoming concurrently
> +	 * queued and then failing attach.
> +	 */
> +	WARN_ON(xa_is_err(xa_store(&group->pasid_array,
> +				   pasid, entry, GFP_KERNEL)));
> +
>  out_unlock:
>  	mutex_unlock(&group->mutex);
>  	return ret;
> @@ -3509,19 +3521,27 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
>  
>  	mutex_lock(&group->mutex);
>  	entry = iommu_make_pasid_array_entry(domain, handle);
> -	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, entry, GFP_KERNEL);
> +	ret = xa_insert(&group->pasid_array,
> +			IOMMU_NO_PASID, XA_ZERO_ENTRY, GFP_KERNEL);

Ditto.

>  	if (ret)
> -		goto err_unlock;
> +		goto out_unlock;
>  
>  	ret = __iommu_attach_group(domain, group);
> -	if (ret)
> -		goto err_erase;
> -	mutex_unlock(&group->mutex);
> +	if (ret) {
> +		xa_release(&group->pasid_array, IOMMU_NO_PASID);
> +		goto out_unlock;
> +	}
>  
> -	return 0;
> -err_erase:
> -	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
> -err_unlock:
> +	/*
> +	 * The xa_insert() above reserved the memory, and the group->mutex is

"xa_insert" here too.

Thanks
Nicolin
