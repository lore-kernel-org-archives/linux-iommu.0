Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0220747F
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 05:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763614962; cv=fail; b=K0sQ+9fBKEjPQDlrDp0mfVaRmirXUzbI/MjiFYdeEzlmefYafLDbcnPs6N9jtVw4i1yA8uhcOX6F84TC4+oFXuMCxd6N3bI9V3UXYWaGqPUlWlH0Duw7Zp5XU8r58OP81VrmlMsRMxsOoKXtuSEGMDVv5Yz09cPe7sd1wyS3+Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763614962; c=relaxed/simple;
	bh=UEfj7fdqCNwYQ58QWjyrX3iObz5eItSfhl2EKS/ON+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HkTEAI8JTwMnixgtFZ7cCmzxEwEb8bz48lwfnn6bVb23046FYChoUd1SHM3cfkr7No+07I60sa4uHbN0Aod5NswGMGh9FJ6//mT2fqpmsCPLi6PrEkHTSJth5MKIVzI747CDBHWOPdmXDKkeRJvr64ni80TDlAxYHzOFcnLRVjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YYpRIQrL; arc=fail smtp.client-ip=52.101.43.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YYpRIQrL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRnZ/OfD4ccScKjaGnB8zex5ymuu/wCnMw3jDbGU/Qvl9vJwIMsk2pKgYxIWlqfO+HRARquHK7bXklRwbGJY5lfFTx+z2TGd4VAFYaqG+84Ki3jfLXHtXoHI+W60eQGpLN21NgL1aDUPJfXveWvJm3N1bP1WRVGJxDILoKumevHPD5DPgT/M0vH2c+kwbxNghglBy9JODZqLkzh6fGcmIsyEhvNN7gmFpGWYlA5F3mGrkzZRstB8Z5NdncgbwqjvQdmwIZHix5NLZzajiIQxFUdae1OYFkaVwPQrPkF/GZts+im/hVxxSam+Ha8XRTwDN3AF9xGqotoBvnnUqOC4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wg+2flunXh0fBXqX4FmgABWqAxIU7W4O07ciSEYYJc=;
 b=zS66Lq+ly0qYS6SuQTao5tSm5ahieTLT9fx5bqQJZNgm4IzuGDaBYLXN5FxdG8luMBA5kBiGHfDX44E1k4Vi5evvsHNUymmya/vTnttnZn+CHWUd77/Tt41z+GktnXvyXKP8LbnJQaS18ZujRNYHVFULI+wC92CFozP7rhHgP2PpmBxoC0kYRqZljIAKtSuwopY4zwnXi6e5s1AYINMAJtZbV51JuBTG4uP1kCpUoQ59USuMmb3d/nTN+oDp2d0Ni28xUwcIl7C7UMU5jAxYtnGpUP2llmBkeWjNrUOH3twbQM2AaTqrZzUPi4YtYz4QsdZif+Ogf5Wl4BdG8fNm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wg+2flunXh0fBXqX4FmgABWqAxIU7W4O07ciSEYYJc=;
 b=YYpRIQrLlNUzuT9uwgz7tWdZ0Ub09Y91x5poQhfJB8CfR8GCA2rmMhmyk0Rjh1cTM/iRtk9/OjKDa2r415W9G/hc7UvP/cBnOKqbnvuQQiVB0W2qBsXqy5fMgKj7Y1sY+wCuzotX/zeUQ/ZKSgUkUV4Cs7F4BemaLdr3Bvtd0x8=
Received: from BN0PR02CA0037.namprd02.prod.outlook.com (2603:10b6:408:e5::12)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 05:02:37 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::2f) by BN0PR02CA0037.outlook.office365.com
 (2603:10b6:408:e5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 05:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 05:02:37 +0000
Received: from [10.85.40.78] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 21:02:34 -0800
Message-ID: <5167fc71-23e2-486e-b9f6-f11960725b19@amd.com>
Date: Thu, 20 Nov 2025 10:32:32 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] amd/iommu: Preserve domain ids inside the kdump
 kernel
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Vasant Hegde <vasant.hegde@amd.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <ashish.kalra@amd.com>,
	<robin.murphy@arm.com>, <will@kernel.org>
