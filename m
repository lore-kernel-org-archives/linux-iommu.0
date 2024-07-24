Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C5C14B09C
	for <iommu@lists.linux.dev>; Wed, 24 Jul 2024 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721809559; cv=fail; b=dHb8a82Xuhp7f91YF9m1tKha9UYW1gjncl7kKdeq5moJiG99OLA7ZjYPwyHXEy52/Ur4QQQRW8a28aQz9lJa9OpdUSSjQCi03bDQ8/QxLrLa9si9PQGL/toB0rwARiRNcPg+Ogv1N7fAdrHLSGxodAos9H1x+vBp9CDdWUZD8Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721809559; c=relaxed/simple;
	bh=/udYeXJdt6u/3w2i1HLJDLybQ+OfzcMQgxHpf5nk0Mo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uN33t+RgWEfSB11HHsyt0SafP2D6F0YEopJu9HfqZR8F0GS3C7KanY2TaORIADH8w9d9YhRCBuszzKWsRu3qMGT2IJzF+i/AW1QzArCsyBmqkamSEUvWK7fUEoYsTpAajIhG3zL0uwXdY34dkjUU0jHOxF1UaZm3minwasH9/Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=grUpE0mL; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="grUpE0mL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVXbhvb+/8VHiX2Oim3xvK7Fr6qkAXKWhZcjN6MSIZXWwLuy+sVcdWU4Jou1WsnRGVr8jGssqs36eNbBAKpcItgLilpzxcjXw0DS3vaRaHnQUvEa4JTga+Ris0z54QQBdZWsReXQLnmq773l4m3bWRR5g8k3GvU0hoNBko4Gk62LHf5Mf9LZ4wGxKthxezoxLzjS5tTqS+vxq+RGR5cEcNyNZBoZFU9s0aFPoU/16vSZL0RGQQoTZgoZJJqyUDXTYnZsSpaAo9I6aM5tq0zxbC5KWbGVq+5LNWS6+H+9v2xf2KiRj/PV2l9onRCmIXLymtbzPAsuFT8dq77QpDEGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJg8hLlgX7/SFEyGPJU/e+spsqBfZHSPsenzuYEdlWI=;
 b=CWio3bGrqo1Sir+DzLHIYihxNpq/O2/xbmhnxFixsqruOApdK6eFQjl2Tw2gWDWD0+ZAiOQehxE7n7U5nRZNXujkp+bopclW7PnIK4H7keZXWleKulrRDpkzNd3X/Vpd8XhttlNhq/YN8dpvxl1MU2L21A+QKyMYNn6My2KfdWKYGXpxkX9wBwGQx7oXluj9xK8oXFbcwbBX0442LYX6fJ1Xb4u9flRzaMr5f0XPBoxOlxxdE7ey/z+0QSBtW+AAIEz7NHQAbnTogUUzDhjmpAcTm2nGST4GQeITBrDlaReuvPht1JfZSgwPgufN6IxAsp+MaaFieBp1oFNW5/rOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJg8hLlgX7/SFEyGPJU/e+spsqBfZHSPsenzuYEdlWI=;
 b=grUpE0mLlDhNgKw62i/4DcJQJdO+7nOioty7ACL+0GDHARYtjQ4okEGNGOxjZLyiF6yDD5CmzdQj7ixNB6oK+2AsLwQsuX19uV3ZAuz4hCtuprPd6qEDrRUzmh3nOafcZvB4VQdew184B+KFSkTfNuNW6D6jjNWi5sL06NmOxtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.19; Wed, 24 Jul 2024 08:25:54 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 08:25:54 +0000
Message-ID: <dda7c011-d427-48b6-8a1e-7a011f23ed77@amd.com>
Date: Wed, 24 Jul 2024 13:55:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Add support to change domain to blocked domain via
 sysfs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com
