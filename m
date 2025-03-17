Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD46B233141
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210580; cv=fail; b=r0Al0DfQWEA+T/6y7A1Hnpo/8u4S2NE8J8d5nZXKPw0DNZDwGeZEmievlhVlknblUDPCCBy7DXBsJjfqWutoWsgEmlCrnCM4qmioSFf4BlBSLIJv+kQKc1lvYwcQx7XMOwEAwv8HbwsuHgT6gfZvC3zLZ7Otpe2QfgEIFcbwxBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210580; c=relaxed/simple;
	bh=4Ej3FExeeaKdLuYTrlDocsY+sV0sCNBkaNBrsCGLkL8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dfEOWiTYlCkJ3fs7BFYuUnA7khSEwH3vVnIKH9bv5BIAihpI7csIod79RiyOXwcE0bzaaY1BnJi30VDfLTLO1t0vgepu7g70/+JzCpqPhb6+5MUeqIwEDXc/d64fYv8PWBTvLbMd0nN5ik0AJEtaW357Xl8WXLtrdWAo3MA+HHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CcaXvhbH; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CcaXvhbH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2sLlCqHUo5WndrRDIC68iOpxc9u0iRoK17IBeGWZgp0zcd0B+kJiKBmiAW5dhrO5m04tdPCzHQp1VjMDNcpgK2UTu//RaACB6t+1GjU5MaqJKC90m5oD7TloVdjmFc0HrytnBJKApxWqFsuA4jVgdcHJJO4ar2JWsXHpFyBdpm/pQAODjJwM4e19i/3rhbi5q+A9KrywdL5SFJAvQHeL/t+uYTsPQohBX/HN0bNuUbsPpXrL0ZpYo5c8plDbts6if8fBJO3DMZRDWXf+YOhd+c1bavE8BGGJKRw+2bznFpkmvKUvC1KoZ7ak/WJk0hUVHN03phzcvL/vZvYAuHAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ul5rlOM4qjhKPTAd6m6Mlvto5WhEtjj0C55Xuk3FfU=;
 b=NJvpHNpeQwP54PvWQb6uy03ltuasUwWFnM031eFLSPzPuAtYmz8xdxuD8JwZjiF5zLHCx7KthAN9KE/Q/izU0yTMW/J6kyz7s4M2J75oyJtiwHxocZMvJbCebIA38X8PL+T+ilfL3r6mNNy++xw/sxdiR6/4HWO/1UDVmiyFZxrz8i8sWTYf8xj8MD+88WUqFTEGvszSpab6OE2l5T6cwWigx520Y6K2rQ+KJ/6ZHxZmAmOF51+zfpSJLr7mXIMP7ahFpqqt+Q3slw/XjxC/h5zGz6Bwv/4auzuQ0SwxYgwLKpUtWngXHRBE6a8nuzgfTqH2BSXfuC4LatNmjko0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ul5rlOM4qjhKPTAd6m6Mlvto5WhEtjj0C55Xuk3FfU=;
 b=CcaXvhbHvxOjXmj1vLS/w7Mje91wFp4ZA0YsLNnnFwnk8HaQaV3/RpbTOZDU2sp49iVj3ARsOUw1XBfoCJk7QJXlGg+v2M9zI2Vd6xZ6MzW2c9+mX4DxdKXwePs/8CU+jEjS6gZeTHz8GTFw92g2MRFVT1yQSBGOPMIzGjH54Ks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 11:22:56 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::61ca:6d43:a98d:3b7f%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 11:22:56 +0000
Message-ID: <aac3de2f-8f76-4df7-8eb2-1f89a86cd91f@amd.com>
Date: Mon, 17 Mar 2025 16:52:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] iommu/amd: Add debugfs support to dump IOMMU MMIO
 registers
To: Vasant Hegde <vasant.hegde@amd.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
 <20250206060003.685-3-dheerajkumar.srivastava@amd.com>
 <08816382-f02c-4f98-a355-a4aa5af16d86@amd.com>
