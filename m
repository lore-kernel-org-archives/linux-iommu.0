Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D83F39EC;
	Mon,  6 Jul 2026 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319834; cv=none; b=U7T8M9VjuxE8+72dMucv0vOUPDJ4ZgjbMjnEj4ZHJgCryEDF9DudnuxNFs3FgaYmQViiZf94GApO9McyyLsgRl+Q4daAzH5xdc8YhDHqjkctwWjiaEF4HbmRoXpAbY2Q3ZPFWNmG5/DV4/A7c4dWesw63wPi/JFyQfm7fSIrA8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319834; c=relaxed/simple;
	bh=Cbmd9UKW9dfTZvnIA7DiY3dYQGgOF0WpXubmOAH8XcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1LCGA8+09q0DzVhvfxmzZvxcoTjDMBk8LhnWhX2UbUu59duPuEF9soKDOTDvDUbh/Go29/lvvXtgpkYgcMyj8n6KIoqe6aUQNR/0Zyr3y8UZf3fIyxXhcxSFPj535VN8pId4abI2EFEUy9iwCGFiV4LhP7G4OYpqchVe2fjEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljqRKau9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljqRKau9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7465C1F000E9;
	Mon,  6 Jul 2026 06:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783319816;
	bh=DgG06+fPhBUefxG+g15sZ2YExh0h/ruMjb8SnPH6H+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ljqRKau9DCFpA3AklvnxUyEXQF+DlQ4bo0jmiHb9FTBi0BiNyfJlYGIAoZKmmV1Rd
	 78hccCK9z0lFtUb2/08OsSZNR/Pi5+h/5rLi1hpnrxlMtDgVjOjbPjDIdKLjtaahIU
	 GpIZyvi3nllQMc/bgvupFzCbkdpIl9wlgqyHvtWeh4fqfkOquRJ8EGp/Qvwgl4xxzu
	 3O5NWIkBJzsu+bWpTPQjhXAa8IUEwO5O2xHAy4S52J3Ys0V/u29PSPLAcMu2RPUsyE
	 EwyFBcFZXGkNSl6z7c/nlw8dmQ40+1esWLB8jmB4ETd0kbE9QCw+0B30vYu34Ozvdf
	 2NdYKatgV9IWQ==
Date: Mon, 6 Jul 2026 08:36:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sean Paul <sean@poorly.run>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/8] dt-bindings: display/msm: gpu: Document Adreno 840
Message-ID: <20260706-radiant-shark-of-calibration-ac2d13@quoll>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-2-6ac53de56314@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260705-kaana-gpu-dt-v2-2-6ac53de56314@oss.qualcomm.com>

On Sun, Jul 05, 2026 at 01:30:06PM +0530, Akhil P Oommen wrote:
> Adreno 840 GPU found in Kaanapali chipsets belongs to the A8x family.
> It is a new IP which features the new slice architecture with 3 slices,
> raytracing support, and the highest GMEM size seen so far on a Snapdragon
> mobile chipsets. Update the dt bindings documentation to describe this GPU.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

