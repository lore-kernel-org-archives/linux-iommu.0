Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC3923644D
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210766; cv=fail; b=BswhIcZ4LsJr3sUJVjQg51dDIPZYxbvfEr8zDaG9Blr3sLwv58HyihP2jJprzhO+rIUXG0R/uXZA15tMOUimi+ayRfElZQq5ywxIqI3TaqofCDZ9hN11/nM9bCDyAzXfrU/0Cr6FFhgAZdan0YAECYO/+qU1ltEQoTmSNc5eIZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210766; c=relaxed/simple;
	bh=BWyxMuMMrue9/DA2xBDRBvh7QK5yIrXE7+S1fOkWBro=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WpCxRkb7hulKxMWEc74QWDBHMJvbqsBc+LY+7TBM8aPdlIM13kxV/s2PNCWfRGaN/aSTGVaG8ysaxi/ORihevs8Vpxn8fy/cPCNMpCFFTXWbcbO+Y4mrz0/fJDU/1u4YcpbaV4lBW5UpwOm2iKEF8TFoqQg8O82OiYXngHj2vZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FbbgwCEB; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FbbgwCEB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qi1cTm++gBCWMOcqgACpLhOCQNRsatnG/4nWifhzN9U8gIlBV+cN2wH3Tl4zJEaYod7CgHTNeGvTrkIDlKB4JgnXKZ4NkWMSckA7zIEx/y+fXtQ6pWFrsPklSy3EGNGvGDyWBWwuheJBV8PHPlGymY9jfv3c/NODP00VXGxj+bHMPHOE1Lcrt/xuM9U3L5hAN1iQhxCTW51/J1LqyOZrhB63kXRBWwCb0XJZCy6EJaTNqRTow+rv6upQ0DqyLct7ettd3eXl8rhGmE2QDAFFdntYmVCweZJZfxG/YUK9YXK3UK+J8IXtcMME5A1+LzKI4C66XcZcQffZkpPO8YENlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN/7Pw5+BTOAVpRxIpVXWeSFttDNXks6gKfxU+Y5eV4=;
 b=AcACE4eJVmcnI66pRaV0JRyJjM2DP4t82n3Hr84JRxetTiB6urshszDMHptnrs9zz2qgQe6Mlu5exE1mvhtKRhrd9y33DViU5382k2KBA/a3zFdyNowH8IRMZVAFQYKyzl49sLXXGOFJD1TwdCQNnGT8jfjc5RNM4vZEOnjO3VMSZPKQgfka/C0q6klnEzuyp6ZPAjqWRe7pvlO+eCMwFwUt/lpYCuQ4pcpmiW1tQSzoP4r+jeftMIK7jn0EYiypSAeLvd4vB6ocjUAEohRg33wTlVj3T7yRuIKikHTwGPmFk43tjjKasqf+/OS6kS98kF+4fmed2zaogG+g6MMxYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN/7Pw5+BTOAVpRxIpVXWeSFttDNXks6gKfxU+Y5eV4=;
 b=FbbgwCEB95Lo7ab5EhSTBmuV0D/w+km8Kvo3nhW8G2lx21B3pXKmR/YBNL4cgeaFkYN6PALfQHlLfO71bBxSnfz9Q4UyxXjK1oaldLIOC37IQ+PIhmLJCi3adsdImi21sM6FD9JZCJzy7YfT8K3VaZ4zghnOBPQiyGfk9dRo1G0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 11:26:02 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 11:26:02 +0000
Message-ID: <743e1940-efcd-410a-aed3-6e06350eb49d@amd.com>
Date: Mon, 17 Mar 2025 16:55:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] iommu/amd: Add support for device id user input
To: Vasant Hegde <vasant.hegde@amd.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
 <20250206060003.685-6-dheerajkumar.srivastava@amd.com>
 <5c48b79d-6b94-4e7c-a78f-bb170b01a9c2@amd.com>
