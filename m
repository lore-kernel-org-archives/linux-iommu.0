Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A13B42E6;
	Thu, 17 Sep 2026 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629122; cv=none; b=LNsTU0hQi9lSKd2OewdyAYFyc2LBIh0bHDbq2Wt4x6Uv1OWb/lNcFeESa52f6tVB+jF4+/aT15tFjuN9xx3BXMeO0SqpY0zmcOvgzZBIcL6k6aYupJ2p59VlDEAob4Eoae5qEHnqGjo6+8++XqgYv/DtmtLZK38bvok2uW1WmqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629122; c=relaxed/simple;
	bh=Xn1OBadHWVaPTEqbMA1foV4rLoLSSPbQZxUyg+8DgOA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eRb0oCJPV6xf9Cx37YC20tmYCCl7Ff4l5x+gX/W+Z10qx2s8EOVXSMrS56jnDUdnKa1Kmmjc1OmGGmNsWfWpfVyW138OvHshhkpUDL/RxmiBSPyAmGLqKTzMTsjSKqSd+KT1cAGuPfKzzOmRugs5yyknVmQENN3SrGL3FZ7gxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXmVaRXz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXmVaRXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0805A1F000FF;
	Thu, 17 Sep 2026 07:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789629121;
	bh=QZWvj0y2qYypNkhqYeG+rMh9NEA31Cl9OJ6XafQCJgo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=KXmVaRXzE1da74MR6oQokswU3bLeCRwAHFedrXabp3UUCO9Kdvx/MeoI9kbDmWQUO
	 qpEXLyjlVso3sqxxU8Uj72ZMRq2zLWFh5YeIeMy8BKf9sM2EadUMah8Ob5d+k4ewMa
	 FBZmEdIxskTVIN5zwgQ8XYetPzqONy2GM5a6KuYkpoh3HoYDOXPa+kC6/jlD2lmMzS
	 +W7K5JLQlqlPXAbxnSZ/BQ6vDZ716L47RkcoGHyRzQ5+rL4srEOOlUO2AnzkYKSSy2
	 exiINVlRe+lg86z+EmDNHHYRWzJHJLUTZ6XOA4meMGwiSinqXmIoPEGcte+ClYw6tL
	 KO84VWL75ywoA==
Message-ID: <ad32f584-ea27-4da9-9397-147b887a7d68@kernel.org>
Date: Thu, 17 Sep 2026 09:11:50 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/9] media: iris: Add support for glymur platform
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
 <20260917-dangerous-illegal-honeybee-cf479a@quoll>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260917-dangerous-illegal-honeybee-cf479a@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/09/2026 09:09, Krzysztof Kozlowski wrote:
> On Thu, Sep 17, 2026 at 10:30:19AM +0530, Vishnu Reddy wrote:
>> ---
>> Mukesh Ojha (1):
>>       media: iris: Enable Secure PAS support with IOMMU managed by Linux
>>
>> Vishnu Reddy (8):
>>       dt-bindings: media: qcom,glymur-iris: Add glymur video codec
>>       media: iris: Replace enum-indexed clock and power domain tables with per-block structures
>>       media: iris: Add power sequence for glymur
>>       media: iris: Handle CPU_CS_SCIACMDARG3 register write via program bootup registers hook
>>       media: iris: Add support to select core for dual core platforms
>>       media: iris: Add platform data for glymur
>>       arm64: dts: qcom: glymur: Add iris video node
>>       arm64: dts: qcom: glymur-crd: Enable iris video codec node
>>
>>  .../bindings/media/qcom,glymur-iris.yaml           | 218 +++++++++++++++++++++
>>  .../bindings/media/qcom,sm8550-iris.yaml           |   6 +
>>  .../bindings/media/qcom,sm8750-iris.yaml           |   6 +
>>  .../bindings/media/qcom,venus-common.yaml          |  11 +-
>>  arch/arm64/boot/dts/qcom/glymur-crd.dtsi           |  10 +
>>  arch/arm64/boot/dts/qcom/glymur.dtsi               | 120 ++++++++++++
>>  drivers/media/platform/qcom/iris/Makefile          |   1 +
>>  drivers/media/platform/qcom/iris/iris_common.c     |  10 +
>>  drivers/media/platform/qcom/iris/iris_common.h     |   1 +
>>  drivers/media/platform/qcom/iris/iris_core.h       |  32 ++-
>>  drivers/media/platform/qcom/iris/iris_firmware.c   |  69 +++++--
>>  drivers/media/platform/qcom/iris/iris_hfi_common.h |   1 +
>>  .../platform/qcom/iris/iris_hfi_gen2_command.c     |  19 ++
>>  .../platform/qcom/iris/iris_hfi_gen2_defines.h     |   1 +
>>  drivers/media/platform/qcom/iris/iris_instance.h   |   2 +
>>  .../platform/qcom/iris/iris_platform_common.h      |  46 ++---
>>  .../platform/qcom/iris/iris_platform_glymur.c      |  78 ++++++++
>>  .../platform/qcom/iris/iris_platform_glymur.h      |  15 ++
>>  .../platform/qcom/iris/iris_platform_sc7280.h      |  28 ++-
>>  .../platform/qcom/iris/iris_platform_sm8250.h      |  26 ++-
>>  .../platform/qcom/iris/iris_platform_sm8550.h      |  26 ++-
>>  .../platform/qcom/iris/iris_platform_sm8750.h      |  29 ++-
>>  .../media/platform/qcom/iris/iris_platform_vpu2.c  |  20 +-
>>  .../media/platform/qcom/iris/iris_platform_vpu3x.c |  67 ++++---
>>  .../platform/qcom/iris/iris_platform_x1p42100.h    |  27 ++-
>>  drivers/media/platform/qcom/iris/iris_power.c      |  20 +-
>>  drivers/media/platform/qcom/iris/iris_probe.c      | 153 +++++++++++++--
>>  drivers/media/platform/qcom/iris/iris_resources.c  |  81 ++++----
>>  drivers/media/platform/qcom/iris/iris_resources.h  |   8 +-
>>  drivers/media/platform/qcom/iris/iris_utils.c      |  58 ++++--
>>  drivers/media/platform/qcom/iris/iris_utils.h      |   3 +-
>>  drivers/media/platform/qcom/iris/iris_vb2.c        |   4 +
>>  drivers/media/platform/qcom/iris/iris_vidc.c       |   6 +-
>>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 216 +++++++++++++++++---
>>  drivers/media/platform/qcom/iris/iris_vpu4x.c      | 137 ++-----------
>>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 102 ++--------
>>  drivers/media/platform/qcom/iris/iris_vpu_common.h |   3 +
>>  .../platform/qcom/iris/iris_vpu_register_defines.h |  13 ++
>>  38 files changed, 1229 insertions(+), 444 deletions(-)
>> ---
>> base-commit: 0d9d0dbf2fddcff5859d623e90ca73c4054276e1
>> change-id: 20260917-glymur-627d049900e0
> 
> Look here:
> https://lore.kernel.org/all/20260726-glymur-v10-0-de451559e88b@oss.qualcomm.com/
> change-id: 20260601-glymur-4fcd4d832ecc
> 
> so now does this work?
> 	b4 diff '20260917-glymur-v11-1-e0c8bc914742@oss.qualcomm.com'
> 
> No, it does not. You are sending bigger work, multi-version one, part of
> even bigger work, so please get the process working correct to make
> reviews easier.
> 

And it is getting even better:
v6 change id was:
	change-id: 20260515-glymur-6e69bc258fb0

https://lore.kernel.org/all/20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com/

???

Best regards,
Krzysztof
