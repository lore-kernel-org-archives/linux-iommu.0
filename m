Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010029.outbound.protection.outlook.com [52.101.193.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D66292B54
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764052394; cv=fail; b=AsLG2zST3K9ptAQDXvnc+59KQ0Ss0xA9pktEAoMctDwzI0QxFAGq3NtwjmD3B7XYw4L/Z2WmfaGyopfAKGTr8kHv99+izYkvKqs78upI/bKa/N0TMBhz4OTepximCEnhgTwsHgF0vKuxBQ+Dz+aMEJGFm61eD/alobeoAs2nUTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764052394; c=relaxed/simple;
	bh=Yn91Fp5ruzOjqlRjSJikLZ7Y4Y2M9FgMvlMMDWYo75Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kngy7Wyeo84LRl44Yu0kYF9kHD7qIHgfBS99kkiMxRSL/lmQA8yOvyh0um9lBr1kqDX2lrj2sI0Zqy1jSZCcBllff6Syzb+lZZT3NjpHg3PZ9QfB7eeSj/UXoWo8GnVHSE5FKrSaRBpbA0KcncW2+D8VjCW7zezvbr6pl98BITo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1vIAYabm; arc=fail smtp.client-ip=52.101.193.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1vIAYabm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9nO6LOzJXG9IMvGa5fWBQiCb7RUAQlRVmFJifF4y8p9jkpm7A7dvKBWwdC2UhM/44cwuijS7ctybW66pXQpxXMeSGML7LleSkgcnd3oo6mC8v0UaDPNSLhkGMYM8qzQqmwYDQw/HodF8XYemTwhCdFOuPRCbk+xs3gnwfN0LZRfFue4N3wE1j00CYNvEAYnHyz2tmzb5AepAcmfsZKebOiI8OjlnY0bw5be8WL9HC/FZ35GZnBerwuiuotBjrheDj9ATZDAL+yzjoHwr3hoyE99kGAbvvVjSsiEHfUDc5VSGNrPlcHNwsoN7mA6+k0UiLaTe+lxwPMgJdzIe1CWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgYuEqlliyUen+JZIFMG+TnJ1CQknD1B98vzFmSiXpM=;
 b=MkcS4DFapmGisgDhWCk+O550zZHvBk0zsK/1y1rTN5z1kLZ5dVsl0KcJmyL9uaX0dWy+R1AvPiSWwwUqkaXqbGYOCZTKCgqVVHVzdiRZCCMzICjGB5sEP9feKjsrXpL4M+4SN3VaHwbCI4drQI8IqwSfnwZmbGKoalaAQUtvO8RqAI/gvn5PW/tUhzUac2qxQd0ZqhiMlbpWPLE6+OVjkupY4ajBib5shVZMvJlDciC7+1qkrzgaQCI131Samo2Zi7JiClHLL38depmzzSF0BJ4IbZXXrQjAubmFIL3OG0/aEJ3nlI1nzJEmmS/172q79fklcc2FpXw9xzwJx0AWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgYuEqlliyUen+JZIFMG+TnJ1CQknD1B98vzFmSiXpM=;
 b=1vIAYabmxrOUtbMhxeb7EfaSVP3cUFf/JUuIGAQKWb2Hh8I/7UPWPQzMG8P7XNxgmrpIHoJG67xHGh3n879f5j0AFKf5TtfAcqVS3C8I/jrR0rbwfynJdgQgwd9qkwgVf8C4QyrhoL37+IU/8W5BdBKKvN2csMmEWjFUxq37Rc0=
Received: from BYAPR08CA0017.namprd08.prod.outlook.com (2603:10b6:a03:100::30)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 06:33:07 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::4b) by BYAPR08CA0017.outlook.office365.com
 (2603:10b6:a03:100::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 06:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 06:33:06 +0000
Received: from [10.136.40.237] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 00:32:59 -0600
Message-ID: <175b697f-6e0b-43f8-86ec-82b0e550b88c@amd.com>
Date: Tue, 25 Nov 2025 12:02:56 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] amd/iommu: Preserve domain ids inside the kdump
 kernel
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<robin.murphy@arm.com>, <ashish.kalra@amd.com>, <will@kernel.org>
References: <20251121091116.25663-1-sarunkod@amd.com>
 <20251121091116.25663-2-sarunkod@amd.com>
 <20251124144458.GH153257@nvidia.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20251124144458.GH153257@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: f37df42d-4ef8-4ee9-d2ea-08de2bec7e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3FiN0kvOW8yemp6TkR1aTFSMUpJU2pGdkVXNm9ackY5R2xldklMOENMalVF?=
 =?utf-8?B?b3JrWTZjclhYMVRjNzFNeDdzVkNuRmYyNkVoWjBQWm0zRDdPemJuQlV2RVJn?=
 =?utf-8?B?WHhNc24rSWhxMnlSRnphWVhsc0trSHQwVFZUUkRxZFlFWjBNVHptemRkNm5T?=
 =?utf-8?B?bDQrTURNUWh2WlRpZytYZ2pRdkh4TStkdjRlcE0zZ0RCdUE3QlV2disvQXAz?=
 =?utf-8?B?cnRjdENpUVN2OXZxQUhKTW9sd0pvc1RtYzlvYThpV1Z1T0VnQ3lhdlJUOXVU?=
 =?utf-8?B?RXh0d3N1eW8vVFRaRUhrdXBBd0ppVjJNcTVHTTlKUjFseE5JUzlnUnNrNFBo?=
 =?utf-8?B?c0QxWkZ1Z1lVQk1rT1RLNVZnTGh2OUpmM256WjFlU1ljWE95QVdDZGwyV0tO?=
 =?utf-8?B?VHZMZEtwcTRMVDI3ZkdwSnltV3Y0S3FzVmo3VDFEdXBHenU5Mk1ONHJhZTFz?=
 =?utf-8?B?Rm9XZ0d2U2VUZlZmZnArV0lJSmEyeFpmOE84T0JBOEdQWkQvU2d2dm1UdTRQ?=
 =?utf-8?B?WjJnRm05aU9ZVmRFL3RyRFM2UEFGQ3BacU1HQ2FEV0JSSU1zc3IyMXI1NXBB?=
 =?utf-8?B?bFlZWkQ3Sm4rY3dpRWNMTGxkWHQ0QmpCWGVCZVU0dUpldzN6RXNBeUJCYW12?=
 =?utf-8?B?MS9BMUpiMEt3SGpWS1BuanA4eG04TTNiOTcvUjhuOUw0aVhKT1VEcURYbW0w?=
 =?utf-8?B?QmZCenN3MTNUUWtGN2l3WEcweUJBeHR0cFFyajFhV3pveDFoMVVpdGdob2la?=
 =?utf-8?B?TFNlQjJWODYweEtCY1JrSnp2blVRNngxamNBVTJxb05PbjQ1bWc5MDE3OExt?=
 =?utf-8?B?cFV4bjRQcVk2TGN0N3ZmMHRmeTFJMTFQZTlzcVo1KzBtckt2Q1drMXJkUEZy?=
 =?utf-8?B?TFpOUmRkQmsxZ2lkdFlreUg4TURvRnJIdXc5clJXckR5KytqNzA5QitrS2c4?=
 =?utf-8?B?c2FNSFNjWFFWSDBQSnlsV29zM2U1ZkNPVlIzci9oTDhTcEUrNVZNdGw5Q0pD?=
 =?utf-8?B?MklnZ1F2VHY4Z0RhWHFLcUxESk9CVk9hT1BXcURzRjdwdGQ3Q2ZUcTZZWGF6?=
 =?utf-8?B?Mm5KNUZueHZtMVRuYjVFU1JJS0dsY0ZkcUxieGc0U3RiRkdGWVh0VGMwSElD?=
 =?utf-8?B?NHd3Y3NkbEhwaVZNSHBDNFpuSGUwUjZuTFJ6bEdzUnBSenV3TjVJek16RjFa?=
 =?utf-8?B?aktVMjlCL2N3cjFmUkFLVmRkM3VBM2UwRTdLQmJyeDlYN3NzdzZ4cmNwcFFk?=
 =?utf-8?B?S2hOb3NIWXErQnNXQVN1alZnbTh0WHRVc3hYZmUzaFpFcmw1MlcvRDZmRGVS?=
 =?utf-8?B?VXRXM093NlcwbVFNU1plRWZYWE96emdjazE5Sm1NSTNwMDIrc2JTdjRpa3BI?=
 =?utf-8?B?RXJlSTNoWE5CUlNuNWR1R2hxY0hHbHpVVThKdHVEaU4wY2h4SHE5dmRqa2l3?=
 =?utf-8?B?akN5RThPZXl5YWM4NW1wbkowUHZuZFgzQXBxOW1ERFdrb1VKSm5XRU9NSWFO?=
 =?utf-8?B?dXMwUkUxUmdzQ3JHR2p1cTBzWmlSanVjbDlSRkl2ekhKMzlsc3VnbkxlSGZX?=
 =?utf-8?B?R0hQYk9hMEFoaXU1TlVDZWJNaVRlYndvcnJ5TENOVVZ5T2N1blJoOVdRT0Yy?=
 =?utf-8?B?amdUQkZ4Ykg5aFFnaHVBZVJYdmFPWWkrcndub2I0TitISStkakNONlNOYUQ3?=
 =?utf-8?B?aThncG4weXJqOEpsZmh2KzNsLzF2RExGM3E3UUdObi92WXZSS2k2QmZOYlAr?=
 =?utf-8?B?aTREUlZwZEVPR0JuNTREY3gvTnZld05pclRlODVBZnhya1BkWXh6aUJiNXVz?=
 =?utf-8?B?TVdISHJUZ3EzL0szamxzcVBIaEpyZ0N4ZTBML0F4RUZzNjUxTWhGckg5UmJw?=
 =?utf-8?B?QjVSY0pvUUpsOGx3YkNFeU52OTcvYm1GN0dKWGpCcUxuYlB4Y1h4R1pHajcx?=
 =?utf-8?B?dUplOFIvNTFoSWlzNXpNNWtOOHJSeVE0MytRUTN5a3FucGhTeE9jNnNFTkp2?=
 =?utf-8?B?SUMwZ2paSDc3YzBJZWRtMks4TGNsZnJYc1kvM2lnMDhMOWVCUXdsWmdheHk1?=
 =?utf-8?B?bVArMHNGZGUwZmxERHluNWhNVHZZZU9oMUh4TFNYQmFtbnhoREhJODB4aXhj?=
 =?utf-8?Q?yRNM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 06:33:06.7607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f37df42d-4ef8-4ee9-d2ea-08de2bec7e91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551



