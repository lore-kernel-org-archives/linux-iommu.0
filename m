Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2F25C803;
	Tue, 20 May 2025 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747707317; cv=none; b=k2ptWUSFhsjDfSnNVKk2PwN6iUfG/RTj4ywVH4r4y6yRDBhTSd4biCBp6ZRHV+PZW7by26I6KVTtIQBtB1j/FzGvvep2+DjrUWTbpvIyL8Zw3zDPwCW8sLG6LpgP2OMIACEGeR2f+t0yfzeuoaZfdw2grTvnElzFi2ZEGbns1fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747707317; c=relaxed/simple;
	bh=g6jZXMWAASQQayHaZW8MlORaAe0WEAlxX9oX2O9V4OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6EhOm41u8laJZlxSAUi1QlMW8vRr385IoGh4li21mxJ7IEL7MjfyXPz1hp3NbJe5/IKdlnrkzLkqzCGxuXeLRur9hj9sZzx9xdWJp3sjuiyGqjhQ/ucd+KPb/z0nHfwoCCSmS/AXHtYRRFZOBS/Dr3uAXOxcRRacoQDqWsE7SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIwcS3Eo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIwcS3Eo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B255C4CEE4;
	Tue, 20 May 2025 02:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747707317;
	bh=g6jZXMWAASQQayHaZW8MlORaAe0WEAlxX9oX2O9V4OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VIwcS3Eo6vPobAzbGYGcOhFDUgd92VyIv4WqcIC/GPKDzzMTemxehtleoQuxsuOYr
	 o+ILHkKeRw8zA3AJQrUcDZMHwMr68nWv57e1E33NdXS3Ze+MsNYT6GZZbWqIzOBjCu
	 ebgkVsCoaVa/hyRkhCkTOO6C+J5owDQXLPFjExW3gj1YyB0cuqNvnYEAHWqFrn3vX8
	 zYzxzHfHYTwD++bxnFgdUhv1FvSmCcTHpBhTemN4C44jwwc7pTBsFj+vmOu6WzuIrP
	 w5qaWskxqwb7dB7jQ9bkzXGrW2YBD8WE8lUylyHgHAv3lgllSbEG3EoArp4NeV3wUE
	 sp6FBNUwcBrpw==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	Jonathan Marek <jonathan@marek.ca>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 00/10] drm/msm: add support for SAR2130P
Date: Mon, 19 May 2025 21:14:45 -0500
Message-ID: <174770727711.36693.10469297206946224831.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250308-sar2130p-display-v1-0-1d4c30f43822@linaro.org>
References: <20250308-sar2130p-display-v1-0-1d4c30f43822@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 08 Mar 2025 03:42:18 +0200, Dmitry Baryshkov wrote:
> Add support for the Mobile Display SubSystem (MDSS) device present on
> the Qualcomm SAR2130P platform. The MDSS device is similar to SM8550, it
> features two MIPI DSI controllers, two MIPI DSI PHYs and one DisplayPort
> controller.
> 
> Note, due to the technical limitations DP controller wasn't completely
> evaluated.
> 
> [...]

Applied, thanks!

[10/10] arm64: dts: qcom: sar2130p: add display nodes
        commit: 541d0b2f4dcd9514265b3a3f7f797525caabc1db

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
