Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DC6230D3A
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392149; cv=fail; b=fgtZrCsckIt4gC74FIDiuMCYUYqoj1A4TzLvwT6n1klYYW0aJK1qWozOISb29gk5LAwB0UThLsgyTMxwYNZ0Mj5YgYC2bOYrPMsCdBQI9371uiC7g8WTWUxpWV+GOv4WfTC3SjgCwST4fIy0ryxmfOL5Wx1lwe+J1F8FOA6CvnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392149; c=relaxed/simple;
	bh=8ZLPZ9tqMLn1vQMO9F6L0RsvKfb8taJZQq+SCzGTI6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J/fH4C8DVnK4uuNxeM+rWxCaTbBQHOJSdbqlSptuR95kieNxGZk0muN0D6Ix2eRg7g7TkpohB4UzL8TFDei1Ql898lHnD4Mv2LLTPh7UbqRf7hyIjl7RUAb292rqEmxjrrkE6nB0X9XNThPRj8EG6/ykK37fhfYe7wevThlyi+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wvqO3akg; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wvqO3akg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTFr+Db3kUbJyt50Qp+kKI3lFSZuSMDk8hlvySGfT1XIDGViTOQqgGFSKrlqqgs9h5NDHW+R2clfXaWOEafKDC+sHRKyNNPAwEMvOeX8Iix8tdALmJpMszGZiIXTOp5JTx29uHBMr819cFyYnjGQ+9upRdLWvQDBJLUNN7JaZhLThq/jyyzCHaOmS8uB8tKXtUMzYThJf6X5fckpiDRZ7yo/us8iDKFLPvdOiMnWRkFdvqKayCX8WpR2NdN+eUQp7AQGxTOgUrzEQUfeSwHIi2roTQl0ERwmbhMmrs5j9m2BHwOeBzizTfqlDe5dpJe0gbvXE3j5JiJT8Q9R6nS3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtUtWQYm6Cbrc1s/M0a8wqSVpWD44g/0MbJsFCjd5xM=;
 b=e/G2qpX9zWoWjK0DmbMyisFJF5l75lgJ7nwpU9w3nqSJdpT4ZXkBqNzI05zIHV1InbcBL3oG9lpdTvv0osMgjndKrYVdsD5t8/aHgzHptQyOr2hrWvINLt/bTGaUJ4BA7wcrlEjFNLhtb3FmzWmSb79bQrSBQDuePv+uAjf5HwGKnCsuvxsaUGLa4sueT13dSTawLvY3IAbEqJlJyZcFeWupAFLBlwFMIw4gXj4BdB2wEHw0hCkKC0Fm5DaKhr6/vBE/Obu4j97kaN5I/BtjCjFf+ne7ECqMDErWkuXLFoK9re5tMH3XtsDb8A4flJAWQx9KBlVYCFGTWdxA8adTmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtUtWQYm6Cbrc1s/M0a8wqSVpWD44g/0MbJsFCjd5xM=;
 b=wvqO3akgCZM2yisz2fLAjXlg+h+yvxb+OEE9Hq+cPnmg2+05lxgCp1zk6vI7A8SgAsZRD8YsfrmepSh0z1fjg1XjQNnvEHxJ+IbXTDmm6FuQGfCxn2upXQNLD/OigSSR7v6YH2q4mmCEEKIzoli6VCNe9qGQVk6Lo+1CrwHfudc=
Received: from DS7PR05CA0029.namprd05.prod.outlook.com (2603:10b6:5:3b9::34)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Fri, 11 Apr
 2025 17:22:22 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::73) by DS7PR05CA0029.outlook.office365.com
 (2603:10b6:5:3b9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via Frontend Transport; Fri,
 11 Apr 2025 17:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 17:22:22 +0000
Received: from [172.31.190.189] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 12:22:17 -0500
Message-ID: <d8fca516-235a-4156-aaf6-8cf41c47d0b0@amd.com>
Date: Fri, 11 Apr 2025 22:52:14 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/67] KVM: x86: Pass new routing entries and irqfd when
 updating IRTEs
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>,
	"David Woodhouse" <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	<kvm@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, "Joao
 Martins" <joao.m.martins@oracle.com>, David Matlack <dmatlack@google.com>,
	Naveen N Rao <naveen.rao@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