References: <20251114104442.23296-1-sarunkod@amd.com>
 <20251114104442.23296-2-sarunkod@amd.com>
 <78a4598d-5d35-4fd0-a830-a740076aba41@amd.com>
 <20251119134351.GM120075@nvidia.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20251119134351.GM120075@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: fe28ba50-0959-4e50-1387-08de27f20619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDJ0ajRRYWxnSW8wa2MveU5UWVhRYVVWQnZSMU50OTZ6aWttaDBlRnRjcEh3?=
 =?utf-8?B?TStLdFBKT1FHR1NaekVhWVNna3plSUs2Q1d0bGtQN3hMaUd3dDFyVlhmUVJl?=
 =?utf-8?B?OVh3aVQveHJpd2lnNXpaMGJ6N08vZ2JydGplOTVRWHlkRzR6dFVsWWdnZGg1?=
 =?utf-8?B?TVNJWDZReGYwU2ExQmlmVFd2dHI4K3h1V0o0MWdWdTh5WGtCRXZDOWxQRXl3?=
 =?utf-8?B?THpQS2RDTGNDQXZ5aURPOXh2VEZkbmtPcy93eTlJUElnQmlsc2xteFpuY0Rm?=
 =?utf-8?B?MU1xVnJMOUU0Y0Z0U2l0cUIwVjIzVnk1aWJhZjVtcFBnc2NWNUxNOE13RmZU?=
 =?utf-8?B?RCtYOGw2K0pRdWl6VmxDdzNjbEVMYWs2alIrVTI1aUUwalVNL3hhaWd4SVhH?=
 =?utf-8?B?aVhvSU0yQ0VrMTFrTnYzWjMvaVZxY0xwb2UxZEcrazQ1cmQ4ZEp0bW82WHpH?=
 =?utf-8?B?dHU3aW40Wk5xUVJxNU1IZ0RNZmJoVi9NUitkQlBOM3A3MkJCbUhpV3lURkpY?=
 =?utf-8?B?SGxGTEVhVGd0MXUwTkM1ajZrajlKQW5FcGNNUlc4UlB4ZnNVU2RmdkVucTU4?=
 =?utf-8?B?REhRVUNDV0Ftc1BBMlJFR3FIU0EwLy9PTDdoZjI0enlPWE1NL0xPOGxkekcx?=
 =?utf-8?B?UW92SnlwL0JkTmJCdFRvYmZtUUNHalpPdXlSNHFrcTF2UVk5VGdQSUtUWmQr?=
 =?utf-8?B?LzV3YmJvRFdzOXBnbVMvYlZKZStNQmtSTHkwZ2Z3V3RydlR3VDd1bVkraDg2?=
 =?utf-8?B?dWd4VlAwdmZ0SlFGV09pY3FZY0lCejdwTWgyRVhON1p6VHR2TGNuaEpQNFU3?=
 =?utf-8?B?eVdubjJlTkcrRXdnYklrWlBnZ1hCWUphQ0VabDNGTURYY0lKdytoNDFlQU5s?=
 =?utf-8?B?Q1J0MnQ4ZXZRWGpCQVRPYkM5NU81VitxZGkzaG1qTDcwMkV1c0xZOVY3bU81?=
 =?utf-8?B?cVpHbmo5Sko0OWVYUjRVcSs5cEdtY1VNVTRNRExyak9ZRTlvVGkrM2laWEIv?=
 =?utf-8?B?UHhNS2dtcFFmWGtkbDFkWnhsTjhiUG10b0kvZjUzY3E4dUxKT2RoRE0wVThK?=
 =?utf-8?B?ek9pYkhLK054V25wcXVKd0dhcEFCUUFWRlp3aUpUbm42S20zcFpZVGNybjJZ?=
 =?utf-8?B?OTEyY2VXTU9qRkVsRll5UVBGQ08xOFJxSFZWbjM2QlhiM2xDeTRRWWdUelFl?=
 =?utf-8?B?YnJIQ2ttcUQvWWpiNHVFczJDUDJWZFRDSGZPdWJRRk9vTDRpOTBnZUw0OVlZ?=
 =?utf-8?B?Ylk3d2lvL0M2ZVFPZEdvQlZCaXNweHpGaWNldFlBcTc1RUl5YWprUldDV3dB?=
 =?utf-8?B?NTEySEpONnJhdEc5ZjVJVk5XNFZ4RzVXMGJpaGNyUVBqYzF1emlKSUkxakxS?=
 =?utf-8?B?U3N2eThnUXpRWkt2NFNXVlJJYzkrM1BQZURjMFhVMDlGM2dZWG15U1pTTzVU?=
 =?utf-8?B?Q3VVR3V6a3VFcjh6MTlUNUhQUG9CblAzMFFreUxnWm5qMVJPMnRRWGYvTVV6?=
 =?utf-8?B?ZldTUkFrQjkvSGJOQjR0L2VIQVQvVEtvUjZQUDBrVlQ4aHczSzdtaUluREg5?=
 =?utf-8?B?MWhOMk8zVUcwWUpXMEM4WUIvTVB6NEd3cXl2NjQvdjVFSnVjMUc5NnMwSUZF?=
 =?utf-8?B?QWpqd2JxSlVta3luQzBpV3Iya2VVM2NoYnBxL241dlhxeFpsTzRWV3Fad2lL?=
 =?utf-8?B?ZXFkdUFjTDNNNFZXOHFUOWJGWndTR2lPaXE5WE1BK0FnWDBpNGFwK0YxOFlU?=
 =?utf-8?B?M1JCTVR3ckxuWGtGMi9JRE1Va2dVRU9wUXQxUG9FcEx5ZGlMclRBdWw1eVhk?=
 =?utf-8?B?WVJiSHZRWm5YUmNnUjl4U2tDQXJkdVduQktjR3VGV0lKNTZSc3NjMDlvZStF?=
 =?utf-8?B?RGoza2o4K2pYSkw2Z2JXdVQwS05saVNEU05zbnNKc0pIMEJqWGE4YVhPZVA0?=
 =?utf-8?B?aU54QzMwaWpoWkMxSHo3MkRiTjlucFFHZkRwODFkTHVIT1ZSMktNV0Zzd2dq?=
 =?utf-8?B?eUhndzkycFFVbDFUQUk2ZTd6UmxVcFVSeFJKNmg2bGRlckRCeDd6c1Ayc2Qx?=
 =?utf-8?B?Y0p2ZHdnalJOTnNIcStrRVpIeEZTV0g2ZlNSWVF3Qi81VXlsUDVpQTlmdnA4?=
 =?utf-8?Q?X5S4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 05:02:37.0613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe28ba50-0959-4e50-1387-08de27f20619
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886



