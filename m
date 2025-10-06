Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273C21FF48
	for <iommu@lists.linux.dev>; Mon,  6 Oct 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762754; cv=fail; b=oy/zSdozJV1t+tGdQBNdm0vlsPPCfxNKZ93CT6jbjxmLZOOcMyeFk1q/g3cHZHS5iitQTv+kB7KY4M4R674HLNIXXeqVq1MUFUnsETfqs7r8HQnKl5Tz32k4b1tbbKeukoetzHbxowz4WdGYubDXNeCxU4d1LrcwL7Z7hDSyyoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762754; c=relaxed/simple;
	bh=2hs47aMyXyjSETaY10Yu7ei6tYIBUAGztl7ZcC3lidw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jdpJA0kclmN6HWchSRIrZrbcnrlC0W3HhoN1oCvgL4nsrcQNqsnOQgtF3V4EyfprT1zn802PRZqLjwPlgwdDhTzjwuXLKl3czg02B1QG3yEXdnHJ3RUVfkdWrrK1OzkTKVad7OT7Yw2J+97i7qujGaSv/CnthX55c4+PAmAFulQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kdJfuP7Y; arc=fail smtp.client-ip=52.101.62.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kdJfuP7Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naaz0q9F3Ytf2d4C4/CWcD7fZw15tWa46WiaVHNihACe8BpKBOyuYX7CGPy7zSu9Y3iz4uJcvs13ZV6W7LYYBwSeujZ/6vpZ3vx4Z+CPju8MYkuOWlzhBRnOkVZAZ0M4Tp1MNo0Zg8s5cwSSBT4fYt5+tMz2RpYpIVWKIQT61z8fMsXtSmemrlqKpnj97uj0v5NPgApkIc0LDg2sb7HFS7aFopDhNdn6vQg77+yvdOFW1qxx3JfUq1eyCAtGZZ+RVBPM/935tj8lMoOYzoOE9+viG4Bn8z3MgD6PksbVfwH1/XFtIUJRW+Q354iTDPSVK+e8vPznFpAIg+G2AJbz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtC5VrOkR+mU/DjcuR9N3r5uYJ5rPolCsAD0LggFq6g=;
 b=C1J7dpLm/qjHh4SWN79TUu8ScDCV2PNzZMKyCGAjO6R+92BJPhkeKUn3WPbmfM+ldJxWhqBXFENj0+3gS0Pn7TT4UfIMN3RdNXjs1hHDp0Z1Xoqu9R/dv0G+watOLhgkQr8ayid0jgcTKx1KT6RUy/IYMqtwDZevo/0BLkCRXpHw1CnzMnKDorpzkupceijFTQyW4ZR2t/D4M2zqOzI4tpjEAXaUA3NfLhgupf5HB48B61GhfVPphahhJmQxzra0xvg34CUhO6DiDRmtly4PRe1Fd/hMRh7M8Ewi9HskzcrvwEHnCxg7wioMI7a1d3WjvQTUIUDXPYwkKqZpNX/KZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtC5VrOkR+mU/DjcuR9N3r5uYJ5rPolCsAD0LggFq6g=;
 b=kdJfuP7Yd5SOEMMc0+HKfTJrbCiLClyhavI40wIjUKGbpc1mLlxRHomBXWgtciD85dTvba7GhMbzRDDC1xeP/L3XHRWJqBBwiGGEbGNCF6v6/rGIG2P8lUbWRbys0t7YZj+hsCjVIfryLGIheFeGFKSsISiec/lMUPueHl269HS1KWYtKWmqgjPKnll1n6RBSt0KpbhVVC+c8/NVqj9oXdd6aEL74UrGiokluM2kKBbaXRclsXXb78+Mu1l6KmuzMrv4PdhzX5Rm0tNdOGPgQlWTmPTS/HrDwyGhfLMQU8ArFRFHZG8K0X27hyMKuYJSZdNV/8zDPdKJZybs8coflA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 14:59:04 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 14:59:04 +0000
Date: Mon, 6 Oct 2025 11:59:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v2 11/12] iommu/amd: Add support for nested domain
 attach/detach
