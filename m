Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3326720DCE
	for <iommu@lists.linux.dev>; Wed, 20 Dec 2023 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jtv9mBmf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1aK0Uv4asJJuGPX40VPDH758pPPKuhlRDyiDyUDSV2n8IV1xHMjns+AWFsGsZ6UPsoY6dvN9vez2dXV6EqAb2YVZ9ghDDbQIOZccLDpgJGFKV62GOr3Z2kRqnpkIRXkLSJtYyx+AWq0T4KeF2nKJ5iqpVFug/ZXTFDLjo1BWeMC254BEnGWXyjux0zX61D2xVCkX0q9p5a0zOwb4qx4RumjUrcjNWoqAXJnYSAmG+rsctaX6fp6sFqS8ifrSpaAEl9eSgzscMpdDhwaTDu/WGC/+C+rae4hWlHMEy5i0FN4ypd/M1plXoYnIjrNPjZ9Slm0xHzoUMdKcPHUONfQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKJzX7hSVUPF07ngplK7Gz112DraB3GzY7BnxWtM+9M=;
 b=ofcOyl2xsCngN6PRVw/90IgLmpDPL2mRDggxHOzOe1KZ9VxAu7XsACZOcmy/MeEtUoIA+r96I9DzLVh5A9TqDATRxFXhql5hzcOHlmpHC0972lfDHfosqGt50OG7m1TqWj2jRMXaoCzqmchQCKX1ePt2cSGkkZEpDPsKq4szbbcslIlvCRIvRVzNf+IGTp+m0kqlQ3R4yN3CQhsVDoiWN0l+bcA4wZqFJbO2FYVrAzQZmezTUIsZhJEb830hSjhQPkXBgt/Eesct8m6D+dMN2m/WLca+4fU6U4K+G2YjcDsRZt6XNdRCOdUaaKB+BnVokPw/KH30UvsZbgKDr6KW0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKJzX7hSVUPF07ngplK7Gz112DraB3GzY7BnxWtM+9M=;
 b=Jtv9mBmfsehbKY+Z7E+8EwaEY+5j1gHkJDYqL2NIc3zmPKtZbR29gtt8ER8LobgJ6Vxj/e9kwx3KdsuDiejwwHFoXR7vC70vjejUxr0mnYgso3sEpnAy30Uo8dNH/pP9JAi+SMiShZgRB7Qij9h7Rw1W3hRynltUf77VTZvwaRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB6162.namprd12.prod.outlook.com (2603:10b6:208:3ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 11:00:10 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 11:00:10 +0000
Message-ID: <faafdd49-0849-2004-0088-5b4aae49b129@amd.com>
Date: Wed, 20 Dec 2023 16:30:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 05/12] iommu/amd: Initial SVA support for AMD IOMMU
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231016104351.5749-1-vasant.hegde@amd.com>
 <20231016104351.5749-6-vasant.hegde@amd.com> <20231106231831.GV4634@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231106231831.GV4634@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::10) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: 465508de-fea3-4bf9-35a9-08dc014ad568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CS/LrD+8r88xW66K4jKEJXUu9/w2d9c1bftl1C21Ez6TAcJ6HMXM9vRXJEm1POEHOlB8RPBJ/mHuLiasnwij4DwhtA4eOrXhb5o9ZlwnstYKdLEvQEDd0cmdnEFuqxeohjk0/JlRqjnZmujuoGT5dk1d+xXPjvxXCoLxf9914bS4dJgboBFVx9wnu6wtnNkdG81cA+DaSoxdYmjIHrbAzQVjzPC1ejC/++fWbhC8mird6eFlaUKIZOGjUR4LKe7fAF8bicOtzXMWWpun976yeUk61wSD9vndYyrx8lBOLM9dBQIdTyqpiEtPmP+elHm4wfTOnaCeQMmNvnhheNi1r4z7SW1Y1BolGPPPtFjVjH/SMDFn4Jk2S2s5omU6+rnj2xnjZVD1AaB4XRASl4H9qZBVIzzlPUlUMTWAwVrh3zeH4giRHZ8w9oWuEJfIznJo8b/QETh3RUEB1MNIrThv3v+a+xM5AVEr+ls0ppyaH2fpjWUberItCwCK5hf/ogVSfFuZKJgnPDu6NtBvru7Jn5qILP3kICOxYgRvf85f2Xs6dMLAi6dISPibkudT5vr83THjfiadTlgr7zNeyYVAGJrAycqYst5AdIiC9hajjWCcSAdKPxQ16lUDB9XNDbgcmrCovXFCZWyXvTe3pIOxTQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(36756003)(31686004)(66899024)(26005)(2906002)(6506007)(478600001)(6916009)(8936002)(53546011)(8676002)(66556008)(6512007)(66476007)(66946007)(6666004)(2616005)(4326008)(316002)(41300700001)(5660300002)(6486002)(966005)(44832011)(86362001)(83380400001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmRBbXpCck95WC9UaktXcFhoM2ZyVXNMRmtFb1B6QW1VcUw5M1czSWFtTTZS?=
 =?utf-8?B?RjB5NXhqSGp6S0Y3Q2E1MWNkZU50bUdhVDJ6K0FpU1gwWFovdXdaaGs4RktR?=
 =?utf-8?B?U25IbisxT3hqeTl2UWNJbTZOODc4dDh2T2JRUzgwc3ladTBFZzRtUHFFeHJ3?=
 =?utf-8?B?N2s0NlRHNXNuTlZPdm1RdklvQ2hlRTVQSzRZUUJRelpPSzVTMTMvZE1veHdi?=
 =?utf-8?B?cmhaT0R2byt4ZnJXR0twZXk0K2ltNnZ0N01TY0FEVXFIdE9XZEJyR243dFBP?=
 =?utf-8?B?enEzcnlaaUY5TCs3ZEhKKzF2cmVQbTVybHNPUmFhWDdrSWRsMURFZ25UOWVk?=
 =?utf-8?B?RGlTK2JBOTF6elhhejhIakc2V0RLSy9EeHcyYVpQYkVDN0xJMHhuK0czRlo0?=
 =?utf-8?B?aE5ubFdXbUU5QUdRTFJRbkZlUHdlRE5TZkI3ZERmcGNyM1VUdGtuN3VIZ0hj?=
 =?utf-8?B?cjZoSU9XMHh5SmlFOG9zNTRDTm1MbytVSS85RVgxaDF5UGRCUTVwSEtUNksy?=
 =?utf-8?B?ZnFzdmhkOXNIK0xXc3M3Vnk4ejVYSlEweVdOYWRNVlB2MjNRc3ByNUMrU1RD?=
 =?utf-8?B?SWlJY25wU0RqbGU4Y20xRWRDZ3E5by9aVFBjcmljblpQWEd3WU9JdnpMVjlq?=
 =?utf-8?B?REh3YldJS0QyY3NBVHRqVEtURTZNdVB1R0YvL3RabmRnS3VUbmdpQ212bmxJ?=
 =?utf-8?B?amRhY0RqaUZvc2RiWTMxR0sxUnAyaU5xTjhoWmxpQ1BBenhweWl1L2wwcU5a?=
 =?utf-8?B?SWFGTERnQkhjN20vQUdyZi9WK0ZLdk5pK2NmZTNZQ25NcjhDcThHdS8yWjZY?=
 =?utf-8?B?Q3lvb1l3ZWMwQ0xOS1ZMZHVPQlJudkZZaGhSK0paWXpxWW45N3VRUE5QMDBo?=
 =?utf-8?B?KzB3aEQyZ2Y3QkozVDVadXRQTXozWUpjZTgvZmMvb28wa0J1M1o2MGtBclpE?=
 =?utf-8?B?ODhXcENzbjJnalFSSFovazA3L1pFT2VzbVNpQkxvRHlkWDNpaCtkRzc4ZE8y?=
 =?utf-8?B?ZnFhWEg4dzVHTno3Sk9peFNjV1VMSW4wRVRKWFlzLzRXbTV3Wksrb0p6Mld4?=
 =?utf-8?B?Y2p6RUNVeHR5Q1h2WW5mRlZtcXlkd3lRQkJzNVQrc3p0VU9od0NzU21OOFBW?=
 =?utf-8?B?NDZGbE1xYlFSTkVRRmFkNmJBdnQ3dldkeUpFdzdQd2RlbVRTRjRSdGFiOTF3?=
 =?utf-8?B?MVM4ZVl6czhjL24wU291eFlYVnBFYk9WRm9pMzh4UjBYcExoeUhOeDdJS1Zi?=
 =?utf-8?B?L3N6eVZwRzdONWlaS0hsOTc3Slp0MGZKaGFpVTFoQnZoRXQwb1VqR001ZDFT?=
 =?utf-8?B?eEhuY2dJajJ3WGVDVUU0Q0hDdnNHRWVhbU02MkxCaWkvMUFVU21mUExmalRu?=
 =?utf-8?B?UEhpaWxEU1FpN3F1QlR6K1VmV3FOSDU2U2Y4YVFsNUFibzJXL1gwN3IrbWF1?=
 =?utf-8?B?Q3VKRkxQS0s0ZDExTDV0ZWRMT2NWNHpvZmJJN1U4a3BySDdGdDJqZTlhMFhu?=
 =?utf-8?B?ZFdacitjVWFKWmJSTFp0TXorb2xDNFZnUk40VlB2cCsyVERuQ1ZPZ3pLbE5F?=
 =?utf-8?B?ekpZY1FjNjFZOWpCcGtHaEZrOHFHT0liL2x3N0w4YTkvcEpiaUl3N1lOSmht?=
 =?utf-8?B?NEJWRXN3SDdsTmpBUGY4TUYxcWtvN09tdDlmWVk1d20wQ01POWNoZXU4eFdw?=
 =?utf-8?B?Tkx0MmlLNC9Kb3A3K3dmVTh2a05mSDk4eEhVbjJnNGIvM3pTVk0xcDNUNThz?=
 =?utf-8?B?bUlNdjN5bnVzQ3VsWCsrUmRXY0Z0MVFLOU80UjVmcTVSb0pETlNGL3oxK1Nn?=
 =?utf-8?B?NzZIelo5WG9jRmY5UzR2cTFlYmRpLzQ0a3BBclhpZWV6Uk5GZFAvWmFQN1hy?=
 =?utf-8?B?dmtXTTN2ckRwZHMxU1B1N3ZTank0alBocUk3Mzl0NWdLNkZqMVNhUVZCUHNL?=
 =?utf-8?B?c2QxZm04VkRrVWZlZUphVUtOVm1oNG9Idlc0NjJkNmErdlNNZTVMc1Zia0xQ?=
 =?utf-8?B?c1h4N3FPN2RGa3B5UTZCN281TXFDcWZheUJjT0lsYmtaelRndG5XOWVMb2V3?=
 =?utf-8?B?VW56SmhXYSttV050WkQvV2ZKUzVJditCYlhoRnM3TUlWZFhheEpqNGNHdkht?=
 =?utf-8?Q?zDZK90gSLXtCbZ3zt6b6ndU45?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465508de-fea3-4bf9-35a9-08dc014ad568
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 11:00:10.2666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tojeqodVP/WMGVODo0RqrANhC9ehsc8LF+s4ucRpK38OJk3ZcGjWBPs35MkhMMixBTI7qksF/w9n9zHwK2yuTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6162



On 11/7/2023 4:48 AM, Jason Gunthorpe wrote:
> On Mon, Oct 16, 2023 at 10:43:44AM +0000, Vasant Hegde wrote:
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index da94dca1eb92..20961353460d 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -8,7 +8,9 @@
>>  #ifndef _ASM_X86_AMD_IOMMU_TYPES_H
>>  #define _ASM_X86_AMD_IOMMU_TYPES_H
>>  
>> +#include <linux/iommu.h>
>>  #include <linux/types.h>
>> +#include <linux/mmu_notifier.h>
>>  #include <linux/mutex.h>
>>  #include <linux/msi.h>
>>  #include <linux/list.h>
>> @@ -541,6 +543,16 @@ enum protection_domain_mode {
>>  	PD_MODE_V2,
>>  };
>>  
>> +/* Track PASID list for the protection domain */
>> +struct pdom_pasid_data {
>> +	/* PASID attached to the protection domain */
>> +	ioasid_t pasid;
>> +	/* Points to attached device data */
>> +	struct iommu_dev_data *dev_data;
>> +	/* Link to protection domain */
>> +	struct list_head pdom_link;
>> +};
>> +
>>  /*
>>   * This structure contains generic data for  IOMMU protection domains
>>   * independent of their use.
>> @@ -556,6 +568,9 @@ struct protection_domain {
>>  	enum protection_domain_mode pd_mode; /* Track page table type */
>>  	unsigned dev_cnt;	/* devices assigned to this domain */
>>  	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
>> +
>> +	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
>> +	struct list_head pasid_list; /* List of pdom_pasid_data */
>>  };
> 
> Oh, see here is the data structure I mentioned earlier, it just needs
> to be done as part of the invalidation cleanup and replace the other
> things I mentioned. Has nothing to do with SVA.
> 
>> @@ -2432,6 +2428,8 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>>  	case IOMMU_DOMAIN_UNMANAGED:
>>  		pgtable = AMD_IOMMU_V1;
>>  		break;
>> +	case IOMMU_DOMAIN_SVA:
>> +		return amd_iommu_sva_domain_alloc(domain);
> 
> Same remark as I gave intel, you should take my patch (strip the ARM
> parts) to give this it's own op which significantly cleans up this
> flow.
> 
> https://lore.kernel.org/linux-iommu/20-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com/

