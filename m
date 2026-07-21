Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C2C443ABD
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626787; cv=fail; b=WzRkFhCmahi1jbLy6GsMOtWIMFiJDANjvWeBhZRGAZpKmeSSRcReUkSuv/cDJHSZfhUk0C8jcb5JZLEmvPsfI6hSLjP1gUAG653CNuVao4Ut+YEJBQgkGRe/GFh678GGXAL+PW9x2Myl09qDSLYg7Bl2XXeDLctuz8A2Urh2Fw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626787; c=relaxed/simple;
	bh=CM8RzUNIvWBPtxRkQdBQHARPZMCgV6TSfqwQlCUYHVA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZyaNjzdLuBXUpZ9KkYHXIXcee2zyfF/zkIojblayWS9ixUe+qAUZjHXzFOvAqPjLc7INNXA2uwj4m61i8T4upNatONeIWswRfqLhhD5/UjDRwsEmnogO13188Ppnhrhj1VTr+ZWdC6Kac2j5B0Yg7tcQUvuHOhUAsuu7bgQYuiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jrvq0N7I; arc=fail smtp.client-ip=40.93.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jrvq0N7I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTb5Ai2zjABMrkLd1v9IydyEGVHGrSz3uuFwFwQO5dE67fIOUHLuF6UlDaRPi0okKHCwkClwGmJqdhFyc/Fc5d1g6rKu2lJiLYsyTmMWuU44BInQZ++gy0uTM4acwHo+9vIWEs/IWKdZTEKlxr3rmxuk5WCwwXBeqIVTBJhKqkBAtMomYwttwjV6wZUPQS2LCiySMK23OBV6o5VeYcshtVW7Cm8jF5r4WAnpE3e/fcBBrLAM5chCbVq2BuWcvO81ps6dNjJ5kLdRfA7nlc7YINkGyA+FS/KQXfFOguE5N/e8B9RnFuoZgLExZceKezfG9IT9ysVmUIBgLjLFd3DVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zN3SF4VMK7/JFEKDI4qsX5yHZCQciijpTJXPAYXf9F8=;
 b=FkeoJ6abQkMoWqRmJgZJq/nN+1Cvj3JDM383G2pKNv00mUzRQKBG0xzsLAM85z/3eJzdN2VKDPcSHdPQKJgzvKXY8W3YSZLHOPDE1L/j9jd9bgBnIps2N7O3WySz2aUPPi7pYoA85QMGfhTAv++1J54HFb1SzJebyolkHnj+QQQfJgBjz4pTqX+Pkx+CDjA2k7Rtrdg1upbIlGBsNKnhIcBV24eoHvxYeCq0F8gxZ05PSPQUjzeG2CuYvaRYis+y5M4w6+m9PYyV7DLnv0ufPbzqc3as7r7lmLX2Wq5F93ITInpKGgtkRJQaorOmzY/ybjLt7K3anFybZHzagfdg+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN3SF4VMK7/JFEKDI4qsX5yHZCQciijpTJXPAYXf9F8=;
 b=Jrvq0N7ILyuBJi8OMOR101fFYAvrAl5cI7XOCoNUUPSzll7+sbOJf8Wm1z7KfbDgn2DFfHfxmbh5NHGc8ylaYj/F4nKuINF/rJ7qP+GVRMsWCJIzJSZFxj5u6gr2F2GffPMoLPRVbfa2rNnzahvRZN4BlAAHKiEDP/8fDTx/b/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 09:39:40 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 09:39:40 +0000
