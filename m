Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7BB111A1
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656446; cv=fail; b=pbVldRgY8ATegllX6x5oltXm45WUSYtQGEghZNFJcqkEDV7GZ7MVRsrtHSIOFQzz965T91PTlXbVD3Vsy8WsFDM9EQLCMkQDJ2sCnKeUUGl9RXqJo7nKF6xixQaiHmTl+HS1/NsUf6A3NLidJNvvppssUl0EyyaUmuIIfczm2Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656446; c=relaxed/simple;
	bh=aBsswLD+hGikPdXI68EJVnG941TfzOZ9H8gyTll3I94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JWQYoMWHddgyyNP9+SUc6SUMt/Egm6AZg+tl3Swr65ybXudRKOaj985FBGQsDZjsQamO2aPCEofzgEH2gnHUNulR6vipi7gjK21P3HdDtduA0wzkBu9Nj5kMaFrwjvLaKsU4GF0QEEx8mS1IQWkjoStoeLBiVUcS3PDylcLMj3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pzPYvgve; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pzPYvgve"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5F7cHiPdgHd9g97cxoAO48Yekb3p9+FFFbwufw1u/4qmODNDUNicQuNIMbG39+ZS5zqhlsY3+dqTjOUUuhL9d3PPYRIu62RUYsR2mUep5Z2R0KZ6VxzfyYDOWqVPE/+HuP0Tx/TR+4lG8czvslmuLsv72wTobu/sHjgikST9YOgKqIKyYNH3mjiTVVEjeCckgmLcqjzq6wT+o0302/PaEhLeMLFMdBI5VTdbyV/zUFd76iIMVOJfptYnW7/kxg41kHRw/Jcmtv5h9V7d4lcKk5Z0Is9YZ5BvsZ6UVgGlkSwMHoaP3U8/D2TD1/Wk2zN9oc5bqKbhfV+X5ZdUsISyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPm4gqqBVgv0dFun86CrtufqE5ZJsuvJy1TzFSNdjos=;
 b=R+cnfZUhspm2LKjkvGCchlqBPzBfmMMQvMQHa90tIcexgBNVy7bDdqoFmgNYee8xqvN1Uzht/9Fu8KIdxxePRdWNhh7OoWPI+4TsijVfFroDLWc5JUysJxirfLzwB1heNUdwAdfZsvdmxI/0cX7e/JyU1vuRjxEYZE8oDh6qjhdhsV3PDUlk5VCOUr6B3tbPyc9O4c99AjJ9woC7Zq5hKS9OsyXztJyBV7HFk/MgtWRkhsGWRebxuDLMLdF5WR8cqRLK6dKB26zLLF+ha0moTWl96/fk3832OhjV6kqF/QP5KQwmxyGnYzBprk3oqrZFu9e7TuULQNXR7a4hItAn9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPm4gqqBVgv0dFun86CrtufqE5ZJsuvJy1TzFSNdjos=;
 b=pzPYvgvemsjs5qMLaiqQmA+Ztffi8BCMHte2rxBPnRODr8qKVysvijX5t9ymyJUBy+IMM24FP6ndKxZgiNqlOmSvyMuNoTp8aFcMKuPfDa4CF2Vt++VQHC916Bm+Um2Nha5nyw4phPbCrNqmLEYmmHwo+VPyzfhoVLAOyirMHEEEUpB5acfZtFER4RtK1YHvW9lJIeItJoIJqwdDfmu16uwGuEIPEnbBEBCPLMxZ2b+WF/2yU3caoWPUnVEw1YVCkwPkkzZmehQUCHNgNMh6XJvAlc0jphX65MNBuNtuL4gQAJaxc3pZn6k4kxqfVYfwztBQzv1gA0Ab1zXALatSVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 17:27:19 +0000
Received: from DM4PR12MB7767.namprd12.prod.outlook.com
 ([fe80::55c8:54a0:23b5:3e52]) by DM4PR12MB7767.namprd12.prod.outlook.com
 ([fe80::55c8:54a0:23b5:3e52%3]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 17:27:19 +0000
Date: Wed, 14 Aug 2024 14:27:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 4/9] iommu/arm-smmu-v3: Pass in cmdq pointer to
 arm_smmu_cmdq_init