On 11/24/2025 8:14 PM, Jason Gunthorpe wrote:
> On Fri, Nov 21, 2025 at 02:41:15PM +0530, Sairaj Kodilkar wrote:
>> Currently AMD IOMMU driver does not reserve domain ids programmed in the
>> DTE while reusing the device table inside kdump kernel. This can cause
>> reallocation of these domain ids for newer domains that are created by
>> the kdump kernel, which can lead to potential IO_PAGE_FAULTs
>>
>> Hence reserve these ids inside pdom_ids.
>>
>> Fixes: 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   drivers/iommu/amd/init.c | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
> This seems OK
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> But the a point of this work was to remove this code:
>
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 48bca4dc8eb61f..1cd799913cbcd6 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2024,7 +2024,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
>                            phys_addr_t top_paddr, unsigned int top_level)
>   {
>          u16 domid;
> -       u32 old_domid;
>          struct dev_table_entry *initial_dte;
>          struct dev_table_entry new = {};
>          struct protection_domain *domain = dev_data->domain;
> @@ -2080,7 +2079,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
>          if (dev_data->ats_enabled)
>                  new.data[1] |= DTE_FLAG_IOTLB;
>   
> -       old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
>          new.data[1] |= domid;
>   
>          /*
> @@ -2096,15 +2094,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
>          set_dte_gcr3_table(iommu, dev_data, &new);
>   
>          update_dte256(iommu, dev_data, &new);
> -
> -       /*
> -        * A kdump kernel might be replacing a domain ID that was copied from
> -        * the previous kernel--if so, it needs to flush the translation cache
> -        * entries for the old domain ID that is being overwritten
> -        */
> -       if (old_domid) {
> -               amd_iommu_flush_tlb_domid(iommu, old_domid);
> -       }
>   }
>   
>   /*
>
> Under the reasoning that:
>   - domids in use by the prior kernel are reserved in the IDA and are
>     never used by this kernel
>   - domids in the IDA must be clean
>   - There is no reason to flush a domid until it is returned to the IDA
>   - detach_device() calls amd_iommu_domain_flush_all() before the
>     domain can be freed and the domid returned the IDA which clears the
>     IOTLB
>
> Please add a patch?

Thanks for the explaination
Will add the patch for it

Thanks
Sairaj

