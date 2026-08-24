Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D246F4A3
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592329; cv=fail; b=efOtzZdjXfMGR5l1TYBEAqa3BenYdx8OEjdBZB8bKMrPmz2FxBtNOf3wsuCZe2OnYVvitIFvSoNyG4QEzRA6fjcMfVfwx29LlZkgA/tS89LYpJFnL5iXthnYgHm4AmGsObMQvLXRpM7JUhHue3nLU/zFVouER/sqszPkQ8u8ld8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592329; c=relaxed/simple;
	bh=AJRuqIrIw55YGb160oRfARzIxca0qR0Q8pGRMwmE7yQ=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=IRbEFBrg1V5A+DRD/X2xAJ3yrnz7vYvwde5VHuemMEqQGcYFOokJLl2l+0frKmT5HY71YVbeGTbu/HNRqxIfjtEx6FVRMID/wxh2yCYl/jMVM+KVuKHPoVUgFRo/3/olP767R2c9+Y/o5vKrkCQ+31uyRZFJhDSPj5cgLGcDfFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=slVAFicZ; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="slVAFicZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLKaYN332TDeNvzGHC6zT3xB8A4SUML6zY/D0nkS64P7nW6iN5olD+7OEN7jjVRKdPlkArjoeEy7xf7nB7Izpzu2yFuQJaIT9MWjcA9sBoXjMELjWD2OTvxRj+kqsPI4rZReHBOCQjJ1EPZ63pn7EtbdYCLWI5k06JVPxH6I5mKbuLTRTDXJVBwLuqiyRZVif6miGpoM4D52Ym59R3a/8Sx66ASBJhoeaBkkQs5SYvzJSIWaeL8xz/3CpSAGkuK0SX1bP7JJynSLZjqt5NX8AdQFD6i+Ehj2jPmMP3iGjQAkbSOZJFkzMjzvZGYV76CfNJBNcc90XyanUlR5Yc3Yxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CP5TqkXuIp0NO6XC1TfWnLwRf3/6bDeVXDMwuzeejI=;
 b=OdaAu+ddvGAMmT2F6d+gMbX7veMfy+1EikfTzc2fHGxRmfhGCrF63iNSMSngRQ1/6BBEe9pzH0Kwg2CkkxoZJEz8w8WsFcm2OJVSX/IFzcCTaSfIvVGfQ6A4xPJzAC/6+fkfMLz6ulryrIb0YUcebEiPIiKBREs3aHZKhflD/biAOIOzXaWbcEr2MQAZHVoL+RRMbXuOX/7QD+DuKP71vYT5r0QPgRZlxgh1/p3+YdB/d7kOZIax5x/C6g7UCztLxieOM9OuKnz/INA2qgCOb/MGE3mA5lpU+IGLvgebma97Ykf+JHHuTSZ2bqJ0pDtMSRX7aqjOY6TjMXOEliSr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CP5TqkXuIp0NO6XC1TfWnLwRf3/6bDeVXDMwuzeejI=;
 b=slVAFicZG/r5XzThJxtQpbiCQnFOlfJ8qBNhcCqyRVZSIiQiCi024G+Qi0njm2T1JpH5yvUPC5VB7Hx9CEpnicnEqZf/KasY4eJDa2ZvyzMzMBoAPlyHKktt32MjuzTRFl7SYa8+qYbb0HvywIH1zXcAruz6ePdkOyLjaOnQFCc4aVAqAOFnj3I2aIcit2IqhufIWgRTqvk7+dQkM8TQ4UzJgYuPZqV5fxEjKYwmTPLPBtwNtPf4RRDWbWMBp8PQxwzjb+HBBNzqUTYsV523P0ZtMl5sSdj1mCMKzJyioSn1An25YU1SHVUY2XzpbYJ3ARyMBAJOMwGSL+FAA7zI2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:25:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:25:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 11/24] iommu/amd: Export amd_iommu_alloc_dev_data()
 helper
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com, 
 nicolinc@nvidia.com, vasant.hegde@amd.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, 
 wnliu@google.com, dantuluris@google.com, chriscli@google.com, 
 kpsingh@google.com, alejandro.j.jimenez@oracle.com, 
 joao.m.martins@oracle.com
