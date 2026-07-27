Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01353BBFB1
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785131705; cv=fail; b=R+sDxWowfEbTHGsqTm6zxrpQ+LqtViAOiIgJb+RoOf9AO+Wb+K53l1lkCBSdAbimMHHmgjev1mdem8biIBvHdpH1OFwbgxnFD4yVdZLQqWLyeAKb68Yp70rFL2RxyaBnAh6pql+/lOI99KFzkryTm8AGlUbCB0SlpBgOkG0vzEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785131705; c=relaxed/simple;
	bh=T5UmgoKjDolZlmK5GBerzPmfUP/H/Gn3gTBsXhyfNH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=amfLn6mbc0VS/tpznX2QCHw5aQxKPLSU3WAHBWLZXdmYxPecVqRGUP3cJlXisLZBHvtbpQssLgfEsP9KciOFKZX/+9KqH2oNQ/1vlnhUTP7h3XhKBwjV8MRR/kR9QrfZO58OMypBqNs5h/Ou0+dPyC5Gn3Mhz87jEUosATizGhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=acN+XoNg; arc=fail smtp.client-ip=52.101.193.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="acN+XoNg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOAWom1hivOFQFsAeBD0K8A+cKVHOpE8WQMCbFBUVNbz5IC7F7kAFltlOjXelW46Yjrm+42CL3vkqmqcTWuV2vjWM4yhxCvi8d6PV1Od43LN4Z4u4u2A24UIIpjLNGLlFAedoX+1hSO+b61LZ9liIom0CkyDSvCaBkuNheeU/iP5DsKDAo9PYJMxuePwO2hpv0WBWOdIWv9GKcmB95BabrVTFYw0KitnleyiLxqfW1rggbNDpn26fHYDQRhd+gvPkbmWIhXXPLmrCLMAn5aAsKvo2VUqqj2IDi2OqL609zxCrcLN8k+y1q5+d/gS0fxsTOpMRshJ7Lf1othqH5hUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmcY0uVy6erEFYIUrHwvpF+3u3yKFQEk4EHmGbWY2Rg=;
 b=usc89r79pBg0efDwVYE3LUkOFvZULbwFHLDP4lsE+n0eSxigoqYQtWMRgrryNzTp70gMk0DKEgvggZDHEfpTfzojBNQrQdH36O5A5WtVbPXkBdzswYpU/VtlXOAveQ1ECBnOKkMA15WlDBNZUR+jtEpORv8wAKUas9Jp5lvCrkVIYbDe5Twahv/KmR/IlFbfLqnLRAF14qglqrdsLQuGOeDsc/4X5Y0s8y7ayp0RM/x2krUF9053YRwlfoGghUpVK0+g0+Y5G19mGsCK+EGJHVnYGlrSutp0efv6N5FZVr1Lko31q3ESJJUQPvI66f5iyn0+qJOE4X2GrvDMUun7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmcY0uVy6erEFYIUrHwvpF+3u3yKFQEk4EHmGbWY2Rg=;
 b=acN+XoNgWW0/RkdskNuLl8KnYQHnv1o/51n4PJpXp7wuNZcsUovWihHoV0+q5Thi3gZD3wUHmabYG7cHdFpVVaYrSbunQtTXDh/ho1ntzw0paZ4qmJfS3s+4Qb9bOIWckefMNFuQjm1MMFZuUiPvgvho6Yi8CMkbYYSSFVE4eeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:54:57 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0223.013; Mon, 27 Jul 2026
 05:54:56 +0000
