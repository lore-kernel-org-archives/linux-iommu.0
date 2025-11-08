Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160AA24DD1F
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762599902; cv=fail; b=ZTqCPqDYU43KwpGkydY/mVlTWV/6WpDfT/c1Gbwwx9wcx6E4IzxIdyDYNUYWUFg9keGslFkVAUpZvMklLGhWLNPzUvCkbmBusMCAuztJvOELZQxtBRG5lZio4t3u8ruwjouLAr6U8880lM8STwcXS2WKzwWK24NA3v5bNL+8mVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762599902; c=relaxed/simple;
	bh=DsnoJG8CkE8M/blNFUVzE3EFhp/0wzh0bVS+/imWV6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ojYWjTG7ApWEvwSZwGPERABCzHbBi8RreHovrVyAjAV0oQGMgVXR0PsNgK8lVdF+RywUIQD2K8F0Qr3vgP4Ygo8AoJX7AS9XdKtCWZQwycqDQ0QufFN8ZUjWWI07v4ReWsPK8qFLHYBHRnGtYq6An5jVtUOJn0aKtVCcHfsW7A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rrDTa1dr; arc=fail smtp.client-ip=52.101.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rrDTa1dr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Grv4numVhzVMCu3yJDEbMTX4z7utIFRvmODr8QkK2wLenhyWed8DpZv7EJA8v5d9uYW7YuMtIcQvmPXnQcuKMLPZOOZadT2kruy55ebBocI1HaKFGmz95Br5ckyNiyZuxWfET0O9cSjqW5Y5tYRBgfsmkqm1Km1aTWJfXXTe8si8AHXT658OrZGqxkfhoHA9vlMSqeXqAHpD93xWeMib4Ty2TPzgIYVIcVrewpq79DLtMzVL87I2GYMJZHuAG3u2yH38o2MmVn0gqc1fDE465gKvqZZvwDKf1KPTjWzzQEtQnCVFvyNI0ojfgLjG1Q6xcJZkfYN7BzX7mj++1qeA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMdHGT6vN/csYgCz9ITSE8vtLF2J8twX+F8fZrcStUQ=;
 b=ae+j+W50JtffoJ8045l/VwTMikulJKbtgOXPtDg2JOKhtoxrrVdEqR0VYmVYXlBoOl8N45IRPZwBQGTqm2DHgoAfIWcaMowzpfWclYQ1u82qpPCtbgmX7usZaniz3KLLC1N+L1S6fAnnOX14wNGerRCK3q8BKGdcLkfEOOHcKBIXgV6fDUHFUpBVqdsG8e5nxI9YMen82gVQv5Luka1GiNhKOaJl/iD/0fXqM4Kxx/fBvFECoDdmazECjjC1fRSWvllyPEL46b0ytEY3wvfKcIPe/AiVlL35mTD/jhtrs+igDAy9IyHv4HBeQKhDMFGqIhMAk5fyxdUZjX/E6EGl2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMdHGT6vN/csYgCz9ITSE8vtLF2J8twX+F8fZrcStUQ=;
 b=rrDTa1drllvb4Ji0Rf9LrbBULVdK3y00+puor/9SgrAzlTob0/mqsczC5ProV8rERrZH3GJtZ8mouoxSm+dbA8KBgNjG71Wk3Jg1dbxTq2oTpZ/bzJS8B6ksh/MiRNeOrS5ESHLd0SyVJL5Tpw+T2OtV9u+mjol+LjvA7ELLkoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.13; Sat, 8 Nov 2025 11:04:57 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 11:04:57 +0000
Message-ID: <29687c29-7c1d-4a86-a07a-a70c83f85fb2@amd.com>
Date: Sat, 8 Nov 2025 16:34:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iommupt: Fix build error in genericpt unit-tests
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>,
 Thorsten Leemhuis <linux@leemhuis.info>
