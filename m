Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A03D4123;
	Thu,  2 Jul 2026 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783035651; cv=none; b=VgX0d/yENMv+YUxm8HjJIjZED85zdUQA3N38e2cVE/Ph0ta6Hw3K3Sw6y9dXyFGXAMI6067n0HGw9Rl0iqOcIG9wZGKWB0jJqHO8OgtJpXIL43JuGycNffjBbanU8N8qoC7XBV2jvlb0N+WZ9JywXJki+gs5R4PtdIxBQqyd/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783035651; c=relaxed/simple;
	bh=smUvZ7mKW4xG+p8esylmTGgaLN+iFv47FgI33ARdWLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YeRycPCD8+Q9nrxJtHGifO38WYyrpOKCwKVAiEk2NVz8nHZwbVGmdvNwyHK1Psw7VJwL96Rn/PCKYbgLv1mfYW8Sz1SDhz1YlHrZYq+OFCOzYrCpGRX7zGWwazO3Jwx4OWuvYG0VgJbFT4AlwTGfRMHlBH8COE0RH5qDFnZBnEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifTRbqCW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifTRbqCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCD51F00ACF;
	Thu,  2 Jul 2026 23:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783035650;
	bh=E0nJyn9ZlHXNy1UtVy9wnNIdYbhNJQE+1kKdh0a86nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ifTRbqCWDMCfJRpsFWFSJW7oCng/TneUHfOCCN8EjG3vvjTMa+DppbPZPE39lcmp3
	 KgAxwXNLRLEQWl5Hofq+MKDVWPtZTvupP6r4Jt6X1MxvF1VcbQy7+XFdhWK4I7+Qd/
	 UBoEEIT54NrPlfyf7v8w6KAxIZG6oC3hRmTjUJUh1kny2QKL5DwxZgRA78v/cg2E5a
	 qMo2ZNe3wn4i8lkD5Ievr1COh413z5G4XYafPOURVlaJAVSj31M7hnIDxblz+3gNl6
	 a7Xzjlh5TfNzMIp6UHGs34v0EVn3jqwv3poSbxu6x+HMhW18soeyZLLF6Sq/iPECm+
	 XKeLLY9rwDRDg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
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
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
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
Subject: Re: (subset) [PATCH v5 0/5] Devicetree support for Glymur GPU
Date: Thu,  2 Jul 2026 18:40:24 -0500
Message-ID: <178303563635.359079.10264708628600253510.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
References: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 22 May 2026 15:41:56 +0530, Akhil P Oommen wrote:
> This series adds the necessary Device Tree bits to enable GPU support
> on the Glymur-based CRD devices. The Adreno X2-85 GPU present in Glymur
> chipsets is based on the new Adreno A8x family of GPUs. It features a new
> slice architecture with 4 slices, significantly higher bandwidth
> throughput compared to mobile counterparts, raytracing support, and the
> highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among other
> improvements.
> 
> [...]

Applied, thanks!

[3/5] arm64: dts: qcom: glymur: Add GPU smmu node
      commit: b90a899027ae9def17cff2c566f50e406bb95307
[4/5] arm64: dts: qcom: Add GPU support for Glymur
      commit: b6ff8cec8aaac2128a4fe82ccfba263cf645cc68
[5/5] arm64: dts: qcom: glymur: Add GPU cooling
      commit: 7d260e77d88fa026a1e181cecee545687fa80f92

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
