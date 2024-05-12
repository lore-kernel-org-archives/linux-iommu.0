Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62C845022
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715525922; cv=fail; b=kAUMXRqmS2KKt//lqsPM5NRWa/GTa8eP5x4c2+O9WDyJnpI2B1iYrE7atg3D+wHHP/K9Ma2b5UcCz4rQjh85EXEDoPUISVOf6dZeZlG54ZtWaQuQ7YBaDpeMramuaO+wnJL12eiVKFbqVKPRUpqFNpJkSBJeaD4FpeMkP7+VHJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715525922; c=relaxed/simple;
	bh=vre2S9K2qDe5h00p1n8JF/OPkPJMLSK9uHVxmbtO7p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QKAiksTbE+Y3xos0QT7IFUYGSo8RzflPvgwN7P304Acbl9YR3XBS0fVrnBK7CfpgGkLam0ewdOKXmjbqN/fnnWoLlvATZZBR3ynSo8/8bCXtgy7SPqceJZHPOpQJs/3Pa2pvHgRTItCJ7e74oyyduYplkOZbVouamyjE9Km8U6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iClJxN6B; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iClJxN6B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGhaxRBEyORasppxoyXir0ZI7PDcL0l+Q/OYQtfbmir5qUPn1OJn48e7jD3j/1O2enVThLQMwxszXMzASFcykOp1nmzfbhn62qGcTqWmxlD/xvg22gq7yv2NW4ODYnaCVWk2Z/1yOf/0+cp3XgGXMcf7mQRU06nW41dJNUqRpoD7l/9zAaEweKZR/t8KrqCWcHaIpRgC8wP7MsuUwCg6QSmtDos6EEs4dUVdwmuWP+BYvbPdbMA6ZDyVduGVFFwiP4lCytdBomxm680H1VlDFaGmKDZlgjVpEhOQRn1iLb/W87sURGAmJPiorfni+zdSLCYlmcuZu7vugvLDFynrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTw9xfjfN+qHTRq9XId5zG016yyOiS5bJkubog43PCo=;
 b=aBXLXGdVO1hOprpE2hE3U3Z+9sxfRF/Y0s0pOeK4jNo0o3NkMUSD1hXfTlL/J3LOxiOPwwk5+V7ioHxtSLnYvvclZ8XRB7CuHsR9JWPTZBUe1WncnS2QUMlxux9AklMJQv1awqioFrlbX0cmfhm7sEIq/6JYMdB+g63s+sTNzn5bi3GPj87SQf63KH4lsTgdzwvxhAbzAs6ZdaX0M3RsdHPFUMsYWGWc7em8Cb1l/HtBsTlxSREp52e3Pe4C9kQh00jr8BJRy2jM1YUADBaaPuQ14/nlN9oup4typ01b629fUBGMfgn4dJoApZ9JbUHlqJB02hwhJ42zGaHjzSL6BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTw9xfjfN+qHTRq9XId5zG016yyOiS5bJkubog43PCo=;
 b=iClJxN6B/IX5J1rSsNcsgY/ZZVpunhbh4I+Mg6OQcOhvUFcDQ0v1Z7+UYLk+l74YDo9/XAFEns++PfK82iRSyhan3Cv+eL0nNr71UKDsZkEGLdEQoJFwS24AIj3eqpGiLIntFyl2Jlyo1b9/n1HW4/62AH2A5lIZAH+JllUNqzuoJrlAP0GanIPwzAqDoUO8UspU1k070S8dR6jGFtkw9Isk6cWlS+NVufEqSr56IuYBFWkTs/QyRDBgKkZ6Gb0MqNjietzXdDupZBSsu10ENn+qJPrnotisTkaDOKohWeAInV+HueyroAuLSZW1cr7JYrH3Q4KhuIPm7cz01GBCCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 14:58:38 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 14:58:37 +0000
