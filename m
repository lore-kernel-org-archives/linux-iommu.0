Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AB21ACDE7
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972187; cv=fail; b=iT+s2xKIugRDp4ZN5f6ecqr+2yatCJ7GQl7heK4MbHTvKjerf7uU7fFOpAdGNUkBpPKSOUFiJGtNvtMU0TBx2QAdku9wiGlVPxs4PyoMsnHn7MtQr8YRxdtxPDsQPIwVcEsU6bk+Kv5MEqAxBNUat5Vl9UJU6VpSwQfeyUAN3/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972187; c=relaxed/simple;
	bh=MDKx2SfODF8tfL0jRhTiAwV24FV0VhpaNu5/0NHdLr4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gk4BDNLg+1vOgTtBssdjzRlO4vyVmiCUByREnSd2IO0c0tAW4O/pWMYrzJRHfNziltRJCS75aURyt2mZt8L8urc7vFhpm3AVd+oHKz8vMU56XN2c4gp57WVXFGPI0SMJjYvoxpLsQfXnmU1xK/4dg51CglyC0W6sKluq6Rxx84s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KqimmuCD; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KqimmuCD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aleWMyyR8saJJiMteOe4DZpIeIdVYmEpss/RUyljtfCYc62+cYry3H/24gVExv8KJdCvFXoCOYsxO3jPIWUEGiW5eWgFyh/EIC9gfMgPY+2Oj8grfBTUwvVBr/OyBJLVmv/Nz3JkmHAEmMR42i9kp97DYhA4mSTwRqEKy/7EB+a/ZUWXFEBBWsURanxgEgxBOQP3LqoMgRXwU2/hWIzsctYaJUEoe75t06DpOTKPurR3Ffz9oysA1INPF0yL7z+v/1TRr3kOrXl+IaGDUqA49FvOzUCfcCOqZghx3cePM6+KBPJVDwwtngjkOauXT5jh/YOyolBHJCVS6jFvbhyB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEqiAU34G+czhYkcdDXNiDKVvaxaguXzBPlTIZ3urSI=;
 b=DbYMGhk6li2h4R/thyh4ofw0EyHgMFQGmpPZN4tVwiuzBhb1j3Ce6g4PV6GZPS5AVd8XoBA9kiYfF6hzll9qAqh41bJ/e49CUmTdjldSIBzd203Aod2fJAR8QLMtoCBth2R/B8mvuox7wPRE6C8ovB7bIz6JD0fUcnT5AKUr1+nWjskjOqjOmnEab/WlN6nZPCPQXZwx8C8huXckwkC/mDimzp1iZQZ6GnAY+/9iPoSpYm7Z7VKRD96786+4A1hOgPjCBaY7csMGfIM23lhYRayoUi57MAiizyKDU7Hnh7XGHYnqs9E8aUeUfZE32aHG+nk60ESvgTjZjPDvi6rAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEqiAU34G+czhYkcdDXNiDKVvaxaguXzBPlTIZ3urSI=;
 b=KqimmuCDFzmcluuBlQDp9PdSWHXKXPUdnzxOZzqquaAjnyEr7ALHGUMMjfmYx4YdUBZFf2jkqUZdUMEmcCFZ9onN4ropg4NuOGVULNoSbxlkA1Ue//2kWm0ctqz4RuSG11vN6QCJlYoBCZjZN3+VxzsVu6G53LX6FlNFDLGWWm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 16:16:23 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 16:16:23 +0000
