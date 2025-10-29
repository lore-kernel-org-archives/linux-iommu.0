Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013006.outbound.protection.outlook.com [40.93.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1630C635
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736591; cv=fail; b=Y+EWMrmo4laE5Sq1SOD8bvH6wK8LG257n0W/zCVGcMBomw4ui4Yur8jpU9H2sqgtYqeRCwHXh6XcYssIFaITMMnGUFnu5SQwx++/fhbe9TKNf/k9VwwEgAE18+8Zvcv74VPy8E+BqCLUGBh8MEvDsZWR+siNeODKKRwREKPfNRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736591; c=relaxed/simple;
	bh=OzQ7Fyk05+h9VIYG3byJeKi9zry0VFUnrd0XcVv+SF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DUa52wnU0nO923bRBe4PpIPvzuQEDdpJHAys85Lpc5fBhbw5WZgK05/hFge5huoH/hKywU3zbs8lTm0Wxn0JMWP5pYcXq167inXHsZuTQZip7iWRNad67+/HsscpAG+FzTh4S6pRpylsFnnYgqMvmX/jhmrbbfCw0eiQj1qaxDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RSI/l0Sj; arc=fail smtp.client-ip=40.93.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RSI/l0Sj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTeXO4rcGlo6Ni2uanyRfe4PKx7z1rR88uWFg8cgMiRSRJQAL0m1uadWfqZeM8H3367ByGNUyTyoLip1ZYKFmquRv1h06cOs6cPpiYuRcDCWxnDnyrX1iuhSd97Y11oxgmGieSKsACu2sjX95qM9ZK4udwcy5b0QBZTrwcWJdqlZBHFh3tUCz8X7AjzVFDs7MBFEhjH9dNQmlLp1cMKsgJIalXa0MCP/AGgJcP/11zRD3bhpwUNgbr1cetoLq2Wy8+9n6XykEZWMeOX+P5m/UfZIdntBXptagMrAE7MBQvZPtToPHO6tkHNUQCqA5nTZbLZTw7l+Hui+STpv+sMy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDCY25J01ugl5SrEKfk85tJ1hsIxWo71wWOxxOcpLjs=;
 b=EOY8cVpKqMm5hr1qC1mPBoGC1oRrGggLotd92b36HF+8eqC9AM/TsekHBnL5ERPp3HGEZFCoCOeSZkxb2qtWw6nKv85QcrJ16strLAzywe5m1UqjOLirHe2htpcTLGqcCzRM+R5ruF16SEN9Ia6cnsACF3oGrhjL34GruqjXquyyiV8Yw5vD12AidcvjJdpZ1AxTFa8OqDoJnLrKzmcUpI3ztA8hlxExYCtn+K3pXhbL2d3dRIDAweIV6EwQxjFPu8lhUjOp1QvhZ6yTvaR9AAaUYGbeQCKgzuQ5XbJx8bNkihFS1l8tG48FrNmujM9kg7JrxtUCjjSFLYJBvC2Fnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDCY25J01ugl5SrEKfk85tJ1hsIxWo71wWOxxOcpLjs=;
 b=RSI/l0SjLwVG7SsRTjH6QFxTK1ePE7XrZICj30lWa4RousAGsGZsvuPZdgl8Oen8aqpnkGXsOHPEOtWJyjkutREhCMwbVJ27Hi9lgNYVfmJinWq1Zo28JNhF22nsSNvFt/ihdNIBz0fintTLlsbc6ZTtHYAn+1izTbMXvuK3R4k=
Received: from CY8PR19CA0029.namprd19.prod.outlook.com (2603:10b6:930:6::18)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 11:16:26 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::d6) by CY8PR19CA0029.outlook.office365.com
 (2603:10b6:930:6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 11:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 11:16:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 29 Oct
 2025 04:16:24 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Oct
 2025 06:16:24 -0500
Received: from [10.252.200.251] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Oct 2025 04:16:22 -0700
Message-ID: <12665f0a-0a1f-48c3-8d07-b982064097ae@amd.com>
Date: Wed, 29 Oct 2025 16:46:21 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Enhance "Completion-wait Time-out" error
 message
To: Vasant Hegde <vasant.hegde@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
	<joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
	<Santosh.Shukla@amd.com>
References: <20251016150809.5465-1-dheerajkumar.srivastava@amd.com>
 <tgugv7ebuxtnp6ou5jnt7od7jmccsipblqityiinhkgratosu6@bxsr73hpiiny>
 <01c81b5e-d6a3-41fa-9758-37661e115483@amd.com>
 <5uof463yi5zq6y3rsjqdifktvqxe4ctb63koz4qgbwvjgiudlg@qtjxrrymt3mj>
 <4571f444-01ca-45e4-8465-745e16c1b73d@amd.com>
Content-Language: en-US
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
In-Reply-To: <4571f444-01ca-45e4-8465-745e16c1b73d@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 4145dadb-40e3-4a37-7b8c-08de16dc99ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW1UK002ajJHaFJKWUt2TGVzdmpod3V2eU55dk9JdGRKWUZENGZxdGNjZEJ5?=
 =?utf-8?B?OVJGczJrMlBMUGRFYmhHMmJ3YlZSeUJEUHVPMlIwWnVHY01Ra29hejloOXl6?=
 =?utf-8?B?SEt2TkVhUzFXUVU0Ujk1YXQrb3VUdVc2OGc3SzZiZlVzdWw3RS9lL2s0eFZt?=
 =?utf-8?B?VkdzanBINWJKVkttL2dBNTM1MU1HeE5yUjhaRGZtSzNPdHlXTFZGMktBSXNw?=
 =?utf-8?B?bzlzOHRXTHhqWTN3NjAyb0NyQ2svVEo4cWdGeW1MZkJaMEY5OENhc2dLWFdE?=
 =?utf-8?B?TzcvemZqbjJGSDcxZ2xCSFZoZ0Vzbjl4VUJqMmlOa1k0K1RTSmVDcUh2cXpB?=
 =?utf-8?B?cnh4QlRiMG9PeU9aQWNXWEhyakhIQVRMRlhKM3ExbkI0N0dlNUR1TGl6cllS?=
 =?utf-8?B?TDFWMkpQbjE2YjZXTmJvY2trNS9wQy9pNWs2cGNIdE5QNDdGd0RRMHNsY2I3?=
 =?utf-8?B?KzduUlc5NGYrV25jWlRWaGtuaVptR1ZSbXRPSTlhWENpblJnN2daRURrYVkr?=
 =?utf-8?B?SEZyRWJuekxlSldjSXNhKzZ6ZXFyeFZmd1VZdDRhZXB4Y1pXNWdLYi9QeDF3?=
 =?utf-8?B?dmlwYmMrbHBMNHZPSmZPb0VUOVZvVWtUUTFYZ1BiM1FndFlabThoVWtPa3F1?=
 =?utf-8?B?OEZCbER2RlBTdUx6YVF6a2l1WUM5dCt2N3lJU0p2LzNQaytyUG9RTElyT2ZJ?=
 =?utf-8?B?MlFjeERWZU1SN2lXSkZNcnNyN3BpRFI2Y3kzZEpJNXlEY1hFQ3UwU2VnQ1Ux?=
 =?utf-8?B?d0IwS2VINTBrekt2bzlMWnNCdDVDcVZyZU9Oekp1U3BFeDhESGx0NGgxZFk0?=
 =?utf-8?B?MUp6ckhvU0ZpaXNJM1B6WURQQ0VhSmxRN2ZoK2pUQmlMYmxTbFh2dDRrajZv?=
 =?utf-8?B?YUtZNFFQSWRrY0J2dVBuMDRYV3RzQ3JlTzA0eE4vTEloNXk0alBFMyt0OGpm?=
 =?utf-8?B?T2RDUStUdkxIQmxjaEVTWHdDdHlXVUdSVjBTM1dnaU1hSEp1b1MwOFFPZWUr?=
 =?utf-8?B?OTFYQi9UZWZmMDFRMkxKa0NKQmlKdHVCcFRJTmVCc0ZlaDhsUEtJekYzV0pU?=
 =?utf-8?B?YkM0dUwrWk13OHBjdFl4OUsvc1lSdkgxU2EyQTVKVEdUbG1FZkFkeGVpeitS?=
 =?utf-8?B?ZWZyUzVLcks1endrMnRXa1pqZGdVakkwdXFTYkNUdG5NZGorQ0I2RGpxUzZG?=
 =?utf-8?B?RkFqWVgxQjVFYlNWTmhDMExqVWVlVGlOWExpZ3p0ZE5EdC83T0RRcnl3ZzVh?=
 =?utf-8?B?TUdvVWpPTUtVeE83V3c0b2ExTnc5K1J2N095WnJIaFEwOUsrVnBBMitNK083?=
 =?utf-8?B?SVRmZk5XZDl3NE9iaG9tRk4zSmJkcWVEMFpteXVzZWFuYTVzWXNOTHJiZG4z?=
 =?utf-8?B?djlNZ2kyUk5JQ0VLT1hSRHo3aVRJdURUTDhYRDlVdWR3SE9xY2lheXBSRGVW?=
 =?utf-8?B?WEtMNzlRMHl5cWtoQXFFRGxXQUxvRGpySVMwaDNSZ2RCdkRBMWlaOUcrWk90?=
 =?utf-8?B?MlF4SXptTEthNEVDdWk2S1BHZHNoS1dYNENTcDNHQjJzZmNSWWc1dWR5VjJH?=
 =?utf-8?B?WERpVHdaWU9PSXU3OG52MnRHdUVaV2FsTGdZWmFaVWpvZ0hiNUFBcEM4enBC?=
 =?utf-8?B?aDhhV1JOYTdBbmtIWFg2bnNUTEJ0eUN5RGtEdXMxbkNJNFdWeGh4TlBveHBN?=
 =?utf-8?B?ZjIzTkc2V25GbWhBdjFFYzBFM3IxeWFvSUtGUG9mMjBnSUpZRTdrZjBub1h5?=
 =?utf-8?B?amJmLzhtbG9QbDNNd1hTNVRRd0R4REVkR3dESVJ5QnN4dExLVTVQZzh2MXUx?=
 =?utf-8?B?TTBvQ2tEU2VqQXRnUU14dmErT1FPSC9hUHJPdUZpNjlaYUVHUTNhaXJrWEVa?=
 =?utf-8?B?Ymt5TGtzOUVYVVJubm1JZlNBQUNMS0RYUnhuRnRDRHJzdHp1NHloZnhpd1BZ?=
 =?utf-8?B?YTNET2QyWSs4ZnBYN2FURm1RZHRwNk8ybEtXRDY0bytNRjVLZlorZFFMdkE1?=
 =?utf-8?B?Y2l5RGtHamNHalBZbmlHVWlVSWh0UHUraFU5VWc2RnRsVUo4NkdSQkxkbkNp?=
 =?utf-8?B?dXlqS0h3bEFmQStqMnpxdWRMWlpjM1VzVlM2UUJKY1ZFRXVEMlV6U0JicEtw?=
 =?utf-8?Q?hcOE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 11:16:25.9210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4145dadb-40e3-4a37-7b8c-08de16dc99ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873

Hi Joerg and Vasant,

On 10/29/2025 4:18 PM, Vasant Hegde wrote:
> 
> 
> On 10/29/2025 2:00 PM, Jörg Rödel wrote:
>> On Tue, Oct 28, 2025 at 02:45:16PM +0530, Vasant Hegde wrote:
>>> We have debugfs support to extract entire command buffer. Also many cases once
>>> we hit completion wait timeout, buffer won't progress.. and we will hit
>>> completion wait repetitively. Hence in V2 he has removed printing entire command
>>> buffer.
>>>
>>> Do you want to log entire buffer once to dmesg if amd_iommu_dump=1 ? (for first
>>> completion wait timeout event).
>>
>> I think there is some value in printing the command buffer contents at the
>> point in time when the timeout happens. When it is read later from debug-fs,
>> the state of the command buffer might already be different, making debugging
>> harder.
> 
> Ack. if amd_iommu_dump=1 then we can log entire command buffer to dmesg once.
> 

Sure. I’ll send an updated version for review.

Thanks
Dheeraj

> 
> -Vasant
> 

