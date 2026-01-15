Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C3350D58
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483409; cv=fail; b=ZyyqehsTrjlCmJwU251LYDgKQ3ulO2zXepZXCNkqZUxkXCVKiVC0VfNit+IbpGoOzqKRiEfR0JlOY5vXKXyhpZgrlyEEwyQR90gVjAwhVRwxDg598u2k3xOx4al3ueyaGqact/YBLHBfzllK10YKgAbq0LtxNsXXCNgbkZW1VTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483409; c=relaxed/simple;
	bh=TCKOVfQogB2UC2y0DpkdaVyi9jXY4W6v+ts7v9tMJ+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S4RaMe/xBos5r1Pl4G4YHLOWbMPM6j8WDRq4A6NI0aXgxEZ3W7XfRitWvjm1SNOkRNtZiALWo9TSKRWdbFLHiWP8p2Qzf9GN/dPDmE8bnHpJM9UHl3LUoV28S/wWc4yQV/rv15MfiG23aOhRjSVBfd6exv6p3TBbRvQFRMDxTAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p80mElH7; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p80mElH7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgkvIrz3RKM7VNn9NrINucqbXL/GN6DDgAFdf6Ydn4G/MjMs/5F9i5H+UA9+f6SUL0GC4qcw0H+QkEaAESOwrdVM7TqZ6bfBjfyYUbP1zYuDiBrTkwWYSUqgyFhWXH3bPZcuZCsCHTmHzVasG661xVdPnUtKTlvsCSaaaF8NIjtlnZbwMxbLSyO0KExtoxMBzZPEC9UNnWKgfcIDYP/egvlFqRQeR/iAKuKyZZF3Hu5s7YaLHDCOf0YCQB8YVdmPLd5zq4T/8Vh71EoTUnwvB0bairTK1rbVpzg0c07DFzoHb3gNYoVlV8KywBJklFD/4OAwbvaAVgNz6SD6WdjVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/LcLQXBl4iF+RntARhb/kJkaEt6rJFyrRhodh3yvhw=;
 b=bOO31te/bJale3Km44W+/vR8QkS60PBzkJ3ILC3vKOliCtpyV2Rruo5b6yH25l4mA5mG8pgiILyfv6esrmj2cUR1mS6uns001NjAH7aYBuIoM1qPk18k9Q1We4tNmIuo9mOd9XZcPqHBVeQZliMJJGWGO7/PvAWQrylqcq/6kDWdYN2+p9q1c+7sj1L1wRoFlWGc4mQW2Y2agBkkkj9gMH1p+50+bW7A+TkTmZ9y/Arior2NhMFzF8sIFHdhLTGI1AbUPAsDXSiOBaXazQdGteLMdlIRxdd8SjKBB+Ir7FLVuppZt1/PherxeZiI5x3ePdDn129wFapn5Z+pk8Qkhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/LcLQXBl4iF+RntARhb/kJkaEt6rJFyrRhodh3yvhw=;
 b=p80mElH7gCL0SipNwDyrQWhzGlp9+1QJh19QO/FRDjx1MdvGvyDPYyDW5KejgDUoPR6Bzi5h6yAMBg0oo5d/qLp2Y8b8+XeCPfVT8P3fsIfX22yw3OZBsVi7mbQxXned335W6PphovdJzyStIg2n6Wf9cAbPiudwBe1gR0SWUXbvSkqFvy/4AgX33qjoJAwCP152jFrlvuFsBREeLH/I2Q/+enXh1z6Oi909n/n/mtqtnzML+b4+QPvDAxzT0r+9rm2WAI4EFqQ79PRy7j2RvdKc3pAp5MDw80LBwj7IvEPtrzLdJ4YLpzwygkB0njgCXwYDPrrvtYhiezny2jHJWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 13:23:24 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%6]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 13:23:24 +0000
Date: Thu, 15 Jan 2026 09:23:22 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iommu/vt-d: Use 128-bit atomic updates for context
 entries
