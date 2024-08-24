Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A4A94D
	for <iommu@lists.linux.dev>; Sat, 24 Aug 2024 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724510883; cv=fail; b=raE5fq+ioWl9LycfhjxiF3s2XrBpVaz92clE867Z/rz8wmGFci6j8SgScSp7LFSXQK3bI+VIGY1hHd3SYXiynNsNGYq+f1vsnyuBFbg+iKc38SUxkiELyQkx6WWGD30Fa3Lz4d3Edy/m6UXqkG7etDyar1f2p5yH3OQ9ZkBs/a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724510883; c=relaxed/simple;
	bh=/kq6hmIiAY/kYnYyXJvIvYbxXBR562ETRtILB947nBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B9+zBXP0iliC3mw/W7WvkQuv7xCUu3uB36A6x+1Hn6WDdvcr0plDNgtaw/AQPTJ3LdWDOFSJy8Tw71c1tzbkE16k5QIUC2pJ7ad/Ghl/xNRn0c2jfWmaJosdbEeekKEogbvt6Ilb7BWiZGbjGbJr3dNr9MceX98OJHuQzg/3OCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KkeSM9n3; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KkeSM9n3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueO+jRy6RqdC2TsvT90gd5eVckYrxeruYm293ipid3K8oT8pwQepZqlbU8CkLYW5SvXNmBxeGOWii/TH1p2ohn4N8xdeswiIXBm1klmKKSJ/AB1jiJiQskVSCia5Hbj7zBYT/pz+QDeVobABNUJmG425udj1wcGXTE3JRbkx6g1Q6Cx8LAkPmalEDEgddHwJbIoLIamPClofAm1D9O9txdTYwk8pxJpjKlETcVWVH2j+IGFkDUavUnD5+H08m+UKQJYmNRHOlxCNMn2du1he6ZFmjmcZC4h+xyRWAVOtHTrei0d9HO60fWuRl1tdSLNJtky9xEOPdemJEOfyzjnS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE2ct2GRf9zTCPaLSea+6oqN6AVYKBqcl5MZjlnG3WE=;
 b=CQ4ol0k9D3GJAmVURfw/rLL/EZdxCjTMg45Mi60y2o8JDxaLiwtF6m/meL8jog8thTyvYlNtNVmb4PNRskxp3iRIB8zCb9bqhs2hbfR0SfVIBFBBjOoRgoYlmkigkmQKUSx35OXaJ1RfhaFhJqlhtJ+27GNU21q9RRhgkJPDse2SdNz/f+4vkyvGSqb52R7/r+kPIsYOO6t99aagxnSF2w+TUlUJRUEiQAxiy9RXkX6YsNrX73aev9tKIgD+OKGmGgtPvtqyuBH1Ua/uuitD9mGGCGxthHXnAUtw5trSyz2wzsfw4dBJ3PfuEC6pqex1DB/ZFSSZgjQ2GwSA0R3qyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE2ct2GRf9zTCPaLSea+6oqN6AVYKBqcl5MZjlnG3WE=;
 b=KkeSM9n3/KtsRUHO0I8KrOeqU3NK4CdhbAGRQzvY4mTpC6NLLmFhjqBczO1PYefVDVVVAzWUbXpM0JG3czTgpJgFdJCIE+bm9JTAqSOYDY8xzL9qoJ5RHxHOusrbDjJ5qBscau/nmUGg59aF1LIEmPYkvIJOyS7F9KXndmNeBuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Sat, 24 Aug 2024 14:47:55 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7897.021; Sat, 24 Aug 2024
 14:47:55 +0000
