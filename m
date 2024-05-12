Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7F28DD0
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715524083; cv=fail; b=ji1IfXu9ynBgqaR33U6Kcn6AYD05rTrOTKwenWnG6wigzf8DowGIMRcmiZ/6xY9qf5mtGlwH9aO0CtEWe0ql7yMe+25GYxtXg3cQyZ0I/3LkqfZ1xDBV5K1gvd3eZ+ED0baXxpwXX+lSNcU3zB3KQlHMb1Jquj31PJB458u3xr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715524083; c=relaxed/simple;
	bh=GmovAfKP6pd5YVE9isXTK9TUhude/h/Kp2eApro9BSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jKEPfAtKAgiRVLK11EJaHB56u3hJVokjZVpebdBOrAbtXOeWHGmE1pVudnNN7agtxu81fMkn2scNxUI+wphMctZrseTegU/4LQ7hzfvz5tgZByDkQ0TUwu7+qjrEFvL4hh3QRXiHb5qSJh3BWmEkkJkEqK9oQVOoh2RBWXyw6UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jXrz8xoK; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jXrz8xoK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnvcaLu9YgBz3KVR16Z6zK8hfWc+WSUkDcJ+kLFWHYQ9Uctub8T4keWS5d6CbAsuheqaXYKuw3uubnVS2DFzpTS6rl7rRt6CnJ4QWfJG1M1sWSTsMOcs9lci6QQdIOoQDmqJU49GJS+/y8wOn5yn6sNYdfLebD0qrdhXbp+ki3ug1UYRLWMxz0XsrFyRRV74fajAgqmuXsgg6AxYZe0Jc7zfRe7b04l2P6Bh9XvL82hI3t7B8KIAkatPJ6kvojHSA5XRGmIdg9q4tyGg50GLdHg4GsH43EKikOTkMvw05mwpR1SqCQWrTv2oD/vN89xW9CT1ud7/DusiFbmWN7jmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8Q+Bt8rEhV5BkUf6cZZ5OWe0HUptFnoBkD6Um5PiIA=;
 b=NVtPcvvQH0Hne/5N4/QRfe5JYq1HTorJC8w4VN61Lfjjz8MnASaYP+Bym9d2DdWxdemtcNmSD4nxpdgdvxj1LI95XUs274cy95U1KkaBCl2lj529oRBKIPH0lyJPx+S5TNbuKVcMma6Y+12DXpW1+sVCCWkdb6oMSzM8CLiFeeWmqQpH1Hz5Z5zyZplCKbIAWFa491rmSp6f4A60MC6s5ChuzLkrD/ENi6K2YG2vu0Z/z6vwGLRhOcabN0OV6dPujYxxKjB3MlHpJwexy71cf93SJoC9J32cjkox4GMy/Drcr9jCD5WyBRwofk/0aGaqU4C9m1XhCpBHUq4OKMKMeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8Q+Bt8rEhV5BkUf6cZZ5OWe0HUptFnoBkD6Um5PiIA=;
 b=jXrz8xoK1vBc1KEr/x1P1E+pl+uN9Mpij5UrfLa7vB7j+jtYl5tBgaYBGkO952NCoVnvay9ASHdJSw/9p1I/RHZoKhYYOq9fK69irXV5ZBdQCr/07JbCoHI7wd2/Pgf4xJ6/7dSSyO+kaKMIlIZDx2BgBlkr5XvQeEwVovOQ/J7iPObr5F/2ossVJ4AzZzey0BXhFHnsyblehZKoQlnWj8tJxVd1N5VHO75opJOwX5FeBsIOLB7Uf0x9iv/XqldnLb92ahjxtBj8NutTYjiMC44ESUC8oBxQjQlLQ7xiDFv5s6ja1G5NLBTRA7O8FT0aKYVifnvLVA/taCh35UxB8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 14:27:58 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 14:27:56 +0000
Date: Sun, 12 May 2024 11:27:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 05/14] iommufd: Add IOMMUFD_OBJ_VIOMMU and
 IOMMUFD_CMD_VIOMMU_ALLOC
