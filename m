Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F84245017
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731469; cv=fail; b=Rvdfl9kx/S8F/4/hfVBOiRFIWEMznKtaoF4HfzDb0CcXhS8Z3m9dzV3A4h5WU5vMYZw89ErlJvP4rM6drlFRbk/4xLYn7xIKf+kew2Mm32Zj7F4Gflw4QTsVpV+SgpvYN+20TJJrkrZB85BnqR6oidAi5OMQgn8fAk1vgp9JZiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731469; c=relaxed/simple;
	bh=0ptrP3MI8WLFbQEXGftN3CdReKpQJSF5faimQY0uCLo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=job5OETLVa5rvTDJbKXBI8HfJeWBWd4hOW/6zUGgczwO3Z2NT8xUGkBL6oq734zPi6vGjbEgrDYQMfxvEffxnhykfPh75p5tdek1WlJBmKig1Q9knT7wfvAn+7QyNcUlBjZS9hkGQjn7nxIpyR8jsZldTzjt1OT3WkPVQRUSvmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aipX34Sj; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aipX34Sj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFW1ed+3qTuRoeK3hCBtWTL0kJOkx5poIfUpBw/Vnsv63anyvTzUqrWnFKChaa+zLueJv961BY5zcFTQ4Oy8B3Tlq8hJUmIImfQSJD15hbuULqGf6eP5B+NmV34EIbmy/1eqVomVGuS8QMVFxlb/vOICp8HsJwTa5FwgheF+cPeoQIkV2wF5VD1ZATvAemywG6P0GtnbUxUTTKEOsb90hwrXXkBAvTHHQPVZ6yrse/lLyDG3dYO8+IOBPFRIxx3qt1T5WqpSf/TunC6wnXWBIzrnnFBbJRIkgxrAiVv7g7Jhw6z3omdiOyqoy5ZpZ5epDRcJrkmYyqzU/Nb2Tqry2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6JlESiV+RwdQOth+p8T8ss3YArOElsPbOiyQv/v5UA=;
 b=a/b1ScW2C9nUz0qOzXLKw/+gQu2zedBTJD6AuFtdvhCiuYW+ki18+vTrmcS9+/s2AyxjPzdzgxNyoaV3/+AsKBTsl5iULmouWqw2n7eU/422dhgjQsjGzkuhtRN9yF0Ry5kSmI5mtdUwgPIPJ/KuyduUTvr3DrC89oGiZfqRW31JMgzZwLbIbMlpX77crEb4I1vUxAGkTN9SDjmeSNrVv5IAybk9SMln/36PgQWyy5yigFGWmMfIB8L1ewFnlAphjY7S0voyIimv1eOY6nFuhGNqu1KGcEF1eQLDDcEu4ZEzE/hA66mC0JvKW5Cmzy4v/J7zwh7XHCFX0JXZ0gFQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6JlESiV+RwdQOth+p8T8ss3YArOElsPbOiyQv/v5UA=;
 b=aipX34SjjfjQduo68/k46R8CeCpEUyIpP5Qfd//E2t+3l0ama/N9zukn4tji62J9AYUhuIr8ECCexO0QFSZgGHwySHm1yOb+48huvl6gLVSVEeXX4hawJ7DGtzzUmM1gykXe+AmLQJmvPDe/ZIlt3vFlCGk9sgmo5MeK/ayQ/iA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.19; Fri, 28 Feb 2025 08:31:04 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 08:31:04 +0000