On 11/19/2025 7:13 PM, Jason Gunthorpe wrote:
> On Wed, Nov 19, 2025 at 04:20:28PM +0530, Vasant Hegde wrote:
>>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>>> index f2991c11867c..9375fba1071c 100644
>>> --- a/drivers/iommu/amd/init.c
>>> +++ b/drivers/iommu/amd/init.c
>>> @@ -1136,9 +1136,13 @@ static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
>>>   static bool __reuse_device_table(struct amd_iommu *iommu)
>>>   {
>>>   	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
>>> -	u32 lo, hi, old_devtb_size;
>>> +	struct dev_table_entry *old_dev_tbl_entry;
>>> +	u32 lo, hi, old_devtb_size, devid;
>>>   	phys_addr_t old_devtb_phys;
>>> +	u16 dom_id;
>>> +	bool dte_v;
>>>   	u64 entry;
>>> +	int ret;
>>>   
>>>   	/* Each IOMMU use separate device table with the same size */
>>>   	lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
>>> @@ -1173,6 +1177,25 @@ static bool __reuse_device_table(struct amd_iommu *iommu)
>>>   		return false;
>>>   	}
>>>   
>>> +	for (devid = 0; devid <= pci_seg->last_bdf; devid++) {
>>> +		old_dev_tbl_entry = &pci_seg->old_dev_tbl_cpy[devid];
>>> +		dte_v = old_dev_tbl_entry->data[0] & DTE_FLAG_V;
>>> +		dom_id = old_dev_tbl_entry->data[1] & DEV_DOMID_MASK;
>>> +
>>> +		if (!dte_v || !dom_id)
>>> +			continue;
>>> +		/*
>>> +		 * ID reseveration can fail with -ENOSPC when there
>>> +		 * are multiple devices present in the same domain,
>>> +		 * hence check only for -ENOMEM.
>>> +		 */
>>> +		ret = ida_alloc_range(&pdom_ids, dom_id, dom_id, GFP_ATOMIC);
> Is it really an atomic context? Why?

No, its not atomic context. My intension was to ensure that the memory 
allocation
succeeds. But I am not sure if it's the most appropriate choice for this 
scenario

Could you please suggest which GFP flag would be best suited for this use ?


>
>>> +		if (ret == -ENOMEM) {
>>> +			pr_err("Failed to reserve domain ID 0x%x\n", dom_id);
>>> +			return false;
> Please don't print on ENOMEM, there is already a print.
>
> I think you should also keep iterating as other dom_ids may still be
> fit in already allocated bitmaps. Though the system is probably toast
> if this happens anyhow.

Sure


Thanks
Sairaj
> Jason

