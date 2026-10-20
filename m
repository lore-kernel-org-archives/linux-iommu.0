Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792506392;
	b=rGJhFRSU4pkzxEOoYmObC7Kr+hHG3i+eFgRaKml/YvoRxdY9EMfwEJWZGpiqtIHJckqc
	 EbF22wtrABsf7tgIB6CWYd5u4xXFf7CCLOGNlWleyd4ko0v93Px4lcDre0dpQtAL/YuPK
	 bsjYt1bKkfuGsunssWZ9Id1qleVExaYNwhyz+FnkpD9FFnFW7sFdH+VqNV1r5eXkHGvch
	 dFE8K+wlrYG2DYN2ung7plHUFCQJ9mpTYVkDav4xIMFbCguvptXVi/5ZOEj7n/aW7lj13
	 wOrFJP4B6/w4vLkvwJ1vU06GTDR1fQ9FnHUgsQHTw7fbnk1LPnSfXYfCSZp4tqSTB7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506392;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jzHxeokEJaVo1IDFXsDAbwiREVTzVQvjrk64uj9lGnE=;
	b=1UJxfggj7bthqRoSgqra7l6185NANqa9CxSlzKoVk5hqy0Ca8jjWS9hnj1LpISKoKtMY
	 FBzVL3emIeIel8tz8JcB8KR8uB/f3LIamoHhrN1DCI5p7o05HpSGzfP0kjGhX0xCQev9u
	 DU3ZRImBF3VWPYzrFLK61IRvSnMAKOSuHZb2bxtJCHXgbNMd8Sl69gCZEzoanWPYxb1zT
	 XN+8ztHIDP+dWT2O/TE1AjW3XRQxxXE6Pq9J1w7HE6QswxQh8oeoKTJjV8f1X5eGkgJEc
	 bkvLydtKh626fG+npZav2pzDk4KoUBdPBIt6MicdBkCWxDbINjfLWUAWB+8OV6O5s4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JDKd6S0Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.55
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011055.outbound.protection.outlook.com [52.101.57.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECF260A2604
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 14:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ECF260A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JDKd6S0Z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbKEfJglbLe51r6iJma0v8S82lJFh6revG6K7jCGrsjRqBl7Ga7Mr5g1K+qJlGLFZHeRFL0+Rd8Yyg/cFQekowdAkddebDfBZYaDJ2rsv35B7i2WqytfLoCEmnrlJu4qup9iF86CPD6nRNxkD9Wm+IvFb5N+RcjXgMsd0GkN/KNaJ7BN3uo3qS07/3TrFKg+LRwYSXIclNY7ginwsWViruZoPtPmQrt9lq/HH6zdm0eU8abjKHt2YrCiAOkDdSnn+pc7rziwt+Vj/tEW9bLpncPw347lGOuiYgMnxf0v/rQglNKFdzborjitMUmguHxFCq0+lmjA40j4CY2wCTwidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzHxeokEJaVo1IDFXsDAbwiREVTzVQvjrk64uj9lGnE=;
 b=YoepurER8vekODd7pDTIg2oBvNTp01AH3Rx3lPpEEPQcSstemWRZp/Vn1WqlVmv+Z31A0NawZs/p6RmOlsj/P7GRzhnBHBtcGCIW3/cOyjTrDuXlnRUz9+gHz/C0FNfNA+6VvRA6fB/EGrz5fz2E41INNsYuVn5V67FXgwNanZrnDzWtaUjg0VpHch0pgmivzFkA4cXfJDf3x8RL6nS8XjTAe9w+8DhnOTgrzSFEdLgn8NnbCOzoQGspiW6bbm9ZcbxLGc0rMp5p0Xmc17IhO4z2+qwAxVLx++RpS6y1mfOKBPeD1Xy4yNMcnUOPrQi7sTWviY625jcWgkuC5kzEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzHxeokEJaVo1IDFXsDAbwiREVTzVQvjrk64uj9lGnE=;
 b=JDKd6S0ZYN1GSPAAbChBT2On5P+bxH7vphCZJcCDaOOvJTEtW8DV/SPC2vENfQRJo3rLxquowNDVKeN3z2hmkYyX/0fjX7kiz5D03qoVfnR1qQUVZXKqOHopW9FLHNSb26b7cfhJvqPowyP+e19z/62vWXj9+4aF7fPed1UWRAja5HCrD0bBr4dG3ieCTaDnLu/KIeFdPm7on8ttbtsxyOGkW/NqIAEToNmkk/z6AzLXrm1A2eM4kcMH+O2UHGTj7RreLq6lOqH88+p8kUt/9icKixeuaoBwoTthihTDHKd8w3z6rAOSBwWz6K2SrmgLfzelnl0yl/aAJOBVSGMZeA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB9500.namprd12.prod.outlook.com
 (2603:10b6:208:596::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 20 Oct
 2026 14:26:26 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 14:26:23 +0000
Date: Tue, 20 Oct 2026 11:26:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	praan@google.com, kevin.tian@intel.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
	Cristian Prundeanu <cpru@amazon.com>,
	Breno Leitao <leitao@kernel.org>
Subject: Re: [PATCH v11 03/11] iommu/arm-smmu-v3: Swap EVTQ_MSI_INDEX and
 GERROR_MSI_INDEX
Message-ID: <20261020142622.GD3008132@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <630e70ba13639e5bd86fca0b574dd47dddb7fb92.1791226953.git.nicolinc@nvidia.com>
 <179190297652.2261874.5664965715184131627.b4-review@b4>
 <as5tVAzw2TAX5bEq@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as5tVAzw2TAX5bEq@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0424.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::24) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a394d5-179e-42ed-2e58-08df2eb61e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|23010399003|4143699003|56012099006|11063799006|10067099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VXsP+1yK+U5v+uBDqo8LC/6L7Y0plt8zDYFvlF67XOV5DMNmjlnFrO69O1e2h1aKX3EezDCLDFoyEVkMVhdzWf8QaaHkqiME5qk4mKWn6mgEO0UJffqO5NKN5MZS1wZ9wWKjVvd038yZBeTJNinr5N9xDsvJDG9NcKOXWOhFZHCJ95CrbtTy7UH0qwca0OMjasbLhmYA7l2qhc0jIK3cYG8Er0bAp0V68a+PRnDBRYOMMZa7l0x5ydF4V+6Jff8isvKAWQIV+NWJ0GDhwPI4Bbun+421LSKGeBleiwFUxJs2zS4eONhD28PmBHekWgewfIuiypUtzcU3K/ZO+XcLqGv76qWzJunwk25IJ66sKRHCq8A5Fq/ylWLqx6vdpuB0qwleEco45FXYHBrlcW808mLbvgyNMzHa1SDYQTe6Ni00BJB53+IBBNGVyoe9UbtHX8EpP+qkdv27LZt81obmtJrYAnyCOLfnRgvUmhn7kUu2uL2lDRLe6gmD6qby05y6Voy1Ex1gdp06Fs56WNKk2evFa6J6bGNZZ3LGk0JmxaRfAdwvg5eQFR41vtg75pIn4YM2xSg2wuMnAc46BB7m3djSRMO0IrQZ1c8ml0qD/U8Gk02O3wTt+wF28cJFIN4Jxo+CalB0zC+je3eZ4CwhCuk6hBN8w6LzBFc56U9Kg9k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n6QF6li6izjzg6iRLFBxNgAv0xfUks8mBUNTvQ++CzJD8hg0EWx7wI7BVlMN?=
 =?us-ascii?Q?be7uOWu7aVBuxc4VWIe7A+Vpu/8GhG32bdX61j8F1P4pZ/4I7n2f4eMbFo/P?=
 =?us-ascii?Q?IiA1ygsciXjKpHWlGQUcqXlVdiN9jIaGFp6n1ikaV33xuV3lURi7IXO4IVUF?=
 =?us-ascii?Q?zV07Rps0K2hi/ezCJfcQfWl/Vg1ZSbrRlcAtnODrgGRQcdmgHo6dMg6vgFDn?=
 =?us-ascii?Q?8db/uUVh7kd6F4QEOxuDwJ0IuCpBCEJq43fhOw6XLJWUQqEuIKJfPZDRsCae?=
 =?us-ascii?Q?g5Y6kOLzyQtWqZcE7H5r3c36F6G3txMGcTGMqBo5+gGUQxw3wFLL2fG9juN2?=
 =?us-ascii?Q?5sy+4XPVDgVtlDpn6vkGWuIyxA/Z9rrTfALuIbtGaJ1ilhaBsmvXpEjIWcgv?=
 =?us-ascii?Q?KI3dWJhwXVzm8mDvOI7ZAMFwnAQWj3w1KN3hUrVsoL0y32MtDnvfheUfqATW?=
 =?us-ascii?Q?bxzu7tprUPVbv4wWu5+DmIkID+ovD3sikbWuy0kJJ/klbHzwqhAgYyequhSr?=
 =?us-ascii?Q?dnOP2cFPzvDMEiqxo3UTLMBBGPuHNyHDO2M4RiZjYjnXGUgk7+oM2DHgoosj?=
 =?us-ascii?Q?bXzQ7V5zyETDEdAu0fHqA504yMJ20LayZ4CmzdPTuTu/2Z1XvBf2rMliYtvX?=
 =?us-ascii?Q?uRwgq929sZX+8X5Hidk4ICagtsayIRl/EFg/+YcoomeQg1Sqaw/vh4Rq8q/W?=
 =?us-ascii?Q?zpyq2oe/lsZDOAKVfhdE7awtCT102QJ+n/XHzNpUfV/898Sqr3akXC7UGn1y?=
 =?us-ascii?Q?fAk2gLUQ9XmHgB2m/tQGxM3S50J8MrHeDvP65XrbIVm/diYX70SDtPucTC0A?=
 =?us-ascii?Q?jqEpEUFiZANBJAuW/I7lWO7JU5DmxR9+netucMQjuxyNDyBgAo6Dy1RpeGLX?=
 =?us-ascii?Q?kPLJjdSfWMcwWywgdVtA9M+85peHKObAseZJBkD2l4gSbsfrmi04uzZ8J4mP?=
 =?us-ascii?Q?jdP8Smh1w5KbToXgXLh8ixQvwDNzA0qn3Zal+DjThkSRhzfdfYCXl0t8zT96?=
 =?us-ascii?Q?AKZe+AcEYsRsdBSDapkcijxb4sCm2PDR7jsAoTt+lz74stJu5xdIOZJO9Lio?=
 =?us-ascii?Q?jrIWUixiyAGjcDEtrfJP2xzEh7i56B9EQeZsb7o7aa5Cr7PSwFgs1Y0sjUs7?=
 =?us-ascii?Q?4QBo4oZFkW0Kq7MMMuV4Oj1+5KZBXE0G3KHsSSV9tRvvcVbnqGSSB9q8y411?=
 =?us-ascii?Q?eXaRXiCrfRU0R56pTrM+SDpZqp1zMo1esVsjQ/sOuK6uyYBWvVcJ4ffN1rhi?=
 =?us-ascii?Q?9vvmkmEfhgL6AjYy7pqOYCoN+6UK60CWaQ+k1PjxnzskksVGeod6ohxgiHBV?=
 =?us-ascii?Q?U5xhFA79dOwaMY+EZjgTUmUWzWjkEojLXn0lNykW54p/cdoSF1H38TYrIm3h?=
 =?us-ascii?Q?C1CACYMAxA7Mwroj+TnrXgS+GklZQJmyb+j6XUhVQgzAGD/h5Bncvs4hb6Y+?=
 =?us-ascii?Q?z3mv/bWUjPpdLHll/mOJ8C+L58rTTCL6B4rA7dECOuz0L0ZVvxTBc0pGircH?=
 =?us-ascii?Q?gUu2ps+sID5tphd+3rK6ESR0iVJ3cjS5T0BfwIRJByrhIgSgPM6Q9WwUOEZp?=
 =?us-ascii?Q?C11VqhnYxqxdGUoxk3SnOYqsblqTFGuA3YtvgqwbgfEf2Y5Tyqeqk+QVrlLe?=
 =?us-ascii?Q?0lq28xbN22dp6Jp+Rz6ErTcOEnznxpHvyHrsK/C7J7vPPR/U2k8c1WUW5B2M?=
 =?us-ascii?Q?72KAKokUfwPkdTTX18v4lntSqWFEwYH2tNhQu9joICh8HhFG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a394d5-179e-42ed-2e58-08df2eb61e23
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:26:23.5262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzn7CdXWk5lDjprnMvj3sCkdcSgTLGlXrpG2vpN//dFo5JcX3SxLlyfZHoWXJp2q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9500

On Tue, Oct 13, 2026 at 10:41:40AM -0700, Nicolin Chen wrote:
> On Tue, Oct 13, 2026 at 11:49:36AM -0300, Jason Gunthorpe wrote:
> > I think if you want to compress the nvec's array it should be done
> > directly.
> > 
> > The smmu should have a small array
> >    u8 msi_map[]
> > 
> > Which holds the xx_MSI_INDEX value. Then arm_smmu_write_msi_msg()
> > would indirect to get the config:
> > 
> > 	phys_addr_t *cfg = arm_smmu_msi_cfg[smmu->msi_map[desc->msi_index]];
> > 
> > And we just compress msi_map as we go through the normal flow
> > 
> >    index_msi[EVTQ_MSI_INDEX] = nvec;
> >    smmu->msi_map[nvec++] = EVTQ_MSI_INDEX
> > 
> > Then it isn't fragile at all.
> 
> Thanks. I replaced this patch with:
> 
> Subject: [PATCH] iommu/arm-smmu-v3: Pack the MSI vectors of the used sources
> 
> arm_smmu_setup_msis() skips the PRIQ vector by decreasing nvec, which only
> works since PRIQ_MSI_INDEX is the last index. A subsequent change will make
> the EVTQ optional for kdump, whose index is 0, so that trick won't work.
> 
> Pack the vectors of the used sources instead, and record the source of each
> vector in a new msi_map, for arm_smmu_write_msi_msg() to find the register
> set, regardless of the sources in use.

Yeah that looks pretty easy to understand

Jason
