Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB35C433F5
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 14:20:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97359827F0;
	Mon, 16 May 2022 14:20:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IwOq0uPoHTYf; Mon, 16 May 2022 14:20:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 74D7C827DE;
	Mon, 16 May 2022 14:20:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3211BC0032;
	Mon, 16 May 2022 14:20:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76803C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 14:20:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 54E3241854
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 14:20:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D_3EbyogpQhD for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 14:20:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3499D41853
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 14:20:28 +0000 (UTC)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L21Y13WBjz67KdQ;
 Mon, 16 May 2022 22:17:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 16:20:25 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 15:20:24 +0100
Date: Mon, 16 May 2022 15:20:22 +0100
To: Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v8 5/8] perf tool: Add support for HiSilicon PCIe Tune
 and Trace device driver
Message-ID: <20220516152022.00001ab9@Huawei.com>
In-Reply-To: <20220516125223.32012-6-yangyicong@hisilicon.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
 <20220516125223.32012-6-yangyicong@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, james.clark@arm.com, will@kernel.org,
 peterz@infradead.org, mingo@redhat.com, helgaas@kernel.org,
 liuqi115@huawei.com, suzuki.poulose@arm.com, acme@kernel.org,
 zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 mathieu.poirier@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 iommu@lists.linux-foundation.org, leo.yan@linaro.org, robin.murphy@arm.com
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
From: Jonathan Cameron via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, 16 May 2022 20:52:20 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> From: Qi Liu <liuqi115@huawei.com>
> 
> HiSilicon PCIe tune and trace device (PTT) could dynamically tune
> the PCIe link's events, and trace the TLP headers).
> 
> This patch add support for PTT device in perf tool, so users could
> use 'perf record' to get TLP headers trace data.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

One query inline.


> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index 384c7cfda0fd..297fffedf45e 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c

...

>  static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
>  					   int pmu_nr, struct evsel *evsel)
>  {
> @@ -71,17 +120,21 @@ struct auxtrace_record
>  {
>  	struct perf_pmu	*cs_etm_pmu = NULL;
>  	struct perf_pmu **arm_spe_pmus = NULL;
> +	struct perf_pmu **hisi_ptt_pmus = NULL;
>  	struct evsel *evsel;
>  	struct perf_pmu *found_etm = NULL;
>  	struct perf_pmu *found_spe = NULL;
> +	struct perf_pmu *found_ptt = NULL;
>  	int auxtrace_event_cnt = 0;
>  	int nr_spes = 0;
> +	int nr_ptts = 0;
>  
>  	if (!evlist)
>  		return NULL;
>  
>  	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
>  	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
> +	hisi_ptt_pmus = find_all_hisi_ptt_pmus(&nr_ptts, err);
>  
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (cs_etm_pmu && !found_etm)
> @@ -89,9 +142,13 @@ struct auxtrace_record
>  
>  		if (arm_spe_pmus && !found_spe)
>  			found_spe = find_pmu_for_event(arm_spe_pmus, nr_spes, evsel);
> +
> +		if (arm_spe_pmus && !found_spe)

		if (hisi_ptt_pmus && !found_ptt) ?

Otherwise, I'm not sure what the purpose of the checking against spe is.

> +			found_ptt = find_pmu_for_event(hisi_ptt_pmus, nr_ptts, evsel);
>  	}
>  
>  	free(arm_spe_pmus);
> +	free(hisi_ptt_pmus);
>  
>  	if (found_etm)
>  		auxtrace_event_cnt++;
> @@ -99,6 +156,9 @@ struct auxtrace_record
>  	if (found_spe)
>  		auxtrace_event_cnt++;
>  
> +	if (found_ptt)
> +		auxtrace_event_cnt++;
> +
>  	if (auxtrace_event_cnt > 1) {
>  		pr_err("Concurrent AUX trace operation not currently supported\n");
>  		*err = -EOPNOTSUPP;
> @@ -111,6 +171,9 @@ struct auxtrace_record
>  #if defined(__aarch64__)
>  	if (found_spe)
>  		return arm_spe_recording_init(err, found_spe);
> +
> +	if (found_ptt)
> +		return hisi_ptt_recording_init(err, found_ptt);
>  #endif
>  
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
