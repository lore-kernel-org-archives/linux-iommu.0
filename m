Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E48F2DEA90;
	Sat, 16 Aug 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755353999; cv=none; b=fsJQggme43DGOR3NLhI+Ue/zK4xnXe0N1BGvdJhZ+E2S4KPL1adwqdFB8PLz6lpNel7D1VNRLrK0gyD18TlUpvRCFj1ufCx3QxtLrZl7G+Am4OC9z94DEd0y42aH0UDnOiZU5nbHuKFRSEEcePdlyMz3BkEk/M4Jy3FgzfvNFKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755353999; c=relaxed/simple;
	bh=nf7kyzbNYEZU4c3UZr5VFb8CoLAMkskXvGH3WdzPbcY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KlbSjBJscH7UDE8IyZ6Z5Bi4vjIRna9U76I/ZXfT8GniwNFrUPFiP7XTWoP935kur7d9FwOW7BU5t5AcUNGZYFs+POX25W6Uao5AmyRcNNMhoSle6lLDB+TEkelsMinYd9UTs3Q1vfXCDLw60maO417OOMOvZiQxp/u1z3LcYGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=IfD1KkmC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cyIG6nbz; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="IfD1KkmC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cyIG6nbz"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4103E7A02B7;
	Sat, 16 Aug 2025 10:19:55 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Sat, 16 Aug 2025 10:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755353995;
	 x=1755440395; bh=uUlh/L5iBn2cZluTjtVOTeuqRXG5pOVjQE6WfHmHMeQ=; b=
	IfD1KkmCs/+imALzV5qqefaa/LNt/OmMOuRPl1WinpFwBNtFotmVLroGZipUlzvQ
	tzUn4cKb3LIKHq25IW0i3MBde+TymZ7qpb6kYF9l0AnCif3IhWNPRK3RHpxI/srF
	UE3E7B70z0XLx3MruxK5PVm9aDNbzx27lIjFiOfsFwnULoA/wFD5nsea65FCgKwe
	K7CkEtr4Zv783Lwj/e/xaFWKa/NLpfBvqXA9JwLj+ciZTKFBi9Q3wNNrOxynxG1L
	XYOiVOcSzn2nx/jYmcP0BSF1wfg5eUsy70gOxB0cJUe9sDDTACxslwHjbP00zKbq
	JqO/73mmFgtVog1bbUFaIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755353995; x=
	1755440395; bh=uUlh/L5iBn2cZluTjtVOTeuqRXG5pOVjQE6WfHmHMeQ=; b=c
	yIG6nbzLkluoUtXyWgJceAgWgySU2RgvaBbKf/ynuH+g6E3dW/1EGyQb0jS/ayGS
	hxRE+Teq6Kjpn4WeiPbh7qywsX1BcaTkuVl5evnAXoVOEU/nzRxRQ8XuLXghGG6w
	qO7/9yMLGs2EdpmgM7otV47Irngkkwcwg9nt3t3RYQQKl60TTsObMIrAA8+FbwIU
	Md4uZ/CDqZCYZXUEpCTkEEyzXsUvWjdep8nyJmtcxOXn0ItUHAr0uZ+Rq43ZT5qZ
	P+PWLa3SXkFPgtRlLeG2mk1ClKj+VaO+ydNeiB/qAiQ9ejzxtWypRZCk4rl2TD57
	05ywDSuOMKKrjfPCCMSZA==
X-ME-Sender: <xms:iZOgaCQ8F1HAx8M4hTKowVC0mkjRJdagCQjS5OzjBc4nE99ujgwFFg>
    <xme:iZOgaHwPE1hSBAx3rN0MD734upqIEjIJpaEfSJ57oUm2PU1QIY_-bpsSE1_Y9kZkO
    y9qx7x9TEySD8nEHE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeejtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfgrnhhn
    vgcuifhruhhnrghufdcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epheejtdeffeethfetgefhffejudegheefueejtedvhfeuheevfeekheetfeduffevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnh
    hnrghurdhnvghtpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhorhhoseeksgihthgvshdrohhrghdprhgtphhtthhopehrohgsihhnrd
    hmuhhrphhhhiesrghrmhdrtghomhdprhgtphhtthhopehnvggrlhesghhomhhprgdruggv
    vhdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilh
    hlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgv
    lheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrshgrhhhise
    hlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepihhomhhmuheslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehmrghrtggrnhesmhgrrhgtrghnrdhsth
X-ME-Proxy: <xmx:iZOgaDUeUO03LyxCXHYfmw9LCDo12_91ql4W0jPaJAPyQt7aChoHwQ>
    <xmx:iZOgaBERpxt-lW-vHqQPifnCjBi0NhCOW2T1JfMINoHysM1DszeGaw>
    <xmx:iZOgaOdbIoTiQTP0SBZz1ioFrYy8IFvNZEGSn3Xk61O1Q3gbTiz5TA>
    <xmx:iZOgaCq5v_XtB0WlQ4GVnjvqiUgDglCFDFYqAVIKeGW1qx9yTJIO5g>
    <xmx:i5OgaHyLWNa1HTaJfEPCJZwiD1JlKOuGsMhoQA33o11jEiOdur44mLq3>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9F059700065; Sat, 16 Aug 2025 10:19:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AIqzQMgvnQL3
