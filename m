Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D05219ED
	for <iommu@lists.linux.dev>; Wed, 24 Jul 2024 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721796757; cv=fail; b=n2pQUdzlYgMwGRz5+S+D/bdGkRgEAgT5C2SbWysVJ5OUp9Jc2Co9YF6/g/GV2Afu6YjofgTZ1qyniNcxbBnt5A4LOhEcW0jVnlRcom1sVLVbQDM8s0YdBfa+mDxOMuAGwlj1jBVYKYjCXharX6pJGnc3ZyRMi6817hDeQh9NHYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721796757; c=relaxed/simple;
	bh=pQaBz3z4QHgAzLwX04HkZ8WQNxiyG2dk2eG+ssr9wd0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C1aqNM41dp6hpuYIBdYVKLEYjuVinyjvYwuHSrBdxC1iNozBeHMl06OdEujg3hY6p4kiTwtk3LSk6sn9dYrlkpIeKx7KRNeO3EkmfJiSizxPdJ7MXSSS+MkiL4gv7Nbc7iiinpPXP9vFsmtIQTgk9O9oR0Ebf99wzr4ySYE0Iyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WEi/yoUo; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WEi/yoUo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcN6StFgZyg3QAnjndzAXM6VSUDlwGQYGDo+8f1+w1aNpQSQRDXikZC9dhdZ0FZ7KV1z5+Z4lUaCjKdLiHTlWSIBOVAU5IWmBJ8EBpF0Dl9VmCVajxLxup7fo1066sNgzrmTx15XMP93wSaX2D1+aYbyJ43KbIXcvIr7WZTNhxgQBV/BT7UyGN7HsmwYUZkAGp+ePQufCBaw4fGJ/ru0JpZH8x18NiaVpj1rz4Xtxmgzr3xZEEJN3OThWEby2rouNVkrz9x6cmLUSNlRlnc88Zb55gkdPh4SbU4PVYDyLZcxHD2BpzaIk9Hj0X142MyKA8qaTblF6dqM2Wk5SOQogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwjfOAY7CQjcoZTFWk//X3VXFMOxKZZ//AVkgMg6b0E=;
 b=gDkwI1JFjxwL9m878yK8YQcw8WLwIy4jH21FW2ap5iTiniTbNTctBFap/S//b79pxFwM1PwylAE5mbMH67Ldv7dhIP4tBXvO6SJsF6Na29pJ7Q9KU3MNCDwJaEZpYi9ZONjkFrTMk/ESaXud9IJALiHpd2qexG4CLgp7SVF5eGGDuhO8EUW5i43Wayx1jlk/eHNzwQn45m4pWxpSkcg1k/jGskA5XqMoNnh8DnKOFXQtHejrqbMqotg9hJnQj7SVAmP8s6wY0hi9Gf1dk/QOG/EMSNSqu0Caml7D8FtmfKNsywOhDuG3Vnql1uI4Z90MsIRiV8V4OESAesj73msIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwjfOAY7CQjcoZTFWk//X3VXFMOxKZZ//AVkgMg6b0E=;
 b=WEi/yoUoMEOivQltW7zgteJk/djefgfBZtOmLau6c4D6JcxN0m7QiYA0wLKPaHSVoR4KJ+bpubD5QvtNEwH9y3Pz/Celhh4NVcLzCaTL3vLWsNP3QKAzSXhYjFRownK+YAgxUPe1wAGc4EiLrVnM0dMlpvVSoFjUmOzKexupaEsOzlvZdh8HQk0ETLmLi6uMzQEsgziDr3HevchrkIFlvxpoQoOk6T7cI56Iee91BtamWUt0zPRPLdrG9OV8pCe8F7uIv4x16qw1BK4+H0G2g0CcDWBSHJVLrR/EpngzVC/n5bbpQPCa0dYV+cCZYxwiRm3+EttAP0Hzb3jlrXsyRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 04:52:31 +0000
Received: from PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::6fdd:1491:4d83:ac33]) by PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::6fdd:1491:4d83:ac33%6]) with mapi id 15.20.7762.027; Wed, 24 Jul 2024
 04:52:30 +0000
Message-ID: <660afec5-d8d6-4cc3-a236-85d98aaad7ff@nvidia.com>
Date: Wed, 24 Jul 2024 10:22:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: arm-smmu: Fix Tegra workaround for PAGE_SIZE
 mappings
