Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B974D21CA00
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492244; cv=fail; b=mSypwGI7m4A8p17/6vbSTeGgn9VqsDH1LpBtzVhQA3KFk/fBq3kXXvPxnCBgdH1RmwqWmlh61Qo4JltlpoPXKY1Wyu5AWjaueLyx5gDL/XZyLhFeVisfM3Jo/eGVKu941QuSwxMSG72mar/P4mVs583wMNpyFyZt1X+XZsQhLEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492244; c=relaxed/simple;
	bh=WE2v0Gg00StZ0Ay2rtXD7leJafMjusd0+yq+QwRg73s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1l1UKboMLPKTOPK+bUweXLiK5VqE8DE1s/jBYKYoiV5v4voPIHBmtF/GMXsGIZ0LaodGH4p16SVuACse7qUzXHhrv9wrlmKOtlCK01lgyELsbgeaphuHfmWmBLnApn1PbDwbuOqcJ1paT7O8dj517OW7K9iX2peXDDjUEF7Jfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jDe5jMgD; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jDe5jMgD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGNBjEbIU7LdQAiPU+/q/zjlMk4ByjLDNxBOhDZf3nNQpIVEiHZmIfkgjlum1Pxf0cVU7GgEA6dr1uSBcS4f2XQ24Br9+9K9PflVriYn6RwQ9vuPWOCrDw5gdL8/UHmlj8qQFxbY2pCJxLaksEP8EoTbAD5XPFMDopbdMVv4woNiPCMyQA4say3b80Yq3LxQBuTCVOYB5w8qw4gzo5r9yigzS3MFTkksRDecOx4hPihRr2KPlmFSX0TW1DiQgRbAiApVgqEmjJeJLKZZ/f5QDEwXoLFSe2dv+cVUPT1qVKJUGH5eW+THTMMaLbk9g1bsPaUDaXfCTReskT96yvZDpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFb7m/n7cqU4jlwLqgQ4efLQowlyvCaEbs2TFxOON74=;
 b=sZTm5oeMzzzUev5IQ+Lz6Zfy/1AHyzCWUPt5S5F2e3/NaTrkuqrkCBceorUlpNh853P4ru2GMX0GrbbMxh8yVWxmJgQYYEx8dJNMpAlkFwMZGMoE+7/RY0cBCwTWX1g+AbV7/ZzS37lZK+6amon2lwioTmlqv66VcVbEdl4Sz0xl3wLyhz73WIW+luADLmPH9l9HTK/pcj7I8ObSxCEPdWeTPuee2QMtSWlC3UVNXHVp/Fy1p+l5oLLkSioAw/OOyUlULtdGw+uks1VURUOYi5ZbgRouzUNp2e3UwpoAbWwgna9XxMKhTQuBpwVu1dOwB6wMZ0+jiK7oBN8N7x1PVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFb7m/n7cqU4jlwLqgQ4efLQowlyvCaEbs2TFxOON74=;
 b=jDe5jMgDpP6vM+F7M85a4lb4gdxz/+6MI4ZUdGDwhEBTUvRrMzkTV8JqbSvvojzJBYkmjIaKnCmz4wsF6lpHio6CA+7hDHG4YKIMgmmnyxZilbrgNlRyVYwqZKl10lF0MgkhHrJrZiqrWMUevouMB+PyJ3AV3ExMbfDMYMB1SDT9Gpn41jfJEBQm+lfpnRNNDPvfGzPjO8VHS3uiLiUTtYgsMSdxnvRD71rKlvys4EWbOIo/akaMGUG5cTVOhHfZXR0pUFPBoVVp8bUaRlhT0u4J8gPU3Q8KzxpnwzN3qwk7mAf1LaF/cFr2f9xzkoRHWFeMRL9PD8SXdcdw6qEmKw==
Received: from MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::12)
 by DS4PR12MB9660.namprd12.prod.outlook.com (2603:10b6:8:281::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 17:37:17 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::22) by MW4P222CA0007.outlook.office365.com
 (2603:10b6:303:114::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Thu,
 20 Mar 2025 17:37:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 17:37:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 10:37:01 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 10:37:01 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 10:37:01 -0700
Date: Thu, 20 Mar 2025 10:36:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 06/18] iommufd/device: Add helper to detect the first
 attach of a group
