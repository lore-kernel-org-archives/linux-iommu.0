Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AAF3AE70D
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486530; cv=none; b=K6mDPEaoxz1liTqk5Q3o5E9aleWu7bPcEvftu5OWQdxM8TEnsDdibZ0YaBnE1gSePZ98U84varDAGcy6ylhPbXdqdtt8diC+l/ub0lS4rYjv0xGb32uivZE5W+JqD+inMaE8EnwQguNsDnJYiP2JTr5JEnwA/bV6UIxT0sVxxrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486530; c=relaxed/simple;
	bh=C4+jOE7NnKqR3CmE/a0VMxJT4JgooAYRBeQzipN8SAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdq7U5TA0quOyTQZlbBScdlS1CEBHrskbzayxVZBYYjRGeNp7eJifmywy1nHqs3uxvwlBJTGXAIG8SzaZHiyrcpSI+MPN+1MeJdip75NiHfmMoLQrHLJopUy8Phmrn5tVapTDNhR8OBzokZwvkV9czQIWGCy5iXmOeU+WtrfzSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=lHkPDpLO; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="lHkPDpLO"
Received: from 8bytes.org (p200300f6af1d9600f5faa5cebd6c042e.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:f5fa:a5ce:bd6c:42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 723AC1C41F2;
	Mon, 11 May 2026 10:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778486521;
	bh=C4+jOE7NnKqR3CmE/a0VMxJT4JgooAYRBeQzipN8SAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHkPDpLOV9pYetKrrbAwRHCkzRl6i8mpLC6SS8PPg0h7g0QdV1s/ZQie2S+0lr1yz
	 Cc4DXNqfNTWcrDPeR0uwQHZIoJ9wLPiLX5knWOOdAbrUSWERFQW/VtVdFU4Wg+WKUG
	 sCwYDeh3if9B28GGoTCzG8QFUL8bThS1lWi7WviANes8QwJjxBgoQCRPKh2Z3HInWS
	 f6B6aX1MnPCniGWkMaPdJR7bMpj7OeECgY4gVTA2O0toQlILbjpE+Qe8pYkjFyo00V
	 vU1r3i6U3U+aFFjIOsIlCgKFL8a75vbjbD8eC5+3NLvH5B/WwlwI4m7T3fIeDg/pR9
	 EgAPWkXCqYuCA==
Date: Mon, 11 May 2026 10:01:59 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: will@kernel.org, robin.murphy@arm.com, krzk+dt@kernel.org, 
	conor+dt@kernel.org, heiko@sntech.de, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v14 0/5] Add support for Verisilicon IOMMU used by media
 codec blocks
Message-ID: <33nsz23rcstwznq6dnsuibndbwtoc767evshltj35kgysdg63r@fxhwobu53cww>
References: <20260415072349.44237-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415072349.44237-1-benjamin.gaignard@collabora.com>

On Wed, Apr 15, 2026 at 09:23:36AM +0200, Benjamin Gaignard wrote:
> Benjamin Gaignard (5):
>   dt-bindings: vendor-prefixes: Add Verisilicon
>   dt-bindings: iommu: verisilicon: Add binding for VSI IOMMU
>   iommu: Add verisilicon IOMMU driver
>   arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588
>   arm64: defconfig: enable Verisilicon IOMMU for Rockchip RK3588
> 
>  .../bindings/iommu/verisilicon,iommu.yaml     |  71 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |   8 +
>  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  11 +
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/iommu/Kconfig                         |  11 +
>  drivers/iommu/Makefile                        |   1 +
>  drivers/iommu/vsi-iommu.c                     | 796 ++++++++++++++++++
>  8 files changed, 901 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
>  create mode 100644 drivers/iommu/vsi-iommu.c

Applied to the new verisilicon branch.
