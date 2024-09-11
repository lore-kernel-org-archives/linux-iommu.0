Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCFC186E5C
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052079; cv=fail; b=r8J6O71JZG/+b+J5s9ksa2cnzrTXoq78HWErYgb6VwKIan76EK0eIMXAV1VeucRDC0rzz/YMS1A3t4Fvr2oZYBzKu3AjdgaAc7jIPa3knUTe8eDnjmfjrvBU+fmSAxlAyVSUVpmI224ay8bZyReu9FKnMlXe3tjfl92Vy5rwqb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052079; c=relaxed/simple;
	bh=o1RkKgqlInBEbNlPerin4KWobZO8OTq3e98TVPc8MAU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jMzDjAhup95iyYVUFjzgN/xCfyrldZ+Q/WmtuGJ7DU8pU+eaWJPZXdjgVSNCjgNGQSIEgWnyXwUAtYr+51/ep8Sca/tLoqKZk45dB1quma081Sfkho4Mvlu1okealmlwq2TLd05yrDofxqcEDRCffG/qO2XIi1jdT6fwRSUKSqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0jl8Zu38; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0jl8Zu38"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bm9ftWdzRhoOSCsF3EDAGOgFKibJjfk8mxayyztJ8tt6Dbb8XwLWeF+hEwrqltt2j+DEZqlmeyT59PnlTV1lhxpMCJ7O5/6/2pBpWIEPjNXNinoMaKMWyn6LqB74JFyDRNlumuluFglzEvLLnjfzxr20okfVOS25Vq3P5hYrqxz0Fyy6K+OtIK/khIDjDZc4KrjuLEUh7rXFgHxi0i0HP7M5KCbqFSu29d4u+njLTnsvPss6E7LCDo+BCXyPobi/hydv1MBU6xs20sHOHdHOGn7WeIigBooOMC7X2i/WTGfeLOoIJexW5LqBbYzBM56PgTy6JfzOrE7QyzA5Z1qaJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdcs+fWDTE69v2+Ny4+MelEfsUzSGlrJ6l8W0b79Uvw=;
 b=Aze3joMqXV3JNS6EyvwIHK7mz707Zuw5ZxpDIZ8oKfZ4xt+715eqgvrphJhnizQ7HMJ5pjzHJJHgOYLAc096GP5i/XoFRP4jMXpBI6+CKNUAni4mF+o9H9QnyHgWnxWKr2ZPt4ssk/1NBZp7TfQ5o7bYow7nOq4L36zy7WtfxYIcwbd7HCF253hmCSTc7/nRgu+i2oslomNTRSm20ovNhdgwsPXh928lw7CpF1k+4sCpeSMs98VCXwfC2UPL0hL/jrrrSj81vwaVqtMVkRbv/Sd6FG484JgrVVbSpk2aKVgu8ePkEWvqEExRVFPYVo8ANXvePaHJ3oMtMAy09TSwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdcs+fWDTE69v2+Ny4+MelEfsUzSGlrJ6l8W0b79Uvw=;
 b=0jl8Zu38YKn4KDIs4e+hleGLmRh8hqt90qbmrQ2Mp3vmhVDZhV+MnMv06i0jr8ZEe+a8f9+ah+m0wH2pqnYZgUkhDVV9xvnItWiW896VSuY9Jlw1qQrUgNLYE85Bwc650TlVTmtlcYFsLviJ6KT4T/viDYS7gpR+PEp5/qBT77Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Wed, 11 Sep
 2024 10:54:34 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 10:54:34 +0000
