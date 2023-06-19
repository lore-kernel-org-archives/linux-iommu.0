Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEBBC123
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 10:16:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ffjk//qsTlUXtK7UFbUFdYh+9w0HITKwKrCk5fBgVEnzblZCV8feUGlB+WwW8GoTxyP80NGej3nG4S8HTo7NLCUg8I4Zg+xDSArKqDLYzIUvaVqJLGV4j8Lqt2NThS4z9Y7vTtDcK3bbYkRcz1flIM51KOMN5dklzmBKOWyU9LjqZSgmrf+LSivjUkAlt08MiLD7o19LNhWLHXXjEBFRCJtqYiY5vj79vkITYsPCAtr2JmsIDNykrPiyb+GOtIC9Bdhy2mnqKm58aVC8HK+nA2sytWSr8NZOZY8jxlGSTyYhJZ4BOmQQhujSgjV8QaiQCwTUYILBz5Xe7GPIc9PdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sv7YgL5CpPFKicqy+ou+mMGbnGr0aCaMX+HVirZxJ0=;
 b=l/TQ4DexaHWaT2PFVmBRXZHDEyQJqLbB5QclEcKqB0oWyj2NTJnMKpMPqBPcgID5bFz1HU1KfVQRE8b6c3rXqJWB9ujOfQILD7xx8p66Kal7cZCDVC1Vd4ihN0gqWnUqliGCOxWSrE0LznDfWu39+FUPpgqDHjdcQdtqQeB/sbPch07Q137wemEgNhFLEEwdoTI0CjsdLFI/p5NM0lFjmVpory9nyCelhCiktw2O5XUTfmjgLGnerXNOAaxZ0TEMk/jCuRJGeOjVj0dsfBtk5YG0FMUqTdeGWxSkotqhgc1nUwB4vrH8fi154T1zcNnFT/AjMuQ7hxBVPSvFQCyc1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sv7YgL5CpPFKicqy+ou+mMGbnGr0aCaMX+HVirZxJ0=;
 b=j5G4BKn4UFAzpYRCaex2AQ87QAEco3gas4CTrom+B0eyiumdtNcRrVmO229wvltvNN0obJJiB0rnN6I4g5beRNqlrEF8ixhYCHlg+OPjHUAc5EU+OjtUPQB22iWsMzlIkRGlmHy8Gj282C56Jfsq/X9VU/S9ijsENmh9SXgGVRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH0PR12MB5155.namprd12.prod.outlook.com (2603:10b6:610:ba::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.36; Mon, 19 Jun 2023 10:16:38 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 10:16:38 +0000
Message-ID: <60549886-795b-a7dd-0311-699df7ac4b56@amd.com>
Date: Mon, 19 Jun 2023 15:46:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] iommu/amd: Enable separate interrupt for PPR and GA
 log
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 joao.m.martins@oracle.com, Alexey Kardashevskiy <aik@amd.com>
References: <20230609102025.6498-1-vasant.hegde@amd.com>
 <20230609102025.6498-3-vasant.hegde@amd.com>
 <6efnbi2x5stp6npyx54ced2uykwq2nvx6qs2ldgboru4bi4dwm@zivxbrdtnxoy>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <6efnbi2x5stp6npyx54ced2uykwq2nvx6qs2ldgboru4bi4dwm@zivxbrdtnxoy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0232.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::10) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH0PR12MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5c51a8-1b37-48d3-12e8-08db70ae446e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SmCGcIWNsVNNAQfVMUnWw57ho/9T8eEZi+ex+9lvlwO1XPXbWKFfvonXbfg/oAgu2fmGYlspqQflPWa0dyI6YQhMtp5/X9gHv2Q2S8tzPmOfmAHTe6vZ6MgBd5LL+ozyo3K8F6CryFj5QzB5NlYJ65x+snQdbJwpc5TX8/F+dDCTJa8CaktWtOFie1A1aAjJIYpzWLV8cZlix6e0OfdtK86XBj80kOR3VeDlnL04CbhHj9aHrLhIywQYElzgt+4/jBjDNppIh85cwmzTwwb+jxBNn1qVtNeKdfuvPWeq28WuBlLEPwAAJ4GRc4wJgogZCggK8OmJJInz1CdD8/rCalGFRm07evdPnG+zVviYtQ3igSaZryX9yZvauTOquQjr40UnM/7HVisv/VrNfke2LesQjvE2eb8oLFP3P6jbrB0o3zldqI4OXOeEdgl+/LHJUJiDKOi/bDL8x/zZjAethJnYGIkqBG1FCcLuX2Il7ZMihMKYTU33N/RIONP2xnP0MwQKCPG0WMi+ARmXMz+ARXje948FS0H05fNN08divEZaWuL1XrFWXkq8hODAEm3fi6OP8Il/xbp3fK+7CbYgeWCwik0Pd6anaHH5kcimv3glmBaxOMTYrfFYx697Qm9nQ25lgxAPG3PbTpWEc77ZtQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(186003)(26005)(6512007)(53546011)(6506007)(2616005)(83380400001)(38100700002)(478600001)(4326008)(41300700001)(66556008)(66476007)(6916009)(31686004)(66946007)(8676002)(36756003)(316002)(8936002)(6486002)(31696002)(44832011)(86362001)(6666004)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTVLQjA5MldSendjeUtpV3c3aC9xV0lkc0JadXpMc1V1ZmpOVDNmd080Rytm?=
 =?utf-8?B?Si9ZN3drNGZIaWhjNUs3bjNpZGp1VFEzRGZQOUM0Z2d4VHcrc09iT3d1Q2tR?=
 =?utf-8?B?Y3VOVzBVaFZZdTJRTE44TjF2b0R4T0g1UWUxN3lWTkRMeUtXN0swN2FxZEZV?=
 =?utf-8?B?b2RjWUdKaG5aWTFiVmoybHZuY1Fndks5Nmt1a2Y5cE9VSnVuNUJ5RFB5cTBK?=
 =?utf-8?B?dEY2QjRzbGcrTHZxQnhQQVEzS05CN05ZQWR5cGNFYmVBbkV4cGMxem8zdkZI?=
 =?utf-8?B?K0phV3F4NERrYmp1NnRteTBna296SGNYWjdwTFY0RTRMSTRaVmV6SlNzdFZR?=
 =?utf-8?B?Z2xzeUhVc3ZLcHduQlhWdWpmeHJKblFXVHpzNkM1MmJZTWhUK1NVeGc0b2U2?=
 =?utf-8?B?WFlDZzRIM3V3MXE3VHZVdVJtcS92aUpLL2JHUmh6UTI2VUVyZHYzbkZRenZn?=
 =?utf-8?B?SlBQQUlnalgzK1VXYjhhS3pZNklMZ0NXdnN4azhIc3BySmFUdVd2Q0lvdE9t?=
 =?utf-8?B?YnY3WmdwenBDaW05TTlnOGRLOTFvMVVNK1AxUjdFSU92MUU5VHV4L0M1b2pt?=
 =?utf-8?B?ZStGd1ZnY1psYkdSK0dRU1Q3cUs1b0s4ajk0cDhnS3U3alZKcVI4eldvbVFz?=
 =?utf-8?B?WEVldjUvcEVHNExWSmNXMDYxLzRYMjhvM0RWTUJCMFpteWg4eDVJQ3pvemYw?=
 =?utf-8?B?S3orMWF3WFdYcVFpTzVmWWlqN2VEYjE0SE41ZGM5T1BuaHNaSnNhSWFSdlFM?=
 =?utf-8?B?NDM2T2RvYVNZSmUzL1V2N3JTcE1Td2FNeFQ2WUJZSnpxb045N3FmT2hUeXVZ?=
 =?utf-8?B?MU1EYmJxSDdHdytlTnVQc09WZG1xaVdIQWxQQXUvbldGcVhzQ1hrZGZDMjVs?=
 =?utf-8?B?K0dSSWVXWWxyZVdZZ0RqdnpJSU8wUmFvUGZIc2RJN0pkZm5YbVVOTDgvZ05Q?=
 =?utf-8?B?RWpSeVhLZjBlb0UwRURacXk3QUVpV2EvTHJicmh4WWpmK0lIZHZCeTJmMjZD?=
 =?utf-8?B?N29aam1SVWQ1dGp6M3llZi91Q1pWVk5qYlNWTG5FT0lJMmpUeURNR3QzTlhX?=
 =?utf-8?B?elcyVnFOZVBhV0hsTlBUakd2V2xrNXpaMkVEeUVlK1ByYm1UZWswVC8zQkhT?=
 =?utf-8?B?NjJWUnQwTWNERlAwNnE4bTF3ZU5JZm42SDNod2Zmb0RXd2dkdTlUQlRZbHRH?=
 =?utf-8?B?L3dPUUU5M1ZWcnZVY0J1SlpvTHp5elkrWDcrQnpJcXlzaTJJS0V0dFI2VXd2?=
 =?utf-8?B?L2VGeUdIUU9hRXBvSmMrazJWOGxOS04xVTllTmJrQjErWVB4bG5Nb0paczZQ?=
 =?utf-8?B?eEM1STExRjUwZ2dZZEVSMlVMdVE3S0xuTG9EMU94UlhxUnJldW5jekJlVDZ1?=
 =?utf-8?B?STlLRU50c0JjVnJkV3lXemsvd2hmSTc2UkRtZjJSa1pOc3B2TGVIQ2ZIaVJI?=
 =?utf-8?B?bkhSdXhMUnNqQnNTVEpEdEI2Mi9aT052WUZ5NW04R2Q2YngrVFlSbzF0SGZx?=
 =?utf-8?B?OElhakpUcTkzeC85VDhacXBJYTNUTkUwVmgzSCtlS05ZckphMVRUL0dZRDhY?=
 =?utf-8?B?NzQxQTF4eDlNOTZoellSUG1waW44SEdNSlVma0t3OGFRYXBTOFRKQURkdXB1?=
 =?utf-8?B?WG5IcGxEajhVYzBlSVRBWks0QlF2bC9DOE9tWEFhRmZXangrZkw4ekpCTkJY?=
 =?utf-8?B?N0hZazFOQS84N29yakdxanZlUkdZbkw2WHpDek1SSitQRllvOEZPYUhjdU9p?=
 =?utf-8?B?aExNeE1PemU0ay9qS2duSGVnU29qMUNFVlBPNkFjczdjakdtTDhYOFZoU1I0?=
 =?utf-8?B?ZVUyeXYzczhpZkRRK3p5UXRPSUpsVkt5TEpHS2I5RUwwN05QTGU0L21uRHB2?=
 =?utf-8?B?djhjVDdmNnFrcFFhY3hUaGc0WGc2NHNaRGdBVFZKbUtHU1MwUm1jbEFwampO?=
 =?utf-8?B?WWFyY1ovYVlSaUJOTGpqR3hrTmc1MXQzcmVRK2VDRVEzcVJkb3d0Ymhvd21m?=
 =?utf-8?B?cVRXNEQ5ZWVjU25taEJCSzNkUUYzbitmWnhZRHRIblc4VjhQeUpRYmk2c25k?=
 =?utf-8?B?QVRCUmFReFZIRUYxc0h3WGh5WUVEQkxNOXcyNmRTaHN2UjFIM2lLOTd5RWZm?=
 =?utf-8?Q?9X5WQ0zEnncWzUSKDcR+U0PFZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5c51a8-1b37-48d3-12e8-08db70ae446e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 10:16:38.1996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZK3GhgFLIWHpdXX3YqNXjsjT48KM76IcXWJjq8mKXiW678CDqQQd6V4Vo0EEGay55nMmWKUprdtcmu3V8fwdPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5155