Date: Sun, 12 May 2024 11:58:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <ZkDZE32JFyKprmpi@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0156cd-6b41-4eb1-80a0-08dc729400f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R5BaSj5Rx+bDM76yfUcA00l0UP9tl9rbXjO29W7XphkPBIjWSQ/4IxOCvnIX?=
 =?us-ascii?Q?WU+8WmYJWiuOVHxaE0qrylg7WDG0ZjxzvfGeKVzdS+3XoqSMDhl+rvgxsIrF?=
 =?us-ascii?Q?S+wp3iQMbeHkJCWSMCisaJIorPqwv0HiVkrJA8eZQTVmIKleGYXZPBNC77Jh?=
 =?us-ascii?Q?8Q6WDYrzdDV9h9Y4CPr+HtCahZsb224ItcNIFYmmflXT86kctSP221S/2Dzn?=
 =?us-ascii?Q?HNZ7msT8RHXMcp7nM88Hqw+WKCs0dsseFqI6gZCV0l5CzlxmywrGuBqO29IS?=
 =?us-ascii?Q?B1Qfk3d1hcLBCOw79BA5nFwrF4G46bwsT81K8DHPjt4VAjswoEqsUb6ZAgLm?=
 =?us-ascii?Q?fDgVXOsFWVOX/UVBimsK0Vk/bCXFVQFGHzKBgp47oKvSG2DdZT6XokY5Jf5a?=
 =?us-ascii?Q?vwaG5N2r92ZD+IdLat4zdtO1oVI/y+fr3fB3QNtqxzfzE7JQLO2jYajobR1D?=
 =?us-ascii?Q?HWjcDcre+8bjHLwvSsgi3sqjtOgQtxCWSkRClRTyq4vbb4P+cPCD/MeJNN9R?=
 =?us-ascii?Q?ppvZsJ9lvBcN5mh7+puF4YOqxWZzmAaRrHFTPdSG21TqaM0o7dGbmqtGBg+j?=
 =?us-ascii?Q?Yj1EwK5hGNsiPlNOJNjF56O+fHn3VNK5cgdNPhqv7V7aHrxL/Xuc0zMbwA0t?=
 =?us-ascii?Q?w54jRlvN/EBx1DFijt+xzfjxGMW7RF2UBYP3UqNqqd7K8AMnWvfd6ArxPlvl?=
 =?us-ascii?Q?52emffaJPO3axonHxX3ewW2J7cfjar82VnhrOfHjr4pLYSGNBdPcGxMXWNc/?=
 =?us-ascii?Q?PJF5hCBOP97cPoIy5k5ABB7TICoVK7+gMbOr+robOywf9uwicY8rwlXpkNID?=
 =?us-ascii?Q?xhREsKvrIvWcVAmds3OzxBRVLx1kXt9C+m9NhwomVN4A7kweF7A4mOMPbESF?=
 =?us-ascii?Q?RcaFMM2F5qeayykbYHUy7dAZM1bh25+cNgcmKtEEoRDFOB16+/OlPyya6QSn?=
 =?us-ascii?Q?RVGuDY6etkX/lSqy7hH/0HwyqNyWrEiaBNUzedvzqpVSuKh1L3u1vwTRFE5R?=
 =?us-ascii?Q?+GBDteSB6BZnFjKfSNiF4gCYexcltIJljf/gVcWu06OEA90gnL0bGfeqf5wi?=
 =?us-ascii?Q?EHKS6Ej7mhCbRRa5GvycFFc7pCeKJWU3ZLHDD9g55vjarnHytTsjChs54JA6?=
 =?us-ascii?Q?BfO0Zcy5DbYYfkSzf8sph10kThSmGczLBraWsCCCxHpw5QPYNtI4N1DHL2qf?=
 =?us-ascii?Q?0rnJS9hK/z+X3iCQ7OmRLD8VDzvO0op/1c5zmJDtm4wn6V2A/JidzTpAPGNL?=
 =?us-ascii?Q?Yv66kXDUwkBJfSbx8/mO/HXTr1ZLZSr9+i9an3zQKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tuovzTTkf2C5By54+w7SelM02DqzO3CEtF84URTzT6Dhb1YCklPihDgbbYg8?=
 =?us-ascii?Q?MnJwciACcvcj2391u13mh7mx9Me3gMCagVuC0GTldeTXl7pVhX673+Oq52bO?=
 =?us-ascii?Q?eavXAuG0jBtKxDIOi+f4kEhSWEU8tJx9fwn6cOCb5FvJk5KuvGN2+5CCE1hV?=
 =?us-ascii?Q?HrBKqwz5t89w9ZQ4PIGsz/ZtlRStKDA9K/63X7O5DhH7tyUVA9H8BArO509s?=
 =?us-ascii?Q?SJeOI8bNe8iIiwrNXDLW1ZOzc6+bA0Nw2IfgnzbibjVmk/VQpeqo8xYWz7zw?=
 =?us-ascii?Q?KGbkNsFCu9r4PuRCuqs8S5i1Cz8YawDuwtDEhGXUt/exwgVlTPeqTFyZdrLD?=
 =?us-ascii?Q?XbpUboBWs6YrTeXivoOgJ2461mbATu7fSJ5X9CPLWmc6YDJZ0riB/lBWT4bN?=
 =?us-ascii?Q?0rCLv+XaP+Vk//cvqeXOhILb3Nf3Fcu6m0ZQLL7fGWVUQnxztLbdj6dVgCxY?=
 =?us-ascii?Q?ehPQUDIYc7HMHQLU0HMZTsZfOORTFCuCxSAU7q08I+fsCnX35sKMd/odUsSN?=
 =?us-ascii?Q?BKjEzxwMAyzWFff4Aki3yEv/VGugpbmGg1AuW1EcbxPgbJ8xGNcoILb8a7a5?=
 =?us-ascii?Q?udSmtkIb4Xhek7IjmNK3BXFMmJCEu5B8MvXUn5lBjstvUxFLbRECQGqzR7Qq?=
 =?us-ascii?Q?BAs4/lNbIv9pNEeSrvQSnK8uN79Wcg244SBjjfoPrg/NzKUnEK5j9mIjvRoE?=
 =?us-ascii?Q?5P2dJMLT8NQ8p2jY3BPOfS5XIRJtYjgVY25jUbcycQpBpVaYXX2lSL8HcXRg?=
 =?us-ascii?Q?w/zYHMOWzKy6MZgEbHYQ9kinUp1td9uYOe5UaxAmi4dZYLSLI5qUn9ebGDEJ?=
 =?us-ascii?Q?x6yxwY5WG2TkjWRwiETijpy8BQNGTHPLjgkHTOUQnGjop9ARF9CPYKO/nIt1?=
 =?us-ascii?Q?dGcRhm/nlWqXHZMCxvGqphpps32pQWwODYCAxJZVML8UX67Sxr1cf7jBWDLM?=
 =?us-ascii?Q?hXH0tX9gukmFX6lKv1WsIygrlcn7FOmQNAN7Su6tuScXT/yXsKqPPhn3mWQr?=
 =?us-ascii?Q?REKUHg81k3Ygy11KfpwGnNUmwXZxibSSVaSXAcBrcgYOQstDW9UOfvZEnFpn?=
 =?us-ascii?Q?4oFDuu/+pYOvjrl/5tCn9XGpBSFMeS458faxUhb/RWxoAx6ZenC3ylu7Khyh?=
 =?us-ascii?Q?NpLozcWh4S0wwpFXDHr4mgrGwQVpXQ/mNilhz50jG+51ztQ1CT9BFdnn9o60?=
 =?us-ascii?Q?PFnJgGnIqgp9MB8TNoNshDPm+uQMuEK9W9Au6Gjg/ppue7TcOnQZRdaIuDOr?=
 =?us-ascii?Q?ZzoTRM9ql7/dzm1dvuobHrB3UlYmjF7XTcSHU6aVYQlfri/4rk6x2lbzxqWf?=
 =?us-ascii?Q?GGsPEytEmlfyeyUEEL6jJMtqb5KGONRsM4zQx4JuhFDgP+oRxD/85P1iZXs3?=
 =?us-ascii?Q?LbM/pxs8ATOEH89D3OEH8YGhU7HwM1UfRrc6JdG7YG6KIIxWwxn/5Zij5rXd?=
 =?us-ascii?Q?eM/BwOSgqrNuzGT5yRm//er5ykZxH1oumSMwaM8GrIF/TlTk4x1yotYLhlhW?=
 =?us-ascii?Q?2noNBZlKSD4zjXVWx2PnPLmsfmfBNUjvH+ljd16vtw5JlSlSAmTXDj8g2rXV?=
 =?us-ascii?Q?fKisDuOMS3tc8X9mQGiL6ceN9xsDWu91MxK1bGUn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0156cd-6b41-4eb1-80a0-08dc729400f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 14:58:37.8751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pa1viGjYNeWTWDB69omCLBCH8mZuYZdUo4xKydeQzpXJHSkkbxLnn6jKFrKCmSo8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

