Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03833993
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736252547; cv=fail; b=mcboz17ftHl4+IaqXt9RGClBN0A3OxNhGwkNpitgvzyGDrzlvEZsY0SDXbx6R/CuSFbNu/aE+oDWzaofFpx7X8+chHoD+IPP8VPDSaK1QQrpum/h4d9Yq3tZu47MXcRad/5W6eOzZdVhD54ECJ+1nOtL9y3HEEKP7FesUPYj/XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736252547; c=relaxed/simple;
	bh=+HF8GXxsij2MAe6L1bvssxgkeh7CtEM1rG9u5mSgD0g=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZmdNJhKb6BOYvOYUpa4i3MZTdWTLY427tmYQ7evTZCuSQ1PE+/qihwj0LtQ6DpcAA3CaUDIizKrCYWFKRpiWjZy88Qy+ep4DghqHs50S79vCrggoZbabDppj1t+YSjDz57qvcC9awWULvpOuFeQ67TBxypk3xIyJi6a07gjywX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fmy0Ri9x; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fmy0Ri9x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSJ1XazRTXIWMuDNVjaDy/nixFM0wrPFkOEJD3LA0xoQW9HBAF8LBsrRt+fwSVz90NueRJR+awZF9A+zzQ/gC8heLyR/pTEttcXKpdb0vaAOoxNP/9z4yP7ej8cMMpJEw/N++858qhASx+g156G8u5k+NaylaL4rLm2A1bLTuC3cdT6CV/AtTg8MS3VaRNWcNV3snxVWDS16s2x3MJrHEzj5ezbYXZj8K75T8IZLz2uzCIfevshDtU/jkNTjlCqN/yl5H1bJ5gNrfC6FDkmv63zn9JxdUPxC1HTHsKj9eQ+zQbZkNo9TasApGsN5rx79jCGYBPLQSCPPID+x2eVF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRlAXac/i4Y6Duxse1RH7fF0qAagtAVawLrErzkRk7Q=;
 b=yw2Lo6ISotQkJBdjBO8IRdzAuJrMrwUNuB/rue84nAIXXl3xEzNQjbKoWEyJnX/rPGRTiXpC9Itvb71WVGLB4667py8Fccs8uhn2Caav46GqsuYFjpkz2p6vHoSHhqjLfFZEkGtIBOFDeEslJACGJdY/J1WUO0WK7VtpBcrKBBO7CW88kKVxH4ltYCoppsoxxMwqEPBQs9TvIgIkreNaLOQUvmxVGA7PGGBI931tWAeQwkIwxSwXfWjNHvMqyxJxCETJpS1/Vo1NvgszemRHwtibSzvwguDKdyOTBvxerfUULfX2ujulpANMl7Rq6OfHh3dFWvvBKGI/pxE1TNF3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRlAXac/i4Y6Duxse1RH7fF0qAagtAVawLrErzkRk7Q=;
 b=fmy0Ri9xZxQerPRivcGj50KGtrRYqP5iV87rJS5RVkgssvIjInoELEsZin5WklB03g+7jr4tZ8sW+E7DOHNdiHxqP4d+co3YfiHuB3LOkwiYoF2sE3+sh+oTxyF0BbGGssQtH+WgweWxBaB5ch/07aOAnG4hO/O66HZEXqs/NRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.18; Tue, 7 Jan 2025 12:22:16 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8335.011; Tue, 7 Jan 2025
 12:22:16 +0000