Date: Sat, 16 Aug 2025 16:19:33 +0200
From: "Janne Grunau" <j@jannau.net>
To: "Sven Peter" <sven@kernel.org>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, "Neal Gompa" <neal@gompa.dev>,
 "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
 "Robin Murphy" <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 "Hector Martin" <marcan@marcan.st>
Message-Id: <2d3e818d-5bc3-4156-a0c6-6d756f814c86@app.fastmail.com>
In-Reply-To: <c9440d31-add4-4c0f-ac2a-184e771ab455@kernel.org>
References: <20250814-apple-dart-4levels-v1-0-db2214a78c08@jannau.net>
 <20250814-apple-dart-4levels-v1-3-db2214a78c08@jannau.net>
 <c9440d31-add4-4c0f-ac2a-184e771ab455@kernel.org>
Subject: Re: [PATCH 3/3] iommu: apple-dart: Add 4-level page table support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hej,

On Sat, Aug 16, 2025, at 15:50, Sven Peter wrote:
> On 14.08.25 10:40, Janne Grunau wrote:
>> From: Hector Martin <marcan@marcan.st>
>>
>> The T8110 variant DART implementation on T602x SoCs indicates an IAS
>> of 42, which requires an extra page table level. The extra level is
>> optional, but let's implement it.
>>
>> Since the driver failed at IO page table creation with 42-bit IAS add
>> "apple,t6020-dart" as separate compatible using the T8110 HW data.
>
> Is the commit description outdated? I don't see this change anywhere.

yes, I decided to handle this as missing feature / bug. Both end up with
the same result and as far as we can tell it is fully compatible.
Removed locally.

>> Later it might be useful to restrict this based on the actual
>> attached devices, since most won't need that much address space
>> anyway.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st> Signed-off-by: Janne
>> Grunau <j@jannau.net>
>> ---
>>   drivers/iommu/apple-dart.c | 23 +++++++++++++++++------ 1 file
>>   changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
>> index e72a93e78e26ca61b233c83d439dbdfadf040fc6..bb48e8603d6c84bcf107-
>> 294d851c2f2fc1273298 100644 --- a/drivers/iommu/apple-dart.c +++ b/drivers/iommu/apple-
>> dart.c @@ -133,6 +133,7 @@  #define DART_T8110_TCR
>> 0x1000  #define DART_T8110_TCR_REMAP            GENMASK(11, 8)
>> #define DART_T8110_TCR_REMAP_EN         BIT(7) +#define
>> DART_T8110_TCR_FOUR_LEVEL       BIT(3)  #define
>> DART_T8110_TCR_BYPASS_DAPF      BIT(2)  #define
>> DART_T8110_TCR_BYPASS_DART      BIT(1)  #define
>> DART_T8110_TCR_TRANSLATE_ENABLE BIT(0) @@ -177,6 +178,7 @@ struct
>> apple_dart_hw {     u32 tcr_enabled;     u32 tcr_disabled;     u32
>> tcr_bypass;
>> +    u32 tcr_4level;
>>
>>      u32 ttbr; u32 ttbr_valid; @@ -217,6 +219,7 @@ struct apple_dart
>>      { u32 pgsize; u32 num_streams; u32 supports_bypass : 1;
>> +    u32 four_level : 1;
>>
>>      struct iommu_group *sid2group[DART_MAX_STREAMS]; struct
>>      iommu_device iommu; @@ -305,13 +308,16 @@ static struct
>>      apple_dart_domain *to_dart_domain(struct iommu_domain *dom) }
>>
>>   static void -apple_dart_hw_enable_translation(struct
>>   apple_dart_stream_map *stream_map)
>>   +apple_dart_hw_enable_translation(struct apple_dart_stream_map
>>   *stream_map, int levels) {   struct apple_dart *dart = stream_map-
>>   >dart;   int sid;
>>
>> +    WARN_ON(levels != 3 && levels != 4);
>> +    WARN_ON(levels == 4 && !dart->four_level); for_each_set_bit(sid,
>>      stream_map->sidmap, dart->num_streams)
>> -            writel(dart->hw->tcr_enabled, dart->regs +
>>              DART_TCR(dart, sid));
>> +            writel(dart->hw->tcr_enabled | (levels == 4 ? dart->hw-
>>              >tcr_4level : 0),
>> +                   dart->regs + DART_TCR(dart, sid));
>
> This is a bit hard to read, I'd prefer an explicit if (dart->hw-
> >tcr_4level) here.

you mean `if (levels == 4)`? `dart->hw->tcr_4level` will be `BIT(3)` for
t8110 darts even when they use just 3 page table levels.

Changed locally to

u32 tcr = dart->hw->tcr_enabled; if (levels == 4)        tcr |= dart->hw-
>tcr_4level;

and then writel(tcr, ...) in the loop.

I've change prefix of all commits in this series to "iommu/apple-dart"
and "iommu/io-pgtable-dart".

thanks,
Janne
