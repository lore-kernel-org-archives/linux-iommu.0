Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719BD382383
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861813; cv=fail; b=fg3JdRHaCxkIX9+VHNoxLFn62VmWiSvicf+fvylo9Wq1z/eu1lzZ1zVGZ2AP8W9YqFZjazyG/vpWp1DWMfgvJuwzJ9lUiYP9DNUlBDoJrfRB8neLMPF8ItGVnT+ny8PphSriDFo8uTgWK0GwFQ4EiYxcMIGnp8OrPKTG8xPJfHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861813; c=relaxed/simple;
	bh=ZKRYKNcmEg5pMfVKLsiV4zsxos4ZYoF5ivb2/DffMg4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W4SMfvZSQWdbYhTjb5LFTrzllU7bI1Xp1Ak2g0uE534qW2c1Zzip2+bW1/Y4qoq+lFpB+li79EZ5imLgaN7d6V5nud/mDUXozRaTIQwwEzzz4ezOZWB6MiIG906vL/XLY+cFwJOFoRQnalkUXDFsfB5ZyCoIHY9NEKoDfoZeK+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YNVl7IVk; arc=fail smtp.client-ip=40.93.194.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YNVl7IVk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HU4/SfnhGxnatKyruuYf5ukhJHvJlIcg1yFCkzcGYYgOn8dVzteL3JAaV7IjDsOOQn0Rjm3a+oo9m6bTXQML0/zUc/xhG7Ht66fepQmCUTlsuvx+IzVp9BJx8/xVsLK0pusApgkIiV720wUiGQLmsXIt25OAPc9cEA4LPKBdm62c/G8fPtaP1GlE3aZWsWAmYAeb28d2oJLWDZy2f8z9d2QGikokEfQChf4ASFoFMeODhtvVMW88Yma06lwydsBmSqr2OPxZvfF69PWvSgjSW7uDhDGpv/PSUsAjR30FyRxree6PezvFcaKXAl3IwmK+K0LY5ZzgQv2X+U9aDuzepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCK1n6pp3fM8275bivRmDHSAXwcyrLl236K6S4dCRzs=;
 b=Vyw7MvnQvhhocBg0XIH/qldMbe8Mcgy4Y9RlRRHrGX+a3FXllQlhrnAOc9OHhG92yTTMRYi6yh2ohYclGNosYRF25YFnqn+R2LQNw42Nizp/fbez5LyPeMrosDCeLWIeg/3UIeSG4NRcCP9MocVbCM0i9xCe+g4REcJ7Crlik2ikyleFNakLTs1QcZysQsyKzKYQriFOtT79faU7JxOTR8hp3ZTOd3f8PExyBEDYOvr7F7leOOjQHRmxpZfaTC3UK/cdkGYssks9bKvGqLlQDy0GOGYPHGa9oV5msmsfsnhTPYfb9OLyfWI3WFs5iZmmwM9EvPPyhSaLVOvvLrzE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCK1n6pp3fM8275bivRmDHSAXwcyrLl236K6S4dCRzs=;
 b=YNVl7IVkovPYh6HwJg9uhTUCN2vsIRS5UMRi7nNBG9cc30F7/ud/8pEZqc+Q7ooY+B5BRaHBCNnD7WRXwzDBDA9FrmKqyVfp6wnUFDPYiTHWXWE5i2EX55wQwQ1A7pbE8bC07+Ccyaid5eWbuVeE7ay0T7rPjMB6jLZICfiGmfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 09:10:09 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%7]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 09:10:09 +0000
