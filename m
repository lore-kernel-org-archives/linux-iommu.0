Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880EB2F7479
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860297; cv=fail; b=Z/88lxfZ5RJeh1W4hdNHwThr40qNc/qPmlHKmp2JVJcPU2jsouBrGn/t0ZQa9LyydU97xkWieuXDfTFSEITXgm+8tfyJIH5fQ2bBJZCt1GxikXt9Mj4aEGOt8e/0eKG1dCHWiIkqS0ztgsvAQf8uDFL9cYejD0SbqWCVisLrBD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860297; c=relaxed/simple;
	bh=3jUkGYonRsP/2NY/u7N1M6ug+VR3PbqGN3q33+6G2R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MQftnH+3PDhzKCpZ2kKCDM431/FqRp3YvA30C2HBJfP+UWUCawj3F9skvD+BtQzHrTHWG9/wJwhPbQ+Kge3v/6rrPXe8BaB3xbnbHY1K/D60PFylXlSbTzSBCsoNIMKkj14FSGJ6lJaCUJHOtzuEYj8K+JpfdaG/X+wadpFp9GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CbO3AFM8; arc=fail smtp.client-ip=52.101.48.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CbO3AFM8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeRUgNdI08GDlQQ3kSdBSK09KbxkgfKcd72sXxqtuITpSPmvh3Iu80umeKns6khPwD/EoqzVcU1f4QHzejhx5t6A6Y6MPfMGh6zUxWORhEe1n1tQuHTQccKTrVUHbEphtu6v2iGXMa8xsQPdxu6zYdZqN85i5nhAHBONvlrMzvHAOrAo5gQd1+KI6k1D0YypEgfxZL18bqHAZ4VkBn0aSjbSX130cl/WGFqhRxdPq6HkM6Q3cadQQOCrp3Dt9G02/R4faCci1/z9V/BeYfT2U1bEgSVlK4ZmoybxLj5OgB8JChJVn5lTV9q7lcL1UFJunh0dQ+PiRcTbD1H1CMEylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWQPJTRlNZwjPuXInSamIGLtcYyaQ5BmzwUmWdPSKCs=;
 b=UDXGfc29RJ34gaEkjXkBeoUz893cFF/pzxgcka131FiOC6KHIi2iPPkWB78ZJBcslYX2x9I1k2aeMTcFQUniRMUaEyfOEJj4hZrldY8B2uLM6/et8m7XuEMm2OyLFNWuNMxtrfe/OdWb23LYOoP+f0jabK/qmV4uy786FcGdtfi7WlDX08600+vcQOyvBupJHKcviOodpjqkboHMoD7LcLsfug/QQsO4wsiUuRfpWNT87+4kbeiiKkERzJZ2YXj/J6Vq07Mj1eNkaOxMMOcSXQNox3dujYIwKHrU/f+EkK9bfE7ojRQ67G6fToBDApMIPv1q2LPC38HMJALeUzeGHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWQPJTRlNZwjPuXInSamIGLtcYyaQ5BmzwUmWdPSKCs=;
 b=CbO3AFM82w1Dx3/95rPYeMUyt55vaNXAU1As7JMNiUBV0pwaLV3WNCYb9EJ/SY0+xfmqstBJQER5AhdiKhxw/UkHF+XSGChNGMQWOZQr8ucj7LTdHz7zDBnBCQwOav1PGWhhglx4aSjC6bByfV+FLxbLvdipdO3T/3RMxR8Uwbk=