Content-Language: en-US
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
In-Reply-To: <5c48b79d-6b94-4e7c-a78f-bb170b01a9c2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::6) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: b6827efe-ef32-4dec-ff6f-08dd65467f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnBmcUJVZVppaUNyRFZHa2pzMEVIYVZqUElKTW5jZTdkeUN0M2ZHV3lYY0xu?=
 =?utf-8?B?K0k3WnpMVVBsWGhUSDZ5eFdTZ3pWdm5QUmhlYkNNdDhvb01Xa1FOclEwbEN6?=
 =?utf-8?B?RHdNd0FvdjVteTh3clVYUlFmeVR0NXdOWXFGMjNGRVVITTdmRVdWekhIWEF6?=
 =?utf-8?B?RnBnbFkyV3pFRTlucWVId0hSQ2F4ZklrTXJMMi8zUFhQelpsNFZ1Z0hZdXJh?=
 =?utf-8?B?Tnk1YWFJbjg2RXpuK3R4UURRV0pOUnh0cnk2Tjc1emdmazI2aVFKNEdkZ1lK?=
 =?utf-8?B?RlJiUXczelBEVlhZenFFc1lqc0NReWc1cHgvYkNvdjk0eUFINHllVThTTlNn?=
 =?utf-8?B?bW5RWTQ2VW1qcG9rYlVRWHZaMmlXNjRsZ3JQVGNSZDJacXExSnhPRmRlaDUr?=
 =?utf-8?B?NUZDSVFTOG9TTkJSV29HZG8veEFiZ2pvM1JzaHM2REU0RUtocERJekdhTnUz?=
 =?utf-8?B?Ny9ZUjM2RkRHa3h1WU94ZU96WUkxd205RmZmSnV3MnJtSEpOdjhPNmNFMVE4?=
 =?utf-8?B?dTFJZEVDZ0ZtdlNJbkxobE83aFNkWDNSL3FnSHY1a21GclFwc000eDJic3la?=
 =?utf-8?B?emgrOHB3eFBKRzZIN1dYSzR6cy91eTV1RC9TWFpIeFJkNnVNamRBMjhJaTBD?=
 =?utf-8?B?enMwUEdmZ0drQ0syREE5TzVVR3FkTDlwc0Q1aEk2RlZUb0VsOFlLRXVLd1Zj?=
 =?utf-8?B?endwRGcyVjFpTVVMMFB3cEJMd09IZ0xtRDZJTTJRZEN0SzBBcUIvNTR1SWJF?=
 =?utf-8?B?bm8yR1Nhd2c4SnJ0N2JGaVVTRWk3MEViUmtRamVKejRJaDN6cThrOGYxN2Q1?=
 =?utf-8?B?UFFDdndpWE1rZGdqNUpHL1R1U0tpOXkxNVhqeVZTaDBqczVPWHZTTzRkQlQ2?=
 =?utf-8?B?OFRrUFdIOTQrMVdGNUljdlFHMkpBMnZOUmI4MkdPeXp2RzVwNFFKQ2c5OUdp?=
 =?utf-8?B?Rnk5RmFnckVsN3RsbmpiNG8xenVSS0dnY2M0SG1adnorWDVuNGZpZ2FNQU5l?=
 =?utf-8?B?bVUvOHp6V3lRR2IrbElnWk44djNBNWdPQW9ydzg3ejIxWDdtdUNUNXBQcmEw?=
 =?utf-8?B?YzQrc2JzekZ6aDN0STdqWHg0MjdTYzEvei82d0hRK2I2MVZaNXBrRms4Z0pN?=
 =?utf-8?B?dmp0UExTR3VWMUFmVXhKd0hpcXdhUmNTSXgvLzRaT1RRN281L1JackZmUXZy?=
 =?utf-8?B?NHpxckFvblZWOG1sWEhnS1Mxa3BzZXFYRVY4WWhwUUgreEdNMC9vL3BzWFZH?=
 =?utf-8?B?Nk1ySGVtdXc3K2NlTU9lbmkrZEZoc3FSVXc2NXpkbG1QU2tkY0dlNHEzbUto?=
 =?utf-8?B?WVFRYWRXdy9uelo2QnZUdktERDdMblRPK3E3cDd3SjV4Wk1pMHYwUVhMWW1y?=
 =?utf-8?B?UllGZTdsUUhpdUgxb0g4SmtNbXR6OC9MUW01ZXNHNVFVRUhIR0hNQ2g0eTRr?=
 =?utf-8?B?b0dWckd6alNlc3FpMHBMSGtkWWV2TjA2Z3YrUkNxYUFMMk1ZdkZGTlltOGN6?=
 =?utf-8?B?SGFmcDZJck5aZzA4LzBTZ2hwK2UrNHJNMlFkN0pYM3gzZ1F5ZEJsVFJtTWtj?=
 =?utf-8?B?aFBBTGkybGF2ZnFROUdZQUtPdHJSWmkrSXhJTC8vRk9TWWZIZW8zN3VmRCtX?=
 =?utf-8?B?QlpQQzd3S2V5R0djclJ0SlZBb25xZUxDUzhYbXZ2aDVlNmx5MDlZYVJtVzNV?=
 =?utf-8?B?NlF2Rm0xQ3FIREdqQ3EwSlpVRTJHZVVBbkovVUg3b3JSVklVbm9Ybkt2MDVX?=
 =?utf-8?B?Z2ZVSnM3TnVFV1ZoSk9DVFZuQ2JYZVJKMGh6THpSOHZQSU8xb2Z5a0JEdENN?=
 =?utf-8?B?aXUxSmtIb0grZFJaNWZOUTlJWlY0c2o3a3ByTElHTksyTDNPZjlKQlkyZll4?=
 =?utf-8?Q?4P60y+ydGDPg9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0dvYXo4a0pPc2ZkYU0ycFh5QTAvNThqdi9vUzZhNHltdVpCb1dXQ0pHeUIr?=
 =?utf-8?B?Kzl1SHNvU3hDTlhyMmJ4bGdRcXlhRkNoR2Y5ellKb1pYNWhobEV4RDlyT3pt?=
 =?utf-8?B?VjdFaTcxK1VjN1ZhQ3Q5aUE3b1RJV05iV2cxUkQxMjVIZTdKV0NocjN0TCtz?=
 =?utf-8?B?azdtc0N6bWRPOTZWcVU2SWJrWW5rWENKVmZNV3o2UDkwVjg3dnc3bG9nZnVz?=
 =?utf-8?B?SEcwM3ZRTGk1VDRRN0thbUtabXdQeEE5VUxlSGYxbW9OeTN3cmZRdHkrNXE4?=
 =?utf-8?B?WmlTdW0xMWx2bzhKRjJjdlVtdUpLNWhwckFvMmZWUGxzaWMrRktRNkhHTUlB?=
 =?utf-8?B?ZkpHZUhnT3hERVp1dlNiZmZVZ0doRjJDWWVBRzJlYWdCUGhxcUowYU5QWFMw?=
 =?utf-8?B?TE9BUkRmUk91TkZnN1ltbnRUR0Nmcjd6aHpETmFZaDY3R3YyekIvd2dGZld6?=
 =?utf-8?B?ZFJRRElKRGJReGtSSGpxY0VDNmYvcjZtMnBVR3dWQ0QwRFJ5dHI4UHJYQzlC?=
 =?utf-8?B?UVgrTklNaXpUd1g0emFkZk5hY2JrMjdoWmxhTVN3bFF6ZUtqelVYTjRsZ210?=
 =?utf-8?B?SDMrRlpvVU1iak96VEwybnFQMGl2elAvazNhMWhvNTVHRlBxclhQNCthMVNh?=
 =?utf-8?B?cEg5aVdsanQxNXdBZ09Bc2RMOVFhV3VXUmRoSk1sOEtBcHBGclZ6QUljNzhZ?=
 =?utf-8?B?QjAxRDNNQzduMXRaYTVHL3ZqbHRtMzA1K2tQODhRZGZOSHNBSkJiZ3BpSXhE?=
 =?utf-8?B?bU44eXhPQ2VFRW1Ra0F1WFhVTVRKNDJ2VlJUMGF2enVEOGJ2M1JneHoyOUV5?=
 =?utf-8?B?bW5FQnQxM0N1UXNxL3pzRkRXUzAxTTZlckRHdDIzUXo1QVpwS2JMWUhjUFFN?=
 =?utf-8?B?WGpmT1N2Y1RodDJQSWtLRks2ME9paXE5dXBxYlFhdlhBQnV4aXpyQmErZHRw?=
 =?utf-8?B?WGhOVzhkT0RvdHhnbHJBaWYzeXdnQkw0ZnNYa2tRbmZ6YkNranBQQmt0SnF1?=
 =?utf-8?B?ZWxsZnBEOVB0NjZ6RDExYmF1ajJDbmcwdEV1TS8rOTBPTVRhMmFkcmNSRFdt?=
 =?utf-8?B?SDhxVkJWVllKNUdOZmEvVzVucFczMU5USVc3UWdWU1dxWUNJZzlJUmF2dktk?=
 =?utf-8?B?aG5nS2JYNHk3cm5xZ29IT1lRZDAzM0l4dlQ2b05Td1h5UVdFYWUzc2FueXVa?=
 =?utf-8?B?OEo4d3FFc0xhVVhGcGVvQ2RHc0locGVGRWlCOWxQdmZpeS84NE4zK1IxUWZz?=
 =?utf-8?B?V2x4eTdXZStlRDNvaWV1U2tFcjNnOHNqSTUzKzFyd0Nnc3QzNjZiMkM1OXl5?=
 =?utf-8?B?RHFjZTYxbmU0U1IxZUFvUEtMbUUvdXlJTXJQWHFZa1haVlpsM3NOQzErejFC?=
 =?utf-8?B?VUJLZ2d0c1FteWlGdTFZbmlTM0NKa1hEQmVSWkFremc5WEc5NC9rck1oNHhP?=
 =?utf-8?B?aWZhb2c4bVdmYmxETHp3VWZOWXAyZ1A4Tk1MLzRyMXVxNG9iY2IrYmpvRVlI?=
 =?utf-8?B?cDVieUQrM3JQaDVKLzc0ZTNRUHB2ZWFsV29mWHFEUEhiQ3VlYkp0WkhaSUpr?=
 =?utf-8?B?LzZGM1FtTVozRDdrakwwaVN4M05Reko4K0dvUmZRbDdlR0JGMU1HSy9iZFRu?=
 =?utf-8?B?ZEQ2Zmhaa2JsMmFpRUVUaTBmMXljL3NQZThSOE5FbmhFTWFmdzhkdzVVTHYw?=
 =?utf-8?B?cE8yamw4UkxwV0N5QUMzTTJjMGI4MnZna1RrVWplODZNaElDMWhCRUxPakht?=
 =?utf-8?B?NlJXMzlXYkRZZi9rZGFjSmNYMFJMQmM4WVhkbks1MVkxTEpLZ1JyR0gzZ0Fl?=
 =?utf-8?B?c01iN1VrTFo3bzV0eXhCYmg3ZndZOFB5TUNoc0gyOGJLeVhldjU4TExKcjA4?=
 =?utf-8?B?dmdEUGtsTkZEVnNBZHdibW5nOGtBRlRQL21jK1plWVVKTWVZSmMvK2YwZTY3?=
 =?utf-8?B?WU1qSkgxai8ycFNHTkx3U2l1OWFnVHVsZDN4aklsNys3MmE0WjNKZkN4VGhn?=
 =?utf-8?B?VEgxQjR6c04vaTJjSURuNkxUcGdINzFITHlicTF2RGxuZVlwNEVDeklXVVpK?=
 =?utf-8?B?YnhtYWNuODVsRGxzZ2pPcXdKWlJoK1RiZlFkUzZNd2piQTY4Z2xyMHNjWXk0?=
 =?utf-8?Q?54vH758AUr5DgRe4CHbgwJ0BP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6827efe-ef32-4dec-ff6f-08dd65467f93
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 11:26:02.2578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52K4VcBcraZ23KqmuodRlvwuCM1Wh6N+37xUqxVdx3zS7zYDtIGa/vsFKvEgRH543RjcMHyPBEw/XMvrnMUOGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964

Hi Vasant

On 3/13/2025 4:22 PM, Vasant Hegde wrote:
> Dheeraj,
> 
> On 2/6/2025 11:30 AM, Dheeraj Kumar Srivastava wrote:
>> Device id user input is needed for dumping IOMMU data structures like
>> device table, IRT etc in AMD IOMMU debugfs.
> 
> You may want to rephrase the description with our approach of printing data per
> device instead of printing everything.
> 

Sure i will add the need to print data per device instead of everything.

Thanks
Dheeraj

> 
> -Vasant
> 
> 

