Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D8C2DC776
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650160; cv=fail; b=IfSaoYQNG06rRLRGZ3UCKOeMavvoap8CjJAdEtxTREErqBBKh2J+Hfted70Vn8pOglulKkWBg7FDSSIZZ/iYqpUw51jhE9YEEcyg9FQS/B/U4X3hZUdfuO/zqBeYRLWjcOJeIyDJdgK7F8xeI0hd/e0x7NwzTZpL/60VCJyVU1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650160; c=relaxed/simple;
	bh=BpFEyBuLjKqlmVxQuMgiuQC6f5CLlllRCzl0CpD4Uy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DvRuRcW6oJwTWp3n1tGITqQ5zV1LRZjhQ+0BvcvXLlgdTo0npYRbsM5s9bJehk2A+POoaTYmCsO3Pg+uMBeABQ4b5/hdxR/++mYP/ybjS/BIsEH88Rj9AWX9tj3NOphszVn2LF3+J+PdxEhxMNwm60iEITn9W60hpg3HetWb8dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PryleNWQ; arc=fail smtp.client-ip=52.101.56.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PryleNWQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eI6c1Ddyh+4ZisuNPzbIUklPeMRNZ5md27cLEHXi2pEhbyD9mlsWsqGsNgqPeWM9kf7X1zVlRO5Sxo+95qzJDye14MR8gidsxfFWYAsd4QiAibxZBSF6gf5s8AIfkNFEKBR8G+bh1hsEQLqjyNwE7jViBLZ/Q+p6eM30bb49yJnL1FACaDinyfYmSq4IqiXBROiw2iwd+oUpCN63eIZ/txeJWuzrktYmq0hIZ6wkHQ1hzAPeubtiZ6sOJpF05EQ/YsDvQJG/qr812dm5BLex3dvEF1MKs+0rqAw+cPplEvxY+lKlkT97YMwsTKCT/fRT82+ni/iNoWpVscIgi+vTTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yudnP2TXIa1SbUYjoD8pzYLME0CMNmIRKeGKfmrnssc=;
 b=YgFj8jlHl3I1paDAUeq5KiPSG7mpgHrMblvMrX9bdO6JZNX9gljOkSrgcCWfZP55y7sIxNN3CgQOR0Qd0cuyk9iu+z6TueH5tmqbYoWy0ci497ex79VvedLF7fnJdabCAp1BTBZ2vgYm5mc9zXSLjTt/Rh1yXlrWlMwrD0KZnjonR7dpyEgehKiIMRDFQ7v4yn8/aKQl+fS0zPAe+mMSSjVWFB1Ksk+4nyZhckpUYcQqBCS4c3JV5MF8ozA9uwH6K9wMRF5WqBodPsS908rAZ5jGsYiTsGwOjBbgRnvYbtf+UY+S1JgptKnjbnwUjyZ9Y8IWm+1/372JIZJ1jjT4qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yudnP2TXIa1SbUYjoD8pzYLME0CMNmIRKeGKfmrnssc=;
 b=PryleNWQsJsnzmuhfq70aLLxLTGI8K4wwoCSKJoRKmGejF/SpRD7ZwwK1aS5UzvlaGX3ik8DAeYQZS71P8mBzzHB3TArd+GJ7QMEMYHKE62oyXUCryy1Hz3L9s6R8MUuImyQEyO2jNlxx3BnbwUp8Uy8+xlIIVOKvO61GZ624WsqnYyg3t56pkpQwmZdG7UUsYajBRdt+iX0dDpu4RsRTVtDs3DZ/1UovkZWiGh+sft6pDvA+OlSxWdwUNWRNZ0iUxQx6rprtc5haENADG5HkQrXWERcpxeoPwRe8eyqgLeeNDv1nUB5hnmCq1/9SmrCxStVJ35PSRbXRo/iAja+Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 17:55:53 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 17:55:52 +0000
Date: Tue, 23 Sep 2025 14:55:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com
Subject: Re: [PATCH v4] iommu/amd: Add support for hw_info for iommu
 capability query
