Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E21CCA47C
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 02:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 986B282E4C;
	Mon, 27 Jun 2022 02:03:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 986B282E4C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=W9NMxYS6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n7NjdzD8RLic; Mon, 27 Jun 2022 02:03:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3CD1482D2F;
	Mon, 27 Jun 2022 02:03:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CD1482D2F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F17E9C0032;
	Mon, 27 Jun 2022 02:03:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E428C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 02:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5276E60E74
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 02:03:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5276E60E74
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=W9NMxYS6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QUqbZOpJFCKF for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 02:03:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5CCB760E30
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5CCB760E30
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 02:03:05 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 n16-20020a17090ade9000b001ed15b37424so7982021pjv.3
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 19:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cFzsYDSniCnlBZ03HwKNu3S5QmFfxy2xvMgtRDJMZis=;
 b=W9NMxYS6VjeyTC2cMMP/U2hMAgucbyOeYIMRtdhZhBzWM9I5CHJvC78CT5KjWoRSaI
 YMzEn64lLecRyWTMhmh0DrHudZ2V8CW8H/fh2J5A0kUiPIXFaaiKzPzEaOeWTlieEib0
 RzNwvSJPuZS6TGyznaBwVLM9izVf6IwyagW8sNL0vyHz9rXDH9/INPnaOfE4mNWGB6+j
 EHtJnShucEnJpz2SjeJ3B06AvpibDKU7g8RGBvsSTA6UqjenJhNn4rlQ3c05GJmR4qcl
 Lk+TrcPs0cWqt6+Kmek4rYYmJccguriPiiBOQudPQNC9JtmDL6HWcSgH0IN2z+JLduXZ
 gFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cFzsYDSniCnlBZ03HwKNu3S5QmFfxy2xvMgtRDJMZis=;
 b=p5M4L64N3JGTy2RVpXNpcjGXAZfyb9dLTOlXUteGx+sBW3lLIP6OKPIu1IPde9yr0a
 h7hg4TOSfXSZks9MKqJR/s04pFYUk39wW7CzZFGnZgGS5+A1ZNLF8uguzF1+HYDbPFrf
 ckqU0ourFu994ZkylnB9t3xDbg2kn6JjU+N6QMEBtLKYnswx6JrL2hd38EW3MyhAK6RM
 1OIZ26pZJyge8kLXB4adSInzcN1NKV6maxIp/+320EdAxOjCrW6kdeUzmo76G9SMFnc+
 hb/YSh4+Br1TZOjnQsB8V5OGWVl28WEYkrHOKo23Wjt0cNcbmlq8zFYmOH/8szvo0X8P
 mNuA==
X-Gm-Message-State: AJIora+qzJPxD58unpDhNtRiqabVGflLKNmrmVsouC/W0EDIYFoljQfg
 uFu1SaE080UV6WAoPBbtaLznuA==
X-Google-Smtp-Source: AGRyM1sMApCNujHeAcMS6o2le4b1Rwn51Wk9w2AAmuhkBTXz7YYbL0AMbuIim8kFUBy3QBW5KtcrJg==
X-Received: by 2002:a17:90b:4c86:b0:1ec:cc0f:32da with SMTP id
 my6-20020a17090b4c8600b001eccc0f32damr18286077pjb.66.1656295384629; 
 Sun, 26 Jun 2022 19:03:04 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.135.249.206])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a056a00078800b0050e006279bfsm5834982pfu.137.2022.06.26.19.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jun 2022 19:03:04 -0700 (PDT)
Date: Mon, 27 Jun 2022 10:02:56 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v9 5/8] perf tool: Add support for HiSilicon PCIe Tune
 and Trace device driver
Message-ID: <20220627020256.GB143063@leoy-ThinkPad-X240s>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <20220606115555.41103-6-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220606115555.41103-6-yangyicong@hisilicon.com>
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

On Mon, Jun 06, 2022 at 07:55:52PM +0800, Yicong Yang wrote:
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

Just one minor comment.

[...]

> diff --git a/tools/perf/util/hisi-ptt.h b/tools/perf/util/hisi-ptt.h
> new file mode 100644
> index 000000000000..2db9b4056214
> --- /dev/null
> +++ b/tools/perf/util/hisi-ptt.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * HiSilicon PCIe Trace and Tuning (PTT) support
> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
> + */
> +
> +#ifndef INCLUDE__PERF_HISI_PTT_H__
> +#define INCLUDE__PERF_HISI_PTT_H__
> +
> +#define HISI_PTT_PMU_NAME		"hisi_ptt"
> +#define HISI_PTT_AUXTRACE_PRIV_SIZE	sizeof(u64)
> +
> +struct auxtrace_record *hisi_ptt_recording_init(int *err,
> +						struct perf_pmu *hisi_ptt_pmu);
> +
> +int hisi_ptt_process_auxtrace_info(union perf_event *event,
> +				   struct perf_session *session);

The function hisi_ptt_process_auxtrace_info() is introduced by next
patch for support PTT decoding, for good practice (e.g. keep
bisection), it's good to introduce function declaration and definition
in one patch.

With this fixing, this patch looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> +
> +#endif
> -- 
> 2.24.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
