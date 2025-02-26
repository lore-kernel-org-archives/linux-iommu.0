Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C325BAB1
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608199; cv=fail; b=utn8E8bKMuk2nezqtaQ1BG1/TYXdAGsTodybvvooYfgW9LCKgfXEw3gR8GvMnNHCqIa7Bg9cS38wywF0bdXV7DwjG3LxuHSQWD6lH17AXIbtCPlArjejg2zPH15LQUFjclkuS8AHMTGkBBHtBegxO3u8NwfLn01hud2gwGXuecI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608199; c=relaxed/simple;
	bh=bPK8xMMXRkh1+8kE0gyR5xlUb0w7XCbKxapy6vH8zWM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv9MUlgXhKM6lF8wRVFGs3d71L+11DuNmH1j13ASgyE6QYaahdRipFsGI0XhHByalqZHKCQOa67QG9CLJjwEBRsYM+ZV2HHCxjLeF7n44ht4ig2dH73Ynig00vZ9JrKwo7+/JKwaV3FXcZu5bGeqDNYmrDl4RXIOBgZ5LVXXS8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KlFoFRBy; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KlFoFRBy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzyiEaeH1FKHa44PMo9RBgYvV50XUkmdzgNDDWlg4f2ErVfWjG9SMV3rYT3secrO2dgtiJNC+E3IwrbmRaa1LVbEZGgR77LGfYrxvEZODaUepXTElGXdRCFQH+AeHx8fCX9azvMnSETl/AE5qXR8ae12kQBl+vqjqjaKggkvk8lAiSHMw5PdKdd9Im9pFMaEhRVUoqbXXA9b0Itqd9RwhYIMRrVB/t7VumXFyGGhjsYqz379LA9L22jz9PN+fz0O5S5ZDMW+lO1sp4ol8bkdL+CJIbsMeMx5HJOU0AZNZVEPruNnP7aB3dKbOeXhW2OHxRZXjuF4VISNGKruUZpRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRc31xm8JN3vBnYXECaLSIZhCMqnckF4CZGR50RJGGk=;
 b=m3Hvb70veQdlSRD8Qd6IBeFN8ee+lBJfvo12IuuisgPbzhf6nItxFQC/K4+iWxcCfPmJjhPAim6Vz7lB1q782KJn7XEDibxLo058QipdxHcvVR1mUE+2btZrCzyZn50UQJNfCnI9OUtr4zrXJMXgAB4aH3dwNhTRe0472bvKgcyHj+xN5HSxw89DHqET4TZH9tpb8e1C2f9OtSdGnGTvBxY9il/WIc5u2sEt7TtT6nCASFtSNuTy0hSt5SPAOACqy7N551veX00L/WIEtLljwUNjIqP1yEkjKTf59y861lG98lllshddH3ATe71bCzpfFV+/gIJ49elvyIikjqn6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRc31xm8JN3vBnYXECaLSIZhCMqnckF4CZGR50RJGGk=;
 b=KlFoFRByCx87aBm11pR0L/WfXswmA2gD0W1nPoU29ULkTL8ydHzY+aroqy2sG88f5TuuH8DaZVLcxmkquEUTn+ZtO2Az92LkQipM461mk1ot5/o4jsWvaPd+H3CQIHYGK1KCMAphCmtjC9V9c33gIGqtC4EJglJRAfDa3ujZlSsMj7bcNaDI34bJCjOZYS0f+i7Uye71L6cISbluBTT7culm2Z7MAZ7oIkRSyYLVgabTIIcD3Jw5zqC7/dgYyLYdL7OQcCrZifbNALuhvZxQStLqbMDWh09ohcRgbffkX9ZKt//gVFXpqYQdxD7jIX9oX1M8BIIteOEjY3tfY3YIkw==
