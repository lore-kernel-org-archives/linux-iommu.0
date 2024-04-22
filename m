Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9FC3CF65;
	Mon, 22 Apr 2024 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796386; cv=none; b=O5xAo6dtfla8y0yWfLuNRBPHL9lQAZxDCixS4CGY+DHI0itLHlPNPekUt1w/58DRAjS+jXpHHKfUrzNcifSDjtJbdEXvzGG7pBOGYqWZaXMsDXkDBUx2Xt705P3BGZCb1xnV4y3K+SM/sHWDvzR62NTb+IZUGxtFrxjzNbXrRJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796386; c=relaxed/simple;
	bh=Eslal+HkCbJOCCz+07WuKpSYvYcwfVTwjLdnrpVYsxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyFEGLScx+Wb75GhpLojnXbBRNCfcaIP961CLDd+Pc3WK/ZzCfj7FEkkAVGzsy6Eq6ErsVATgpNTtGNBju4jgHKMaLh+NDIwSQKd8k0tW63APDXZHHRecBQtuFOd/9RTyguqNwi47b4cjLc9Ltd9tZpfCmZtSLxFI7ENx7dIeow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3PdjdIs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3PdjdIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836CAC113CC;
	Mon, 22 Apr 2024 14:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713796385;
	bh=Eslal+HkCbJOCCz+07WuKpSYvYcwfVTwjLdnrpVYsxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e3PdjdIsdNmjMSThGWwW32F9JlSsGp99LHumKwAINAzsjBzBghLuTB8TYBV5jMXky
	 SY7ZIv9r5Tcun+gvb5SToul5QsLu003+Gn9RXT7C7LrPocI2jfNM34ffJ3BMdbkhNX
	 Mj/O4O5SbBqrLrPACmEbnyCJFk1/4G7GkIkfBH6iTY2rDbV/1wtJfc6ZKcNJicQuOV
	 4xxqVGYFD41GstWDqgZ6h7y/Si+iWXGPaiRvqgWaB5NaWE5vYGPla4HTKAjVw3DNSb
	 AP9ebutqS0CHngVvTb1rI8aXTxtLDyWkK43LIXRQhfP3ye/csHmcilzyGXKJdbaBoS
	 wn4jRCJGUrHxw==
Date: Mon, 22 Apr 2024 09:33:03 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Will Deacon <will@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Thanh Le <thanh.le.xv@renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iommu: renesas,ipmmu-vmsa: add r8a779h0
 support
Message-ID: <171379636788.1217601.3918831043392288178.robh@kernel.org>
References: <13643259be4e8a8e30632de622ad7c685dbb7c61.1713526852.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13643259be4e8a8e30632de622ad7c685dbb7c61.1713526852.git.geert+renesas@glider.be>


On Fri, 19 Apr 2024 13:42:11 +0200, Geert Uytterhoeven wrote:
> From: Thanh Le <thanh.le.xv@renesas.com>
> 
> Document support for the I/O Memory Management Unit (IPMMU) on the
> Renesas R-Car V4M (R8A779H0) SoC.
> 
> Signed-off-by: Thanh Le <thanh.le.xv@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Interestingly, the IMSSTR register is documented for R-Car V4M, unlike
> for R-Car S4 and R-Car V4H, so the second cell of the renesas,ipmmu-main
> property could be added again.
> As nothing really uses this register and the associated bit numbers,
> I think it is better to keep it simple, and not partially revert commit
> b67ab6fb63bbbe6d ("dt-bindings: iommu: renesas, ipmmu-vmsa: Update for
> R-Car Gen4").
> ---
>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

