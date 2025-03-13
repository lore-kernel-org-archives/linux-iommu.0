Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99D263C8A
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861654; cv=fail; b=kMzHWecyJPtVV2R2ZYuLHWJCyCbioiI4MfqqRhUic0kDpOf0hoyptGPK6y61NNHHcWNbgN4eGoFaDLI5HStbqC+FwmFKdZrpGkrZff/hKelid/L261RuOI/jUBFdSdN3oLZaSlsGZcoPxFSHcH6luJWn8wP8lB8stxlKGUSSDoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861654; c=relaxed/simple;
	bh=M16xtBCpX7eRjhjlhhe4qBg0xPHrjyD50iLLwTQTvYg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YQWzNRzB+nD1u257+gn+nTZzE1FqmfFfAP6DAnA3GTw7jk76iMZn6W7hen5pBcSSBEQZuTZjVU7cUSAC62cozC+Rdrl7Jy1Z+rDTwfUo7p5bHDIJiJ9igCLcAtIPS4HWUu0W2D4qFQcYo80+nebqMfwkT64RNkVr34ulND8zVsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HbExxFYv; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HbExxFYv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csdXiq+L8Ab2sozMByserTHq89yvVO+GJJZIVkDeVRHqS8TWDEFLaMxJCJ8S6j8TaO9hFNsMutRtTx0Xm6I3FU8tcS9n9pd86Tqi4b/Ia3Md4weIwk3UdQWSJh+NfAwcmlywjvvRZxlf/Cn6vt4Y3rjxPSS984nMwZDTmEITh7kFZwme+FP9ArO+QyhD4ggsx8bDuNmSmeYx+iI6FSJCEgIHMoVvWMgBcW9i87sAPNHPESpar1bqS6upiCaupE9ph3ixd9ZzdjUY7mFsMAWjEnJKrrBmCx2lFa/jcludjw1nGP8sXglrECGAdMo6KnJDo3tY8Vu554RIqyBRYrV7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQ0MKv6RONB749LSecPO5qIRpCGiXxE6zVWWBtDapq8=;
 b=UZZx1YQqdYzYzKuf4kPsTVkoyYN1tjRrHKvIcxW1TWeX1sagdpW4+sBGBmDUr2BSP9uzcRzI6AgBkxcYSuGM7vYzgbQIip6fZZi0GVS2kYMMC2XQDpYUS6q5hn+9BCb6AiUfa1BNN/HaPj6CLw2rG+cXI9IKox/bGalAOAkqB6szDqz+9YJr8XQq98/+nekY0ysgXUV+ofCUWdD08sxF0WrxDDgptI7QdQ691ygB0Gz3j8v3JdkSHibBAIXh/1fx/6BJ/uUP8RxJzVFBTIIhJJjeq2gQPdEthRVzMJj+jx7CM/27L5rkezP91Jzt1gTVmJZv1/jTfjb4/juP5I3jqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQ0MKv6RONB749LSecPO5qIRpCGiXxE6zVWWBtDapq8=;
 b=HbExxFYveyZmm1GcwOXRW+usQPCQLoIvcKr86ZrrLbGHb8VTyeu/4R3P7JPWe9IcXvcViyGJrLKbwrf+T/C9duKPEn4lBWkSlf7z1OXJ1QVncB+rxP8XuemGmNDahzwOrAmjEf23g1GcjPvNePOCcSWN+kwoUL9z5kuZFRMwO6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 10:27:28 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 10:27:28 +0000
