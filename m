Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522EE7083C
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 01:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558781; cv=fail; b=T/d3La+pBGxxsH6lVcmM9GrTMwktUJe+EOU7VZ4EPe9yeCuUyojzr3Ez3+dGt2gCtaop3p8tgC169bvZL5Q3Jnx4JwtfKh+CpITg29X+lfbOP6lg/iTtntwopDFpJHOYWMhBZq9z0MA8hjo3ySw7sgzqtTMYwXXhYryrigIs0tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558781; c=relaxed/simple;
	bh=geNcw279zn799QgytApZg/6q0vmH/JVTMZ/5HNuggf4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QpsRiJ+TsXyu6WKn/VcGBuBEynCw1Dmxr051t8MzgRx6caVbULHtKTQwZAff54Qaq5zwQVWi3XLFUIGCg0MY6bJxRz488Oa4agHYjl+9soWu2a9izG8dko4GB68A/zFy80qW8n2fIBaDjFc4eB8SclznyvahTSkNB+5Qaafg6Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KI6uhAAw; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KI6uhAAw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hd628v74mLluPNqm8o5vuQq7lC5g6SXZvAGHvmKM/+yb3s8ObotN9aYuGx0PPHcJBJ+fBhCLQB/rjyL0ClwuebFCJewZ2baQFYFF5WaQFI5VpVUT0Th8ZLT3/MJc82LtBxZrNNibD0XUL1a0FxMWS7iN08+/vljTplTO4Bo8mswMiDTbJop1gJLPVE0bT3HW7FWl2jM7gvC/WIQN4VkgryCc/D7jAhw9PmZJIVuLM6wi22aT/8tPykMzWvqmO6n8YCcH2oa5sxtK23wcL26Zj6yGsCLxNVK1kgSfRQmft9jAyJZbygUxRG38iFS2WTsxSQLe46UDvZh3JfL1MjkYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLl3NF1GNuW/kIldYaFZKhlazPZirYjrBsMrEu9tSHc=;
 b=iBD+rkw0ABOGTSF7VQuPJ+nFy9Da1LyJ4duBLLAF7QeWl+mepHZOBCcW5zEYp2kDb6/QNDTba1zNO9nRx8W++DXeiyuH17K36bEnob9U7o2xKk+LU9eruUIrnL1WD5Czw3zpaFFLloFOfiPdcWCMFovEtI1gQrpf3+RApGJ6gmtXmrMMl/SLkyMYO5zjnrQqdZrrrKSayLbD37IrLeio3XGU2y+JbvaRx1KJZmYUwfy12TUPUGJKsXp2j+j7BDwIFADk1TEFJJnzAhy+KJavXOyxVdaZZN6XKE7xe3wiEJ4yisKbGw5VL7hfkkxFfcDSBGGtTYcd1Ktl/UaUKqJatA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLl3NF1GNuW/kIldYaFZKhlazPZirYjrBsMrEu9tSHc=;
 b=KI6uhAAwS+XhUEvp5fSquGtU9qI28+NJ/A8vP46EOWKViRyvkkuN3PxfITpo1zpiEREGYq07yGCXuGvdZIs+5ixkjMZMwNw6H/Wn8Slk7BaJgYu0e8OdppWcpvfrpoUHf2mSR0LbafMiLIXnsm5myb7V6g59Gr20FhE8il10ABA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.19; Mon, 28 Sep 2026 01:26:17 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 01:26:16 +0000
Message-ID: <19b16cb3-b4f1-4f6b-97a8-0f06c9ae3adc@amd.com>
Date: Mon, 28 Sep 2026 08:26:06 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/24] iommu/amd: Map vIOMMU VF and VF Control MMIO
 BARs
