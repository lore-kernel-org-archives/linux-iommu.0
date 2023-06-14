Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004813FE6
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 08:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5KHeNQ+jz8vffJ2qqDMfGGvSCmaH88vIIukWBa40c8+eXf3ukh8bZ6SDieRDqwu1I+2haDIidNGmPzdAvlG5ThPV6J+teGdzEBflCatoSPsb1nhi0dSzW2/loU2Tm9bstE3M7G5sjAapeG293j6N4ux3uOMc/us/qe+i+E8Q3JxSjfTTnVNyVlCOLI2EzNev0pQZjpUnI317tdN0ucCb3C2Z+CSC0KDw2kc20GgUdX7IRAJayx1uMTAlYKQtKyzogDgC0fBehpyIB7pGXJ6ZRCc4prP54GjKAAVFLMWdaZRRyxCphIXDBwi6QxH2cuUPSnyo9h+yRyXfWAB5q5cIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxvAE/LQ15otOC6WHK6xzO47H40Ec0qpaDAo6oCWBrg=;
 b=nnyskjxHcdy/LgbYI+qXOMwdEkActnW9fqv/k8oVe4xF1F1yBwZxcr+rQtYKtKNr/5e/rJLYavLvIo2vqZt9z6QvXyqroZyVOTVcJnr17jlYCuDQ8L7b5C5vwTBgnU9xWlkroSJYjHltlGKziafWlbR6O8Ki1aK/lIkyx0EJtEOzt8JC6e19ILrnzuddbtG3lSKKfe5U+muwakhF9qs8epnD4N7mdZQn4z+h0OdjiR7z1JfLSK5KstKjrGdEuzJC69tG4ybuIMtuLHbm7cANKMMOb2mF0rAP7XzIsPnZ1bbHEEUpOZXBCBif/3Yw3rOnPCBuDbebYLufwG+PQmRQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxvAE/LQ15otOC6WHK6xzO47H40Ec0qpaDAo6oCWBrg=;
 b=MiSdSnvLoUMuQj+Ys9ZTgD6zJLhppf2EvbJqiqWJx3gy1kw3RqlCuxDtlAx6Oo/DPwem4mDxL09ZsYcc0NCrLmuWEhGdyqUb5iOMFjp778bkCi/+hpiz65B+S11pP2qXlSleK7NXuXKazDIXKA4uGUKfNMP00gMqTt1t5Gc6F6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.44; Wed, 14 Jun 2023 08:59:34 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 08:59:34 +0000
