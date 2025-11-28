Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98082134CF
	for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764314840; cv=none; b=eFxJkgn3TjmMJYXGBrcsKH4TOjAXgNoA+4pnomKpe/L40ew1CAS7ETglBicHvbbQTTzZHa7dEfQVDZz1mWyRH4Vlr/wPJ5C21WWMnrObRqO8Su94csakfQiE6e+JrOokdVe71vVyHTGdgXGz2hOceZAamfXS29DwjO3OvSSXqU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764314840; c=relaxed/simple;
	bh=1phZalzMOMzvhJk+/Zxj1oLv61WAMvs3iBRcwH61vbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P70EPRkr4kiJQac5fdGfR5rFBIIQAzvLyFjz6CnO6gP+bD4a87cQVM47APAgdz6LK+T4EXmh2abs1PbgfQenbiP+IldzWGfKCLRUEZxlLvltwKeJ4i8zavk4b0SdLkuaz7CXctP+zkpMe+GmwuFKNrL9WmUYlOSlUoH3//HcWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.pueschel@pengutronix.de>)
	id 1vOssm-0005Lu-Ba; Fri, 28 Nov 2025 08:27:08 +0100
Message-ID: <cea54dcb-6236-4363-8b46-e2213a190894@pengutronix.de>
Date: Fri, 28 Nov 2025 08:26:55 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/rockchip: disable fetch dte time limit
To: Shawn Lin <shawn.lin@rock-chips.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Simon Xue <xxm@rock-chips.com>, kernel@pengutronix.de
References: <20251126-spu-iommudtefix-v1-1-f90003dbfcc4@pengutronix.de>
 <075100c0-b4af-4077-bd3c-dd9407524671@rock-chips.com>
Content-Language: en-US
From: =?UTF-8?Q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>
In-Reply-To: <075100c0-b4af-4077-bd3c-dd9407524671@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.pueschel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux.dev


On 11/27/25 5:32 AM, Shawn Lin wrote:
> 在 2025/11/26 星期三 19:45, Sven Püschel 写道:
>> From: Simon Xue <xxm@rock-chips.com>
>>
>> Disable the Bit 31 of the AUTO_GATING iommu register, as it causes
>> hangups with the RGA3 (Raster Graphics Acceleration 3) peripheral.
>> The RGA3 register description of the TRM already states that the bit
>> must be set to 1. The vendor kernel sets the bit unconditionally to
>> 1 to fix VOP (Video Output Processor) screen black issues. This patch
>> squashes the 2 vendor kernel commits with the following commit messages:
>>
>> Master fetch data and cpu update page table may work in parallel, may
>> have the following procedure:
>>
>>     master                  cpu
>>     fetch dte               update page tabl
>>             |                       |
>>     (make dte invalid)  <-  zap iotlb entry
>>             |                       |
>>     fetch dte again
>>     (make dte invalid)  <-  zap iotlb entry
>>             |                       |
>>     fetch dte again
>>     (make dte invalid)  <-  zap iotlb entry
>>             |                       |
>>     fetch dte again
>>     (make iommu block)  <-  zap iotlb entry
>>
>> New iommu version has the above bug, if fetch dte consecutively four
>> times, then it will be blocked. Fortunately, we can set bit 31 of
>> register MMU_AUTO_GATING to 1 to make it work as old version which does
>> not have this issue.
>>
>> This issue only appears on RV1126 so far, so make a workaround dedicated
>> to "rockchip,rv1126" machine type.
>>
>> iommu/rockchip: fix vop blocked and screen black on RK356X and RK3588
>>
>> RK3568 and RK3588 has the same issue as RV1126/RV1109 that caused by
>> dte fetch time limit, So we can set BIT(31) of register 0x24 default
>> to 1 as a workaround.
>>
>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
>> Signed-off-by: Sven Püschel <s.pueschel@pengutronix.de>
>> ---
>> During testing of a newly developed driver for the RGA3 peripheral [1]
>> (Raster Graphic Acceleration 3) of the RK3588 some sporadic hangs
>> have been observed. The upstream rockchip-iommu driver is used to handle
>> the RGA3 IOMMU register space.
>>
>> After a closer look at the TRM for the RK3588, the RGA3 iommu register
>> description of the RGA3_MMU_AUTO_GATING register (offset 0x24) mentions
>
> It's 0xF24 per RGA3 chapter.

yeah, sorry. I was already thinking relative to the rga3 iommu address 
space in my head, but didn't really mention that the chapter says 0xF24 
with the iommu related registers starting at 0xF00.

Sincerely
     Sven

>
>> a mmu_bug_fixed_disable bit, which must be set to 1 but defaults to 0.
>>
>> Looking at the commits in the vendor kernel, the bit is unconditionally
>> set to 1 and mentions that it fixes a blocked VOP (Video Output
>> Processor) [3]. Therefore squash the relevant vendor commits
>> [2] and [3] into a single patch, combine the commit messages and keep
>> the Signed-off-by line from the original author.
>>
>> [1] 
>> https://lore.kernel.org/all/20251007-spu-rga3-v1-0-36ad85570402@pengutronix.de/
>> [2] 
>> https://github.com/rockchip-linux/kernel/commit/7f8158fb41b5cc8e738aaeebc3637c50ebd74cae
>> [3] 
>> https://github.com/rockchip-linux/kernel/commit/6a355e5f9a2069a2309e240791bc3aad63b7324e
>> ---
>>   drivers/iommu/rockchip-iommu.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/iommu/rockchip-iommu.c 
>> b/drivers/iommu/rockchip-iommu.c
>> index 0861dd469bd86..2d0dabb0d101a 100644
>> --- a/drivers/iommu/rockchip-iommu.c
>> +++ b/drivers/iommu/rockchip-iommu.c
>> @@ -76,6 +76,8 @@
>>   #define SPAGE_ORDER 12
>>   #define SPAGE_SIZE (1 << SPAGE_ORDER)
>>   +#define DISABLE_FETCH_DTE_TIME_LIMIT BIT(31)
>> +
>>    /*
>>     * Support mapping any size that fits in one page table:
>>     *   4 KiB to 4 MiB
>> @@ -930,6 +932,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>>       struct iommu_domain *domain = iommu->domain;
>>       struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
>>       int ret, i;
>> +    u32 auto_gate;
>>         ret = clk_bulk_enable(iommu->num_clocks, iommu->clocks);
>>       if (ret)
>> @@ -948,6 +951,11 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>> rk_ops->mk_dtentries(rk_domain->dt_dma));
>>           rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
>>           rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, 
>> RK_MMU_IRQ_MASK);
>> +
>> +        /* Workaround for iommu blocked, BIT(31) default to 1 */
>> +        auto_gate = rk_iommu_read(iommu->bases[i], RK_MMU_AUTO_GATING);
>> +        auto_gate |= DISABLE_FETCH_DTE_TIME_LIMIT;
>> +        rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATING, auto_gate);
>>       }
>>         ret = rk_iommu_enable_paging(iommu);
>>
>> ---
>> base-commit: 30f09200cc4aefbd8385b01e41bde2e4565a6f0e
>> change-id: 20251126-spu-iommudtefix-cd0c5244c74a
>>
>> Best regards,
>
>
