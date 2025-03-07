Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E928E8
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335441; cv=fail; b=tUpGxzuccz+zggCcUAROvFMJhYlClPsh3FTpCYDjOTXU6y+cH4isD7vI6BSq+VAgQQnZphHvmdsGCNsJE7QNwdFCmRtpR5E7cXV95KfRl5T6uPxkxOq1Q2srGjEN8l0V1Jp5aviy5poUIGpe7d0Lz6c9dkFOCGL5LbBoCEPm8AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335441; c=relaxed/simple;
	bh=GDrk34/7H251PoReHikaqoFJkDIwp2LJyTbuYxW2YY4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fG6YjecwsEntoEzhbpmkz5fM01MOzNX1+trPuTp8sOplOPDBcUFH3eoQI3L8pTFNPJVHuSBNGkzZlg882hTVywAHon0f48y1oKpKqSnZFswra2DM3x3UidTnWuXvSaVyO08XTAyN1eQk7Q/py+150ybCWG3XU3QpqkphGbzw97Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EhiuCu1p; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EhiuCu1p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhYGeOie+liXkJ35EoS9uq/n9RHb8mKY09EC3tKuQQoEbLjg3Di4yLQcPp7VI8OXt2U9E7IW+Ytaj7E08NhxAh6/frkkk/N610EY1IMr+CkUQfYa+VtFTZvTvyiRtf2XigsI55oedt05kFGEYFbof5X5lcptC2S7vSlJN8bozxtnSG6uh+bXCdT5zn8BhbrCqKi0PzmRc9GOPqdilsHh0Ad131MlfLxjyXVmVi77ayuULj5nIp2DSTYMV7wjjyJ7rrPyl5EeGIXthRru7wIYsZB9HpzvgAPBA0nf0fxHvQRUbh3dXYLzfkGuFjmx2SPY2e5QMpX3qL/Ch6LNgMQJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4jD3QevSM0uHW/MciWC9XX98AdxcnXuV2o9XNQ+gzk=;
 b=tbxNSbXVT4/OMR5CqOWm9vM4wSoLZIM1KE6PWaf1W+VQYNh9unV3R5gY8o8kTtP9jAr7ve9+KesDqyqQxpmKdQ0p5IqlDQG7yyLorNv8DE+PGXwHQhSeCvdV0sK6rMjt1CuEvpPPitvELLkcYeO129CJNpLSbh7Rr5GoYPIu4Mh0thP5R62c09djUScTY9RgifZI11F2luw7Lm81uWi8Vx/lzOgrv+o4GrQyL8cbSM62TfrftnjpyNWj0ispO0kTNOQnXM21N18pXnPmmjZ5gaXo8QXrzJi44MW9EU6GaSWaQQ0HAaxd5urbQkNWaN3cVJdQDJN2k4f6PBh1WAsNUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4jD3QevSM0uHW/MciWC9XX98AdxcnXuV2o9XNQ+gzk=;
 b=EhiuCu1p4gUYolmlPnVEApGLuAw9P8wayowITocrJrYbugoU/N/2VA42kLi32NKfzqRXrtGcJJEx8d6lTXOQfJ/k/7i0Inc1YoAApuc8KOndSsQIMgqAAjSFmDHeDzkvM5GagjJgDihQ0YtHPXdEaEXGNUFaLlztgDOupKu9FuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 08:17:16 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 08:17:15 +0000