Message-ID: <ZkDR4Rp57cy9qSqP@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <3aa9bc1df6a2ee58a03c6ea6ededbc210a2d23a8.1712978212.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa9bc1df6a2ee58a03c6ea6ededbc210a2d23a8.1712978212.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: fc385a0e-e27d-45ec-c069-08dc728fb740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uAmb/02rjl89qDpyyWZKW6h7Q+FHjYI2stZNe6lLqsp8r8YsLOQTS/yYtWLu?=
 =?us-ascii?Q?la/+itJJN+p3y0mbQpNcWowUtQpfra1M/hDZGUCtS1k2OeigwR9em4iDlqr6?=
 =?us-ascii?Q?3Njvu+3FzOQvR398hoqYIAgrT7xSrsRvfDlQ+eVqNP7MnT9eqD0DO5Hdqsmr?=
 =?us-ascii?Q?t77DNly/5ToYVRx8MDVCMQVn3D6kTdGymJ+6aO3yFwZfhT8VabFV9oAytJr+?=
 =?us-ascii?Q?OnFxE4+mbv2jRIfOJnpugI8UMRUQmf8/3TR3xzExooC4Uc9G214oexfY+9QT?=
 =?us-ascii?Q?OmY+n0Hdk5OtKjlkEgCkxUdYGQy0qHNYUtbFeI4vfVpKVKMO4w6YO9mLu9IL?=
 =?us-ascii?Q?ASlxiFuHPn5RT0gKPF3+oKc12pAFDND2JU5KE7FC+PKpRgJhbVdDUxLEQ+hQ?=
 =?us-ascii?Q?SKJfwdXrlQVKlIBUTjUkKsfWZr08c8qh8HZyjtzYEiZY9iOk5LWwdulMjVqD?=
 =?us-ascii?Q?xS4pw0bBJsm69Ni0owNfXlb6zsSjTt6S+Dy0jPSc0wwxf4sLSO7e1vl7YW8E?=
 =?us-ascii?Q?HQvHojgVddscFeez3QEjDL6fDiwv1rHo+QiQct7imwDUoyOmBFNTsB4SdtAw?=
 =?us-ascii?Q?CFE39nt2S4blH9pKFyLlXt16bNCPHELTFeZoDfh3f35NRwQ6esLoeLDOrKh0?=
 =?us-ascii?Q?PkJR7u1drd2i8H3HOgwkmpaj/wJ3kSvO1dhFY5OGSgK+3C9uhVa0PS9lglOB?=
 =?us-ascii?Q?42FbSf24MwRvYPnUXIuSB/h5+s5tMvxzbTMZcRUbSzYY3bTk38OhyJvScIRW?=
 =?us-ascii?Q?ayQ8eJndDpaYuFzvMKgrXSQuHHbOUKGGOAYYI2NY+c8j8gjVDDdcH7cXv8ig?=
 =?us-ascii?Q?mLu+QiB1zq0l9ZwI+c7JyX9hNc5MqXQNI73ahKJ72MEm/ryw8SMlGQJkUOOE?=
 =?us-ascii?Q?N1Oq4gvtXhOcg8himMf27Sg6gqpBVOBBeaHJwS5FtEGgR/Uhfv6sUTiXxGAU?=
 =?us-ascii?Q?HkXryyK7Pu4uN87CG4hzi0fcSzl2ILP+jJWay/jZnvXMFzgDTPVN3UCOtATM?=
 =?us-ascii?Q?Ssz1OIUG8yUzzBObgS4R7lqo5xlQc2KLXnm0OKiUvipfSHkoccpA/lNlFbdL?=
 =?us-ascii?Q?xkzQ7yyV7SyYVB3+WizBkt9vHmB7GiSLpmIbu8DoROKsLB6x+B5p9K2bq8Dp?=
 =?us-ascii?Q?YD5eT5u0ocBPO8aY7lwnxy6EwB5EjB+SR8BzHeidHHFffdQ6IPlIoLRUxLww?=
 =?us-ascii?Q?kamVgSXuYqj6GOcz3aYeK8LlTw30WXO2+eIKdJxGxX7o7HI+7eVJZdc9VSPy?=
 =?us-ascii?Q?btca47Sb2Nqsj6pxPZ/4UCgEoKyTyFJCN0YR+2oLaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x0RoRbAi+I6U0DeEKtmJrFPf+Zo7X42yFHEYcTCCrn3fCMJH3Ys+ali/U1ot?=
 =?us-ascii?Q?yq7cXUPdZ8Frb5iZAoj9s6S9EDC1jqqmP5wydSMZWJu/WmshgYLQ5m9ko/XC?=
 =?us-ascii?Q?7gjnEa2oQF6KHczy2lt1OkuvCIdCwsCI95wWXn37yD0ycHfEq6H0hXQfjqik?=
 =?us-ascii?Q?hwhbEZek4lVNhX7ahSRlAA/nCnrOqoWivsFwaHiSPV96OxA9uouYcTAPTvBu?=
 =?us-ascii?Q?f6YED6gvvc+jpJrBazf+iPHl3O4eyGiePBmdNVi7+mAux2qXFdfmUtRJOygP?=
 =?us-ascii?Q?PeWTgGO7h1X8wJCLC6sBAaxJSSoxKdGBE3sVBP3cslVuOfttV389CNCCfirp?=
 =?us-ascii?Q?eouOtZOB8tuK4ulGYokeLWmEklpa1jP7ifyQP2i99d3S2+r1BnRBsFRgul/M?=
 =?us-ascii?Q?6tzTj2jMFQ6NZxTkF1O/qffR3VWxMv6cGpIvx7raNPQdvtyrxhjw1b9w7V+z?=
 =?us-ascii?Q?GQimCGgTKKRWa+NuFLkLqPYNyWQ+ENScOeayWEEhBJIzgWv5z6a3vYH6FZse?=
 =?us-ascii?Q?78rZC9BJSdbRsBSNEghO9bOp+ZfdEASVJ8t5CThnjpavlWFVRj+tJ5PN/TZ+?=
 =?us-ascii?Q?qx2garhVxrMVIFJdf40hgTlfZoFrYpFM9VGe6GP355aMeTKlXJl2PV6B4mV0?=
 =?us-ascii?Q?93nNAgy76Fox1x18dlJ1rg3zvuwcCkvJp/AWiXVNIykDj5de7y74dQm8XFTa?=
 =?us-ascii?Q?aYgwkB8eU/bWeQJ+052v9U0xtFBBmwb/O/CaXECMakmvezVNkTaXtkqov0nE?=
 =?us-ascii?Q?aQ5pPTjpw/V0xQ+lmQoeeSv65byb3nJT5Agttmkfp/897/PamEfe9DbX9vOG?=
 =?us-ascii?Q?6QEfWdKP/ViX8SnOfIyMYOIdadiTNZpH4JiElHP7x4kBP1WV0dweS9wO7i/h?=
 =?us-ascii?Q?5Q5ZnzOLA5NCHu9xHoakcAQkdrnLFssXHdt9xpCPATyPWb2+YPlk8XerLkfY?=
 =?us-ascii?Q?SmzJixZD6vBgrwsJ6RDafHmDmRV7u0SYcrhV/FRmZbdQxxoHXJPbNGqAo76j?=
 =?us-ascii?Q?VxIiGz4tWRivmh7kswZEm3lkGoSo41eNLYMFQR0TW2URa944XUh7C7ok6Flx?=
 =?us-ascii?Q?TZyX6aZ5ofCMJSiTWiEgzoYoFq2OxofF+GwQRUMKHZOa4brbhUuJpTUjqigd?=
 =?us-ascii?Q?TkPT4dvQcgszRaKTbhy8spNgP6GZXqmkmDKVZ3sbmA2kFsbo8+6Aip/YcHxc?=
 =?us-ascii?Q?N8tELcvmVKZbrn2/cCR6/bsjaz54EHVIRDSm7yh41e1ZCRMHLcW8epBTjXhs?=
 =?us-ascii?Q?z9Ay1VrWETPb4UJX7kyavJXhIMelCTFmM/9Iz2WocyDUBy1fLtrA8owbjx/B?=
 =?us-ascii?Q?VILp3Ta5SwwnBNr+c40gksiuoeoUV2uKfAltHljcmfi8R1GgDjXWM5kFpQlk?=
 =?us-ascii?Q?dQx2wSl3U2VKEBzX7OVmdvEcln8qcYi7M+YGJinuc01eYwQpVqtkpi973S16?=
 =?us-ascii?Q?mh1/HfIVewu3D8arhNu/hMXyP0hqidHXB618bQmuNrI4+ll/qto8TY9csXpu?=
 =?us-ascii?Q?cL4S3BCq24iC789xT2IC65Bf5dHG/RkNtflIcODVlSmLiIGsvondpVL87qWw?=
 =?us-ascii?Q?mGlzfsrQ5WDL84Y9qulHXH2oVh3mGdBWh1ppZxvG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc385a0e-e27d-45ec-c069-08dc728fb740
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 14:27:56.1727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5X51SI7Ixl5cUMykSanCGqgM3OTo+qSEz+IzxhF96iaSqxKkEIyIm0rnDiyfj90
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570

