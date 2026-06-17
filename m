Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D72D46C0
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 03:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781668703; cv=fail; b=fkLA+wq2k3BzE7jzCSoPyJr6qKcEKHWm5FYL3mhHz9Hf+GigdXHuv6uP/U1EzrtHdQZ7nQvAzIdamx7uwP3ytIfhe+gU9FqFUVA9TYATukWFX+TadQhTShCv+qMgHpXpv/ST3CvVTGsEU8F0FT1Y0Y2Je0wLXrWLfoBCcgWxE5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781668703; c=relaxed/simple;
	bh=4dCqvL3dJYMxJ+MAX83Yw+bGdY+6/hQLwZh3TwkARAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gdlcD28DI9lKzXRdAToOrItj8wB1PMKMHELjIlBQlJ15XRRoRRabqL8RoxUs0OnDpRbo4LIhrPuzeJ+J+8lP08dhX3wfAL41+jjvrEIZKobMHFnQVcELiiF2iPNAwJcfFDU6sAkzmB2lI2gCipKPsQIBI1ZPgFiVW08FlwbETqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OMdRGAnQ; arc=fail smtp.client-ip=52.101.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OMdRGAnQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UA8Coyd9IZzHHCEygV9BTCd4h6hv3l6/X+qCaE2x4iaY/cLIYwm0v58MjcdTK2Kh/fqH6DknJhD7NJmDXGBMwtMReWog2w09vHt2+U6nnbz2Kajuo2N2j+8LkjIaRj5I2saio5pBLIljsJbBO/4OQXv3CWI6s8zoAyO+kbkHIKsvWgtV/DQV8Ciju1dfVMJOfuZd112flStOw/ZDjxSiST2uEXQvIHrMlR1dO6XLDXbymRl+sd4edXpXN9A5grrZJt2dsQsVasd6SVDr58m4Cis22kUZql6ybO5CipS0tfJmHteMkD9cMRaTdfgKkCx7maTfEt4uvlVZfmuYenHwJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7ob2kKiqtQyTtHhFceguAyCNwKD7k0NXODfL1Kue1s=;
 b=fdE52hZ7gQec9qwJx3e/Ps+pdWC/MOBqbgVook3QYf/1i3R2Lg+69U67JvO1YPGAYv5pDYl+rAD+GLbsy2/KC4+Qoud194MFjp0uutXUmGCfZaj3KFMyZz54gGkl++RHfTyiekgSOl9Qr04EzJ9qSRKMbxPeiEw4terkjHzjHK9mP5w/mimaL3Vyyt5DV6HOMM5TnUe1/2AgZx0E7sAsQapn8+0JIex2UDhtjaCIr8XS9NK8YeP0oX5IisfAUC/fSA1lXnnMmyOiKuDo3IcS88mAV0ilYJf7SKG1wDn7tXyK+oT4xtmvBvMIGQAypqtHuZRidxvuwzsxLo6Tira8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7ob2kKiqtQyTtHhFceguAyCNwKD7k0NXODfL1Kue1s=;
 b=OMdRGAnQnRVDUAVw0uZKq3IqKgfFdCxQRkLBujpvpVYwsGe6z0WSN+cLY+9/us2vDaIADzJjkU+pefYHml8C/al7OZ/thRlfpbozT/BwSM3mp13F19d7Fc1gUzDqAbNTVw0o29TQzGI7TLf3aBn7iOMx20Pbn6710javKm+klKNHXhol20TUEpC+866n1SP2KwOsMo0RzYyLYXRk1mPzXaTmx7attV9TWhBu+8ID4zeSnHgIdlKns6k73YupoPacFbNrhNwxQbiiEO0VJ/YELjzi++hMsBI31z0MpbbhBXOehjlZ2e8UQsJWtFY39UN6e2751dwInPLf4qnNWwJFJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 03:58:18 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 03:58:18 +0000
