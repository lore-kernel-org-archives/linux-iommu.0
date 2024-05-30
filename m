Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC617C7CC
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717066539; cv=fail; b=DKhpLRoulTidx4RaYtBCObHl6+o/mKrIZnvQdxKriyH+S0gZMYUizHg9upOeneakQDYu/v3g0x3VQs5BTrBRYIgQzwXzb1WP+iCL35o6FulT4BQPD5cDBlHreWQaxv0wSFs/n/DEExNsRhwEhDAVLkkUyNJIk/DiQalt86w8sxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717066539; c=relaxed/simple;
	bh=AJHV53Aw4W5XSNKW9VC+gsDnYnyhkHLrJhIcQT+8WMo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ePNJSf9UKwpBWq3CXOXRhDlWYQuF7rCAGxPcNIJ3i7N5fKoW2ubnWXo4m9VIue3AziWOlpZegw283Hsys4dJNx4drbS1X/J46cU3qu7fJVS3SFCCyR/yMP9igwqZIRsEvCGDR5Ts2SsoTbAFWr9TqVdilBBGivGRZPVc4NfU1vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3olI2yGm; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3olI2yGm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRDvJGgERd4mndgQbQ2YqAwRWE22iBvokp8cG0VpqSMvglGkzXlcXfxMXQWOH+BqRbvnxADawo/i0Ttv7Br/xU4984ztShnzT3SL7r+WXCwZkEZ65XW6UiDU1r1LvopNVAdX2NCRsE7/902btcAaLODE91BtUq/Kqa+ekfqkeJMakZHTicEkIxn4qMw1UNpIE8T4jnnggydgpNNNlYsqrrG+eyk4y0LECt7RKgJm3I4j+ZzJQM2Wpi/JMWSxD8/hYFg0Fx/hRoYkpVfh5otFmwQUPucFXM0FDrUyEzkE29S+jwDnnrhkVZH9Ax2bvAtdBmvmyG+ksalfM0WHMdJ2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vud4aHIgbuApaV73Ceu0tFmc/mfPWE/2ErRrmS+RV8=;
 b=ZhVQMGhGDH5kATgHfofKt9zUN1+TN3stedhbF0wva0jpNqFmMXdhTy0a1dC3Y73HNQBgyAIJ9T5ponbpMxi211UR6Fju5PV8BiGNo7RHX4YfhNYQzeaz/Dz4qTRSNakeGlJauC5LQEFdQIynW93Kitddy2BxDvJVmjkcHU0ZUgdRB/ElZEV1BIdSaDlPZFQz0kSDfB+bQg0jxNGQrqJ5X/RYsIX38EpApU1YrLdzWZ+0UN8wTtijpWAUKPXoZBTi8ost5ra4spoPPo5wCzebNO05mSzSTKOhHc4biPd/ikx4i5CR3oEXE9DJhzlv/1KrblmZFeBK4X5p2LGecJ8G/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vud4aHIgbuApaV73Ceu0tFmc/mfPWE/2ErRrmS+RV8=;
 b=3olI2yGmzx4VR9jpnmYTkN34CVRqXwNqKR5APxZakZ5I0A74Pjd1InuA+BIgVYPdz0mKNAr3cyvatdFOOfyoeorX3OVno7mEUMBoOhx3iAZKMK4eEfMp9eUlpt73FPY7bxHmcwH+ooJ+0WSYm3ZHzz9imRD67Ry5AUNxdtcLk8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.17; Thu, 30 May 2024 10:55:32 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 10:55:32 +0000
