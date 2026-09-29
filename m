Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05948374A14;
	Tue, 29 Sep 2026 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669841; cv=none; b=YpLCTB4zrqAU1e4Wdl0P8Qxh3LAxZPGOr6ysG313YggkF1byrYqWDJLNDZeBkt/NyvIbh6HT+F8lwPPvzOvUn+zARp4vtwIok+i9tHwGo2E1ObM5RDb/SZYaqNMipEVa5oICqnrmQIfYtBe8iZOJcBpkZhor1jfW4ZXYV6ZOEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669841; c=relaxed/simple;
	bh=lnF5tFypu+F3wl1Ds/5DQP8UtYYEHrvBTYAfE6PBeys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL72ztkGxSSIKRc3lvZIhYiJAyUQb96ACm6bejyLO88gFkjed/0ezmadhbkZ9rF+3Q5w35TKqJDApSW/MO0RGYjIzT1dmES3uwxf87CKHxndWIFsA08E/eWBLmr7neY3MrWBM8b+ATF1gZtIJgMVnspuo2DEW6DNXr0/j+Oj3UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smq4C7Ca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smq4C7Ca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2EE1F000FF;
	Tue, 29 Sep 2026 08:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669839;
	bh=eZRHw7RgDM0zXXk/3KIjBq2VdWFLOso3NRavH42G174=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Smq4C7Ca+4ynJlgInChrfWL5g6vVLyXTAdOldVpbtYHYUKmXK4S1r2y0Ic81bSs4S
	 yaE/xL8/0yxVtokrrL7RKm7vf2hvYKhqcGriaEgb+v3Kmoi7rjQvL3XZOQxUMBUNuR
	 SpJzfo7htNlQXDmFwLG/oP+xUC/yWyQYjLkFNpIveYRQpQMz+MC6d98Fs/sRnOpFMN
	 fyjHVeLB+3HtMmT085eKJ+0qjuK/GuVA+1nz5nsA/FTcoBOq4ZcpRWKxGHw1557QJm
	 QjaMVVUvKWNsqqXz9LP2ute7BgRAEuekC+0yAeigOZurKZbHREeLBM4ne3JdiHZ01G
	 ziAFOvqHDZ6Jw==
Date: Tue, 29 Sep 2026 10:17:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 4/7] dt-bindings: nvme: apple,nvme-ans: Add Apple M3
 compatibles
Message-ID: <20260929-illegal-international-guillemot-1dbbab@quoll>
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
 <20260925-apple-m3-nvme-v1-4-5e832e2f4aa9@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925-apple-m3-nvme-v1-4-5e832e2f4aa9@jannau.net>

On Fri, Sep 25, 2026 at 10:22:51AM +0200, Janne Grunau wrote:
> The ANS NVMe on Apple M3, M3 Pro and M3 Max/Ultra is compatible with
> with the NVMe on M1. Add their per-SoC compatibles
> "apple,t8122-nvme-ans2", "apple,t6030-nvme-ans2" and
> "apple,t6031-nvme-ans2" to its dt-bindings.
> The NVMe on M3 Max/Ultra uses 3 power-domains so add it to the
> power-domains conditional to change 'minItems'.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

