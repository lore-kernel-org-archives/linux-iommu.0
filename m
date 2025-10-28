Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F92D877E
	for <iommu@lists.linux.dev>; Tue, 28 Oct 2025 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642928; cv=fail; b=UvtXKGwIr5HsAyIdl2yKTZ9TpdGw4IOZqrTWBqAO0ke6qsYeJm+7IKaYDsBJr4PRi1jiB/Pa9FX13XOb0pue64eHdC5pQDRKHQ1E1p9wfSEuyjFWqRiV/mGUcae01O+bjfumpD2Kaug1rIQQA+BstTyJl33N1tFwnlP7+YuK7Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642928; c=relaxed/simple;
	bh=m+XlH74ewMR3JqkDAjX9NJWWpMPkulNkjQTgiGUSMkg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ua8olZK02/UVJKnPcEFecxSRt6uwrJnyEji72lXVTx0Qblls0h0lQZWGexKLzW4miwD2Hdx/7jKqhoMalZdRjASw/pwLbh39hxwMzN3bHK9XceXLU8HQ7F8ZegXCLxShtntdttr+b+kvNL8PO6E1Bs7nbw47MVZ7bEARMkQKtMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QdVsNQTr; arc=fail smtp.client-ip=52.101.61.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QdVsNQTr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mD6Gu3H2lIHHVovJfMqpynSKA+O1JhqDHKBfJCubSbcp+5p4KhBZP1Vz3c1GHCyhyCyXGVO7xosMPqjJN92Qgbt5nyjN5DZfcS8fLAPAYaDsE0bttwsXnHCmmHe8bNUDJsZi93z0dtT/xL6ON+qKXARGNqhQZJIjcbR/dN9qdwI6EBmEF8CvXBaC+7AU/2IcbH+/RZovF0fCJ3WyqlB7ZNJlKDMdRxyRPucFmjfjOCPL9eqqGXJSJCVTyMQIUQ1g5+Qa3gI/mnmLCAOdlBVF2/P/cdsvhcfN6Iaag8afpEGtOShNOXOLcUT/N1wTKc0TBPlHrKSYxGU6OayatZxQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiErT7lWv9O1aIG8635JxQyDFbYJhbyU7JEptIcFMB0=;
 b=P3/1tiB4FNL0GCkU0zK/SIJ5BIkY6kOi8J6IkHZVDvv06ok7XrxblBfwSbcARv5Ll7aSnhASsWJwWYhPYHLJ+sY7wnSPo2oB0SAoPRcog/WxUp77hKgfJmJeuk3BfrHl0vk5UL15DR7fOD8KD1tL2EJ87I0XQmGfOJ1HXa/dVSd7UiT+m4XtnAeJqFZ/29Ziau16yN6jwbjnJq71qw0bvfPr5cq8+PR37aYq80WGtlM0bYDxPKJlQI72lfN6qZPflDkdjIv2uOPUrTKxIjzrzQmavkP0IyV/67ECgBe3Dy36b8OXJW+WPsrm1cRfaiTRBkzXCAvKELROioXCICplCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiErT7lWv9O1aIG8635JxQyDFbYJhbyU7JEptIcFMB0=;
 b=QdVsNQTrGgRGraQTAk23AAwiX9iX4bwXErmy8bi3rDfikNX6XHQ9g+b5EKSozsZLtmn8yN3DAahjWen4NjR6VEWd1CSXVe69UTSlnAZ/jhdTtEKIFhAPeXgh3eLzq2Fqzmqi1P3HLI4HFpG3poX8FnIZDZ+J50XrkzjeX6+g56o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 09:15:24 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 09:15:24 +0000
Message-ID: <01c81b5e-d6a3-41fa-9758-37661e115483@amd.com>
Date: Tue, 28 Oct 2025 14:45:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Enhance "Completion-wait Time-out" error
 message
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com,
 Santosh.Shukla@amd.com