References: <20251107104701.237041-1-joro@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251107104701.237041-1-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d41fef-24db-458d-e080-08de1eb6a70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkRESU1aN3pFRHM3SEZMMEY4WG43cW9wQXZUZlJDVXdERUsveVFXamdmZE92?=
 =?utf-8?B?bWRzeHg3V2ZSd0YvUURTVnNIc0hweDFteldCUXF1Nm5HendQMURFd3JoeUNa?=
 =?utf-8?B?aUVJRUVkWW5uNDRiRE8va1pub0h4RDlpMWVRdG51RGZSV0pmam5vMWkzeGow?=
 =?utf-8?B?UlBvQWgyR2Vocjd2aUFSdks0UnkyMGg0NmlNdStDQXBlRzNGbG5NUVRSZklj?=
 =?utf-8?B?d2lIQ0wzKzRRNlpHRGIzVmZESWpYYW5JTDRJR3QvQWxsN1Z5NWEzbVNLQ2Rm?=
 =?utf-8?B?dDdxcnNPY1J5THlvcExMSG9wTUxvdFh6TCtydFYvUmRNekFlNWM1QjVDR2g2?=
 =?utf-8?B?cUxSRUxXdk9wUU1GN3YwdEJ4Q0o5ZGhUTmdOQ09zRE12VGFqZnp2WXRZQUFG?=
 =?utf-8?B?S3FNTG5pR1JFT21WTzRRR05BcklpTEpkVlU1MnRZbnFBZTRxazVTUHBRblhO?=
 =?utf-8?B?NXZBcGF2eTVrV0tjZVM3RXd0QjhTR1VIWEdTRU9hcGhmaENiaFdrSFlSTXdp?=
 =?utf-8?B?WjNOT05CZStLRE1VaDl3TVBYaWg0Y2RsVllRYll0SkxOSjZzTEw5ZWxndm9K?=
 =?utf-8?B?ayt6ak1iSHYrZmhEZlovWHFJbGlSYjB6K2g3UXYzZGZ4Nnp1MzJkdUtzZDNy?=
 =?utf-8?B?N1ZjK2UrMmVGb0RnWHpHTy94KzhFQ1hzWnlDR1ZadFZRa0NRNnlDbzNKTUF2?=
 =?utf-8?B?N2ZVRTlwVWJMWVlWVFhQSnZ3SjdEOHZQU3NScHByZWpXR05ZMmEvTjFvN3la?=
 =?utf-8?B?dkh4K1JIamRSNHk4aVNKTnBuYlF2c3NBK0hacWZxZkFWMHhRc3VxZC9FR0pK?=
 =?utf-8?B?Sy9GeVhkZ1p4Z2cxWGVPTmxIUllScnpEZUZHM1prN2RXZ2t4QmNmSmpjdVZ6?=
 =?utf-8?B?Zm1zQnN2TjdnNnUzL0RuR2NNajQvNmQzMFpJa1R6V3hQYmVjUUtRRVRiMnJp?=
 =?utf-8?B?MWV5dWVtcWM0S0NyUUlqWUM5bmtjK2pucHg5azJVeG5UcEZmTUdmYkxsSmdJ?=
 =?utf-8?B?QUNQbXZ4cWZCWUFQSXZnV3lQQ09BQmFDelNFdUhYcWZCQnNDQmNhYWl6QUNU?=
 =?utf-8?B?MG1vSlNqQkE3VkZwMjM3SW5SbFdVRFZZNyswT3VBbjZObzc3VXgvdUNPeXFk?=
 =?utf-8?B?Sjc2Y2NSWnIvTkZhN3MvMGVaNU1GQjhpL1dFaHVNcVAyZ0N4Q05rZkpYZzJO?=
 =?utf-8?B?eFczK21vdEFVRUw2eGIzcFNoeTl1ZHFQUW92eDNGRkNlMlBiYW41c0xrTnBB?=
 =?utf-8?B?amxrc0UrN2VXVTl0WHgyaHpCcDdwRGZkYysyaGYybitxTDk3bkNFUktBYTh5?=
 =?utf-8?B?YkRsemtCYXJ4ZnVGN3JpSVJiZnB0cDZnRGtjMW90SHFpeFBRbzdoQ1ZhdURp?=
 =?utf-8?B?cytHbnZTVjJNQzZ5ZHdicFUvTklsUzJ3MVlXN1B6ZmVlSGFFdUFGZVdQM0hQ?=
 =?utf-8?B?cXZKK29ya0lkNTl0OVFmTkFsSmVjai9tZ1poUnNHN2FKbEh0Zm0zSWhWMlV6?=
 =?utf-8?B?ZVhCVXpEYXZyOVFHZ1pzVjh1ak93dWFZenlVNEJCdmtyNjhGcGVVMjd3UEV3?=
 =?utf-8?B?OUdpWmZrL09SblJRaXFFUHBSUHh0VXBxUXYwWUFYVFZNNEtaWUZPQU9kMmVo?=
 =?utf-8?B?dXcrUjVEKy9ia2swQzZLRXNGZ2Jid3hzZXRGVW9xdDRYYzFWLzRrdXZMUGp4?=
 =?utf-8?B?bE5jYUcvMFhueEZkdkpScElxU3V2c2RVUXdTZ20yQWhWUjdWbCtCVUtTYzFH?=
 =?utf-8?B?bHlpRVFlNVk4cURjR3ZpWkUrZzFmbDNVeUNOVDMwWGZIdUZLTlh2WEhmRGtT?=
 =?utf-8?B?c1RrcFgvZnc4WUgxZkkzSzlNYXEzRUNra2ovUzF0elpMVHlOOXJENzZaajU3?=
 =?utf-8?B?SWV0OVhoQ1FINXZ1ZEFNRnhGNEtGNEVENVFXUkU5WDNNbitmVnlkTU1aeEZr?=
 =?utf-8?B?dFFVVzFFaCtYenl1ZlgxZ0h0OFFuVHdyaXN3a2pjdG1zOWVzRkZTeDRMaDdR?=
 =?utf-8?B?Mjc5dmFUam5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0F0aDkwNWZ6RzNuT21Ld0h2S1cxODgyaTd0bUM5OUkwQ3NMZ2cxT0NIajBo?=
 =?utf-8?B?b2RWNFN4TEI2U0tZMURjeWo2b0hISEJpdzZ0MVdPS1VOeTJ1Q3NYZCtZU0Na?=
 =?utf-8?B?ZWpGSjRuZ3VKRS9ZMW1UZHRDY1YrNHJpMDNHMzhNOHZmd1JjRGtrV0NLRWNz?=
 =?utf-8?B?SWJ0WUtXZ09rRnl3aVJkM2M5ZTI4WGs2TzFRTDg2SWlhcnFWT0FFcUJReEJk?=
 =?utf-8?B?cTdRUUZUWlVueTM2dFF1c2NFZE51TCswaTErYjAvamZoZHNadXR0UUJubmRw?=
 =?utf-8?B?bFVvVHphOXRIVHYwa0pMdE1nUFBZMDFLQytTdXVyb2hCaHdNKzRxUC9Rb3Qx?=
 =?utf-8?B?cjlaaHNQTmdRbHhTQUdaUmFkOWlPNitOTVM4WmVLU0JodUYxSFQxMnpML1pj?=
 =?utf-8?B?dit0T2MyUzJqYVFNN2dlWDJWVWlySWpkUDdVeTNvaEJOSUtuc0w2elh4ZXow?=
 =?utf-8?B?c1R4M05QMnFiQ09xYW1lQTBoZElRd0pQaERiWTcyM3NlNkpqVWNkWGtCVEp6?=
 =?utf-8?B?R25aM2RpYVlhM2JkVm9Kc2VyNVZQL09DZjFZR3Nocy9yY2ZqVTExSEpta045?=
 =?utf-8?B?ZHJzeDJ0bTRLYnlUNU0rcjVtRVJqOGNVbmhSOWtDZVVDd25FQnZsVzREUFhy?=
 =?utf-8?B?aWFrZVN4YmZoZ29uQi82bVZ6VDRVcDByM3pnVHliUlFmQjRnb0NWL280QnJs?=
 =?utf-8?B?KzlGZElERUZ4Z3ZVbGdiTElSWWRKU2czMm9HUlNFaWIxSEhmSEdCZURrVWRp?=
 =?utf-8?B?ck9ESmN2bGt5RjRpZWlnL1BRUnU4a1RhdVVMeFlVcUxqKzU3YWFWNDJSNXI0?=
 =?utf-8?B?SjNKRmJZbkwybGZXQnhrZExRVjVyMnlLQ3MwQVhzcW5HTFQ2RjRBSG9rRHRX?=
 =?utf-8?B?eFJwZWNPekphQUxBdWNpM1JRL0FrUjFXNERxaUZXRzVpZ25IWVM3QnFWZm1O?=
 =?utf-8?B?VEY3VjhMV3VkendMNmZWZ3pCL1IzTmcwSWJOWDhhcEpxYitCVmh0OHFtajVR?=
 =?utf-8?B?a1ZQWktXWDQyM1cvcmdnYlNTUzFDcmV5TjMxMnBKMFFUOHBTL1hrc0N6NUhJ?=
 =?utf-8?B?THkwT2tyVmRlcm1ET1J3eDJTV0UvRWFOdm10YVQ2cWRqL0NOaHVwNlBiWHFI?=
 =?utf-8?B?K0E1M2VEeUdKUTU0cWI2a1BmVXBoeEhBZnZFWXdkUmdCVWpRTnNISk9KdzBr?=
 =?utf-8?B?dnErbmwwbTRBNlFoQ0JWaDhvdWZTNFpaM3djaW1oVFEzYlo5SThyN0k1R3ZR?=
 =?utf-8?B?MUhOOFdOWjJOMkhNOFFOMG40M0lqcE5UN3NlK3BKQzdvdURLcFJFanpSWG9Z?=
 =?utf-8?B?YTc5bmJZYi9sQ1hlQkg1Q2Q0QlJweGh3TEZmaFJtUTFoQWRINm51RWFJRXc0?=
 =?utf-8?B?SVNxSksvN2Q5WTNpdFdJaEhlRnVyeTFVZGhwajR1RytwNTFTL3VTd2dQRHB3?=
 =?utf-8?B?WDBPdVlVK1R5QnVTNU5WZ2wwaTBnTmtnSXFSQ0tTVkVTbHRPMHBoWHNNWWoy?=
 =?utf-8?B?YytRMDBsejBZZjNiL0ZYVEVsU3hhMFJ2WFljK0tzemlUL1dkV3BvbllIQWxp?=
 =?utf-8?B?Z0NQdm80Z1ZycHNWbFVpWFJSUHljQWQ2UUlzcUNJSXZWYlN2ejNwbzlVdlgv?=
 =?utf-8?B?MXNSTXNiUnhjNTBvL2dWZVdhUjVxcithN1lBY25RUlhtMkVkMEUwSEY0Q1VK?=
 =?utf-8?B?aXRyUi81ZnZOZnVlM0tmRTMrTXlNSjlSTDNSdlJnZUtVNEJWM0JLOVNpZEdS?=
 =?utf-8?B?eVZzamJWeTRQVEdSRnpsQ2JxeU9FQ1NQQ3pqNm1Bbmp3ZGxhTjZLZ0VDUWc3?=
 =?utf-8?B?c3ZDODV4SzNFNjcvK3FkbTAzOXhaVnhNVmpreUwwZFNvWFlYamZuWHRYUHVN?=
 =?utf-8?B?bmlXNWp5N0tMS3lZOFlJaGFFcnErOEsvcU15R3hkZHdsWURxU2pHQkg5NE82?=
 =?utf-8?B?L1J4TTU1L1dYTGd0Q0FwQ1F2UFAwelBXcURYLzR6R000R215WDdDOXdVVXBK?=
 =?utf-8?B?UFN4TVNlZFZ2czRFVVVEVzd4aHJXZk5rMlk5ZktPbWRyTE5sM1Z4UFIxaCtR?=
 =?utf-8?B?cDl3ME9ZZUc2RlljSkJuSmZWNmh4N1I0cnNPY3ZHb2RXV3M0c1FrTlVyd1c5?=
 =?utf-8?Q?+EVXUTTfgNpZz8W9jVcVFhOqU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d41fef-24db-458d-e080-08de1eb6a70e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 11:04:57.2520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIKCLCV7zuq+DSUHpwb6UWAtc3VdzZKnZ574iPA9jhibUdYtPS3PVe7FtH39mGtsXxNgn9lVOPmdpPo0td99/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295

On 11/7/2025 4:17 PM, Joerg Roedel wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
> 
> Fix the include of iommu-pages.h in the KUnit tests for the IOMMU
> generic page-table code to make the tests compile again.
> 
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Closes: https://lore.kernel.org/all/9844d4cb-f517-478b-9911-b6dc1a963b8e@leemhuis.info/
> Fixes: 1dd4187f53c3 ("iommupt: Add a kunit test for Generic Page Table")
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

Tested-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