Message-ID: <20260115132322.GE961588@nvidia.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276EFACF8AA21215568550F8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <db26b1e3-bd7a-44ee-b458-6cb0fedf6662@linux.intel.com>
 <BN9PR11MB52768CB67C102CFCF562E8248C8CA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768CB67C102CFCF562E8248C8CA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:208:23d::21) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbc0a6d-c732-42d8-91a0-08de5439426a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HoPEmpTYmVUdgaaXR704mAQZITHrZ6ypILA+rLag6d/oI9qY02Op3kpRaCNO?=
 =?us-ascii?Q?gcYMMo57hjrmrKUlEcKaH524/Q4mxVQuQmMhm7MZUT/jvlDzyU72oeTZT7QM?=
 =?us-ascii?Q?ILn3aLCWkLEBKIGB+RD9ghlhvvh8vc4+ZbpCcTP5HqJv8p13q8J/NIKX2wvv?=
 =?us-ascii?Q?ZFCTDsK8iyQL7yiHvi2iXOCnWEghwGvF3/of5QR7406rS1r5/kqDyYt4wphj?=
 =?us-ascii?Q?jxb8f0rPKmDbSwSZUSkZySW5FVAikle0rvdw5IRMM4/7Sd61cwtZONysaoOw?=
 =?us-ascii?Q?CKHV9Z5YeRTk4tPQGZB4ckqUGZfOpCOzqb+RQFZUNJpOrS9nYNZfu7/qKaEX?=
 =?us-ascii?Q?mg2W3Wce6/Oi5NTDO8SXs1DACpUSh5Twz0LT1Zj4RmgR76+vTmMavrUoqIgq?=
 =?us-ascii?Q?mvmWlIRaWsORRqV+/ApmauAlvDVMN5jG4dxRsTez4pIwOTkXYuPAjysljeJi?=
 =?us-ascii?Q?9biwIwPhkYmyHoqkvhWMJkECxtf60B++zBxoTAbhBELBAqd8AOARiTxdlXly?=
 =?us-ascii?Q?y3kzR+JnVYGAub7w0r7qwOVRx/0s8Ei6jf4uEiROeBKYfdo1myb6dBd41yky?=
 =?us-ascii?Q?fhaXFYCk1WC22MyR1W+RGrfmOlXXy2xObyPPfytxq2G0v0HkGFDoh0i/vfdi?=
 =?us-ascii?Q?vDR0bxe9iudRbRkty26A34CKJfmk5Pso5fnKuuTj3iXmpNvDqaGv3XRZ0kVr?=
 =?us-ascii?Q?wSqmhNumOJ2Ht6milwkGM1Q2UzVYtojq3u7suiSA5xMTsy06nyyjaxzcTvZC?=
 =?us-ascii?Q?gPalmwuDezNGMNc5svSIoH5+37os2R4IMPbb0T/91a4iyguo+zlI4Gspx91W?=
 =?us-ascii?Q?T+Kme+Jsm0HkXmi0B5FojmHeakaEzR0lIMM/SbGO6qgIa7oBxJ9WL2gGPMJm?=
 =?us-ascii?Q?OSez9BKRbFUeDM5QqzsL0kpFF0YUmwX9bwc8kwq2rjughSLnff11xE7GKFX2?=
 =?us-ascii?Q?duYLQSWzJcD+p90ElUo16LkaL6ALILFbZ2oLoey+THHNl+7seKiMDPX0MVmn?=
 =?us-ascii?Q?8p7Yii1mmihd5MMNCM1RsgOej7LI0Djbn/XzbbJxcue6gyZZ88KhioM6PXtk?=
 =?us-ascii?Q?FZkVG+dIiDRG4rsF83lwxNS43Ff0Nbh2KaiqQzkwRlq7jgCnsyhugSzJY2eJ?=
 =?us-ascii?Q?KAhT/Zbujo3FgOvECxUSH+nvs9NSAggcviGPus5NRdz2K37byqVPDCsDP5CG?=
 =?us-ascii?Q?kfATksHuNA6hHIr7dCb/AINsxbAbSFZkJ3cSE7x37HYLpFjShWeBGsxwanU+?=
 =?us-ascii?Q?1t7xAHqeySE9YI0Zb4Y+6gj+AA40ZAvWvUovjQ3xcU0VKOJ0BQW2YDepx334?=
 =?us-ascii?Q?LrnEUjsgPwIbTmkTwJpWta63OWUXxIE8+/q4soIOFK7pm6Y5TiFJgT+Oov2A?=
 =?us-ascii?Q?hAsuLPFOLn4f2qAEAzAMEqEe94Ci2MrREC/ZTlWmszlaBskX89qmSZs8RCQT?=
 =?us-ascii?Q?K8f75eNywbOV4zkGyaxUpSY1matQ+P1ilZcDOV5WLyfaSE34COowjncsz7jl?=
 =?us-ascii?Q?dBjo89KGaMQacCRQ+RKJ02lFKNxzmSvkPWnOunlhDBmfpX2HGpdR+JXv3FY0?=
 =?us-ascii?Q?lFE1CPfNVWGWcwoAv+E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9z8FbstwWQFegV4ctQa1jRKb2l0+IP6ltJBsjCZsMUycR+hFL8+l/MMT3I9y?=
 =?us-ascii?Q?dEMifYHllQXeYuJKy9MJqaBQJ0k30FH9pROow8yehewAjo2i4rGRTVUqfVyZ?=
 =?us-ascii?Q?JaICcGjJh1BaxrG0dseLrlS4b7ibXBeooTNqJ3bwNSmvbvtXtQD84B/iXGUs?=
 =?us-ascii?Q?zJFvgHXifVW55OmezzBuSuAkj/lwK4tpTZxQR5jhvOrZJp/upPYTmhcpWUIK?=
 =?us-ascii?Q?4bmncAktf22mC7wUcTnKiMgr/klfVfi8cNWK8x4Ue/RP8UYWXqGBiZ+IdB63?=
 =?us-ascii?Q?TYZZ9TUzrnqhRu6GiyNPRw8GRIb2J9g5I8xQvimrN8yHhyKGLd+71GaId+Po?=
 =?us-ascii?Q?+9re97TbLlaSK+vHhE/RpZPXun92hjNkzGOaiwqW067lqCt7Zxyz5WxqTY1m?=
 =?us-ascii?Q?0hYnWCiLj4QLCfCdhJ8k1OizKmxVl8oR+uQX0ZciJFZenaPS3JuCW3zi6/ng?=
 =?us-ascii?Q?sXmWXdnCxUky0x5FjP6z7yISeGZ2EK41Cw4QxpaK5cU10Ic6fP6sPp6bO6V0?=
 =?us-ascii?Q?pzc87pOuozKNAg8c2/XBbQcghohXwETyjZPpyp8QV4VQyo95VU3adJ0Dn7Zf?=
 =?us-ascii?Q?xOnmiQahuZsRkt1zMU24VoL9iHVQyru8hXzwCsNSacsO08z+VKBmWUHLogAY?=
 =?us-ascii?Q?2mYr4arxKxFBGkNtaizQKq7ECZNxR546n+KatGGtGXUJ628/6yB1H41BdJxt?=
 =?us-ascii?Q?qzYd197S2xlPA0iHbnvXllOUivafexptbGUVlDkgIAH6NEVVjc76E8STaCT1?=
 =?us-ascii?Q?R/xoBxWgysxr9bE6OsvOM6mHvPouu5m88dfw0VxW4Xpm3sLI2Iq1yNOgrbEm?=
 =?us-ascii?Q?6+IY8eZjlYs+uZDBFsvkUDVhFv9/9FJtd4GzxIVWZq0yx087d0hzBovXJEuR?=
 =?us-ascii?Q?fX3n6xzMBsvYbkKflpCK6c47Ju7pI8BWYdL8fftRnRxQLBcJITV8b/6F9xDK?=
 =?us-ascii?Q?gVp74XgME4T0Rl20Xqe0FChVK9UC4XYpJ9Aq5CNjyoxcyMyqyxvKos3nBssj?=
 =?us-ascii?Q?X1uGRuafXQIqDJSB4b5e2C3WcXDxfgl2D7w7dkoMWaQ3RdOGffvVZy5ADSwW?=
 =?us-ascii?Q?dzIkxbwMopGmswizf+4ouqy0kZf+rQ47O8wmB3WawEBi2VB5fBXuN4/SMHmw?=
 =?us-ascii?Q?f7LCRGi/QJv0kfrQT5Fy9S25bLPCKBbN1kv6yjvwtGdGh19smmvpgKkUVmLq?=
 =?us-ascii?Q?yna0pYnY2cBFImCyI9YM2orexLtfWQZKpG67VudeGCTgYYkWf+CMsUHPhJEH?=
 =?us-ascii?Q?O1FwAvXwCPb8wLi50RYiY+RSZTihhuKZzRGha9SicpDzfFo8PkU/I7cZitPA?=
 =?us-ascii?Q?A/TKY77f48OXRmSTDRY9KiLlG8h6Id0/hHKw2FlW1BrNeTkNi138gn3iN0/N?=
 =?us-ascii?Q?jqV4Md7xwcZlU9BM1+MwUWvgt4ZHBiZ+nyn2wi7zycUne6usJ4zEz41kcftT?=
 =?us-ascii?Q?VSTqax7X+DiQ2XNGbn0qLF95eLc7EgsVhezSPOT6HagLBPNtlsIJpAWwlk4G?=
 =?us-ascii?Q?wDUEi72ZUHdyd5LrZhy+J16YHfckPp947gr/o01VqGbkkQsUiniL22HEa/SO?=
 =?us-ascii?Q?KqhvSVRUlCzdPqqs3g0tFQJiEGqX8gbI9KFbN6dxLZQcZfEVOkMo6Yc396L1?=
 =?us-ascii?Q?fvkHoA2X2ZTg/3F0WQhDbR5Z/6K0EBrhNyVmg2KxZGnc2J8Rnv/7bhjjl53q?=
 =?us-ascii?Q?4AFfxorOoh/XvFDxFRi7nj1ig1xiPxodxIj1ygN3x2vHngf+h8HtEmMcbwxw?=
 =?us-ascii?Q?JTlomBm+4Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbc0a6d-c732-42d8-91a0-08de5439426a
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 13:23:24.2506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zkrZBo01umy9GVs41QgbBQgfShPZdspu4tSqWYbXiVOLOEGoKWAguHuG+MftAiC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082

