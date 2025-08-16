Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0ED2E3717;
	Sat, 16 Aug 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357990; cv=none; b=rpbp8uryDaOHKyUcJRFcl03aMazAOZERDMdgkD5cDNYARFGkzx0aQXF8Pnjx+8dpHPzMra/uAw7chIx4Yspb2bnW1jndERppPxqo7BjnCqrFDGzjvsn8qp26PM/gZwFZWI0sKkuUkZl8ezXKUj91IebLrxMdfCDklYTaHht9CYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357990; c=relaxed/simple;
	bh=Pc4q8yjY8pxZXyMW5NA6zIA9FgLD4a52pcg6bXs53hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgXbwuch0Ot2aF1EiN59jTGMcaOuOwaqkPrgWeQ1V2uxqIkCS6QtEtVvSN1xKRD8Vw2YAABknlOnS2VWc6n/nV9FyyzLmOKyTL4po+/10IIJayxPSmustatF3HjNLsAs6aHL1wtK+e4IwOXTXuX/8VrBruv0Gun9Hkx3s0tU/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0UR2x2/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0UR2x2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A586C4CEEF;
	Sat, 16 Aug 2025 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755357989;
	bh=Pc4q8yjY8pxZXyMW5NA6zIA9FgLD4a52pcg6bXs53hc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i0UR2x2/Uy/VCJta0LcRf9hVPfE+cxny4aiT/Uz048xnKZOhwlKu5x0IAxYyy4JHT
	 or+hmzQ3DUbdoerIvupVraj4bRIBoEmkqj0psjRoSLkIj1yh5SUu7OSBEupL8x4Fd4
	 ut2pXLlFTcDQ/GnW2dmKOrQ2sVMy42jnVN+AsXuaZ0VZHzZKJUiZKaXCkHRGQLAL8S
	 fxmKYy4aE4yo1kg7e/AJOi1A+FkmkGs3EeuFkO/ft5ObauSVo0/yqNvtbmPP9uBjZB
	 3nfFQCQLsRx95RBPCpEJ92LY25sRARzi53yrsD0bUt8fu3YH503wQmkLfLUXaxi+n/
	 Rsvd3Y8dShXfg==
Message-ID: <b0dfb39b-e72e-4b8f-bd4a-bc8320aae98f@kernel.org>
Date: Sat, 16 Aug 2025 17:26:25 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iommu: apple-dart: Add 4-level page table support
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 Hector Martin <marcan@marcan.st>
References: <20250814-apple-dart-4levels-v1-0-db2214a78c08@jannau.net>
 <20250814-apple-dart-4levels-v1-3-db2214a78c08@jannau.net>
 <c9440d31-add4-4c0f-ac2a-184e771ab455@kernel.org>
 <2d3e818d-5bc3-4156-a0c6-6d756f814c86@app.fastmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <2d3e818d-5bc3-4156-a0c6-6d756f814c86@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.25 16:19, Janne Grunau wrote:
> Hej,
> 
> On Sat, Aug 16, 2025, at 15:50, Sven Peter wrote:
>> On 14.08.25 10:40, Janne Grunau wrote:
>>> From: Hector Martin <marcan@marcan.st>
>>>
>>> The T8110 variant DART implementation on T602x SoCs indicates an IAS
>>> of 42, which requires an extra page table level. The extra level is
>>> optional, but let's implement it.
>>>
>>> Since the driver failed at IO page table creation with 42-bit IAS add
>>> "apple,t6020-dart" as separate compatible using the T8110 HW data.
>>
>> Is the commit description outdated? I don't see this change anywhere.
> 
> yes, I decided to handle this as missing feature / bug. Both end up with
> the same result and as far as we can tell it is fully compatible.
> Removed locally.
> 
>>> Later it might be useful to restrict this based on the actual
>>> attached devices, since most won't need that much address space
>>> anyway.
>>>
>>> Signed-off-by: Hector Martin <marcan@marcan.st> Signed-off-by: Janne
>>> Grunau <j@jannau.net>
>>> ---
>>>    drivers/iommu/apple-dart.c | 23 +++++++++++++++++------ 1 file
>>>    changed, 17 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
>>> index e72a93e78e26ca61b233c83d439dbdfadf040fc6..bb48e8603d6c84bcf107-
>>> 294d851c2f2fc1273298 100644 --- a/drivers/iommu/apple-dart.c +++ b/drivers/iommu/apple-
>>> dart.c @@ -133,6 +133,7 @@  #define DART_T8110_TCR
>>> 0x1000  #define DART_T8110_TCR_REMAP            GENMASK(11, 8)
>>> #define DART_T8110_TCR_REMAP_EN         BIT(7) +#define
>>> DART_T8110_TCR_FOUR_LEVEL       BIT(3)  #define
>>> DART_T8110_TCR_BYPASS_DAPF      BIT(2)  #define
>>> DART_T8110_TCR_BYPASS_DART      BIT(1)  #define
>>> DART_T8110_TCR_TRANSLATE_ENABLE BIT(0) @@ -177,6 +178,7 @@ struct
>>> apple_dart_hw {     u32 tcr_enabled;     u32 tcr_disabled;     u32
>>> tcr_bypass;
>>> +    u32 tcr_4level;
>>>
>>>       u32 ttbr; u32 ttbr_valid; @@ -217,6 +219,7 @@ struct apple_dart
>>>       { u32 pgsize; u32 num_streams; u32 supports_bypass : 1;
>>> +    u32 four_level : 1;
>>>
>>>       struct iommu_group *sid2group[DART_MAX_STREAMS]; struct
>>>       iommu_device iommu; @@ -305,13 +308,16 @@ static struct
>>>       apple_dart_domain *to_dart_domain(struct iommu_domain *dom) }
>>>
>>>    static void -apple_dart_hw_enable_translation(struct
>>>    apple_dart_stream_map *stream_map)
>>>    +apple_dart_hw_enable_translation(struct apple_dart_stream_map
>>>    *stream_map, int levels) {   struct apple_dart *dart = stream_map-
>>>    >dart;   int sid;
>>>
>>> +    WARN_ON(levels != 3 && levels != 4);
>>> +    WARN_ON(levels == 4 && !dart->four_level); for_each_set_bit(sid,
>>>       stream_map->sidmap, dart->num_streams)
>>> -            writel(dart->hw->tcr_enabled, dart->regs +
>>>               DART_TCR(dart, sid));
>>> +            writel(dart->hw->tcr_enabled | (levels == 4 ? dart->hw-
>>>               >tcr_4level : 0),
>>> +                   dart->regs + DART_TCR(dart, sid));
>>
>> This is a bit hard to read, I'd prefer an explicit if (dart->hw-
>>> tcr_4level) here.
> 
> you mean `if (levels == 4)`? `dart->hw->tcr_4level` will be `BIT(3)` for
> t8110 darts even when they use just 3 page table levels.

yup, I must've copy/pasted the wrong thing.

> 
> Changed locally to
> 
> u32 tcr = dart->hw->tcr_enabled; if (levels == 4)        tcr |= dart->hw-
>> tcr_4level;
> 
> and then writel(tcr, ...) in the loop.
Great, I didn't even realize you could move that entire thing out of the 
loop.

> I've change prefix of all commits in this series to "iommu/apple-dart"
> and "iommu/io-pgtable-dart".

Feel free to add my Reviewed-by for this commit as well then.



Thanks,

Sven

