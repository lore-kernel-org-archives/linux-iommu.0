Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C73EFD36;
	Mon,  6 Jul 2026 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321050; cv=none; b=pQY8CIMZeNEf0hCgz2iCA6zSnJ82CzWOyPuZYK6xScf0d2QQOAhnUm6ej1CGPbrMly/KJrdkX4Zfhc2pr08ykUzKon3GqVg6YjXAZIeXxk1tbGktvLW2HGf2nVaEishQZH81oDBiri4o31KfWELKjLF2LUS26PXkYjbuwPjRWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321050; c=relaxed/simple;
	bh=GBnJ/HGn063WC0vwh1cPovUlxJPS3BsBDjn5dNWiSBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYgY2q92pKPqA9D6xa6fvX5mQfl4YWJqTZKH4n0YlRnlxqAur88M2bVGz5Rq2g0M8i1hshEAOt7G7qxUASTP5aUuYaFLq55NVFYF4t1fK3+XUOHaO7XIeijLP356ZNU3pOV3D1Nhvqhii5iiZMHdHFp/qSeR/Cjlrv8htdnx5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kpry7HAx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kpry7HAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6CE1F000E9;
	Mon,  6 Jul 2026 06:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783321037;
	bh=IED6QZNQ0APBb2RT+lZieni4CjI0wDzgvUKFq8gCmw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kpry7HAxYLJsH0ML10AxcMpo8KxAyeapJlQMnPgDFWzIbZH/IyYsGX/Jj/Bpb6iPD
	 Ziaw8VqdWNEuZEhsltRuIeVVRYzoNMX33u3oIjvMHufuOfIhqTq4dfcd9tBhgsjnni
	 CJUYqKnLZgdhYIZoLUaYz9GHNPCUMH1ARtay3rHOC1ZsRgTnrkoOTsFeMqUX/JuYw6
	 TbomheDZUMqTjhi3+bu/Yn8UmPoRdtJW0y5Tfcs2Wxagni8AsEyfDERXnaNY5UzHHI
	 bU+OGc6qo0OrhxGDxB7SMTUZ0Lhy2rIsHKM9JEs5yHBDyi7SGKwPmASlXTT8S3qo4A
	 vIITuQM52GChQ==
Date: Mon, 6 Jul 2026 08:57:13 +0200
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
Subject: Re: [PATCH 5/8] dt-bindings: display/msm: Document Adreno 722 GPU
 and GMU
Message-ID: <20260706-attractive-flawless-otter-fdc7d7@quoll>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-5-c9f1354dbd29@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260705-eliza-gpu-v1-5-c9f1354dbd29@oss.qualcomm.com>

On Sun, Jul 05, 2026 at 01:44:20PM +0530, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> 
> Adreno 722 found in Eliza chipset belongs to the A7x Gen1 family. It is
> derived from A730 and shares the same IP-level configurations: HWCG
> registers, protected registers, GBIF CX registers and gmu_cgc_mode.
> Major differences include lower cache/core counts, 1MB GMEM, no
> Concurrent Binning & LPAC support. Some of the peripheral blocks like
> RSCC are from A740 that resulted in updates to RSC layout.
> 
> Update the dt-binding docs to document this GPU and GMU.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/gmu.yaml | 1 +
>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
>  2 files changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

