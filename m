Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD13AECE588
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 11:24:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7635C21835
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 11:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7635C21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 58EF0C7C;
	Tue, 15 Oct 2019 11:24:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 141C7C77
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 11:24:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 812F86D6
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 11:24:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAE3D1000;
	Tue, 15 Oct 2019 04:24:04 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC9373F68E;
	Tue, 15 Oct 2019 04:24:02 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] iommu/mediatek: Delete the leaf in the tlb flush
To: Yong Wu <yong.wu@mediatek.com>
References: <1571035101-4213-1-git-send-email-yong.wu@mediatek.com>
	<1571035101-4213-5-git-send-email-yong.wu@mediatek.com>
	<20c74c20-864e-88af-3c58-ad3bb7600bcc@arm.com>
	<1571117118.19130.81.camel@mhfsdcap03>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <888d299a-b314-2735-bc73-dd68b92c33af@arm.com>
Date: Tue, 15 Oct 2019 12:24:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1571117118.19130.81.camel@mhfsdcap03>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, edison.hsieh@mediatek.com,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 15/10/2019 06:25, Yong Wu wrote:
> On Mon, 2019-10-14 at 15:22 +0100, Robin Murphy wrote:
>> On 14/10/2019 07:38, Yong Wu wrote:
>>> In our tlb range flush, we don't care the "leaf". Remove it to simplify
>>> the code. no functional change.
>>
>> Presumably you don't care about the granule either?
> 
> Yes. I only keep "granule" to satisfy the format of "tlb_flush_walk",
> then it's no need add a new helper function.

Ah, I'd failed to make the connection that it ends up wired in directly 
to the callbacks in patch #5 - indeed there's no point churning the 
mtk_iommu_tlb_add_flush_nosync() callsites here if they're just getting 
removed later anyway. In that case,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>>    drivers/iommu/mtk_iommu.c | 16 ++++------------
>>>    1 file changed, 4 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index 8712afc..19f936c 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -174,8 +174,7 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
>>>    }
>>>    
>>>    static void mtk_iommu_tlb_add_flush_nosync(unsigned long iova, size_t size,
>>> -					   size_t granule, bool leaf,
>>> -					   void *cookie)
>>> +					   size_t granule, void *cookie)
>>>    {
>>>    	struct mtk_iommu_data *data = cookie;
>>>    
>>> @@ -219,14 +218,7 @@ static void mtk_iommu_tlb_sync(void *cookie)
>>>    static void mtk_iommu_tlb_flush_walk(unsigned long iova, size_t size,
>>>    				     size_t granule, void *cookie)
>>>    {
>>> -	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, false, cookie);
>>> -	mtk_iommu_tlb_sync(cookie);
>>> -}
>>> -
>>> -static void mtk_iommu_tlb_flush_leaf(unsigned long iova, size_t size,
>>> -				     size_t granule, void *cookie)
>>> -{
>>> -	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, true, cookie);
>>> +	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, cookie);
>>>    	mtk_iommu_tlb_sync(cookie);
>>>    }
>>>    
>>> @@ -245,7 +237,7 @@ static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
>>>    static const struct iommu_flush_ops mtk_iommu_flush_ops = {
>>>    	.tlb_flush_all = mtk_iommu_tlb_flush_all,
>>>    	.tlb_flush_walk = mtk_iommu_tlb_flush_walk,
>>> -	.tlb_flush_leaf = mtk_iommu_tlb_flush_leaf,
>>> +	.tlb_flush_leaf = mtk_iommu_tlb_flush_walk,
>>>    	.tlb_add_page = mtk_iommu_tlb_flush_page_nosync,
>>>    };
>>>    
>>> @@ -475,7 +467,7 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
>>>    		spin_lock_irqsave(&dom->pgtlock, flags);
>>>    
>>>    	mtk_iommu_tlb_add_flush_nosync(gather->start, length, gather->pgsize,
>>> -				       false, data);
>>> +				       data);
>>>    	mtk_iommu_tlb_sync(data);
>>>    
>>>    	if (!is_in_gather)
>>>
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
