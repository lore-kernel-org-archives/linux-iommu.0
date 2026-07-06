Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6526C3DEAD2;
	Mon,  6 Jul 2026 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321011; cv=none; b=tihTGYeGSqdEq3gTaWFr7qE8LjAhfLl8J900QdAJwiPg6exl4s5jXcDpUbaTrOtM5mg1snpR4PvI2LNHGYsG7/F6uPf7u+2JS0bCWkK5noVrX0yavcG18yXfuM1FzfFyMxpAYV8fPEI4sTv/sytYfH5CY6+bKX9zmaUKIXFAmEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321011; c=relaxed/simple;
	bh=kPDZpccy4ZyYKweUh7fJbdPTLlJSBWzM2hB/tU4HKhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKcTW8gVzoiDXl7Ad/CvVqXbbsjDe2tuGV0GozJWnRF8YUly0D63HvFdIWlq07SgBjrDnfnBu8TjYGK5vomfHVe1dFHBb89rXOpBiDOXu0hXKmAuOgVKKaccRNfvOim8oMJffYPej/Alo2kJH/MFySf9M02R7pAIQ00ExMmivHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ2qDUgj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ2qDUgj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA501F000E9;
	Mon,  6 Jul 2026 06:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783321002;
	bh=6UvsdoJ2FUgLr9sdil9O7uR5TP3u8LCrzHRnMzjqw2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iJ2qDUgjnu/4u0aM7/x9sq28AXbSlVKIzLzJbI+jchuUgJ88fCvmroQpMdrDZeq7j
	 ODPItrIykgUXQqk4TIBlpM+17hvIxPvywC+ikLXeXC4OtLXpVGVqi9C2e7tThr+R50
	 FZuctFGjAKgoaJJFz5jNpj0xbR0r3++3ljHxyFFHTfsetGx+zKilB2PKVLyZRV/Mch
	 B3Uzl4PL25BaSMpKE+amwKND61FgbsOuuJ+ZpWZw7bnjS7r3jaqShbi2NaOxI7Fzj5
	 zqT/tznJKsQku24GAjANskpz4Jex4Et8LwcOnL4rFMfBQLY0oGTrYJ8UPyg4b/cNC8
	 uYNDx+Po2h7Vw==
Date: Mon, 6 Jul 2026 08:56:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH 4/8] dt-bindings: arm-smmu: Document GPU SMMU for Eliza
 SoC
Message-ID: <20260706-judicious-tasteful-crane-5f7455@quoll>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-4-c9f1354dbd29@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260705-eliza-gpu-v1-4-c9f1354dbd29@oss.qualcomm.com>

On Sun, Jul 05, 2026 at 01:44:19PM +0530, Akhil P Oommen wrote:
> Add specific compatible strings to document the GPU SMMU present
> in the Shikra SoC.

s/Shikra/Eliza/

> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)

With above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