Message-ID: <97b4dcc7-3ed3-47eb-ac38-51fc2dfb6480@nvidia.com>
Date: Wed, 17 Jun 2026 09:28:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] iommu/arm-smmu-v3: Tegra264 invalidation
 workaround
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
 nicolinc@nvidia.com
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260609073204.1760077-1-amhetre@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <20260609073204.1760077-1-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 979c779c-708e-4872-c8ca-08decc24aa0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NbeKyRMr9uWuGibhMic1H1gii5V0IoAnIrwxiRybb/PweUHPkP0aWhn67ICzGnAJToXxdKNabryPyIAMAUOcn9lwXmkakeV41+bp5IHGd+hchPsDvJQTAf47nW9KDKOv6qNJjL6cuNzjc1OZbl7gg9RL/4qUjUEknBX/sMD5oRoiJOECB0W1A8V3dEJb0pUiXmUd253K/AVfpln4P6YpIcGr4O1y6h1OTIrpE/YUOqbKPTeDfMxalgf/dVusN+0hpl/BvC5/rcBJSsm6Ql90bgTh4t5ZU2Z2j8/buZr0J1brL8RNSLYGqFrzd25u5U3h3rfilJOuIIbRvtoKB7NV5ZmVKDboIchbqzg+xf94YGPAhvwtZRuorZHKt780l9eQgnTxsj8/oLENaH7qDRUX4PEpUsyj5g2pGRr7Ax3H3kW/XWA4BTMFEJECcfTHWvlLgm7YFQuL/8QKQecwgCBFJzf/psn6z4jBb5p0oEZMP/Qz9fRnRn8K6fogAtjzBDDwizUgbwrWgKd5pEdf+w/C/TEzSHBCuO6NaxGg67R8qjy52g2/0G+vV7CTc/mCn9IXtzR3gXrTakXJomvO52rNC5uAKov2uCFqP3YTCz9QiZ4uQ/CpGVOG0tqEKDh1UfPBne5Yg2pzh0r0BHFXe4TjC55ur+W8uFbJdf0wKeRej0cycAecv3skXc8+WnQx7kvN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUdreHZHbE16MG9HREUybkI0L0EvWWNtbDN0SDZkc3lpTmhTRjdSVFlCbEN6?=
 =?utf-8?B?a2JsakJ6OHJrTERDMEZoL0pRM1BqbGtXNi83SFEyQWh5S3JTV3pmNWlYaEFZ?=
 =?utf-8?B?SzZYMGN4bUF6NVJGZ3dtZVQwelpobEFJTVB5aGVIUWNwa2xoWGVwT09lQzV0?=
 =?utf-8?B?ZjdxMGZ1K1ovVzJXTVk5RkttZ1h3REZSWnFnRWk0Mzk4MlVFYXp6WlEwWG5n?=
 =?utf-8?B?QmZta1E4dUVFTmloOXRZTWhnZkU5elRFQWVGWFZia2FObHJuU081c2RtckNJ?=
 =?utf-8?B?M1grUXdhbXduSEVUcVRYMDBJY29BNlpLUmdJYXRjYU5ZY3pGQkorOEVUa0k3?=
 =?utf-8?B?MUlDK2dSR0dKKzZpcnRrLzZPZmtRQUI3KzYzSHV4clhzZjdrb2p5NWpRU2Zl?=
 =?utf-8?B?Y3o1eHpKVXRYaktKVHFNdE1BeHo2ZlZNS29ubDdDL0hLNG5iYjdHOENpd2F0?=
 =?utf-8?B?RkdzbGQwbFVIQ3hmd1NTOWthak9pbFpGVFFUOXN3UkVLNEJHUThYTmJCQkhh?=
 =?utf-8?B?TzdZT2hIOG1USEhIWENKWUJrNk90dFpxbTdQT0MzZjNUV3BTVUVSQkswWCtL?=
 =?utf-8?B?d2VBK1BBRTlkZWk5VjdIdE9LYzFwTWYxZGozNXduTDA4c2xJdmNCbnRYQ3VG?=
 =?utf-8?B?TnF0R242SHJUVmZ3bC8rMnFhUkxwVnBOZWxvSjNMM1hKS2wrTkpZcDhud0pV?=
 =?utf-8?B?aW51SGh4d1hYWGlZUnJ3RUZYMXRMSWRNZlMxTVMvK0laRHFWbHJ1ZWl3ZTdN?=
 =?utf-8?B?dlV0dWJpamtvM092TXNINEp1Z1JWelFNWVl0ZHEvbzY2TGM4NUtDRnkvT1lO?=
 =?utf-8?B?R3MzNHMvMlJ6TFlWTjA5a29vLzJqZloxdE45QTlCK1dCQVVRYTNBWDE5ZTdK?=
 =?utf-8?B?QVVGUDV4U01uTHVnQ2dTa25DdXNnUWRtWU9vc2NwRGlVTDNPazNWN1ppS043?=
 =?utf-8?B?S3d5a1hMVmxHbXNWdStkYi9EMmlrYkFVRjRmbkxJWXpOOCs5YUpTWXlWZUVp?=
 =?utf-8?B?TkZUV3ZLVnFkRjIycUQxelRFMnBVYmVIUzFZeXRkdWxyQjUrMXMvcXE0MzR0?=
 =?utf-8?B?NUpLYmdjSjIvcTcrVEExSk1WY2tYY0RHaWxhK2gyOWVBZFJXajdXRU5yTU92?=
 =?utf-8?B?SkNlNE51ajBrRWV6SW5ScDc0MklaQ05LRjRXRWlvQVVnZ1IrNDJHcVV2TGU0?=
 =?utf-8?B?R3A1N09ZMzdnSkoybUxiRlRtd3RvTDFxdFJQNXNkTU43M2RSbTl5MjFCb0FJ?=
 =?utf-8?B?ekQ4b3BvdlVsVlJOSG1KVDZ6SnJTSUJ4UStia0owZEhFMDZ5UGZ1VllBRzNq?=
 =?utf-8?B?Y2dLelNHN0hVYUYzbFRxMXdnVHlsNG9ucE95dlYyWmxSOGRFMDRuS0xjd3cz?=
 =?utf-8?B?eWU2YTNhTlhOUWNvOCtYNHROYU5ITG5RbHRmRzhMVEhDNzIzdWFuRSt0aXJO?=
 =?utf-8?B?cGgzOW1sOHhQZG9Gd1IydG1XOTkrZndCaG9sRnBqSC9XMGpwTlVRUXFqYVdu?=
 =?utf-8?B?ZmlhUnpLakNrT2NEb0UwbWN1UUZRUTh4Z00wWXlhUGF5QkhPU3BHMW1Pa2dM?=
 =?utf-8?B?aVBuYjZkSW5INU5memVWNy9XWmhua1VkYXh2bDlYZEEyWEMxSHNyekVaTitG?=
 =?utf-8?B?NmR5bTBKb1c3QTRvTTEwZWZnanZaM3JJSU1yaVZ6Q2tlUDY1T1hkY2RpWjVZ?=
 =?utf-8?B?YS9JcVBnYitndXpGckxjdmV0dmV2ZmdEMTQvV25GdTFMZXlLRVorTUx2RFoy?=
 =?utf-8?B?N2UvZWdDM1VIUlh5a1l3MXlFL3AxZ1JiaWthU3lPSXlHWE5OMVBBRXNVdUFv?=
 =?utf-8?B?NTJPVWIzdkJyNnhUaEVTa1JnYUE2dHV4RWEvVk1ZaHRGQkpVcWNDWXQ2ZmdR?=
 =?utf-8?B?OXFtRStOKzBEU0N2MDBQaVJDT2JFdExQZ3RUZWJVU3Zid3Zaa1BkcmMzZFNP?=
 =?utf-8?B?ZjdxWTRHdi9GaGFJNGxOZGdVTFVGRFkrcFJQTm44VnlWc1k4bWRHdFN0eWsv?=
 =?utf-8?B?Z1QvUTFsZ2o0anNjSHR2WVU4aERuS0d1Q0FBdEZ1a3gwWjFJdng4WFFhM1Rj?=
 =?utf-8?B?M3BWZXYyWXFjOEltUUY5NmdXUU1zeHI5NVRZUXczTk8xRk5VOG1VUWtkb2JK?=
 =?utf-8?B?S1BuR0lsTHAvbTBCakVYMkZlLzJ0bDhkNHUzNVU2cm5hdmpJSlFPYUR0QmN3?=
 =?utf-8?B?MkkwN1UraFJiRHF3dEsvQndrdmZiZUVUS3dEYkxJam1ZUU9FRitVZkRibkxO?=
 =?utf-8?B?QU01eWJPY2QvMzBzaExMWXdIdzNHdnFuKzhINDYrNFVWdU54L2RaalFSa2pw?=
 =?utf-8?B?c3ZMTytKZjVwVWFEN3pLT01PUFQ4bThZeG40YjhtKzhDajg1aWlHdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979c779c-708e-4872-c8ca-08decc24aa0f
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 03:58:17.9036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d55g/jDL6qVgB+y+jvW22WEO35XnAOXNvAzVEWy+CGGSHDK4Y0E+ytXi+GkjQH9bGabEX0JsRjLe42HgtFvBEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415



