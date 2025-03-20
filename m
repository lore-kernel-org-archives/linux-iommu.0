Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2DAE555
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742498395; cv=fail; b=rkrZhz5x51B3AH1T29NID10RF6GAdHLtu+5qPt1W8+0xHzB0iJhyU2pO2IGBak0I2HOUS3Cl6DaQHr1DpQzN1/nzw/XWtH+OFRdZc+5IE+Vj3gofV92Y2TWuiMwOyzEJbU9F3Jw0ET0coafU3x9JE/uTLWA7ejqE4v7NbKeTjpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742498395; c=relaxed/simple;
	bh=JaFwiKmQG8FRDwaXDtIXuZyeVeQPQ2K8RPR9ceDbpEo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4rk1q17jPZ7H7CjMDTC7uXjoC6j97qikertHABtVGQKR8uj6ckH7gsa/s7L+n6Es8U/pelI3oMf69DCLYFePZLi/7x7O1F9/yMGxpmqqgnohX4Q2yFyulF5rDlPA432J6hN5XtVNJRz5dhXCPJVsFMbk4RzVBNWUVYifK9hLnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ejQfOGgU; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ejQfOGgU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+IcYJaAkkfPcmBsHziUeWNwa5im5WMu1FAgKiUmXIXLPBTknyu91Gl7/bZcfxLU5UG+xMdKhmGvpgvXm3y1ZpWyw69TNpl+QyLSGVl94divaOLxRy54eMQVCis6FlgurAf0tQN/z+PG3S1a4A5HRvVisHnSWqw4XzCo2pcr2qce0VLwLT24boVpmmtOzIozIO4xWUG8zIjtkjtlBABpCLx2xT8Gz+q8hxJpIvo/JHl+Doo/oJRp9Q8FAatG1k2h/CSzt1v5vLDfum9I8sv7QMofTDN0rfAzTXMaU4i5cVDZP93Q8RkYs8G5z3LIYwu0e4G+iSNpqa/2rKasLFm2yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6w86d0fgZ7gxHw6nIwPv3J/EC5trBmYdGUurBzRh+Mc=;
 b=mnSU/e2RB0ZkFylRkNArxrperhcvJZ/E9S7Du3AuNZyg1uaH+2VgnxMyIudeqCKlQcKnykTX69efFWrKxrvLxwTs1kcktjqW7WMQUZWwvRH/J+wJyFNd4jDbPKNzs4RhmJg8GbX4WX+qmimpyVTZeonVWes/cYsWt1S26i7aIOW9OAtSHF040nuNWwcL3uIHqEC/+e0QxWzGS9RryfE17NE83c5faA+i6LdDSJyS4spuPASF3TRHkAdzSH/XKf8kAGSzA8ZE6VHLpYF4Yn9sNTPfLAyoVtDYkNbbkYmKe4TeSxfkxNoRry8kcCxpzQnM2qNMpl9LCEaG1yrE1J8m0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w86d0fgZ7gxHw6nIwPv3J/EC5trBmYdGUurBzRh+Mc=;
 b=ejQfOGgUoA76H+9Hr692rtlkNef+ZhrSBOQpQUVYdnIO8Hdz7V3TlxHrWhY6cRN3J1pYjL12VZIW4AwhnrmI3Yid/evOFzKvM6rGmlGhzNZ/c6iF6QxOc6NHkJ4K9TWZws4zai6emQbiA6JbWT84CjkxsfBgR5s34Y8zjDTc4QH8sdaLilAJ+lFg+AhkVzLodsy6pbRscin8ArPjDJBOYhYP6txu93x7q9Yvea8uporLD0F8In8RlHvGk53WTO752x8PbD0duudmyDKIb7cjz5zbb4fqCGZq4tXJgYzfnCvsOY1CIGIOGSpRIREnJRTqSYRMN1bm5HpSZuSfsTEsiw==
