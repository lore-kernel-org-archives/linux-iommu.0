Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A2175D2D
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730463032; cv=fail; b=ZVnl44IGG649zXfhe2iVds5LafggxuTscMArgjwVbEYz5qbhvj/bZMrRtLKEyeu2mUuKVHU5q08EiN/Ez6j83Gz5eyEQCH5V73mZeavb3bwX867LCYftr1GVxj0CGdistOohQdeAS9yG1fSbxX3MLtgj00KhRrYH+sthiBwbAFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730463032; c=relaxed/simple;
	bh=gFRoCIwBpF9UtG9Hy425w6BQrX2b+W2x01YEIVsZkyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XmzQ6KwXBWrHgl52j45Iq4DecZadD5k2EMZObS0iyZZCzRzl0d6YSs2c2P2WD0rEm/HwuU8CP85/UOmzwPW4vGePxCmUS/5jgcAd8SdcNIScEvwv8sTmYGGSm8SbE7fqUBgRd6HZh5xIM6YZQuFCbK93b3RKoa4rvyK4sX5olUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bZ+aUbuK; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bZ+aUbuK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4e+rf+7IJa1IKlg2QWmqOissuCSocZoF9qZwszM0aXbyWXgLYGDXLxN4RgFyIDl9aqcORDUffBMsAjVd+dCruliFIaA9WHd9Qnf003HKmn4m8PKcq2JpU86s2wFCX4gKu81oG6i3kvfern7IjjwHWint/c4T+zCsz6hGlPD+7CVrP9K4KcGIPzgmaFEn/pT7PXjOudcJE0QACAlSEKvoFQmXeBqB7Jot8gD+Boi/Xpf855RUAwk/zns3GhQJvbMdXZHbzL3LO+6ThbjkeGHo2Q88CEYMmPjWtoxO+K3u8NUiy69q4zNLAdDF9aTCR/Cla+XjPUHlbQTnk0342XfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQXRIoi4N2Y4Xpj/1QSslRmuImxvGyOyMyFCGNOwTtg=;
 b=whpt0+TObthG82gz9aD8dXUGrgQSEhyVSB/Rnp/SdRgD2JsZbF5HQtuRaQ6UZq2C+JZ88hOlw2FnZFjug64jsGHH8ySFweNVLmGijCUehVjFpL0DcxDaoLovEYKT2e4SSz4uvhxApPv5H/guuyj/SIrO0c6nDhCGxPRxhxDutR3JX00tPT/s4mxBK7VNI1+icawpcsJ07EcpEndGq2vAzKnZXXSp2vqtjZsZ1FtfLXA2d8nm0YetwjM/0HkGQWgdvTXu5UH0ZNJdX2TUSU+UAYI/JAHcbSToG1tw4Q9+0NzqKumyYmSwYWdGs7dDIKrmMF6mitOFY08C8ujEHw6XIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQXRIoi4N2Y4Xpj/1QSslRmuImxvGyOyMyFCGNOwTtg=;
 b=bZ+aUbuKp53H+u2+JqstlcHQELMuhCyIaVyqG6+VVjZzB7m9w8Fba9QKnwjYoOqjPYC/Hp6fuW3xcNMix7oqzwZFOWyiyYnBO0+f0cZrMSIoWLzsGP7S+WgEDUjldX0WOPy1+YoHw545p7eFKGV/exsQztw6pS6dwTcnADONRhSx9iZyDeQfHDDG/zVGzUSufhnFv48O6o7uFkr+U3dKiKyc62FZbAGSfFn6usY+Vd9KI+zb3z5xDimRkdwDA9FY+pkr3moA6V0NsIEmMKERA3DNelVHupFTmdqiYoE+ny5HBYuHCAlff9T7XM2LvSTedeO99p6/rTzNsJmQChTILA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Fri, 1 Nov
 2024 12:10:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Fri, 1 Nov 2024
 12:10:24 +0000
Date: Fri, 1 Nov 2024 09:10:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v8 06/10] iommu/amd: Modify set_dte_entry() to use
 256-bit DTE helpers
