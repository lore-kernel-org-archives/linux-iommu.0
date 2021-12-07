Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DC6C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 08:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD43760E24;
	Tue,  7 Dec 2021 08:32:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FmQVR407FhJa; Tue,  7 Dec 2021 08:32:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7F00C607C8;
	Tue,  7 Dec 2021 08:32:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E3BBC002F;
	Tue,  7 Dec 2021 08:32:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D8FDC0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 08:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18E9B40568
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 08:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=fail (2048-bit key) reason="fail (bad RSA signature)"
 header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MllLa1wNt4je for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 08:32:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 007F140057
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 08:32:04 +0000 (UTC)
Received: from [IPv6:2a00:c281:1230:3700:b039:4e10:9830:879f] (unknown
 [IPv6:2a00:c281:1230:3700:b039:4e10:9830:879f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BE2921F44D3A;
 Tue,  7 Dec 2021 08:32:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1638865922; bh=2jT1HU0XXAhidWEVV53WhPL8fQKqtf/4yrL0tbbkOnM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=H8qqPeNx6IsI21O014oDXTH/VJPk0/FIS/OeG9mV9/eLLQgTpbUy3Af9v2xtWhlFu
 pGzoC3ksCC6Fm+6Cm5Pw12WdJpWmc8mZn8L9YrBmPoxldWpLqmNw+Cf1NbFViLQlO+
 gwShAQbW3Pm/ofTXOnBU/SUw4f8ruMXleDJkni9PuIPom9KY6x8m4eSwxZk1qohmOE
 Hi17B6DDh36OhC3+PQGKEsf8snz55ZWmOKdF7k80JUpOdvQVKVkfS0/HjdJbeWRVt5
 M3nBkZIVftBSYx5/Zar3YUg+awtIJEvpy6ehbhvcVrCXq2IW54XFCm/Y2TMNN6hL9B
 W7M605TV6cS9A==
Subject: Re: [PATCH 1/2] iommu/mediatek: Always tlb_flush_all when each PM
 resume
To: Yong Wu <yong.wu@mediatek.com>
References: <20211122104400.4160-1-dafna.hirschfeld@collabora.com>
 <20211122104400.4160-2-dafna.hirschfeld@collabora.com>
 <6abef78f6447c626b737fd35688f421c29871f43.camel@mediatek.com>
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <d30438bf-9add-7904-bad0-0764e3602263@collabora.com>
Date: Tue, 7 Dec 2021 10:31:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6abef78f6447c626b737fd35688f421c29871f43.camel@mediatek.com>
Content-Language: en-US
Cc: open list <linux-kernel@vger.kernel.org>, sebastian.reichel@collabora.com,
 iommu@lists.linux-foundation.org,
 "moderated list:MEDIATEK IOMMU DRIVER" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 Will Deacon <will@kernel.org>, "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>, linux-media@vger.kernel.org
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



On 27.11.21 04:46, Yong Wu wrote:
> Hi Dafna,
> 
> Sorry for reply late.
> 
> On Mon, 2021-11-22 at 12:43 +0200, Dafna Hirschfeld wrote:
>> From: Yong Wu <yong.wu@mediatek.com>
>>
>> Prepare for 2 HWs that sharing pgtable in different power-domains.
>>
>> When there are 2 M4U HWs, it may has problem in the flush_range in
>> which
>> we get the pm_status via the m4u dev, BUT that function don't reflect
>> the
>> real power-domain status of the HW since there may be other HW also
>> use
>> that power-domain.
>>
>> The function dma_alloc_attrs help allocate the iommu buffer which
>> need the corresponding power domain since tlb flush is needed when
>> preparing iova. BUT this function only is for allocating buffer,
>> we have no good reason to request the user always call pm_runtime_get
>> before calling dma_alloc_xxx. Therefore, we add a tlb_flush_all
>> in the pm_runtime_resume to make sure the tlb always is clean.
>>
>> Another solution is always call pm_runtime_get in the
>> tlb_flush_range.
>> This will trigger pm runtime resume/backup so often when the iommu
>> power is not active at some time(means user don't call pm_runtime_get
>> before calling dma_alloc_xxx), This may cause the performance drop.
>> thus we don't use this.
>>
>> In other case, the iommu's power should always be active via device
>> link with smi.
>>
>> The previous SoC don't have PM except mt8192. the mt8192 IOMMU is
>> display's
>> power-domain which nearly always is enabled. thus no need fix tags
>> here.
>> Prepare for mt8195.
> 
> In this patchset, this message should be not proper. I think you could
> add the comment why this patch is needed in mt8173.
> 
>>
>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>> [imporvie inline doc]
>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>> ---
>>   drivers/iommu/mtk_iommu.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>> index 25b834104790..28dc4b95b6d9 100644
>> --- a/drivers/iommu/mtk_iommu.c
>> +++ b/drivers/iommu/mtk_iommu.c
>> @@ -964,6 +964,13 @@ static int __maybe_unused
>> mtk_iommu_runtime_resume(struct device *dev)
>>   		return ret;
>>   	}
>>   
>> +	/*
>> +	 * Users may allocate dma buffer before they call
>> pm_runtime_get,
>> +	 * in which case it will lack the necessary tlb flush.
>> +	 * Thus, make sure to update the tlb after each PM resume.
>> +	 */
>> +	mtk_iommu_tlb_flush_all(data);
> 
> This should not work. since current the *_tlb_flush_all call
> pm_runtime_get_if_in_use which will always return 0 when it called from
> this runtime_cb in my test. thus, It won't do the tlb_flush_all
> actually.
> 
> I guess this also depend on these two patches of mt8195 v3.
> [PATCH v3 09/33] iommu/mediatek: Remove for_each_m4u in tlb_sync_all
> [PATCH v3 10/33] iommu/mediatek: Add tlb_lock in tlb_flush_all
> 
> like in [10/33], I added a mtk_iommu_tlb_do_flush_all which don't have
> the pm operation.
> 
> This looks has a dependence. Let me know if I can help this.

It did work for me, testing on elm device. I'll check that again.


> 
>> +
>>   	/*
>>   	 * Uppon first resume, only enable the clk and return, since
>> the values of the
>>   	 * registers are not yet set.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
