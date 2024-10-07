Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748111D4159
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309910; cv=fail; b=Tx8Nd9ABNGdbcKwy5lqWvYG6/0v3wTxMMwyjxuVFnIFQRY/tI7E9LOAA3xTXJtT5jtBQsbrTDDOpDPNilAgoqmEaKRz2NOFmwq5yYTgM7BpOms2SYMQq9ik0MoLwwhhNwyJAaEd6+hq4WzyOLGf/E2jIarwEnSBSI9TWSs4RxMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309910; c=relaxed/simple;
	bh=y+HrJbC0AgTRgni0yyaOEU3ImFiJGvaC1jxNoRvp1cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WlkoG99Y3dPDmcbkReSBX773dhPkRf5oyzm6a+9epUpvyC2uqsLqhqsyRiqNlkUxLuIEJWv6ntvGzuAbf1qn7ZW5WN/Lx1FN7stS898qa5ZWity0bONcWFo05MBFLZRhBX+xg7aIxGQ+I8sGYd9Knn7ojY5R6oaHe/LMKCT9b9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lkFGnBa5; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lkFGnBa5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJW8BRT68akhSKmMOnVSnI3dvyI2a3rGebamOvxwRCMTwOjnm63oTNI7sg15twHXxk3ryDv6pN1YVz+guYK4bBfuwdiY7eNXx8r2U08pZttgP2YL4U9YpFIE0cR8PD+j0N3DNshkpOnGwWdesbydXtje45rTVhhl/7xK04v0T+DepPDLxBkx/YeseMCusK67WelrMOhEXXyrbuxjti8ZEhz4qklAZo4do577hxXh2vwXehUidKd3cFF0iF7giFGL3u0sEMBZAc98ZxjZhpZQsFCN0/brr08P67/FitFR904OoJsq+a1XYB8Wwu9CoyG8xMDcuqUG+VIkmAmIih9ysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5n55efBk5Om5GCg6arcQ2mgq4Wig4gVnS5JuRYf/iQ=;
 b=Ohuzg/JqD+5p3fqMpxJ5hroDcaKUImuMDPD/2F8EZJkf5dQEmcl38DLo947s+WKsCGx2bOmV/7F0lUSMGaRY5xGzqAydueVkWDFqmydRYSbjneSsUplOEaoEBpg50xNLuMrYeypZUtU3vfD7eQRWhwEit4FgGYiKk+47ezqfHnbjOSvuduxDXHg7wkiWBjCFc+MibFifjw9OkFb/zJwlCqnt5D5mRX9x+jeSlfTtsovT9TAXYJwFle1ZQ6Wj1kCj77BcEzG7znJhySo6MU48fZn22Z9ekj9KPfkGN6Mg2gJR3v7zpp7t3G/qKQRlXIjiFBDnVk9N5Mp6mRlhJvtfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5n55efBk5Om5GCg6arcQ2mgq4Wig4gVnS5JuRYf/iQ=;
 b=lkFGnBa5Qt6e6lulspMJG/nMZjRguw+gYHUCstkKOpG1TSVmyt9qke2kgkZKCeaT5nh+54+9eWEigfZthcAxxEYqOENIRiDr5BfKhyQKQlGuG8oir57FJRNFEVSnlUHcrOei369D85U0yfg6w0IUJcD2I0rpbtZZJjEf2kXnPJeIBJbop+WJqoHFyz4+pZX4vVhKehMWnpi3JGpDhT2kscAkSJGZDJGIKG17TU9jX3Mf0wICRdtEYLNSekG5jSXEScSvt1NgccEszKFkeonG78iP9qr0ckYozr0+5PT6C/XlvuxeL7Gf1EXIqE6/hbd8RdiX4TvYs+if+SOaAT5k8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 14:05:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 14:05:04 +0000
Date: Mon, 7 Oct 2024 11:05:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v5 3/6] iommu/amd: Modify set_dte_entry() to use 256-bit
 DTE helpers