Message-ID: <64014aa9-4d33-4178-97bc-719c2db00d93@amd.com>
Date: Thu, 13 Mar 2025 15:57:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] iommu/amd: Refactor AMD IOMMU debugfs initial
 setup
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
 <20250206060003.685-2-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250206060003.685-2-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: c66e3be5-3f0f-47fb-27db-08dd6219a770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzQ0M01tOXJyUHFpQVBaL1hOVFBGYlR5aXVwbmU5L3JmM0Y2YzZSaEg1Zm1H?=
 =?utf-8?B?UjBSSThWWU9wcE9kby9mamxBUnV0Qk9pZXNKbytVU09DbzJ2ODROdFV6TGZq?=
 =?utf-8?B?aUI4ZHdDTzd5YkIrNS9hS0FVcWplQmxnSDI2c0RtYTV0bWZsYStZcGMyVWlv?=
 =?utf-8?B?Q2kwWFU5elpuamVpTzdMeDRKVStEM0ZqU01MazJBdlhlOVZ4cnNZNDJHZWtw?=
 =?utf-8?B?L0tJaEoza1A1U3JLZVdXeVJjNHZMRXR1Qngvc2g0bUJEdHN2TytyNXhEeTJL?=
 =?utf-8?B?bGlQOHBBbG04WENOSlBMSGF6SXE3dENpdFVYOTNoa2NWYncraEVFTXJ0eW85?=
 =?utf-8?B?aWlnZXBCR21yaktKaTdueWRMQ1NpaFlaTXo1eXEvSmtCV3RoZHQvenhDTkJB?=
 =?utf-8?B?UVU1M1E5bWRPUzlwcHlqcnhiNVdIRlBkMy9pUmw2TnNRaWNDMngwdHIyK1pP?=
 =?utf-8?B?bXZtY1B0ZWZJK0xUSG9Jd3RvUGRjeUhDbjdVNUozYkpkVVN4SURRNlM1ZnZT?=
 =?utf-8?B?cGVPbElIZ2JlQ3FqQlRPbkhySWhUaTNNVS9ieWF0by9wNU1SL0VDcm5pOGQr?=
 =?utf-8?B?cGFySFd3QXBvbVM5WUFFNlI4ZSswdlFLMXo5bmIwN3JUWVdteU1MZEF5QlQ5?=
 =?utf-8?B?eFRaWjZWQVZBZFltTEVuSVRXYzRTU3R3MUlxYWI3WnROb1pmU2U2SkFidDI0?=
 =?utf-8?B?b1hBdUwxSm4vZ0F6RkFpRUh5aTF5cCtOUXZ5MEtaUHYvc0o4RG8xU3VSZDhz?=
 =?utf-8?B?RzQ0YVdMSjdWaGZueTJMcHV1RWV1dG9Ra0NRa3J6alBVRzQ2V1FZQVZFSDVC?=
 =?utf-8?B?SHZKdDRRa3F4RVgyZ0pBVG4xVVppdHpGNDNHQ1VYMTNsZUxSRkpTdTQvcno3?=
 =?utf-8?B?M2x6RUtYSmhja2JnZEJRVkNPSGUzQWpUL1h3bWFNdFQvSlNkK1ZHeUlXQkNQ?=
 =?utf-8?B?QUN1cHFaTGs1MTRKbG5wNFJ2QlQ4TTJtZlFNQndmd2gwNG9UTUpDWGtKU2I3?=
 =?utf-8?B?VERCVzU5dDVzMEdtRWxUeGFNd0hhVUI3NTNGdVFibGJKNkljM3ZHWU5Sekps?=
 =?utf-8?B?MlprTGswYk1VQXp6Mm5oN2NVMlRGV0tUK3VXeURQdThPNG9DOTU1TGgzelIw?=
 =?utf-8?B?SSs4VERocE80VW9wY2UzZ01OTUhFeGZGdDVWT1Znc0szYjY1S3RYRmlkY0o1?=
 =?utf-8?B?dUNnenR2S2ZzVHQ5Qk1uYmcwZGxtbDRJTFdoSUd2UjRCSHdzV0Yzbm1mMmc2?=
 =?utf-8?B?cDV2WWtsS2pDN0Z2WEZKQVhSUmdFUnltc1Era2ZRdkRNRVVHWWEwdjQwOFZX?=
 =?utf-8?B?enZJbXBjRjhuQ3pCaUhGaFFFUXdRYVpsUWxIU3daRjVkN3lHZHlNZ3N0NHRJ?=
 =?utf-8?B?bi9TQlZENHdvRVFFUFlNaTUvVEtzNklyVzV3bFhGM0gvRDlMZzkxYzl4WWpC?=
 =?utf-8?B?REQ5NGlzbk5oUGNxK3dRTHU0TnBWU256T3EvOXh5RjY4UStJaVR0ZHd1S2g4?=
 =?utf-8?B?bGpBa2ZnMHR0QXcrWDNzUzNVUTJpVkdKVVphSUxtSm1ETTFKTFUzNkVHM2d0?=
 =?utf-8?B?cHlxN2RjWE5MVHpEVU9TRVRsdmpzVHNSeE1xZDdrWWQvRlFwMmVMWmtHc2Ja?=
 =?utf-8?B?ekpiVGtaQlZrNjV2WmNVM3A2emNzclRiYk5hRThuaWhMNjhpcU1aZnlCdkVj?=
 =?utf-8?B?K0JWN1JEV2xhQ0lvSlJTM09OUHF5cGFWNHV0RGgvc3UwWE8zcHd1cHZMSEI4?=
 =?utf-8?B?eGx5U3NLTHFFL2hlQUNjcy83b2JHVGExR1hFS3pMM1JQSkVLNmgwQm42Y1lK?=
 =?utf-8?B?eXY0TzZvVnc0SVpCTjFBM01BVy9GMTRmL21sdFkwZDNtakVjcHRVRStYMmNh?=
 =?utf-8?Q?Cxve2B/NnyMFg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHBtOXdyNVIwQXRrSngxZ09OYUlick1tN2V5bmNyMlA5VmNNVkt2bFRZcFJ0?=
 =?utf-8?B?dTVLSWVpQkdsV0FsQkV5SXpFKzRjVVRQeXpETnRrdUhkNk5kbisvWTY4T0lB?=
 =?utf-8?B?MTZnME4zenhzcDNDemIrbjF0ayt2OWNNMXZKSmJob05qU2tiRGh2cEh6b3dz?=
 =?utf-8?B?c3JuZkd1YkprbTNxWVMvZDBIZERLc2pwdzVsNVhoVHloeHdMa2t0Z0c1VTBy?=
 =?utf-8?B?c2ZXZzdMZjY1SmZYeTF5N1lMbkhNR0xNM1Z6SEhXaFNxOUdSaWJmcTJpUGl2?=
 =?utf-8?B?NE1nWXRIa3dBNkxiUnR1OE9mNzJHbGNodzEvNEwxTU5mMy9oc1lRWFE3dnVt?=
 =?utf-8?B?aE10M21LRDhva2lIbXo0QW1rYnBVTUtneENReUZqSHYxNE1ETHBpdTRRd0NS?=
 =?utf-8?B?OUREam83WXNmN05mWHJSUlc0bzYwTFNtZkFseEFHWnpzUTdPVk1vY21kRUc4?=
 =?utf-8?B?T1p2VWQ2cFhGYi85NWFsV1M4TXJLZ1lndHlib081WXlmaVlZN1M0cVkwUnZI?=
 =?utf-8?B?WmlZZzB1ZUtscS82SVMvU3ZJaGtDY2hHM0VwMEYvUHRCaEE5TE4wODVOdExD?=
 =?utf-8?B?Y2xzMXNZcFB4dmlmWnM2U2ZaVU1pUHVJMTdNYS8vQk5hTkJWdjdNQVpvN3ly?=
 =?utf-8?B?ZUYxdUlxTW1kR0FCcXhoVXQ3ZEgrWUF6c25UTC8yc2hwMUdJM0hWWlRERGhS?=
 =?utf-8?B?ZXJpR0hzVkhEMzdnWUNMZ2xqNjgwcDRuRVkzY2daTVJVbUN1MGdKbHVlb09P?=
 =?utf-8?B?aWlCVDJmYlQwbXp3ZjEyT2FkY2k3SjJtQzA3M25RNFNQdjNNZFArZSszS2xM?=
 =?utf-8?B?cVpRbnVPTEdJSEFGb2JYUDIyd01hcnVUaE5PM3dSV0hJUlBlL0ZRUVk0SDNP?=
 =?utf-8?B?bk1SN2JBYksxUTBjSjBqL05SZDlFcUZWSW9KZUNKK3o5UjM5MWhGZkZEZnVW?=
 =?utf-8?B?K00xNnUxdXl3TWVhS3pLTDNFeUJ0YzQ0S1VOZGNhN1R1ZzlpSSsyY3JBRGJm?=
 =?utf-8?B?VWR1K3lmOXJNYk9hc08vQWcvY1V1TTl2UHNROHplMDZWcnBRMVNBWEl5YU1J?=
 =?utf-8?B?QWFlVDFyZ0U1KzVrb0VuOVpBRVlJR3BqejdOVitneHNwSGFOUXQxVklla0RZ?=
 =?utf-8?B?T1hHUENOSzlaSmtpNkNQL0lOTnJHRGlWSkJTYklndVYwUFhmMi9GbGt0UTNy?=
 =?utf-8?B?RUZxSGRCbUNISzRnV3lpSnlZWlora2VWd3grZzBMbnJleEgxdVVuTVRwd2tN?=
 =?utf-8?B?L0N5TGt0clk2bGo5V3dxWUtvaXFCVENjTERiQU5lZ2pZb1BaVXRGWlF3Y3Fo?=
 =?utf-8?B?WUFaaGcrZjJGOTA0bWJxU3J3TXcvNVljclo5bnBXN3ZLS3ZwUkQ3REVPNTQy?=
 =?utf-8?B?UGZjVENaQVp5Z1FqaWdpdzFIcXNFbCtLdENwWHpkaGNGdEI3V1lGQTVTcjNp?=
 =?utf-8?B?VDljeCtCdlgybHJqTUVGTW04R1oyRUZtTkd6cUpqQktkOGdWeXVERFMySitB?=
 =?utf-8?B?cXZ4RUVCUWhpNFY5Z0FQbWJrZ2tIeVlWbS9nODR0SVlQYTlqalJLVUJaUndT?=
 =?utf-8?B?bUlGejZpWm5COGptTDFCaC9kVU4yLytvK05FSi9ZVEg4K3Ewb0FOcGRXRnp6?=
 =?utf-8?B?NG42Z3pFdGhGNGJDZDc1c2w4UUNoeWNKUXRFcWNTNS81dmZ2bDhtOFR6Ylpi?=
 =?utf-8?B?d3hoVEU0OVFsQmtqcE5iN2RJRVZyOWt2RE9hVmpKRFJWVFk1NDRKZ2w1c3hl?=
 =?utf-8?B?d044ZUsvMExqamd4cFY4bDBUVG1oMTYzV3FPRzZra3pLYlJBQmJhWW5OcnRR?=
 =?utf-8?B?QlVFdHViT3BxbWJqN25wSkV5dEN5bXY1cUpaMk9YaTNrK2ZPZUxjNDdjYmZC?=
 =?utf-8?B?NUZSTEZvL0tVQXo5RnVMbW44c3JaaGxMTmxZZ0pnSU9OVVVrS0pHUFplRWJM?=
 =?utf-8?B?ZDI4bHFuSnM3dE8xRDhMY3dKdnQwSnp0K2pibERidlBWNkhEYVRkZnRmVSsz?=
 =?utf-8?B?cTlTaDcvV3FMdHV3RTY4UkdyS2I0Y3V4L2NnT05CZFFseGx3eWpxUEhtaWdK?=
 =?utf-8?B?NnZ3Nno2QWVsb0xRWmswZ2pCdUlLTVpIQTF2cFNCRUxTbmFYTTF3d0ZyZEpr?=
 =?utf-8?Q?iSHSiqRvhwVPtnxhO5kcuJrzx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66e3be5-3f0f-47fb-27db-08dd6219a770
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:27:28.2252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/VN3EtmSOGDcfcEq3I/tGpqxqtP84iy4NNM6KMq146G3szLx1/KlTEEG8+arsol5C4Cv1+3bEZcXrE8is7uxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483



On 2/6/2025 11:29 AM, Dheeraj Kumar Srivastava wrote:
> Rearrange initial setup of AMD IOMMU debugfs to segregate per IOMMU
> setup and setup which is common for all IOMMUs. This ensures that common
> debugfs paths (introduced in subsequent patches) are created only once
> instead of being created for each IOMMU.
> 
> With the change, there is no need to use lock as amd_iommu_debugfs_setup()
> will be called only once during AMD IOMMU initialization. So remove lock
> acquisition in amd_iommu_debugfs_setup().
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

