Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C799F25B69F
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622856; cv=fail; b=GiP4Meas0OL0CP8Babkz+q4TwP8bD1eIjAbn7eFMmoKCsshpKWZVmW6ngVCkJHgHLWJiwGdFvjvCHkbiaZYy3gSLbY1brheEPU7ZQniWjecExWeqLr2G1x1Dk5VAx8H6RneWY6mQOc9DsICnLGrLCf4+WiZjFXlD8Mnrxvx0wCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622856; c=relaxed/simple;
	bh=KGVdiXGx4EXhANH49W3V6gfvktLqfmQSfSj+jwPpzdU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fnRjWec6OGaZbTGBBNpKMMdgZBvD8j749oTNGZ5k+aQv86UvFMYZA38HqDnl2i+p+9Tq15qK5PYV5/cfDOGCn26gOy1uidfCYHXwe4Mb+V901UlWJyO7h+aC+LrSpVYTt1h94O4pyyGGOS5FZtmNIgyrOzmF2pODoJTn0EHqmj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J9b5Z/d3; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J9b5Z/d3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcfK0ONW7/D7SK1wRG6wOveEyS3v27CGH+dgy+BB4PbCqdQNTGmk9KnHZI6bs570TInNzLCS7RDPwdWDIGQZL1ML6OQwdmDK6qUdBNMNQbvQ6aygl67rQPQPaylLytnL6e1Dkpe6Zc3bMKSqPNy+ouiBqnrMGzl8hXLGIJuCQ4OsmjxeOAaZ9Iku3fm238INV31K6uCHNIwsI6KeY7pCuZFJOfeFLpVc+R0vIWXvEy1/vLck0EllLEp5rPnFZhRMVZl9J5xDzS9iZZDEUNAawMGPugIYoBXfuwYmFtF/zwpQUOBN5u7f2KCaB5BMflyo8tkCwOf4dW+GaMgIkmfMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKCnYAxczTMeBcfNL9gcRbLFUBpBLuU/+RqRTFAEElo=;
 b=JWGdag3FYhzEB+KXphagNZP3h5iwd/LgBN9+a/DS3K4k6qewcG1ZxBYjtTEJ95GUaHbhdNPCEZeOM7LibRcD9ur37tv/UORXncBWlG1Nj4sV6nJD6yGfWlXdspLnxytLTct7hfFugJc71N4nomUg/rbBjepXSsk6VMiFOsCDP9VWLMGBOlFjJ1gFgKPunKqK4DHcVr8EeVOVa31I39RUpnc1E9ljuGavXrcxzlXHxGAy5XpdAI/lW5CG2qCtIUBRCC0HS6VP8Y2+NyusO1vNCDY0R1uPbhS8/C3J50d4mV43rZOb/R/GC/KZB0vKhDyCIJI7ln6FhW6AFbKKC+zieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKCnYAxczTMeBcfNL9gcRbLFUBpBLuU/+RqRTFAEElo=;
 b=J9b5Z/d3JcL7DFQYsZXU09FlPEq4ACGvukkmaS5eF04TJ9zntsL/o6WVaPhiVKiFpLgq2GFpQmajHUaTFjr5fI4CN8iqTaOWfUOLF7FSeCgfZl75mHE+QfhqPoZQ+VuXczz7u7aTDOGcGeyhHjv/SNjT8UqdIh0JJJidwJ1njNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Sat, 8 Nov
 2025 17:27:32 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 17:27:32 +0000