Jerry,


On 6/14/2023 10:48 PM, Jerry Snitselaar wrote:
> On Fri, Jun 09, 2023 at 10:20:25AM +0000, Vasant Hegde wrote:
>> AMD IOMMU supports separate interrupt for event, ppr and ga log. It has
>> separate interrupt control register for same. So far we were using
>> single interrupt to handle all three interrupts.
>>
>> Add separate interrupt for event, ppr and ga log. `hwirq` is
>> set to INTCAPXT register offset. We will use hwirq to [un]mask irqs.
>>
>> Also add support for irq naming. It will display proper name for irq
>> (AMD-Vi<X>-[Evt/PPR/GA]) instead of generic name (AMD-Vi).
>>
>> Note that this patch changes interrupt handling only in IOMMU x2apic mode
>> (MMIO 0x18[IntCapXTEn]=1). In legacy mode it will continue to use single
>> MSI interrupt.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu_types.h |  9 ++++++
>>  drivers/iommu/amd/init.c            | 48 +++++++++++++++++++++--------
>>  2 files changed, 45 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index a993e1bdb70b..65e18b590a54 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -704,12 +704,21 @@ struct amd_iommu {
>>  	/* event buffer virtual address */
>>  	u8 *evt_buf;


.../...

>> +static int iommu_setup_intcapxt(struct amd_iommu *iommu)
>> +{
>> +	int ret;
>> +
>> +	snprintf(iommu->evt_irq_name, sizeof(iommu->evt_irq_name),
>> +		 "AMD-Vi%d-Evt", iommu->index);
>> +	ret = __iommu_setup_intcapxt(iommu, iommu->evt_irq_name,
>> +				     MMIO_INTCAPXT_EVT_OFFSET,
>> +				     amd_iommu_int_thread_evtlog);
>> +	if (ret)
>> +		return ret;
>> +
>> +	snprintf(iommu->ppr_irq_name, sizeof(iommu->ppr_irq_name),
>> +		 "AMD-Vi%d-PPR", iommu->index);
>> +	ret = __iommu_setup_intcapxt(iommu, iommu->ppr_irq_name,
>> +				     MMIO_INTCAPXT_PPR_OFFSET,
>> +				     amd_iommu_int_thread_pprlog);
>> +	if (ret)
>> +		return ret;
>> +
>> +	snprintf(iommu->ga_irq_name, sizeof(iommu->ga_irq_name),
>> +		 "AMD-Vi%d-GA", iommu->index);
>> +	ret = __iommu_setup_intcapxt(iommu, iommu->ga_irq_name,
>> +				     MMIO_INTCAPXT_GALOG_OFFSET,
>> +				     amd_iommu_int_thread_galog);
>> +
> 
> Related to the question with the first patch, should this only
> get set up if CONFIG_IRQ_REMAP is enabled?

Ack. Will fix it in v2.

Thanks
-Vasant