To: Guixin Liu <kanie@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, joro@8bytes.org, jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com,
 wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com, guanghuifeng@linux.alibaba.com
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
 <20260914184750.222939-7-suravee.suthikulpanit@amd.com>
 <e0ceffa9-4c75-459d-9298-dd1663d88fbe@linux.alibaba.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <e0ceffa9-4c75-459d-9298-dd1663d88fbe@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:d10:32::13) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 898eaa7e-fa8b-4211-d039-08df1cff7dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|4143699003|6133799003|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	J/PZrR2sgBPMaU6KEMMjDLywXVng4QuCbQ7Vteb4py06Qm9qApCPESSKdm3hziRuUnY1EOmFgsph2ZCthMnAy0IyGfzcZY+TxbxTcOOgb8GRf2MJK5otkmz6+sPoKv8U9LpT7EbHhmnUk7BCJrT3u0R7MMPalJn5q6TV8KSD8Vht1bi2ZQ+LLP4zFhaQDhliirqGOk4r+Lpv+pcnu/zRYV8N1u428IIABP2pK4er/IomemuhraED3rKufZz5BBsCL4cFtQ9P80n0ihZhoIBtOO9fWczHBb+pF6AW4CMiagc3oH5nl2BfcjB3r6Mo7P1OeLDWpwxARiRVJI19k22Th0fZfCcIw+mBkxvM2CRKyCyiyzQMY6R3jYxaQQqe5j9niUwwW+YJIgTAAiAh/CgDp1RfXQB2+8mwA/zhAy86Gw1Hly904sKO1sPiN/Tw+4IgfjkrMs/PIkLzAuiEfkqqgCUFszYnz9MeMINSTFCxEH1q9rLnL8a4mOkrNxUGvGQs3WCCAV500UEZeri7q7EAxMnlfmHapRfmUzLrbN5Rw3U/dh++483q/rhFbdOvSa7TeAnBcRcy9Li4Ijl6nNFnrkEKjiOxZKVB1rBuQh7WPGzqtqyE/WDc4kYfW95qink4mqFaZ1U9IaCKetkzmYWAQ9jmaeHu9z2/vlW9IkSd9p4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(6133799003)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFMveWw3eVZ2UnNUZkMwaW56UnVvVHZZK05VcElHVXhoeVJBbGlHenNzTC9C?=
 =?utf-8?B?YS85cm1KNVpMdEw2VmxENDJGNHNsYWlEMG9kZTVZK2pVS1A1cU5yVjVxVE9o?=
 =?utf-8?B?dysyZHpNclc1Y21NMzRsVGV0eUxCNU1KVEEwelNRTWVmeUwxVkdTRkhhekFT?=
 =?utf-8?B?ckp4VE5IclVsT3M4M1picTFJQ2IxR1lvcTVKNmRQYzlpeUhiWW5TNEJPMXBI?=
 =?utf-8?B?Y3lVMnpvWmgrZWZBZHBMSVZyaGViV3lySnFidHE0c0cvOHlaZ2kwZGp1RmVI?=
 =?utf-8?B?S05YeW94REhsMVZXc0owQVFCMmFCeURQQ0dYQlVFQ1BXV2I0NzIzcEpLeVZ2?=
 =?utf-8?B?VHk1Rk5xVDFhcjA1cysvL1VLWHVaVktqUXN2QXJ4aW9YQ0NJbk9pMVRRYjM4?=
 =?utf-8?B?QVQrdktmVHlxVm1zOE5QUEExU1NiRUZTVi9PNFVUWFhRL0NGMkhZU1VlOGdu?=
 =?utf-8?B?dVEwU01Kemo5eklzSi9PUHlFVTVLaERRajFWeVc5OXZ3K3lWdldheGI4dDBX?=
 =?utf-8?B?blpXUmJid2NOTzI5ZVRFelJVS2VRYVBObDI1aGs3aDZvN1h2TU1za2ZsdWt6?=
 =?utf-8?B?azY5NzFlTW53dGVmeVBIY24wNnl5c1NCQmErVEtReXRDQWZuRElobkNlQVdt?=
 =?utf-8?B?TTJNelJjTmVVenRJbWZwZ2k3eXlkUGV2MzRjM3p6VlgwWkpVQ2RyaFAraS9k?=
 =?utf-8?B?T2NhODhBMVdWVXdpTnppbWZzZ0hyZGxPWVhLTlY4azhnUmtpNkp0bkJEejc2?=
 =?utf-8?B?cjdDNGtoeVVITm1UY1ZkYjlhemt5bGtsdDlEc0lWVGVaMytkT204QzN2M3hu?=
 =?utf-8?B?d1dNcEgzMTNPVHp6U25ZNFQrSkRTa1Y0bFduVmd2K0ZsQ0ZRWnNyTjVpamxZ?=
 =?utf-8?B?dHk0UmpZRHR5VHVGSmJJQlV5TGtCd0dNRjhubnQ1bDhWT2ZmQTErL1pBZXh3?=
 =?utf-8?B?VStuTThPU2d3MjdtOG5IejdTRnJsN080Q2grTVBJZ0oxSVQrYktqUHNIQTU4?=
 =?utf-8?B?YVZCNlNJZkJ6QzZjZDlKVEhlbGZER1RKeThUT2ErRTIwMkVtSGt4VkVneklw?=
 =?utf-8?B?Z25KRm5TWndZZzZTd1I3YTFRODdzYThDZk9mTlA3M0ZKT0wzRWFFUVUxaGJa?=
 =?utf-8?B?cUtiaDFMVGQ1Yk5SSWxmZjdhOXJqemo4WUZsclNDV3JLc0VTaWxqbmYyQ3ZY?=
 =?utf-8?B?YXpDck5paE5PMG1vT1BKRGNndVEyWjB0dTJ0NUtFaXNCZlI0ZVRaZ2g2ZXlC?=
 =?utf-8?B?bW13NEc4cTVQeDc4dzMzYjNNd2ViTWpTaXRYT3Rlcll4RGc2YUwzSndDWm5J?=
 =?utf-8?B?YTRpWTBRS01oaGdEUldwWHo1YnhUQlE0ZnI2QitMQUcvaTJpanUyL0dVQTFS?=
 =?utf-8?B?c0MyRWw3YjdtZGRGNWFieVNRT0taNEtzTU5wcVU5eXJZa05FWnBGVFd0QVdl?=
 =?utf-8?B?RTVmTXBqUG5wNVU4dVcxb3NsZ0tvNi9jSzNGbExZeVlkb1hLakRyWmFvQ1Z0?=
 =?utf-8?B?VDNBRkV5NGRCZElGSlE3c3NtNHRQK3NkbThtSmg4Y2lsQ1p1eFl1R0txYVpC?=
 =?utf-8?B?OE83dVNQZjh6UkRycCtGRnIyTVVKaDhlOWhucnVST2p4eXJRRXU0akVQZG9j?=
 =?utf-8?B?SEtGUERzZVBKOUhxVFViS3RwYzVEUVJGMVpxbzdJQ2dvYmFiWkZHVGhyNEJ5?=
 =?utf-8?B?MnBZQW5zZWZudUwzdHdhQjJZajIrazY1ZlROMHRuRjJLbVE1NnFuK2FXejcr?=
 =?utf-8?B?ZmJCYkVmOCtsai9uQUprTVVhNytrNWZKanBuTmk3ZXNJWDV0L0xzbHcrUDN2?=
 =?utf-8?B?VDczcjFrWHk4SzV3OUxqakUvWTJLYmRrTExFYW5kUDRldk1VdzQ1cWg1T3Ro?=
 =?utf-8?B?bCt2cjNvby9nUGpjS2xjSzNFTWl3T0RPMUR6MGFzL3hidlpmRUlRd2JyTC9P?=
 =?utf-8?B?Qm51Wnl5UjhvWnJ5bmVrVmVTUlJULzVDV0NrZFYyNjZzc21ITXowSmNxd2M0?=
 =?utf-8?B?RUt5YjN1RUxGNUVybnB0c3ZGcW16ejEzWC91OEJMOFIzOE5nTmpMaEl6Nlhp?=
 =?utf-8?B?eWp1d1ROdnEvZUMzVzlIaW9IU2Nyc2tsL1gxLy9BM1JtYnRyWW1mek0yRUEz?=
 =?utf-8?B?Y3hFN3hTYnBlVFpndjh1KzNuNGhFeDNGcUxUSjdaOHhPV2lxeXU4NmVDVGdH?=
 =?utf-8?B?UlEvbE1QcTdiOVU5UE9zajdwZnpIYTFWSTYvYTVsTlE5SlZ0ZGFXTHQwSWZr?=
 =?utf-8?B?UVZaN1NRcDdGcW1OVEUrOFE0MmNyVTRFa014T2h0MGhtMklWZmlJWHVFN3JX?=
 =?utf-8?B?Wkh3QVh0R2NmaGtDdXRaY0hPMG95R1RLdEVQbzcveU5oY2ZLRXFWQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898eaa7e-fa8b-4211-d039-08df1cff7dbc
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 01:26:16.2776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06EQgvqEyvfvcOSjEyciJcDHWiE8nOQ+VEtMiLKmB5e/s4iWc7ke3dWy2iB60nw/+jLqANJH39/B4eBq/lcg5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448



On 9/22/2026 1:43 PM, Guixin Liu wrote:
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 7b4cb473019d..79386816807a 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -459,8 +459,10 @@ static void iommu_disable(struct amd_iommu *iommu)
>>    * mapping and unmapping functions for the IOMMU MMIO space. Each AMD IOMMU in
>>    * the system has one.
>>    */
>> -static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
>> +u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
>>   {
>> +	u8 __iomem *base;
>> +
>>   	if (!request_mem_region(address, end, "amd_iommu")) {
>>   		pr_err("Can not reserve memory region %llx-%llx for mmio\n",
>>   			address, end);
>> @@ -468,10 +470,14 @@ static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
>>   		return NULL;
>>   	}
>>   
>> -	return (u8 __iomem *)ioremap(address, end);
>> +	base = ioremap(address, end);
>> +	if (!base)
>> +		release_mem_region(address, end);
> This release is duplicated with following free_iommu_resources() -> free_iommu_all()
> -> free_iommu_one() -> iommu_unmap_mmio_space()

I'll update this in v6.
Thanks,
Suravee