Message-ID: <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
Date: Fri, 28 Feb 2025 14:00:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: ec018889-e435-494c-70a5-08dd57d23d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnJxQ3crVFBWVkg2VXAwcHZoS3FLWFVRK1QwOVhzLzRZcUt5d29Db04wM0JO?=
 =?utf-8?B?a1Uvb1dKSmV5TzAxRGUxUGpQN1kyU2V3SHVoREVQM2JHekR4UEROZCtpZk9k?=
 =?utf-8?B?YUJtYWZVUUV1bDBYcVNYb3loRkczRlFQbFBTaFNROTFUNVlGSHhYenpnRGVO?=
 =?utf-8?B?Ukt1K3dXQmE1NEhqSU9RMGZOS2NlTWFPSWw1djRnL3FNbTFZQWxiSENsMU53?=
 =?utf-8?B?WVMva0p0bXRMVXJBTSsrTHpGTm9MczdXaEJwM1g0WUNOZHdnZVRRR01Wa29H?=
 =?utf-8?B?WDFQWFZMT3lEZVZZTGtxTVVKT21KNGZXcjFWV3RNTXdxelVFTmdFT252Zjda?=
 =?utf-8?B?V2Z6Vzdqb0ZJTUprelQ4TjN3NkJBVXZHS3RFZVZlcW9kYzVTSFk0dUoyaW1M?=
 =?utf-8?B?ZmNTbnZJeDJ6aVlFN1IyT2ZxaEh0aVJBYm03NER5UXF5anIrdzZDYXN2eS9B?=
 =?utf-8?B?SXdmalpLYVlrZk52QzNVSEdSS1d0TVpOUWVkOVJzZnZUT0VsNng2NWlXRElT?=
 =?utf-8?B?MXkvelZORzBIRElQUDU3YzNnRTZZbWRtUFBkNXN3Qk9sSlhONUt3UDhZTzJl?=
 =?utf-8?B?NzRBRjVySjAzQ1p3dmw0RjFqVzVpaVpXSjlXQkVsS0lnRVZlSGhnNjl6L2p3?=
 =?utf-8?B?MUs3b2ZFNEhZOWxNbzI3SUg3QUxUbVZlQjJOQWV0L2g3eTR4KzM2NnNCeXhr?=
 =?utf-8?B?REV2RWh2Z3YxQ2JENkF3UWxCMzNRM3RVOFRMVXBibW1qM2JQMWJZZzc4Yjg5?=
 =?utf-8?B?VXJPSUwzNlZURTZaVjQ5Zk1vcUp5SEthb3JBTDlXMlAxSHFlZ2FCTkZKbHBs?=
 =?utf-8?B?cndBQTRlakRwV2g5M0tIUEVMQ3BUSHVkUVBFNnFZNko0R0R4M1hnNmJPSGFN?=
 =?utf-8?B?WHlodVREc3pJeEswdGpVdUZKMWhEWlVTdnU1c2RNdzFra3U2VnNnamlOSEFF?=
 =?utf-8?B?a21IWUJUdnpFYWxDMXVLRlY3dUVkQnBtMGl1dVVPV1QyTi8yalhaYWwvUElm?=
 =?utf-8?B?elRtY3JnKzhSVUczR1ZkdlU4Tk4rdEV5MkFmZmVvYVZtUTlhSmtaMDVhOHlH?=
 =?utf-8?B?M1hlMHB1b21ORUFNalZVSmFyQkUwT2tRSTQ4OHRtZTZrZ3pCS0hDcVpaMU1n?=
 =?utf-8?B?QXdScjlTa3dpS3JEazBXSUtDODRvOEJhMHM4ZXk1Mk9IRDArcy9jWC9VTnhZ?=
 =?utf-8?B?Q0tRcVQ3bmJQK2hoRVVFMnNqVDFLWmc0Y3c4OWRXSFo4SEZIRDM3L2dDSmw5?=
 =?utf-8?B?NlVlLzNBd1JoY3luK3ZIM1ZNMm9mZUJmYkpxaWlNK0hKOUlkallISTNkQ056?=
 =?utf-8?B?QXJQYTkwdUIxeEErOTd0YWpQbUNhdHNRVDM4aThSY3RjcjQ2MnBtYVJBV3pH?=
 =?utf-8?B?UzdBWHZwNDZ0bHBwYzBXaWtkSEIvaE5oUjZDSk5wbDd2TXRWZHY1aDNFRldv?=
 =?utf-8?B?ekZoNzBDam53S3NqdnErMkxMZ2lkb3NpYVE5VThCL21mWXgveUs1bWhUbEJG?=
 =?utf-8?B?aUxxNElMUjI3a1l1b0VjTUl1QWVQbVorUUlMZDkraGd2SS9kOVh3QVZ6dSt1?=
 =?utf-8?B?MXY3NVI3QTkrMkNBTldWRFdhZmdFSEVydDdYc2x5YWlzdmZvYXdKWXBxUzBX?=
 =?utf-8?B?Ynk0eW1aY3ZwWllaTDJvcVFsL2w1QU9wZGhvSXhxdVZ2VnFuWGZiNjUyY2E4?=
 =?utf-8?B?b0pSSXBnSnNBb1B5Z0JLVk9FbWdZK05qaWtzWVNNWnJuYTNhdTM5VFVIMXR0?=
 =?utf-8?B?aGptVlpPb2h6Vk1rQUV2QzRFUmlHSVJqd093Z2pSQUNXVXE0cWw0bkN6K29p?=
 =?utf-8?B?U3NuNXFGZGt4N05ERTRxSVN3NUtvZVg2UmpHWTJPMElaWE11T1ZpTFNpRW5s?=
 =?utf-8?Q?NbmSSShg49HRx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXpqSEllc0Z4dDlWazcvWEJ5N3I0a3hqd21jLzFjYWdUMkJLMllqZSs2c2l3?=
 =?utf-8?B?Q3RzbFowaGEvQ1JOdEdURFNzN3RoUDF6TGhiekxOdnBqQlNOWlNQT2tIMTAw?=
 =?utf-8?B?dXd5d1RMbU55blJ0RlFzRWFud1JRUHFTbGFneHNLQUJMR1RQKzhRUndvV0xK?=
 =?utf-8?B?eXd3elRsS1oyd0dKTDZWQXV2dTdWd3JzZTRTRlN6dWxrVWxLc05aSGMzZlVq?=
 =?utf-8?B?L2lwdVBmVDFBV3hhTkU0V3U2SUtuekN3RUFFOUg2aGFVd3doZE8rczVzd1dz?=
 =?utf-8?B?THRzZTdUcUtYYkkweVdWVWQxNnRPS0czbUJidy9idm0vRjhjWXp0Y0R0YW9L?=
 =?utf-8?B?Y3dER0VtQ0JDeXNZL1lab2dlY0VUK3FnbEh0NE1NbHgrdXk0QzRTQkx3bUxl?=
 =?utf-8?B?TTVWc0hiZkZQMmMybWYzVWJiNmRHNlVQOEkwdnhYYmhwaFFVRmhZWmtFNEZD?=
 =?utf-8?B?Z1R3RHJFL3RSbXd0NVF3Zi9CajdVbTVyRk1NY2ZjYUxyY0hFZG1ITEV4UXlF?=
 =?utf-8?B?N1g3SnlXc2tMdUFCV0p0YzA3bk9rYVI3b1ZUWTlQaStBcFhrMkN5dTlsYlFk?=
 =?utf-8?B?UHRhZndqQ05pa0dYUC9iQjNmOWdlUVhGUE1jMFZVZFlFSDJoWFZ5WlFPTmhY?=
 =?utf-8?B?QjJGVkJTY2phWTAvajlNdmZkeDVEa0lEZjgrUUFGVyt5S2xpTUtCTGNmYzdv?=
 =?utf-8?B?QTl4OHRwNmhBa1lKWGpVNjVtOFA5bkZ2czB0Zk1TbHlwM2UwcGxOSnoydUJi?=
 =?utf-8?B?UHZXSVY0RmNIZnkzdllQcXFRaGIwWmJxSUhUT0NKQmhWTXY4YUJXQVpKU3Na?=
 =?utf-8?B?TXlkTXJRVW04YjBkM2IzMjlzQndiVkJTZkNXZitqUEh5K0grdi9wMWNhYXJ1?=
 =?utf-8?B?ciszUCtCVUp1OXdVVmVjMXJpUDFLdDNGdUNHYnBaQ1M4THJ2Zy92VlkxRTMy?=
 =?utf-8?B?eXgvOWc0M1BCQ2Zid1Fnb2FqWDFNblMwQmFPT2hQUkErZDg2L3JZU1hoZUxW?=
 =?utf-8?B?VUpZN2FoYjVtR0d2dkhOeHpscllDb1pmTTVZRHRObHhibmpwZGxUZFovNUcx?=
 =?utf-8?B?ZzZEbi9JN1VlQVFHdUlCY3p2YXBjZnAvbnZtcUtETm80QXFaRGd1MlhTVDJQ?=
 =?utf-8?B?VWwwLzNjVWkvL2hjR0NBSmlNeWJxc3FjSXdWWmxtaXNleUlJZVplN29XT2F1?=
 =?utf-8?B?d01HTWxqUjJJUkhnMGpnaWZCNThsb0xEWVlrQW9yTDRVRUVkT3BNVXB3c3hy?=
 =?utf-8?B?ZDhQZHBJYnBXNG9vRjRTYU5XeWZDeS9PMHFMT1dpLzU1MzZyVW9sbW5iZ2hr?=
 =?utf-8?B?K3M4S0d3TWhCQXhxMk9nOWM4YjlBTFpjMDhGV0Q5U052M0ZsaThieWF1ODdo?=
 =?utf-8?B?Z1c4c2dlTTYvbXZWR3lOLytvK2w1eGJDa2p0aGRtYVgvZXRXVWQ3eGpGQWRu?=
 =?utf-8?B?VTNETDZyUW9ZNVdhaS8vOHhDeS9TdHc4TFpsci9vOTFrZGdxaVBYWTU2N0lh?=
 =?utf-8?B?bmFyZkNxdEFxelVkdk5VSTZnbXBIT2UwQkk3SlU3THhPbE5ZVmRUWFNtT0Ix?=
 =?utf-8?B?L2hKNWNtUE95R2IxM25SWFB4bXRneGZ5aFVpelFvdS8yYUVLTGlzWGZneERo?=
 =?utf-8?B?QTNJTXg2MWdEeUN2a01TQTJZZ1J1ZkhqSjJqT0R0R0hnUFR4d2h4eXlGSkVh?=
 =?utf-8?B?Uk0vZS9pNjZ5Z2d6ODBhVFN2ZU1jdzIrT3ZybkxWcFY1NGJKdStvM1Vtc1Nu?=
 =?utf-8?B?NUwySkNtRWVSMjVsejlCSjlwNEd3enhRK1hCampPdFNqWGFLalhpVXdXcURC?=
 =?utf-8?B?dHQ0TmhiamI1c3B0NkZaeERsMmZURGZTMjY1cFZKYVZzS21IeU14NHRJT2d5?=
 =?utf-8?B?VEU5RFUyakVSWGNyTmNkQmZoZmdTRENYSGNsYWtLZGk2aE9YTG44V3YvbVNJ?=
 =?utf-8?B?cytXQlAydmtQVkdhQlkrUmRud1h4ME5oMGJKK2NGc2lTWFF1NmpQR3BRMDBm?=
 =?utf-8?B?MjlxQmVMR2dLajlic1VjZzgvdDlOSFZidE5jZ1NVa09wcnhnV2d1OEhyN3ho?=
 =?utf-8?B?Rk9yUHZvcndkZVBFdnhuYWtsNENZVGZOY0hOa29rblJDRmJHV1BPUk03K3Fs?=
 =?utf-8?Q?mIxEotdaJrAe5Y59jJScLvGOo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec018889-e435-494c-70a5-08dd57d23d6e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 08:31:04.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I742oMIUNfiP9FPqTgNxZHhYkXwGVEYradRjQBBorxNsxFm8fh66Us7hTBxaGLRkFk9Et14BYlno6FL09r6+ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676

