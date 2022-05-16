Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F526C4332F
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 14:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C89D061088;
	Mon, 16 May 2022 14:17:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xGe3LPlDSdvP; Mon, 16 May 2022 14:17:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B4BF76105B;
	Mon, 16 May 2022 14:17:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70AC0C0032;
	Mon, 16 May 2022 14:17:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15074C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 14:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2AF761063
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 14:17:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rfwtFqnXWRKc for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 14:17:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D3286105B
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 14:17:29 +0000 (UTC)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L21Sn1vZGz67Mx2;
 Mon, 16 May 2022 22:13:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 16:17:25 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 15:17:24 +0100
Date: Mon, 16 May 2022 15:17:22 +0100
To: Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v8 4/8] perf arm: Refactor event list iteration in
 auxtrace_record__init()
Message-ID: <20220516151722.0000693a@Huawei.com>
In-Reply-To: <20220516125223.32012-5-yangyicong@hisilicon.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
 <20220516125223.32012-5-yangyicong@hisilicon.com>
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

On Mon, 16 May 2022 20:52:19 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> From: Qi Liu <liuqi115@huawei.com>
> 
> Use find_pmu_for_event() to simplify logic in auxtrace_record__init().
Possibly reword as 

"Add find_pmu_for_event() and use to simplify logic in
auxtrace_record_init(). find_pmu_for_event() will be
reused in subsequent patches."

> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
FWIW as this isn't an area I know much about. It seems
like a good cleanup and functionally equivalent.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  tools/perf/arch/arm/util/auxtrace.c | 53 ++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index 5fc6a2a3dbc5..384c7cfda0fd 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -50,16 +50,32 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
>  	return arm_spe_pmus;
>  }
>  
> +static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
> +					   int pmu_nr, struct evsel *evsel)
> +{
> +	int i;
> +
> +	if (!pmus)
> +		return NULL;
> +
> +	for (i = 0; i < pmu_nr; i++) {
> +		if (evsel->core.attr.type == pmus[i]->type)
> +			return pmus[i];
> +	}
> +
> +	return NULL;
> +}
> +
>  struct auxtrace_record
>  *auxtrace_record__init(struct evlist *evlist, int *err)
>  {
> -	struct perf_pmu	*cs_etm_pmu;
> +	struct perf_pmu	*cs_etm_pmu = NULL;
> +	struct perf_pmu **arm_spe_pmus = NULL;
>  	struct evsel *evsel;
> -	bool found_etm = false;
> +	struct perf_pmu *found_etm = NULL;
>  	struct perf_pmu *found_spe = NULL;
> -	struct perf_pmu **arm_spe_pmus = NULL;
> +	int auxtrace_event_cnt = 0;
>  	int nr_spes = 0;
> -	int i = 0;
>  
>  	if (!evlist)
>  		return NULL;
> @@ -68,24 +84,23 @@ struct auxtrace_record
>  	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (cs_etm_pmu &&
> -		    evsel->core.attr.type == cs_etm_pmu->type)
> -			found_etm = true;
> -
> -		if (!nr_spes || found_spe)
> -			continue;
> -
> -		for (i = 0; i < nr_spes; i++) {
> -			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
> -				found_spe = arm_spe_pmus[i];
> -				break;
> -			}
> -		}
> +		if (cs_etm_pmu && !found_etm)
> +			found_etm = find_pmu_for_event(&cs_etm_pmu, 1, evsel);
> +
> +		if (arm_spe_pmus && !found_spe)
> +			found_spe = find_pmu_for_event(arm_spe_pmus, nr_spes, evsel);
>  	}
> +
>  	free(arm_spe_pmus);
>  
> -	if (found_etm && found_spe) {
> -		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
> +	if (found_etm)
> +		auxtrace_event_cnt++;
> +
> +	if (found_spe)
> +		auxtrace_event_cnt++;
> +
> +	if (auxtrace_event_cnt > 1) {
> +		pr_err("Concurrent AUX trace operation not currently supported\n");
>  		*err = -EOPNOTSUPP;
>  		return NULL;
>  	}

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
