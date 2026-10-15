Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819393DAADE;
	Thu, 15 Oct 2026 10:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061558; cv=none; b=g6gCuPouF7Vk0CerG3GqeGhKQMIdyNartBmcmcMqzcm3x2hjfScUgPZMhlSscPyOAyRtamz5lNLGOh+tpMNjsgaqkPvSA/A02Mrc0c2hnMFzfyspujWce4q8mU1fS4HE1Pb0pC7yL1l0kOLzOBfJ8GcNFOnGgQdQTSOjK24SWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061558; c=relaxed/simple;
	bh=m7cKcAII0plOVkGKcv7uSfFLh3XYSWdt5h/PKHYcFK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xg1JiBa/0fP93fglgTYTgCjjrukeNJXzde3QR3Oyo9Y0y3zDk26JKFHugjkDxKOw4AV9GYKTJdITI/deQJf0bpSvasZPM3fYjMSetfS8cTetpOOLQFTK4wJjfEdqBDie9kXYqB98VKauUyJFydoomhqzfNnMWXlHZvwPRilgQT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpu1v2r0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpu1v2r0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156521F000C4;
	Thu, 15 Oct 2026 10:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792061549;
	bh=xC/wmtw3i4A2qkYE5TyAigTML94khyrDMBlobSOJqgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lpu1v2r0eRW+NRHnHYNntpREb8FMeCzXvUSXWLPRx2DICFS4FVUw0CR1u/6+PzGt+
	 Yzl8fxEqDbo8MXZhXaDNuIBJ6JeqVUHk+X9/tHvhPtpVsOOEoTfdpKE4ZeGl0/3D7c
	 W52ZmS9sh+GQ3PmXB+jkFg9vC6beXSxsuyoAdrn2azxT22T0+C3B/6RLnG2xLU/qCO
	 Xwyu91CPNXWyge0u1YAOun349hIpNU9DILBK/DuEyCDVZinqo/u+YX4ik+1JVKcn4k
	 L0/lnaxv+n/8+XgltW01lXWDw/NepkPyzJrVbiS2Du+anuU9FCrp/UOkam0rFCILkY
	 9RzfHijUP9llg==
Date: Thu, 15 Oct 2026 12:52:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Philipp Stanner <phasta@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH 13/13] arm64: dts: qcom: hawi: Add DCP support
Message-ID: <20261015-unstoppable-masterful-wrasse-87dcd4@quoll>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-13-48aad0fe4f72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-13-48aad0fe4f72@oss.qualcomm.com>

On Thu, Oct 15, 2026 at 01:08:33PM +0530, Jayant Shekhar wrote:
> diff --git a/arch/arm64/boot/dts/qcom/hawi.dtsi b/arch/arm64/boot/dts/qcom/hawi.dtsi
> index 0926d880cb0c..58fcf42cbaba 100644
> --- a/arch/arm64/boot/dts/qcom/hawi.dtsi
> +++ b/arch/arm64/boot/dts/qcom/hawi.dtsi
> @@ -8235,4 +8235,63 @@ timer {
>  			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>  			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
>  	};
> +
> +	dcp: virtio@9be8000 {
> +		compatible = "qcom,dcp-virtio", "virtio,mmio";

More slop.

At least you could ask your agent to TEST it. See internal guidelines
how to do it.

Best regards,
Krzysztof