References: <20251016150809.5465-1-dheerajkumar.srivastava@amd.com>
 <tgugv7ebuxtnp6ou5jnt7od7jmccsipblqityiinhkgratosu6@bxsr73hpiiny>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <tgugv7ebuxtnp6ou5jnt7od7jmccsipblqityiinhkgratosu6@bxsr73hpiiny>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: 766bfd74-b87c-43fa-6d1f-08de1602869c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SktjY1BIYUpsREFYck8zNmtmNkhhelNiTDBJc0xNakl1V1hZVTRCRGp2V2Fv?=
 =?utf-8?B?Zzd3U1lMMDVwN1RqZ2RtM3o0aHZJNkJsdVhaWFYxR1lwdzVGVDZCRnZOeC9Y?=
 =?utf-8?B?RGxTRVFpaU1nZkFaMlU4VXNEYkNTMG1mYVZhdVN0V3JFZ3dKZ3I2djlVaUMx?=
 =?utf-8?B?bW91cDUybWk2ZExiMzhYUHBYS1pQeHBrbExXbmpEK2lDUUh4em85YXNtVkpQ?=
 =?utf-8?B?eklXdS95UCtRdU5hS0dBczRBZ3FoWE8xK1VJSlpRcndPVC9vbjJZOFQ3dXdw?=
 =?utf-8?B?SkJ0Sm9BTkpFeU13bFRCekJqT24yb25pRlUxM2tEVEZ0dHQ2ck44WFlSN1VN?=
 =?utf-8?B?MHVDdTBLbEZhRWZ3RVJZNEJBbHpOd3A2dWxDSVVtT1RPSEJldVc1aEpHT3lY?=
 =?utf-8?B?QjNUVlVydlZFaFErMGk5N1BJK241WkZRK2FBcGsvQ3lWbURRbC8rVTVMeFRp?=
 =?utf-8?B?TWVLaDhIV21HY0ZLOXRyQWZSZGNpNXZNMlJWVDNhQjdOUzdDcld4a0l1anlF?=
 =?utf-8?B?QnIwOUU1TS9FdG1mdG1URkxvVkJEdjdoQkJWUVhBaVQ1azZqdzBVQ2ZHWCtI?=
 =?utf-8?B?bGZVLzBLWVZHazNPYUFOSy9GTmpmcitNYVg1a1JVcFJ4QjhTbW1CSVNhTHpy?=
 =?utf-8?B?VlR0NUI4RHJDNUFvOStDcWNqQ1BlVXgrMk1USkxkcVg3SjdhMFNrMUUzMzc5?=
 =?utf-8?B?TGZqYyt3SEdlbTNQM2UzanZkNFNHWU1SMFF1ZXI4ZUhhL01qOVpyTTJZamNq?=
 =?utf-8?B?Nkx6WVg5QllQNWN0U1BpUHltRjdta3ZKbVVXb0VydVlWMHY4Ykk4Y1FRZFlG?=
 =?utf-8?B?SFdUUHZVdUZIVGhSZWVyOG40S1JOMGc4eDR6UkVacjhTYmVnUjdveWpEQ2tX?=
 =?utf-8?B?S2FBNXk1ckN5TCtBUUlwNGZURGh5cWlQeGV4dzlCRVBoUjlFaW9rSGxxTWJ3?=
 =?utf-8?B?emRCVnFyTVdJeURpSzJ3VS9XaW9SMzlXQit4aU45V3Eza1EwMGJmeVM3UXJu?=
 =?utf-8?B?VVI3UVJYVjFBL3B4SHlDTzZJc3djRmZnOUN5aHZQbHhxK2lER0Roc01vZ0FB?=
 =?utf-8?B?NUZ4ZjUzQnY5SC9YMk9KR1JhcG1jVGhwYlo5YWxqb1VxODZCcWxraENUNEhP?=
 =?utf-8?B?NzQzYW1MZWQ2WCthR3ZaU3hTOG9PcC9lTDFNQzhaZ0NQY0laSytabGpJZm9G?=
 =?utf-8?B?VUl5d1NqS2xjQlZ2S0xycmVwc2NCQ1habzdRbExtcGRyelFFTy8xSnpWVE11?=
 =?utf-8?B?bERyblNOcDBaemhUVjhHcVlQVTdWK1llNW16WkcxZmw0aW14TUVCcTlVY3Ar?=
 =?utf-8?B?aUlVTStXR2ZGWWkwbmN5dXZmRThNYWs4d0M0SHZMbTF0ZHYxVUVjSmZVYnEx?=
 =?utf-8?B?ckJMQ3RGS1BndnlJU3d6cFBjSDJVYTJ0ZHNEdEhFbnA0VEFSZXZWK3VVeksv?=
 =?utf-8?B?Mk9VRHliY3BCK0M1Y2ozT1Q2ajR5aEFuN3lPZU1uN2Z5RE9talVSbU1pdTZy?=
 =?utf-8?B?WFIvWXJQMmxqaGJwS2s0TEdrWXZsSzVmSTRzMm9IQVdvYVNSbHRidDBNem1Y?=
 =?utf-8?B?NTBlRkErTmFuV1VHY0UzL0tvM09aZC9rN0EwZE0xa0RpQUNBV013WXYwbXhi?=
 =?utf-8?B?Wi94ak9zQzlNaDc3MThEZzVLYjdOSWRqR2lsWHh2SUphVmFsMGY3YzVyOVBM?=
 =?utf-8?B?N0hiMmZHZm5aSE00ZXhrQzk3WGRVVStKTjNJeXFFUDg5SUh6RS9uTlpmVDFD?=
 =?utf-8?B?VlJGZTRKaGc5RVlnMEo5U3FTNFBWbVJxQVl4YUpZaU1KNEFyajNsVUEzZmtZ?=
 =?utf-8?B?VDdRR0JwYlpld2dWNXJUVGRDOVhQTjRSWEk4SVNpM1NucStENmh5djQzTlhZ?=
 =?utf-8?B?eFhNejV3ZEdINnczTUgvazNtWXNxSmllT013bTFDc3ZUbERRa1BUeG8yTXRa?=
 =?utf-8?Q?Ctb+JsMf2oYCSVXP95kVjV42SwVc8ezp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEdwTlVXR1lTQVBZekZGUUxSY2w4MURSbnlaNENsM1JybndRT3hvMC9TaTZ6?=
 =?utf-8?B?eDI4cjk2OUUycjE3ekI1UXhGZXptbDE0NmhwTWVmWC9CL2lXblc2RUwrYXFR?=
 =?utf-8?B?QTFrWlFtZGRtUHFzY2xveTh6TnVDWTU0TVdIOW50Mkh5V3Q1bTZSNFRKdFAx?=
 =?utf-8?B?VStxQlJab3hMYlRvVVk0Z0hZblNETXdtSGZlYTBjaGl1KzNMc3FVSUgzRlBZ?=
 =?utf-8?B?UGZrR1JWOVlBUTl6Rmg1dXdwVEt2NUlpNE5Jc1lRS00zbE5oeGJEMzBhVk5F?=
 =?utf-8?B?WEVrcnlSL3lTQU56Nmdmb2hybWZjTDU3c3I5ZFhkRzhWWktrTzhFcitvR3ZF?=
 =?utf-8?B?bnFNOUFYZHhHZnBoMXl5eFpLVXppZjd0VGNiUUdYd2NKME5uRlMyZ2h6OEZZ?=
 =?utf-8?B?VitNSklPV3V5NkRZOFpGTFl3WjdYTjJFVWNZL3ZKdlFIbU9Ha1AzZ3kzajli?=
 =?utf-8?B?akt2VEhuUHNEbHVHVStzeHAxa3EyNWI0M04yMENXR0owWDV6cEhJclc2bEpE?=
 =?utf-8?B?cFdjeXVsOFZKeGNzTVo1cUtxNWJ3UmRXVGhQbVo2bWpPd1lOSG1rQUxVT1lo?=
 =?utf-8?B?akxEL3FpUzhyRmlqQTlkalhRcEx6MGRaenJoSkZvUkJhTTltWUo1T2cwbDNK?=
 =?utf-8?B?a2lBMkpjWTBtdzNIRmEvdG1BZHZTSHlvZkxMWnQ3enBaZjRJcmk0bFI5dlE0?=
 =?utf-8?B?c0NoU1p2bVNuV0s4SFdMNFBnK3pINmxtV3M1NTduK0FkSWlreFZOUHAyMzRJ?=
 =?utf-8?B?MUpvOSt2c01Sd3kyRStXeFEzWitoMWl2amRXb1hiV243cTN4MTZuZDBGaVJ6?=
 =?utf-8?B?Z2NoaDlPTHdDQU5WYlBOQzJTT0kxUEpKbldXdjRGL2tSMnFWWHh0bDBPWWtO?=
 =?utf-8?B?VzZCMTNaNWV0dlhVSDk3YmJYeHRFdVNvb01FMzB4ckZBY2J4MEJmSjB3cHZN?=
 =?utf-8?B?L3hYMnFnTlI5OFNqdlZ6SjVZN1haS0hiZTdibloycXlLa1ZuNmc5eWl6eXVU?=
 =?utf-8?B?c2lSaVZoQXA0YUszWkJZWUNkYjdOZzJuRkQ1T3l3MGhPbnFzSGUrTGIzdEp3?=
 =?utf-8?B?QnBRMzVXK3d6eDNLTklFQmV6MjhzSHVvMEtFbmR3ZFRDQUdEdFo0VFFEem5R?=
 =?utf-8?B?R0g4cW1Wc3RJL0ZqZVE3ZXRQTjFVQmtHMldWdWluR3J2ZVBNS0pROHZ5LzU3?=
 =?utf-8?B?MERGVGR0SmhxV3FLMDIycERMNlhGS2FyZVdyTDZMbm1DZ1ZhZnladVVhaEZy?=
 =?utf-8?B?UmZvSVBacE1OY2FKNVdIRGJKamM3bHFTbEJmK1RsQ1ovM2UyUSs3Ky9DTklx?=
 =?utf-8?B?UkxkNFNYZy9oRWd6VmU4eUZ0UkNZVGl3bkVpTWFPRURoVHlIUXY1OVFRMDAy?=
 =?utf-8?B?dmFWZUFlL0ZXVk5UWVJROWZIWTd2UGtkcDlJeGRZbXZwd2R3WWtXRXNCOWtC?=
 =?utf-8?B?L2ovcFI0aExiRkFUdEVDOG5aMXFJQkNraUNZY3MyY0ZyQzEyWk1LQmgyUmhN?=
 =?utf-8?B?elkwUVNybDhtcDBtSld2MWVyZmk0NXZvM1JmZHg4bDhPZG4zS3R1WC9Md25k?=
 =?utf-8?B?NVhwaVQyUFVUdXB5V0dlTmNIdE5ZNGpEaFYwY2FXbHFYSnFhRzluNFZ2c3Jn?=
 =?utf-8?B?M1NOZjdXYTRFNStKRXF2VEFhUXI1L2plNElhaktkamthcUgyeURQc2lhWVBy?=
 =?utf-8?B?ZWMwbWNWc1Q2Q0pSUUpIUkJaMGE4dm5WUXZDbUxqTTVEa0xuT1B2RTVtOXBH?=
 =?utf-8?B?SU9pQWE0ZVROb05zY1RVbmtXUmYzOVRUb3pyak1BVCt1aStrc2pBQUdiNlcv?=
 =?utf-8?B?TU5ETXBQWEV6OWVnaFB0SUdBb0FMV2pyVCsyV0dXQm9YRk4yWnpzU1ZmcXo1?=
 =?utf-8?B?SzNzYng2TGNoNHNhVG5zVXhzSFZyU2duRFJRTDhhVWhkcmZuZ3JUekNKdU1H?=
 =?utf-8?B?QTVEY3NmOWdVOHI1RlBFNXdXN0lTVXY2Zldtc0lva3VJWmZsUW80MVg1RmRv?=
 =?utf-8?B?cldTOVZmOWNzejJrYklVMjZHU1dUWTF1NWFQRE11ck9pdmtUSW5CRHdFb29M?=
 =?utf-8?B?S0ExV2ZxQXBDSktNVGN2MUFUTzFQZG1HUUxVY1hqN1JkUVAzMHZIVXdnY0VS?=
 =?utf-8?Q?iHfuhQkkhAWeF8y5fKhqZglbu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766bfd74-b87c-43fa-6d1f-08de1602869c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:15:24.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgeAOuKuVqeuyWmtu/vpi+bi13SA89ttyDAiQBTlA7xx14bEcctAvri6ph8Nq/WEHmD8qbRtUPUVdy7YuTdzUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324