Message-ID: <aaaab5d3-047c-4d48-a4d9-cb5b4adc733c@amd.com>
Date: Thu, 3 Oct 2024 23:16:19 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] iommu/amd: Modify set_dte_entry() to use 256-bit
 DTE helpers
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
 <20240916171805.324292-4-suravee.suthikulpanit@amd.com>
 <20240926195648.GA229871@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240926195648.GA229871@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb0a25d-d88f-418a-04ab-08dce3c6b8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vjh2eFN2RmZHcUI0Rk5DT292VDdrYURqSElTcFR0WGpaQm54VVFpdDNnbGdM?=
 =?utf-8?B?dEZRUHY1NCtuMnU2aHdGazFuZjd6K3NUNnREYi9VcGtVWjFHeDBOS3FidWJF?=
 =?utf-8?B?T3VXV3NXVi9jc1d2U0tMQk8yMkNUTm1XQzRXWmV2aDdSSEhGNzJTM1JyUjBn?=
 =?utf-8?B?TzZXYmtCcnRUVHlxZWI5V1FjNTBuRE0yMVBTZW96bDVrVVBtWFVQL3ZsTHFQ?=
 =?utf-8?B?cDJIN0FDeDdmVmtBZTJJSFl1MG9QbzdrVEM4VkM4TVNpMkVKcnRDMGd6UTVk?=
 =?utf-8?B?M1NFUVpZL0xKakt3bGlTNHhOWk8vT3o0RytPYjVFR0JPMTRMcUJwdHZCUzhy?=
 =?utf-8?B?V2RoS0hNL3ZjU20xakFQdEJ6VFdHNWJzZTlwcmVHZXBaQUR0VStubTh0U1Zs?=
 =?utf-8?B?RWxHU09VaXl1dFZ6MTZvQlVlVmphOUVSbFEvYnBXREZYWUd6VU5nYWxXQkRj?=
 =?utf-8?B?cDhvcFBzRk5VUDlUeG1aNkFoSU9EWEc1eWJUWnhYRXN3UitRNjRuZnhEa3lq?=
 =?utf-8?B?cjFUN3RJK21tVHBlZ1VyWmZGVCtrUTdINTN4VWZad3NrbElJODlJcFZjU2JV?=
 =?utf-8?B?VFgxdHFiTHl5b0RLTFc0NlRyVEE2bWhDQzc2VERKRGhrdER2UDkzbmZkK056?=
 =?utf-8?B?ZStoc2M5ODFkMHZYUXRHWHMzd2tMVElqbWxubEI3UUIrUXFvNjZWNHM0bW5q?=
 =?utf-8?B?d09CVEhyZHM5Q3pYaXJPTUdBd2I0YVNDSjdOUklnVEtYcXY0NTdpbnRMalpq?=
 =?utf-8?B?Tno0bUUyMXZyT0JQMFp2ZmEzZ2NuSnBJS3JrTWxYYTl5ZFdTeFVhamNJU0w0?=
 =?utf-8?B?NWhwK0Z6NkxvVUpDR2ovWHlEWnJTVU1kZjl1c3VVMGJ6ZmZJMVhIKy90M2tp?=
 =?utf-8?B?eUZ1ejREVkZ0RU9seTVEOC9JNS9BYWhBWVpOU0hxeFlUNmZLT1FDSk4wL1lE?=
 =?utf-8?B?bFNPdXJzMmluMVMzWDhNYVBBRDQ3ZkM2dENGUndiVnhBZm1uTGY2RlJ4QzlF?=
 =?utf-8?B?cG80YkVVRWI0V1FJY0lVNWljTkc2OGZGaWgwWDZlaS9VcDNjdzF6bkl3MW1Y?=
 =?utf-8?B?OFhwTzlMbHFmSlBtSCtWaGxYM1dkNDEwalBEZ3AydHRpWUdpU0hqeDZGTkFh?=
 =?utf-8?B?WFlqSTY4ZmlndlFXTXhuVnRNcUVtZkJnZ3BXNHRJRG1sRis3V2ExVFFHUU81?=
 =?utf-8?B?NkJUZXJtY292TlR3OTQwVS8xTU5sOVFqNFZjOFZJMS9QRllTZGhkTTJmcnQ4?=
 =?utf-8?B?OGptNWVnV1pRb3hZaGRmNk1jT1BiWFVjL0ViVTZNSEhoSkQ0WVZrVFV6RDU5?=
 =?utf-8?B?SmdvN2FHU29xbENvdVd2cGY1WmV4dmUvb29rbWpSU1BpbmFwak5oNzQzWVRH?=
 =?utf-8?B?dnVpU2YrcmppRjJ4V2JmTnNvYm5HZUV2c1ZpakxKWEp5Skg3TUF4NDY3T0NP?=
 =?utf-8?B?SFdEMHRGbmxuelQzZjNtQlVLcWZyU3p1NFp4SnRzczdyU0t4N0NiSURRWDVq?=
 =?utf-8?B?OHVPaG1MbjA5M3lSNUtkYkRuWi81Ui9ZVDl2RzhzNTQ2c0dFL3ZjblpPZ0F6?=
 =?utf-8?B?MnByZ2s5bG8wbXdZWFh6aXorTDdXR3gvSTJQUnpNKzRpelFMZXBFUmQxN1g4?=
 =?utf-8?B?SUJsMmlORHhNcVdObFgxRUJWOU5kODdhRy84NFlBOFhHTXhGWDgvNjZ2WENi?=
 =?utf-8?B?eENkZXJkckR0QVMxZVhBeXJiQXNlUDdwYnc0VHpPRnFxNkJxM1Z5eDBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDBKcVUraWh1b0lLekZvam1UU01BNFRIRjNaVHJNMVJUcEoxQmdoeUFTOW5X?=
 =?utf-8?B?MGlkaVV1RFlnQnlvaCtnLzZnaW0zQ3VXNVo4MWRoU3ZRKzdmVmRWNHl3Zmhl?=
 =?utf-8?B?WXB4WkkrcE9oL01ReHdsUGFRU0ZRaVpxczhYUForU0Z1TWRSRERvWWlhM3Jo?=
 =?utf-8?B?YXVYSE8rMmY1UGV0NnhiUVNMR1I3emNhZ3pTRkJpaDI5QzBEU01OOXZYd01K?=
 =?utf-8?B?MVYzWWxHMUdXclNsbm1oSzA4NFhoSUVDNk15dzRiY3Z5QTFEQmxNR0N1VTVM?=
 =?utf-8?B?V2Z5T3pObkZ3d0kwOHFkcExCR1VVVWhTRHQxNFlZNUFQVVQrUFd4bzQ4RzJa?=
 =?utf-8?B?QU9HQm92VjRzY2hHSHcwK0tFSzFGcWp0RTgzZng1NWxIYk9QS0xhZ2pVTTVr?=
 =?utf-8?B?NUhBTFBDaXV3UlQySUliTWRnUXNtaXZMUjJsb1dJZVhneWtMUXFqWm05dTRu?=
 =?utf-8?B?YjQxOXV4V3ZTakllZTErUC9PTk9OVzY1enh5eTFvUG1aWmRick1KZXJjcldD?=
 =?utf-8?B?OGhLMzkxWDNNcWZtaUIxUHdLOVBCNnF6d2VoSGlFQkppYVhXTHdWRXJSaTN2?=
 =?utf-8?B?OW5vZnBWWlVWY1lRRmVYV053c3B1N3JRUEh4aURmUk5CR2ZDTGtNT0FsODdh?=
 =?utf-8?B?a0NHN05FVnpMQUF4ak92eklJSkNwZkxINit6NlFtVFlPYzhGbzkvNk80UFNH?=
 =?utf-8?B?UmRCL2Ivd3NtVnU2bUoreFQxc09hS29CWTR0elBCUzdsNTZGelRSc1d1TXc3?=
 =?utf-8?B?cTE5QmRBc0JGOHRFbTNOSGVaaDZYdlQrdmVEN3NHVFlYWXpMU0RsOG5XUjFm?=
 =?utf-8?B?SzJEY0FOckMwNmlJRDV6eFBqUkxMMHlEOGI4Y0lJNzV4WHg3a3l2TTIxYkIy?=
 =?utf-8?B?RFN0elpZV2xOVTA5cUNXeXF4Vm52ZnhtWDZ3Yk91a3ZxMUN2d2RLWmdzc2tO?=
 =?utf-8?B?dWpMUXZERnZtdGxKMW9qVk9ZWEZJTlcvYURBZ2VEeStRcnFjZWU5eEVqcFdn?=
 =?utf-8?B?dk5yNkswK0h1Z0ZGVnhsTUhpWTJZMU9FcCtDZVlPV1J2QWFYRlFhMTB2SEZY?=
 =?utf-8?B?RFhjV2hIT0luQU9GM0R3QjNVVDZLRE9lY0RjQ0FZSlZEejYxSE8vQU1rSTcr?=
 =?utf-8?B?aFNoOGo4eW9HZVlNRHNoN3NjRGo5cEd0cEYwc05Db3RJS2h6MWhSMlc3QzRT?=
 =?utf-8?B?WkQxRmkrd2VmdTl2eTBJWFlsV3R3dnpZYkh3eVFmS2lvbEVGY2J6ZEdOdU1z?=
 =?utf-8?B?NzlxT2V4TnlCYmtBekNlRThDK0Z2eUtFMk9kQXVaZjJWejZwYkVrYk16US9T?=
 =?utf-8?B?SFZEdW5iVGhZTW9FeFhaY3JXc2pjSzhoTURtV0JHQk9Idmp0eGg3UEJCRzVp?=
 =?utf-8?B?eGhmcS9HVVovbzZ1ZGdIcDlUNk5CRnpDQlFYUkdrcW43ZVllY2M5aDMrQWpm?=
 =?utf-8?B?SkNLQld4S3Ztb1VyZ3B5UGtVSklxT0srZ0ZVMG5ZTS9NN1Q3YWxqWmVkVEUy?=
 =?utf-8?B?bHNLVkFLb3BCYitxcTc0ZTU5V201d2lhcXA1K2JlcjI4cjJzbEc0WnhGeTV1?=
 =?utf-8?B?S0dpb1NMNXFoUVNFUmZQQlRVZytnTjE3MWJqK1dkTTZCaitBZWwyQkNmaTZQ?=
 =?utf-8?B?a0ZRTytwdnBrMTJrbEpzMDI2Y0hOVEVIdGZrRVkrWXdrTjYreFJBaVZyQmM2?=
 =?utf-8?B?SVdsYUxTSzJKaURGR2RMa2drNElkTGNuQjZCR1NFT3lkeVZ3ai9hdzE2Q1VM?=
 =?utf-8?B?MkFQQkQzYy9GU3dLRFRUb3diVENsWkJDd244SnVDZWpLQWQza1ZBaWV0Vm0y?=
 =?utf-8?B?TTZKWXlweTY0cG42QmJuVnZESkNLRWVYd3Bpa3k0K0JRcENGZHlmZnJHYkFL?=
 =?utf-8?B?ekpTUVQ2WVJJS1pFaXFRYXZNeFd6V25GUnhqTTZ6RW5iUk1rek1BUGhCV2Nu?=
 =?utf-8?B?V09Xbmowb1dzTjRTMnN3c1djcVhoTnlBeWpjKzNhMmdkM3ZyZnhqU2c3Q2xX?=
 =?utf-8?B?akRIVGw2Tmc2SEJpN0Vza2NvOHBRaU03U2tyeDZPVGgzbWxmeE4xN2FURCs2?=
 =?utf-8?B?TytnbERJbGQwVFBnNG5YZi9XRFBWcTRzZkVmUVBxZ2ZKOHM3NHFmNW4vcnhh?=
 =?utf-8?Q?eC+CQNTIVDCdu6YAWOXeoBvtE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb0a25d-d88f-418a-04ab-08dce3c6b8f7
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 16:16:22.9203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFzw5gbWvFGzplNjbmRB0Kk0bO1hnJDw8W7kq7kz2w0pKjXbpb1NkaevDvmARYOxdnM8Ldv50J79fr2s9ihkxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769

