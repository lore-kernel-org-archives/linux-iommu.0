Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D76027E1D0;
	Wed, 20 Aug 2025 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755728445; cv=none; b=pFPpysp1DmiMcB8NQTCQiNJkvKrKCbAos1NNtQ7Mdvd5SnXOLMzCp1q7Bg9ezlMuQuB/9ScBmyaCvJn20jJzKL1F87nhFayPZi6UmMkxrJemLDqyGPauIi3A7IEewShhO9DOCzfWOPyuuF2ffKOAEeMobutONtLNZXVBf16/Cmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755728445; c=relaxed/simple;
	bh=wsUPldU04Nc0Tm1FqMCC1+DGwqczRsoyIsHWywBiPgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J84OWHcsmDuqS3oxo6CGXJ2dQBVVKsKxntUhPHqCWygCI2mRrby9Wvitzca2VIo7SFIni7vAy9pxiHAlQPWk3KyOGOGK/gKjMSZbZc784VUx8/RX8yl70dsRDK9LyIy8/HksthC7vOrTERQc1WEkH8Fcay6LJS0naS9oKPmmSHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvsougiK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvsougiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FA6C4CEE7;
	Wed, 20 Aug 2025 22:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755728444;
	bh=wsUPldU04Nc0Tm1FqMCC1+DGwqczRsoyIsHWywBiPgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvsougiKOoa5TSf6WheDqGzlEMw00QFrCBKPtwUf2Tj9Nc4GtcSPwAfQpiNWBbMHc
	 E8qH/k7/hsk/RF3qbvoavwyuL17GbLlrCyU+7YzdQ61EHOGWKCtUybMhI0bsvL8o7m
	 T91q85AUiTZeiZmnEq7pMcS+5rSRcAWpFhJtqRXT/mYz/Bi7zGNGC/AuraNoQMnBTq
	 FyYxpl8DPOnWIemaxZnlpHuT/AhTETzjwLko+J71Bzr3wODLBVMkYOW5eRfZLOecGt
	 jlBK0S8hxOvvtj+JVF+fqiPZPbm97dPvagupwd9+f5tVqJ8iAGC5ffci5EJC8V27rT
	 vJlROA+aDptSA==
Date: Wed, 20 Aug 2025 17:20:44 -0500
From: Rob Herring <robh@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/9] dt-bindings: iommu: apple,sart: Add Apple A11
Message-ID: <20250820222044.GA1513864-robh@kernel.org>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-3-65648cd189e0@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-t8015-nvme-v2-3-65648cd189e0@gmail.com>

On Mon, Aug 18, 2025 at 04:42:56PM +0800, Nick Chan wrote:
> Add bindings for SARTv0 as found on Apple A11 SoC.
> 
> Reviewed-by: Sven Peter <sven@kernel.org>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> index e87c1520fea60a2de549aa8a469fcded52e3b6e3..95d55ec688779bd52b8aef316a4c1ba7b7449574 100644
> --- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> +++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> @@ -29,6 +29,7 @@ description:
>  properties:
>    compatible:
>      oneOf:
> +      - const: apple,t8015-sart

Actually I take back my ack, move this to the existing 'enum' down 
below. With that change, you can keep the ack.

>        - items:
>            - const: apple,t8112-sart
>            - const: apple,t6000-sart
> 
> -- 
> 2.50.1
> 