Message-ID: <951ae02a-1d43-444a-a2f3-5f9f56fce0fd@amd.com>
Date: Fri, 7 Mar 2025 13:47:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Introduce debugfs support in IOMMU
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: vasant.hegde@amd.com
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
In-Reply-To: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::11) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 20531cad-1e64-4810-845e-08dd5d507799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N20vWGdtU1M1QkpPT2Z6NWtxay9KVVlPcTY2dVcrTmttUWlqL1RFVm1GZGJY?=
 =?utf-8?B?VERpMFFsMG9nU3A4NlVjQ0ZQRmZzQkdOeDdvTklLMGNzbXBNVE03akNmc3FW?=
 =?utf-8?B?NjRRN3luNGpTUzJBZXdhL2xmU0RQQlNvb1ZSc1JrUE56STNMdEU1SlBZcDFH?=
 =?utf-8?B?YTR0R2gzeHNRanNvaTJYblU2ZExUTUNnS3BNbWtZT2lzUFVpMUlvZS9pRWJX?=
 =?utf-8?B?OHZZeXdFbktXci82cHJUU1gyRCtPMzJzbEJJbytISFVvaXYydlQwTmwwc3hR?=
 =?utf-8?B?RXRwbVBGcjhnRVQvd3FVTlVHMEkwVGRwNVlxY0EzMW1sZWpSaHcrclFaOXNK?=
 =?utf-8?B?NkQ2eWpBYXFubHFxMWxabmtoemEwYWc1SHFJaFU0ZVNUbzZvcldCSFVucFVq?=
 =?utf-8?B?YjFIN1NUc3BSbjUzTmZ5ZkZqUEo1RUtOZUxDTHIyL002UE83RW52NWJISndG?=
 =?utf-8?B?M0poVktMY3BDSXJqWjVpRENVTGpCRk1DUWh5YzVrb0ZXRWR1RzA5ejdHZlFI?=
 =?utf-8?B?Q2dxM2hQRXM3VklMTXY2NzAxNm5GbmRVa2ZrTFF4MTRiL2xJdERBVTl0TVNG?=
 =?utf-8?B?dW8rUTRwanI2WWM3dlNUR253Y3RJRzY5ZUVnUGYwdTVYcnBFQTg3b3JBbjMv?=
 =?utf-8?B?RVpveVRDL3pKbGpUVy91eTZYOEtvWWxZN0dWbnFQaUFQRHNERGZiZ0txVHVt?=
 =?utf-8?B?R2NQbnN4dzVGcDBpckhleFZ0VGxTeUhvVytnemtlbjJQZ2tuckd1b080YmhP?=
 =?utf-8?B?M1dwdytZdzZRZW1XcXJURTR3bGRDUHAyVEo4emRpQzk3QVl0Ny9GQzA0V3E2?=
 =?utf-8?B?cmxOdVJUa1F0SmJvNm9ZWk1xQVRwRVNKTlJJUnlQZlFUTkZRQldRVWJGNEV5?=
 =?utf-8?B?eTk4Q1JJYnJ5N04xeU1MbmVwc3RGb0IwOU5BMlNQblQ1RktBTnVsK1RzN0xN?=
 =?utf-8?B?ZWxuODlvb3ptZTFPOE5FdTd2TDl3YThhd2ZYS3doL1FpU3pUcFJEU3hEOS9J?=
 =?utf-8?B?TG5BakRpMVA4RzVoQzZpNlFlZnprM05pU24veWh5N2FjVnRhVUVwUDVYR3Nw?=
 =?utf-8?B?Q045NVZZSjBRV09pY0VsSnpiSnJFL2I5T3RyczNCcDVTeWxLbk1aRzA1SFNL?=
 =?utf-8?B?cW9JZitNS3JrbGNwM0ZVekxpNE5WZWViYTZ3YmxubkZSN1RiN1VIVllhWUhM?=
 =?utf-8?B?R3V4SFBZT3pheDFVT2MwOElTK3VzNUdFdWEzRzVzQzZ2bk5DUUtVNC9kUFBS?=
 =?utf-8?B?aTNhZ3hxVVZqVHh5U0FyRVkwQ1pkd3RsNElZR00wZEJ5dlJUS1Y5OENzblZT?=
 =?utf-8?B?dGZndG9mdUw2RjFlZTJBeWEyRTNhVlpPVzRCbitZUVFJaXJYU296YlZZdWk3?=
 =?utf-8?B?TVJzY3pFaGJTZkI5T1MyaHFuZVRUVmFQV3RyLzEwQ1Q5NUQwSllCaDY4S0Mr?=
 =?utf-8?B?WnM5UFlMaGZ1L1J2SE8xb0FVL1BmeFRLS3ROUTFsY3R6NzlXY3ZoRjVpS096?=
 =?utf-8?B?T0E3TVlIVnp2dDdUTnR0VHBzaVlPZTluZzl1RGkyRkM1V0ExWGRoUDVGdWF3?=
 =?utf-8?B?cGV5bVEyU3JETzJ0UUM1OFEvaktpSWc2WEhXSHFkeXdQcmdVUXM0K3JiNmJ2?=
 =?utf-8?B?NVk1dnZUc0c0TCtYTEFCYXh1QzU3UlJEdlZ1a0hob3ZzZU9hcmRoQXJ0ZEkz?=
 =?utf-8?B?VVVwWXhWNFIxaGs2eFdOdkg0OTRSK3pZbGN2djRNVmRNUDdlQ3UzbytLMEQ2?=
 =?utf-8?B?cHdkY2FOMTlGNk5qaFROencwb3pvRk8xcURvRWVSQnlZckhGTDVKSlErV2tq?=
 =?utf-8?B?OWV3OTF4RzhCbDhnYjNDWDFVempIRFgrem5CSTN2SFo4R0NPM05JeERTdFc5?=
 =?utf-8?Q?caVJD33LDIKJG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWdUQzlnWWNNOGhkY0tEYTZvbzFUMU9GdkVWQTFxWXJHSGlmT3JmNzJYa3Jx?=
 =?utf-8?B?MVlYOWlFd3ZLYkx2NXNYcnp0bDQ4cXZxOW5wbmFUNG9PMjhmN1JiTWxtNGZZ?=
 =?utf-8?B?MTdoU1h4aFlhYm9zY1VVWFdtM2xHYzlGYk1HcWtFa0dhL2VyQmt2YW15THdy?=
 =?utf-8?B?ajZ2KzNQbDBRSGZBTFJNV3htczVCRG4yRkR6Sm1rWWtkUFJoQUx5aGl2ZURP?=
 =?utf-8?B?VytVV0FtNzMwZUdiSmtNRXNhQ05GendCWGcwa2QxZnFHVzQydFo0b0FxRThs?=
 =?utf-8?B?TEZhVXdFZGZYWnhON0w1Z3BLUGM5UXhEaDZ6R3llWm5NZnFURXBURTRMMXNZ?=
 =?utf-8?B?d1pUSEVzcThFREpUYlkzcU9VTS9CUEpRT2I0cFN0QWJjWFJKZzlvRFhkM0NB?=
 =?utf-8?B?Wmh6Snh3YkRxbEIwcWh4b0NzUXU4NHlwUDBKakVaVy95cENoblgzbVkweUs1?=
 =?utf-8?B?L0t6Rm01TG52K1dVcmprMnB6emRRYjdsVVNxRFhmSTl4V3AxM3R3bkRqL0E0?=
 =?utf-8?B?T1V0L2hTVDlTSVhNQVpHM242d2Q2UFg3anM5Z1ZLRmk0ZzlsSjFoMVltMXp0?=
 =?utf-8?B?VFh3djQwNDJnd3ZhOHNZZzk1bytJa2N4R3AyamlkSGFZTXhIdlJGalpEZkFG?=
 =?utf-8?B?b2NkU1BwZDFIemZOT3l5dW90dmd4RzJJZjYxT2VBcE5GT0plczk5UFZsckpm?=
 =?utf-8?B?bnA2M016UmwvRG04bzFqcEFYclpYaWZwWGpIRHI1cFpEakJ1UFpjY2dNbXNN?=
 =?utf-8?B?dTkyZ3hWZi9IUnN5RFgrcFBOSnpBbnBMTlM2TGlJY25iZFRscGx0T205bU1D?=
 =?utf-8?B?dEljZkhqOXZsV0EzVDRlQjF5aWV4bFJQUzAxRi91cEw4dkxGbmsxdHFVNW1l?=
 =?utf-8?B?MXFZSjRnaXJ3dm42NDRNS3Y4OTZ4MStzNHNyY2RMdXlvcE9EL1dERm1FZDBO?=
 =?utf-8?B?bHRJZTNxYmpyU3ZiY3A4cUY4RzRmeGExb29iY3JOTUxHVm5FczQzZjhjT2lM?=
 =?utf-8?B?amMwTGcvVFo3Njk4NmUzTERXdVpvVzljU3VJYkRZdkgya0wvWkIwbGc4dkN4?=
 =?utf-8?B?UURwaGRkQml4NVhsV3JRT3J1T3NyR0F3TG50cnNEMEZTUi9keTh3SElwTTRi?=
 =?utf-8?B?U0ZWeFpDeU4xRGFFMzlsU2wyNU1JN0tlTExnaG1ndk9OL0pyd2JxYWhSS2N3?=
 =?utf-8?B?UXNHLzBBVmxFZDEvMVNobkpwRnY4a1BIdTBteEgrYUNyVCs4cEltMFg4dnFQ?=
 =?utf-8?B?eXFPWDZpQlhDRDltVjdRUEtNWGp0TDhHWWRzNTdnV0hGQkc4cW5xZVJMOGZo?=
 =?utf-8?B?WnYvd21nOUZ4UHUvQ1E3WVRrS3gzSTNERjExNHJMcVlhUC95T3hKbHFoK1Qv?=
 =?utf-8?B?WnBWYlAvWk5vM1NYYy9XZjVrQzlqMzlSMHdkblQzMEhLNHhvTFhHd3BDM1FW?=
 =?utf-8?B?aHBwaktKdXNMcEVVZExBSVhwR3BySndpZi9ESlZLeDF1d2txSUVIUGFTYU1M?=
 =?utf-8?B?Z0VpSXFuRVcrUlNqYndyYUQ4dlVHQUJyaTQzU3JCWmp2UE9MMytZbWpYMWll?=
 =?utf-8?B?U20zMEF2OS9ISzhuZzdqL1ZVeUhDK05ZMzltWGVmM0JPM0hGbW1GekFESTJn?=
 =?utf-8?B?b0E3SnpWSnE5YzFhbVo3NnV3SVBHaXBGcnk4MlpJNUVkZ3VrQmZsNWlWY2RI?=
 =?utf-8?B?VTlLUnVhTWk3UGVmeW1Ta1YwYnNvZFpLZ0kybER5Y1RoRmh1RjdPSjB4eW1r?=
 =?utf-8?B?YWVCNGpPRlo4M1I1bGcrQ2xKQkZzUkIwS21UNjdBM25KTXdoZHRIRDdPSVl2?=
 =?utf-8?B?S3AyamJrTjU2UG5MWTdyLzBqblRPV29rNEhsOXlYcWVqNTkwUm5wdDNXQWxN?=
 =?utf-8?B?d0RaeHM2SFpnTC93SkQzWGhWUS9GQTRMSlpHb1M3eUxSenNkSjJ4RWh5eXdF?=
 =?utf-8?B?NG1CaTRhdG5wbGxHUEwyTU83MTJ0NXdvbG1YVkJSWXZnT3RSaFM5QTRnRTJI?=
 =?utf-8?B?bVp4TXp5eWlXSk4zOTFBeHc5a3hLS253YU1HWHBBNlhzRGRiWFdPeFBLQ0ty?=
 =?utf-8?B?L3hPQ1Y3ZlU1cllENHphMWNvOGF0ZnliTTk0T1FpZVJia3pYSVVIbHhYT1Vl?=
 =?utf-8?Q?kP/+fjK+XPQglvU/KOr1rPlpB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20531cad-1e64-4810-845e-08dd5d507799
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 08:17:15.2222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WM4Q9JuWGXFQv3fZqNjRpYJMU/Zy0eEXArXxAWyl6ZAP4Pg5fyo0kC/NrEhcr3PO9fM0EZyBfy5Y0xpNqqLjDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964