Received: from CH2PR20CA0023.namprd20.prod.outlook.com (2603:10b6:610:58::33)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 19:19:49 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::ba) by CH2PR20CA0023.outlook.office365.com
 (2603:10b6:610:58::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Thu,
 20 Mar 2025 19:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 19:19:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 12:19:35 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 12:19:35 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 12:19:34 -0700
Date: Thu, 20 Mar 2025 12:19:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 09/18] iommufd/device: Add pasid_attach array to
 track per-PASID attach
Message-ID: <Z9xqRS6CHLnPAT2w@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-10-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-10-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eee1923-b2d8-4fd7-0477-08dd67e42eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?abWAUphd2US9NTMq4rq4E8eZIYJ9/CwRBSCk5pha+HJzKrVKhh4wRYo7jN5o?=
 =?us-ascii?Q?wyGKzAb1eQk99fN8ZGT5FeUrUpJzNu8JH7Bg2Pp+O/nZZZ/pBpltAWI5BFO6?=
 =?us-ascii?Q?LqV+x2my0smGDuEHu7nbUBO9A6T9pG1g5cQRRAeUgRejXLjNdSER9LqzW05i?=
 =?us-ascii?Q?kzrNQUr7/kMtGwF4YIACpJSkrgy5FS6K0D9Nul/UMIBUQ1Hshpk9No3zbMHN?=
 =?us-ascii?Q?7yo5D2ooSH6Vjbj0RBOlSVi/KGLZ5l3uJCbVjza8TdGhXYStAOMMkUEdlp7R?=
 =?us-ascii?Q?NlzkTELu8mK/OAkcaP/4ldFkH0KHuKwp+axv+BqHCD2+ftwi7MHdbsQ0lCHg?=
 =?us-ascii?Q?jY75nuILJjPYb9tORT2HK0F2J0kmP6KMTKOHd709jqX9rxFp+/8PrwgaFyft?=
 =?us-ascii?Q?hbBxsrMpfFaj5DeDfgzLaMyBt4+TB5Sf8wyGxh0LP3KdRC36rWX8Kvscm5XZ?=
 =?us-ascii?Q?xG5UC/l5B8HmKazGh1xiFa9VRpKovZdATpZAaz29IjbkGN+Dpp9jWuUyC5S6?=
 =?us-ascii?Q?mFYQdCa8/Z5XW+XOGKUR13n9r/iHgjXxSxM3F1i+QHsVhrHmHQokiw6cmdk+?=
 =?us-ascii?Q?Vs+wRZ62OWE/8QkeskGBeCVHambOaEM5ah/TEw8Q/O5BZlGBFxahcOrnQQ1j?=
 =?us-ascii?Q?uRjklsXsj0k+J4Qwk3N/s3RtsRZLM6JihUF98woa9VIoHT080OR26dzxBABM?=
 =?us-ascii?Q?ajsEcg7ANbUYxuFj4ex5DBwiCsOhPF6NeFmx6Bza5jQ1RtSR8PPcT9/y3/Lp?=
 =?us-ascii?Q?U7nhJ7QgwpTniuPVKTy1J7qu6E+afCUdmUgDcmYav6WF4hMmXFu4IeUXAfXC?=
 =?us-ascii?Q?HY7yWGXv+60PyK7hY8Xz/O/e2s8KjtEngZItEGOuU/XwTQHGD62AyO0LIsar?=
 =?us-ascii?Q?1V8jcSd1JKQwePHlGpzRyhSTpnL+KZBx6ozr+2f65vsBL7DJtBStGZpR60vZ?=
 =?us-ascii?Q?xrGFUSrsTer8cRuQjSUs7BInimA8ZDO2n3DG9caNEfwu8mxf/Jo6zzfS8vK+?=
 =?us-ascii?Q?owtmT5GZQ5FWRXGxKU53V/VAKQVYWwsiuLgW3fyqPz6HLQgX1OGJmYE4yY46?=
 =?us-ascii?Q?Fzz4wiSQ0rm3QDYBTHCwfkILnBOycjQvKbD3SLUXV4vQzhPVoLGW0b0F7PWz?=
 =?us-ascii?Q?NDGLu8gcaLYEqYlrpTj9+lVMvXVMPHYwW6kMVoen+smftjCjXk2v5oKQ6CD0?=
 =?us-ascii?Q?rlgpEQmvZZCpKg4UXPTV2DXT7q+kjJUZ0bD1httOhx+lvDnxnO4UcD18j9Rk?=
 =?us-ascii?Q?oorvEvVnoxPdgopyn4GfCv4GKVNZZ7FErhYOJfyy605kTARt8i9OMuy+miX2?=
 =?us-ascii?Q?ChepD4QqAI2+Jd5huK7Q0cYhhCcNl4oH9BMdiYgxounfghfZsAYlzH+Vfi7n?=
 =?us-ascii?Q?SjIyi0qHHGZHqym6rovwoMkXJ1pyPtpQi1YoqaJcyZORFlVCnwKzWCLmFcKp?=
 =?us-ascii?Q?Jen0xIDALN5T1nGh7zDN1XnNYIKKvhSZsr08eiSZnKTsXJvQeTqauQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 19:19:48.8955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eee1923-b2d8-4fd7-0477-08dd67e42eb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800

