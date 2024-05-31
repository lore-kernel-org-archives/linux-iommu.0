Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C18287A
	for <iommu@lists.linux.dev>; Fri, 31 May 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147390; cv=fail; b=n3GBGMmcxFy6Xs4nwYxhQziq28rMuB8yS+cv7MYg/rfr3KgZaHp3xtleEyE2exMjl5WOxGCdxzUvko0/JfHDPYTN4iypPIeWYn2yQP4QXse1kEQElT4z6jo1QUvlqe0hleIvSvif91NHLq7UsI8ADzGwdSSMVKilRWGhiI69oUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147390; c=relaxed/simple;
	bh=96mW1AFF9bd4uTRp+lFrIfp3OZq0XtYigHNnAVNt5Eg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KwJ6z/q5TwnHz4zRMrwFozJR6qSzcp78AKo7JW5dvH/yFeAdwtZA1IlC9tXISA5l+oRx0TnvRKaoQUM9YFV299OHqQ64ALkgW/PaE37ZFedXEso8CSofSJJ0F/Gp+3cXpAwxO+CmvjpF7ewKBeqRHeGCkQK6A//Vimikke7ToKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lf6FdB0a; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lf6FdB0a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5yzlG4fNayP6Tq6EKKs9DYY73vxQK3lfsDThqc2QdVfEqcMt11k5i9y2blrZySyAFAseCat32ExvFzYP6TN6tsZnc+IhEMyyUh0skRiPDd+1R6CiHqk/bOcVjG0Kqbcdewirn1nb+L0fBdrsmScM2z0a6RGULu9h7sZ12J0yC0xyM46aScRX2IUELcXYMXzBvP+SQ6Eb2ncf7qtgXDQ3FXrHa1AJkCOUYzrpJvBIazfPlkAL/HY83ublYYlB0xrQMnR3EvzJn6xeEwWl+ZJXUYcrru201s3ZyrwHqhwYuKePlf6N+mi+fn1fGF7tWdHq4q15nXR4NvQDMo/SJPxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=336s1kqBzWVF1xuSOVUVNH1KsRPz3tDANBo0zZBHL3o=;
 b=ddF5lTrNH+WGYjLs5ah8DeqBg6n4rOAfLtkU2x6YTMnIHce/naCfjajpnJSlvO8SnPybVqtqtGmgQc35muSvL64NoAykDsvMnqovJRB9LhFy4FsfjRJsC6MUGn1Z9rt6YWEj6BehEJHG6V8TSxKl8sda8TdLB7DV+RwOJ2/Ko3Kt4GeC+wCj0brK6+zfdBUPW4P/uxzmevhmVDlpema8hIoBfKGYC9JfVSXrtuv4RPuYp1cvXPXSBQv7sd8T113knUkSZMsW5wpjjV6ai8cNIRGDT0bZJtFpwHZJTlwtjasPk5mLqmxqPNe9023xADlNACYxaa/iKTispMEaPmvPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=336s1kqBzWVF1xuSOVUVNH1KsRPz3tDANBo0zZBHL3o=;
 b=Lf6FdB0aSMG1cC0SF7ef2cj2aDOITQsXG4cPZl4cMwQsmonxzVl+0rHaImthryZUJM2oX7wnBEF39wNfIH2XrtI7Vbw+RQUSSOhJROOX0n1G7cStigM/rbgLRrfECDXxhzch/jsiPPr5/DzIJm/bZZarAc1P4oYSMX5MSu8urQHjyQAwORWNUs1Ibe/6TJ8/0RPjfs2nJTLk24yQs/Tc73YChAGJLcMmuauthwAUiKGxYJkjDJhlxnxJFki+6X22fmTyGJBhkx6Lw56Gj65k4Pcxow/iykgBB5n238htBt8HEPFVtNzFW4jzB9UyN8sK9I3cUs9cdJ+HMQr92DLffw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 by MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Fri, 31 May
 2024 09:23:05 +0000