Message-ID: <8215e4d4-2077-4fca-a002-27ddbfc0ddf2@amd.com>
Date: Sat, 24 Aug 2024 20:17:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
To: Yi Liu <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <67436cba-3d05-4528-9519-231b8396ed51@intel.com>
 <20240822124433.GD3468552@ziepe.ca>
 <0ca31cc6-1741-40d1-b8c1-20e6b4fc955a@intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <0ca31cc6-1741-40d1-b8c1-20e6b4fc955a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::36) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 2502ca31-835c-4abb-9278-08dcc44bbcb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0hWaG9RbmR4bVJhUUpsa1NUZmF0aHQ5RVJ3d1BtbUFjalQzVTBGbWJCR2tO?=
 =?utf-8?B?WlJ6dExFQlN0a0x5MVhaeTRmV2JERGk4cVdwSllBQ3VDUE1rMGZaOTA5Tk1u?=
 =?utf-8?B?VVNPMHd0NEpwZzF0d0JWVDhFczF5cGxCZElEQm1Eb3c1ZzNJNkFlWHRmUXZz?=
 =?utf-8?B?TDBuNzlocGpqNmNGMmRkckZYSzJKZFRyWDR1RzNJUHA0RmNEUGd6RTh5QzNK?=
 =?utf-8?B?MDdLNnhrT1Ewclp2Y3lheC9qNk1hTmVLOVAxOWNMSzNMc0o0bC92S0tTUG95?=
 =?utf-8?B?SmJ3U3NwejhmM1JkUzRPUEZZL002S1NMUk12UTJnU1RnVC8xMWN1a2dOTkpN?=
 =?utf-8?B?UXJhZng4SFZJQ1VHdlRzMlZEK3ZKZ0c3Q3NZMlRNTmRoNHh4bVI4QUQyN25M?=
 =?utf-8?B?SVpiWFJnUWR2MjF1MFpGRzlGZmIvOWxHQk1aRWVRbEE5NHZibjBJbG0vd3Vu?=
 =?utf-8?B?dzZJTEVnKy9GMWVFMDc4SzZBV0NrZTluTGxyRm8vOXJNbHc2K3c2TWNwYnNu?=
 =?utf-8?B?cGlLa0g2am5rbHpXQTFlQUFPaERrbk9Dd1ltTkpSTzFUL3NXVHEyb1k4cEVi?=
 =?utf-8?B?QnljcUxqcFE2Ynk0TmNHWlBxVk1qejIxbXo1WlN0end4MHdTOGNiZGppL2tN?=
 =?utf-8?B?Rm15VVQ3RDRyZmVRTytrblNLVDhCYjdNQzlMMi9iQytXTWl5a2NtMTcvZkVr?=
 =?utf-8?B?TklLWXlNY0RjOC9HYklMMlZMOFhXWHZyNnRGTXJWS2RSYWFVUkFuUnFUSWN0?=
 =?utf-8?B?VjdyMmZKSFJQYmdnelBWbVJKOHJiV3F2ZmZpOSs3dE10L2YxVzRoUlVGdE4r?=
 =?utf-8?B?Y2FJb01jN09YaFBJWTJjdmFmdW1uOHM2YmVBangwMGNZbnlHY3FRWThXVFcy?=
 =?utf-8?B?VzRmeUNIc3J0T1pLOWl2TXFOY3FxOWM5YUxUUStaNGRwcGk2WVAyU1ZNcTVr?=
 =?utf-8?B?WVRDL3g0eVdzSHVOc2JkZVZ3U2lkaVhGQnNpcXFOV2xkTXh1TWxjRlJyMm1h?=
 =?utf-8?B?c2tMeFhBTGlxRzd2MXE4ZzQxOWxGVGsvS0FyTVNGVGVDTnZOV0dYdE5JUE9Y?=
 =?utf-8?B?cUJkOWFDQzQxN0RxYTJINURSN0QzOE0zNWpNUkNoQkJWVVYySGNTd0hIb2FQ?=
 =?utf-8?B?UFN4ZEZNcW5DV0dMZHNUQlg4eDh3T3NNMEpVeHdGWVVLalNaa09ucHpnQjkr?=
 =?utf-8?B?cUZSL1NvR3RTc0trK1J4YnhWSHVnRk84QWZoNWF6THBJUGdZNU9VZitvR24r?=
 =?utf-8?B?YXpxbVZNUTlRMmpaWXo0bGVzSTFHcFlUU3BwUlhVWnN3dkxBN1JlcFVuaXN4?=
 =?utf-8?B?YmpuS0s0eHRqMjhJbExwMVJzeWp4VUJHTzdnaGt4U0FHUUJBc2tWamdXWWVJ?=
 =?utf-8?B?eE1zN0YyS1ZCS01pVmdSMEtrcHZRQ1RQOXhlaTFNa01uMGl6aGxvM0VnTTFL?=
 =?utf-8?B?RkR1Qm15UXA3TEsyZ2MybXpkR2ZRcXFUaGsrWjV2dU9lVkt1Y3ErK0JJUVBL?=
 =?utf-8?B?eXduVEoyd24yUWF4VE5aTGplWFR5ZGpYQU44UmdWK2V0ditkSE80SGRtSnha?=
 =?utf-8?B?b3Zsb3FwS0NIV1d2YndNbVR3d0tOb3I0VFdtVzZZZzdCU2Q2VmlEUDEyeFUv?=
 =?utf-8?B?S2FFU0hVQmlEZG5sRFNRV01qeFNDQjFYeE1nRlZLK0ZDTHJxYXdSQVFyWmJt?=
 =?utf-8?B?VHdleXVpWVNDNlkzd1NVQUhFQVJ1NmFIM3c0QVpaN3hTQUFEZWNMOG9RRFRw?=
 =?utf-8?B?eU9vK21tMDkrajFOVUQ2b3RMWlE0bUNlTXVBelp5ZjUwMEpxVDhQZWpQUHlj?=
 =?utf-8?B?alhWRlVTMXIxa0czSWxNUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejN3bFJmNUFnbDZmQnRwZzNVS0xIODkra0JUMW9ZTU9sRVBVa3ZQdVdWeits?=
 =?utf-8?B?STNFZXdSbmFKc1NtSEpjQ1NMSmptd2lYQUR0MERsaGpLZzhNQ24yTkNBQTh1?=
 =?utf-8?B?VzRSbXlXL0l4a2ZEdEI0ZHI4WElRbnVhTHBvUWJvYWt4YkpkaFQ4YTlsMDFa?=
 =?utf-8?B?UmllVHFybVFFUi93RDlBNWo2eFR6SVp6MFNNZTNTanJFNktQZWxoMVhSZjFj?=
 =?utf-8?B?RE9JcExoM2M0Rzhpd2RGNHNwRVRXRTd5dnRlRjBVMXdwYjdZT0Z4K201Wktk?=
 =?utf-8?B?d3RBeE1vekxjUS8yQzFxL2h6dEVscUxIMnlkc2ZhR3pjUVZnYVJOcHRCNWQz?=
 =?utf-8?B?YzZ5WHF4ZTk4QUh6Zm1nUkl3MWhNQmQvNWNBaFJIMWNtdXBOU0xORko4Y1dD?=
 =?utf-8?B?czlBOER2bG1mMHFDdFFpZFh4bFlrUmQzU3l4dUQwL3BELzBpK2tmaUNDbUt2?=
 =?utf-8?B?QWRVWDk1UWZVOFRMWWp1S1pZYXJrQlpVNVBIKzZjYWVCY0xDY2IvdkxRTGpW?=
 =?utf-8?B?ckJFQmV1T0FJL0duYk0vaGhveDRiZUdYVzE0MWlVdFdLWTIzZWx5TFZHck4r?=
 =?utf-8?B?YkhseW5JOWt0YnZTUXc3eThyeDF4eFlRb2RZNXUvUytYUlBzU2QyWHllQnpT?=
 =?utf-8?B?dmd5S2x2UDFKR0VncGYvMytzVGprTmhRdkRHT3BUNEQvV01lalpqNzkxYlh1?=
 =?utf-8?B?S0l3bTdMRDlmSktUeEdaMjhoMXRMU2Q0S3BQRTBQVlRXLzV0SXZLY3F1c3N6?=
 =?utf-8?B?MTk4Q1FDbFZhK0s2bVVnUjBRcmZTVHBPb05VOVo0V0tNYXpHV1F2RHJ3WjNa?=
 =?utf-8?B?b0N5SjI5bHdQSm8wbjZWVXhmdTIvZzFaK003TkoxZU5UTFkrZFRLQnBxQ1Jv?=
 =?utf-8?B?QWJrV1Fqd2h6VkZoWVFmVEo4Q3NheHZtWHRCem52UWFienZtc241YWJNOEtk?=
 =?utf-8?B?YnNHMjJYdUVrdnBuUlNOOEZxV0dFOVZtZFdxQWg2VTFaZTFWd0FqSkt0dlNt?=
 =?utf-8?B?M21WUDZ1dUhzemRWckdBanBmUGlXV2dzcVU4TUp1VEJtTzc3Qmk4MzFiRHBL?=
 =?utf-8?B?VDhZWkw1aEhwOXpQYSsxM2RYYTUvUzVQQjFkRGpFMGlqMUkwKzZYYldNd2hm?=
 =?utf-8?B?Y2wrTWY2dGxiclR3aytsR2NnV0dDYzIzT2liV2QzODA0MjJnOHVMbUhRV0Vq?=
 =?utf-8?B?ZXROd3psNkhVMG1FV0N0eHNsU2x2a0lpdGpyd1BBUUFlOVVON01GdVEreDk1?=
 =?utf-8?B?SlllcjdkcG0zN05iUFpwa2pMRHZ1SlJhbFVMdDBIdTE4Y3ppck1LUFZraE1u?=
 =?utf-8?B?WFJ0aVZtSFRjUGVtc2FkdWI3MkJyYkdma3lCQVdWb1RqZUxmY1NCTFBBTTZx?=
 =?utf-8?B?dE9vTFpZcks5b09vN0JhbTk4VHMxNC81M0NGdS9LV3EvOTZvT05sWm5CNmMv?=
 =?utf-8?B?MU5IRkhyeXVYek5udUttblNjTVZXZVpWWnVIWjgzMDdBOFFVdVVqOXU5Y1Bu?=
 =?utf-8?B?Q2Fra1JJcjRQWm5LMjg5Ym9Gb0NXVitNbjN6bkpDWmhpOVAydDZXSUFaUkla?=
 =?utf-8?B?eGI2Q1lZU283VFh0YmJMakcxenh1OFc0bUN1M254UWxkYTQwUWpzcHRKdzRx?=
 =?utf-8?B?OVNGaGFVMDdkT1N6ejNDWFRPTkQwWCtGR3VSdDNLMytjM2J0KzlUMy9QNWVL?=
 =?utf-8?B?T2ZDNERjV1pXZHA3eDQxemlhcUJFWWx0K0hJQXU1ZGRrNndiZ3g5cWR4cVQ5?=
 =?utf-8?B?QnVkTFIzSHJnSFFnY3dBS0pFV0JtbFhoYnNSTUtFK0FzTDdkOXY1RURCREsv?=
 =?utf-8?B?dTBSTUtOOUUwZ1M3Vi91ZzBPK2hYbHVCSXRIbXltVDR0VzU4R2tYWEowamVj?=
 =?utf-8?B?RzVPY2lXdGxpYVMvZHpRbmhhN3EreDh5Y3YrVXlqbFZ3R3kyRmd0aGpPL012?=
 =?utf-8?B?VklCRkJrNWRMb0FveGsyZDM2MDlRV3M0L3hpQzZ3aU1EcG5mcDZlN2VoeGVY?=
 =?utf-8?B?MWhja0JhcnoxYlhuNjdnMnVpMUNlekNFa3ExUHpPR1dmRSsyWlF5NHN2ZThH?=
 =?utf-8?B?RDRXQllwSFJ3K2pScGJEVFN3QS9JRnhqVUNNMlkrQmRJMEljWmVveHN3YjN3?=
 =?utf-8?Q?gTsmMYYTgIZFW8Btnl1ZjpyVI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2502ca31-835c-4abb-9278-08dcc44bbcb3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 14:47:55.1016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9I+anpNM3PMbxqHRfYX6jRdxFnZs3NYvpzXrPEkorZgis7vJyQK38PvRL2m+ktHY1FEth22JotE9CjrTBghODA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5902

