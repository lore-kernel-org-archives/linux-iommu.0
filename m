Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37A81D5CDB;
	Mon, 10 Mar 2025 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591367; cv=none; b=roVTsfNydqytK3yq1sdI39368rS0TCQTAZCvZFvt20y4eWcZIc09W6t7UJd37qcjLcPzwH0eB6T50vQClBaHetXMkkYW2Wxyerk6lipkQcQPwo4SKwiegqVTsD7C8MQWkqRzOZ1gAPOorjG/nRXkKER9ZsC5kdVbsINjDNAgAsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591367; c=relaxed/simple;
	bh=Od8L1z8gpGuI01Q46FCrk/dgTluhyNxz/YRj8wTeP4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRD1KqRAvmorBtwnueOEiZsRkLayZvSEqFNDpV8z4qIlM2cGCBWGYw8XQKmxyLq+wH7m6ziCu2JaHsXsRsqml2q75Lr5BwXSFZN/TdFiwWNeYOvxBd9cDajWBkqJOdTLrlYrFPfBI29ftAkaD5NNnWBj9NlGQg/Ii7ixa0Meo24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUc4q3Gd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUc4q3Gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D291C4CEEC;
	Mon, 10 Mar 2025 07:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741591367;
	bh=Od8L1z8gpGuI01Q46FCrk/dgTluhyNxz/YRj8wTeP4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUc4q3GdNN+6ts/tAqY680p2XE7YKchNwjX3K8gVj7z0To82usUJf6QbgxHL16oTC
	 2uNsjiDTH9d/fy9Y431E8JtXL7h9i6Wup3Sp/zrYSul273raYEowyy1X4U+j7CmvL4
	 aVDTcmOU5yOBBVZaAzKmznQJpkzM67qmY+IWu279KU2ckDT7DGKrGvQrFOi3izceGK
	 dZFdyod48PZ+tN34na43hFAzeZkl3xXbMorWV2Hhag67SCnA44FotBRDf2o5qIEQNh
	 BXSFoFpqDyBaI0hOkYW5zqM1NeC5trbydPMJ1Et0Jn7DuvIap30ME0gn0XHKhlmHkD
	 UVhlOCV7C1xtw==
Date: Mon, 10 Mar 2025 08:22:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <lumag@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Jonathan Marek <jonathan@marek.ca>, 
	Bjorn Andersson <andersson@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/10] dt-bindings: display/msm: dsi-controller-main:
 describe SAR2130P
Message-ID: <20250310-wise-jumping-moose-b45f1b@krzk-bin>
References: <20250308-sar2130p-display-v1-0-1d4c30f43822@linaro.org>
 <20250308-sar2130p-display-v1-2-1d4c30f43822@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250308-sar2130p-display-v1-2-1d4c30f43822@linaro.org>

On Sat, Mar 08, 2025 at 03:42:20AM +0200, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Describe MIPI DSI controller present on Qualcomm SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

