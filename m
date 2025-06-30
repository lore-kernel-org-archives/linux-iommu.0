Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC421DFE26
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312062; cv=fail; b=oJ1Dl4Uad/bwm4bCJ259eIJsWfWvgMF4Oe6iHqcp0unkmY3vI+YGFkIfVVarKHseTcsMQcoYlTGzKZwbMt5hVWh9R428CcDBtracSDbgvZhGV4pdLCntievwZG8AwwozeC66YMFZt1TFDYkVHveKm9EYrT/vkO8fREyXrMayZfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312062; c=relaxed/simple;
	bh=ihPdzWrtWjfhMvn9MTg8KbWjCRYqCc7J22awCB4Ngg4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSebK0axoCDOM3+UibnpKaSkOG2wrECD1q/LMcobwiOsvuqWC+8Rj917YqlN+aBMuX1B3fYEhvJH6f+04pGI5T3FmzovthKJGaVx+CJEGno9qe3N5934pgCR+wRm782BNArWcS8mqBEFUeHPgOiV5oW+/gs6bTeGVeKJdRABANo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WsJ5frh6; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WsJ5frh6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnuBZtv+2ofiDFyLItobAaxV94VjjCPjZ+rAuamY3ggm1R6ZB85iOfVFGw7l1hFXlarzFuS5xARmCFEb4ibBXvtACs/m52UD2iUFBR39giRQtGPZjBL9t+s2DzlJyaxcXs27a/zD4FZtQ68tlA+Lr9rbMqGsr07W+kdVIVVeTfREJMP6CuLTTwR9GcDzX/BoOgt07HCKy92NvOrMe7W1fqbdKxkSC+YXQFt2GAw2oDZGnjANu9p8V6C3eFkoSFq1hnbNTosMmsYfEi7buzdCM0ofv3h1CZsBe8iHqzX+fhDpiK2jOz76gVHQbKzTjpwQmCRLamT9yCaiInjz4UlXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gnjy+RpRV921LvA1P4Ggk7vhp6Lsrnk9RGK9sQMmQbI=;
 b=ZmDKemvZEojGbIa2guVrwssh9ckFW6Z3wjqvizRRfvTLdniPI79YjQdd57P/OUAUAIP5anomIdwwhPQ+BGYgh186Y54wa5VDKh6xulxlmFh5EE+qjO6uBKtutFl4MT4U+hDPWwtoiHYXiRvbv63XV5RYuyKr9JoJ5gsUF+LPf3AKpFKbLiLYok2L2B8I2q4TDZcL1BQBYC7ObhP3PfK/LxIAUPdA4PVrcUDlqCWV38n6omAYM8TNc3kT/Vzi1BxcDwAqiQxWiNiYBP8ZZAhq8XooLtx+i3xJGgZIOs/QdK8x28npknbeVY/4bjagRTMzLIyVVj1yvxiaSJZkb8g2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gnjy+RpRV921LvA1P4Ggk7vhp6Lsrnk9RGK9sQMmQbI=;
 b=WsJ5frh6aCnJFJN+spcbvjOuhq1AZOBlA4R7xH0lVLC8MnI31HcyXfroMh3MHi/Q5yKzfzk5qebR0vx2AjZFk7lqOeBepjeKwanW68Ow72RJ+quv6CsXSYzF4IccCyh4mUUHaCGugVNhkOb//0m/67DD756I3DFxW9Q/R/RG5sLKLLIFtbR/bTnxcgcmoIQfjOGbjuPj1QWuQtoTVL3ZNqpoJnu7xA7f1V+lL4ce0ol8213nHhfLQPsE4xl1pGmmqyjzhmKaz/o+EboejGn+mh+elbX4/8IFYo6Gg+L5eFplnxGw8k9bjU0CDv0tsQ0Ww/xmfbPFgUvpRPLcV24dhA==
