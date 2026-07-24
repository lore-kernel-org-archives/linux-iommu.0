Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6773E2FF65F
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 04:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784867091; cv=fail; b=pUfUZClhm3eKIDNn0FDz7N4VQe8cv21jqjRu84I91Lvht1YroDlD6515tXqmf0UoaefOO9aBZN+WeVf6ddxLH6nY2OgOoVo1Bl/X5/h2yCTKr9vJzb5Njsyc5sP8yRbFCtyOCO/9TM+RKiTNFCe9XGn3NUvI+kGAbmRkYdCTxh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784867091; c=relaxed/simple;
	bh=tusE0WFbyx5V0dmbDc9gBoHrD20lxKx8RFCIx5zKqK8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mfuXkOeEjIktyhe5xMYq8PWHeF4dlthqv+bqB0Zu7UdNNnxIwrulLZiHN9I9dbN/cxjKiPeBrHjPO2X4xMFe85f//RXW5IY3e3BYwxuNrovDYj6rF/Viprpl9WzF8+MUDQ8C6C2mHgK1TA3AWXDffZryh7OVD9YfetdihrcJYWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TB87qlXY; arc=fail smtp.client-ip=52.101.62.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TB87qlXY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ackJSV0uNFS8LXQA2V2MiscXOTYygixYjXRNNblgYeTH2Fjrhk9nIUm2ib6xSfzBpCbMT4cGzz6lOJXigp+Qh8lJyPKLaeSjwZSLd+JcmP9iyP3T53eq5inuuGT4KHTL6rvgTPQYJq2urdtCFEnTSAuTUBZtogXaatyNiU7Sxh1Hv8WBlZqXxZ092oS6ZpfLaPy2o5hg50lU7+UakIZPoRpF6VRXsRDcL7PEsW75HWYc6I1N5R2KSMW7aStGe8ZHerQvvZxcLv1hWIWQEgZb/LTpTIuTNHnv2Zc1t/zWO4uk9zAwv/L5CrZD0asbadXk1p0w2Kj+GYCtJKlHevHSHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iX4cfEy5VSKd83LDJGV9ZDk/v96kIL2Mlo2mBS265E=;
 b=BxUk3r6LhGudFqMNUTrcnRhQ2k7VILGCreKA3TDXlDEwbx2tdOXlef/+ta1RqrKaE5+3VTWaiYcyIQLEStl3S6PubB3N9PbarQMEGwgho9x+dXYnCzngs6FUI2oBBR1tBlm11fGe/zQ8/ssXPyDMG6wCS5m5h6PFJN+ECNqJCYVi4S4riZai1FQ5RY9GI/iIIB67tfPMpmMrU5wCYCBNmfqwubieU1vfcQFYRqXq94/jgRnhhYyu3uKxXKQCRT2ayLSiW18Dj9fsAZWK2JxK4FdCQZU0w0I/lEb9opC9Myt7i1hnOO+e46X75YHBDsat0Rkl3M29u3MPkPzLsvx8FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iX4cfEy5VSKd83LDJGV9ZDk/v96kIL2Mlo2mBS265E=;
 b=TB87qlXYXYWZYWeGY69UqNGJVHEk9O3iC+RDU2DeUXlDWDliKoAJM31pCzPoE3nZqVFVipS5lzntwZ83f4zJpkcqRkMOgH/FfFlBLXx2pL7+g7EioCEroNE63YGz4/uuU9T3zgMvvRqxgW7QBeCa8pSQLC0n8X7v/F8GhCX8PydnnU5NDOMAwpump5i7avWQICeu76RGPalaKfKZ0mMNxWFpIpeXQj2vrJhQA8yVjNWt5tcOF6OeLRvlaa6F9Qt0xr/WpzYr5+DyGB5asBPwKxlQ5XutFl1l2HsJ6odCc3fT7pmMw9m8TPpayMtb4bXnpV245KVAr22Q07ZIFkM5Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by CH1PPF2D39B31FF.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 04:24:45 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 04:24:45 +0000
