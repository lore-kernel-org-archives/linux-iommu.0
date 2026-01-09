Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DFB32F750
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948556; cv=fail; b=lB+m9N949PMngI6cXSLDxSZh60R38yM+1eYhStF+bDw/pQIdCzJ+Pl462R7iCWYIIOVzja8HG/1Fc+U+LOLCN9Gbpa7tEtyw5WftmG86sMeJro8hA3nxSpQ5o/NOlThu5y54/TVntYEWBqcW57bB23zld02IrvmNZCxIA38vXJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948556; c=relaxed/simple;
	bh=3v1xrgBm3jsKDSZnikLnmpba7Ee5svY0VzmDyVeQpWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jf1KpH58DsNxeP1Q1j96fRv9mZeXmsB2Ye0y63fi7Xigjby7Lmv/dda0ccp8mHdJOAbtYhTKDilqZh18EtT4uso30F96u7ZDLv9BdF4XTqcBGjMPZWLHgrveGuHOl+Ji2yQ+L/zE7yD0mDXgARaOxx71w6S0bqTCoAC0wUgiH5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BwxfMAyi; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BwxfMAyi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfIPKC7/AyyLb2xz+XXSezCX6K9Ux7FToSteYpIJ9ps/D01F7B6nsWikpfDbFSSSR4QwrEPNn4MyPc3Dh6d82BKp6hUi9+/a3MFqv6UpEQX+SWHZj1PEOg6kMaYQYs8Mlx50gGB/dx2l0je016S58ApVuWUHpPtPUhCHyBRK2Tk9kHShDO2bzjUIuAbbqE1LxEnXkWeKdsY9YzhzNBhhsf7VedEPTeGWe/Rbadt1k/AhGX3TzieLzRWj+hrGePnoikyLsxKyNguF+X6eudOxYcKZqpT+buSD7gil4kd+scat29A19Jb5cOGc/XSDDOtkulwpFuDzkbPSsTbrzGPm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tvokGQgFwIWAv5RY9nZC9KGFBL+OCk3l+EdWAcGykA=;
 b=qYcKBiUdGzEV4C2jTSkYBo17o9sOz/Jz+RIcRGrB66slD0/GVbZWSJogYP7Gxbr4+MnqBwmzLy3pfDVIPcmSZs6pYTubfCnjPCCJtTQzFrOCIQjenSPcckMRPO4J9O9zf6SAYk4QeSEm94soW2YMw89SvRpqkOKOYWDWLN6rRQg+4fhCyFXEHeSyeYAFHjka0A4Jka4jK/r2tixwpghDhn70Oo7vdGcxH0HYvuwGHxB6i5zuWqjcaXVnwP5CLx74IdG2izEMbDHRZNfn6Qc/uH7EtwQnzH6bg+w8xZyMqxEZjOkC3aBHTMZSk6IrC49HmZbxUYFJUEQf8b23JRPdHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tvokGQgFwIWAv5RY9nZC9KGFBL+OCk3l+EdWAcGykA=;
 b=BwxfMAyivL0hY8K5WGUS+Y+6p28P08RJdCHTn/hVMDIPDgTLP+dTi9IVpHThb11Nu2NiNsWNMiQ5jry8ZRWRsTP80jJQt1AQrmjkkbVVd1pxSoRCa2HUgp8iT/b4m8LUreNAczZLcqqReU9cxWJOp3ag5k1mNLvc/W9EZJLdexI=
