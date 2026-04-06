Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013019.outbound.protection.outlook.com [40.93.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A4C3290C7
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494983; cv=fail; b=rN63ZjM7zYcO/tMOXbJRToM1GAVqJ+XVhVqlMOY0T6SGqRFI5EB3ZEGrTjEjbI4IsrVIfpWH6BAJbu13MNIUbGaFDvmNdAJzrd+4rIx8KWGjMzaVkQyFr63vS0/6qMMS6r5HOdK5hMzonVPmLPy4OdxYAxzjsV+lg1/xWZ2TKW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494983; c=relaxed/simple;
	bh=dAnsY81kRXis19+CJAyt6bg+m4P3w5xMYLGHrHn2qNA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YE+KXLTVqsHkLvJg/+S5Lg4L+IeTGCpNFZgCNxhG/tIp0QJhQGhgisZAyc7CP864r2Ss0rs/oONevlk2+7SnukKd0qtS546g4DGFv4cL/Eg90s4enld/Weq/bMNtwMQj611/2/jjNP/ssukQPKFhibWtWsn+S9s6FCvgma+ubwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zk+GijUG; arc=fail smtp.client-ip=40.93.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zk+GijUG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQhb5td0fQlBl5tGTxuyrs8oL9DVHhMzBg1yU+O3WYUt0kK0QVNi5WUM6DnG57M+zcMmPBR0D5f8lO7Wh1p9wcKz+MhPc+VYj2F6H1++hulDFPfoxOBYSRyNTd2G62BLJALghavm83SGjBbN0M0uOWkEPgPIovdTvSg1fSWLzIRHILivwWLDwJ5UURLZ5F3c3M1P12N8fuYEFRDM5OypLi1m5o6tUKVQh4iMgt+lZ20h5lBEP+8crAPLJQWInnzO+Yms+YL1w6pzIaaU8XzKG0zuYMCLc+jI1979Hn9bPyZU7UBrS4RZLjEL6imlqpAqdbnSICkAXqVe3r+UyA9zkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPRVxFLJZ7JqTKu7T8rGldfiuYQ9x0ChKbW7D1duIwE=;
 b=XWJzlE5o011liV0XJolJUUw1wsGb7NW1mMUyDZIlB5Ihkt2sqyaJbrjCYqJHybjnnxF5NVUz+oym/+SvPFfQHegaRc/3NUMsxZ/JOdBGzKAzVSElOpeGsroEOGbF4yv7VZJ+1BuVVSbDJeLptTyNbr3qxBp+ViHXLtz5Q9uplFyFKXR0n7Fic0Vy4Kv1xS+6zCt7VKfWbh/iaqw2oTEwcuRqCyTXOyWpmNDk3y1IJMzTud57CFv6qlWLpVCHVSG3b+fmacxhdxITO/FA1MQ/HVmMPFSX2G30YHAYIbfEpBFgzsOZstcXwZExPkzsZfuN839cnomT3P7I7BphrT7yRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPRVxFLJZ7JqTKu7T8rGldfiuYQ9x0ChKbW7D1duIwE=;
 b=zk+GijUGj7MueITAn5Uv5KcSaeo6/wErJlCKqjIgLtDqjjQ5458to4dravWaAuTAXN1S82lIo9Fk51GOOmvCS4cwYAkoOZXQ2VQQuoNrBfW3dEIX0hRj7xeNmwOO0wHcFIKF1TAf28RFgnPdC2L2Aa1OxVBJcmvGPUsOxP/ut04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 17:02:59 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%7]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 17:02:59 +0000