Ok. I have grabbed above patch (minus arm stuff) and added as separate patch in
my series.

> 
>> +static void dev_pasid_remove(struct pdom_pasid_data *pasid_data)
>> +{
>> +	/* make it visible */
>> +	smp_wmb();
> 
> What is "it"? Don't put barriers like this, the barrier should
> immediately follow whatever store it is protecting.

Fixed.

> 
>> +static struct pdom_pasid_data *get_pdom_pasid_data(struct protection_domain *pdom,
>> +					   struct device *dev, ioasid_t pasid)
>> +{
>> +	struct pdom_pasid_data *pasid_data;
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +
> 
> Add a lockdep assertion, but it seems strange a function like this
> would even exist.. Better to call it "remove_pdom_pasid_data" and
> include the list_del(). And then pull the locking into here too.


Ok. I have renamed these function names.

> 
>> +static void sva_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
>> +				    struct mm_struct *mm,
>> +				    unsigned long start, unsigned long end)
>> +{
>> +	struct protection_domain *sva_pdom;
>> +	struct pdom_pasid_data *pasid_data;
>> +	struct iommu_dev_data *dev_data;
>> +	unsigned long flags;
>> +
>> +	sva_pdom = container_of(mn, struct protection_domain, mn);
>> +
>> +	spin_lock_irqsave(&sva_pdom->lock, flags);
>> +
>> +	list_for_each_entry(pasid_data, &sva_pdom->pasid_list, pdom_link) {
>> +		dev_data = pasid_data->dev_data;
>> +
>> +		spin_lock(&dev_data->lock);
>> +		amd_iommu_dev_flush_pasid_pages(dev_data, pasid_data->pasid,
>> +						start, end - start);
> 
> Nope, can't unlock while still holding the pointer. Use a mutex or a
> rcu scheme. Again this should all be general non-SVA code to fix the
> entire invalidation logic.
> 
>> +static void sva_mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
>> +{
>> +	struct pdom_pasid_data *pasid_data, *next;
>> +	struct protection_domain *sva_pdom;
>> +	unsigned long flags;
>> +
>> +	sva_pdom = container_of(mn, struct protection_domain, mn);
>> +
>> +	spin_lock_irqsave(&sva_pdom->lock, flags);
>> +
>> +	/* Assume pasid_list contains same PASID with different devices */
>> +	list_for_each_entry_safe(pasid_data, next,
>> +				 &sva_pdom->pasid_list, pdom_link) {
>> +		dev_pasid_remove(pasid_data);
>> +	}
> 
> Be mindful of any logging in other parts of the driver.. Ideally a
> non-present PASID translation will generate a debugging log but a
> released SVA will not.

Ok.

> 
>> +static int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
>> +				   struct device *dev, ioasid_t pasid)
>> +{
>> +	struct pdom_pasid_data *pasid_data;
>> +	struct protection_domain *sva_pdom = to_pdomain(domain);
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>> +	unsigned long flags;
>> +	int ret = -EINVAL;
>> +
>> +	/* PASID zero is used for requests from the I/O device without PASID */
>> +	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
>> +		return ret;
>> +
>> +	/* Use SVA protection domain lock */
>> +	spin_lock_irqsave(&sva_pdom->lock, flags);
>> +
>> +	/* Add PASID to protection domain pasid list */
>> +	pasid_data = kzalloc(sizeof(*pasid_data), GFP_KERNEL);
> 
> GFP_KERNEL under a spinlock - did you test this with full debugging?

Fixed.

> 
>> +	if (pasid_data == NULL) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	pasid_data->pasid = pasid;
>> +	pasid_data->dev_data = dev_data;
>> +
>> +	if (list_empty(&sva_pdom->pasid_list)) {
>> +		sva_pdom->mn.ops = &sva_mn;
>> +
>> +		ret = mmu_notifier_register(&sva_pdom->mn, domain->mm);
>> +		if (ret) {
>> +			sva_pdom->mn.ops = NULL;
>> +			goto out_free_pasid_data;
>> +		}
>> +	}
>> +
>> +	/* Setup GCR3 table */
>> +	ret = amd_iommu_set_gcr3(dev_data, pasid,
>> +				 iommu_virt_to_phys(domain->mm->pgd));
>> +	if (ret)
>> +		goto out_unreg_notifier;
> 
> Something looks missing, what if the RID domain hasn't installed a
> GCR3? Eg it is a v1 domain or something?

I do have check in next patch. Anyway I have re-arranged patches and its all
part of single patch now.

> 
>> +	list_add(&pasid_data->pdom_link, &sva_pdom->pasid_list);
>> +	spin_unlock_irqrestore(&sva_pdom->lock, flags);
>> +	return ret;
>> +
>> +out_unreg_notifier:
>> +	mmu_notifier_unregister(&sva_pdom->mn, domain->mm);
>> +	sva_pdom->mn.ops = NULL;
> 
> I'm pretty sure you can't actually unregister while holding the
> spinlock without creating a deadlock.
> 
> Take my SVA patch and move notifier registration to alloc/free and out
> of attach to fix this.

mmu_notifier is moved to domain alloc/free.

-Vasant
