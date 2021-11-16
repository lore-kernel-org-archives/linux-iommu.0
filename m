Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582E1C433EF
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 14:21:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55F263213
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 14:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D55F263213
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94EC940206;
	Tue, 16 Nov 2021 14:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mIyvDcsD6ncr; Tue, 16 Nov 2021 14:21:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3E8C540497;
	Tue, 16 Nov 2021 14:21:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14F0EC002E;
	Tue, 16 Nov 2021 14:21:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0474BC0012;
 Tue, 16 Nov 2021 14:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D847F401B2;
 Tue, 16 Nov 2021 14:21:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wg1iEoDJ-ktO; Tue, 16 Nov 2021 14:21:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6322440189;
 Tue, 16 Nov 2021 14:21:18 +0000 (UTC)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Htp6h1wrjz67ybx;
 Tue, 16 Nov 2021 22:17:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 15:21:14 +0100
Received: from [10.47.82.31] (10.47.82.31) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 16 Nov
 2021 14:21:13 +0000
Subject: Re: [PATCH 0/5] iommu: Some IOVA code reorganisation
To: Will Deacon <will@kernel.org>, <robin.murphy@arm.com>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
 <20211004114418.GC27373@willie-the-truck>
From: John Garry <john.garry@huawei.com>
Message-ID: <cdb502c5-4896-385b-8872-f4f20e9c7e34@huawei.com>
Date: Tue, 16 Nov 2021 14:21:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211004114418.GC27373@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.47.82.31]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: mst@redhat.com, linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 iommu@lists.linux-foundation.org, jasowang@redhat.com
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

On 04/10/2021 12:44, Will Deacon wrote:
> On Fri, Sep 24, 2021 at 06:01:52PM +0800, John Garry wrote:
>> The IOVA domain structure is a bit overloaded, holding:
>> - IOVA tree management
>> - FQ control
>> - IOVA rcache memories
>>
>> Indeed only a couple of IOVA users use the rcache, and only dma-iommu.c
>> uses the FQ feature.
>>
>> This series separates out that structure. In addition, it moves the FQ
>> code into dma-iommu.c . This is not strictly necessary, but it does make
>> it easier for the FQ domain lookup the rcache domain.
>>
>> The rcache code stays where it is, as it may be reworked in future, so
>> there is not much point in relocating and then discarding.
>>
>> This topic was initially discussed and suggested (I think) by Robin here:
>> https://lore.kernel.org/linux-iommu/1d06eda1-9961-d023-f5e7-fe87e768f067@arm.com/
> It would be useful to have Robin's Ack on patches 2-4. The implementation
> looks straightforward to me, but the thread above isn't very clear about
> what is being suggested.

Hi Robin,

Just wondering if you had made any progress on your FQ code rework or 
your own re-org?

I wasn't planning on progressing 
https://lore.kernel.org/linux-iommu/1626259003-201303-1-git-send-email-john.garry@huawei.com/ 
until this is done first (and that is still a big issue), even though 
not strictly necessary.

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