Message-ID: <b2be21bf-005d-4b32-ac71-5eff86154c2e@amd.com>
Date: Tue, 21 Jul 2026 16:39:31 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/22] iommu/amd: Reserve translate-device-id for PCI
 requestor aliases
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-21-suravee.suthikulpanit@amd.com>
 <20260707143950.GH220801@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260707143950.GH220801@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b41cf3-afc8-4384-7d74-08dee70bfcc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|5023799004|11063799006|4143699003|56012099006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gZ4w+ivuxl28krWsgvTPmdvaiYUlnSi1B3eNt97s4S6YzczEHdPxZRa1t0MJbchE8lgxpMVnkZIeJQHLApyh+1g+YCQUjlh6yKddEupR54e8fDv2MWybwJprErj66glAJSfE3UcKQm49TZoyz9UHZlMkO17IGTswI23H/jcFA0ageaGA4K5GGOnZOFIlKhFlJ8v96AtrSOEtBAVJ0LYVRkovGKx395NKI29S5PE6iaMHyNma2L+144buT4I+JDx7gFa3OCt122ymMc+SHvRNO8+gBT1Bhp4IXw7nfTl7lN63RVxFK19gLE+M8aYoS/2qK/FmE3euAC0BKKhMs9lu8jiN68CTUYBmzAYCmyMSQpbOR6buKh++50hMTKe9I8uaz9h6+/Tl43ulbl5+ExHQ/ClzJ/6kwl19dhyFNFSVtsp3czV+KpbJa22K3jV5wMiqDy4m+vjhn9rjXMYyAuE9lJx9lZznCHKGWR2GeI65wYwV8g7sFR6sx2iX7dJIND7p9B6V/M6TBdv4/Z50QWeg6blBFi6d5QrV4Ecm0yvGNyalhgXz4kBFGBG0HpYiESqT7Uf5P5tTKvFP3vuMbzDe6hncii5zz0cguoN63nfi3MY9YvF19V5HiMpgD0YRAwXbWrLuQsJLJmycrNhmq0bq/r0nDNxqJI29XBlS2T4RJKE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUdFTm9oTUNpTWRVYndwVm1aVEZlNW9CYy9qU1ZaSVR6b1BqRXlKYXI5a0kz?=
 =?utf-8?B?ZG9VWVhRcjJ3dnMrR0pmL256YUllNFg5U1ZiREhzZFhIanArNG1PT3hGYnht?=
 =?utf-8?B?SGdRRHJpTmd0aFliR1hHMUxJQ0lHNDA4dGlSdHhWelZ3cWpmUVAxN1RkK3A1?=
 =?utf-8?B?Zm42MmphVUJDeXRac3J6REFncU9mU2hjREVVUFdmMnNsS3Q0b3RNSDVZS1pm?=
 =?utf-8?B?MUxYR1pPdzVGb2dicUtCS1VPM25ldVdBNEpGcnZPZUxHSmJTaTNKTEJiblZ6?=
 =?utf-8?B?VmVOUndiaFJaelI2dHJnUHBpNkx2ckxZNzdaSEJBVVN3aWZXb0RnL2ptTHJs?=
 =?utf-8?B?dHVNbFZMNndTOW5ISHhQZ3M3YkxwWTU2eGpDZ1BxUkFlUEZ5V3B3M1JTNmtp?=
 =?utf-8?B?M2daTGkwODIvNFBGQ05mbTkvMXo4K3QyUjRuODR4QzJhcWVPNGlyVDlVVFEr?=
 =?utf-8?B?NWpDcFlZT3dIVjRYSGZNOE5mckRBV21PRFpWZjBaWHNaRU50VU0vbmtDY2xa?=
 =?utf-8?B?eDJoS3BjdlJsYWNqOFpmNk9XcGNrWE9zd09RSTRXaTV5NUxHaStjVk56WHZD?=
 =?utf-8?B?Y0VCS1lqQkVBTGlESUVJYUpwanR4bGRjZjJES214dkJmTW1CbEtpNGsxcVRQ?=
 =?utf-8?B?NGd3MWw3UnFVRkRlMmszSWk0OEFyZFlQc1lPL1pWWnVaSTlzVFNTS09Hek9L?=
 =?utf-8?B?dkVYWElpQjh0M256a2tXdHdTR2pHTklQRTN3ZUFSL09yUThXdTVxMldjMUw2?=
 =?utf-8?B?WHJIczFzaElneTBIUWNROS94S1VNSGpmMTUzWnExVGZsUndNV3BvYnFEMXBy?=
 =?utf-8?B?ZUZFakJwK0hvWXptYlB1cUxVTFhadmVIREtoZjJoOVVCOCtWcFJRcDI3dFB5?=
 =?utf-8?B?QlRUSEtUQ01kNkZuempzK3FXVzc3UElSdjAzcFg5YzJwNXdqSmdiRXVpditJ?=
 =?utf-8?B?NXF1M1dCY1BkYnhneHZVY0NES2hHYnJ5TTZPcFYzZ1NuY28rSVZJeHREN3hD?=
 =?utf-8?B?bk9IbTIxWDI0T1BFUmhMYlp1bGVGNjVXbmhpald5dWJqOHJidUZaZWUrNC9i?=
 =?utf-8?B?dDNZdDlzZEJqMkc0cmRXNXhGUEdQRU9mTFJjNnJnbVB4d1gzZC9UZ3BxdGwx?=
 =?utf-8?B?R3dpOGJidDRpSG9kemtwMDRjRXphb3Bsc0UyKzZ5aUNxYTlISzUyMjRmbjhh?=
 =?utf-8?B?bGJuNUJUVS9qOC9zYVVxUFJpcEZzekIrblJ4QU8vekp0dEdBQ0U2dnNaUEdI?=
 =?utf-8?B?QUJCVHRiKy94TkJJd1VteVRSelU4c1RMQ1A3K2FlWWFoaTNEc05aMzNDdys1?=
 =?utf-8?B?aHhzYUEwdU5TcENTTERmdmFuSnBETGZDTTdJMzcxMzJ5c1I5cy9CRXU4Zklh?=
 =?utf-8?B?S0VmdUdMeGZvWnIrZkIyNTBGOEJRTWJZQmUvQmtsTDMvYWJjeDRMeExFMXBp?=
 =?utf-8?B?VDI3ZjhDM3FDUWxyU3ZGdW1nSWRNYUFwUXBzb0dTblpGMWl5eTJpajNHSjZj?=
 =?utf-8?B?MGd3bVA3a0o4UFc2NDZQN0FGY1hBRGJXSEFLM1RLOC9mRDVYQzdrN3FqR0V0?=
 =?utf-8?B?cDFYMVNBcXZhVVRCd2NEeEhWY1ZUbGhVTTNhaytyeVBLU1Zyb0lNOTJVNjBl?=
 =?utf-8?B?bmtuN1BqR0hIYnZDV2ZBNnNLVEp5MXhxQnRvM2l6dlk2VUJOUWpxUDA3UDVF?=
 =?utf-8?B?SmdxWC9DbWNIaHNiZkNxclN6UDU1Q2lTQlRxcDdEbElMVklibG5wdUpJM3pN?=
 =?utf-8?B?VytNM004aVd0bUg0SmNSeXhRQVF2bGlXVkdFSHN6VDh1WldMWWZYQWV1cmdF?=
 =?utf-8?B?dkJXNXBOYnhxd3J5ZTlHWlBUMmtNdXZXV3habExKTkxrZ3d4TXlGTm4zTzli?=
 =?utf-8?B?Q0VSSk56bWFEdnY3TU5pcWhjaFZmSDdRaG1FMlZmRGt2QTdKWUVoWXJHV1VT?=
 =?utf-8?B?TGVQQnVtcVczbGswUGpId2hHaE5KS3JvUy9LaDZNTzA1WjdMcEdMZzRxSHlD?=
 =?utf-8?B?M3VMeTNlYTh6MnkvYWJiU1BuVWtxSnJCV0hTNndhSTlScmZ2aUZtdmsyRDlE?=
 =?utf-8?B?c1pERFhySmFkL2Z2WE9XcW4vT2d3VjN3eEE1ejBDVGZsd1BnWXZTcG1LOFlt?=
 =?utf-8?B?Vk1rSThIbDAyaC93R1NMS2FtaHFkajlIei95WkRiNjhWUVBlUVVjTlVSbW5D?=
 =?utf-8?B?Z0c1eHYxZm10MklrYjh4TlBWRGZQdGdsRkhFODNWclhWR1I0ZjZQMGVWV0Mw?=
 =?utf-8?B?UTJFQ25PMGgyM3hLdUJwcEZyd0NYdEFQZW5hWit4eEFSa0s2andBVmcwWS9F?=
 =?utf-8?Q?VTR2Nthj7lticvZF74?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b41cf3-afc8-4384-7d74-08dee70bfcc5
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:39:40.6196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4BbjpNeXqwqeQ5gUsEwTVKyFcgEO1VbOfHBin8cqKQLDRHpS/waItdnKv2ONOYFE6TavIkw5ShmBN5NrMsZPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655



