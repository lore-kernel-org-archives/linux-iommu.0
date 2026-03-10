Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617483D16FB
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165467; cv=fail; b=Qt4LXIXevRol3UeEqE+QQMahVWRlIPwNLFhTeC6YybbQFEB5TqzdC5D4rP6YP5h3FDW9VFeOvgxhgMZa1B8yaexDPyIdId+7GTI12kmMw7NqzscjPFJlW2jXnznkGhxOW+0BI4P97SPhDuMaZ/ssxFKp6aGdIoeMF+za0U/AXpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165467; c=relaxed/simple;
	bh=VFQR1AdewBC482ifwf/438Mvip/XYmWrB1L/gas36rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nyeo6VJXnWUvZub84nnW0Met0jWlL+9TCeUp1cIfhyGeJXUkyCv4gPhcR9SISGCbjjvf0qWad2EcQ9P9U7+ej8AK6zPTZeX4I3P2qVYXwTTz9l5h7qX7rtQeSY5+22QEL1TqEsa+5/OwOVb/v3EqMJGii7/2XDY5F384ceGO4rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V7ao1DCQ; arc=fail smtp.client-ip=52.101.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V7ao1DCQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akF2AhhIYCKZQgWx4PVL10DlZxflDGb7p9Bg4Z9hsMmhjQv4XyLVlK4RbN9lfzlIucXtl1uoYF5FjzZsSYXvcjC00niFDJ1IN5h4Q3e7aCR3ihDi2vSeaHSaYjMIm5xSvH26nFngEOySAH6rUhdjhkdtBOm5TihxefDVR0rM8oGsGZhu3SN9eRMPY9oYQ/qNa8+QHVIrHnX01x/oYuGVYYqdyomAbTtFG/J52qCngtKXdqGnrAs69kZr1GIKdl0+1R/pbFBiiedGsUHHG36EtmBuMrTLKBBuShFFfPsbRyoampabOOQobPmvN+cX9WKDx7cpUKwCV0yW8yE37WxD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFQR1AdewBC482ifwf/438Mvip/XYmWrB1L/gas36rY=;
 b=bPXClo26qtuJo4wICjQ7nsF4bsEPFc44YRqC5xMw3ysM9fka3CT7knbZXN5kGdaeWDtwtRbbLCsPF44/rv6Xo8iPBZXLYuIGCxYqz0mtXp6FbPpA3TOVkUlpKwO7CfrQtDwsFtfQ+vO70BGtMPUaF93a3VWbHedwee6jNZ59hemP3Zyf6s5N7pQx4dSvyfxZ9QubJ8Imwy5nwJZYu7yMNwB6InNvFODa0VG7POlKTT5GTQwCGDuey4xMAF01TFaRUCznPljIHDZAhJSNPzMskU8d6WEBZaNnivKfk4qRV4s6wmCTphjx+X+eeSj1iUglS3tXDXpXNdWXNEEWzFFxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFQR1AdewBC482ifwf/438Mvip/XYmWrB1L/gas36rY=;
 b=V7ao1DCQz7DHD9CdP1mCyarBQga6FE9USspOr9mL7ty2xXi1TNeXvm/fzPctCoBiaNi31mbQcKjmb+2TA5YCzsBP6qvYMW6bH0v8gB0UBHlEf0lXQB7jjic0Ex2CUJDHqAE9cfN7N1hgNWJvJsIM4dqg5XucSVKKkglvLBVrvXMk5aYthL8m6VKHRPWrJ5cnovP/OqYYbgIYd+/TtxxOnKo2HqH5Z+KzIgb0kPkNahWhEyMeEQdRjHSZ2WAWAiGrWIGy2kNlVIGlHKgbyDwjSmGWJ3fygDPbwX2xIBoywwpvCvoGlTWSCrcHdZWIH7isdY23A0XJPZD+gUsCvp1jAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 17:57:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 10 Mar 2026
 17:57:41 +0000
Date: Tue, 10 Mar 2026 14:57:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sherry Yang <sherry.yang@oracle.com>
Cc: "joerg.roedel@amd.com" <joerg.roedel@amd.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommupt/amdv1: avoid GCOV builds triggering FIELD_PREP
 build failure
Message-ID: <20260310175740.GB1410323@nvidia.com>
References: <20260310163136.1179322-1-sherry.yang@oracle.com>
 <20260310164134.GA1410323@nvidia.com>
 <62EB69AA-FA3E-4820-B268-A207CCA6F23A@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62EB69AA-FA3E-4820-B268-A207CCA6F23A@oracle.com>