References: <20240722115553.6005-1-vasant.hegde@amd.com>
 <20240723130507.GK14050@ziepe.ca>
 <e7a6ce53-c473-44d0-9177-b7dafa5c6aa5@amd.com>
 <20240723164448.GM14050@ziepe.ca>
 <110c57d1-1a84-44e6-bf71-ab5cbae12120@amd.com>
 <20240723173228.GN14050@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240723173228.GN14050@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::33) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 494465cf-bbd5-4df8-17e5-08dcabba3a33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXNMdWF3NHZOOWJ4ZVBFZ0VFUjNiQ05pU3ZhblBna25uUEE5SWdaZlNpMWdW?=
 =?utf-8?B?L3dDTHN5dHFXY1RvWTF6L21iRDNQMzFyR2d2UXZmMi83ZVA5NmRsNUVlN05S?=
 =?utf-8?B?QnVma01QVFE2N0xISXljRko0a2tyVk5GOXhXUHBUSzZiaW93empCNTBza1dY?=
 =?utf-8?B?dU51L015UTNDVU4xRGtmOEVFOFoyRWo5SWg3ZGlsR3NyS0VvdHVKOVpCTngr?=
 =?utf-8?B?Ri9NanRlaFdYWUlmSzd3bVpQc3AxT3gwdUNpZHRoVTNEZ3dvVnNHTTJjN2tX?=
 =?utf-8?B?OXkzdWhObnBXYkRyUGZwSGFTUFdONmRoMEg1cmk0MGhOQjBwOGplTXN2WVg3?=
 =?utf-8?B?WWFZemJVeWFLN3pMRVBkRnJvcUt1V212T1QwZnVhNWNkTkZIQjJnTk4rZHdT?=
 =?utf-8?B?VjR5SWtNYzBnOGVVUWNZeStPeVhHREcrb0xvQlZpbXloQUx4TXdYb1U3ZDVU?=
 =?utf-8?B?Y1dnZHU0VHpNK2NJc0JUcGw0U3ltdFEwTmhnK2I5anJvZXA3M3REcDdZNzZz?=
 =?utf-8?B?dCtnOHJzZjdmNTZ4Z2k4T29uTFMwWHJvcjRWK0ZhTmFOL1dSeXJ2WHZOWUFx?=
 =?utf-8?B?STBnelFUS2ZxNi9GazlCbTEyajYrQ293ams4dlZndGFNeWRHUE1od3BRbVdB?=
 =?utf-8?B?b2lXT1pvUTN0WWI3dmtCRUt1TEJGekFRdXJRSGpmM1lPQVpsbnBwSmNPOGk2?=
 =?utf-8?B?QytqL0Jad3NSNmZhSlFNM3B6NnpIV2kyM0djWEZ1Uk1qUWx1Z3RuSTJvMXk2?=
 =?utf-8?B?WDhiUWUzRk1rTDEvWWhNV3RwN050aW4yUzFhM2RvY1QzQXV2L0tDdmErM2dz?=
 =?utf-8?B?Nm9RUjZzc1JuL0dWd3VxYmpUNXpDU0dTQ2k1QlV4Y1h3d0hwWjhKcitUUCtq?=
 =?utf-8?B?ZEY5WnZpbVpOeE4vYVhMRnJCZ1h2RDc4STh4RTNCaUhjTXlGTEY2VVVqNmRQ?=
 =?utf-8?B?dnhnY1BwQUxXSkxYY1dXM0V2WVlPTFowMTBZRVFtTzRPNmN5SGxvcXd3MHJV?=
 =?utf-8?B?YUw2M2haMWhTNk5XeXdjTW5nRkV2VlVhWlcrWnlsM3pRb3ZiclpYNXFDMFVB?=
 =?utf-8?B?K0FQTjcxN1lYVmh2OUlneVF0T3ZiNEpHWkhaTkgrZnlIVURYUkR2RStLdytL?=
 =?utf-8?B?T2U3SWsvSWluUytZWktic1R2Rlc4UGYvKzlBSUExdS9CU054SDllUjlLR1F6?=
 =?utf-8?B?Nld0MCtwN0ZwZ1hkUlBHMTVNaU4xZjgwTjBOU1FhWTNUZ0VTdVhsWkw3MWo3?=
 =?utf-8?B?cCtJbTFFVUFGRm05amFrbDFJbDZCV3ROV1VvVE9scXgwdEJ0ZnBuT05iNFRX?=
 =?utf-8?B?RU5acUtqM1FrMGx2Wm8wOTFxd0VDWG5xaDNlcnF5eFgybnY4eWJ0TDRHcmRJ?=
 =?utf-8?B?MjVwNllnWUkwQ3ozQWV1SVltOENJOFRuL3QvRHUxVVZ1MXdVSEZIVlRQY0dZ?=
 =?utf-8?B?SEZ4UGw3dWt2QlV4d3hCQTE0UHRWV0NSVXpFQ1ZyOUxUVGs5bkpEYjdScUpt?=
 =?utf-8?B?bnBNVXRYeDF1ZnRyRUVMYVhGcVJsVTY4N0JYVyt5S01UYVVZY1V2aDBIeTdW?=
 =?utf-8?B?aWttUDRMWEEvMWhja1pyb2pGOTdhM3BIR09sanN4aEF6RXpPdVlEeC9SWEdr?=
 =?utf-8?B?VmM3Z2lVL0d2akxGc1RSc3o0NUxXVWlwdlQ1MHovZHBRemYxcFp2MXpMQyta?=
 =?utf-8?B?MndJWHFPUVUvZEsrZWRFQUd3OFBVeXpHQ2wwcjJwelgyOENRWTdueHppeElQ?=
 =?utf-8?B?dG01S1pETVFMbWJoMVZtL0dLMU5tVlVqS2dxK3BTZ2toRlU3bFB2Z1AwOEI3?=
 =?utf-8?B?SzhRV3QyajVNSmV5TlZlUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDlNR2JDd0ptZWpKTG5KQzBNWkxvalYrNlRISDVNZjlQb1lRRStLSVNoY2lr?=
 =?utf-8?B?a1AvREh3L1hlTVNoVlFXeTlSWFA2NzFEeVRoN2o3eHdQYzJMOHJMMlRZK1lI?=
 =?utf-8?B?a0dJL2FmaEhCWEw4Ni9FZ0p4emtNNG4xeDBYOEdwaUJqZ0tyNmI2d29Ed2NV?=
 =?utf-8?B?MzhlbXBNYy9qOS9QNmJRUEZVWVdqYVZFMkxiMnRxblBjNjZvQ1hTc3RYd0o2?=
 =?utf-8?B?Tk0xWDZvSnowc005MFFXSzRJRFRBdnZYUXAvNUVkdjlJN1lzYlpGYWxvQlNI?=
 =?utf-8?B?clVDZUlpRVdxUzg5bjdLVkJBeVYyNExVYURPYlRhN0c0VzlhOHNzQTJxOGxP?=
 =?utf-8?B?VEw4ZnZZelROdUtNdTVMUVdXMU1WTG1HZ1Y0REYrVXp6R29MVlhWWktRVEw2?=
 =?utf-8?B?WjBSa3RETmNvUnNRWVlyNFZyNnU5QjIrejNWalZXclFjd2pPL3VFYi83YmMy?=
 =?utf-8?B?eWthQXhqRUFqYklZalJNVThmZ25JS3g1TEU4MkcwWUJ3VW1mWHZacGNrTWJ3?=
 =?utf-8?B?ZkZCNVZ3R2c1M1A2bkwyM3NyOEZYeDZGSjhndFF1Y3J5RWx6bzN4cklGdlFX?=
 =?utf-8?B?aUNacFpKSDZLZlZsZW1qQVFnM0Rab1hYeXdIOGZ6MVZEbVBsZFM1N01CL2I1?=
 =?utf-8?B?UkRvZ2YzRzRMaEoxeEdDbEJHVXZoVnFMUnJWOUFKVTYySzd2cGZFb1FQWXJX?=
 =?utf-8?B?N2UycnIxUjYxcUN4ZU0zMEpFaC9kU01tcDUxMHZaU3lSQkRxaEFibU5xMDQv?=
 =?utf-8?B?dW5uQzBRVG02RjlnaGZmbS9VeXYzSU5JSHpCTGxMMTlMMVhOTHBHdGlCTlRS?=
 =?utf-8?B?RzE4cnlQb0ZxYWpZSmt1dHBUZlR2NVNiNVpkMEtma3R5SGttdC9zN0tFd3dB?=
 =?utf-8?B?RGFrTlBoQnJnV0d1Z1JITi9PZGs0TU9sYlJVcHhKSVREa0Q1cFJCU0lHOTBr?=
 =?utf-8?B?UWV4dFBxRlYxdHhWdWUwL0g4Q2ZVMkR2ZW00UE9CTmhUUkxxbkQwSHlFMFQ5?=
 =?utf-8?B?WWhUTjJmUGFKaklWT0ZjWll0UU14UHRyUFgrQ3E0Zm5GUjNuYzZtRktzd1ZV?=
 =?utf-8?B?NlgxbFJoRmxQdmNvRkpuZFNNMDhvb2gxUVlMeTdHMENua3FsQjY1K3dNQjhm?=
 =?utf-8?B?VW5haWpZT2lDYjFTRnkrVGlmb3hZWk5Rd3lKcWRqUjNwYjYwd0JxWTBxMmto?=
 =?utf-8?B?d21iRzYrU29kRndzc25oaTArdHgwcHg5bldqQUt4QXFtY0xaMnl0dHFIbVFv?=
 =?utf-8?B?aGphL1ArK0xuZ2NEV1B6c3lhekxrQUZtd2I1QUNpbEMzelZBMDBiQm5Qc1A0?=
 =?utf-8?B?aTdMZWwySlNDazF3N1g5K0hOY3h4T0VsQXFIdFJBQVZEZGQ5N2JhYlBNYjBx?=
 =?utf-8?B?MmxXcmxVN0JjSjc3MGVaTXdrUnVIMHhlaFEyVnNWVmFjVDNFVU96bDdONzZR?=
 =?utf-8?B?cVExYUdXcHhLU003N0Z6ZmtDUXNFdWlGNnhObUx1WENQeUxIVUh6NDcxbTh5?=
 =?utf-8?B?RWlWTTlHV2kxdVNXR1MyT1lreWxYMDgxajNQaFR3RUlDR2JrczlQbU5ERWxK?=
 =?utf-8?B?em5PanlPSDR6Z3QzTklqRTVVWi9yZkRkTm9VbndVb0dSMm5NVElGRHVrV0h1?=
 =?utf-8?B?KzhBQ2pRZkxCc0N1RWRRQkJIU2tVRjV5eTdGZnRucFY5S2lVTXR2WGJ6YmxJ?=
 =?utf-8?B?N085QWxQeGFacThpRzF0Y29ZN0ZHQTVDdlJ3RlJSV2hZL21hRWtQSWdwQXV1?=
 =?utf-8?B?RXFuSENIVGxyUE5WVlQzVFJmQk43U1g2cXUxaUFYd0ZYV1VmQ1BSUG10UDhw?=
 =?utf-8?B?U1h1b0puRndzZ2krZ2lOcXpGYXZVVHhobkh4MkhLSloyL0RMcVNSbktwZUdt?=
 =?utf-8?B?ZDNZNjlOSzB3eHlOdVA2WFY4V09uSC9nR2U4T2FnSXpGdkl4VHNTN2pTNHUr?=
 =?utf-8?B?WnZTUUZwbFcwWFRidUVSOEFrNDhwb0dIcTVQWDBmVzgxVE11dmJZdFc0SS9v?=
 =?utf-8?B?Y0NJcGtJQmpvdXVma3FSQklHbk50eElYaGxsV0tOdmZVRlkxb2ttWE83dGpm?=
 =?utf-8?B?Zm9DLzZ6TDRUZUgrbURaU1hRMDVsL1d1elNwZ2ZTQkd3ZXZTdjF4cXd2dlZr?=
 =?utf-8?Q?phe2voAsAsfVZgbV3uKQaEv2G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494465cf-bbd5-4df8-17e5-08dcabba3a33
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 08:25:54.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvJpYVQPZ+alsYDh9hO6ZqUSDhM//UKNqzXhjqRHjwpO1bjqMY23Hq/vHIhSYySGtDxWPUSAxxKJMfKANEknjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196

