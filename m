Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3B558B6
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662057; cv=fail; b=BJchfs5hWAoKb+KJNKLRjITetj4biuh5EBdnR1lD3mahFFXDMqL/JpFilyZ/1gUmsDo7F7Q0Xsc/ASsUpJoivPR7OMjoSNO9S78N7keZmkZSHQ4Q7UW2ox9Vzus4DR28bDgNdLjJmqDiPLhVcfURlSvYkBcNBUEOBSVHbz9H0i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662057; c=relaxed/simple;
	bh=9pBsENr3/fj9xDfHvDrs7f2JgA/CJqcZznkflspTu38=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lxF9I5GT/jkGqguGTZHZOuP0ivZzPi+wBP+csvm26cXIV0y7BbEL+6qflwkdQpVYVLP3iNeve8PZ9kByu6rYBBMnZg4Ay1X5RZjqVKCFRd0IXSzsDDrfMz7+/61Lck8Mb0ZlYj5Sblp/4sBhSUjAIm6tigltFntZfZvx6AcO11g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h44WMQwX; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h44WMQwX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COfHW/FOF/OPRfGdrb1bfYtxqsIiqXq9GHgi4tMeyveJ5eXpdeJp2a8K+MbowmhZM5sgFmz6a61pdZ9jBRmVQLsFDXPuwFZqf6EVdeI4lnNyjfjElJ7RATlKypxK8YUvePF80v7yu2LRVWXF8muM8ezTKBa2IAdQBx9QZN93dGyJBHu/Acseevtda/HiIsBvlGkb57bhhJ7stfp/vwVfb9D7L0VleuZ4hhzZV0qqGKsoxzyBgj0ICJ24kcFhXP0ugheiDrtqjRb2O1aUy8+hGT71rDh64VvSRBWApCyVn2hJ/o+hsf8eijOrOZcKFTNPmRjq8dqkQUSzYecJXcJ2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b22D74VxQfqa334DB1lGwm63w0JBg/z4HeAIp4E+U8k=;
 b=JmfN5gvUYEKjCg/w9OEUPAGcMhJZ0Re88M12EovrefRga+ZoP1UMv8aHX3pqYlG4LwkB4hjjgUuge2daWqh25BTlxVMthW66xi70Qgdk6M2O+7vbsgm5wYGjXVEH3Bb7R2EQQxcqotlX/wJEtIUQV8HEUtKT/9YyoWw0DakjYXOADwLVbVaT2pnR0ay5+YF07jnIzksLQr1u4+/fh9bkRLpSQ0CWU87uw2n9RO+xGvzKb597PeNMeqTA3pFTvJAAYk2n1DGrBchdsrZsrQEGXLaN5EW3cwywLv8EoVxbba2q4vIvBtjcPjdc8YiBpNwcwg2CZp2FkH6R3OBWnQg6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b22D74VxQfqa334DB1lGwm63w0JBg/z4HeAIp4E+U8k=;
 b=h44WMQwXePcb4LHP86sxZnS/iEG8Pxfdlnf0gb8DfQpXw3FEnu4xXBkjfLJhurZ3XydiEKmOmznzXVWL0g7wrOcw1iAqle0D/uGLiGZ1Rj3QSVmFSsweOQpLQpn40fqLY075tw8TITj8npDVYJJQ/SJa3LMeVza5ZsPJEU289Do=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 08:47:32 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:47:32 +0000
