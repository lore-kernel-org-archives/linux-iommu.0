Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C70347FC7
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549440; cv=fail; b=iiDDcoWQZONhUdP3ZpVUe55xRDEuL4dpPRGbE+6oowOl5kYFyMlkyFv4I9l2GZicLYrjFwfowSppxS4Ii76jcFW06NUYU6uZDcYxZ2UU0GciWx3wZfh4dcTjzwZp+58LNPeBSBxY0mCvOlFuyj69F9XrF42KTkvlkULOaeCOiqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549440; c=relaxed/simple;
	bh=Opm3vN5ad7rDT46xPEhs43b5CO9kd+qpOUmraQzSZKQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EPzmAFSQ9CUE1riX+9fi+hW8ptTcecEspflQJTE1Y0AuvZlh2MhctzaCLkdJdKJ/cydxDO1qWuVyT76OGL0xLIXb7yQKZKl12vfYIsCo9miSR8AvSEPZC5+fFNX7pTz09AennjckTOBDrQnWeHZYjjyqAd6mDEACUuDi5WXiLY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dIG/H1Qs; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dIG/H1Qs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiZOMzXxFX6zKfSIxFVPX6AW8JucevDBOa5Iczt21I4EvZZYPbcvfzxv4L1n0jc/aznA+XxNeCbdbfmk4wvWl4M0inxZqFZAx+EQvht4YJL6zSK2r5lXm1b5kCMqk5zoIQ4Ho32XWwYycNQCjsEbInPDVnVLq31icXKQJjkZQIInSP/+vwiLs14WiZxZsoajijfzGmstscf/qxwHMS6pgPBB5SLnsSo3dXt/msDgpziNAUFtFUIYAE9IQiDk0GRt1Qz+i2R3IalzpkGAWS3xj/6kioMlLqoRjRlEbWTt25d/wAJX550fnFxiagFBogoJBNTFFMDiJKxU/bDpMBxpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkklU+U5k+eZsERkg3UXA9YBWR2FzzaRL2vQdLg8t1s=;
 b=Q/gO+LGgRTd36nLuB2o7pJQhYhrpZheXi9qx2bnediWcFPkr05CgO/4Ba0Jwz2xGfhQsFnnrP95X1qmWMPdtoX4h5/qeL3BNRrjIzH1xnAzyoFQffgEfHoTmR2eiq/A2HPc4N/4irfSpUUi1ksD8gbsBfDu9Aht1p1UqKMW3J+Qo2G4HhsU2GG67lzGb8icMtMEBeDdM3jZblmqs8BUXSSgYqtdne/ca3Re29Fn0VM1Wt8VmhsslZN8lymrkzv1g7aNaFw+1McY+gi5jNCMWkekbFE5dc/dmaIOOGeZkXOp0vJmhT/eOyqgkoE3WBG0oQ+bOp6LmsGOZ0Z9Dh3Ficg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkklU+U5k+eZsERkg3UXA9YBWR2FzzaRL2vQdLg8t1s=;
 b=dIG/H1QsRlq1NtR+CyBaSw/26I3J2hn1Ei2NgcsB9Xr1dd48z5U+r+8UJ0GnQhpIEbD7gQvWtElD8k9mL+ktny2FR93ezxxZpcza7msO3jXWT/JWpxEh02zorEXravDvKeqdxW6ZtBVrfSNWu+GtxcA/2MX7U/W2loqFYPhLmhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:50:36 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 10:50:36 +0000
Message-ID: <78a4598d-5d35-4fd0-a830-a740076aba41@amd.com>
Date: Wed, 19 Nov 2025 16:20:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] amd/iommu: Preserve domain ids inside the kdump
 kernel
To: Sairaj Kodilkar <sarunkod@amd.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, ashish.kalra@amd.com,
 robin.murphy@arm.com, will@kernel.org, Jason Gunthorpe <jgg@nvidia.com>
