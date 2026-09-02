Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFEC4AF17C;
	Wed,  2 Sep 2026 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385509; cv=none; b=XVmAgAG9Og0elzadtxm7TLeeYjW52XlRHxEWm3prJGhb0AYbjkbq6z5tYdRTZ79Kruc7z3UUnDlsm36pBdkKn/XSx1T3s9hIuFxBo41zviOPD+WzJkyEt5QWD1MVUy4Ddro+xfAV64uY3CkyeKQXBVt+DUEKEFw4o27OXuJNW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385509; c=relaxed/simple;
	bh=qXjirkWdv13HIbedJwozzZLsromb3xjMWq+l48ozG/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6EGhIfQUd6zdBq2egM6sVeLrEB4e7UaG+Oz2wRs4o7MzinlekjDSM7VXNJvcGOzgsqxIE3MO9XjVARvbsmihz1bvbOHj+oTsXZCq0q+dNlOH2LrVbzbZ6lgmv3i8SNuLZv2I1ZskjSsQH/G/0tAslxHHdeyRBGEN3dxDIbH/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9Y4NCsI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9Y4NCsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649651F00A3A;
	Wed,  2 Sep 2026 21:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788385497;
	bh=+JuyjwHbaaYNfgnJqhnqi/RDpMTuEjW1rSeLs2DZTYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y9Y4NCsItJcVpoapXIjhPVr/xF62UBUMDn7klXC679J/nhvjaIcCTqQG9cGMQzlds
	 8ZZ30vDAf3Ze79Ry+QKF1JaUqAboVWCHN8vQcv8Tswg7iH1KnEJc2FPXectXgrsHjl
	 nmpsfDXna3mDiY0eJXQXL6dThQIu6MKpYVVwmvKJf4lSrQnFmN7NxhCnaN4FimFfo0
	 WOdjOU/S8hecfK4NyEQr8wcPEodf6u63gso3cMYrrbUFPZadWreJWyO0GlG4DfKh3d
	 ghCg6M4VzsIhwi5PTSGeah5A4m1hTtyMYLXRkohHNkTudqyCYr5w9HoFLy9Ou5J1lJ
	 lHcW7FRv96PdQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Aditya Sherawat <asherawa@qti.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v6 0/7] drm/msm: Add support for Shikra GPU (A704)
Date: Wed,  2 Sep 2026 16:44:45 -0500
Message-ID: <178838546713.167607.11279652924360293843.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 10 Jul 2026 00:11:59 +0530, Akhil P Oommen wrote:
> Adreno A704 GPU found in Shikra is an IP reuse of A702 GPU with very
> minimal changes. The only KMD facing difference is the chipid and the
> zap firmware which is specified via devicetree.
> 
> Mesa side support is already merged:
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/41762
> 
> [...]

Applied, thanks!

[4/7] arm64: dts: qcom: shikra: Add Adreno SMMU node
      commit: 91b139e9204c8ed4e1f5c89826a92e28716dd7d5
[5/7] arm64: dts: qcom: shikra: Add A704 GPU support
      commit: 4f365deb0e5ecd48998537ab67b5270d719a8fe5
[6/7] arm64: dts: qcom: shikra: Add GPU cooling
      commit: edd7232e163723a0f15bd9446f3f831edb5893e2
[7/7] arm64: dts: qcom: shikra-evk: Enable A704 GPU
      commit: 94654d16acfce2ed56e39f86645c3c5f56cc3f3b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
