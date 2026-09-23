Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA55505D5
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181606; cv=fail; b=lxe2ERgq6hBfn1RklGmAmyGE0N+572WriaOuMfpxEOtiF9oZK9vmLNAEXBpmkZ6B/mwbyjrI44vq3kbE/2sDF5em9Pg8Q/n8+/1hJgOpUpILjLGBbmt7lDShpkCSvs0ePh7w19ARiGyq8mgJ6h4octrfd+iWzPjgeV/y6S2QnEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181606; c=relaxed/simple;
	bh=FQDLsYXjSJ2L9oVAdyhgD1hOYXdXv6n54toT0jBZtuE=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=htSu6d+srS8EQmx0S6uU6ZCDEfGUH9mfOQf560lIx2dpm8fQGcYJULQ6fwY1iEHmRJFwOd/2n7SLl5Y9ddsRrkznE+rP7pPhptBtJmcmXGN2no8NgMp5IGJU0wJzJlPDpeJm9Gdtk63HwU7s0HHSm4cHO2xBgqc4+HG62uY/okQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A73wtVGM; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A73wtVGM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGDQeJPZkPYx8awwUeigYYJ8vXVP699VhDVG33u/nim2Q1fPiM6Zye1OfcXEKIHP2LjgOEbDverK4ghNfzlGgeaCbfZg2qbseRsbqT3vod5e4eOS7MZvn+6yHb+syyXMRoA+YGyRxk3ylbx7BVWdA8ph7ZNejrDlFdiQwW4BM93qrLxzUbfdRxnPhY+kRldtskrnU5D3EEJXGVc9M6iyt3Y737ImKR1fgnxqz5dlAXKPg8+qFvigq+xRpanIDveov5waKPUur5ytiS8o/gI35StWyg3Ag8GSa9hj0JvHmTnUMqI3U6dKHSag6Hw/HrrcOwz1N9tugu+6n3IhnCIgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYEkEyLYRvEXLcgoszpDt9CeBmBWPTZByrsf+KwGr/c=;
 b=p3m0XX/CQuE9WLKmvG3GL+lBfO05XRM7TuqOHRxEy2rVXiSSi3J0fTU18jjv73jBos6edBovO9aS48h9EQl/UYl7ahh+bzRpEikN5hVWsB2mfgFtjwuHAJRt0zRo2xqpP1I6yoKK6gXA3oWFQcOSuEr2XbbnaPkQtRFxTd2Ry3JGyXytuNawdLkYyGXVsDjcPB0wbFEO43T8tiLyPkKfWvLz3s46QxX/n9OmtI/yPXT/R4IrS8QrDKcgQKVS0isjTPI/3U2G6ldClKCZoZvyZCJrbEGrufyrHbpnusMw6bJI9KhvnSM7LpQmydMekvmU8+E7bo3P9JvC55Gpyf3l2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYEkEyLYRvEXLcgoszpDt9CeBmBWPTZByrsf+KwGr/c=;
 b=A73wtVGMrABuKpo9BlfvrPe0G1Ttxhs8TjxfNU2Kk/+ZCEyG4ka+FPp0d7dIqAvAtf8MyXwTS9bl7jos9IYUWoIQUvL+pV38D3BSTl5CMmZuvrGs39Nyzio9ncXKzOt+80Nv7g1I8V1FpdD/zZt/dHmgVJ35zciEuqtkuuo8X67wv2Lb1oRUs44LkCsWUMJ7sILgflhAf657+YDIiDYzBeH4fTZu+kLEIaPi1btV3trojDuayy6JgKkDu22y2sjP7tVQOBcoRGcqa4kCSx1aKEGD74QGyZkC7t31G7XsnQddXofno4d3t0nv9+yuHgx1eo+rQyhMdFHZRXzDCrIEcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by SN7PR12MB8170.namprd12.prod.outlook.com
 (2603:10b6:806:32c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 16:39:25 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:39:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 04/13] iommu/arm-smmu-v3: Disable the EVTQ and the
 PRIQ in a kdump kernel
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, 
 praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org
