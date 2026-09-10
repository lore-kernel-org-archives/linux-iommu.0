Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E69379980;
	Thu, 10 Sep 2026 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023576; cv=none; b=Aplnk+7SA0VCkMBspOOYk68wvf3ECpCKfL/BT5Cr1lP3dLaijNi6+O9vuTRM6Etnkrgq/qSEPxSwAsuMbj3q/2+rCM9bFVc0htzzy1PqVjR+THFXJBcaBC+gHb9/tpt09+1L0MXXezc9i16Bzy9bPcKGPaOUvQ3Sv/pwMjw555Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023576; c=relaxed/simple;
	bh=LrjsJpRIxtlsE0g/6n4aq0UCVyY9zTwGOd0s4+L37ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEQ5Fn73drILRyLpLCJMkc/WXoQeSgBVlY1wA4F+rh96esw4sXUurkEqSJu7jumDY9eNvMmZR+uDvv+wA9Yw2PCrW3OLM7BSN+G7J9+tHPgnb1hN4EA309E/zvf5CriivrG5eC2V9RCZOU88LTF/p3/G6WiIiiL2cVXjJf+N4z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkleIUXx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkleIUXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0701F000FF;
	Thu, 10 Sep 2026 06:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789023574;
	bh=tskACuagwOaxkuwzFhldeuCVdSOEtOA0YgcoFIIkLQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dkleIUXxhDKYdAVIQBqWxvkaBIKjKyNnWIKzd9qbaYsvTItAG6XCdkXF2nTqguwDY
	 GhKR7mV4Bfq972b8+MA4pfByXEbpAiOrBb3wPcw7S5Ac6mHIKni5MNQB/dgsAK6dVl
	 LkHF/Q73JwDzBWLVdwT7srUyZ4TQJ7pKLorXYIIIxy8tP8zYz2pt8w7M1kTh0aeNVj
	 A6hTP2xtkJOT+xo2D2gGIwbW87MhDeyZHPIX79aZdC4YwhS9zK8g7MM6x6rkdDZ0LZ
	 3z7kVbyL+jB1DzZje/TDALhliK3dn0sRU2ICmEELL1k+uGz5/POyqACgHBsrc5TZnA
	 TlDr9VE/akbKA==
Date: Thu, 10 Sep 2026 08:59:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Stanimir Varbanov <stanimir.varbanov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, iommu@lists.linux.dev, Daniel J Blueman <daniel@quora.org>
Subject: Re: [PATCH v3 01/13] dt-bindings: media: qcom,venus: Add context
 bank subnodes to common schema
Message-ID: <20260910-careful-finch-of-fame-eeeac7@quoll>
References: <20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com>
 <20260909-vpu_iommu_iova_handling-v3-1-2fe43ae45495@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909-vpu_iommu_iova_handling-v3-1-2fe43ae45495@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 08:27:08PM +0530, Vikash Garodia wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> cannot address the low 600MB of IOVA space, while the pixel stream can
> address the full range:
>     +-----------------------------------------------------------+
>     | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>     | 0x25800000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
>     | pixel stream addressable range (0 - 3.5 GB)               |
>     | 0x00000000 - 0xe0000000                                   |
>     +-----------------------------------------------------------+
> A single "iommus" property on the video-codec node puts every stream in
> one IOMMU domain sharing one IOVA allocator, so nothing restricts a
> non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below
> that boundary the hardware faults, which shows up as unhandled SMMU page
> faults and spontaneous reboots:
> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
> 
> Given that the address range restriction is for specific VPU stream, it
> should be ideally be moved to that stream. To achieve the same, a subset
> of streams is now represented as subnodes, so that each can be
> associated with its respective addressable range. The design was
> discussed and agreed by mainatiners here
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org
> 
> In the past, this limitation was addressed with an iommu-map approach,
> with the iris driver dynamically creating the devices. That approach was
> later concluded to be a hack to avoid having subnodes, and was NAKed by
> the iommu maintainers. It was discussed in detail here:
> https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/
> 
> "iommu-ranges" on the subnode describes the *allowed* IOVA range that
> stream is allowed to use, so the IOVA is allocated from the specified
> range only. Define all the possible subnodes so as to describe all the
> VPU hardware iommu interfaces, both secure as well as non secure.
> 
> address-cells, size-cells and dma-ranges declares the 1:1 DMA
> translation into the parent.
> 
> The parent "iommus" is kept as an alternative via "oneOf", so platforms
> that have not been converted to subnodes still validate. New platforms
> should use the subnode form.
> 
> This patch depends-on:
> https://github.com/devicetree-org/dt-schema/pull/207

Please drop, not suitable for commit, keep it in the changelog

> 
>  Tested-by: Daniel J Blueman <daniel@quora.org>

Plese drop, not true here


> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  .../bindings/media/qcom,sc7180-venus.yaml          | 15 ----
>  .../bindings/media/qcom,venus-common.yaml          | 97 ++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 15 deletions(-)
> 

I see this causes DT checks failures but I don't see the report, so
probably it was because of schema dependency.

Best regards,
Krzysztof

