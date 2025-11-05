Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458B42C0F7E
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762325041; cv=fail; b=LrTPVZ9ikeQS7E5sttCuPsh10vPYCghdWUjiwppCccL2Nlgl6HJpy1BcxluUi+NU1b4c4LKFiJsgQPidhBm+pu51cygF71ASLH1z4Vr8b72bfl5sjfiWciV06Y75lG597uqFVHwaprt2dtipi1hR4Nmj0lTKGCjhs7PwUvP0Hy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762325041; c=relaxed/simple;
	bh=T54w/+dxHWQCRrMn0fYPouOoZ6a/33XUM2frzcmq/+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oYKW/9fuZguLr9Kk8LNPj0JPg24gxyNT/wqq9ogY4+jJc+2fqoM1ujPfolK1158jeMCfwM09O9Hv0pyzUtEpAwwOc6Acly63R+JESZvorT/tM0vBTTJJPgEUzzJijMiByfGzplyIGILszsK8EyUb5v5aHhOdQv/doyxX7gqurSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vTASjm2/; arc=fail smtp.client-ip=40.93.195.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vTASjm2/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7Y00O7KybBfgRpxXB6gJM92eBKBaoW8rAMPIiCcPzegHBdF8IBmG4dyS2QfmVP/Uomu1+TDLIVowhzgDBVyH1yIM9TqUoN//cPACUr+HuMgJrlzisVDd4zH/oHZiPP5T4KZQ22KE/2RW8IgXldbsP3Fpmt4hRh7K5UtGxZ06PZuVsotGSM6+KyBa8kctENwCRnBYRxa0nfB63q914EZ65rB/ZUs81SEn+vFnHB+supS2rBSrnJNgD8WB3iSpRWT3XjsqUHAvgThfP1CnL5W2J8UNRGU8Ur9S7V2xdlh7HjZROQSf8xnX+fzDdgLuKP6mRisMRZ3N5HjHVAS9FBvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uV1x5xP7F1n+FIx2kmtOQgh1pW9PMoYNhyJugQgbw0A=;
 b=KHjT1h5lVaDMOc/uTdDIFh2eFA7fXLy+hsxNs0PpIE2+qp6krHVLFUM0WleuErGi70LFvdpe40A22WD69q2Kdb4xVCQCubr1Id0wZAElcvF4B4A9zEAJANTE35o51p+Z3KfIVVe1d01DjL6ezdTkUHx7owGbZyAl4fsxQczmQXVs5TPoR23FDaiMmbieXkaaTGJL0uL0JrTf9s3ejNpyyNmpVR6Tm6v9Fz5oryLnbkrKBRPo05GpYUH/zfs4TS9TtF/sKn5rtUk5I4gnWph3YEaXCXz5pRKok726V6775ORIvGi+rpjN3ZUBwk3BVEFTi4EKXPbABAhNWUodclFR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV1x5xP7F1n+FIx2kmtOQgh1pW9PMoYNhyJugQgbw0A=;
 b=vTASjm2/UsbFXxtJUu9U5uRbiGyFPDlFn0CX0NISAa/7jPNz6COSxk0oKSd9fPfB4KInD5TdZzD7+whuO0V5RnQm30s2IzRVv3n8BxRbdxdtbisnHjHjCBWPIfWzB8FqnZSVMSLpht+sckrMAzX80J9D6K2uA61+eT7UGBbIeSk=