Message-ID: <20250923175551.GB2617119@nvidia.com>
References: <20250904193112.7418-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904193112.7418-1-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CY5PR12MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a469fe-6357-468d-9889-08ddfaca701a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5d2a7HEJCgl2P+MP9kOgFjkLE8gzv0UFV79ZDmW/TU3ExuKYCq1Z3GYzhm7G?=
 =?us-ascii?Q?DmoywSqly9/prJKmVEkFsIHSK1PPbrzshesENW5G9U8JrwSsPIHlUx64nP9u?=
 =?us-ascii?Q?HYoMyT8God3fdNREvPYnuQK1c13lxgy38KUodK9hCZaEvGf5aq1oy6oH6Ndd?=
 =?us-ascii?Q?LF14pUhXnwZ7yRkrE7nfUbN+laZTjK3NqlKmIaX6hdFg/JAM2PJzr+GkGH+b?=
 =?us-ascii?Q?MNo7d+PuYvZQUm44wz8cnBfPl2gArU2tY0f/Xn/PxUQR5wjHIESXh3BOR8Dc?=
 =?us-ascii?Q?DBHHuBuiXRflx/n0dSvR+VVvwD1yZyQNfR/K10HeBwSfEDSWNiP91JMa3fBL?=
 =?us-ascii?Q?ZmSrGmnF/zQiFLKhawoXnwLMALUTcs2eJyolk+3zm6bH0cinF1iuaPJWKOjj?=
 =?us-ascii?Q?DZgeJbC9pIXGPLcFS0iH0JWABe/6D6V6wP3Uj76OrwJda6rbh71R4hEiTw2i?=
 =?us-ascii?Q?M/UIcI2vbQpOlyXvVVOt78qovAg+O5M1UHt0KrztjY7eJmngeOZok30BHVrU?=
 =?us-ascii?Q?9PDyuXwhTyou8Kst2qtjx7QE2iYXkZanPbnH/bKr+0AtJBEorrnportVcCXS?=
 =?us-ascii?Q?DRjPyo7j/jzwKmcFg+5/y1jpdv5e6J9gRd0Rem4YfJ3I395FVlj7Br/ERQyt?=
 =?us-ascii?Q?ysKYuhse1cUxvZXvSG18AKM2ieeeLEdMgGYuPDolftBrhc5U/1s14y3IlSbT?=
 =?us-ascii?Q?q2REVTTP/SqdaKP6pDlXhjTY2fJWhFfUXEGUv4e3YzcvtpF+O9lw2O0RpAks?=
 =?us-ascii?Q?QfdzOwFyzTweXd2YpP6ZhGj2LZ3lz0vx7tFyogsp5RA5RdLXimvtNeruknCV?=
 =?us-ascii?Q?gXbMt0ooSp1LRCvYm/rcYb1hEZHKJfpRTkUMkh2v70ZhqjFDLU/k1ffleat1?=
 =?us-ascii?Q?7i0wY/R+hOOmUGyapwarlIhFv2fUuYWMJCWTU+llkXJ5t6BwRvF00YtnSN8C?=
 =?us-ascii?Q?SJFGt63W4LPmlAlUhlW8uic6WQoiFXYCmZyNgfM1JwWTBiCV68rTzzUoeltP?=
 =?us-ascii?Q?EIjz0vwZeITJp73tGfcUs4dRO2ytxTmXNcNf8R7fP6QfxMg722mPQ/kqwFd6?=
 =?us-ascii?Q?lT+rCq3i5eWhK8QjgMhPKiEn2wrlzXBukNnCknucs4bM29FDq1JEIAXp1uDW?=
 =?us-ascii?Q?EEtcjn5NK1+tspQp1sOqrsB4JCZAdP36hfAq7tJVB0IYndMGBIWpPD5rQxir?=
 =?us-ascii?Q?DoUcvPQEN7BD2chvCpEdvLsGhIL3UxG+LlklHbTRD0+QCv7FIjO6ZzzDX2wy?=
 =?us-ascii?Q?YNFZvuNs4R4+QE90mDssjSopj4fpMNmBTeo6vimIf0q26Wh+ncH4kd7+mz8m?=
 =?us-ascii?Q?A5KS+A6b5l7TELSxsZrWumuYIwyx+iESqbDCULY5+rMS/4Vh/TTN1oOwq2SB?=
 =?us-ascii?Q?OJKKhsnawgFIhPpKGkDcKRG7rrGFFAgxP+65zxGtUy8EpF84eZ4BPec7pWvW?=
 =?us-ascii?Q?60oz/JUPqtg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/zTh/YRYY2+n4MwkAV38ZBWu+5fZplJWRhaUaPuWrH1sAGyXz3z+5Y7SDX1K?=
 =?us-ascii?Q?BxkvsQhXyUN3LQ5vtq8Zoi+G8IFRf8zxPixi2gDk5pg745dv3ckLs132jy8A?=
 =?us-ascii?Q?PpWjjpTRMZWbvzOHgJcWqG4UH+J95dg6NDE7SE8+bWE9SHEpjNCUBhvCNEJz?=
 =?us-ascii?Q?vJUizOQ82O5ESor0QsOrQQSkit9sWjX4BQ7fVwIhCgvvpdn0NFcsro/DRgaq?=
 =?us-ascii?Q?3jL+Xrn2MyUVAHpikoUx2A98fqz5A4PHKmgJYluwltTDwiytXI4Z2I5bOXkc?=
 =?us-ascii?Q?P/45SbL+w/MkWImYsMTkNkpp4DW1cQj5bcG4hnkJ0iRmWzZI2DgLovNa/Asn?=
 =?us-ascii?Q?89VlDzkjUTIKmnI2VIPGVPuHxbVlAjAAo3xkX1gJBwyIBepVjTcecNw6fQ7a?=
 =?us-ascii?Q?BNOdIPnJTWmSLR7JvoCJ71MqGg+86BU2Mxrc4RjZgIoajcPAveMLXSuHFMyU?=
 =?us-ascii?Q?+6/lDilkWc4K48B26mPnKp8UGPJMrPI2PqNklJwKRhcQxaBDEJjzT3+HeakJ?=
 =?us-ascii?Q?Veka8SVSlc4fUV5x/lXekMUyZ1kH74zaDVpv4Azdf3M5VMhoFk274OUrVANf?=
 =?us-ascii?Q?3CzU2b9o/YtcYPeVCkLK+coaMfLPemgLG8nSliwd49qP6YZ/Iuc6Em+bmnQL?=
 =?us-ascii?Q?3eH8qPFxSThJvrJckzZBDc5/y6U7x0dmIz32SqH20mP2t90s+6nMR165xqvq?=
 =?us-ascii?Q?OEXkR6MWOeofKkVXZTBbGZsBDLBEaW3yxejrasASrCz7dC7ZK+eqkHdoiWD7?=
 =?us-ascii?Q?tl+gZwhQPX7n9GmGMSOQEFq9KgsmGvsAdudsdW+Jn1w083x6muprnnTHOglF?=
 =?us-ascii?Q?U7OCon0aQO9VsJ33rLDN5LkK/a4UtJhXqo+lGqyETXtLhxD2pHM4U0sYLIs+?=
 =?us-ascii?Q?YMwm8QT7wSCIqUTsODiNJSklaNH0TdN+ukcuqPgEG9uwfoJAwI8IuN/x+bc1?=
 =?us-ascii?Q?B5+SIYjuzUq1oXREGFeGamSMZHHthJRnNDFpsPpQnbLIE8cPSkY1ko5Ovg+G?=
 =?us-ascii?Q?guPd6AFv8J8qwn23oHdkiCy+74ZF8arl4TQOE+fQgq7f4swPcDJ/B+G31HGw?=
 =?us-ascii?Q?B1BRALxyTLuI1m4zq6+jGAerWN0X460Zcm36vcDhr+DU6IiBMsrkuVXEa94q?=
 =?us-ascii?Q?sGlPfIpbb0hV1ubeMhsNm9kvAh4g5E4VgsUQFREoOIYMZwFhk3N3NIWvSSoV?=
 =?us-ascii?Q?hcPpRVowlWh2UwOAL9l6SHRyhbkchdTFJ1g9QvUNUYLHSqrPrp09is1pTpuH?=
 =?us-ascii?Q?sIH80FYnM8/7maYasOWsjIzyY+qdthzBa11pF8lozkEYJV2DcCoPsIqi4vWu?=
 =?us-ascii?Q?9dMHPZ+KDRLxJXI0jo+uYrgvZTnyOC36v0T+tm0/7KThV+UwgPBfA/vxilCI?=
 =?us-ascii?Q?zEdOoUkKUykqsM8iwPHXPDT+feYFhRv+yj17e2VU4zpuACKZzt+9B0vvHyfX?=
 =?us-ascii?Q?/XqGJd6P2YBO67f5AWzSztuUyjTF2wLpbJvqZjyz12upBKv7M/OBbM9o11AO?=
 =?us-ascii?Q?VsBxOK2k0Fi6WXRn+XJ8eDeKr15VXs3FfVNjV13OVnjWptt/TH09XwLu8sAU?=
 =?us-ascii?Q?eyxJ9FbtR6DscKc5MDfzTZuKlSvaoHxY3XhUBZEx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a469fe-6357-468d-9889-08ddfaca701a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 17:55:52.8985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RX+W+b+oSH3nXBt/qMQMXwdGDV7xJylQnsGcQ2/hWAX33LkIAMF53v0+1rY+vo1X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381

