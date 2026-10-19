Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541E24AAC66
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409413; cv=fail; b=MjwWnKOUyCCsvWYXbjALREpseYummNJphcUMMF/9jyd6DeQX5HKMtA3S23aPmU6zKfKziLEKkLbJ2ag+r3920E7R9btSAiAvrw9OeAtaNlt5SClFLR/kSH7Gu4gmYXFuc6TV20Q6DWSGI5osJSoPtjYIWS9ZpCdn82nQWZM7KnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409413; c=relaxed/simple;
	bh=2Y17Y+cFoxgoA/U/dfwbdvxSewrMQ6ZCbljFOh/6HwE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P4U3i1pMnQ/7Km1S2MyEjKQwwmQ6Ylcz3/OF1R6EW5UOoNXZkjPEj68MWl9XGiwbEzUyWJstFZpLbeiF7HWZvPbCDLnUADdIEOqNsHdkcxEOi81l7NkM6fbwSgrlr6cYs3DxqD1BSPMRN6HRiMIAm06tJgswbVyxfxik/n8dDAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cDMFBs2h; arc=fail smtp.client-ip=52.101.61.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cDMFBs2h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMWLtrrD9gMDBNSLxc6dCovPcbTtGZjYk1ZuNz/WFWzqsJr8RSo6m4sZnMyjInNsEsE/TuRnRGcLA9eQ2YCRT5hjTTFAHcNVwzRPigS1kcRd/AVi3KQWbizM7rsRKA9mrWWwH1uIvIXoK+Ilob98dZ9vEq8vCaa/sc/JFZ8JSTed+EYX+QsZAjrmZ2mv9Akk6m1sDxy3GT3WivYzKwo8A2BcmAqs99nOZY1iMlQTs/o/r1LIuynDcgB17I5W3XsCzHak1b061IxppladUpHOwu1wDNhUEqFwhFV3+P9a0cMbz9p3pZGE9SyL9O14rhkflNCAN121Rnlx3sZFrj3iQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCIP6MflMKeSwZzW0KQFSECURaVvFqh4GVkdY9rF+aU=;
 b=KX6dax90FkQjLQoId30uX3no6b8Ve7JvYa6RZZup6PGfzqqd6DI1d1P1SXRMlKzn72pbtLe9jLqpFIWu/RU2PYWch0bZ+3s8cx0HH1CGb/OEokGJ+7GrKE7R9GZtrY3ovuzo7twZP/4pnKAqscq+be/ZDmZ/I32HqyW7SbFkZ3jE8j2YHg7rhaNMHLydAa9zgav/NtuFkDKyDBfaua2rHOC+DQYt+bxWKl/oqpL5V9jaIi//lfLPQlUYcieGdE/XDWnjGYyT8Ku9zv3ed3liymbEcFGUzObr4vFM5izkqHdITZ808Mkx3asbCzNQ14woBDUB6czFXVcAzYyCfgxPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCIP6MflMKeSwZzW0KQFSECURaVvFqh4GVkdY9rF+aU=;
 b=cDMFBs2hxJotzisO+0T16OpzaHnUTg5ZL9XyrANvWF7OPOn8gCYRayCWMLwGEuxZPlV1hxfNm0H+l+fRjbboX8YsQTxFvzTj6Cu/lHiParJMmKivanqWkuYoEuJLH+7BqLT6wd4aF9sm9x5A3q+XsTusyVKtX1V9YnB8u3Lme9c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:28:20 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:28:19 +0000