Received: from SA0PR11CA0091.namprd11.prod.outlook.com (2603:10b6:806:d1::6)
 by SJ5PPFE4FC9FAB3.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 06:43:53 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::18) by SA0PR11CA0091.outlook.office365.com
 (2603:10b6:806:d1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 06:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 06:43:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 22:43:52 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 22:43:51 -0800
Received: from [10.252.212.85] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 4 Nov 2025 22:43:49 -0800
Message-ID: <eb0624df-3cae-46ec-9f7e-b45bea46a345@amd.com>
Date: Wed, 5 Nov 2025 12:13:48 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Enhance "Completion-wait Time-out" error
 message
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
	<Vasant.Hegde@amd.com>, <Santosh.Shukla@amd.com>
References: <20251016150809.5465-1-dheerajkumar.srivastava@amd.com>
 <tgugv7ebuxtnp6ou5jnt7od7jmccsipblqityiinhkgratosu6@bxsr73hpiiny>
Content-Language: en-US
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
In-Reply-To: <tgugv7ebuxtnp6ou5jnt7od7jmccsipblqityiinhkgratosu6@bxsr73hpiiny>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|SJ5PPFE4FC9FAB3:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b658c08-4d3b-452e-84c2-08de1c36af20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UCtLVE1pS0ZKbVErWkdyRjNsQWJ0MVE3eXY5NFUralEvcGdCV3FnclRtZThZ?=
 =?utf-8?B?dXY0Q05yUWs2UWgxQURFcXJWNjVKSC9FVFJCZUQ3ck0rcFUrcWlYMGd3RExX?=
 =?utf-8?B?M3dLejRmZDJGbWYyTWN5YzNrcWVOWk1Rd0xuemxUU3ZLN0VRMk51YXFxMTQr?=
 =?utf-8?B?UlA4NkdPdThvUTVVNkRlcGFDMS9MbnRvZHRkVDFwVTl1eTR4NUFKaTZ4L3Rq?=
 =?utf-8?B?NmxJeTdyckw1SE5Ra0ZQVUNYS0pMZnJzbTBlMGdVNjNpM2dNUis4dTBlcTM3?=
 =?utf-8?B?RWVlL0JubkRCc1BEUDNJdUhxYS9Zbm1aaG5Mckx3VzZHeUhyemtKQ0tIR3BJ?=
 =?utf-8?B?VXBPOWNJK3BIZGtONllrdG4xdW5YM1NtOW9hUHJQeGN3NnVQeGs4RnFSc3NF?=
 =?utf-8?B?OGNDbXJCa21JT1d4N1BtYXpJb3NLNTFRay9RNVozc0VDVlNKbGNiVWVNenNW?=
 =?utf-8?B?Szk5emZydlMzdzZ6VHdyN1hubjlTcWplSVNZQmcxVklpTEtCbWlycDl6N05a?=
 =?utf-8?B?MGR5MVIySjhjVlhGa2MwRENGUGR1VEpJUHE2cDNiR1V4MTNDUm1ETXdzUW9N?=
 =?utf-8?B?THNCVUgyK0ZGUkRXYWZSWVRpVjRQVGN2aXBqT2NxdGd3TDE5ajUxZ3RUaWw2?=
 =?utf-8?B?d2NTN1BuVmZ5M1dZVWc4NEdyYktjMUpGQjFEd1FLeUZUOFF5VTVUUnpONkY3?=
 =?utf-8?B?OFZOVUw1eVh2VnEzT1RDQ2crbENpdWRGU2o5N1hERGIxOW9mM0RSTHY4b3hX?=
 =?utf-8?B?aXI0QS82VER1MFBLcWZCVFFOV0FUZHZ2SFBkanhjb1RpTitVSFJSNjhWdm11?=
 =?utf-8?B?dHRzeUkybmlFQ296TXorYWgrOEo4YXhBMWY1dUdPL1V6ZzZmTkpNOTNhZ2kx?=
 =?utf-8?B?a0lCU0lMVTFUd3d1am1mRUxwYWRLL1NDQzE4cHB1SUtPb2l0dlNTajNtZXoz?=
 =?utf-8?B?OTZWVHo4ajNtSFQyb0Y1ZFV0dXBJZFFXOGR0KzhCbFBZRGtoREVJeHNRcmNt?=
 =?utf-8?B?QllBTG5TNGpLS3VLcDNwcDVZdno3cUVCWnFNSi9admtIUEZob0ZWd1p3eVV0?=
 =?utf-8?B?b1B3dnVEQ05CQ1UxZldLY25RNU5qeCtLSjFCWVQwWUhORHhUanp2Q0tHY2kv?=
 =?utf-8?B?d1BmUGVOc2RkYjJJNkdZcHo2dHJiSENjMk43RGREd3JtRjBmZFREekFHdVEr?=
 =?utf-8?B?S2xZN1VybEhxZjZ5TVZSRnlIcWJMdFYvRWJlRE5uY0l2VWc3WFErV0tuaEpl?=
 =?utf-8?B?eEJoRSs5N0x4dkhXY3ROMXFkK0dtTjkzZnIzLzRaVTU4eVNnU3F1TXVvWGpn?=
 =?utf-8?B?NDQ4NXN0S1NueFRqOHRSTVRRZTJHcEJzaWxMZ1J6akExT3Zlc3BxbjJRbURX?=
 =?utf-8?B?dDRwK1FBVmo1NndTVTVIbG4yemh2MWk0S1loQWhjSlVSaHExUjd6Y0xzYTZQ?=
 =?utf-8?B?ZDVKdDFNcFRkZDdoSkJZNWo5Sng4VjNnL2lEZ1dNYk5LNE00UXZ0Q2Y5OXVW?=
 =?utf-8?B?cWlERk9hZWRaQ0ErNTRiT2NGNThtTGhCNjBHRkhLYVBRVndQYXQ5ajlsM0kx?=
 =?utf-8?B?Z3hmYy9ibW1QaElpbnRwbWFVZjMwemtZa2k2Tlh0cURYT3V1VjFUaVgrVlBF?=
 =?utf-8?B?Q2xjR3VHOG8wR1FNZVh4QjJUQ29lUmEzUzh6MkZNb0xvWjArRGxESTNUR0Y0?=
 =?utf-8?B?QmxrNVZBWjhzeUh0cmhlQVAycEwweUQxZEd3Qm9VcnhsOUVFTXhXN1A5UWpu?=
 =?utf-8?B?VGdtcUMxcHZaUmJ1U1B4RS9URHJOdSt5YjFQWmJFemFZQnd6akpFV0pWVktC?=
 =?utf-8?B?TlM4L1pPbWlLTVRhbzJDZ1ZobkhxM2h5SWdaRlBzaDJwczErdFFOWnNUeUNo?=
 =?utf-8?B?QjlaV1dpNFlteWszNE5lVWtGcEYzaC9LbmUrR1pXNEVLamJQeFhhN1lQaTU0?=
 =?utf-8?B?UVlIRmx1UUdzWjZ3aCs1NW13RkhZMkpFUEJWaXphZmN6ODR3SXRlbWIwbWVn?=
 =?utf-8?B?aG9rNVRwOHJxazJDMERXS0RFcXJmOG1TUGE3UVpjc2ZtTm9VQnVqd0wxRzRx?=
 =?utf-8?B?YU1FNnNpVWdWRGt4cVdDTjlYL1AyMnBYa2NVVkhtL1hlMEs1a0paQTVJamVD?=
 =?utf-8?Q?k/MA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 06:43:52.4497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b658c08-4d3b-452e-84c2-08de1c36af20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFE4FC9FAB3

Hey Joerg,

On 10/27/2025 6:19 PM, Jörg Rödel wrote:
> Hey Dheeraj,
> 
> On Thu, Oct 16, 2025 at 08:38:09PM +0530, Dheeraj Kumar Srivastava wrote:
>>   static int wait_on_sem(struct amd_iommu *iommu, u64 data)
>>   {
>> -	int i = 0;
>> +	struct iommu_cmd *cmd;
>> +	int i = 0, j;
>>   
>>   	while (*iommu->cmd_sem != data && i < LOOP_TIMEOUT) {
>>   		udelay(1);
>> @@ -1166,7 +1167,33 @@ static int wait_on_sem(struct amd_iommu *iommu, u64 data)
>>   	}
>>   
>>   	if (i == LOOP_TIMEOUT) {
>> -		pr_alert("Completion-Wait loop timed out\n");
>> +		int head, tail;
>> +
>> +		head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
>> +		tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
>> +
>> +		pr_alert("IOMMU %04x:%02x:%02x.%01x: Completion-Wait loop timed out\n",
>> +			 iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
>> +			 PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));
> 
> Better use dev_err(&amd_iommu->dev->dev, ...) here.

In the early boot process, the command buffer is used but 
iommu->dev->dev is not set, which can lead to a kernel crash with dev_err.

Thanks
Dheeraj

> 
>> +		if (!amd_iommu_dump) {
>> +			/*
>> +			 * On command buffer completion timeout, step back by 2 commands
>> +			 * to locate the actual command that is causing the issue.
>> +			 */
>> +			tail = (MMIO_CMD_BUFFER_TAIL(tail) - 2) & (CMD_BUFFER_ENTRIES - 1);
>> +			cmd = (struct iommu_cmd *)(iommu->cmd_buf + tail * sizeof(*cmd));
>> +			dump_command(iommu_virt_to_phys(cmd));
>> +		} else {
>> +			/* Dump entire command buffer along with head and tail indices */
>> +			pr_alert("CMD Buffer head=%d tail=%d\n", (int)(MMIO_CMD_BUFFER_HEAD(head)),
>> +				 (int)(MMIO_CMD_BUFFER_TAIL(tail)));
>> +			for (j = 0; j < CMD_BUFFER_ENTRIES; j++) {
>> +				cmd = (struct iommu_cmd *)(iommu->cmd_buf + j * sizeof(*cmd));
>> +				pr_err("%3d: %08x %08x %08x %08x\n", j, cmd->data[0], cmd->data[1],
>> +				       cmd->data[2], cmd->data[3]);
>> +			}
>> +		}
> 
> I don't think it makes much sense to just print the command before the failed
> completion wait. In case of a timeout and amd_iommu_dump == true, just dump the
> whole pending command buffer, from head to tail.
> 
> Also, please put all the parsing/dumping code into a separate function.
> 
> Regards,
> 
> 	Joerg