Message-ID: <cafe5714-aeaa-4774-bdad-124e4e036ae7@amd.com>
Date: Tue, 7 Jan 2025 17:52:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][v2] iommu: move the adding group info to proper place
To: Li RongQing <lirongqing@baidu.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, iommu@lists.linux.dev, baolu.lu@linux.intel.com
References: <20250107033558.41135-1-lirongqing@baidu.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250107033558.41135-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: c11af973-941d-4d0c-5cab-08dd2f15ec2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkFMdWJFYldVTlNaUW52RDd6SFQwTFc3MXpPQUtSTWZEUXhQYmZlQUJoRXB3?=
 =?utf-8?B?MXYwUDR2c0wvdVNlaGlwMmF1cVhqODFKcVJ5TENxRzhoWVBFNVphSWlrVGZO?=
 =?utf-8?B?OWx3SWVtRlJYZXdaQjRYR0JYd2JlMEk4YXZKU2ZWVm5hdGc5UDJVTVhIMEZa?=
 =?utf-8?B?S2J4a0s4WElnVjRDVTN4d2JzVFg5a1ZLcG42aUJ0ek05TEttaURkaFNvYnl1?=
 =?utf-8?B?ZDhIR3EzTktzcW9aZENMdXZaZ09CSnU0Z2xlZ2QxSTRlYU9uY0lQdFVhWDJp?=
 =?utf-8?B?UDNiZUlIaE9YVE1Id3lhMXpLS1lCcU15L1RkWCtCa0dnUW9DYXI2UE01OWdt?=
 =?utf-8?B?UktVdjVsSXN0Y0VUVEZjcGRjSGxUaXA0cExoR0xlaHhSaURJaHFsLzRiZGlo?=
 =?utf-8?B?NXo5NjhrSDJtMXlSd3hkMGUwZ3lDVHVNcTZQS3ZVWHlrdkVUa3NoMmQzYlN6?=
 =?utf-8?B?R3RYbVc2RnFUVHg0RXAza2RLMUhtRkdrWUlEZlFqdGxNSzV1NkRCRmhkRWw4?=
 =?utf-8?B?WGc0aWxyOGs1STdDaDZoYTk3MzlYL3BpS3dKZWg5V01USHplN2ZNcHRpK3Fl?=
 =?utf-8?B?cHFvRzFJYmNoSVdmNk1ocCs4NUJMNXcxRWROK3l1WG5wa0plL2RqODY3Ymoz?=
 =?utf-8?B?TE02cFd5RnBYclpsNUxHMm16RmNMbXNXa0wyQjlYQnlTa3JVY3B1dnkrdzJB?=
 =?utf-8?B?RGQzTnFvaGpRS3FjcWhUb3pFSTJhY2doeVNKb1hDWHBqcUJTZGYxOC9vYzB0?=
 =?utf-8?B?TFdTbGQ5UXpjRTJjWmxGNVU5Mkt0Z0F5SFlIMkRxdzBPVGtWQklkai9kRXNo?=
 =?utf-8?B?ZFp6aVhrUUpSUmhtZ2d6ME9OaG91UmtHeXYwWXBvdTcwRkpBaE1zcDJtSVkw?=
 =?utf-8?B?Qm1CWldmdmZ5bmJsZVQ3d29uSUUwNG9UUDJEMnZKQys1NDlYeTh6ODZnWTlV?=
 =?utf-8?B?RlFvbFZLSlFLUzZ3cS9ZdlMwTHQ2K3A4NUJrWU9UYmdqcHR4MnN3U3ZkdGlS?=
 =?utf-8?B?MjZRdUlYUXcyemlza3R1bnZFL0hhOHd4dDZvSG1BNm5nRi8wNmJ1SFk4b1FG?=
 =?utf-8?B?Mk9GV2kzWlg0eUROOUEzWGhUTUZJK1Y3Y0llQ0x5cWJibG5VMi9rdVlSZmxw?=
 =?utf-8?B?cS9ZK09JdUl2enlqUk5ld3VMT1RFNCtnUVFkUDdLdVpVdUErR1hTYlppVm5T?=
 =?utf-8?B?U1FzWHh6VTVZTy9yNXQ4ZHp1QnFGcHNwcTg3WnpsaDM1ZlFzL2lkS29jRWR5?=
 =?utf-8?B?cUhJU1Bld0taM0JJU0pHVERTeHk4T1pBOVFjR0RUUlVyWmtCMlhBQkN0NkFU?=
 =?utf-8?B?Y2JEMko5elNGOGRlMDF1N3BhSlNYWDUzWHUwRnFHNUk0ajJhdGxNdkdTL3Jr?=
 =?utf-8?B?ajRKTnVyVDlzVDkxbmlmQ1BnWExGZHdMVHBTZDlvNXdkeEdZVnMzWkIyRXFL?=
 =?utf-8?B?VW9oR0JDY0l6SzBpMjN4c2lRT2Iya3JldjFwZXQ0UjN5enpiSFJ0NGVwTjlr?=
 =?utf-8?B?cW8yd01ycEZQQjZZenkrZXJsOW1MSmNKTzg2ZHpRUm9EOW9sbytwUDMzYXhz?=
 =?utf-8?B?YnB2aTQybWtEVjZOWW5kKzBiVlNlL0tjNC9GVDhuaGk4L3krSkdJNzNjQUcz?=
 =?utf-8?B?b2FtODduNnNSZ1Qwb2lsYllJTlo1TmprVWxjTHhhNHVEMWhpNzhWVG90RzhY?=
 =?utf-8?B?cnFORkJIdXB2YS9DRXBucVBNUUw4SmNncnlYaFpzL0hUL1dPZXMxaGJyTDZj?=
 =?utf-8?B?Q016QU8wengwMGJLWFpZOFlhcTdhNTFrVDZBSmZBa2hSWlBSR0FPTVlOYjll?=
 =?utf-8?B?Tkp6YzI1RnRXZVVDeFp2aktDbGNkK0V4ZmQ3NmY3c2FWVk1qSGNBRUcrdkdQ?=
 =?utf-8?Q?Pndx9fOLF8sCT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVBVcVpvbzFRTlBzMk4vdTZmam9BblNSSDN0NEtmZHJWaEhCVXdSUzJ5U1pT?=
 =?utf-8?B?WW1ULy84aElpQ0FjUmlhRWRDeVV1NGhmSXRNRHJYYWFQcUZzYTh2eGlBQUdS?=
 =?utf-8?B?bTFHZ0xsR2dzd3l1aXAxMm9XWGV5MGNJZWJObmIzUDJZTWhxZnoyL2w3U0c0?=
 =?utf-8?B?eTVCMG1FMFR5a2d6d3lreWdTeW1YMEVUNGRNc3RaUnNkbStudVNLZEx4OHhJ?=
 =?utf-8?B?aVVEWmZXWCsrZERJb29panZyR09VWW9GQTc3OFZOWWNER0tpTW1MNlVlZUJw?=
 =?utf-8?B?Y29FQTVlQkRZVytpY1lCcXpmZTNtMmRtTTl1NlhjNFFaZHVydFhDb3FsMDNp?=
 =?utf-8?B?U050dU81bXd3QnMxMFBqRjJtekpkL1Ewa3h0b1FpSjYwUXBBaUFVei9XSHo2?=
 =?utf-8?B?VGVuWjg3cHFhNnJBaXFrK3pTd2VQS2ZNeWI2aVo5dTUxWG9pRnRBMkpFaFkx?=
 =?utf-8?B?Q2xUMlRvOXlWa2VmN0VUZlg2bEFtQXJtR1FsZzRaVEIwcm9MSVgwN0MyMnIv?=
 =?utf-8?B?MzJLQk9KaUwwWWFCbExOK3FWbzBwQVF6OHJyQmJXQmdnT25NSTdqL2lZSEV5?=
 =?utf-8?B?Z1dNTTZ3ZDdCcTJMZWRUUytGbVhyZ2ZyQVdhRCtIa1VVMFd1WkFoSDJZMkFN?=
 =?utf-8?B?VUR3aDVLT2l6eWtmdkprK0RqV1ROMUtPM0lIUnBOVVdVOGpnNEw0ZS8ydUJU?=
 =?utf-8?B?b0g5SDNMN3JZTEZKbHRQK1dPdmNXRjdEdUk5M1JXdVBJU0Naa1R4MnZHak5h?=
 =?utf-8?B?OUtJbmlJN3cyRG9NTFErSkNycHJnSHBqampadTg1OXdmTkZjeU1zM0wrc3g1?=
 =?utf-8?B?WXdreEh0L2lHS0o5L2NueWZ5RzF3MDlPQ0RRWVRKcFZXMlQrY1RNR0J5cVdj?=
 =?utf-8?B?dm1SN25aUGszYTdnamU1NnI0OUJNcHd6MDV0WkFTSGFXUmNiWW9XVUFEdlNp?=
 =?utf-8?B?MVZ0MEdaRDNNekV3OG04WDBIQStIZ29EYWhSeFFqNUxwQVlNWVFHcHlLRG1o?=
 =?utf-8?B?Y0lzaXNxYVFvb0xQcXhxUm5jcVZmZ1M4dWczVnVPWWpvbTZxQTFHQ1grVGM3?=
 =?utf-8?B?MERIcG1TVy93dGg2akdPdCtCRWhPeERJY0VMWEpvMGpmbFpYY09ZQ3FYSG5M?=
 =?utf-8?B?NXVjRzRQemVhdHdJTVREbFM1enNnUlR6NVRYWXdaZWgzOWMwazhmN1dQTWRi?=
 =?utf-8?B?OHRZSXF1VlI5dUZOL0Y5OFR4ZWpCN1l4YkhLdkZFWWt5SDl4cmRBRTJ5cjBC?=
 =?utf-8?B?YUt1ODYvWTlCR1A0Q1hhUEFWRkNmTVRoSlpzVldGS1pNYzFlWG5xTkJIVHBS?=
 =?utf-8?B?eXExclRnNG1aZnBackVsZnBlQVNSWFBZMlJPdk94bGdBVkFhTDRkLzZtYVVm?=
 =?utf-8?B?SS9wK3NNdFQ5OTZQRmhtWHVFcXhRWE9aSDlTb0psVTEwcWZmUCthdENBUFhs?=
 =?utf-8?B?bTRBME4vbE1NRitlNjdteXRLQm9RZWh1U29qMnkxelorRnN2UlVoR1o1MlR6?=
 =?utf-8?B?Zy9ITjhXOVozcTdCa3crZ0xUZGZnNS9iVVdEUDI1eUo0SHhXTmVmZXlwK2hT?=
 =?utf-8?B?MzRSSDJhVmdUNU1GODVIUnY0UmlQY2J3MDBjVktaUFVuQzN2Sk41VGM4SmZo?=
 =?utf-8?B?NzZRM09vaVRUT3BKaUpPTkdheng4d3hKQkNsQ3dWMm53eFd0Mk1la3hEMGhu?=
 =?utf-8?B?Y213di9rV3dRRVZNSlNCcGpGdHlUVXhiWEFLakZkL0QrWDNHcjBYcG9MUGtr?=
 =?utf-8?B?YUt1ZGt6SFB3VDV6VW9jK242ZGg1NmdnT3MremNGOVFIemJQN3FmanZMNkVM?=
 =?utf-8?B?T0xocnVyTDVSK1RzenFkTGVTSGw4UVd5SnhYTHhBNUlzMEVTRjB2QzJQbTFT?=
 =?utf-8?B?RTFqcGlVbXhCNnBGYnFYd2JPdktuSENSOEowVEV2aUZHQTNlQzhzbkxJUmt2?=
 =?utf-8?B?cFZEOFVpMDc5ZTlRbTBTNVQ0NlJ3dHBFeXlMTktGanNjelJBNnBzdGtiMDNw?=
 =?utf-8?B?cTVGWkpCdDhJQi8vVGsvcDdGMHdnTlBOTUFDYi82VnRIMzJiM21Gd1RpRDJs?=
 =?utf-8?B?Y2JrSHA4SnhZUE5MYXFOYVNDanhFWTNJdkNEWWd4M2FRaGxmOWxvWHErQko5?=
 =?utf-8?Q?5UhENrOguSmexulxlI1htcHCy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11af973-941d-4d0c-5cab-08dd2f15ec2c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 12:22:16.2930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFM9U/zB6IzF8X2/2upna0J49cof3V/qwpZluqXavOLlWWhqet5P69D0+rSOdKSubW1R2evhJLlFy5LpKl3CYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190