Content-Language: en-US
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
In-Reply-To: <08816382-f02c-4f98-a355-a4aa5af16d86@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: f66af216-6b8a-4ec1-1f60-08dd65460ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1VteWg0eFBFZm05c2RKck1Ta3hya3hyZThuUXR3SzJxcVhiL3ZpQStnVkZM?=
 =?utf-8?B?UENvMmdRMUFMTW85TnVZWXdCdkQyS2lhSFEvUlo2bTRJRWlSWTJzRjBZUDZV?=
 =?utf-8?B?RlQvRFNxYk00UnRJdFBMVjl4bDdiZnVTYjdVV0xtcHYrMmZkWjhkWk93b3Jh?=
 =?utf-8?B?YlVYSUpZS0RSRHFPZ0dCcHRSNWRmK1B0ay9nTk4vOVRXT0FOV1JXejk1ZFB5?=
 =?utf-8?B?NnhudVI3VXY1TFdLYmJVVmtlbnJ0UjUzOHkrT3BTSERUVGdidUtYNk4vY0ZX?=
 =?utf-8?B?dmlWZ0l4TExwY3ZIa3hFYVgrMkJDNURna2tieENBejdpZ0M2elNrMzFEenhj?=
 =?utf-8?B?Qk1KZWpYVDd5Z3N6VWxtbHk2QmNCQWNrWEVVbEZiaHFRQStHcWFSWUllN09o?=
 =?utf-8?B?d1dOMkwyejlzOUs0bGJ6VktDSlF2NGJkbTN2LzhmM1NwK3VrNnhkUnhvSWhL?=
 =?utf-8?B?VEFGTzU4aDNwTUwvTFF0WHdpUVpSd3JrRkVISWpZNjE1YmlPM3l0dG4wMHJI?=
 =?utf-8?B?QlBZMlhid0JKYkdPYVpINXgvWUJGZThYeHU2V3UwN2dzK3E1QXFQeSs5QWFP?=
 =?utf-8?B?M1piT0duNE5yenpNRjZ0VzJUdEt3RXVOZEJScTB3TVhhSGdWRzBhVVdLR2hE?=
 =?utf-8?B?dStPWnRNUkZCZEM3V0hOZ3ZtU0kxUlF6bjJEeGt0a2FuZ2Y4aXVIR1lHYlVU?=
 =?utf-8?B?ZkJ2Y3ZFdWYvZFdPUzZpQWtkWkVFazcxWVpKWFk3V0RwWTN3SjA3NWpyYlRW?=
 =?utf-8?B?YmJySzlkMTBuRkpWYmNPYTBKNm5Hc01SZWdBWUpGbk1RSW5WVHN3MHRqck5m?=
 =?utf-8?B?QU1mckxncEpkOFNrOGhwTTFPV1YzeTlhMFE1bmpwVW5qWGpIWENOTXJPME5P?=
 =?utf-8?B?aFZudjJ4OTR6UEZwY3Nnd3VDdVI1VWdhZ0MzVXNwZnAvNnM2NGNlZUNXb2tW?=
 =?utf-8?B?WHRpWTlPTjdBcEUwZVJ6VElFMkZwWkhWYTJPU1BxRGdzUDlYWmwzbFYxSWxK?=
 =?utf-8?B?M0RmeFlsZDl4R1o5K0VpNWJPTUVsR2RZU3dERjVEK3RSV1BLU1Q3ZEh1dW9G?=
 =?utf-8?B?OEk0OWdYSmtCeGprQ0hQTTM2WUVXQTZ0UkZzT0NDTGxQS08zY1RPOEpFK0dT?=
 =?utf-8?B?d1NKZXdsbHhpcmswbDBmdGZkSXlSSUY5OWR0dmUvWG95ZURRTkI0V3REdUY5?=
 =?utf-8?B?OGY3d3BMbFd2TytKdGZOMzFIWFU5ZDdIK1p0RE9acVB6bVMraS9qUjNyUXJn?=
 =?utf-8?B?RmwyVGMvM2VJN0hJVTRlQnJGVjZCZnc0TloweHdKZ3lmMVlaaFNFNmtOZFJJ?=
 =?utf-8?B?MERyZU5MNUxQb0I3Sjhxd3VWeUN3MktHUllJenRJUm9uTU1vcEZzZDk5VFZw?=
 =?utf-8?B?T1FBSHNMUCtlS1QvL2xqOHlvMm9zZk9RZ284SWJ4a1Y5Smx5WkZVVmlBTTBm?=
 =?utf-8?B?bU5LVEN0cDNCUzJHakJxaDJGQTIrY3F0VmpjNVVBN2FIUHk4MC9CSTZ3Y3dX?=
 =?utf-8?B?bWE4OFZQZVZVaWJ4c2NrU1ZVejU0Wi9pYStZVHBWRm9BSkZta2N2YXdqSFAy?=
 =?utf-8?B?Vy85WHE1M3l0cGp4SkRpMDAxRHVJY21MSlhScmhvcHRQaFpaZS9RdmVBQXp2?=
 =?utf-8?B?eForT2dYWjVWdXpYYkVZZ0tpOTdmaVRhSXBVVTJUN2lmRldkbFZ4QytybFhE?=
 =?utf-8?B?WElnWTZidnovUWViOFQva2V6UkpYZlpIWjM5aXNTdTY4aGJyaVJhVmE2a1VT?=
 =?utf-8?B?ZVhMQnM2OUo1ODk4YzFjcklMTEQ0TnJLZXVRSkRwOEtZcFA4ZHhqRnpqN0RM?=
 =?utf-8?B?cEtrdkN5dmJQbFpITEpvMlR0UUhha2VMalp4ZVNZdmJoRlhjbTR6NTN5c2pE?=
 =?utf-8?Q?d34AJbHVKn3uS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1k2ZlhXRm05TXlMcVQyK0MwMHBzdkxiMit4aWN2WHFOWjg0VThxc05WVk1n?=
 =?utf-8?B?Smw0cXk4RWhKeFNTdkl3NHIzZmhpQkJmQmxSZkNxV3FCREVnc0FZVldDeVFZ?=
 =?utf-8?B?bUYxbFRJNHQ2cG5FcXZ0T1NrRTB6YUR2QUJ5RldJME5QRkZCQ2UrclV0OUp2?=
 =?utf-8?B?Wm9yWGRiZFpRazRSazJXMWhNUmJTRDF1cjIySVZETnBWZXNUYy9kQUxkTzFT?=
 =?utf-8?B?NElwbS9BK21pRUNxSUFvZlQ0UzBoUWp1UnhKYVV2OE9YK0o1YjdoblJWL0FO?=
 =?utf-8?B?RlVsYktobkk0QktXSHpmbW1kbndESHZZZDRSMGdDK1E4dkNHTmF1R3FLVnNU?=
 =?utf-8?B?NmRyOXV0cGRWQXdUVXdWWVh0MHU1SWl5bnQ1NHpMWjZKdXhtUXZzcjFmWDQ5?=
 =?utf-8?B?NVFwL0E1OWNmU1FBS0FSZlpQcmlrV05rNnZKeEJLNjhlVE51cG9wKzRmSHpP?=
 =?utf-8?B?eE9WN28walRlS3ZrT2JCWmtjZ1EvMUg2UXQ3TFZlM1NEUkk1VDNvU2hSc2xU?=
 =?utf-8?B?MHZjZHhCS0ZQYUNDYURIVUVvRTZDVFVEb2ozSkRNN3Zybzh0VVQ5WXhzWC9D?=
 =?utf-8?B?SGNkbUdiemdSS1lLd1ZaSDNNSnRDR0hkQTZGa1VGVERoZFQxT1VsTmFlZnJX?=
 =?utf-8?B?QnhOYy9TZ09YTVJWWmUzVkFRN012Nm9qOVo3cnUvRnRydVg5c1lYRlRZeGZW?=
 =?utf-8?B?dHM0VFJBNUVHa3o0UWFnWWNrb1J4YWtEUkd2WGZSZ3ViRHdDeVFsRjEyNjlF?=
 =?utf-8?B?Z3JvRGZGbFlHZXZhUWFVelhoU0lxSmFneUREYllsYjNxbS9ielV0YnFMcTZW?=
 =?utf-8?B?d2JCQ1RnclRJbS9sRGMzYkwvRDZBdmMxUWZQenZydTU0RlVTZ0dVWlgvQnF6?=
 =?utf-8?B?WTRtd1VJTE4veVQ3TXh4Q0JURkpnSUVPVGFDaks4K0Y0aEtiUm9aVWxDVCsx?=
 =?utf-8?B?RXV4TTllQkZJNU5DV0RhRitCYkRwVkROZXYwMXYzaTBLWGV0TnUvNk1wellk?=
 =?utf-8?B?enhMVHBiVk9VOEIwZTU3YkVFYmZrYWV5S2NFaHhqN2ovQlA3YVdESHBnNzdK?=
 =?utf-8?B?T1VhU0cwSmJCN0UvRGdReHY2NjBFZFp2ZVBNVi8zRU8xTjhoU2ZxOGJqOTJ1?=
 =?utf-8?B?VW1kU1NxQjdwd004ckhsSjlXVndpSkRJYW52aVdkaEswdTZkZHlxRlRnbURo?=
 =?utf-8?B?cXpvZ25jSWtKcHVpaHJEdmQ4UkVDeDZIUExUSmczWXZpZ3JqancxeTJQbTkw?=
 =?utf-8?B?ZEpCZWpjYlhXaDIvS0VEcy9ScFlkY01EN1JFemNZNFNnTlBjRU4xM0pXT1M3?=
 =?utf-8?B?SUZ5RVgreCtmanBtaGxVZVVFbi9DeWRXaStMQTlpSldmUHNPR0xGc1ZRZDE4?=
 =?utf-8?B?RXZYOFBMMzdKTGN0TnNVdXV0V0tuTlB1bnpIbkdwbXUyNmJTR0kyMkY3aGNo?=
 =?utf-8?B?ei9lSG9RZ0d1MWdjYVlsZlRWR2pHL0hYZFcyeW5waWlocTBDbmpUWXM0Y1pt?=
 =?utf-8?B?OXJDZlhtYVc5TDhJZzhKY3BIZk5HR3N2NSs1eDZvNEJmZlplL3FPQVM5WUZy?=
 =?utf-8?B?NjR0VnovT2VMUVJxMEtOUXAwb2ZJcnBnVDZud044b1htbzQvdnoyZEtwTkNn?=
 =?utf-8?B?SWlXUnlPcFFtYm0xaU0xY2FReXYya2p4bEg5U3Q1Z3RFUm9EQUJrZUtrL3NP?=
 =?utf-8?B?NWhsN1hadlNwN1ZZOFczdUVLYktrd2RkZ1NQMXdoQ1ZEVDdLT3RUQmVCU0U1?=
 =?utf-8?B?RFRGakkvcEFoejhDZXBmSS9zYmpndnkwOWdIb0J5NGxCeXBQbFRpa2FxU0o0?=
 =?utf-8?B?WFZPZmNTRkw3MUc0YlgzUi9qalNEQVQ3Y0xqdlFpMXJ2bm1TdXIxdlBObzFW?=
 =?utf-8?B?bXdtYkxiNTh5aXBoYm1TaDRRM2xuM2ovSmhiRmhjWjl1ZTg4WU9NbURvR3VE?=
 =?utf-8?B?Wm5ZUkRkZ1RIYXZCRFpmbTJ2dklLdXlUdkxZU3RBMEEzOVpLY2pGUmx2TW41?=
 =?utf-8?B?M0VXRjFaZU9mSW1PYXpzYWV3YUM0amNPZmxRMkRXOGpCNlVUQ1Vab1lsSDlh?=
 =?utf-8?B?UXgrU1BqWFNzcUVhR3RrVUw5ekJpRHpVQkRxRmZSb0JQTHcraHk0bXk2b0x3?=
 =?utf-8?Q?6o06QE9Qmw4oVGtuxEf1BY57a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66af216-6b8a-4ec1-1f60-08dd65460ffc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 11:22:55.8545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsHgrw0XBmLblYvKRw8NaIlFAO/gM7N6PbtjdiPQgwY8gEKklM1qGyczRQq54hsx4X97u86ODYKZAACfav/Ypg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964

Hi Vasant,

On 3/13/2025 3:58 PM, Vasant Hegde wrote:
> 
> 
> On 2/6/2025 11:29 AM, Dheeraj Kumar Srivastava wrote:
>> Analyzing IOMMU MMIO registers gives a view of what IOMMU is
>> configured with on the system and is helpful to debug issues
>> with IOMMU.
>>
>> eg.
>> 1. To get mmio registers value for iommu<x>
>>     # echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
>>     # cat /sys/kernel/debug/iommu/amd/iommu00/mmio
> 
> Many of MMIO registers are 8 bytes. By default can we print 8 bytes instead of 4
> bytes?

Sure will print 64 bits (8 bytes) for MMIO registers dump.

Thanks
Dheeraj

> 
> -Vasant
> 