Hi,

I hope you're doing well.  Just a friendly reminder to kindly review the
patches at your earliest convenience. Your feedback is greatly appreciated.

Thanks
Dheeraj

On 2/6/2025 11:29 AM, Dheeraj Kumar Srivastava wrote:
> From: root <root@BLRDHSRIVAS.amd.com>
> 
> Introducing debugfs support in AMD/IOMMU driver that will allow
> userspace to dump below IOMMU information
> 1) MMIO and Capability register per IOMMU
> 2) Command buffer
> 3) Device table entry
> 4) Interrupt remapping table entry
> 
> Analyzing contents of IOMMU data structures helps in understanding IOMMU
> capabilities and behavior and debug issues faster.
> 
> 1. MMIO and Capability registers - Add support to dump MMIO and Capability
>     registers per IOMMU.
> 
>     Example:
>     a. Write MMIO register offset to dump it
>        $ echo 0x18 > /sys/kernel/debug/iommu/amd/iommu00/mmio
>        $ cat /sys/kernel/debug/iommu/amd/iommu00/mmio
> 
>        Output:
>        $ 0x0003f48d
> 
>      b. Write capability register offset to dump it
>         $ echo 0x10 > /sys/kernel/debug/iommu/amd/iommu00/capability
>         $ cat /sys/kernel/debug/iommu/amd/iommu00/capability
> 
>         Output:
>         $ 0x00203040
> 
> 2. Command buffer - Add support to dump per IOMMU command buffer.
> 
>     Example:
>     a. cat /sys/kernel/debug/iommu/amd/iommu00/cmdbuf
> 
>     Output:
>     CMD Buffer Head Offset:339 Tail Offset:339
>       0: 00835001100000010000990000000000
>       1: 0000000030000005fffff0037fffffff
>       2: 00835001100000010000990100000000
>       3: 0000000030000005fffff0037fffffff
>       4: 00835001100000010000990200000000
>     ...................................
>     ...................................
>     ...................................
> 
> 3. Device table - Add support to dump device table per IOMMU.
> 
>     Example:
>     a. Write device id to dump device table entry for that device
>        $ echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
>        $ cat /sys/kernel/debug/iommu/amd/devid
> 
>        Output:
>        0000:01:00.0
> 
>        Dump the device table entry for the input given
>        $ cat /sys/kernel/debug/iommu/amd/devtbl
> 
>        Output:
>        DeviceId             QWORD[3]         QWORD[2]         QWORD[1]         QWORD[0] iommu
>        0000:01:00.0 0000000000000000 20000001373b8013 0000000000000038 6000000114d7b603 iommu3
> 
>      b. Write device id to dump device table entry for that device
>        $ echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
>        $ cat /sys/kernel/debug/iommu/amd/devid
> 
>        Output:
>        0000:01:00.0
> 
>        Dump the device table entry for the input given
>        $ cat /sys/kernel/debug/iommu/amd/devtbl
> 
>        Output:
>        DeviceId             QWORD[3]         QWORD[2]         QWORD[1]         QWORD[0] iommu
>        0000:01:00.0 0000000000000000 20000001373b8013 0000000000000038 6000000114d7b603 iommu3
> 
> 4. Interrupt remapping table - Add support to dump IRT table valid entries in
>     "iommu_irqtbl" file. This supports user input to dump IRT entry for a
>     specific pci device.
> 
>     Example:
>     a. Write device id to dump device table entry for that device
>        $ echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
>        $ cat /sys/kernel/debug/iommu/amd/devid
> 
>        Output:
>        0000:01:00.0
> 
>        Dump the device table entry for the input given
>        $ cat /sys/kernel/debug/iommu/amd/irtbl
> 
>        Output:
>        DeviceId 0000:01:00.0
>        IRT[0000] 00000000000000200000000000000241
>        IRT[0001] 00000000000000200000000000000841
>        IRT[0002] 00000000000000200000000000002041
>        IRT[0003] 00000000000000200000000000008041
>        IRT[0004] 00000000000000200000000000020041
>        ..........................................
>        ..........................................
>        ..........................................
> 
>     b. Write device id to dump device table entry for that device
>        $ echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
>        $ cat /sys/kernel/debug/iommu/amd/devid
> 
>        Output:
>        0000:01:00.0
> 
>        Dump the device table entry for the input given
>        $ cat /sys/kernel/debug/iommu/amd/irttbl
> 
>        Output:
>        Device 0000:01:00.0
>        IRT[0000] 00000000000000200000000000000241
>        IRT[0001] 00000000000000200000000000000841
>        IRT[0002] 00000000000000200000000000002041
>        IRT[0003] 00000000000000200000000000008041
>        IRT[0004] 00000000000000200000000000020041
>        ..........................................
>        ..........................................
>        ..........................................
> 
> Open question:[Suggestion from Bjorn Helgaas] Instead of using device-id input with
> 	      "/sys/kernel/debug/iommu/amd/devid", can we have something like other drivers
> 	      have "/sys/kernel/debug/iommu/amd/<bdf>/".
> 
> 	      Each "/sys/kernel/debug/iommu/amd/<bdf>/" will have "devtbl" and "irqtbl" files
>                for device table and interrupt remapping table dump file.
> 
> 
> Changes since v2:
> -> Patch 2/8 and 3/8: Use single file mmio and capability for input and output registers
>     offset and registers dump respctively.
> -> Patch 8/8: Correct path for files "irqtbl" and "devtbl" in Documentation
> 
> Changes since v1:
> -> Patch 2/8 and 3/8: Use kstrtou32_from_user() instead of memdup_user_nul() --> kstrtou32()
> -> Patch 4/8: Dump command buffer head and tail offset instead of head and tail pointer registers.
> -> Patch 8/8: Fix bot reported warning on v1 upstream.
> 
> Dheeraj Kumar Srivastava (8):
>    iommu/amd: Refactor AMD IOMMU debugfs initial setup
>    iommu/amd: Add debugfs support to dump IOMMU MMIO registers
>    iommu/amd: Add debugfs support to dump IOMMU Capability registers
>    iommu/amd: Add debugfs support to dump IOMMU command buffer
>    iommu/amd: Add support for device id user input
>    iommu/amd: Add debugfs support to dump device table
>    iommu/amd: Add debugfs support to dump IRT Table
>    iommu/amd: Add documentation for AMD IOMMU debugfs support
> 
>   Documentation/ABI/testing/debugfs-amd-iommu | 114 +++++++
>   drivers/iommu/amd/amd_iommu.h               |   4 +-
>   drivers/iommu/amd/amd_iommu_types.h         |   7 +
>   drivers/iommu/amd/debugfs.c                 | 350 +++++++++++++++++++-
>   drivers/iommu/amd/init.c                    |   5 +-
>   drivers/iommu/amd/iommu.c                   |   7 -
>   6 files changed, 466 insertions(+), 21 deletions(-)
>   create mode 100644 Documentation/ABI/testing/debugfs-amd-iommu
> 