Message-ID: <20251006145900.GT3360665@nvidia.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-12-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-12-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4P288CA0012.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::16) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: cf466f7e-b162-4aa6-c167-08de04e8e33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ECmAhXEfdUav0jYvaEalPz3rLUeOEhVGJqpjsFjzroRcyd8M5FmA36i7gDps?=
 =?us-ascii?Q?MDvw55Ffg7ldC42er353jpIchKmiTBVRlQDjv5P/0AcQlvBVbH/Rv5Ucvn9m?=
 =?us-ascii?Q?N248R8l9KCBpYplL51Pb5OA95O+tx/UD5AKfZoImr/AtG7Vjn+Qin2cdPPu8?=
 =?us-ascii?Q?bysXz/oJL6iJIa3iLkD+8g2qEc9fN8/+z2MJVQ9rSNXw0dhMV2rV4IZpsVuz?=
 =?us-ascii?Q?2l6SxkoDmjg/phMZTLkJ10RVkrvJYoTfI9yCM3u67M8aj4Pb3bO0qrhpNP99?=
 =?us-ascii?Q?/PkRtir80JEL3pfHJxCZoohKSMLFmZLp2wfWyOPAytfCY0BQHnBM1y5CdPuU?=
 =?us-ascii?Q?20b2gky6iMNA4K9oxhKh2sdZ6twsXcRfU0x4FoSJSqA061XQdD2qP76XFWHQ?=
 =?us-ascii?Q?8wWhOTVjWecdgeNXrMstzBEB1y3Ruhd4H5WTTD7liumqLOIWREN0RUd/1Qng?=
 =?us-ascii?Q?x11ofwH015Gv0WNvrLhQ3Zm4VklSAoxU3t8jhSVhn6klKXDR76aKmulUOoXP?=
 =?us-ascii?Q?L7CfvLgTUYTlZt6GtcAMtUu3wCiLf4DEvyzpa2/rdrajH92T6sjyYtEdV2Gn?=
 =?us-ascii?Q?SI8m9G1QTFqcwnH13LFSqmd3rxxfUFUEUbTKDsODfK27YLFSZpwCuViNsOHP?=
 =?us-ascii?Q?y3EJ0bugLmZWci+uu9baM3pV17Vah0P2+EfPhaaPY7++HNzTPFIajEuGW2P9?=
 =?us-ascii?Q?QoCZ5LciI59QPAMEfumBjr0+a1Yme0+GHMgUHCH5f2q0ZfhXvWFeAXgMphsU?=
 =?us-ascii?Q?VUcT395mmX4nMztE8ABYkamkVP12e5575sdynsJxPPBehQrhUjAtZlwM/+aN?=
 =?us-ascii?Q?1qnjaSf0icDDDGJeJ6YISttqUu8qXtYemnZG7FW/NjEoAnQtBrp7cCbfgjYC?=
 =?us-ascii?Q?CEQ73ek28XENOEYM9LJURgrQ+yUHCxbcQUPY1Lh/toXxv2QClEtdHIWMMBwv?=
 =?us-ascii?Q?QmqTYgzIOWBUu+te9ModB1iz77Xh0JxedDvPg9WFWJaGJyt9iOLiwyPWThSH?=
 =?us-ascii?Q?o740dz78fZTlKr0EnN3kZIoosQ0r/8ANL/wkW7pAd93n8hNQNXVibbQc+HTg?=
 =?us-ascii?Q?XmY0ub5bCLWiK+NxNKNviJ/K+okYJ1gQAxpnKt4MajKFv+Y1BMfVHChauSaq?=
 =?us-ascii?Q?93nG+nd7Wb0QZjLKQk8ynYJW5nOmkH6AwlJOKs3bJTvI3VMgFJxVI4ehy9BA?=
 =?us-ascii?Q?S+MFw4SCCBgKQs35juPpcpB8zL8BNhmoq9DDk/dJgAoxNeqFeYxdgkG/2kuK?=
 =?us-ascii?Q?CNiUQFYiIOIzXzTG+QuV2Zbe0iSJP3CK9W4PYRSwNkhVeQO698r+cKMyVCTh?=
 =?us-ascii?Q?/oFiErrwxRHI/fK17P+UmYxI8cSuI4Fqe++3fX7tIlsf1+nK+dU7VU1dbB/X?=
 =?us-ascii?Q?DaaQHYwa+wlnaFcVMA1ZRlWgJxcRm33DefGtauPnEFqysm0N5WBfhVKfPYy1?=
 =?us-ascii?Q?8Zubsg11/bLPS9euKK9zpy8D4uaTLRHe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rW+8xO8dI0QSKVr8dLve6GpL0PZPUVmt8ka9ZOPAjvMNrGiSRKDWFKfCkDA7?=
 =?us-ascii?Q?6V8YzrFTOTUS9AFejJhgikKlB2J6BVpZlit4qHiCYhWVizjmw6MD3GVnvo20?=
 =?us-ascii?Q?GyYvoBrleHRxiIOW+jyOTn/504kMhiAVoW+zAtzknNUwO4UfrGrCtjuSHHKc?=
 =?us-ascii?Q?ApklBBlxe4kzElrHwMV/M7o+x6gDdlWt6gLc8p3dT+MCY5yl6flEM8Xko6WC?=
 =?us-ascii?Q?qOEsfVAHqOKn/w4obkQy85C90MP0XOj++BoRx5kVmEgcIOB+YyMNj/kEFJpr?=
 =?us-ascii?Q?dXLnBhkzITWgzs9WluTFXgZoNw7LN7+hgTjQ1AEZ6u/cu/xLW49J3hcdw/ki?=
 =?us-ascii?Q?g/HwbcawDpEjiiF2owpGyQa5hblD3FkjYNAiCi3VWyjkxTdG8sEOWUrglB81?=
 =?us-ascii?Q?Eug8+gvmQkgEUXnbp6PauVKoNJ1ZSpa4fVA8fLB9+0dUdbUrbNQlUYiEqYi/?=
 =?us-ascii?Q?WdMmGoR5/7BfJdWwYGwiP9+oIp1CcnLGqWTK77kStAIWBJVs3hVstRy7c+0A?=
 =?us-ascii?Q?HmdmSvBtG46uIO5iqwdkASH2VzhajT4KzaWCD94D4KDjpR24Kz/Y5fh58F3W?=
 =?us-ascii?Q?hptn+ju0NuWevmTdY0JeRXC7Y9ulacJhq4ZAQWuFpR1w0xgUhhn0wul1Ip+j?=
 =?us-ascii?Q?1+Y4vi2FkG8Az8xFSgzGqjFm3tbi3W8i1Npf74wu72IwZo5V2jFQmw2L3v8s?=
 =?us-ascii?Q?Y2rOVSmXOnsNZrQYyHmwNJdah9yz3GvR555SFcYYcYtPRhFDoVKF3ZvWhgTj?=
 =?us-ascii?Q?G7Yd7etdU+wPXL4liMRyq4ba8dj7XbU1/DpvvAiIQv9C+nZGQlXm4HxuITRe?=
 =?us-ascii?Q?oww/hI/C7Tuf24EzIhss2UCT7oebwijB1SaThp4w89W7HkhTZfT7d2u9G9ku?=
 =?us-ascii?Q?w+OZxTefnJH4ubAv/vEOkJpFV/s9D0/tJE8/1ii0EBp2i16UidiwJF3/JYkj?=
 =?us-ascii?Q?Fw0FBYHrpev9jfbPF5GPCLlXaRwzZVJrupQvjp3sJd1bo8PBp12y9C9SWSwM?=
 =?us-ascii?Q?xCB4dESDChIDp0Cd3YYfWBr4kzzOctS01Bo4+qeEQFM0KLpriPzxpPGwtVnm?=
 =?us-ascii?Q?Fn2jkMatRAxjoVVxcMqN7WD7Ngt7gT+r9RG7SnN1WvyRJ7hgfiEkZx1e8jxH?=
 =?us-ascii?Q?ouYJzAtjHjjjBt/RwHiyEKKuEfi9l78LKcJHlVlNwXbmZ5r7FvArWzmZuRVO?=
 =?us-ascii?Q?JtN/rEyvySBaOMQZnXnilYeiqwwtE55OoDr/H1JgK+M83f5y3uCYCKq2lwAp?=
 =?us-ascii?Q?YRa2Tgxd9NK3ork+LLI1/4wJMD5MWKP+FLa23SKYRBVRBSLK3gmZcvFxp3vw?=
 =?us-ascii?Q?crBcpMt/C8+RJ7JJG2etXEtVpAJW/KMnjse1jNahiWZ5tAa/IImRA6vq0khJ?=
 =?us-ascii?Q?s3kwRrMfP5Qc5uWgs6YExQrRkR/51vmfl3p43P1HJVYF9z0yZycT/RY8BHHN?=
 =?us-ascii?Q?sizhh/fY9k+W3dXLW+Pd9Rz2Xm8lgybQdBsytVxwUfLJkCqQ57Y/kqoIBuuf?=
 =?us-ascii?Q?aFZpjgJ7lHmmAEw2cnK5xybslR3KgrgdTi3GgDAd6CCPj1xp4D7Ytm19my4o?=
 =?us-ascii?Q?cxASnVawygvEw6uWTqo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf466f7e-b162-4aa6-c167-08de04e8e33e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:59:02.9072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFg8eLlRlWA4dkry/q/gP7y9sA/EvK9fnHD1whQJ4w2oqouDHJAZCPTJPxegHjoO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111

