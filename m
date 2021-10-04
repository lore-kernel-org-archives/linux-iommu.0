Return-Path: <SRS0=nHvM=OY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616F6C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 13:30:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1614861181
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 13:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1614861181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB1A260BBC;
	Mon,  4 Oct 2021 13:30:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WFeBdIyyT8BY; Mon,  4 Oct 2021 13:30:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AEFEF606C8;
	Mon,  4 Oct 2021 13:30:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 972B2C0011;
	Mon,  4 Oct 2021 13:30:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAA23C000D;
 Mon,  4 Oct 2021 13:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A675960BA1;
 Mon,  4 Oct 2021 13:30:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7L92W-o1exoO; Mon,  4 Oct 2021 13:30:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8285E606C8;
 Mon,  4 Oct 2021 13:30:54 +0000 (UTC)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HNM2k6pySz67b2m;
 Mon,  4 Oct 2021 21:27:26 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 4 Oct 2021 15:30:50 +0200
Received: from [10.47.27.199] (10.47.27.199) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 14:30:49 +0100
Subject: Re: [PATCH 5/5] iommu/iova: Avoid double-negatives in magazine helpers
To: Will Deacon <will@kernel.org>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <1632477717-5254-6-git-send-email-john.garry@huawei.com>
 <20211004113836.GB27373@willie-the-truck>
From: John Garry <john.garry@huawei.com>
Message-ID: <743a089c-6b5f-ed3f-d0bd-23b891c03a66@huawei.com>
Date: Mon, 4 Oct 2021 14:33:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211004113836.GB27373@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.47.27.199]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: mst@redhat.com, linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com, jasowang@redhat.com
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

On 04/10/2021 12:38, Will Deacon wrote:

Hi Will,

>> To avoid this, stop using double-negatives, like !iova_magazine_full() and
>> !iova_magazine_empty(), and use positive tests, like
>> iova_magazine_has_space() and iova_magazine_has_pfns(), respectively; these
>> can safely deal with cpu_rcache->{loaded, prev} = NULL.
> I don't understand why you're saying that things like !iova_magazine_empty()
> are double-negatives. What about e.g. !list_empty() elsewhre in the kernel?

IMO, a check for an empty magazine is a negative check, as opposed to a 
check for availability.

But I'm not saying that patterns like !list_empty() are a bad practice. 
I'm just saying that they are not NULL safe, and that matters in this 
case as we can potentially pass a NULL pointer.

> 
> The crux of the fix seems to be:
> 
>> @@ -783,8 +787,9 @@ static bool __iova_rcache_insert(struct iova_caching_domain *rcached,
>>   		if (new_mag) {
>>   			spin_lock(&rcache->lock);
>>   			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
>> -				rcache->depot[rcache->depot_size++] =
>> -						cpu_rcache->loaded;
>> +				if (cpu_rcache->loaded)
>> +					rcache->depot[rcache->depot_size++] =
>> +							cpu_rcache->loaded;
> Which could be independent of the renaming?

If cpu_rcache->loaded was NULL, then we crash before we reach this code.

Anyway, since I earlier reworked init_iova_rcaches() to properly handle 
failed mem allocations for rcache->cpu_rcaches, I can rework further to 
fail the init for failed mem allocations for cpu_rcaches->loaded, so we 
don't need this change.

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