On 9/27/2024 2:56 AM, Jason Gunthorpe wrote:
> On Mon, Sep 16, 2024 at 05:18:02PM +0000, Suravee Suthikulpanit wrote:
>> Also, the set_dte_entry() is used to program several DTE fields (e.g.
>> stage1 table, stage2 table, domain id, and etc.), which is difficult
>> to keep track with current implementation.
>>
>> Therefore, separate logic for setting up the GCR3 Table Root Pointer,
>> GIOV, GV, GLX, and GuestPagingMode into another helper function
>> set_dte_gcr3_table().
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd/iommu.c | 117 +++++++++++++++++++++-----------------
>>   1 file changed, 65 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 48a721d10f06..12f27061680d 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -1947,17 +1947,58 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
>>   	return ret;
>>   }
>>   
>> +static void set_dte_gcr3_table(struct amd_iommu *iommu,
>> +			       struct iommu_dev_data *dev_data,
>> +			       struct dev_table_entry *target)
>> +{
>> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>> +	u64 tmp, gcr3;
>> +
>> +	if (!gcr3_info->gcr3_tbl)
>> +		return;
>> +
>> +	pr_debug("%s: devid=%#x, glx=%#x, gcr3_tbl=%#llx\n",
>> +		 __func__, dev_data->devid, gcr3_info->glx,
>> +		 (unsigned long long)gcr3_info->gcr3_tbl);
>> +
>> +	tmp = gcr3_info->glx;
>> +	target->data[0] |= (tmp & DTE_GLX_MASK) << DTE_GLX_SHIFT;
>> +	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
>> +		target->data[0] |= DTE_FLAG_GIOV;
> 
> When does this get called to install a gcr3 table without a v2 domain?

The GCR3 table is also used when we setup v2 table for SVA stuff. In 
such case, we would be setting up w/ PASID. Therefore, the GIOV bit is 
not needed.

> Other than my remark on patch 5 this looks Ok to me and making a
> helper function for the gcr3 case is a good step forward.
> 
> Suggest you follow up with helper functions for blocking, identity and
> v1 as well :) Then it will be really easy to follow.

We will look to simplify the code in the future.

Thanks,
Suravee