Message-ID: <5c3c9071-789c-405a-962c-e4ef79832e6e@amd.com>
Date: Sat, 8 Nov 2025 22:57:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/16] iommu/amd: Make amd_iommu_update_dte256()
 non-static
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, jgg@nvidia.com,
 nicolinc@nvidia.com
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
 joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 iommu@lists.linux.dev, santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
 jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
 wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-6-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251021014324.5837-6-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::26) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc1c09d-13f6-4a09-64a4-08de1eec1916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnJNNFVnUmc1QU5yR28xaG02VmdzQlgxOFEzWGVmVWtyckg0WktFWlR2NFha?=
 =?utf-8?B?TDZCMjVDd09rNzJvSjNOUndNL0VnSWdiT2J4VzkrQVBJZ3YvdjE2ZE1UZTFP?=
 =?utf-8?B?MGd1Vk8wVGlNNzFwVmh5ZGJyUDZuZmJseWc3bTN0L3djUjU0a3VDcVBlQ3dH?=
 =?utf-8?B?OTgremZZcnFFY3hwejBES25XMTlFWTdXM2Z3di9lczVDb1JqZ2UrMkxCQVZi?=
 =?utf-8?B?UjlFaEUvbXVWNzRFbU50Ym5WYnlOODNmL3k4SXlIT3gzeTJFWFI2cktiR3Yr?=
 =?utf-8?B?ak1mTHY2N0VOK1JGV2M5UEwyVWlURXZlQUREQ2pYd1lGTXU5SUR5N2ZlT0hM?=
 =?utf-8?B?UXM0aEdMdVpIQ0MxZkVDbVFTaXN3MUNMMUJzKy83Q05rUjZBcjJQdkZrR2VT?=
 =?utf-8?B?Nm9UWkVSN0xyRVNwcnFNVk05YjdaSEpjSzZEL3JwOTAwTUNzYXExVHpSK2dM?=
 =?utf-8?B?dE1KQTZoTWdaYkNSaTN1T0E5UE9tRkpKcVByVFRhK1BsOG14dEtsTm5IRitQ?=
 =?utf-8?B?eVNxS2JnSVpMR3Zzalc5N3hvZDZENkZPMTB1bHI1UElxcE9Xd283aUh1QnAz?=
 =?utf-8?B?M3A0THpGVFBFbjUxMUp0OVFveGZVYW13ejNsWkZDRUlsdlY4a1JFd0JHMlFh?=
 =?utf-8?B?TkpQNTg2WWcxK01Tb0hLTC90dUYybHVTempBK1BKQi92MEZWS242em10TFZ5?=
 =?utf-8?B?WGx0U3NoaG9SMmNZSkYwOU8ram1pZjdEZ2hoUmJtT1VlQXpUTmE2N0RrTjJz?=
 =?utf-8?B?YlM4VHVrcWdXclFtYW02Q3FGMVl6VWlZRTc0bnphbWlKL3BHSXJrN295ZkYy?=
 =?utf-8?B?TVQyUjlXNytKUGxWZUlmV0xWWEJZbS9QTXE4RENQUldjSktOVWhCS2laNGIz?=
 =?utf-8?B?cEl2T2xwLzMwNEpaWVhJQU9UZ1NPbVkxUURUY1dSclJhUTl6anFEUGhOZDcy?=
 =?utf-8?B?QXhTWXJFMW5NdGh1NlhxZ3JvOWV3OCt4bXBkOTNQdkVNSURYWnZlKzJrSnVr?=
 =?utf-8?B?Y3g0UHpqUVRNcTd2VDVmWVVYSGNkMjhMSDVvbEtQWFpvUjJWVlQ5ZXd4QTRX?=
 =?utf-8?B?bEFYcHk0enN0R1lRNlg4cWRETEU1c3JYL2xKd1l6Z1M2ZS83djhMalhFSGty?=
 =?utf-8?B?cVpWcnREcUIxMDMwN2VZTVlSTmF6dXNIK3EzdFFNemZBRThrdmh5Q2JEaWsz?=
 =?utf-8?B?UTFHKzhEQ2QzdVEzdm9tWjRpaDAxN2J4a1JUbXFNdmg5Ymh1cjBmMFNDNjdq?=
 =?utf-8?B?UnRpSFZ3WXJyK2wxS2tpZ3Z6MXNvVHVFNXdPOEtYZHZZRVE1N0NGc0tqQmVS?=
 =?utf-8?B?YWpKT2tGTUg4eXNaVCsrTFRELzVYbERNekxRd0FGcWNhTHNnWnBlRStTMjZh?=
 =?utf-8?B?dkdWdENtbEVRVlZ6dGdjVi9zdjRSckJ5T2h6Q1FkQUtSRW13WnBjbng5SXpX?=
 =?utf-8?B?YVgvRm5tbk5BZmZpV2xJV1FoTmVHcENSTVJxYVNxUU10V29vN0dPZHVyMlV6?=
 =?utf-8?B?ejRlZXo2ZkluNXZHWTFhd1JNdVpNMGJQOFQ4T0l6SkxHV3V3bWNDdGJ6MGN4?=
 =?utf-8?B?VVJRcC9JNW1ITE9LR0Ezb3JEZllKbXhmbnloK01pOFhsdCtwc3NPOGJqNng0?=
 =?utf-8?B?M3NrdlF6M0JzRUMramszb0dNbThkTU5GWnExOEpFOTIrblkwaFNpbHNKaVpl?=
 =?utf-8?B?TTc3N0FzVU5oVGtGMGUwOVQycXI1eEJzaFI5QzFEUUZNRjZZbjdTUExJbWZr?=
 =?utf-8?B?NWMySEN3QnpGZ2QvdVQ3SGxEUndwV2hTTnlNV2RlemxNMGtWeHdyeUdTNUtK?=
 =?utf-8?B?em5xSVlmRXFoZGxjSzRrdlFhL2xpdkxxQjB3c253TFVhVmdTYmFUVDk5QTZY?=
 =?utf-8?B?ZFpWR0RmeXBXSVU0N1ZQMElkc0JpOHRsSm44L3ZMWlp4dkZPS0Y0ejZnNFZV?=
 =?utf-8?Q?rAG1ISDoHj45k5lAAvxVd1mvNs5wOhoI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MS9BWVhnVmMySlRqcmZBaFBDM3RMK01tY0xIZDg1MjcwMkNCa0hzbXBGYkVN?=
 =?utf-8?B?SU5KSk9mUFBxNkhpaFl3OUxLTi95Z2ZWUUxIQTVvdTRyUE9MTlZQT3RCNTlY?=
 =?utf-8?B?MklJMVFtSWoxWkpmYmpMbWkwWU5wcnF0Z0V6YSs0MHljaUhQWHpGb241bVNF?=
 =?utf-8?B?Vnl5cmJRUGRWbmRCNEpkSk9paDJ1WGRaRnphR2NTUlVtOFdZNjhmSmVZSzE4?=
 =?utf-8?B?QnVRUkRWT2k0bmRHSXpGcVVyMWsyTTkybmJ3MmNYZVBWMlZSTzlqMXB6WS8r?=
 =?utf-8?B?YmwrbktkdjlUendudmUxT2JwYmRCUUcrQXJaay91VTNqdDdkWGxWVzdXZjVE?=
 =?utf-8?B?QVIzSmZuNERvN1kvZnN1RUM5WEJKeld6Qks0aTNHczc1L2p4OSsvQ25NQ0ZZ?=
 =?utf-8?B?VWVoZm8vdzUwZHZsQ0VNUjRlbjhzRllZVmxQNStWWUdwL0VUTzZBUGRndThL?=
 =?utf-8?B?azl5dmtZT3NzUGZkZUZNWnpaNzlSWnBIK0ZDWFBESXdRclNjSHZWUjNhbzI1?=
 =?utf-8?B?d1NVOGFJTFhZelRxN3QzU1VjRXFwU0pyNHdkRUtKNTczWldDaDlmbXNnU3Fj?=
 =?utf-8?B?aWUyWnJpNDdxd2kwRk9SSmxFY1dROEh1cTdmbE1JQ01pNVRaaXVYMkZHeFJk?=
 =?utf-8?B?WmFzcUdjQ1Q4QmFoNjk3OGNCSUNxN2JOWDFvaVQ4dWsvTjE2dGVNQmVsVnJW?=
 =?utf-8?B?Tjk2dnptSkJFQ21OL0F4bGtlc1A3ZUV6VEZ4bGVkSjRmdE9ITlo5d2s0TzZa?=
 =?utf-8?B?VVUzUW5GSEpXTERxSDJGb053MnViSXVSUjJVaHdnNDduSDBtVG9SQzFVVlhn?=
 =?utf-8?B?WEZ6bm5QNE4vd20rU08wL2JFaGMxTWhQWDVEOW1EeVJVZElBLzZuUXlyVW5i?=
 =?utf-8?B?UGM4RVkxeUZKeXJvaHVwTkNmbFNQZmtTcm9YN3FmQ1k2TjM1bThNazB3S1BT?=
 =?utf-8?B?UWtvWW1iY2JnSDlNcjNRTkFuTTRoN1ZyaWZXcWdCNXpQdkZsMEJ0WitPUnZB?=
 =?utf-8?B?UkpYc2dXYlVET2NFci9DeHhWRGIxZk5NcW16SS90TWQ4Tnh0dlJyNVJTMENm?=
 =?utf-8?B?T1lnb09wZ013ZFY1dzVTQjNpSTFVT2dOZjRXbUNkNVd4QnR6N1JJdGxMaU9O?=
 =?utf-8?B?bXdvcmZZSWVldnZIdUZaMG1XSkxCTmtpdktLNExUNEVFckxPSWhUOW5iUGF5?=
 =?utf-8?B?eERwODhrOTZ1NUtuRGkzd0xRbS9wWk9yd0lLY2N0bG9GMXhSNUlwQWduRmFr?=
 =?utf-8?B?WTVLQSs2c0w3bkF0aGJ5YnZFSFp6cjJ4OGU4NFpxaU9xNnVWbmVkajFac01o?=
 =?utf-8?B?REw0ZmdydHFTV3RLbVRIMmN1MXR6VzlpNWRsZklKTmlBeVQ5TUhPdi9kdmxv?=
 =?utf-8?B?bHNzKzhNOC9VNndmRXg5SWc5YVBGNldnbmlta0FOSzFtay9tVmQ0S1JIYlh5?=
 =?utf-8?B?RkVwQXJvU2tHWjhML09rcGpJbGJ5eDNMb1lIUmVEZU5LOE1OWE5uS2NqWkZi?=
 =?utf-8?B?em9pUmdIc08ybUhNcmx3bkxtbHN2dHd6RXNrY1htOHg1ZHZsanY0cUh6YkdP?=
 =?utf-8?B?T1VpQ2QyUGR4WGhrK3FXalVWQUNqeE1Ob3hPMUtiM21lMkl5YWVVSHRPWFdH?=
 =?utf-8?B?clpCeGxJZGF6Ym9iSWhTMWV6NFNVNXUrdWZLVDZTcHJJbHc5cXBSbmYvbVdH?=
 =?utf-8?B?NkxxRUFtM0lCSmRrMEtza25lby9LbG1oTGU2bTU3ekVzaDNjSkhUNHYvTmIz?=
 =?utf-8?B?aXVvTDZpWlJFYUlidElaZkV0SmJ1OUdOb1VIcm5WR2htdTNLUlJCYVJTNmh2?=
 =?utf-8?B?eXhFQkNjeFVFZzdYSWY5bzljejkzR2JOcXl2WmhNVXN6UHVOVVFTYVB1K2pD?=
 =?utf-8?B?TUx4SXJ0NHdUc2pxS3ZQYmhMa1ZZSldEMlJSV1FXbk9XWnN4V2hDajlHZytI?=
 =?utf-8?B?WjVxWHJPeEs1amFTNjZCaUV2ZVdTNlRiVHlsWlJoajgvL3RFNC83NGxvcUFl?=
 =?utf-8?B?a09scy9JUVMwVU9aa3BKODFSSWZFZnptU0NUQjBmM3N5aDhaQVhuNklZbm9n?=
 =?utf-8?B?MkVBaEJGWDFEZ0FFaDJoV0dGTHpPdUpmdktkMmZ0S0xSVjJsSDdQTVlUV1k4?=
 =?utf-8?Q?LJxC7LoGcQEFsjxA5Kdfxg91h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc1c09d-13f6-4a09-64a4-08de1eec1916
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:27:31.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOJVw09Bns1xk9dTOWDOTgMw1F4hvG/saT0T2FvyFdANCDHqZ3bvQ75npeEyhwhJ9KkCgI76+W6r6WLr33jAdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992



On 10/21/2025 7:13 AM, Suravee Suthikulpanit wrote:
> This will be reused in a new iommufd.c file for nested translation.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant



