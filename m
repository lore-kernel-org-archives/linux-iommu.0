Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173C3EA957;
	Tue, 19 May 2026 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204207; cv=none; b=j5WwN6R/0eGDH9V9Z1AhIYpYTA86SK3Ts49rysWeRzQmGGGPuBzPdwxniRBorRWfVZOpihxmKFQ4nwCk4KR8ZCW0aUykrRZt5KSGWkQBj5QOqt6NJVOpkcHoncfrHmHB6eKFMUgYR9mFk96jKE/a1X/lXPc/fnZHK8EhXi7WrBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204207; c=relaxed/simple;
	bh=9t2LcnoGG/k1YKOm6YjM1CNX5Tv3sp5Ya2M6JAEa0UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/h5QCmcugpBZA2xOBOAFZREvMDSkuO2XD3o2ViYRxE/ro/obpBwXEMY+eR2J59Ef4hBw7cjzLWkoVF+1BohsGvRdtFb1/yHO2jCjrKBkxLy87pUkbJQJ5wNOBJIlk8XTG028eJjQYjwkIBAShKUNl/9KxdP9yvW78+OxHXtXo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXmF0fTI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXmF0fTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C271C2BCB3;
	Tue, 19 May 2026 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779204207;
	bh=9t2LcnoGG/k1YKOm6YjM1CNX5Tv3sp5Ya2M6JAEa0UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXmF0fTIIuet4DYdesw2f7JeMrsmA3kwSf5TpMxAWx+l4Ch3NsSx16Du5Ga0klbNR
	 e9ia0iLH+q6P55dDzZGzylYD+W6lV8mwKnZzyG+0/rbHjo8ZTy6TjXttm+HhJf4JqL
	 KQWmGfkGmjNlUW9+V01HA6SNvo1Bu82JdfXJTKYv0LfcDTtbpRAFrXlm2D/GqOE9YQ
	 N+2GvsHkCrpaiNE1Syam7c2CO0oy3ICX5Fr6vpYpmBJI7IcavSdB9JRTADZAgV+daI
	 cP5ni4Clh3zxm2K6WsY52SRCLgXAagD3JBIvNERJ/5u96P7q3w6/lDX4/dc06W8Nw9
	 V31yHYHhrCkGQ==
From: Will Deacon <will@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/6] Devicetree support for Glymur GPU
Date: Tue, 19 May 2026 16:22:50 +0100
Message-ID: <177919251300.824194.8161105120233128741.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
References: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 13 May 2026 00:51:17 +0530, Akhil P Oommen wrote:
> This series adds the necessary Device Tree bits to enable GPU support
> on the Glymur-based CRD devices. The Adreno X2-85 GPU present in Glymur
> chipsets is based on the new Adreno A8x family of GPUs. It features a new
> slice architecture with 4 slices, significantly higher bandwidth
> throughput compared to mobile counterparts, raytracing support, and the
> highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among other
> improvements.
> 
> [...]

Applied SMMU bindings update to iommu (arm/smmu/bindings), thanks!

[3/6] dt-bindings: arm-smmu: Update the description for Glymur GPU SMMU
      https://git.kernel.org/iommu/c/23bc2dd17b20

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
