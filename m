Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC31DBB38;
	Thu, 17 Apr 2025 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744869807; cv=none; b=qT7p0ZoAetiNb3hB8Hai0nlxc36/mdN137/JB1JTF2c76h0UMx85A3+MIVDLqnnabx2PcVziHJzLjF9IXdiq/kqTDogHtEuRZ0M5Z4z7h9MN5Ev/tm7Sd0gQ3WHid67lKhPHgzL4lQP6WygPmPT5UC8p7/Fx76qG0pe5CpyW4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744869807; c=relaxed/simple;
	bh=6ZoqTPwfO/hTrww6ih36cHlyfM9o4ZZ9D90K3jw68XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkwctCfX6MEOvzdYtrJlBboDxk0EPBlcpAGfS7qo/WYR0kMgHlpwKL5ExjbWu405AdTUr7FtiFvOF4dbw8jYnXuTcT0P/Vxd9WkyGXKSFS6Ss4xn0MRGWxshQkSvQIvNax+v7QqFspnKJmSczT5TW314tZh9YKyRlbpacHsbcnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72006C4CEE4;
	Thu, 17 Apr 2025 06:03:26 +0000 (UTC)
Date: Thu, 17 Apr 2025 08:03:22 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>, 
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
Subject: Re: [PATCH v4 01/10] dt-bindings: display/msm: dp-controller:
 describe SAR2130P
Message-ID: <20250417-arboreal-turkey-of-acumen-e1e3da@shite>
References: <20250417-sar2130p-display-v4-0-b91dd8a21b1a@oss.qualcomm.com>
 <20250417-sar2130p-display-v4-1-b91dd8a21b1a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250417-sar2130p-display-v4-1-b91dd8a21b1a@oss.qualcomm.com>

On Thu, Apr 17, 2025 at 02:16:31AM GMT, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <lumag@kernel.org>
> 
> Describe DisplayPort controller present on Qualcomm SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Addresses do not match. You re-authored the commit, so now everywhere is
mess.

Best regards,
Krzysztof