Received: from BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::16)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 11:24:50 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::4b) by BY1P220CA0021.outlook.office365.com
 (2603:10b6:a03:5c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 11:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 11:24:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 11 Nov
 2025 03:24:49 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Nov
 2025 05:24:49 -0600
Received: from [10.136.39.158] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 11 Nov 2025 03:24:46 -0800
Message-ID: <3a81ba12-ca32-4565-9b07-5b89629f0ed5@amd.com>
Date: Tue, 11 Nov 2025 16:54:40 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iommu/amd: Enhance "Completion-wait Time-out" error
 message
To: Ankit Soni <Ankit.Soni@amd.com>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<suravee.suthikulpanit@amd.com>, <Vasant.Hegde@amd.com>,
	<Santosh.Shukla@amd.com>
References: <20251105080342.820-1-dheerajkumar.srivastava@amd.com>
 <mmmsb4pp37slzy65ez4z5i7z342zx3vdxbll5axuio2ugdzzbt@i6yurbrb7k2o>
Content-Language: en-US
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
In-Reply-To: <mmmsb4pp37slzy65ez4z5i7z342zx3vdxbll5axuio2ugdzzbt@i6yurbrb7k2o>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d2b1c4-b22b-4c9d-db1f-08de2114ed97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmpPbm1lMnFLd0RMZkVtSkhQTG5KS3Nlamdkbi90bFlUbE14dHZsRVEvZUts?=
 =?utf-8?B?bStJY1BUOTdLbkhsRzhyUTc3QmcxemwzQTZVWnNja1l2aEwzV1pxZjcxVFVB?=
 =?utf-8?B?MnVHcWgzL2pheFFDWnpqS3R4WENnSndTK1licXhYTzMraFk4R0V3TDJyQml0?=
 =?utf-8?B?NjkxMDdVWDdCL0s5QUJnSTJFSUpQTStWTks3cWw2R3Ywc2JVQzEwU2N5Wksv?=
 =?utf-8?B?em84Y3ByVFpoQXUxYS8rV3JkclNFRmNZekFGWmtIL1N0a09nUUY0U2hVTFdX?=
 =?utf-8?B?WG1kdHpKenBqL0ZzVTNROXI1dWRzTzkrcnJORkFYWmVSNEJWWVRZZnBlc3J0?=
 =?utf-8?B?TW5FaUt2YWFZRllKMytnZWlERzJNYWdDWC9FOEpONjMxL0k1NWwwcFZBVWMv?=
 =?utf-8?B?aC90d3V1RElTZ2lnQ2R6RVRCWCs3cDJESXVYZmVoQ0RRaEZWejk4d2YvaGNP?=
 =?utf-8?B?SnlDZGNZRTAvOGs0UVlkQjcvUVlBUko2VjdIUXMvVkpNMjgzTUtqMlVMV01F?=
 =?utf-8?B?anZIdjZKazNtWEZjQzJ3bTVoWmRzSURZZDRuMXNCaGhEeFFSN0Z5Um8yVEt0?=
 =?utf-8?B?VFo5emNzMFNVQjBUOHlDWUNFSTU2S0dVZ0l5aEozeDAwN2s1SW1KQWZkSXFS?=
 =?utf-8?B?TXJaUVJQcEo4OWFRYlFBcHk5c3ZhWFVtZEF0WklWTk9taHU2bGZaUTllVDJk?=
 =?utf-8?B?YVpJT0hHbmp6S29qNEpKYkZzWU5FUFZNa2VlOFdsQlpReGpkbFg1Zjd5NHlr?=
 =?utf-8?B?UGF2NjEzRG9ZTUt5QTZiQ2pzeXlJNkg3MWNJQ0V0ZGw0Nit1Nk9YR1U2Zk5O?=
 =?utf-8?B?eG9EYmpMLzVWbmtHMU9Wd3hZSngwL056TjRnRWJuRDZLSXRrWUU5OEp5RDB2?=
 =?utf-8?B?ODNrdUI4UGRHN0YwME9ia20vQTlmSEsvclNNakg2Uis5SW01TnVlUFZ1NEVu?=
 =?utf-8?B?ZWplVTVTVlhGNlZjbzFkd0JTZzVzZVVEQWRZbWxDWUpXR2NKWDdEYUIvZmZK?=
 =?utf-8?B?a0pjaG5OQXdaZ0JucnlKVzRVVEo2ZDdBdkVFaTZORWUwbGdUdFlGU096RjRG?=
 =?utf-8?B?a0UyMG50Z1p5ZmVwZ0ZBdG0ycWJlU3J2eDlDY1RSWDNLYlg2d01DcGJpYTJv?=
 =?utf-8?B?b2twbTVWby96TTl3Y3BSa2FabWhGMnI1N0phZExmRlYzWkwyY3IzcitPYW1J?=
 =?utf-8?B?c0JMT2ttUlpzQjFMQ3VxSTFDemtGZ3lqT0Q3MTZtNDdyK3ZsdTlIeWNPTnRD?=
 =?utf-8?B?SG5PNHRoODl0bTVicExtck50U0VnK0Q1MUFSUklwaHcxTFFvN0FBRWYwMUVY?=
 =?utf-8?B?am8wZTVIZFp2bVJERUVCUDJCSExBVDB0ZzBVb1dNZENsaW9GSi92ckxsWnNZ?=
 =?utf-8?B?bGJadTdRZHdZd0pXcVF5QVlhNFRXRXBKUkowZ0JqeHUwUFRQYUNBVithRkRB?=
 =?utf-8?B?QnNESGw1ZWdKQU9ycWdqRkY5a25ZUXZ5SEVxVE0rcGVMMDBiYVEvKysrMGY2?=
 =?utf-8?B?L01XSUc1UzF4MGlmWS80Wkt4M2FJTHVnUEQzbzNyWkJiM0lwWmVCUjBnbjFJ?=
 =?utf-8?B?b2UvclgwSERTc1Z0ajlyNVZYSUpDbSt1TXZJR09TYkxVWnNieW9DWnA1SCs3?=
 =?utf-8?B?bjBFQ0xFY3VUUnBtK3JDMEd6NEhVcURoYkR4NzlzV29VZkE3Tko4OG9nK0VH?=
 =?utf-8?B?bG13WGJQUjUyWmhXd2FsY3ltTjZUTjFmd0JpOTRNV2tUVkVmTmFDbXBPd3dn?=
 =?utf-8?B?VE9Yb1VlOXpVQmlvbnFRWTlUQ21qdVcwdjFFeCtEbW9ZajNtZjBMU3RrN1Vv?=
 =?utf-8?B?bElJSHBsb1phREtMRFNQZG5zVEVSaTA0OGJsMk5RSGxTb3FiM0NkT1BMa1FP?=
 =?utf-8?B?Q2ozY2svU0ExdjVicklMOEdHLzk4TWF4VVYvSGNiMnJlTGZjT1l0aWM5QVB0?=
 =?utf-8?B?ZmFjaWE0ci9ubHBlL25vMDlTcWEyN0JqaGNLUUI3NUJ1WkxBL0NiN0kycEtW?=
 =?utf-8?B?WkZvTTRhQ2V1R2pXVFVaL2s1UERVMEh3a01nQ1M2RC90MGpML1dzT0Y1Y0V3?=
 =?utf-8?B?cVFNQjUyV2wyMm42VkIzVFRTWXh0NVZwdnNqdzlqc3MrTGdBUnNvSWZKdjhM?=
 =?utf-8?Q?KJlY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 11:24:50.1048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d2b1c4-b22b-4c9d-db1f-08de2114ed97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

Hi Ankit,

Thanks for reviewing the patch.

On 11/7/2025 7:36 PM, Ankit Soni wrote:
> Hello Dheeraj,
> 
> On Wed, Nov 05, 2025 at 01:33:42PM +0530, Dheeraj Kumar Srivastava wrote:
>> Current IOMMU driver prints "Completion-wait Time-out" error message with
>> insufficient information to further debug the issue.
>>
>> Enhancing the error message as following:
>> 1. Log IOMMU PCI device ID in the error message.
>> 2. With "amd_iommu_dump=1" kernel command line option, dump entire
>>     command buffer entries including Head and Tail offset.
>>
>> Dump the entire command buffer only on the first 'Completion-wait Time-out'
>> to avoid dmesg spam.
>>
>> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
>> ---
>> Changes since v3:
>> -> Dump the entire command buffer only on the first 'Completion-wait Time-out'
>>     when amd_iommu_dump=1, instead of dumping it on every occurrence.
>>
>>   drivers/iommu/amd/amd_iommu_types.h |  4 ++++
>>   drivers/iommu/amd/iommu.c           | 28 +++++++++++++++++++++++++++-
>>   2 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 95f63c5f6159..7576814f944d 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -247,6 +247,10 @@
>>   #define CMD_BUFFER_ENTRIES 512
>>   #define MMIO_CMD_SIZE_SHIFT 56
>>   #define MMIO_CMD_SIZE_512 (0x9ULL << MMIO_CMD_SIZE_SHIFT)
> 
> It's worth adding comment for MASK 4-18.
> 

Sure.

>> +#define MMIO_CMD_HEAD_MASK	GENMASK_ULL(18, 4)
>> +#define MMIO_CMD_BUFFER_HEAD(x) FIELD_GET(MMIO_CMD_HEAD_MASK, (x))
>> +#define MMIO_CMD_TAIL_MASK	GENMASK_ULL(18, 4)
> 
> Since HEAD and TAIL masks are same, may be, you can use something like
> MMIO_CMD_HEAD_TAIL_MASK().
> 

Agree, but I’d prefer to keep them as separate definitions for clarity 
and potential future changes. Let me know if you have any further comments.

>> +#define MMIO_CMD_BUFFER_TAIL(x) FIELD_GET(MMIO_CMD_TAIL_MASK, (x))
>>   
>>   /* constants for event buffer handling */
>>   #define EVT_BUFFER_SIZE		8192 /* 512 entries */
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index eb348c63a8d0..abce078d2323 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -1156,6 +1156,25 @@ irqreturn_t amd_iommu_int_handler(int irq, void *data)
>>    *
>>    ****************************************************************************/
>>   
>> +static void dump_command_buffer(struct amd_iommu *iommu)
>> +{
>> +	struct iommu_cmd *cmd;
>> +	int head, tail, i;
> 
> Since readl returns u32, prefer u32 for head/tail to avoid any surprises
> or sign-ext issues.

Sure.

> and similarly use %u in pr_err() below.

I’d prefer dumping the head and tail values as integers, so they can be 
easily mapped to the command buffer entries indexed by integer offsets. 
Let me know if you have any further comments?

> 
>> +
>> +	head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
>> +	tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
>> +
>> +	pr_err("CMD Buffer head=%d tail=%d\n", (int)(MMIO_CMD_BUFFER_HEAD(head)),
>> +	       (int)(MMIO_CMD_BUFFER_TAIL(tail)));
>> +
>> +	for (i = 0; i < CMD_BUFFER_ENTRIES; i++) {
>> +		cmd = (struct iommu_cmd *)(iommu->cmd_buf + i * sizeof(*cmd));
>> +		pr_err("%3d: %08x %08x %08x %08x\n", i, cmd->data[0], cmd->data[1], cmd->data[2],
>> +		       cmd->data[3]);
>> +	}
>> +}
>> +
>> +
> 
> Remove extra line.
> 

Sure.

Thanks
Dheeraj

> Best,
> Ankit
> 
>>   static int wait_on_sem(struct amd_iommu *iommu, u64 data)
>>   {
>>   	int i = 0;
>> @@ -1166,7 +1185,14 @@ static int wait_on_sem(struct amd_iommu *iommu, u64 data)
>>   	}
>>   
>>   	if (i == LOOP_TIMEOUT) {
>> -		pr_alert("Completion-Wait loop timed out\n");
>> +
>> +		pr_alert("IOMMU %04x:%02x:%02x.%01x: Completion-Wait loop timed out\n",
>> +			 iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
>> +			 PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));
>> +
>> +		if (amd_iommu_dump)
>> +			DO_ONCE_LITE(dump_command_buffer, iommu);
>> +
>>   		return -EIO;
>>   	}
>>   
>> -- 
>> 2.25.1
>>