Received: from DM6PR13CA0004.namprd13.prod.outlook.com (2603:10b6:5:bc::17) by
 MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Wed, 26 Feb 2025 22:16:27 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::92) by DM6PR13CA0004.outlook.office365.com
 (2603:10b6:5:bc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Wed,
 26 Feb 2025 22:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 22:16:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 14:16:15 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 14:16:15 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Feb 2025 14:16:14 -0800
Date: Wed, 26 Feb 2025 14:16:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v8 01/12] iommu: Add iommu_attach_device_pasid_handle()
Message-ID: <Z7+SrQFXdheJQzuK@Asurada-Nvidia>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-2-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226114032.4591-2-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 3962eaca-4917-4c91-5753-08dd56b336b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L2oxcc3bm53OttT+zMnEY9lEtU8IjiAyr9gerZ4IfVYbEXAbd9z38N1zRsCd?=
 =?us-ascii?Q?meWCakk1bvC/YtaU8UMECJSXq0aqH0YdAS6ZkGkOfQN5RSP/ela0HON5TDWm?=
 =?us-ascii?Q?cL9ldw4VPq0d/HecdabHfEA4muSWBgSgrwXrRyNprxZWd/RtdO/rfzH2Zey/?=
 =?us-ascii?Q?ojKimFdUkYYXcqEfuZ4cHD/p7QT8YTiXPkCGRwarenLrTGLEb7RtBxY9RpkW?=
 =?us-ascii?Q?9eLxPplt+1gxeypkfulX8jKwBtvXDyg533srqudIeTSgomkVPcS9V0fcXXHS?=
 =?us-ascii?Q?Lh+fZUdcmm1lkqWjWzfiwxbNiV2LxBE1hRyi5zeqO2bRL15ThdGARvsz4RoA?=
 =?us-ascii?Q?wWRC07LffNqoMGRO1Whl0KvVjUTUv8OLrG5ParT+EaY7LiLJvNj+iOKIcWzx?=
 =?us-ascii?Q?LiWK7vWRCE/Q7t127C5f/cJK1eowP7AF7hYGiNcVDisdGwZ5yyQ7O3/w/jpX?=
 =?us-ascii?Q?WKdXL3wqQ2lZ0fsTtcYtj3TZlb1ZcI9v4GPbiIWeMyt7TK28OiHxfl23ThEf?=
 =?us-ascii?Q?WBOnQbjI0VCstRjdokxK+Kw/OuODa3BV0ZKfb3BzQG3ophgo3w9I2cs6jDhu?=
 =?us-ascii?Q?fQPR3M4hlV5vGjOBrRIuYYjlCKPjUmKBYMRtb5pH/EPXdoACWxekjDbpahYX?=
 =?us-ascii?Q?ZzoeRpM0UtdqbuRaCtlaaRLHTwZTgvShQtBnk61XIHQ00mIqtRKZKCIitYPE?=
 =?us-ascii?Q?pSedw2n1twJICm079gAZDIL07MK8Jm2PCIzG5SropC9dKTjKeqjr89jiHwMj?=
 =?us-ascii?Q?Ugy4QGs9qXbNJqaUeNbGioWj8nrQ5ZaX++s9xrm1Mjmpn7poU5NIk5gdgyn5?=
 =?us-ascii?Q?pO/p0NaDoVuR4YwhI/NemkPsOXnB2OpWGK0va3WtWfUMaLeJcnSlEZ5+g5jk?=
 =?us-ascii?Q?WvHNsGQO9ZsuKbHsLnl+FKW2cTLtHisiqjErYrt5Rqrt8T3bvxkIqXaiUqsp?=
 =?us-ascii?Q?f+TVuj1wAgSqBVUxT/QTJav30yX9ZD2T5Kttqmb9NGJEKW5FN1erXGgXeZy4?=
 =?us-ascii?Q?GsoSveJus4DrTwtbSfs/rWD2Uuq3oca11vtlnrJlrVpl+t7di8GsYwrWJ15N?=
 =?us-ascii?Q?X/EBk4l8e4sJBAFhiiHvPB8xVgnvckk22oSpkyNXS0owS3c6DaDLSaNmrhyv?=
 =?us-ascii?Q?qjS99w8qjx/XTiRdHpqKU7eT2OQROrR+MH1AYLhKSei5tPbUqWLk+x0Rg7J0?=
 =?us-ascii?Q?70RUx3TorpM76irdg9sXupxdFx7Ur1SBcaY7kbwnG73AtkZJ890zHrRsmtbw?=
 =?us-ascii?Q?+11MwOuqn/rmytB2+4rCj9kg3+1ktKb3/aZulIqXQbGMzCMLB31C622fLROY?=
 =?us-ascii?Q?Y5pLq0FeWHNDO5GAKirQwlTsJPp5ZKrh9KuTap6a2GJE8MNH7Ah6qdaykDoU?=
 =?us-ascii?Q?j4BRWfNyuugnxfpPnp/iDsrBEw5DomHzAqY3M5rg4ABgmvGoy0fuUJY4frk2?=
 =?us-ascii?Q?gvfMp1qBo/RHNXKQmFmHD8xkr1B0yAfjBcoxB2Wvlo0R/5CtII0ECo5E2oB/?=
 =?us-ascii?Q?DHI/Dqan+ZqXNPc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 22:16:27.1889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3962eaca-4917-4c91-5753-08dd56b336b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957