Message-ID: <49816faf-2bb3-4aba-86f4-d46798a110c0@nvidia.com>
Date: Fri, 24 Jul 2026 09:54:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat
 workaround on Tegra264
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, robin.murphy@arm.com, joro@8bytes.org,
 jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-tegra@vger.kernel.org
References: <20260722102033.1122277-1-amhetre@nvidia.com>
 <20260722102033.1122277-4-amhetre@nvidia.com> <amEXBlsOiDyAvZ0w@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <amEXBlsOiDyAvZ0w@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0168.namprd05.prod.outlook.com
 (2603:10b6:a03:339::23) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|CH1PPF2D39B31FF:EE_
X-MS-Office365-Filtering-Correlation-Id: db6fc649-98b3-4cf4-0dad-08dee93b7d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|3023799007|10067099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	ybbspy1KcX2bClJ7TTJ8sPChEJ2JC8zjgRs6ndYwUlilGax8FQxI6TZJmf2Z5yRBE7fYCmzHnk7V/rHdqrpyqJQyCK7aJg4THzExZ9vB1JcIj26DhaTVFzRO9xjjimCQHMJ8yUp9UTRPWlvcqC62eGVZCXeengTClJbjS/QjiM1xwh3JIr3wtngKuQC6QfKoxiFdxAdJW02rr1Dhjzx7lIdz/3+2808hhvzk2DL09eRofk0vnpzrLj9MD0nTSTFRRPhCQLUwClck/D2DXL3FsEHbRoeyxiq93JnDtOduVqOkMLwX9JIx6QF56F2qVG7et4fERBE8JrWxqdRX9auAAgZv4s7jNUEC0U3ve+iwybQFtoRnCsVWoIzAATBh22SkBJw290Ss6hRO26VMOQFnCxsu4WWpphGL3On4aDHdD5mhid6jo/hMxUGXVx2Mu6MBSh70vM1+opeyRe81sw7p62yKo+aJQLjtKumFQPJgBozROolMSjKp2aG9rL6OIruEKtmwNpyHK84ZvvuYyIwg02tQ5RGQzhVkw6VAWDgE90EiVJFUPEBCGVhc8Caf3OM9Xjlt7Ay3+5syAvigKLw1PB5B+7Ozb+ghRuCwRMbs6D3RWOT5Ck3Zw38gje/wTVHQKBkxb3N6+T2+jNle6sHVqg/1qozMSK4FPYcBgrFl7Hk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjNBYmxCM0FaY0kxTlAvbkVDNGNSK1llQ3c1SENlV0V3U2c2NnZiUDhJNXZi?=
 =?utf-8?B?RThHWVVjVTZXZjVBS0hkMGowQjdId0dOcFg5Nkp3bHNYaXV6L1UyVHY0T2JG?=
 =?utf-8?B?bDY4ZFd3S2FpZUZ3aHVQVVRSdUNTRlhWSWZnOUdLK3dxS1UxYSs2bFZiUkg3?=
 =?utf-8?B?Q2V5M1RXVUJ5WHhJTWJsV0Zxb2V2L3pWWDFUaEFsNUROUWREL0VrS21QU2xG?=
 =?utf-8?B?T0wwSVM5TlFINGZaazNtRktFZng0MVhPT1ExVEZqRDlNM1JJcC81TTAvYWhE?=
 =?utf-8?B?R2NGSjhjUldlTjZJbk0xalFrY1NQamtWQzdzbHowZXo4bVo3WkZBVGJQdHVs?=
 =?utf-8?B?dUZqVjNpYXJQSmNaSi96SlVaampuUGd6VWhFLzh3KzVyaGJzdTgrdlRNUTVx?=
 =?utf-8?B?c3FtcDQ0Qkwwa1d6R0M5TzArWXRiazVqdVMyUEtCVDREZHBpc1pRNVBiai9o?=
 =?utf-8?B?anhvYWdBblQ4QWR3c3hLNTNHa0QrTHdieTBGODNGcEVnT3R0STc0QzVLQWpm?=
 =?utf-8?B?UUp6ZTVuOGxWS1MybEVKU2N2cWRMamNPL2phN3gvV1dtK0NQY1dYTFFRRTll?=
 =?utf-8?B?RnFaSTdVdDdidzZISHVhYzlIbDBDdmc5SUYzcDdoS1hhQmNYSzZEbG1yMzhy?=
 =?utf-8?B?RW0yZDdnUjEyRlorbGFSb2NNbTY3M2xDNGFSRTZGY01RUVFUblhSenYxUXV3?=
 =?utf-8?B?aE1tTTFnbEV3UndBS2VtcFlKK2NMUTdxZDFMRmEyeTBrb0pnTHBRZUtERUd1?=
 =?utf-8?B?VjFqS1dGbkk5WWR4aDNKK0lHMmpJL0JZZExuMHFEVzVhWVA5S1RoVHJlSGlW?=
 =?utf-8?B?blZ4ZzNzWmhrbDlLTDA5Qkp3dnpTZVp0Ull0TGorRWU1UHJtK29YNTdmdkww?=
 =?utf-8?B?WW4yNEU5dmZhZUl2RW5BNHV5N3NXbFdzSGx3eWxkM0E1dTNHeUx5WXpxdUg4?=
 =?utf-8?B?dGZUdWcvZk1kc29iSGlqemVvdFpBbDhTTEVNQ1Bwd2g2TVV3UXpoN1gzRDIx?=
 =?utf-8?B?Y3Y0RUVWUXpYNzdOMDk4Y2pTRkNGTEhyQkMvNlJ2emxuR2tIMWp5TmlOMlB2?=
 =?utf-8?B?RXNCMnNxaXZhSGJ5QUVtbTkzNWZBQUpNbENKTFZiVGRhci9GV2xwZ0Q2Zi9a?=
 =?utf-8?B?UzJWbFFXMGlUK0owb2tpL3ZEVkNaOGxsVUVDRXNZWGhOdnBSakExLy9sZGRI?=
 =?utf-8?B?SW9LNGRRUXJQRUhwV21QSklVdmJzTzBhMEtNN3J1WVYza3VGYVZZUldwMyts?=
 =?utf-8?B?U2dBV1dMdWxFb0J1bkZOWWxMYzRUN3JKeWRMQlBVb2FrbGlOQUFXNEYwc3k5?=
 =?utf-8?B?RWs0d3BSNTQ1aXI3d2pDNmhCcm82VHpCVS9HcHJwTWpEdnVoUFdEaHRPaU0v?=
 =?utf-8?B?QUpLQkt4RGVlM09uamFNZEN2ZUNsRW9lRm94STloRjJlOUZtK0diRjg5SERz?=
 =?utf-8?B?eHRiUjRHTFBRWitCZm4vRVkwcTVUcGRUVTd0ZXV6aUxBbERoSHFpcFRTcytJ?=
 =?utf-8?B?K3Jubk1RU21XWEs5c05aaVhpNEVYSWNtSzRzK3c5V24vK0dkN3VySWVKNVM4?=
 =?utf-8?B?aVZqTnR1S21xeGFVYWJyMzVrTkVsYTJiNmZPcHRxNzd0aE5KSElWc2ZTSXQr?=
 =?utf-8?B?SkY1VWdDbW10U0NhNXFGRkpVWXlEbndPeWJoUHV1SGM4b0Y3eUtINTN1ZnlQ?=
 =?utf-8?B?UTk0RTJYUlIzN3pOQjl4YVAzYnVqL3J5MTJlSTZhaEtVVjZQZEVwWnVERlQx?=
 =?utf-8?B?WVFiamhoRGZ3SVhNK2ZKZC9xbHZjQytaNVpYYzNjQnFIRFIxY0N1bDFiR1lr?=
 =?utf-8?B?eVRNbzhCNHdtNDBML0piN0ZRUVZ3TWxGUDJubWh2aWNUb05mTGRVVkFZc0Iy?=
 =?utf-8?B?Z0NUUUZVdWtXRE9IZGdEWHZmbGtkckVtTzFxaDlmOXJlMmc0c2RqSjAyLzRK?=
 =?utf-8?B?WUNUQ09GdGZNVjB6a2dialcyeEh1YkRZVDgyS2tWWlg2bWZxa2YvbjRtUUhT?=
 =?utf-8?B?Y3kyV0trTkRzNVdtRzlXWVYvbnJUM2JRWEVLUlI1bDNNMVFhOElwYWZSd3Zq?=
 =?utf-8?B?RzA1OGNUbmRzZkxBWVJaN1Q2U09zb0xvc3liTHdBRTdhTXpsRjNRS09hVkVo?=
 =?utf-8?B?U0ZUSGpDRHlZMEJNUnFIb0plWStTVHBmeEFyQ2hUNk1yU05YeHBIR3FnNG9W?=
 =?utf-8?B?bGRRczhoUzFWMnlkbWwwNFRIK1Vxb1E0cnV6NU4zNVBIc21NYi94b095T2dq?=
 =?utf-8?B?N3NTWXoyZFlGMnJhc0ZlTkJ3TkNuUzJvd2Yvby9sZE0rbWY1eis1YnRHTWEx?=
 =?utf-8?B?aTZsY1IyRkhveDhRT0hKQmxDSEtPYXhDMjMvVHZMaWp4Y2ljSHB3UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6fc649-98b3-4cf4-0dad-08dee93b7d75
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 04:24:45.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfOCccPETB4cwVKKDkLfL7oLemyxlLDsq7OnrStqWls/0MW3aSfkfYnZ8DMo6S+6hq6ebZiXSHrRPPtFiICniA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2D39B31FF