On Fri, Apr 12, 2024 at 08:47:05PM -0700, Nicolin Chen wrote:
> Introduce a new ioctl to set a per-viommu device virtual id that should be
> linked to the physical device id (or just a struct device pointer).
> 
> Since a viommu (user space IOMMU instance) can have multiple devices while
> it's not ideal to confine a device to one single user space IOMMU instance
> either, these two shouldn't just do a 1:1 mapping. Add two xarrays in their
> structures to bind them bidirectionally.

Since I would like to retain the dev_id, I think this is probably
better done with an allocated struct per dev-id:

struct dev_id {
    struct iommufd_device *idev;
    struct iommufd_viommu *viommu;
    u64 vdev_id;
    u64 driver_private; // Ie the driver can store the pSID here
    struct list_head idev_entry;
};

> @@ -135,7 +135,16 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>  {
>  	struct iommufd_device *idev =
>  		container_of(obj, struct iommufd_device, obj);
> +	struct iommufd_viommu *viommu;
> +	unsigned long index;
>  
> +	xa_for_each(&idev->viommus, index, viommu) {
> +		if (viommu->ops->unset_dev_id)
> +			viommu->ops->unset_dev_id(viommu, idev->dev);
> +		xa_erase(&viommu->idevs, idev->obj.id);
> +		xa_erase(&idev->viommus, index);
> +	}

Then this turns into list_for_each(idev->viommu_vdevid_list)

> +int iommufd_viommu_set_device_id(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_viommu_set_dev_id *cmd = ucmd->cmd;
> +	unsigned int dev_id, viommu_id;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	int rc;
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +	dev_id = idev->obj.id;
> +
> +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> +	if (IS_ERR(viommu)) {
> +		rc = PTR_ERR(viommu);
> +		goto out_put_idev;
> +	}
> +
> +	if (viommu->iommu_dev != idev->dev->iommu->iommu_dev) {
> +		rc = -EINVAL;
> +		goto out_put_viommu;
> +	}
> +
> +	if (!viommu->ops->set_dev_id || !viommu->ops->unset_dev_id) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_viommu;
> +	}
> +
> +	rc = xa_alloc(&idev->viommus, &viommu_id, viommu,
> +		      XA_LIMIT(viommu->obj.id, viommu->obj.id),
> +		      GFP_KERNEL_ACCOUNT);
> +	if (rc)
> +		goto out_put_viommu;
> +
> +	rc = xa_alloc(&viommu->idevs, &dev_id, idev,
> +		      XA_LIMIT(dev_id, dev_id), GFP_KERNEL_ACCOUNT);
> +	if (rc)
> +		goto out_xa_erase_viommu;

Both of these are API mis-uses, you don't want an allocating xarray
you just want to use xa_cmpxchg

Put an xarray in the viommu object and fill it with pointers to the
struct dev_id thing above

The driver can piggyback on this xarray too if it wants, so we only
need one.

xa_cmpchg to install the user requests vdev_id only if the vdev_id is
already unused.

> @@ -51,6 +51,7 @@ enum {
>  	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP,
>  	IOMMUFD_CMD_HWPT_INVALIDATE,
>  	IOMMUFD_CMD_VIOMMU_ALLOC,
> +	IOMMUFD_CMD_VIOMMU_SET_DEV_ID,
>  };

We almost certainly will need a REMOVE_DEV_ID so userspace can have
sensible error handling.

> +
> +/**
> + * struct iommu_viommu_set_dev_id - ioctl(IOMMU_VIOMMU_SET_DEV_ID)
> + * @size: sizeof(struct iommu_viommu_set_dev_id)
> + * @viommu_id: viommu ID to associate with the device to store its virtual ID
> + * @dev_id: device ID to set a device virtual ID
> + * @__reserved: Must be 0
> + * @id: Device virtual ID
> + *
> + * Set a viommu-specific virtual ID of a device
> + */
> +struct iommu_viommu_set_dev_id {
> +	__u32 size;
> +	__u32 viommu_id;
> +	__u32 dev_id;
> +	__u32 __reserved;
> +	__aligned_u64 id;

I think I'd consistently call this vdev_id throughout the API

Jason
