Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730DB3C2B;
	Wed,  4 Jan 2023 13:19:15 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id D67293200943;
	Wed,  4 Jan 2023 08:19:13 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Wed, 04 Jan 2023 08:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1672838353; x=1672924753; bh=Bo
	7BNFU8pROhJYRhF85cv4PW1aA16wwv31J+QatGx2E=; b=FkCKJxP4eaOksY+daQ
	LyHpudNp3EYQ+ozdKKXENEkSK79rBHfW0sMmevKEvrCO/KKeLFX7zDBb3+pe64ZO
	OBAzEuMgJifNnpNv6zvvctls7Gh+p2e81fXgzxS1kD/iQYy+bTITP0RPOkifyjzl
	fqNWW7c9tJXFAPEGXgGh3v0ywtjkOHqrfYrnRPQonLMCZyVUZRywLmj5oSc4ac+9
	0RLvU+qFZZx9kwDPG8YlEq4dJxBkpGyOXniXcQj73SFJisH1K9FNcOphLkS8z3hr
	6wloyrsc26GlsPZdCh9ikZBiAtdB3RNPmzI5+wAN1ytmtY72BHcQ4skd5oHaqfDN
	gYEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1672838353; x=1672924753; bh=Bo7BNFU8pROhJYRhF85cv4PW1aA1
	6wwv31J+QatGx2E=; b=QmjUElivSGyaSA54z3Djjw+SZXmsed+7jX+t2zadnnL3
	Yk8gKLZHmkI+F9JpWbLsma/ka4fstt8JwiHhdOUAYb3JapReREKOsv9p5bB6z+i6
	BK6tXYtT2uTqOvTj2+r+cXRj9HTIX+7MTp2ccguWwp+YvvShfnucwmY5V+8Zfiaa
	9O2VGqa31U8xoHzVMj4wqz1QNoC/3385pONrHrKk6Yo3BlzFqfeh1JqmwekNAPvq
	2wN4sp+6ZtD/WJv+ZtbxhdicZBZ1l0kKRS9w9l+zlq7ox7ULHVSfVEcDJQxvROhl
	LFGR/OUja/JM3fIC+UU9CLo79WEfFqjVNGtR1CXgUg==
X-ME-Sender: <xms:0Xy1Y65axzY-MKXuXST9EsWLcMBF6g5GOr9SLujsv80VLg3lIrGCcA>
    <xme:0Xy1Yz4MuDJU7A9y3uFyiaX3UYDH42_d7EsCjsjpdqnYpwTm1Y5qmSOc-6DaO4WcC
    d07dOqVfmQlKaKPEWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:0Xy1Y5dC5fdAw7JjIh0JTrdOz4V3KvW6C3yoX-a9j97iVSbCR0GgYg>
    <xmx:0Xy1Y3JwiCAD_wA-GedmYqU3BV3nfqJralCq-H-8ymsL8GDXZGMjkQ>
    <xmx:0Xy1Y-IQejAAWAp65m8x0SNvQJfXVLmJCBgtU9cgujuUMg5O6UJnSA>
    <xmx:0Xy1Y7Cf7jmbmgJ0cLYVH72j9M7b0Dm_3pd2XlZ58IzWGGYNnKe-8g>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 43730A6007C; Wed,  4 Jan 2023 08:19:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Message-Id: <6852ebfa-bebc-48cf-a31c-04801fc90af1@app.fastmail.com>
In-Reply-To: <20230104110013.24738-5-marcan@marcan.st>
References: <20230104110013.24738-1-marcan@marcan.st>
 <20230104110013.24738-5-marcan@marcan.st>
Date: Wed, 04 Jan 2023 14:18:52 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Hector Martin" <marcan@marcan.st>, "Joerg Roedel" <joro@8bytes.org>,
 "Will Deacon" <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>
Cc: "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, "Janne Grunau" <j@jannau.net>,
 "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, iommu@lists.linux.dev, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] iommu: dart: Support a variable number of TTBRs per stream
Content-Type: text/plain