Message-ID: <3eae322b-1fee-4994-bb9b-ab30ec45e7e5@amd.com>
Date: Mon, 19 Oct 2026 16:58:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/24] iommu/amd: Map vIOMMU VF and VF Control MMIO
 BARs
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org,
 wvw@google.com, wnliu@google.com, dantuluris@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com,
 guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-7-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930092344.5616-7-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0211.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::12) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 456e9513-eb07-45af-a1d1-08df2dd413ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|10067099003|22082099003|4143699003|261009223027099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kDDXiTNbzjIwhpZKA1BDTsEk6TaFD88SmTNBlFza4IvfC065IPXHq+0EjmqzHTNMUIS/KlvdWmMdFT2N9beAk5WHF22sAE+KxwX4NQQhBahqSkPW6Aqhq5pOFUJGCqU0icGl4lsBySNlNqNa727NrIccZSzEJ2hg0pXcmYVgPPYDd5oQl/xr+pR5Osvk9nl1mDEcYJgVq8R1QJGV7QafjSTTAhmwv9ixtLTbaFbDJ2lVp6mQ8eRZwGC80S3hJq45cpR5O+nmyzno7QtgBpZGuAOeVevPOs2b0T9ADXaWUA3nuxt5vWK9BJup09/ug6cjcJh1nPExNREHgSklR9pCMdB5bjPkdUbeoCUV5nS4x2kI59dexbmnYb+go868ANaQsOa+LcMvIOjAnI9V2vlNHiXkynipnXYXtkErfeaLJUvMw/5wxesO8UWj8jd7jrRi/oI7LkvFWjfkXPV9bB6WSPqmGKDJIChcVcMWzZM8Tp4ixb2ilmkR4iY9szCq/DGldFlSCimkMos5MwVMVo0rHS4vScUArQBRZcfPSh6Y6EnQpq//W2njttHGxLDMwDXy/1nbs+D9Owax9FUBEEK2DPfhfQLUJB1ipfA+UhYcSihD+6m/kZbQ6+taOrGJHGfg4sKb+FAlnBtrzouYEqztRQzY4uu+xPHz+3W4CIZRblc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEladWdxQ3oyV2ZQcXMvMkNQemJ2KzNXeW10Z3pNK3lHdzA4aWdLYjh4dFU0?=
 =?utf-8?B?Q2g1TENJZnFnbFlMOHBMdSt4SlNSbEQwK2tJUHpRSGxVemJUdEMyQXNwVFRL?=
 =?utf-8?B?STlySVlxVEU2cDFyeCtCcW9WbE1NbW5SUGNZUm9xQys0VGhERXBnZzdvZU1L?=
 =?utf-8?B?OFY2OWpjODBGRkVBS00yVFlINFFhbEhZWi9PWDNnVnBJTU5odVBBUFpJK01M?=
 =?utf-8?B?V1FpUTRqYUxWK3BKSUg0NkVpOHF2Qk5SZ01IamdrVDJYZy9tU0RENUVzcEpu?=
 =?utf-8?B?VEVwb0Uvakl1bDBrYjRDZkJSM3l6MmhRamkva2FSbW1HMGNoVGxpVXEyd202?=
 =?utf-8?B?bGVaVzNxZlpQeC9iVVh0YWdCK0MwVGUvellBa3Bsa3REdDdwbkNsY3VVOXJQ?=
 =?utf-8?B?T3ZPUEdaWTJ2ZTFzYkdvK3dKWHIzZGZRMkRSRWl0QW9pVDdJOThtdGZVSHlU?=
 =?utf-8?B?TXg0NUhpd0xhdVh6VjVRQzREUFhwZURPTjhROVIvOXhRRysrQWpVSVFwU0Zl?=
 =?utf-8?B?aCt4NWQyUno2MzRhNVhYQndNYmY1Y3I0ancrMm84RjNqMzUvU3dSYTZiN3Jt?=
 =?utf-8?B?UCt1UHl1U2tJaGVqeHpEc3d3TkptTURzUEMxaWFkUlh0UE5aaWlsRHQyWkNR?=
 =?utf-8?B?c3FUZzFVNUN4blNmbmRPY3RVdzZkSHhkUkxiYVlzcWtkOTZBS1FLZ3ErVko1?=
 =?utf-8?B?MUNVK01NSFJtaXJHOFlIa3JJeERuNXR6ZlJnUWtuR2tOaE0zNVZvYXBRb09C?=
 =?utf-8?B?QWNpNGNUQmQxZGljVkRzSFZiWEpLNWhpU0RmYTdMcXFWUDRsa3UzeFg2b0lP?=
 =?utf-8?B?TEhub1lvSm5reFFLNU9BRFdwT2p6MU9XU3FwWEJoTndLQkJPR3Z1aWpzTGF5?=
 =?utf-8?B?YkdTTC84RWs4U3R5Vm1JeHg2L1ladFFFeGRMQ3BNNllEd2o4ZFhrVVFMZWVG?=
 =?utf-8?B?Ym1TditCS3hMRXd2WmhkclVvRUpTVjN2c2twbk1kV2V1RWhob05abE83dHFp?=
 =?utf-8?B?Z2FnWVRCYUVMNTB3NlNDNERON1FtK1Y3aGdCd1MrWkNQUCtVdWpwdi9hR1V4?=
 =?utf-8?B?blJaNzA2ZGVlV3BOTVJLR3BmakV0RzZ4Q3JaaTNOSXo0SjQ4TnFvVzlQS05O?=
 =?utf-8?B?alN0R3FnYzlwckhtdFpEY2dyUkhXVTRHeEhHSjczOC9CZ1VDaTVjQmhsWldT?=
 =?utf-8?B?eFcxNGJhR3pIV1F6Q0YvVVQ2NUlFd1VJVmVOaFVNYjY4anBTQk5aU0JZTHky?=
 =?utf-8?B?Mk1WMmp2UG8wWm5Vc0ZtQ3IwcG1yM2xwNkE5VEhmVDVubE83eXNOQnh3SGxB?=
 =?utf-8?B?MGlRUkZmc3RSQmp0YVRsN09SSm4zYjlnMkhqNEVvT1hpOFducHBRbVhUWjMz?=
 =?utf-8?B?SDEyTnNjYVBhenlaWSs3dlY4UkhnM09aYU1sWC9mUURHNC9EQW9kRWdpcmtj?=
 =?utf-8?B?VUkzOGgzZnRmRjMrQXJYaXphSDBqci8yZFdrdGVnY3BJZDZRN1VBcUt5SjZE?=
 =?utf-8?B?cDY1T2UwMTdCL2FCZnlDOU9xaXJaakhBbUhQT2ZQVEo4aGQ2anhneGt4QTZ1?=
 =?utf-8?B?d0x3MndBNkJzY0c2Vm1ZLzJqT1VIY04yaUNQeSszd0ErL3Fmamh5YVRUUktN?=
 =?utf-8?B?Q3d4TUdhZjg1MmVjYmp0ZERpdFZ2c3BQS1Fnck10ODRQK2dZZmZ0UWhGTFRC?=
 =?utf-8?B?em9URGtkWVVHWjhPTnBJbUtuR0pvUU9tZTk5S3Q5WWRQZis1bTNDM0FZQWRq?=
 =?utf-8?B?aUZqcklhMVdyZU9XUDA0SGovRXpVbVN1b05ZdVk5QWpqMlBteWZjYVVvN2lx?=
 =?utf-8?B?YnBvQ2I2WmVkZUw5OUNNNnB3ckZ5ejk4MStEOGlPY3l0ZEN4VXB1c0xtK2NJ?=
 =?utf-8?B?WS9VWU94NzVJQTBwcnBydjN4OVBkMU9lSDNIOTVCYzNPVXA3ejBGNG1ZK3Vy?=
 =?utf-8?B?ZUN1ME5DY0ZrdC9Ya0VaZjNucCt5WnpJVnlUZHc5YUdIeXVwbkJrZUlOdzlr?=
 =?utf-8?B?YzJiMExNSWhhQTJmbWp0TUVwUnVtMGxZZXVhVEdadXdwdHphYldtenFhdGJE?=
 =?utf-8?B?ZFZKQnhpVUxKam1nWmpjWEFVNXkwdjFBeWlHVFVxTE1VWm1oSlg0cWlydlhP?=
 =?utf-8?B?RTFST2drVGxLcjc2MUI0Ykd6T3RlTmZNai9yeTZSRnZraHVzS3hIN2hZRUZF?=
 =?utf-8?B?dFA1Z1JCcm1KenloZEUyOGtaNld5YStnRHBPVW1iVldEYk5jK1RpekJLTldC?=
 =?utf-8?B?WTlzK3RKVVoxRkxjRUNvWTBhaXF4WDVOMGRoUGh4dkJrejBJd25SYUdJWVVG?=
 =?utf-8?Q?I+7Xu1ng8hi30/7vx/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456e9513-eb07-45af-a1d1-08df2dd413ba
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:28:19.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6E8C4n6cFAWDQJC+ghmmgZeIFbed89rwIQvTkIXaS/Rry+0mUBauVD2WRvgwTPHbHJDlxiHimziOercWmo9TdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730



