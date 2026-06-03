Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3501525A2A2
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780460001; cv=fail; b=BZ0Zgw/p2/WPcYT0sS4tjoDbRqJW8X1MMM40slzGXnzCxq/rxPbB5aoHvycaKJBS7KWQjFqOT+nYutG5YAYWqAc1tlB7HjT5LyV0fp1wNdzC4TYAZQYnl93OB+qEcppDGnV0pzyvLxyV50ruZ01ngCARFyP0RE0ug1eyiUMQiGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780460001; c=relaxed/simple;
	bh=DRVyHMA71f1vocdWFRQRZPC6qRfIOhnYeRbq0gB2q0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wm/udaE+qmQb3fHATxSBmnvpdjHN8YPMwistxbQgJ4bmsJOwQlDSeXKgvvbpYILAq36tpwybu8brI4ezuu9CWUZMX8z+ztQZbd82lgZOKEyePrxLjUkt5/CuHDXvE9oKq/Of/sRu2IPP7wC9KZbEBLsm7Gv8M5x1NL2XP0z4B6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wXU9gjsY; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wXU9gjsY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTRliKJj14B+SR+bVlSxCJkYXocLoT7V0y9XER81q2aW4IUgj0m/4YbfTwcrQT1gS8+mELAlhDtT9Mkeg0e7csw/R4Fqn0O2gGLD0BerDqdQL/noI6OS99dgKPdwwEoiaRbwYz3ScQzhAC3+zKPWGm5ejdHlJj3XvUlLHCqCDmVwN2ExdYfAL9QCfHxnPobb63beZLpf5N49ha/B6zQGzadFWQzqAIrJsxYVgtsm8lqN1Z1t0dG74lCA+PnzBePfHwZ444VXjF/8JzyZlMiHhfUCA0egj85sS8yNIZjtgHFmVeamWoZ2yslNWeclMOfYBPL3Re+ydu8OQANxNmwa3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TCHb5LzgPm1G8lrur2+4aWDiMuWhZhnK+SJUPZCy9s=;
 b=XZd836tGJHn6kgYGmc89zPPFWYJLJnNCm3+7OktaEGcD6MmT/Dqa7LH4tBBtF6+CUGVx/JRXe1KeGj7x7gCK3uoFCZXtCGHA78E7MKEWmcfhFw347qR2f8vWNJ50+CwnMlWDOLCj9J2n9H9IsbP4A3QzpmlI5iuo4F9q7SGn6+vGmLKD3mxLYUxEETGIN+9H4bM1vZrBE/BWqz9gX0wLkLtk32as1imTmpWAqlA5yXXYeMQxdiJaEJKWShDSKHsMAJ99exX7eGXjayotCFmmOyBU7W2YeenGTFet9CpD+MMr5h5jrtLBMt3Gqb+AhdHPwyMHZSHyM1aoztAs0g2Y+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TCHb5LzgPm1G8lrur2+4aWDiMuWhZhnK+SJUPZCy9s=;
 b=wXU9gjsY9fSQcTigcNXoZKisT5Nwy+wOAmyY1/Gn2lI/qVqhx8v/bppiw1HdiQxY6oqdQBpeEDYPGdGkuz1Ih4ngnNGVHAOGdZTfKMY2aK+u0LSlJIF7BHitbHLJnHce6WXUO323rBeB41wWbZ7w9RKzpaEFenIeMXo3qlRii9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
 by SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 04:13:13 +0000
