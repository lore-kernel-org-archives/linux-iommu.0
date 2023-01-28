Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874913232;
	Sat, 28 Jan 2023 11:45:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 7C716424D0;
	Sat, 28 Jan 2023 11:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1674906342; bh=izttfsBM8FR0txRob5fPFR1ElRpJR+EMtvZG2dF3LfQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bapk+bDshERBmlwTnHFQeQJ0Dx1YtANznhHJijZm0H0Q47HMZDnOaIfi+hFHPEjmi
	 Qdi+xL4ZMDV4KAGLhJ8+0yzk9/Qjv3bBS3VbVaAG53aS7EEzCHn5g0R+/JLQM062xH
	 hk6jf9rjUEjC2b5jytAAgkczIplMi7spn5MxvL+LqU9GoiZBjIVM1Xx6uLnL7cdpy9
	 iEkvNU0Or6xVFTjhMukMHPElqh5UEGFwLxRYYOeecR35HJVsTVCJncCV3e2GZF0h6p
	 Ez2DbHmw8C67tshDZskxcKxGv2bCmX+OK1yi9/wmztt5LVD0iLkEFr47Vw9A81HBpE
	 k736D4Vf46IwQ==
Message-ID: <defcbb1a-599f-c905-1f4c-5c512d0a67c1@marcan.st>
Date: Sat, 28 Jan 2023 20:45:37 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/4] iommu: dart: Write to all DART_T8020_STREAM_SELECT
Content-Language: en-US
To: Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230128111114.4049-1-sven@svenpeter.dev>
 <20230128111114.4049-4-sven@svenpeter.dev>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <20230128111114.4049-4-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/01/2023 20.11, Sven Peter wrote:
> We're about to add support for a DART variant that use more than 16
> streams and requires writing to two separate stream select registers
> when issuing TLB flushes.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/iommu/apple-dart.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 7d8b2b90cdb6..7579c97a9062 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -372,12 +372,14 @@ apple_dart_t8020_hw_stream_command(struct apple_dart_stream_map *stream_map,
>  			     u32 command)
>  {
>  	unsigned long flags;
> -	int ret;
> +	int ret, i;
>  	u32 command_reg;
>  
>  	spin_lock_irqsave(&stream_map->dart->lock, flags);
>  
> -	writel(stream_map->sidmap[0], stream_map->dart->regs + DART_T8020_STREAM_SELECT);
> +	for (i = 0; i < BITS_TO_U32(stream_map->dart->num_streams); i++)
> +		writel(stream_map->sidmap[i],
> +		       stream_map->dart->regs + DART_T8020_STREAM_SELECT + 4 * i);
>  	writel(command, stream_map->dart->regs + DART_T8020_STREAM_COMMAND);
>  
>  	ret = readl_poll_timeout_atomic(

Acked-by: Hector Martin <marcan@marcan.st>

- Hector