On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
> Enable hardware vIOMMU on an IOMMU by locating its PCI vendor-specific
> capability (VSC), reading the VF and VF Control BAR addresses, and
> mapping them for host access (256MB VF, 4MB VF Control).
> 
> VF Control covers the first 4K of guest IOMMU MMIO (control registers,
> trapped by QEMU). VF MMIO covers the third 4K (virtualized by the
> IOMMU). Per-guest bases use the Guest ID from the previous patch.
> 
> Reject a VSC VF or VF Control BAR that is disabled or decodes to
> physical address zero before mapping MMIO.
> 
> Set AMD_IOMMU_FLAG_VIOMMU_EN after the VF BARs are mapped. Export
> MMIO map helpers. Call amd_viommu_uninit() from IOMMU teardown
> before free_iommu_buffers() so MMIO and the command buffer remain.
> 
> Release the reserved MMIO region if ioremap() fails so VF/VFCTRL map
> errors do not leak request_mem_region() for the life of the machine.
> 
> Skip the host release in iommu_unmap_mmio_space() when mmio_base is
> NULL, so a failed ioremap() is not released twice.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---


.../...

> +
> +	pci_read_config_dword(iommu->dev, vsc + MMIO_VSC_VF_CNTL_BAR_LO_OFFSET, &lo);
> +	pci_read_config_dword(iommu->dev, vsc + MMIO_VSC_VF_CNTL_BAR_HI_OFFSET, &hi);
> +	vf_cntl_phys = hi;
> +	vf_cntl_phys = (vf_cntl_phys << 32) | lo;
> +	if (!(vf_cntl_phys & 1)) {
> +		pr_err(FW_BUG "vf_cntl_phys disabled\n");
> +		return -EINVAL;
> +	}
> +	vf_cntl_phys &= ~1ULL;
> +	if (!vf_cntl_phys) {
> +		pr_err(FW_BUG "vf_cntl_phys address is zero\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Mapping 256MB of VF and 4MB of VF_CNTL BARs */
> +	iommu->vf_base = iommu_map_mmio_space(vf_phys, VIOMMU_VF_MMIO_MAP_SIZE);
> +	if (!iommu->vf_base) {
> +		pr_err("Can't reserve vf_base\n");
> +		goto err_out;
> +	}
> +	iommu->vf_base_phys = vf_phys;
> +
> +	iommu->vfctrl_base = iommu_map_mmio_space(vf_cntl_phys, VIOMMU_VF_CNTL_MMIO_MAP_SIZE);
> +	if (!iommu->vfctrl_base) {
> +		pr_err("Can't reserve vfctrl_base\n");
> +		goto err_out;

Nothing to cleanup here. You can replace goto with return.

-Vasant