X-ClientProxiedBy: IA1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8efdf7-1a84-4eeb-7c46-08de7ece85f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kgOyKphigkemSMuwI39304nfalhOQiFxfAUDLraY79ycgiSHfzaLBXKqHchqUk09KTIdqjH2BnCIakMfELd2UsDzuo+a3sJpdA68CmZwk8UurIbB6hmxkk/o3Vc1mlMhVO7gwQd54BxvYnjr02p6LL3aLwTI85q1NMUzXX2B0gSq7ekiBw3EBL1pNgKE3NibBfzv0c25YzgtDPo06w5ZmPkJSUR1KFuMs/ya1PE8Lpb9y+06KT2Xngr6h7DGfHS6tM6qapS1kbfcpM8PueHgCWqqI27E3nhqPNfLXldku8jLgEihx26vOUghhwRgrlscXrJI9mEyjWXDugokt6EDDDfK/QeGoCzV0lXTtzdmSHX6rU8+609IYRlN71T7z0BakVscrqGS9DSvD2nyCMXsma8o9eEpAn1zlJkFZ7Hw2CSoDSDQKH3E0Km+ONY9+OT7xJr7WjJOHxNHpaqTOKTkEWkFlXBv509x6dbIf/486IZGdcWG0Fk0mD8/MBpFjRyxBwSFU6ysJ7U32iB+hZ9d/tLy9biQgzFzbCwQUGiL7IylYxoWYt4KE81AWbYQZX5g6ACsWuzCwXU7674y1Ee9D/raDB+I1IXGl5b3OieOYpF/lb4E8+Vm9WaUt+5jfMmTh3plse94KK6juSWmmJTPRrDa0kc9ysncrSaZoDZx8cC/AcGHG2yIpeETmN311QGdFI6+pD7wqpJmoOlbZE816qaoxH/4tacWeU1FfdeINVU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWdwbVh0dG1aVTFzZUsxbGlOZE14dGg1NGtOOERLMGZtUU9FWWZidmY1SjdW?=
 =?utf-8?B?QnE1R2c1MFVrSUlVSGpjakJVcmkwRmdPRzN3YmNZT2hvb2htVUJXZlp1MDRE?=
 =?utf-8?B?My9LOVJpUG5OVEJIc1AyTEQ2V2ttcjFJU2VhdHRVV1F6ZzBZMzJ4cXhwcmQ2?=
 =?utf-8?B?Qndzc2h1d1ZDNWNiVlRpWUlMZEZnVWF2bmxEbmxCaGs4eFhvazVlcXJEOG1C?=
 =?utf-8?B?Q1lIeGJteFRQQ1Rmcmlhd2JiMFNZTUJ6THhCQVpLTzMzb3J3N1J3OU9qcWMw?=
 =?utf-8?B?NXlsUFlNclBqVU1QN3crajVQOFJoVXA5RmhWS0RlS3F4ajAzb05YNU5wL2VM?=
 =?utf-8?B?cVVLeGdDOGZKeWlSQmRZUDY5MkQxWVJWVmowUUpUMHJ2VmlMbzUzbFV3RWJG?=
 =?utf-8?B?UStnSU5JZkxaRUF4bkxCa3R0c25CWk8za01BdW9EOU1GVnRzNG4vTTlnVEpB?=
 =?utf-8?B?Ky9tVU83R3hGSEFzT0VWRVdyWFZzS2VUNW44YXU0QWJPc2M0Uy9jd1NsbW1j?=
 =?utf-8?B?QzBLZVlJd2JUUVBjRnVYcldXNlZiL1BqL1lkNkduM3RRSzBQOTNtbXRIY0Ir?=
 =?utf-8?B?bXB2SWFWZzJDcTkvZjdPOWJXRkErMDI5bzNnanltR0RJbzFVRFBGY1gvNnBV?=
 =?utf-8?B?TTgvbXJqTmx2bTQwenp0TzY3RkpDQ0JmQnBEalo2eklUcDcxeG50cGhiVlc2?=
 =?utf-8?B?bjl6NkRpK0djRTJXaTJidTEram85bnhxVlduV0JTdkJ1elprY3VSaXpFZ2VM?=
 =?utf-8?B?MmVKaVg5VHBBS2M4OTl4NGF0aThFdHhtRXJmTDg3N2xVSExqL0hveTZ0K3Rm?=
 =?utf-8?B?WHBiZU1wV3dSeXY1b2NmNHhIcWJaMzRDNXBsamdFbi9JTnN3U0RiOWpxclNR?=
 =?utf-8?B?Q2hYQ3hLZEpHZ0RCN2lRWERVQVdtWUltNUx3WjFUQXBKOGJEb096VUZ3aDhI?=
 =?utf-8?B?Qk9OQ2pOSHBZc2NJUkZkdzFXT1g5alhMdWFzSzBuS2tZZ1BCUUVLQkxoalVC?=
 =?utf-8?B?akM3a1Jzckl4MWlrTWlrN09aNCtEVEE3VnU4dStCRnRtdDBycENPNnRtQjFi?=
 =?utf-8?B?R29MRVllRU1LYTVXS3JMeWNsME9OSERMdzNiK3h5eTFVMmx0ZlBFS2tmTkw2?=
 =?utf-8?B?WStPU2ROZUxsVTUzRHpyL2pjbk9lMFZxOFVidTFxYTdBN1haVTVnQTNrbTc3?=
 =?utf-8?B?UWxBQnViN2dKWkQ4L2pHbC9HQTBCMW1mUm40ek5Oa3ZoZzc3Zm5FSGVwZURD?=
 =?utf-8?B?bG9VY3IwaVh6VzhadnE1ZVlYUlBIT1VVOHZSK2hUSXoxVjZRUFIvYVNwZlgv?=
 =?utf-8?B?UGRmbnZhYTc1TDFSMTdyRG91YWVIemtMUCtIVnJFMWFKQ1FoSks1UmZoSWVJ?=
 =?utf-8?B?OUFubVN5RDlHWTBnWmROVUhReUR4ZS9ONVpZWlYvMnJCbFkvUFVrQlhnT3NC?=
 =?utf-8?B?c1I2TWFaU3U4VDA5Qk16TVd1VUUzQUtibmtrdHYwZUVXZmIwcUp4ejd1NWJD?=
 =?utf-8?B?enVFVlZxMUo1QXpBOGQySVo0M0Z4MCtydTRwaTgwczVMbmJKSHJvVmQrZTNv?=
 =?utf-8?B?RzFVU1hsUEhJOHFoQWhLYjhUQ0dlbUVWWkp3Q01MMzFBZnJyTkJkNEI2Nkh1?=
 =?utf-8?B?cFErajB5ZTdvUHUwbEtQZUxBNXpCVEsreXY0dGFaVVlYd1pRYWJOWE9EOXFZ?=
 =?utf-8?B?bFhEUGVhdUpMTDNnMkJsdFo4QndjT2x2MHlPcGR5M0J0ejV0Y0xrM2s4Q3pl?=
 =?utf-8?B?anhhS3ZCUllKSi81R1JxVDlYdThOVkdZMlg5VmpZMlJENkRZMjBmTjgxekFy?=
 =?utf-8?B?Nk1BYkxKWjhOdFV1QXR1cjR5YlEwUTlmL1hiTE5uMGF3aHZEcU5iU1lFYnZX?=
 =?utf-8?B?QkRDR2piRG9Vb2paTExDZUxlaS90SVJoWFNDZVpTK0l0U1JWUGpzYmwxMC9y?=
 =?utf-8?B?TVN4RUJMRS9BZWl0QjVvTXY1Z1UycmI1MXlqYVdVMkEwZDI3VnFlVXVkbHRN?=
 =?utf-8?B?cURPbWZGY3h6aWNKVlJEc2VFdE93eko2VFBJUC9udmhyRHRFTVV3bFIyeXF0?=
 =?utf-8?B?N3BuRG1SQnVJbnFoUk1IRCs0Q2RLWG9Pam91dys0b0NhNVZkZjljUy9RTVha?=
 =?utf-8?B?Q2JjT3NBSWo0VllxQW5aV1FoYWJrMmdJZ3Z2ZHBIUm5TQWZIbkxvSXNlci9T?=
 =?utf-8?B?QnE3YzVQUE96WWgralI3TDZiVG9RdWRYZ2Q4UFdoVm9NM2JkT0ppVXFqRTRo?=
 =?utf-8?B?bDVlUlUrOGduZEQzc0N4MzFSMkM5MGxPcStRQ3JHcHYwUTFDZGwwWmYxSG9Z?=
 =?utf-8?B?OGlCQm5ibzlBTnB4T2xLekpEbkxMeXM3NlF5aGFQaXZsZzZ0aWhqZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8efdf7-1a84-4eeb-7c46-08de7ece85f3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 17:57:41.0413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlJd8AjUXJQ6AoD72aJlOi0XG/o6VqjsZAW6wvCwH1FQqHDbdH1w7ArQZrrE8Jpl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157

On Tue, Mar 10, 2026 at 05:17:31PM +0000, Sherry Yang wrote:

> Unfortunately, I ran into the FIELD_PREP build failure with
> 98d5110f90ae (“iommupt: Make it clearer to the compiler that
> pts.level == 0 for single page”) already merged, which means it
> doesn’t work for me. I noticed you mentioned clang 18 hit the same
> issue and fixed by the patch. We’re using GCC 14.2.1, looks like GCC
> still constant-folds the contiguous branch despite the change to
> pts.level.

This is all a performance path, I'm reluctant to add more code for
everyone just to hide things from GCC bugs.

Maybe you can rework this to be only when gcov is on, or maybe you can
fix it by futher enhancing what the other commit does. Perhaps an
always inline annotation is all that is missing?

Or maybe we should remove the use of FIELD_PREP?

Jason