Message-ID: <ae009e39-7a1a-484c-9b7f-65038950c9e1@amd.com>
Date: Tue, 7 Apr 2026 00:02:48 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/22] iommufd: Introduce vIOMMU option via IOMMU_OPTION
 ioctl
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
 <20260330084206.9251-21-suravee.suthikulpanit@amd.com>
 <20260330121507.GD310919@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260330121507.GD310919@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 412b54bb-4253-448e-77e8-08de93fe5aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/4GnQFO6ZY8VPdF5vMvBqESXpqDRwud1EW1O2SkPy5zcVu024rvoE9wBlHfNKADwoJvtQIdH46osHarKHmY+u5CErR0pDIdV/t/lsEy/lJWgUyb3EzZwMTfStfWj6Wq2ebQoS8/SRqEGeGg8i+AhPUfMUQxZ30hrsmNZYJPZ1ejhAmyr1NDF/JjwNeoyD+EhVUJ3O0X4Br51niKbzLQ3Rk+2UElEVJIJrP4AKHmSnRcIURm0ueFqSC6AbHVnclJQWIV1Sdy/0pNknbBZMzZx6A9z++pACj7r0mXn0MBkvlXtKt4w/Me0DimKCKpE084BVCDGWb1m+z/YVpfz57b/knDCPJC/oq5c9tEp1NvDh86OiLYjjGN0uoUIx+HAWOGnxt89deEHDM44cWDJrLyLPMhZSBbTqoAFtY29eGK8TGasxbOT+feOMMY4UraSpOtEHt+Co6FECvYWt7QTPARpX8/YvsP5dsxlBy7JogWYM9A3O91u2cHjIQyqHQ4B6VKL7vBG8sv5MlORgi1L/SibZWccVJgTtGu4WKi1mXLpssAoRXmSnoGmlFxLJFrLSr1WtLXWgCsK0XmxmiTIffQ2EN1Id0BsYDFFdgnhKkPuLck2mfpemtz7rsS6oz48x+k2fLOiP4K6s7w7ALe3jVqBKd5A+YMAO0GLM2TKWFnpK8mJI5I0x8mxJRyssoM0uZegEgJ37w04th31jwOBF/Zjz8k+/jSr5TSq9/x9FRDouDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWJFV1hqWmJuYjlMUmgxd25GSlhqcDNUdEM3amZ5VjYvMXVDV2hTRituNkVI?=
 =?utf-8?B?aHJPRlFlMWJncDlONDN0dnFnenNnMkNqTWJ4S1BZaHZhODYvWS92LzFhV25y?=
 =?utf-8?B?bUlwYit4QXJZN0JXOE9YazlMdXhwRzlEMGRzNk01S1Vjc0RLQlBuc0N4QVlP?=
 =?utf-8?B?OGYzNzgrZU56Y3JaVE52MDhwaE1URlA2T0xtL2o0N2E2SURyZ0s2QWlTT1g2?=
 =?utf-8?B?RHZqL2N4MnZ4aU0rdVJMSUlDbFZmeUQ0QU1rV0ZwNnV4T0V5S2E4b2syT21Z?=
 =?utf-8?B?WW1pRFJDWVlna0ZCcEtlOE55amMzanZOVlNNcWhpemlxUXE2d01PWEVhYXBB?=
 =?utf-8?B?ekFhdWxiUHhkZVpld0xKemh0eUpqOUFKYjVScmM3T05zSzhBeGdjbWFFVlhH?=
 =?utf-8?B?RWNJS0tSMU14aVZ2amlDM3ZwQXNCcnB4bjIzdVJ2WTR6bUtJdlM4cHNkUDhP?=
 =?utf-8?B?emg3aU54dm8yNnRsbDIvTmF3OHg5QkwyY0Z5dG9Lb2VKN1E2aVVnQkZlcGxa?=
 =?utf-8?B?eDVlV1BNaCtZVTFqRVBGdnpNN1doV3E0bm9MT3hKb05JZ1piT1FwUGh6MXI2?=
 =?utf-8?B?YUFKV2R1YzhQQ3dVSFJvNlA0S21ibTN1d1JYd2xiNWtmVjIxNjRobnk4UUtt?=
 =?utf-8?B?cEdxVlJob3JKeEJpZkpEazl3WFVXNG9HQXdUQmJFaEp2R0pHamRQZnVrNGxs?=
 =?utf-8?B?N0dmRnBueTU5SnB5Zk9pc1hLeHRRdWN0cFRpRmIraDMxT3luS3N4OEllRjNH?=
 =?utf-8?B?dFZEVDJURHVTNm9KdTBKV2MxQVVOTEVubVhMM015SjRBak5EUGlRSHFZWkR2?=
 =?utf-8?B?UkthT2FXOGo2SndVZ1V2SVNKbEtlSXAwMWlNckkvdGJ6dHRpdGYyT0s0OEpQ?=
 =?utf-8?B?SytDTzFKaWpyU01XMTlrS20yUk5VMUkzZTRWWmVYRmMycEJJbmVVNWo2MWV4?=
 =?utf-8?B?MUhlWGpCVERZS1c3NER3c0xDcHJIcStYUjA2V2dnQ3VoSEZUNUZmM3RDM3R2?=
 =?utf-8?B?T2Vmb3QyS1VvN24vME9EdnFxVUdqVms5c3JNL202TWRkSVQ3TzVkbllnaEZQ?=
 =?utf-8?B?cVBmdFJ3WC9jUnh5bGVSUW9XVW5LaXJKVXA3d2JHQ3FqWC9oYU5KTXFXcW9J?=
 =?utf-8?B?ck8zRkZIMGhCL21QTVZZQ0J5Y2VQS3BnYXR2bUtlZE5YVzJJNHVJN1pwZFRF?=
 =?utf-8?B?MkpVYXpDbFg5RkJCdktkdGFKeDRHTTVjRlBrbWdIZmZVbWZxeXJoOURiSU9U?=
 =?utf-8?B?d1J1ZDBxRjRIYXFzUVhpWU5OTllYanMwbkNYb3NwNUpCUXZDZWh2d2tZZGNj?=
 =?utf-8?B?aUExWXJnWHFUZXQrUitRbDFham02YldXMzBubnZXUC9HOWFZTHRMektVL1lD?=
 =?utf-8?B?a0lUQmIrSFRSS01RNXZrN2pCbG1nbis4RzRib04vOVBLYkpWMFVtaDdaQjdw?=
 =?utf-8?B?b0xlcmY2WkNyc3VTWGpMWGNiaG80eHBGOG9HN0ZWUUNiWUpHQzZ5dE8rdENU?=
 =?utf-8?B?cCt6V1kyeUhSUFd2RHNNbU9nN3dWek4waldORTRTb1oyeTRmeG5nQlZEQ2RB?=
 =?utf-8?B?ZEcyK1prQ2U5eEdWeStzYWVQZ2l5SGZuVkdrMVpPdFNoNkcrU1N5dmk5cnd0?=
 =?utf-8?B?OEZYdWtXaDZQOHNuOHdHUGdBMTc0UU5MdEdxVFB2ZndSRmxKRmtLZitaMjNW?=
 =?utf-8?B?SExqWXVCL2c0RkRETTNOVlhic0c5aVZtdDZVQmU5clNYUkQ0UVZ1U0V2clBS?=
 =?utf-8?B?Tk1QRnFYNGdqSGlXN0dIWFFWU240SWUxdGxSeXk5c08vNXNtKzRLZmhSNnZ5?=
 =?utf-8?B?djFvZWJ5eTZvRXhieDNDVGNVZHA1aktxU2hLbW1tc0Q1bStkYmRLMnNMb1ZH?=
 =?utf-8?B?cjEybGdocE5xQmtHSkZIb0ZKSnhVTnZEakRNcVNPdWdDSXMrMUgveWVNZXRm?=
 =?utf-8?B?UCtmdUtNNXQ4dlhwR1BCNU91QS9PeTFSclpuVFFIWkdrVk1IZGJ2QVNnMXls?=
 =?utf-8?B?anF3V1dJQkVyWEJMaGwzMzdaQ3hJVEtZV2V3dmo3Z2lTbm1Xb0RiYnZTNVdj?=
 =?utf-8?B?SVg4MXpCTHdVVFpwaktwTjk1NmNxK3NiN3JRUSt4N0Q3YjdxZVcrTy9Jam9L?=
 =?utf-8?B?YThUYXVscjh1MDlydDZ1dzZvVXQ5QUpHQlZ5MWpROHR2dWJLYTJDYUZZbnZm?=
 =?utf-8?B?WXBKOE1NV1M0aFE3Z2xpY1hkeWpCZkdhWWdBVGVpSHVsZlc4TnAvaVgrMHA4?=
 =?utf-8?B?RjdUaWRBSHIyajg0eHNmZnZZVU8yV2dBT2dOK3BmRkNsSGdVaklnSkpweWtr?=
 =?utf-8?B?NWpnMGxVSGNOdUxGRCtEditxeFlwODFsd3FTbDdCUGZGaW5pQUxtZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412b54bb-4253-448e-77e8-08de93fe5aad
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:02:58.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxhSsXU6ZeEN3ZPSVXM9V1OPrxrdG5dGGq/RmYGC3jtrPJGzSfP+Ur9CS9BI2d0Cz/OyNEXfX5+V1HK+Ro3SQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466



On 3/30/2026 7:15 PM, Jason Gunthorpe wrote:
> On Mon, Mar 30, 2026 at 08:42:04AM +0000, Suravee Suthikulpanit wrote:
>> Introduce a new iommufd_option enum value, IOMMU_OPTION_VIOMMU, to
>> support vIOMMU-specific options. Extend the existing IOMMU_OPTION
>> ioctl to accept key-value style input, enabling access to data arrays
>> such as hardware registers.
>>
>> Additionally, introduce struct iommufd_viommu_ops with set_option
>> and get_option callbacks to support IOMMUFD vIOMMU options.
> 
> This doesn't seem like the right API to use use for this. You should
> probably add a new ioctl for viommu "commands" or something like that
> which is better structured..
> 
> Jason

Ok. I'll introduce a new IOCTL.

Suravee
