Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C795316907
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061557; cv=fail; b=ukV4Yn4w22LAsu/UsdWxKoQtqi5zLN85OH+JbjLijCRUOWvlCuVphEWXjGA/pTSkNN4ck1VAPPAK18jSI3td0W0SyTtLdU9CXUvg40j4ITiRrNIU1sRHbyTFd0sbH43Ka2D+He64yc1BqlARaln2VKgU2RV0Ysnhqk5KOyVc0n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061557; c=relaxed/simple;
	bh=da6vTOUf/jgsYaXvtJf3Ms8cltWddmVPH7O272cr1UU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LevYw/tRF1nmd90qzFfWvb8eu3ZoplIMZVcbr8IixhxEzOac28+LwmgpC1aPrX/dP0cQr0DOwX/8HhVQPSovtJuMKfKaDO7pKaXnK2+n3r/5qZCh/Qqwpxl8gYCH/4Umhy1+St008T5F2u5Jxq2Jso0UIHtHNN8IYsX2YhgP3ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qn8V6LQm; arc=fail smtp.client-ip=40.107.209.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qn8V6LQm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwf9mzwWrrbXjeKrEW7vs/EcVxfE+rP9s7sxBtA/XICZH5UlUZZm7bOzyGUpDHu1NBM8Hcq9A+CdjwE0uwUJL0Q9zxYYo4dJ4y0O71jMFmpZwGlZ8GzSucatGQzTSv7H3F4EYBXTKDtOjv95LOKLdNmXGcXxuUXmyeKx5lOwgNcms5j5Vlu9Wpio0jKOHy/ustzo/i1fAIIDpu7q86DSk6ZJBQlpBGn0H+tXeNhxuidadcx12pyWH/HblxCVbXw5THqU0/z2e1PJkYKiKKpiEQoXxVSg3QSSkI8XkCKd8KnF+a39QsQGLnhcQz3G6gSoiEWmixFmcMiww4dfs9dv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg0izK0P2fLPkwhrJ7pxfBBy69+5j2OiTkTaQc0Od5k=;
 b=ruj6BzYHjO7zti7IeFIQUrClXVBPiO9dTEJpzFpTupeBqGTcYlP3mr6CYsnkfNcHgq9aQ/6ymZS9RqPOcn3lLTZ/tZsIBZC4YZYs82JcKN7JsssL1K08yNFlEXGTkV7kUtGwq+n2rwNA7U7Y19Z4Nc8JNLDpclboR12eWtw4sGdZAJpDiMl5Au2jUbZ+anJ3R7zXjD2vaOZZZTvZj+2mup/MkxWTj+mLj0aYJoVdjLyoDs871iCPpgXbIF2C0FEReGNjZrN4LZp/U7Hfohq3THnhAjSncC/uypoZHKxUi25eTi6720tL3rqQeVUQ2v53I4mBBVxRPZXsilHGFpa50g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg0izK0P2fLPkwhrJ7pxfBBy69+5j2OiTkTaQc0Od5k=;
 b=qn8V6LQmRTIHDMJzR3oItUNDvBW4JO7R7+7EH9JT9pyFf+VOGUruIxqe8tQdLeR0KC+i0qXq3jO1SwUgs6Er960p9+PkjZLup1u/pSszLVG6EuBXyHLvLL1r1XFE9W1xDvBoql4n3joieSC/2yWG3sC6BmSpCbrH2Fbl00dAl8iAl13AV/IhpeQF+meARwpn8gEdEHocmjh0rDC0v2go6TI90TkoxxlsnFapGM5+0SZ2+VmBN0D4Fk6FxDOtT5bwft5CXzp2iwMBGZbf4s46AD273kJJT6i1TyMTOcShq3tQ1794YenEdqv4vYnIyphEMlWccAaqC7nNnp+kzUsQhg==