Message-ID: <84c6e2d0-4016-422f-9bc9-554834b18a04@amd.com>
Date: Wed, 11 Sep 2024 16:24:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com
References: <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <67436cba-3d05-4528-9519-231b8396ed51@intel.com>
 <20240822124433.GD3468552@ziepe.ca>
 <0ca31cc6-1741-40d1-b8c1-20e6b4fc955a@intel.com>
 <8215e4d4-2077-4fca-a002-27ddbfc0ddf2@amd.com>
 <20240828145224.2e949806@DESKTOP-0403QTC.>
 <6741bdcc-d9ca-4090-805b-3a7f4a4d650a@amd.com>
 <20240829121002.GV3468552@ziepe.ca>
 <b57b8846-9d13-4ede-98ba-2d09268c15ce@amd.com>
 <20240829131128.GW3468552@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240829131128.GW3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 67dfc750-69c1-4dd9-65e9-08dcd2501ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGlnYTZ3V2E5Z1QxVm1YMytLM2NzbDdaVjdYYUcwSzU1ZTJlS1E4L2MvWFJz?=
 =?utf-8?B?SmU3cmg1emNGTGE5MUhkdUZzWTBTT1dmU3JxUytSclFsSFBtTC9RSWQ4SFdV?=
 =?utf-8?B?NDZOQkVCT3J4TUlwRlVoM1FSYWsrVCszNGtNbVRWS3hDbm8vRHJWUTVGSmg1?=
 =?utf-8?B?cHBNd0FnVE9EckpLNWNrSFJjRnpPYlFFYmsvSUo0eFJyRzJEWEFiOVQzSHJn?=
 =?utf-8?B?TmpOekRrWlZpNERzTHpKRStuRFplK0NZNHBoN0pGYy9NT1ZLR2U1dVYvNzhW?=
 =?utf-8?B?NDhSdC9hTGM5UjFOVmhrYlNqKzgyRUZWcENzSnRBRjlVamtxSmRNMWNBODFo?=
 =?utf-8?B?UDNEK21KV2tJNjcwbGxNTEwxVllNVjd2UXA0MzFYMUZsWXlCc0huQk1JTVVD?=
 =?utf-8?B?SVE1TnlMZWlQRXZWUjkzSnVta0h2NHYwKzU5aFdXMy81M0NhVjVHL01Hd2pB?=
 =?utf-8?B?SG1tclR4QXFHOHJjbHJYQ2w4RDRCd2NtMngzdHJzRW9qYTkzZGFMRVVjUzBN?=
 =?utf-8?B?Um5jNUdkVzNjOEFTQkFjU1FybHdVNEJzTVZQMnl4SzVHS0gxcG5sd2JiWkVl?=
 =?utf-8?B?S09uN2RnUklzcHZQS05SMThMVVZGVjVra1Y1VXV3NC9TblBRVTdZY0JEVGE3?=
 =?utf-8?B?TUFIa1BvQ3BCZ0wxVWVpSGMxWE5vbCt2eVZQWjBGVHNOTTBOdGxkbGNOZ2Rv?=
 =?utf-8?B?SDEzV1MrV1FJanJiKzlaZ3VyNUNBZ3NUY09jNWM4U3JpdFQrVi9ORkdPMXJY?=
 =?utf-8?B?S1ZvWlBMRUFOZVg1OW5xZ0M4RGpqUzRwWVVja0NjMG9jOEpXUzBSYk44enRW?=
 =?utf-8?B?SDdHelQ0Q1ZERkJEOGQ4ZTFQcTIwcUhiZ2hYb0ltN3EvaWsxMVJYTllZbWRE?=
 =?utf-8?B?c0JoTkE3U2Vjd0JhZEk1bFVNSkZJWnlsVFhFRGpSVnhNSU9aS3U1RHNkUC8r?=
 =?utf-8?B?aHcvRTQ5VWwxRWpoWVUwa3k0azEwZGl4Sk0yWVh1THAwSGpJQlpnQ0U0S3pL?=
 =?utf-8?B?SmZ5eVFWRk5XRXR1TEIyUFJIekdvQ3FHRTJKS25zVllVcGd3a0M5WWEyejR5?=
 =?utf-8?B?S0R5emdiSmtWV3pYRlZKUngyQSt6WERmSHJwNjZQZ0d1M1MrMWVwK1BqOGJS?=
 =?utf-8?B?bUZjQnBlSVBtdEFoYmowTFIwQTRtZjIvZDdML1JGOThVZitpeFBBekdjN1B1?=
 =?utf-8?B?a3BoQWZrTjJxMkNPZXBiSDdHQm5BZ1kxM3hKazR1RGJHUDlQSTE0MHNXakZh?=
 =?utf-8?B?TDdEcWNtMCtzb0ZZTHVDTUxKUnQ4Rm5Ic1FLaktlWk82ZDJsV3VvWWtWMk41?=
 =?utf-8?B?emtrcWhRUURPY0xRNWtTcnJ4L2phUWxMaVVCd2RLSGQ5NFV3TzhoWllRM3cx?=
 =?utf-8?B?c25yQU5FMkJJdlN2Ni9BdkxzcXoxWG1lMVI2NG9zV2ZjenJud05USTJzWFRR?=
 =?utf-8?B?UzBmblNHS1A3STYwSktLenRtbXd4UVVLZ3BqQ3RCR1ovdGo5RVozQmtxakNJ?=
 =?utf-8?B?dEtFYTF0YUZRU2l1OVF5K3JFRURxS25kRGVnWm4xY3F3b0s4RDdaRlgvSmt6?=
 =?utf-8?B?TXRqZ0FrbzlPcHF5VGpPY3REeTczQVNZOW9aeEx3YUVLZm5URkFQQTBoL2JE?=
 =?utf-8?B?WTFSS3BCY1pMcWdsbzJYTVNBYVdUQnJuL3l1cEVvakp1VVNPYWM4VlBNWnRx?=
 =?utf-8?B?TG1QQUl0cndPUmo4QXFBRGY2eXREeGJES1VWT08zTjRIYVAya0RFQlQ2T1hq?=
 =?utf-8?B?NUM4QTA3NDJ6ZkhxU3ZHYlBacEN1K0FjditQTnpVSml5ZEN4Z0g5S3hyUmRN?=
 =?utf-8?B?Um9UVVFDa21IdzFYK3pxUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REtqRHA4WGZNQUV6S3Arc2h2SmZRQkUxQzFjM2xsZHFHSEh1bkpDeGM3Nkxr?=
 =?utf-8?B?cVVkZjR3OVc3UnhyV2wwa0lYMEFZaEFlc21ZWjcxS3FJK0U2RkIrb3orNHhN?=
 =?utf-8?B?S3hneGwrTGRJaVZjdFA0Q0wwQ2k5dlcvcTZXcHF6NkZseXVxcFlpVWRKMDd0?=
 =?utf-8?B?K3RGa2g5T3RMa3haQ1puallJenpLcDdaNWdDMFh5NG9HNlViQ3NiR0NqREpO?=
 =?utf-8?B?VHI2c2IweGxsVzVEeXQwVFFyN1JPeDZCL0Q1dWQyNXpzZ21nY0duVnlmdzZ2?=
 =?utf-8?B?VDlRRmt6b3NWUzgyN3hlTWN4bGRKVVVjMWlYbm1JbVlRbHI1OGErWVV0MnpN?=
 =?utf-8?B?YzJmS2FTQTI4YndxL2J0dE1ENW1SVWhWSUoxSi9jMEdaekY5OGQwRWs1N1Q5?=
 =?utf-8?B?MkQzVFNGTm5IOG4wN0YxcVN5MkM3UWErZWVSZDZWYTYwTVNEcDBiU1BneDBB?=
 =?utf-8?B?Q1Q0Z0dpek1KSjgyNUNPWjZKcWtwOWhRWHkxRHBaKzhPdno5QVgzaTJScFdF?=
 =?utf-8?B?cFFVTlFvUGE4c2U4ZCthSHpsNFRSZGdpRmc5amRCNTJ2d1NZTFR1K1dlVE4x?=
 =?utf-8?B?WWJMNitKTUhGbkx4NE92L0gxbW1tNGloZVZVbDlKdTJpN0JON0Fxcy96cUFn?=
 =?utf-8?B?ZWVTK3UrN3lVYWdVdjlNbGdYMWVaL2laRURaZ1VMS3RjTVVSeWsveU5QMWd0?=
 =?utf-8?B?bjRua2pXU3V2b1dOMWRZakp6WWd3b0FPQzVmekw4d0NSVUVnOUxFSXh0cVd1?=
 =?utf-8?B?ZWIvTVIxcjR1Z2I1TnpBQlNuOXdWaVlHSlVFZndRRzZMZERWMlVyQkF1SEE0?=
 =?utf-8?B?ZGJOWjV1aDMxUHVnRGNoMEk4ZGlvK3VLZ0N4NFBScDVhazdESkFyaVlHL21y?=
 =?utf-8?B?RHdYVVB0R1QzQmlJV2Y0Z290dDdiSlhKYWN6S2hncUFUYmE0OGNGWmtSNGhB?=
 =?utf-8?B?bjZ4WmJkdTBPYTBSZzdURExRT0FMVWVjUElZRTA3QW90VjUrYks4ZUd3NVcr?=
 =?utf-8?B?VmI4SlVQemk4VjNqNDNWVEJTOVpWb1h2ZjBLdDh5TEE2VGhmNXdXWHh1WDBv?=
 =?utf-8?B?VCtIcnVyczJVcnZtRGROUjZWSGcxVzRVN2ptNjk0ME9xc0ljRGZ6ZTFINE5Q?=
 =?utf-8?B?dWVBQ1ZaOEJIbXRwK3BTZHZNRm13dXNjeWVFNEdWdnZiMVhFbHppT3FUOXdO?=
 =?utf-8?B?NnA4RjVkRTNkN3hqeHJFcFF5S1BFOE51V3B1T3IyaExyMjF3ZkVSOFhoWXo3?=
 =?utf-8?B?MUNYOWJEQXk2NFJ2NUwweDE3Tm9leU5ISUhsYW90YlpJZGk3R3Uzd0h0R25w?=
 =?utf-8?B?UXp3RitOOEVWT2Y4N2thNnZQUUIvVW9qZWFiYnFkN2NNRTUyMlY2VTBSY01t?=
 =?utf-8?B?b0dnTzU2cXpWclBKY2djNVF5bnVhL2luRFI2emNzaVZ1b0s2b25FOFFheU5I?=
 =?utf-8?B?NFpuUzFhYnpSYll4OFpMTWI5Mm9qQjllZjZlT0Q2czhzcTA3L2VLR2hoSDN0?=
 =?utf-8?B?bjB6OEVCWFo3MkVmbzdVTGJocjBzcW5uOGVGbHdaWmkyZmZNSnk5SnQvbnFo?=
 =?utf-8?B?dm9oYUZjeGs2dUx2TlBwNFMyNHd4QlZhUkROM2NQNmRiS2xDVDMyWklLd3VF?=
 =?utf-8?B?Ti9xVGJkNStkOVZRT2wybVIybkhqaHZQRG0vVjB3Z2JQamdESlhhUUxrOGtC?=
 =?utf-8?B?alptenhxYXJITFBxUTd4dENlc00wNFpjSjc0cjljeDAzUDNMNUFlYTlZWGFW?=
 =?utf-8?B?cnNwT3AyajFmVm81eE5DRUM0Nm5ENUFQamxua0x0SWhLR0M3M1JQMWdnREhH?=
 =?utf-8?B?dDRxZk1XQlh1Q1cvV3BxYmg1L3pZS3B0dXpTa3pLdlE5RXVKV09NRjhCNXd1?=
 =?utf-8?B?TUhGcU5jYTh1aFNUN0F6bzc5cXFjSkhuM09MTnZBZTI4aUtCd2J2TldLOERw?=
 =?utf-8?B?bTFlM0NXa2VSdXJUajFEeElENEFsdW5XNHRVV0E1ek1UVERzYzdhL3VRQkp6?=
 =?utf-8?B?SUR0aldBYi9jdXBvamNnWnhPU2RFejUzVkc2M3Q2ejY1cGZNUzU5eWdOa3dW?=
 =?utf-8?B?MkhzNTdHdDgyYU9iZ3ZOVVRtSnEzZUJELzQzRWd2Rk0zSXpxcVBKMEx1K1pk?=
 =?utf-8?Q?lezNFH86zfm1ZyWffmaxFfzLd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dfc750-69c1-4dd9-65e9-08dcd2501ee3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 10:54:34.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Pa7bZ+nDpwpwx/xhZ+sd+jbdl0mjWUSppAxw0gSuw+kGyKldoQTeQIl3HsvM0378yOJF4FUIUyAwVfRPuZjQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003

Jason,


On 8/29/2024 6:41 PM, Jason Gunthorpe wrote:
> On Thu, Aug 29, 2024 at 06:17:38PM +0530, Vasant Hegde wrote:
> 
>> For HW-vIOMMU where we will have nested page table, Host will be in V1 and Guest
>> will be in V2 page table. We need to add few checks to detect and use
>> appropriate page table. It should be part of nested page table support.
> 
> You need to push those checks ASAP..
> 
> Guest enablement needs to be fast tracked to distros ahead of building
> the hypervisor component.


Sure. We are actively working on adding this support.

-Vasant
