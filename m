Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F422AC433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 01:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C67C40B3A;
	Tue, 17 May 2022 01:35:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ahjTmJLIQOT3; Tue, 17 May 2022 01:35:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4383C404FE;
	Tue, 17 May 2022 01:35:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15EABC0039;
	Tue, 17 May 2022 01:35:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7625C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 01:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2C4683295
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 01:35:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vpAs7i6af6zO for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 01:35:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 930CA83280
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 01:35:06 +0000 (UTC)
Received: from kwepemi100019.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L2JYy4SnjzhZBR;
 Tue, 17 May 2022 09:34:14 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100019.china.huawei.com (7.221.188.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 09:35:01 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 09:35:00 +0800
Subject: Re: [PATCH v8 4/8] perf arm: Refactor event list iteration in
 auxtrace_record__init()
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Yicong Yang
 <yangyicong@hisilicon.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
 <20220516125223.32012-5-yangyicong@hisilicon.com>
 <20220516151722.0000693a@Huawei.com>
Message-ID: <791a4e66-2e55-c97f-cc05-16032d576121@huawei.com>
Date: Tue, 17 May 2022 09:35:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220516151722.0000693a@Huawei.com>
Content-Language: en-GB
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


Hi Jonathan,
On 2022/5/16 22:17, Jonathan Cameron wrote:
> On Mon, 16 May 2022 20:52:19 +0800
> Yicong Yang <yangyicong@hisilicon.com> wrote:
> 
>> From: Qi Liu <liuqi115@huawei.com>
>>
>> Use find_pmu_for_event() to simplify logic in auxtrace_record__init().
> Possibly reword as
> 
> "Add find_pmu_for_event() and use to simplify logic in
> auxtrace_record_init(). find_pmu_for_event() will be
> reused in subsequent patches."
> 
thanks, I'll modify the commit message next version.

Thanks,
Qi
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> FWIW as this isn't an area I know much about. It seems
> like a good cleanup and functionally equivalent.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   tools/perf/arch/arm/util/auxtrace.c | 53 ++++++++++++++++++-----------
>>   1 file changed, 34 insertions(+), 19 deletions(-)
>>
>> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
>> index 5fc6a2a3dbc5..384c7cfda0fd 100644
>> --- a/tools/perf/arch/arm/util/auxtrace.c
>> +++ b/tools/perf/arch/arm/util/auxtrace.c
>> @@ -50,16 +50,32 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
>>   	return arm_spe_pmus;
>>   }
>>   
>> +static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
>> +					   int pmu_nr, struct evsel *evsel)
>> +{
>> +	int i;
>> +
>> +	if (!pmus)
>> +		return NULL;
>> +
>> +	for (i = 0; i < pmu_nr; i++) {
>> +		if (evsel->core.attr.type == pmus[i]->type)
>> +			return pmus[i];
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>>   struct auxtrace_record
>>   *auxtrace_record__init(struct evlist *evlist, int *err)
>>   {
>> -	struct perf_pmu	*cs_etm_pmu;
>> +	struct perf_pmu	*cs_etm_pmu = NULL;
>> +	struct perf_pmu **arm_spe_pmus = NULL;
>>   	struct evsel *evsel;
>> -	bool found_etm = false;
>> +	struct perf_pmu *found_etm = NULL;
>>   	struct perf_pmu *found_spe = NULL;
>> -	struct perf_pmu **arm_spe_pmus = NULL;
>> +	int auxtrace_event_cnt = 0;
>>   	int nr_spes = 0;
>> -	int i = 0;
>>   
>>   	if (!evlist)
>>   		return NULL;
>> @@ -68,24 +84,23 @@ struct auxtrace_record
>>   	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
>>   
>>   	evlist__for_each_entry(evlist, evsel) {
>> -		if (cs_etm_pmu &&
>> -		    evsel->core.attr.type == cs_etm_pmu->type)
>> -			found_etm = true;
>> -
>> -		if (!nr_spes || found_spe)
>> -			continue;
>> -
>> -		for (i = 0; i < nr_spes; i++) {
>> -			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
>> -				found_spe = arm_spe_pmus[i];
>> -				break;
>> -			}
>> -		}
>> +		if (cs_etm_pmu && !found_etm)
>> +			found_etm = find_pmu_for_event(&cs_etm_pmu, 1, evsel);
>> +
>> +		if (arm_spe_pmus && !found_spe)
>> +			found_spe = find_pmu_for_event(arm_spe_pmus, nr_spes, evsel);
>>   	}
>> +
>>   	free(arm_spe_pmus);
>>   
>> -	if (found_etm && found_spe) {
>> -		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
>> +	if (found_etm)
>> +		auxtrace_event_cnt++;
>> +
>> +	if (found_spe)
>> +		auxtrace_event_cnt++;
>> +
>> +	if (auxtrace_event_cnt > 1) {
>> +		pr_err("Concurrent AUX trace operation not currently supported\n");
>>   		*err = -EOPNOTSUPP;
>>   		return NULL;
>>   	}
> 
> .
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
