Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010045.outbound.protection.outlook.com [40.93.198.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2422459D7
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994327; cv=fail; b=jIaBvEGmEg/C4bi69pugV1Ei6aLWgbMYzuZ293gPFoIsuK+tUjS5aJQL7sGL90kwZUdvD7qko2Sx7L0g59KpptYA0/QEMvUHFDn0Ek9PmMeulvS6QxKSDYePJ8QOCJrJ8nP1S/1qPUsFlwD32J10BZUUp726KIQm+kSYpi1sY08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994327; c=relaxed/simple;
	bh=RUPo5Y6b5SYBCW5N3aStxsbb34yP8oU0zRiwxjQASZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TUtVgnR2V+gMuJjV+tEzYOgJekoS2V7Jwh9BIPEztAgT+Y4rEe8YJPXFE2CUE9fGHczBSe3QDfG/20Fu0fgC8xZ2/mrNDnn0h5ysVA3RxQuHcD1+VmflIz63g3wGTcYmkzPHdkrnQZAcRoUAOwEzh0HeIzqusw3d0cpXXaq3abk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bt3CzPH4; arc=fail smtp.client-ip=40.93.198.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bt3CzPH4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9a7f2hEP323VPblbRYgUu8s6JViUP6uuUezMQeawcYkIQHZF1SCam2dXWnVmvo3h5BSMpju0ep7YEYRdKRRrZF/0eGq7BtFg1CeJgBAu/gbWm8uits8aeSe/KpWDwqUaN9acntlaOGo8vJNZOGmjRvBS4COQjnsWbqrn6R0XtN7ghghADNz2RxVvro67eMaR0lkQtP8aLlnFmI+Wrq/FvfaAAEkk8eoXiHyOFsN4GjJEYKYgnIgP6SDz3P5hQO4wCzwVbw/xW9mObA7dPam1tL+slAD322gA0QVe3OVhKqm/peZQvvQNOuzui7BTJTik05SeZ9TMpBhpprhfTQP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oC6RvycqsvUO2M8TBa7VosAeAS+9YFc8Z30Rpc7Mstg=;
 b=Ppf/uezZmO1fXL6GPpgU+diGOsNFU5glwMNnETFcrE6Jl3ac2v2TsJ/Uu5eWcVBMfg3bQxBvuP+MPb9U0fELbyCa+AZ7v9V/EivJfUzVQ+a/6DaeY75p+LUbo3dNWEgqmBDxAhGJPNL9q59eRcP2t/NyiVp5ROFeYOdGH6UpvtEd9Gn1+YzWi7wc8I9vo5z2lGJQf87GV8HXk6OiFJBBuiDnxuzBOO3HRHbBIa2AgYBMZ1BinAEv5DLi9dz9poL59PdaTwY14VstSxa6xQS682tEV+R6A8WlcjIkTrlG2W0Y6e7s7jEVpjOVEXnCn+i400JFQm7Yg7U8twuvks8G2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oC6RvycqsvUO2M8TBa7VosAeAS+9YFc8Z30Rpc7Mstg=;
 b=Bt3CzPH4tNYJF8/Sp8pfpt9t4bpVYeYKsH5Z1uCTSpGdT/sC5siQhyl3KED/GeBG/P1mdIfK1X2k9TRETbt91jxmYMRUGlSbgWXTpYFJMHunVIo20HBnc26vO3lVXD7EkM5al95r5Nef6TDRzb2eQZUl1kVjRuWdxB6z59D8cgE=
Received: from BN0PR04CA0098.namprd04.prod.outlook.com (2603:10b6:408:ec::13)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 07:18:36 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::bd) by BN0PR04CA0098.outlook.office365.com
 (2603:10b6:408:ec::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Thu,
 9 Oct 2025 07:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 07:18:36 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 00:18:30 -0700
Message-ID: <32d2a380-ec66-4087-83f6-339f22745889@amd.com>
Date: Thu, 9 Oct 2025 12:48:27 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] iommu/amd: Add support for nested domain
 attach/detach
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, "Suthikulpanit, Suravee"
	<suravee.suthikulpanit@amd.com>