Message-ID: <1b84076a-6395-43f1-837c-d5fac9a76dcd@amd.com>
Date: Mon, 27 Jul 2026 11:24:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Put PCI device after handling PPR faults
To: Shuai Xue <xueshuai@linux.alibaba.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com
Cc: bhelgaas@google.com, oliver.yang@linux.alibaba.com,
 zhuo.song@linux.alibaba.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260727030212.51759-1-xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260727030212.51759-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::9) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f04ba65-ab21-4844-d358-08deeba395ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CXRAymEteuvjpQB8hx/9X+m3znquKNc+yjk4Zs1ifYJnju3O321XGv7slkbR4V2qfsv/EVJJmNKwUk6hG6iIvQso+gquSNWDPlFPf5Fx0NDmkr8JuXr/nNMGj5yloqrtyxbPJULpWBrMFeR241iA1DgbYAC+f2C1QltnLOGmF2aEQOjqVa70niG5OWJw0S85r/R7CLrrSBC2GB6NIX0foLq9zoPv9AHBFqt8wxAm8iF1US5eL8Mbs3AcU8xOnVkAAZeZYf+q4G7yruztgJ7cXV9sMlxSTFVHgjrxS+CPSVzDp9LeoAAT2orgNO4pkPD4A9lpK18VQi7UN7+k8t8mZOkrhMF8WEdg1+62w79HGtA7WeCuHkeLJzciasXg8cscWxRvRbB/pWPu0ofEXgLN1BxHWnq2bonKVn3fumfIBAyeRDJUNJ7bP+QdeF8kiSkgRNEEyENM0IfZXFuBFnZ9YYVHFxaJ7wKYE9VZ8LC77FUqRtlm+l2c7BLV0Lx+9deMsAnW3XAWTO25N5AnsUJbTJ+4lMZhB1KHLKOJVvgd4JXYGk0np+AiTgsnS83/Qomt2XXbg+DT5OyHVKdg+bFhAfBP3zM7KDCh1w5zfxTdb0hZFS8JVdZ+NwhQ55UqoSereZJUa8z8mmZe7pSLqHfnOg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amtLMllKa1pHK0tPSEdIbXIyeEFTaUZwSGNLeVdNV3V4eUN5NkZ3ZDl5TVBu?=
 =?utf-8?B?a2xOWW9jbW5BdWhyejZ0UUt6aEpmMUo3anM1dXU2WHVXd0dWeUtFd1BxNDBQ?=
 =?utf-8?B?cVU1STJiZlkxclhHZ3Jna1Y4V2ZFT0Q3YTNPTHJpTUx4QkhiR0NHRzlOMHla?=
 =?utf-8?B?US95MkZTUW9sdUYwN1N3YjdKR1Z4ZmQzSVQzSTl4d3ZZSkJxZ0F2b3pIWW9o?=
 =?utf-8?B?emFMZktvYzU3ZXlWWHY0cmlKbE56U3hPNWNWRTFqNDM2VzNBT1BDSjljdEtw?=
 =?utf-8?B?WERXZ1p3YnlBcUVBQk5WQndPUW9nYTBVL1k0elg3RmVGeXhaUUlUSDREOU5k?=
 =?utf-8?B?bU5MWUxvdXFxb1N3eDUvTG1NajA3M3AxeGcvQUNMemRFVlVXZ2R4NGVTQW9O?=
 =?utf-8?B?dVF1a2VRNlNhNWZtbXlPOEo1cmRQb3l5VDB4cHNkL3hielFUYW1pbkc2bU1r?=
 =?utf-8?B?cHk3WjlmZDRhRkJhTDY1SXJCTmJwWTdIYlFzaGVQQ1VvZ0ZtdCtYdG1JeWI1?=
 =?utf-8?B?dm1HM2lXQlZqMVZ2NzdNSmFNM2oydnNXcUEwVHhNamRxZzY2Zkw2UjFkT1FM?=
 =?utf-8?B?Ym5HZ0srNjd3NnFnaEo1Qmg0MllHcFBkSWYwb0o4bi9peWswNU03ZDYxTVB6?=
 =?utf-8?B?ZDNmemtUd3gzUXdITDhBUk11MjdpWjdhWllMTWVLR0U4V25QWHlPSjh2ODdW?=
 =?utf-8?B?OHdzR0JLaC9UY2JwMkJnc3BaT0pUcGpuaVlWUzJRcFpRbDY5bU9yOXIzZVg1?=
 =?utf-8?B?eWJ1alE1VnVJOUZXSUNMcUhlaUd3WUVuazY1bmlBMGxneWl1MldObjhIOFU5?=
 =?utf-8?B?UWE3YXdYWUtMYktFOGRjVTlDYjVrcmtMVjZEbmo3NzQ4dGxTcnpTbVEvM0Nn?=
 =?utf-8?B?MzNoVHhUelF2T3ZyZk9CZ2Q0TWVlbCtqZ3lTSHVUbUtiZjVyNUQvRW1tbkh5?=
 =?utf-8?B?WVNhZnpLMTBxVWxmV0hZWlc5SVF5elQvZGppNHFsOGlaUG51SjZ4cFZ2RU5l?=
 =?utf-8?B?Q25QMEJCaDBTLzRZSk1jQWU5STB6bnhMYmtGZEk0T0ZhREF3VFBLYjFvK0ZF?=
 =?utf-8?B?amtndVIvd3p2YXBLdFZLQlJEWWtLWEpNaUJQOXFHMnZpUThWRjFUWUZEV1JD?=
 =?utf-8?B?cU5Ib0IxQklHaGtIaXFVb0VjK1k0YTJ5ZGJFcGU0SDAzTkI1Q1kyL25Zc2x0?=
 =?utf-8?B?V3R6NU4zbGlGWmRyV0Z6dUhYSnBrcjdCL2tmSFhlcjIvL0p5M3EzVkRBNGtE?=
 =?utf-8?B?aXlsTmRsUVp3QnZ5WUZIYWpVWkNBZE5LM1hGMTA2dFVkUnZaemF4SjY1T2RZ?=
 =?utf-8?B?YmNOcTJlbXVNSHp0WWNldXh1NkFLU0E4ZFF3d3ZEZ2Q0R1hwRUtCT2ZuUkVG?=
 =?utf-8?B?Vk1WRDgvUk94emtTeDY3dXdhZEZCZlFiWjIyckFkdDJqZXlwcjdLWGVybklr?=
 =?utf-8?B?NVVGVEdJZmcwUnNkdEJMWHMxcG9xSzhtTkZYeklwSmtVZW9ISlVJaVhONGZB?=
 =?utf-8?B?c1NURy9oSDlPb3RrcVUzWSs0WWFQTDRvUjhaaE1KLzBma1lXcG1LRTJpNlBY?=
 =?utf-8?B?NGNLS2U5WGhyNDVCMElId3lwY0x0dHFycXU5cFFHV2dRVW1zWEd2MnYvWUNV?=
 =?utf-8?B?NkQwa2h0SUg5aTg5QVRFc1JsOFZHdTEzQzlMOWRLUHF4Syt1anV1WEpjR0E0?=
 =?utf-8?B?ZE1FQlhMY25YSzMzNG9XMENIL1lkWDBmTkRXemhYbGFRZXJYQXc0NEo1aWp4?=
 =?utf-8?B?WFErT1NPNjROWkJsQ1d1eFZ6Sks0bllJYVVoWXRBZXJYU3VmSzN2ZlJvNUFC?=
 =?utf-8?B?YmhZSnBJdEVYd0hGc1ZFczFzRkI1dXZJNzBWczdVSnltZGlDRXVRdDA2dzBP?=
 =?utf-8?B?TExYNlVieFhyMEdRMHNUbjJnTTduMUgyZUQ1MFF5cGJUT3FtK3lBaHp3RnUv?=
 =?utf-8?B?ZjlCd1pxOEQvVVo2UnBrejJkRW1zV2NHVWxsZUxETVNBdGRkYWtVazB5L1Fy?=
 =?utf-8?B?cGhrV2E3NUVqQjlYbXVXaStXcWU1V3RJbVFMa05RMnFsZzNKQUZHRHo4cm5k?=
 =?utf-8?B?RGszYXplcG10NC8xQWtEQ3ovYWxRVHp4a3lEV082djZQcXBTeldMNVpNeEUz?=
 =?utf-8?B?TlFUMURWTTE1QjRzWWI0bTZNaVA0RVpkWmVkY3hFa2Npcml0QlVPNVlXOWZk?=
 =?utf-8?B?WlFrYUk2bXZwK3JQK2xlUHV5WWowSGhHdzJ0YmhpSEQ1Vk4vVmg0aFlSV1pS?=
 =?utf-8?B?clk2aDI4QWtsOFNvNS9COHUrWTdud2hNK0xUbFUzZEdjLzNKeUpzcmJEa3dl?=
 =?utf-8?B?dDloTFBWK0paSk4xUDFNZG90Q2FRejFMSXB4cW1iZE9STFgzeUhXdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f04ba65-ab21-4844-d358-08deeba395ef
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:54:56.4469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UA3UZGP63Mucbltk/5Tzk9e5ozEmulBtKKEWbx1KDEVmlOb94FXgxsnWMApGggyZAmMxFQZlpfoUs8yOUqnqTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332



On 7/27/2026 8:32 AM, Shuai Xue wrote:
> iommu_call_iopf_notifier() looks up the requester with
> pci_get_domain_bus_and_slot(), which returns a PCI device with its
> reference count incremented.
> 
> Neither the successful iommu_report_device_fault() path nor the abort
> path drops that reference, so every handled PPR request leaks a PCI
> device reference.
> 
> This is the same ownership rule that was fixed for the old iommu_v2
> ppr_notifier() path by commit 6cf0981c2233 ("iommu/amd: Fix pci device
> refcount leak in ppr_notifier()"), but iommu_call_iopf_notifier() was
> added later as a separate PPR/IOPF notifier path.
> 
> Drop the PCI device reference after handling the PPR entry.
> 
> Fixes: 978d626b8f1a ("iommu/amd: Add IO page fault notifier handler")
> Cc: stable@vger.kernel.org
> Assisted-by: Qoder:Qwen-3.8-MAX-Preview
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