Message-ID: <51b252b1-7fa0-48b6-8055-d512b61c9016@amd.com>
Date: Mon, 26 Aug 2024 14:17:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 kevin.tian@intel.com
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <689eee1c-4b84-454b-8dc5-a5f35abe1631@linux.intel.com>
 <20240822124307.GC3468552@ziepe.ca>
 <ec556b8e-4a8c-45ed-a3d2-319ef9fdd04f@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ec556b8e-4a8c-45ed-a3d2-319ef9fdd04f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::24) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: c34e482f-8ff1-40ba-875b-08dcc5abb936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHh5T1phT3NzdmhjYmJ6SVJ3R1YxUkx0RTF6Tnk4OFdOWWlpWUlJd1FNRjhy?=
 =?utf-8?B?L0FJblhyWU8vaDZqaU1yS01GVlFTbDFtL1dQY2wxb1RDQ2l6cXJaN3dzV1Aw?=
 =?utf-8?B?Nm4xb2hqNk4wRU5ZU0tEN0FJazhPbXBqQjllZmtXMEJNbXloU3VOSUpCK3Nx?=
 =?utf-8?B?cmVZYyt6dnR1aUJCRFo3clNtdlR2c0tuYU5IWDJIWFJ0QXhzQkdTellUNVJ2?=
 =?utf-8?B?TEUrNUd4ajhaRTVSdkNpK3I2aWZ5Tnhja0hKamh1U09jTXJDU3FHTmRMU1lZ?=
 =?utf-8?B?b3hNd2Y1TUJNTVA3Y3hyNXJoZmFGQ0J4ckt3NnBKWk5BNEd0ekZLQnZCdmp3?=
 =?utf-8?B?Z3o3WVlPWHJRYUYwZXgxNUY0Y3U5UExpc2JsMmoxN3FHYmlockNTVk9yb2I3?=
 =?utf-8?B?T0lpNHRrQWVXbGhlUFZjNnQ4NmFCZ1JQUUJLN0xTaG1Nb3hVa0VQenZmWWVy?=
 =?utf-8?B?UndwUVlFMER4NEY5d0xpcWtGeVBZTm1oblhYeGJBTHU0bm9tdjdlZkQ5Nlp6?=
 =?utf-8?B?VHdmTmdzaXZTVlUzaFVPNlI4SVo5cjZjMS94bDFoSkErZGJLNkhhV1NCQXY4?=
 =?utf-8?B?NGZRTXhHd2JyNzdZby94bHYycno4QW5tOFI0eThZdVFNVlVnSmVlVm5UQzY4?=
 =?utf-8?B?VHpBaSttcW1SL1EzejdmeHloUDJsR0tqVHhpdWlQZ1RFeHFtTW04NlFsMnRz?=
 =?utf-8?B?bjAwYUFIQnVFUHhlbWdwWkpFWk92MWZKYk9vTERpM00rd29yODVzbXk4OUJj?=
 =?utf-8?B?N1FLZmswUG9GV3k0UHVhalBnQXZ3Slk1cVVManFtUnJidDhoVmpCdk9DY1ZK?=
 =?utf-8?B?c0Y0MTZWNFIrRU1XUE5YampWTVM5RGNxdHFGRlMyZGxEcmZ2SkFlZUJ6R2ZM?=
 =?utf-8?B?QWRYNS9lZHhkVktiYWlDQUR4c2F0d0dBRzZ1aDFWd1Q3MEx0UHM1a2tYcTFM?=
 =?utf-8?B?alltOW9DRllhcm9SRFNRVzhyY0NXRGdjSm5QbDhneXdURkl6TVFnQzFYc0tW?=
 =?utf-8?B?WE9YL2tsYWMrUkZpNzNSekYva1NXa1BtNklHZlBlQzB4NkVJL3ZXQnNrK2da?=
 =?utf-8?B?TEUrZ3NaYkhWSmc5VDQybWF4MnpQNVovUXpCY1ZXaE80QXQrWmMvTVdoa3pz?=
 =?utf-8?B?Y3lXVjNlT01BRXlreG1tRHNkNWdRTWJwS1kvNHViRjlqZWFhYkpmN0I2R0RE?=
 =?utf-8?B?YUxhYnErbmdCc3FHVFJiV3lSMGVZcmZKL1ZrYk5LNDFvSnhsUlBnS2F1eFpJ?=
 =?utf-8?B?N3ZqcDNRWTZGWVJId3JaUExHMXZHcWlzalk0bVNvT1kwenFyNzhLWU5FWWVH?=
 =?utf-8?B?K2VlRnozT2ljcDVSM0lhTkIwRXF5U01URVZFRmtOREVST3RxYmpMQ2tOUkJC?=
 =?utf-8?B?UksvNXYwZStOWmJZejkwV3BvRnA3d1VsdzFNYTB5ckNPdC9JQnArR0Y2Wnkz?=
 =?utf-8?B?WVI4NnFCQ2pvaHpOQ1NJZEFXNzRxd3kvcWE2a0dyd2tQM1MwVy92Y1NzaUFX?=
 =?utf-8?B?ZUlpelJzTHBnQlZUR3kzVlovc042WjdTZmdWYUMrNUkwUzdKRGJyR0RiUUh4?=
 =?utf-8?B?RmdCQW9ldnpUdmNYOE14M1VzSmh1d2k5MlZSUzNIZjc5UUdKN0VscDhLSXEr?=
 =?utf-8?B?bGp3TzRPOFh3TzdqcTZFNWhRUlV3NDJsZ29aN1h6MU5oQzUvWWRuaGFMemhJ?=
 =?utf-8?B?YURXOE9nbDAxMWg4eHd5MlNTeTJETFNBNHVGOTRQK1M2S0ZYWjRmUFg4RW9j?=
 =?utf-8?B?K3MwNGY3WmZHY0RGMlJZOWlsNUZqMjh4WmN1alpHL1VMVXVZVktXelp4Q2Va?=
 =?utf-8?B?Q2Z2MlNWcVNOWkJvRU9uUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXRYMHJZbGVHMVhpajdkVlJtYTZPUzlFSm5oYitBZkY2Uk8yYURYMDJZYXN3?=
 =?utf-8?B?RmJtNjkvUHZUZ0JNUGkwOGZaMHBxbkkraUx1RkpPaEZMVFM5N21GeVQ4aXdU?=
 =?utf-8?B?WGtYN2FyVVF1Zk1POGlQVyt4NUo2blNoYU9lN0FRaWtRdWNhVWJCdGhpNEZH?=
 =?utf-8?B?b2hPU1oxNVFYZllvd0ZXRStyR1RGVW9qWURxalpKQVpHWHRyalU2cWswRlpQ?=
 =?utf-8?B?UWNDNEVTSTU5V3Q2R3hSWWFnc1NuMWJsaGdCVDRVbFdRam9uRUN1S1NFTG50?=
 =?utf-8?B?K25DY3lGbGxCMm9wY3BnZFBJUCtES1VkVzNqQzc5NzRnZ1FqcEpQOTdvaStN?=
 =?utf-8?B?ZEYvaTRVa3B2RkNUbUduLzdkcnBwNlFjWmFUZWJ1aHNIamV0a001RFUrY3NM?=
 =?utf-8?B?d2JDandLemZKY2FwYWJIdXFnTzA2Z2doMmJ4eEZyNDBHL3NXZ2kwUlNVS3lu?=
 =?utf-8?B?RWFwMHc0a3FaWS9RNVo2eXR4TGhralpFVWpyZFBMektES0R0SGsvU0t4NVVG?=
 =?utf-8?B?WndzOGpucHJTWTRjckpuajRybVU3Zm0vN2JrNU80WEsvZk1IWW5aUFI2K1Ew?=
 =?utf-8?B?ZllzRTBYVTlPYXdiNklBU1JIVHdObGRaWG9ueUJ4ckttTG1YMGwzMGhYdnky?=
 =?utf-8?B?RmRNRTN0a2tzaFQ1Nno3NmZaeHZWOHcwV2lXdXRMaUhHbjVva2JsT3Jla3RS?=
 =?utf-8?B?VUw3bjl2eWg1TGRKelRxbHIwNGtwSm9lV3o1NUJjdzdKOHgxZVJ6UHd5aXF4?=
 =?utf-8?B?RmtpWERmZDZQVkxOY0VNM3N2Qk4ySmV2dHFRNUpud01lOUV1V2hlRmFndGhv?=
 =?utf-8?B?cmFLMTBUOVFJMjlrdlRJa3Ezczk5U2tyclBRdGVkTmtJWFM2bWFRY3I2bE1J?=
 =?utf-8?B?SUNmOGNrUzJMNUhZdDNlTGs2SWxKdHcyWWtGNDJ1ZkkxQWNQRXY3bFh0NVh1?=
 =?utf-8?B?Z0VmVlF2VkFrL21lZjRxQ0ZMUDM2WlpkbkVmbVAyN0JSM1JqaFpXWi9JVDlw?=
 =?utf-8?B?NjVFV1l1Mi9JUjhaNHJocHBhUjhFVHYwTmNaRExUSFN1MGNIRk1YUEZZRER0?=
 =?utf-8?B?bldBQkxQZnRaRm1EcDU4eGUrSjdlMDR3Y2I3c0REcGV4Y2tuZUFPcmtDbDl6?=
 =?utf-8?B?N0MvaU5wNi94enRMWDZEb0daNDZ2SnNFVDFOVXhBUk1XUm1wd2g3aEw4Slpp?=
 =?utf-8?B?RFFaeWp1K1pONlF1REtXZjNSMS83ZUZlOGU1MnZaUjFmM2FCZzQvaEVGTXZW?=
 =?utf-8?B?SE01OCt4R3FBV2RGWitmSWN0L01EbDZYL1dmVlNIeWZ3ckx2Rk52TWZXREtD?=
 =?utf-8?B?SkxVYzk0aWdZMlIxelVqUVdIM2NRYmwxaytVN3Zhczlnbjc4Uy96Vi9CVjds?=
 =?utf-8?B?WEYzZ0NqZUNxR2pFVSt3M2tPV2F6elFSeVRGRHZCcDk0Y0gxYUlsNEU3K1pq?=
 =?utf-8?B?OFVSUHVVbE5VVkt5ZDA1RU1NQ2ZHZndNN0dvWk81b3dJeDc5RWd2RW1vS0M5?=
 =?utf-8?B?Y1FhdE5Sc3I4R1cwelpuZlFTMWl4VHBsNmZUSW5TcVg1clhrYVNqMlNsR3Jj?=
 =?utf-8?B?VEh3YVk4M05NTHFyeXhNZDN2Zm55WjViUVVXY1pBNGJWTHlkcG5qYk1hYm5t?=
 =?utf-8?B?U21hcHRxeGRFREpjdHpCUTV3TW5JQ0orTnlDbEhZVE5lcUNsUWU4Y1JQNmJP?=
 =?utf-8?B?eGlrVXhRWG8vZnRid3lCZ0tzT08vTXc5NzJTeXFDbm5SMzVNQVI2dUdBbkE1?=
 =?utf-8?B?U3JLZG0vNklIYWZ3emlncWp3MWExOXljYi9VbWtCRThXNkhQL0JwYnRNdG1m?=
 =?utf-8?B?dlQ4cXBzMElnZHovWFA1M2s5ZUg2L1JKd0FZbG9TQnpkZHZneUhpRXJCM1lw?=
 =?utf-8?B?b2FFUmJVcDhRM0ZrcHREYTJ3WlZCZlg1V2hNZzdlalF4aC9jWWVBSXh1Q3Bo?=
 =?utf-8?B?eGxDc3J4dWxMd1RhMEdQd0RNRytUcWZmdmEvb0tRYmxDRzhJeUhoa3dZNU1v?=
 =?utf-8?B?VXhweGFBc1B0L3NsdlJ6VlJDZkFiU3ZlTjhkaWdobkZ4SmRDRzhLeDB0MkRo?=
 =?utf-8?B?bjZXb3V6VHhzT0pwQkRjRjVxU3cwS0IxSUU3YWFPQjZTSVBXUTVkb2w2Nloy?=
 =?utf-8?Q?qtQGhaBzA7BwjCW5w+RRutxyZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34e482f-8ff1-40ba-875b-08dcc5abb936
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:47:32.0171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZFYOSuuBLApEaksM3IGpbI13IR51e6Jui4VK9WsKbdXq7VVYK/Xi8gmmbAj3XkgjkzVu8U+85c9FE4HDMUQUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723