Hi Li,


On 1/7/2025 9:05 AM, Li RongQing wrote:
> After commit fa0828036488 ("iommu: Split iommu_group_add_device()"), the
> adding group information is left in iommu_group_alloc_device, but which
> only allocate group device, not attach the device to iommu group;
> 
> so move the print to iommu probing and adding functions
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v1: add log when iommu_group_alloc_device failed in iommu_group_add_device
> 
>  drivers/iommu/iommu.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 599030e..2eaa8ab 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -586,6 +586,9 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  
>  	mutex_unlock(&group->mutex);
>  
> +	trace_add_device_to_group(group->id, dev);
> +	dev_info(dev, "Adding to iommu group %d\n", group->id);
> +
>  	return 0;
>  
>  err_remove_gdev:
> @@ -594,6 +597,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  err_put_group:
>  	iommu_deinit_device(dev);
>  	mutex_unlock(&group->mutex);
> +	dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);
>  	iommu_group_put(group);
>  
>  	return ret;
> @@ -1192,10 +1196,6 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
>  		goto err_free_name;
>  	}
>  
> -	trace_add_device_to_group(group->id, dev);
> -
> -	dev_info(dev, "Adding to iommu group %d\n", group->id);
> -
>  	return device;
>  
>  err_free_name:
> @@ -1204,7 +1204,6 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
>  	sysfs_remove_link(&dev->kobj, "iommu_group");
>  err_free_device:
>  	kfree(device);
> -	dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);
>  	return ERR_PTR(ret);
>  }
>  
> @@ -1219,10 +1218,14 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
>  int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>  {
>  	struct group_device *gdev;
> +	int ret;
>  
>  	gdev = iommu_group_alloc_device(group, dev);
> -	if (IS_ERR(gdev))
> -		return PTR_ERR(gdev);
> +	if (IS_ERR(gdev)) {
> +		ret = PTR_ERR(gdev);
> +		dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);
> +		return ret;

Why not just return PTR_ERR(gdev)?

-Vasant

