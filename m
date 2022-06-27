Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A065BC43334
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 08:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A04141551;
	Mon, 27 Jun 2022 08:18:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A04141551
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wIQ4sONOGyEx; Mon, 27 Jun 2022 08:18:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A8E5240A05;
	Mon, 27 Jun 2022 08:18:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8E5240A05
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E4A0C0032;
	Mon, 27 Jun 2022 08:18:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACBF4C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 08:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 789D9410A8
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 08:18:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 789D9410A8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DnrniXPB_hD5 for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:18:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0EC7C40A05
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0EC7C40A05
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 08:18:42 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LWgY31qVdzhYn4;
 Mon, 27 Jun 2022 16:16:23 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 16:18:36 +0800
Subject: Re: [PATCH v9 5/8] perf tool: Add support for HiSilicon PCIe Tune and
 Trace device driver
To: Leo Yan <leo.yan@linaro.org>, Yicong Yang <yangyicong@hisilicon.com>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <20220606115555.41103-6-yangyicong@hisilicon.com>
 <20220627020256.GB143063@leoy-ThinkPad-X240s>
Message-ID: <fb55fdab-3ad6-a21a-315a-9dc404b35f11@huawei.com>
Date: Mon, 27 Jun 2022 16:18:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220627020256.GB143063@leoy-ThinkPad-X240s>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
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
From: Yicong Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yicong Yang <yangyicong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/6/27 10:02, Leo Yan wrote:
> On Mon, Jun 06, 2022 at 07:55:52PM +0800, Yicong Yang wrote:
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
> Just one minor comment.
> 
> [...]
> 
>> diff --git a/tools/perf/util/hisi-ptt.h b/tools/perf/util/hisi-ptt.h
>> new file mode 100644
>> index 000000000000..2db9b4056214
>> --- /dev/null
>> +++ b/tools/perf/util/hisi-ptt.h
>> @@ -0,0 +1,19 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * HiSilicon PCIe Trace and Tuning (PTT) support
>> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
>> + */
>> +
>> +#ifndef INCLUDE__PERF_HISI_PTT_H__
>> +#define INCLUDE__PERF_HISI_PTT_H__
>> +
>> +#define HISI_PTT_PMU_NAME		"hisi_ptt"
>> +#define HISI_PTT_AUXTRACE_PRIV_SIZE	sizeof(u64)
>> +
>> +struct auxtrace_record *hisi_ptt_recording_init(int *err,
>> +						struct perf_pmu *hisi_ptt_pmu);
>> +
>> +int hisi_ptt_process_auxtrace_info(union perf_event *event,
>> +				   struct perf_session *session);
> 
> The function hisi_ptt_process_auxtrace_info() is introduced by next
> patch for support PTT decoding, for good practice (e.g. keep
> bisection), it's good to introduce function declaration and definition
> in one patch.
> 

Thanks for catching this. There's something wrong when doing the patch splitting.
Will fix this!

> With this fixing, this patch looks good to me:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
