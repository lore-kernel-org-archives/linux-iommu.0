Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4421CC433EF
	for <iommu@archiver.kernel.org>; Tue,  8 Mar 2022 13:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8E1C41795;
	Tue,  8 Mar 2022 13:20:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mvnvURI6QM5i; Tue,  8 Mar 2022 13:20:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7BBE941794;
	Tue,  8 Mar 2022 13:20:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A7A8C0012;
	Tue,  8 Mar 2022 13:20:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AB04C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 13:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7512A84148
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 13:20:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 37-Td-_BImlN for <iommu@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 13:20:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB44182965
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 13:20:38 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KCbW35fxwzBrbM;
 Tue,  8 Mar 2022 21:18:39 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 21:20:34 +0800
Subject: Re: [PATCH v5 3/8] hisi_ptt: Register PMU device for PTT trace
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20220308084930.5142-1-yangyicong@hisilicon.com>
 <20220308084930.5142-4-yangyicong@hisilicon.com>
 <20220308102157.00003725@Huawei.com>
 <d3b555c1-ed7e-f668-7d81-9cc2dbe6ffba@huawei.com>
 <20220308120607.000064e6@Huawei.com>
Message-ID: <a8476fe5-2802-4788-b877-58a5e4fe898a@huawei.com>
Date: Tue, 8 Mar 2022 21:20:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220308120607.000064e6@Huawei.com>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, yangyicong@hisilicon.com, will@kernel.org,
 daniel.thompson@linaro.org, peterz@infradead.org, mingo@redhat.com,
 helgaas@kernel.org, liuqi115@huawei.com, mike.leach@linaro.org,
 suzuki.poulose@arm.com, coresight@lists.linaro.org, acme@kernel.org,
 zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 song.bao.hua@hisilicon.com, mathieu.poirier@linaro.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
 leo.yan@linaro.org, robin.murphy@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Yicong Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yicong Yang <yangyicong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/3/8 20:06, Jonathan Cameron wrote:
> On Tue, 8 Mar 2022 19:13:08 +0800
> Yicong Yang <yangyicong@huawei.com> wrote:
> 
>> On 2022/3/8 18:21, Jonathan Cameron wrote:
>>> On Tue, 8 Mar 2022 16:49:25 +0800
>>> Yicong Yang <yangyicong@hisilicon.com> wrote:
>>>   
>>>> Register PMU device of PTT trace, then users can use trace through perf
>>>> command. The driver makes use of perf AUX trace and support following
>>>> events to configure the trace:
>>>>
>>>> - filter: select Root port or Endpoint to trace
>>>> - type: select the type of traced TLP headers
>>>> - direction: select the direction of traced TLP headers
>>>> - format: select the data format of the traced TLP headers
>>>>
>>>> This patch adds the PMU driver part of PTT trace. The perf command support
>>>> of PTT trace is added in the following patch.
>>>>
>>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>  
>>>
>>> It seems to me that you ended up doing both suggestions for
>>> how to clean up the remove order when it was meant to be
>>> a question of picking one or the other.
>>>
>>> Otherwise this looks good to me - so with that tidied up
>>>   
>>
>> Hi Jonathan,
>>
>> Thanks for the comments. I'd like to illustrate the reason why I decide to
>> manually unregister the PMU device.
>>
>> The DMA buffers are devm allocated when necessary. They're only allocated
>> when user is going to use the PTT in the first time after the driver's probe,
>> so when driver removal the buffers are released prior to the PMU device's
>> unregistration. I think there's a race condition.
>>
>> IIUC, The PMU device(as the user interface) should be unregistered first then
>> we're safe to free the DMA buffers. But unregister the PMU device by devm
>> cannot keep that order.
> 
> Ok. Please add a comment in the remove() giving this reasoning.
> 

Sure will add a comment for the reason why we need this manual unregistration in remove().

> Jonathan
> 
>>
>> Thanks,
>> Yicong
>>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>   
>>>> ---  
>>>   
>>>> +
>>>> +static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
>>>> +{
>>>> +	u16 core_id, sicl_id;
>>>> +	char *pmu_name;
>>>> +	u32 reg;
>>>> +
>>>> +	hisi_ptt->hisi_ptt_pmu = (struct pmu) {
>>>> +		.module		= THIS_MODULE,
>>>> +		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
>>>> +		.task_ctx_nr	= perf_sw_context,
>>>> +		.attr_groups	= hisi_ptt_pmu_groups,
>>>> +		.event_init	= hisi_ptt_pmu_event_init,
>>>> +		.setup_aux	= hisi_ptt_pmu_setup_aux,
>>>> +		.free_aux	= hisi_ptt_pmu_free_aux,
>>>> +		.start		= hisi_ptt_pmu_start,
>>>> +		.stop		= hisi_ptt_pmu_stop,
>>>> +		.add		= hisi_ptt_pmu_add,
>>>> +		.del		= hisi_ptt_pmu_del,
>>>> +	};
>>>> +
>>>> +	reg = readl(hisi_ptt->iobase + HISI_PTT_LOCATION);
>>>> +	core_id = FIELD_GET(HISI_PTT_CORE_ID, reg);
>>>> +	sicl_id = FIELD_GET(HISI_PTT_SICL_ID, reg);
>>>> +
>>>> +	pmu_name = devm_kasprintf(&hisi_ptt->pdev->dev, GFP_KERNEL, "hisi_ptt%u_%u",
>>>> +				  sicl_id, core_id);
>>>> +	if (!pmu_name)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	return perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);  
>>>
>>> As below, you can put back the devm cleanup that you had in v4 now you
>>> have modified how the filter cleanup is done to also be devm managed.
>>>   
>>>> +}
>>>> +
>>>>  /*
>>>>   * The DMA of PTT trace can only use direct mapping, due to some
>>>>   * hardware restriction. Check whether there is an IOMMU or the
>>>> @@ -303,15 +825,32 @@ static int hisi_ptt_probe(struct pci_dev *pdev,
>>>>  
>>>>  	pci_set_master(pdev);
>>>>  
>>>> +	ret = hisi_ptt_register_irq(hisi_ptt);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>>  	ret = hisi_ptt_init_ctrls(hisi_ptt);
>>>>  	if (ret) {
>>>>  		pci_err(pdev, "failed to init controls, ret = %d.\n", ret);
>>>>  		return ret;
>>>>  	}
>>>>  
>>>> +	ret = hisi_ptt_register_pmu(hisi_ptt);
>>>> +	if (ret) {
>>>> +		pci_err(pdev, "failed to register pmu device, ret = %d", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +void hisi_ptt_remove(struct pci_dev *pdev)
>>>> +{
>>>> +	struct hisi_ptt *hisi_ptt = pci_get_drvdata(pdev);
>>>> +
>>>> +	perf_pmu_unregister(&hisi_ptt->hisi_ptt_pmu);  
>>>
>>> Now you have the filter cleanup occurring using a devm_add_action_or_reset()
>>> there is no need to have a manual cleanup of this - you can
>>> use the approach of a devm_add_action_or_reset like you had in v4.
>>>
>>> As it is the last call in the probe() order it will be the first one
>>> called in the device managed cleanup.
>>>   
>>>> +}
>>>> +  
>>>
>>>
>>> .
>>>   
> 
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
