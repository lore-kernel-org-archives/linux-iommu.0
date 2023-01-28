Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5D3232;
	Sat, 28 Jan 2023 11:44:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 8131B426ED;
	Sat, 28 Jan 2023 11:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1674906295; bh=y6NjkpFqlOQK1FSsD4eLjzZgK5uIpnQZ0YXWid4+Q4c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=e0mF4vXkfbWFXEabiUuBQJt7nfOuTDhewCng07+Nkp0H7xfRoKPePFQ4cOa7qxNsW
	 qmlKS1cMaehu65VPYqinQYsiMdOD/dNI0PnIj1FpLSV0+6XmKOAzPag18BHI9rD72C
	 vRdCO3ozZJMX1Vd7NWcGyLsl0Tj6pXRWy1DY9r9+z2VdtSvpiAO/min0ntLKJxFeq9
	 uDEkvvK6XWvAAzbczFZ8rfd7rZhLSD/IPCbygcGyk00ZnA/T6KJUXEVnHpOYRP0Bec
	 BReNp9ZhpCSmmEcubYn6ZRf/2WX8sRAmoUVLekBPfuMoRk+5BB6yww1ygDQFnM0FNg
	 bzJv9uBiJ9iBg==
Message-ID: <b4428d3b-bcad-cea0-7364-753b050faa78@marcan.st>
Date: Sat, 28 Jan 2023 20:44:50 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/4] iommu: dart: Add flag to override bypass support
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
 <20230128111114.4049-3-sven@svenpeter.dev>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <20230128111114.4049-3-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/01/2023 20.11, Sven Peter wrote:
> The USB4 PCIe DARTs claim to support bypass but we never want to allow
> that on externally facing ports.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/iommu/apple-dart.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 42666617803d..7d8b2b90cdb6 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -182,6 +182,8 @@ struct apple_dart_hw {
>  	u64 ttbr_addr_field_shift;
>  	u64 ttbr_shift;
>  	int ttbr_count;
> +
> +	bool disable_bypass;
>  };
>  
>  /*
> @@ -1075,6 +1077,9 @@ static int apple_dart_probe(struct platform_device *pdev)
>  	dart->pgsize = 1 << FIELD_GET(DART_PARAMS1_PAGE_SHIFT, dart_params[0]);
>  	dart->supports_bypass = dart_params[1] & DART_PARAMS2_BYPASS_SUPPORT;
>  
> +	if (dart->hw->disable_bypass)
> +		dart->supports_bypass = 0;
> +
>  	switch (dart->hw->type) {
>  	case DART_T8020:
>  	case DART_T6000:


Acked-by: Hector Martin <marcan@marcan.st>

- Hector