References: <20251114104442.23296-1-sarunkod@amd.com>
 <20251114104442.23296-2-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251114104442.23296-2-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 589310ee-1fc4-4429-6a5c-08de27597835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTIwbnpEMkl1ZFFUTkpUbXBDRVVFR0ZBVk5CeUdyZE9BbWVHWG54aWYzQU9D?=
 =?utf-8?B?VkllYmxGRGh3Rk9PMFhMWFJIK0pER3A2NC9lanFtQnVaNkxiazFQRUtVSXo4?=
 =?utf-8?B?SUE2N2VSdXlZMVk3OGtGbkQ3WWxTQUpJcmJENVVoYkFuZ0VHZTFOSUhMVG9i?=
 =?utf-8?B?bkw0cFZVTDBmNTJJM1YrRS82V0FyaGVRRGxLSkpkUGsyK3E3SzR6WnZqelps?=
 =?utf-8?B?azlEb1JTVVdWaGJxTGV3bkp4NTVsKzdsTjRVaWVFUWh5VkNtTnhqZHg2d1VW?=
 =?utf-8?B?MmFXbWFiQ09JQTNrU2NaUTdicmRieHVTekhTTUJtTjYxL3JOazU1cS9jRWVO?=
 =?utf-8?B?TFh6cGs5TVo5QVBmcDFtZmluN0g2bTIxSGI4ZWZDUnN3UENibGoxVlFsNmpM?=
 =?utf-8?B?eVJIVDRpVTExNTFNOHQ3WGp0OVFYZW1KbmJwYm5FWWQyWHdIbzFUOWpQb1Bo?=
 =?utf-8?B?K0VlWEtKUmR4K0YrQjkzcHpBT3JEeGNZSXBMK0ppYUpRTXFobmJnd1l2Q3ZQ?=
 =?utf-8?B?ajkvV2VaZ1grcmVhS2hVdWptYkJJOVBmbGJyWnhySW9Ec3NrNkpIeWxZajBz?=
 =?utf-8?B?QmF0UGxYRE9kdDhNcDZBdXFwcXJDRFh3aVJuNk45WUVoVHpLTzNjMDlGeXE0?=
 =?utf-8?B?RlZqalF4OUxqVy9tR2ovZUptNGF0Z0Vsd1R1NXA5NlBNS0xqRTFwaUNFSDUy?=
 =?utf-8?B?SEpjeUtaVXZpUGsxMldZcEMxZmtDYVB1N3kwcWFoK0s4Q0E0UnJPVkFmNWor?=
 =?utf-8?B?VFRRa2xXL0t3WHcwWE9RaDZwdUJLd1NMcmtWS2srYlU3bXdldFBtZ3MyZU9C?=
 =?utf-8?B?aFBJQjVtT0o3Z0V3RVZxT3NvbEQzSnhiVlFIbUd4NDVTUUl6Tjcvd2MzbHlz?=
 =?utf-8?B?M0JYbjkvcTJObmRmck55ekhEeHZ4ZVU5cWdpRXRXa0pNT0hFY3d4VjZubHFW?=
 =?utf-8?B?aEFVQXJyOE83N3lPR2RqaERGeVVieXBPTkg3cUxKOUlBVFo3QTNWbElpUlRq?=
 =?utf-8?B?UVBYeHB2MzJiTDJEcEMwSk5WTDFLcmdNTjBpNCtRU2lCbEJWdnpoVno0eHVj?=
 =?utf-8?B?T2NkdmN1Y3JXMXlQREVwa0JNZHlqU0dXclZvVTF3S25wcDBIMzRJaThaWnR6?=
 =?utf-8?B?VENCOGdOS1kxMUtYdnpmOVdDbEh0SFYwN1BaSWt4WTRRRnRnWm5QKy9jRS81?=
 =?utf-8?B?U1JHU1d4VmZ6WG83S3Y3b0c2TlFBUnZ2cnZYMzNWL2pMUi9GMUZ5SGc2cnFU?=
 =?utf-8?B?UG04M1RWVzNGVWRwZ3NKVldoKzdMOWtnL3BER2hrck1pdVZsaC9rL08wWk5q?=
 =?utf-8?B?N21CQ29MR2RWeHIvOWNydUtSaUVHMENtSVFKSnRyb3o0UWtlQjd1YW5QMXlN?=
 =?utf-8?B?M2hGMEgyWlZwdlliZ2RPZk5uaXQ5cTNSdENyRXlTZ1RHcUIwZytNcC9MUzhO?=
 =?utf-8?B?LzlYZ1ZuOUR0OUhYTlNseTAvMExHOWJYNDlsakoxa0sxcXJxd0JZVTBtVThU?=
 =?utf-8?B?OXlpaHFWUEc2ajZwMldpVmhPNmdMZlZTVU5nVVBicUJ5RERGZzJrelVOTVQ5?=
 =?utf-8?B?WnRacitlcXZiQUJudGdkblpLcVV3alBnVlkra0pobHFzL3lIMDZFeVdXWFBH?=
 =?utf-8?B?MVIxYlhrNkkwaEdtN1RKUWNWSytDbVFWN1lxRlFYZ1ducWhldTJLaEV2ZjBh?=
 =?utf-8?B?VmlNNS9WcWhGdy9laEFURWdaZVdJY3FNZGxTcitmVXhPRXdmbHFnL1E5NXIr?=
 =?utf-8?B?TFpqSGxUajd5aWp5SHNIczlRUk4xMEE3UEdHQWYxOVlCNFBRUVNUbDlvdjJo?=
 =?utf-8?B?VysxaGdDS1ZCNnFPRnVHY1AyZFBIc2JwamNrOVZpTFpUUk5CNnNCTEJiT3B1?=
 =?utf-8?B?b00xd1htQ1FjVFNCUFhQUXViZkZ0Z3Jid3hUU1pxNUw2UlYvMzU3dndVM2xh?=
 =?utf-8?Q?SxmKup21C2EIopEV3rfwk2VT11+4FjRo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm1uaHlZTkduRFpaNHJtUVBXdGx5djRiVjEvMFZyR1RmMkdsV2ZMeDhZMDIz?=
 =?utf-8?B?c25QUDdITkRNcWh2T3pMeEhsVDlqY2VWbFJodkdYNTNHT0k4a3kyZ3Fkc1ZH?=
 =?utf-8?B?bjFGeE5DQW1lVjdLN3RTdTd3aVBZRnpZUUNEUUpwODNZRnVuNTFwRGN3QmhH?=
 =?utf-8?B?Nlp6WU11L3h3Z2YxeUZramxQTTZaQU1DVkpkMlRqNkRkeFBwdEhyWjJ0WGs2?=
 =?utf-8?B?Y2tudkFsVTJsZElVM3IzT2JzMnpzN0JRa0c5ZUt1TW1iY3hVdUtPalpvYU1r?=
 =?utf-8?B?d2JEeFFaZzZkcVIraElxUlVIODhjYXlyY3JKZ080VXRSNG5ON1dvRjZiYlhN?=
 =?utf-8?B?eVFXOW5rUkU3TnN6bUx2aWVvbTFoUU5Hc00zTXJZdGxiV29TcDc1L2lTUm1L?=
 =?utf-8?B?L1JsVXJjQTZCdC9nSnVCMmNkV2FwV21ROFRzSC9EYzA2clc5WnJvTnRhcGEx?=
 =?utf-8?B?anZvUzFsN2UrZTlhMWxqczF1dVRSQTgrV0FyZlBtb09GRWxIZEx4MXpLeTUv?=
 =?utf-8?B?ZjkzZmJKQ1VyUTU5WHBhZGlsQkkrME9icSs4M2t5NkswUTJWVkEyV0hOek9B?=
 =?utf-8?B?Vk9CUmxwcG5JNlkraWdZSFBHZ2kva0RZY1RZVDYxbG15UkRqZHJSMW9ydGYw?=
 =?utf-8?B?NlhzdXlCNVo3bFBxblpnVTR2TW50ZHJwUVAvdkd0NkZ0a0VVMHFnZU90b1l4?=
 =?utf-8?B?RnIyeVBRamQxTm1qWHdpZDlPZVZtcWViaHhEdkFnVW1qQldVaUVkbE1JM01H?=
 =?utf-8?B?RWNFbmh4R214WWJDT0lPUVRuSGxJUGVwTm5keWIwR2djZGR2c0JUc1VtRXJB?=
 =?utf-8?B?YjNFNlNBSkpEUnVMNVFuL0pmMDBJU3psRExXWFhabFZ3WHpENEl1RmVqUWpx?=
 =?utf-8?B?U3U0Y05kL0l0aTFxNEZBUzVZc0ZRMFBBRzNwSzh4ZDZlMlVnTzVYTGxiMVpH?=
 =?utf-8?B?Nkt4TWhHN1NFQXBCZGFoQ2tjYkNHTHFOY3NsREJ4c09nN2RYS3RraWJxWkJs?=
 =?utf-8?B?ZVkyMUt6OHcwT3NhalpIb0pzWmdjQUNIOTJoVnExRXdzSVcySXhsMkdpTWI4?=
 =?utf-8?B?cG9UdE81eGx5VDc3Z2tRMnhCbEdCcWlvenVHWTdUcFlWdXl0TkpjVEJrQmFi?=
 =?utf-8?B?TU9JSTg3UDBmOFJuS1RpekN2elAwaTV2SE5Wd0JNYTMxdlVZTGtJbEs3M2tC?=
 =?utf-8?B?ekQ4UzZqNUlDWVJZa0ttcWhGTmphSlVsRXZwdGQvd0hIajVBcStINHkwc3RN?=
 =?utf-8?B?eldkSGRDNEl0MG1ES0JPeEh2eWd5Z29EaElueFR1M2wxRHVRbW5ZRllDYjdY?=
 =?utf-8?B?d2tHT3ZNcGwzQVhXNTJBYlVveXVSTUFuTCt2SERERFhPM2t3ci85ajRFYnVs?=
 =?utf-8?B?SWhDdjh0VG5PNXlZSWFBSmlEQmpsc1BqZlU5WHpoNXV3ZEpiaWM1Uml0WnZI?=
 =?utf-8?B?dDEwb1BXRTEvZUNYdEMrYW5NNGhjZEx5YVUvUHJQeWxFOUgwRkdXdlRsSTdB?=
 =?utf-8?B?bjR5SUIyczA4WFJ1NEZsVGhLWjFXTGVaZHBrYnZBRlNaOGlRbDBsaXZwMWIx?=
 =?utf-8?B?QUl3akprSHdUdDgzajlJY3ZqL1gwY25ENTNMcUJITURlZWNObHVTdnI2VGlm?=
 =?utf-8?B?U2gxdkVnNmpRdUpFWENvN2FoZWN0L2hBZ3ZNajRZYTA1eGN0U29PNE1TL0ZW?=
 =?utf-8?B?c1VsNm9ranc2ZDFiY3Q3ZmZZeitjMjMxVk4yeE1aZHNpTzVXZ29lazNsUC9o?=
 =?utf-8?B?eElSdFBvekVzQ3VjeW5WVk8vb2RheTI0QzNlVkVxNlpJVTkrbmVZOHowbVN0?=
 =?utf-8?B?bXRlWFZhN0tUVXh2ek1Ma21aT2pRWGdZU3B6TW9lQTdNTFBHZVA1NzFsemYz?=
 =?utf-8?B?ZlBwK3pIYnFEZFlPV3lTR1BaSWdGYmNVNEJmLzB3RytLYUtwZlh5Y05GbnV2?=
 =?utf-8?B?ZGxaTzkvUzU4NWFMN0tVWjNLK3drYld4QU83dmhKaVJsVG0zVldpcTA0aEdt?=
 =?utf-8?B?NWZGTEFjSlNWSXNGSVdtQTFaU1Zkb1dYQkFtYTJzRkpZN1B0R1dXd1BpSnZ6?=
 =?utf-8?B?SW9tU2kwS2xuQmViSWlwZS9ONUpVNkJWWjFRTXA4c1lSNUZheFQvY3RodjBo?=
 =?utf-8?Q?kGw730uJFrKeauVO25zOREUX9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589310ee-1fc4-4429-6a5c-08de27597835
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:50:35.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YQKNaI4l3gK5ocA5ZIM8DX1sonUpj2cZLQ3i/i0+d10dUZkkGEb+WlPGKlyM35y15sI53Skv/A1BGA3Nkldyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255