On Thu, Mar 20, 2025 at 06:47:35AM -0700, Yi Liu wrote:
> @@ -497,10 +501,13 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
>  
>  /* The device attach/detach/replace helpers for attach_handle */
>  
> -/* Check if idev is attached to igroup->hwpt */
> -static bool iommufd_device_is_attached(struct iommufd_device *idev)
> +static bool iommufd_device_is_attached(struct iommufd_device *idev,
> +				       ioasid_t pasid)
>  {
> -	return xa_load(&idev->igroup->attach->device_array, idev->obj.id);
> +	struct iommufd_attach *attach;
> +
> +	attach = xa_load(&idev->igroup->pasid_attach, pasid);
> +	return xa_load(&attach->device_array, idev->obj.id);

This helper is called in iommufd_device_do_replace() after it does
xa_cmpxchg() on to the same igroup->pasid_attach?

>  static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
> @@ -627,19 +634,25 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>  
>  	mutex_lock(&igroup->lock);
>  
> -	attach = igroup->attach;
> +	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
> +			    XA_ZERO_ENTRY, GFP_KERNEL);
> +	if (xa_is_err(attach)) {
> +		rc = xa_err(attach);
> +		goto err_unlock;
> +	}
> +
>  	if (!attach) {
>  		attach = kzalloc(sizeof(*attach), GFP_KERNEL);

Since this is attach() and we do xa_cmpxchg() with an "old=NULL",
should !attach always be true?

> -	rc = xa_insert(&igroup->attach->device_array, idev->obj.id, XA_ZERO_ENTRY,
> +	rc = xa_insert(&attach->device_array, idev->obj.id, XA_ZERO_ENTRY,

Nit: looks like this should have been done in the PATCH-8
"iommufd/device: Replace device_list with device_array"

> @@ -787,8 +808,15 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
>  
>  	mutex_lock(&igroup->lock);
>  
> -	attach = igroup->attach;
> +	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
> +			    XA_ZERO_ENTRY, GFP_KERNEL);

Hmm, this is replace(). Should the "pasid" position in pasid_attach
be already filled? I mean the old entry shouldn't be "NULL" so as to
call it a "replace"?

> +	if (xa_is_err(attach)) {
> +		rc = xa_err(attach);
> +		goto err_unlock;
> +	}
> +
>  	if (!attach) {
> +		xa_release(&igroup->pasid_attach, pasid);
>  		rc = -EINVAL;
>  		goto err_unlock;
>  	}

Here too? Is attach always !NULL?

Thanks
Nicolin