On Wed, Jan 4, 2023, at 12:00, Hector Martin wrote:
> T8110 only has one TTBR per stream, so un-hardcode that.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/iommu/apple-dart.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 48743bcd5b9d..189487c1d978 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -77,15 +77,21 @@
>  #define DART_TCR_BYPASS0_ENABLE BIT(8)
>  #define DART_TCR_BYPASS1_ENABLE BIT(12)
> 
> -#define DART_TTBR(sid, idx) (0x200 + 16 * (sid) + 4 * (idx))
>  #define DART_TTBR_VALID BIT(31)
>  #define DART_TTBR_SHIFT 12
> 
> +#define DART_TTBR(dart, sid, idx) (0x200 + \
> +				   (((dart)->hw->ttbr_count * (sid)) << 2) + \
> +				   ((idx) << 2))
> +
> +
>  struct apple_dart_hw {
>  	u32 oas;
>  	enum io_pgtable_fmt fmt;
> 
>  	int max_sid_count;
> +
> +	int ttbr_count;
>  };
> 
>  /*
> @@ -245,7 +251,7 @@ static void apple_dart_hw_set_ttbr(struct 
> apple_dart_stream_map *stream_map,
>  	WARN_ON(paddr & ((1 << DART_TTBR_SHIFT) - 1));
>  	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
>  		writel(DART_TTBR_VALID | (paddr >> DART_TTBR_SHIFT),
> -		       dart->regs + DART_TTBR(sid, idx));
> +		       dart->regs + DART_TTBR(dart, sid, idx));
>  }
> 
>  static void apple_dart_hw_clear_ttbr(struct apple_dart_stream_map 
> *stream_map,
> @@ -255,7 +261,7 @@ static void apple_dart_hw_clear_ttbr(struct 
> apple_dart_stream_map *stream_map,
>  	int sid;
> 
>  	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
> -		writel(0, dart->regs + DART_TTBR(sid, idx));
> +		writel(0, dart->regs + DART_TTBR(dart, sid, idx));
>  }
> 
>  static void
> @@ -263,7 +269,7 @@ apple_dart_hw_clear_all_ttbrs(struct 
> apple_dart_stream_map *stream_map)
>  {
>  	int i;
> 
> -	for (i = 0; i < DART_MAX_TTBR; ++i)
> +	for (i = 0; i < stream_map->dart->hw->ttbr_count; ++i)
>  		apple_dart_hw_clear_ttbr(stream_map, i);
>  }
> 
> @@ -415,7 +421,7 @@ apple_dart_setup_translation(struct 
> apple_dart_domain *domain,
>  	for (i = 0; i < pgtbl_cfg->apple_dart_cfg.n_ttbrs; ++i)
>  		apple_dart_hw_set_ttbr(stream_map, i,
>  				       pgtbl_cfg->apple_dart_cfg.ttbr[i]);
> -	for (; i < DART_MAX_TTBR; ++i)
> +	for (; i < stream_map->dart->hw->ttbr_count; ++i)
>  		apple_dart_hw_clear_ttbr(stream_map, i);
> 
>  	apple_dart_hw_enable_translation(stream_map);
> @@ -956,11 +962,15 @@ static const struct apple_dart_hw apple_dart_hw_t8103 = {
>  	.oas = 36,
>  	.fmt = APPLE_DART,
>  	.max_sid_count = 16,
> +
> +	.ttbr_count = 4,
>  };
>  static const struct apple_dart_hw apple_dart_hw_t6000 = {
>  	.oas = 42,
>  	.fmt = APPLE_DART2,
>  	.max_sid_count = 16,
> +
> +	.ttbr_count = 4,
>  };
> 
>  static __maybe_unused int apple_dart_suspend(struct device *dev)
> @@ -970,9 +980,9 @@ static __maybe_unused int apple_dart_suspend(struct 
> device *dev)
> 
>  	for (sid = 0; sid < dart->num_streams; sid++) {
>  		dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(sid));
> -		for (idx = 0; idx < DART_MAX_TTBR; idx++)
> +		for (idx = 0; idx < dart->hw->ttbr_count; idx++)
>  			dart->save_ttbr[sid][idx] =
> -				readl(dart->regs + DART_TTBR(sid, idx));
> +				readl(dart->regs + DART_TTBR(dart, sid, idx));
>  	}
> 
>  	return 0;
> @@ -993,7 +1003,7 @@ static __maybe_unused int apple_dart_resume(struct 
> device *dev)
>  	for (sid = 0; sid < dart->num_streams; sid++) {
>  		for (idx = 0; idx < DART_MAX_TTBR; idx++)

s/DART_MAX_TTBR/dart->hw->ttbr_count/ I think.

With that fixed:

Reviewed-by: Sven Peter <sven@svenpeter.dev>



Sven