On Wed, Feb 26, 2025 at 03:40:21AM -0800, Yi Liu wrote:
> The existing iommu_attach_device_pasid() function allows both a valid
> handle and a NULL handle, which is not consistent with the RID path where
> iommu_attach_group() and iommu_attach_group_handle() coexist. To refine
> it, this adds iommu_attach_device_pasid_handle() to cover the case with
> valid handle, while let the iommu_attach_device_pasid() only deals with
> the case with NULL handle.

Hmm, I am not very sure about the necessity of this change. The
underlying function being called from those two helpers (with/
without handle) is still taking a NULL handle, which looks very
straightforward to me already, so this extra layer feels a bit
redundant..

> @@ -130,8 +131,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>  		goto out_free_handle;
>  	}
>  
> -	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid,
> -					&handle->handle);
[..]
> +	ret = iommu_attach_device_pasid_handle(domain, dev,
> +					       iommu_mm->pasid,

These two could fit in one line.

>  	if (ret)
>  		goto out_free_domain;
>  	domain->users = 1;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 73a3b20b2ef9..f6dbb60ef948 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3354,9 +3354,9 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
>   *
>   * Return: 0 on success, or an error.
>   */
> -int iommu_attach_device_pasid(struct iommu_domain *domain,
> -			      struct device *dev, ioasid_t pasid,
> -			      struct iommu_attach_handle *handle)
> +int __iommu_attach_device_pasid(struct iommu_domain *domain,
> +				struct device *dev, ioasid_t pasid,
> +				struct iommu_attach_handle *handle)

Should it be just iommu_attach_device_pasid_handle?

> +static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
> +					    struct device *dev, ioasid_t pasid)
> +{
> +	return __iommu_attach_device_pasid(domain, dev, pasid, NULL);

Then, here:
	return iommu_attach_device_pasid_handle(domain, dev, pasid, NULL);
?

> +static inline int
> +iommu_attach_device_pasid_handle(struct iommu_domain *domain,
> +				 struct device *dev, ioasid_t pasid,
> +				 struct iommu_attach_handle *handle)
> +{
> +	return __iommu_attach_device_pasid(domain, dev, pasid, handle);

And drop this?

> @@ -1139,6 +1154,8 @@ struct iommu_fault_param {};
>  struct iommu_iotlb_gather {};
>  struct iommu_dirty_bitmap {};
>  struct iommu_dirty_ops {};
> +struct iommu_attach_handle {};
> +

Nit: no need of the extra line

Thanks
Nicolin
