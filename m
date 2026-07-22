Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264833E3177;
	Wed, 22 Jul 2026 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756397; cv=none; b=VMpQiKP3dDXgbDdG9+cGW1aVZaYBlZYk3J/xssl2HrB8xSjas0Rgt+YLA8s7t0XS4WGikSocDoDZIo/IIODTT2m71juge2tkal5mG15OEPbqR2PBu2WFiC/sfOLyfGIPlUyB3pTIesWWYsbhFKuc5pTX6uiJAdpN4RwyWPwqpHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756397; c=relaxed/simple;
	bh=x0Vctnx3llfCo40eIELT2VVY6L8u1/hh7NJ3J/k6MxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GP1zzeWVxTlvcqY3KWSK65plzTvqNqZC0Wlf7iBiF6ZgfRQ7nnZhasbQOJG5Qv7IQctu3hfBLACh+14hYbyA8iWarf3EKcthTXMbfYSfiIvBwG+akfm1v7NaX5BK1ULCYIICnqS8tCYRvF50ZX08Y+qM6jRbFS42wAHmEU7THck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV3up+hK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV3up+hK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B77A1F00A3A;
	Wed, 22 Jul 2026 21:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756395;
	bh=f1wOx0e4PjnlF3z9WLHEYARB2GSoN4b0UX9bWrnaH3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FV3up+hKKYgBreJt+xgk9qax0vNTRVcRIerlpcYvJJHFkhgMsoucwlRE5dVJVQAUk
	 NOlaCo6qFmrDUWShS2RAfkllGOVrpRZeeBAfEj2xXaL65AFASCVyoQ1w+/xtYmJPQG
	 BhW19lZxp72vmGZyaxEo/cuhnq3Uvz0D04ymSYpQ3dyGhCLwEdYwB4s8Dimd1+FQut
	 4IkAqpkLCT+q8XwUidRGtcQQM59e6Pm/Jrv9mUfVZnryPkH43Sl4l2BM2NKVEPK4zF
	 lT3HNeglZh+8GdzQ2CFnty4o8eBGg+9m9WuRIR4RJZ0NxY4rW7uCfcTv++ZdOnHzGC
	 Yn1nhDKXxPlLg==
From: Will Deacon <will@kernel.org>
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
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
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
Subject: Re: [PATCH v6 0/7] drm/msm: Add support for Shikra GPU (A704)
Date: Wed, 22 Jul 2026 22:39:20 +0100
Message-ID: <178472212670.2848256.16113852617483173149.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
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

Applied bindings update to iommu (arm/smmu/bindings), thanks!

[3/7] dt-bindings: arm-smmu: Document GPU SMMU for Shikra SoC
      https://git.kernel.org/iommu/c/20b4f0f120ea

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