On Wed, Oct 01, 2025 at 06:09:53AM +0000, Suravee Suthikulpanit wrote:
> +static void set_dte_nested(struct amd_iommu *iommu,
> +			   struct dev_table_entry *gdte,
> +			   struct nested_domain *ndom,
> +			   struct iommu_dev_data *dev_data)
> +{
> +	struct dev_table_entry *initial_dte;
> +	struct dev_table_entry new = {0};
> +	struct protection_domain *pdom = dev_data->parent;

No, this is ndom->parent.

The parent is NOT required to be attached to the device already.

> +	if (WARN_ON(!ndom || !pdom || (pdom->iop.mode == PAGE_MODE_NONE)))
> +		return;
> +
> +	amd_iommu_make_clear_dte(dev_data, &new);
> +
> +	new.data[0] |= iommu_virt_to_phys(pdom->iop.root);
> +	new.data[0] |= FIELD_PREP(DTE_MODE_MASK, pdom->iop.mode);
> +	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV;
> +	new.data[0] |= (DTE_FLAG_PPR & gdte->data[0]);

> +	if (pdom->dirty_tracking)
> +		new.data[0] |= DTE_FLAG_HAD;
> +
> +	if (dev_data->ats_enabled)
> +		new.data[1] |= DTE_FLAG_IOTLB;

This sequence should be in some set_dte_gcr3() ??

> +	/*
> +	 * Restore cached persistent DTE bits, which can be set by information
> +	 * in IVRS table. See set_dev_entry_from_acpi().
> +	 */
> +	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
> +	if (initial_dte) {
> +		new.data128[0] |= initial_dte->data128[0];
> +		new.data128[1] |= initial_dte->data128[1];
> +	}

This should go into amd_iommu_make_clear_dte() I think, and refactor
it out of iommu_update_dte256() ?

Every created DTE needs these bits set, right?

> +
> +	/* Guest translation stuff */
> +	new.data[0] |= (gdte->data[0] &
> +		       (DTE_GLX | DTE_FLAG_GV | DTE_FLAG_GIOV));
> +
> +	/* GCR3 table */
> +	new.data[0] |= (gdte->data[0] & DTE_GCR3_14_12);
> +	new.data[1] |= (gdte->data[1] & (DTE_GCR3_30_15 | DTE_GCR3_51_31));
> +
> +	/* Guest paging mode */
> +	new.data[2] |= (gdte->data[2] & DTE_GPT_LEVEL_MASK);

I didn't see anything validating gdte has only permitted set bits in
the prior patch?

If this is goint to decode array item by item then why not use struct
iommu_hwpt_amd_guest in the nested_domain ?

> +static int nested_attach_device(struct iommu_domain *dom, struct device *dev)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
> +	struct nested_domain *ndom = to_ndomain(dom);
> +	struct dev_table_entry *gdte = &ndom->guest_dte;
> +	int ret = 0;
> +
> +	if (dev_data->ndom == ndom)
> +		return ret;
> +
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;

Why?

> +	/* Currently only support GCR3TRPMode with nested translation */
> +	if (!check_feature2(FEATURE_GCR3TRPMODE))
> +		return -EOPNOTSUPP;

This is impossible since we can't allocate a nest parent. If you want
to make a redundent check then call is_nest_parent_supported()

> +	/* We need to check host capability before setting the mode */
> +	if ((FIELD_GET(DTE_GPT_LEVEL_MASK, gdte->data[2]) == GUEST_PGTABLE_5_LEVEL) &&
> +	    (amd_iommu_gpt_level < PAGE_MODE_5_LEVEL))
> +		return -EOPNOTSUPP;

I wonder if this should be done during alloc

> +	WARN_ON(dev_data->ndom);
> +
> +	dev_data->ndom = ndom;

Useless?

> +	mutex_lock(&dev_data->mutex);
> +
> +	/* Update device table entry */
> +	set_dte_nested(iommu, gdte, ndom, dev_data);
> +	amd_iommu_device_flush_dte(dev_data);
> +	amd_iommu_completion_wait(iommu);

Hurray

Jason
