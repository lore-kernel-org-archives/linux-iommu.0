Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ECB3EB0FE
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435433; cv=fail; b=ggfi8/9HsBBZsULAMpRopPnYjn3tEdKLtEBwKYeQXz/sV5bkgYnmnN3gqtdUnctJ2CqP+G6yFXrzW/JDJhWOQ/eW7v/P9VSraFVM9fSTjHVs7JFw33cE1R7H+0UQKwtP6JiFeiBm8OIJF86T/6GcXBaTMyBa93835ZAnoSvZPz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435433; c=relaxed/simple;
	bh=AxxSNzl0PR2FRNeKRvUendfWeeTdDsEJCZXgTmQEySs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ENahdmz+RQx/sqUkUvqxbLCTjdMol/ANbEFvf9G+MtZxWo7yiGEwkA8CxtpwwoTf6sRG3ZNaoFqT1V41j5DMxeLTeMts5jrl50jyPRas+yKCCKkrK9vWfX+ikzibOm3lNc5eO8K0ahDyeXbov/oqinIueRtm4tqxmY+3Otn2FkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HqJUpYmS; arc=fail smtp.client-ip=52.101.57.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HqJUpYmS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdjvZOlQwOD6nhFkboP6m60h8IGI1NY6mPqgPD3R9r0yChmnt8jDhxotaYlr2xcD/YbYemSRXa4gvsMlX0HDcjR9XKAbT3tFqkgZRCsnxvj6XYmtxw87pglaA5dtbjDmqz5XOCmydJYPJqTcCplyV9MFZRh/gxYUL98npX9mWEjzPmhhrF800PeshXbgZyO/LvUpBISAHwvzxw9ZfYemhpew1aF1FMFpogEUv7HehUNKVlRxY+iUf4OXX0QbHe/UHMPtYhRflYuNWa0DcUGJDfgiOgIhGp1y37/3/KWCdGWXnX+H+s9168IrHwYPPBHszKAdrqmeLen5i1F3+szaeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rO0LsHWHr7ikz54iUnbJigDtQeQ8cqX9bHU2BT/tdk=;
 b=o4P+MCkvxUwsD7knIbOueUwAk9I17rov0QdND8b/EYh/LlrWsEFjwrqGuah4ncp6MyBQc+f5WP+JNi/hAvlajJqMwBShudQqCtPm0nDSRCZ4G15R9GE1oNjBuHP1qSLXyJH4HlGdZ279wKgNnCpfx7ftrSys502CNSqdprsS8OBxsuRhetvCWUshJQDQmo2sN3PoJso6FgPxfOafLkTdpvh9VNyr6yHyfIB45jIDp/Dq8VN6Vz6/cJagajV5JkKEtBJnxSN6OAgt0TpwfXHThb9WItk5GZljJb8jdsGi6w51DjP6C0UNJsPVfiILvhE1rb1VDdrS438Xl5udu54beQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rO0LsHWHr7ikz54iUnbJigDtQeQ8cqX9bHU2BT/tdk=;
 b=HqJUpYmSqawcOKtRXH1Iti4m/JqqOd2TV1Ca9bcCDqQyN5kk4luOfybosuFleS0yR5CRQyaHG2HEosK/CSChaEu/ZHzuwXVF1hjK6a/b8RUC8uAXs9wt129EaBMwLlFsfQx2RIzI/Pk+X78cgi0LSnbmpIDHp3rrCgSF0gbx+RQhNx9Ckn+FcCuiJ70Pj9qTxMqK6nuBdvK3vJWIOIUzDqNYZJBsund3kWpEIMUA0AMjHrZbu5MMwTe4V6sGEDF3xQHT9v3Cqndg4mAvWug3Q58Iw+ph1t/BSqMnI/5P9e+3hpTOb6iYL9faUphpAo+pmP84ZnfLv9hs4lNTp59kpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 14:43:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 14:43:48 +0000
Date: Tue, 7 Jul 2026 11:43:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v3 21/22] iommu/amd: Add translation DTE and VFctrl
 TransDevID helpers
