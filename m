Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A84A8A11;
	Mon, 19 Oct 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401247; cv=none; b=iQ3rdCi5zz/K80tNwY6afFcKRi394DJmGlPhSimxs/CSNNKKHsUHzbHLN6Jx34+kox7BScuyQiNjZ/FKsdo25OxUlq8LU/6MqG5YFtbmA2j9Uaw7R4tmNrwvNlzOgi9Z0CREQqaNWS+vSzzL3mOUSOJ3MOPlVCMUsWQ83mq8Wp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401247; c=relaxed/simple;
	bh=3W4cAYwZGz92pNzMK9iClEcu7WJT2sBpKNAlQk0Ebms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXC++khBht1aULS/ZtB9ThCf62LzmhCrgY3V/2W98lvvxjfK0glxGQuuZBrX2rRxEUTbh3oP58go8/3fjMHlYwy/EqNAQVq4iioNIT9LAT+otvu6P5ge3z1mb2ukvt/BbnbYHtBByLci0Uf/uFlJiYQeplPaaSZMTnrNVSXcw/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B36kJOtW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B36kJOtW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3641F000C5;
	Mon, 19 Oct 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792401243;
	bh=p193/eXdAlpEtyVeP9Mx6DfUR9LJvk6PjfiJHNyehUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B36kJOtWjlEI2DFQu7ZOHAK8nVedVl3ufY729WsU7kCBUl5lWX6ao/0kN9ifxnwii
	 fMXtzCaXm4ugTlc5B+WeLqbgr/9t5D8hadTxTECh+h1aUX0jxM35XJ6iadjbxFaxuX
	 pbpUsOdC2m0DeThHEp7OYR3YBFOVHZ6TvzERNwf9XjEez1UTMXg+r7+D/tAbopHg+2
	 U6l20LwGnHAKpUiVgLc6YCXOJTf084FOQJgVcTKI+WBNaTOSEPUUZpkWR2unf+kXeZ
	 zQyvzSM4t0oFIXNJSg8QWKamAom9bL0L29NOsWYw00/pMT7+j7KmwMhLWNhAFngOBJ
	 eZtQ15hFk/AsQ==
Date: Mon, 19 Oct 2026 11:14:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iommu: apple,sart: Add apple,t6050-sart
 compatible
Message-ID: <20261019-terrific-attractive-goose-d375b1@quoll>
References: <20261018-apple-sartv4-v1-0-1eaa5d63f6a2@cyberchaos.dev>
 <20261018-apple-sartv4-v1-1-1eaa5d63f6a2@cyberchaos.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261018-apple-sartv4-v1-1-1eaa5d63f6a2@cyberchaos.dev>

On Sun, Oct 18, 2026 at 06:38:10PM +0200, Yureka Lilian wrote:
> The SART4 is on Apple M5 Pro/Max (t6050) SoCs. It has 50% more entries
> than its SART3 predecessor and is otherwise the same.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  Documentation/devicetree/bindings/iommu/apple,sart.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