Message-ID: <20241007140502.GO1365916@nvidia.com>
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
 <20241007041353.4756-4-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007041353.4756-4-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN9PR03CA0889.namprd03.prod.outlook.com
 (2603:10b6:408:13c::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 9103e600-a394-48c3-429e-08dce6d90a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lm1FAn1ECX3imVOass0lcE3X6BX9iFGDp9F/K8bGhZnaHbyQN+3RJ26iKl59?=
 =?us-ascii?Q?A8lv3da6prjgwACI+Hq1fFTV8xjXcv5T9SwQ4vQgoEAJn5IKXF6uFH/zE9ef?=
 =?us-ascii?Q?aqwKdaSJEd1oYrMmNJvu+OWca6CGAfamt/T3B5DxeZUfMMy4IpcZ91Xwt3X/?=
 =?us-ascii?Q?eDRyMwVNeZwIXL43JNj6BuU9L+EKNzMsFQ2XZleST0Dx+2ukYfjc1SUo5lqU?=
 =?us-ascii?Q?twDlhuE82peM3YKmbcQVB4IxouyVMgwRRSXkZuYpGwp1LZRsvNTn5pO+eMis?=
 =?us-ascii?Q?bcNAByqnGFgzg/3U/iRARJhzNhyOywZrk0RI5u1X0/IDqIJAg1BDnhSL4Kdw?=
 =?us-ascii?Q?sUBCpu3+amD8L48cHjDaw489mewJoko5Rt6LGZJxwkEnoW2rPmkZIC6v6pLA?=
 =?us-ascii?Q?X0rmNCpPt5iiidToEKvvIntpbFfhGKA23r/NMjBaea6CG7sLduW6lqjVDTG6?=
 =?us-ascii?Q?yVwDPjTlKymJtOczfVxTupRy8V8Bc1bBJ4Oj1ioN1POeelwAs0cYk8tcvlcw?=
 =?us-ascii?Q?5J6MdsXkQ4Lv7c32T0PreGyAsG5uErCBccyzaNs5OSnNZGRptWCQSyfEc8Bi?=
 =?us-ascii?Q?DhkFKIgcryl6a8nXF4cLcF0D4UK/Xcng4FiVzIvEuwFRWZEtfJ0xnwiBtcEC?=
 =?us-ascii?Q?X/E2QBl4Mz7WVEWS7z0PWeAFp4aFVLMVImA9IsfPCktXnr/7+t/E82PXLvPz?=
 =?us-ascii?Q?EnT1ZMvfYhSkGYBwyjoEwGkk3nJIbq3viGoCmHTCnScCKsA2469ZcasjDq+r?=
 =?us-ascii?Q?SRgcv6XsUrcCx5dGVnpZqTd48t3NhHz9DqhOk2BW2c7XSvQ4TCsh3tKl9MFc?=
 =?us-ascii?Q?EVvIpIc4e4siQ45gPPMIto7BTffGMJ+aUT7ZqDPU22hi2HCOiQvOKDgjEsqD?=
 =?us-ascii?Q?zAVr4QevdzQLWVV6ZNIqP90OG6eNswXcU24mzzDpD6WK+v3sxps6SHpt1PKI?=
 =?us-ascii?Q?6idX8wyr2UAEtG0BWcjFRP5bfcDTEZDhvhy2rVZUmObwM7foOFZA6fnBxToX?=
 =?us-ascii?Q?YF+Mx9NLCyEtZnX6DK8AQv6ytB85o7SANWx833f28H88wN9dvVU71m/PPeiZ?=
 =?us-ascii?Q?bhdfFGU87u+lYJ0E3ItvjLWqrfUXEGKnLhKuej7Zi6qXFZ1M5vL1j3TYqPX3?=
 =?us-ascii?Q?/rCUy9rBP9DYLqcU/12N+zTnDr9TmdF5cCaxEG+9w4TAq12pcBnFPGFTbEjl?=
 =?us-ascii?Q?ZY1+RDbjQ+x1mtRoqsmFMcGgyzl7XeFfYqXp03CcA0W/7EcGGUiNiM+7Fdyi?=
 =?us-ascii?Q?lJtMpBgTDB1c/EA+oJ8S080hDV86JECqHXraBgOgDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JhUv4xTBYphjr8X90qpzLUnPWwpGRfOQEnbAuq8R2yBHEdeYSWKvjoc+hsPV?=
 =?us-ascii?Q?R425UgRdF2YdG1VyKNP35BMLd8ncqy9IK/P5oS78Dq9JQSuUWNGbYVVDaP09?=
 =?us-ascii?Q?lqZ+y+WAAXzlRS7eY2FctZR4xVVXIN6yQQ7QaCrmVPo6DQUGmtSAvW9l3ER3?=
 =?us-ascii?Q?vqg2e8rwjs/kO1Og3R1gUeLyeIjDRHF8Dpu89LmFuc7VQMtuodca2UtIpthg?=
 =?us-ascii?Q?2nhKHgtQKtn4/oWqxDzpyBKI4YpF1YAkbJSKzksF/8aPeqtitwI73DG6EQdW?=
 =?us-ascii?Q?VJ2Skjt99rY6uv2Q5FjlLwG3JsB6cs98gfo3lOQeEF62KhqkQzjLB+OjL0a2?=
 =?us-ascii?Q?910wGbZV52/FhAB2li3ACZcgdY9ZtU1cfK5OF5YOuDqIGYK4mA/PX9DbHdBu?=
 =?us-ascii?Q?BwcRRRINlaAzY5O4VM9BX3HQa+5npn1+3Nlfu1vmzjr3Qb/XMotokKDGl45V?=
 =?us-ascii?Q?pN07THymE/VXZ0i4qCbskpC3IAxn56rK3oYoAezQaY30RdjHqdyYqoG0khjq?=
 =?us-ascii?Q?XvRW9siygD6+2g2L649kq/9gakjdZwKht4yd8ipS4UnZRXJf82zsPi6/zMl+?=
 =?us-ascii?Q?nkQ2xHQOM7JWwe8VRgeWwbcf15xikhbg5RZswuJTS9ZAByGp7KwkVLVT2jDS?=
 =?us-ascii?Q?3i8UNS6SAvgspNMeqvmjrIV8nEXCubzOWzSIMq1v+TLusMhiGAmzKIaOdFnX?=
 =?us-ascii?Q?tIggZvjd5vMc+ekV8r2EDb92+JewycW+LdTMZibNsJ0xnFcfc/14K7eiQ5VS?=
 =?us-ascii?Q?LjRiRg1GqUOx4Pl6OOm/aN4Aar/H8VdzJC01PVe0icWNdyBtJEivVvlhvxs0?=
 =?us-ascii?Q?cjfjeGItahhNHT6CikmOWtSbjk8PBrGocTJ9oAY2ObW1SG77zf7Q5CtJ84AT?=
 =?us-ascii?Q?A+mpZA7MDsYYRmDxCdokNE1NMFRUlSE5RWa1YfiZgFP93qb0lO6IZgOnzI2t?=
 =?us-ascii?Q?PwjBIsJHGSnrhijTb2uJAJndxv/yatdN5U2+YnmtoKgJ9soxTeOS8cHMrvJ1?=
 =?us-ascii?Q?Kj89GjwmuqoQKCtLKVpLgzR6blQAiiXfcr+cyw8HbQm+0RbicdPAK6gampQx?=
 =?us-ascii?Q?MUhm5wkWX0p1VZsTIxCZhBBvROvB82iyeUKjNb80w1YQquCkXHGfEWQiv2D+?=
 =?us-ascii?Q?REhppyNDxxrxdVHguzWr7ny6E/QEq0QTdB5ZXW3fQXHTH6kUBkivBYZ/mmJk?=
 =?us-ascii?Q?CTF7iL0AdRzZP4nIZHPVlVxzRWYA57elnEFMHzUzSdeao63FbOyDiixYiduC?=
 =?us-ascii?Q?BFb0iQL2DrIz7HB/zBltBq+KpkVQUKtDk2Zg1vUEvETHG/B2XM7occgsb9de?=
 =?us-ascii?Q?/BfkbdMJhVvfO0xf6eObsxv+8cKaLDB6AuRWMH55doTCSuIupBke93nPr4Xc?=
 =?us-ascii?Q?xhwVqX7l5Wfi8Plq4ZOs/lk0UT1+GhA/kkuNwRR/kQ0AYxxjdCUAYckX63zn?=
 =?us-ascii?Q?C3k+gTJhSbTauc8xXmihiqRcgSqTQTjgpdLdAP3HyF2CbEn5qf+Y6dl4fvv+?=
 =?us-ascii?Q?cM9CUrZW2m2gHFInJSF8ZUNBKeUu20Zb/fzI/Xstmv+yHIAh6xSMRj8/LxGg?=
 =?us-ascii?Q?FB7FlpgrK5bpXx1/35E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9103e600-a394-48c3-429e-08dce6d90a8b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 14:05:04.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJ3ng/5SliFAJ+1cqBXYomZq6m76zTyqVX6RVmC/Ns9gXJZAyISDwMXzPeAfvskB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629

On Mon, Oct 07, 2024 at 04:13:50AM +0000, Suravee Suthikulpanit wrote:
> +static void make_clear_dte(struct amd_iommu *iommu, struct dev_table_entry *dte,
> +			   struct dev_table_entry *new)
> +{
> +	new->data[0] = DTE_FLAG_V;
> +
> +	/* Apply erratum 63 */
> +	if (FIELD_GET(DTE_SYSMGT_MASK, dte->data[1]) == 0x01)
> +		new->data[0] |= BIT_ULL(DEV_ENTRY_IW);
> +
> +	if (!amd_iommu_snp_en)
> +		new->data[0] |= DTE_FLAG_TV;

It would be nice to have a comment here.. 

clear_dte() must create a blocking configuration as several callers
depend on that.

Why is blocking with TV=1,Mode=0,IW=0,IR=0 used sometimes but
sometimes TV=0 is used instead?

> +	/* Need to preserve interrupt remapping information in DTE[128:255] */
> +	new->data128[1] = dte->data128[1];

It doesn't need to preserve.. write_dte_upper128() does the
preservation automatically under the right lock. Any bits in
DTE_DATA2_INTR_MASK should be 0 for the input DTE because they will be
ignored by the masking:

+               new->data[2] &= ~DTE_DATA2_INTR_MASK;
+               new->data[2] |= old.data[2] & (DTE_DATA2_INTR_MASK | DTE_DATA2_RESV_MASK);

Also this shouldn't preserve the top Guest related 64 bit for a 'clear
dte' either.

So, I think this can just be

   new->data128[1] = 0;

?

Jason
