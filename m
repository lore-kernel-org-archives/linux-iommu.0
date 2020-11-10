Return-Path: <SRS0=ThSx=EQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8141C5517A
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 08:38:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3388720780
	for <iommu@archiver.kernel.org>; Tue, 10 Nov 2020 08:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3388720780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7CF1D871B9;
	Tue, 10 Nov 2020 08:38:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vC9+FoeUBUN3; Tue, 10 Nov 2020 08:38:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D7882870E5;
	Tue, 10 Nov 2020 08:38:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB32FC0889;
	Tue, 10 Nov 2020 08:38:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C0F3C016F
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 08:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2A16B8717D
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 08:38:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nU3VPBXqXuP1 for <iommu@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 08:38:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BB0EB870E5
 for <iommu@lists.linux-foundation.org>; Tue, 10 Nov 2020 08:38:43 +0000 (UTC)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CVh7K19MDz67DbT;
 Tue, 10 Nov 2020 16:37:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 10 Nov 2020 09:38:39 +0100
Received: from [10.210.169.2] (10.210.169.2) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 10 Nov
 2020 08:38:38 +0000
Subject: Re: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
 DMA APIs
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "hch@lst.de" <hch@lst.de>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
References: <20201102080646.2180-1-song.bao.hua@hisilicon.com>
 <20201102080646.2180-2-song.bao.hua@hisilicon.com>
 <eb317e5050b944c3aec97c5fb64a74cb@hisilicon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <0658ee16-d539-61c5-1d39-77d50f559803@huawei.com>
Date: Tue, 10 Nov 2020 08:38:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <eb317e5050b944c3aec97c5fb64a74cb@hisilicon.com>
Content-Language: en-US
X-Originating-IP: [10.210.169.2]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Will
 Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Shuah Khan <shuah@kernel.org>
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

On 10/11/2020 08:10, Song Bao Hua (Barry Song) wrote:
> Hello Robin, Christoph,
> Any further comment? John suggested that "depends on DEBUG_FS" should be added in Kconfig.
> I am collecting more comments to send v4 together with fixing this minor issue :-)
> 
> Thanks
> Barry
> 
>> -----Original Message-----
>> From: Song Bao Hua (Barry Song)
>> Sent: Monday, November 2, 2020 9:07 PM
>> To: iommu@lists.linux-foundation.org; hch@lst.de; robin.murphy@arm.com;
>> m.szyprowski@samsung.com
>> Cc: Linuxarm <linuxarm@huawei.com>; linux-kselftest@vger.kernel.org; xuwei
>> (O) <xuwei5@huawei.com>; Song Bao Hua (Barry Song)
>> <song.bao.hua@hisilicon.com>; Joerg Roedel <joro@8bytes.org>; Will Deacon
>> <will@kernel.org>; Shuah Khan <shuah@kernel.org>
>> Subject: [PATCH v3 1/2] dma-mapping: add benchmark support for streaming
>> DMA APIs
>>
>> Nowadays, there are increasing requirements to benchmark the performance
>> of dma_map and dma_unmap particually while the device is attached to an
>> IOMMU.
>>
>> This patch enables the support. Users can run specified number of threads to
>> do dma_map_page and dma_unmap_page on a specific NUMA node with the
>> specified duration. Then dma_map_benchmark will calculate the average
>> latency for map and unmap.
>>
>> A difficulity for this benchmark is that dma_map/unmap APIs must run on a
>> particular device. Each device might have different backend of IOMMU or
>> non-IOMMU.
>>
>> So we use the driver_override to bind dma_map_benchmark to a particual
>> device by:
>> For platform devices:
>> echo dma_map_benchmark > /sys/bus/platform/devices/xxx/driver_override
>> echo xxx > /sys/bus/platform/drivers/xxx/unbind
>> echo xxx > /sys/bus/platform/drivers/dma_map_benchmark/bind
>>

Hi Barry,

>> For PCI devices:
>> echo dma_map_benchmark >
>> /sys/bus/pci/devices/0000:00:01.0/driver_override
>> echo 0000:00:01.0 > /sys/bus/pci/drivers/xxx/unbind echo 0000:00:01.0 >
>> /sys/bus/pci/drivers/dma_map_benchmark/bind

Do we need to check if the device to which we attach actually has DMA 
mapping capability?

>>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
>> ---

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