Yi,


On 8/23/2024 2:28 PM, Yi Liu wrote:
> On 2024/8/22 20:44, Jason Gunthorpe wrote:
>> On Thu, Aug 22, 2024 at 07:27:39PM +0800, Yi Liu wrote:
>>> On 2024/8/22 00:31, Jason Gunthorpe wrote:
>>>
>>>>> @@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
>>>>>     *                                   enforced on device attachment
>>>>>     * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation
>>>>> data is
>>>>>     *                             valid.
>>>>> + * @IOMMUFD_HWPT_ALLOC_PASID: When the domain is used on a device, with no
>>>>> + *                            PASID, the device will support later attaching
>>>>> + *                            a PASID as well. Some HW requires a specific
>>>>> + *                            domain format on the device to allow PASID to
>>>>> + *                            work.
>>>>
>>>> Maybe:
>>>>
>>>>    Requests a domain that can be used with PASID. The domain can be
>>>>    attached to any PASID on the device. Any domain attached to the
>>>>    non-PASID part of the device must also be flaged, otherwise attaching
>>>>    a PASID will blocked.
>>>>
>>>> Yi will need to add a check that IOMMUFD_HWPT_ALLOC_PASID was
>>>> specified on the RID domain while processing attach on the PASID
>>>> domain.
>>>
>>> this means if userspace wants to user pasid on a device, it should allocate
>>> hwpt with this flag, no matter the hwpt is going to be attached to RID or
>>> pasid. is it?
>>
>> Yes>>
>>> I still have a confusion. Say on AMD, is it a legitimate configuration that
>>> the RID is attached to a domain that uses V1 page table while pasid is
>>> attached to domains that use V2 page table? From architecture p.o.v., it
>>> seems allowed.
>>
>> I think that is exactly what they have been saying their design cannot
>> do.
> 
> ok. I don't think Intel has this limitation. RID/PASID is free to use s1
> or s2 format page table. So such enforcement is nop on Intel platform.
> 
>>
>> If you want to use PASID you must install a GCR3 table full of V2
>> tables. Doing this denies use of the V1 format for anything except a
>> NESTING_PARENT.
> 
> thanks for the explanation. So if pasid is to be used, amd iommu driver
> just programs the GCR3 tables and the request without pasid would use the
> v2 page table installed at pasid#0. It does not use the
> DTE->host_page_table at all. I remember the DTE->host_page_table uses v1
> format.


Right. Only V2 page table supports PASID. So when user space requests hwpt with
PASID AMD driver will allocate V2 page table with GCR3 setup and updated DTE. So
it can handle attaching Device ID (uses PASID#0) and PASID (as GCR3 table is
already setup).

Note that when we use NESTED page table it will have both v1 (L2 / stage 2
level) and v2 page table (L1 / stage 1 level). Even in this setup V2 page table
inside guest can support PASID.

Hope this clarifies.

-Vasant


> 
