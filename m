Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F62031A068;
	Tue, 19 Aug 2025 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595137; cv=none; b=EHhqXSFAuQjPgJydT5eTpJb29CG3srKBN0Jkkvh9TgNHpUmoNi2bLsbSo3duW74czJV3WNpFICa5Cfvy8IE1RLA1N8baF8W/JByZZFlqPy7KFeEwoAT+vNJAIIuz0J+7JJr11QqH7aunZJG4nQrZaik2I7QaQKtSiv3xyfXPFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595137; c=relaxed/simple;
	bh=WE8xKTIRA1LGG0DwAxRK64uxUZcadJaYjOQ4rCBYnxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaiFdk0AL9VaTp3OQi/1GaXW/GTYdJL8lx6Vr6W0/Ul1ZspcdGDmQ2/o/gs/obfycPRn50YpYhsJT4s/BMl4glGjZyFTcN+GpHcnM1hgz/5lrY87EAmsVubdN0IPwTT3SfB8lJnrEyLbOe960A0nUw5nvgNi1fnYbadE8bPRozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKwOCXjG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKwOCXjG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0DCC113D0;
	Tue, 19 Aug 2025 09:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755595136;
	bh=WE8xKTIRA1LGG0DwAxRK64uxUZcadJaYjOQ4rCBYnxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKwOCXjG4KIRJxgDlrsIKTTiaDCEjfwXzD7R6W9dL+Vj138hCKhIcivtdFEfrLWY+
	 zV3NXLqlASbFhj/k7b3YwRrDAl/WazGaFhUy3fV48/haFnBtqgMqbPbxqEcG7D5jDu
	 tkVlz0C2F218z8idseR3Op/HSEuNQy32gK8xC4vFeDqK58lacQeXMAarNZZmYaItws
	 qq2ff6loPEMNutxw7ju0TQaFMjfb8IpH44XlP+9goTQRaIYGTxqI8wTwHfmUjnQaUI
	 cpVNc1pLMovcTQXufxVFE+99vJLaZFWnfYEOueduj40Tnl+1lTDdyDGZUnVRrDYYr0
	 EueGu7VP4YK3g==
Date: Tue, 19 Aug 2025 11:18:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
Message-ID: <20250819-polite-papaya-catfish-1a9d1a@kuoka>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-6-65648cd189e0@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818-t8015-nvme-v2-6-65648cd189e0@gmail.com>

On Mon, Aug 18, 2025 at 04:42:59PM +0800, Nick Chan wrote:
> Add ANS2 NVMe bindings for Apple A11 SoC.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
> index fc6555724e1858e8a16f6750302ff0ad9c4e5b88..4127d7b0a0f066fd0e144b32d1b676e3406b9d5a 100644
> --- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
> +++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
> @@ -11,12 +11,14 @@ maintainers:
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - apple,t8103-nvme-ans2
> -          - apple,t8112-nvme-ans2
> -          - apple,t6000-nvme-ans2
> -      - const: apple,nvme-ans2
> +    oneOf:
> +      - const: apple,t8015-nvme-ans2
> +      - items:
> +          - enum:
> +              - apple,t8103-nvme-ans2
> +              - apple,t8112-nvme-ans2
> +              - apple,t6000-nvme-ans2
> +          - const: apple,nvme-ans2

When some months ago this pattern of generic fallback appeared, I
believe I commented it is bad idea. So now months later we have a proof
- generic fallback is useless and you should have been using SoC
specific compatibles from the start.

Now it is just confusing and this broken pattern will be spreading more
and more, because you folks put generic compatibles everywhere.

Best regards,
Krzysztof