Jason,


On 7/23/2024 11:02 PM, Jason Gunthorpe wrote:
> On Tue, Jul 23, 2024 at 10:16:51PM +0530, Vasant Hegde wrote:
>> Jason,
>>
>> On 7/23/2024 10:14 PM, Jason Gunthorpe wrote:
>>> On Tue, Jul 23, 2024 at 10:08:52PM +0530, Vasant Hegde wrote:
>>>> Hi Jason,
>>>>
>>>>
>>>> On 7/23/2024 6:35 PM, Jason Gunthorpe wrote:
>>>>> On Mon, Jul 22, 2024 at 11:55:53AM +0000, Vasant Hegde wrote:
>>>>>> Add support to change default domain to 'blocked' domain. This is useful
>>>>>> for debugging.
>>>>>
>>>>> But how does it work? 
>>>>
>>>> 1. unload the module
>>>> 2. echo "blocked" > /sys/kernel/iommu_group/<groupid>/type
>>>>
>>>>> If you set the default domain (aka the domain
>>>>> used by the DMA API) to blocked, then surely no drivers should be
>>>>> bindable too? 
>>>>
>>>> That's correct.
>>>
>>> What prevents binding after being blocked though?
>>
>> Device is in blocked domain. So any access from device will be blocked.
> 
> My point is that is just going to make any driver that binds to it
> malfunction. The DMA API does not comprehend a blocked translation to
> fail all DMAs. It is great for testing because you call all the DMA
> failures logged, but not useful otherwise.

That's right. Purpose is to test blocked domain.

I'd expect someone changing domain via sysfs knows what he is doing. Hence I
thought its fine to add blocked domain support.

-Vasant
