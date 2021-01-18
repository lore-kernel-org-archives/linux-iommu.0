Return-Path: <SRS0=rNTl=GV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B351C433E0
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 15:11:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0939622BEA
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 15:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0939622BEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AB5432001E;
	Mon, 18 Jan 2021 15:11:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ecJqBP+N9gpJ; Mon, 18 Jan 2021 15:11:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BE56E2001C;
	Mon, 18 Jan 2021 15:11:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0332C08A1;
	Mon, 18 Jan 2021 15:11:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69D29C013A
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 15:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 509282001E
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 15:11:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dhrb+SGH+nqq for <iommu@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:11:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by silver.osuosl.org (Postfix) with ESMTPS id B58CD2001C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 15:11:04 +0000 (UTC)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DKFW45rLFz67bgN;
 Mon, 18 Jan 2021 23:06:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 18 Jan 2021 16:11:01 +0100
Received: from [10.47.8.82] (10.47.8.82) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 18 Jan
 2021 15:11:00 +0000
Subject: Re: [PATCH v4 2/3] iommu/iova: Avoid double-negatives in magazine
 helpers
To: Robin Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
 <1607538189-237944-3-git-send-email-john.garry@huawei.com>
 <YAHRKCkcHAEUdRNT@larix.localdomain>
 <69c30e85-4a72-a0e1-1e56-4ffbd0df5aba@huawei.com> <YAVeDOiKBEKZ2Tdq@myrica>
 <cdc77ccd-823d-464b-fe3c-2a9da17bcb61@huawei.com>
 <69614e38-fcc0-4220-e1cd-15de91dd61ef@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <5fdeed73-190f-3272-03e5-8adc60148521@huawei.com>
Date: Mon, 18 Jan 2021 15:09:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <69614e38-fcc0-4220-e1cd-15de91dd61ef@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.8.82]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: will@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linuxarm@huawei.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 18/01/2021 12:59, Robin Murphy wrote:
>>>>> for cpu_rcaches too, and get a similar abort at runtime.
>>>> It's not specifically that we expect them (allocation failures for the
>>>> loaded magazine), rather we should make safe against it.
>>>>
>>>> So could you be more specific in your concern for the cpu_rcache 
>>>> failure?
>>>> cpu_rcache magazine assignment comes from this logic.
>>> If this fails:
>>>
>>> drivers/iommu/iova.c:847: rcache->cpu_rcaches = 
>>> __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
>>>
>>> then we'll get an Oops in __iova_rcache_get(). So if we're making the
>>> module safer against magazine allocation failure, shouldn't we also
>>> protect against cpu_rcaches allocation failure?
>>
>> Ah, gotcha. So we have the WARN there, but that's not much use as this 
>> would still crash, as you say.
>>
>> So maybe we can embed the cpu rcaches in iova_domain struct, to avoid 
>> the separate (failable) cpu rcache allocation.
> 
> Is that even possible? The size of percpu data isn't known at compile 
> time, so at best it would add ugly runtime complexity to any allocation 
> of a struct iova_domain by itself, but worse than that it means that 
> embedding iova_domain in any other structure becomes completely broken, no?

Ah, now I see that it's not possible. I was thinking of using 
DEFINE_PER_CPU(), but it's not permitted.

So even though this patch saves us from cpu_rcache->loaded / ->prev == 
NULL, I still prefer not to add explicit checks for cpu_rcache == NULL 
in the IOVA alloc/free paths, and would rather pass an error back in 
init_iova_rcaches(), but adding code for tidy-up looks messy.

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