On Fri, Apr 12, 2024 at 08:47:02PM -0700, Nicolin Chen wrote:

> +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_viommu_alloc *cmd = ucmd->cmd;
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommu_device *iommu_dev;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	int rc;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +	iommu_dev = idev->dev->iommu->iommu_dev;
> +
> +	if (!iommu_dev->ops->viommu_alloc) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_idev;
> +	}
> +
> +	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> +	if (IS_ERR(hwpt_paging)) {
> +		rc = PTR_ERR(hwpt_paging);
> +		goto out_put_idev;
> +	}
> +
> +	if (!hwpt_paging->nest_parent) {
> +		rc = -EINVAL;
> +		goto out_put_hwpt;
> +	}
> +
> +	viommu = iommu_dev->ops->viommu_alloc(idev->dev, cmd->type,
> +					      hwpt_paging->common.domain);
> +	if (IS_ERR(viommu)) {
> +		rc = PTR_ERR(viommu);
> +		goto out_put_hwpt;
> +	}

Ah you did already include the S2, So should it be
domain->viommu_alloc() then?

> +
> +	/* iommufd_object_finalize will store the viommu->obj.id */
> +	rc = xa_alloc(&ucmd->ictx->objects, &viommu->obj.id, XA_ZERO_ENTRY,
> +		      xa_limit_31b, GFP_KERNEL_ACCOUNT);
> +	if (rc)
> +		goto out_free;
> +
> +	viommu->obj.type = IOMMUFD_OBJ_VIOMMU;

