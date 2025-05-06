Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3472634;
	Tue,  6 May 2025 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746558303; cv=none; b=EdDw1nJl0/O/E/v5fq6rWkCWdYgSRlO5VZSwTDGTqJlN9ZSCQsc/MpcEqh2Mdm337uQsKdWZRJcnCTBOrLdLOtqWyeCd3HkTFVuyf1YTY5UklNM+RazPvwh0Zwwzkar2ceI6hay2PHfl+Q4xcdxeVWz6gXADPXxhcwmXiixAzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746558303; c=relaxed/simple;
	bh=MSo35+Amh/seHP0yrFLPNV2O0EEaD2IT75vNZ18nUtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JD1fVsJUqdoIwWsQB7iS6Udb5zzWTSArRpWkWr3sN6jKC9N1pvRcx57KVt8updnLmU9RZ3BNAEYdRQQ6kg9vOrwBMmC2815MCBmDK9yCR/kPPTfNxQRwfu506R14eVR5nOsPqkpX/8KgHRbUnkTDeu6Q8gzv7aSnFtN3ZKpoG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyXGHcOF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyXGHcOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5832EC4CEE4;
	Tue,  6 May 2025 19:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746558303;
	bh=MSo35+Amh/seHP0yrFLPNV2O0EEaD2IT75vNZ18nUtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iyXGHcOFG6J2D23m+FcvBlj4G/IiJWlHR9TR3aFYRXBes+B4963dDPBB0fiGGigXs
	 w6q8Ub/1rj9oThenxajNA2en9yHlLPL3hueOzLnr8ZR3UjPtF7iBJhrU6DyTqCDckl
	 1BVDnTvFDp6pYoPzWMZXPOTfa47bnxW557WYDOw6t5Ab+s4e7nsqc3PVUSjfas4peA
	 ePzrqny9plQg327zhXEvM/FjAPU/5YNncQc725YUZ1GLmQg0PImMCNi6sZDBeQWEtd
	 aQBXDbLqSwiRzWjcok4dkAXzica29VpwoZUzqA1XocAlM/Yzc0UloZ0m7pPgXTsvbB
	 z//PJRGt3MdNg==
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
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
	Bjorn Andersson <andersson@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 00/10] drm/msm: add support for SAR2130P
Date: Tue,  6 May 2025 20:04:52 +0100
Message-Id: <174653623031.1666674.14201410658457114582.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250418-sar2130p-display-v5-0-442c905cb3a4@oss.qualcomm.com>
References: <20250418-sar2130p-display-v5-0-442c905cb3a4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 18 Apr 2025 10:49:55 +0300, Dmitry Baryshkov wrote:
> Add support for the Mobile Display SubSystem (MDSS) device present on
> the Qualcomm SAR2130P platform. The MDSS device is similar to SM8550, it
> features two MIPI DSI controllers, two MIPI DSI PHYs and one DisplayPort
> controller.
> 
> Note, due to the technical limitations DP controller wasn't completely
> evaluated.
> 
> [...]

Applied SMMU bindings change to iommu (arm/smmu/bindings), thanks!

[09/10] iommu/arm-smmu-qcom: Add SAR2130P MDSS compatible
        https://git.kernel.org/iommu/c/b3f3c493e963

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