Message-ID: <20241101121022.GT10193@nvidia.com>
References: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
 <20241031184243.4184-7-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031184243.4184-7-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN9P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: bda7c584-9bc2-4c78-6eac-08dcfa6e29fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9UViphAPo9ipcBVEe5ZxcebWrUN6KPDCE/FZ6jvYtW/9ze7b3lu0rpOd8hoU?=
 =?us-ascii?Q?T876m3MbXTMKjOp0LknEP1K74JccPKcLPiwpN20KZLkcx90qr5S9r8Bxf5ct?=
 =?us-ascii?Q?gdV5OK/pFU/xSx+BiDJUtqHCBM6DNeCy3ypxi6w/mtZKttXHYfajDgQQNUhm?=
 =?us-ascii?Q?M38+7Pha3P2pdXbTJUBa/LZFKsPDDQqznBBjPqQGvPl1k0Uv7bvzw2O4Ctpz?=
 =?us-ascii?Q?G1Zdd3Jh4W1zvteOmmcUexWHstgSUOn/lTQ14pVLfPixDOxvAb7VjWpREU0l?=
 =?us-ascii?Q?qbtK/pQq/AjPFFRPuY+PEwu95qF+LnWYbPFdwp0NjlByYmWIO34j4dct6mNi?=
 =?us-ascii?Q?njha9Gy9mtfr25iCImSaMS8VurzSIzpxGY1i4EZh/zjCXYwE3knMiKPk3oQx?=
 =?us-ascii?Q?dx6cDm7QorkBngYvYvH6KLT4aqo4N4IIYlEB86hmcJV89yr9IGx2HvGveH6f?=
 =?us-ascii?Q?SBiJm3Y/PoJN1Nj2ZsXOyCnLFffDMX7s40wH5dAGDD/BXXYE1t17hJA/zscM?=
 =?us-ascii?Q?TwjM/40PBr3pakkyWK/QMGxk8Yn9hZQ8sJfuZOR4houA/3eldFQ/TkDUMnS+?=
 =?us-ascii?Q?F8U9fL/I1psxEu5FzI/CWu2ESyWRTVmpqozDhrkoQZj8NVnT6/iq0RUcuVYi?=
 =?us-ascii?Q?EnC9KUKH7DVa/QoB3ZSAG6gXYyfPiZ5fH/qtg0VxDVFMrYvScVdmmf8LSPVd?=
 =?us-ascii?Q?3j6ZhPyCmvovqNFcbdbotmWRKtfuak7gV3HBHmn6ERg8hmvAWGt0CI/y4M5c?=
 =?us-ascii?Q?dJaeaic88Dj4QpS2SENob4jDHi/F+At3OkZE0XwdTOVaItvgvZJvRpcgI+LP?=
 =?us-ascii?Q?CY5rlhrBECirXmlPGNSObR2XE7me8cNlO0FL2dVSIgmoJ1IJdly0PPgTiJfj?=
 =?us-ascii?Q?PafWlA5S/Pj0+PElK1Sgmu/N3vusz3svEPwQBjPx2dka3K/m+6/RgVykQFYT?=
 =?us-ascii?Q?riyl4P5HQ4LkfNA/0jOXkp0TMrFSEOKXPiG2/xzqiof7PaqY3DS+fvQYA3aP?=
 =?us-ascii?Q?1Hio4r2N9dZy1HUst9F6OcFuUjDtziQpVBVUHMRgV0iiyDvN0ixi4hRf1wwi?=
 =?us-ascii?Q?Sk22N36IbD1makIx00CupbvXiYlpmCAr3dCG3ifRU+iIB/YzjxOoOuRvnb8H?=
 =?us-ascii?Q?/rTlbdOy6qBgzW3HA3TFPrXdn/hXpvnrxUosjGOIHdJpjFMSSIb2886PIM8w?=
 =?us-ascii?Q?vORgSUF3g4Apaz5dDx8Rig8xohRdnTqK5dUqv98xmjjbB1hvdjqChRBZyyC1?=
 =?us-ascii?Q?gyANbIwLovAoxXFiZ7nN8duZeUmarlsi47KOXXF7epMIfrhvxDHzmwHqi6xL?=
 =?us-ascii?Q?d9BJVpLUzyk7+ayRa6bbYbeM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BOQ0O/oKLY3OL5WBvKcCT+RJd+1uiZO+vVzk/3gyztsl5g2kCSFxgJywadq3?=
 =?us-ascii?Q?5B8ga0lL+tsfgSfHZvcNWVdbW9wrxROhwx5SU0kUgB/unoXlouThjaJVvhdf?=
 =?us-ascii?Q?RaV0stcxaU34FSWXUs1nyrsLMImE4MV3XaM/K/OoCNH1yR73/3AvYQUBHTDM?=
 =?us-ascii?Q?4gfSXkO5Bdv6q4hslWdp8QdJMKniutEP6ZgZv2B+Xa02XUf91QcsPMy1f3jZ?=
 =?us-ascii?Q?6xI8O1hn+Ov7CIgQexopVHNcLSOcP2VzB3SrFOJdLMnMyc0tyQ68Q10jI7rW?=
 =?us-ascii?Q?Knfxycd4iqk48WShcrhyWDLLhL6m8pxKTW664Vh+geMSd1MrkXAwu+16zwrS?=
 =?us-ascii?Q?tRSa8Fr/mqkbwUSPE339rgO4hopD1fTpNMoVs6hPX8MuUn7l6vo5DsrtDN7Q?=
 =?us-ascii?Q?q4tC8eE1KnbSeX/HvcS7MlMkUVlDFMxixjWMJVxWNHB3RZw8SUuELklT15s6?=
 =?us-ascii?Q?JMG0YGNhSkNkGYQXmQS+syh1y1yYAUyhcyey310Z7NsKjboU8H/5px24EKSA?=
 =?us-ascii?Q?wg/s/Uq0EzBLpRn6jQLWCnOqtCxKMUwgyJKmnkECkFw3qUPZCXJ8WBEFIQoP?=
 =?us-ascii?Q?vHdMwBrXotX3h2LbOTOujNjBXBZ1jZuUgEiQJyk9JYg6P5l3wUCxnS5S5dNG?=
 =?us-ascii?Q?5I2EDpPpfwX22fc0SPh2IskIy2jwZaxbEnVjvCL+JQNoMhFQL3SfuqCp1Ipz?=
 =?us-ascii?Q?Txgyuzzn3N2wcTEmGP0zIeXoF2P8GMNA11LvB9jJeTIS3ID1IRpdcULQA8ij?=
 =?us-ascii?Q?17sPV2G/zG1NUWnOLvSLksT3FEbDJuIAD/aHGTWbI6rziEWLEOf0BaP81UpP?=
 =?us-ascii?Q?Iuzrzf6+HKCEoNxg+EMGtWKAlHJPJpsPsJ9ksKX7/eXjZsAlUOQJrQD2yGDS?=
 =?us-ascii?Q?xJ8hYuFasOGWkozFuyxQBuTrppdwJB+fI+G93Mda85YWyIU+KOEZCRxO42e3?=
 =?us-ascii?Q?DPNOn0enbsoyEwKJyC8YR8s1bhGVTLSFbWWa/TiquPUTqvN3f1mAg63sfU1P?=
 =?us-ascii?Q?HEaFep7QAp2gGFJXUOIT4Jy7I6SjPe5dVGndCIxLfT1ILnOlsKbANMeYiph4?=
 =?us-ascii?Q?Qkb3CfTO/NdSMmLAQH8hnDisbXhMaHFdKHLlEUtSu+sPRwHP34y208WPrXrt?=
 =?us-ascii?Q?eIIERNK5jKNOAKaKnTFO/cb9Wglj1LZRCQ6afweHGxD31qQ68Rwzo/kF2GUc?=
 =?us-ascii?Q?o8cqJfBLpAa/C5PxZalUcsVms03sJ/pTL+Qj5GZMSxc12+OpvXaDO/CfuTGO?=
 =?us-ascii?Q?kG3dWEMBJcTzJwL6S6xPT6OuJLsz6nWIaKvwoyhvjskXtBCPoFnQulCaAe60?=
 =?us-ascii?Q?I2SA77ulSrTXc0/imysyVwWePuE8IRlX6rR9z0AV+foCljaojrBU+byC4evX?=
 =?us-ascii?Q?PzPcWpgY1cAAFHicAfJmWKDPYqK+F4EshBCgBPAX81qp29kQdBHcPNlUhO3q?=
 =?us-ascii?Q?KQxLhW2z+OR959GHJ87AaFKXh0C68Ot2c+K6XD7dRqftoeQoAF4y11Q608Xk?=
 =?us-ascii?Q?XUP5NKzr9HWxDVHmMrJ83HxSuD1ASG+hrZ+Uk8f48aImP6VyEzZ4n5w5YXXj?=
 =?us-ascii?Q?Jpf4bVqAF2OQzXLumi3ouvIEizNM+eSyjHVHEfVI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda7c584-9bc2-4c78-6eac-08dcfa6e29fa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 12:10:23.9859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQ24pIb54nXT9jfuHvBIrcG7rHCIbxdx48pC+vBAN0Ga83/2SKPB88Ct4gHdjROx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921

On Thu, Oct 31, 2024 at 06:42:39PM +0000, Suravee Suthikulpanit wrote:
> +struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid)
> +{
> +	struct ivhd_dte_flags *e;
> +	unsigned int best_len = UINT_MAX;
> +	struct dev_table_entry *dte = NULL;
> +
> +	for_each_ivhd_dte_flags(e) {
> +		/*
> +		 * Need to go through the whole list to find the smallest range,
> +		 * which contains the devid.
> +		 */
> +		if ((e->segid == segid) &&
> +		    (e->devid_first >= devid) &&
> +		    (e->devid_last <= devid)) {

Again, I don't know much about this format, but are you sure about
this logic? Consider:

 e->devid_first = 10
 devid = 12
 e->devid_last = 15

 (e->devid_first >= devid) == 10 >= 12 == FALSE
 (e->devid_last <= devid) == 15 <= 12 == FALSE

FALSE && FALSE == FALSE

It seems to me it does not do what the comment says? Compare to the
version I sent in my last email

Jason