Message-ID: <14e5691d-1914-031e-8a8c-5a18c62fc94d@amd.com>
Date: Wed, 14 Jun 2023 14:29:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] iommu/amd: Add separate interrupt handler for PPR and
 GA log
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 joao.m.martins@oracle.com
References: <20230609102025.6498-1-vasant.hegde@amd.com>
 <20230609102025.6498-2-vasant.hegde@amd.com>
 <nm5ndwb7flwfa7tmgekubndrtmrd6brnjz77n2ub3iuoyyzcmv@msgzwfm3r4q5>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <nm5ndwb7flwfa7tmgekubndrtmrd6brnjz77n2ub3iuoyyzcmv@msgzwfm3r4q5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::29) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: b05d74cd-0ba8-4c97-4387-08db6cb5ac2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yf9pjNXZ7hfNdP/T+O5r8xsyN+K7O7dYUPeUr9fnyadBVFc+qxgKBfWZv0viSHtLWLgxAECXqpNmXr21jQu9TSjtDN6a6TSbfs9QWdKlpOa8vdBaYDmsup3qSH9U4phXQA5mknCkUP6duVK00oceQ2TLVMDMCXnhJKhkpg1s/dElaCmu+9lV4dVricuSixQD7PGa1hOxMt74BZD0/Ys/FZ9w2paWdWZQzBxpGLaQRwWXq43gA4haLDGDuHYECwXOztqnpOXI/z6akwfQbCY0+o2Wnij0VBjOjpxuYd5IaepofpqczTllsBbNeWcvlJ5IBkU8T1sW9Gbi9WxYT21I4vX+zp4l2F1b8xYu+PzadXGHoBJc05+eqe8G4uogH/gIktJnzAiGcAtG0yMczNccH9H/sajvymT6SqdQRr8+S6+exZAx+Ym/Yqx5UIaLH6XpeZiAkBiGLsyccfTi1jCZBjRhL6UfMuXFaXGpbuI0WimSbyLP9Yak62EI+nMDKXIpS/07HuMI8mkNvyjKOlTKM7WjYSh6lEWFzfTs/IjLEU3Khm3gUNNci1j2/P1ctmTrRco3Z+k7Ht57nGblgTNVlS1LaDFfjGagU6Ntw2v4qKFB69De+MMw0ESkBiRAdpwxwbxBMbAuf0kKHkXYTWlYwA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(5660300002)(8936002)(31686004)(4326008)(6916009)(66556008)(66946007)(316002)(44832011)(41300700001)(8676002)(186003)(2906002)(478600001)(66476007)(6666004)(6486002)(53546011)(6512007)(26005)(6506007)(2616005)(36756003)(83380400001)(86362001)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1hIdVpUQ1lOU1A1RTlGNHM1SHM5Szl2cjgzS2FvYVBsWFNuaUJtUHQyVmhi?=
 =?utf-8?B?bXBLVHBnbVdZN3pOdTBDMmt0cktKZHZSU1RkbVRibkVsMk82SW5kdjZOaExS?=
 =?utf-8?B?K1JRMkthb2pINExHNHIvRW80cDNTYnlCa2FJRW1rNWdCU3IyT21hcEdSTU9Q?=
 =?utf-8?B?QnJvTjh2djloZk1UQVlmZkNrSWs1SFhEb1pidGhqSWhRbGdPYVVZL0VMbDRk?=
 =?utf-8?B?d3cydDFqdldJd1IvU09taSt2M3VpRU5BamdBY0FYUWY2TEdhOG8xZDBqOTYw?=
 =?utf-8?B?Z0pneDFHQllEckEwV2pPb0lxelBGWW9QRW1zVjVIWG5LM0xUSm42Wk10Zy9k?=
 =?utf-8?B?dnM1R2VNT2lGeUFoRFdRVGU1eThVS0RSZXVDMGxvOUhHZHVvQVpkaXRkQ3dn?=
 =?utf-8?B?SGhtdDJzckFiTURmZjVNZktuMEszOXVsSnF3Y0h5MFpHNUF5NlhEcGR5QitZ?=
 =?utf-8?B?a0Q0TXpvc3BXMjY5YXZXSm9NWmFRU0Y3c1R5K2s2MzkxTUV5UG1zVWVwWTd1?=
 =?utf-8?B?em5Kc3M5NTBRdlJicG90WjYvZUdpNm1Ldy9Xa0dYcTh5SmxmUWtsRGlQQlhZ?=
 =?utf-8?B?ekR6eS92TnE4VTVCRXprZGFTSGhWYkVJOGN1NGNoZWVTWkI0WFhBcGtGSVlj?=
 =?utf-8?B?cWlybUJRZElQYWkzUE9KeXlXOGxXY0g2dlhReWJlSGFkMllCTTM3dDRqV3BR?=
 =?utf-8?B?bFBhK1h0Q2RiZ2srQWZ2ZjUyVytudnJpZnU3cUxTYzAzcU5TbmNEdk9RV29j?=
 =?utf-8?B?bjZXbjI0b3Z0YTRTY0U3U3Z1SXU4bGZOblRFelRNL1FQcjlPTmVWZ2U2ZVpD?=
 =?utf-8?B?emx5bDRlOWk2MFFreXJWY0p5OGd4a0FwTUMvZndNK1JZRGc5M2FLbGQ3RTcx?=
 =?utf-8?B?MUlvcCs2TURJRGU3MDlTRnpDenRCM3JIR1hVaUVuaWdZNUV1dzB4YllIVDV0?=
 =?utf-8?B?VHhia0o0ZDdoVHNMdUk0UURGa090YkhWb09oSHBZbTdUOStHSThqcWI2TFVp?=
 =?utf-8?B?eXcreUdhOEFSTUo4Zml0MWJXSThORnNrZVh5MmJEU2IrdHM3RHhOb2hrdldP?=
 =?utf-8?B?WlhUeFN4b2FBWTVzcmJnUjM1TmVNYUxnTjA5YjdsNEFERG95dzR2c1hKRU53?=
 =?utf-8?B?N09vQlQ2dGtwVUdqR0hhRDgyUkg4YUdxQkhCTWduczhwa1NoSncySjRlRkxp?=
 =?utf-8?B?YXAwbnBPaisyVERhbUFoZENERTJRRzFyaC9yZklVSnF3UkZnaXJtbXdkcVhj?=
 =?utf-8?B?ZlQwYXdnWVdjRHhaL21ZQjhieFdJelF5d2dzcVFwaU9CUHdpemhIN2ZxZk01?=
 =?utf-8?B?MWNoQWlzVjhCZHR4dUJmWHJQWjdXd3VOZ0JqZk9WelZrWktiRktLa1NRN04z?=
 =?utf-8?B?dHhzVVBPL1VzY2RrODZQdWtTaTM1Y2ZKSlZHb2hsMVRkSktEMWlLWnovcmdO?=
 =?utf-8?B?dFZoNTN5TDRBNnl2REdNekh4UFRqVm8zR2c3ZHlLTjNGNXVuS1g2blFtOGln?=
 =?utf-8?B?QlBoUzhWUzAreGJLd1FBY0psRnNnSGN4azVDdm40Nk9vT2dKOTBZcUdjQXZi?=
 =?utf-8?B?UUg2TWRNcXBlYk9zSDNpaUpieEtWRG1xd0lmS3FmUlR0WDBNN2VVRDNkSWlj?=
 =?utf-8?B?YnJ6TDRKVUsvLzVUcTJsMy9Uc1hsbTBZT21NUGxrS1dqaFEyZmN2Wm9yaURh?=
 =?utf-8?B?b1Y3TjJLbkhCZWh1RG9IUFlHZzRRSm8xV0JZM2V6eWEwMmFCamxFWWJhREpU?=
 =?utf-8?B?QzlUdlAveFVBZThvK1NFY0hrc1NNRzhHNVJCMzRkdnFKWkhVQUVUbmVGZ1Q4?=
 =?utf-8?B?dTJXOHFLVktOekg2eFpVdDFNd3RpZDdWd2g0ZHNDMUZ5WXdabWsrU1R4UXRl?=
 =?utf-8?B?YkF5WThjeTFYZ2UzNHJ4NGN2TEpaMnhVSnRIN2EyUmlkbU9ZMUZjWWl2cUFH?=
 =?utf-8?B?Qm5WeVIzL2x2UU1KZEl5aXR0bWthemFBVkIyRGY0UHRrNWRGcmI1bE4wcklJ?=
 =?utf-8?B?cW54ZVhIWHBnWjBnSUVObmtKZVBmOUM0RStnUmJCVXZOenhHcmkxVEhWb2Zl?=
 =?utf-8?B?OFI5TW4zdVBQTC81QTR4LzdGTDJBN3l1STBlRFJJelVuMTdYZHd0dG51TitJ?=
 =?utf-8?Q?gMuAXYK0wj1+mF2hpFRn3tqUD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05d74cd-0ba8-4c97-4387-08db6cb5ac2e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 08:59:34.1876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlrGDhIPfSBKBhTHwbXu4RMZLn2Nr7ircI+Fm4UyOOiSGR2VGQG9k+RukAAPuwgfj6lNozbKmk1Bh0Fxoje7gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562