In-Reply-To: <20260727132913.22475-12-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-12-suravee.suthikulpanit@amd.com>
Date: Mon, 24 Aug 2026 14:24:56 -0300
Message-Id: <178759229634.3131778.3315395924169031004.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0422.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 78271026-d54f-432d-3dc9-08df0204a448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|11063799006|4143699003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1xS1TmnZS03E+RKS7iyIpItnY2WWSEe8DasM8Nvm7eCiniuZgsn0tzGdl01tlfImcScZG697S4CAVgEbiXV0OOJG7ziVG+VwEkgz7pyT68quC5zSrLUmmxuTNB+f/6ZA6YA+fKYoynYxk4gq6DoK9zELqUg0WHNGP0+CvdEDm+rgTqz8L3GIKGXJoo8Vz8qxtqtQlSTHly4tHXCyU+Phw7SZ4g5ntF8Go7L0oJCddPP+ELKbZhOnFLFMSueqq80P7YGrZUFQanzW1yCQoAUdkr2we5Uc4OlvxOysftiQ9AfMk9Z7202S07PW+e9FOTknFkpYYfo0I1LuQ+tPJwfzyNrJdiIgfoxt+PfNXI0C+ZuL7UAHwrn94F2i1Wi8tSKV5uekycZ4M6WM1TXBsDyebNe7o9cpJgC/nVxWuCUHf5nem5dO/7YmJyPsw1JtV2ziaOqVH9zIDWuBVvkYF4QxPKCteju2ZLHO8fdGpp/kPLfnk2P3eUBQ13IxyF5fIvGlkrpSxAiFLsVf7T+/17xknHn2r35ABiIaIBl2UjJ7uo6UfuPVNYKfRzGnNFn5p2s6AOINstaJvmTywSmlEA0vapXo0sHl7hgmORZYuRIgwEc5bUQZ4Jt9HLM5ltVLlApuH9qtmJeZbykqOeOx0ZbGtjyRQSa2JolJR6++MM+q7pc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVVqOWsxSE9HalpKK0pFMnNhQVd4TUpMeUcwU3Z1QXR2akRNT1RpcmVmQTdp?=
 =?utf-8?B?azJtVU9mbjZsdDFMbnYxMnQwMGZYUy9QdXJZWTl1TlhKVEZBbTVESjgzNGhJ?=
 =?utf-8?B?REdHcExLeHhxektpQjkxV3dzcHBtMkRCbUgvSkR1bjNibDlYbXdhY1haVFhY?=
 =?utf-8?B?L1RwdkdyNWtxVzFHdUVFQWV4UWxKYjFDM3ZCZ2Rzc0EzdFBscmtPb0V4Qk1R?=
 =?utf-8?B?Rys5REppejI0MmtyUVNWcXhYaWRFOXhQVWk0aDlsdEI4bUc2ek40NkVORThh?=
 =?utf-8?B?VTliY3BidFV0NWp2c2hXaE5NUDJqaXo4OFpkYjNZcllSbTZMaUZKSHgzRVpv?=
 =?utf-8?B?SEpTZzJxQ3BXOU5Jbkh0TXgrZzE4TXI2VVNLNnY1d0VkbGVrRWcvczlhSTha?=
 =?utf-8?B?OXdNaXhqZTZ0bWh0ZjZ1OGR5MGREb2drN25JVmRjQmVoeGpldVhhNGk5dVFm?=
 =?utf-8?B?YWtRRkdXUi9WZHpNb0lSck5YUmlhblp4eVJzaTZEQlNYL0s0dklYYktnN1Fa?=
 =?utf-8?B?aHRzU2NBbGwyUmFRYWxiNmdkTDhTY3Y2Um1EK29XWnhCdXR1bGRYWUdDcXMy?=
 =?utf-8?B?VVg0bEZLUWZTZFZPN1VNUGcwTUNKdm9DQlB1VHJyNmg2dnhqL2ZhUDZiN2lr?=
 =?utf-8?B?OS9xWUVDZGJRUTlhR3pQbkNrTzhObTMxNjlXblhhUU9rQVBESVE1ME54RGIv?=
 =?utf-8?B?OTRNdVJUSGNDeXR5NXBXa05PYlJtSCtBVkRFZTRQbWlnd05CSzlyOVlGcVZL?=
 =?utf-8?B?RElDTEFacjNXVUZJMFE0VkFyWi9wN2pNWEFOc0NRVXgyR2lra1dGRGppSXFa?=
 =?utf-8?B?NmFZU05NQ1h1aUlrMXhwZ1AxM1NkMXRhcDZ5NTBwUUora2Z3Q3JwWDBrK0x2?=
 =?utf-8?B?Uld6aUFQMDRTUmVDUzlBOFBPZGJreno1S05yeDlkSjVDTExTWG1NeHpxWUQ1?=
 =?utf-8?B?WHYvRVU0YWFrQ1JvdlNFVERGR3hoR0hSZlRrbFJBVVZnSHl2d2g0SHd1VDQy?=
 =?utf-8?B?YlMyRjVZUkxPVVowNXVrYyt4cFY5ZlhCU3VYdVdoOFlkL2k4MUZYRkx4RDlz?=
 =?utf-8?B?bmF4RHFIRUdxU29jV2NzbDVod1kxRzRlNU5YUkxzK3VXRFV5WDIxWUw4Rkw0?=
 =?utf-8?B?ZjRJcEEwSkJybVl6eWNhV0c2anJTb3licEY4TUhGbXBSY1NhSTd2RW5PNXRH?=
 =?utf-8?B?cmtYZndpeUczZHVGK0FsMTZpNzdhcW11bFRzS3hhNWk4UFV2YjVCMkZlUEww?=
 =?utf-8?B?Y0pkTzhQV3JrbmZMRVBGWFZ6cW11MGtzUDNad1krVjVtbmlzV1hIWWVPNVVO?=
 =?utf-8?B?dUJVUnQrbW10OVp6MXFXZEl5L3pEWkl4TU4vSk4zSk43Q2VLUC9Bd0FmcnZk?=
 =?utf-8?B?YnFGTVhUcmw0aUF0elNUMDhjVHUzdUhicXJleVhHdW44OEYreHhqeVRIemlE?=
 =?utf-8?B?YWxOYk9QYkgvV1dGRU5kUEdEZ3NSOWcySkJFWWltRkVjekN0SmNBcGcwMlpY?=
 =?utf-8?B?SmttbEpQVERPR1E0a05WMEw3NVNDbyttcGMwbVlnalNCOE8vcThnbHVjMzdW?=
 =?utf-8?B?NjliL2VUbGYvNkZiZXFIQ1dNRXptV3JLandpamo1cU5CbUY4RDIyT1U5UXRm?=
 =?utf-8?B?VVhSZFZIdGNEdUZ5bzdrYUFqeVFpNVZZVGlpaWZYQVVXMzBYQy93RGhxczR4?=
 =?utf-8?B?SG8rNmFiUHh1UWZ5NUlGZkVUTW5odlgvRndZV3lEZG9sdE9xUGU2WlErOWhJ?=
 =?utf-8?B?WXVKdnliTHo1VndLSHN0L0srS0ppeWh6alArWjhKOERGWkpsd1NscWhhbmpV?=
 =?utf-8?B?dm4xTWVmMk1DWjNoMUFsOU9lMHBJcm1ueHg5VlZGTnZtSy9aaU1RNzM3RGs1?=
 =?utf-8?B?ZWdDSVVNcVRHYWJlL2ZIMWpaeWorOW9mMFBrSFhKelJWSUhURUY3TUhVenc2?=
 =?utf-8?B?c2JhcXU2OE50RzErQzVCcWRRelJOM1BWOWNZUjNNcHhoYllIOWlBQ1B6RnRs?=
 =?utf-8?B?SGZKekNKaDgxUlV2ZFMxL2I0aC9qN281NjErR3YrVnZ3SHAzU0NTbUhlQ0lX?=
 =?utf-8?B?MXV1bUI3b3BzZDJxVk9VR1NRTlYzNFRudVA1Z25kalZLQXVCNUtmUlJFSER3?=
 =?utf-8?B?bzRsZGZTcmJaYmRpcnZwM3ozVVFJVk45eWN3ZjJna1FXSFZhbUhUOExKYURI?=
 =?utf-8?B?NjVBM254eUZaMG4wM043b0NjUDFWS0pxMDZmaTMwdnJjZ1QrdVk2aVJuYWIy?=
 =?utf-8?B?Q3pUM0UxY3JEVFpNcUNqYjU4S3pzSlZXOUF4aXpoazliQUFUR0VhTHMyU0J4?=
 =?utf-8?Q?b+kbXsk4M3wE+5m+Od?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78271026-d54f-432d-3dc9-08df0204a448
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:25:07.1651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdEXsM3l0gdHS5JLG8Tb/EBvSzU+pbEJfyc62Qhq5X14UZKHO+mrqG7MBHS0PZC3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

On Mon, 27 Jul 2026 13:29:00 +0000, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
> AMD vIOMMU requires programming the DTE of the IOMMU device ID to set up
> IPA mapping, and current DTE helper functions (for setting / clearing)
> require struct iommu_dev_data.
> 
> However, the IOMMU device does not go through the normal PCI device attach
> path, which would allocate the struct iommu_dev_data. So, the driver needs
> to manually allocate and initialize the struct iommu_dev_data for IOMMU
> in order to reuse the helper functions.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