Message-ID: <c03f6f4d-1a7a-4076-af4f-e3d66ace0861@amd.com>
Date: Thu, 30 May 2024 16:25:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu: Return right value in iommu_sva_bind_device()
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240528042528.71396-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240528042528.71396-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4f0a68-4824-43d1-2723-08dc8097066d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUpWRjB2anR5UTBPcmZRVjd1YStOWHo4Q0UxTTd4cFh0UUpabjZPZ1paOTdJ?=
 =?utf-8?B?aEphRTYzMmo4UVJ2UlJMc1N2eXdjd1c3R1lFNkUvQ0JEZjhhbmt3eElQS1Rj?=
 =?utf-8?B?UDhsV0hzODlYMXNpZHJCZVNNRTJXSFFJWjFKWTZnRmRpYVZvY0MycTlackFu?=
 =?utf-8?B?SjFZbzhBTE5hbzlVa0d5czJKK3JHMkRiaVZid1hONzQ4N2hray90cEtIMFFP?=
 =?utf-8?B?My8wOUdXbU16ay9kVWNaZVYwU1JJdnFrVC9vZHdrRmZzejJ3VnVzR0VQNTg5?=
 =?utf-8?B?SGsxdVhtV080Nlp3NjA1ajd6bkZHbGNsRDRUUGc2NWZZczJWRHJCeTdlUFNj?=
 =?utf-8?B?WHlER294eFJzU3FYQXlCa1VxTjVMajA4SjRBaWZCbU5uU2t3M3dxdi8xbmNj?=
 =?utf-8?B?TmdsdVM4QWxYTGM3S0tTT3NneWFHUTBzemlVczY3M3puVlFGZ0MrQlphRG1I?=
 =?utf-8?B?QllvVUVqRTZ3ZWVualBoVDNleEI5Qk80dDd1cC9KQnZOdGVYekxWcm1MVDFQ?=
 =?utf-8?B?WElod1ljOTBsOVQ4VTVsMXh3SUo1dEpZVnphQXdRMFBxd3BRNng4cGU0WFlD?=
 =?utf-8?B?TnVwdGEvS3lPbkhIQStSbk9lUkYyV2loVEEyVm9neHVsRWkvYmxyZjFXSnlV?=
 =?utf-8?B?RzdoMjBtQVpSSWx3SXlwK01XTFNBYjdhSURXeWV3MkIrcFJhOFhvNXpZTnRT?=
 =?utf-8?B?VE9oOXZKZmd4R2dwNlF0NHFqZUtXb0Y5SEVZVkVJcXJxUGJCVmEraFRMN1lG?=
 =?utf-8?B?NU84RFloWUJTOXgxekZkMUNxQWR1THdxMUxFc3I0SEozcTZ2eVVYM2ZWNjI3?=
 =?utf-8?B?NXI5NmtqQXM0ZjY0RTVQYksyNVhNSjYzSCtGRWtqWEhPQnAzL2JwZURhbStB?=
 =?utf-8?B?RUcxR2hFeFkyR2ZTZjJYOU9QbW9oNXp1MG1LS094bythUW9GcE1SU2pyMlUw?=
 =?utf-8?B?cjhHc2JET1NoMTJqM1AxSmdyRHhEUjVXbEFVNStkdy9JNFJmN1dUYXBKN2lB?=
 =?utf-8?B?SGY2NGVLMGk1bm9IMUVISzBZd1NQbWVRY1RvREpRNGNzRTBjU0JjdjA5b1ZI?=
 =?utf-8?B?TGs0dDlDeGN3bFczSzBCdHU3bmxCU1dlbENLUjBmc2tVcjJLWnpjOUlPK1RF?=
 =?utf-8?B?OUJ2V2daTHE0bGRCZVlVSmRwQVRLU3FZb3Y0TS8wUHFmRllYcXkxMC9TRGR4?=
 =?utf-8?B?dHZpOEVNQjFBNkFMUG96dGpMZUtKM0QyY2JqOSszZzNxSDcvb0luVFVWVHly?=
 =?utf-8?B?ajB2V3BBZUhrZG13NElIRUxmd2J0NjZGYmo4OUp5akkxTkRzemZ1YnUvTUU4?=
 =?utf-8?B?ejZrSWE2V2JTY3c2L2J4YUphTUwzVExodUE5WGowd1VQYnZWSFZhQ21qV3p6?=
 =?utf-8?B?SzM0cHZDSEdMSm9na0hSMEdPQS9IOTdZZ1BjT04xNmtlRHpwRllBY2MxRURW?=
 =?utf-8?B?MTk1NXBkRmphSkQ3N0w0VWp2dUcxL1p1RkVqeDBnMGNFSVY0Rm1WR3MrWmJO?=
 =?utf-8?B?Y3JLNStGZ2JiV2xCL0w4NlBGTUVqUUcxdXpWbVdHbERYS2FkcVAyM0NRWFhH?=
 =?utf-8?B?Vm04OTM4SktIbFdBMWFNUkptNWVnNXB4VUNoWUdndkk3Ky9uQ0hEczFhSFZy?=
 =?utf-8?B?UTYwRWRnYUMrNmplY2x5czVEN3lDMnVhblVIR0NkbzhvblBPWm9RWEZ0VWVG?=
 =?utf-8?B?M3ZoaDhWVkczTllzMVpQdzNoSE94c1hZQkZXNStCWUhocENqNVc2UDRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0R1ZFdQWVB6ZGxKS0Fhd3NUUVd4RGxNM3BXSDNNRSt2K0lkYjR2SlQrSTU1?=
 =?utf-8?B?ZmpONXkvaktCNzdONkNhZmw5dm0wcU9hVGl3NE5zaWFmdXFBczhTdFFYcis0?=
 =?utf-8?B?clZhUEhCMUhXa2x5UmJJNHZXUEpNa1YzcXF6d1pYMFhLUzRldGFjWGRUVk1Y?=
 =?utf-8?B?ZHZLd0lsWEhIbENQOE9ONUJ4bzRybnhXam95b3l0QnNjdlFxc0lwVFE3Z0FC?=
 =?utf-8?B?MytDYjlRL2xVZWd2a0wydkZDdmgyMkNRb1hwbWhqNnN3SWJ1RzR0ajJSUUwx?=
 =?utf-8?B?bFhrVGFyM0xDaDk2M01NQm5ZZDZOdXJYNTZ1bTlaT3pjN212ZzlVby9hUjBP?=
 =?utf-8?B?SUhrVkNKR2lZam9zUGJvRCtRNXNYamZEK3pKU2w5SXlhR3BjcjRLck1DTVpL?=
 =?utf-8?B?dHBoa2lqNWhnSEhkRUdla2hBSXFXc2t5Mk02QmUwSU45ajRRRlJNTmlFZVRy?=
 =?utf-8?B?bGtuQVBWZjhpdE9hMHJ5T1lvNHJSTzJudlVCMEROb28rak11Y2VhdFpRc3NF?=
 =?utf-8?B?OVRqdGUzT0pOZ0hYN3YrSTMrT2tTMkZ6KzdKQ1lGbStXWXNvdnVxUDlpMUEv?=
 =?utf-8?B?UmlieDlOOEJrYnhXS01WN2VlMTczRjBTTmpYZmx1VVU4dHEvYTJ6dnBWd2Jt?=
 =?utf-8?B?YlppRHhPQXQzM1RMM3hEYU1wT3dTOCtlejY4eW4wdlNScHhNSVRwTUJYY1gy?=
 =?utf-8?B?S1NTRjVxR3MyQzlTaGpUbWREZlZyZkpiRjcyc1V2SkttQS9pWGpJaDA4Tm5R?=
 =?utf-8?B?SS9lQldYSzdyd3V4aDIrNmJudkJPNkhrRjU5ZmNhdGlsU21SSUNwZHR3MFB4?=
 =?utf-8?B?aXFUSGp2YTRSbjNOV240QVZwNzJRTTl2eXVtcHNuQTRUWFkyTklYeHFUS3Vy?=
 =?utf-8?B?SXhhS3F4bFg1NFRhL3Q4N3dsWitFU00rT28vdjFxMUg3bHYzcFJZT2w5L2ZR?=
 =?utf-8?B?ZkE5WFM0eUZXTVYvMk5YVEduc2FMZm5UMW5ETFV2dk5EeTlPMEJ0VlV0dzdj?=
 =?utf-8?B?SEI5dmNDM0FEUlo2YkxZTnphYzNYSmExcDBDVnBncVJOdzZ2VkN0TWxpeERD?=
 =?utf-8?B?cFZCQmxYMm42eW4xbVhJNWx5alFMaW5oM2pYV1dZYzV6aUlHK1FSNHh3bFlX?=
 =?utf-8?B?V3ZlM3g3SXZGaFAyRXFXRlJpN1VnSnpjbUJ3K29kKzdkT2cveVBOQmFnSGgx?=
 =?utf-8?B?SHhieHdUM0RObzRPck9iRVBpNTI0VU1tOWJVWmptRjYrOEdlUWw2VzdiSEJ1?=
 =?utf-8?B?TENaTzVSVEVBdTJyR09EdFU0TnZXc1czQkNqaVozVmtOTDZTM3BwTG1xU2k1?=
 =?utf-8?B?K2lrRjhIbWhtQnFjS0NJNk9Pb2JVNTVud0lITktCMzRuOElUcVhTK0k5VGw0?=
 =?utf-8?B?VTF0b1VzYldEcEk5bUMxWlk5TGRaUTNjQVNBNXEvbWVHQ0ZsVktpVEl0T2pI?=
 =?utf-8?B?T3VoTVV3eTJONFJvcktTYWpEczVqNi9sRHNEcTRrc2JMUTE4S2I5ZmNVclFC?=
 =?utf-8?B?Y3czR2xvYU5qUVR4NVRLNlJmVWtXaXc0QlNDNHRucFhXczJFc0RWZ3RRNld0?=
 =?utf-8?B?dGpuL09zMnlHb3pDZjl1bmRzSFpFME5FNWwrU1ZzVm43aHBLL3NPVXVJSWxq?=
 =?utf-8?B?d2VEbmJRK25KTXZHMDlScXh1UGNpU0lYcmpnQ0hOQXpCTUJqWjk1NE10cjFR?=
 =?utf-8?B?Mkg2eDhzRytsSW9FSzIvRkpFcWVFQzJtd04yU0IxMExLbVViczQxaHFFTmhX?=
 =?utf-8?B?N0M1eVF0NHZnYTJuckFINFdwTmJKd3FNVzduRkEwdWgvUnlYQlZlcEp0N2JG?=
 =?utf-8?B?ckxKMmxBd3hWYjJMMUxJTFZ6Q2czOHQ0eXluQVZ3Zm5vKzBIRUZiSWxWMXVI?=
 =?utf-8?B?RFBVY0JRT3J3UEVsYWdWcm1oOGpRek9CVjByQTJpRjVHTDE1Szl1Ynd6QTg4?=
 =?utf-8?B?cWhrZFppWGJuWmViZS9vSGhsSHpZbkJ6NTZkNS8vcFdzMHptQklXMHRkNlpF?=
 =?utf-8?B?aFpqOUxTY3VtanNISUJoQ283cEhPOGsrdEZIYm95QWFieVEvUk95S3l6azlv?=
 =?utf-8?B?NWpmRll5azNnSzErTDFCYU8yR041N3QxWjNvR0N5RDlTT1FpVHlQKzQvWUFY?=
 =?utf-8?Q?8ouoM5VPAFQs+60LQLONaNjFu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4f0a68-4824-43d1-2723-08dc8097066d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 10:55:31.9486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nROEXp9Xb4+PO6puPSH1JOe4YH0Dbx75yBsd8W9Nl2O4JomXIAncX7Ph0IvXaRAX7ujW0O0nkbOHu9knpZGzSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648

On 5/28/2024 9:55 AM, Lu Baolu wrote:
> iommu_sva_bind_device() should return either a sva bond handle or an
> ERR_PTR value in error cases. Existing drivers (idxd and uacce) only
> check the return value with IS_ERR(). This could potentially lead to
> a kernel NULL pointer dereference issue if the function returns NULL
> instead of an error pointer.
> 
> In reality, this doesn't cause any problems because iommu_sva_bind_device()
> only returns NULL when the kernel is not configured with CONFIG_IOMMU_SVA.
> In this case, iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) will
> return an error, and the device drivers won't call iommu_sva_bind_device()
> at all.>
> Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