Hi Jerry,


On 6/14/2023 3:08 AM, Jerry Snitselaar wrote:
> On Fri, Jun 09, 2023 at 10:20:24AM +0000, Vasant Hegde wrote:
>> The AMD IOMMU has three different logs (Event, PPR and GA) and it can be
>> configured to send separate interrupt for each log type.
>>   - Event log is used whenever IOMMU reports events like IO_PAGE_FAULT,
>>     TLB_INV_TIMEOUT, etc,. During normal system operation this log is not
>>     used actively.
>>
>>   - GA log is used to record device interrupt requests that could not be
>>     immediately delivered to the target virtual processor due the fact the
>>     target was not running. This is actively used when we do device
>>     passthrough to AVIC enabled guest.
>>
>>   - PPR log is used to service the page fault request from device in Shared
>>     Virtual Addressing (SVA) mode where page table is shared by CPU and
>>     device. In this mode it will generate PPR interrupt frequently.
>>
>> Currently we have single interrupt to handle all three logs. GA log and
>> PPR log usage is increasing. Hence, split interrupt handler thread
>> into three separate interrupt handler function. Following patch enables
>> separate interrupt for PPR and GA Log.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu.h |  3 ++
>>  drivers/iommu/amd/iommu.c     | 98 +++++++++++++++++++----------------
>>  2 files changed, 57 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
>> index 156f57b4f78c..e2857109e966 100644
>> --- a/drivers/iommu/amd/amd_iommu.h
>> +++ b/drivers/iommu/amd/amd_iommu.h
>> @@ -12,6 +12,9 @@
>>  #include "amd_iommu_types.h"
>>  
>>  irqreturn_t amd_iommu_int_thread(int irq, void *data);
>> +irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
>> +irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
>> +irqreturn_t amd_iommu_int_thread_galog(int irq, void *data);
>>  irqreturn_t amd_iommu_int_handler(int irq, void *data);
>>  void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
>>  void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 3c179d548ecd..d427f7e3b869 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -841,57 +841,23 @@ static inline void
>>  amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
>>  #endif /* !CONFIG_IRQ_REMAP */
>>  
>> -#define AMD_IOMMU_INT_MASK	\
>> -	(MMIO_STATUS_EVT_OVERFLOW_MASK | \
>> -	 MMIO_STATUS_EVT_INT_MASK | \
>> -	 MMIO_STATUS_PPR_OVERFLOW_MASK | \
>> -	 MMIO_STATUS_PPR_INT_MASK | \
>> -	 MMIO_STATUS_GALOG_OVERFLOW_MASK | \
>> -	 MMIO_STATUS_GALOG_INT_MASK)
>> -
>> -irqreturn_t amd_iommu_int_thread(int irq, void *data)
>> +static void amd_iommu_handle_irq(void *data, u32 int_mask, u32 overflow_mask,
>> +				 void (*int_handler)(struct amd_iommu *),
>> +				 void (*overflow_handler)(struct amd_iommu *))
>>  {
>>  	struct amd_iommu *iommu = (struct amd_iommu *) data;
>>  	u32 status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
>> +	u32 mask = int_mask | overflow_mask;
>>  
>> -	while (status & AMD_IOMMU_INT_MASK) {
>> +	while (status & mask) {
>>  		/* Enable interrupt sources again */
>> -		writel(AMD_IOMMU_INT_MASK,
>> -			iommu->mmio_base + MMIO_STATUS_OFFSET);
>> -
>> -		if (status & MMIO_STATUS_EVT_INT_MASK) {
>> -			pr_devel("Processing IOMMU Event Log\n");
>> -			iommu_poll_events(iommu);
>> -		}
>> -
>> -		if (status & (MMIO_STATUS_PPR_INT_MASK |
>> -			      MMIO_STATUS_PPR_OVERFLOW_MASK)) {
>> -			pr_devel("Processing IOMMU PPR Log\n");
>> -			iommu_poll_ppr_log(iommu);
>> -		}
>> +		writel(mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
>>  
>> -		if (status & MMIO_STATUS_PPR_OVERFLOW_MASK) {
>> -			pr_info_ratelimited("IOMMU PPR log overflow\n");
>> -			amd_iommu_restart_ppr_log(iommu);
>> -		}
>> +		if (int_handler)
>> +			int_handler(iommu);
>>  
>> -#ifdef CONFIG_IRQ_REMAP
>> -		if (status & (MMIO_STATUS_GALOG_INT_MASK |
>> -			      MMIO_STATUS_GALOG_OVERFLOW_MASK)) {
>> -			pr_devel("Processing IOMMU GA Log\n");
>> -			iommu_poll_ga_log(iommu);
>> -		}
>> -
>> -		if (status & MMIO_STATUS_GALOG_OVERFLOW_MASK) {
>> -			pr_info_ratelimited("IOMMU GA Log overflow\n");
>> -			amd_iommu_restart_ga_log(iommu);
>> -		}
>> -#endif
>> -
>> -		if (status & MMIO_STATUS_EVT_OVERFLOW_MASK) {
>> -			pr_info_ratelimited("IOMMU event log overflow\n");
>> -			amd_iommu_restart_event_logging(iommu);
>> -		}
>> +		if ((status & overflow_mask) && overflow_handler)
>> +			overflow_handler(iommu);
>>  
>>  		/*
>>  		 * Hardware bug: ERBT1312
>> @@ -908,6 +874,50 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
>>  		 */
>>  		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
>>  	}
>> +}
>> +
>> +irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data)
>> +{
>> +	pr_devel("Processing IOMMU Event Log\n");
>> +	amd_iommu_handle_irq(data, MMIO_STATUS_EVT_INT_MASK,
>> +			     MMIO_STATUS_EVT_OVERFLOW_MASK,
>> +			     iommu_poll_events, amd_iommu_restart_event_logging);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data)
>> +{
>> +	pr_devel("Processing IOMMU PPR Log\n");
>> +	amd_iommu_handle_irq(data, MMIO_STATUS_PPR_INT_MASK,
>> +			     MMIO_STATUS_PPR_OVERFLOW_MASK,
>> +			     iommu_poll_ppr_log, amd_iommu_restart_ppr_log);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +irqreturn_t amd_iommu_int_thread_galog(int irq, void *data)
>> +{
>> +
>> +	pr_devel("Processing IOMMU GA Log\n");
>> +#ifdef CONFIG_IRQ_REMAP
>> +	amd_iommu_handle_irq(data, MMIO_STATUS_GALOG_INT_MASK,
>> +			     MMIO_STATUS_GALOG_OVERFLOW_MASK,
>> +			     iommu_poll_ga_log, amd_iommu_restart_ga_log);
>> +#else
>> +	amd_iommu_handle_irq(data, MMIO_STATUS_GALOG_INT_MASK,
>> +			     MMIO_STATUS_GALOG_OVERFLOW_MASK, NULL, NULL);
>> +#endif
> 
> Is the else needed here, since GAEn will only get set if CONFIG_IRQ_REMAP is enabled?

In the current flow we clear the the interrupt bits (including GALOG_INT and
GALOG_OVERFLOW) first and then if IRQ_REMAP is enabled then we process GA log.
To match that flow I have added else part.

But you are right. We enable GALOG only when IRQ_REMAP is enabled.
Probably I can drop else part.


-Vasant