Message-ID: <Z9xSO6pIPZZLP4lf@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-7-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-7-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|DS4PR12MB9660:EE_
X-MS-Office365-Filtering-Correlation-Id: 857087a1-020e-4966-d292-08dd67d5dbea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Td0Lzi4tPbzCtih/pXJNEFeWnje3LMIBhIFk6p7RM8mi4uCnaCoO9JpvUfkK?=
 =?us-ascii?Q?oWnqyX6y37OzpY3nC8qvyMssFxWNbVIia6ci/thPyoO1g6dtsZ+Xe0dEKPil?=
 =?us-ascii?Q?3mncfV1svOX1p9phi67eyODIPZNK+pn58zymuaLDPXN3bgz9agghbqahQhhc?=
 =?us-ascii?Q?wmu9OtLmGIQJBC0PjgDi375wozLthrRkY35Jq4OabJr4QcH+SFu/KJ/X3xYl?=
 =?us-ascii?Q?YYs/Ssvo37vl7lUw0gDAD9qb2owx31iIYqG3DbddwsYeuLpu0mjyFb9JiFpR?=
 =?us-ascii?Q?n+9O9dsyuy0lZvam2HKkmhTjInEnSGE3X/rKpLwupUEBpp1n9yZV6mr3WZkk?=
 =?us-ascii?Q?bUsHqi/8ii8M2TxD2Jh4YNyP8BKW5Ou1RG8IiY5Xwo6YLTNuniwkEsfPKpEi?=
 =?us-ascii?Q?3XGTVATV+0voq0NqmEO+a9XddqKSEm3Y3yzzf3HQl1FSWpeDbB3dEbUlmhAQ?=
 =?us-ascii?Q?P/O7sXDAF7DnYI8kAg1dVXXg3pJSzUJ808MIh06g3s72HMHSWUFK2nXqLV9V?=
 =?us-ascii?Q?SIbQQpFIhstbsNg4K780zGV7GvYLnwndPPTa5NE4+SSAqBwAjq7qCkMvkdgG?=
 =?us-ascii?Q?xwaV8/7P8iwkWwiUDsM5W6hh3NbZVO3qU4tu+WZ4TtGGk/iMl0cZ3wZ8Dliu?=
 =?us-ascii?Q?MGmXDMlcdrXFK4EIlUwqTenLBby4NI9W3Lqb4TIrIJ+GQIn0hSQ5TldGFZ1/?=
 =?us-ascii?Q?pTTEIm131pmFkwvJaXnNCnbJFyEcRf/XF8xwZnSTnLxGEZcAELfbDoonu4i2?=
 =?us-ascii?Q?0pH1SaRBp2Qx6craNw4P8KPW2vA4RuRVzNqmxcFf25MyJzfBEidncZ7yIufz?=
 =?us-ascii?Q?oNLpC5RzLZMa1DIiungRMFIp+3OAT5vNQdEdve5X5WO5K0NjlKd88oTUf4jh?=
 =?us-ascii?Q?y9ERwR2RvsAMNiVxPGMFX3806BHT27Axlf7gCd1xUz2HsgS2plDoGhHMvKYP?=
 =?us-ascii?Q?CNtn9E1IARXQX+5SMVKCaoUkgzDxbSSO/J6gqHj1ylCLQ/NDCz7sVBZkVEjp?=
 =?us-ascii?Q?jHNGnoCmtXnSxV7US8MnbdVUfkuF64yY7ASV6SEqRoYO6bf9kJtLNeIHEmGE?=
 =?us-ascii?Q?zGAbxKta0pro9uzXi3CXYxRLr0v/JXPuIShD3CRvgf1gWzwNS/aK0bLhmxu9?=
 =?us-ascii?Q?UD55qhBpzTLk4BKJ6qwy6/D9MDZYTl8vfJBzoBK9kIHq8VYrAwRtOwhdIEvW?=
 =?us-ascii?Q?51o4TillRsgLDXWLicb1Kbu8Ckpv3fcO7tBrbc2ut6025OaJDlFNDztDYCmb?=
 =?us-ascii?Q?UhcKQuh3krPOOMGpJ1YDOmX1QL/ZZ6biJHtEUmoQT//65m70kn7s5a7UmeWy?=
 =?us-ascii?Q?SB6cfewo6S8p0Au1cpTaapJHJ/4zRv96GxgEyhzpxUk3yGLsOHRHeim8E8KL?=
 =?us-ascii?Q?q0yaJy3AhkcyPyvki83aor8lN+xqQTlVmKkDT2V/7NlP3omEc3tJbLUTPplx?=
 =?us-ascii?Q?MO4oRVL84nTCC1p11LW4g3U99k451Q5aFSAqUre0zQBq9fTaavXEXoXBsCHG?=
 =?us-ascii?Q?rEROcwLOZtcciSs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:37:17.1460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 857087a1-020e-4966-d292-08dd67d5dbea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9660

On Thu, Mar 20, 2025 at 06:47:32AM -0700, Yi Liu wrote:
> The existing code detects the first attach by checking the
> igroup->device_list. However, the igroup->hwpt can also be used to detect
> the first attach. In future modifications, it is better to check the
> igroup->hwpt instead of the device_list. To improve readbility and also
> prepare for further modifications on this part, this adds a helper for it.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
> v9 -> v10: It is patch 07 of v9, it's reworked hence renamed as well.
> ---
>  drivers/iommu/iommufd/device.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index ac54d734b819..9db36346328f 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -444,6 +444,13 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
>  	return 0;
>  }
>  
> +static inline bool
> +igroup_first_attach(struct iommufd_group *igroup, ioasid_t pasid)
> +{
> +	lockdep_assert_held(&igroup->lock);
> +	return !igroup->hwpt;
> +}
> +
>  static int
>  iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
>  				    struct iommufd_hwpt_paging *hwpt_paging)
> @@ -459,7 +466,7 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
>  	if (rc)
>  		return rc;
>  
> -	if (list_empty(&igroup->device_list)) {
> +	if (igroup_first_attach(igroup, IOMMU_NO_PASID)) {
>  		rc = iommufd_group_setup_msi(igroup, hwpt_paging);
>  		if (rc) {
>  			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
> @@ -623,7 +630,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>  	 * reserved regions are only updated during individual device
>  	 * attachment.
>  	 */
> -	if (list_empty(&igroup->device_list)) {
> +	if (igroup_first_attach(igroup, pasid)) {
>  		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
>  		if (rc)
>  			goto err_unresv;

We have the same list_empty in the iommufd_hw_pagetable_detach()
and iommufd_group_release() too?

And I feel "igroup_is_not_attached" could be clearer, as it fits
the detach/release context too.

Thanks
Nicolin