On 7/7/2026 9:39 PM, Jason Gunthorpe wrote:
> On Mon, Jun 29, 2026 at 03:35:33PM +0000, Suravee Suthikulpanit wrote:
>> The per-segment translate-device-id (trans_devid) pool hands out numeric
>> device-table indices used by the AMD vIOMMU / iommufd path (e.g. mapping a
>> KVM file descriptor to a shared trans_devid).
> 
> Nothing to do with kvm

Noted. I'll update this in v4.

>> Introduce amd_iommu_trans_devid_reserve_pci_aliases() in trans_devid.c and
>> invoke it from amd_iommu_attach_device() immediately after the primary
>> amd_iommu_trans_devid_reserve() succeeds.  For PCI devices the helper
>> reserves the IVRS alias when it differs from the device BDF, then walks
>> pci_for_each_dma_alias() and reserves each alias BDF.  Repeated attach and
>> overlap with the primary BDF in the PCI walk are handled by the existing
>> idempotency of amd_iommu_trans_devid_reserve() (a second reserve of an
>> already-reserved id succeeds).
> 
> It would be so nice if the AMD driver could get fixed up to work more
> like ARM with the alais devids.
> 
> ie on probe you allocate an array of all the alias dev ids, fill it in
> with the information from PCI and then never touch the PCI again.
> 
> Then you'd just dump the whole array into the allocator in one clean
> shot and this would all be simpler.
> 
> Instead we have these endless pci walks every where :\
> 
> But its fine like this I suppose

I agree. Let me look into this in following this series, and propose change.

Thanks,
Suravee