Baolu,


On 8/23/2024 8:17 AM, Baolu Lu wrote:
> On 8/22/24 8:43 PM, Jason Gunthorpe wrote:
>> On Thu, Aug 22, 2024 at 09:50:57AM +0800, Baolu Lu wrote:
>>> On 8/22/24 12:31 AM, Jason Gunthorpe wrote:
>>>>>     I think instead of having separate function it may be better to
>>>>>     enhance __iommu_domain_alloc() such that:
>>>>>       - Keep below changes from this patch
>>>>>         - iommu_domain_init()
>>>>>         - iommu_get_dma_cookie call inside iommu_setup_default_domain()
>>>>>       - modify __iommu_domain_alloc() to additional param (flags)
>>>>>       - iommu_paging_domain_alloc_flags() will call __iommu_domain_alloc()
>>>> My expectation was to basically remove iommu_domain_alloc() entirely
>>>> once Lu's work is merged.


.../...

> 
> It relates to Intel VT-d's nested translation. Intel VT-d has two types
> of page table formats for DMA translation: first level and second level.
> In nested translation, the first level page table is used for first-
> stage translation, and the second level page table is used for second-
> stage translation.
> 
> The iommu driver for vIOMMU in the guest kernel must use the first level
> page table format for kernel DMA. This page table will then be nested on
> a second level page table in the VMM host kernel.
> 
> Our current design uses the first level page table for both the host and
> guest kernel for simplicity. This is why we use different page table
> formats for IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_UNMANAGED.
> 
> We considered determining the page table format based on whether the
> iommu has caching mode capability. This would result in the first level
> page table format being used for guest kernel DMA and the second level
> page table format being used for host kernel DMA. However, this approach
> creates an inconsistency between the host and guest kernels.
> 
> I am not sure about other architectures, like AMD, ARM and RISC-V.
> Perhaps all of them have the similar need?

AMD driver has caching mode capability (amd_iommu_np_cache).

-Vasant