Message-ID: <20260707144346.GI220801@nvidia.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-22-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629153535.15775-22-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4P288CA0012.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2e2029-cce9-48d8-7cb9-08dedc362766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XQHZnM5mkY7ctM9rrUpM+7c+gYy+Zn0/L+V58yr5PinxGnE3RI3+oK0W43UDz8yOhmhiKZ7Cj0HObFRW+4a67nXy/OtmOOqGHiWu1Kj0uQioKxR2MqT54I3p/oXUAXfdpjQoFy7oLBTdxpXKMy6addSmetOF40qFSvQV+52S+KhM9n6LP244oxOUjKgrvEPnE7oLLujudF9omQsd5bTPrVtDEoquZgt+EhPluv0Tdk/oK7ggxX6RfHlqpp5gdFSXxw3BnsjUf3czD8QyaszmljEbzjfp1z1ppfqkxcM1my2NnpsPJpaA7iWbPQsdt3Hahp82q3BDTAP5Ufx7KbzGLfb6PT/FndELQTP3u9In+MFOr3toLNL/fu+KUDfEVriwsDI0ns4mch3mzh3cvmRK+uKHrTrNnwHprL8RoO23OUDoJkDO0jSIs1H8bFrChTl2MZq7GZPz9dfoB9yq0q4d9q2SQa0SNc/rYU1GHPv2hXPsOVlKF/I8m3zHAWeS8obrU2G2hMFVc8gAE+rSXaVln5A/3Vm6g3OoImztCXdnB03DnoRYJfQN1QFxhLjVzPrY5bVLaxD1A+Dk4vWj890B2LYI1xtHqg7GE4aHAhOj2NFi3XPY7r/wKZ8btPXq90b8oLXij3tdmEodL1kqWzJuOkQ+z+t8jeFOOeHn/anAnqY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SzPTGrxkA2CRUsROdM3Mi//daIghFW71pB60pntxb+KtBSbSBaKe6aWNPvw+?=
 =?us-ascii?Q?ESAdzVBnGNvX3xyc3E04+CIDhyCecuf/vzhRHnwMNqK4aE3a6cJOp++3UTbJ?=
 =?us-ascii?Q?eSRxnuCc+ro4cJuZyWHgTrImbEVj3X7DbSGDdyPD3oBWubuPB0fhzQO4Mhuo?=
 =?us-ascii?Q?jFsotTyeYpQUTWK0LwleFDlvPCnid2Iulruoc2rfs0FXYlj6YVyCTPhf4ntD?=
 =?us-ascii?Q?QShvGNf4X943Lq7/0j3dEagpdrSQSQzLnla+r3xVYWeTT7LDPHI3HbvTTuAE?=
 =?us-ascii?Q?MJYPO0Y1zv1QPvJnH0BbIFV5Md3WXHTp2qFpy0tL1hjCy9nmaP9JMeC9lg/f?=
 =?us-ascii?Q?L6YisLsU0g6cLu0qLWBLPvTaoeq+yEVhiwETArKtn+CXLdMq/aUlh3oozUiF?=
 =?us-ascii?Q?U0Zb3yYGiE8co2NCT+o2ZsGlRHBZswzfBF7DIwcazXN8y14fl724uk9ZJyze?=
 =?us-ascii?Q?HosZPkRmOOSBXJa+wNrgcSLucVrLtztXYD8HXYHWFCG4kS5gJCEvI6Kf4rYD?=
 =?us-ascii?Q?lzYRFS0CfqODMlLnHpI2OGCjFy5xUwFACcVoDDupI4zDAYcLFt1nendPssZ4?=
 =?us-ascii?Q?8sp/krmiVIki76aOy0Go6NFrulw6afZrQB4olbax4PurwltW7q9ruhkfX6bG?=
 =?us-ascii?Q?jzD78u+RHjs8Pwu4rYazfR6pdPYvotged7ZKNNK4uUG0Zi0T1sYekpxjOItX?=
 =?us-ascii?Q?z04s5+uoJcv4gslnJfqxunaJKzUbzdYMmmEbr7dE+3Rh7n4zo9bTIb7YJkPT?=
 =?us-ascii?Q?/pir6XM769ztQNa4bY1O6nRk2vdo2pAgyuwS39VoaBsUdxLrSWgImk6a2c7Y?=
 =?us-ascii?Q?nm+0k6MD9/BvQAjxPjWnbKbT/7WeHHFkq4nSzSyICoL76scv3BxPepwX3Rgd?=
 =?us-ascii?Q?AajZH4UBgHTiRXpUPR+/iSlw2S7RPopfqU5HM4UPAXqaDGTurDTgch/mKDsu?=
 =?us-ascii?Q?pURqBVgyPaGV24sHGytOCQlxO/6lEdEILrjw9ek4wdZJ7pYflUfn9BNgxuEr?=
 =?us-ascii?Q?ir6f1SiUllKis5vBKxm/nl3s8d7bUdevmc0H3jQaBuKrCCY230uttRTWiMPs?=
 =?us-ascii?Q?g0IQ0x4A8Fd2XZwz4AemaCTDdBt9/NAjrV7bs4G0YD1X/OoKY0ShynJZNVOc?=
 =?us-ascii?Q?GnYMFHtW6Fv6dBx6MLUwqAGCAyDXUIZtre92jCFXxACmDh07XFmwEk+QRBuT?=
 =?us-ascii?Q?dNNY13jXAYYL9p+GcBD115c/nCSa9dWnZpf9J9hMeTgucX5CRdH1hE85kqRe?=
 =?us-ascii?Q?71BV7XTkmu9TEQZ/heLN/CAzUcFpqcFnwBezdSnBfirVpzusDXhB81Wd8la7?=
 =?us-ascii?Q?N0NDp2qIpNEgqCUj/jxa/3DUd8MSLMffNexxKossD3CP4/XrJx4s6Aaqfbpg?=
 =?us-ascii?Q?/AIwKHr3Ipa2WmQCSnlxBbcxDUt8KgiBlpdPlg+BBYNdgSqGgxZE7YXsMF6U?=
 =?us-ascii?Q?OWe1XWkg221a5iOeQywnWZ4MY1AjsjnYfNvatOrTkns4GzmznUnyeA6bpUpA?=
 =?us-ascii?Q?CmI3fC1NpGivDzESkL1J6v9o0lC3H1YyJARRXVkz44fZdvzWQVnbxcWLYauG?=
 =?us-ascii?Q?2TY6Waj1Kd4UD+cqg5y/qU8RHzZRms9uyZkXKDPI5GF5Zdup2OwJTO9RQphA?=
 =?us-ascii?Q?TT6RIiQ+xmTRiFYPz+sdb4/UUgvKH6rBzD40npQ8SMyAUFMKtPw7q4p1WwEa?=
 =?us-ascii?Q?1QpspW2WWnOLkLmsSVPiRypRkSgGVXR6PxF3Hpu/zp27HopD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2e2029-cce9-48d8-7cb9-08dedc362766
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:43:48.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBtYfhaR4NWgUY9EHX7/8leMaXpz5c7c90H0Kv5nlTqF52iEv5yoYzu4sEtHyq/h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749