On 6/9/2026 1:02 PM, Ashish Mhetre wrote:
> Nvidia Tegra264 SMMUs are affected by an erratum where a TLB entry can
> survive an invalidation that races with concurrent traffic targeting
> the same entry. The hardware-recommended software workaround is to
> issue every CFGI/TLBI command (each followed by CMD_SYNC) twice.
> The second issue must execute only after the first issue's CMD_SYNC
> has completed, giving the sequence:
>
>      TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC
>
> ATC_INV is not affected and must not be doubled.
>
> The erratum is not flagged by any SMMUv3 IDR/IIDR register, so it
> cannot be detected from hardware ID. Tegra264 is device-tree-only
> (no ACPI/IORT support), so detection is purely by compatible string.
>
> This series is structured as a small refactor + detect + apply
> sequence so that each step is reviewable in isolation:
>
>   1/3 Pure refactor (no functional change): lift the existing
>       force-sync conditions out of arm_smmu_cmdq_batch_add_cmd_p()
>       into a new arm_smmu_cmdq_batch_force_sync() helper, so that
>       adding another condition (in patch 3) is a one-liner.
>       Authored by Nicolin Chen.
>
>   2/3 Detect the erratum and provide the classifier. Adds the
>       ARM_SMMU_OPT_REPEAT_TLBI_CFGI per-instance option, a global
>       arm_smmu_erratum_repeat_tlbi_cfgi_key static key, and the
>       arm_smmu_erratum_cmd_needs_repeating() predicate. The static
>       key means the wrapper compiles to a single tested branch on
>       unaffected kernels.
>
>   3/3 Apply the workaround: factor arm_smmu_cmdq_issue_cmdlist()
>       into a thin wrapper around __arm_smmu_cmdq_issue_cmdlist()
>       that re-issues the cmdlist a second time when the predicate
>       fires; register the same condition with the batch helper so
>       full batches of CFGI/TLBI flush with sync=true; and add
>       arm_vsmmu_can_batch_cmd() so iommufd does not mix command
>       classes inside a single batch. Also documents the erratum
>       in silicon-errata.rst.
>
> The series applies cleanly on linux-next/master (base-commit below).
>
> Changes since v3:
>   - Drop the cmds->num == 0 early-return so the refactor is
>     truly "no functional change".
>   - Rename ARM_SMMU_OPT_TLBI_TWICE -> ARM_SMMU_OPT_REPEAT_TLBI_CFGI
>     and rephrase its kdoc to be hardware-agnostic.
>   - Rename arm_smmu_cmd_needs_tlbi_twice() ->
>     arm_smmu_erratum_cmd_needs_repeating() and drop the kdoc
>     above it.
>   - Replace the explicit opcode switch with a single range check
>     opcode >= CMDQ_OP_CFGI_STE && opcode < CMDQ_OP_ATC_INV.
>   - Introduce arm_smmu_erratum_repeat_tlbi_cfgi_key static key:
>     the predicate gates on it first so unaffected kernels pay
>     only a single static_branch_unlikely() check.
>   - Drop the verbose Tegra264-specific comments above
>     arm_vsmmu_can_batch_cmd() and inside the batch helper.
>   - Document the erratum in
>     Documentation/arch/arm64/silicon-errata.rst.
>   - Guard the repeat path in arm_smmu_cmdq_issue_cmdlist() with
>     an n > 0 check so we never inspect cmds[0] on the bare-SYNC
>     flush emitted by arm_smmu_cmdq_batch_add_cmd_p() when the
>     next command is unsupported by the batch's pre-selected
>     cmdq.
>   - Drop the carried Reviewed-by tags now that the patch
>     shape has changed; re-review appreciated.
>
> Changes since v2:
>   - Split into a 3-patch series (refactor / detect / apply) to keep
>     each step small and bisectable.
>   - Move the classifier to arm-smmu-v3.h as static inline so the
>     iommufd file can share it.
>   - Add arm_vsmmu_can_batch_cmd() to split iommufd batches at
>     "needs repeating" transitions so the per-batch decision based
>     on the first command stays correct under mixed user input.
>   - Spell out in the commit message why detection is via DT and
>     not via IIDR/ACPI.
>
> Changes since v1:
>   - Detect the erratum from the existing "nvidia,tegra264-smmu"
>     compatible instead of adding a new property.
>   - Centralise the doubling at the CMDQ submission layer and only
>     apply it to CFGI/TLBI (not ATC_INV).
>   - Drop the binding/dtsi patches accordingly.
>
> Ashish Mhetre (2):
>    iommu/arm-smmu-v3: Detect Tegra264 erratum
>    iommu/arm-smmu-v3: Issue CFGI/TLBI twice on Tegra264
>
> Nicolin Chen (1):
>    iommu/arm-smmu-v3: Factor out CMDQ batch force-sync conditions
>
>   Documentation/arch/arm64/silicon-errata.rst   |  2 +
>   .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 15 ++++-
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 65 +++++++++++++++----
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 24 +++++++
>   4 files changed, 94 insertions(+), 12 deletions(-)
>
>
> base-commit: 7da7f07112610a520567421dd2ffcb51beaefbcc

Hi all,

A gentle reminder to review the patches and share your comments.

Thanks,
Ashish Mhetre