On Thu, Sep 04, 2025 at 07:31:12PM +0000, Suravee Suthikulpanit wrote:
> AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
> specify features supported by each IOMMU hardware instance.
> The IOMMU driver checks each feature-specific bits before enabling
> each feature at run time.
> 
> For IOMMUFD, the hypervisor passes the raw value of amd_iommu_efr and
> amd_iommu_efr2 to VMM via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
> Change in v4:
>  * Add CONFIG_AMD_IOMMU_IOMMUFD
>  * Update comment regarding EFR/EFR2 from struct iommu_hw_info_amd.
> 
> Change in v3:
>  * Remove extern
>  * Fix link to IOMMU spec
>  * Update kdoc
> 
> Change in v2:
>  * Do not mask the EFR/EFR2 and simply return the value reported by hardware
>  * Move amd_iommufd_hw_info() to drivers/iommu/amd/iommufd.c
>  * Also support IOMMU_HW_INFO_TYPE_DEFAULT
> 
>  drivers/iommu/amd/Kconfig    | 10 ++++++++++
>  drivers/iommu/amd/Makefile   |  1 +
>  drivers/iommu/amd/iommu.c    |  2 ++
>  drivers/iommu/amd/iommufd.c  | 31 +++++++++++++++++++++++++++++++
>  drivers/iommu/amd/iommufd.h  | 15 +++++++++++++++
>  include/uapi/linux/iommufd.h | 28 ++++++++++++++++++++++++++++
>  6 files changed, 87 insertions(+)
>  create mode 100644 drivers/iommu/amd/iommufd.c
>  create mode 100644 drivers/iommu/amd/iommufd.h

There was a kbuild issue so this needs to be resent, but

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