Message-ID: <63e3b861-be30-4819-91fd-f8a5be60f3db@amd.com>
Date: Mon, 30 Mar 2026 14:40:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Fix illegal cap/mmio access in IOMMU
 debugfs
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, ming.shu@amd.com
References: <20260319073754.651998-1-guanghuifeng@linux.alibaba.com>
 <20260319073754.651998-3-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260319073754.651998-3-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a2f4de-f192-4cc9-70c6-08de8e3c2457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KjsnIUyxLTIRBgCK5D9vRy6eTJSckbCWXkSivBfPbgS+rhUpahPZbqyygbC7qy/xtBHE6vqtPf5GlumnTlRlqqf3Kth3mJ5JHF1ayWxiDyl9fZ6wP7/QvDzk8Oj+dR5+euk0uh08eVsmUZ0/lGjbWCXjogKqLQWLOcVcdd9qT2RlrJBcUnFGBtpA36kqgOHjT4toAvCxt9X+tdbKSf8YZ44q6lXS4DbEEPFr6PToPa5j9qSx6/S6FuY06V5SXZc4/8lNoHB4IiaVrnHAjTo8tmkoe+EoIr39AjSW+/GA6LwpJVlxLxnBflMmTO5hZhVesA3VCbtJDgNst1orTfGDFTm9NVeaRhrbY9ERf06z62cQynm++gaP1Iuncro91XLGEmB5c2sLfCzJ+mPHwm6zhnWlXS/smbZBaB1X6oHzj48aRG+SGtE/ck1WjUeOsvRIVBwNnQw5BS5t9IZnNu8BrQ7+hZrVzOpBR5SJ4g2/OyW2CSpnr659+XhlKKpMRggn0v5vo9WBZf8ggBWUFJU/bcA20oMzUC33PS7D0HhZnmjxU1NUmJJXt+S+j2n8BG0SqUvv9C39Xozw3thCUAsCM+dcYGKTiHmmlrRJkqWGCgGNXbw7q2b+eUF4JjUeZBBOz4ygwIx6G44M7qWbjsDL7DeYkmGL9tpIpuNGvogDuSZHdXfGr0c3dQgjxNtxhMCVMFITnCKYoRT3RzjvkQ2cSLM519AClDnOlliwVqhgHM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnpLSVRkZzNOWEJKMUEvakk0WGhvTHpTd2tCV1ovU1RDRnZvc0wwY1JrNWhp?=
 =?utf-8?B?ekZpa08rbnNCb2NHK1UxaEptNkJoYmJkaTFpVTM1SjZ2UmRLSGNXQm1SY1k2?=
 =?utf-8?B?cFhkYjhQWmIybFhMMHVwMVA4SW8wUHc2dW1oZXRJTkt0aE84RnNrcUw2MUg1?=
 =?utf-8?B?WjFyWmlpWXVHaXpWeGsrTFhURXVhZFJ2cHdxSVU5Vi9iTW1LcXhrNjhSS2hE?=
 =?utf-8?B?VHJDcXh0NGh1aXpHVndBTjVIeVdNalJXSjlZYmcxbnFHU2JsaXE4MTBheHhL?=
 =?utf-8?B?S1lkdHkrVUxabVZ5UUlIeW96ZHpTYUxPWk1JVno3ZjFadXFuR3ZBeitVc1FK?=
 =?utf-8?B?NWNycnhSWWtpVmNiYVZTQWlvTlh4cWRDYzRIZEZRTSttRVQ0YWNrNXNQS0Y1?=
 =?utf-8?B?SDBPbXJqMXk5Tnl5enBRWE9zMkwxUWZuWnZIeDJ1SkF0SklleitKRURuMnB5?=
 =?utf-8?B?UGFlVjlxNEFYa3BvakxNampmT1Vkc3ZtY05DZ3MrV1RqSkpXWkxqbzVhMllQ?=
 =?utf-8?B?QUN6MVJ2VkVPVUk3U2RGdjEwNWY3Y1JIb1l1a0lzQmViQ01YekNhM29GeW83?=
 =?utf-8?B?cnRNckdUSE5XY3VvMWt3TWsycDgxSVJTcGFlUmg1SFdNNlczVjhHR3lyRFBt?=
 =?utf-8?B?WnlhQ083cExydDdUcnZXVmxKTzMwQVVlWStPZzlIaHNHODJxUDlxTEpQMkl6?=
 =?utf-8?B?Tk1VdURxVnVNYS8yOURiY0ZQNWNwWEJHbjU1VUROQVZDbHNOSExFZ0xxMWhp?=
 =?utf-8?B?NWliQmQrMTZtdXFYem5lN3ZnR3pPc0J1NXMva2NtenVDZGZSQk8vUXVqejhD?=
 =?utf-8?B?ZGRKeWhwSnZtTC9laHgrZFBRY0lNVVRSQ0lzUnVVb2drVUxoMGQrUnFWamFP?=
 =?utf-8?B?N0cvZG1iN1FpNmY5V29iQVRMU2FYbkF5NS9IdFNHYnFic0YySEM4ai9DRGJD?=
 =?utf-8?B?RDdWdWNRbW8wZHpXMld2YXhDVXlIQWtUa2w2dlhRT0Vyd2FSUEFDMkpRNlZv?=
 =?utf-8?B?S3JOYjl0eEhpNHdZNGFsanhzMXptR3BJQkhIRWFFeTk2c3p1YXlOOXdWVzZ4?=
 =?utf-8?B?NUNrRStjUUNPaEh4YXZrR1crNVcvNmlBYk1PY1ZaOVVBUGtRTzR0U08yVmZF?=
 =?utf-8?B?M3krUTd3SGpFbnFXRTRMWEl0cFlaL2hDcVJqT3F1RGsxKzl4SkdqVXhFWkhT?=
 =?utf-8?B?N2lZVkpOQi9Xcmx4RGlFbVNMRmFWaEF3Qm90VGFGcDVGVVRDdkxRczRTSlds?=
 =?utf-8?B?UFNVdGMwM0JRS1FPSHpHcjBveDEwNDNkZDlmVVdWL1FaZ3RLT0NBOWJQcGcv?=
 =?utf-8?B?SStBUUl6aDFybmdSQ0ViZ3JxRmhHTTZobDlLU0FFWlNEMHJpek1Gby9pVU1H?=
 =?utf-8?B?REFhcUpKUTZIblkrbWtwdTBxd05ORHVHUWFCVUlwUWRyV3RxR0piQXlXZUQy?=
 =?utf-8?B?QXpXMldzTlVwS3hhUXUzaHpOUnV6L0srZVM4SEFETWVXUC9yR1lLVWNUcHJo?=
 =?utf-8?B?aXgxSG9mNDE0UlR0b3M1eUJ6UElZWkNMWFlIWW9zVzZlUHNkS0dpbHNySmpC?=
 =?utf-8?B?WEt0c05kWHIxZlY5SXlpdkVJbGhmNTYrSmpHdEtTamMvby9SQ1dlNlZLRlBj?=
 =?utf-8?B?c2J2MmpqdTNPcE15RGlsOTh2N1NIUnkwaFk3bFM1OE56ZHQwbkFJdkJYckhq?=
 =?utf-8?B?QlBBQ0U4RVFEWERjT2x5RE9oc0M4Nnc0c0pFOUMxV2xlRG5CUmtKMERBczFt?=
 =?utf-8?B?WGJ1empPRTFKaGJtV1JpTGdSZTdhTVRLTlVkaFhmZ3RQbHJuQ3ZIMEFabm5n?=
 =?utf-8?B?REUrVUdDU0laV29NOXo1YWczVmRvajBWN1paREFUdmlDQUpqSnI5Z1hDcklV?=
 =?utf-8?B?MlpSaE5NRmJMRFNScXMzYjdGQ0pROTduZUtMZjRYVjF2dXRrRGRLdEhmTVBD?=
 =?utf-8?B?TXVvelExRGE1L09yamlJeG1xQUc5NlVNUDB3anRPR3pTU1hnR0E0SDVURVRO?=
 =?utf-8?B?R2t1SjFSNlB6WlJqWldZaWdzeGdiV2ZyUXFHVHRTekM2ZG9WbXk2Y2hWWGpZ?=
 =?utf-8?B?NjRjVU11S0Y4cnM3cWh5em13eFZtUGFZRG1FNkhHVEw0bVE2eDVYSVA4QmhO?=
 =?utf-8?B?YTBPZU8yUXl4dENhS3NBc25SMURWTkhPWlpTb1lBdEE4MDhvZ3pxSzJDRVI2?=
 =?utf-8?B?SzQ1aXRzQWhUa2J6REJ1SW5GNStNWndRTEZqTTdkZUlmSHpkUVJWUVlHbjQv?=
 =?utf-8?B?TmV4U2lrNnpDckM4cWJqY0pmaFhzUVBTTnlmelNKc0lGaERHajE1bjloVmJR?=
 =?utf-8?B?b2I0ZXlHbzRJLzBiWjlHNFpIT01XOHRnZElvNjU4bW9SWG9ja1pIQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a2f4de-f192-4cc9-70c6-08de8e3c2457
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 09:10:09.3483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PP0ttp5toe7agxF+VSRPn6RXwTQkFVET0Lhs39sFdqzRMKz+r4tAoJIvjfQyTKx/pz9+0hAR62nuFXLPl9j8rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088

On 3/19/2026 1:07 PM, Guanghui Feng wrote:
> In the current AMD IOMMU debugfs, when multiple processes simultaneously
> access the IOMMU mmio/cap registers using the IOMMU debugfs, illegal
> access issues can occur in the following execution flow:
> 
> 1. CPU1: Sets a valid access address using iommu_mmio/capability_write,
> and verifies the access address's validity in iommu_mmio/capability_show
> 
> 2. CPU2: Sets an invalid address using iommu_mmio/capability_write
> 
> 3. CPU1: accesses the IOMMU mmio/cap registers based on the invalid
> address, resulting in an illegal access.
> 
> This patch modifies the execution process to first verify the address's
> validity and then access it based on the same address, ensuring
> correctness and robustness.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>

Looks good.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