References: <20250404193923.1413163-1-seanjc@google.com>
 <20250404193923.1413163-9-seanjc@google.com>
 <6f76183f-a903-47fd-8c84-0d9892632fca@amd.com> <Z_kgbna7grb833Fy@google.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <Z_kgbna7grb833Fy@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b4ec70-616a-4cbc-b37f-08dd791d6b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmZnYmtlRDRwaTVyVUJFd2xkbVk1N1lTNTM0dDZWQ29SUW5XaHZYM2dLTU52?=
 =?utf-8?B?TEY4V0JwRkYwQnFQVjQ1YktXTGNicENBZVcrM3l4MmpXakRmZGVKS0FsbWhH?=
 =?utf-8?B?d3U5akkwN09WQi9wdHF3S0xQeDZXcCtrdWF6UnVYNElwOXpkSlR5QkhVbnFI?=
 =?utf-8?B?WXpwck5IcnNheVhmNzNnZDY4RkhvWlBmQWpaOVdhaEk0MFVaUlhRUFhqbzA1?=
 =?utf-8?B?bDZhbVNvQ0dTQzd6U2VYNFU1SEM5dkRjK0NOSlZiWDlEamNSTG5lcVB4YlVO?=
 =?utf-8?B?QURMY3Rwa2t5SEQwRnI0cDdweTJjTnJhSHg3RTJPKzdvZXJNdGdWdm02R1hw?=
 =?utf-8?B?Y2NyN3lrUHlFWmk0RnJIZlVaN0dWMXhJK2w2UWw5UDdnQjRISWFmQ0J6MmJy?=
 =?utf-8?B?Qkk4aHNZcVVOWUtGYXRieGVabWVEN2tMRGdSNFl4bHl0bWdHRjNiVlQ5bDBs?=
 =?utf-8?B?VEdtSWZoN2JxSFNyaGhsZXBxbGR6WnpFTURvM1VqL1NWUTRtbXJ5STdFQWZU?=
 =?utf-8?B?UGlSb2p4L3NwMVh4cUtXRHl5c3ErV09TNkg4dklnZkNBaWRnS3ZzME1uNXlo?=
 =?utf-8?B?alJTYVhBVFNobmhhSFdYbm9DcFhtQXBrVFRTODA3Q3JhMXFnbjJqaldxRXU3?=
 =?utf-8?B?ZXFWRFdnQnMySnZSZy9FcFlrMThvc3JBaTVCY0ZEN1NPVll4eEE1VzVnNkFO?=
 =?utf-8?B?UjlMaWNNYkNONElQODRuUmJOZUpwQ2wyU21ha0VHYi9sVFFONEdKVzVkT1h2?=
 =?utf-8?B?ZlR0aGZINk5FWGtQdm5JdW5ydDhYcFQ3dlVVTURMWmViS2dyZW5jeWF4Uk1W?=
 =?utf-8?B?MEJISXlrTHdYQ3U3M2dkeEpqVnFlaktWMHdFUkJYdTF3SUNCU2xET280elpV?=
 =?utf-8?B?RTFocEF2WXdrd1J2dHowazJRcm5qYVQvOU9WdE82RHBtRzBaNTFoUVBqSHhz?=
 =?utf-8?B?OFJlQ3VoS0NhVUdwVVRuSGhiN0p0RUw1MEN1aFZPSjJXdjM3dWt5bDFPK21i?=
 =?utf-8?B?ZktPRkYyWk50MEk4QnF0RjBLSmJHZ0lZSWpsaWM1enpFZ21VejcwbUR0OVBq?=
 =?utf-8?B?eW1ZODFLRWVOenVzZnJ3M3FWdmhVUlBrVG1FdVJsV3NzMEdielA4U25haWZ3?=
 =?utf-8?B?SGtZYng5dVkzVmFnRDhpK2V6ZjJXSUdXWExHMWJxeStBaCtXZXFkQWhDZ0dX?=
 =?utf-8?B?ZzdwSEtSa3ZEcisxSFArOTJJYUhodkZRSmk2OUlxd1lwMm9RWU1NWnlObTZW?=
 =?utf-8?B?T1dKMUdZTEgrMkdnYkM0Rkh6UEdQMTBjTGhsQ3owM3VsSFordkhHbDlUMWpJ?=
 =?utf-8?B?Y2xHN2VDcytwcTRlUWFPdlVuYWo4V0lUN28xaGl6ZVBXU1dCT0ZBaU94aERu?=
 =?utf-8?B?K0tKR3k4a1pySEdITE1BTm9HQ0FSRFVZSjRVbTlBWmxKSThWV21Ob1ZWRkVu?=
 =?utf-8?B?R2p2MEVFUThmR3RDK2R6Y0tQQ1BUM2N6MEkxLzRoa09TZWlxQ0NBcC9peGtU?=
 =?utf-8?B?T2ptb21sWk9oRUNON3NvYUovTHpGNFYwNE0xVTFQVFpnUDdlazRoRjZDMWE5?=
 =?utf-8?B?cGxyT0NaWituQU9xTWJyVDZ4dk5kOTAzTW80ZFA5a1Y3VG9QMDZMb0dFbVFB?=
 =?utf-8?B?aFd4WjZ5RnF1bVFSVllhRVU3Q0JtN1JJYzFCdW5WNmxvZ2NCYWEvOSt3dUtD?=
 =?utf-8?B?eFl6cHRtZ2hmbU9ldm5NeFdhdVdmU0tpaFJySk5yNFJRYnZKVDR2YTR1UnIw?=
 =?utf-8?B?cW9KM3BTckFyWU1WWVVKNEk0RCt5aUk5QmVyTjhIOXhrWjU1Q2xlZERoWmU1?=
 =?utf-8?B?RFpXaDlpaTZ1NytKQjk2Mzl6a2FpUFpRWEtsVEJMdGw0THhsTDBudUZhdlBz?=
 =?utf-8?B?Ti8yOEJ1Smluc1NoVTNLa2dUVW5IdjhYb2JFTXczdllPeTBONElOVVIyS3B0?=
 =?utf-8?B?eHEvck41UXpWaS9DZUFzWnZkdkphb09rN1U2SjFYWitudlRhZjhvWW1WSkxH?=
 =?utf-8?B?U0ZWMmRTcWZTSzVlMjViQXpXYnRzWWdIWFlGc25NTUFtN2hKZ0Vja29Yb3dM?=
 =?utf-8?Q?R2of/l?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:22:22.0699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b4ec70-616a-4cbc-b37f-08dd791d6b86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912