Message-ID: <20240814172718.GU2032816@nvidia.com>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <b59ddbb8e30303704fa054875162f1280c9512dd.1722993435.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b59ddbb8e30303704fa054875162f1280c9512dd.1722993435.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAP220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::19) To DM4PR12MB7767.namprd12.prod.outlook.com
 (2603:10b6:8:100::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7767:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b91e55b-1e6b-40d6-4ed6-08dcbc86599f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZjpLiqR2LVWGZlV2IX/f/6GxZyDXW3lZlRsa7bAQ1RELDP79ztnsQs07CQYh?=
 =?us-ascii?Q?WQdETHYyaj4OvdZjmI0JdN3suX7XbR0Dp08V260ZDWN5G0cKlyxBNIoD5lWg?=
 =?us-ascii?Q?xWEW2JdSiPIFoJdkrhPmJ+dW/gcdo4tRGB39V8gk+HlP+TRorwM2q7jNz1pa?=
 =?us-ascii?Q?oiPYzwnHvSj7a89Fi/PBzDkcaav8nW76Evn/XokcFnk54b/0+qDl8HkYDBpH?=
 =?us-ascii?Q?XO/LNZpuRSuE1L0QaZlUr/E94FPhx9alvN8Gk0vMfNHfautP0q3Lcbz7HZYl?=
 =?us-ascii?Q?iy79Vtn0v2NYExD9phWuDDjTC1SKIzQgl61ZlxsTPt/UZVAwMT5OThydcX7N?=
 =?us-ascii?Q?Y+9YD0F7MnoCK+3bxRiAJZReZjRXOlpIP2yk67X2EfghBCE2Uib0V+nYD2w9?=
 =?us-ascii?Q?fwE2RJcx94dSJPB7BONOVG8F6nP1kGcA6IzIBX/7zoR7Hp8LwxDrmGqGhC+8?=
 =?us-ascii?Q?0ICwCFFcH2DRTTBGXKjEM3QNXdmnVFm5nq+jCtY0YcfIyKdhLgE87OcF7Zai?=
 =?us-ascii?Q?QDxhueOOPq2Ef17YoRufPEr8GrkWHcoVS5NbhnDnBdv+936MHhEPd+hbHsfG?=
 =?us-ascii?Q?2LXhVE6uV+VKlpGDwB+73Ck/tGrvFEpqFfstJFrFKGcnwdNrCULL6v4PVUs6?=
 =?us-ascii?Q?AqkGcTRtz3DsywGnTUe4fWc0Sb1v3Fy91N8Dt7iZjqhMDM9XKXCqma+IFrSS?=
 =?us-ascii?Q?D6ELwqMYLDzoCx1+1tc4UoS5uepY7K6f5wcMo2ShFoz+H3J0X0SQUJFCf6EW?=
 =?us-ascii?Q?8RihMphqCiNQVK5o8srQgd7RImLAhBN25lGQG9dkVLQXVLEKvQAyaCwTsl5E?=
 =?us-ascii?Q?UgVcWTEYAgvs4RwtrGZkYR/8aNUxx/cbbLI8h0U1PrG64pnv/tPo6ey36F7p?=
 =?us-ascii?Q?z8/+LwKrYuuUXAQWC3kLoqTTap4RC21fiUhsmV7Hlii2aamHq+NL2EV87YD9?=
 =?us-ascii?Q?UG7/TxT5/zcv7YcRUWpGu+2is/n+c8WflgEOs2G7eOLs6+FtQuA7Jq31cXSS?=
 =?us-ascii?Q?+z9kP6iQm/wH4YtrLcCI99T/ThGKTf112NBl4I/3xkbM2iAQEV0YrMBuMwB8?=
 =?us-ascii?Q?2Qq/wLOC+z5BHL5/onajOm+ZKz9Arbf0oCmZcfOwcohToq9AZNhYcGg37mYM?=
 =?us-ascii?Q?yezXIgLpyXDiaTnB2RH1q9fo68ns6zfW73gAchsCumWpgrRLAhpriPKw1YBt?=
 =?us-ascii?Q?N+Z1J+fcn1xCeARzp93zVTeFnZkVl6ypfXMDujgXrKvLkLoNj/s0uLx6nJy2?=
 =?us-ascii?Q?0R/4LuzQET8sRe7Rpe3Tsa1K1ckfUO27slStEy2WbMRedOOOT/n52G2DF5py?=
 =?us-ascii?Q?hSRRgA5d+TPHvNjXW/zvjH9bJ3zfY+URNUtspL/7XkKKJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TEdjCGhtiF/Vev3VFsGDYjSSXOrlPSCumakUdu3CDmDcQzhu8we20oFKy3oa?=
 =?us-ascii?Q?uIQmDS3+yIofywxflR33JLXNsJD6CdRV2sBYNpP8Pg8pNVfsfREAtBPTdI5v?=
 =?us-ascii?Q?vUB+7lDN+wJwwp/RZax4TH3hoqpusRSt0445CrDUZtQ08bLxa8YYRxmtYyHA?=
 =?us-ascii?Q?JFgSmihGfw8qrHPXa8fUtfnTx7EaxcXYr9IvvdYi9uzbrbrH4eKguXkwTGY6?=
 =?us-ascii?Q?CMJ3SSA3Xc1dNIm5uq/jUpQFmdFSK7GJx0jZPQWUrXyHwMhTgLzhduB6kRkp?=
 =?us-ascii?Q?eS/XYlZD4YVHP8aTBkVA66yi6y0j0h0E+fjESWn0j8Wqg8C488c1YWCKNYg8?=
 =?us-ascii?Q?f9f0RVn4HCtesI0PPcw1tAacEaZM0da9jo3K5gDZmEBrXE5SGdl0ZHKV1720?=
 =?us-ascii?Q?Vqe3ikD4PSh2P/CbzWoJ6ZkbnLNH6ub6obdEKaG/6kRVojbOWz3OXv441b4d?=
 =?us-ascii?Q?nnBl5+Z2C2sZVm9tlc25FpbdLe1K9OOuIL0LceVP8nvihk9HSk7i/otIq8Hs?=
 =?us-ascii?Q?X2NI48AixqfOtIRkD24GaMWoeG7NiDiPsH/pnkziEnA+3SM1My0mefqdlCEZ?=
 =?us-ascii?Q?mX+FZctX3hXonW0dFuwAB3vOudA7c+DYEr4UI+dtUl/KeQ2oGxkGLcEowJ73?=
 =?us-ascii?Q?UjlC0vYuSkTMcezKgOQ38WYAjATt9eDiumOgoTZ2hMbXAF5LkevOVCw/MQ3W?=
 =?us-ascii?Q?xC8mPBorw5ZkQkYToeOTQMSXXL7ZZ3OUAKheRJxEWJbxptFX1GfAWRX85Dl6?=
 =?us-ascii?Q?9/+qzryPdsLmby4fEKCZMCOd1So2QB+5/22YhAM4E0k0uMm727/GLf1pgagc?=
 =?us-ascii?Q?MEMzaX1HulXI0SjlMurOpAuqs+IhhRywtxWAqzR09Jo8FraLosyXpxiWLw7K?=
 =?us-ascii?Q?X0iZrftoTyD6PQ+jAcYYN3f9J/N9mP/9Ju7MyMnJDExnyAhIxcnXbum2LaWu?=
 =?us-ascii?Q?KV4n5DEeJeiAJEf2mg5quN7NNltKzBsIlLShB6Vet2E/W2t2oeqgeMOofyTs?=
 =?us-ascii?Q?bwDppbFFK9CC5AZfs7/HuQrYHM63SG/b4CazGxVkdGp51U72KHwMsYco1x8J?=
 =?us-ascii?Q?KagkCiKGGmGZL9h+abH9rYmpYdnU7rl86E3M2TABhXjCvZCjtT4QlzaaBzK1?=
 =?us-ascii?Q?qqMlTZNFHXdmXXxdFP4sQsbfFkygWors91obFboaEPV10GGTAmHq9gk1sZ6F?=
 =?us-ascii?Q?KZ71aTeMJG643Mb4HYJK1v1xmujsV2eJeKXA/RbEApCKrwP8LfujYKOGOclv?=
 =?us-ascii?Q?yX5jv2N0HTcJK0QfCBv8cg9XbIIDO9hNYg1ZavQMXIJcW1c+ONW4EL/oAYjf?=
 =?us-ascii?Q?baJhTUahslzn7JQREuB2Mc/hc59OegtGd6yIoNHR2n0Ug+ihp0LR3Na8p1DS?=
 =?us-ascii?Q?Wn3QqUOZdhlhWNtWAWDi0HvqAcpuaX9LfjijjZPd9LBdDBseZAkdajYE0mK+?=
 =?us-ascii?Q?PcSzxZ+QhrK998n3x2g8+CjUcJzb3wn71a8Eprg7mnlrdH3u9Q7CGgRKECb4?=
 =?us-ascii?Q?qXtsNPT+yEzQd83OX51Vk+Uja175IsIADUGKMee3W23hsoc0SMgtslOexDGo?=
 =?us-ascii?Q?azUmycr+7YlAv2Wdmg27ft4fwfGL6hTNjp/VJhgm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b91e55b-1e6b-40d6-4ed6-08dcbc86599f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 17:27:19.6057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xUkox6vpLE0O8UilGUO/mZQYqXlwTy3VYBTWy0onAfwQp20oPwMHFYuEBFOWMjH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313

On Tue, Aug 06, 2024 at 07:11:49PM -0700, Nicolin Chen wrote:
> So that this function can be used by other cmdqs than &smmu->cmdq only.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