Received: from PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::6fdd:1491:4d83:ac33]) by PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::6fdd:1491:4d83:ac33%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 09:23:04 +0000
Message-ID: <d854664c-ab56-46b6-81f9-9ef712c32b3a@nvidia.com>
Date: Fri, 31 May 2024 14:52:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu: Optimize IOMMU UnMap
From: Ashish Mhetre <amhetre@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: vdumpa@nvidia.com, linux-tegra@vger.kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240523031935.90856-1-amhetre@nvidia.com>
 <6b707eb4-5cf3-4b66-8152-5ba252f5df39@arm.com>
 <2a349725-72cf-45e2-9ca2-5a8b153a6fae@nvidia.com>
Content-Language: en-US
In-Reply-To: <2a349725-72cf-45e2-9ca2-5a8b153a6fae@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::14) To PH7PR12MB7426.namprd12.prod.outlook.com
 (2603:10b6:510:201::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7426:EE_|MW4PR12MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 82702143-86ec-4c46-cc3f-08dc8153467e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3lhUlpDTU03NmVpQnRlM2FSaGVkVEkvejQ3azc2a0tyMEpCa3RaaUhLTzVa?=
 =?utf-8?B?dEkwR0g5MEJWZkxhRUtld013TDJ6bHpuZndHc1k2cDdLRTJ5eUJjZ292NG1E?=
 =?utf-8?B?UkJ2MVBKbEJrVXUraHFTcVh6OU9LQ0R6cUlRYVpyZi9OWGNaS2E5b29sT25u?=
 =?utf-8?B?TzRzbHpBK20xTUdhL083T01YMjJ4bVNRQ0MxRkZpdGtsb0oxVTdOTkVDQUtU?=
 =?utf-8?B?TjZ1dG54VlozMjJEbDhjaWUwM2Q2dVQ5bDVtWEY3MjhTRFMvMi9Uc1ZlUlMy?=
 =?utf-8?B?MXR6OGJ1bmZpNVdzTzNjQXRlSklJM1JxcWtHbSsvSDBIMm82RGRBOFdFV29K?=
 =?utf-8?B?ZWZoRzZTOFpHTFNYQWJPem1pZUc1RFBoMmQxSXRJTUwvQlNJRDJlMkNWZ3NZ?=
 =?utf-8?B?VERDTVVpRDhXNEQydEhydG8rNTBRTFJKWmRVR1dKVzVndld4VzZ4aFI5Qk52?=
 =?utf-8?B?Nml0dXh2V0kyKy83aC9sYjFKWU0yV2RkeUszckhpNnpjc29lYlVKek03c2tU?=
 =?utf-8?B?dXFtUzRpbDYzSSszRmFzT1hBVzNyMXk5ZjBTSkFrVnpiVGxabkhIM2VpRUll?=
 =?utf-8?B?U3oyZFFJZmVBYTRFRXY4NHo2V1huNG9WSnJ3ZU5Kc1B3U2lVdnNTOHZqa2dp?=
 =?utf-8?B?RlA1VHVUcTBNTEVZbUxGZTRIQlArY1NEenNnTlMyekZ1SXRFdFRuZGFpYi9k?=
 =?utf-8?B?T2pQYSs1cmpjWG0xdkVnb2VXblNVSG1JemlPWE4wbnROKzMyVHpKU3IwUzlZ?=
 =?utf-8?B?dTFmckFJM3d2eDRqWUtpWXZWa0YreExQUGs1TzJ0bXR5ZVRMZHBzYjlkMVlh?=
 =?utf-8?B?M254WXRPMGhDRnlzWENMeUJZRGhnd24xTTAwbUdzemhDYkFyTERTNEVBQ3VF?=
 =?utf-8?B?bHdiSXlOQnVHOXl6RitFa3dWRDBwZDAzdXFqVGZKVkNYSFBsYzNkUjIyenp3?=
 =?utf-8?B?M2xES0hkQzkzRkd2ZWszMk5BNXg2VnUwR3NoVHFzMjNSOG10cWk3eUVlMWhh?=
 =?utf-8?B?RVFScUhsY3d0ZXBibEFVM1FKTTFQOS9tTFBLVm9mY3NvU1NML3NIdDExNUhO?=
 =?utf-8?B?bVI4Y1ZsTGo3S2NPSXBlbFF6cnRNdGhXRUtlUkFQS25BZExmbzlnelN2RXUr?=
 =?utf-8?B?Z0FKY1VBaER1T2I1YTBzVnozUGlOeUkyMlFsYnQrNlVlS2QzR1NNaE51aGhJ?=
 =?utf-8?B?YTZwbHNScmRqY3pZVy9zRWpyR0gzeWJaQmg0YU5xaUFtVWdRTXlBaytRT1My?=
 =?utf-8?B?aExHaW1WbDNXYzVGT3U2UlA0R1kzamJqaEdMMDQ2MXJGT2k5cXpnRzFuY2Jp?=
 =?utf-8?B?bGFQaXJPMFJ3THNRVWVQeU9GcVhNVklGU2xuYXNFcjdaT2JWT2p0Y1dpQWpE?=
 =?utf-8?B?THVXWDA0Vmk5Q1BiRFJVSGdCTUZUSEN3M2M5VU1rTXFRQWFieWE2dGJmQk9N?=
 =?utf-8?B?eEV4Ti9vVVUwV0VjVjJzNGtJb1NsVFdpaTFGTDlpeXJDcEZvWE55aGRGcGd6?=
 =?utf-8?B?TzZYeWhJRmZFNGpUQ0prMjhQdk9ST1FZS1p3LzRFd1AveDRnZE9Pby91K2Ro?=
 =?utf-8?B?cE9XOGVEWGRSZE5uRlBHTzBPTFFHemkvT2djSVFKT3J3cEQyZU4zSFVFWlNY?=
 =?utf-8?B?NGVhMWdnOEJ4dzJSQmZ4TUpieVBuVE9uaDE3VTZyc1BPVVFpYlJYQXZSUTJq?=
 =?utf-8?B?UXBnemR1dnd6Yk9MSmdOcHVIUFRTbnNxaXB5dUxURXZMbVlXb29MNW5RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7426.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0RtRGJjZHFwcEZFcm9PS0R2YSsvaHpHZTVKaExkMC9odTF2MUFZeXlvUTg2?=
 =?utf-8?B?SWdtaDdhWmlGTllraktZamFpWjc0bmJGQTQ2eTdWTnpnNzdOM1RiY2xBV3E1?=
 =?utf-8?B?KzRuNFN5WjIyZ0lvcUxEWjRzbUdDWkVOMWFrL1NHZGZTeDJoSTVwZ3VDOU5n?=
 =?utf-8?B?WkYxRWxFQ21lY0lLenBReUtqa2N2WkE1djB1OVNKaWZBRzV3eXRndjE5M2dR?=
 =?utf-8?B?aGlZaFdzeWQxUW81MkxONnBuMEdzU2NrV3BqUmRxbEpoUmU1ZHFxcWRHODky?=
 =?utf-8?B?WUlPVExDK0hQQVFweXc4RURXbE9DVzVtZUxwYTl5SHR3c2dnQXY4Vnd1Nk9s?=
 =?utf-8?B?QWtwUVoyb0EzbHdiQWNVWCs1UGxnMEQ5U1hrUExZVWNxZ0ZzMlpMVGNQYWhK?=
 =?utf-8?B?ODBoUlg2MzlYTWJJZFZmY3pyNFRablcybTNUdTlrT09LUnVneUN0azZVQXlU?=
 =?utf-8?B?UDZ0NHcrNXF6eEMvYVZlRVFiS1g2c3ltaUszeW56OFlockc4Z0k2Zkplays3?=
 =?utf-8?B?dnBXQ3puL3lBZ1pQVE5YZWlWSHNmM2E0NDNqS3FpSEJwYU9EdVAyTWgrS1hx?=
 =?utf-8?B?UHBmU0puMHZLWUVRRFpzQ1lBajdUOTg0eDJBTW5LWkdYRmtpTENsUFczMXNJ?=
 =?utf-8?B?RnJoNXNTdVNwQnFEVmhVKzcyTWczK0U2RUxrbWxGbHRmc0MvOWpNczRLb3I0?=
 =?utf-8?B?R0dmbjNXSVVkYUszcmVZUHkrcWdsZ1hnemtDY2J0YlUwUUJGdU5WNE5LeWdn?=
 =?utf-8?B?MFRYdnpRVFU4eDZON0xHODQvUFpOVnZ3QWsxa0VnMHVJaUo5MWJubndjS3dG?=
 =?utf-8?B?YitFNTZ5VG9iWm5wVHZoS2srNU96N3dTQ0RtdXg1cXNpV0FvWHpRalFkc2th?=
 =?utf-8?B?Yzd5UFB2T242T2VzNU1NYzhYZmZPM3VEbC9KcDlqS3FqbjlwdWtNb2Y3MGRt?=
 =?utf-8?B?MW9vazRMNy9vNnBNbmJQQTMyWEVGUTdMUzkzRFNSYmtuUGlrVTltelVFSFhI?=
 =?utf-8?B?S2gzWGpEaXU2S05LMjZZUHBOcmNEMjd3VTZJM0k5VjI2cXhIYUltV3ROV1E0?=
 =?utf-8?B?MytPZUxQYUdzRVIwUnlEVU9COXVYRG1KckY5SlhpVlcydXpCR1AvVkhXSThU?=
 =?utf-8?B?SXFoRjZrckp1amtVdWZRS3F5cEo3TGxVa1VMU1M0QlFqU0JEditrbHFrUlpj?=
 =?utf-8?B?MFlXK0F2RlRPQXFqZU1CdU5rb2x0MWZFK3ViTEs5NWtxMUtRRGtFUFVic2lZ?=
 =?utf-8?B?RisxUnFYWVFmUUJva2t1Qlo0NUJUZktERzdUYzBUOVBqQTduTmtoYjZlbkRG?=
 =?utf-8?B?VTJVTnZZMTh6Z3ZjODcrWDFJN1FiNmxMdUJLbm1vV2JyRkZRWVBIYm5wRWdz?=
 =?utf-8?B?UDNLak9SRnplbExObVZlREJrYnZPblpQZjlqSDNFNHhJVVE0bGhIQkQ2K1gx?=
 =?utf-8?B?anBzZmE0RmNWM21FV3ZJUkcrY044VEVxUENITjdWcE5oSVB6ZWtnczJaT1hX?=
 =?utf-8?B?VzFuNm0wSEdmWUlyN0NKTEJzbGl3OWkrYzF1ZnVPU1hib2FWRDBOMFlGK3hW?=
 =?utf-8?B?MTFTcXFjQ3RWZWRxcHlCSXlWOFVVTTRPdzl0aTRmUnZHeDRQazVLRGFzclBz?=
 =?utf-8?B?RTRUM0JBT2VldS9lcktxbERPUzBCS2V1aTFWQWxDUW02TzBKYlZ6UytORVJq?=
 =?utf-8?B?dFRtU1VGcVpZVDI0cTllL096cjE0alFpaE5hL3krZXQvZGFKOVVGSE84WjdM?=
 =?utf-8?B?Q0FxdURtaC81ZXRPNitrQkluOTBsdXMzMHVONmtFR29jUHNrMG1zMG41Ynl5?=
 =?utf-8?B?Q3dhN1JmaEluUS9za1B6Um55eEdtd2RhUTZYTWFtL0lSSXo3RXVXVDY5Yzlt?=
 =?utf-8?B?a3c1ZlJiNHE5dHd4TTNMdk55Wnk0bWVJZFVBZVQvd3RCbGpaUzcrR3BaNC90?=
 =?utf-8?B?T1h5QzBnQ1pFY0VEL0IzVitMc2puK1NITi9CdWV0b1krNWY5QTEwUEFDRHRl?=
 =?utf-8?B?Ym9rQ1kwejBPYjFuVlRFQm53cFF6SzIzdUF2b0xybzFZNzk2Vk9jTHB2QjAr?=
 =?utf-8?B?Rkt5SVBDa0R4S1B3d1N6OHo0SHpDV0dXRFUvbXJKZ0orWVhMNm9WNzRTUjVn?=
 =?utf-8?Q?I4NawtCGOklxrit0po2KvZo3T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82702143-86ec-4c46-cc3f-08dc8153467e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7426.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 09:23:04.8070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /E0ivVhp55GGOtqUgG31eaoz96FwdENo9Q/nuZ39fQliQIudnOV7Yg5KaYyB969Vh5U/pj+IkJV7aVvJauQk7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849


On 5/24/2024 6:09 PM, Ashish Mhetre wrote:
>
> On 5/23/2024 7:11 PM, Robin Murphy wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 23/05/2024 4:19 am, Ashish Mhetre wrote:
>>> The current __arm_lpae_unmap() function calls dma_sync() on individual
>>> PTEs after clearing them. By updating the __arm_lpae_unmap() to call
>>> dma_sync() once for all cleared PTEs, the overall performance can be
>>> improved 25% for large buffer sizes.
>>> Below is detailed analysis of average unmap latency(in us) with and
>>> without this optimization obtained by running dma_map_benchmark for
>>> different buffer sizes.
>>>
>>> Size  Time W/O        Time With       % Improvement
>>>       Optimization    Optimization
>>>       (us)            (us)
>>>
>>> 4KB   3.0             3.1             -3.33
>>> 1MB   250.3           187.9           24.93
>>
>> This seems highly suspect - the smallest possible block size is 2MB so a
>> 1MB unmap should not be affected by this path at all.
>>
> It will be unmapped at 4KB block size, right? The 'size' passed to
> __arm_lpae_unmap will be 4KB and 'pgcount' will be 256 for 1MB
> buffer from iommu_pgsize() unless the IOVA and phys address met
> conditions for next bigger size i.e., 2MB.
>>> 2MB   493.7           368.7 25.32
>>> 4MB   974.7           723.4           25.78
>>
>> I'm guessing this is on Tegra with the workaround to force everything to
>> PAGE_SIZE? In the normal case a 2MB unmap should be nominally *faster*
>> than 4KB, since it would also be a single PTE, but with one fewer level
>> of table to walk to reach it. The 25% figure is rather misleading if
>> it's only a mitigation of an existing erratum workaround, and the actual
>> impact on the majority of non-broken systems is unmeasured.
>>
> Yes, I forgot about the workaround we have and agree that without the
> workaround, 2MB unmap will be faster without this optimization. But
> for any size between 4KB and 2MB, this optimization would help in
> improving the unmap latencies. To verify that, I reverted the workaround
> and again got unmap latencies using dma_map_benchmark which are as
> mentioned below. We can see an improvement around 20% to 25%:
>
> Size          Time WO Opt(us)     Time With Opt(us)       % improvement
> 4KB          3                                  3.1                 -3.33
> 64KB        18.6                            15 19.36
> 128KB      35.2                            27.7            21.31
> 256KB      67.6                            52.6            22.19
> 512KB      128.4                          97.7           23.91
> 1MB         249.9                          188.1           24.72
> 2MB         67.4                             67.5 -0.15
> 4MB         121.3                          121.2           0.08
>
>> (As an aside, I think that workaround itself is a bit broken, since at
>> least on Tegra234 with Cortex-A78, PAGE_SIZE could be 16KB which MMU-500
>> doesn't support.)
>>
> Yes, that's true. For 16KB PAGE_SIZE, we need to fall back to 4KB 
> pgsize_bitmap.
>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>> ---
>>>   drivers/iommu/io-pgtable-arm.c | 34 
>>> +++++++++++++++++++++++++---------
>>>   1 file changed, 25 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>>> b/drivers/iommu/io-pgtable-arm.c
>>> index 3d23b924cec1..94094b711cba 100644
>>> --- a/drivers/iommu/io-pgtable-arm.c
>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>> @@ -256,13 +256,15 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte 
>>> *ptep, int num_entries,
>>>                                  sizeof(*ptep) * num_entries, 
>>> DMA_TO_DEVICE);
>>>   }
>>>
>>> -static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct 
>>> io_pgtable_cfg *cfg)
>>> +static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct 
>>> io_pgtable_cfg *cfg, int num_entries)
>>>   {
>>> +     int i;
>>>
>>> -     *ptep = 0;
>>> +     for (i = 0; i < num_entries; i++)
>>> +             ptep[i] = 0;
>>>
>>>       if (!cfg->coherent_walk)
>>> -             __arm_lpae_sync_pte(ptep, 1, cfg);
>>> +             __arm_lpae_sync_pte(ptep, num_entries, cfg);
>>>   }
>>>
>>>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>> @@ -633,13 +635,25 @@ static size_t __arm_lpae_unmap(struct 
>>> arm_lpae_io_pgtable *data,
>>>       if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
>>>               max_entries = ARM_LPAE_PTES_PER_TABLE(data) - 
>>> unmap_idx_start;
>>>               num_entries = min_t(int, pgcount, max_entries);
>>> -
>>> -             while (i < num_entries) {
>>> -                     pte = READ_ONCE(*ptep);
>>> +             arm_lpae_iopte *pte_flush;
>>> +             int j = 0;
>>> +
>>> +             pte_flush = kvcalloc(num_entries, sizeof(*pte_flush), 
>>> GFP_ATOMIC);
>>
>> kvmalloc() with GFP_ATOMIC isn't valid. However, I'm not sure if there
>> isn't a more fundamental problem here - Rob, Boris; was it just the map
>> path, or would any allocation on unmap risk the GPU reclaim deadlock
>> thing as well?
>>
> I am using kvmalloc() here to create an array which is used to store PTEs
> that are going to be flushed after clearing. If we don't store them then
> those will be lost once cleared and we won't be able to flush them.
> I tried using GFP_KERNEL instead of GFP_ATOMIC but then I am getting
> warning from might_sleep().
> Is there any other alternative way we can use here to store the PTEs?
>> Thanks,
>> Robin.
>>
>>> +             if (pte_flush) {
>>> +                     for (j = 0; j < num_entries; j++) {
>>> +                             pte_flush[j] = READ_ONCE(ptep[j]);
>>> +                             if (WARN_ON(!pte_flush[j]))
>>> +                                     break;
>>> +                     }
>>> +                     __arm_lpae_clear_pte(ptep, &iop->cfg, j);
>>> +             }
>>> +             while (i < (pte_flush ? j : num_entries)) {
>>> +                     pte = pte_flush ? pte_flush[i] : 
>>> READ_ONCE(*ptep);
>>>                       if (WARN_ON(!pte))
>>>                               break;
>>>
>>> -                     __arm_lpae_clear_pte(ptep, &iop->cfg);
>>> +                     if (!pte_flush)
>>> +                             __arm_lpae_clear_pte(ptep, &iop->cfg, 1);
>>>
>>>                       if (!iopte_leaf(pte, lvl, iop->fmt)) {
>>>                               /* Also flush any partial walks */
>>> @@ -649,10 +663,12 @@ static size_t __arm_lpae_unmap(struct 
>>> arm_lpae_io_pgtable *data,
>>>                       } else if (!iommu_iotlb_gather_queued(gather)) {
>>>                               io_pgtable_tlb_add_page(iop, gather, 
>>> iova + i * size, size);
>>>                       }
>>> -
>>> -                     ptep++;
>>> +                     if (!pte_flush)
>>> +                             ptep++;
>>>                       i++;
>>>               }
>>> +             if (pte_flush)
>>> +                     kvfree(pte_flush);
>>>
>>>               return i * size;
>>>       } else if (iopte_leaf(pte, lvl, iop->fmt)) {
Hi all,

Can you please provide feedback on this patch? Is this optimization
worth pursuing?

Thanks,
Ashish Mhetre