CC: <nicolinc@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<kevin.tian@intel.com>, <jsnitsel@redhat.com>, <vasant.hegde@amd.com>,
	<iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-12-suravee.suthikulpanit@amd.com>
 <20251006145900.GT3360665@nvidia.com>
 <3e27de73-61a1-4977-b0a1-629ffaa81032@amd.com>
 <20251007234313.GE3474167@nvidia.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20251007234313.GE3474167@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: edc37460-d4fa-44b8-c251-08de07040fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnpTbVBTbVp3djhBNGJQT0JuSWNJcjl1MFprYTVCcnlYMGI5Zk02SWp0aWpB?=
 =?utf-8?B?SmljQzh3dnB6L2xDbXJRYzFwSFVXdWZDcGttRkd0MWxIamx6S2JHbUZNM01o?=
 =?utf-8?B?M0NwZ0JZeXRncnlGK0d6Yis5QnVnY0t6bkhLKzIxKzJMZ0ZTTzBTejVQTlpF?=
 =?utf-8?B?bFlMZkhyWlpuNEc4NUQrQ2RZRXRadElKcDErbzV2eVBSdUpuUWVSMzkzSzgz?=
 =?utf-8?B?U1RFNDlNMjFnNDBFVDloYWp1VUhXbzJoNENkTlVxcEwwSkdzYmkzelNrSm5n?=
 =?utf-8?B?WXM0WStEM0l3SThqTmh1SDRSVUJkaEMvdjlnVDBkczEydHh5SFFWSUFUaWY0?=
 =?utf-8?B?d3V4YjFqNWZYblJqakJTNzNjbUJObGp0bitpdTA2Z2d5eGsxMnJSMEZ5VmQ3?=
 =?utf-8?B?S2wwaVk2ZnhzRm51dGRxVnpVNmZsUUd2bHNFcGswbWhTSTVHTGxsSFJHZWkz?=
 =?utf-8?B?SEhJNXZ2WWtGdjZZT3ovWm93R1dZNjQ2dWU4NzFZaUEzVXNiVnQ0OVVxNi9j?=
 =?utf-8?B?cERVUVZUVG1IMWNSVHF0RUNHL1lGMVY2NDFqSElDL0dNRzdlTDEzYmdHZFdq?=
 =?utf-8?B?b0hCU3pNUVlHQ1BOZXhsaU5rTmo4eUdCamlnbGVxZ1ZkSjlvRnNEU2pzdEdO?=
 =?utf-8?B?dTkxNi9rVWtWYnNVUDFCV25XVWpjRTlnUTRBRU85Vm9QZ0NKVDhxL1B0d1Zw?=
 =?utf-8?B?NzZ6ZUtDZXN4eHdIT2RQbHlhR3hEaHlPMUxZblBLdDlCWFBhakM1Z3MxU0Yw?=
 =?utf-8?B?UytJTGROeXBkTGtiL2gvbVR0eG9HVHQrbFhnNEx1Nm9yYVhoM3NsNENSa2w3?=
 =?utf-8?B?N1JkNFNIL1orOFd4UWlhN29RK3hHT1ZVRUxyeUppQmFVL3pScGRFNzd4MTJU?=
 =?utf-8?B?T2p6a3RHWThpeThJaUFpWDhNUDI2eVdWNkU2SE5hUWJ0bENwakZ2N2NSYWxD?=
 =?utf-8?B?MGR4MEtZL1pETkpuVnZYSjBSZEVlekxIZnFXUWREMENhMG9aOTQ1bEs0Vk9C?=
 =?utf-8?B?cTB3VkxLTFZ2MVlzcHlzNVNqSldLU3ZuTU9OelFKQ2F5YU96ZUNxZVlpQXQx?=
 =?utf-8?B?M1dPSDMzdDdrclluTHNnTHd0L3p3NHdZcUhvbXQ4NGhocHBIOGRCM0RteGsz?=
 =?utf-8?B?T3RMZmJtUVBXOFo5Tyt2KzB1MVM5QVEycU5IcVNxdmsyTWUzTTV3ZlNSYU5H?=
 =?utf-8?B?SjhjckdnY0N5MVBHYU0vWUFwZGV4ZXhDb2REYTFqYURKMFNZRFdPcU45aHZv?=
 =?utf-8?B?dm5XSC9KeVMzQ3ZIaXhmTmljakx4RytiK21iTGQ4VWVuem1GZkFBT3I5cjdo?=
 =?utf-8?B?NElYRmtYRlljUkw1eklBR0lNOTJaZDdQUmpYYVNOLy9qOENlMmhXUGZhT0cz?=
 =?utf-8?B?a05KUTlBY1NmeWoyT1NlTlFUVS9yVkNUSVBzSlRNWmZvbndpVUVmZnVvZndK?=
 =?utf-8?B?V1ViNTBDTG9FdFI1UHo4TVVvMkMxc1BNcm1YZUlYUHkvMFdHYUVsNldPZTVZ?=
 =?utf-8?B?Z0ZyUWE3L2JxWEpmMGJKc3NWRFNXbHFmYnR4akVoYWxKUFcxZXd3b25VK1I2?=
 =?utf-8?B?M2dLZWVLTjIvcFhLelRFOS9zdktKL1QwbUFrVEVjMm9TSTJ2OVdFbHBxL0pH?=
 =?utf-8?B?RFcwYWxiV2FCV1BRenZndll0SlFFTTBkSGMwcFpsR3RqcjVUNFNpTEhpMEpl?=
 =?utf-8?B?ZWorcGhNT1pmSEVMbUNWeGEwNnFWOXV3SFNWOEJ5KzQ3VEFSU1h5RjMrbk85?=
 =?utf-8?B?M1YrMEUyRW9NamovNlF2YlRHcUd3bG1vaUw1cTYxRU90dHVnUnA4MUVmbGl4?=
 =?utf-8?B?cWFkbkZwV09qQy9aaWJ6RTgrVU5SZ1M0QndWOXJ6eEE1RVhxelUzWWJ0MFB3?=
 =?utf-8?B?bWNNVDk4SkIxOVExR3JKb1ZrNjBrRjU4dWpHRy9GME84UElLd2tNTUdtQnEy?=
 =?utf-8?B?UHBGZlFXVFNQMVJEa3NHTmNaajllWTZGOVplTzVBcmNKbUdMakRVdm0rU3g0?=
 =?utf-8?B?bFREUkRTN1llb0hLUTVibjAzb0IweXduRDU4RGhoaEwvSEVJSnQ2cFFUVUJw?=
 =?utf-8?B?MnU5TjZ3aDUvblozeHpPYWZkREkxa0I2SnVvRFJWN3Z4RnhhYys4TkxDaEFn?=
 =?utf-8?Q?aDq4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 07:18:36.2438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc37460-d4fa-44b8-c251-08de07040fff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180



