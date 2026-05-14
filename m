Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA93909B1;
	Thu, 14 May 2026 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753615; cv=none; b=obtFZtIg5aeSOgNp2ZhsYu7i09NCFPDwsFq7wyhy7bK7Bvp80IoFHqfv6N0JgVbRuNWUt/PBj3yXLCYwNAjRPBxgpLvPgYqRZJzEk/O1LdNYpbJ27zCkr5G7sALX8mnfszgx62wrFAcVPZ6Iso2Oz3w/4kShY4npzMJqVU2/o1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753615; c=relaxed/simple;
	bh=rXQRhGpz7xYtLzNL2vzAmJA6KRx3QEVri+tj58EgfE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIha/bEx6adRBBoA7bYOWsmZ9+4tcJOC1KgV3ODWRwHh2ENiE0xfEWpIThhTOY3iSM9DT4yJOSK/x0NG7JZvnXtRyecoZOzLCjgpZ2Q6mvNBHv3NDuWUcvZo+F4o5yzZrt1+bfmTVdwFrSnFSzwk+64UDDV9cDvDWalTvOd3PPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0UwHvR9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0UwHvR9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F252C2BCC7;
	Thu, 14 May 2026 10:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778753614;
	bh=rXQRhGpz7xYtLzNL2vzAmJA6KRx3QEVri+tj58EgfE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m0UwHvR97FgarFPgSNeFKajHCBU+IEAAsdsnq/e9ocLHGoitfmub6hWS3DIho8g+t
	 5AU2BZxmqbce8svlzVZZy/Br31Jqm7wr86A15XvyICMw4Gw18J/bldZsKDBzTlh+ol
	 Zik6DUHnt222yezt+2tFldhfB7nryMAKGgSuhOup+z2jo4KajZrcQTqazf51g35j5p
	 7QRvQKV2L332hBjRdNxTGsMq8mAlg83W1anSHgfspf4MM26I4U5rovJZTZh6VUfv/E
	 fDG15RGre0zeEFreBl6316FbSn0Rr89LsOtWJBDFHCRAQSpgwJJnNXFtlDxeeqIiOj
	 OFmUDRQKnzT7g==
Date: Thu, 14 May 2026 12:13:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v4 2/6] dt-bindings: display/msm: gpu: Document Adreno
 X2-185
Message-ID: <20260514-pearl-mamba-of-inquire-e4888f@quoll>
References: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
 <20260513-glymur-gpu-dt-v4-2-f83832c3bc9a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-glymur-gpu-dt-v4-2-f83832c3bc9a@oss.qualcomm.com>

On Wed, May 13, 2026 at 12:51:19AM +0530, Akhil P Oommen wrote:
> Adreno X2-185 GPU found in Glymur chipsets belongs to the A8x family.
> It features a new slice architecture with 4 slices, significantly higher
> bandwidth throughput compared to mobile counterparts, raytracing support,
> and the highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among
> other improvements. Update the dt bindings documentation to describe this
> GPU.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Someone needs to start applying Adreno GPU patches...
https://lore.kernel.org/all/20260301142033.88851-2-krzysztof.kozlowski@oss.qualcomm.com/


> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> index 04b2328903ca..e67cd708dda2 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> @@ -411,6 +411,22 @@ allOf:
>          - clocks
>          - clock-names
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,adreno-44070001
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +          maxItems: 2
> +
> +        reg-names:
> +          items:
> +            - const: kgsl_3d0_reg_memory
> +            - const: cx_mem

Are you sure there is no cx_dbgc? If not, then just minItems+maxItems
like for 'reg:'.

Best regards,
Krzysztof

