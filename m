Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EC1C433ED
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 08:32:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C93C613C0
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 08:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C93C613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AA638497F;
	Tue,  6 Apr 2021 08:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LJ8u15m_HJTK; Tue,  6 Apr 2021 08:32:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FB1F8493E;
	Tue,  6 Apr 2021 08:32:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3333FC000C;
	Tue,  6 Apr 2021 08:32:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 528FAC000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 08:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 498A28495D
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 08:32:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4bZHAlB_Dj8w for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 08:32:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56C2A8493E
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 08:32:21 +0000 (UTC)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FF0xt062Gz687Z7;
 Tue,  6 Apr 2021 16:27:14 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 10:32:18 +0200
Received: from [10.210.166.136] (10.210.166.136) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 09:32:17 +0100
Subject: Re: [PATCH v2 0/4] iommu/iova: Add CPU hotplug handler to flush
 rcaches to core code
To: Will Deacon <will@kernel.org>
References: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
 <20210325175354.GE15504@willie-the-truck>
From: John Garry <john.garry@huawei.com>
Message-ID: <9aad6e94-ecb7-ca34-7f7d-3df6e43e9c42@huawei.com>
Date: Tue, 6 Apr 2021 09:29:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210325175354.GE15504@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.210.166.136]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 25/03/2021 17:53, Will Deacon wrote:
> On Thu, Mar 25, 2021 at 08:29:57PM +0800, John Garry wrote:
>> The Intel IOMMU driver supports flushing the per-CPU rcaches when a CPU is
>> offlined.
>>
>> Let's move it to core code, so everyone can take advantage.
>>
>> Also throw in a patch to stop exporting free_iova_fast().
>>
>> Differences to v1:
>> - Add RB tags (thanks!)
>> - Add patch to stop exporting free_iova_fast()
>> - Drop patch to correct comment
>> - Add patch to delete iommu_dma_free_cpu_cached_iovas() and associated
>>    changes
>>
>> John Garry (4):
>>    iova: Add CPU hotplug handler to flush rcaches
>>    iommu/vt-d: Remove IOVA domain rcache flushing for CPU offlining
>>    iommu: Delete iommu_dma_free_cpu_cached_iovas()
>>    iommu: Stop exporting free_iova_fast()
> Looks like this is all set for 5.13, so hopefully Joerg can stick it in
> -next for a bit more exposure.
> 


Hi Joerg,

Can you kindly consider picking this up now?

Thanks,
John

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
