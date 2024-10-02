Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96C1CF7C0
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891476; cv=fail; b=mBLctHPzrRoRYdmXhA3E/l+/brtcx0BUduVvHF1uY78O+7pu090s/8W2VsQ4qjq8YWOQOjafoSf8wfIIk1LdFcuL6Qwp9BGZofn1W6OCCVsaBTrqkXN5OrQCTGPU1IlgZuRiScoA2bZ3nnv9IbN9M2JXjsySgS6Wl33g+qmW7t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891476; c=relaxed/simple;
	bh=p+conTnyaC7hl00Dpsl0tDNnJwW2YHqWGxIO50EuwJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O5VWp4cWs+bEirDqN3Td6VFzfo5EzLH7lvaq/znktEpEmBC9fBdRQct7iJHPIoWHTM5fHeDXcRGkWopWDxgRmLarlagOWjybXDjdemVaSGHGf8yht3dfUZEjHezu0HAst4fj/ZDzxquTP4Il9658ubrUkBRVQAmF2nyER1o6X/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F8lRqsGL; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F8lRqsGL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2tguP2E/e6PlC8R2PuUhQxqdl4mShbHfodOfp8ym0DQOnGWlAAEaPZTtSt0zBeeKaUBHtk6SkoUsU6bcMf3NHvTyl7iqJMyBU4K8YzPf4acnPpHSfgZ7OyjL6sYGRHd9B42pdkv/WOTtCLf5zCDaF7pLAcoPyXDk0+B3m1BFYxWZ/I4ho7r21rzvPLE6NPz6OBb1krFIYh1YQbnD1LFd44J/kLn+6ZndkIKcI1BxocSL7jSS3BsYl0k1ZGcAok6sGJG4aawIFzR5ti74locy/IoRv9hv946YOwL3P1CzONj53MAK25RuepJzSFA67cTFkOfIt/hjzzusWX4D6/nRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aI5i0G58I6rYR/OuX7uNT/dCF7nQQcDmwZqc2cem3yQ=;
 b=sqf3MgtOOPmubM4a6Qtnt+Pfybdj985IgiRX6f0SDh8wXzvEfBAq7P68EA4mIZYUE0VEWusXfOmFv13UDEFQdqXcfA+a8IPAruf23X9mFI+nKtgz2nzVecCQ3/hdcQ+xe1mS8n66HW3Nz9y+dnrlRsvz7dWl4tdqcDpik1Yx+BgDo5T1VAPNaqrf+ojXLmDf15W4AC0avEWTJ3hdSlgKyoGUytmMts9Ma8/ERe0uSV9mfNN8lZwMlfzA4+fafZ55ku36dLmPQsVFaCgqZdlfbrIC8c+tnGzoCh1GoMjrKujzmegXMcJ9QYnSETmyGa89WgyoRF2zM+IU8rgA8H/e0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aI5i0G58I6rYR/OuX7uNT/dCF7nQQcDmwZqc2cem3yQ=;
 b=F8lRqsGLwTNfkxPZYXul1fcvEMzSvwHfQjJG9MxzTmZqTdaSepQ8YL1+H0942XcPtTtprSRqagVlxCh6euMpe7rsOhJl7YRjFZmLKvJY+OZavU7+t4yZCm8fa3sq0oRHbiZkzaZMegqDKWlzNJGWJZi0US4u2G/mxy2mPsW8BAk5gY9CpwlanLhrm1eWSz9ryayHWUiKqy1/BiU5sjqyaFk8TIjB+VpOVC4GwOyU9/2QLaWaBJrXugJeMX13SkCUIcolOelyOI2dJbSFxaGjprJxlBSaDVJALxAn/42B4SoQz/FwLzPXZA1Gpq8uTCzC0ElRHprRnWmUaIQb2G6DXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB8827.namprd12.prod.outlook.com (2603:10b6:510:26b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:51:10 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 17:51:10 +0000
Date: Wed, 2 Oct 2024 14:51:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V2 3/4] iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
Message-ID: <20241002175109.GW1365916@nvidia.com>
References: <1727358828-97791-1-git-send-email-steven.sistare@oracle.com>
 <1727358828-97791-4-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727358828-97791-4-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: MN2PR20CA0056.namprd20.prod.outlook.com
 (2603:10b6:208:235::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9d8408-d6f9-453f-4c40-08dce30acca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IhpX0WLGzJjaFyvAwghqq0O47cJkAo+ueItG7OxmMom6TqBRNaag1wQXnGMp?=
 =?us-ascii?Q?BG2jBpZ2hvUraN/j6ytuWkbq69HIZ/aR8b7AWyK+q6g7MC1h87tfDWqt7h88?=
 =?us-ascii?Q?j4YuBXZe6GxysmKe8Gy0jCsfiiRfuJyFVsyA8cQQdu515HeOEE755DxrHH0a?=
 =?us-ascii?Q?2bLW+Y40/MhcTPjgymoh6qxT1V3BTOc5cZkRT9TiVV62CxbDED/+q00w27lj?=
 =?us-ascii?Q?7m9wQCQkRIr1YYqicVfj9lt67ZQ2DD38HZGpQmsG6gUyBzdAGydzGbuNcMVA?=
 =?us-ascii?Q?WbFRXMox8zoHvv4/GVbC2GXOtLxFY91NhgTWo3NpAZN0AQ4EowbSvaUMMG6i?=
 =?us-ascii?Q?bciht2IMXsJsFlSESZ+1TlNEQ2cYkrBow5R7bD/Nd7XwS8Eeb8wpxhh/gepJ?=
 =?us-ascii?Q?X3V/aUWksIc20C7Fjox5SeCL+Yw0MD+P5/bOCdvpWGkINFEjcxY2qatsFagb?=
 =?us-ascii?Q?tbDZHpeRDVrpDS8BrFI5nRggE0r7GxbgJ9RA6ccNPjaCwL7vPe2t02qjWLPI?=
 =?us-ascii?Q?UF0xKw0wSd0TTf+KIZWyA/ZHXi3WeBAhPFI7WkIEKoVLCgI1NcuyHzLSo5SC?=
 =?us-ascii?Q?ibyNOyo0XNuVrdViCiBalwc2ZrDYbQl7v+bGDSybNmERZ61+6U21jNs/4ncS?=
 =?us-ascii?Q?zcZ0G0B4OQqKiFttrYViA/ppeWWGq1ROsxUeTpBT2XVht0h6AXRxypKyLma/?=
 =?us-ascii?Q?K1u44um9GCLNCbmzjklVWVJvoqPMm1M6nA6GHvH/5fZD/W90PQIJ5TTTw9pY?=
 =?us-ascii?Q?Yl0XW7VMvsX64n6rEoGgZFinq+5njef5klGAHqZSFQAvDC58+zmhlnU7MQIg?=
 =?us-ascii?Q?cY7wbxQVp47LZzZUBy+Dhb33R5XV8Y+Ll7g1uOOlZPTM0dNUHamDys1S64Yr?=
 =?us-ascii?Q?G33EGLHbYsLzyHhlN8vVfdym2/0GyNLiytV1JlzFtd92E+p0JXWC19H2J1ng?=
 =?us-ascii?Q?7GT8352AvLbw9GjebhQsJctPwwnfqZ+Gpz5eIqsMGwR3iccFtxeP2+4RNmEU?=
 =?us-ascii?Q?Uf9/CVeVOTKV9KhusyRSPn9c29zlmvrE5peKvyXjH5sfUWuMviMBesg2mLYn?=
 =?us-ascii?Q?hGNK2D7mV+rcc87xW1A76CIVZjqLKmCW2BKrBJOUVQ9BHU78BO4mL0HFM77n?=
 =?us-ascii?Q?W5G7OEYJHGigJcV1nOcHFAeQz7fPWAkhlL+1ybN0nSqHWQqYG37QYkggMNfM?=
 =?us-ascii?Q?nj8UW5R2yL0Lf+MgZxgXAzlLc+QDuRZkx3aVMVhKOwSqSfRot9FxEpmFunQ+?=
 =?us-ascii?Q?hCEY8Z3cQC7TXMNYLLnF5mRRt8l/1+uZW0zd3j5Vvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jvk7hYohwk3Z3hmcPtiyc7SZdwk4vPbiXLwlyFPoCyxYFzvffAvgMycQ32FQ?=
 =?us-ascii?Q?ac+0PZNkybDY9D7+tHAED7AY3PpwN+/Hk3mOdOUpFMv4bsXqGgpNiL4o3nHu?=
 =?us-ascii?Q?V3eiGm7elhYMxkyG/sBxXteo/0xdJ+6LGoaA9tnvwCOURNt+cOgEaxBO+dgr?=
 =?us-ascii?Q?VGaom0liypo54Yx4JY4A9CllrZAA0T2/ncH5W2dTpcQnfclcrBYAtaYtDbCx?=
 =?us-ascii?Q?CDzBTJ7xZ51B2zJKCfke8Osfpkr4mwWKiSTV6D/MmnVm9zLxWelYEAaEE0jF?=
 =?us-ascii?Q?5CMNMXgsddsFTdS0O7MCV3EUh7s/wkvzXdtkxhjaYgF1SbffZhvI3OebwnPt?=
 =?us-ascii?Q?mScfoj/WcRKCXBqDm59mV7eCHFudeNbhHvQHGUxanikpLq9QQ0DZm+5vJkcO?=
 =?us-ascii?Q?IoTl7+mpD7C3Yl7D08gJ+0ADHoshQJmI/zeo5l0Fs1PsuGp1NE24ncqXy1Gy?=
 =?us-ascii?Q?daQ8hf594PHsFETO5YHgEoCzTLIRsz3xFFs78BU2n+YQLuoQYFEUbtO9wbOV?=
 =?us-ascii?Q?CHBVGUkkw6EenWV/rMwG0qcR8jSX//NR840evq41S/Lvl6pO1CkjuzIl0OxG?=
 =?us-ascii?Q?YHQNIcNgbqGDzUb9bWb+E7VavwTZML6FJKAj3YAkEsuuT/Mo88X7H1GtKQ0R?=
 =?us-ascii?Q?zY3z4M787ixO2s63dqsoMuJ+oZHrAnOLThHlLMOStsNkVRqUhf6al/7l1Sxa?=
 =?us-ascii?Q?bB72eAhlaYeOgjvnrbBmFRbfJnt2Lb7TjjIHQT5Mw675CAeK6/La6va5z/iy?=
 =?us-ascii?Q?1Vey383Z3zaIKafFAYxzj+PvArVDokb84THbLdK5kbPd0wXLOc0J73t9k70B?=
 =?us-ascii?Q?C2DoC5TMH6Jxy13RLWlAcJHWpoUberxuQiXIAnGGiXe248huJw3s3DAcoiXT?=
 =?us-ascii?Q?hxXwhqTssE/ni/L3Pn6vZkBcGyMd+IDRjAIQapLXg4kVGFl3UoGhiATscoZe?=
 =?us-ascii?Q?0IN95E/PZsEuA8SqRC5LzXKicv+OmKGAFNLoZrDsG/JDG1ZfLpmNUBb2++nP?=
 =?us-ascii?Q?3+QFkfTyGvFBz1BspH4dcfpsZEAF/5ck/q6hFbg9ejwbwBJyOyzlAb99VFaG?=
 =?us-ascii?Q?UO7jJKK6iOMxtCNyeTGyhH2Su6JkG3KFXM+dNr0p5dgfuML6w4J5zr+3/vJ9?=
 =?us-ascii?Q?MkWGDnYSEtrJqWVPHSDHgegUq1jafkGtrfVikcxGU3VtbNcWh9/YLYsxm0Fe?=
 =?us-ascii?Q?KU9o4SbSrmu/8szjnhbqRqQlwCU1G59QRO2uIJ6+TfevUtASpPYCkwzIcVUA?=
 =?us-ascii?Q?L1o71FCCayzx3sfWzHXtTzzcnVqMBe36Aq+MhFTspF/W2xP5oX3Ai9ctWUfK?=
 =?us-ascii?Q?e0w+f4lfqqCS/yx4xoid7rLgU1ofavAD6g00i5QxNVIwmjsb9MAaPlIQyyK2?=
 =?us-ascii?Q?DMMvv3oUjosAIiJnOsRGgTETx7RVw8d7RejrIF1PC34D0HJfwSJwgyWDlorJ?=
 =?us-ascii?Q?JKDYwXLa9bExKaANWeGJFFGPYjhFHALJPgWeAUgzuHEe8DbxqD3eduBX+CQz?=
 =?us-ascii?Q?W0xJQ1IWmMg+p7GDzAX1hiNqWD2koICXB1JarjOXImyut1aL52emEkoEXH9p?=
 =?us-ascii?Q?cjfZ6Op4L9I3TqaWcwI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9d8408-d6f9-453f-4c40-08dce30acca8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:51:10.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9wl5vYiQPMWYulnWz6tuW9Sb+FOSJk5k/yyb8oteaWutVFWjnsE3P8l0BSb67Eh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8827

On Thu, Sep 26, 2024 at 06:53:47AM -0700, Steve Sistare wrote:

> +static int charge_current(unsigned long *npinned)
> +{
> +	struct iopt_pages tmp = {
> +		.source_mm = current->mm,
> +		.source_task = current->group_leader,
> +		.source_user = current_user(),
> +	};
> +	unsigned int account_mode;
> +	int rc;

This seems like it needs a bit more protection, we shouldn't be
touching pages that are not set to current otherwise it will corrupt
the counts during the uncharge?

Maybe the whole operation should fail if any areas are not owned by
this process?

> +	for (account_mode = 0; account_mode != IOPT_PAGES_ACCOUNT_MODE_NUM;
> +	     account_mode++) {
> +		if (!npinned[account_mode])
> +			continue;
> +
> +		tmp.account_mode = account_mode;
> +		rc = iopt_update_pinned(&tmp, npinned[account_mode], true,
> +					NULL);
> +		if (rc)
> +			goto err_undo;
> +	}
> +	return 0;
> +
> +err_undo:
> +	while (account_mode != 0) {
> +		account_mode--;

Do we need to check:

		if (!npinned[account_mode])
			continue;

To match the charging side?

> +int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_ioas_change_process *cmd = ucmd->cmd;
> +	struct iommufd_ctx *ictx = ucmd->ictx;
> +	unsigned long all_npinned[IOPT_PAGES_ACCOUNT_MODE_NUM] = {0, 0, 0};

Just use  "= {}"

> +	struct iommufd_ioas *ioas;
> +	struct iopt_area *area;
> +	struct iopt_pages *pages;
> +	struct xarray ioas_list;
> +	unsigned long index;
> +	int rc;
> +
> +	if (cmd->__reserved)
> +		return -EOPNOTSUPP;
> +
> +	xa_init(&ioas_list);
> +	rc = iommufd_take_all_iova_rwsem(ictx, &ioas_list);
> +	if (rc)
> +		goto out_no_release;
> +
> +	for_each_ioas_area(&ioas_list, index, ioas, area)  {
> +		if (area->pages->type != IOPT_ADDRESS_FILE) {
> +			rc = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
> +	/*
> +	 * Count last_pinned pages, then clear it to avoid double counting
> +	 * if the same iopt_pages is visited multiple times in this loop.
> +	 * Since we are under all the locks, npinned == last_npinned, so we
> +	 * can easily restore last_npinned before we return.
> +	 */
> +	for_each_ioas_area(&ioas_list, index, ioas, area)  {
> +		pages = area->pages;
> +
> +		if (need_charge_update(pages)) {
> +			all_npinned[pages->account_mode] += pages->last_npinned;
> +			pages->last_npinned = 0;
> +		}
> +	}
> +
> +	rc = charge_current(all_npinned);
> +
> +	if (rc) {
> +		/* Charge failed.  Fix last_npinned and bail. */
> +		for_each_ioas_area(&ioas_list, index, ioas, area)
> +			area->pages->last_npinned = area->pages->npinned;
> +		goto out;
> +	}
> +
> +	for_each_ioas_area(&ioas_list, index, ioas, area) {
> +		pages = area->pages;
> +
> +		/* Uncharge the old one (which also restores last_npinned) */
> +		if (need_charge_update(pages))
> +			iopt_update_pinned(pages, pages->npinned, false, NULL);
> +
> +		change_mm(pages);
> +	}
> +
> +out:
> +	iommufd_release_all_iova_rwsem(ictx, &ioas_list);
> +
> +out_no_release:
> +	return rc;

Don't need this label

Jason
