Return-Path: <SRS0=xVSy=SS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D39C10F14
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 13:37:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363F321904
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 13:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363F321904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E7B7DFE2;
	Tue, 16 Apr 2019 13:37:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0FC34F7D
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 13:37:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 12C06828
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 13:37:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBD86EBD;
	Tue, 16 Apr 2019 06:37:43 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B21A73F59C;
	Tue, 16 Apr 2019 06:37:40 -0700 (PDT)
Subject: Re: [PATCH 3/9] iommu/dma-iommu: Add iommu_dma_copy_reserved_iova,
	iommu_dma_apply_resv_region to the dma-iommu api
To: Tom Murphy <tmurphy@arista.com>, Christoph Hellwig <hch@infradead.org>
References: <20190411184741.27540-1-tmurphy@arista.com>
	<20190411184741.27540-4-tmurphy@arista.com>
	<20190415063134.GB1377@infradead.org>
	<CAPL0++7Z=EMpYOvUn8yvcRqRT5iwJMD8zLhmFr4uFbH7W3WqXQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <bc3cc59a-ea12-c82a-87a0-779a3418125f@arm.com>
Date: Tue, 16 Apr 2019 14:37:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPL0++7Z=EMpYOvUn8yvcRqRT5iwJMD8zLhmFr4uFbH7W3WqXQ@mail.gmail.com>
Content-Language: en-GB
Cc: linux-samsung-soc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
	Dmitry Safonov <dima@arista.com>, Marc Zyngier <marc.zyngier@arm.com>,
	linux-arm-msm@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	David Brown <david.brown@linaro.org>,
	iommu@lists.linux-foundation.org, Kukjin Kim <kgene@kernel.org>,
	linux-mediatek@lists.infradead.org, Tom Murphy <murphyt7@tcd.ie>,
	Andy Gross <andy.gross@linaro.org>, linux-rockchip@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190416133739.8GowdzEXvLQLIhAOEB0y3p28kgxcN8cvvkLIkT0QRPo@z>

On 16/04/2019 14:22, Tom Murphy wrote:
> I hoped this could be an exception, it's easier to grok without the
> line break and isn't crazy long. Because you mentioned it I'll fix it.

Frankly this patch is hard to justify anyway - iommu-dma already has its 
own reserved region handling, and there should be no need for external 
callers to be poking into the innards provided the IOMMU driver reports 
the correct reserved regions in the first place.

If the iommu-dma abstraction is not quite sufficient to actually convert 
amd-iommu to use it properly, then we should improve the abstraction, 
rather than just punching holes in it to merely poke renamed parts of 
the existing amd-iommu logic into.

Robin.

> On Mon, Apr 15, 2019 at 7:31 AM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Thu, Apr 11, 2019 at 07:47:32PM +0100, Tom Murphy via iommu wrote:
>>> +
>>> +     WARN_ON_ONCE(iommu_dma_reserve_iova(domain, region->start, end) == NULL);
>>
>> Overly long line..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