Received: from DS7PR03CA0107.namprd03.prod.outlook.com (2603:10b6:5:3b7::22)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 19:19:11 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::a7) by DS7PR03CA0107.outlook.office365.com
 (2603:10b6:5:3b7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 19:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 19:19:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 11:18:49 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 11:18:48 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 11:18:47 -0800
Date: Thu, 13 Nov 2025 11:18:46 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v5 05/14] iommu/amd: Introduce helper function
 amd_iommu_update_dte()
Message-ID: <aRYvFmHdUImiU0zA@Asurada-Nvidia>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-6-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112182506.7165-6-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4a0be4-006c-423d-9cb6-08de22e9866c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hnaUpdOIMmiEqlU/JSAwzbSdnO/pAujrw1R3kgzgU3Ar9JWCSL8MZJErDfww?=
 =?us-ascii?Q?GRqGAZgJQoPiFAOrDoENFaI1OFRF5dh7O1lF5myA5HVGTV+FypUZ5/XltAOE?=
 =?us-ascii?Q?91g/l1/fYd011t3s7LvG99jF8UWXW+rSusqzU9LccP/DPYaHpHlzGzYNx2FG?=
 =?us-ascii?Q?Qw9CWzuDELXRpVlgtw0nWfU1zHiAf4aZSMeoG3zPLHkFOzmsw0rsUayLSBll?=
 =?us-ascii?Q?jnz3hSK9ufTw57hkww4PdiDR1Su60SF/wzVDSSOUGLgF8EAmuI6rd3mHt2cV?=
 =?us-ascii?Q?CxVvUDh4W87HgCuPSkDJL3Wvdzx6s/d6rNaXWDhKZ3a6+ERQHYpVaZiYV2C2?=
 =?us-ascii?Q?zPDbrNL4u7DSRc587hPZNMlD5eJRxExuVNFz+3UtP+t+SNs2zY2UdfSrL5fx?=
 =?us-ascii?Q?XfPPeo76l8fhPVsztiwVoNni9GimwP7ji3BRmgfe/oigezx+gBMNbSSepar6?=
 =?us-ascii?Q?OOY+0e/Z1XmgcDIP868/5dLLA3DoAjwH1FGfhDdDczLaVugvLEkK1zykNWJQ?=
 =?us-ascii?Q?htwa7JM81NUPxHbpv622wkVe8rlcKlgWrRGZtZjGPZOZyYdPW8HowURcN+cP?=
 =?us-ascii?Q?aXtJmyN9psiYwEWRJftGn1S2h5dbtA+1OW3XtA1Aoi2oNyN0eZODwpJh7Uwy?=
 =?us-ascii?Q?vhfWGg+nw2RGkRwHNbqRC7J1Uswpamt4qZcjc8Bcd5mOh8TuqiPH43wkkig0?=
 =?us-ascii?Q?nUum1WfKa02DZCkrGTEdL5aHElHXw4InWNLbeVy6/oh3hbNYIoLIBZEAYzAF?=
 =?us-ascii?Q?DIvLy1yL9FVGRNEjgJJmLj9FyL3hyW6IfDhSNTAme7FRf+JtUNFM2S7aIio1?=
 =?us-ascii?Q?pkQm6PCwDw+tFptiGoOtQ7WhGmT1b6CrPU0bnvHWTsjrD+9wyynkLGX2P0Zg?=
 =?us-ascii?Q?PvjNOkO0xEdOE5EUIM/lutKdIfZrFAg5+Ma7p37wWSZNJsthIGB6xoHYp+OZ?=
 =?us-ascii?Q?4dqeKA5/pte3UnSGZqMFmNAKLLupwnbxFv0DFo3/JN4E6P9iz4K5dosLMNe8?=
 =?us-ascii?Q?9VXmiLMz5KqDkyNpou87NO2oiHifv2mlrm/z6eXA8ZYnTCHPcY5TjOtxRLGd?=
 =?us-ascii?Q?WnvSqO5ZpH2XqOjiEyxLnKniBVaE67FYHjM15CAJXfgsqRusCOlmPV7+M882?=
 =?us-ascii?Q?VkRzNjqI0Piedr3crsmDUeowfy3qSdMsyIGQiJEdLPvUQsY5TWACrNWcaUi0?=
 =?us-ascii?Q?SBTmiMg1Py//HLVQkNttqQ+vhxYGPjJ6pmwLNHt01GTL6j0WWd3IfevAro9D?=
 =?us-ascii?Q?1Wv09K4EzvWF3S+yUa3foborHbHJuiDcDPxhiHjFkwKb9qTXiOAPr/WEHive?=
 =?us-ascii?Q?bZPfiayCA5ApSR3ZtNGb2u4rXovYv9SxjPrNajoLTs5A/W4bbBBFIs25t13D?=
 =?us-ascii?Q?7hNOhbFlwuq681vRINfGfxxLF0i8xR0fIf9ZmSwCXorJO/+ZMTXxW8FClXRs?=
 =?us-ascii?Q?Ecq9A7pcj80CWeiYNNnHj2WbYzRQeUD+5R4AIfzg1IcIEjib3Khq4Pl/wtHF?=
 =?us-ascii?Q?67b9Wz7MJsY1iIVMmWP/c+rDkDYZvIo3AU0WMARDT7hDXu1GYvwZKL0RLnJG?=
 =?us-ascii?Q?zFWz5yXksfsdQ3aEV0E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 19:19:11.0039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4a0be4-006c-423d-9cb6-08de22e9866c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125

