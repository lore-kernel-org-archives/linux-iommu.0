Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CECE1B949
	for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989544; cv=none; b=ho2uPTn7Z/kg+pFmJ+9eSc4ab7SJzgHqfME5cRt7BuLTZa15WKgPeNYP+LHgk1KJRrFXWFp6pWf4jPKL4E0Yx5ANxSXcSeAg8cb+idpYXgI/Df7k5qRo+cZ8ubhGOH2fIAhqu4FGc0e8LWnr9X/WTiPwQv0mHI4+zVp9QPkPMLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989544; c=relaxed/simple;
	bh=t8fjnbGI5gCrFfnFsadlQGU4sXRofYXA6zNJI24MqTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cozsx5cupn5qZZHTNltdBuYeX3DvO9/lDyfjhmOMz770TpyEs/9jsEe4Xu/4uBBP2HYwVaqfQQsGQs7Ur/Bp+E3dDgmqyeG6OKpTkEm+ebj7a6KYjK5qCygoDO21SdpzeSmYUeYsw3z3byNpI5khRHMbhqd/JtIhs3QCQr0RJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f0dzn3ov; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0dzn3ov"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso565012276.0
        for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 01:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707989541; x=1708594341; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xhsL/cUAT42+vhfZnH+MnscoqoxI62SZOZMcf2180Ao=;
        b=f0dzn3ov6UAYCAmA4AXjsQFJl6xzjFJe7Kqp9fPLJjL/tUjFbh4/fH9GU1lWbbpPW0
         wGpf+7Cndru7yXtJN6cCZUpR9OS8NFyR0RdxBy2yMEVll0qO3TvDro+VNhsoVAJ/aH8/
         zli3ERbHD/ss0sDYGmHp3tqW1Q/XHglz1NEsuRTSycUO3jGGSOeSKbRTKQHnEZW3/kuI
         0RW4CsfN6AakuMyquaKSxwwUZ4XXxB8wfsCymzZ/UZt+sZktxxMyp/RH6/UID+6Gjvrt
         z1FxPZKe4xS7HeEw9lzvqUxFUHZBZHIX5Qx3UFpVzN5LoGgkXxRHmuQoWcNygN8v2J8R
         FIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989541; x=1708594341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhsL/cUAT42+vhfZnH+MnscoqoxI62SZOZMcf2180Ao=;
        b=PHTDNJhGGrNdhlnrbrCaOaQckMAZLK/27uCWflR1pE4xH0GT4xODSsZWlnFhLHJCw1
         xawUHKe8YtMfYUQI99gwKghctFBrDKiHXqF7sY35xd5to233MeSAljcWOl6Nnry5YDo8
         roQMKNiWs6p6jK+cEoYtj0dnquHHByPKW7bgdcWh+wI+hsi4edKjII4QTMOqISeejvQC
         EUODCj6nWrxTgHGB7LHio6pCxePrkjfGSjkuYQLMNI5OWgsNGPXnmqPrl+PlfD6VBDz1
         KGpZXzgkIhO1vQ6qOx/osN8719TGD4jNUkeKZXaY6Zriw2+iJHnfje5GGscduf/5oebL
         16xw==
X-Forwarded-Encrypted: i=1; AJvYcCVLPzTh7pomO9o0nTs4/nS9oo6MRaQr2UuUG1OqmnQVmqfii4VGft8wttfn5hTDhqQKQ2v0OcCjcJRNxsiS8lpcQo1EUB0=
X-Gm-Message-State: AOJu0Yw0/XVfAcLysQOl+LB13F0c47iV3NYm+SljAAlBojoy/nHNRQ8L
	CUaEnCgtnAOXfwfvHnmV5Lxazel2UtEt+ALzkGwiy6NF1ZLeCYI5YrDPo5+beJocH3hOvUtzepS
	EvOh9ZUzZey+P//fA5XOx3kb7DTZXYzC2S3M+JQ==
X-Google-Smtp-Source: AGHT+IGo2HcfVD2s8rsl4Q6UKE4zYlvCOdCjsO2WiOwy9pC6rfEmy2MtkOAphVrWtXxWh32cSnZlcfv9SsjiJWqGlD8=
X-Received: by 2002:a25:d68b:0:b0:dc6:aed5:718a with SMTP id
 n133-20020a25d68b000000b00dc6aed5718amr968831ybg.26.1707989541228; Thu, 15
 Feb 2024 01:32:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org>
 <20240215-topic-sm8650-gpu-v2-2-6be0b4bf2e09@linaro.org> <CAA8EJprpYEhGi5b+uWGWtOa+qbSwUR8C0j9NLC+ah_-nvy-=Ng@mail.gmail.com>
 <ffb16ef6-fc9a-42b1-b9c3-4e8f6b52d849@linaro.org>
In-Reply-To: <ffb16ef6-fc9a-42b1-b9c3-4e8f6b52d849@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 15 Feb 2024 11:32:10 +0200
Message-ID: <CAA8EJpobWYu8LoHZarOw82z78=kLJrKH0P4ncK6sX7zE1nHuqQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: arm-smmu: Document SM8650 GPU SMMU
To: neil.armstrong@linaro.org
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 11:29, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 15/02/2024 10:25, Dmitry Baryshkov wrote:
> > On Thu, 15 Feb 2024 at 11:20, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >>
> >> Document the GPU SMMU found on the SM8650 platform.
> >>
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >> ---
> >>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> index a4042ae24770..3ad5c850f3bf 100644
> >> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> @@ -93,6 +93,7 @@ properties:
> >>                 - qcom,sm8350-smmu-500
> >>                 - qcom,sm8450-smmu-500
> >>                 - qcom,sm8550-smmu-500
> >> +              - qcom,sm8650-smmu-500
> >>             - const: qcom,adreno-smmu
> >>             - const: qcom,smmu-500
> >>             - const: arm,mmu-500
> >> @@ -508,7 +509,10 @@ allOf:
> >>     - if:
> >>         properties:
> >>           compatible:
> >> -          const: qcom,sm8550-smmu-500
> >> +          contains:
> >> +            enum:
> >> +              - qcom,sm8550-smmu-500
> >> +              - qcom,sm8650-smmu-500
> >
> > Doesn't this cause warnings for non-GPU SMMU on this platform?
>
> No because it doesn't add those to required, it simply allows clock the properties.

Can we further constrain this branch so that it is applicable only to
the Adreno SMMUs (and enforce requirement)? And maybe constrain the
second if-branch so that it doesn't apply to the Adreno SMMUs?

>
> >
> >>       then:
> >>         properties:
> >>           clock-names:
> >> @@ -544,7 +548,6 @@ allOf:
> >>                 - qcom,sdx65-smmu-500
> >>                 - qcom,sm6350-smmu-500
> >>                 - qcom,sm6375-smmu-500
> >> -              - qcom,sm8650-smmu-500
> >>                 - qcom,x1e80100-smmu-500
> >>       then:
> >>         properties:
> >>
> >> --
> >> 2.34.1
> >>
> >
> >
>


-- 
With best wishes
Dmitry