See my other notes, lets try not to open code this.

> +	viommu->type = cmd->type;
> +
> +	viommu->ictx = ucmd->ictx;
> +	viommu->hwpt = hwpt_paging;
> +	viommu->iommu_dev = idev->dev->iommu->iommu_dev;
> +	cmd->out_viommu_id = viommu->obj.id;
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +	if (rc)
> +		goto out_erase_xa;
> +	iommufd_object_finalize(ucmd->ictx, &viommu->obj);
> +	refcount_inc(&viommu->hwpt->common.obj.users);
> +	goto out_put_hwpt;
> +
> +out_erase_xa:
> +	xa_erase(&ucmd->ictx->objects, viommu->obj.id);
> +out_free:
> +	if (viommu->ops && viommu->ops->free)
> +		viommu->ops->free(viommu);
> +	kfree(viommu);

This really should use the abort flow. The driver free callback has to
be in the object release..

> +
> +/**
> + * enum iommu_viommu_type - VIOMMU Type
> + * @IOMMU_VIOMMU_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension for SMMUv3
> + */
> +enum iommu_viommu_type {
> +	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> +};

At least the 241 line should be in a following patch

> +/**
> + * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
> + * @size: sizeof(struct iommu_viommu_alloc)
> + * @flags: Must be 0
> + * @type: Type of the VIOMMU object. Must be defined in enum iommu_viommu_type
> + * @dev_id: The device to allocate this virtual IOMMU for
> + * @hwpt_id: ID of a nested parent HWPT
> + * @out_viommu_id: Output virtual IOMMU ID for the allocated object
> + *
> + * Allocate an virtual IOMMU object that holds a (shared) nested parent HWPT
> + */
> +struct iommu_viommu_alloc {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 type;
> +	__u32 dev_id;
> +	__u32 hwpt_id;
> +	__u32 out_viommu_id;
> +};

This seems fine.

Let's have a following patch to change the hwpt_alloc to accept the
viommu as a hwpt as a uAPI change as well. 

The more I think about how this needs to work the more sure I am that
we need to do that.

ARM will need a fairly tricky set of things to manage the VMID
lifecycle. In BTM mode the VMID must come from the KVM. For vcmdq the
VMID is needed to create the queue/viommu. For AMD the S2 is needed to
create the VIOMMU in the first place.

So, to make this all work perfectly we need approx the following
 - S2 sharing across instances in ARM - meaning the VMID is allocated
   at attach not domain alloc
 - S2 hwpt is refcounted by the VIOMMU in the iommufd layer
 - VIOMMU is refcounted by every nesting child in the iommufd layer
 - The nesting child holds a pointer to both the S2 and the VIOMMU
   (viommu optional)
 - When the nesting child attaches to a device the STE will source the
   VMID from the VIOMMU if present otherwise from the S2
 - "RID" attach (ie naked S2) will have to be done with a Nesting
   Child using a vSTE that indicates Identity. Then the attach logic
   will have enough information to get the VMID from the VIOMMU
 - In full VIOMMU mode the S2 will never get a VMID of its own, it
   will always use the VIOMMU. Life cycle is simple, the VMID is freed
   when the VIOMMU is freed. That can't happen until all Nesting
   Children are freed. That can't happen until all Nesting Children
   are detached from devices. Detatching removes the HW touch of the VMID.

At this point you don't need the full generality, but let's please get
ready and get the viommu pointer available in all the right spots and
we can keep the current logic to borrow the VMID from the S2 for the
VIOMMU.

AMD folks, please consider if this works for you as well.

Jason