Received: from DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e]) by DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 04:13:12 +0000
Message-ID: <600343aa-d21c-4a4d-a376-5fa2b5dd7796@amd.com>
Date: Wed, 3 Jun 2026 11:13:00 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/26] iommu/amd: Introduce AMD Hardware-accelerated
 Virtualized IOMMU (vIOMMU) Support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260601133031.GA403363@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260601133031.GA403363@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0116.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::8) To DSSPR12MB999236.namprd12.prod.outlook.com
 (2603:10b6:8:374::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSSPR12MB999236:EE_|SA1PR12MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8bad69-0b15-42b1-9b4b-08dec1266d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4hz30bhO02UAzaq5vHMAZVIHznOaD+tpO34HwfR/zPj9XtbZhWYENR98HV7j+5W04IsR+0BVow1iNICD/vyVe1J6cmo9PO7fmRJM59SdY8F3PuZx7CwuPwt8kdiAycF//RrMrlvLzrVt3sGNmQLQrmnY3JuGLb0QdOs1J1RQ/28Iy9szQBfQIlwDEG0Pls6aRf9hhv+0z/RAdOXDf9dZU7io5D81gOQ3AkDcfwornUq8kgsonam37C6qjta2FCO7ebqRZkp3i53kMUoQYoaMDGwsr3PhzT6ehhmhLrcwlx1b9//PQ158vGxCoyOk0sfsB9bWFGi9QjCSb7vf6h/ZBhU937l3W3UhbQDtB4yGdBjt5OO4tDKdUM6jjchZQ/qN42SGDZht1n3c8VwtCLo7oLMUkVUlUnB9l8QT3WTAv1z8j81HnEYFwXLRoFDo9vRwEjiQtFDY4vZiWM/IwgixexQMw8zIJD+50Yd0a4NOuMmi3hdOWpZJCrny82W9up6CJ3FatGuJWwRTxBxVdmCGyqN/Ezmd9P4y4JZKf0PyhEnjuH2JOScnwn4TABN3XD+kRs6ig25p4IAmFPwa2VovnjAeTfDo5DNI1CLXkS1hzXjHqryWNzmoRpOu+zVizQ2UK0l1cvvFtnan89kePXn1YoJbL8LKrjt6FQhcTVDlw6LcZGM9udlRulMfqohZfUgL82uA/5FaKIXqmfiys8ry/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFRqLzN0aE0wUTh1QTUzSDVudDEwSFQ4M2xWdUJoMVZxWFFBdnk5QU5qRTNP?=
 =?utf-8?B?SzJ3eWlEYUlpbGFvbjV6dy9MRCt5Y2MrRHZMU0t5WGQyZVlVRmpDU2RaV2J2?=
 =?utf-8?B?cFh2UnlmMUJzdUtvaS83eXdvbXFKL3A5UVBXRlJSQjc3MkFCYXRIZ2ErSmsy?=
 =?utf-8?B?bmVxK3dEczVFcmdLbzJ3QXJDeUlOSW55YUlKZkdNUUdxSDh1Rk1CbGFQYUZH?=
 =?utf-8?B?cTVhc2tHeEtZSi9NUEJVSDhGemRXZitNa3lDQ09QREljbHdnRmdpd0JQWUhD?=
 =?utf-8?B?M3NrRmsrZ09mODY3T0s5YVFIdmphVnZUV0JHTmJTRld6QnVZVDd5RzI2RkY4?=
 =?utf-8?B?aWFoT3ZMRHVJWlBxU0VxVTNqeGhmMG1HNC90Q3FJWGMvaml0SytKWWtrN1dO?=
 =?utf-8?B?SDNxRzRQMzNEMjZWRGV1RzlIUkhXNHhjL3dQQWtpQW41UXFrSXJSMERnS1pU?=
 =?utf-8?B?bkR1UDgvR2JscGxZSFM0NnVXT05SUUk0ekdtdmtxTUZyVFU3WjFYVXRIaWha?=
 =?utf-8?B?OWorZGFkOERzSEZHRTFPcmtBN3BlOU1NVGw5TEdnS2ZwUjk2RFFBelNVUnFm?=
 =?utf-8?B?RzFQYjRFVG5TdzhnRURvMmVaMXdYL0tRQ1ZicTFpZnhDOUFMYi9ITWJQejY2?=
 =?utf-8?B?andheHduR3V1eWtxbE0zMmhQZVJiTXpra1FkOWZSTU1PQ1I0SDhkZEo2UkI1?=
 =?utf-8?B?RVB3eE1GbnRiUEM5QUlvNmFUTkxnam1VNmVBOU9ZWjhHQnlpU3ZCTjcwMVh5?=
 =?utf-8?B?NDhmVVkxdE1Bb0R2a1lhMTZrU0NSWG9jT3U2NnB6dEJHMStnNzNxK3RieXh0?=
 =?utf-8?B?ZS83T1RyYnh6Z283Q3ZrWWpKaEdUdHRwRDdUWGhpczRtMndDU2N2SXdqanp3?=
 =?utf-8?B?T0JXczVrUUdoR0FKbEFZRmtEQ0tqaytXckY1ZXJJQWM1ZjBFbGhCd3hITmh5?=
 =?utf-8?B?cFROYXNzZTVqRVFkenlBZ21hS2g4TGlLQXVUdnhRN3ZEMWhmTkpsdjFOVWlw?=
 =?utf-8?B?emlkN2wzUjNsSUwvc2FpUUdYdFFSUGpSd1BaUkpuR05yWkowM282a3loTm1G?=
 =?utf-8?B?WVhwNUtBbElTYnE4dzJvSVJwUTBHdG5ITGd1cDZNSlFOSzJqcjEvVmVubkk1?=
 =?utf-8?B?YWN6RERHd2JlcjNXajFwSVgwZW9ITnMzUFJCYXZPUmpsYzhiSWVTbTVDUzhB?=
 =?utf-8?B?UTFXbElYeVNWZE9DYmxPb3pvVDkwRk9TY2tSR3AzVXpnZlNVZ2xzMUFkMFh4?=
 =?utf-8?B?ejMxS0Y1RUtiS1YwVDVpTjY2eWROUTNWUnBSVmpQUXA0Zk1XNFo1c2NMenV1?=
 =?utf-8?B?ZlVKb1dsdU0ybXNLbzRPT0dVaitrcDFDSFFXeE1LNG1icHBLblZXS0lHblU4?=
 =?utf-8?B?NHJHTzhSRXo0cTBMK1BqckFQYWd6UTNuNzQzdGlwdjk3WS9uQ3krQlg1YWQr?=
 =?utf-8?B?QU9TRHF3SUdkSlkrc0tqNUdHRGwzNUJtVytWNkZGRytJU2ZCb2F0cU5GRjNx?=
 =?utf-8?B?cFQrK3p4RnlTaXdWSUVxcDkrZXp2S1RTN3dkb2dvMDJMRC9lckd4K3ZuNU5L?=
 =?utf-8?B?Nlh6MEJGeG5uSjBnVk4rKy9jaXlRd1VsZUkxMU1Ucm5NcWZXU0JwYmwvMEQ4?=
 =?utf-8?B?RU5rQ3daSVo4VElpU2ZLRVhrWlZaWWJLK3dsVVMxRlNyL3RPRGlQd2hUaVBp?=
 =?utf-8?B?andpamN6QTNHMmxDVHZyMEFxVFJNVE5IR1lGK0s3VHA3RzVLNmt1Um80Q3dN?=
 =?utf-8?B?UVpNbzNzcUtWcW9GVzJSYzVOekRRcVU1Rmg0MnBzK1IySE5hQVA4bC9aNWdP?=
 =?utf-8?B?THdSYnZ6NFdQQURtYklTRGpzZ0IrU3g4a0pqNmR2QlpDV2ZxK0l2ZWd3RTRV?=
 =?utf-8?B?SUc3UzNreDBzRjFiRHllT1JJL1hoY2EzQ3owc1JSTW5idnBKWWtVeHRBKzVx?=
 =?utf-8?B?MitiOU43MENHYkRqUFVsTk9heUh3T2JPNGZQV29TbTYrWGZaY3pCV2d0eEpB?=
 =?utf-8?B?c090Q3JPWUVrZVJFVld0cE5yQkNMcXJSMjBRbHdHVUZjREg0RVpTd3phdlRk?=
 =?utf-8?B?MTIyRVN3aE9YeUlvZVVBQWZnVzczUjlZRDk3RlplTjBhV2NxK3ZhNFdoMWVX?=
 =?utf-8?B?blVMNmRFYk9zVlhDVTEza0w5b2Q2eTNLc2lqUC94QWdCY2U1ZmQvVUpUQXV4?=
 =?utf-8?B?a2JuS2s0aEFXOUQ5emtwMGcrWFVoMlUzbUlQdDNEMDFvWC9MT3BYVk1YWXB4?=
 =?utf-8?B?bHFSVFhlMEltMjNRcXZYSDJIcEJ4d0o5UXZSbkF6eXN0QTVQRjR0N0g3STcy?=
 =?utf-8?Q?ucBVlkktCIgGCg6O8S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8bad69-0b15-42b1-9b4b-08dec1266d39
X-MS-Exchange-CrossTenant-AuthSource: DSSPR12MB999236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 04:13:12.1873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXyTmeI9AwoG2eCXfcrEyTq81Oq1ZvxgxWDJkhN17cvfH3SGiNHnnrlNoKN/xvXvPE1UM7lvI8pS63EW6V+GMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969



On 6/1/2026 8:30 PM, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 05:17:12AM +0000, Suravee Suthikulpanit wrote:
> 
>> [1] IOMMU Specification: https://docs.amd.com/v/u/en-US/48882_3.10_PUB
> 
> This link doesn't work

AMD Documentation team have recently updated the doc and remove the old 
link :( Here is the most recent one.

https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB

> And I'm not sure the older PDF has everything, I haven't figure out
> where in the spec this TransDevID stuff comes from

The term TransDevID is not mentioning in the spec. It's basically what 
we need to program into the VFCntlMMIO Offset {16’b[GuestID], 
6’b01_0000} Guest Miscellaneous Control Register bits [31:16] (DeviceID: 
The system deviceID which has the entire guest GPA to SPA translation).

The hardware expects driver to setup some unused DTE with the 
translation (Host Page Table Root Pointer [31:12], Mode[2:0], TV, V 
bits). So, I am referring to the device ID used as index of the unused 
DTE as TransDevID.

Suravee


>> [2] Linux git tree: https://github.com/AMDESE/linux-iommu/tree/linux-7.1.0-rc4-amd-viommu_upstream_v2
> 
> Build test all the kconfig combinations, I noticed problems.
> 
> Jason

