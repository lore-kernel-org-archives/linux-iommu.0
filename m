Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DF224886F
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622770; cv=fail; b=Az37qJbUT/4eFuGEPWwIhql6ev5mS2L+TrEerjvpGCsp6DqXSMRka2zBY4W9FL6HtsLRlF8pYNn2hPNZMywJ25ErX7ogzWq62wO/vxj+uUc9BBdmODGibMwXr6SQO+E1MImnBxVZrAu5ajZA/UJm9dFpGpMlajWwsaZkS7n/EDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622770; c=relaxed/simple;
	bh=2vIYKRHSAd//2WqR9b2wlZqZbUtFKNInPmoII4XXOeU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kz1p5PSznLzEpjvkTIRs4PWhq4MDPpPfXW0WYhOarvQClOlXjZW8kv3eoEKvxcseTplM4hf/ywjsAmuDmjAtrtziVhXY1D6r0up0CG7ju02VXbBqUyu+Q60q80Kt1jK3jUTGlPW86ht3jkZkXGeRzNRr+FH90Z9qptqjmmuq9pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=myCrXnBw; arc=fail smtp.client-ip=40.93.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="myCrXnBw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvdhcvFI060gxCp3jabs14g7wyxlYKrO2cMuqlRuw/9QBMQBsgUqNiIjao5T8ysuEmJO6ZqwoAyY26xYp85bSTCkNfbeJ3WuNtxEvsxAL45ga0ISAFrmixBQAh4Nl/u8QmWjPA+CdSebv/FnENoyTrDDfqXdMP5QB0vCHEnXSREYWQd4HZswytXD9HKOnllauFDIY9bN2a/cBgRt+N0aI7d+X+ZDpmjjMUbXkPZOiVwLN03BmPiSEdVKkJXqDWw4xGPk5TpvmfRrgrgXMn5OxBt4n1rPmzqwbOvFgYJ21wtsuNCbCoANKv2Bx0TnKef+ENWGJIIA9sEJmdVcVnxW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9olP5AQ05rnKIM645iPA0vkpT/7RXM5z7X8iBGMGEc=;
 b=C7py+XsvOCVlJye+LxQbbsnCOiLO3277W8qw7VCdgTVhT/KNBoc7FuH6ybuy0JvOMP+2mso8Ddm0cFlXvVNzrVc7OqZ8YfCg6oHMZCflL4Etngj8ngBub6lKr7Zghz/5WKtvjqK3IdM5xyvn7R9gg87ds0NjYwQLulwylFa9t4KRAWNxMAj/Euk8PTAyKiRqzIAesO8DixKGleDipoAJg2Yu62tPVMQeqXEGFyVpIk29FkmsjB55ihfdCo9grK3N/sjxylaafDTEJjgf/cGeg3BA3ei/fnUdEklzKJD5u8FFWDM9zr6BzjX0poQiaWazqDntloiIkMJ6puHZqQ5EIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9olP5AQ05rnKIM645iPA0vkpT/7RXM5z7X8iBGMGEc=;
 b=myCrXnBwNUfQC3E81of9k36Qelt853aUsdNKaX1niI+AbJ65bxsI4138/a168Zt9FQlMO1HzCGqfQxzzxIXRvNkOPA9Un2GDGw0539C2oKLqZy4+d7pHmE8ETHImSWaBgx9GI2Cn7ItvZMx4Vi7qlCEmk9MD1ELynXOkEkP7AGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Sat, 8 Nov
 2025 17:26:03 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 17:26:03 +0000
