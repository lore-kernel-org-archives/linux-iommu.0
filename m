Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79081CCA481
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 01:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC8E9415E7;
	Mon, 27 Jun 2022 01:20:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC8E9415E7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MsSky8rD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c09jwqtI3CJF; Mon, 27 Jun 2022 01:20:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2687E415DD;
	Mon, 27 Jun 2022 01:20:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2687E415DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEEC2C0032;
	Mon, 27 Jun 2022 01:20:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CDAAC002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 01:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5D9060F09
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 01:20:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5D9060F09
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=MsSky8rD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lsKRnAGtdV-I for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 01:20:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2131760E74
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2131760E74
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 01:20:01 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id q18so6791626pld.13
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 18:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=JiM3N5evqJOowVHWeRy1BwX3FfyhynbxcUWkOm6L1ik=;
 b=MsSky8rDDNs+PaeJiRVQB1ywR02u//iGONyyvf7FEtTfEv4lDjV4I0s9czbxLDUlC7
 hsbylmLh4lkwFDR2wcTssR4JKfGmiC0X2jbsyTQqZ8piT/seBMuw9fJg5afyGhwP6hWJ
 h4KVr+A/lgCTGixqzRRf/QAH3Ih2kD9CrSUYJyArsX3bkBBSeQWDmcUaIaTgp/poVGou
 wCELTMGy/eNdRn8wkTfLBYMviw3HKzeBKLaP4DuXF7jOANwxuL7mwKoQdphN9VwfycyL
 EYnKRM7gBzMgq54yzBZbT0+8WpoxkEAGhh9PIHUMCo7yarxf3rbI8yqoZGFOpq3EQwXU
 GTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JiM3N5evqJOowVHWeRy1BwX3FfyhynbxcUWkOm6L1ik=;
 b=e9WcRX+DonGdgL1XE3dAtRLMURamcunqUcl4WenSCj1LwYbohPLRCNVLN8WXDBrPU4
 W8YKx1jL+n5T2aUGhzsBngvUCJVW6r95UPAXpzJ4x6SwEcYrr5yAdGfDpB8oAkFrsiKD
 caIHO3xuhPhkIBF2EP90ueI+8mXEJ44+UebpbxmYV0tYLr73cFH8x7Xfu1iR8ArJ0bTG
 /9x5mMWVeSRv9Z14iQZ0LR69mASd5jlJGvJB6GLGTGFaft5aq6FY+D3SMRELN4KfZ9r0
 4s1n0rzh7wBZpJdonAzyRCIG90ZCsA1SksLQp9m8lYmFiJPx6piiSbFgNa9R1rfJ9P5c
 cQSA==
X-Gm-Message-State: AJIora9SdjFNm+f1mgigqoVcjLOJiCvFRTRZHNqUtvIJiRBS1bhkmDSO
 yErvW34gPSfozzcGnBu4Jgr4/A==
X-Google-Smtp-Source: AGRyM1t2oztCFYrN6uMQKxDHkXdOqDSQ8UIJhLBDVPzheHA8LqCKnazYXDAdI5hfVtGXQ8ObBUyVpQ==
X-Received: by 2002:a17:903:1cf:b0:16a:605a:d58a with SMTP id
 e15-20020a17090301cf00b0016a605ad58amr11786381plh.37.1656292800336; 
 Sun, 26 Jun 2022 18:20:00 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.135.249.206])
 by smtp.gmail.com with ESMTPSA id
 n22-20020a17090a161600b001ecd48b80a2sm8064260pja.5.2022.06.26.18.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jun 2022 18:19:59 -0700 (PDT)
Date: Mon, 27 Jun 2022 09:19:52 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v9 4/8] perf tool: arm: Refactor event list iteration in
 auxtrace_record__init()
Message-ID: <20220627011952.GA143063@leoy-ThinkPad-X240s>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <20220606115555.41103-5-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220606115555.41103-5-yangyicong@hisilicon.com>
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, james.clark@arm.com, will@kernel.org,
 peterz@infradead.org, mingo@redhat.com, helgaas@kernel.org,
 liuqi115@huawei.com, suzuki.poulose@arm.com, acme@kernel.org,
 zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 mathieu.poirier@linaro.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Jun 06, 2022 at 07:55:51PM +0800, Yicong Yang wrote:
> From: Qi Liu <liuqi115@huawei.com>
> 
> Add find_pmu_for_event() and use to simplify logic in
> auxtrace_record_init(). find_pmu_for_event() will be
> reused in subsequent patches.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

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
> -- 
> 2.24.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
