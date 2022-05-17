Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB967C433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 01:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 621064017E;
	Tue, 17 May 2022 01:57:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QNHqJE-Kiv8m; Tue, 17 May 2022 01:57:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C7E0440179;
	Tue, 17 May 2022 01:57:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 979FEC0039;
	Tue, 17 May 2022 01:57:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74714C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 01:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 639BE832EB
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 01:57:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iQwM7f5_pp4b for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 01:57:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2701B832DB
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 01:57:21 +0000 (UTC)
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.54])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L2Jyw5mJqzCsjB;
 Tue, 17 May 2022 09:52:24 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 09:57:18 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 09:57:17 +0800
Subject: Re: [PATCH v8 5/8] perf tool: Add support for HiSilicon PCIe Tune and
 Trace device driver
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Yicong Yang
 <yangyicong@hisilicon.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
 <20220516125223.32012-6-yangyicong@hisilicon.com>
 <20220516152022.00001ab9@Huawei.com>
Message-ID: <3b952043-53a0-b15e-47bb-e4680c1860c9@huawei.com>
Date: Tue, 17 May 2022 09:57:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220516152022.00001ab9@Huawei.com>
Content-Language: en-GB
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, james.clark@arm.com, will@kernel.org,
 peterz@infradead.org, mingo@redhat.com, helgaas@kernel.org,
 suzuki.poulose@arm.com, acme@kernel.org, zhangshaokun@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
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
From: "liuqi \(BA\) via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "liuqi \(BA\)" <liuqi115@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2022/5/16 22:20, Jonathan Cameron wrote:
> On Mon, 16 May 2022 20:52:20 +0800
> Yicong Yang <yangyicong@hisilicon.com> wrote:
> 
>> From: Qi Liu <liuqi115@huawei.com>
>>
>> HiSilicon PCIe tune and trace device (PTT) could dynamically tune
>> the PCIe link's events, and trace the TLP headers).
>>
>> This patch add support for PTT device in perf tool, so users could
>> use 'perf record' to get TLP headers trace data.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> One query inline.
> 
> 
>> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
>> index 384c7cfda0fd..297fffedf45e 100644
>> --- a/tools/perf/arch/arm/util/auxtrace.c
>> +++ b/tools/perf/arch/arm/util/auxtrace.c
> 
> ...
> 
>>   static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
>>   					   int pmu_nr, struct evsel *evsel)
>>   {
>> @@ -71,17 +120,21 @@ struct auxtrace_record
>>   {
>>   	struct perf_pmu	*cs_etm_pmu = NULL;
>>   	struct perf_pmu **arm_spe_pmus = NULL;
>> +	struct perf_pmu **hisi_ptt_pmus = NULL;
>>   	struct evsel *evsel;
>>   	struct perf_pmu *found_etm = NULL;
>>   	struct perf_pmu *found_spe = NULL;
>> +	struct perf_pmu *found_ptt = NULL;
>>   	int auxtrace_event_cnt = 0;
>>   	int nr_spes = 0;
>> +	int nr_ptts = 0;
>>   
>>   	if (!evlist)
>>   		return NULL;
>>   
>>   	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
>>   	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
>> +	hisi_ptt_pmus = find_all_hisi_ptt_pmus(&nr_ptts, err);
>>   
>>   	evlist__for_each_entry(evlist, evsel) {
>>   		if (cs_etm_pmu && !found_etm)
>> @@ -89,9 +142,13 @@ struct auxtrace_record
>>   
>>   		if (arm_spe_pmus && !found_spe)
>>   			found_spe = find_pmu_for_event(arm_spe_pmus, nr_spes, evsel);
>> +
>> +		if (arm_spe_pmus && !found_spe)
> 
> 		if (hisi_ptt_pmus && !found_ptt) ?
> 
> Otherwise, I'm not sure what the purpose of the checking against spe is.
> 

yes...it's a typo here, thanks for the reminder!

Qi
>> +			found_ptt = find_pmu_for_event(hisi_ptt_pmus, nr_ptts, evsel);
>>   	}
>>   
>>   	free(arm_spe_pmus);
>> +	free(hisi_ptt_pmus);
>>   
>>   	if (found_etm)
>>   		auxtrace_event_cnt++;
>> @@ -99,6 +156,9 @@ struct auxtrace_record
>>   	if (found_spe)
>>   		auxtrace_event_cnt++;
>>   
>> +	if (found_ptt)
>> +		auxtrace_event_cnt++;
>> +
>>   	if (auxtrace_event_cnt > 1) {
>>   		pr_err("Concurrent AUX trace operation not currently supported\n");
>>   		*err = -EOPNOTSUPP;
>> @@ -111,6 +171,9 @@ struct auxtrace_record
>>   #if defined(__aarch64__)
>>   	if (found_spe)
>>   		return arm_spe_recording_init(err, found_spe);
>> +
>> +	if (found_ptt)
>> +		return hisi_ptt_recording_init(err, found_ptt);
>>   #endif
>>   
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
