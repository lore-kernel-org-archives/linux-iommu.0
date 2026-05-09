Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AF51A6836
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778349407; cv=none; b=Vpgu4LieOXJIGVCQNjMjETP16Yg0CysU/kcc8+Jl5SnK5jh+YCmx8VUQPI7jFLuFewbLV+NWHNS8dpoMJr3SKH7k5aZ7a0ikdbzv62M8dIWjgmrFn4nlOaybQcWea5AobJa6ZCMGm5p2GqiwuYDL4gBg5n6BB3+2EY/uAHlTXuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778349407; c=relaxed/simple;
	bh=6Dx5Ivk2dUgZlsc0ikWY+XsRb81CBEQG/iCXu/vtNQM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=aK84b5E8/IExmlvEQlSpt05BjLLeREjhjGNRtk5b7Y0braHuV4i45CNKV09SpdWlK+rT/wmGwauiH5V04NxWXS8hjxfZNagQVO7nMnZcCzT5MRYnKPfIwyr+XIOWIbF5waq1huCSMinvhK9HNGqpZObPFAv7HNnVtPIqxEAE8L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=MPD2dCcm; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="MPD2dCcm"
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1778349401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIh60pxxvGKOUsnTbxcu3v39dVCI3FE1FnfA1fpg1iA=;
	b=MPD2dCcmz3mdk8VygCqc9i2PHEr4TZNN9lNCBmKzcxGHZ+eWZ+AuNUgrvZXxXTlqHwdXS9
	wx7CycvLytT3JhZ8axiRlRYLDxxuoBCb9qD6djOQe+86kK2bCeo2lkFLpN2ANV14xXjT5L
	pccNsYyuvstsAo8Na6Faab8YRnpWDwwQpJt6sZrpMXFeH8uMctcmAa8SdnZSDwRZVDWHNz
	5stVLgqHcGfEohu6HqOjmJCrk4NLHKgJgStX+NCXk7IrOF2T1yy3icRH7qmwwqQRarbgIc
	+YLJyETMWPEFvHAQ0fNd05zlzs8yF8Jm+fQHZZkxI7FhRkPx32RcQfdOaOIw2A==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 09 May 2026 19:56:37 +0200
Message-Id: <DIEC8YT0XK4O.VAG6G4H31KJM@cknow-tech.com>
Subject: Re: [PATCH v14 1/5] dt-bindings: vendor-prefixes: Add Verisilicon
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Benjamin Gaignard" <benjamin.gaignard@collabora.com>,
 <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <heiko@sntech.de>
Cc: <iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <kernel@collabora.com>, "Conor
 Dooley" <conor.dooley@microchip.com>
References: <20260415072349.44237-1-benjamin.gaignard@collabora.com>
 <20260415072349.44237-2-benjamin.gaignard@collabora.com>
In-Reply-To: <20260415072349.44237-2-benjamin.gaignard@collabora.com>
X-Migadu-Flow: FLOW_OUT

On Wed Apr 15, 2026 at 9:23 AM CEST, Benjamin Gaignard wrote:
> Verisilicon Microelectronics is a company based in Shanghai, China,
> developping hardware blocks for SoC.
>
> https://verisilicon.com/
>
> Add their name to the list of vendors.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index ee7fd3cfe203..ebd9072300a8 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1761,6 +1761,8 @@ patternProperties:
>      description: Variscite Ltd.
>    "^vdl,.*":
>      description: Van der Laan b.v.
> +  "^verisilicon,.*":
> +    description: VeriSilicon Microelectronics
>    "^vertexcom,.*":
>      description: Vertexcom Technologies, Inc.
>    "^via,.*":

FTR: Another version of this patch is already present in Linus' tree:
c131d78840d7 ("dt-bindings: vendor-prefixes: add verisilicon")
