Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A513A83BF;
	Thu, 17 Sep 2026 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629004; cv=none; b=O/z0ZouVRmolrxTWLw9REACJppFQvoKlZBI80pHUFAJ5od2BzOh6xaIiLH+Fg8Vjr4Bgo3BDmVjjum7yIcWSWzKIXaIvSkeRhW0B8DzhQOfisgv+80SxdXfa6IjMJ0eY3Rg50UupyB+QNVBtpT2FiPMlvHU5GeuL05csGZyWGeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629004; c=relaxed/simple;
	bh=mEsXJXUfeg+J2wdVlTN6mxmLM6jb7gdwBS092oeyO38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgB+sfAhkL4qKxxPAQmJOkyWaHiuPaWwD2vLkxx6Lzd2sx9KnvLKj1afhD5gnm0uuc3ptUNriMMSnD6sDLkg4KLjMBfhq4iYXkUsBLAsAUB4Chnp8eOktua4Q5Oj7w+DgChFZh0BQdSYzqHeaWHxNhI420AV4JSyPWeAOrkMDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hqs02RGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hqs02RGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515B31F000FF;
	Thu, 17 Sep 2026 07:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789629003;
	bh=rbz4sBgqfAts7eX1udBwlfoWe0KdCOY5WEmV0mk1Z6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hqs02RGjFzhob40I4I0u75rm4iBFm92AjrYKUIrTHn5bYY4DvgK4R4DdtER7Qs2Zz
	 6pkucpOlySv3U3tgDbrPmzhHFBu9RGxrzXqK/+OKs1qVQ7RCOMvsE0monbKYImOzZR
	 GB+S8m4hHm8cNtcEeUMqv2PD+bTjPo7yOsA1+5NNQSWXXF/NAFL2MQBLnR80BQkqoL
	 10jWWMEBjkB5IkbA44Mxp0OWmveDj4NjduB96NJYR+VOmQorU7V7LdxMlSlnYw/ghv
	 yZvmcxJX7yYC4GxaPgFP3X0YRd9KIFoQ6ilAIw0H9Ymxkzi7NWcaQT8OBc/lr5LZ05
	 0/9aMwJv+mGJQ==
Date: Thu, 17 Sep 2026 09:09:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>, 
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>, Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v11 0/9] media: iris: Add support for glymur platform
Message-ID: <20260917-dangerous-illegal-honeybee-cf479a@quoll>
References: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>

On Thu, Sep 17, 2026 at 10:30:19AM +0530, Vishnu Reddy wrote:
> ---
> Mukesh Ojha (1):
>       media: iris: Enable Secure PAS support with IOMMU managed by Linux
> 
> Vishnu Reddy (8):
>       dt-bindings: media: qcom,glymur-iris: Add glymur video codec
>       media: iris: Replace enum-indexed clock and power domain tables with per-block structures
>       media: iris: Add power sequence for glymur
>       media: iris: Handle CPU_CS_SCIACMDARG3 register write via program bootup registers hook
>       media: iris: Add support to select core for dual core platforms
>       media: iris: Add platform data for glymur
>       arm64: dts: qcom: glymur: Add iris video node
>       arm64: dts: qcom: glymur-crd: Enable iris video codec node
> 
>  .../bindings/media/qcom,glymur-iris.yaml           | 218 +++++++++++++++++++++
>  .../bindings/media/qcom,sm8550-iris.yaml           |   6 +
>  .../bindings/media/qcom,sm8750-iris.yaml           |   6 +
>  .../bindings/media/qcom,venus-common.yaml          |  11 +-
>  arch/arm64/boot/dts/qcom/glymur-crd.dtsi           |  10 +
>  arch/arm64/boot/dts/qcom/glymur.dtsi               | 120 ++++++++++++
>  drivers/media/platform/qcom/iris/Makefile          |   1 +
>  drivers/media/platform/qcom/iris/iris_common.c     |  10 +
>  drivers/media/platform/qcom/iris/iris_common.h     |   1 +
>  drivers/media/platform/qcom/iris/iris_core.h       |  32 ++-
>  drivers/media/platform/qcom/iris/iris_firmware.c   |  69 +++++--
>  drivers/media/platform/qcom/iris/iris_hfi_common.h |   1 +
>  .../platform/qcom/iris/iris_hfi_gen2_command.c     |  19 ++
>  .../platform/qcom/iris/iris_hfi_gen2_defines.h     |   1 +
>  drivers/media/platform/qcom/iris/iris_instance.h   |   2 +
>  .../platform/qcom/iris/iris_platform_common.h      |  46 ++---
>  .../platform/qcom/iris/iris_platform_glymur.c      |  78 ++++++++
>  .../platform/qcom/iris/iris_platform_glymur.h      |  15 ++
>  .../platform/qcom/iris/iris_platform_sc7280.h      |  28 ++-
>  .../platform/qcom/iris/iris_platform_sm8250.h      |  26 ++-
>  .../platform/qcom/iris/iris_platform_sm8550.h      |  26 ++-
>  .../platform/qcom/iris/iris_platform_sm8750.h      |  29 ++-
>  .../media/platform/qcom/iris/iris_platform_vpu2.c  |  20 +-
>  .../media/platform/qcom/iris/iris_platform_vpu3x.c |  67 ++++---
>  .../platform/qcom/iris/iris_platform_x1p42100.h    |  27 ++-
>  drivers/media/platform/qcom/iris/iris_power.c      |  20 +-
>  drivers/media/platform/qcom/iris/iris_probe.c      | 153 +++++++++++++--
>  drivers/media/platform/qcom/iris/iris_resources.c  |  81 ++++----
>  drivers/media/platform/qcom/iris/iris_resources.h  |   8 +-
>  drivers/media/platform/qcom/iris/iris_utils.c      |  58 ++++--
>  drivers/media/platform/qcom/iris/iris_utils.h      |   3 +-
>  drivers/media/platform/qcom/iris/iris_vb2.c        |   4 +
>  drivers/media/platform/qcom/iris/iris_vidc.c       |   6 +-
>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 216 +++++++++++++++++---
>  drivers/media/platform/qcom/iris/iris_vpu4x.c      | 137 ++-----------
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 102 ++--------
>  drivers/media/platform/qcom/iris/iris_vpu_common.h |   3 +
>  .../platform/qcom/iris/iris_vpu_register_defines.h |  13 ++
>  38 files changed, 1229 insertions(+), 444 deletions(-)
> ---
> base-commit: 0d9d0dbf2fddcff5859d623e90ca73c4054276e1
> change-id: 20260917-glymur-627d049900e0

Look here:
https://lore.kernel.org/all/20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com/
change-id: 20260601-glymur-4fcd4d832ecc

so now does this work?
	b4 diff '20260917-glymur-v11-1-e0c8bc914742@oss.qualcomm.com'

No, it does not. You are sending bigger work, multi-version one, part of
even bigger work, so please get the process working correct to make
reviews easier.

Best regards,
Krzysztof