Hi Yi,


On 2/28/2025 1:13 PM, Yi Liu wrote:
> On 2025/2/28 14:32, Tian, Kevin wrote:
>>> From: Vasant Hegde <vasant.hegde@amd.com>
>>> Sent: Thursday, February 27, 2025 11:28 PM
>>>
>>> Hi Kevin,
>>>
>>>
>>> On 2/26/2025 12:35 PM, Tian, Kevin wrote:
>>>>> From: Tian, Kevin
>>>>> Sent: Wednesday, February 26, 2025 10:51 AM
>>>>>
>>>>>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>>>>> Sent: Wednesday, February 26, 2025 9:18 AM
>>>>>>
>>>>>> On Wed, Feb 26, 2025 at 01:12:38AM +0000, Tian, Kevin wrote:
>>>>>>> If above understanding is true, my preference is to support a sats flag
>>>>>>> in domain alloc (nested_parent only and PCI/CXL.io only, as the start).
>>> For
>>>>>>> AMD it turns on the sats bit in the DTE. for Intel/ARM the permission
>>>>>>> structure is created and updated according to the map/unmap calls
>>>>>>> on the parent S2.
>>>>>>
>>>>>> They are functionally different things, and have different
>>>>>> requirements on the PCI topologies supported (eg CXL.cache vs no
>>>>>> CXL.cache)
>>>>>>
>>>>>> I think they need to be different flags
>>>>>>
>>>>>
>>>>> Not exactly. They are functionally different but serving the same purpose
>>>>> to the user. From user p.o.v. it's sufficient to have a general flag for sats
>>>>> when allocating a domain. The underlying driver decides whether such
>>>>> flag is supported based on the domain type and the associated device,
>>>>> just like checks on other existing flags.
>>>>>
>>>>
>>>> Chatted with Yi offline. Having untrusted user control a security
>>>> feature doesn't make much sense. Probably what we really require
>>>> is:
>>>>
>>>> - IOMMU core exposes a separate sats knob per probed device,
>>>>    allowing the administrator to manage the sats policy which could
>>>>    be no ats, unsecure ats and secure ats (might be further set per
>>>>    domain type in case the hw doesn't support sats for all types or
>>>>    the driver doesn't support all hw-supported types in one batch).
>>>
>>> When you say "sats knob", you mean sysfs interface?
>>
>> yes
> 
> in case this is the direction. This might be a per iommu_group knob. do we


> want a default value per some info that can be probed by kernel? 

I prefer kernel probe/setting default values so that we can enforce HW
restrictions (like SNP, untrusted device etc) and then....

> or we just fully rely on admin to program it?

have a admin option to make choice (I prefer global enforcement option). As
Kevin mentioned for fine grained control, we can have per group know as well.
(may be we can hook it to /sys/kernel/iommu_groups/<x>/<ats knob> ?

-Vasant