Received: from BN1PR12CA0011.namprd12.prod.outlook.com (2603:10b6:408:e1::16)
 by CY3PR12MB9578.namprd12.prod.outlook.com (2603:10b6:930:109::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 08:49:08 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:e1:cafe::90) by BN1PR12CA0011.outlook.office365.com
 (2603:10b6:408:e1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 08:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Fri, 9 Jan 2026 08:49:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 9 Jan
 2026 02:49:07 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Jan
 2026 02:49:07 -0600
Received: from [10.136.35.106] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 9 Jan 2026 02:49:04 -0600
Message-ID: <c591995e-7b4d-4246-ac8f-2bc96d44a2bc@amd.com>
Date: Fri, 9 Jan 2026 14:19:03 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Use array_index_nospec() for rlookup_table
 index
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <Vasant.Hegde@amd.com>, Sairaj Kodilkar
	<Sairaj.ArunKodilkar@amd.com>, kernel test robot <lkp@intel.com>, "Dan
 Carpenter" <error27@gmail.com>
References: <20260109052040.938-1-dheerajkumar.srivastava@amd.com>
 <aWCakni4dwgJpuE_@stanley.mountain>
Content-Language: en-US
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
In-Reply-To: <aWCakni4dwgJpuE_@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: dheerajkumar.srivastava@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|CY3PR12MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7d2e77-c5cb-419d-76bc-08de4f5bf3ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVNMSjVQdHNGeWJEckZXL0E0S1NVRmo3U3FUSE5CQVY0aFhjQzZIMzNPdXVU?=
 =?utf-8?B?dC9kRkFCTVZZRTV6cmYzZ3BKcnVSMlk1NTJhbW1rU2hnR1czT0hFaXpqeGNR?=
 =?utf-8?B?SjRkZFZVeElXTWd5UWpScHNWYkVwSjdHZERQL1lQTVRVYzRIMHhVbDhoU3hD?=
 =?utf-8?B?MHpTLzBPazZxTExKMEZTTW13akFTN2tNc3QzR1BSY1ZhcSt4WnlXakVmb29u?=
 =?utf-8?B?ancyeitsWjVnVjd2VFoxWUdBWmFYYVhlWUs3enFoZDRVVjhYWnFCeEJjcWE1?=
 =?utf-8?B?M2NsMEd0SkJ1d3dhVXppVmpCRVlzcllqbDZ4VHVRUXRCSnJ1dHRTTDVGaTJO?=
 =?utf-8?B?Wit4NlFLbG9aa05sdGdndW9xWS8wajBlWkJtRnJyYmN4Z0JqaG5GZ0phVm9u?=
 =?utf-8?B?UHBycTI4YVNKTHVFOURIcXI1d3RLaEVDUEZUcHRmU3hXdFI2V2tKeTR2aUxa?=
 =?utf-8?B?RlJkcVFDSkl5alBFbTJ6R3RWUG9iRlBJT0hQT2YxRzhmVldBbXZrYkYzM3ZH?=
 =?utf-8?B?RGhCZEZFY1VBQkRSYzFZK3pvUlBNMHpGbkV6TlQ3UWFIWDJDdUphK1dOeFNj?=
 =?utf-8?B?dHM3Qlg0bHdPeDczeDVUcnlRUjEvbGJqZkNVRzE5VEJuOU9HQnhmWGwwY2lB?=
 =?utf-8?B?RVhaRWVkZ01aM1pzNnh0L1lLK1VjK3duUmJBZ29tSXZVT1d6U3ltU0RaVzl5?=
 =?utf-8?B?NkY2OVliaFJvZHBWeGd3YXdvOUhaQTU1WUkxMlJuUWVIUHlncU1GbTVtRjIx?=
 =?utf-8?B?VEc5SlJzWXZ0eFBGM0F2U09MSWx4R0xjSzBoVHJFRnpMd0hoMHI0akFXYnFV?=
 =?utf-8?B?bWsrNGFXUFVBN0IyeDIvRHMzek1xb29FRENzNm9nOW02WjBVckVwWHdmcWJm?=
 =?utf-8?B?amRFV3ZKYUNMbi9wZ0wyUW5rOUJUY1RZbFFGMEc3bEwydndZSkx2YUJqajJh?=
 =?utf-8?B?UE1NSFgzQS96Q1FwMVlOQkVkSy9kUnp1NWxWcDlrK0dzYWxqU2l2N2h1WHVL?=
 =?utf-8?B?QlVIYllLd08vdGIzYVBTV21jSGVyR2NLRXlnY0RWVEZLallHUTRiU0syMXdE?=
 =?utf-8?B?WHZvMFRHSWZ0eFNla29MVm9zS3NCM2FZVnQ0ZTJPYU1EVHRUbDFlRi9PLzJS?=
 =?utf-8?B?U0FuZFQ4UDEza01UMzJOUkFERTJ4ZEx2bmdCSkhyOTNITUJKcjl1TTZzN3RZ?=
 =?utf-8?B?cmIzLzBkN1hhNXdJaDh6K1U5L3h1WnVIV05uSGRSbEx4a2tNcm4wNElFMlJ4?=
 =?utf-8?B?dE54RGkxRkJjZDJaWXk5alJMMmk0NWY3aVR5VWIzMTZFeW1FSzI2TFFVangv?=
 =?utf-8?B?dTRZcm9ENFRBZUp3N3d0WmpNMWk5UEZJbDh3NFJhTVZlQ2ZIdkR2MHVDSFVX?=
 =?utf-8?B?Y1NtTDZDTmJrUWFRVDBHZGNNSG5wMjJuYWJYbXlzc3BweVk0RHJjeU5tTXFT?=
 =?utf-8?B?dkpqRVo2ZitaVHZrbmYwNHVhdjJkYVpGWGoySFJ3emhuTlBQNWVmLzFjQWpQ?=
 =?utf-8?B?WmgwMzNpMlNtdytwb1haVlNUcm85MWgyT3dROTR0SEE4dmV3aGsrd3FZMlVn?=
 =?utf-8?B?Umlzc2Y3Yk1oR2c0VmNyajJYVTY3ZHlHK1hMS0FaQTVCN0JvdmphbzV5RUZX?=
 =?utf-8?B?TVJoWjNNLzRPUkQ1c0pOV0VUQ2daQ0M1Z0tmVkxkUWlFOUxtMnE1RnRUK2VM?=
 =?utf-8?B?bWVhSHcydVNiS2RKTkgyeXRiU3hyOWc2dFFlYmNYejIzUlZ2bzdKcWU3bXNt?=
 =?utf-8?B?UFJ0OFh6dnRtNURvU0F1Q1dqU2I4Q3JVZ2N4VFpYdjNJbUhOZ1Q1eVZLS0dQ?=
 =?utf-8?B?dEh1TnhLeTJMeERDdE1HQnJlTEExZXZkWStqZXByem5ZTHgwbDd1N2p4dzVo?=
 =?utf-8?B?WkhQWjB3WHlLWFBoVEpCOFlRTzkvK1ZhdklHZHRDY2FqcklhRzJvRDJUVVNV?=
 =?utf-8?B?N2NQMnZscW1BRVBsd0duc1lkZ1VlbTQvT2o3Y242ZXQyb3A4R1hjZStCTHJ5?=
 =?utf-8?B?NnBsVlY1b1YzK3g4VWRPcUNqcE1ickEwOEQ2dDVUN093WHExOVNoMGZ0Rnlp?=
 =?utf-8?B?M3Y0aFMxejdocUl3Vmh2cVRIZTlheFI4YWNXazREejNDcVNUaGFRNWRuRFRQ?=
 =?utf-8?Q?wM+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 08:49:08.1619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7d2e77-c5cb-419d-76bc-08de4f5bf3ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9578

Hi Dan,

On 1/9/2026 11:35 AM, Dan Carpenter wrote:
> On Fri, Jan 09, 2026 at 10:50:40AM +0530, Dheeraj Kumar Srivastava wrote:
>> Use array_index_nospec() to prevent speculative out-of-bounds
>> access when indexing pci_seg->rlookup_table with a user provided
>> device id.
>>
>> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
>> Reviewed-by: Sairaj Kodilkar <Sairaj.ArunKodilkar@amd.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Closes: https://lore.kernel.org/r/202510281233.q4cBnp3z-lkp@intel.com/
> 
> This is interesting because more and more people are using lei to
> recieve email and now they get unfiltered Smatch warnings from zero day
> bot.
> 
> Normally, I just ignore these warnings because they're hard to review
> and I recently modified Smatch to stop the zero day bot from warning
> about them.
> 
> The problem is that I've tried to contact people from Intel to help
> review some of the warnings but I've never recieved a response.  I've
> heard that Intel has a handful of people that deal with Spectre v1 bugs
> but I've never seen any evidence of that...  I've never tried reaching
> out to AMD.
> 
>> ---
>>   drivers/iommu/amd/debugfs.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
>> index 10fa217a7119..4990f6db99ef 100644
>> --- a/drivers/iommu/amd/debugfs.c
>> +++ b/drivers/iommu/amd/debugfs.c
>> @@ -174,6 +174,7 @@ static ssize_t devid_write(struct file *filp, const char __user *ubuf,
>>   			kfree(srcid_ptr);
>>   			return -EINVAL;
>>   		}
>> +		devid = array_index_nospec(devid, (u32)pci_seg->last_bdf + 1);
> 
> This is debugfs so it's already root only.  The cast to (u32) is
> unnecessary.
> 

I agree that the (u32) cast is unnecessary here and will remove it.

When you mentioned that this is debugfs and therefore root-only, could 
you clarify the context of that comment? I just want to make sure I’m 
interpreting the rationale correctly.

Thanks
Dheeraj

> regards,
> dan carpenter
> 
>>   		iommu = pci_seg->rlookup_table[devid];
>>   		if (!iommu) {
>>   			kfree(srcid_ptr);
>> -- 
>> 2.25.1

