Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F407FD;
	Thu,  5 Jan 2023 05:16:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 4266242137;
	Thu,  5 Jan 2023 05:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1672895792; bh=6G+K5gRC9t4y2G8nB4otob8iev95c+3AsFRTdh6iaKw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N934kro5t42Ie8SO5mlE3VQJ6FAsRAHdUm5x98+1zshhtrEThZvzw42SxMkAphNkn
	 PJSubN1zLTep0pak6PzxjE0+6EFACn79K2jW31p5yva/vPo5xI45kMQOV3PSajzLNX
	 vXXzaLRRuq3z9fdY8o9gVyCqvRA592fkbReP6Qh04FiaSyvlI2gg3iuOFAgbUF433m
	 C23R2b6uGBN6uDpY+UUE1OTf1C2/WMGJroS+AB1Qz8hT5xS5cyFeG21IbxUxugMLCB
	 xLWGjOsoJy3NKicPr8hwgKe4niLyKqNmK4NCfw8Bd1HVqjDzGfG1Aw1RhLb6UQkTw/
	 HtvlAGkHxLbMQ==
Message-ID: <57a52e19-e121-6082-a4d8-f58ade353782@marcan.st>
Date: Thu, 5 Jan 2023 14:16:27 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/7] iommu: dart: Support different variants with
 different registers
Content-Language: en-US
To: Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, iommu@lists.linux.dev, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230104110013.24738-1-marcan@marcan.st>
 <20230104110013.24738-7-marcan@marcan.st>
 <228a80d4-752b-42ae-84b4-47197ec82c24@app.fastmail.com>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <228a80d4-752b-42ae-84b4-47197ec82c24@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/01/04 22:43, Sven Peter wrote:
> On Wed, Jan 4, 2023, at 12:00, Hector Martin wrote:
>> +	u64 enable_streams;
>> +	u64 disable_streams;
> I don't think disable_streams is used anywhere. I assume you just left it in
> here to document it?

Yeah, we don't use this field ever, so we might as well drop it. I'll
leave the #define for T8110 in though, as documentation.

>> +	u64 ttbr;
>> +	u64 ttbr_valid;
>> +	u64 ttbr_addr_off;
> 
> This name confused me a bit since off sounds like offset to me while
> this is actually another shift. Can't really think of a better name
> right now though. I'd at least a comment here to describe it.

How about `ttbr_addr_field_shift`?

- Hector
