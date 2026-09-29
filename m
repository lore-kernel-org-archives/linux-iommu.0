Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3975380FDD;
	Tue, 29 Sep 2026 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669806; cv=none; b=iBaRVJYdvPmj0PKYMT8TZIAo+EQzox604hcHHX4Dl4weJEIeaNp6INYpDvhRc71/A9KMLuUByVbltyO1WgBwXD/rV1YDqQie+YfP7H39BM+zRgMQGw1QbTikex/F9CIHeXn60ZWUObTrLeEI2pPz9oyQYLtleSNAo806vkvVQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669806; c=relaxed/simple;
	bh=oyCimMHR/llud5W7qNa07iP75A6clWh7YgqixViNa3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/l289VLMVWLUOL7Bcp7J8MFjD2yRii8dm/sgTyoVWSrCBsBcJEVYKV/jhV05HrZ/u3cLCl6lAAmdbX+2xZP7JXBRpn7SFuHVj/L8Hgiyk5jivnBtxtG243nX9B4ARnXuiisoJMoMze2zutgpKgzUci1fIvToGorGwZ/fbkap2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3CPe98N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3CPe98N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A7D1F000FF;
	Tue, 29 Sep 2026 08:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669804;
	bh=FXGaiD0t1LmHxEN66KA1O49FI312SmoXeAH9OHpamW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T3CPe98NVW/8EygC813eAT88KGlltDJPKBv6AU3tOdukWJdV/IP6/5l0Su1PQV5dn
	 C0/RI8sHigLqw4oXC/lv0mLPGBtYurFgbEiTn5yxbkh9U5oegoe9TGD97aeNvxvNSc
	 7p1DuWayxD8xPfwMoDMvnFlyBIZBhrwSLWYoKxCkfB/DUopjaCFtUhymQZSiix2V1m
	 Z/aBb+AvjsocSWNBYP9prkhhmRWynH/aF4FG4XeCc+WSj+QX1AT0KvIEZ0FJOhJJ1c
	 Gq64LPqK1RGgr8kd+TNUIGNvEUdfxV7pm/WghsA599xnx1gvWpLViiinK9sSEf+j8f
	 naIUsr+kC4JrA==
Date: Tue, 29 Sep 2026 10:16:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev, 
	Michael Reeves <michael.reeves077@gmail.com>
Subject: Re: [PATCH 3/7] dt-bindings: iommu: apple,sart: Add Apple M3
 compatibles
Message-ID: <20260929-basilisk-of-marvelous-fame-a0d58f@quoll>
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
 <20260925-apple-m3-nvme-v1-3-5e832e2f4aa9@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925-apple-m3-nvme-v1-3-5e832e2f4aa9@jannau.net>

On Fri, Sep 25, 2026 at 10:22:50AM +0200, Janne Grunau wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
> 
> SART on M3, M3 Pro and M3 Max/Ultra is compatible to SART on M1
> Pro/Max/Ultra. Add their per-SoC compatibles "apple,t8122-sart",
> "apple,t6030-sart" and "apple,t6031-sart" to its dt-bindings.
> 
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/iommu/apple,sart.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