On Wed, Nov 12, 2025 at 06:24:57PM +0000, Suravee Suthikulpanit wrote:
> +void amd_iommu_update_dte(struct amd_iommu *iommu,
> +			     struct iommu_dev_data *dev_data,
> +			     struct dev_table_entry *new)
> +{
> +	update_dte256(iommu, dev_data, new);
> +	clone_aliases(iommu, dev_data->dev);
> +	device_flush_dte(dev_data);
> +	iommu_completion_wait(iommu);
> +}
> +
>  static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
>  		      struct dev_table_entry *dte)
>  {
> @@ -2088,7 +2104,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
>  
>  	set_dte_gcr3_table(iommu, dev_data, &new);
>  
> -	update_dte256(iommu, dev_data, &new);
> +	amd_iommu_update_dte(iommu, dev_data, &new);
>  
>  	/*
>  	 * A kdump kernel might be replacing a domain ID that was copied from
> @@ -2108,7 +2124,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_
>  	struct dev_table_entry new = {};
>  
>  	amd_iommu_make_clear_dte(dev_data, &new);
> -	update_dte256(iommu, dev_data, &new);
> +	amd_iommu_update_dte(iommu, dev_data, &new);
>  }
>  
>  /* Update and flush DTE for the given device */
> @@ -2120,10 +2136,6 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
>  		set_dte_entry(iommu, dev_data, 0, 0);
>  	else
>  		clear_dte_entry(iommu, dev_data);

I found these two are somewhat unnecessary.

set_dte_entry()
{
	u32 old_domid;

	make_clear_dte(dev_data, dte, &new);
	....
	amd_iommu_update_dte(iommu, dev_data, &new);
	if (old_domid)
		amd_iommu_flush_tlb_domid(iommu, old_domid);
}

clear_dte_entry()
{
	make_clear_dte(dev_data, dte, &new);
	amd_iommu_update_dte(iommu, dev_data, &new);
}

And given that dev_update_dte() now are just calling these them
without any other thing to do. Why not just unwrap them:

dev_update_dte(struct iommu_dev_data *dev_data, bool set)
{
	u32 old_domid = 0;

	make_clear_dte(dev_data, dte, &new);
	if (!set)
		goto update_dte;
	....
update_dte:
	amd_iommu_update_dte(iommu, dev_data, &new);
	if (old_domid)
		amd_iommu_flush_tlb_domid(iommu, old_domid);
}

?

Nicolin