On 11/14/2025 4:14 PM, Sairaj Kodilkar wrote:
> Currently AMD IOMMU driver does not reserve domain ids programmed in the
> DTE while reusing the device table inside kdump kernel. This can cause
> reallocation of these domain ids for newer domains that are created by
> the kdump kernel, which can lead to potential IO_PAGE_FAULTs
> 
> Hence reserve these ids inside pdom_ids.
> 
> Fixes: 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>

I missed to inform you. This was reported by Jason while reviewing nested
series. So

Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  drivers/iommu/amd/init.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f2991c11867c..9375fba1071c 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1136,9 +1136,13 @@ static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
>  static bool __reuse_device_table(struct amd_iommu *iommu)
>  {
>  	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
> -	u32 lo, hi, old_devtb_size;
> +	struct dev_table_entry *old_dev_tbl_entry;
> +	u32 lo, hi, old_devtb_size, devid;
>  	phys_addr_t old_devtb_phys;
> +	u16 dom_id;
> +	bool dte_v;
>  	u64 entry;
> +	int ret;
>  
>  	/* Each IOMMU use separate device table with the same size */
>  	lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
> @@ -1173,6 +1177,25 @@ static bool __reuse_device_table(struct amd_iommu *iommu)
>  		return false;
>  	}
>  
> +	for (devid = 0; devid <= pci_seg->last_bdf; devid++) {
> +		old_dev_tbl_entry = &pci_seg->old_dev_tbl_cpy[devid];
> +		dte_v = old_dev_tbl_entry->data[0] & DTE_FLAG_V;
> +		dom_id = old_dev_tbl_entry->data[1] & DEV_DOMID_MASK;
> +
> +		if (!dte_v || !dom_id)
> +			continue;
> +		/*
> +		 * ID reseveration can fail with -ENOSPC when there
> +		 * are multiple devices present in the same domain,
> +		 * hence check only for -ENOMEM.
> +		 */
> +		ret = ida_alloc_range(&pdom_ids, dom_id, dom_id, GFP_ATOMIC);
> +		if (ret == -ENOMEM) {
> +			pr_err("Failed to reserve domain ID 0x%x\n", dom_id);
> +			return false;
> +		}
> +	}
> +
>  	return true;
>  }
>  

