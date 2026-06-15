Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C442F83A2;
	Mon, 15 Jun 2026 06:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781503390; cv=none; b=D2acaFv1f2NUveeiHoSLk2TwHTP9gcHDk8CsiDicV37D7qAbHU0sS5FqVxhYly5o48dT1+TArT07lHaaLNjEFtrrFricA0Hz5//whrvbOZ68auSVHd4xRXlQtpQEHwVtLM62wVpa4uKKb/J5X/x9yPAdlJQi4npwGETa1gATveg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781503390; c=relaxed/simple;
	bh=Z+fkan5wigI8iAtffGnN82eGFFsPPZ5SA5LYevo1zKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cO5zfEFXhgspJVf0+NWb+Rxrxw+0l0CT+Ks769hFvy/1NKK0rBVS1/koUekC38K/G01Pwg3rV7gbQEP6awa0t1I3LqGjZDx2OsMVdG6SuLWxyqxVlUdBuXAP0DjmVGX9sRdDABB/78IRblbneN55AJfMiZ2xLosgcoSp00LOnCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeSMN76Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeSMN76Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF33D1F000E9;
	Mon, 15 Jun 2026 06:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781503389;
	bh=NH91vhgtpim2mvTKLEXlcggfytTmn9NzXEfuRjaO5Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oeSMN76QlgQpFNDQ9ZPs97txznTmGvIYY10j/7nHqew76rsgUzAdF3HKX/zNtettd
	 W96YkR/xavSqS7/9H5conjE9VOzTCZaUQN2aZhs80VnT8sj/EvHMTi716P8Q0B8x8h
	 rk6zLDKBnSylGlM+U7txGlav+5I7I8TlSndqWzW3jLspx7NnFgODc7yxR2NlARYukm
	 30Kfa6fhqS0jGn6tpUX94n3t6xh/FycJl1CwOJPSvWH5tU+Qm8AEzZTrRZnIfvfN1i
	 C7K8cxTIQ77oKFV8XecAv/hdwlNGncM/5yX3uCiUfW9RNQOKRwvTQAa7OxzUTD4te+
	 7UPX4idfRPqew==
Date: Mon, 15 Jun 2026 08:03:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 3/3] dt-bindings: arm-smmu: Document GPU SMMU for
 Shikra SoC
Message-ID: <20260615-quirky-horned-chital-543dce@quoll>
References: <20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com>
 <20260615-shikra-gpu-v2-3-2f2d1347c3fb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260615-shikra-gpu-v2-3-2f2d1347c3fb@oss.qualcomm.com>

On Mon, Jun 15, 2026 at 03:02:59AM +0530, Akhil P Oommen wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Add specific compatible strings to document the GPU SMMU present
> in the Shikra SoC.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