On 7/23/2026 12:46 AM, Nicolin Chen wrote:
> On Wed, Jul 22, 2026 at 10:20:33AM +0000, Ashish Mhetre wrote:
>> The host repeats only the invalidations it issues itself. On a nesting
>> setup the guest submits its own invalidations, either directly through
>> VCMDQ or via the iommufd user-invalidation path, so the guest is the one
>> that has to apply the workaround there. Report the erratum to user space
>> through the new IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI hw_info
>> flag so a VMM can confirm the guest runs a matching "nvidia,tegra264-smmu"
>> (or otherwise double the commands itself). The host therefore does not
>> repeat the guest's user-issued invalidations, which would otherwise be
>> doubled a second time.
> I think this "enable" patch is doing a bit too much.
>
> All the iommufd-related changes can be added separately
>
> I would do a cleanup:
>   - arm-smmu-v3: Factor force_sync
>   - arm-smmu-v3: Add arm_smmu_erratum_repeat_tlbi_cfgi_key and WAR
>   - arm-smmu-v3-iommufd: Add IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI
>   - arm-smmu-v3: Set arm_smmu_erratum_repeat_tlbi_cfgi_key
>    

Okay, I will add one more patch to series for iommu-fd related changes 
in v9.

>> +/**
>> + * enum iommu_hw_info_arm_smmuv3_flags - Flags for ARM SMMUv3 hw_info
>> + * @IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI: If set, user space must
>> + *	issue TLBI/CFGI+SYNC commands twice due to a hardware erratum T264-SMMU-3.
>> + *	See the description at arm_smmu_erratum_repeat_tlbi_cfgi_key.
> You can follow the kdoc style as enum iommufd_option.
>
> Nicolin

Ack, I will fix it in v9.

Thanks,
Ashish Mhetre
