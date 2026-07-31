Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033ED30F92D;
	Fri, 31 Jul 2026 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481145; cv=none; b=tcxi1tiDZCrmYe7hCrUH8KRUk/mPRxNmCn0Ur5NKUpViRb4HRgf5BsJL9EaL7rp5986c/pS2+8cuZ2mriGhesocrcTCiRkzQ+61cnnQWGSOidis8LC5UuCkhTqjq+Vu0ueaHM77wpamsy6aPK5Wn+MERhJz+tz87jMDGqMgQbPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481145; c=relaxed/simple;
	bh=t3fu4ERIgAp3SPftQhcSUQl7vnnwo5MlU0VgTL4EBzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koFjhWLZqx7VqQFL53fCLT6OAVq72uo0Cj9BeCD5+IR4zSBCCseaYiyTWnutXz0jinbmuX3fKWQng3WgNHlgPi+QegAmet78x/goFDIRk6wHDHiKNGrXmh2ata4z847v9xDHbBnjtOGH4ZF44KgaKUtkGkUwrfT/UqRs7ItAjpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFukX1pp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFukX1pp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727131F000E9;
	Fri, 31 Jul 2026 06:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785481142;
	bh=TSAEgxrMlqybf5QIJudXURJtL6q614aZdpapzyJXnNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cFukX1ppkHNLJ/1aKTfYLg9GSZZSV/FFnQ1SsB4u6/pHnQ1onDN6bp/V+1W9c0KRP
	 zP5qq+ZMXGYscUg3ZGOH2IO5hW1c4dN0oiMPn8R+EBKBR21EBb1PMjRXje9OmLVKMh
	 Ny0+qXfNWtHtl1cf7sFvqD64coB2vFIi10F1K8NxmONkp17u2stmHUs2C9NszJz90c
	 FDMKRLQ84NBQbDpz+uG1v/0vl6B5jTO0CT/NsmtX80xDE3gzEUGyCM7xva4VyYRatm
	 ncra0Zp/Y1i3B7ssOcbDnp53JvJDrcyVz3udKLmVKHiZ7HUhgB5+As99YgHcJgL3pl
	 AbqpV1eS61neQ==
Date: Fri, 31 Jul 2026 08:58:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Bryan O'Donoghue <bod@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v10 01/14] dt-bindings: media: qcom,glymur-iris: Add
 glymur video codec
Message-ID: <20260731-voracious-supportive-kraken-edb2fb@quoll>
References: <20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com>
 <20260726-glymur-v10-1-de451559e88b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260726-glymur-v10-1-de451559e88b@oss.qualcomm.com>

On Sun, Jul 26, 2026 at 11:19:31AM +0530, Vishnu Reddy wrote:
> Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
> is a new generation of video IP that introduces a dual-core architecture.
> The second core brings its own power domain, clocks, and reset lines,
> requiring additional power domains and clocks in the power sequence.
> The current maxItems constraints for clocks and power-domains in the
> common venus schema were sized for platforms available at the time of
> authoring. The glymur platform introduces a dual core architecture
> that requires more clocks and power domains, exceeding these limits.
> Raise maxItems for clocks, clock-names, power-domains and
> power-domain-names to accommodate the glymur platform.
> The glymur platform-specific schema have fixed constraints for these
> properties, so the common schema only acts as an upper bound.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  .../bindings/media/qcom,glymur-iris.yaml           | 257 +++++++++++++++++++++
>  .../bindings/media/qcom,venus-common.yaml          |   8 +-
>  2 files changed, 261 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
> new file mode 100644
> index 000000000000..1bb16206d859
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,glymur-iris.yaml
> @@ -0,0 +1,257 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/qcom,glymur-iris.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Glymur SoC Iris video encoder and decoder
> +
> +maintainers:
> +  - Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> +
> +description:
> +  The Iris video processing unit on Qualcomm Glymur SoC is a video encode and
> +  decode accelerator.
> +
> +properties:
> +  compatible:
> +    const: qcom,glymur-iris
> +
> +  clocks:
> +    maxItems: 9
> +
> +  clock-names:
> +    items:
> +      - const: core_iface
> +      - const: core
> +      - const: vcodec0_core
> +      - const: vcodec0_iface
> +      - const: core_freerun
> +      - const: vcodec0_core_freerun
> +      - const: vcodec1_iface
> +      - const: vcodec1_core
> +      - const: vcodec1_core_freerun
> +
> +  dma-coherent: true
> +
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: cpu-cfg
> +      - const: video-mem
> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 2

Rob already commented on these. And then he clarified, so you cannot
send the same code.

Best regards,
Krzysztof