In-Reply-To: <861f488cbbfa84a4d222a22615adbe5d2617bc87.1788130528.git.nicolinc@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <861f488cbbfa84a4d222a22615adbe5d2617bc87.1788130528.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 13:39:16 -0300
Message-Id: <179018155689.3334538.8553838316169800701.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: SJ0PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::10) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 57eb832d-84a5-4dcf-9391-08df199137f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|10067099003|4143699003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	VW/9QQjtzwj0Q3OuWoMiVlkrMb1f+XjJY8K5Z0VGdlfAZgF8HHpwKuNbgeVihgKtILYEUKMH9IhAF7aWqJvVotuR9S+h6SpE6Kd+252Xv2OrOy/4S1UzQUAFmxfM0KSSPwNGmoaLXfsc4iG/9k8+KeztQx0CeACDz5xmbRt+vF4MmyqURdeuR8IfOLhCjDSkNXHY5Xy01dQgJ0LxIUqwXmcPKZvPeFsddriHgMRVswT3T7HmcQXK2a5Tu6nfv++AeTufP3/BVSWt37giHH4tn0BHEX52XvsJ3H5agYnX7iTqjgx0e33EQKukJ4g5elNAaklunRU7nTMdO6i25xUgqptLGAfaPj4pQLGPPsmTEmx0H4rRONLbpr8DWggkSarov6fG3ZLmdJ5Qx7GC53ucp29Hh8LgNnplUZrITWHpzMhJlAMM6jN6tlJh88M9VrvIhzSzW2twLmnTUT71aT3KAFHNzjSDX4QPSe2KG0M4DMLeg77TxHx/YrS8pwccEppajekJ62k5BtSmSy/b7Do9qRNgzHDEPsOCxr2N88oJVcIlP14bwQD+e50+j44XE8JvhY8env84I2A2FudhZITDA+UrIUQULWWzB8eyVDj8klFWWB6pd59ruQAkWK8yXMl7SHhDrcOGlMftkIDPDw6H3a3YZwHK2/HazKvmyze2CmU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ME5KbFBTS0p5ZkFDem0vRnVPY3RIenZzb2hocVV5UldTVHg1dkxPRVlqZERO?=
 =?utf-8?B?c3pHZXNOYUx5aGF6c2o2V2k2TEd0S2NEdFNML2Nab1I4UG1YVmRBcENIZjBN?=
 =?utf-8?B?d3lIRlA2NmswTnR5WEh2dUFPTTdHeGhKWFp4UFdNVThtMkd0V2M3Y01yVkwr?=
 =?utf-8?B?ZlRNSFZNN1E0R2NFMU9wMm5jTlp5ZWlWRlY4TVd6VEtCUUUrcEpEWEM2NVVo?=
 =?utf-8?B?RWR2QTNFZkk2WExjSEhpMkFDQm1QWlBXMWxHWnppWTVDL2ZCcERvZGpGSUJL?=
 =?utf-8?B?WDlLTlNkYkh2SzNESStGazFzMHFibG40TUN6c0xleWdwZ1dBTHBLTEZSUEVu?=
 =?utf-8?B?a2pHaHgrUndMc0owOUtmMldXL3BjY1gxRUI5c1E4VW9tR3EzSW9ucEVYano0?=
 =?utf-8?B?YWV5Y3JtUzZyMk42bUovcEVzS3dOcGluYkJJSUpuMWtPZlFpSHhKRlZ4blNT?=
 =?utf-8?B?VTg4b2g3eElHNURJNi9UczhiamZyaEplRnpPQnREaTMvU1pvaVRMU1BKTkFZ?=
 =?utf-8?B?QU9jcGNZYkNpNGE2VUVSaE5BVHRMd1R5YWtkbStpWi83UGszTGUwZGNwTmtl?=
 =?utf-8?B?eHZ3c0Z0UUc1ZzF1ODYxYlhoRkljRUx5Yis0RlJMbXdhVDlmTHI2YktQd1ow?=
 =?utf-8?B?eFFtbCtxdnZDTWYrYzk2SlZGWUgyWE5YZTlRYXhmaFVockY0M2g3cG1XelZE?=
 =?utf-8?B?UkE5TlpDejRXbDg1V3k3RTRBSkhJUmh2ZWdiVm9vUjRxTEs5TmNrZmJ1cEQr?=
 =?utf-8?B?cnlRYnZxUTRPVis1Vy9ZRWpVeE0xa1d1YzIya3VIMllvQk1IVWxLVmVHWXF4?=
 =?utf-8?B?ck1pTiswZ0pTL0J5VXFMeVpzWVdBSWJOalR6d1djS0FpL0FJK2FoUE5wWG9S?=
 =?utf-8?B?L2poV1czUHExWXU4NzRCQVlMb2pNd25YQ0cwdDBlNDg1a1VhN1drS3A2SFpm?=
 =?utf-8?B?QjJHblpZT3NncFRWdjBWdnFZNk1MT2h4SjNHdlRJQ0cxN3FXcWxxTzdKZlVZ?=
 =?utf-8?B?N1FXVDEwVFZiK0hsVDBsMnhhb1d6U3dxWkp4OWVKVHZ2dzN3RHFMRzF1MkZK?=
 =?utf-8?B?c0lMZW5MR2xWams1TEErT1FvaEN0TDN6OTZvbjl1TlhybnpiQno0MXZLNWlp?=
 =?utf-8?B?a3ZrMzc1WWdSZVROTGdEcllVSTVteERwcThjaUJDRnV2cTRIbnZHZzNsVG94?=
 =?utf-8?B?SDlWTWJqQXFTbUcva21PZ055bnBWUFRPMEZMVFNrR3c5R2RySUlSN3Y0Kzh6?=
 =?utf-8?B?Nm1JVGJXeXRVOEFpUFlKOU1HZ1hENVhpV1ZQNVpxQXRoZ29CZ1hERWFid1Y4?=
 =?utf-8?B?b2hoUEM2YlN4VjhPUGgxYnUvRjJGTTBwaU8xNnp6QnNpNTJYRkNyVkw1aWxn?=
 =?utf-8?B?NDU0K041MmY1c0tWSXRGWjNrVDRFU1lPUzNjTG9LRTFnRENMOFBjTlpSSi92?=
 =?utf-8?B?T1JpRE5McmROOGRqbUZIb21Nc3I4NURBdG9uVlNVcTVGK2RVTWlnYU9UWitH?=
 =?utf-8?B?MU1SK05sbEVZYTgyM091Q1ByOFltbzlaUWZtUEQyNGtXN0k5dHovUGlwTDBt?=
 =?utf-8?B?Z1NKZk1rd2RKeWpSeldSQ0MzRHR3cXUvQW1DZ01uQVNUQUp2bUpJM29BaUdi?=
 =?utf-8?B?Ry93ektJQjBIS3diZzlCUTJzeXRSbUlxWk0yZmlWaWdxdk9Vc253TzdjVFl4?=
 =?utf-8?B?Q0dzZWFGYlA1V05RLzZNUFhrcmlPbU9sVFdxZTM1Z2xueUoxNEk3R2V5SEpj?=
 =?utf-8?B?ZUsyTnRkc3ptVWRUSGFkV1NYeE5uZCsyT2xtbDRPTDBRSnhWOGxYT1FQOUVu?=
 =?utf-8?B?ay9zQmd0ZG1ZR1JLVldYZW9hN013TzdRTVFpOG93ZEE3ZU5UVGExMXhDUzNq?=
 =?utf-8?B?TzhWY1ZvQ3drUXZDS1VHVXVGM2RESE5ubkZsakFKb25SRzVJejAybi80a2V3?=
 =?utf-8?B?b2Y1WGV0UUFNOG5YTURIV1BBNWRJblVCMG1ObzNpV1lDa1lybHFveGZVVk5p?=
 =?utf-8?B?TGR1UnBnaERtSWprZU5WOFB1ZlNLank1Z25rWFMxWDUrOFhZUzdPeFA5SXZX?=
 =?utf-8?B?YWpaS0tXOWtudUJCMzVXZW51VmYwQ0xyRHkrS0hqYzRyTVdyanc4eUlGQlgy?=
 =?utf-8?B?U3hGeXcvYy9SMk5JUXdhZnkyTzJDYW5XQkEraDkreHdOVXRkQjVwK3g1V2ds?=
 =?utf-8?B?cStRTEdtMjJGNWhiZ20yeFZWdVlrNkllT1ZGTXFTOFc3QitoeDlMMzE0Y2xs?=
 =?utf-8?B?OTRla3J1MkFxZFJnVHlPdnJ5djh2eG5kb3ZKUGsrZDdHWFFkTzJFaCtaRm9E?=
 =?utf-8?Q?/WQ99ksdbaxSoEmXgP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57eb832d-84a5-4dcf-9391-08df199137f9
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:39:21.0439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YbZRnheVQmJkS5kWOTdYmLgPRJZm1BRx8HpDy8qTbcD+809wiRVIB8ZPX/D4Wjn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170

On Sun, 30 Aug 2026 16:18:05 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> A kdump kernel cannot use either queue. The crashed kernel's CDs and page
> tables might be corrupted, so events would spam the EVTQ, and there is no
> way to serve the page requests that would arrive at the PRIQ.
> 
> The reset routine still enables both of the queues and then masks the two
> enable bits back out, having already programmed the queue bases and taken
> the interrupts of both.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