To: Will Deacon <will@kernel.org>
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, robin.murphy@arm.com,
 joro@8bytes.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240717072145.107412-1-amhetre@nvidia.com>
 <20240723161137.GB26546@willie-the-truck>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <20240723161137.GB26546@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::7) To PH7PR12MB7426.namprd12.prod.outlook.com
 (2603:10b6:510:201::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7426:EE_|MW4PR12MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b63dad-0ce4-46ea-b313-08dcab9c6ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTVXeGJKT0d6LzlLYU93S29rdmxWejhTSFMwMEoxS2ZGaWtmRmRLZTdKNXgz?=
 =?utf-8?B?YStoZnorZ3FGdkl5NGhCWko0cE9Uei9ZZXVtSWl6REtLNi9PYWVlQWVHOWRa?=
 =?utf-8?B?NEk0NjF2eGxzWjhzcjhMOWhXb012QjlPWHlHNnV4K2FCMldJWW9ldEVUTmxE?=
 =?utf-8?B?Q1M0a2dtU2pNbEFTZHJraC9helNrNmRwZ1h6N2NOOXlWYVc2RGJXQjdaQ0pE?=
 =?utf-8?B?S1NnNW16SkpCMWpFNW52SXR5ZG9rUWVhVHFzZE1iR2E2MnlYdXExcVArOTRp?=
 =?utf-8?B?L0RkVDdwZ0VIMVg3RkRTZklUOCtkNlZtVmZWRlJJcGgxOE14cGNJdTlSeStz?=
 =?utf-8?B?blc3Z3BNaUtpeWx6WXpzemF4TElBcFQ5SVFzOGJ4bzR5bTJpN0pvM2RDVjdi?=
 =?utf-8?B?UWV4ekJocnJpNDZaY0NoUTdaVHg4aVdKY2lOc0RFOHlxSjJ5L2ZwY25Jdk8y?=
 =?utf-8?B?WGVVanV4TzZJaDdibVRJZHh4UzJFekRzdzl2YzdoVmV2T3kzeWVHOGxuUktm?=
 =?utf-8?B?RlhmbmNkV010V0JLT3FVemtiUHNtLzNqc0FqcjdnZk5CUnZYb25LRG1yakla?=
 =?utf-8?B?VlBualQxZkpjSTg2dmlTOUZITkMyY1BqajhTUFRSNWdGSjI3ckxXaXJ1Vzdz?=
 =?utf-8?B?WjYydi94anF3LzA5R01ybmgwUVpoOTFYMzhDUUtXMkpGQ0pQSzNGUWhMdXhI?=
 =?utf-8?B?K1pFeTV0aVRLcmFhL1ljdlVBMlZhUGsxVVJwbWp4NXF1ZkZkLzM3R0ExMFZr?=
 =?utf-8?B?VE1ocE5CRERlQkN0WHgxUjlEK1BMV3cwTUZnK1RleXRiZzM2MGRPelNLcXcx?=
 =?utf-8?B?b2VIY1hTZFZ3SEFLeW4ra1dlMU5FWUVvSjR2cGNySSttM3hZbW5IOERQSWY3?=
 =?utf-8?B?bDFub3JoN2IwMG0zMzVhS2xVU3lIYnVNdUtjSXFhZ3pYQTFTVWllNjJ5aDFU?=
 =?utf-8?B?ZytSTzZoSThGZDQ2Smk3QVJEN2h0d1BHR2ZLUHEzNXpibGlDcy9ERmRsdWZO?=
 =?utf-8?B?UmtIcGRiRHI5ZGd3SXJUVGtRVmliVHR3Qk9oMXg1MlhZdlFuejMxYkNGTEgv?=
 =?utf-8?B?ZW9KY0pNSEtzOGkvdDBUNlJTYkNGYWN6dGk2WHllc2xEcHlkNWRNYVh4bGFP?=
 =?utf-8?B?S1FENjRnVHo4OFBIU2t0ZnFrclFZN3dERjhtdmw1aUJWVW1yMUJST0xIUjI0?=
 =?utf-8?B?am9ESFZ0MDJIelo2U0JRaGRaWHlUczJqZEx3VTIwVU40N3FGRkhHSnVta0k1?=
 =?utf-8?B?UkNSVlNxOTh3cjIyMy82U3hWemo2dVZna201QXp3YzU1c2tZcisrOWlxNDd4?=
 =?utf-8?B?RmtxVTdXdHBndzEvWWxqT1g0REVvR2VEMGpJQ3psTTlWdUVYV2Q1UDhscHBR?=
 =?utf-8?B?U1h1ZkFIKy91KzQ0a0I1THJEOWoxTHJuaTBQVFZQdlIxQkJ5WGw1WWJTMFZ5?=
 =?utf-8?B?dHdRTS9mdXRUdS9vbDFXWjdKdUhyU2pFS2paMFJwZ0xBY2pBZnhWNWNGeEhE?=
 =?utf-8?B?THVSS0VuS254MWFjYkM4MEFKNTdQRjQyZG1vdFhGQVBjcEl1bVU0MGJ1S09W?=
 =?utf-8?B?eVZHSTQ2TFZXM2VoTjM5N25wRFJwZVZ5Z1doSmRiSHdhVk1kclJhWGNZNkVY?=
 =?utf-8?B?dVRjR016NmhuOC96QUZscXVKeVhBaExvVzRiYk1ZaDU1UkJMc0lKQTludlRP?=
 =?utf-8?B?WGpvYXhUWU8zSTN0djVkMXJpQnM0eVNSNmpCUTFPNC81UmtocHM0UVNFSkFw?=
 =?utf-8?B?emFsaDlxUEVqdmRPNDMvMjF3dEF5a25UV3crS2pXOWFDZ1dOSEpYNGloS2Ro?=
 =?utf-8?B?TTBYNytJQjFodjNEUEZ1UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7426.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0JYRjZGaG9BWndWQjVRODhjNUU5cnFCc0tXYkNWWC9UZ3JDaFlvOW5FV2E2?=
 =?utf-8?B?bVNPcTA3WHFhcC9mNGNCbFVQRlREN0t6T2JxUWpYNjcvajZPNzVGRVhoa21N?=
 =?utf-8?B?MHhINU5iY3RwZHV1MTd4M3lNdXdHakdyVWhwTVBPeUpEQklkUmFvWEhnOHRG?=
 =?utf-8?B?V3ZvKzhYTytzcVljMUtPZG8wT2c1TFNUWUkxOHlXK3VCTy83MXBPVEVOdmg4?=
 =?utf-8?B?Q284Z1ZUOG1RbFRMM2VtbXhQc0hTQnR6c0xVQ0R4cVVJWXNwOWtTMjhNUVV0?=
 =?utf-8?B?ZmdPVUc5U2dFNEpTajRCVXlwaFlha2R6M1VzR0d5UnlWNFd1b2VIeG9lNkg5?=
 =?utf-8?B?eEp3TUlJd3BVM05JaTcxV1FGbkwzR2FheXk4TDFsZXZGZjBJM1JBRkJvZ3dZ?=
 =?utf-8?B?K1pydjB3SXlSNVhSVkdGbWFXRm81UVVic3BnOFZveUcxNEtyUG5hTEw5MGw3?=
 =?utf-8?B?ZFk3TzhZS2lSOHMyVzhMV3BCOFVQNnpXb3JTY0ROb2hjcDNaWHdDN1FMU3dN?=
 =?utf-8?B?Rm9qQ24wcDF0Ymk0MGw1THU3cFFPblVEd0RMb2FoV3RQdHc0eG9ML0Y5VkVq?=
 =?utf-8?B?eHVFY3NFeVBnZTN6MTJ1bTZlbXNxb2xWbnlhNHFYdGhDRC8zeHJqemxnd0hD?=
 =?utf-8?B?dUxvMG9NTThRTy9Qd1p2TC84ZVBKdHU1WkcvU2Rac2hGYzIyYnFNRExmUFds?=
 =?utf-8?B?cVJGL2ppaWZFLzNldUlqMzRIUHpFSE12RXVNMmhjOVprVUhRNzBxZklxT0NB?=
 =?utf-8?B?VXlsZWJpdEowVnI0K3l5NXVFd3dhM0N1VHlJZldZRkpCRkZwVE5Wc3N3Rm1u?=
 =?utf-8?B?Qjgyc3U3amVDbTB4d0YrR3FlUzhlTFdsdXdZWnBrUjJ0SWVuZVYrLzhra2Vv?=
 =?utf-8?B?dFdPQ3A5eW5rVjRKb2lBL1VnOWZlQlMrY1pDd3VlUVlqODFKVnA5ZTBpNDB3?=
 =?utf-8?B?czNqVk1NeUVsK0RLRWl2MUNzNXErdS9tTTVnQ01oMVJMaGdsU1I1YW1PWmJI?=
 =?utf-8?B?M2JIcDNPQ2prU25KL2RWS3JhQ2lwWTUrdjY5ZmM2RFByS2trMStMaXJ6Y01G?=
 =?utf-8?B?QnYzZ05ydEVROEtoLzhqSUhDcVk1STJaQnZSTGo3YWxRaUdFNExSb0E2eUhX?=
 =?utf-8?B?dzExYU5iMDFxMHFtcmxQVXZCUnJ6RHZ5dzg2VnpUKzNXeHJPQjJ5cFVSSk1I?=
 =?utf-8?B?MEFpaGIvNFlFZlhVMVdoNTNIMzd0aHQ1YWcrOHNDOVpFekg3MXRVa1lyRFRl?=
 =?utf-8?B?eURVcVFMQjAxWTZYdzNjVkFlZVlYUHROSmZVVGlmSlZ1VlJrRTlTR1ZXcGNl?=
 =?utf-8?B?azAzMmZWODRRYWx2ZzBHNUZtT3lrRmVLMkcrSDBLcDZkdDBwVjQ4S2JwZSti?=
 =?utf-8?B?a3l2MVE1bGxScjYxeCtGa3NiNjhwcjI2Nkp5b1RZUURYNlFDaVRhMG5nSWZ6?=
 =?utf-8?B?dG5vc1FDMVhablNKTmUvOWF6MHB2dklMd0ZjN1JpY3B5QWZ6MVF2ZHRHSUw5?=
 =?utf-8?B?ZnVhSlZxWkZnTkFWY0tiNW5MRk9LU3lYYnllMzhtbjFqaGt6cXcwelVmWkYr?=
 =?utf-8?B?d3NueVorY0lDM2d5QkhvbmJvMzNkT01FeWFxbmRlMkdVV3ZwemU3b240b3BW?=
 =?utf-8?B?bFdxdVlhUHlsY0lNYVhmMko4aXpkdCtxVzM2V2JHSzlaUlJuNGJ6OWpPZ1c5?=
 =?utf-8?B?YXQ3THJhWm1odDZLN2l2ak9UbXFUb0dKcktSdkcrS0xlb3BDSDgvNkRma3gx?=
 =?utf-8?B?V3paa05aa05lN1RCRUl0SUI5Wk1WVTVsYW1OTk56WTU2WW1LcXhOcG5vclVC?=
 =?utf-8?B?NTVhWXpJY2FYUjR6ZTNVM3RNTkpDV2ZRSkdRM0hOZVRhbklKSXVxcjJqTFJI?=
 =?utf-8?B?TFh4a2tuNFZZWkZ1SnpSYnV5WHgwZHBkbjd4Nksza0dHYUl2V3EzWGplTmxk?=
 =?utf-8?B?RVZFWXZRRGxSeitHb1pQNmh1TnVPTllDZ0c5ODhjT1M4bnRKeWNSWDQ1bU9y?=
 =?utf-8?B?Ny9SWjZpZmJLWXRDa2FhRk40RzVWWGdNZHNpVjlqTGpEWjJ4YmR1UkpYaXo2?=
 =?utf-8?B?YnJNc3A3OGNlbHJBZWlwWm8yaTVTMWpOMHlicmVGRG10bjJ3NmlZOVJYSUtu?=
 =?utf-8?Q?8RLM5WChZE/xOPosCSCR9W2Oc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b63dad-0ce4-46ea-b313-08dcab9c6ca6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7426.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 04:52:30.9051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvTIOMZtBg8C9tQqJClRYWzf5A86rg8M93s4UXMPLYiQK4IN6mq+bkEiqX4MJByl/f6MAd9/+kI+wcYurPriWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604


On 7/23/2024 9:41 PM, Will Deacon wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Jul 17, 2024 at 07:21:45AM +0000, Ashish Mhetre wrote:
>> PAGE_SIZE can be 16KB for Tegra which is not supported by MMU-500 on
>> both Tegra194 and Tegra234. So, use 4KB mappings when PAGE_SIZE is 16KB.
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
>> index 4b2994b6126d..bb621a94f6fe 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
>> @@ -273,11 +273,12 @@ static int nvidia_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>         * release of PMD entry and avoid translations seeing stale PMD entry in
>>         * walk cache.
>>         * Fix this by limiting the page mappings to PAGE_SIZE on Tegra194 and
>> -      * Tegra234.
>> +      * Tegra234. Use 4K page mappings if PAGE_SIZE is 16K as MMU500 doesn't
>> +      * support it.
>>         */
>>        if (of_device_is_compatible(np, "nvidia,tegra234-smmu") ||
>>            of_device_is_compatible(np, "nvidia,tegra194-smmu")) {
>> -             smmu->pgsize_bitmap = PAGE_SIZE;
>> +             smmu->pgsize_bitmap = (PAGE_SIZE == SZ_16K) ? SZ_4K : PAGE_SIZE;
> Perhaps it would be more robust to do a read-modify-write of the
> pgsize_bitmap, preserving all the page-sizes that are <= PAGE_SIZE (i.e.
> and it with something like GENMASK(PAGE_SHIFT, 0)?
>
> Will


Thanks for the review Will. Yes, that will be a better approach as
pgsize_bitmap will never be with 16K granularity for Tegra.
I will send new version with this update.