On 10/8/2025 5:13 AM, Jason Gunthorpe wrote:
> On Tue, Oct 07, 2025 at 02:22:30PM -0500, Suthikulpanit, Suravee wrote:
>>
>> On 10/6/2025 9:59 AM, Jason Gunthorpe wrote:
>>> On Wed, Oct 01, 2025 at 06:09:53AM +0000, Suravee Suthikulpanit wrote:
>>>> ....
>>>> +	if (WARN_ON(!ndom || !pdom || (pdom->iop.mode == PAGE_MODE_NONE)))
>>>> +		return;
>>>> +
>>>> +	amd_iommu_make_clear_dte(dev_data, &new);
>>>> +
>>>> +	new.data[0] |= iommu_virt_to_phys(pdom->iop.root);
>>>> +	new.data[0] |= FIELD_PREP(DTE_MODE_MASK, pdom->iop.mode);
>>>> +	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV;
>>>> +	new.data[0] |= (DTE_FLAG_PPR & gdte->data[0]);
>>>> +	if (pdom->dirty_tracking)
>>>> +		new.data[0] |= DTE_FLAG_HAD;
>>>> +
>>>> +	if (dev_data->ats_enabled)
>>>> +		new.data[1] |= DTE_FLAG_IOTLB;
>>> This sequence should be in some set_dte_gcr3() ??
>> Not sure what you mean. This logic was in set_dte_entry(), and duplicated
>> here in the set_dte_nested() since we no longer calling set_dte_entry() from
>> the nested path. Also, it's not really related to GCR3 table.
> Sorry some make_ste_v1()
>
> This logic should be the same for any v1 page table.
>>>> +	/*
>>>> +	 * Restore cached persistent DTE bits, which can be set by information
>>>> +	 * in IVRS table. See set_dev_entry_from_acpi().
>>>> +	 */
>>>> +	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
>>>> +	if (initial_dte) {
>>>> +		new.data128[0] |= initial_dte->data128[0];
>>>> +		new.data128[1] |= initial_dte->data128[1];
>>>> +	}
>>> This should go into amd_iommu_make_clear_dte() I think, and refactor
>>> it out of iommu_update_dte256() ?
>>> Every created DTE needs these bits set, right?
>> Currently, the amd_iommu_make_clear_dte() clears all the DTE bits and set
>> the DTE[V] (valid) bit. This is used when preparing the DTE for programming,
>> detaching domain, and when setting the blocking domain. Putting this logic
>> in the function would change the behavior.
> Yes, but it seems like that is the right behavior?
>
>> These bits affect Interrupt remapping (Lint0/Lint1/NMI/INIT/ExtInt interrupt
>> pass-through) and System management message behavior.
> Because these bits shouldn't be cleared on a blocking domain!
> Interrupts are still expected to work.
>
>
>>>> +
>>>> +	/* Guest translation stuff */
>>>> +	new.data[0] |= (gdte->data[0] &
>>>> +		       (DTE_GLX | DTE_FLAG_GV | DTE_FLAG_GIOV));
>>>> +
>>>> +	/* GCR3 table */
>>>> +	new.data[0] |= (gdte->data[0] & DTE_GCR3_14_12);
>>>> +	new.data[1] |= (gdte->data[1] & (DTE_GCR3_30_15 | DTE_GCR3_51_31));
>>>> +
>>>> +	/* Guest paging mode */
>>>> +	new.data[2] |= (gdte->data[2] & DTE_GPT_LEVEL_MASK);
>>> I didn't see anything validating gdte has only permitted set bits in
>>> the prior patch?
>> Not sure which on are you referring to.
> You have to validate gdte has only valid bits.
>
>>> If this is goint to decode array item by item then why not use struct
>>> iommu_hwpt_amd_guest in the nested_domain ?
>> The struct dev_table_entry *gdte is basically the same information as in the
>> struct iommu_hwpt_amd_guest.dte that we copied from the userspace into the
>> more appropriate in-kernel data structure type, which is used within the
>> driver.
> The appropriate type is the userspace type if you don't actually ever
> use anything unique to the kernel type. You can avoid the special
> assert/etc since this way of accessing it is not sensitive to layout.
>
>> Here, we just select only what we needed for configuring guest page table
>> specifically to be programmed onto the host DTE.
> Everything you don't pick up should be checked to be 0. VMM needs to
> filter out unsuopported things or generate a bad DTE error.
An alternative can be to introduce a struct which only contains relevant 
fields.
Something similar to -->

struct iommu_hwpt_amd_guest {
    void *gcr3;
    unsigned char guest_paging_mode;
}

VMM can take care of writing to these fields.

Thanks
Sairaj