On Thu, Jan 15, 2026 at 05:59:56AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Thursday, January 15, 2026 11:27 AM
> > 
> > On 1/14/26 15:54, Tian, Kevin wrote:
> > >
> > > Then this may be split into three patches:
> > >
> > > - change context_clear_entry() to be atomic, to fix the teardown path
> > > - add present bit check in other functions in this patch, to scrutinize the
> > >    attach path
> > > - change those functions to be atomic, as a clean up
> > 
> > Perhaps this also paves the way for enabling hitless replace in the
> > attach_dev path?
> > 
> 
> I didn't get it. attach/replace are different paths and iommu core will
> reject an attach request for a device which is already attached...

From a driver perspective there should be no such thing as
repalce. vt-d has gone wrong by having special replace flows inside
itself.

Drivers do attach and should try to make it hitless, that's it.

Meaning drivers do the whole attach sequence in a robust way:
 - Manage invalidation lists so that old/new domains continue to
   generate invalidations while transitioning
 - Updating HW data structures without making them non-present
 - Managing ATS enable/disable in the right order

It is alot to think about, but if you follow the ARM sequence it is
all written out there..

So this series should be about the 2nd one, making HW updates go from
something on the stack to something in the HW, and if Balou is going
to use entry_set then use entry_set for *everything* and it will deal
with things like using the 128 bit store or making things non-present
temporarily. Even if the thing has only 128 bits used you may as well
stick with it.

Remember also that the 128 bit store is a CPU optional feature. AMD
investigated and found all their CPUs with IOMMUs have the store
feature so they could use it unconditionally (IIRC they check at
driver probe and fail probe without 128 bit store). VTD needs to do
the same thing, and if 128 bit store is actually sometimes not
available it needs to fall back to the 64 bit entry set, for
eveything.

Jason