Message-ID: <b890c467-4194-4f5f-9c05-9835826341b6@amd.com>
Date: Sat, 8 Nov 2025 22:55:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/16] iommu/amd: Rename DEV_DOMID_MASK to
 DTE_DOMID_MASK
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, jgg@nvidia.com,
 nicolinc@nvidia.com
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
 joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 iommu@lists.linux.dev, santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
 jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
 wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-2-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251021014324.5837-2-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: abe6b918-6368-4207-3eb2-08de1eebe437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVFseTN1NUlVN2t0SnhkcXFvWVdjMjZkb3dlV3hmeU4rL3dpSlNSaDd3OXdr?=
 =?utf-8?B?bTg2aGhUcFVNV3FpWlRKS2JOd3JKVEJYWmkyNGxyS280ZnI3blNWSS96UjNB?=
 =?utf-8?B?VFhPMUtNUHFUR0NWT3E2WVJUY0dVbGxPQ3ZaS0Uvc2JaUGd0ZVpvcDFGVU9z?=
 =?utf-8?B?WWZsTVVDUXBhTW0vNENxSzZZMVJ3VjZLT2QrK1lhVmZzcUtMelE2bFlYOTFm?=
 =?utf-8?B?bytMelB4QXNOamFhZjIvcVd5MjYwRzNXYThReERZS015a1YzT3MvTnl3Nkdr?=
 =?utf-8?B?R0pEdHJreWRvNWY5amZOQWhnNUdWZ0xaQk5jTFVkS1pHN3RPaEpNa1BaT1hU?=
 =?utf-8?B?T3BzMUhybzFJeUh6RVM2RDZ4N2E2QkJnY29Ja0RMMG9JQTczdFpKM1UvMlBs?=
 =?utf-8?B?YzkvOU9CM043djdvbUEvNVVob2FwWHRXWEdoeVJNQVY2QlFLVE43RHNqeXFS?=
 =?utf-8?B?WjEwVGx1V1lYNUl6NG8zSjRwN3dFQ1lOc2hNc2pqaUNZRXNXUHNoQzlBM1BV?=
 =?utf-8?B?cEZ5dW4wVlRhVFlWRDNBcVNxWktSQmtyMkdLeU9YTGxiWHhZWnlrL0QydEh6?=
 =?utf-8?B?czZlMHMrTEdGb0dSMlNjcXk1a2MvVFp6VU1TMGYyZ2FvZW1PVE5hODNjYkQ0?=
 =?utf-8?B?c1FRbEo1MC9DVVJIUExNMmtIa3E1Z1dkcjM0cnhmS1V1SW5JZmRxaVkwSzBO?=
 =?utf-8?B?RmZmbHgwOXYwdHA0aS93MmRpWCtma0s4RDh5N3BlNzBJR1M0QU1YOW1RalFN?=
 =?utf-8?B?NUJkSWlGYjlLa3BjZjQwNk04U2lCYktIVG9WbTZFcHB3enJLcmI4Sm9KTmF0?=
 =?utf-8?B?b29NK2tINENuT0VyenJxcUYxa1RvbERVOXFPU0J2b2dENWppREVmYTNrMnNC?=
 =?utf-8?B?aFJZbnhMVDhkQzh4RFc2VjlrMHAyRmMvVDdOVUl4b29hbmtKRDAzL0JkL0Zl?=
 =?utf-8?B?NW5YWm80aExDOXUwVmhidGpKSzBKUlZzWHEySk5LSDdZZnFXcHlQNkNOTzZX?=
 =?utf-8?B?MGNaV2FxZ0FuclkxTTFNLy9LWW9lWUFmV0VaNUYzQmxoN3JvTFlLZ1czcHZU?=
 =?utf-8?B?RzMwaHlLRUFmSjJKVTUrM0Y2MnBVQ29leWJ5aFl2K0ZNdlNmcDd5V1dpR0VS?=
 =?utf-8?B?T0Z5WUZENmJTN3VNNVdqTkxIU3MyTHRZRk50TjVDMWFkNkZWemhsSGF0Z2JN?=
 =?utf-8?B?MXJJQjgrQ1NQdm52a3h4Y0ltSm0wZlErN3MyQzNNQzI3RVpadTVwbTR1ZEtx?=
 =?utf-8?B?UzVWY3ZXTjBic3BTRW05dnZmUExoNTlTdE9XajJtbHFlOGE3RkdrVmpJbUUv?=
 =?utf-8?B?ZE1XVVpWN0VjTE5UZlR4clZlWkMxMDVTemhkS0wxMVVZMHZsTUdmQ1ZFUzVM?=
 =?utf-8?B?dWdURjBicFp1enl1M2Yva3MvQ2hZaGxzVFR4ZW5qVVYzR1BrWjBNQ09EbTZz?=
 =?utf-8?B?bm96WjJuS25lTWxrYTVodGVlUE5GOWRLRkx5S0pLK0M4b3JTUjZ3dXVtK0t2?=
 =?utf-8?B?UWtwZXN3Zk9NcU4wMXFjT0h5SWE3TWZjVERSWER3YUtra2tSbE01cnZRQS82?=
 =?utf-8?B?bTJhc21LRHMrd2x1Z3RVNy85TVlzNGNUZG03OWMvRUIvV0dGbjYrd2wwWXpz?=
 =?utf-8?B?TXY3MkxMNmNoZUpBWEFRYXQxTS9SNzM5bUZuYjdtc1JGWGFsemozZTI5R0NT?=
 =?utf-8?B?STgwWHRETWVnVGZsbExxSzg3TTlQelBWenczZGpWRE1RVEFMb2NoUG9Eczk5?=
 =?utf-8?B?Nm5WVHNVQ0hOSVBHNkoxbXFXV0cyOEZXS2dWRkh1V3BxUC9lMkFMd2JKVzFZ?=
 =?utf-8?B?YkUwa2hQaW1UNXFIQjArQkpRN3A5bnppQXVrc1V0eE4rVGRRNExXOE5SZkdu?=
 =?utf-8?B?blJjK3RsNUNnZDh6SDhlZGhTUTM5SGdSdDltSUNvR3NYa2wwUUYwczNGNVV5?=
 =?utf-8?Q?BOBFy1xIcFMMER0rJ/tUy/F6PlCzToqi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWgwZzU0NXFvOG5Qek1ZOEFneFU4azYyWlVpMHZrM2ZBa1FlQW1UbDBRUHpv?=
 =?utf-8?B?cFNlSGY5RWpTdlZHd1lCekpoNmlERFZEbC9NL1JuY0Qrelp4VGdDMnBSZFBR?=
 =?utf-8?B?WVFqMk5GNTJEVzhaU3hDT3RoeEtLcGkra1p6ZXpwSVJiZGpQcW1TYWxyVllE?=
 =?utf-8?B?N2Nzb2xmdWp2cEVjRHZWYkk2WUhiYTNUcThKdU4wK1k4VzNPTk83YmNka1N5?=
 =?utf-8?B?TmFlcHEySVRRZnFNTkpLV004NGVkdHlVSzc1RUF5Qytic0tDdlNkNXdMbTNz?=
 =?utf-8?B?QkY5cDVSWDNsaE43TWRRSHpVRVMwMFhXczhaMEFtcEZVY1NzMHhnZmlMdGxL?=
 =?utf-8?B?V3c1YzFpenpBVS9lZFZsWHlxQ2NzTlJOeXhRaTRYbk1nN2c0cGwyeStnWFZF?=
 =?utf-8?B?VnZlZlUxc1pwOGxCNWt0TlFuanBTV1Q2cmRPaUhoa1dGK3FEcXBJSExTRVUr?=
 =?utf-8?B?eitNUVVyNzg1WUdTbHk1WDBwUGQ0aXRFcHRPM2I4aExYSjRpTTdIMzMrN3Bu?=
 =?utf-8?B?UE9zUmdibVRmUUpHQ2lDcTd6TWd5NTJ5aG02WllNZDV5QmFHOURZNldQTTUy?=
 =?utf-8?B?c2l2QUhWb1NqTEY2NHZnWDQ3UEs4czkzbFBJSGtQcDBCTXVZamIyV0ptQStL?=
 =?utf-8?B?cERtbEgvOU43am9rZFRXcEZydklLR3lkcFZYMkpmRTFGVGpzOVZ4NEMwaWtG?=
 =?utf-8?B?UHp4MzU5OG4vL2piYy9VS1BTclh0MnJpejQrV3I5TkZPWEs2ays0TVBqc1cr?=
 =?utf-8?B?L2VWcElvSVl2elFkWXJwUFZ2bWdrN244VmhFbCt1WUxuYkFDRGFURTVxcXYy?=
 =?utf-8?B?d1c4YXlFRFJsUnN0TG12VGNWSkFTbGhoaERGN0d6STJqZVJXUXU1MzYveUkw?=
 =?utf-8?B?NDZmU0hUVVJ5YUNLeElYQkI1L241cktDM2hxdmppL2k1aHlVOFBGZlhBQUlM?=
 =?utf-8?B?YWNpWU0xNTlhZGVVYkdwa3E1eGFlYVNSZUVwVXRJanZxWndyT1VjV0dTei9R?=
 =?utf-8?B?Z1I5YU16cVV2M0VVNGdlTkkrcTZmNmN4NFZUTHB0ZDhMd3FPMzJ6QmdibDNW?=
 =?utf-8?B?QTdFRk9jWk0yeUVCOHRyTDNGQTVZU09LOEF3L3FZUTdHOCtSSWpxNjZrbjdp?=
 =?utf-8?B?NmlZb2xzTC92TGdpV29pMlp5MlZROG9MN01QNnVZM1lKUHhXVzVHb3kzakNJ?=
 =?utf-8?B?Z2JYb1c2MXU5aURDU01YS1EwdnR3RFdKaTlmcnQrNWFRYTVDMXpZbXUwSXRC?=
 =?utf-8?B?QXNad1dkK3NiMUhPaHRhZzdETlJzTlVVTUR1MTArdUJRa280dUZiNFZWMnVH?=
 =?utf-8?B?akU0Q250ZnJiMGhSNFVMbC9Sd1JCWUNGM0thelNoeWM0Wk9ta2M5Y0J4SmQ0?=
 =?utf-8?B?NUs5VXB6WG1MSnpERUJpV1VRQjg1THdEZ3dsUVp0MjIvVmxCS2FEdEhUd0o4?=
 =?utf-8?B?TVVsVkNjc3Vlalo0c0hmR3lrWlZMajRNS04xUlkwZU1YL252VEJwbGV1QnUr?=
 =?utf-8?B?bXFxaE50Rk1WQnVPZUIrRnZwdGFEN2N0eERVMDRXaThUbVVkUWRpdG9CV2Qy?=
 =?utf-8?B?Y2w2NXJiSU9TaTBlMkVsUEFSWjRIcjRqRklYemo3c3NNanVPTWpCeVJkcC96?=
 =?utf-8?B?WEE1U3I3cElsMFp0R3ArU1ozV3VjajBSditLM0M4ZkI3U1RNZklYc0t3bVBv?=
 =?utf-8?B?d01lbXJoWEt6ZUNBVHJsUG1pZHVaQ2J6Q2ZxdFAzNElkVHRwWXl5YmtoN1ZZ?=
 =?utf-8?B?Z1JsRlhweDZweGZCV1JVRGJTUXdMdnI3bzltVnN0VFdHWEFpNVVKbkREY1JL?=
 =?utf-8?B?M2h6RnJ1T05TQVd4bEF3K2VUNXdCckhOSk1OQi9nVHB2SFpIcnZxWDFmWVVI?=
 =?utf-8?B?Mnh5QnlLWmtLRVkyVHhPejMwYUJZOTkxQ0JEQnlhaERocW1HQmpwNWdGUjdD?=
 =?utf-8?B?WTE1dXVaVFl0OHlXVUd6Ri9HMXQ5Q3FJcTFZeTFEVEVzMkFMUzd3MVd6L0Z3?=
 =?utf-8?B?OHl3WG9pQWZYL0lxTE5BRUVnVHhmR28wSk5VbVV6NEhHSWxGcm9CSllCYnZj?=
 =?utf-8?B?ZWhhRzBHL0dTQVVEcWVVVmsxWkIyeHVLbEMreGhFYTZodmJxM2hZcmVudFAz?=
 =?utf-8?Q?DjhBr9Q5W8yjD36nGzFj5ys4g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe6b918-6368-4207-3eb2-08de1eebe437
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:26:03.2350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2LlI7Zubi05UUXRnPPfebo0kXqg5vtAnuurEap1VLLvs2T+L/MIRtmpAinpdYBoNzMVRuaP3mGoXBifS4Er/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992



On 10/21/2025 7:13 AM, Suravee Suthikulpanit wrote:
> Also change the define to use GENMASK_ULL instead.
> There is no functional change.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