On Mon, Jun 29, 2026 at 03:35:34PM +0000, Suravee Suthikulpanit wrote:
> The hardware vIOMMU uses a per-VM translate device ID (TransDevID)
> to

per-viommu, the iommu drivers don't work with the concept of VM.

> index the host device table when guest IOMMU traffic needs GPA->SPA
> translation.  The VF Control guest miscellaneous register tells the
> IOMMU which TransDevID to use; the corresponding device table entry
> (DTE) points at the nested IOMMU v1 page table that performs the walk
> from guest physical to system physical addresses.

A v1 page table is a "parent" not a nested

> @@ -213,7 +213,12 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
>  			     struct dev_table_entry *new)
>  {
>  	update_dte256(iommu, dev_data, new);
> -	clone_aliases(iommu, dev_data->dev);
> +	/*
> +	 * The dev_data for trans_devid does not have struct dev.
> +	 * So clone_aliases is not supported for translate-device-id.
> +	 */
> +	if (dev_data->dev)
> +		clone_aliases(iommu, dev_data->dev);

More junk from the ugly alias scheme :\ Maybe you should fix it

> +int amd_iommu_set_translate_dte(struct amd_iommu *iommu,
> +				 struct protection_domain *pdom,
> +				 u16 gid, u32 trans_devid)
> +{

This should probably accept a viommu struct instead of all these arguments.

Jason