Received: from SA1P222CA0160.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::6)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 30 Jun
 2025 19:34:18 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::f6) by SA1P222CA0160.outlook.office365.com
 (2603:10b6:806:3c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.32 via Frontend Transport; Mon,
 30 Jun 2025 19:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 19:34:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Jun
 2025 12:34:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 30 Jun 2025 12:34:05 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 30 Jun 2025 12:34:04 -0700
Date: Mon, 30 Jun 2025 12:34:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <jgg@nvidia.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aGLmq8D88mN5lkmN@Asurada-Nvidia>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-3-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250627033809.1730752-3-yilun.xu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2a20af-25af-453b-4c8f-08ddb80d1a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FLkPjQ9d0iR6qNwYiNLyBmhB988DVZxIUKUJ9XWDmtXdGHiCyU5NcegQu4fN?=
 =?us-ascii?Q?Af4WlbWCE7mzMvxEPIPl3b5PaG3aFnQcfUnXG0ZYZnWFCbt6PUWjozRIig6I?=
 =?us-ascii?Q?ImZktojA0lZB+iyF1CfU1G317tWuI1neSp21spnQpAzW6Vx2N9V46HO/TWxg?=
 =?us-ascii?Q?eUzJRbZpZKThGEd+tXFkzlLzieQol9xY5NBccw+FBIfdfkopgcFj+OOyVslF?=
 =?us-ascii?Q?xyOH1hviNcjxXE0I8g5SWmGar2aN2+P7UuZjZYTGa0xwtU533pkrjz+33kXq?=
 =?us-ascii?Q?nxMj/NcTO8vaxQoyyZcEMagiV3zVuiomPAU4S65iQxCuo4DsYu+pBe6O7ni6?=
 =?us-ascii?Q?BTADA4h3ANwcuQhmklvgZZ+x+gBJ+DSZI+VuS4SXvNuExoZoOfOh6V+OTR6V?=
 =?us-ascii?Q?qGrxkoD9d3EwFhwrUWz3V+pjxeQvMtrpugH6gR4XQbRhX3EnKgVunsh9C9fN?=
 =?us-ascii?Q?LEtKDLbaBaJ87rMafm5dKWwx+v33RKb67n4tETD8RMxUUwZjVzRczSWjy/yU?=
 =?us-ascii?Q?V4t3Ebvhl9v7h86WknwPtpzuvfCV9TBvZwXwxZtVRbvQnlqF1ZavP5mIRegD?=
 =?us-ascii?Q?emCKnOlhpnV77ToW3YCHI0/+CDfRSbQ3gxAEx2jIBlTfpjv3UESZZpjnypnp?=
 =?us-ascii?Q?zX6Pott3LVHq0a9SLNNUz3r81ZyoFLi1xjRIVDUOq9jPCH9G7eyCEQtxT1I8?=
 =?us-ascii?Q?jeXO/8aV3W8RRtHp9a2ouIe4LTmQrCEbU+xVQTSbRaPXzxzCyKYiqqcpPayZ?=
 =?us-ascii?Q?+K//LcjTY7JLxJ3m8SzxFD/8u4Y1J53XnEwd3YtfAxS+cBA7Sd+dxa+nKpVX?=
 =?us-ascii?Q?54BRd/qGoFCJ7DIm56Yih4IPX5WLcdCne0q0QNHBou6sEdJxkkqJP3rH3WWK?=
 =?us-ascii?Q?KGeEj8gqEfrMcZreAzAOG/5wjykWJZiD2zkbT9L1qT7PyAHXj5Cw9caYbqQY?=
 =?us-ascii?Q?Ua/0SIlGIQsSVSfAnVcScWIXVUAyARFXKV8IFMkRI32pAMPM/eOC/RJGhNvw?=
 =?us-ascii?Q?IaiV6gbSgVhIWAOs0r8KqAFb+A2adFfb/mU4Ho9lMIDjciXsMrGZdyT2YDfJ?=
 =?us-ascii?Q?9kCvurK6EPLzgBgRYb6WakqVkCOC08/pAO0rtjoraIfSfeIsqGB4YThggbBw?=
 =?us-ascii?Q?x6lNOAe58iffvtUGa80Gy8C63CXRm9a7rGWwQW9mcPxqHXv4lH6Wzg/j0l7L?=
 =?us-ascii?Q?KQt12g2s+p1cUk6XdlP9Q+xLCriZ6CMJhDdCTyYuFCWoU4Cwbn2gCWpMmliQ?=
 =?us-ascii?Q?BdBLk9ls7TRnV0RyVar4vdK4JLyiyzum3tZAScUgMwAz84ELuaRU8UfYhaHG?=
 =?us-ascii?Q?8RKBM2VSsN2OrLQx1bl/qJUgX4gW9KC1yyCCvnprmHK0pYmED1rt8LYgwJVu?=
 =?us-ascii?Q?/6jpfB/xJ/PIKu6QgTuf79or2LxEP3iRP5UsQmDHvHxHM3ymSh3Jdxbg1Qbi?=
 =?us-ascii?Q?Sc+khfYqy3n4oRmTH3auWdNe7geQwdzAUCkNI0d7jewMbuD90RpriBJRVl2V?=
 =?us-ascii?Q?RaEasr2srt2pvQIQYwaxnvph4AmOTbv9oqQapGYrSJfbAwIoyWzeeYXYUQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 19:34:17.3737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2a20af-25af-453b-4c8f-08ddb80d1a7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446

On Fri, Jun 27, 2025 at 11:38:06AM +0800, Xu Yilun wrote:
> +static void iommufd_device_remove_vdev(struct iommufd_device *idev)
> +{
> +	struct iommufd_vdevice *vdev;
> +
> +	mutex_lock(&idev->igroup->lock);
> +	/* vdev has been completely destroyed by userspace */
> +	if (!idev->vdev)
> +		goto out_unlock;
> +
> +	vdev = iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
> +	if (IS_ERR(vdev)) {
> +		/*
> +		 * vdev is removed from xarray by userspace, but is not
> +		 * destroyed/freed. Since iommufd_vdevice_abort() is reentrant,
> +		 * safe to destroy vdev here.
> +		 */
> +		iommufd_vdevice_abort(&idev->vdev->obj);
> +		goto out_unlock;

This is the case #3, i.e. a racing vdev destory, in the commit log?

I think it is worth clarifying that there is a concurrent destroy:
		/*
		 * An ongoing vdev destroy ioctl has removed the vdev from the
		 * object xarray but has not finished iommufd_vdevice_destroy()
		 * yet, as it is holding the same mutex. Destroy the vdev here,
		 * i.e. the iommufd_vdevice_destroy() will be a NOP once it is
		 * unlocked.
		 */

> @@ -147,10 +183,12 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	if (rc)
>  		goto out_abort;
>  	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
> -	goto out_put_idev;
> +	goto out_unlock_igroup;
>  
>  out_abort:
>  	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
> +out_unlock_igroup:
> +	mutex_unlock(&idev->igroup->lock);

Looks like we will have to partially revert the _ucmd allocator,
in this function:
https://lore.kernel.org/all/107b24a3b791091bb09c92ffb0081c56c413b26d.1749882255.git.nicolinc@nvidia.com/

Please try fixing the conflicts on top of Jason's for-next tree.

Thanks
Nicolin