Joerg,


On 10/27/2025 6:19 PM, Jörg Rödel wrote:
> Hey Dheeraj,
> 
> On Thu, Oct 16, 2025 at 08:38:09PM +0530, Dheeraj Kumar Srivastava wrote:
>>  static int wait_on_sem(struct amd_iommu *iommu, u64 data)
>>  {
>> -	int i = 0;
>> +	struct iommu_cmd *cmd;
>> +	int i = 0, j;
>>  
>>  	while (*iommu->cmd_sem != data && i < LOOP_TIMEOUT) {
>>  		udelay(1);
>> @@ -1166,7 +1167,33 @@ static int wait_on_sem(struct amd_iommu *iommu, u64 data)
>>  	}
>>  
>>  	if (i == LOOP_TIMEOUT) {
>> -		pr_alert("Completion-Wait loop timed out\n");
>> +		int head, tail;
>> +
>> +		head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
>> +		tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
>> +
>> +		pr_alert("IOMMU %04x:%02x:%02x.%01x: Completion-Wait loop timed out\n",
>> +			 iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
>> +			 PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));
> 
> Better use dev_err(&amd_iommu->dev->dev, ...) here.
> 
>> +		if (!amd_iommu_dump) {
>> +			/*
>> +			 * On command buffer completion timeout, step back by 2 commands
>> +			 * to locate the actual command that is causing the issue.
>> +			 */
>> +			tail = (MMIO_CMD_BUFFER_TAIL(tail) - 2) & (CMD_BUFFER_ENTRIES - 1);
>> +			cmd = (struct iommu_cmd *)(iommu->cmd_buf + tail * sizeof(*cmd));
>> +			dump_command(iommu_virt_to_phys(cmd));
>> +		} else {
>> +			/* Dump entire command buffer along with head and tail indices */
>> +			pr_alert("CMD Buffer head=%d tail=%d\n", (int)(MMIO_CMD_BUFFER_HEAD(head)),
>> +				 (int)(MMIO_CMD_BUFFER_TAIL(tail)));
>> +			for (j = 0; j < CMD_BUFFER_ENTRIES; j++) {
>> +				cmd = (struct iommu_cmd *)(iommu->cmd_buf + j * sizeof(*cmd));
>> +				pr_err("%3d: %08x %08x %08x %08x\n", j, cmd->data[0], cmd->data[1],
>> +				       cmd->data[2], cmd->data[3]);
>> +			}
>> +		}
> 
> I don't think it makes much sense to just print the command before the failed
> completion wait. In case of a timeout and amd_iommu_dump == true, just dump the
> whole pending command buffer, from head to tail.

We have debugfs support to extract entire command buffer. Also many cases once
we hit completion wait timeout, buffer won't progress.. and we will hit
completion wait repetitively. Hence in V2 he has removed printing entire command
buffer.


Do you want to log entire buffer once to dmesg if amd_iommu_dump=1 ? (for first
completion wait timeout event).


-Vasant