On 4/11/2025 7:31 PM, Sean Christopherson wrote:
> On Fri, Apr 11, 2025, Arun Kodilkar, Sairaj wrote:
>> On 4/5/2025 1:08 AM, Sean Christopherson wrote:
>>> +int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
>>> +			unsigned int host_irq, uint32_t guest_irq,
>>> +			struct kvm_kernel_irq_routing_entry *new)
>>>    {
>>>    	struct kvm_kernel_irq_routing_entry *e;
>>>    	struct kvm_irq_routing_table *irq_rt;
>>>    	bool enable_remapped_mode = true;
>>> +	bool set = !!new;
>>>    	int idx, ret = 0;
>>>    	if (!kvm_arch_has_assigned_device(kvm) || !kvm_arch_has_irq_bypass())
>>> @@ -925,6 +919,8 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
>>>    		if (e->type != KVM_IRQ_ROUTING_MSI)
>>>    			continue;
>>> +		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
>>> +
>>>
>>
>> Hi Sean,
>>
>> In kvm_irq_routing_update() function, its possible that there are
>> multiple entries in the `kvm_irq_routing_table`,
> 
> Not if one of them is an MSI.  In setup_routing_entry():
> 
> 	/*
> 	 * Do not allow GSI to be mapped to the same irqchip more than once.
> 	 * Allow only one to one mapping between GSI and non-irqchip routing.
> 	 */
> 	hlist_for_each_entry(ei, &rt->map[gsi], link)
> 		if (ei->type != KVM_IRQ_ROUTING_IRQCHIP ||
> 		    ue->type != KVM_IRQ_ROUTING_IRQCHIP ||
> 		    ue->u.irqchip.irqchip == ei->irqchip.irqchip)
> 			return -EINVAL;
> 
>> and `irqfd_update()` ends up setting up the new entry type to 0 instead of
>> copying the entry.
>>
>> if (n_entries == 1)
>>      irqfd->irq_entry = *e;
>> else
>>      irqfd->irq_entry.type = 0;
>>
>> Since irqfd_update() did not copy the entry to irqfd->entries, the "new"
>> will not match entry "e" obtained from irq_rt, which can trigger a false
>> WARN_ON.
> 
> And since there can only be one MSI, if there are multiple routing entries, then
> the WARN won't be reached thanks to the continue that's just above:
> 
> 		if (e->type != KVM_IRQ_ROUTING_MSI)
> 			continue;

Thanks.. I understand it now. I did not see complete code hence the 
confusion. Sorry about that.

Regards
Sairaj kodilkar
